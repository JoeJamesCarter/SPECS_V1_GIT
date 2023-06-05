Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO
Imports MySql.Data.MySqlClient

Partial Class FurnitureOrdering_POGeneration
    Inherits System.Web.UI.Page

    Public furnLines As New DataTable
    Public bldgData As New DataTable
    Public savedPOData As New DataTable
    Public veadaColorChart As New DataTable
    Public furnImages As New DataTable
    Public canvasParts As New DataTable

    Public minProd As String
    Public maxProd As String

    Public starterRow As Integer = 3
    Public lastRow As Integer
    Public nextRow As Integer


    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
    End Sub

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class

    Protected Sub FurnitureOrdering_POGeneration_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)

        Dim selectedDate As Date = calDueDate.SelectedDate

        'Hide all PO Export Fields
        'gvFurnOrders.Columns(0).Visible = True 'Prod #
        'gvFurnOrders.Columns(1).Visible = True 'Due Date
        'gvFurnOrders.Columns(2).Visible = True 'Base Series
        'gvFurnOrders.Columns(3).Visible = True 'Model

        'gvFurnOrders.Columns(4).Visible = True 'bv
        'gvFurnOrders.Columns(5).Visible = True 'acc
        'gvFurnOrders.Columns(6).Visible = True 'stitch
        'gvFurnOrders.Columns(7).Visible = True 'desc
        'gvFurnOrders.Columns(8).Visible = True 'trim
        'gvFurnOrders.Columns(9).Visible = True 'flooring
        'gvFurnOrders.Columns(10).Visible = True  'canvas
        'gvFurnOrders.Columns(11).Visible = True  'buildloc
        'gvFurnOrders.Columns(12).Visible = True  'lines
        gvFurnOrders.Columns(13).Visible = False 'parent
        gvFurnOrders.Columns(14).Visible = False 'po cost
        gvFurnOrders.Columns(15).Visible = False 'std cost
        gvFurnOrders.Columns(16).Visible = False 'custom
        gvFurnOrders.Columns(17).Visible = False 'vendor #
        gvFurnOrders.Columns(18).Visible = False 'po date
        gvFurnOrders.Columns(19).Visible = False 'buyer #
        gvFurnOrders.Columns(20).Visible = False 'loc
        gvFurnOrders.Columns(21).Visible = False 'qty
        gvFurnOrders.Columns(22).Visible = False 'batch


        gvFurnOrders.Columns(23).Visible = False 'image
        gvFurnOrders.Columns(24).Visible = False 'image



        Dim sqldataadapter1 As New SqlDataAdapter
        Dim sqldataadapter2 As New SqlDataAdapter
        Dim sqldataadapter3 As New SqlDataAdapter
        Dim sqldatadapter4 As New SqlDataAdapter

        Dim mysqldataadapter1 As New MySqlDataAdapter
        Dim mysqldataadapter2 As New MySqlDataAdapter
        ' Dim mysqldataadapter3 As New MySqlDataAdapter

        Dim conn1 As New SqlConnection
        Dim conn2 As New SqlConnection
        ' Dim conn3 As New MySqlConnection
        Dim conn4 As New SqlConnection

        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim connstr2 As String = ConfigurationManager.ConnectionStrings("VeadaMySQL_ReadOnly").ConnectionString
        Dim connstr3 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString

        conn1.ConnectionString = connstr1
        conn2.ConnectionString = connstr1
        ' conn3.ConnectionString = connstr2
        conn4.ConnectionString = connstr3

        conn1.Open()
        'get prod data 1 time from scheduling where buildloc is stored before the nightly SPECS reload.
        sqldataadapter1.SelectCommand = New SqlCommand("SELECT SONo, BuildLoc FROM Scheduling.dbo.Order_Assignments WHERE Monday > '20190801' ORDER BY SONo asc", conn1)
        sqldataadapter1.Fill(bldgData)


        sqldataadapter3.SelectCommand = New SqlCommand("SELECT MODEL_YEAR, SERIES_PART, BASE_VINYL_PART, PRIMARY_ACCENT_PART, BENCH_IMG_URL, RECLINER_IMG_URL FROM Furniture_Combinations", conn1)
        sqldataadapter3.Fill(furnImages)

        sqldataadapter3.SelectCommand = New SqlCommand("SELECT OEORDLIN_SQL.item_no, ord_no, IMITMIDX_SQL.item_desc_1 FROM OEORDLIN_SQL Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no Where IMITMIDX_SQL.prod_cat = 'H5'", conn4)
        sqldataadapter3.Fill(canvasParts)




        conn1.Close()
        conn1.Dispose()

        conn2.Open()
        'get saved po veada colors and lines to popuate on load
        ''sqldataadapter2.SelectCommand = New SqlCommand("SELECT ProdNo, LineValue, LineText, ColorValue, ColorText FROM [VeadaPOs] WHERE DueDate = '" & selectedDate & "' Order By ProdNo", conn2)
        'sqldataadapter2.SelectCommand = New SqlCommand("SELECT ProdNo, LineValue, LineText, ColorValue, ColorText FROM [VeadaPOs] WHERE ProdNo > 2000000 Order By ProdNo", conn2)
        'sqldataadapter2.Fill(savedPOData)

        conn2.Close()
        conn2.Dispose()

        'conn3.Open()
        'mysqldataadapter1.SelectCommand = New MySqlCommand("Select Distinct(Series), Line, ModelYear from BennSeriesColorLegend order By Series", conn3)
        'mysqldataadapter1.Fill(veadaLines)

        'mysqldataadapter2.SelectCommand = New MySqlCommand("Select Color, Mid(ColorExt,2) as ColorExt, Line, ModelYear from BennSeriesColorLegend order By Series", conn3)
        'mysqldataadapter2.Fill(veadaColors)

        ' mysqldataadapter3.SelectCommand = New MySqlCommand("Select * from BennSeriesColorLegend order By Line", conn3)
        'mysqldataadapter3.Fill(veadaColorChart)

        'conn3.Close()
        'conn3.Dispose()

    End Sub

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
        Dim sqldataadapter As New SqlDataAdapter

        Dim conn As New SqlConnection

        Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString

        conn.ConnectionString = connstr

        conn.Open()

        sqldataadapter.SelectCommand = New SqlCommand("SELECT production_no,component_desc, calc_qty, ([std_cost] * [calc_qty]) as std_cost, ([last_cost] * [calc_qty]) as last_cost, [tot_std_cost], [tot_last_cost], cus_ord_no, bomparent_item FROM [BML_PURPRDBOM] WHERE ((([vendor_name] = 'VEADA IND INC' or component_desc like '%LUXURY RECLINER%' or vendor_name is null ) AND [p_or_m] = 'P') AND ([mat_cost_type] = 'FUR' OR [prod_cat] = 'H5')) OR [prod_cat] = 'S2' and production_no > 2200000 ORDER BY component_desc desc, calc_qty, parent_item", conn) ' has to order by component_desc desc, calc_qty, parent_item to process the negating sets correctly.
        sqldataadapter.Fill(furnLines)

        conn.Close()
        conn.Dispose()

        Return False

    End Function

    Protected Sub gvFurnOrders_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvFurnOrders.RowDataBound
        'Bind the lines grid to a subset of the datatable to avoid multiple calls to the server

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim prod As String = e.Row.Cells(0).Text
            Dim gvLines As GridView = e.Row.Cells(0).FindControl("gvLineItems")
            Dim modelyear As String = Left(prod, 2)

            'Dim img1 As Image = DirectCast(e.Row.FindControl("img1"), Image)
            'Dim img2 As Image = DirectCast(e.Row.FindControl("img2"), Image)
            'Dim phBench As PlaceHolder = DirectCast(e.Row.FindControl("phBench"), PlaceHolder)
            'Dim phRecliner As PlaceHolder = DirectCast(e.Row.FindControl("phRecliner"), PlaceHolder)

            Dim model As String = e.Row.Cells(3).Text
            Dim so As String = e.Row.DataItem("src_ord_no")

            Dim lblVeadaParent As Label = e.Row.Cells(11).FindControl("lblVeadaParentPart")
            Dim lblVeadaParentColor As Label = e.Row.Cells(11).FindControl("lblVeadaParentColor")
            Dim lblBuyerNo As Label = e.Row.Cells(16).FindControl("lblBuyerNo")
            Dim lblBldg As Label = e.Row.Cells(17).FindControl("lblBldg")
            Dim lblBatchID As Label = e.Row.Cells(18).FindControl("lblBatchID")

            Dim lblAccentDesc As Label = e.Row.Cells(6).FindControl("lblAccentDesc")
            Dim lblFurnDesc As Label = e.Row.Cells(8).FindControl("lblFurnDesc")
            Dim lblBVDesc As Label = e.Row.Cells(5).FindControl("lblBVDesc")
            Dim lblCanvas As Label = e.Row.Cells(10).FindControl("lblCanvas")
            Dim lblTrim As Label = e.Row.Cells(11).FindControl("lblTrimDesc")

            Dim dataView As DataView = furnLines.DefaultView
            furnLines.DefaultView.RowFilter = Nothing

            Dim dataView1 As DataView = bldgData.DefaultView
            bldgData.DefaultView.RowFilter = Nothing

            'Dim dataView2 As DataView = savedPOData.DefaultView
            'savedPOData.DefaultView.RowFilter = Nothing

            lblVeadaParent.Text = "FSB." + modelyear + ".001."

            'If Not String.IsNullOrEmpty(prod) Then
            'dataView2.RowFilter = Nothing
            dataView.RowFilter = "production_no =  '" & prod & "'"
            dataView1.RowFilter = "SONo = '" & Right(so, 6) & "'"
            'MesgBox(so)

            Dim dataView2 As DataView = canvasParts.DefaultView
            dataView2.RowFilter = "ord_no = '" & so & "'"

            Try
                Dim canvasColor As String = dataView2(0)(2).ToString
                lblCanvas.Text = canvasColor.Substring(7)
            Catch
            End Try


            gvLines.DataSource = dataView
            gvLines.DataBind()
            Try
                lblBldg.Text = dataView1.Item(0)(1).ToString
            Catch
            End Try


            'try to set Veada BOM # based on order data
            Try
                Dim seriespart As String = Trim(e.Row.DataItem("pillowtop_item"))
                Dim bvpart As String = Trim(e.Row.DataItem("base_vinyl_item"))
                Dim accentpart As String = Trim(e.Row.DataItem("vinyl_accent_item"))

                Dim dataView3 As DataView = veadaColorChart.DefaultView
                dataView3.RowFilter = "ModelYear = " & "'20" & modelyear & "' AND SeriesPartNumber = '" & seriespart & "' AND BaseVinylPartNumber='" & bvpart & "' AND AccentPartNumber='" & accentpart & "'"

                Dim vLine As String = dataView3(0)(1).ToString
                Dim vColorExt As String = dataView3(0)(5).ToString
                Dim vColorDesc As String = dataView3(0)(2).ToString

                If vLine.Length > 0 And vColorExt.Length > 0 Then
                    lblVeadaParent.Text += vLine + vColorExt + "." + model
                    lblVeadaParentColor.Text = vColorDesc
                Else
                    e.Row.Cells(12).BackColor = Drawing.Color.Red
                End If
            Catch
            End Try

            'Get Furn Images - works, but currently disabled so purchasing doesn't have to format the lines.
            'Try
            '    Dim imgseriespart As String = Trim(e.Row.DataItem("pillowtop_item"))
            '    Dim imgbvpart As String = Trim(e.Row.DataItem("base_vinyl_item"))
            '    Dim imgaccentpart As String = Trim(e.Row.DataItem("vinyl_accent_item"))


            '    Dim dataView4 As DataView = furnImages.DefaultView
            '    dataView4.RowFilter = "Model_Year = '" & modelyear & "' AND SERIES_PART = '" & imgseriespart & "' AND BASE_VINYl_PART='" & imgbvpart & "' AND PRIMARY_ACCENT_PART='" & imgaccentpart & "'"

            '    Dim benchurl As String = dataView4(0)(4).ToString
            '    Dim reclinerurl As String = dataView4(0)(5).ToString

            '    'get only the file name
            '    Dim pos = benchurl.LastIndexOf("\") + 1
            '    benchurl = benchurl.Substring(pos, benchurl.Length - pos)


            '    Dim pos1 = reclinerurl.LastIndexOf("\") + 1
            '    reclinerurl = reclinerurl.Substring(pos1, reclinerurl.Length - pos1)


            '    img1.ImageUrl = "http://specs1/Live/PopReporting/FurnitureImages/" & modelyear & "/" & reclinerurl 'hard coded full path to see if I can get the image to export
            '    img2.ImageUrl = "http://specs1/Live/PopReporting/FurnitureImages/" & modelyear & "/" & benchurl

            '    e.Row.Cells(26).Width = 500
            '    e.Row.Cells(27).Width = 500

            '    img1.Width = 500
            '    img2.Width = 500


            'Catch ex As Exception

            'End Try


            If ddlSeries.SelectedValue = "S" Then
                lblBuyerNo.Text = "25" ' Krystle
            Else
                lblBuyerNo.Text = "80" 'Heidi
            End If

            lblBatchID.Text += lblBuyerNo.Text

            Try
                If lblAccentDesc.Text Like "*DIAMONTE*" Then
                    Dim desc As String = lblAccentDesc.Text

                    desc = Replace(desc, "DIAMONTE", "DMNT")
                    lblAccentDesc.Text = desc
                End If

                If lblAccentDesc.Text Like "*DIAMNTE" Then
                    Dim desc As String = lblAccentDesc.Text
                    desc = Replace(desc, "DIAMNTE", "DMNT")
                    lblAccentDesc.Text = desc
                End If

                If lblFurnDesc.Text Like "PILLOWTOP*" Then
                    Dim desc As String = lblFurnDesc.Text
                    desc = Replace(desc, "PILLOWTOP", "PTOP")
                    lblFurnDesc.Text = desc
                End If


                If lblFurnDesc.Text Like "*DIAMOND*" Then
                    Dim desc As String = lblFurnDesc.Text
                    desc = Replace(desc, "DIAMOND", "DMND")
                    lblFurnDesc.Text = desc
                End If

                If lblBVDesc.Text Like "*INTERIOR*" Then
                    Dim desc As String = lblBVDesc.Text
                    desc = Replace(desc, "INTERIOR", "")
                    lblBVDesc.Text = desc
                End If

                If lblBVDesc.Text Like "*INTER*" Then
                    Dim desc As String = lblBVDesc.Text
                    desc = Replace(desc, "INTER", "")
                    lblBVDesc.Text = desc
                End If

                If lblCanvas.Text Like "*TWEED*" Then
                    Dim desc As String = lblCanvas.Text
                    desc = Replace(desc, "TWEED", "TWD")
                    lblCanvas.Text = desc
                End If

                If lblTrim.Text Like "*ZEBRAWOOD*" Then
                    Dim desc As String = lblTrim.Text
                    desc = Replace(desc, "ZEBRAWOOD", "")
                    lblTrim.Text = desc
                End If

                If lblTrim.Text Like "*ZWOOD*" Then
                    Dim desc As String = lblTrim.Text
                    desc = Replace(desc, "ZWOOD", "")
                    lblTrim.Text = desc
                End If

                If lblTrim.Text Like "*MATTE*" Then
                    Dim desc As String = lblTrim.Text
                    desc = Replace(desc, "MATTE", "")
                    lblTrim.Text = desc
                End If


            Catch
            End Try

        End If
    End Sub

    Protected Sub calDueDate_SelectionChanged(sender As Object, e As EventArgs) Handles calDueDate.SelectionChanged
        PopulateDataTables()


        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn

        cmd.Parameters.AddWithValue("@due", calDueDate.SelectedDate)
        cmd1.Parameters.AddWithValue("@due", calDueDate.SelectedDate)

        cmd.CommandText = "Select min(user_def_fld_1) from PPORDFIL_SQL Where due_dt = @due"
        cmd1.CommandText = "Select max(user_def_fld_1) from  PPORDFIL_SQL Where due_dt = @due"

        conn.Open()
        Try
            minProd = cmd.ExecuteScalar
            maxProd = cmd1.ExecuteScalar
        Catch
        End Try

        conn.Close()
        gvFurnOrders.DataBind()
        gvFurnOrders.Columns(12).HeaderText = "LINES FOR PROD #'s " + Trim(minProd) + "- " + Trim(maxProd) + "  -  " + calDueDate.SelectedDate
        starterRow = 3
    End Sub

    Protected Sub ddlSeries_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSeries.SelectedIndexChanged
        If furnLines.Rows.Count = 0 Then
            PopulateDataTables()
        End If

    End Sub

    Dim lastTotal As Decimal = 0
    Dim stdTotal As Decimal = 0
    Dim var As Decimal = 0
    Dim setCount As Integer = 0
    Dim dupSet As String = "No"
    Dim dupSetCost As String
    Dim curSetCost As String

    Dim numRecordsHidden As Integer = 0
    Protected Sub gvLineItems_RowDataBound(sender As Object, e As GridViewRowEventArgs)

        Dim gvr As GridViewRow = DirectCast(sender.NamingContainer, GridViewRow)
        Dim lblCustomForImport As Label = CType(gvr.Cells(15).FindControl("lblCustomForImport"), Label)


        If e.Row.RowType = DataControlRowType.DataRow Then

            If e.Row.Cells(0).Text Like "*PILLOWTOP*" Then
                Dim desc As String = e.Row.Cells(0).Text
                desc = Replace(desc, "PILLOWTOP", "PTOP")
                e.Row.Cells(0).Text = desc
            End If


            If e.Row.Cells(0).Text Like "UPGD,*" Then
                e.Row.Cells(0).Font.Bold = True
                Dim desc As String = e.Row.Cells(0).Text
                desc = Replace(desc, "UPGD,", "")
                e.Row.Cells(0).Text = desc
            End If

            If e.Row.Cells(0).Text Like "*SET*" Then
                e.Row.Cells(0).Font.Bold = True
            End If

            If e.Row.Cells(0).Text Like "*CUSTOM*" Then
                e.Row.BackColor = Drawing.Color.Red
                lblCustomForImport.Text = "CUSTOM"

                If e.Row.Cells(0).Text Like "CUSTOM BOAT*" Then 'get the drawing #
                    Dim sono As String = e.Row.DataItem("cus_ord_no")
                    'MesgBox(e.Row.DataItem("cus_ord_no"))
                    Dim conn As New SqlConnection()
                    Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
                    Dim cmd As New SqlCommand

                    conn.ConnectionString = connstr
                    cmd.Connection = conn
                    cmd.CommandType = CommandType.Text

                    cmd.CommandText = "Select extra_8 FROM OEORDHDR_SQL where ord_no =  '" & sono & "'"
                    conn.Open()
                    Try
                        Dim custdrawno As String = cmd.ExecuteScalar()
                        e.Row.Cells(0).Text = "CUSTOM BOAT UPG - DRAWING #: " & custdrawno
                        lblCustomForImport.Text = "CUSTOM BOAT UPG - DRAWING #: " & custdrawno
                    Catch
                    End Try

                    conn.Close()


                End If

            Else
                lblCustomForImport.Text = ""
            End If


            'eliminate sets that 0 each other out

            If e.Row.Cells(0).Text Like "SET,*" And e.Row.Cells(1).Text = "-1" Then
                dupSet = e.Row.Cells(0).Text
                dupSetCost = e.Row.Cells(2).Text
                e.Row.Visible = False
                numRecordsHidden += 1
            End If

            If e.Row.Cells(0).Text = dupSet And e.Row.Cells(1).Text = "1" Then
                e.Row.Visible = False
                numRecordsHidden += 1
            End If

            'end of eliminate sets that 0 each other out.

            lastTotal += Convert.ToInt64(DataBinder.Eval(e.Row.DataItem, "last_cost"))
            stdTotal += Convert.ToInt64(DataBinder.Eval(e.Row.DataItem, "std_cost"))

            If e.Row.Cells(0).Text Like "CANVAS*" Then
                e.Row.Visible = False
                numRecordsHidden += 1
            End If


        End If


        If e.Row.RowType = DataControlRowType.Footer Then


            Dim lblLastTotal As Label = CType(e.Row.FindControl("lblLastTotal"), Label)
            Dim lblStdTotal As Label = CType(e.Row.FindControl("lblStdTotal"), Label)
            Dim lblVariance As Label = CType(e.Row.FindControl("lblVariance"), Label)

            lastRow = starterRow + sender.Rows.Count - numRecordsHidden - 1 ' works




            'MesgBox(lastRow)
            Dim formula As String = "=SUM(M" & starterRow & ":" & "M" & lastRow & ")"
            Dim formula2 As String = "=SUM(O" & starterRow & ":" & "O" & lastRow & ")"
            Dim formula3 As String = "=N" & lastRow + 1 & "-" & "P" & lastRow + 1
            'Try
            lblLastTotal.Text = formula
            lblStdTotal.Text = formula2
            lblVariance.Text = formula3

            'Catch
            'End Try

            starterRow = lastRow + 3 'works

            numRecordsHidden = 0
        End If


    End Sub

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnExport.Click
        Dim selectedDate As Date = calDueDate.SelectedDate

        'Hide all PO Export Fields
        'gvFurnOrders.Columns(0).Visible = True 'Prod #
        gvFurnOrders.Columns(1).Visible = False 'Due Date
        gvFurnOrders.Columns(2).Visible = False 'Base Series
        'gvFurnOrders.Columns(3).Visible = True 'Model
        'gvFurnOrders.Columns(4).Visible = True 'bv
        'gvFurnOrders.Columns(5).Visible = True 'acc
        'gvFurnOrders.Columns(6).Visible = True 'stitch
        'gvFurnOrders.Columns(7).Visible = True 'desc
        'gvFurnOrders.Columns(8).Visible = True 'trim
        'gvFurnOrders.Columns(9).Visible = True 'flooring
        'gvFurnOrders.Columns(10).Visible = True 'canvas
        'gvFurnOrders.Columns(11).Visible = True  'buildloc
        gvFurnOrders.Columns(12).Visible = True  'lines
        gvFurnOrders.Columns(13).Visible = True 'parent
        gvFurnOrders.Columns(14).Visible = False 'po cost
        gvFurnOrders.Columns(15).Visible = False 'std cost
        gvFurnOrders.Columns(16).Visible = False 'custom
        gvFurnOrders.Columns(17).Visible = False 'vendor #
        gvFurnOrders.Columns(18).Visible = False 'po date
        gvFurnOrders.Columns(19).Visible = False 'buyer #
        gvFurnOrders.Columns(20).Visible = False 'loc
        gvFurnOrders.Columns(21).Visible = False 'qty
        gvFurnOrders.Columns(22).Visible = False 'batch
        gvFurnOrders.Columns(23).Visible = False 'image
        gvFurnOrders.Columns(24).Visible = False 'image

        Dim prodrange As String = gvFurnOrders.Columns(12).HeaderText
        prodrange = prodrange.Substring(19)
        prodrange = prodrange.Replace(" ", "")

        Dim bldg As String = ddlSeries.SelectedItem.ToString()

        ExportExcel("VeadaPO_" + selectedDate + "_" + prodrange + "_" + bldg + "-Series", gvFurnOrders)
        gvFurnOrders.Columns(12).Visible = True

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

    Protected Sub btnExportPO_Click(sender As Object, e As EventArgs) Handles btnExportPO.Click
        Dim selectedDate As Date = calDueDate.SelectedDate

        gvFurnOrders.Columns(10).Visible = True
        gvFurnOrders.Columns(11).Visible = False
        gvFurnOrders.Columns(12).Visible = False
        gvFurnOrders.Columns(13).Visible = True
        gvFurnOrders.Columns(14).Visible = True
        gvFurnOrders.Columns(15).Visible = True
        gvFurnOrders.Columns(16).Visible = True
        gvFurnOrders.Columns(17).Visible = True
        gvFurnOrders.Columns(18).Visible = True
        gvFurnOrders.Columns(19).Visible = True
        gvFurnOrders.Columns(20).Visible = True
        gvFurnOrders.Columns(21).Visible = True

        gvFurnOrders.Columns(22).Visible = False
        gvFurnOrders.Columns(23).Visible = False
        gvFurnOrders.Columns(24).Visible = False


        ExportExcel("VeadaPOExportForMacola_" + selectedDate, gvFurnOrders)

        gvFurnOrders.Columns(11).Visible = True
        gvFurnOrders.Columns(12).Visible = True
        gvFurnOrders.Columns(13).Visible = False
        gvFurnOrders.Columns(14).Visible = False
        gvFurnOrders.Columns(15).Visible = False
        gvFurnOrders.Columns(16).Visible = False
        gvFurnOrders.Columns(17).Visible = False
        gvFurnOrders.Columns(18).Visible = False
        gvFurnOrders.Columns(19).Visible = False
        gvFurnOrders.Columns(20).Visible = False
        gvFurnOrders.Columns(21).Visible = False

        'gvFurnOrders.Columns(22).Visible = True
        'gvFurnOrders.Columns(23).Visible = True


    End Sub

    'Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
    '    Dim conn As New SqlConnection()
    '    Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
    '    Dim cmd As New SqlCommand
    '    Dim cmd1 As New SqlCommand
    '    Dim cmd2 As New SqlCommand

    '    Dim duedate As Date = calDueDate.SelectedDate
    '    Dim saveddate As Date = Date.Now
    '    conn.ConnectionString = connstr
    '    cmd.Connection = conn
    '    cmd1.Connection = conn
    '    cmd2.Connection = conn

    '    cmd.CommandType = CommandType.Text
    '    cmd1.CommandType = CommandType.Text
    '    cmd2.CommandType = CommandType.Text

    '    conn.Open()

    '    For Each row In gvFurnOrders.Rows
    '        Dim prodno As String = row.Cells(0).Text
    '        Dim lblLine As Label = CType(row.Cells(10).FindControl("lblVeadaSeries"), Label)
    '        Dim lblColor As Label = CType(row.Cells(10).FindControl("lblVeadaColor"), Label)
    '        Dim lblParent As Label = CType(row.Cells(11).FindControl("lblVeadaParentPart"), Label)
    '        'Dim ddlVeadaSeries As DropDownList = CType(row.FindControl("ddlVeadaSeries"), DropDownList)
    '        'Dim ddlVeadaColor As DropDownList = CType(row.FindControl("ddlVeadaColors"), DropDownList)

    '        Dim ddlVeadaSeriesValue As String = ddlVeadaSeries.SelectedValue
    '        Dim ddlVeadaColorValue As String = ddlVeadaColor.SelectedValue

    '        cmd.Parameters.AddWithValue("@prod", prodno)

    '        cmd1.Parameters.AddWithValue("@prod1", prodno)
    '        cmd1.Parameters.AddWithValue("@duedate1", duedate)
    '        cmd1.Parameters.AddWithValue("@line1", lblLine.Text)
    '        cmd1.Parameters.AddWithValue("@linevalue1", ddlVeadaSeriesValue)
    '        cmd1.Parameters.AddWithValue("@color1", lblColor.Text)
    '        cmd1.Parameters.AddWithValue("@colorvalue1", ddlVeadaColorValue)
    '        cmd1.Parameters.AddWithValue("@parent1", lblParent.Text)
    '        cmd1.Parameters.AddWithValue("@today1", saveddate)
    '        cmd1.Parameters.AddWithValue("@user1", GlobalVariables.stationID)


    '        cmd2.Parameters.AddWithValue("@prod2", prodno)
    '        cmd2.Parameters.AddWithValue("@duedate2", duedate)
    '        cmd2.Parameters.AddWithValue("@line2", lblLine.Text)
    '        cmd2.Parameters.AddWithValue("@linevalue2", ddlVeadaSeriesValue)
    '        cmd2.Parameters.AddWithValue("@color2", lblColor.Text)
    '        cmd2.Parameters.AddWithValue("@colorvalue2", ddlVeadaColorValue)
    '        cmd2.Parameters.AddWithValue("@parent2", lblParent.Text)
    '        cmd2.Parameters.AddWithValue("@today2", saveddate)
    '        cmd2.Parameters.AddWithValue("@user2", GlobalVariables.stationID)

    '        cmd.CommandText = "Select Count(*) From VeadaPOs where ProdNo = @prod"
    '        cmd1.CommandText = "Insert into VeadaPOs(ProdNo, DueDate,LineValue, LineText, ColorValue, ColorText,Parent,DateSaved,SavedBy) Values (@prod1, @duedate1, @linevalue1, @line1, @colorvalue1, @color1, @parent1, @today1, @user1)"
    '        cmd2.CommandText = "Update VeadaPOs set DueDate = @duedate2, LineValue = @linevalue2, LineText = @line2, ColorValue = @colorvalue2, ColorText = @color2, Parent = @parent2, DateSaved = @today2, SavedBy = @user2 where ProdNo = @prod2"

    '        Dim count As Integer = cmd.ExecuteScalar

    '        If count > 0 Then
    '            cmd2.ExecuteScalar() 'exists so update
    '        Else
    '            cmd1.ExecuteScalar() 'does not exist so insert
    '        End If

    '        cmd.Parameters.Clear()
    '        cmd1.Parameters.Clear()
    '        cmd2.Parameters.Clear()
    '    Next

    '    'conn.Close()
    'End Sub

    Protected Function SplitBValSlash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("\")(1)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function

    Protected Sub gvFurnOrders_DataBound(sender As Object, e As EventArgs) Handles gvFurnOrders.DataBound

    End Sub

    Protected Sub gvLineItems_DataBound(sender As Object, e As EventArgs)

    End Sub

End Class
