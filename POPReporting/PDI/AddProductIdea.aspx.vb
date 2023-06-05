﻿
Partial Class PDI_AddProductIdea
    Inherits System.Web.UI.Page

    Protected Sub dvProject_ItemInserting(sender As Object, e As DetailsViewInsertEventArgs) Handles dvProject.ItemInserting
        Dim ddlApprovalStatus As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlApprovalStatus"), DropDownList)
        Dim ddlCategory As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlCategories"), DropDownList)

        Dim tbInitialDesc As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbInitialDescription"), TextBox)
        Dim tbNarrowDesc As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbNarrowedDescription"), TextBox)
        Dim ddlStrategicPriority As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlStrategicPriority"), DropDownList)
        Dim ddlSalesPriority As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlSalesPriority"), DropDownList)
        Dim ddlEngActive As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlEngActive"), DropDownList)
        Dim ddlProjectStatus As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlProjectStatus"), DropDownList)


        sdsProjects.InsertParameters("ApprovalStatus").DefaultValue = ddlApprovalStatus.SelectedValue
        sdsProjects.InsertParameters("InitialDescription").DefaultValue = tbInitialDesc.Text
        sdsProjects.InsertParameters("NarrowedDescription").DefaultValue = tbNarrowDesc.Text
        sdsProjects.InsertParameters("StrategicPriority").DefaultValue = ddlStrategicPriority.SelectedValue
        sdsProjects.InsertParameters("SalesPriority").DefaultValue = ddlSalesPriority.SelectedValue
        sdsProjects.InsertParameters("EngActiveFlag").DefaultValue = ddlEngActive.SelectedValue
        sdsProjects.InsertParameters("ProjectStatus").DefaultValue = ddlProjectStatus.SelectedValue
    End Sub

  
End Class

