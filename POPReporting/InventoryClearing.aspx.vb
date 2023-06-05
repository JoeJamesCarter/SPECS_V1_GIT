Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class InventoryClearing
    Inherits System.Web.UI.Page

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

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        gvAreasToClear.DataBind()
    End Sub

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
    End Sub

    Protected Sub gvAreasToClear_RowCommand1(sender As Object, e As GridViewCommandEventArgs) Handles gvAreasToClear.RowCommand
        If e.CommandName = "updateaccept" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim area As String = gvAreasToClear.Rows(Key).Cells(0).Text
            Dim stationID As String = GlobalVariables.stationID
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE Inventory SET ClearingInProgress = 1, ClearingAuditor = '" & stationID & "', TimeAccepted = '" & TodaysDate & "' where Area =  '" & area & "'"
            cmd1.CommandText = "Select ClearingInProgress from Inventory where Area = '" & area & "'"
            conn.Open()

            Dim clearinginprogressflag = cmd1.ExecuteScalar

            If clearinginprogressflag = 0 Then
                cmd.ExecuteNonQuery()
            Else
                'ClientScript.RegisterStartupScript(Me.GetType(), "AlertMessageBox", "alert('This Area has already been accepted by another auditor');", True)
            End If

            conn.Close()
            gvAreasToClear.DataBind()
        End If


        If e.CommandName = "updatecleared" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim area As String = gvAreasToClear.Rows(Key).Cells(0).Text
            Dim stationID As String = GlobalVariables.stationID
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE Inventory SET ClearingInProgress = 0, TimeCleared = '" & TodaysDate & "', Status = 2 where Area =  '" & area & "'"
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvAreasToClear.DataBind()
        End If





    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAreasToClear.DataBind()
    End Sub
End Class
