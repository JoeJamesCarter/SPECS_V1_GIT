Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Barcode_Tubes_PhyInvTubeInfo
    Inherits System.Web.UI.Page

    Public tagData As New DataTable
    Public tubePriority As New DataTable
    Public ChineFoilConfigGrid As New DataTable
    Public ChineFoilStockSizes As New DataTable
    Public tagLog As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub
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
    Public Function PopulateDataTables() As String

        Dim sqldataadapter As New SqlDataAdapter
        Dim sqldataadapter1 As New SqlDataAdapter
        Dim sqldataadapter2 As New SqlDataAdapter
        Dim sqldataadapter3 As New SqlDataAdapter


        Dim TodaysDate As Date = Date.Now

        Dim conn As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()
        sqldataadapter.SelectCommand = New SqlCommand("SELECT * From Tubes_TagLookups", conn)
        sqldataadapter.Fill(tagData)
        'MesgBox(tagData.Rows.Count)

        'get prod data 1 time from scheduling where buildloc is stored before the nightly SPECS reload.
        '     0          1               2            3        4       5    6      7                  8               9             10           11           12
        ' BoatWidth, TubeLength, TubeLengthJustFt, Config, NumTubes, Perf, IO, UpsweptChines, CtrChinesLength, OtrsInnerLength, OtrsInnerType, OtrsOuter, OtrsOuterType
        sqldataadapter1.SelectCommand = New SqlCommand("SELECT * FROM Tubes_ChinesFoilsConfigs ORDER BY TubeLengthJustFt asc", conn)
        sqldataadapter1.Fill(ChineFoilConfigGrid)

        '   0       1          2        3  
        'AutoID, StockLength, Type, ChineOrFoil
        sqldataadapter2.SelectCommand = New SqlCommand("SELECT * FROM Tubes_ChineFoilStockSizes ORDER BY StockLength, Type, ChineOrFoil asc", conn)
        sqldataadapter2.Fill(ChineFoilStockSizes)

        sqldataadapter3.SelectCommand = New SqlCommand("SELECT RTrim(t1.ProdNo) as ProdNo, t2.PerfPkg, t2.IO FROM BML_POPREPORTING_GREENLIGHTS t1 Left join BML_POPREPORTING_TUBEPRIORITY t2 on t1.ProdNo = t2.ProdNo Where t1.ProdNo > 2000000 and CompleteStatus < 2", conn)
        sqldataadapter3.Fill(tubePriority)

        'MesgBox(tubePriority.Rows.Count)

        conn.Close()

        conn.Dispose()
        Return False

    End Function
    Public Function PopulateTagLog(ProdNo As String) As String

        Dim sqldataadapter As New SqlDataAdapter
        Dim TodaysDate As Date = Date.Now
        'Dim tube As String = lblPSC.Text
        'Dim prod As String = lblProdNo.Text

        Dim conn As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()

        sqldataadapter.SelectCommand = New SqlCommand("SELECT * from Tubes_PhyInvTagLog where ProdNo = '" & ProdNo & "' And LogDate = '" & TodaysDate & "'", conn)
        sqldataadapter.Fill(tagLog)

        conn.Close()
        conn.Dispose()

        Return False

    End Function
    Private Sub Barcode_Tubes_PhyInvTubeInfo_Load(sender As Object, e As EventArgs) Handles Me.Load
        centers.Visible = False
        outers.Visible = False
        tbTubeInfo.Focus()
        If tagData.Rows.Count < 1 Then
            PopulateDataTables()
            'PopulateTagLog()
        End If
    End Sub
    Private Sub tbTubeInfo_TextChanged(sender As Object, e As EventArgs) Handles tbTubeInfo.TextChanged

        Dim fullprodno As String = tbTubeInfo.Text

        Dim outerReader As SqlDataReader
        Dim centerReader As SqlDataReader
        Dim tubetype As String = ""

        lblInsideStockType.Text = ""
        lblInsideStockCorF.Text = ""
        lblInsideStockLength.Text = ""

        lblOutsideStockType.Text = ""
        lblOutsideStockCorF.Text = ""
        lblOutsideStockLength.Text = ""

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn
        cmd1.Connection = conn

        Dim prod As String = fullprodno.Split("-")(0)
        Dim section As String = fullprodno.Split("-")(1)

        If section Like "P*" Then
            lblPSC.Text = "PORT"
        ElseIf section Like "S*" Then
            lblPSC.Text = "STRB"
        ElseIf section Like "C*" Then
            lblPSC.Text = "CTR"
        End If

        cmd.Parameters.AddWithValue("@prod", Trim(prod))
        cmd1.Parameters.AddWithValue("@prod1", Trim(prod))

        cmd.CommandText = "Select t1.*, t2.ItemNo from OutertubeDetails t1 left join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo where t1.ProdNo = @prod"
        cmd1.CommandText = "Select t1.*, t2.ItemNo from CentertubeDetails t1 left join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo where t1.ProdNo = @prod1"

        If fullprodno.Split("-").Count = 3 Then
            tubetype = fullprodno.Split("-")(2)
        End If

        lblProdNo.Text = prod

        gvTagPredictions.DataBind()
        gvCtrTagPredictions.DataBind()
        gvChines.DataBind()
        gvFuel.DataBind()
        gvStorage.DataBind()

        conn.Open()

        If section Like "P*" Or section Like "S*" Or section Like "p*" Or section Like "s*" Then
            lblTubeType.Text = "OUTER"
            outerReader = cmd.ExecuteReader()
            outers.Visible = True
            centers.Visible = False
            While outerReader.Read
                lblModel.Text = outerReader.Item("ItemNo").ToString
                lblOBracket.Text = outerReader.Item("Bracket").ToString
                'lblODrawingNo.Text = outerReader.Item("DrawingNo").ToString
                lblOFuel.Text = outerReader.Item("Fuel").ToString
                lblStyle.Text = outerReader.Item("Style").ToString
                lblDiameter.Text = outerReader.Item("Diameter").ToString
                'lblLadder.Text = outerReader.Item("Ladder").ToString
                'lblKeel.Text = outerReader.Item("Keel").ToString
                lblSplash.Text = outerReader.Item("Splash").ToString
                lblOStrakes.Text = outerReader.Item("Strakes").ToString
                'lblStrbTrans.Text = outerReader.Item("StrbTrans").ToString
                lblComments.Text = outerReader.Item("Comments").ToString
                lblBlack.Text = outerReader.Item("Black").ToString
                lblOLength.Text = Left(outerReader.Item("TubeModel"), 2).ToString
            End While

            Try
                PredictOuterTag()
            Catch ex As Exception
            End Try

            Try
                PredictOuterChinesandFoils()
            Catch
            End Try


        ElseIf section Like "C*" Or section Like "c*" Then
            lblTubeType.Text = "CENTER"
            centerReader = cmd1.ExecuteReader()
            centers.Visible = True
            outers.Visible = False

            While centerReader.Read
                lblModel.Text = centerReader.Item("ItemNo").ToString
                lblShape.Text = centerReader.Item("Center").ToString
                lblCStrakes.Text = centerReader.Item("Strakes").ToString
                lblStorage.Text = centerReader.Item("Storage").ToString
                lblCLength.Text = centerReader.Item("Length").ToString
                lblTenWide.Text = centerReader.Item("TenWide").ToString
                lblCBracket.Text = centerReader.Item("Bracket").ToString
                lblCDrawingNo.Text = centerReader.Item("DrawingNo").ToString
                lblCFuel.Text = centerReader.Item("Fuel").ToString
                lblTubeUpg.Text = centerReader.Item("TubeUpg").ToString
                lblUpsweep.Text = centerReader.Item("Upsweep_SldTrans").ToString

            End While

            'Try
            PredictCenterTag()
                PredictStorage()
                PredictFuel()
            'Completed center tubes are counted as the chines are already installed. There are no M tags for indiv chines or foils.
            'PredictCenterChines()

            'Catch ex As Exception

            'End Try
        End If

        conn.Close()

        tbTubeInfo.Text = ""
        tbTubeInfo.Focus()

    End Sub
    Function PredictOuterTag() As String

        Dim ioFlag As Integer = 0
        Dim x1Flag As Integer = 0
        Dim x2Flag As Integer = 0
        Dim valueFlag As Integer = 0
        Dim thickness As String = "0"
        Dim length As String = lblOLength.Text

        If lblModel.Text Like "*IO*" Then
            ioFlag = 1
        End If

        If lblModel.Text Like "*X1" Then
            x1Flag = 1
        End If

        If lblModel.Text Like "*X2" Then
            x2Flag = 1
        End If

        If lblModel.Text Like "*V*" Then
            valueFlag = 1
        End If

        If lblStyle.Text Like "*.125" Then
            thickness = "0.125"
        ElseIf lblStyle.Text Like "*.100" Then
            thickness = "0.1"
        End If

        'MesgBox(ioFlag & x1Flag & x2Flag & valueFlag & thickness)

        Dim dvOutertags As DataView = tagData.DefaultView

        'x2s don't count the transom in the tube length so subract 2 from the boat model numbers.
        If length = "27" Or length = "30" Then
            length = length - 2
        End If

        'MesgBox(length & lblDiameter.Text & valueFlag & x1Flag & x2Flag & thickness)

        dvOutertags.RowFilter = "Type = 'PS' AND Length = " & length & " AND Diameter = " & lblDiameter.Text & "AND Value = " & valueFlag & "AND X1 = " & x1Flag & "AND X2 = " & x2Flag & "AND Thickness =" & thickness '& "AND IO = " & ioFlag '

        'MesgBox(dvOutertags.Count)

        If dvOutertags.Count = 0 Or thickness Is Nothing Then
            dvOutertags.RowFilter = "Type = 'PS' AND Length = " & length & " AND Diameter = " & lblDiameter.Text & "AND Value = " & valueFlag & "AND X1 = " & x1Flag & "AND X2 = " & x2Flag '& "AND Thickness =" & thickness '& "AND IO = " & ioFlag '        End If
        End If

        'MesgBox(dvOutertags.Count)

        gvTagPredictions.DataSource = dvOutertags
        gvTagPredictions.DataBind()


        Return False
    End Function
    Function PredictOuterChinesandFoils() As String
        'MesgBox("Predict Chines and Foils")

        Dim outerStrakes As String = lblOStrakes.Text
        Dim tubeLength As String = lblOLength.Text
        Dim prodno As String = lblProdNo.Text
        Dim style As String = lblStyle.Text

        'MesgBox(prodno)
        Try
            Dim dvTubePriority As DataView = tubePriority.DefaultView
            dvTubePriority.RowFilter = "ProdNo = '" & prodno & "'"

            'MesgBox(dvTubePriority.Count)

            If dvTubePriority.Count > 0 Then
                Dim perf As String = dvTubePriority(0)(1).ToString
                Dim IO As String = dvTubePriority(0)(2).ToString

                Dim stockType As String = ""
                Dim outsideChineOrFoil As String = ""
                Dim insideChineOrFoil As String = ""
                Dim insideStock As String = ""
                Dim outsideStock As String = ""

                If outerStrakes.Length > 0 Then
                    Try
                        Dim dvOuterChines As DataView = ChineFoilConfigGrid.DefaultView
                        dvOuterChines.RowFilter = "TubeLengthJustFt = '" & tubeLength & "' AND Perf = '" & perf & "' AND IO = '" & IO & "'"

                        If dvOuterChines.Count > 0 Then

                            Dim OuterInside As String = dvOuterChines(0)(9).ToString + " " + dvOuterChines(0)(10).ToString
                            Dim OuterOutside As String = dvOuterChines(0)(11).ToString + " " + dvOuterChines(0)(12).ToString

                            If dvOuterChines(0)(10).ToString Like "*chine*" Then
                                insideChineOrFoil = "Chine"
                            ElseIf dvOuterChines(0)(10).ToString Like "*foil*" Then
                                insideChineOrFoil = "Foil"
                            End If

                            If dvOuterChines(0)(12).ToString Like "*chine*" Then
                                outsideChineOrFoil = "Chine"
                            ElseIf dvOuterChines(0)(12).ToString Like "*foil*" Then
                                outsideChineOrFoil = "Foil"
                            End If

                            If outerStrakes Like "SW*" Then

                                stockType = "Sealed"
                            Else

                                stockType = "Open"
                            End If

                            'get Inside Stock Length

                            Try
                                Dim OuterInsideLength As Integer = Int16.Parse(dvOuterChines(0)(9).ToString())
                                Dim dvInsideLength As DataView = ChineFoilStockSizes.DefaultView
                                dvInsideLength.RowFilter = "StockLength >= '" & OuterInsideLength & "' AND Type = '" & stockType & "' AND ChineOrFoil = '" & insideChineOrFoil & "'"
                                insideStock = dvInsideLength(0)(1).ToString + " " + stockType + " " + insideChineOrFoil

                                'MesgBox(insideStock)
                                lblInsideStockLength.Text = dvInsideLength(0)(1).ToString
                                lblInsideStockType.Text = stockType
                                lblInsideStockCorF.Text = insideChineOrFoil

                            Catch ex As Exception

                            End Try

                            Try
                                If style = "2" Then

                                    Dim OuterOutsideLength As Integer = Int16.Parse(Left(dvOuterChines(0)(11).ToString(), 3))

                                    Dim dvStockSizes As DataView = ChineFoilStockSizes.DefaultView
                                    dvStockSizes.RowFilter = "StockLength >= '" & OuterOutsideLength & "' AND Type = '" & stockType & "' AND ChineOrFoil = '" & outsideChineOrFoil & "'"
                                    outsideStock = dvStockSizes(0)(1).ToString + " " + stockType + " " + outsideChineOrFoil

                                    'MesgBox(outsideStock)
                                    lblOutsideStockLength.Text = dvStockSizes(0)(1).ToString
                                    lblOutsideStockType.Text = stockType
                                    lblOutsideStockCorF.Text = insideChineOrFoil
                                End If
                            Catch ex As Exception

                            End Try

                            Try
                                Dim dvChines As DataView = tagData.DefaultView
                                dvChines.RowFilter = "(Type = '" & lblInsideStockCorF.Text & "' OR Type = '" & lblOutsideStockCorF.Text & "') AND (CorFType = '" & lblInsideStockType.Text.ToUpper & "' OR CorFType = '" & lblOutsideStockType.Text.ToUpper & "') And (Convert(Length, System.String) = '" & lblInsideStockLength.Text & "' OR Convert(Length, System.String) = '" & lblOutsideStockLength.Text & "')"
                                gvChines.DataSource = dvChines
                                gvChines.DataBind()

                            Catch ex As Exception

                            End Try
                        End If
                    Catch
                    End Try

                End If
            End If
        Catch
        End Try

        Return False
    End Function
    Function PredictCenterTag() As String

        Dim ioFlag As Integer = 0
        Dim valueFlag As Integer = 0
        Dim length As String = lblCLength.Text
        Dim RTflag As Integer = 0
        Dim expressFlag As Integer = 0

        If lblModel.Text Like "*IO*" Then
            ioFlag = 1
        End If

        If lblModel.Text Like "*RT*" Then
            RTflag = 1
        End If

        If lblModel.Text Like "*V*" Then
            valueFlag = 1
        End If

        If lblShape.Text = "EXPRESS" Then
            expressFlag = 1
        End If

        'MesgBox(ioFlag & x1Flag & x2Flag & valueFlag & thickness)
        'MesgBox(ioFlag)

        'Try
        Dim dvCtrTubes As DataView = tagData.DefaultView

            'x2s don't count the transon in the tube length so subract 2 from the boat model numbers.
            If length = "27" Or length = "30" Then
                length = length - 2
            End If

            'MesgBox(length & lblDiameter.Text & valueFlag & x1Flag & x2Flag & thickness)
            If RTflag = 0 And expressFlag = 0 Then
                dvCtrTubes.RowFilter = "Type = 'CTR' AND Length = " & length & "AND IO = " & ioFlag  '& " AND Diameter = " & lblDiameter.Text '& "AND Value = " & valueFlag ' & "AND X1 = " & x1Flag & "AND X2 = " & x2Flag & "AND Thickness =" & thickness '& "AND IO = " & ioFlag '
            ElseIf RTflag = 1 Then
                dvCtrTubes.RowFilter = "Type = 'RT' AND Length = " & length
            ElseIf expressFlag = 1 Then

                If lblCStrakes.Text Like "*SW*" Then
                    dvCtrTubes.RowFilter = "Type = 'EXP' and CorFType = 'SEALED'"
                Else
                    dvCtrTubes.RowFilter = "Type = 'EXP' and CorFType = 'OPEN'"
                End If
            End If

            gvCtrTagPredictions.DataSource = dvCtrTubes
            gvCtrTagPredictions.DataBind()

        'Catch
        'End Try

        Return False
    End Function
    Function PredictStorage() As String

        Try
            Dim dvStorage As DataView = tagData.DefaultView
            If lblStorage.Text = "STOR" Then
                dvStorage.RowFilter = "Type = 'STOR'"
            Else
                dvStorage.RowFilter = "Type='NO'"
            End If

            gvStorage.DataSource = dvStorage
            gvStorage.DataBind()
        Catch
        End Try
        Return False

    End Function
    Function PredictFuel() As String
        Try
            Dim dvFuel As DataView = tagData.DefaultView

            If lblCFuel.Text = "FUEL" Then
                dvFuel.RowFilter = "Type = 'FUEL'"
            Else
                dvFuel.RowFilter = "Type = 'NOPE'"
            End If

            gvFuel.DataSource = dvFuel
            gvFuel.DataBind()
        Catch
        End Try
        Return False
    End Function
    Function PredictCenterChines() As String
        'MesgBox("Predict Chines and Foils")

        Dim centerStrakes As String = lblCStrakes.Text
        Dim tubeLength As String = lblCLength.Text
        Dim prodno As String = lblProdNo.Text
        'Dim style As String = lblStyle.Text

        'MesgBox(prodno)
        Try
            Dim dvTubePriority2 As DataView = tubePriority.DefaultView
            dvTubePriority2.RowFilter = "ProdNo = '" & prodno & "'"

            'MesgBox(dvTubePriority2.Count)

            If dvTubePriority2.Count > 0 Then
                Dim perf As String = dvTubePriority2(0)(1).ToString
                Dim IO As String = dvTubePriority2(0)(2).ToString
                Dim stockType As String

                If centerStrakes.Length > 0 Then
                    Try
                        Dim dvChineConfigs As DataView = ChineFoilConfigGrid.DefaultView
                        dvChineConfigs.RowFilter = "TubeLengthJustFt = '" & tubeLength & "' AND Perf = '" & perf & "' AND IO = '" & IO & "'"

                        If dvChineConfigs.Count > 0 Then

                            Dim CtrChineLength As String = dvChineConfigs(0)(8).ToString
                            If centerStrakes Like "SW*" Then
                                stockType = "Sealed"
                            Else
                                stockType = "Open"
                            End If

                            'get Ctr Stock Length

                            Try
                                Dim CtrStockLength As Integer ' = Int16.Parse(CtrChineLength)
                                Dim dvCtrChineSizes As DataView = ChineFoilStockSizes.DefaultView
                                dvCtrChineSizes.RowFilter = "StockLength >= '" & CtrChineLength & "' AND Type = '" & stockType & "' AND ChineOrFoil = 'Chine'"
                                CtrStockLength = dvCtrChineSizes(0)(1).ToString

                                'MesgBox(centerStock)

                                lblCtrStockLength.Text = CtrStockLength
                                lblCtrStockType.Text = stockType.ToUpper()
                                lblCtrStockCorF.Text = "Chines"


                            Catch ex As Exception

                            End Try

                            Try

                                Dim dvCtrChines As DataView = tagData.DefaultView
                                dvCtrChines.RowFilter = "Type = 'CHINE' And Length = '" & lblCtrStockLength.Text & "' And CorFType = '" & lblCtrStockType.Text & "'"


                                gvChines.DataSource = dvCtrChines
                                gvChines.DataBind()

                            Catch ex As Exception

                            End Try


                        End If
                    Catch
                    End Try

                End If
            End If
        Catch
        End Try



        Return False
    End Function
    Private Sub gvTagPredictions_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvTagPredictions.RowDataBound
        Dim prod As String = Trim(lblProdNo.Text)
        PopulateTagLog(prod)

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim TodaysDate As Date = Date.Now
            Dim btnTag As Button = DirectCast(e.Row.FindControl("btnTag"), Button)
            btnTag.Attributes.Add("class", "btn btn-lg btn-outline-success p-2")

            Dim dvTagLogTags As DataView = tagLog.DefaultView
            'dvTagLogTags.RowFilter = "ProdNo = '" & prod & "'  And TagNo = '" & e.Row.DataItem("TagNo") & "'"
            dvTagLogTags.RowFilter = "TagNo = '" & e.Row.DataItem("TagNo") & "'"

            If dvTagLogTags.Count > 0 Then
                btnTag.Attributes.Add("class", "btn btn-lg btn-success p-2")
            End If

        End If
    End Sub
    Private Sub gvStorage_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvStorage.RowDataBound
        Dim prod As String = Trim(lblProdNo.Text)
        PopulateTagLog(prod)

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim TodaysDate As Date = Date.Now
            Dim btnTag As Button = DirectCast(e.Row.FindControl("btnTag"), Button)
            btnTag.Attributes.Add("class", "btn btn-lg btn-outline-success p-2")

            Dim dvTagLogStorage As DataView = tagLog.DefaultView
            'dvTagLogTags.RowFilter = "ProdNo = '" & prod & "'  And TagNo = '" & e.Row.DataItem("TagNo") & "'"
            dvTagLogStorage.RowFilter = "TagNo = '" & e.Row.DataItem("TagNo") & "'"

            If dvTagLogStorage.Count > 0 Then
                btnTag.Attributes.Add("class", "btn btn-lg btn-success p-2")
            End If

        End If
    End Sub
    Private Sub gvFuel_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvFuel.RowDataBound
        Dim prod As String = Trim(lblProdNo.Text)
        PopulateTagLog(prod)

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim TodaysDate As Date = Date.Now
            Dim btnTag As Button = DirectCast(e.Row.FindControl("btnTag"), Button)
            btnTag.Attributes.Add("class", "btn btn-lg btn-outline-success p-2")

            Dim dvTagLogFuel As DataView = tagLog.DefaultView
            'dvTagLogTags.RowFilter = "ProdNo = '" & prod & "'  And TagNo = '" & e.Row.DataItem("TagNo") & "'"
            dvTagLogFuel.RowFilter = "TagNo = '" & e.Row.DataItem("TagNo") & "'"

            If dvTagLogFuel.Count > 0 Then
                btnTag.Attributes.Add("class", "btn btn-lg btn-success p-2")
            End If

        End If
    End Sub
    Private Sub gvChines_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvChines.RowDataBound
        Dim prod As String = Trim(lblProdNo.Text)
        PopulateTagLog(prod)

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim TodaysDate As Date = Date.Now
            Dim btnTag As Button = DirectCast(e.Row.FindControl("btnTag"), Button)
            btnTag.Attributes.Add("class", "btn btn-lg btn-outline-success p-2")

            Dim dvTagLogChines As DataView = tagLog.DefaultView
            'dvTagLogTags.RowFilter = "ProdNo = '" & prod & "'  And TagNo = '" & e.Row.DataItem("TagNo") & "'"
            dvTagLogChines.RowFilter = "TagNo = '" & e.Row.DataItem("TagNo") & "'"

            If dvTagLogChines.Count > 0 Then
                btnTag.Attributes.Add("class", "btn btn-lg btn-success p-2")
            End If

        End If
    End Sub
    Private Sub gvTagPredictions_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvTagPredictions.RowCommand
        If e.CommandName = "selecttubetags" Then

            Dim prod As String = lblProdNo.Text
            Dim tube As String = lblPSC.Text
            Dim tag As String = e.CommandArgument
            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.CommandType = CommandType.Text
            cmd.Connection = conn
            cmd1.Connection = conn

            cmd.Parameters.AddWithValue("@ProdNo", prod)
            cmd.Parameters.AddWithValue("@Tube", tube)
            cmd.Parameters.AddWithValue("@Tag", tag)
            cmd.Parameters.AddWithValue("@LogDate", ThisDay)

            cmd1.Parameters.AddWithValue("@ProdNo1", prod)
            cmd1.Parameters.AddWithValue("@Tube1", tube)
            cmd1.Parameters.AddWithValue("@Tag1", tag)
            cmd1.Parameters.AddWithValue("@LogDate1", ThisDay)

            cmd.CommandText = "Insert Into Tubes_PhyInvTagLog (ProdNo, Tube, TagNo, LogDate) VALUES (@ProdNo, @Tube, @Tag, @LogDate)"
            cmd1.CommandText = "Delete From Tubes_PhyInvTagLog Where ProdNo = @ProdNo1 and TagNo = @Tag1  and Tube = @Tube1 and LogDate = @LogDate1"

            conn.Open()
            Try
                cmd.ExecuteNonQuery()
            Catch
                cmd1.ExecuteNonQuery() 'if insert fails, it already exists so delete it. Basic Toggle.
            End Try
            conn.Close()

            If tube = "CTR" Then
                tbTubeInfo.Text = prod & "-C"
                tbTubeInfo_TextChanged(sender, e)
            ElseIf tube = "PORT" Then
                tbTubeInfo.Text = prod & "-P"
                tbTubeInfo_TextChanged(sender, e)
            ElseIf tube = "STRB" Then
                tbTubeInfo.Text = prod & "-S"
                tbTubeInfo_TextChanged(sender, e)
            End If
        End If
    End Sub
    Private Sub gvChines_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvChines.RowCommand
        If e.CommandName = "selecttubetags" Then

            Dim prod As String = lblProdNo.Text
            Dim tube As String = lblPSC.Text
            Dim tag As String = e.CommandArgument
            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.CommandType = CommandType.Text
            cmd.Connection = conn
            cmd1.Connection = conn

            cmd.Parameters.AddWithValue("@ProdNo", prod)
            cmd.Parameters.AddWithValue("@Tube", tube)
            cmd.Parameters.AddWithValue("@Tag", tag)
            cmd.Parameters.AddWithValue("@LogDate", ThisDay)

            cmd1.Parameters.AddWithValue("@ProdNo1", prod)
            cmd1.Parameters.AddWithValue("@Tube1", tube)
            cmd1.Parameters.AddWithValue("@Tag1", tag)
            cmd1.Parameters.AddWithValue("@LogDate1", ThisDay)

            cmd.CommandText = "Insert Into Tubes_PhyInvTagLog (ProdNo, Tube, TagNo, LogDate) VALUES (@ProdNo, @Tube, @Tag, @LogDate)"
            cmd1.CommandText = "Delete From Tubes_PhyInvTagLog Where ProdNo = @ProdNo1 and TagNo = @Tag1  and Tube = @Tube1 and LogDate = @LogDate1"

            conn.Open()
            Try
                cmd.ExecuteNonQuery()
            Catch
                cmd1.ExecuteNonQuery() 'if insert fails, it already exists so delete it. Basic Toggle.
            End Try

            conn.Close()

            If tube = "CTR" Then
                tbTubeInfo.Text = prod & "-C"
                tbTubeInfo_TextChanged(sender, e)
            ElseIf tube = "PORT" Then
                tbTubeInfo.Text = prod & "-P"
                tbTubeInfo_TextChanged(sender, e)
            ElseIf tube = "STRB" Then
                tbTubeInfo.Text = prod & "-S"
                tbTubeInfo_TextChanged(sender, e)

            End If

        End If

    End Sub
    Private Sub gvFuel_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvFuel.RowCommand
        If e.CommandName = "selecttubetags" Then

            Dim prod As String = lblProdNo.Text
            Dim tube As String = lblPSC.Text
            Dim tag As String = e.CommandArgument
            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.CommandType = CommandType.Text
            cmd.Connection = conn
            cmd1.Connection = conn

            cmd.Parameters.AddWithValue("@ProdNo", prod)
            cmd.Parameters.AddWithValue("@Tube", tube)
            cmd.Parameters.AddWithValue("@Tag", tag)
            cmd.Parameters.AddWithValue("@LogDate", ThisDay)

            cmd1.Parameters.AddWithValue("@ProdNo1", prod)
            cmd1.Parameters.AddWithValue("@Tube1", tube)
            cmd1.Parameters.AddWithValue("@Tag1", tag)
            cmd1.Parameters.AddWithValue("@LogDate1", ThisDay)

            cmd.CommandText = "Insert Into Tubes_PhyInvTagLog (ProdNo, Tube, TagNo, LogDate) VALUES (@ProdNo, @Tube, @Tag, @LogDate)"
            cmd1.CommandText = "Delete From Tubes_PhyInvTagLog Where ProdNo = @ProdNo1 and TagNo = @Tag1  and Tube = @Tube1 and LogDate = @LogDate1"
            conn.Open()

            Try
                cmd.ExecuteNonQuery()
            Catch
                cmd1.ExecuteNonQuery() 'if insert fails, it already exists so delete it. Basic Toggle.
            End Try

            conn.Close()

            If tube = "CTR" Then
                tbTubeInfo.Text = prod & "-C"
                tbTubeInfo_TextChanged(sender, e)
            ElseIf tube = "PORT" Then
                tbTubeInfo.Text = prod & "-P"
                tbTubeInfo_TextChanged(sender, e)
            ElseIf tube = "STRB" Then
                tbTubeInfo.Text = prod & "-S"
                tbTubeInfo_TextChanged(sender, e)

            End If
        End If
    End Sub
    Private Sub gvStorage_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvStorage.RowCommand
        If e.CommandName = "selecttubetags" Then

            Dim prod As String = lblProdNo.Text
            Dim tube As String = lblPSC.Text
            Dim tag As String = e.CommandArgument
            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            conn.ConnectionString = connstr
            cmd.CommandType = CommandType.Text
            cmd.Connection = conn
            cmd1.Connection = conn

            cmd.Parameters.AddWithValue("@ProdNo", prod)
            cmd.Parameters.AddWithValue("@Tube", tube)
            cmd.Parameters.AddWithValue("@Tag", tag)
            cmd.Parameters.AddWithValue("@LogDate", ThisDay)

            cmd1.Parameters.AddWithValue("@ProdNo1", prod)
            cmd1.Parameters.AddWithValue("@Tube1", tube)
            cmd1.Parameters.AddWithValue("@Tag1", tag)
            cmd1.Parameters.AddWithValue("@LogDate1", ThisDay)

            cmd.CommandText = "Insert Into Tubes_PhyInvTagLog (ProdNo, Tube, TagNo, LogDate) VALUES (@ProdNo, @Tube, @Tag, @LogDate)"
            cmd1.CommandText = "Delete From Tubes_PhyInvTagLog Where ProdNo = @ProdNo1 and TagNo = @Tag1  and Tube = @Tube1 and LogDate = @LogDate1"

            conn.Open()
            Try
                cmd.ExecuteNonQuery()
            Catch
                cmd1.ExecuteNonQuery() 'if insert fails, it already exists so delete it. Basic Toggle.
            End Try
            conn.Close()


            If tube = "CTR" Then
                tbTubeInfo.Text = prod & "-C"
                tbTubeInfo_TextChanged(sender, e)
            ElseIf tube = "PORT" Then
                tbTubeInfo.Text = prod & "-P"
                tbTubeInfo_TextChanged(sender, e)
            ElseIf tube = "STRB" Then
                tbTubeInfo.Text = prod & "-S"
                tbTubeInfo_TextChanged(sender, e)
            End If
        End If
    End Sub
    Private Sub gvCtrTagPredictions_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvCtrTagPredictions.RowCommand
        If e.CommandName = "selecttubetags" Then

            Dim prod As String = lblProdNo.Text
            Dim tube As String = lblPSC.Text
            Dim tag As String = e.CommandArgument
            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.CommandType = CommandType.Text
            cmd.Connection = conn
            cmd1.Connection = conn

            cmd.Parameters.AddWithValue("@ProdNo", prod)
            cmd.Parameters.AddWithValue("@Tube", tube)
            cmd.Parameters.AddWithValue("@Tag", tag)
            cmd.Parameters.AddWithValue("@LogDate", ThisDay)

            cmd1.Parameters.AddWithValue("@ProdNo1", prod)
            cmd1.Parameters.AddWithValue("@Tube1", tube)
            cmd1.Parameters.AddWithValue("@Tag1", tag)
            cmd1.Parameters.AddWithValue("@LogDate1", ThisDay)

            cmd.CommandText = "Insert Into Tubes_PhyInvTagLog (ProdNo, Tube, TagNo, LogDate) VALUES (@ProdNo, @Tube, @Tag, @LogDate)"
            cmd1.CommandText = "Delete From Tubes_PhyInvTagLog Where ProdNo = @ProdNo1 and TagNo = @Tag1 and Tube = @Tube1 and LogDate = @LogDate1"
            conn.Open()
            Try
                cmd.ExecuteNonQuery()
            Catch
                cmd1.ExecuteNonQuery() 'if insert fails, it already exists so delete it. Basic Toggle.
            End Try
            conn.Close()

            If tube = "CTR" Then
                tbTubeInfo.Text = prod & "-C"
                tbTubeInfo_TextChanged(sender, e)
            ElseIf tube = "PORT" Then
                tbTubeInfo.Text = prod & "-P"
                tbTubeInfo_TextChanged(sender, e)
            ElseIf tube = "STRB" Then
                tbTubeInfo.Text = prod & "-S"
                tbTubeInfo_TextChanged(sender, e)
            End If


        End If
    End Sub
    Private Sub gvCtrTagPredictions_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCtrTagPredictions.RowDataBound
        Dim prod As String = Trim(lblProdNo.Text)
        PopulateTagLog(prod)

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim TodaysDate As Date = Date.Now
            Dim btnTag As Button = DirectCast(e.Row.FindControl("btnTag"), Button)
            btnTag.Attributes.Add("class", "btn btn-lg btn-outline-success p-2")

            Dim dvTagLogCtrTags As DataView = tagLog.DefaultView
            'dvTagLogTags.RowFilter = "ProdNo = '" & prod & "'  And TagNo = '" & e.Row.DataItem("TagNo") & "'"
            dvTagLogCtrTags.RowFilter = "TagNo = '" & e.Row.DataItem("TagNo") & "'"

            If dvTagLogCtrTags.Count > 0 Then
                btnTag.Attributes.Add("class", "btn btn-lg btn-success p-2")
            End If

        End If
    End Sub

    'Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
    '    'tbTubeInfo.Text = ""
    '    'gvTagPredictions.DataBind()
    '    'lblProdNo.Text = ""
    '    'lblTubeType.Text = ""
    '    'lblModel.Text = ""

    'End Sub
End Class
