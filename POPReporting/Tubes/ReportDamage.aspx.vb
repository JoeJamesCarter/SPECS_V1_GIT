Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Tubes_ReportDamage
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

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        'Dim lblProdNo As Label
        Dim ProdNo As String
        Dim Model As String

        ProdNo = Request.QueryString("ProdNo")
        'Model = Request.QueryString("Model")
        Model = Request.QueryString("Model")
        lblProdNo.Text = ProdNo
        lblModel.Text = Model


        tbPortDamage.Visible = False
        tbStrbDamage.Visible = False
        tbCenterDamage.Visible = False
        ddlPortPrediction.Visible = False
        ddlStrbPrediction.Visible = False
        ddlCenterPrediction.Visible = False

        Label9.Visible = False
        Label10.Visible = False
        Label11.Visible = False

        Label5.Visible = False
        Label6.Visible = False
        Label7.Visible = False

        btnSubmit.Visible = False

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
        tbReportedBy.Text = GlobalVariables.stationID

        If user = "IUSR" Then
            tbReportedBy.Text = ""
        End If

        ddlPScrap.Visible = False
        lblPScrap.Visible = False
        ddlSScrap.Visible = False
        lblSScrap.Visible = False
        ddlCScrap.Visible = False
        lblCScrap.Visible = False


    End Sub

    Protected Function SplitBValSlash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("\")(1)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function

    Protected Function EmailNorth(prod As String, model As String, tube As String, prediction As String) As String
        Try
            'Send email to Dan
            Dim newline As String = "<br/>"

            Dim stationID As String = GlobalVariables.stationID
            Dim TodaysDate As Date = Date.Now

            System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12
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

            mail.To.Add("zspringman@benningtonmarine.com") 'ZS added Zach to monitor 1/10/2023
            mail.To.Add("dgorbics@benningtonmarine.com")
            mail.To.Add("trever.schneider@polarisind.com")

            mail.Subject = "Tube Damage Evaluation Has Resulted in Replacement or Unknown Action Required"
            mail.IsBodyHtml = True
            Dim mymessage As String = "A replacement or unknown tube has been requested on " & TodaysDate & newline & "Prod #: " & prod & newline & "Model: " & model & newline & "Tube: " & tube & newline & "Evaluated By: " & stationID & newline & "Their Prediction: " & prediction & "."
            Dim message As String = mymessage

            mail.Body = message

            SmtpServer.Send(mail)
        Catch ex As Exception

        End Try
    End Function

    Protected Function EmailForEval(prod As String, model As String, tube As String) As String
        Try
            'Send email to Dan
            Dim newline As String = "<br/>"

            Dim stationID As String = GlobalVariables.stationID
            Dim TodaysDate As Date = Date.Now

            System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12
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

            mail.To.Add("msmith@benningtonmarine.com")
            mail.To.Add("bwinkels@benningtonmarine.com")
            mail.To.Add("zspringman@benningtonmarine.com") 'ZS added Zach to monitor 1/10/2023
            mail.To.Add("dgorbics@benningtonmarine.com")
            mail.To.Add("nreynolds@benningtonmarine.com")
            mail.To.Add("trever.schneider@polarisind.com")
            mail.To.Add("bbowlb@polarisind.com")

            mail.Subject = "Tube Damage Is Unknown. Please review. "
            mail.IsBodyHtml = True
            Dim mymessage As String = "Superviser Evaluation required: Tube has been reported on " & TodaysDate & newline & "Prod #: " & prod & newline & "Model: " & model & newline & "Tube: " & tube & newline & "Evaluated By: " & stationID & newline & "See http://specs1/Live/PopReporting/Tubes/EvaluateDamage.aspx for more details."
            Dim message As String = mymessage

            mail.Body = message

            SmtpServer.Send(mail)
        Catch ex As Exception

        End Try
    End Function

    Protected Function ResetTubeFieldsOnRerunReqd(prod As String, tube As String) As String 'port strb or center

        Try
            Dim cmd As New SqlCommand

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            cmd.Connection = conn
            conn.ConnectionString = connstr

            cmd.Parameters.AddWithValue("@prodno", prod)

            If tube = "PORT" Then
                cmd.CommandText = "Update Tubes Set RollerPStatus = 1, RollerP = NULL, RoundSeamerPStatus = 0, RoundSeamerP = NULL, SeamerSectPFStatus = 0, SeamerSectPF = NULL, SeamerSectPMStatus = 0, SeamerSectPM = NULL, SeamerSectPM2Status = 0, SeamerSectPM2 = NULL, SeamerSectPRStatus = 0, SeamerSectPR = NULL, BafflesSectPFStatus = 0, BafflesSectPF = NULL, BafflesSectPMStatus = 0, BafflesSectPM = NULL, BafflesSectPM2Status = 0, BafflesSectPM2 = NULL, BafflesSectPRStatus = 0, BafflesSectPR = NULL, SeamerPFID = NULL, SeamerPMID = NULL, SeamerPM2ID = NULL, SeamerPRID = NULL, BafflesPFID = NULL, BafflesPMID = NULL, BafflesPM2ID = NULL, BafflesPRID = NULL, RoundSeamerPID = NULL, BracketsPStatus = 0, BracketsP = NULL, BracketsPID = NULL, AirCheckPStatus = 0, AirCheckP = NULL, AirCheckPID = NULL, FinalPStatus = 1, FinalP = NULL, FinalPID = NULL Where ProdNo = @prodno"
            ElseIf tube = "STRB" Then
                cmd.CommandText = "Update Tubes Set RollerSStatus = 1, RollerS = NULL, RoundSeamerSStatus = 0, RoundSeamerS = NULL, SeamerSectSFStatus = 0, SeamerSectSF = NULL, SeamerSectSMStatus = 0, SeamerSectSM = NULL, SeamerSectSM2Status = 0, SeamerSectSM2 = NULL, SeamerSectSRStatus = 0, SeamerSectSR = NULL, BafflesSectSFStatus = 0, BafflesSectSF = NULL, BafflesSectSMStatus = 0, BafflesSectSM = NULL, BafflesSectSM2Status = 0, BafflesSectSM2 = NULL, BafflesSectSRStatus = 0, BafflesSectSR = NULL, SeamerSFID = NULL, SeamerSMID = NULL, SeamerSM2ID = NULL, SeamerSRID = NULL, BafflesSFID = NULL, BafflesSMID = NULL, BafflesSM2ID = NULL, BafflesSRID = NULL, RoundSeamerSID = NULL, BracketsSStatus = 0, BracketsS = NULL, BracketsSID = NULL, AirCheckSStatus = 0, AirCheckS = NULL, AirCheckSID = NULL, FinalSStatus = 1, FinalS = NULL, FinalSID = NULL Where ProdNo = @prodno"
            ElseIf tube = "CTR" Then
                cmd.CommandText = "Update Tubes Set RollerCStatus = 1, RollerC = NULL, RoundSeamerCStatus = 0, RoundSeamerC = NULL, SeamerSectCFStatus = 0, SeamerSectCF = NULL, SeamerSectCMStatus = 0, SeamerSectCM = NULL, SeamerSectCM2Status = 0, SeamerSectCM2 = NULL, SeamerSectCRStatus = 0, SeamerSectCR = NULL, BafflesSectCFStatus = 0, BafflesSectCF = NULL, BafflesSectCMStatus = 0, BafflesSectCM = NULL, BafflesSectCM2Status = 0, BafflesSectCM2 = NULL, BafflesSectCRStatus = 0, BafflesSectCR = NULL, SeamerCFID = NULL, SeamerCMID = NULL, SeamerCM2ID = NULL, SeamerCRID = NULL, BafflesCFID = NULL, BafflesCMID = NULL, BafflesCM2ID = NULL, BafflesCRID = NULL, RoundSeamerCID = NULL, BracketsCStatus = 0, BracketsC = NULL, BracketsCID = NULL, AirCheckCStatus = 0, AirCheckC = NULL, AirCheckCID = NULL Where ProdNo = @prodno"
            End If

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

        Catch ex As Exception

        End Try
    End Function

    Protected Function RetainTubeInfoOnReplace(prod As String) As String 'port strb or center

        Try
            Dim cmd As New SqlCommand

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            cmd.Connection = conn
            conn.ConnectionString = connstr

            cmd.Parameters.AddWithValue("@prodno", prod)

            cmd.CommandText = "Insert Into Tubes_RerunsRetainHistory Select * From Tubes Where ProdNo = @prodno" 'everytime damage is reported grab the history for potential further review"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

        Catch ex As Exception

        End Try
    End Function

    Protected Sub cbTubes_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbTubes.SelectedIndexChanged

        Dim User As String = tbReportedBy.Text

        For Each li As ListItem In cbTubes.Items
            If li.Selected = True And li.Value = "Port" Then
                Label9.Visible = True
                Label5.Visible = True
                tbPortDamage.Visible = True
                ddlPortPrediction.Visible = True
                btnSubmit.Visible = True

                If User = "specstube1" Then
                    ddlPScrap.Visible = True
                    lblPScrap.Visible = True
                End If

            End If
            If li.Selected = True And li.Value = "Strb" Then
                Label10.Visible = True
                Label6.Visible = True
                tbStrbDamage.Visible = True
                ddlStrbPrediction.Visible = True
                btnSubmit.Visible = True

                If User = "specstube1" Then
                    ddlSScrap.Visible = True
                    lblSScrap.Visible = True
                End If
            End If
            If li.Selected = True And li.Value = "Ctr" Then
                Label11.Visible = True
                Label7.Visible = True
                tbCenterDamage.Visible = True
                ddlCenterPrediction.Visible = True
                btnSubmit.Visible = True

                If User = "specstube1" Then
                    ddlCScrap.Visible = True
                    lblCScrap.Visible = True
                End If
            End If
        Next
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        'if damage reported by norma-tubes1 then ask if it is scrap when replace is selected bc it might be able to be reused. Mark or Jarrid replacements are immediately scrapped.

        If tbReportedBy.Text = "" Or tbReportedBy.Text = "IUSR" Then
            MesgBox("Please Enter Your Name and Submit Again.")
            Return
        End If

        tbReportedBy.Text = Trim(tbReportedBy.Text)
        Dim reportedBy As String = Trim(tbReportedBy.Text)
        reportedBy = reportedBy.ToLower
        tbReportedBy.Text = reportedBy

        'MesgBox(tbReportedBy.Text)

        Dim whichtubes As String = ""
        Dim howmanytubes As Integer = 0
        Dim portdamage As String = ""
        Dim strbdamage As String = ""
        Dim ctrdamage As String = ""
        Dim stationID As String = GlobalVariables.stationID
        Dim pscrap As Integer = 0
        Dim sscrap As Integer = 0
        Dim cscrap As Integer = 0

        For Each li As ListItem In cbTubes.Items
            If li.Selected = True And li.Value = "Port" Then
                howmanytubes = howmanytubes + 1
                whichtubes = whichtubes & " " & "PORT"
                portdamage = tbPortDamage.Text

                If tbReportedBy.Text = "specstube1" Then
                    pscrap = ddlPScrap.SelectedValue
                End If

            End If

            If li.Selected = True And li.Value = "Strb" Then
                howmanytubes = howmanytubes + 1
                whichtubes = whichtubes & " " & "STRB"
                strbdamage = tbStrbDamage.Text

                If tbReportedBy.Text = "specstube1" Then
                    sscrap = ddlSScrap.SelectedValue
                End If
            End If

            If li.Selected = True And li.Value = "Ctr" Then
                howmanytubes = howmanytubes + 1
                whichtubes = whichtubes & " " & "CTR"
                ctrdamage = tbCenterDamage.Text

                If tbReportedBy.Text = "specstube1" Then
                    cscrap = ddlCScrap.SelectedValue
                End If
            End If
        Next

        If howmanytubes = 0 Then
            MesgBox("Please select which tubes have damage.")
            Return
        End If

        'Send email to Scotty and Mark

        Dim TodaysDate As Date = Date.Now
        System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12
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

        Dim newline As String = "<br/>"

        Dim rackloc As String = ""

        If hdnFilled.Value = "1" Then
            rackloc = hdnRackLocation.Value
        End If

        Dim supervisor As Int16 = 0
        If reportedBy = "msmith" Or reportedBy = "specsshnk1" Or reportedBy = "specsshnk2" Or reportedBy = "specsshrk2" Or reportedBy = "krimba" Or reportedBy = "tschne" Or reportedBy = "ispecshelm1" Or reportedBy = "specsfin1" Or reportedBy = "specstube1" Or reportedBy = "dgorbi" Or reportedBy = "nryeno" Or reportedBy = "specstube1" Then
            'do not email unless Unknown
            supervisor = 1
        End If

        If (ddlPortPrediction.SelectedItem.Text = "Unknown" Or ddlStrbPrediction.SelectedItem.Text = "Unknown" Or ddlCenterPrediction.SelectedItem.Text = "Unknown") Or supervisor = 0 Then

            'mail.From = New Net.Mail.MailAddress("krimbaugh@benningtonmarine.com")

            mail.To.Add("zspringman@benningtonmarine.com") 'ZS added Zach Springman to Monitor 1/10/2023
            mail.To.Add("bbowlb@polarisind.com") 'ZS added Branndon Bowlby 1/10/2023
            mail.To.Add("cthorold@benningtonmarine.com") 'ZS added Chuck Thorold 1/10/2023
            mail.To.Add("nreynolds@benningtonmarine.com")
            mail.To.Add("dgorbics@benningtonmarine.com")
            mail.To.Add("trever.schneider@polarisind.com")

            mail.Subject = "Prod # " & Trim(lblProdNo.Text) & " - Request for Tube Damage Evaluation"
            mail.IsBodyHtml = True
            Dim mymessage As String = "Tube Damage Reported On:" & newline & "Production #: " & Trim(lblProdNo.Text) & newline & "Model:  " & lblModel.Text & newline & " By: " & tbReportedBy.Text & newline & newline & "Tube(s) Reported: " & whichtubes & newline
            Dim mymessage1 As String = "Due Date:     " & hdnDueDate.Value & newline & "Scheduled To Load On: " & hdnLoadDate.Value & newline & "Building: " & hdnBuildLoc.Value & newline & "Current Status: " & hdnCurrentStatus.Value & newline & "Rack Location: " & rackloc & newline
            Dim mymessage2 As String = "Port Damage: " & portdamage & ".   " & tbReportedBy.Text & " Predicts that it: " & ddlPortPrediction.SelectedItem.Text
            Dim mymessage3 As String = "Strb Damage: " & strbdamage & ".  " & tbReportedBy.Text & " Predicts that it: " & ddlStrbPrediction.SelectedItem.Text
            Dim mymessage4 As String = "Center Damage: " & ctrdamage & ".   " & tbReportedBy.Text & " Predicts that it: " & ddlCenterPrediction.SelectedItem.Text
            Dim message As String = mymessage + mymessage1

            For Each li As ListItem In cbTubes.Items
                If li.Selected = True And li.Value = "Port" Then
                    message = message + newline + mymessage2
                End If
                If li.Selected = True And li.Value = "Strb" Then
                    message = message + newline + mymessage3
                End If
                If li.Selected = True And li.Value = "Ctr" Then
                    message = message + newline + mymessage4
                End If

            Next

            mail.Body = message
            Try
                SmtpServer.Send(mail)
            Catch
            End Try

        End If



        'Commit to db
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        'Dim TodaysDate As Date = Date.Now
        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        cmd.Parameters.AddWithValue("@prod", lblProdNo.Text)
        cmd.Parameters.AddWithValue("@PortDmgDesc", portdamage)
        cmd.Parameters.AddWithValue("@PortPrediction", ddlPortPrediction.SelectedValue)
        cmd.Parameters.AddWithValue("@reportedby", tbReportedBy.Text)
        cmd.Parameters.AddWithValue("@today", TodaysDate)

        cmd1.Parameters.AddWithValue("@prod1", lblProdNo.Text)
        cmd1.Parameters.AddWithValue("@StrbDmgDesc1", strbdamage)
        cmd1.Parameters.AddWithValue("@StrbPrediction", ddlStrbPrediction.SelectedValue)
        cmd1.Parameters.AddWithValue("@reportedby1", tbReportedBy.Text)
        cmd1.Parameters.AddWithValue("@today1", TodaysDate)


        cmd2.Parameters.AddWithValue("@prod2", lblProdNo.Text)
        cmd2.Parameters.AddWithValue("@CtrDmgDesc2", tbCenterDamage.Text)
        cmd2.Parameters.AddWithValue("@CtrPrediction", ddlCenterPrediction.SelectedValue)
        cmd2.Parameters.AddWithValue("@reportedby2", tbReportedBy.Text)
        cmd2.Parameters.AddWithValue("@today2", TodaysDate)


        cmd3.Parameters.AddWithValue("@prod3", lblProdNo.Text)

        cmd4.Parameters.AddWithValue("@prod4", lblProdNo.Text)

        Dim reportedByUser As String = Trim(LCase(tbReportedBy.Text))

        If supervisor = 1 Then
            'If LCase(tbReportedBy.Text) = "msmith" Or LCase(tbReportedBy.Text) = "spescshrk1" Or LCase(tbReportedBy.Text) = "specsshrk2" Or LCase(tbReportedBy.Text) = "specsshnk1" Or LCase(tbReportedBy.Text) = "specsshnk2" Or LCase(tbReportedBy.Text) = "krimba" Or LCase(tbReportedBy.Text) = "tleitz" Or LCase(tbReportedBy.Text) = "specstube1" Or LCase(tbReportedBy.Text) = "dgorbi" Then
            If ddlPortPrediction.SelectedValue = "REPAIR" Then
                cmd.Parameters.AddWithValue("@repairreqdflag", 1)
                cmd.Parameters.AddWithValue("@replacereqdflag", 0)
                cmd.Parameters.AddWithValue("@actionreqd", "REPAIR")
                cmd.Parameters.AddWithValue("@pscrap", pscrap)
                cmd.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, PortDmgDesc, PortPredictedAction, ReportedBy, DateReported, EvaluatedBy, DateEvaluated, ActionRequired, RepairReqdFlag, ReplaceReqdFlag, IsScrap) VALUES (@prod, 'PORT', @PortDmgDesc, @PortPrediction, @reportedby, @today, @reportedby, @today, @actionreqd, @repairreqdflag, @replacereqdflag, @pscrap)"
            ElseIf ddlPortPrediction.SelectedValue = "REPLACE" Then
                cmd.Parameters.AddWithValue("@repairreqdflag", 0)
                cmd.Parameters.AddWithValue("@replacereqdflag", 1)
                cmd.Parameters.AddWithValue("@actionreqd", "REPLACE")

                If tbReportedBy.Text = "specstube1" Then
                    cmd.Parameters.AddWithValue("@pscrap", pscrap)
                Else
                    cmd.Parameters.AddWithValue("@pscrap", 1)
                End If
                RetainTubeInfoOnReplace(lblProdNo.Text)
                ResetTubeFieldsOnRerunReqd(lblProdNo.Text, "PORT")
                cmd.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, PortDmgDesc, PortPredictedAction, ReportedBy, DateReported, EvaluatedBy, DateEvaluated, ActionRequired, RepairReqdFlag, ReplaceReqdFlag, IsScrap) VALUES (@prod, 'PORT', @PortDmgDesc, @PortPrediction, @reportedby, @today, @reportedby, @today, @actionreqd, @repairreqdflag, @replacereqdflag, @pscrap)"
            ElseIf ddlPortPrediction.SelectedValue = "Unknown" Then
                cmd.Parameters.AddWithValue("@repairreqdflag", 0)
                cmd.Parameters.AddWithValue("@replacereqdflag", 0)
                cmd.Parameters.AddWithValue("@actionreqd", "UNKNOWN")
                cmd.Parameters.AddWithValue("@pscrap", pscrap)
                cmd.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, PortDmgDesc, PortPredictedAction, ReportedBy, DateReported, ActionRequired, RepairReqdFlag, ReplaceReqdFlag, IsScrap) VALUES (@prod, 'PORT', @PortDmgDesc, @PortPrediction, @reportedby, @today, @actionreqd, @repairreqdflag, @replacereqdflag, @pscrap)"
                EmailForEval(lblProdNo.Text, lblModel.Text, "Port")
            End If

        Else
            cmd.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, PortDmgDesc, PortPredictedAction, ReportedBy, DateReported) VALUES (@prod, 'PORT', @PortDmgDesc, @PortPrediction, @reportedby, @today)"
            'EmailNorth(lblProdNo.Text, lblModel.Text, "Port", ddlPortPrediction.SelectedItem.Text)
        End If

        If supervisor = 1 Then
            'If LCase(tbReportedBy.Text) = "msmith" Or LCase(tbReportedBy.Text) = "spescshrk1" Or LCase(tbReportedBy.Text) = "specsshrk2" Or LCase(tbReportedBy.Text) = "specsshnk1" Or LCase(tbReportedBy.Text) = "specsshnk2" Or LCase(tbReportedBy.Text) = "krimba" Or LCase(tbReportedBy.Text) = "tleitz" Or LCase(tbReportedBy.Text) = "specstube1" Or LCase(tbReportedBy.Text) = "dgorbi" Then
            If ddlStrbPrediction.SelectedValue = "REPAIR" Then
                cmd1.Parameters.AddWithValue("@repairreqdflag1", 1)
                cmd1.Parameters.AddWithValue("@replacereqdflag1", 0)
                cmd1.Parameters.AddWithValue("@actionreqd1", "REPAIR")
                cmd1.Parameters.AddWithValue("@sscrap", 0)
                cmd1.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, StrbDmgDesc, StrbPredictedAction, ReportedBy, DateReported, EvaluatedBy, DateEvaluated, ActionRequired, RepairReqdFlag, ReplaceReqdFlag, IsScrap) VALUES (@prod1, 'STRB', @StrbDmgDesc1, @StrbPrediction, @reportedby1, @today1, @reportedby1, @today1, @actionreqd1, @repairreqdflag1, @replacereqdflag1, @sscrap)"
            ElseIf ddlStrbPrediction.SelectedValue = "REPLACE" Then
                cmd1.Parameters.AddWithValue("@repairreqdflag1", 0)
                cmd1.Parameters.AddWithValue("@replacereqdflag1", 1)
                cmd1.Parameters.AddWithValue("@actionreqd1", "REPLACE")
                cmd1.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, StrbDmgDesc, StrbPredictedAction, ReportedBy, DateReported, EvaluatedBy, DateEvaluated, ActionRequired, RepairReqdFlag, ReplaceReqdFlag, IsScrap) VALUES (@prod1, 'STRB', @StrbDmgDesc1, @StrbPrediction, @reportedby1, @today1, @reportedby1, @today1, @actionreqd1, @repairreqdflag1, @replacereqdflag1, @sscrap)"

                If tbReportedBy.Text = "specstube1" Then
                    cmd1.Parameters.AddWithValue("@sscrap", sscrap)
                Else
                    cmd1.Parameters.AddWithValue("@sscrap", 1)
                End If
                RetainTubeInfoOnReplace(lblProdNo.Text)
                ResetTubeFieldsOnRerunReqd(lblProdNo.Text, "STRB")
            ElseIf ddlStrbPrediction.SelectedValue = "Unknown" Then
                cmd1.Parameters.AddWithValue("@repairreqdflag1", 0)
                cmd1.Parameters.AddWithValue("@replacereqdflag1", 0)
                cmd1.Parameters.AddWithValue("@actionreqd1", "UNKNOWN")
                cmd1.Parameters.AddWithValue("@sscrap", 0)
                cmd1.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, StrbDmgDesc, StrbPredictedAction, ReportedBy, DateReported, ActionRequired, RepairReqdFlag, ReplaceReqdFlag, IsScrap) VALUES (@prod1, 'STRB', @StrbDmgDesc1, @StrbPrediction, @reportedby1, @today1, @reportedby1, @repairreqdflag1, @replacereqdflag1, @sscrap)"
                EmailForEval(lblProdNo.Text, lblModel.Text, "Strb")
            End If

        Else
            cmd1.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, StrbDmgDesc, StrbPredictedAction, ReportedBy, DateReported) VALUES (@prod1, 'STRB', @StrbDmgDesc1, @StrbPrediction, @reportedby1, @today1)"
            'EmailNorth(lblProdNo.Text, lblModel.Text, "Strb", ddlStrbPrediction.SelectedItem.Text)
        End If

        If supervisor = 1 Then
            'If LCase(tbReportedBy.Text) = "msmith" Or LCase(tbReportedBy.Text) = "spescshrk1" Or LCase(tbReportedBy.Text) = "specsshrk2" Or LCase(tbReportedBy.Text) = "specsshnk1" Or LCase(tbReportedBy.Text) = "specsshnk2" Or LCase(tbReportedBy.Text) = "krimba" Or LCase(tbReportedBy.Text) = "tleitz" Or LCase(tbReportedBy.Text) = "specstube1" Or LCase(tbReportedBy.Text) = "dgorbi" Then
            If ddlCenterPrediction.SelectedValue = "REPAIR" Then
                cmd2.Parameters.AddWithValue("@repairreqdflag2", 1)
                cmd2.Parameters.AddWithValue("@replacereqdflag2", 0)
                cmd2.Parameters.AddWithValue("@actionreqd2", "REPAIR")
                cmd2.Parameters.AddWithValue("@cscrap", 0)
                cmd2.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, CtrDmgDesc, CtrPredictedAction, ReportedBy, DateReported, EvaluatedBy, DateEvaluated, ActionRequired, RepairReqdFlag, ReplaceReqdFlag, IsScrap) Values (@prod2, 'CTR', @CtrDmgDesc2, @CtrPrediction, @reportedby2, @today2, @reportedby2, @today2, @actionreqd2, @repairreqdflag2, @replacereqdflag2, @cscrap)"
            ElseIf ddlCenterPrediction.SelectedValue = "REPLACE" Then
                cmd2.Parameters.AddWithValue("@repairreqdflag2", 0)
                cmd2.Parameters.AddWithValue("@replacereqdflag2", 1)
                cmd2.Parameters.AddWithValue("@actionreqd2", "REPLACE")

                If tbReportedBy.Text = "specstube1" Then
                    cmd2.Parameters.AddWithValue("@cscrap", cscrap)
                Else
                    cmd2.Parameters.AddWithValue("@cscrap", 1)
                End If
                RetainTubeInfoOnReplace(lblProdNo.Text)
                ResetTubeFieldsOnRerunReqd(lblProdNo.Text, "CTR")
                cmd2.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, CtrDmgDesc, CtrPredictedAction, ReportedBy, DateReported, EvaluatedBy, DateEvaluated, ActionRequired, RepairReqdFlag, ReplaceReqdFlag, IsScrap) Values (@prod2, 'CTR', @CtrDmgDesc2, @CtrPrediction, @reportedby2, @today2, @reportedby2, @today2, @actionreqd2, @repairreqdflag2, @replacereqdflag2, @cscrap)"
            ElseIf ddlCenterPrediction.SelectedValue = "Unknown" Then
                cmd2.Parameters.AddWithValue("@repairreqdflag2", 0)
                cmd2.Parameters.AddWithValue("@replacereqdflag2", 0)
                cmd2.Parameters.AddWithValue("@actionreqd2", "UNKNOWN")
                cmd2.Parameters.AddWithValue("@cscrap", 0)
                cmd2.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, CtrDmgDesc, CtrPredictedAction, ReportedBy, DateReported, ActionRequired, RepairReqdFlag, ReplaceReqdFlag, IsScrap) Values (@prod2, 'CTR', @CtrDmgDesc2, @CtrPrediction, @reportedby2, @today2, @actionreqd2, @repairreqdflag2, @replacereqdflag2, @cscrap)"
                EmailForEval(lblProdNo.Text, lblModel.Text, "Center")
            End If

        Else
            cmd2.CommandText = "Insert Into Tubes_DamageReported (ProdNo, Tube, CtrDmgDesc, CtrPredictedAction, ReportedBy, DateReported) Values (@prod2, 'CTR', @CtrDmgDesc2, @CtrPrediction, @reportedby2, @today2)"
            'EmailNorth(lblProdNo.Text, lblModel.Text, "Center", ddlCenterPrediction.SelectedItem.Text)
        End If

        cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set HasTubeDamage = 1 Where ProdNo = @prod3"
        'cmd4.CommandText = "Insert Into Tubes_RerunsRetainHistory Select * From Tubes Where ProdNo = @prod4" 'everytime damage is reported grab the history for potential further review

        conn.Open()

        For Each li As ListItem In cbTubes.Items
            If li.Selected = True And li.Value = "Port" Then
                cmd.ExecuteNonQuery()
                Try
                    If (supervisor = 1) And (ddlPortPrediction.SelectedValue = "REPLACE" Or ddlPortPrediction.SelectedValue = "Unknown") Then 'have to email Dan about replacements if they are auto evaluated by Mark or Jarrid's Entry.  Then
                        'If (LCase(tbReportedBy.Text) = "msmith" Or LCase(tbReportedBy.Text) = "spescshrk1" Or LCase(tbReportedBy.Text) = "specsshrk2" Or LCase(tbReportedBy.Text) = "specsshnk2" Or LCase(tbReportedBy.Text) = "krimba" Or LCase(tbReportedBy.Text) = "tleitz") And ddlPortPrediction.SelectedValue = "REPLACE" Then 'have to email Dan about replacements if they are auto evaluated by Mark or Jarrid's Entry.
                        'EmailNorth(lblProdNo.Text, lblModel.Text, "Port", ddlPortPrediction.SelectedItem.Text)
                    End If
                Catch ex As Exception
                End Try
                li.Selected = False
            End If
            If li.Selected = True And li.Value = "Strb" Then
                cmd1.ExecuteNonQuery()
                Try
                    If (supervisor = 1) And (ddlStrbPrediction.SelectedValue = "REPLACE" Or ddlStrbPrediction.SelectedValue = "Unknown") Then
                        'If (LCase(tbReportedBy.Text) = "msmith" Or LCase(tbReportedBy.Text) = "specsshrk1" Or LCase(tbReportedBy.Text) = "specsshrk2" Or LCase(tbReportedBy.Text) = "specsshnk1" Or LCase(tbReportedBy.Text) = "krimba" Or LCase(tbReportedBy.Text) = "tleitz") And ddlStrbPrediction.SelectedValue = "REPLACE" Then
                        'EmailNorth(lblProdNo.Text, lblModel.Text, "Strb", ddlStrbPrediction.SelectedItem.Text)
                    End If
                Catch ex As Exception
                End Try
                li.Selected = False
            End If
            If li.Selected = True And li.Value = "Ctr" Then
                cmd2.ExecuteNonQuery()
                Try
                    If (supervisor = 1) And (ddlCenterPrediction.SelectedValue = "REPLACE" Or ddlCenterPrediction.SelectedValue = "Unknown") Then
                        'If (LCase(tbReportedBy.Text) = "msmith" Or LCase(tbReportedBy.Text) = "specsshrk1" Or LCase(tbReportedBy.Text) = "specsshrk2" Or LCase(tbReportedBy.Text) = "specsshrnk1" Or LCase(tbReportedBy.Text) = "krimba" Or LCase(tbReportedBy.Text) = "tleitz") And ddlCenterPrediction.SelectedValue = "REPLACE" Then
                        'EmailNorth(lblProdNo.Text, lblModel.Text, "Ctr", ddlCenterPrediction.SelectedItem.Text)
                    End If
                Catch ex As Exception
                End Try
                li.Selected = False
            End If
        Next

        cmd3.ExecuteNonQuery()
        'cmd4.ExecuteNonQuery() moved to a function

        conn.Close()

        'Reset fields
        tbReportedBy.Text = ""
        tbCenterDamage.Text = ""
        tbPortDamage.Text = ""
        tbStrbDamage.Text = ""
        ddlPortPrediction.SelectedIndex = -1
        ddlStrbPrediction.SelectedIndex = -1
        ddlCenterPrediction.SelectedIndex = -1

        gvTubeDamageHistory.DataBind()

        ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
        Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")
    End Sub

    Protected Sub gvBoatData_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBoatData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            hdnBuildLoc.Value = e.Row.DataItem("BuildLoc")
            hdnDueDate.Value = e.Row.DataItem("DueDate")

            If e.Row.DataItem("Filled").ToString Is DBNull.Value Or e.Row.DataItem("Filled").ToString = "0" Then
                hdnFilled.Value = "0"
                hdnRackLocation.Value = ""
            Else
                hdnFilled.Value = e.Row.DataItem("Filled").ToString
                hdnRackLocation.Value = e.Row.DataItem("SlotKey").ToString
            End If

            If e.Row.DataItem("ActualLoadDate").ToString Is DBNull.Value Then
                hdnLoadDate.Value = ""
            Else
                hdnLoadDate.Value = e.Row.DataItem("ActualLoadDate").ToString

            End If

            If e.Row.DataItem("CurrentStatus").ToString Is DBNull.Value Then
                hdnCurrentStatus.Value = ""
            Else
                hdnCurrentStatus.Value = e.Row.DataItem("CurrentStatus").ToString
            End If
        End If

    End Sub
End Class
