Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports RestSharp

Partial Class Workstations_Rigging
    Inherits System.Web.UI.Page

    Public pocmts As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvRigging_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvRigging.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRigging.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rigging " 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRigging.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rigging" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "gototubedamage" Then
            gvRigging.DataBind()
            Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command

            Dim Line() As String = Selected.Split(";")
            Dim SelectedProd As Integer = Line(0)
            Dim SelectedModel As String = Line(1)

            Dim url As String = "../Tubes/ReportDamage.aspx?ProdNo=" & SelectedProd & "&Model=" & SelectedModel
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=1000,height=600,toolbars=1');popUpObj.focus()}</script>")
        End If
        'This code is for the update button
        If e.CommandName = "gotoupdate" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRigging.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRigging.Rows(Key).FindControl("btnUpdateRigging"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 26, 1) 'get the value of RiggingStatus from the imageurl.
            Dim NextWorkstationHasDate As Int16
            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0

            Dim HasWaveTamercount As Int16
            Dim HasSharkhidecount As Int16
            Dim HasRiggingCount As Int16
            Dim NextWorkstation As String
            Dim NextWorkstationStatus As String


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd1a As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand
            Dim cmd5a As New SqlCommand
            Dim cmd6 As New SqlCommand
            Dim cmd7 As New SqlCommand
            Dim cmd7a As New SqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text

            'Set shrinkwrap to done and set the date.
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RiggingStatus = '2', Rigging = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            'Check if WaveTamer is needed.
            cmd1.CommandText = "Select Count (*) FROM BML_POPREPORTING where WaveTamerNeeded = '1'and ProdNo = '" & SelectedProdNo & "'"
            cmd1a.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET WavetamerStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"

            'Check if Sharkhide is needed.
            cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING where SharkhideNeeded = '1'and ProdNo = '" & SelectedProdNo & "'"
            cmd5a.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET SharkhideStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"

            cmd6.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET CompleteStatus = '2', Complete = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"

            cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING where RiggingNeeded = '1'and ProdNo = '" & SelectedProdNo & "'"
            cmd7a.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RiggingStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"

            'to get the count of the prod #'s completed that day as it changes
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus = 2 and Convert(date,Rigging) ='" & ThisDay & "'"


            cmd.Connection = conn
            cmd1.Connection = conn
            cmd1a.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd5a.Connection = conn
            cmd6.Connection = conn
            cmd7.Connection = conn
            cmd7a.Connection = conn

            conn.Open()


            If floorvalue <= 1 Then
                cmd.ExecuteNonQuery()
                HasRiggingCount = Convert.ToInt16(cmd7.ExecuteScalar())
                HasWaveTamercount = Convert.ToInt16(cmd1.ExecuteScalar())

                If HasWaveTamercount = 1 Then
                    cmd1a.ExecuteNonQuery()
                Else
                    HasSharkhidecount = Convert.ToInt16(cmd5.ExecuteScalar())
                    If HasSharkhidecount = 1 Then
                        cmd5a.ExecuteNonQuery()
                    Else
                        cmd6.ExecuteNonQuery() 'No WT or SH, Boat is complete.
                    End If
                End If
            Else

                'Figure out if next workstation is WT, SH or Complete.
                HasRiggingCount = Convert.ToInt16(cmd7.ExecuteScalar())
                HasWaveTamercount = Convert.ToInt16(cmd1.ExecuteScalar())


                If HasWaveTamercount = 1 Then
                    NextWorkstation = "WaveTamerInstalled"
                    NextWorkstationStatus = "WavetamerStatus"

                Else
                    HasSharkhidecount = Convert.ToInt16(cmd5.ExecuteScalar())
                    If HasSharkhidecount = 1 Then
                        NextWorkstation = "SharkhideInstalled"
                        NextWorkstationStatus = "SharkhideStatus"

                    Else : NextWorkstation = "Complete"
                        NextWorkstationStatus = "CompleteStatus"

                    End If
                End If


                'REVERSING DONE
                'Check if the next workstation already has a finish date.
                cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where " & NextWorkstation & " is not NULL and ProdNo = '" & SelectedProdNo & "'"
                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())

                If NextWorkstationHasDate = 1 And NextWorkstation = "WaveTamerInstalled" Then
                    MesgBox("You cannot undo this action because the next station has already completed this boat.")
                ElseIf NextWorkstationHasDate = 1 And NextWorkstation = "SharkhideInstalled" Then
                    MesgBox("You cannot undo this action because the next station has already completed this boat.")
                Else
                    'reverse it only if the next workstation hasn't reported it complete.
                    cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RiggingStatus = '1', " & NextWorkstationStatus & " = '0', Rigging = NULL where ProdNo =  " & SelectedProdNo & ""
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started/finished.
                End If


            End If
            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount
            gvRigging.DataBind()

            conn.Close()
        End If

        'This code is for the update button
        If e.CommandName = "gotoupdatenew" Then

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim Key As Integer = Convert.ToInt16(Line(0))
            Dim buildloc As String = Line(1)
            Dim shark As Integer = Line(2)
            Dim rigging As Integer = Line(3)
            Dim wave As Integer = Line(4)

            Dim SelectedProdNo As Integer = gvRigging.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRigging.Rows(Key).FindControl("btnUpdateRigging"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 26, 1) 'get the value of WavetamerStatus from the imageurl.
            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim NextWorkstationHasDate As Int16
            Dim NextWorkstation As String = "Test"
            Dim NextWorkstationStatus As String = "Test"


            Dim IsInternational As String = "0"
            Try
                IsInternational = CType(gvRigging.Rows(Key).FindControl("international"), HiddenField).Value.ToString
            Catch
            End Try

            Dim model As String = CType(gvRigging.Rows(Key).FindControl("Label1"), Label).Text

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand
            Dim cmd5a As New SqlCommand
            Dim cmd6 As New SqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text

            'Set Wavetamer to done and set the date.
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RiggingStatus = '2', Rigging = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RiggingStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"
            cmd5.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET WavetamerStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"

            cmd5a.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET SharkhideStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"

            cmd6.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET CompleteStatus = '2', Complete = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"

            'to get the count of the prod #'s completed that day as it changes
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where WavetamerStatus = 2 and Convert(date,WavetamerInstalled) ='" & ThisDay & "'"


            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd5a.Connection = conn
            cmd6.Connection = conn

            conn.Open()

            If buildloc = "M" Or buildloc = "V" Then

                NextWorkstation = "Complete"
                NextWorkstationStatus = "CompleteStatus"
            ElseIf buildloc = "S" Then
                If wave = 1 Then

                    NextWorkstation = "Wavetamer"
                    NextWorkstationStatus = "WavetamerStatus"
                ElseIf shark = 1 Then

                    NextWorkstation = "SharkhideInstalled"
                    NextWorkstationStatus = "SharkhideStatus"
                Else

                    NextWorkstation = "Complete"
                    NextWorkstationStatus = "CompleteStatus"
                End If
            End If

            If floorvalue <= 1 Then
                cmd.ExecuteNonQuery()

                If IsInternational = "1" Then
                    PostToTeamsAuditNotification(SelectedProdNo, "Rigging", model)
                End If

                If buildloc = "M" Or buildloc = "V" Then
                    cmd6.ExecuteNonQuery() 'Boat is complete.

                ElseIf buildloc = "S" Then
                    If wave = 1 Then
                        cmd5.ExecuteNonQuery()

                    ElseIf shark = 1 Then
                        cmd5a.ExecuteNonQuery()

                    Else
                        cmd6.ExecuteNonQuery() 'No SH, Boat is complete.

                    End If
                End If

            Else

                'REVERSING DONE
                'Check if the next workstation already has a finish date.
                cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where " & NextWorkstation & " is not NULL and ProdNo = '" & SelectedProdNo & "'"
                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())

                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed this boat.")
                ElseIf NextWorkstationHasDate = 0 Then
                    'reverse it only if the next workstation hasn't reported it complete.
                    cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RiggingStatus = '1', " & NextWorkstationStatus & " = '0', Rigging = NULL where ProdNo =  " & SelectedProdNo & " and " & NextWorkstation & " is NULL"
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started/finished.
                End If
                If NextWorkstation = "Complete" Then
                    'reverse it only if the next workstation hasn't reported it complete.
                    cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RiggingStatus = '1', CompleteStatus = '0', Rigging = NULL where ProdNo =  " & SelectedProdNo & ""
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started/finished.
                End If
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount
            gvRigging.DataBind()
            conn.Close()
        End If


    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String

        If ddlDaysInAdvance.Items.Count = 0 Then  'stop it from repopulating everytime the grid rebinds
            DaystoShow = ThisDay.AddDays(5).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("3 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(7).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("5 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(12).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("10 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(17).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("15 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(22).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("20 Days", DaystoShow))
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus = 2 and Convert(date,Rigging) ='" & ThisDay & "'"
        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount
        'MesgBox(recordcount)
        conn.Close()
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvRigging.DataBind()
    End Sub


    Protected Sub btbCantSee_Click(sender As Object, e As EventArgs) Handles btnCantSee.Click
        Dim url As String = "./RigABoatICantSee.aspx"
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")
    End Sub

    Protected Sub gvRigging_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRigging.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsRigging"), SqlDataSource)
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsMacola"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsBoatNotes"), SqlDataSource)

            Dim so As String = DataBinder.Eval(e.Row.DataItem, "SONo")
            Dim prod As String = DataBinder.Eval(e.Row.DataItem, "ProdNo")
            Dim lblEngPO As Label = DirectCast(e.Row.FindControl("lblEngPO"), Label)
            Dim lblPOLine As Label = DirectCast(e.Row.FindControl("lblPoLineNo"), Label)
            Dim lblETA As Label = DirectCast(e.Row.FindControl("lblETA"), Label)


            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                s.SelectParameters(0).DefaultValue = so
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
            If (e.Row.DataItem("ScheduledToLoad") = "1") Then
                e.Row.Cells(8).BackColor = Drawing.Color.Orange
            End If

            'Get the PO # where the cmt = Prod # from Line 3.

            Dim conn As New SqlConnection()
            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            conn.Open()
            cmd.Connection = conn
            cmd1.Connection = conn

            cmd.Parameters.AddWithValue("@Prod", prod)

            cmd.CommandText = "Select ord_no, line_no from POCOMFIL_SQL where RTrim(cmt) = @Prod and seq_no = '3'"

            Dim results As SqlDataReader = cmd.ExecuteReader

            If results.HasRows = True Then
                While results.Read
                    Try
                        lblEngPO.Text = Trim(results.Item("ord_no")).ToString
                        lblPOLine.Text = Trim(results.Item("line_no")).ToString


                    Catch
                    End Try
                End While
                results.Close()
            End If

            Try
                cmd1.Parameters.AddWithValue("@PO", Trim(lblEngPO.Text))
                cmd1.Parameters.AddWithValue("@Line", Trim(lblPOLine.Text))

                cmd1.CommandText = "Select cmt from POCOMFIL_SQL where ord_no = @PO and line_no = @Line and seq_no = 6"
                Dim eta As String = cmd1.ExecuteScalar
                lblETA.Text = eta

            Catch ex As Exception

            End Try


            conn.Close()

        End If
    End Sub

    Private Sub PostToTeamsAuditNotification(Prod As String, WS As String, Model As String)
        Dim client = New RestClient("https://polarisind.webhook.office.com/webhookb2/575d63df-68ca-4f80-b5fb-d8178ab3d75e@85f78c4c-ad11-4735-9624-0b2c11611dff/IncomingWebhook/08f8f4e1e00c4d6fbafb5920df00de43/e21f1092-8010-45f9-b419-50aa3efc4b1f")
        client.Timeout = -1
        Dim request = New RestRequest(Method.POST)
        request.AddHeader("Content-Type", "application/json")
        request.AddParameter("application/json", "{" & vbCrLf & "    ""@context"": ""https://schema.org/extensions""," & vbCrLf & "    ""@type"": ""MessageCard""," & vbCrLf & "    ""themeColor"": ""0072C6""," & vbCrLf & "    ""title"": ""Prod #: " & Prod & "    Model:  " & Model & " ""," & vbCrLf & "    ""text"": ""Prod #:  " & Prod & "  Has Just Completed Through  " & WS & " .""" & vbCrLf & "    " & vbCrLf & "}", ParameterType.RequestBody)
        Dim response As IRestResponse = client.Execute(request)
        Console.WriteLine(response.Content)
    End Sub
End Class
