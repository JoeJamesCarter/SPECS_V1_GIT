Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Rails_ReceivingQFronts
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvAllFieldsR_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsR.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFabOptions"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try

            ' If (e.Row.DataItem("WeldDate") < ddlDateSelected.SelectedValue) Then
            'e.Row.BackColor = Drawing.Color.LightGray
            'End If

            'If e.Row.DataItem("CustDrawNo") = "" Then

            'Else
            'e.Row.Cells(2).BackColor = System.Drawing.Color.Yellow
            'End If

        End If

    End Sub



    Protected Sub gvAllFieldsR_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsR.RowCommand

        If e.CommandName = "goto" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsR.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rails" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotorepair" Then 'handles when the repair button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsR.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Repair" 'to pass in the workstation that makes the note.
            Dim url As String = "Repair.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1050,height=1000,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoreorder" Then 'handles when the reorder button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsR.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Reorder" 'to pass in the workstation that makes the note.
            Dim url As String = "Reorder.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1050,height=1000,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "UpdateRRStatus" Then
            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvAllFieldsR.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command

            'Dim NumRailsNeeded As Integer = gvAllFieldsR.Rows(Key).DataItem("RailsNeeded")

            Dim cbPF As CheckBox = DirectCast(gvAllFieldsR.Rows(Key).Cells(5).FindControl("cbPF"), CheckBox)
            Dim cbPR As CheckBox = DirectCast(gvAllFieldsR.Rows(Key).Cells(5).FindControl("cbPR"), CheckBox)
            Dim cbSF As CheckBox = DirectCast(gvAllFieldsR.Rows(Key).Cells(5).FindControl("cbSF"), CheckBox)
            Dim cbSR As CheckBox = DirectCast(gvAllFieldsR.Rows(Key).Cells(5).FindControl("cbSR"), CheckBox)
            Dim cbT As CheckBox = DirectCast(gvAllFieldsR.Rows(Key).Cells(5).FindControl("cbT"), CheckBox)
            Dim cbPM As CheckBox = DirectCast(gvAllFieldsR.Rows(Key).Cells(5).FindControl("cbPM"), CheckBox)
            Dim cbSM As CheckBox = DirectCast(gvAllFieldsR.Rows(Key).Cells(5).FindControl("cbSM"), CheckBox)

            Dim PF As Integer = If(cbPF.Checked, 1, 0)
            Dim PR As Integer = If(cbPR.Checked, 1, 0)
            Dim SF As Integer = If(cbSF.Checked, 1, 0)
            Dim SR As Integer = If(cbSR.Checked, 1, 0)
            Dim T As Integer = If(cbT.Checked, 1, 0)
            Dim PM As Integer = If(cbPM.Checked, 1, 0)
            Dim SM As Integer = If(cbSM.Checked, 1, 0)

            Dim RailsInStock As Integer = PF + PR + SF + SR + T + PM + SM
            Dim EmptySlotSet As Integer = 0
            Dim ExistsInLocationsAlready As Integer = 0 'in case the reclick a boat with only one rail, don't want it in multiple locations

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand
            Dim cmd6 As New SqlCommand
            Dim cmd7 As New SqlCommand
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand
            Dim cmd10 As New SqlCommand
            Dim cmd11 As New SqlCommand
            Dim cmd12 As New SqlCommand
            Dim cmd13 As New SqlCommand
            Dim cmd14 As New SqlCommand
           

            cmd.Parameters.AddWithValue("@PF", PF)
            cmd.Parameters.AddWithValue("@SF", SF)
           

            cmd4.Parameters.AddWithValue("@PF", PF)
            cmd4.Parameters.AddWithValue("@PR", PR)
            cmd4.Parameters.AddWithValue("@SF", SF)
            cmd4.Parameters.AddWithValue("@SR", SR)
            cmd4.Parameters.AddWithValue("@T", T)
            cmd4.Parameters.AddWithValue("@PM", PM)
            cmd4.Parameters.AddWithValue("@SM", SM)


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd6.Connection = conn
            cmd7.Connection = conn
            cmd8.Connection = conn
            cmd9.Connection = conn
            cmd10.Connection = conn
            cmd11.Connection = conn
            cmd12.Connection = conn
            cmd13.Connection = conn
            cmd14.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE Rails_Tracking SET PF_Received = @PF, SF_Received = @SF where ProdNo =  '" & SelectedProdNo & "'"

            cmd1.CommandText = "Select RailsNeeded From Rails_Tracking where ProdNo =  '" & SelectedProdNo & "'"

            cmd2.CommandText = "UPDATE Rails_Tracking SET HasAllRails = '1' where ProdNo =  '" & SelectedProdNo & "'"
            cmd3.CommandText = "UPDATE Rails_Tracking SET HasAllRails = '0' where ProdNo =  '" & SelectedProdNo & "'"

            'Transactions
            cmd4.CommandText = "INSERT Into Rails_Transactions(ProdNo,TransactionDate,PF,SF,PR,SR,PM,SM,T,Produced,Received) VALUES ('" & SelectedProdNo & "', '" & TodaysDate & "', @PF, @SF, @PR, @SR, @PM, @SM, @T,0,1)"

            'For Clearing Flags
            cmd5.CommandText = "Select Count (*) From Rails_RepairsReorders where ReReceived = '0' and ProdNo =  '" & SelectedProdNo & "'"
            cmd7.CommandText = "Select Count (*) From Rails_RepairsReorders where ReReceived = '0' and Type = 'Repair' and ProdNo =  '" & SelectedProdNo & "'"
            cmd8.CommandText = "Select Count (*) From Rails_RepairsReorders where ReReceived = '0' and Type = 'Reorder' and ProdNo =  '" & SelectedProdNo & "'"
            cmd9.CommandText = "UPDATE Rails_Tracking SET RepairFlag = '0' where ProdNo =  '" & SelectedProdNo & "'"
            cmd10.CommandText = "UPDATE Rails_Tracking SET ReorderFlag = '0' where ProdNo =  '" & SelectedProdNo & "'"

            'For Tracking Location in Vertical Racks
            cmd11.CommandText = "Select Top 1 RailsSlot From Rails_KittingLocations Where InUse = 0"
            cmd12.CommandText = "Select Count (*) ProdNo From Rails_KittingLocations Where InUse = '1' and ProdNo = '" & SelectedProdNo & "'"
           
            conn.Open()
            cmd.ExecuteNonQuery()

            Dim NumRailsNeeded As Integer = cmd1.ExecuteScalar()

            If RailsInStock = NumRailsNeeded Then
                cmd2.ExecuteNonQuery()
            Else
                cmd3.ExecuteNonQuery()
            End If

            cmd4.ExecuteNonQuery()

            'Re-Receiving into the Repairs table at the same time.

            Dim rrCount As Int16 = Convert.ToInt16(cmd5.ExecuteScalar)


            If rrCount > 0 Then

                If PF = 1 Then
                    Try
                        cmd6.CommandText = "UPDATE Rails_RepairsReorders SET ReReceived = '2',ReReceivedDate = '" & TodaysDate & "' where PF = '1' and ReReceived='0' and ProdNo =  '" & SelectedProdNo & "'"
                        cmd6.ExecuteNonQuery()
                    Catch ex As Exception
                        MesgBox("Failed")
                    End Try

                End If


                If SF = 1 Then
                    Try
                        cmd6.CommandText = "UPDATE Rails_RepairsReorders SET ReReceived = '2', ReReceivedDate = '" & TodaysDate & "' where SF = '1' and ReReceived='0' and ProdNo =  '" & SelectedProdNo & "'"
                        cmd6.ExecuteNonQuery()
                    Catch ex As Exception

                    End Try

                End If

               
            End If

            'Reset the flags that make the buttons red.
            Dim repaircountleft As Int16 = Convert.ToInt16(cmd7.ExecuteScalar)
            Dim reordercountleft As Int16 = Convert.ToInt16(cmd8.ExecuteScalar)

            If repaircountleft = 0 Then
                cmd9.ExecuteNonQuery()
            End If

            If reordercountleft = 0 Then
                cmd10.ExecuteNonQuery()
            End If

            ''If this is the first rail receieved then set its location to next available slot

            'If RailsInStock = 1 Then
            '    ExistsInLocationsAlready = cmd12.ExecuteScalar

            '    If ExistsInLocationsAlready = 0 Then
            '        Try
            '            EmptySlotSet = cmd11.ExecuteScalar
            '            cmd13.CommandText = "Update Rails_KittingLocations Set ProdNo = '" & SelectedProdNo & "', DateIn = '" & TodaysDate & "', InUse = 1 Where RailsSlot = '" & EmptySlotSet & "'"
            '            cmd13.ExecuteNonQuery()
            '        Catch
            '        End Try
            '    End If

            'ElseIf RailsInStock = 0 Then
            '    'clear the only rail we had was reversed.
            '    cmd14.CommandText = "Update Rails_KittingLocations Set InUse = 0 Where ProdNo = '" & SelectedProdNo & "'"
            '    cmd14.ExecuteNonQuery()
            'End If



            conn.Close()
            gvAllFieldsR.DataBind()

        End If

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        ddlShowSelect.Visible = False
        ddlRailsStatus.Visible = False

    End Sub
End Class
