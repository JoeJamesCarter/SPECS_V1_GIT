Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class OpenOrders
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim BenPart As String
        BenPart = Request.QueryString("BenPart")
        Label1.Text = BenPart
    End Sub

    Protected Sub gvPartsOrders_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvPartsOrders.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then


            'Dim requested As String = e.Row.Cells(5).Text
            'Dim received As String = e.Row.Cells(6).Text

            'Dim requestedY As String = Mid(requested, 3, 2)
            'Dim requestedD As String = Right(requested, 2)
            'Dim requestedM As String = Mid(requested, 5, 2)
            'Dim requestedFullDate As String = requestedM & "/" & requestedD & "/" & requestedY

            'e.Row.Cells(5).Text = requestedFullDate

            'If received <> "0" Then

            'Dim receivedY As String = Mid(requested, 3, 2)
            'Dim receivedD As String = Right(requested, 2)
            'Dim receivedM As String = Mid(requested, 5, 2)
            'Dim receivedFullDate As String = receivedM & "/" & receivedD & "/" & receivedY
            'e.Row.Cells(7).Text = receivedFullDate
            'End If


        End If


    End Sub
End Class
