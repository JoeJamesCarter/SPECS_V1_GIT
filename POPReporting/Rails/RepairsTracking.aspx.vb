Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Rails_RepairsTracking
    Inherits System.Web.UI.Page

    Protected Sub gvAllFieldsR_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsR.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFabOptions"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try

            Dim welddate As Date = e.Row.DataItem("WeldDate")
            Dim welddateset As Date = welddate.Date
            Dim reqdate As Date = e.Row.DataItem("DateReq")
            Dim reqdateset As Date = reqdate.Date

            If e.Row.DataItem("PF") = "1" Then
                e.Row.Cells(2).Text = "Port Front"

            ElseIf e.Row.DataItem("SF") = "1" Then
                e.Row.Cells(2).Text = "Strb Front"

            ElseIf e.Row.DataItem("PR") = "1" Then
                e.Row.Cells(2).Text = "Port Rear"

            ElseIf e.Row.DataItem("SR") = "1" Then
                e.Row.Cells(2).Text = "Strb Rear"

            ElseIf e.Row.DataItem("T") = "1" Then
                e.Row.Cells(2).Text = "Transom"

            ElseIf e.Row.DataItem("PM") = "1" Then
                e.Row.Cells(2).Text = "Port Mid"

            ElseIf e.Row.DataItem("SM") = "1" Then
                e.Row.Cells(2).Text = "Strb Mid"
            End If

            If welddateset = reqdateset Then
                e.Row.BackColor = Drawing.Color.LightGreen
            End If

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

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
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

        If e.CommandName = "UpdateRRStatus" Then
            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvAllFieldsR.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command

            Dim rbList As RadioButtonList = DirectCast(gvAllFieldsR.Rows(Key).Cells(5).FindControl("rblRepairStatus"), RadioButtonList)
            Dim status As Integer = rbList.SelectedValue
            Dim autoid As String = DirectCast(gvAllFieldsR.Rows(Key).Cells(1).FindControl("lblAutoID"), Label).Text

            Dim scrapflag As Integer
            Dim cmd As New SqlCommand

            If status = 1 Then
                scrapflag = 1
            Else
                scrapflag = 0
            End If

            Dim Rail As String = gvAllFieldsR.Rows(Key).Cells(2).Text 'find the rail in that row to use in the update command
            Dim RailToClear As String

            If Rail = "Port Front" Then
                RailToClear = "PF"
           
            ElseIf Rail = "Strb Front" Then
                RailToClear = "SF"

            ElseIf Rail = "Port Rear" Then
                RailToClear = "PR"

            ElseIf Rail = "Strb Rear" Then
                RailToClear = "SR"

            ElseIf Rail = "Transom" Then
                RailToClear = "T"

            ElseIf Rail = "Port Mid" Then
                RailToClear = "PM"

            ElseIf Rail = "Strb Mid" Then
                RailToClear = "SM"

            End If


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString


            Dim cmd1 As New SqlCommand


            cmd.Parameters.AddWithValue("@Status", status)
            cmd.Parameters.AddWithValue("@Scrapflag", scrapflag)
            
            Dim Note As String = "Unrepairable, Rebuild"
            cmd1.Parameters.AddWithValue("@Note", Note)
            cmd1.Parameters.AddWithValue("@BoatNotesProdNo", SelectedProdNo)



            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn


            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE Rails_RepairsReorders SET Status = @Status, StatusDate = '" & TodaysDate & "', Scrap = @Scrapflag where Auto =  '" & autoid & "'"

            conn.Open()
            cmd.ExecuteNonQuery()

            'Cannot repair - automatically reorder
            If status = 1 Then

                If RailToClear = "PF" Then
                    cmd1.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate, Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'1', '0','0','0','0','0','0', @Note, @TodaysDate, '0', @TodaysDate, 'Reorder', '0', '0')"
                    cmd1.ExecuteNonQuery()

                End If

                If RailToClear = "SF" Then
                    cmd1.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate, Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0', '1','0','0','0','0','0', @Note, @TodaysDate, '0',@TodaysDate, 'Reorder', '0', '0')"
                    cmd1.ExecuteNonQuery()

                End If

                If RailToClear = "PR" Then
                    cmd1.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status,StatusDate, Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0','0','1','0','0','0','0', @Note, @TodaysDate, '0', @TodaysDate,'Reorder', '0', '0')"
                    cmd1.ExecuteNonQuery()

                End If

                If RailToClear = "SR" Then
                    cmd1.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status,StatusDate, Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0', '0','0','1','0','0','0', @Note, @TodaysDate, '0', @TodaysDate,'Reorder', '0', '0')"
                    cmd1.ExecuteNonQuery()

                End If

                If RailToClear = "PM" Then
                    cmd1.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate,Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0','0','0','0','1','0','0', @Note, @TodaysDate, '0', @TodaysDate,'Reorder', '0', '0')"
                    cmd1.ExecuteNonQuery()

                End If

                If RailToClear = "SM" Then
                    cmd1.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate,Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0','0','0','0','0','1','0', @Note, @TodaysDate, '0', @TodaysDate,'Reorder', '0', '0')"
                    cmd1.ExecuteNonQuery()

                End If

                If RailToClear = "T" Then
                    cmd1.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status,StatusDate, Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0','0','0','0','0','0','1', @Note, @TodaysDate, '0', @TodaysDate,'Reorder', '0', '0')"
                    cmd1.ExecuteNonQuery()

                End If

                conn.Close()


            End If
            gvAllFieldsR.DataBind()
        End If


    End Sub


    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsR.DataBind()
    End Sub
End Class
