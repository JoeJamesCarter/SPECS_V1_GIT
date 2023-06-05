Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Barcode_Tubes_FinalCenters
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

    Protected Sub btnInProgress_Click(sender As Object, e As EventArgs) Handles btnInProgress.Click

    End Sub
    Protected Sub btnComplete_Click(sender As Object, e As EventArgs) Handles btnComplete.Click

    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbProd.Text = ""
        tbProd.Focus()
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbProd.Focus()
        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
        Label1.Text = GlobalVariables.stationID.ToUpper

        btnComplete.Visible = False
        btnInProgress.Visible = False
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

    Protected Function EmailRplTeam(prod As String, tube As String) As String
        Try
            'Send email to Dan
            Dim newline As String = "<br/>"
            Dim tubeSubj As String = ""
            Dim TodaysDate As Date = Date.Now

            If tube = "ctr" Then
                tubeSubj = "(CTR)"
            End If

            Dim SmtpServer As New Net.Mail.SmtpClient
            Dim mail As New Net.Mail.MailMessage
            SmtpServer.Host = "elkhart.benningtonmarine.com"
            SmtpServer.UseDefaultCredentials = False

            mail.From = New Net.Mail.MailAddress("krimbaugh@benningtonmarine.com")
            mail.To.Add("krimbaugh@benningtonmarine.com")
            mail.To.Add("jgarber@benningtonmarine.com")

            mail.Subject = "Replacement Tube " & tubeSubj & " is Ready in North for Prod # " & prod
            mail.IsBodyHtml = True
            Dim mymessage As String = "Replacement tube " & tubeSubj & " has been greened in North on " & TodaysDate & " for Prod #: " & prod & "."
            Dim message As String = mymessage

            mail.Body = message

            SmtpServer.Send(mail)
        Catch ex As Exception

        End Try
    End Function

    Protected Function EmailCSTeam(prod As String, tube As String) As String
        Try
            'Send email to Dan
            Dim newline As String = "<br/>"
            Dim tubeSubj As String = ""
            Dim TodaysDate As Date = Date.Now

            If tube = "ctr" Then
                tubeSubj = "(CTR)"
            End If

            Dim SmtpServer As New Net.Mail.SmtpClient
            Dim mail As New Net.Mail.MailMessage
            SmtpServer.Host = "elkhart.benningtonmarine.com"
            SmtpServer.UseDefaultCredentials = False

            mail.From = New Net.Mail.MailAddress("krimbaugh@benningtonmarine.com")
            mail.To.Add("krimbaugh@benningtonmarine.com")
            mail.To.Add("jholdeman@benningtonmarine.com")

            mail.Subject = "Customer Service Tube " & tubeSubj & " is Ready in North for CS Tube ID # " & prod
            mail.IsBodyHtml = True
            Dim mymessage As String = "Customer Service tube " & tubeSubj & " has been greened in North on " & TodaysDate & " for CS ID #: " & prod & "."
            Dim message As String = mymessage

            mail.Body = message

            SmtpServer.Send(mail)
        Catch ex As Exception

        End Try
    End Function

    Protected Function MarkComplete() As String

        Dim fullprodno As String = tbProd.Text
        Dim TodaysDate As Date = Date.Now
        Dim stationID As String = GlobalVariables.stationID
        Dim tubetype As String = ""

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand 'companion tube status
        Dim cmd2 As New SqlCommand 'set TubesStatus = 2 if both are done.
        Dim cmd3 As New SqlCommand 'get current tube status, don't re-green and re-date tubes if they are already green.
        Dim cmd4 As New SqlCommand 'only update p or s if it isn't already green.

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
       
        Dim prod As String = fullprodno.Split("-")(0)
        Dim section As String = fullprodno.Split("-")(1)

        If fullprodno.Split("-").Count = 3 Then
            tubetype = fullprodno.Split("-")(2)
        End If

        Dim currentstatus As Integer = 0
        Dim companionstatus As Integer = 0
        Dim currenttubestatus As Integer = 0


        cmd.Parameters.AddWithValue("@prodno", prod)
        cmd.Parameters.AddWithValue("@station", stationID)
        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)

        cmd1.Parameters.AddWithValue("@prodno1", prod)

        cmd2.Parameters.AddWithValue("@prodno2", prod)
        cmd2.Parameters.AddWithValue("@TodaysDate2", TodaysDate)

        conn.Open()

        If tubetype = "" Or tubetype = "RERUN" Then
            If (section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR") Then
                cmd1.CommandText = "Select FinalCStatus From Tubes Where ProdNo = @prodno1"
            End If

        ElseIf tubetype = "WRTY" Then
            If (section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR") Then
                cmd1.CommandText = "Select FinalCStatus From CS_Tubes Where TubeID = @prodno1" 'companion status
            End If

        End If

        currentstatus = cmd1.ExecuteScalar()

        If tubetype = "" Or tubetype = "RERUN" Then

            If (section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR") And currentstatus <> 2 Then
                cmd.CommandText = "UPDATE Tubes SET FinalCStatus = 2, FinalC = @TodaysDate, FinalCID = @station where ProdNo =  @prodno"
                cmd.ExecuteNonQuery() ' update specific tube
                cmd2.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET CentertubeStatus = 2, CentertubeLastUpdated = @TodaysDate2 where CentertubeStatus < 2 and ProdNo = @prodno2"
                cmd2.ExecuteNonQuery()
                If tubetype = "RERUN" Then
                    EmailRplTeam(prod, "ctr")
                End If
            End If

        ElseIf tubetype = "WRTY" Then
            If (section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR") And currentstatus <> 2 Then
                cmd.CommandText = "UPDATE CS_Tubes SET FinalCStatus = 2, FinalC = @TodaysDate, FinalCID = @station where TubeID =  @prodno"
                cmd.ExecuteNonQuery() ' update specific tube
                EmailCSTeam(prod, "ctr")
            End If

        End If

        conn.Close()

        lblLast.Text = fullprodno
        tbProd.Text = ""
        tbProd.Focus()

    End Function

    Protected Sub tbProd_TextChanged(sender As Object, e As EventArgs) Handles tbProd.TextChanged
        MarkComplete()
    End Sub
End Class