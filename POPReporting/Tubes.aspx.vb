
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls


Partial Class Tubes
    Inherits System.Web.UI.Page

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Function SplitBValSlash(val As Object) As String
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("\")(1)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function

    Protected Sub gvAllFieldsT_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsT.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFabOptions"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If

    End Sub

    Protected Sub gvAllFieldsT_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsT.RowCommand

        If e.CommandName = "goto" Then 'handles when the offline/online button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsT.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Tubes" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "gototubedamage" Then

            Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command
            Dim Line() As String = Selected.Split(";")
            Dim SelectedProd As Integer = Line(0)
            Dim SelectedModel As String = Line(1)

            Dim url As String = "./Tubes/ReportDamage.aspx?ProdNo=" & SelectedProd & "&Model=" & SelectedModel
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=1500,height=600,toolbars=1');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "UpdateTStatus" Then
            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvAllFieldsT.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


            Dim rbList As RadioButtonList = DirectCast(gvAllFieldsT.Rows(Key).Cells(4).FindControl("rblTubesStatus"), RadioButtonList)
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
            Dim outertubecount As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET TubesStatus = '" & rbList.SelectedValue & "' , TubesLastUpdated = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = 2 and Convert(date,TubesLastUpdated) ='" & ThisDay & "'"
            'to get the count of the prod #'s completed that day as it changes
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '1', DateAllGreen = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "' and FramesInstalled is NULL"
            cmd5.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '0', DateAllGreen = NULL where ProdNo =  '" & SelectedProdNo & "' and FramesInstalled is NULL"
            'if all green lights are on (covers can be yellow) check if Centertubeneeded is 1 and if CentertubeStatus = 2.  If true, Frames can start.
            cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING where CentertubeNeeded = 1 and ProdNo =  '" & SelectedProdNo & "'"
            cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"
            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1" 'get count boats ready to start
            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'" 'get count of boats that are not ios.
            cmd10.CommandText = "Select BuildLoc FROM BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & SelectedProdNo & "'"
            cmd11.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"

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

            'building = cmd10.ExecuteScalar

            gvAllFieldsT.DataBind()


            'greenlightcount = Convert.ToInt16(cmd3.ExecuteScalar())
            'outertubecount = Convert.ToInt16(cmd11.ExecuteScalar)

            'If building = "M" Then
            '    If greenlightcount = 1 Then '5 major greenlights are green

            '        tubeneeded = Convert.ToInt16(cmd6.ExecuteScalar()) 'is a centertube on the order
            '        tubecomplete = Convert.ToInt16(cmd7.ExecuteScalar()) 'if so, is it complete?

            '        If tubeneeded = 0 Then 'not on the order
            '            cmd4.ExecuteNonQuery() 'start frames to start.
            '        ElseIf tubeneeded = 1 And tubecomplete = 0 Then 'if on the order and complete, reverse frames
            '            cmd5.ExecuteNonQuery()
            '        ElseIf tubeneeded = 1 And tubecomplete = 1 Then ' if on the order and not complete, set frames to start.
            '            cmd4.ExecuteNonQuery()
            '        End If
            '    Else
            '        cmd5.ExecuteNonQuery()
            '    End If
            'End If


            'If building = "S" Then
            '    If outertubecount = 1 Then
            '        tubeneeded = Convert.ToInt16(cmd6.ExecuteScalar()) 'is a centertube on the order
            '        tubecomplete = Convert.ToInt16(cmd7.ExecuteScalar()) 'if so, is it complete?

            '        If tubeneeded = 0 Then 'not on the order
            '            cmd4.ExecuteNonQuery() 'start frames to start.
            '        ElseIf tubeneeded = 1 And tubecomplete = 0 Then 'if on the order and complete, reverse frames
            '            cmd5.ExecuteNonQuery()
            '        ElseIf tubeneeded = 1 And tubecomplete = 1 Then ' if on the order and not complete, set frames to start.
            '            cmd4.ExecuteNonQuery()
            '        End If
            '    Else
            '        cmd5.ExecuteNonQuery()
            '    End If
            'End If

            If rbList.SelectedValue.ToString = "2" Then
                Try
                    If gvAllFieldsT.Rows(Key).DataItem("IsPilot").ToString = "1" Then
                        Dim modelLbl As Label = CType(gvAllFieldsT.Rows(Key).FindControl("lblItemNo"), Label)
                        Dim model As String = modelLbl.Text
                        SpecsGlobalFunctions.EmailPilotTeam(SelectedProdNo, model, "Outer Tubes are Green ")
                    End If

                Catch ex As Exception

                End Try

            End If

            gvNorthReruns.DataBind()
            gvReplacements.DataBind()
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

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)

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
        End If

        If ddlShowSelect.SelectedValue = 2 Then
            gvAllFieldsT.Columns(6).Visible = True
        Else : gvAllFieldsT.Columns(6).Visible = False
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = 2 and Convert(date,TubesLastUpdated) ='" & ThisDay & "'"
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
        gvAllFieldsT.DataBind() 'used to allow the user to hide/show jobs that they have completed.
        If ddlShowSelect.SelectedValue = 1 Then
            gvAllFieldsT.Columns(6).Visible = False
        Else : gvAllFieldsT.Columns(6).Visible = True
        End If
    End Sub

    Protected Sub ddlDaysInAdvance_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDaysInAdvance.SelectedIndexChanged

        gvAllFieldsT.DataBind()
        If ddlShowSelect.SelectedValue = 2 Then
            gvAllFieldsT.Columns(6).Visible = True
        Else : gvAllFieldsT.Columns(6).Visible = False
        End If

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsT.DataBind()
        gvNorthReruns.DataBind()
        If ddlShowSelect.SelectedValue = 2 Then
            gvAllFieldsT.Columns(6).Visible = True
        Else : gvAllFieldsT.Columns(6).Visible = False
        End If
    End Sub

    Protected Sub gvNorthReruns_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvNorthReruns.RowCommand
        If e.CommandName = "gotoupdatePRerun" Then

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim AutoID As Integer = Line(1)
            Dim Prod As String = gvNorthReruns.Rows(id).Cells(0).Text

            Dim NumTubesDamaged As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            Dim TodaysDate As Date = Date.Now

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE Tubes_DamageReported SET ReplacedFlag = 1, Replaced = '" & TodaysDate & "' where AutoID =  '" & AutoID & "'"
            cmd1.CommandText = "UPDATE Tubes Set FinalPStatus = 2, FinalP = '" & TodaysDate & "' Where FinalPStatus < 2 and ProdNo = '" & Prod & "'"
            cmd2.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS Set HasTubeDamage = 0 Where ProdNo = '" & Prod & "'"
            cmd3.CommandText = "Select Count (*) from Tubes_DamageReported where ((RepairReqdFlag = 1 and RepairedFlag = 0) or (ReplaceReqdFlag = 1 and ReplacedFlag = 0)) and ProdNo = '" & Prod & "'"

            conn.Open()

            cmd.ExecuteNonQuery()
            cmd1.ExecuteNonQuery()
            NumTubesDamaged = cmd3.ExecuteScalar()

            If NumTubesDamaged = 0 Then
                cmd2.ExecuteNonQuery()
            End If

            gvNorthReruns.DataBind()
            conn.Close()
        End If

        If e.CommandName = "gotoupdateSRerun" Then

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim AutoID As Integer = Line(1)
            Dim Prod As String = gvNorthReruns.Rows(id).Cells(0).Text

            Dim NumTubesDamaged As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            Dim TodaysDate As Date = Date.Now

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE Tubes_DamageReported SET ReplacedFlag = 1, Replaced = '" & TodaysDate & "' where AutoID =  '" & AutoID & "'"
            cmd1.CommandText = "UPDATE Tubes Set FinalSStatus = 2, FinalS = '" & TodaysDate & "' Where FinalSStatus < 2 and ProdNo = '" & Prod & "'"
            cmd2.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS Set HasTubeDamage = 0 Where ProdNo = '" & Prod & "'"
            cmd3.CommandText = "Select Count (*) from Tubes_DamageReported where ((RepairReqdFlag = 1 and RepairedFlag = 0) or (ReplaceReqdFlag = 1 and ReplacedFlag = 0)) and ProdNo = '" & Prod & "'"

            conn.Open()

            cmd.ExecuteNonQuery()
            cmd1.ExecuteNonQuery()

            NumTubesDamaged = cmd3.ExecuteScalar()

            If NumTubesDamaged = 0 Then
                cmd2.ExecuteNonQuery()
            End If


            gvReplacements.DataBind()
            gvNorthReruns.DataBind()
            conn.Close()
        End If

        If e.CommandName = "gotoupdateCRerun" Then

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim AutoID As Integer = Line(1)
            Dim Prod As String = gvNorthReruns.Rows(id).Cells(0).Text

            Dim NumTubesDamaged As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            Dim TodaysDate As Date = Date.Now

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE Tubes_DamageReported SET ReplacedFlag = 1, Replaced = '" & TodaysDate & "' where AutoID =  '" & AutoID & "'"
            cmd1.CommandText = "UPDATE Tubes Set FinalCStatus = 2, FinalC = '" & TodaysDate & "' Where FinalCStatus < 2 and ProdNo = '" & Prod & "'"
            cmd2.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS Set HasTubeDamage = 0 Where ProdNo = '" & Prod & "'"
            cmd3.CommandText = "Select Count (*) from Tubes_DamageReported where ((RepairReqdFlag = 1 and RepairedFlag = 0) or (ReplaceReqdFlag = 1 and ReplacedFlag = 0)) and ProdNo = '" & Prod & "'"

            conn.Open()

            cmd.ExecuteNonQuery()
            cmd1.ExecuteNonQuery()

            NumTubesDamaged = cmd3.ExecuteScalar()

            If NumTubesDamaged = 0 Then
                cmd2.ExecuteNonQuery()
            End If


            gvReplacements.DataBind()
            gvNorthReruns.DataBind()
            conn.Close()
        End If
    End Sub

    Protected Sub gvReplacements_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvReplacements.RowCommand
        If e.CommandName = "gotoupdatePRPLRerun" Then

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim AutoID As Integer = Line(1)
            Dim Prod As String = gvReplacements.Rows(id).Cells(0).Text

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            Dim TodaysDate As Date = Date.Now

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn

            cmd.CommandType = CommandType.Text

            cmd1.CommandText = "UPDATE Tubes Set FinalPStatus = 2, FinalP = '" & TodaysDate & "' Where ProdNo = '" & Prod & "'"

            conn.Open()


            cmd1.ExecuteNonQuery()
            gvReplacements.DataBind()
            gvNorthReruns.DataBind()

            conn.Close()

            Try
                'Dim floors As String = gvReplacements.Rows(id).DataItem("FloorsInstalledStatus").ToString
                'If floors = "2" Then
                'Send email to Dan
                Dim newline As String = "<br/>"

                Dim SmtpServer As New Net.Mail.SmtpClient()
                Dim mail As New Net.Mail.MailMessage
                'SmtpServer.Host = "elkhart.benningtonmarine.com"
                SmtpServer.Credentials = New System.Net.NetworkCredential("svccopier_smtp@polarisind.com", "dccGqWkzFWrFM4")
                SmtpServer.Host = "smtp.office365.com"
                'SmtpServer.Host = "polaris-com.mail.protection.outlook.com"
                SmtpServer.EnableSsl = True
                SmtpServer.Port = 587

                'mail.From = New Net.Mail.MailAddress("krimbaugh@benningtonmarine.com")
                mail.IsBodyHtml = True
                mail.From = New Net.Mail.MailAddress("svccopier_smtp@polaris.com", "SPECS")

                mail.To.Add("krimbaugh@benningtonmarine.com")
                mail.To.Add("dgorbics@benningtonmarine.com")
                mail.To.Add("trever.schneider@polarisind.com")

                mail.Subject = "Replacement Tube (PORT) is Ready in North for Prod # " & Prod
                mail.IsBodyHtml = True
                Dim mymessage As String = "A PORT replacement tube has been greened in North on " & TodaysDate & " for Prod #: " & Prod & "."
                Dim message As String = mymessage

                mail.Body = message

                SmtpServer.Send(mail)
                'End If

            Catch ex As Exception

            End Try

        End If

        If e.CommandName = "gotoupdateSRPLRerun" Then

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim AutoID As Integer = Line(1)
            Dim Prod As String = gvReplacements.Rows(id).Cells(0).Text

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            Dim TodaysDate As Date = Date.Now

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn

            cmd.CommandType = CommandType.Text

            cmd1.CommandText = "UPDATE Tubes Set FinalSStatus = 2, FinalS = '" & TodaysDate & "' Where ProdNo = '" & Prod & "'"

            conn.Open()


            cmd1.ExecuteNonQuery()
            gvReplacements.DataBind()
            gvNorthReruns.DataBind()
            conn.Close()

            Try
                'Dim floors As String = gvReplacements.Rows(id).DataItem("FloorsInstalledStatus").ToString
                'If floors = "2 Then" Then
                Dim newline As String = "<br/>"


                Dim SmtpServer As New Net.Mail.SmtpClient()
                Dim mail As New Net.Mail.MailMessage
                'SmtpServer.Host = "elkhart.benningtonmarine.com"
                SmtpServer.Credentials = New System.Net.NetworkCredential("svccopier_smtp@polarisind.com", "dccGqWkzFWrFM4")
                SmtpServer.Host = "smtp.office365.com"
                'SmtpServer.Host = "polaris-com.mail.protection.outlook.com"
                SmtpServer.EnableSsl = True
                SmtpServer.Port = 587

                'mail.From = New Net.Mail.MailAddress("krimbaugh@benningtonmarine.com")
                mail.IsBodyHtml = True
                mail.From = New Net.Mail.MailAddress("svccopier_smtp@polaris.com", "SPECS")


                mail.To.Add("krimbaugh@benningtonmarine.com")
                mail.To.Add("dgorbics@benningtonmarine.com")
                mail.To.Add("trever.schneider@polarisind.com")

                mail.Subject = "Replacement Tube (STRB) is Ready in North for Prod # " & Prod
                mail.IsBodyHtml = True
                Dim mymessage As String = "A STRB replacement tube has been greened in North on " & TodaysDate & " for Prod #: " & Prod & "."
                Dim message As String = mymessage

                mail.Body = message

                SmtpServer.Send(mail)
                'End If

            Catch ex As Exception

            End Try
        End If
    End Sub

    Protected Sub gvCSTubes_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCSTubes.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblTube As Label = CType(e.Row.FindControl("lblTube"), Label)

            If e.Row.DataItem("Port") = 1 Then
                lblTube.Text = "PORT"
            ElseIf e.Row.DataItem("Strb") = 1 Then
                lblTube.Text = "STRB"
            End If

        End If
    End Sub

    Protected Sub gvCSTubes_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvCSTubes.RowCommand
        If e.CommandName = "gotoupdateCSPort" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedTubeID As Integer = gvCSTubes.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvCSTubes.Rows(Key).FindControl("btnUpdateCSPRoller"), Image)

            Dim lblDealer As Label = CType(gvCSTubes.Rows(Key).FindControl("lblDealer"), Label)
            Dim lblOE As Label = CType(gvCSTubes.Rows(Key).FindControl("lblOE"), Label)

            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 25, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.
            Dim stationID As String = GlobalVariables.stationID

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

            conn.ConnectionString = connstr

            cmd7.CommandText = "UPDATE CS_Tubes SET FinalPStatus = 2, FinalP = '" & TodaysDate & "', FinalPID = '" & stationID & "' where TubeID =  '" & SelectedTubeID & "'"
            'reversal
            cmd8.CommandText = "UPDATE CS_Tubes SET FinalPStatus = 1, FinalP =  NULL where TubeID =  '" & SelectedTubeID & "'"

            cmd7.Connection = conn
            cmd8.Connection = conn

            conn.Open()

            'If framevalue <> 2 Then
            cmd7.ExecuteNonQuery()
            EmailCSTeam(SelectedTubeID, "port", lblDealer.Text, lblOE.Text)
            'Else
            'cmd8.ExecuteNonQuery()
            'End If

            gvCSTubes.DataBind()


            conn.Close()

        End If
        If e.CommandName = "gotoupdateCSStrb" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedTubeID As Integer = gvCSTubes.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvCSTubes.Rows(Key).FindControl("btnUpdateCSSRoller"), Image)

            Dim lblDealer As Label = CType(gvCSTubes.Rows(Key).FindControl("lblDealer"), Label)
            Dim lblOE As Label = CType(gvCSTubes.Rows(Key).FindControl("lblOE"), Label)


            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 25, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.
            Dim stationID As String = GlobalVariables.stationID


            Dim NumOuterSections As Integer = gvCSTubes.Rows(Key).Cells(5).Text

            'start with all 0s for the seamer sections
            Dim SF As Integer = -1
            Dim SM As Integer = 0
            Dim SM2 As Integer = 0
            Dim SR As Integer = -1

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

            conn.ConnectionString = connstr

            If NumOuterSections = 3 Then
                SM = -1
            ElseIf NumOuterSections = 4 Then
                SM = -1
                SM2 = -1
            End If

            cmd7.Parameters.AddWithValue("@SF", SF)
            cmd7.Parameters.AddWithValue("@SM", SM)
            cmd7.Parameters.AddWithValue("@SM2", SM2)
            cmd7.Parameters.AddWithValue("@SR", SR)

            cmd8.Parameters.AddWithValue("@SF8", 0)
            cmd8.Parameters.AddWithValue("@SM8", 0)
            cmd8.Parameters.AddWithValue("@SM28", 0)
            cmd8.Parameters.AddWithValue("@SR8", 0)


            cmd7.CommandText = "UPDATE CS_Tubes SET FinalSStatus = 2, FinalS = '" & TodaysDate & "', FinalSID = '" & stationID & "' where TubeID =  '" & SelectedTubeID & "'"
            'reversal
            cmd8.CommandText = "UPDATE CS_Tubes SET FinalSStatus = 1, FinalS =  NULL where TubeID =  '" & SelectedTubeID & "'"

            cmd7.Connection = conn
            cmd8.Connection = conn

            conn.Open()

            'If framevalue <> 2 Then
            EmailCSTeam(SelectedTubeID, "strb", lblDealer.Text, lblOE.Text)
            cmd7.ExecuteNonQuery()
            'Else
            'cmd8.ExecuteNonQuery()
            'End If


            gvCSTubes.DataBind()


            conn.Close()
        End If
    End Sub

    Protected Function EmailCSTeam(prod As String, tube As String, dealer As String, oe As String) As String
        Try
            'Send email to Dan
            Dim newline As String = "<br/>"
            Dim tubeSubj As String = ""
            Dim TodaysDate As Date = Date.Now

            If tube = "port" Then
                tubeSubj = "(PORT)"
            ElseIf tube = "strb" Then
                tubeSubj = "(STRB)"
            End If

            Dim SmtpServer As New Net.Mail.SmtpClient()
            Dim mail As New Net.Mail.MailMessage
            'SmtpServer.Host = "elkhart.benningtonmarine.com"
            SmtpServer.Credentials = New System.Net.NetworkCredential("svccopier_smtp@polarisind.com", "dccGqWkzFWrFM4")
            SmtpServer.Host = "smtp.office365.com"
            'SmtpServer.Host = "polaris-com.mail.protection.outlook.com"
            SmtpServer.EnableSsl = True
            SmtpServer.Port = 587

            'mail.From = New Net.Mail.MailAddress("krimbaugh@benningtonmarine.com")
            mail.IsBodyHtml = True
            mail.From = New Net.Mail.MailAddress("svccopier_smtp@polaris.com", "SPECS")

            mail.To.Add("krimbaugh@benningtonmarine.com")
            mail.To.Add("jholdeman@benningtonmarine.com")

            mail.Subject = "Customer Service Tube " & tubeSubj & " is Ready in North for OE # " & oe & "for dealer " & dealer
            mail.IsBodyHtml = True
            Dim mymessage As String = "Customer Service tube " & tubeSubj & " for " & dealer & " has been greened in North on " & TodaysDate & " for OE #: " & oe & "."
            Dim message As String = mymessage

            mail.Body = message

            SmtpServer.Send(mail)
        Catch ex As Exception

        End Try
    End Function

End Class
