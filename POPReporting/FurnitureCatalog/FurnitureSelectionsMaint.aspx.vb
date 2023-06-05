Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class FurnitureCatalog_FurnitureSelectionsMaint
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub ddlTypes_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlTypes As DropDownList = DirectCast(sender.FindControl("ddlTypes"), DropDownList)
        Dim selectionType As String = ddlTypes.SelectedValue
        Dim tbMacolaPart As TextBox = DirectCast(sender.FindControl("tbMacolaPartInsert"), TextBox)
        Dim tbMacolaPart2 As TextBox = DirectCast(sender.FindControl("tbMacolaPart2Insert"), TextBox)
        Dim ddlSeries As DropDownList = DirectCast(sender.FindControl("ddlSeries0"), DropDownList)

        If selectionType <> "BV" And selectionType <> "ACC" And selectionType <> "FUR" Then

            'get the next highest auto number for the part field

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Select Max(MACOLA_PART) from Furniture_Catalog_Descs Where PART_TYPE != 'BV' and PART_TYPE != 'ACC' and PART_TYPE != 'FUR'"

            conn.Open()

            Dim maxNo As Int16 = cmd.ExecuteScalar
            conn.Close()
            tbMacolaPart.Text = maxNo + 1
        Else
            tbMacolaPart.Text = ""
        End If

        If selectionType = "FUR" Then
            tbMacolaPart2.Enabled = True
            ddlSeries.Enabled = True
        Else
            tbMacolaPart2.Enabled = False
            ddlSeries.Enabled = False
        End If

    End Sub
    Protected Sub dvInsertSelection_ItemInserting(sender As Object, e As DetailsViewInsertEventArgs) Handles dvInsertSelection.ItemInserting

        Dim ddlModelYearInsert As DropDownList = dvInsertSelection.FindControl("ddlModelYearInsert")
        Dim ddlTypes As DropDownList = dvInsertSelection.FindControl("ddlTypes")
        Dim ddlSeries As DropDownList = dvInsertSelection.FindControl("ddlSeries0")
        Dim tbMacolaPart As TextBox = dvInsertSelection.FindControl("tbMacolaPartInsert")
        Dim tbMacolaPart2 As TextBox = dvInsertSelection.FindControl("tbMacolaPart2Insert")
        Dim tbDesc As TextBox = dvInsertSelection.FindControl("tbCatalogDesc")

        sdsAddSelection.InsertParameters("MODEL_YEAR").DefaultValue = ddlModelYearInsert.SelectedValue
        sdsAddSelection.InsertParameters("PART_TYPE").DefaultValue = ddlTypes.SelectedValue
        sdsAddSelection.InsertParameters("SERIES").DefaultValue = ddlSeries.SelectedValue
        sdsAddSelection.InsertParameters("MACOLA_PART").DefaultValue = tbMacolaPart.Text
        sdsAddSelection.InsertParameters("MACOLA_PART_2").DefaultValue = tbMacolaPart2.Text
        sdsAddSelection.InsertParameters("CATALOG_DESC").DefaultValue = tbDesc.Text


    End Sub
End Class
