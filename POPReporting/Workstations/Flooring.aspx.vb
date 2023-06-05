﻿Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_Flooring
    Inherits System.Web.UI.Page

    Public PossibleTags As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        gvFloors.DataBind()
    End Sub

    Protected Sub gvFloors_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvFloors.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvFloors.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Floors" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url2 As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url2 + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvFloors.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Floors" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)
        End If

        'This code is for the update button
        If e.CommandName = "gotoupdate" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvFloors.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvFloors.Rows(Key).FindControl("btnUpdateFloors"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 32, 1) 'get the value of FloorsInstalledStatus from the imageurl.
            Dim NextWorkstationHasDate As Int16



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
            Dim recordcountS As Int16 = 0
            Dim isSBoat As Int16 = 0
            Dim isPilot As Int16 = 0
            Dim floorsreadytostart As Int16 = 0
            Dim southshrinkcount As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FloorsInstalledStatus = '2', TrimStatus = '1', FloorsInstalled = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 2 and BuildLoc = 'M' and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
            cmd11.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 2 and BuildLoc = 'V' and Convert(date,FloorsInstalled) ='" & ThisDay & "'"

            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where Trim is not NULL and ProdNo = '" & SelectedProdNo & "'"
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FloorsInstalledStatus = '1', TrimStatus = '0', FloorsInstalled = NULL where ProdNo =  '" & SelectedProdNo & "' and Trim is NULL"
            'cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 2 and BuildLoc = 'S' and ProdNo ='" & SelectedProdNo & "'"
            cmd5.CommandText = "Select IsPilot FROM BML_POPREPORTING_GREENLIGHTS where ProdNo ='" & SelectedProdNo & "'"
            cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > 2100000 and (BuildLoc = 'S' or (BuildLoc = 'M' and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2))"
            cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > 2100000 and BuildLoc = 'M' and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2 and HelmBuildStatus > 0"
            'and (SBNeeded = 0 or (SBNeeded = 1 and SwingbackStatus =2))
            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > 2100000 and BuildLoc = 'S'"
            cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > 2100000 and BuildLoc = 'V' and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2 and HelmBuildStatus > 0"

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


            If floorvalue <= 1 Then
                cmd.ExecuteNonQuery()

                'isSBoat = Convert.ToInt16(cmd5.ExecuteScalar())

                'If isSBoat = 1 Then 'email Jim to come get it

                'cmd8.ExecuteNonQuery() 'Set it to have notes for Rails
                'cmd9.ExecuteNonQuery() 'Add Note for Rails

                'Dim SmtpServer As New Net.Mail.SmtpClient
                'Dim mail As New Net.Mail.MailMessage
                'SmtpServer.Host = "192.168.1.5"
                'SmtpServer.UseDefaultCredentials = False
                'SmtpServer.Credentials = New System.Net.NetworkCredential("krimbaugh@benningtonmarine.com", "keRi0213")

                'mail.From = New Net.Mail.MailAddress("specs@benningtonmarine.com", "SPECS")
                'mail.To.Add("jsmith@benningtonmarine.com")
                'mail.To.Add("krimbaugh@benningtonmarine.com")
                'mail.Subject = "Bennington South Bldg Frame Ready for Pickup - " & SelectedProdNo & ""
                'mail.Body = "Bennington Production #" & SelectedProdNo & " is completed through floors and ready to go to the south building. "
                'SmtpServer.Send(mail)
                'End If

                Try
                    If gvFloors.Rows(Key).DataItem("IsPilot").ToString = "1" Then
                        Dim modelLbl As Label = CType(gvFloors.Rows(Key).FindControl("lblItemNo"), Label)
                        Dim model As String = modelLbl.Text
                        SpecsGlobalFunctions.EmailPilotTeam(SelectedProdNo, model, "Flooring Started ")
                    End If

                Catch ex As Exception

                End Try
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed this boat.")
                Else
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started/finished.
                End If
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            recordcount = Convert.ToInt16(cmd5.ExecuteScalar())

            lblBoatsStarted.Text = recordcount
            lblVBoatsStarted.Text = cmd11.ExecuteScalar
            lblBoatsStartedS.Text = recordcountS

            floorsreadytostart = Convert.ToInt16(cmd6.ExecuteScalar)
            lblReadyToStart.Text = floorsreadytostart
            lblMainReadyToStart.Text = Convert.ToInt16(cmd8.ExecuteScalar)
            lblSouthReadyToStart.Text = Convert.ToInt16(cmd9.ExecuteScalar)
            lblValueReadyToStart.Text = Convert.ToInt16(cmd10.ExecuteScalar)

            'southshrinkcount = Convert.ToInt16(cmd7.ExecuteScalar())
            'lblSouthShrink.Text = southshrinkcount

            gvFloors.DataBind()

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
        Dim cmd9 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim recordcountS As Int16 = 0
        Dim floorsreadytostart As Int16 = 0
        Dim southshrinkcount As Int16 = 0

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
            DaystoShow = ThisDay.AddDays(32).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("40 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(42).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("50 Days", DaystoShow))
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 2 and BuildLoc ='M' and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
        cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 2 and BuildLoc ='V' and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 2 and BuildLoc ='S' and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
        'to get the count of the prod #'s completed that day
        'cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > 160188"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > 180000 and (BuildLoc = 'S' or (BuildLoc = 'M' and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2))"
        cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > 180000 and BuildLoc = 'M' and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2 and HelmBuildStatus > 0"
        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > 180000 and BuildLoc = 'S'"
        cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > 2100000 and BuildLoc = 'V' and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2 and HelmBuildStatus > 0"

        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd8.Connection = conn
        cmd9.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount

        recordcountS = Convert.ToInt16(cmd3.ExecuteScalar())
        lblBoatsStartedS.Text = recordcountS
        lblVBoatsStarted.Text = cmd9.ExecuteScalar

        floorsreadytostart = Convert.ToInt16(cmd4.ExecuteScalar)
        lblReadyToStart.Text = floorsreadytostart
        lblMainReadyToStart.Text = Convert.ToInt16(cmd6.ExecuteScalar)
        lblSouthReadyToStart.Text = Convert.ToInt16(cmd7.ExecuteScalar)
        lblValueReadyToStart.Text = Convert.ToInt16(cmd8.ExecuteScalar)

        'southshrinkcount = Convert.ToInt16(cmd5.ExecuteScalar())
        'lblSouthShrink.Text = southshrinkcount
        'MesgBox(recordcount)
        conn.Close()
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvFloors.DataBind()
    End Sub

    Protected Sub gvFloors_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvFloors.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsFloors"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFabOptionsSSLadder"), SqlDataSource)
            Dim v As SqlDataSource = CType(e.Row.FindControl("sdsTubeData"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                v.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If

            Dim cmd1 As New SqlCommand
            Dim conn1 As New SqlConnection()
            Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
            conn1.ConnectionString = connstr1

            cmd1.Connection = conn1
            cmd1.Parameters.AddWithValue("@ProdNo", e.Row.Cells(0).Text)
            cmd1.CommandText = "SELECT item_no From PPORDFIL_SQL WHERE (user_def_fld_1 = @ProdNo)" 'get full model with year letters from order
            conn1.Open()
            Dim fullModelNo As String = cmd1.ExecuteScalar
            conn1.Close()

            PossibleTags.Clear()
            Dim conn2 As New SqlConnection()
            Dim connstr2 As String = ConfigurationManager.ConnectionStrings("BRAINConnString").ConnectionString
            Dim sqldataadapter As New SqlDataAdapter
            conn2.ConnectionString = connstr2
            cmd1.Parameters.AddWithValue("@ProdNo", e.Row.Cells(0).Text)
            cmd1.CommandText = "SELECT item_no From PPORFIL_SQL WHERE (user_def_fld_1 = @ProdNo)" 'get full model with year letters from order
            conn2.Open()
            sqldataadapter.SelectCommand = New SqlCommand("SELECT CapTagDesc as 'Possible Tag' from CapacityTags where FullModel = '" & fullModelNo & "' and Len(CapTagDesc) > 3 ", conn2)
            sqldataadapter.Fill(PossibleTags)
            conn2.Close()

            Dim gvPossibleTags As GridView = DirectCast(e.Row.FindControl("gvPossibleTags"), GridView)
            gvPossibleTags.DataSource = PossibleTags
            gvPossibleTags.DataBind()

        End If
    End Sub


End Class

