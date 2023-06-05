Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO
Imports MySql.Data.MySqlClient
Partial Class Tubes_ChineFoilDailySchedule
    Inherits System.Web.UI.Page

    Public ChineFoilConfigGrid As New DataTable
    Public ChineFoilStockSizes As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub Tubes_ChineFoilDailySchedule_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim sqldataadapter1 As New SqlDataAdapter
        Dim sqldataadapter2 As New SqlDataAdapter

        Dim conn1 As New SqlConnection
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1

        conn1.Open()
        'get prod data 1 time from scheduling where buildloc is stored before the nightly SPECS reload.
        '     0          1               2            3        4       5    6      7                  8               9             10           11           12
        ' BoatWidth, TubeLength, TubeLengthJustFt, Config, NumTubes, Perf, IO, UpsweptChines, CtrChinesLength, OtrsInnerLength, OtrsInnerType, OtrsOuter, OtrsOuterType
        sqldataadapter1.SelectCommand = New SqlCommand("SELECT * FROM Tubes_ChinesFoilsConfigs ORDER BY TubeLengthJustFt asc", conn1)
        sqldataadapter1.Fill(ChineFoilConfigGrid)

        '   0       1          2        3  
        'AutoID, StockLength, Type, ChineOrFoil
        sqldataadapter1.SelectCommand = New SqlCommand("SELECT * FROM Tubes_ChineFoilStockSizes ORDER BY StockLength, Type, ChineOrFoil asc", conn1)
        sqldataadapter1.Fill(ChineFoilStockSizes)

        conn1.Close()
        conn1.Dispose()


    End Sub

    Protected Sub gvOuters_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOuters.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim OtrTubes_Inner As Label = DirectCast(e.Row.FindControl("OtrTubes_Inner"), Label)
            Dim OtrTubes_Outer As Label = DirectCast(e.Row.FindControl("OtrTubes_Outer"), Label)
            Dim OutsideStock As Label = DirectCast(e.Row.FindControl("OutsideStock"), Label)
            Dim InsideStock As Label = DirectCast(e.Row.FindControl("InsideStock"), Label)
            Dim InsideQty As Label = DirectCast(e.Row.FindControl("lblInsideQty"), Label)
            Dim OutsideQty As Label = DirectCast(e.Row.FindControl("lblOutsideQty"), Label)
            Dim ProdNo As String = Trim(e.Row.DataItem("ProdNo"))

            Dim outerStrakes As String = e.Row.DataItem("Strakes").ToString
            Dim tubeLength As Int16 = 0
            Try
                tubeLength = Left(e.Row.DataItem("OtrTubeLength"), 2)
            Catch
            End Try
            Dim perf As String = e.Row.DataItem("PerfPkg")
            Dim IO As Int16 = e.Row.DataItem("IO")


            Dim stockType As String = ""
            Dim insideChineOrFoil As String = ""
            Dim outsideChineOrFoil As String = ""

            If outerStrakes.Length > 0 Then
                Dim dataView As DataView = ChineFoilConfigGrid.DefaultView
                dataView.RowFilter = "TubeLengthJustFt = '" & tubeLength & "' AND Perf = '" & perf & "' AND IO = '" & IO & "'"

                If dataView.Count > 0 Then

                    Dim OuterInside As String = dataView(0)(9).ToString + " " + dataView(0)(10).ToString
                    Dim OuterOutside As String = dataView(0)(11).ToString + " " + dataView(0)(12).ToString

                    Dim needangleouters As String = ""

                    If dataView(0)(11).ToString() Like "*angle*" Then
                        needangleouters = "Angle"
                    End If

                    If dataView(0)(10).ToString Like "*chine*" Then
                        insideChineOrFoil = "Chine"
                    ElseIf dataView(0)(10).ToString Like "*foil*" Then
                        insideChineOrFoil = "Foil"
                    End If

                    If dataView(0)(12).ToString Like "*chine*" Then
                        outsideChineOrFoil = "Chine"
                    ElseIf dataView(0)(12).ToString Like "*foil*" Then
                        outsideChineOrFoil = "Foil"
                    End If

                    OtrTubes_Inner.Text = OuterInside
                    OtrTubes_Outer.Text = OuterOutside



                    'get stock lengths

                    If outerStrakes Like "SW*" Then

                        stockType = "Sealed"
                    Else

                        stockType = "Open"
                    End If

                    'get Inside Stock Length

                    Try
                        Dim OuterInsideLength As Integer = Int16.Parse(dataView(0)(9).ToString())

                        'MesgBox(stockType.ToString)
                        'MesgBox(insideChineOrFoil.ToString)
                        Dim needangleoutersinside As String = ""
                        Dim dataView1 As DataView = ChineFoilStockSizes.DefaultView
                        dataView1.RowFilter = "StockLength >= '" & OuterInsideLength & "' AND Type = '" & stockType & "' AND ChineOrFoil = '" & insideChineOrFoil & "'"
                        InsideStock.Text = needangleoutersinside + " " + OuterInsideLength.ToString + " From " + " " + dataView1(0)(1).ToString + " " + stockType + " " + insideChineOrFoil
                        'InsideStock.Text = OuterInsideLength.ToString + " From " + " " + dataView1(0)(1).ToString + " " + stockType + " " + insideChineOrFoil

                    Catch ex As Exception
                        e.Row.BackColor = Drawing.Color.Red
                    End Try

                    'get Outside Stock Length
                    Try
                        'MesgBox(dataView(0)(11).ToString)

                        Dim OuterOutsideLength As Integer = Int16.Parse(Left(dataView(0)(11).ToString(), 3))
                        Dim needangle As String = ""

                        If dataView(0)(11).ToString() Like "*angle*" Then
                            needangle = "Angle"
                        End If
                        Dim dataView2 As DataView = ChineFoilStockSizes.DefaultView
                        dataView2.RowFilter = "StockLength >= '" & OuterOutsideLength & "' AND Type = '" & stockType & "' AND ChineOrFoil = '" & outsideChineOrFoil & "'"
                        OutsideStock.Text = needangle + " " + OuterOutsideLength.ToString + " From " + dataView2(0)(1).ToString + " " + stockType + " " + outsideChineOrFoil
                    Catch ex As Exception

                    End Try

                    'Qty's only on lines with strakes and only inside if no outside.

                    If outerStrakes.Length > 0 And OuterInside.Length > 0 Then
                        InsideQty.Text = "2"

                    End If

                    If outerStrakes.Length > 0 And OuterOutside.Length > 3 Then
                        OutsideQty.Text = "2"

                    End If
                Else
                    'MesgBox(tubeLength)
                    'MesgBox(perf)
                    'MesgBox(IO)
                    MesgBox(ProdNo + " Could have an issue.")
                End If
            End If


        End If
    End Sub


    Protected Sub btnCalc_Click(sender As Object, e As EventArgs) Handles btnCalc.Click
        '<-----------------------> Outers Inside and Outside

        lblSelectedDate.Text = calSelectedDate.SelectedDate
        lblSelectedDate0.Text = calSelectedDate.SelectedDate

        Dim calcResults As DataTable
        calcResults = New DataTable("calcResults")

        Dim piece As DataColumn = New DataColumn("Piece")
        piece.DataType = System.Type.GetType("System.String")

        Dim count As DataColumn = New DataColumn("Count")
        count.DataType = System.Type.GetType("System.Int32")


        calcResults.Columns.Add(piece)
        calcResults.Columns.Add(count)


        For Each row In gvOuters.Rows

            Dim lblInsideStock As Label = DirectCast(row.FindControl("InsideStock"), Label)
            Dim lblOutsideStock As Label = DirectCast(row.FindControl("OutsideStock"), Label)
            Dim insideStock As String = lblInsideStock.Text
            Dim outsideStock As String = lblOutsideStock.Text

            If lblInsideStock.Text.Length > 0 Then

                'Else
                Dim row1 As DataRow
                row1 = calcResults.NewRow()

                row1(0) = insideStock
                row1(1) = 2

                calcResults.Rows.Add(row1)

            End If

            If lblOutsideStock.Text.Length > 0 Then

                'Else
                Dim row1 As DataRow
                row1 = calcResults.NewRow()

                row1(0) = outsideStock
                row1(1) = 2
                calcResults.Rows.Add(row1)

            End If

        Next



        Dim calcResultsSummary As DataTable
        calcResultsSummary = New DataTable("calcResultsSummary")
        calcResultsSummary.Columns.Add("Piece")
        calcResultsSummary.Columns.Add("Count")
        calcResultsSummary.Columns.Add("--")
        calcResultsSummary.Columns.Add("-")



        calcResultsSummary.DefaultView.Sort = "Piece ASC"

        Dim view As DataView = New DataView(calcResults)
        Dim distinctValues As DataTable = view.ToTable(True, "Piece", "Count")
        distinctValues.DefaultView.Sort = "Piece ASC"

        For Each row As DataRow In distinctValues.Rows
            Dim query As String = String.Format("Piece='{0}'", row(0))
            Dim total As Integer = calcResults.[Select](query).Length * 2
            calcResultsSummary.Rows.Add(row(0), total)
        Next

        'MesgBox(calcResults.Rows.Count)
        gvOuterSummary.DataSource = calcResultsSummary
        gvOuterSummary.DataBind()



        '<------------------------>  Centers

        Dim calcResultsCenters As DataTable
        calcResultsCenters = New DataTable("calcResultsCenters")

        Dim pieceCtrs As DataColumn = New DataColumn("Piece")
        piece.DataType = System.Type.GetType("System.String")

        Dim countCtr As DataColumn = New DataColumn("Count")
        count.DataType = System.Type.GetType("System.Int32")

        Dim cutLengthCtr As DataColumn = New DataColumn("CutLength")
        cutLengthCtr.DataType = System.Type.GetType("System.Int32")


        calcResultsCenters.Columns.Add("Piece")
        calcResultsCenters.Columns.Add("Count")
        'calcResultsCenters.Columns.Add("CutLength")


        For Each row In gvCenters.Rows

            Dim lblCenterStock As Label = DirectCast(row.FindControl("lblCenterStock"), Label)
            Dim centerStock As String = lblCenterStock.Text

            If lblCenterStock.Text.Length > 0 Then

                'Else
                Dim row2 As DataRow
                row2 = calcResultsCenters.NewRow()

                row2(0) = centerStock
                row2(1) = 2
                calcResultsCenters.Rows.Add(row2)

            End If

        Next


        Dim calcResultsCentersSummary As DataTable
        calcResultsCentersSummary = New DataTable("calcResultsCenters")
        calcResultsCentersSummary.Columns.Add("Piece")
        calcResultsCentersSummary.Columns.Add("Count")
        'calcResultsCentersSummary.Columns.Add("CutLength")
        calcResultsCentersSummary.DefaultView.Sort = "Piece ASC"

        Dim view2 As DataView = New DataView(calcResultsCenters)
        Dim distinctValuesCtrs As DataTable = view2.ToTable(True, "Piece", "Count")
        distinctValuesCtrs.DefaultView.Sort = "Piece ASC"

        For Each row As DataRow In distinctValuesCtrs.Rows

            Dim queryCtr As String = String.Format("Piece='{0}'", row(0))
            Dim totalCtr As Integer = calcResultsCenters.[Select](queryCtr).Length * 2
            calcResultsCentersSummary.Rows.Add(row(0), totalCtr)

        Next


        gvCentersSummary.DataSource = calcResultsCentersSummary
        gvCentersSummary.DataBind()


        '<------------------------------Stock Summary Table

        Dim dtCombined As DataTable = calcResultsSummary.Copy()
        dtCombined.Merge(calcResultsCentersSummary, False)

        'add a column for the length post merge
        ' Dim dtCombinedCutLength As DataColumn = New DataColumn("CutLength")
        'dtCombinedCutLength.DataType = System.Type.GetType("System.Int32")

        'Dim dtCombinedAngle As DataColumn = New DataColumn("Angled?")
        'dtCombinedAngle.DataType = System.Type.GetType("System.String")

        Dim dtCombinedAltered As New DataTable

        Dim alteredStockpiece As DataColumn = New DataColumn("Piece")
        alteredStockpiece.DataType = System.Type.GetType("System.String")

        Dim alteredStockcount As DataColumn = New DataColumn("Count")
        alteredStockcount.DataType = System.Type.GetType("System.Int32")

        Dim alteredStocklength As DataColumn = New DataColumn("CutLength")
        alteredStocklength.DataType = System.Type.GetType("System.Int32")

        Dim alteredStockAngled As DataColumn = New DataColumn("Angled?")
        alteredStockAngled.DataType = System.Type.GetType("System.String")


        dtCombinedAltered.Columns.Add("Piece")
        dtCombinedAltered.Columns.Add("Count")
        dtCombinedAltered.Columns.Add("Cut Length")
        dtCombinedAltered.Columns.Add("Angled?")


        'Remove Angle and actual length from to get stock pieces only.

        For Each row As DataRow In dtCombined.Rows
            If row(0) Like "Angle*" Then
                Dim pieceText = row(0)
                pieceText = row(0).Remove(0, 6)
                row(0) = pieceText
                Dim length As Integer = Left(row(0), 4)
                'MesgBox(length)
                Dim stockText = row(0).Remove(0, 9)
                row(0) = stockText
                row(2) = length
                row(3) = "Angled"

            Else
                Try
                    Dim length As Integer = Left(row(0), 4)


                    Dim stockText = row(0).Remove(0, 9)
                    row(0) = stockText
                    row(2) = length
                Catch
                End Try
            End If

            dtCombinedAltered.Rows.Add(Trim(row(0)), row(1), row(2), row(3))
        Next

        dtCombinedAltered.DefaultView.Sort = "Piece ASC"
        gvaltered.DataSource = dtCombinedAltered
        gvaltered.DataBind()

        'Consolidate Results

        Dim stockResultsSummary As DataTable
        stockResultsSummary = New DataTable("dtCombinedAltered")

        Dim Stockpiece As DataColumn = New DataColumn("Piece")
        Stockpiece.DataType = System.Type.GetType("System.String")

        Dim Stockcount As DataColumn = New DataColumn("Count")
        Stockcount.DataType = System.Type.GetType("System.Int32")

        stockResultsSummary.Columns.Add("Piece")
        stockResultsSummary.Columns.Add("Count")

        For Each row As DataRow In dtCombinedAltered.Rows

            Dim dataView As DataView = dtCombinedAltered.DefaultView
            Dim dataView2 As DataView = stockResultsSummary.DefaultView

            Dim pieceText As String = Trim(row(0))
            Dim pieceCount As Integer = row(1)

            dataView.RowFilter = "Piece =  '" & Trim(pieceText) & "'"
            dataView2.RowFilter = "Piece =  '" & Trim(pieceText) & "'"

            Dim currentLineCount As Integer = 0
            Dim currentCount As Integer = 0
            Dim newCount As Integer = 0

            If dataView2.Count = 0 Then 'sum up all the lines and add a line for it.

                Dim totalCount As Integer = 0

                For Each rowView As DataRowView In dataView
                    Dim row6 As DataRow = rowView.Row
                    totalCount += row6("Count")
                Next
                stockResultsSummary.Rows.Add(Trim(row(0)), totalCount)

            Else ' skip it already done above

            End If

            dataView.RowFilter = Nothing
            dataView2.RowFilter = Nothing

        Next

        stockResultsSummary.DefaultView.Sort = "Piece ASC"
        gvStockRequiredSummary.DataSource = stockResultsSummary

        gvStockRequiredSummary.DataBind()

    End Sub

    Private Sub gvOuters_DataBound(sender As Object, e As EventArgs) Handles gvOuters.DataBound

    End Sub
    Protected Sub gvCenters_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCenters.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim lblCenterStock As Label = DirectCast(e.Row.FindControl("lblCenterStock"), Label)
            Dim centerStrakes As String = e.Row.DataItem("Strakes").ToString
            Dim lblCenterLength As Label = DirectCast(e.Row.FindControl("lblCenterLength"), Label)
            Dim centerTubeLength As String = Trim(lblCenterLength.Text)
            Dim stockType As String
            Dim centerChineOrFoil As String = "CHINE"
            Dim needangle As String = ""

            'get stock lengths
            ' MesgBox(centerStrakes)
            If (centerStrakes Like "*SW*" Or centerStrakes Like "SW*") Then
                stockType = "Sealed"
            Else
                stockType = "Open"
            End If
            'MesgBox(centerTubeLength)

            If e.Row.DataItem("CtrTubeLength") = "27" Or e.Row.DataItem("CtrTubeLength") = "28" Or e.Row.DataItem("CtrTubeLength") = "30" Then
                stockType = "Sealed" 'we only have 300 inch in sealed, not open so they get sealed regardless
            End If

            'get Center Stock Length

            Try
                    Dim dataView2 As DataView = ChineFoilStockSizes.DefaultView
                    dataView2.RowFilter = "StockLength >= '" & centerTubeLength & "' AND Type = '" & stockType & "' AND ChineOrFoil = '" & centerChineOrFoil & "'"
                    lblCenterStock.Text = needangle + " " + centerTubeLength.ToString + " From " + dataView2(0)(1).ToString + " " + stockType + " " + "Chine"

                Catch ex As Exception
                    e.Row.BackColor = Drawing.Color.Red
                End Try
            End If
    End Sub
    Protected Sub calSelectedDate_SelectionChanged(sender As Object, e As EventArgs) Handles calSelectedDate.SelectionChanged
        gvCenters.DataBind()
        gvOuters.DataBind()
        btnCalc_Click(sender, e)

    End Sub
    Protected Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click

    End Sub
    Protected Sub gvaltered_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvaltered.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.Cells(0).Text Like "*Sealed*" Then
                e.Row.BackColor = Drawing.Color.LightBlue
            End If
        End If
    End Sub
    Protected Sub gvStockRequiredSummary_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvStockRequiredSummary.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.Cells(0).Text Like "*Sealed*" Then
                e.Row.BackColor = Drawing.Color.LightBlue
            End If


        End If
    End Sub
    Protected Sub btnMaintain_Click(sender As Object, e As EventArgs) Handles btnMaintain.Click

        Dim url As String = "ChineFoilMaint.aspx"
        'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=3000,height=2000');", True)


    End Sub
End Class
