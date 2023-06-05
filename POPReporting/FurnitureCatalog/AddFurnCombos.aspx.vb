
Partial Class FurnitureOrdering_AddFurnCombs
    Inherits System.Web.UI.Page

    Protected Sub ddlSeries_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim ddlPatterns As DropDownList = DirectCast(sender.FindControl("ddlPatterns"), DropDownList)
        Dim tbFurniturePart As TextBox = DirectCast(sender.FindControl("tbFurniturePart"), TextBox)


        tbFurniturePart.Text = ""

        ddlPatterns.DataBind()
        tbFurniturePart.Text = ddlPatterns.SelectedValue
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
    Protected Sub dvAddFurnCombox_ItemInserting(sender As Object, e As DetailsViewInsertEventArgs) Handles dvAddFurnCombox.ItemInserting

        Dim TodaysDate As Date = Date.Now
        Dim tbCatalogPg As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbCatalogPg"), TextBox)

        Dim tbPatternPart As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbFurniturePart"), TextBox)
        Dim tbBVPart As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbBVPart"), TextBox)
        Dim tbAccentPart As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbAccentPart"), TextBox)


        Dim ddlSeries As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlSeries"), DropDownList)
        Dim ddlBV As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlBaseVinyl"), DropDownList)
        Dim ddlACC As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlIntAccents"), DropDownList)
        Dim ddlPattern As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlPatterns"), DropDownList)
        Dim ddlACC2 As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlAcc2"), DropDownList)
        Dim ddlACC3 As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlAcc3"), DropDownList)
        Dim ddlLumbar As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlLumbar"), DropDownList)
        Dim ddlLumbar2 As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlLumbar2"), DropDownList)

        Dim ddlTopStitch As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlTopStitch"), DropDownList)
        Dim ddlSeatPanOverlay As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlSeatPanOverlay"), DropDownList)
        Dim ddlMonogram As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlMonogram"), DropDownList)
        Dim ddlMonogram2 As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlMonogram2"), DropDownList)
        Dim ddlMonogramWing As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlMonogramWing"), DropDownList)

        Dim ddlRecliner_Monogram As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlRecliner_Monogram"), DropDownList)
        Dim ddlRecliner_Monogram2 As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlRecliner_Monogram2"), DropDownList)
        Dim ddlWelt_Color As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlWelt_Color"), DropDownList)
        Dim ddlWelt_Color2 As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlWelt_Color2"), DropDownList)
        Dim ddlBenchMonoPanel As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlBenchMonoPanel"), DropDownList)

        Dim ddlReclinerAccent As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlReclinerAccent"), DropDownList)
        Dim ddlReclinerTopStitch As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlReclinerTopStitch"), DropDownList)
        Dim ddlDiamondAccent As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlDiamondAccent"), DropDownList)
        Dim ddlDiamondThread As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlDiamondThread"), DropDownList)

        Dim ddlXStitch As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlXStitch"), DropDownList)
        Dim tbBenchURL As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbBenchURL"), TextBox)
        Dim tbReclinerURL As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbReclinerURL"), TextBox)
        Dim ddlCatGroup As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlGroups"), DropDownList)
        Dim tbNotes As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbNotes"), TextBox)

        sdsFurnCombos.InsertParameters("MODEL_YEAR").DefaultValue = ddlModelYear.SelectedValue
        sdsFurnCombos.InsertParameters("CATALOG_PAGE").DefaultValue = tbCatalogPg.Text
        sdsFurnCombos.InsertParameters("SERIES").DefaultValue = ddlSeries.SelectedValue
        sdsFurnCombos.InsertParameters("PRIMARY_BASE_VINYL").DefaultValue = ddlBV.SelectedItem.Text
        sdsFurnCombos.InsertParameters("ACCENT").DefaultValue = ddlACC.SelectedItem.Text
        sdsFurnCombos.InsertParameters("PATTERN").DefaultValue = ddlPattern.SelectedItem.Text
        sdsFurnCombos.InsertParameters("ACCENT_2").DefaultValue = ddlACC2.SelectedValue
        sdsFurnCombos.InsertParameters("ACCENT_3").DefaultValue = ddlACC3.SelectedValue
        sdsFurnCombos.InsertParameters("LUMBAR").DefaultValue = ddlLumbar.SelectedValue
        sdsFurnCombos.InsertParameters("LUMBAR_2").DefaultValue = ddlLumbar2.SelectedValue
        sdsFurnCombos.InsertParameters("TOP_STITCH").DefaultValue = ddlTopStitch.SelectedValue
        sdsFurnCombos.InsertParameters("SEAT_PAN_OVERLAY").DefaultValue = ddlSeatPanOverlay.SelectedValue
        sdsFurnCombos.InsertParameters("MONOGRAM").DefaultValue = ddlMonogram.SelectedValue
        sdsFurnCombos.InsertParameters("MONOGRAM_2").DefaultValue = ddlMonogram.SelectedValue
        sdsFurnCombos.InsertParameters("MONOGRAM_WING").DefaultValue = ddlMonogramWing.SelectedValue
        sdsFurnCombos.InsertParameters("RECLINER_MONOGRAM").DefaultValue = ddlRecliner_Monogram.SelectedValue
        sdsFurnCombos.InsertParameters("RECLINER_MONOGRAM_2").DefaultValue = ddlRecliner_Monogram2.SelectedValue
        sdsFurnCombos.InsertParameters("WELT_COLOR").DefaultValue = ddlWelt_Color.SelectedValue
        sdsFurnCombos.InsertParameters("WELT_COLOR_2").DefaultValue = ddlWelt_Color2.SelectedValue
        sdsFurnCombos.InsertParameters("BENCH_MONO_PANEL").DefaultValue = ddlBenchMonoPanel.SelectedValue
        sdsFurnCombos.InsertParameters("RECLINER_ACCENT").DefaultValue = ddlReclinerAccent.SelectedValue
        sdsFurnCombos.InsertParameters("RECLINER_TOP_STITCH").DefaultValue = ddlReclinerTopStitch.SelectedValue
        sdsFurnCombos.InsertParameters("DIAMOND_ACCENT").DefaultValue = ddlDiamondAccent.SelectedValue
        sdsFurnCombos.InsertParameters("DIAMOND_THREAD").DefaultValue = ddlDiamondThread.SelectedValue
        sdsFurnCombos.InsertParameters("X_STITCH").DefaultValue = ddlXStitch.SelectedValue
        sdsFurnCombos.InsertParameters("BENCH_IMG_URL").DefaultValue = tbBenchURL.Text
        sdsFurnCombos.InsertParameters("RECLINER_IMG_URL").DefaultValue = tbReclinerURL.Text

        sdsFurnCombos.InsertParameters("SERIES_PART").DefaultValue = tbPatternPart.Text
        sdsFurnCombos.InsertParameters("BASE_VINYL_PART").DefaultValue = tbBVPart.Text
        sdsFurnCombos.InsertParameters("PRIMARY_ACCENT_PART").DefaultValue = tbAccentPart.Text
        sdsFurnCombos.InsertParameters("CATALOG_GROUP").DefaultValue = ddlCatGroup.SelectedValue
        sdsFurnCombos.InsertParameters("NOTES").DefaultValue = tbNotes.Text
        sdsFurnCombos.InsertParameters("ADDED").DefaultValue = TodaysDate

    End Sub
End Class
