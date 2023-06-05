Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Barcode_Tubes_Audit
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

    Protected Function MarkComplete() As String
        'If it is an outer with foils or a center with chines turn on chines else if it is outer set final to ready.
        'Copied Aircheck to repeat logic that should really be at repair2 instead. Repair2 will turn on chines or not based on strakes.

        Dim fullprodno As String = tbProd.Text
        Dim TodaysDate As Date = Date.Now
        Dim stationID As String = GlobalVariables.stationID
        Dim tubetype As String = ""
        Dim strakes As String = ""

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand 'Check for Strakes or Foils
        Dim cmd2 As New SqlCommand 'Set Final or Chines to -1 based on strakes

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


        'get strakes
        If tubetype = "" Or tubetype = "RERUN" Then
            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Or section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
                cmd1.CommandText = "SELECT Strakes from OuterTubeDetails Where ProdNo = @prodno1"
            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                cmd1.CommandText = "SELECT Strakes from CentertubeDetails Where ProdNo = @prodno1"
            End If

        ElseIf tubetype = "WRTY" Then
            cmd1.CommandText = "SELECT Strakes from CS_Tubes Where TubeID = @prodno1"
        End If

        'udpate repair2
        If tubetype = "" Or tubetype = "RERUN" Then
            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then
                cmd.CommandText = "UPDATE Tubes SET AuditPStatus = 2, AuditP = @TodaysDate, AuditPID = @station where ProdNo =  @prodno"
            ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
                cmd.CommandText = "UPDATE Tubes SET AuditSStatus = 2, AuditS = @TodaysDate, AuditSID = @station where ProdNo =  @prodno"
            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                cmd.CommandText = "UPDATE Tubes SET AuditCStatus = 2, AuditC = @TodaysDate, AuditCID = @station where ProdNo =  @prodno"
            End If

        ElseIf tubetype = "WRTY" Then
            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET AuditPStatus = 2, AuditP = @TodaysDate, AuditPID = @station where TubeID =  @prodno"
            ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET AuditSStatus = 2, AuditS = @TodaysDate, AuditSID = @station where TubeID =  @prodno"
            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET AuditCStatus = 2, AuditC = @TodaysDate, AuditCID = @station where TubeID =  @prodno"
            End If
        End If

        conn.Open()
        cmd1.Parameters.AddWithValue("@prodno1", prod)
        cmd2.Parameters.AddWithValue("@prodno2", prod)
        strakes = cmd1.ExecuteScalar().ToString()

        cmd.Parameters.AddWithValue("@prodno", prod)
        cmd.Parameters.AddWithValue("@station", stationID)
        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)


        'If strakes Like "*FOILS*" Or strakes Like "*STRAKES*" Then
        'MesgBox("Yes")
        'Else
        'MesgBox("No")
        'End If

        cmd.ExecuteNonQuery()

        'update next station
        If tubetype = "" Or tubetype = "RERUN" Then
            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then

                If strakes Like "*FOIL*" Or strakes Like "*CHINE*" Then
                    cmd2.CommandText = "UPDATE Tubes SET ChinesPStatus = -1 where ProdNo =  @prodno2"
                Else
                    cmd2.CommandText = "UPDATE Tubes SET FinalPStatus = -1 where FinalPStatus < 2 and ProdNo =  @prodno2"
                End If

            ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then

                If strakes Like "*FOIL*" Or strakes.ToString() Like "*STRAKES*" Then
                    cmd2.CommandText = "UPDATE Tubes SET ChinesSStatus = -1 where ProdNo =  @prodno2"
                Else
                    cmd2.CommandText = "UPDATE Tubes SET FinalSStatus = -1 where FinalSStatus < 2 and ProdNo =  @prodno2"
                End If

            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                'If strakes Like "*FOIL*" Or strakes Like "*CHINE*" Then
                cmd2.CommandText = "UPDATE Tubes SET ChinesCStatus = -1 where ProdNo =  @prodno2"
                'Else
                'cmd2.CommandText = "UPDATE Tubes SET FinalCStatus = -1 where FinalCStatus < 2 and ProdNo =  @prodno2"
                'End If
            End If

        ElseIf tubetype = "WRTY" Then

            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then
                If strakes Like "*FOIL*" Or strakes Like "*CHINE*" Then
                    cmd2.CommandText = "UPDATE CS_Tubes SET ChinesPStatus = -1 where TubeID =  @prodno2"
                Else
                    cmd2.CommandText = "UPDATE CS_Tubes SET FinalPStatus = -1 where FinalPStatus < 2 and TubeID =  @prodno2"
                End If
            ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
                If strakes Like "*FOIL*" Or strakes Like "*CHINE*" Then
                    cmd2.CommandText = "UPDATE CS_Tubes SET ChinesSStatus = -1 where TubeID =  @prodno2"
                Else
                    cmd2.CommandText = "UPDATE CS_Tubes SET FinalSStatus = -1 where FinalSStatus < 2 and TubeID =  @prodno2"
                End If
            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                'If strakes Like "*FOIL*" Or strakes Like "*CHINE*" Then Note: All Centers get chines, they only designate Salt water on the schedule
                cmd2.CommandText = "UPDATE CS_Tubes SET ChinesCStatus = -1 where TubeID =  @prodno2"
                'Else
                'cmd2.CommandText = "UPDATE CS_Tubes SET FinalCStatus = -1 where FinalCStatus < 2 and TubeID =  @prodno2"
                'End If
            End If

        End If

        cmd2.ExecuteNonQuery()
        conn.Close()

        lblLast.Text = fullprodno
        tbProd.Text = ""
        tbProd.Focus()

    End Function

    Protected Sub tbProd_TextChanged(sender As Object, e As EventArgs) Handles tbProd.TextChanged
        MarkComplete()
    End Sub
End Class
