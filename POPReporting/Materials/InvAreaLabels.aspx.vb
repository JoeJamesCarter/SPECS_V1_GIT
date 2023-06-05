
Partial Class Materials_InvAreaLabels
    Inherits System.Web.UI.Page

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbAreaNo.Focus()
        If Not IsPostBack Then
            ddlPrinters.SelectedIndex = -1
        End If
    End Sub
    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbAreaNo.Text = ""
    End Sub
End Class
