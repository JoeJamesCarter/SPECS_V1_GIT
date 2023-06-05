Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports MySql.Data.MySqlClient

Partial Class SouthMap
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        'PopulateDataTables()
        'dlFrames.DataBind()
        'dlFloors.DataBind()
        dlRails.DataBind()
        dlFurniture.DataBind()
        dlHelms.DataBind()
        dlInspection.DataBind()
        dlFinal.DataBind()
        dlShrink.DataBind()
        'dlRigging.DataBind()
        'dlWavetamer.DataBind()
        'dlSharkhide.DataBind()
    End Sub

    Protected Sub dlInspection_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles dlRails.ItemDataBound, dlFurniture.ItemDataBound, dlHelms.ItemDataBound, dlInspection.ItemDataBound, dlFinal.ItemDataBound, dlShrink.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then

            Dim prod As String = e.Item.DataItem("ProdNo")
            Dim a As SqlDataSource = CType(e.Item.FindControl("sdsOfflineReasons"), SqlDataSource)

            Try
                a.SelectParameters(0).DefaultValue = prod

            Catch ex As Exception

            End Try
        End If

    End Sub
End Class
