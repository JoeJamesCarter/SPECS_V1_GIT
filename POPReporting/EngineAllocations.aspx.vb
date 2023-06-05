
Partial Class EngineAllocations
    Inherits System.Web.UI.Page

    Protected Sub dlSouthWip_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles dlSouthWip.ItemDataBound, dlRailsSouth.ItemDataBound, dlDecks.ItemDataBound

        If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then
            Dim s As SqlDataSource = CType(e.Item.FindControl("sdsMacola"), SqlDataSource)

            Dim so As String = DataBinder.Eval(e.Item.DataItem, "SONo")

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.

                s.SelectParameters(0).DefaultValue = so
            Catch

            End Try

            If e.Item.DataItem("BuildLoc") = "S" Then
                e.Item.BackColor = Drawing.Color.LightGray
            End If
        End If


    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        dlSouthWip.DataBind()
        dlRailsSouth.DataBind()
        dlDecks.DataBind()

    End Sub
End Class
