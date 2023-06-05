
Partial Class ReworkKeying
    Inherits System.Web.UI.Page

    Public workstation As String
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub
    Protected Sub dvAddDefect_ItemInserting(sender As Object, e As DetailsViewInsertEventArgs) Handles dvAddDefect.ItemInserting

        Dim tbProdNo As TextBox = FindControl("tbProdNo")

        Dim tbWorkstation As TextBox = FindControl("tbWorkstation")

        'Dim tbWorkstation As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbWorkstation"), TextBox)
        Dim ddlArea As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlArea"), DropDownList)
        Dim ddlCategory As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlCategories"), DropDownList)
        Dim tbItem As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbItem"), TextBox)
        Dim rbLocation As RadioButtonList = DirectCast(DirectCast(sender, DetailsView).FindControl("rbLocation"), RadioButtonList)
        Dim rbDiscrepancy As RadioButtonList = DirectCast(DirectCast(sender, DetailsView).FindControl("rbDiscrepancy"), RadioButtonList)
        Dim rbSource As RadioButtonList = DirectCast(DirectCast(sender, DetailsView).FindControl("rbSource"), RadioButtonList)
        Dim tbDetail As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbDetail"), TextBox)
        Dim TodaysDate As Date = Date.Now

        If ddlCategory.SelectedIndex = -1 Or tbItem.Text.Length = 0 Or rbDiscrepancy.SelectedIndex = -1 Or rbSource.SelectedIndex = -1 Or tbDetail.Text.Length = 0 Then
            MesgBox("Please Fill out all of the required fields (*)")
            e.Cancel = True
        Else

            sdsRework.InsertParameters("ProdNo").DefaultValue = tbProdNo.Text
            sdsRework.InsertParameters("DateOfDefect").DefaultValue = TodaysDate
            sdsRework.InsertParameters("Workstation").DefaultValue = tbWorkstation.Text
            sdsRework.InsertParameters("Area").DefaultValue = ddlArea.SelectedValue
            sdsRework.InsertParameters("Category").DefaultValue = ddlCategory.SelectedValue
            sdsRework.InsertParameters("Item").DefaultValue = tbItem.Text
            sdsRework.InsertParameters("Location").DefaultValue = rbLocation.SelectedValue
            sdsRework.InsertParameters("Discrepancy").DefaultValue = rbDiscrepancy.SelectedValue
            sdsRework.InsertParameters("Source").DefaultValue = rbSource.SelectedValue
            sdsRework.InsertParameters("Detail").DefaultValue = tbDetail.Text
        End If

    End Sub
    Protected Sub dvAddDefect_ItemUpdated(sender As Object, e As DetailsViewUpdatedEventArgs) Handles dvAddDefect.ItemUpdated
        gvReworkHistory.DataBind()
    End Sub

    Private Sub ReworkKeying_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim TodaysDate As Date = Date.Now

        workstation = Request.QueryString("ws")

        Dim tbWorkstation As TextBox = DirectCast(FindControl("tbWorkstation"), TextBox)
        tbWorkstation.Text = workstation

        Dim prod As String = Request.QueryString("prod")
        Dim tbProd As TextBox = DirectCast(FindControl("tbProdNo"), TextBox)
        tbProd.Text = prod


    End Sub


End Class
