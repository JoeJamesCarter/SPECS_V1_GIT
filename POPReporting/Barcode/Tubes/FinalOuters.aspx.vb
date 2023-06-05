Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Barcode_Tubes_FinalOuters
    Inherits System.Web.UI.Page
    'This Page allows Norma to scan each tube and auto greens the outers when both Port and Strb are complete.
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
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            Dim floors As String = "0"

            cmd.CommandText = "Select FloorsInstalledStatus From BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & prod & "'"
            conn.Open()
            floors = cmd.ExecuteScalar.ToString
            conn.Close()

            If floors = "2" Then
                Dim newline As String = "<br/>"
                Dim tubeSubj As String = ""
                Dim TodaysDate As Date = Date.Now

                If tube = "port" Then
                    tubeSubj = "(PORT)"
                ElseIf tube = "strb" Then
                    tubeSubj = "(STRB)"
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
            End If

        Catch ex As Exception

        End Try
    End Function

    Protected Function EmailCSTeam(prod As String, tube As String) As String
        Try

            Dim newline As String = "<br/>"
            Dim tubeSubj As String = ""
            Dim TodaysDate As Date = Date.Now

            If tube = "port" Then
                tubeSubj = "(PORT)"
            ElseIf tube = "strb" Then
                tubeSubj = "(STRB)"
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
        cmd3.Connection = conn
        cmd4.Connection = conn

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

        cmd3.Parameters.AddWithValue("@prodno3", prod)

        cmd4.Parameters.AddWithValue("@prodno4", prod)

        conn.Open()

        If tubetype = "" Or tubetype = "RERUN" Then
            If (section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR") Then
                cmd1.CommandText = "Select FinalSStatus From Tubes Where ProdNo = @prodno1" 'companion status
                cmd4.CommandText = "Select FinalPStatus From Tubes Where ProdNo = @prodno4" 'this tube status
            ElseIf (section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR") Then
                cmd1.CommandText = "Select FinalPStatus From Tubes Where ProdNo = @prodno1"
                cmd4.CommandText = "Select FinalSStatus From Tubes Where ProdNo = @prodno4"
            End If
        ElseIf tubetype = "WRTY" Then
            If (section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR") Then
                cmd1.CommandText = "Select FinalSStatus From CS_Tubes Where TubeID = @prodno1" 'companion status
                cmd4.CommandText = "Select FinalPStatus From CS_Tubes Where TubeID = @prodno4" 'this tube status
            ElseIf (section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR") Then
                cmd1.CommandText = "Select FinalPStatus From CS_Tubes Where TubeID = @prodno1"
                cmd4.CommandText = "Select FinalSStatus From CS_Tubes Where TubeID = @prodno4"
            End If
        End If

        currentstatus = cmd4.ExecuteScalar
        companionstatus = cmd1.ExecuteScalar 'check if opposite tube is finished also


        If tubetype = "" Or tubetype = "RERUN" Then

            If (section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR") And currentstatus <> 2 Then
                cmd.CommandText = "UPDATE Tubes SET FinalPStatus = 2, FinalP = @TodaysDate, FinalPID = @station where ProdNo =  @prodno"
                cmd.ExecuteNonQuery() ' update specific tube

                If tubetype = "RERUN" Then
                    EmailRplTeam(prod, "port")
                End If

            ElseIf (section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR") And currentstatus <> 2 Then
                cmd.CommandText = "UPDATE Tubes SET FinalSStatus = 2, FinalS = @TodaysDate, FinalSID = @station where ProdNo =  @prodno"
                cmd.ExecuteNonQuery() ' update specific tube
                If tubetype = "RERUN" Then
                    EmailRplTeam(prod, "strb") 'figure out how to only send if rpl submitted by tubes1
                End If
            End If

        ElseIf tubetype = "WRTY" Then
            If (section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR") And currentstatus <> 2 Then
                cmd.CommandText = "UPDATE CS_Tubes SET FinalPStatus = 2, FinalP = @TodaysDate, FinalPID = @station where TubeID =  @prodno"
                cmd.ExecuteNonQuery() ' update specific tube
                EmailCSTeam(prod, "port")
            ElseIf (section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR") And currentstatus <> 2 Then
                cmd.CommandText = "UPDATE CS_Tubes SET FinalSStatus = 2, FinalS = @TodaysDate, FinalSID = @station where TubeID =  @prodno"
                cmd.ExecuteNonQuery() ' update specific tube
                EmailCSTeam(prod, "strb")
            End If
        End If

        If tubetype = "" Or tubetype = "RERUN" Then
            cmd3.CommandText = "Select TubesStatus From BML_POPREPORTING_GREENLIGHTS Where ProdNo = @prodno3"
            currenttubestatus = cmd3.ExecuteScalar 'get current tube status

            'if it is and tubes aren't already green, green the tubes - cust service tubes are only 1 tube each so there is no master combined tube status

            If companionstatus = 2 And currenttubestatus <> 2 Then ' companion tube status is green
                cmd2.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET TubesStatus = 2, TubesLastUpdated = @TodaysDate2 where ProdNo = @prodno2"
                cmd2.ExecuteNonQuery()
                btnInProgress.Visible = False
                btnComplete.Visible = True
            ElseIf companionstatus <> 2 Then
                btnComplete.Visible = False
                btnInProgress.Visible = True
            ElseIf companionstatus = 2 And currentstatus = 2 Then
                btnComplete.Visible = True
                btnInProgress.Visible = False
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