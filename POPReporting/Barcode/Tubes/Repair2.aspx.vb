Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Barcode_Tubes_Repair2
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

        Dim prod As String = fullprodno.Split("-")(0)
        Dim section As String = fullprodno.Split("-")(1)

        If fullprodno.Split("-").Count = 3 Then
            tubetype = fullprodno.Split("-")(2)
        End If

        'udpate repair2
        If tubetype = "" Or tubetype = "RERUN" Then
            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then
                cmd.CommandText = "UPDATE Tubes SET Repair2PStatus = 2, Repair2P = @TodaysDate, Repair2PID = @station, AuditPStatus = -1 where ProdNo =  @prodno"
            ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
                cmd.CommandText = "UPDATE Tubes SET Repair2SStatus = 2, Repair2S = @TodaysDate, Repair2SID = @station, AuditSStatus = -1 where ProdNo =  @prodno"
            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                cmd.CommandText = "UPDATE Tubes SET Repair2CStatus = 2, Repair2C = @TodaysDate, Repair2CID = @station, AuditCStatus = -1 where ProdNo =  @prodno"
            End If

        ElseIf tubetype = "WRTY" Then
            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET Repair2PStatus = 2, Repair2P = @TodaysDate, Repair2PID = @station, AuditPStatus = -1 where TubeID =  @prodno"
            ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET Repair2SStatus = 2, Repair2S = @TodaysDate, Repair2SID = @station, AuditSStatus = -1  where TubeID =  @prodno"
            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET Repair2CStatus = 2, Repair2C = @TodaysDate, Repair2CID = @station, AuditCStatus = -1 where TubeID =  @prodno"
            End If
        End If

        conn.Open()

        cmd1.Parameters.AddWithValue("@prodno1", prod)

        cmd.Parameters.AddWithValue("@prodno", prod)
        cmd.Parameters.AddWithValue("@station", stationID)
        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)

        cmd.ExecuteNonQuery()

        conn.Close()

        lblLast.Text = fullprodno
        tbProd.Text = ""
        tbProd.Focus()

    End Function

    Protected Sub tbProd_TextChanged(sender As Object, e As EventArgs) Handles tbProd.TextChanged
        MarkComplete()
    End Sub
End Class
