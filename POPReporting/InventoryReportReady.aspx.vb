Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class InventoryReportReady
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gvAreas_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAreas.RowCommand
        If e.CommandName = "updatestatus" Then
            'This code is for the update button

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim area As String = gvAreas.Rows(Key).Cells(0).Text

            Dim TodaysDate As Date = Date.Now

            'set the value of the radio button equal to what it is in the database on load.

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text

            cmd.CommandText = "UPDATE Inventory.dbo.Inventory SET Status = 8, ReportRan = '" & TodaysDate & "' where Area =  '" & area & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvAreas.DataBind()

        End If


        If e.CommandName = "updatestatustoerrors" Then
            'This code is for the update button

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim area As String = gvAreas.Rows(Key).Cells(0).Text

            Dim TodaysDate As Date = Date.Now

            'set the value of the radio button equal to what it is in the database on load.

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text

            cmd.CommandText = "UPDATE Inventory.dbo.Inventory SET Status = 7 where Area =  '" & area & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvAreas.DataBind()

        End If


    End Sub
    Protected Sub gvAreas_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAreas.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If (e.Row.DataItem("Status") = "7") Then
                e.Row.BackColor = Drawing.Color.Red
            End If
        End If
    End Sub

    Private Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAreas.DataBind()
    End Sub
End Class
