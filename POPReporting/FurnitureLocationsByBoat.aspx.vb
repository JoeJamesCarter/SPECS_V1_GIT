Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class FurnitureLocationsByBoat
    Inherits System.Web.UI.Page


    Protected Sub gvBoats_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBoats.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsRacks"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try
        End If

    End Sub
End Class
