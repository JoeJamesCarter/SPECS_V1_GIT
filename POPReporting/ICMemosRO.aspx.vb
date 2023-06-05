Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class ICMemosRO
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

   

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvMemos.DataBind()
    End Sub

    Protected Sub gvMemos_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvMemos.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim BenPart As String = e.Row.Cells(4).Text
            Dim Vendor As String = ""

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.Parameters.AddWithValue("@benpart", BenPart)

            cmd.CommandText = "Select top 1 payee_name from POORDLIN_SQL Left Join [APVENFIL_SQL] on POORDLIN_SQL.vend_no = APVENFIL_SQL.vend_no WHERE [item_no] = @benpart and qty_ordered > 0 order by request_dt desc"

            conn.Open()
            Vendor = cmd.ExecuteScalar()
            conn.Close()
            e.Row.Cells(6).Text = Vendor

        End If
    End Sub
End Class
