Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_Shrinkwrap
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gvShrinkwrap_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvShrinkwrap.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvShrinkwrap.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Shrinkwrap " 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvShrinkwrap.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Shrinkwrap" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "gotoredtag" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvShrinkwrap.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Shrinkwrap " 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../RedTags.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gototubedamage" Then

            Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command

            Dim Line() As String = Selected.Split(";")
            Dim SelectedProd As Integer = Line(0)
            Dim SelectedModel As String = Line(1)

            Dim url As String = "../Tubes/ReportDamage.aspx?ProdNo=" & SelectedProd & "&Model=" & SelectedModel
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=1000,height=600,toolbars=1');popUpObj.focus()}</script>")
        End If


        'This code is for the update button - replaced oon 2/3/21 bc Main order is Shrink Wave Shark Rig Complete and the South Ordeer is Shrink Rig Wave Shark Complete.
        If e.CommandName = "gotoupdate" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvShrinkwrap.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvShrinkwrap.Rows(Key).FindControl("btnUpdateShrinkwrap"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 26, 1) 'get the value of ShrinkwrapStatus from the imageurl.
            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim NextWorkstationHasDate As Int16
            Dim HasWaveTamercount As Int16
            Dim HasSharkhidecount As Int16
            Dim HasRiggingCount As Int16
            Dim NextWorkstation As String
            Dim NextWorkstationStatus As String
            Dim southshrinkcount As Int16 = 0
            Dim buildloc = gvShrinkwrap.Rows(Key).DataItem("BuildLoc")
            Dim rigging = gvShrinkwrap.Rows(Key).DataItem("RiggingNeeded")
            Dim wt = gvShrinkwrap.Rows(Key).DataItem("WavetamerNeeded")
            Dim shark = gvShrinkwrap.Rows(Key).DataItem("SharkhideNeeded")


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
            Dim cmd8 As New SqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text

            'Set shrinkwrap to done and set the date.
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET ShrinkwrapStatus = '2', Shrinkwrap = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "' and ShrinkwrapStatus <> 2"
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
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = 'M' and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

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
            cmd8.Connection = conn

            conn.Open()


            If floorvalue <= 1 Then
                cmd.ExecuteNonQuery()
                HasRiggingCount = Convert.ToInt16(cmd7.ExecuteScalar())
                HasWaveTamercount = Convert.ToInt16(cmd1.ExecuteScalar())

                If HasRiggingCount = 1 Then
                    cmd7a.ExecuteNonQuery()
                Else
                    If HasWaveTamercount = 1 Then
                        cmd1a.ExecuteNonQuery()
                    Else
                        HasSharkhidecount = Convert.ToInt16(cmd5.ExecuteScalar())
                        If HasSharkhidecount = 1 Then
                            cmd5a.ExecuteNonQuery()
                        Else
                            cmd6.ExecuteNonQuery() 'No Rigging, WT or SH, Boat is complete.
                        End If
                    End If
                End If
            Else

                'Figure out if next workstation is Rigging, WT, SH or Complete.
                HasRiggingCount = Convert.ToInt16(cmd7.ExecuteScalar())
                HasWaveTamercount = Convert.ToInt16(cmd1.ExecuteScalar())


                If HasRiggingCount = 1 Then
                    NextWorkstation = "Rigging"
                    NextWorkstationStatus = "RiggingStatus"
                Else
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
                End If


                'REVERSING DONE
                'Check if the next workstation already has a finish date.
                cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where " & NextWorkstation & " is not NULL and ProdNo = '" & SelectedProdNo & "'"
                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 And NextWorkstation = "Rigging" Then
                    MesgBox("You cannot undo this action because the next station has already completed this boat.")
                ElseIf NextWorkstationHasDate = 1 And NextWorkstation = "WaveTamerInstalled" Then
                    MesgBox("You cannot undo this action because the next station has already completed this boat.")
                ElseIf NextWorkstationHasDate = 1 And NextWorkstation = "SharkhideInstalled" Then
                    MesgBox("You cannot undo this action because the next station has already completed this boat.")
                Else
                    'reverse it only if the next workstation hasn't reported it complete.
                    cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET ShrinkwrapStatus = '1', " & NextWorkstationStatus & " = '0', ShrinkWrap = NULL where ProdNo =  " & SelectedProdNo & ""
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started/finished.
                End If


            End If
            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount

            'southshrinkcount = Convert.ToInt16(cmd8.ExecuteScalar())
            'lblSouthShrink.Text = southshrinkcount



            gvShrinkwrap.DataBind()

            conn.Close()
        End If

        If e.CommandName = "gotoupdatenew" Then
            'Dim Key As String = e.CommandArgument 'get the row that is clicked

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim Key As Integer = Convert.ToInt16(Line(0))

            Dim buildloc As String = Line(1)
            Dim wt As Integer = Line(2)
            Dim shark As Integer = Line(3)
            Dim rigging As Integer = Line(4)

            Dim SelectedProdNo As Integer = gvShrinkwrap.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvShrinkwrap.Rows(Key).FindControl("btnUpdateShrinkwrap"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 26, 1) 'get the value of ShrinkwrapStatus from the imageurl.
            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim southshrinkcount As Int16 = 0
            Dim NextWorkstation As String = ""
            Dim NextWorkstationStatus As String = ""
            Dim NextWorkstationHasDate As Int16

            Dim nextstep As String = ""

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
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand
            Dim cmd10 As New SqlCommand
            Dim cmd11 As New SqlCommand
            Dim cmd12 As New SqlCommand
            Dim cmd13 As New SqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text

            'Set shrinkwrap to done and set the date.
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET ShrinkwrapStatus = '2', Shrinkwrap = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd1a.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET WavetamerStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"
            cmd5a.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET SharkhideStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"
            cmd6.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET CompleteStatus = '2', Complete = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd7a.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RiggingStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"

            'to get the count of the prod #'s completed that day as it changes
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = 'M' and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = 'S' and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
            cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = 'V' and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

            cmd11.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 1 and BuildLoc = 'M' and CompleteStatus < 2 and ProdNo > 2100000"
            cmd12.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 1 and BuildLoc = 'S' and CompleteStatus < 2 and ProdNo > 2100000"
            cmd13.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 1 and BuildLoc = 'V' and CompleteStatus < 2 and ProdNo > 2100000"

            cmd.Connection = conn
            cmd1a.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5a.Connection = conn
            cmd6.Connection = conn
            cmd7a.Connection = conn
            cmd8.Connection = conn
            cmd9.Connection = conn
            cmd10.Connection = conn
            cmd11.Connection = conn
            cmd12.Connection = conn
            cmd13.Connection = conn


            conn.Open()
            'MesgBox(SelectedProdNo)
            'MesgBox(buildloc)
            If buildloc = "M" Or buildloc = "V" Then
                If wt = 1 Then
                    nextstep = "WT"
                    NextWorkstation = "WaveTamerInstalled"
                    NextWorkstationStatus = "WavetamerStatus"
                ElseIf shark = 1 Then
                    nextstep = "SH"
                    NextWorkstation = "SharkhideInstalled"
                    NextWorkstationStatus = "SharkhideStatus"
                ElseIf rigging = 1 Then
                    nextstep = "Rig"
                    NextWorkstation = "Rigging"
                    NextWorkstationStatus = "RiggingStatus"
                ElseIf nextstep = "Complete" Then
                Else
                    nextstep = "Complete"
                    NextWorkstation = "Complete"
                    NextWorkstationStatus = "CompleteStatus"
                End If

            ElseIf buildloc = "S" Then
                If rigging = 1 Then
                    nextstep = "Rig"
                    NextWorkstation = "Rigging"
                    NextWorkstationStatus = "RiggingStatus"
                ElseIf wt = 1 Then
                    nextstep = "WT"
                    NextWorkstation = "WaveTamerInstalled"
                    NextWorkstationStatus = "WavetamerStatus"
                ElseIf shark = 1 Then
                    nextstep = "SH"
                    NextWorkstation = "SharkhideInstalled"
                    NextWorkstationStatus = "SharkhideStatus"
                Else
                    nextstep = "Complete"
                    NextWorkstation = "Complete"
                    NextWorkstationStatus = "CompleteStatus"
                End If
            End If

            'MesgBox(nextstep)
            'MesgBox(floorvalue)
            If floorvalue <= 1 Then
                cmd.ExecuteNonQuery()
                If nextstep = "WT" Then
                    cmd1a.ExecuteNonQuery()
                ElseIf nextstep = "SH" Then
                    cmd5a.ExecuteNonQuery()
                ElseIf nextstep = "Rig" Then
                    cmd7a.ExecuteNonQuery()
                Else
                    cmd6.ExecuteNonQuery()
                End If

            ElseIf floorvalue = 2 Then
                'reversals
                'Check if the next workstation already has a finish date.
                cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where " & NextWorkstation & " Is Not NULL And ProdNo = '" & SelectedProdNo & "'"
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed this boat.")
                Else
                    'reverse it only if the next workstation hasn't reported it complete.
                    cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET ShrinkwrapStatus = '1', " & NextWorkstationStatus & " = '0', ShrinkWrap = NULL where ProdNo =  " & SelectedProdNo & ""
                    cmd4.ExecuteNonQuery()
                End If

            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount


            lblBoatsStartedS.Text = cmd9.ExecuteScalar
            lblVBoatsStarted.Text = cmd10.ExecuteScalar

            lblMainReadyToStart.Text = Convert.ToInt16(cmd11.ExecuteScalar)
            lblSouthReadyToStart.Text = Convert.ToInt16(cmd12.ExecuteScalar)
            lblValueReadyToStart.Text = Convert.ToInt16(cmd13.ExecuteScalar)

            lblReadyToStart.Text = ""

            'southshrinkcount = Convert.ToInt16(cmd8.ExecuteScalar())
            'lblSouthShrink.Text = southshrinkcount

            gvShrinkwrap.DataBind()

            conn.Close()

        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd6 As New SqlCommand
        Dim cmd7 As New SqlCommand
        Dim cmd8 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String
        Dim southshrinkcount As Int16 = 0

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
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = 'M' and Convert(date,ShrinkWrap) ='" & ThisDay & "'"
        'to get the count of the prod #'s completed that day

        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = 'S' and Convert(date,ShrinkWrap) ='" & ThisDay & "'"
        cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = 'V' and Convert(date,ShrinkWrap) ='" & ThisDay & "'"

        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 1 and BuildLoc = 'M' and CompleteStatus < 2 and ProdNo > 2100000"
        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 1 and BuildLoc = 'S' and CompleteStatus < 2 and ProdNo > 2100000"
        cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 1 and BuildLoc = 'V' and CompleteStatus < 2 and ProdNo > 2100000"

        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd8.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount

        lblBoatsStartedS.Text = cmd4.ExecuteScalar
        lblVBoatsStarted.Text = cmd5.ExecuteScalar

        lblMainReadyToStart.Text = Convert.ToInt16(cmd6.ExecuteScalar)
        lblSouthReadyToStart.Text = Convert.ToInt16(cmd7.ExecuteScalar)
        lblValueReadyToStart.Text = Convert.ToInt16(cmd8.ExecuteScalar)

        'southshrinkcount = Convert.ToInt16(cmd3.ExecuteScalar())
        'lblSouthShrink.Text = southshrinkcount
        lblReadyToStart.Text = ""


        'southshrinkcount = Convert.ToInt16(cmd3.ExecuteScalar())
        'lblSouthShrink.Text = southshrinkcount

        'MesgBox(recordcount)
        conn.Close()
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvShrinkwrap.DataBind()
    End Sub
    Protected Sub gvShrinkwrap_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvShrinkwrap.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsShrinkwrap"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If

        End If
    End Sub




End Class