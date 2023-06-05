
Partial Class MaintainHotList
    Inherits System.Web.UI.Page




    Protected Sub gvHotList_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvHotList.RowDataBound
        Dim u As SqlDataSource = CType(e.Row.FindControl("sdsBoatNotes"), SqlDataSource)


        Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
            '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            u.SelectParameters(0).DefaultValue = e.Row.Cells(1).Text
        Catch

        End Try
    End Sub
End Class
