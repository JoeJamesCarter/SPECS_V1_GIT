Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class RailsPrepTest
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
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsRailsData"), SqlDataSource)


            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text


            Catch

            End Try

            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If

    End Sub


    Protected Sub gvAllFieldsR_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsR.RowCommand

        If e.CommandName = "goto" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsR.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rails" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "UpdateRStatus" Then
            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvAllFieldsR.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


            Dim rbList As RadioButtonList = DirectCast(gvAllFieldsR.Rows(Key).Cells(4).FindControl("rblRailsStatus"), RadioButtonList)
            'set the value of the radio button equal to what it is in the database on load.

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
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

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim greenlightcount As Int16 = 0
            Dim tubeneeded As Int16 = 0
            Dim tubecomplete As Int16 = 0
            Dim framesreadytostart As Int16
            Dim framesreadytostartio As Int16
            Dim building As String


            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RailsStatus = '" & rbList.SelectedValue & "' , RailsLastUpdated = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsStatus = 2 and Convert(date,RailsLastUpdated) ='" & ThisDay & "'"
            'to get the count of the prod #'s completed that day as it changes
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '1', DateAllGreen = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "' and FramesInstalled is NULL"
            cmd5.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '0', DateAllGreen = NULL where ProdNo =  '" & SelectedProdNo & "' and FramesInstalled is NULL"
            'if all green lights are on (covers can be yellow) check if Centertubeneeded is 1 and if CentertubeStatus = 2.  If true, Frames can start.
            cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING where CentertubeNeeded = 1 and ProdNo =  '" & SelectedProdNo & "'"
            cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"
            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
            cmd10.CommandText = "Select BuildLoc FROM BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & SelectedProdNo & "'"

            'clear the slot if the rails are marked as picked - yellowed
            cmd11.CommandText = "Update Rails_KittingLocations Set InUse = 0 Where ProdNo = '" & SelectedProdNo & "'"

            cmd.Connection = conn
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

            conn.Open()
            'MesgBox(rbList.SelectedValue)
            'MesgBox(Key)
            'MesgBox(SelectedProdNo)
            cmd.ExecuteNonQuery()
            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())

            lblBoatsStarted.Text = recordcount

            framesreadytostart = Convert.ToInt16(cmd8.ExecuteScalar)
            framesreadytostartio = Convert.ToInt16(cmd9.ExecuteScalar)
            lblReadytoStart.Text = framesreadytostart
            lblios.Text = framesreadytostartio
            building = cmd10.ExecuteScalar()

            gvAllFieldsR.DataBind()

            'greenlightcount = Convert.ToInt16(cmd3.ExecuteScalar())

            'If building = "M" Then

            '    If greenlightcount = 1 Then '5 major greenlights are green

            '        tubeneeded = Convert.ToInt16(cmd6.ExecuteScalar()) 'is a centertube on the order
            '        tubecomplete = Convert.ToInt16(cmd7.ExecuteScalar()) 'if so, is it complete?

            '        If tubeneeded = 0 Then 'not on the order
            '            cmd4.ExecuteNonQuery() 'start frames to start.
            '        ElseIf tubeneeded = 1 And tubecomplete = 0 Then 'if on the order and complete, set frames to start.
            '            cmd5.ExecuteNonQuery()
            '        ElseIf tubeneeded = 1 And tubecomplete = 1 Then ' if on the order and not complete, reverse frames.
            '            cmd4.ExecuteNonQuery()
            '        End If
            '    Else
            '        cmd5.ExecuteNonQuery()
            '    End If
            'End If

            'If Yellow then rails are picked so clear the slot
            If rbList.SelectedValue = 1 Or rbList.SelectedValue = 2 Then
                'Try
                    cmd11.ExecuteNonQuery()
                'Catch ex As Exception
                'End Try
            End If

            conn.Close()
        End If

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String
        Dim framesreadytostart As Int16
        Dim framesreadytostartio As Int16


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

        If ddlShowSelect.SelectedValue = 2 Then
            gvAllFieldsR.Columns(7).Visible = True
        Else : gvAllFieldsR.Columns(7).Visible = False
        End If

        'ddlDaysInAdvance.SelectedIndex = 2
        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsStatus = 2 and Convert(date,RailsLastUpdated) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"

        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn


        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount

        framesreadytostart = Convert.ToInt16(cmd3.ExecuteScalar)
        framesreadytostartio = Convert.ToInt16(cmd4.ExecuteScalar)

        lblReadytoStart.Text = framesreadytostart
        lblios.Text = framesreadytostartio

        conn.Close()
    End Sub

    Protected Sub ddlShowSelect_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlShowSelect.SelectedIndexChanged
        gvAllFieldsR.DataBind() 'used to allow the user to hide/show jobs that they have completed.
        If ddlShowSelect.SelectedValue = 2 Then
            gvAllFieldsR.Columns(7).Visible = True
        Else : gvAllFieldsR.Columns(7).Visible = False
        End If
    End Sub

    Protected Sub ddlDaysInAdvance_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDaysInAdvance.SelectedIndexChanged

        gvAllFieldsR.DataBind()
        If ddlShowSelect.SelectedValue = 2 Then
            gvAllFieldsR.Columns(7).Visible = True
        Else : gvAllFieldsR.Columns(7).Visible = False
        End If
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsR.DataBind()
        If ddlShowSelect.SelectedValue = 2 Then
            gvAllFieldsR.Columns(7).Visible = True
        Else : gvAllFieldsR.Columns(7).Visible = False
        End If
    End Sub

    Protected Sub gvFabOptionsRails_RowDataBound(sender As Object, e As GridViewRowEventArgs)

    End Sub


    Protected Sub gvRailsData_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                If e.Row.DataItem("CustDrawNo") = "" Then
                    e.Row.Cells(7).BackColor = System.Drawing.Color.White
                Else
                    e.Row.Cells(7).BackColor = System.Drawing.Color.Yellow
                End If
            Catch ex As Exception

            End Try

        End If
    End Sub


    Protected Sub cbPF_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        Dim SelectedProdNo As String = row.Cells(0).Text
        Dim PF As Integer = If(chk.Checked, 1, 0)

        cmd1.Parameters.AddWithValue("@PF", PF)
        cmd2.Parameters.AddWithValue("@PF", PF)


        cmd3.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd3.Parameters.AddWithValue("@Note", "Missing PF")
        cmd3.Parameters.AddWithValue("@BoatNotesProdNo", SelectedProdNo)
        cmd3.Parameters.AddWithValue("@Workstation", "Rails")
        cmd3.Parameters.AddWithValue("@CreatedFor", "RailsPrep")

        cmd.CommandText = "Select Count(ProdNo) From Rails_MissingOrDamaged where ProdNo =  '" & SelectedProdNo & "'"
        cmd1.CommandText = "UPDATE Rails_MissingOrDamaged SET PF = @PF, PF_Date = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "INSERT Into Rails_MissingOrDamaged(ProdNo,PF,PF_Date) VALUES ( '" & SelectedProdNo & "', @PF, '" & TodaysDate & "')"
        cmd3.CommandText = "Insert into BML_POPREPORTING_NOTES (Date, Note, ProdNo, Workstation, CreatedFor) VALUES (@TodaysDate, @Note, @BoatNotesProdNo, @Workstation, @CreatedFor)"
        cmd4.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set NotesRailsPrep = '1',BoatHasNotes ='1' where ProdNo = '" & SelectedProdNo & "'"

        conn.Open()

        Dim exists As Integer = cmd.ExecuteScalar

        If exists = 1 Then
            cmd1.ExecuteNonQuery()
        Else
            cmd2.ExecuteNonQuery()
        End If

        If chk.Checked = True Then
            cmd3.ExecuteNonQuery()
            cmd4.ExecuteNonQuery()
        End If


        conn.Close()
        gvAllFieldsR.DataBind()


    End Sub


    Protected Sub cbSF_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        Dim SelectedProdNo As String = row.Cells(0).Text
        Dim SF As Integer = If(chk.Checked, 1, 0)

        cmd1.Parameters.AddWithValue("@SF", SF)
        cmd2.Parameters.AddWithValue("@SF", SF)

        cmd3.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd3.Parameters.AddWithValue("@Note", "Missing SF")
        cmd3.Parameters.AddWithValue("@BoatNotesProdNo", SelectedProdNo)
        cmd3.Parameters.AddWithValue("@Workstation", "Rails")
        cmd3.Parameters.AddWithValue("@CreatedFor", "RailsPrep")

        cmd.CommandText = "Select Count(ProdNo) From Rails_MissingOrDamaged where ProdNo =  '" & SelectedProdNo & "'"
        cmd1.CommandText = "UPDATE Rails_MissingOrDamaged SET SF = @SF,SF_Date = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "INSERT Into Rails_MissingOrDamaged(ProdNo,SF,SF_Date) VALUES ( '" & SelectedProdNo & "', @SF, '" & TodaysDate & "')"
        cmd3.CommandText = "Insert into BML_POPREPORTING_NOTES (Date, Note, ProdNo, Workstation, CreatedFor) VALUES (@TodaysDate, @Note, @BoatNotesProdNo, @Workstation, @CreatedFor)"
        cmd4.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set NotesRailsPrep = '1',BoatHasNotes ='1' where ProdNo = '" & SelectedProdNo & "'"

        conn.Open()

        Dim exists As Integer = cmd.ExecuteScalar

        If exists = 1 Then
            cmd1.ExecuteNonQuery()
        Else
            cmd2.ExecuteNonQuery()
        End If

        If chk.Checked = True Then
            cmd3.ExecuteNonQuery()
            cmd4.ExecuteNonQuery()
        End If

        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub cbPR_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        Dim SelectedProdNo As String = row.Cells(0).Text
        Dim PR As Integer = If(chk.Checked, 1, 0)

        cmd1.Parameters.AddWithValue("@PR", PR)
        cmd2.Parameters.AddWithValue("@PR", PR)

        cmd3.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd3.Parameters.AddWithValue("@Note", "Missing PR")
        cmd3.Parameters.AddWithValue("@BoatNotesProdNo", SelectedProdNo)
        cmd3.Parameters.AddWithValue("@Workstation", "Rails")
        cmd3.Parameters.AddWithValue("@CreatedFor", "RailsPrep")

        cmd.CommandText = "Select Count(ProdNo) From Rails_MissingOrDamaged where ProdNo =  '" & SelectedProdNo & "'"
        cmd1.CommandText = "UPDATE Rails_MissingOrDamaged SET PR = @PR,PR_Date = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "INSERT Into Rails_MissingOrDamaged(ProdNo,PR,PR_Date) VALUES ( '" & SelectedProdNo & "', @PR, '" & TodaysDate & "')"
        cmd3.CommandText = "Insert into BML_POPREPORTING_NOTES (Date, Note, ProdNo, Workstation, CreatedFor) VALUES (@TodaysDate, @Note, @BoatNotesProdNo, @Workstation, @CreatedFor)"
        cmd4.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set NotesRailsPrep = '1', BoatHasNotes ='1' where ProdNo = '" & SelectedProdNo & "'"


        conn.Open()

        Dim exists As Integer = cmd.ExecuteScalar

        If exists = 1 Then
            cmd1.ExecuteNonQuery()
        Else
            cmd2.ExecuteNonQuery()
        End If
        If chk.Checked = True Then
            cmd3.ExecuteNonQuery()
            cmd4.ExecuteNonQuery()
        End If

        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub cbSR_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        Dim SelectedProdNo As String = row.Cells(0).Text
        Dim SR As Integer = If(chk.Checked, 1, 0)

        cmd1.Parameters.AddWithValue("@SR", SR)
        cmd2.Parameters.AddWithValue("@SR", SR)

        cmd3.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd3.Parameters.AddWithValue("@Note", "Missing SR")
        cmd3.Parameters.AddWithValue("@BoatNotesProdNo", SelectedProdNo)
        cmd3.Parameters.AddWithValue("@Workstation", "Rails")
        cmd3.Parameters.AddWithValue("@CreatedFor", "RailsPrep")

        cmd.CommandText = "Select Count(ProdNo) From Rails_MissingOrDamaged where ProdNo =  '" & SelectedProdNo & "'"
        cmd1.CommandText = "UPDATE Rails_MissingOrDamaged SET SR = @SR,SR_Date = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "INSERT Into Rails_MissingOrDamaged(ProdNo,SR,SR_Date) VALUES ( '" & SelectedProdNo & "', @SR, '" & TodaysDate & "')"
        cmd3.CommandText = "Insert into BML_POPREPORTING_NOTES (Date, Note, ProdNo, Workstation, CreatedFor) VALUES (@TodaysDate, @Note, @BoatNotesProdNo, @Workstation, @CreatedFor)"
        cmd4.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set NotesRailsPrep = '1',BoatHasNotes ='1' where ProdNo = '" & SelectedProdNo & "'"

        conn.Open()

        Dim exists As Integer = cmd.ExecuteScalar

        If exists = 1 Then
            cmd1.ExecuteNonQuery()
        Else
            cmd2.ExecuteNonQuery()
        End If

        If chk.Checked = True Then
            cmd3.ExecuteNonQuery()
            cmd4.ExecuteNonQuery()
        End If

        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub cbT_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand


        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        Dim SelectedProdNo As String = row.Cells(0).Text
        Dim T As Integer = If(chk.Checked, 1, 0)

        cmd1.Parameters.AddWithValue("@T", T)
        cmd2.Parameters.AddWithValue("@T", T)

        cmd3.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd3.Parameters.AddWithValue("@Note", "Missing Transom Rail")
        cmd3.Parameters.AddWithValue("@BoatNotesProdNo", SelectedProdNo)
        cmd3.Parameters.AddWithValue("@Workstation", "Rails")
        cmd3.Parameters.AddWithValue("@CreatedFor", "RailsPrep")

        cmd.CommandText = "Select Count(ProdNo) From Rails_MissingOrDamaged where ProdNo =  '" & SelectedProdNo & "'"
        cmd1.CommandText = "UPDATE Rails_MissingOrDamaged SET T = @T,T_Date = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "INSERT Into Rails_MissingOrDamaged(ProdNo,T,T_Date) VALUES ( '" & SelectedProdNo & "', @T, '" & TodaysDate & "')"
        cmd3.CommandText = "Insert into BML_POPREPORTING_NOTES (Date, Note, ProdNo, Workstation, CreatedFor) VALUES (@TodaysDate, @Note, @BoatNotesProdNo, @Workstation, @CreatedFor)"
        cmd4.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set NotesRailsPrep = '1',BoatHasNotes ='1' where ProdNo = '" & SelectedProdNo & "'"

        conn.Open()

        Dim exists As Integer = cmd.ExecuteScalar

        If exists = 1 Then
            cmd1.ExecuteNonQuery()
        Else
            cmd2.ExecuteNonQuery()
        End If

        If chk.Checked = True Then
            cmd3.ExecuteNonQuery()
            cmd4.ExecuteNonQuery()
        End If

        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub
    Protected Sub cbPM_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        Dim SelectedProdNo As String = row.Cells(0).Text
        Dim PM As Integer = If(chk.Checked, 1, 0)

        cmd1.Parameters.AddWithValue("@PM", PM)
        cmd2.Parameters.AddWithValue("@PM", PM)

        cmd3.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd3.Parameters.AddWithValue("@Note", "Missing PM")
        cmd3.Parameters.AddWithValue("@BoatNotesProdNo", SelectedProdNo)
        cmd3.Parameters.AddWithValue("@Workstation", "Rails")
        cmd3.Parameters.AddWithValue("@CreatedFor", "RailsPrep")

        cmd.CommandText = "Select Count(ProdNo) From Rails_MissingOrDamaged where ProdNo =  '" & SelectedProdNo & "'"
        cmd1.CommandText = "UPDATE Rails_MissingOrDamaged SET PM = @PM,PM_Date = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "INSERT Into Rails_MissingOrDamaged(ProdNo,PM,PM_Date) VALUES ( '" & SelectedProdNo & "', @PM, '" & TodaysDate & "')"
        cmd3.CommandText = "Insert into BML_POPREPORTING_NOTES (Date, Note, ProdNo, Workstation, CreatedFor) VALUES (@TodaysDate, @Note, @BoatNotesProdNo, @Workstation, @CreatedFor)"
        cmd4.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set NotesRailsPrep = '1',BoatHasNotes ='1' where ProdNo = '" & SelectedProdNo & "'"

        conn.Open()

        Dim exists As Integer = cmd.ExecuteScalar

        If exists = 1 Then
            cmd1.ExecuteNonQuery()
        Else
            cmd2.ExecuteNonQuery()
        End If

        If chk.Checked = True Then
            cmd3.ExecuteNonQuery()
            cmd4.ExecuteNonQuery()
        End If

        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub cbSM_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        Dim SelectedProdNo As String = row.Cells(0).Text
        Dim SM As Integer = If(chk.Checked, 1, 0)

        cmd1.Parameters.AddWithValue("@SM", SM)
        cmd2.Parameters.AddWithValue("@SM", SM)

        cmd3.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd3.Parameters.AddWithValue("@Note", "Missing SM")
        cmd3.Parameters.AddWithValue("@BoatNotesProdNo", SelectedProdNo)
        cmd3.Parameters.AddWithValue("@Workstation", "Rails")
        cmd3.Parameters.AddWithValue("@CreatedFor", "RailsPrep")

        cmd.CommandText = "Select Count(ProdNo) From Rails_MissingOrDamaged where ProdNo =  '" & SelectedProdNo & "'"
        cmd1.CommandText = "UPDATE Rails_MissingOrDamaged SET SM = @SM,SM_Date = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "INSERT Into Rails_MissingOrDamaged(ProdNo,SM,SM_Date) VALUES ( '" & SelectedProdNo & "', @SM, '" & TodaysDate & "')"
        cmd3.CommandText = "Insert into BML_POPREPORTING_NOTES (Date, Note, ProdNo, Workstation, CreatedFor) VALUES (@TodaysDate, @Note, @BoatNotesProdNo, @Workstation, @CreatedFor)"
        cmd4.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set NotesRailsPrep = '1',BoatHasNotes ='1' where ProdNo = '" & SelectedProdNo & "'"

        conn.Open()

        Dim exists As Integer = cmd.ExecuteScalar

        If exists = 1 Then
            cmd1.ExecuteNonQuery()
        Else
            cmd2.ExecuteNonQuery()
        End If
        If chk.Checked = True Then
            cmd3.ExecuteNonQuery()
            cmd4.ExecuteNonQuery()
        End If


        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub


End Class
