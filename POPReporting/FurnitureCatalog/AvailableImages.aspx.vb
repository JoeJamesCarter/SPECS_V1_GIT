Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO
Imports MySql.Data.MySqlClient
Partial Class FurnitureCatalog_AvailableImages
    Inherits System.Web.UI.Page

    Public veadaColorChart As New DataTable


    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
    End Sub

    Private Sub FurnitureCatalog_AvailableImages_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim mysqldataadapter1 As New MySqlDataAdapter

        Dim conn1 As New MySqlConnection

        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("VeadaMySQL_ReadOnly").ConnectionString

        conn1.ConnectionString = connstr1

        mysqldataadapter1.SelectCommand = New MySqlCommand("Select * from BennSeriesColorLegend order By Line", conn1)
        mysqldataadapter1.Fill(veadaColorChart)

        conn1.Close()
        conn1.Dispose()

    End Sub

    Protected Sub gvFurnImages_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvFurnImages.RowDataBound
        Try
            Dim img1 As Image = DirectCast(e.Row.FindControl("img1"), Image)
            Dim img2 As Image = DirectCast(e.Row.FindControl("img2"), Image)
            Dim imgBenchFile As String = Trim(e.Row.DataItem("BENCH_IMG"))
            Dim imgReclFile As String = Trim(e.Row.DataItem("RECLINER_IMG"))

            Dim modelyear As String = Trim(e.Row.DataItem("MODEL_YEAR"))


            img1.ImageUrl = "http://specs1/Live/PopReporting/FurnitureImages/" & modelyear & "/" & imgBenchFile 'hard coded full path to see if I can get the image to export
            img2.ImageUrl = "http://specs1/Live/PopReporting/FurnitureImages/" & modelyear & "/" & imgReclFile

            'img1.Height = 314
            'img2.Height = 314

        Catch ex As Exception

        End Try

        'try to set Veada BOM # based on order data
        Try
            Dim seriespart As String = Trim(e.Row.DataItem("SERIES_PART"))
            Dim bvpart As String = Trim(e.Row.DataItem("BASE_VINYL_PART"))
            Dim accentpart As String = Trim(e.Row.DataItem("PRIMARY_ACCENT_PART"))
            Dim modelyear As Int16 = Trim(e.Row.DataItem("MODEL_YEAR"))
            Dim lblVeadaParent As Label = e.Row.Cells(2).FindControl("lblVeadaParentPart")

            Dim dataView1 As DataView = veadaColorChart.DefaultView
            dataView1.RowFilter = "ModelYear = " & "'20" & modelyear & "' AND SeriesPartNumber = '" & seriespart & "' AND BaseVinylPartNumber='" & bvpart & "' AND AccentPartNumber='" & accentpart & "'"

            'MesgBox(dataView3.ToString)

            Dim vLine As String = dataView1(0)(1).ToString
            Dim vColorExt As String = dataView1(0)(5).ToString

            If vLine.Length > 0 And vColorExt.Length > 0 Then
                lblVeadaParent.Text += vLine + vColorExt
            Else
                e.Row.Cells(2).BackColor = Drawing.Color.Red
            End If
        Catch
        End Try
        e.Row.Cells(32).Visible = False ' hide urls
        e.Row.Cells(33).Visible = False ' hide urls
    End Sub

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnExport.Click
        ExportExcel("VeadaImagesAndBOMs", gvFurnImages)
    End Sub

    Public Sub ExportExcel(ByVal filename As String, ByVal gv As GridView)

        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=" & filename & ".xls")
        Response.ContentType = "application/vnd.ms-excel"
        Dim sw As New StringWriter()

        Dim htw As New HtmlTextWriter(sw)

        gv.RenderControl(htw)
        Response.Write(sw.ToString())
        Response.Flush()
        Response.[End]()
    End Sub


End Class
