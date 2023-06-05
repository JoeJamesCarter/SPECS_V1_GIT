Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Tubes_EvaluateDamage
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

    Protected Function ResetTubeFieldsOnRerunReqd(prod As String, tube As String) As String 'port strb or center

        Try
            Dim cmd As New SqlCommand

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            cmd.Connection = conn
            conn.ConnectionString = connstr

            cmd.Parameters.AddWithValue("@prodno", prod)

            If tube = "PORT" Then
                cmd.CommandText = "Update Tubes Set RollerPStatus = 1, RollerP = NULL, RoundSeamerPStatus = 0, RoundSeamerP = NULL, SeamerSectPFStatus = 0, SeamerSectPF = NULL, SeamerSectPMStatus = 0, SeamerSectPM = NULL, SeamerSectPM2Status = 0, SeamerSectPM2 = NULL, SeamerSectPRStatus = 0, SeamerSectPR = NULL, BafflesSectPFStatus = 0, BafflesSectPF = NULL, BafflesSectPMStatus = 0, BafflesSectPM = NULL, BafflesSectPM2Status = 0, BafflesSectPM2 = NULL, BafflesSectPRStatus = 0, BafflesSectPR = NULL, SeamerPFID = NULL, SeamerPMID = NULL, SeamerPM2ID = NULL, SeamerPRID = NULL, BafflesPFID = NULL, BafflesPMID = NULL, BafflesPM2ID = NULL, BafflesPRID = NULL, RoundSeamerPID = NULL, BracketsPStatus = 0, BracketsP = NULL, BracketsPID = NULL, AirCheckPStatus = 0, AirCheckP = NULL, AirCheckPID = NULL, FinalPStatus = 0, FinalP = NULL, FinalPID = NULL Where ProdNo = @prodno"
            ElseIf tube = "STRB" Then
                cmd.CommandText = "Update Tubes Set RollerSStatus = 1, RollerS = NULL, RoundSeamerSStatus = 0, RoundSeamerS = NULL, SeamerSectSFStatus = 0, SeamerSectSF = NULL, SeamerSectSMStatus = 0, SeamerSectSM = NULL, SeamerSectSM2Status = 0, SeamerSectSM2 = NULL, SeamerSectSRStatus = 0, SeamerSectSR = NULL, BafflesSectSFStatus = 0, BafflesSectSF = NULL, BafflesSectSMStatus = 0, BafflesSectSM = NULL, BafflesSectSM2Status = 0, BafflesSectSM2 = NULL, BafflesSectSRStatus = 0, BafflesSectSR = NULL, SeamerSFID = NULL, SeamerSMID = NULL, SeamerSM2ID = NULL, SeamerSRID = NULL, BafflesSFID = NULL, BafflesSMID = NULL, BafflesSM2ID = NULL, BafflesSRID = NULL, RoundSeamerSID = NULL, BracketsSStatus = 0, BracketsS = NULL, BracketsSID = NULL, AirCheckSStatus = 0, AirCheckS = NULL, AirCheckSID = NULL, FinalSStatus = 0, FinalS = NULL, FinalSID = NULL Where ProdNo = @prodno"
            ElseIf tube = "CTR" Then
                cmd.CommandText = "Update Tubes Set RollerCStatus = 1, RollerC = NULL, RoundSeamerCStatus = 0, RoundSeamerC = NULL, SeamerSectCFStatus = 0, SeamerSectCF = NULL, SeamerSectCMStatus = 0, SeamerSectCM = NULL, SeamerSectCM2Status = 0, SeamerSectCM2 = NULL, SeamerSectCRStatus = 0, SeamerSectCR = NULL, BafflesSectCFStatus = 0, BafflesSectCF = NULL, BafflesSectCMStatus = 0, BafflesSectCM = NULL, BafflesSectCM2Status = 0, BafflesSectCM2 = NULL, BafflesSectCRStatus = 0, BafflesSectCR = NULL, SeamerCFID = NULL, SeamerCMID = NULL, SeamerCM2ID = NULL, SeamerCRID = NULL, BafflesCFID = NULL, BafflesCMID = NULL, BafflesCM2ID = NULL, BafflesCRID = NULL, RoundSeamerCID = NULL, BracketsCStatus = 0, BracketsC = NULL, BracketsCID = NULL, AirCheckCStatus = 0, AirCheckC = NULL, AirCheckCID = NULL Where ProdNo = @prodno"
            End If

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

        Catch ex As Exception

        End Try
    End Function

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        gvTubeDamageEvals.DataBind()
    End Sub

    Protected Sub gvTubeDamageEvals_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvTubeDamageEvals.RowCommand
        If e.CommandName = "gotorepair" Then 'handles when the repair button is clicked

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim Key As Integer = Convert.ToInt16(Line(0))
            Dim ID As Integer = Convert.ToInt16(Line(1))
            Dim SelectedProd As Integer = Line(2)
            Dim SelectedModel As String = Line(3)
            Dim Tube As String = Line(4)
            Dim newline As String = "<br/>"

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            
            Dim stationID As String = GlobalVariables.stationID
            Dim TodaysDate As Date = Date.Now
            Dim actionRequired As String = "REPAIR"
            Dim repairreqdflag As Integer = 1

            cmd.Parameters.AddWithValue("@stationID", stationID)
            cmd.Parameters.AddWithValue("@today", TodaysDate)
            cmd.Parameters.AddWithValue("@action", actionRequired)
            cmd.Parameters.AddWithValue("@repairflag", repairreqdflag)

            cmd.CommandText = "UPDATE Tubes_DamageReported SET EvaluatedBy = @stationID, DateEvaluated = @today, ActionRequired = @action, RepairReqdFlag = @repairflag where AutoID =  '" & ID & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            Try
                'Send email to Dan
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

                mail.To.Add("krimbaugh@benningtonmarine.com")
                mail.To.Add("dgorbics@benningtonmarine.com")
                mail.To.Add("Trever.Schneider@polaris.com")
                mail.To.Add("nreynolds@benningtonmarine.com")

                mail.Subject = "Tube Damage Evaluation Has Resulted in Repair Required"
                mail.IsBodyHtml = True
                Dim mymessage As String = "A repair of a tube has been requested on " & TodaysDate & newline & "Prod #: " & SelectedProd & newline & "Model: " & SelectedModel & newline & "Tube: " & Tube & newline & "Evaluated By: " & stationID & newline & "See Repair Tubes page for more details."
                Dim message As String = mymessage

                mail.Body = message

                SmtpServer.Send(mail)
            Catch ex As Exception

            End Try


            gvTubeDamageEvals.DataBind()
            gvTubeDamageHistory.DataBind()

        End If

        If e.CommandName = "gotoreorder" Then 'handles when the reorder button is clicked

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim Key As Integer = Convert.ToInt16(Line(0))
            Dim ID As Integer = Convert.ToInt16(Line(1))
            Dim SelectedProd As Integer = Line(2)
            Dim SelectedModel As String = Line(3)
            Dim Tube As String = Line(4)
            Dim newline As String = "<br/>"

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn

            Dim stationID As String = GlobalVariables.stationID
            Dim TodaysDate As Date = Date.Now
            Dim actionRequired As String = "REPLACE"
            Dim replacereqdflag As Integer = 1

            cmd.Parameters.AddWithValue("@stationID", stationID)
            cmd.Parameters.AddWithValue("@today", TodaysDate)
            cmd.Parameters.AddWithValue("@action", actionRequired)
            cmd.Parameters.AddWithValue("@replaceflag", replacereqdflag)

            cmd.CommandText = "UPDATE Tubes_DamageReported SET EvaluatedBy = @stationID, DateEvaluated = @today, ActionRequired = @action, ReplaceReqdFlag = @replaceflag, IsScrap = 1 where AutoID =  '" & ID & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            Try
                ResetTubeFieldsOnRerunReqd(SelectedProd, Tube)

                'Send email to Dan

                'Dim TodaysDate As Date = Date.Now
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

                mail.To.Add("krimbaugh@benningtonmarine.com")
                mail.To.Add("dgorbics@benningtonmarine.com")
                mail.To.Add("Trever.Schneider@polaris.com")

                mail.Subject = "Tube Damage Evaluation Has Resulted in Replacement Required"
                mail.IsBodyHtml = True
                Dim mymessage As String = "A replacement tube has been requested on " & TodaysDate & newline & "Prod #: " & SelectedProd & newline & "Model: " & SelectedModel & newline & "Tube: " & Tube & newline & "Evaluated By: " & stationID & newline & "See Repair Tubes page for more details."
                Dim message As String = mymessage

                mail.Body = message

                SmtpServer.Send(mail)
            Catch ex As Exception

            End Try


            gvTubeDamageEvals.DataBind()
            gvTubeDamageHistory.DataBind()

        End If

        If e.CommandName = "gotoshipasis" Then 'handles when the reorder button is clicked

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim Key As Integer = Convert.ToInt16(Line(0))
            Dim ID As Integer = Convert.ToInt16(Line(1))
            Dim SelectedProd As Integer = Line(2)
            Dim SelectedModel As String = Line(3)
            Dim Tube As String = Line(4)
            Dim newline As String = "<br/>"

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn

            Dim stationID As String = GlobalVariables.stationID
            Dim TodaysDate As Date = Date.Now
            Dim actionRequired As String = "OK AS IS"
            Dim shipasisflag As Integer = 1

            cmd.Parameters.AddWithValue("@stationID", stationID)
            cmd.Parameters.AddWithValue("@today", TodaysDate)
            cmd.Parameters.AddWithValue("@action", actionRequired)
            cmd.Parameters.AddWithValue("@shipasisflag", shipasisflag)

            cmd1.Parameters.AddWithValue("@prod", SelectedProd)

            cmd.CommandText = "UPDATE Tubes_DamageReported SET EvaluatedBy = @stationID, DateEvaluated = @today, ActionRequired = @action, ShipAsIsFlag = @shipasisflag where AutoID =  '" & ID & "'"
            cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS Set HasTubeDamage = 0 Where ProdNo = @prod"

            conn.Open()

            cmd.ExecuteNonQuery()
            cmd1.ExecuteNonQuery()

            conn.Close()


            Try
                'Send email to Dan and Blain
                'Dim TodaysDate As Date = Date.Now
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

                mail.To.Add("krimbaugh@benningtonmarine.com")
                mail.To.Add("dgorbics@benningtonmarine.com")
                mail.To.Add("btrosper@benningtonmarine.com")

                mail.Subject = "Tube Damage Evaluation Has Resulted in Ship As Is."
                mail.IsBodyHtml = True
                Dim mymessage As String = "This tube damage has been evaluated and resulted in Ok to Ship As Is On: " & TodaysDate & newline & "Prod #: " & SelectedProd & newline & "Model: " & SelectedModel & newline & "Tube: " & Tube & newline & "Evaluated By: " & stationID & newline
                Dim message As String = mymessage

                mail.Body = message

                SmtpServer.Send(mail)
            Catch ex As Exception

            End Try


            gvTubeDamageEvals.DataBind()
            gvTubeDamageHistory.DataBind()
        End If

    End Sub

    Protected Sub Tubes_EvaluateDamage_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
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

End Class
