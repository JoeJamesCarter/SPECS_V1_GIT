Imports System.IO
Imports System.Data
Imports System.Data.SqlClient

Partial Class PDI_EditProjectStatus
    Inherits System.Web.UI.Page

    Protected Sub PDI_EditProjectStatus_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim ItemID As String
        Dim ModelYear As String

        ItemID = Request.QueryString("ItemID")
        ModelYear = Request.QueryString("MY")

        lblModelYear.Text = ModelYear
        lblItemID.Text = ItemID

        'populate attachments placeholder

        Dim strFileSize As String = ""
        Dim di As New IO.DirectoryInfo(Server.MapPath("Uploads/" + ModelYear + "-" + ItemID + "/"))
        If di.Exists Then

            Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
            Dim fi As IO.FileInfo
            Dim k As Integer = 0


            For Each fi In aryFi

                strFileSize = (Math.Round(fi.Length / 1024)).ToString()
                'lblUploadResult.Text = fi.Name

                Dim lnk As New HyperLink
                Dim img As New Image
                lnk.ID = "lnk" & k.ToString()
                img.ID = "img" & k.ToString()
                'PlaceHolder1.Controls.Add(GetLiteral("</br/>""))
                'PlaceHolder1.Controls.Add(GetLiteral("<br />"))
                lnk.ID = "lnk" & k.ToString()
                lnk.NavigateUrl = "http:\\specs1\Live\PopReporting\PDI\Uploads\" & ModelYear + "-" + ItemID & "\" & fi.Name
                img.ImageUrl = "http:\\specs1\Live\PopReporting\PDI\Uploads\" & ModelYear + "-" + ItemID & "\" & fi.Name
                img.ToolTip = fi.Name
                lnk.Target = "_blank"
                lnk.Text = fi.Name
                PlaceHolder1.Controls.Add(New LiteralControl("<br />"))
                'PlaceHolder1.Controls.Add(lnk)
                PlaceHolder1.Controls.Add(img)
                k += 1

            Next
        End If

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        conn.ConnectionString = connstr
        Dim cmd As New SqlCommand

        Dim results As SqlDataReader


        cmd.Parameters.AddWithValue("@ModelYear", ModelYear)
        cmd.Parameters.AddWithValue("@ItemID", ItemID)

        cmd.CommandText = "Select Image1URL, Image2URL, Image3URL From ProductDesignIdeas Where ModelYear = @ModelYear and AutoID = @ItemID"
        cmd.Connection = conn
        conn.Open()

        results = cmd.ExecuteReader(CommandBehavior.SingleRow)

        If results.Read() Then

            If (Len(results.Item("Image1URL").ToString) > 0) Then
                Dim Image1URL As String = results.Item("Image1URL")
                Dim img As New Image
                img.ImageUrl = Image1URL
                PlaceHolder1.Controls.Add(img)
            End If

            If (Len(results.Item("Image2URL").ToString) > 0) Then
                Dim Image2URL As String = results.Item("Image2URL")
                Dim img As New Image
                img.ImageUrl = Image2URL
                PlaceHolder1.Controls.Add(img)
            End If

            If (Len(results.Item("Image3URL").ToString) > 0) Then
                Dim Image3URL As String = results.Item("Image3URL")
                Dim img As New Image
                img.ImageUrl = Image3URL
                PlaceHolder1.Controls.Add(img)
            End If

        End If

        conn.Close()

    End Sub

    Protected Sub dvProject_DataBound(sender As Object, e As EventArgs) Handles dvProject.DataBound

        If dvProject.CurrentMode = DetailsViewMode.Edit Then

            Dim tbInitialDescriptionBox As TextBox = CType(dvProject.FindControl("tbInitialDescription"), TextBox)
            tbInitialDescriptionBox.Enabled = True
            Dim tbNarrowedDescriptionBox As TextBox = CType(dvProject.FindControl("tbNarrowedDescription"), TextBox)
            tbNarrowedDescriptionBox.Enabled = True

        End If
    End Sub

    Protected Sub dvProject_ItemUpdating(sender As Object, e As DetailsViewUpdateEventArgs) Handles dvProject.ItemUpdating


        Dim ddlApprovalStatus As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlApprovalStatus"), DropDownList)
        Dim ddlCategory As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlCategories"), DropDownList)

        Dim tbInitialDesc As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbInitialDescription"), TextBox)
        Dim tbNarrowDesc As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbNarrowedDescription"), TextBox)
        Dim ddlStrategicPriority As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlStrategicPriority"), DropDownList)
        Dim ddlSalesPriority As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlSalesPriority"), DropDownList)
        Dim ddlEngActive As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlEngActive"), DropDownList)
        Dim ddlProjectStatus As DropDownList = DirectCast(DirectCast(sender, DetailsView).FindControl("ddlProjectStatus"), DropDownList)

        sdsProjects.UpdateParameters("ApprovalStatus").DefaultValue = ddlApprovalStatus.SelectedValue
        sdsProjects.UpdateParameters("Category").DefaultValue = ddlCategory.SelectedValue
        sdsProjects.UpdateParameters("InitialDescription").DefaultValue = tbInitialDesc.Text
        sdsProjects.UpdateParameters("NarrowedDescription").DefaultValue = tbNarrowDesc.Text
        sdsProjects.UpdateParameters("StrategicPriority").DefaultValue = ddlStrategicPriority.SelectedValue
        sdsProjects.UpdateParameters("SalesPriority").DefaultValue = ddlSalesPriority.SelectedValue
        sdsProjects.UpdateParameters("EngActiveFlag").DefaultValue = ddlEngActive.SelectedValue
        sdsProjects.UpdateParameters("ProjectStatus").DefaultValue = ddlProjectStatus.SelectedValue

    End Sub

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click
        If IsPostBack Then
            Dim ModelYear As String = lblModelYear.Text
            Dim ItemNo As String = lblItemID.Text
            Dim path As String = Server.MapPath("Uploads/" + ModelYear + "-" + ItemNo + "/")
            Dim fileOK As Boolean = False

            If File1.HasFile Then
                Dim fileExtension As String
                fileExtension = System.IO.Path. _
                    GetExtension(File1.FileName).ToLower()
                Dim allowedExtensions As String() = _
                    {".jpg", ".jpeg", ".png", ".gif", ".pdf", ".xls", ".xlsx", ".doc", ".docx"}
                For i As Integer = 0 To allowedExtensions.Length - 1
                    If fileExtension = allowedExtensions(i) Then
                        fileOK = True
                    End If
                Next
                If fileOK Then
                    If (Not System.IO.Directory.Exists(path)) Then
                        System.IO.Directory.CreateDirectory(path)
                    End If
                    Try
                        File1.PostedFile.SaveAs(path & _
                             File1.FileName)
                        lblUploadResult.Text = "File uploaded!"
                    Catch ex As Exception
                        lblUploadResult.Text = "File could not be uploaded."
                    End Try
                Else
                    lblUploadResult.Text = "Cannot accept files of this type. Ask Keri."
                End If
            End If
        End If
    End Sub


End Class
