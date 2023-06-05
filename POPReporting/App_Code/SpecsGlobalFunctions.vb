Public Class SpecsGlobalFunctions
    Public Shared Function EmailPilotTeam(prod As String, model As String, workstation As String) As String
        Try
            'Send email to Pilot Team when a Pilot boat is has tubes completed, before framing, when the rails are all here, and when it is completed thru floors.
            Dim newline As String = "<br/>"

            Dim TodaysDate As Date = Date.Now

            Dim SmtpServer As New Net.Mail.SmtpClient
            Dim mail As New Net.Mail.MailMessage
            SmtpServer.Host = "elkhart.benningtonmarine.com"
            SmtpServer.UseDefaultCredentials = False

            mail.From = New Net.Mail.MailAddress("krimbaugh@benningtonmarine.com")
            mail.To.Add("krimbaugh@benningtonmarine.com")

            'mail.To.Add("aweiss@benningtonmarine.com")
            'mail.To.Add("bdonat@benningtonmarine.com")
            'mail.To.Add("skantz@benningtonmarine.com")
            'mail.To.Add("msmith@benningtonmarine.com")
            'mail.To.Add("kbruens@benningtonmarine.com")
            'mail.To.Add("jwarfel@benningtonmarine.com")
            'mail.To.Add("ecarillo@benningtonmarine.com")
            'mail.To.Add("jjourdan@benningtonmarine.com")

            mail.Subject = "Pilot Boat has Completed Thru " & workstation & " - Prod #: " & prod
            mail.IsBodyHtml = True
            Dim mymessage As String = "A Pilot boat has completed thru " & workstation & " on " & TodaysDate & newline & "Prod #: " & prod & newline & "Model: " & model & "."
            Dim message As String = mymessage

            mail.Body = message

            SmtpServer.Send(mail)
        Catch ex As Exception

        End Try

    End Function
End Class