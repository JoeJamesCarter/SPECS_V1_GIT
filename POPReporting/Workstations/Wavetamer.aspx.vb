Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_Wavetamer
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gvWavetamer_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvWavetamer.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvWavetamer.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Wavetamer " 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvWavetamer.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Wavetamer" 'to pass in the workstation that makes the note.
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

            Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command

            Dim Line() As String = Selected.Split(";")
            Dim SelectedProd As Integer = Line(0)
            Dim SelectedModel As String = Line(1)

            Dim url As String = "../Tubes/ReportDamage.aspx?ProdNo=" & SelectedProd & "&Model=" & SelectedModel
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=1000,height=600,toolbars=1');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "gotoredtag" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvWavetamer.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Sharkhide " 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../RedTags.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        'This code is for the update button
        If e.CommandName = "gotoupdate" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvWavetamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvWavetamer.Rows(Key).FindControl("btnUpdateWavetamer"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 26, 1) 'get the value of WavetamerStatus from the imageurl.
            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim NextWorkstationHasDate As Int16
            Dim HasSharkhidecount As Int16
            Dim NextWorkstation As String
            Dim NextWorkstationStatus As String

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand
            Dim cmd5a As New SqlCommand
            Dim cmd6 As New SqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text

            'Set Wavetamer to done and set the date.
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET WavetamerStatus = '2', WavetamerInstalled = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"

            'Check if Sharkhide is needed.
            cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING where SharkhideNeeded = '1'and ProdNo = '" & SelectedProdNo & "'"
            cmd5a.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET SharkhideStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"

            cmd6.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET CompleteStatus = '2', Complete = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"

            'to get the count of the prod #'s completed that day as it changes
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where WavetamerStatus = 2 and Convert(date,WavetamerInstalled) ='" & ThisDay & "'"


            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd5a.Connection = conn
            cmd6.Connection = conn

            conn.Open()


            If floorvalue <= 1 Then
                cmd.ExecuteNonQuery()
                HasSharkhidecount = Convert.ToInt16(cmd5.ExecuteScalar())
                If HasSharkhidecount = 1 Then
                    cmd5a.ExecuteNonQuery()
                Else
                    cmd6.ExecuteNonQuery() 'No SH, Boat is complete.
                End If
            Else
                'Reverse Done
                'Figure out if next workstation is SH or Complete.

                HasSharkhidecount = Convert.ToInt16(cmd5.ExecuteScalar())
                If HasSharkhidecount = 1 Then
                    NextWorkstation = "SharkhideInstalled"
                    NextWorkstationStatus = "SharkhideStatus"

                Else : NextWorkstation = "Complete"
                    NextWorkstationStatus = "CompleteStatus"
                End If

                'REVERSING DONE
                'Check if the next workstation already has a finish date.
                cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where " & NextWorkstation & " is not NULL and ProdNo = '" & SelectedProdNo & "'"
                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())

                If NextWorkstation = "SharkhideInstalled" And NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed this boat.")
                Else
                    If NextWorkstation = "SharkhideInstalled" And NextWorkstationHasDate = 0 Then
                        'reverse it only if the next workstation hasn't reported it complete.
                        cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET WavetamerStatus = '1', " & NextWorkstationStatus & " = '0', WavetamerInstalled = NULL where ProdNo =  " & SelectedProdNo & " and " & NextWorkstation & " is NULL"
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started/finished.
                    End If
                    If NextWorkstation = "Complete" Then
                        'reverse it only if the next workstation hasn't reported it complete.
                        cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET WavetamerStatus = '1', CompleteStatus = '0', WavetamerInstalled = NULL where ProdNo =  " & SelectedProdNo & ""
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started/finished.
                    End If
                End If

            End If


            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount
            gvWavetamer.DataBind()
            conn.Close()
        End If

        'This code is for the update button
        If e.CommandName = "gotoupdatenew" Then

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim Key As Integer = Convert.ToInt16(Line(0))
            Dim buildloc As String = Trim(Line(1))
            Dim shark As Integer = Convert.ToInt16(Line(2))
            Dim rigging As Integer = Convert.ToInt16(Line(3))



            Dim SelectedProdNo As Integer = gvWavetamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


            Dim img As Image = CType(gvWavetamer.Rows(Key).FindControl("btnUpdateWavetamer"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 26, 1) 'get the value of WavetamerStatus from the imageurl.
            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim NextWorkstationHasDate As Int16
            Dim NextWorkstation As String = "Test"
            Dim NextWorkstationStatus As String = "Test"

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
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET WavetamerStatus = '2', WavetamerInstalled = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RiggingStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"

            'Check if Sharkhide is needed.
            'cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING where SharkhideNeeded = '1'and ProdNo = '" & SelectedProdNo & "'"
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
                If shark = "1" Then
                    NextWorkstation = "SharkhideInstalled"
                    NextWorkstationStatus = "SharkhideStatus"
                ElseIf rigging = "1" Then
                    NextWorkstation = "Rigging"
                    NextWorkstationStatus = "RiggingStatus"
                Else
                    NextWorkstation = "Complete"
                    NextWorkstationStatus = "CompleteStatus"
                End If

            ElseIf buildloc = "S" Then
                If shark = "1" Then
                    NextWorkstation = "SharkhideInstalled"
                    NextWorkstationStatus = "SharkhideStatus"
                Else
                    NextWorkstation = "Complete"
                    NextWorkstationStatus = "CompleteStatus"
                End If
            End If


            If floorvalue <= 1 Then
                cmd.ExecuteNonQuery()

                If buildloc = "M" Or buildloc = "V" Then
                    If shark = "1" Then
                        cmd5a.ExecuteNonQuery() 'enable shark

                    ElseIf rigging = "1" Then
                        cmd1.ExecuteNonQuery() 'enable rig

                    Else
                        cmd6.ExecuteNonQuery() 'Boat is complete.

                    End If

                ElseIf buildloc = "S" Then
                    If shark = "1" Then
                        cmd5a.ExecuteNonQuery()

                    Else
                        cmd6.ExecuteNonQuery() 'No SH, Boat is complete.

                    End If
                End If


            Else

                'MesgBox(buildloc)
                'MesgBox(shark)
                'MesgBox(rigging)
                'MesgBox(SelectedProdNo)
                'Reverse Done
                'Figure out if next workstation is SH, Rigging or Complete.

                'REVERSING DONE
                'Check if the next workstation already has a finish date.
                cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where " & NextWorkstation & " is not NULL and ProdNo = '" & SelectedProdNo & "'"
                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())

                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed this boat.")
                ElseIf NextWorkstationHasDate = 0 Then
                    'reverse it only if the next workstation hasn't reported it complete.
                    cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET WavetamerStatus = '1', " & NextWorkstationStatus & " = '0', WavetamerInstalled = NULL where ProdNo =  " & SelectedProdNo & " and " & NextWorkstation & " is NULL"
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started/finished.
                End If
                If NextWorkstation = "Complete" Then
                    'reverse it only if the next workstation hasn't reported it complete.
                    cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET WavetamerStatus = '1', CompleteStatus = '0', WavetamerInstalled = NULL where ProdNo =  " & SelectedProdNo & ""
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started/finished.
                End If
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount
            gvWavetamer.DataBind()
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
            DaystoShow = ThisDay.AddDays(42).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("40 Days", DaystoShow))
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where WavetamerStatus = 2 and Convert(date,WavetamerInstalled) ='" & ThisDay & "'"
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
        gvWavetamer.DataBind()
    End Sub
    Protected Sub gvWavetamer_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvWavetamer.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsWavetamer"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
            If (e.Row.DataItem("ScheduledToLoad") = "1") Then
                e.Row.Cells(7).BackColor = Drawing.Color.Orange
            End If
        End If
    End Sub




End Class