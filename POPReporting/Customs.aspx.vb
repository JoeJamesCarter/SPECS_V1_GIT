
Partial Class Customs
    Inherits System.Web.UI.Page

    Protected Sub gvOpenOrders_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOpenOrders.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsMacola"), SqlDataSource)
            Dim so As String = DataBinder.Eval(e.Row.DataItem, "src_ord_no")
            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = so

            Catch

            End Try

            Dim cbArch As CheckBox = DirectCast(e.Row.FindControl("cbArch"), CheckBox)

        End If
    End Sub
End Class
