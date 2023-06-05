Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO
Imports MySql.Data.MySqlClient

Partial Class FurnitureOrdering_FurnitureOpenOrders
    Inherits System.Web.UI.Page

    Public furnImages As New DataTable
    Public veadaColorChart As New DataTable
    Public customParts As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvOpenOrders_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOpenOrders.RowDataBound

        Dim img1 As Image = DirectCast(e.Row.FindControl("img1"), Image)
        Dim img2 As Image = DirectCast(e.Row.FindControl("img2"), Image)

        'Get Furn Images
        Try
            Dim imgseriespart As String = Trim(e.Row.DataItem("pillowtop_item"))
            Dim imgbvpart As String = Trim(e.Row.DataItem("base_vinyl_item"))
            Dim imgaccentpart As String = Trim(e.Row.DataItem("vinyl_accent_item"))
            Dim modelyear As Int16 = Left(e.Row.DataItem("production_no"), 2)

            'Dim phBench As PlaceHolder = DirectCast(e.Row.FindControl("phBench"), PlaceHolder)
            ' Dim phRecliner As PlaceHolder = DirectCast(e.Row.FindControl("phRecliner"), PlaceHolder)

            Dim dataView4 As DataView = furnImages.DefaultView
            dataView4.RowFilter = "Model_Year = '" & modelyear & "' AND SERIES_PART = '" & imgseriespart & "' AND BASE_VINYl_PART='" & imgbvpart & "' AND PRIMARY_ACCENT_PART='" & imgaccentpart & "'"

            Dim benchurl As String = dataView4(0)(4).ToString
            Dim reclinerurl As String = dataView4(0)(5).ToString

            'get only the file name
            Dim pos = benchurl.LastIndexOf("\") + 1
            benchurl = benchurl.Substring(pos, benchurl.Length - pos)

            Dim pos1 = reclinerurl.LastIndexOf("\") + 1
            reclinerurl = reclinerurl.Substring(pos1, reclinerurl.Length - pos1)


            img1.ImageUrl = "http://specs1/Live/PopReporting/FurnitureImages/" & modelyear & "/" & reclinerurl 'hard coded full path to see if I can get the image to export
            img2.ImageUrl = "http://specs1/Live/PopReporting/FurnitureImages/" & modelyear & "/" & benchurl

            img1.Width = 500
            img2.Width = 500

        Catch ex As Exception

        End Try
        'Populate Veada BOM
        Try
            Dim lblVeadaParent As Label = e.Row.Cells(3).FindControl("lblVeadaParent")

            Dim imgseriespart2 As String = Trim(e.Row.DataItem("pillowtop_item"))
            Dim imgbvpart2 As String = Trim(e.Row.DataItem("base_vinyl_item"))
            Dim imgaccentpart2 As String = Trim(e.Row.DataItem("vinyl_accent_item"))
            Dim modelyear2 As Int16 = Left(e.Row.DataItem("production_no"), 2)

            'MesgBox(imgseriespart2)
            'MesgBox(imgbvpart2)
            'MesgBox(imgaccentpart2)
            'MesgBox(modelyear2)


            Dim dataView1 As DataView = veadaColorChart.DefaultView
            dataView1.RowFilter = "ModelYear = " & "'20" & modelyear2 & "' AND SeriesPartNumber = '" & imgseriespart2 & "' AND BaseVinylPartNumber='" & imgbvpart2 & "' AND AccentPartNumber='" & imgaccentpart2 & "'"

            'MesgBox(dataView1(0)(1).ToString)

            Dim vLine As String = dataView1(0)(1).ToString
            Dim vColorExt As String = dataView1(0)(5).ToString

            If vLine.Length > 0 And vColorExt.Length > 0 Then
                lblVeadaParent.Text += vLine + vColorExt
            Else
                e.Row.Cells(2).BackColor = Drawing.Color.Red
            End If
        Catch ex As Exception

        End Try

        'Show if Custom boat (905101) or Custom Vinyl (902895)
        Try
            Dim prodno As String = e.Row.Cells(4).Text
            Dim dataView2 As DataView = customParts.DefaultView
            dataView2.RowFilter = "production_no = '" & prodno & "'"

            Dim lblCustom As Label = e.Row.Cells(2).FindControl("lblCustom")
            lblCustom.Text = dataView2(0)(1)
            e.Row.Cells(2).BackColor = Drawing.Color.Red
            e.Row.Cells(2).ForeColor = Drawing.Color.White

        Catch

        End Try



    End Sub

    Private Sub FurnitureOrdering_FurnitureOpenOrders_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim sqldataadapter1 As New SqlDataAdapter
        Dim mysqldataadapter1 As New MySqlDataAdapter
        Dim sqldataadapter2 As New SqlDataAdapter

        Dim conn1 As New SqlConnection
        Dim conn2 As New MySqlConnection
        Dim conn3 As New SqlConnection

        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim connstr2 As String = ConfigurationManager.ConnectionStrings("VeadaMySQL_ReadOnly").ConnectionString
        Dim connstr3 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString

        conn1.ConnectionString = connstr1
        conn2.ConnectionString = connstr2
        conn3.ConnectionString = connstr3

        conn1.Open()
        sqldataadapter1.SelectCommand = New SqlCommand("Select MODEL_YEAR, SERIES_PART, BASE_VINYL_PART, PRIMARY_ACCENT_PART, BENCH_IMG_URL, RECLINER_IMG_URL FROM Furniture_Combinations", conn1)
        sqldataadapter1.Fill(furnImages)

        conn1.Close()
        conn1.Dispose()

        conn2.Open()
        mysqldataadapter1.SelectCommand = New MySqlCommand("Select * from BennSeriesColorLegend order By Line", conn2)
        mysqldataadapter1.Fill(veadaColorChart)

        conn2.Close()
        conn2.Dispose()

        conn3.Open()

        sqldataadapter2.SelectCommand = New SqlCommand("Select production_no, parent_desc FROM BML_PURPRDBOM Where parent_item ='905101' or parent_item = '902895'", conn3)
        sqldataadapter2.Fill(customParts)

        conn3.Close()
        conn3.Dispose()
    End Sub
End Class
