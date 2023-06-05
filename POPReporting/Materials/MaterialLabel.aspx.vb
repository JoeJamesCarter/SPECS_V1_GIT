
Partial Class Materials_MaterialLabel
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
       
        Dim BenPart As String
        Dim VendPart As String
        Dim Qty As String
        Dim Desc As String

        BenPart = Request.QueryString("ben")
        VendPart = Request.QueryString("vendor")
        Qty = Request.QueryString("qty")
        Desc = Request.QueryString("desc")

        lblItemNo.Text = BenPart
        lblItemDesc2.Text = VendPart
        lblQty.Text = Qty
        lblItemDesc1.Text = Desc


    End Sub

    Protected Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        btnPrint.Visible = False


    End Sub
End Class
