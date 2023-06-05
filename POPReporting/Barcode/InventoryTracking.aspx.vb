Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Barcode_InventoryTracking
    Inherits System.Web.UI.Page

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        If Not IsPostBack Then
            tbArea.Text = ""
            lblArea.Text = ""
            lblCurrentStatus.Text = ""
        End If

    End Sub

    Protected Sub btnRunReport_Click(sender As Object, e As EventArgs) Handles btnRunReport.Click
        Dim area As String = tbArea.Text
        Dim TodaysDate As Date = Date.Now
        Dim status As Integer = 4

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@status", status)
        cmd.Parameters.AddWithValue("@area", area)
        cmd.Parameters.AddWithValue("@today", TodaysDate)
        cmd.CommandText = "UPDATE Inventory SET Status = @status, ReportRan = @today where Area = @area"

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        tbArea.Text = ""
        lblCurrentStatus.Text = "Report Ran"

        Dim url As String = "http://inventory/Home/GetPdf?areaid=" & area
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1');popUpObj.focus()}</script>")

    End Sub

    Protected Sub btnErrors_Click(sender As Object, e As EventArgs) Handles btnErrors.Click

        Dim area As String = tbArea.Text
        Dim TodaysDate As Date = Date.Now
        Dim status As Integer = 3

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@status", status)
        cmd.Parameters.AddWithValue("@area", area)
        cmd.Parameters.AddWithValue("@today", TodaysDate)
        cmd.CommandText = "UPDATE Inventory SET Status = @status where Area = @area"

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()
        tbArea.Text = ""
        lblCurrentStatus.Text = "Errors"
    End Sub

    Protected Sub btnComplete_Click(sender As Object, e As EventArgs) Handles btnComplete.Click
        Dim area As String = tbArea.Text
        Dim TodaysDate As Date = Date.Now
        Dim status As Integer = 5

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@status", status)
        cmd.Parameters.AddWithValue("@area", area)
        cmd.Parameters.AddWithValue("@today", TodaysDate)
        cmd.CommandText = "UPDATE Inventory SET Status = @status, AreaComplete = @today where Area = @area"

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()
        tbArea.Text = ""
        lblCurrentStatus.Text = "Complete"
    End Sub

    Protected Sub tbArea_TextChanged(sender As Object, e As EventArgs) Handles tbArea.TextChanged
        'get areas current status

        lblArea.Text = tbArea.Text
        Dim area As String = lblArea.Text
        Dim currentStatus As Integer = 0
        Dim currentStatusText As String = ""

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@area", area)
        cmd.CommandText = "Select Status from Inventory Where Area = @area"

        conn.Open()
        currentStatus = cmd.ExecuteScalar
        conn.Close()

        If currentStatus = 0 Then
            currentStatusText = "Not Started"
        ElseIf currentStatus = 1 Then
            currentStatusText = "Clearing Requested"
        ElseIf currentStatus = 2 Then
            currentStatusText = "Cleared"
        ElseIf currentStatus = 3 Then
            currentStatusText = "Errors"
        ElseIf currentStatus = 4 Then
            currentStatusText = "Report Ready"
        ElseIf currentStatus = 5 Then
            currentStatusText = "Complete"
        End If

        lblCurrentStatus.Text = currentStatusText

    End Sub

    Protected Sub Barcode_InventoryTracking_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbArea.Focus()
    End Sub
End Class
