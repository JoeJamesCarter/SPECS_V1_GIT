
Partial Class Warranty_WarrantyWork
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        gvWarrantyWork.Columns(12).Visible = False
        gvWarrantyWork.Columns(10).Visible = False
        gvWarrantyWork.Columns(14).Visible = False
    End Sub

    Protected Sub btnInventory_Click(sender As Object, e As ImageClickEventArgs)
        gvWarrantyWork.Columns(12).Visible = True
    End Sub

    Protected Sub btnInspected_Click(sender As Object, e As ImageClickEventArgs)
        gvWarrantyWork.Columns(10).Visible = True
    End Sub

    
    Protected Sub btnEval_Click(sender As Object, e As ImageClickEventArgs)
        gvWarrantyWork.Columns(14).Visible = True
    End Sub

    Protected Sub btnWorkComplete_Click(sender As Object, e As ImageClickEventArgs)

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvWarrantyWork.DataBind()
    End Sub
End Class
