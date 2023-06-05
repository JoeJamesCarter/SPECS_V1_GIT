Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Tubes_CSTubesRO
    Inherits System.Web.UI.Page

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbSearch.Text = ""
    End Sub
End Class
