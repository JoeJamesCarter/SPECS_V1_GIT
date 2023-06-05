Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Barcode_Tubes_Transom
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

    Protected Function MarkComplete() As String

        Dim fullprodno As String = tbProd.Text
        Dim TodaysDate As Date = Date.Now
        Dim stationID As String = GlobalVariables.stationID
        Dim tubetype As String = ""

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand 'current status

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn
        cmd1.Connection = conn

        Dim prod As String = fullprodno.Split("-")(0)
        Dim section As String = fullprodno.Split("-")(1)

        If fullprodno.Split("-").Count = 3 Then
            tubetype = fullprodno.Split("-")(2)
        End If

        Dim currentstatus As Integer
        Dim statusSet As String = ""

        cmd.Parameters.AddWithValue("@prodno", prod)
        cmd.Parameters.AddWithValue("@station", stationID)
        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)

        cmd1.Parameters.AddWithValue("@prodno1", prod)

        If tubetype = "" Or tubetype = "RERUN" Then
            'Get current Transom status to determine if next step is in progress or complete.
           If (section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR") Then
                cmd1.CommandText = "Select TransomCStatus From Tubes Where ProdNo = @prodno1"
            End If
        ElseIf tubetype = "WRTY" Then
            If (section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR") Then
                cmd1.CommandText = "Select TransomCStatus From CS_Tubes Where TubeID = @prodno1"
            End If
        End If


        conn.Open()
        currentstatus = cmd1.ExecuteScalar

        'outers go to final, centers go to transoms

        If tubetype = "" Or tubetype = "" Then
          
            If (section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR") And (currentstatus.ToString = "-1" Or currentstatus = 0) Then
                cmd.CommandText = "UPDATE Tubes SET TransomCStatus = 1, TransomC = @TodaysDate, TransomCID = @station where ProdNo =  @prodno"
                statusSet = "In Progress "
            ElseIf (section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR") And currentstatus = 1 Then
                cmd.CommandText = "UPDATE Tubes SET TransomCStatus = 2, TransomC = @TodaysDate, TransomCID = @station, FinalCStatus = -1 where FinalCStatus < 2 and ProdNo =  @prodno"
                statusSet = "Complete"
            End If

        ElseIf tubetype = "WRTY" Then
            If (section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR") And (currentstatus.ToString = "-1" Or currentstatus = 0) Then
                cmd.CommandText = "UPDATE CS_Tubes SET TransomCStatus = 1, TransomC = @TodaysDate, TransomCID = @station where TubeID =  @prodno"
                statusSet = "In Progress "
            ElseIf (section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR") And currentstatus = 1 Then
                cmd.CommandText = "UPDATE CS_Tubes SET TransomCStatus = 2, TransomC = @TodaysDate, TransomCID = @station, FinalCStatus = -1 where FinalCStatus < 2 and TubeID =  @prodno"
                statusSet = "Complete"
            End If

        End If


        If currentstatus < 2 Then
            cmd.ExecuteNonQuery()
        End If

        conn.Close()


        If currentstatus = -1 Then
            btnInProgress.Visible = True
            btnComplete.Visible = False
        ElseIf currentstatus = 1 Then
            btnComplete.Visible = True
            btnInProgress.Visible = False
        End If

        'lblLastStatus.Text = statusSet
        lblLast.Text = fullprodno
        tbProd.Text = ""
        tbProd.Focus()

    End Function

    Protected Sub tbProd_TextChanged(sender As Object, e As EventArgs) Handles tbProd.TextChanged
        MarkComplete()
    End Sub
End Class
