Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO
Partial Class FurnitureCatalog_CatalogMaint
    Inherits System.Web.UI.Page

    Private Sub FurnitureCatalog_CatalogMaint_Load(sender As Object, e As EventArgs) Handles Me.Load

    End Sub

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub ddlPatterns_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim ddlPatterns As DropDownList = DirectCast(sender.FindControl("ddlPatterns"), DropDownList)
        Dim tbFurniturePart As TextBox = DirectCast(sender.FindControl("tbFurniturePart"), TextBox)

        Try
            tbFurniturePart.Text = ddlPatterns.SelectedValue
        Catch
        End Try

    End Sub
    Protected Sub ddlBaseVinyl_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim ddlBaseVinyl As DropDownList = DirectCast(sender.FindControl("ddlBaseVinyl"), DropDownList)
        Dim tbBVPart As TextBox = DirectCast(sender.FindControl("tbBVPart"), TextBox)

        Try
            tbBVPart.Text = ddlBaseVinyl.SelectedValue
        Catch
        End Try

    End Sub
    Protected Sub ddlIntAccents_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim ddlIntAccents As DropDownList = DirectCast(sender.FindControl("ddlIntAccents"), DropDownList)
        Dim tbAccentPart As TextBox = DirectCast(sender.FindControl("tbAccentPart"), TextBox)

        Try
            tbAccentPart.Text = ddlIntAccents.SelectedValue
        Catch
        End Try

    End Sub

    Protected Sub gvFurnCatalog2_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvFurnCatalog2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Cells(4).BackColor = Drawing.Color.LightYellow
            e.Row.Cells(5).BackColor = Drawing.Color.LightYellow

            e.Row.Cells(6).BackColor = Drawing.Color.LightBlue
            e.Row.Cells(7).BackColor = Drawing.Color.LightBlue

            e.Row.Cells(8).BackColor = Drawing.Color.LightCyan
            e.Row.Cells(9).BackColor = Drawing.Color.LightCyan

        End If
    End Sub
    Protected Sub ddlSeries_SelectedIndexChanged(sender As Object, e As EventArgs)
        'If series changes, rebind the style choices and the part # for the one that is selected.

        Dim ddlPatterns As DropDownList = DirectCast(sender.FindControl("ddlPatterns"), DropDownList)
        Dim tbFurniturePart As TextBox = DirectCast(sender.FindControl("tbFurniturePart"), TextBox)


        tbFurniturePart.Text = ""

        ddlPatterns.DataBind()
        tbFurniturePart.Text = ddlPatterns.SelectedValue

    End Sub

    Protected Sub gvFurnCatalog2_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvFurnCatalog2.RowUpdating
        Dim ddlModelYear As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlModelYear")

        'Dim ddlModelYear As DropDownList = DirectCast(DirectCast(sender, GridView).FindControl("ddlModelYear"), DropDownList)
        Dim tbCatalogPg As TextBox = gvFurnCatalog2.Rows(e.RowIndex).FindControl("tbCatalogPg")

        Dim tbPatternPart As TextBox = gvFurnCatalog2.Rows(e.RowIndex).FindControl("tbFurniturePart")
        Dim tbBVPart As TextBox = gvFurnCatalog2.Rows(e.RowIndex).FindControl("tbBVPart")
        Dim tbAccentPart As TextBox = gvFurnCatalog2.Rows(e.RowIndex).FindControl("tbAccentPart")


        Dim ddlSeries As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlSeries")
        Dim ddlBV As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlBaseVinyl")
        Dim ddlACC As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlIntAccents")
        Dim ddlPattern As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlPatterns")
        Dim ddlACC2 As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlAcc2")
        Dim ddlACC3 As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlAcc3")
        Dim ddlLumbar As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlLumbar")
        Dim ddlLumbar2 As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlLumbar2")

        Dim ddlTopStitch As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlTopStitch")
        Dim ddlSeatPanOverlay As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlSeatPanOverlay")
        Dim ddlMonogram As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlMonogram")
        Dim ddlMonogram2 As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlMonogram2")
        Dim ddlMonogramWing As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlMonogramWing")

        Dim ddlRecliner_Monogram As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlRecliner_Monogram")
        Dim ddlRecliner_Monogram2 As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlRecliner_Monogram2")
        Dim ddlWelt_Color As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlWelt_Color")
        Dim ddlWelt_Color2 As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlWelt_Color2")
        Dim ddlBenchMonoPanel As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlBenchMonoPanel")

        Dim ddlReclinerAccent As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlReclinerAccent")
        Dim ddlReclinerTopStitch As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlReclinerTopStitch")
        Dim ddlDiamondAccent As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlDiamondAccent")
        Dim ddlDiamondThread As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlDiamondThread")

        Dim ddlXStitch As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlXStitch")
        Dim tbBenchURL As TextBox = gvFurnCatalog2.Rows(e.RowIndex).FindControl("tbBenchURL")
        Dim tbReclinerURL As TextBox = gvFurnCatalog2.Rows(e.RowIndex).FindControl("tbReclinerURL")
        Dim tbNotes As TextBox = gvFurnCatalog2.Rows(e.RowIndex).FindControl("tbNotes")
        Dim ddlCatGroups As DropDownList = gvFurnCatalog2.Rows(e.RowIndex).FindControl("ddlGroups")

        sdsFurnCatalog.UpdateParameters("MODEL_YEAR").DefaultValue = ddlModelYear.SelectedValue
        sdsFurnCatalog.UpdateParameters("CATALOG_PAGE").DefaultValue = tbCatalogPg.Text
        sdsFurnCatalog.UpdateParameters("SERIES").DefaultValue = ddlSeries.SelectedValue
        sdsFurnCatalog.UpdateParameters("PRIMARY_BASE_VINYL").DefaultValue = ddlBV.SelectedItem.Text
        sdsFurnCatalog.UpdateParameters("ACCENT").DefaultValue = ddlACC.SelectedItem.Text
        sdsFurnCatalog.UpdateParameters("PATTERN").DefaultValue = ddlPattern.SelectedItem.Text
        sdsFurnCatalog.UpdateParameters("ACCENT_2").DefaultValue = ddlACC2.SelectedValue
        sdsFurnCatalog.UpdateParameters("ACCENT_3").DefaultValue = ddlACC3.SelectedValue
        sdsFurnCatalog.UpdateParameters("LUMBAR").DefaultValue = ddlLumbar.SelectedValue
        sdsFurnCatalog.UpdateParameters("LUMBAR_2").DefaultValue = ddlLumbar2.SelectedValue
        sdsFurnCatalog.UpdateParameters("TOP_STITCH").DefaultValue = ddlTopStitch.SelectedValue
        sdsFurnCatalog.UpdateParameters("SEAT_PAN_OVERLAY").DefaultValue = ddlSeatPanOverlay.SelectedValue
        sdsFurnCatalog.UpdateParameters("MONOGRAM").DefaultValue = ddlMonogram.SelectedValue
        sdsFurnCatalog.UpdateParameters("MONOGRAM_2").DefaultValue = ddlMonogram.SelectedValue
        sdsFurnCatalog.UpdateParameters("MONOGRAM_WING").DefaultValue = ddlMonogramWing.SelectedValue
        sdsFurnCatalog.UpdateParameters("RECLINER_MONOGRAM").DefaultValue = ddlRecliner_Monogram.SelectedValue
        sdsFurnCatalog.UpdateParameters("RECLINER_MONOGRAM_2").DefaultValue = ddlRecliner_Monogram2.SelectedValue
        sdsFurnCatalog.UpdateParameters("WELT_COLOR").DefaultValue = ddlWelt_Color.SelectedValue
        sdsFurnCatalog.UpdateParameters("WELT_COLOR_2").DefaultValue = ddlWelt_Color2.SelectedValue
        sdsFurnCatalog.UpdateParameters("BENCH_MONO_PANEL").DefaultValue = ddlBenchMonoPanel.SelectedValue
        sdsFurnCatalog.UpdateParameters("RECLINER_ACCENT").DefaultValue = ddlReclinerAccent.SelectedValue
        sdsFurnCatalog.UpdateParameters("RECLINER_TOP_STITCH").DefaultValue = ddlReclinerTopStitch.SelectedValue
        sdsFurnCatalog.UpdateParameters("DIAMOND_ACCENT").DefaultValue = ddlDiamondAccent.SelectedValue
        sdsFurnCatalog.UpdateParameters("DIAMOND_THREAD").DefaultValue = ddlDiamondThread.SelectedValue
        sdsFurnCatalog.UpdateParameters("X_STITCH").DefaultValue = ddlXStitch.SelectedValue
        sdsFurnCatalog.UpdateParameters("BENCH_IMG_URL").DefaultValue = tbBenchURL.Text
        sdsFurnCatalog.UpdateParameters("RECLINER_IMG_URL").DefaultValue = tbReclinerURL.Text

        sdsFurnCatalog.UpdateParameters("SERIES_PART").DefaultValue = tbPatternPart.Text
        sdsFurnCatalog.UpdateParameters("BASE_VINYL_PART").DefaultValue = tbBVPart.Text
        sdsFurnCatalog.UpdateParameters("PRIMARY_ACCENT_PART").DefaultValue = tbAccentPart.Text
        sdsFurnCatalog.UpdateParameters("NOTES").DefaultValue = tbNotes.Text
        sdsFurnCatalog.UpdateParameters("CATALOG_GROUP").DefaultValue = ddlCatGroups.SelectedValue
    End Sub
    Protected Sub btnAddNew_Click(sender As Object, e As EventArgs) Handles btnAddNew.Click
        Dim url As String = "AddFurnCombos.aspx"
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=1,resizable=1,toolbars=1,width=900,height=1050');popUpObj.focus()}</script>")
    End Sub
    Protected Sub btnModDropDowns_Click(sender As Object, e As EventArgs) Handles btnModDropDowns.Click
        Dim url As String = "http://specs1/Live/PopReporting/FurnitureCatalog/FurnitureSelectionsMaint.aspx"
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=1,resizable=1,toolbars=1,width=900,height=1050');popUpObj.focus()}</script>")

    End Sub
End Class
