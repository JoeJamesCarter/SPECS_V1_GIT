Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Materials_MaintainPartsByLocation
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvPartsByLocation_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvPartsByLocation.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim item As String = e.Row.Cells(1).Text
            Dim cost As Decimal

            'Mesgbox(item)
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.CommandText = "Select last_cost from IMINVLOC_SQL Where item_no = '" & item & "'"

            conn.Open()

            cost = cmd.ExecuteScalar
            conn.Close()

            e.Row.Cells(8).Text = cost.ToString("N2")

        End If
    End Sub
End Class
