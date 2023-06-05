Imports System.Data
Imports System.Data.SqlClient
Imports MySql.Data.MySqlClient

Partial Class OverviewProd
    Inherits System.Web.UI.Page

    Public greenlights As New DataTable
    Public liveboats As New DataTable
    Public railRacks As New DataTable
    Public offline As New DataTable
    Public materiallocationswgls As New DataTable
    Public materiallocations As New DataTable
    Public rgas As New DataTable
    Public bos As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub OverviewProd_Load(sender As Object, e As EventArgs) Handles Me.Load

        PopulateDataTables()
        GetGreenedMaterialsToday()
        GetStock()
        GetCompleteByWS()
        GetReadyByWS()
        GetSouthStats()
        GetPastDue()
        GetRails()
        GetHealth()
        GetWip()
        GetFurnStats()
        GetVeadaInfo()

        'gvTest.DataSource = greenlights
        'gvTest.DataBind()

    End Sub

    Public Function PopulateDataTables() As String

        Dim sqldataadapter As New SqlDataAdapter
        Dim sqldataadapter1 As New SqlDataAdapter
        Dim sqldataadapter2 As New SqlDataAdapter
        Dim sqldataadapter3 As New SqlDataAdapter
        Dim sqldataadapter4 As New SqlDataAdapter
        Dim sqldataadapter5 As New SqlDataAdapter

        Dim mysqldataadapter As New MySqlDataAdapter
        Dim mysqldataadapter1 As New MySqlDataAdapter

        Dim conn As New SqlConnection()
        Dim conn2 As New MySqlConnection

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim connstr2 As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"
        conn2.ConnectionString = connstr2

        conn.Open()
        sqldataadapter.SelectCommand = New SqlCommand("SELECT t2.ProdNo, t2.FurnitureStatus,Convert(date,t2.FurniturePrepLastUpdated) as FurniturePrepLastUpdated,t2.FiberglassStatus,Convert(date,t2.FiberglassLastUpdated) as FiberglassLastUpdated,t2.CoversStatus,Convert(date,t2.CoversLastUpdated) as CoversLastUpdated,t2.RailsStatus,t2.GaugeStatus, t2.HarnessStatus, Convert(date,t2.RailsLastUpdated) as RailsLastUpdated,t2.TubesStatus,Convert(date,t2.TubesLastUpdated) as TubesLastUpdated,t2.FramesInstalledStatus,Convert(date,t2.FramesInstalled) as FramesInstalled,t2.FloorsInstalledStatus,Convert(date,t2.FloorsInstalled) as FloorsInstalled,t2.RailsInstalledStatus,Convert(date,t2.RailsInstalled) as RailsInstalled,t2.FurnitureInstalledStatus,Convert(date,t2.FurnitureInstalled) as FurnitureInstalled,t2.HelmInstalledStatus,Convert(date,t2.HelmInstalled) as HelmInstalled,t2.CleaningStatus,Convert(date,t2.Cleaning) as Cleaning,t2.FinalInspectionStatus,Convert(date,t2.FinalInspection) as FinalInspection,t2.ShrinkwrapStatus,Convert(date,t2.ShrinkWrap) as ShrinkWrap,t2.WavetamerStatus,Convert(date,t2.WaveTamerInstalled) as WaveTamer, t2.SharkhideStatus,Convert(date,t2.SharkhideInstalled) as Sharkhide, t2.CompleteStatus,Convert(date,t2.Complete) as Complete,t2.IsBoatOffline,t2.CentertubeStatus,Convert(date,t2.Centertube) as Centertube,t2.HelmKittingStatus,Convert(date,t2.HelmKitting) as HelmKitting,t2.HelmBuildStatus,Convert(date,t2.HelmBuild) as HelmBuild, t2.RiggingStatus, Convert(date, t2.Rigging) as Rigging, t2.ItemNo,t2.SONo,t2.DueDate,t2.PanelColor,t2.SharkhideNeeded,t2.WavetamerNeeded,t2.CentertubeNeeded,t2.IsCustom,t2.IsRedTagged,t2.BuildLoc,t2.GaugeStatus,Convert(date,t2.GaugeLastUpdated) as GaugeLastUpdated,t2.HarnessStatus,Convert(date,t2.HarnessLastUpdated) as HarnessLastUpdated,t2.Kitting1Status,Convert(date,t2.Kitting1) as Kitting1,t2.Kitting2Status,Convert(date,t2.Kitting2) as Kitting2,t2.Kitting3Status,Convert(date,t2.Kitting3) as Kitting3,t2.Kitting4Status,Convert(date,t2.Kitting4) as Kitting4,t2.GatesStatus,Convert(date,t2.Gates) as Gates,t2.BiminiStatus,Convert(date,t2.Bimini) as Bimini,t2.QFrontNeeded,t2.QFrontStatus,Convert(date,t2.QFront) as QFront,t2.ArchTowerNeeded,t2.ArchTowerStatus,Convert(date,t2.ArchTower) as ArchTower,t2.SBNeeded,t2.SwingbackStatus,Convert(date,t2.Swingback) as Swingback,t2.FurnHwrStatus,Convert(date,t2.FurnHwr) as FurnHwr,t2.BiminiRcvdStatus,Convert(date,t2.BiminiRcvd) as BiminiRcvd,t2.NeedsLadder,t2.LadderStatus,Convert(date,t2.Ladder) as Ladder,t2.TenWidePort,t2.TenWideStrb,t2.TrimStatus,Convert(date,t2.Trim) as Trim,t2.PhotosStatus,Convert(date,t2.Photos) as Photos,t2.HasTubeDamage,t2.FiberglassInspStatus,Convert(date,t2.FiberglassInsp) as FiberglassInsp,t2.IsDeckInside,Convert(date,t2.DeckLocModified) as DeckLocModified,t2.FurnHwrDelStatus,Convert(date,t2.FurnHwrDel) as FurnHwrDel From BML_POPREPORTING_GREENLIGHTS t2 Where ProdNo > 2000000  Order By t2.ProdNo", conn)
        sqldataadapter.Fill(greenlights)

        sqldataadapter1.SelectCommand = New SqlCommand("Select t1.*, t2.FurnitureStatus, t2.FiberglassStatus, t2.CoversStatus, t2.RailsStatus, t2.TubesStatus, t2.CentertubeStatus, t2.CentertubeNeeded, t2.GaugeStatus, t2.HarnessStatus, t2.FramesInstalledStatus, BuildLoc, Requested, HasAllRails, PF_Received, PR_Received, SF_Received, SR_Received, PM_Received, SM_Received, T_Received From Rails_KittingLocations t1 left join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Left Join Rails_Tracking t4 on t1.ProdNo = t4.ProdNo", conn)
        sqldataadapter1.Fill(railRacks)

        sqldataadapter2.SelectCommand = New SqlCommand("Select Distinct t1.ProdNo, t2.BuildLoc From BML_POPREPORTING_OFFLINE t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo where CompleteStatus < 2 and Cleared = 0 AND OfflineNote <> ''", conn)
        sqldataadapter2.Fill(offline)

        sqldataadapter3.SelectCommand = New SqlCommand("Select Distinct(t1.ProdNo), t1.Usable, t1.InUse, t2.FurnitureStatus, t2.CompleteStatus  from Material_Locations t1 Left join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = Substring(t2.ProdNo,3,5) Where InUse = 1 and Usable = 1 and CompleteStatus < 2", conn)
        sqldataadapter3.Fill(materiallocationswgls)

        sqldataadapter4.SelectCommand = New SqlCommand("Select * from Material_Locations", conn)
        sqldataadapter4.Fill(materiallocations)

        sqldataadapter5.SelectCommand = New SqlCommand("SELECT t2.ProdNo, t2.FurnitureStatus,Convert(date,t2.FurniturePrepLastUpdated) as FurniturePrepLastUpdated,t2.FiberglassStatus,Convert(date,t2.FiberglassLastUpdated) as FiberglassLastUpdated,t2.CoversStatus,Convert(date,t2.CoversLastUpdated) as CoversLastUpdated,t2.RailsStatus,Convert(date,t2.RailsLastUpdated) as RailsLastUpdated,t2.TubesStatus,Convert(date,t2.TubesLastUpdated) as TubesLastUpdated,t2.FramesInstalledStatus,Convert(date,t2.FramesInstalled) as FramesInstalled,t2.FloorsInstalledStatus,Convert(date,t2.FloorsInstalled) as FloorsInstalled,t2.RailsInstalledStatus,Convert(date,t2.RailsInstalled) as RailsInstalled,t2.FurnitureInstalledStatus,Convert(date,t2.FurnitureInstalled) as FurnitureInstalled,t2.HelmInstalledStatus,Convert(date,t2.HelmInstalled) as HelmInstalled,t2.CleaningStatus,Convert(date,t2.Cleaning) as Cleaning,t2.FinalInspectionStatus,Convert(date,t2.FinalInspection) as FinalInspection,t2.ShrinkwrapStatus,Convert(date,t2.ShrinkWrap) as ShrinkWrap,t2.WavetamerStatus,Convert(date,t2.WaveTamerInstalled) as WaveTamer, t2.SharkhideStatus,Convert(date,t2.SharkhideInstalled) as Sharkhide, t2.CompleteStatus,Convert(date,t2.Complete) as Complete,t2.IsBoatOffline,t2.CentertubeStatus,Convert(date,t2.Centertube) as Centertube,t2.HelmKittingStatus,Convert(date,t2.HelmKitting) as HelmKitting,t2.HelmBuildStatus,Convert(date,t2.HelmBuild) as HelmBuild, t2.RiggingStatus, Convert(date, t2.Rigging) as Rigging, t2.ItemNo,t2.SONo,t2.DueDate,t2.PanelColor,t2.SharkhideNeeded,t2.WavetamerNeeded,t2.CentertubeNeeded,t2.IsCustom,t2.IsRedTagged,t2.BuildLoc,t2.GaugeStatus,Convert(date,t2.GaugeLastUpdated) as GaugeLastUpdated,t2.HarnessStatus,Convert(date,t2.HarnessLastUpdated) as HarnessLastUpdated,t2.Kitting1Status,Convert(date,t2.Kitting1) as Kitting1,t2.Kitting2Status,Convert(date,t2.Kitting2) as Kitting2,t2.Kitting3Status,Convert(date,t2.Kitting3) as Kitting3,t2.Kitting4Status,Convert(date,t2.Kitting4) as Kitting4,t2.GatesStatus,Convert(date,t2.Gates) as Gates,t2.BiminiStatus,Convert(date,t2.Bimini) as Bimini,t2.QFrontNeeded,t2.QFrontStatus,Convert(date,t2.QFront) as QFront,t2.ArchTowerNeeded,t2.ArchTowerStatus,Convert(date,t2.ArchTower) as ArchTower,t2.SBNeeded,t2.SwingbackStatus,Convert(date,t2.Swingback) as Swingback,t2.FurnHwrStatus,Convert(date,t2.FurnHwr) as FurnHwr,t2.BiminiRcvdStatus,Convert(date,t2.BiminiRcvd) as BiminiRcvd,t2.NeedsLadder,t2.LadderStatus,Convert(date,t2.Ladder) as Ladder,t2.TenWidePort,t2.TenWideStrb,t2.TrimStatus,Convert(date,t2.Trim) as Trim,t2.PhotosStatus,Convert(date,t2.Photos) as Photos,t2.HasTubeDamage,t2.FiberglassInspStatus,Convert(date,t2.FiberglassInsp) as FiberglassInsp,t2.IsDeckInside,Convert(date,t2.DeckLocModified) as DeckLocModified,t2.FurnHwrDelStatus,Convert(date,t2.FurnHwrDel) as FurnHwrDel From BML_POPREPORTING t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Order By t2.ProdNo", conn)
        sqldataadapter5.Fill(liveboats)

        conn.Close()

        conn2.Open()

        mysqldataadapter.SelectCommand = New MySqlCommand("Select t1.* from RGAs t1 where BenRcvd is null and RgaNo is not null", conn2)
        mysqldataadapter.Fill(rgas)

        mysqldataadapter.SelectCommand = New MySqlCommand("Select t1.* from Backorders t1 where Cleared = 0", conn2)
        mysqldataadapter.Fill(bos)




        conn2.Close()


        'MesgBox(greenlights.Rows.Count)
        'MesgBox(railRacks.Rows.Count)

        conn.Dispose()
        Return False

    End Function
    Public Function GetGreenedMaterialsToday() As String
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        'Main
        Dim FGreenedM As Int16 = greenlights.Select("BuildLoc = 'M' and FurnitureStatus = '2' and FurniturePrepLastUpdated = '" & ThisDay & "'").Length
        lblFMain.Text = FGreenedM

        Dim FGGreenedM As Int16 = greenlights.Select("BuildLoc = 'M' and FiberglassStatus = '2' and FiberglassLastUpdated = '" & ThisDay & "'").Length
        lblFGMain.Text = FGGreenedM

        Dim CGreenedM As Int16 = greenlights.Select("BuildLoc = 'M' and CoversStatus = '2' and CoversLastUpdated = '" & ThisDay & "'").Length
        lblCMain.Text = CGreenedM

        Dim RGreenedM As Int16 = greenlights.Select("BuildLoc = 'M' and RailsStatus = '2' and RailsLastUpdated = '" & ThisDay & "'").Length
        lblRMain.Text = RGreenedM

        Dim TGreenedM As Int16 = greenlights.Select("BuildLoc = 'M' and TubesStatus = '2' and TubesLastUpdated = '" & ThisDay & "'").Length
        lblTMain.Text = TGreenedM

        Dim CTGreenedM As Int16 = greenlights.Select("BuildLoc = 'M' and CenterTubeStatus = '2' and CenterTube = '" & ThisDay & "'").Length
        lblCTMain.Text = CTGreenedM

        Dim GGreenedM As Int16 = greenlights.Select("BuildLoc = 'M' and GaugeStatus = '2' and GaugeLastUpdated = '" & ThisDay & "'").Length
        lblGMain.Text = GGreenedM

        Dim HGreenedM As Int16 = greenlights.Select("BuildLoc = 'M' and HarnessStatus = '2' and HarnessLastUpdated = '" & ThisDay & "'").Length
        lblHMain.Text = HGreenedM


        'South
        Dim FGreenedS As Int16 = greenlights.Select("BuildLoc = 'S' and FurnitureStatus = '2' and FurniturePrepLastUpdated = '" & ThisDay & "'").Length
        lblFSouth.Text = FGreenedS

        Dim FGGreenedS As Int16 = greenlights.Select("BuildLoc = 'S' and FiberglassStatus = '2' and FiberglassLastUpdated = '" & ThisDay & "'").Length
        lblFGSouth.Text = FGGreenedS

        Dim CGreenedS As Int16 = greenlights.Select("BuildLoc = 'S' and CoversStatus = '2' and CoversLastUpdated = '" & ThisDay & "'").Length
        lblCSouth.Text = CGreenedS

        Dim RGreenedS As Int16 = greenlights.Select("BuildLoc = 'S' and RailsStatus = '2' and RailsLastUpdated = '" & ThisDay & "'").Length
        lblRSouth.Text = RGreenedS

        Dim TGreenedS As Int16 = greenlights.Select("BuildLoc = 'S' and TubesStatus = '2' and TubesLastUpdated = '" & ThisDay & "'").Length
        lblTSouth.Text = TGreenedS

        Dim CTGreenedS As Int16 = greenlights.Select("BuildLoc = 'S' and CenterTubeStatus = '2' and CenterTube = '" & ThisDay & "'").Length
        lblCTSouth.Text = CTGreenedS

        Dim GGreenedS As Int16 = greenlights.Select("BuildLoc = 'S' and GaugeStatus = '2' and GaugeLastUpdated = '" & ThisDay & "'").Length
        lblGSouth.Text = GGreenedS

        Dim HGreenedS As Int16 = greenlights.Select("BuildLoc = 'S' and HarnessStatus = '2' and HarnessLastUpdated = '" & ThisDay & "'").Length
        lblHSouth.Text = HGreenedS

        Dim AGreenS As Int16 = greenlights.Select("ArchTowerStatus = '2' and ArchTower = '" & ThisDay & "'").Length
        lblATTotal.Text = AGreenS

        Dim QFrontFGS As Int16 = greenlights.Select("QFrontStatus = '2' and QFront = '" & ThisDay & "'").Length
        lblQFTotal.Text = QFrontFGS



        'Totals
        lblFTotal.Text = Convert.ToInt32(lblFMain.Text) + Convert.ToInt32(lblFSouth.Text)
        lblFGTotal.Text = Convert.ToInt32(lblFGMain.Text) + Convert.ToInt32(lblFGSouth.Text)
        lblCTotal.Text = Convert.ToInt32(lblCMain.Text) + Convert.ToInt32(lblCSouth.Text)
        lblRTotal.Text = Convert.ToInt32(lblRMain.Text) + Convert.ToInt32(lblRSouth.Text)
        lblTTotal.Text = Convert.ToInt32(lblTMain.Text) + Convert.ToInt32(lblTSouth.Text)
        lblCTTotal.Text = Convert.ToInt32(lblCTMain.Text) + Convert.ToInt32(lblCTSouth.Text)
        lblGTotal.Text = Convert.ToInt32(lblGMain.Text) + Convert.ToInt32(lblGSouth.Text)
        lblHTotal.Text = Convert.ToInt32(lblHMain.Text) + Convert.ToInt32(lblHSouth.Text)



        Return False
    End Function
    Public Function GetStock() As String

        'Main
        Dim FStockM As Int16 = liveboats.Select("BuildLoc = 'M' and FurnitureStatus = 2 and FloorsInstalledStatus < 2 ").Length
        lblFurnStockM.Text = FStockM

        Dim FGStockM As Int16 = liveboats.Select("BuildLoc = 'M' and FiberglassStatus = 2 and FloorsInstalledStatus < 2 ").Length
        lblFGStockM.Text = FGStockM

        Dim CStockM As Int16 = liveboats.Select("BuildLoc = 'M' and CoversStatus = 2 and FloorsInstalledStatus < 2 ").Length
        lblCanvasStockM.Text = CStockM

        Dim RStockM As Int16 = liveboats.Select("BuildLoc = 'M' and RailsStatus = 2 and FloorsInstalledStatus < 2 ").Length
        lblRailsStockM.Text = RStockM

        Dim TStockM As Int16 = liveboats.Select("BuildLoc = 'M' and TubesStatus = 2 and FramesInstalledStatus < 2 ").Length
        lblTubeStockM.Text = TStockM

        Dim CTStockM As Int16 = liveboats.Select("BuildLoc = 'M' and CenterTubeStatus = 2 and FramesInstalledStatus < 2 ").Length
        lblCTStockM.Text = CTStockM

        Dim GStockM As Int16 = liveboats.Select("BuildLoc = 'M' and GaugeStatus = 2 and FloorsInstalledStatus < 2 ").Length
        lblGaugeStockM.Text = GStockM

        Dim HStockM As Int16 = liveboats.Select("BuildLoc = 'M' and HarnessStatus = 2 and FloorsInstalledStatus < 2 ").Length
        lblHarnessStockM.Text = HStockM


        'South

        Dim FStockS As Int16 = liveboats.Select("BuildLoc = 'S' and FurnitureStatus = 2 and RailsInstalledStatus < 2  ").Length
        lblFurnStockS.Text = FStockS

        Dim FGStockS As Int16 = liveboats.Select("BuildLoc = 'S' and FiberglassStatus = 2 and RailsInstalledStatus < 2 ").Length
        lblFGStockS.Text = FGStockS

        Dim CStockS As Int16 = liveboats.Select("BuildLoc = 'S' and CoversStatus = 2 and RailsInstalledStatus < 2 ").Length
        lblCanvasStockS.Text = CStockS

        Dim RStockS As Int16 = liveboats.Select("BuildLoc = 'S' and RailsStatus = 2 and RailsInstalledStatus < 2 ").Length
        lblRailsStockS.Text = RStockS

        Dim TStockS As Int16 = liveboats.Select("BuildLoc = 'S' and TubesStatus = 2 and FramesInstalledStatus < 2 ").Length
        lblTubeStockS.Text = TStockS

        Dim CTStockS As Int16 = liveboats.Select("BuildLoc = 'S' and CenterTubeStatus = 2 and FramesInstalledStatus < 2 ").Length
        lblCTStockS.Text = CTStockS

        Dim GStockS As Int16 = liveboats.Select("BuildLoc = 'S' and GaugeStatus = 2 and RailsInstalledStatus < 2 ").Length
        lblGaugeStockS.Text = GStockS

        Dim HStockS As Int16 = liveboats.Select("BuildLoc = 'S' and HarnessStatus = 2 and RailsInstalledStatus < 2 ").Length
        lblHarnessStockS.Text = HStockS

        Dim AStockS As Int16 = liveboats.Select("BuildLoc = 'S' and ArchTowerStatus = '2'").Length
        lblATStockTotal.Text = AStockS

        Dim QFrontFGStock As Int16 = liveboats.Select("BuildLoc = 'S' and QFrontStatus = '2'").Length
        lblQFrontStockTotal.Text = QFrontFGStock

        'Totals

        lblFurnStockTotal.Text = Convert.ToInt32(lblFurnStockM.Text) + Convert.ToInt32(lblFurnStockS.Text)
        lblFGStockTotal.Text = Convert.ToInt32(lblFGStockM.Text) + Convert.ToInt32(lblFGStockS.Text)
        lblCanvasStockTotal.Text = Convert.ToInt32(lblCanvasStockM.Text) + Convert.ToInt32(lblCanvasStockS.Text)
        lblRailsStockTotal.Text = Convert.ToInt32(lblRailsStockM.Text) + Convert.ToInt32(lblRailsStockS.Text)
        lblTubeStockTotal.Text = Convert.ToInt32(lblTubeStockM.Text) + Convert.ToInt32(lblTubeStockS.Text)
        lblCTStockTotal.Text = Convert.ToInt32(lblCTStockM.Text) + Convert.ToInt32(lblCTStockS.Text)
        lblGaugeStockTotal.Text = Convert.ToInt32(lblGaugeStockM.Text) + Convert.ToInt32(lblGaugeStockS.Text)
        lblHarnessStockTotal.Text = Convert.ToInt32(lblHarnessStockM.Text) + Convert.ToInt32(lblHarnessStockS.Text)

        Return False
    End Function
    Public Function GetCompleteByWS() As String
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        'Main
        Dim FramesMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and FramesInstalledStatus = 2 and FramesInstalled  ='" & ThisDay & "' ").Length
        lblFramesMComplete.Text = FramesMComplete

        Dim FloorsMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and FloorsInstalledStatus = 2 and FloorsInstalled  ='" & ThisDay & "' ").Length
        lblFloorsMComplete.Text = FloorsMComplete

        Dim TrimMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and TrimStatus = 2 and Trim  ='" & ThisDay & "' ").Length
        lblTrimMComplete.Text = TrimMComplete

        Dim RailsMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and RailsInstalledStatus = 2 and RailsInstalled  ='" & ThisDay & "' ").Length
        lblRailsMComplete.Text = RailsMComplete

        Dim FurnMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and FurnitureInstalledStatus = 2 and FurnitureInstalled  ='" & ThisDay & "' ").Length
        lblFurnitureMComplete.Text = FurnMComplete

        Dim HelmMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and HelmInstalledStatus = 2 and HelmInstalled  ='" & ThisDay & "' ").Length
        lblHelmMComplete.Text = HelmMComplete

        Dim InspMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and CleaningStatus = 2 and Cleaning  ='" & ThisDay & "' ").Length
        lblCleaningMComplete.Text = InspMComplete

        Dim FinalMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and FinalInspectionStatus = 2 and FinalInspection  ='" & ThisDay & "' ").Length
        lblInspectionMComplete.Text = FinalMComplete

        Dim ShrinkMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and ShrinkwrapStatus = 2 and Shrinkwrap  ='" & ThisDay & "' ").Length
        lblShrinkMComplete.Text = ShrinkMComplete

        Dim RiggingMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and RiggingStatus = 2 and Rigging  ='" & ThisDay & "' ").Length
        lblRiggingMComplete.Text = RiggingMComplete

        Dim WTMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and WaveTamerStatus = 2 and WaveTamer  ='" & ThisDay & "' ").Length
        lblWTMComplete.Text = WTMComplete

        Dim SharkMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and SharkhideStatus = 2 and Sharkhide  ='" & ThisDay & "' ").Length
        lblSharkhideMComplete.Text = SharkMComplete

        Dim MComplete As Int16 = greenlights.Select("BuildLoc = 'M' and CompleteStatus = 2 and Complete  ='" & ThisDay & "' ").Length
        lblCompleteM.Text = MComplete

        'South

        Dim FramesSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and FramesInstalledStatus = 2 and FramesInstalled  ='" & ThisDay & "' ").Length
        lblFramesSComplete.Text = FramesSComplete

        Dim FloorsSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and FloorsInstalledStatus = 2 and FloorsInstalled  ='" & ThisDay & "' ").Length
        lblFloorsSComplete.Text = FloorsSComplete

        Dim TrimSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and TrimStatus = 2 and Trim  ='" & ThisDay & "' ").Length
        lblTrimSComplete.Text = TrimSComplete

        Dim RailsSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and RailsInstalledStatus = 2 and RailsInstalled  ='" & ThisDay & "' ").Length
        lblRailsSComplete.Text = RailsSComplete

        Dim FurnSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and FurnitureInstalledStatus = 2 and FurnitureInstalled  ='" & ThisDay & "' ").Length
        lblFurnitureSComplete.Text = FurnSComplete

        Dim HelmSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and HelmInstalledStatus = 2 and HelmInstalled  ='" & ThisDay & "' ").Length
        lblHelmSComplete.Text = HelmSComplete

        Dim InspSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and CleaningStatus = 2 and Cleaning  ='" & ThisDay & "' ").Length
        lblCleaningSComplete.Text = InspSComplete

        Dim FinalSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and FinalInspectionStatus = 2 and FinalInspection  ='" & ThisDay & "' ").Length
        lblInspectionSComplete.Text = FinalSComplete

        Dim ShrinkSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and ShrinkwrapStatus = 2 and Shrinkwrap  ='" & ThisDay & "' ").Length
        lblShrinkSComplete.Text = ShrinkSComplete

        Dim RiggingSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and RiggingStatus = 2 and Rigging  ='" & ThisDay & "' ").Length
        lblRiggingSComplete.Text = RiggingSComplete

        Dim WTSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and WaveTamerStatus = 2 and WaveTamer  ='" & ThisDay & "' ").Length
        lblWTSComplete.Text = WTSComplete

        Dim SharkSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and SharkhideStatus = 2 and Sharkhide  ='" & ThisDay & "' ").Length
        lblSharkhideSComplete.Text = SharkSComplete

        Dim SComplete As Int16 = greenlights.Select("BuildLoc = 'S' and CompleteStatus = 2 and Complete  ='" & ThisDay & "' ").Length
        lblCompleteS.Text = SComplete

        'Totals
        lblFramesTotalComplete.Text = Convert.ToInt32(lblFramesMComplete.Text) + Convert.ToInt32(lblFramesSComplete.Text)
        lblFloorsTotalComplete.Text = Convert.ToInt32(lblFloorsMComplete.Text) + Convert.ToInt32(lblFloorsSComplete.Text)
        lblTrimTotalComplete.Text = Convert.ToInt32(lblTrimMComplete.Text) + Convert.ToInt32(lblTrimSComplete.Text)
        lblRailsTotalComplete.Text = Convert.ToInt32(lblRailsMComplete.Text) + Convert.ToInt32(lblRailsSComplete.Text)
        lblFurnitureTotalComplete.Text = Convert.ToInt32(lblFurnitureMComplete.Text) + Convert.ToInt32(lblFurnitureSComplete.Text)
        lblHelmTotalComplete.Text = Convert.ToInt32(lblHelmMComplete.Text) + Convert.ToInt32(lblHelmSComplete.Text)
        lblCleaningTotalComplete.Text = Convert.ToInt32(lblCleaningMComplete.Text) + Convert.ToInt32(lblCleaningSComplete.Text)
        lblInspectionTotalComplete.Text = Convert.ToInt32(lblInspectionMComplete.Text) + Convert.ToInt32(lblInspectionSComplete.Text)
        lblShrinkTotalComplete.Text = Convert.ToInt32(lblShrinkMComplete.Text) + Convert.ToInt32(lblShrinkSComplete.Text)
        lblRiggingTotalComplete.Text = Convert.ToInt32(lblRiggingMComplete.Text) + Convert.ToInt32(lblRiggingSComplete.Text)
        lblWTTotalComplete.Text = Convert.ToInt32(lblWTMComplete.Text) + Convert.ToInt32(lblWTSComplete.Text)
        lblSharkhideTotalComplete.Text = Convert.ToInt32(lblSharkhideMComplete.Text) + Convert.ToInt32(lblSharkhideSComplete.Text)
        lblCompleteTotal.Text = Convert.ToInt32(lblCompleteM.Text) + Convert.ToInt32(lblCompleteS.Text)

        Return False
    End Function
    Public Function GetReadyByWS() As String

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        'Main
        Dim FramesMReady As Int16 = liveboats.Select("BuildLoc = 'M' and TubesStatus = 2 and (CentertubeStatus = '2' or CentertubeNeeded = '0') and FramesInstalledStatus < 2").Length
        lblFramesMReady.Text = FramesMReady

        Dim FloorsMReady As Int16 = liveboats.Select("BuildLoc = 'M' and FloorsInstalledStatus = 1 and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2").Length
        lblFloorsMReady.Text = FloorsMReady

        Dim TrimMReady As Int16 = liveboats.Select("BuildLoc = 'M' and TrimStatus = 1").Length
        lblTrimMReady.Text = TrimMReady

        Dim RailsMReady As Int16 = liveboats.Select("BuildLoc = 'M' and RailsInstalledStatus = 1").Length
        lblRailsMReady.Text = RailsMReady

        Dim FurnMReady As Int16 = liveboats.Select("BuildLoc = 'M' and FurnitureInstalledStatus = 1").Length
        lblFurnitureMReady.Text = FurnMReady

        Dim HelmMReady As Int16 = liveboats.Select("BuildLoc = 'M' and HelmInstalledStatus = 1").Length
        lblHelmMReady.Text = HelmMReady

        Dim InspMReady As Int16 = liveboats.Select("BuildLoc = 'M' and CleaningStatus = 1").Length
        lblCleaningMReady.Text = InspMReady

        Dim FinalMReady As Int16 = liveboats.Select("BuildLoc = 'M' and FinalInspectionStatus = 1").Length
        lblFinalInspectionMReady.Text = FinalMReady

        Dim ShrinkMReady As Int16 = liveboats.Select("BuildLoc = 'M' and ShrinkwrapStatus = 1").Length
        lblShrinkMReady.Text = ShrinkMReady

        Dim RiggingMReady As Int16 = liveboats.Select("BuildLoc = 'M' and RiggingStatus = 1").Length
        lblRiggingMReady.Text = RiggingMReady

        Dim WTMReady As Int16 = liveboats.Select("BuildLoc = 'M' and WaveTamerStatus = 1").Length
        lblWTMReady.Text = WTMReady

        Dim SharkMReady As Int16 = liveboats.Select("BuildLoc = 'M' and SharkhideStatus = 1").Length
        lblSharkhideMReady.Text = SharkMReady



        'South

        Dim FramesSReady As Int16 = liveboats.Select("BuildLoc = 'S' and TubesStatus = '2' and (CentertubeStatus = '2' or CentertubeNeeded = '0') and FramesInstalledStatus < 2").Length
        lblFramesSReady.Text = FramesSReady

        Dim FloorsSReady As Int16 = liveboats.Select("BuildLoc = 'S' and FloorsInstalledStatus = 1").Length
        lblFloorsSReady.Text = FloorsSReady

        Dim TrimSReady As Int16 = liveboats.Select("BuildLoc = 'S' and TrimStatus = 1").Length
        lblTrimSReady.Text = TrimSReady

        Dim RailsSReady As Int16 = liveboats.Select("BuildLoc = 'S' and RailsInstalledStatus = 1 and IsDeckInside = 1").Length
        lblRailsSReady.Text = RailsSReady

        Dim FurnSReady As Int16 = liveboats.Select("BuildLoc = 'S' and FurnitureInstalledStatus = 1").Length
        lblFurnitureSReady.Text = FurnSReady

        Dim HelmSReady As Int16 = liveboats.Select("BuildLoc = 'S' and HelmInstalledStatus = 1").Length
        lblHelmSReady.Text = HelmSReady

        Dim InspSReady As Int16 = liveboats.Select("BuildLoc = 'S' and CleaningStatus = 1").Length
        lblCleaningSReady.Text = InspSReady

        Dim FinalSReady As Int16 = liveboats.Select("BuildLoc = 'S' and FinalInspectionStatus = 1").Length
        lblFinalInspectionSReady.Text = FinalSReady

        Dim ShrinkSReady As Int16 = liveboats.Select("BuildLoc = 'S' and ShrinkwrapStatus = 1 ").Length
        lblShrinkSReady.Text = ShrinkSReady

        Dim RiggingSReady As Int16 = greenlights.Select("BuildLoc = 'S' and RiggingStatus = 1").Length
        lblRiggingSReady.Text = RiggingSReady

        Dim WTSReady As Int16 = liveboats.Select("BuildLoc = 'S' and WaveTamerStatus = 1").Length
        lblWTSReady.Text = WTSReady

        Dim SharkSReady As Int16 = liveboats.Select("BuildLoc = 'S' and SharkhideStatus = 1").Length
        lblSharkhideSReady.Text = SharkSReady


        Return False
    End Function
    Public Function GetSouthStats() As String
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        Dim SBroughtIn As Int16 = greenlights.Select("BuildLoc = 'S' and IsDeckInside = 1 and DeckLocModified ='" & ThisDay & "'").Length
        lblBroughtIn.Text = SBroughtIn

        Dim SWip As Int16 = liveboats.Select("BuildLoc = 'S' And (RailsInstalledStatus > 1 Or (RailsInstalledStatus = 1 And IsDeckInside = 1)) And ShrinkwrapStatus < 2 ").Length
        lblWip.Text = SWip

        Dim SDecks As Int16 = liveboats.Select("BuildLoc = 'S' and RailsInstalledStatus = 1 and IsDeckInside = 0").Length
        lblDecks.Text = SDecks

        Dim SReady As Int16 = liveboats.Select("BuildLoc = 'S' and RailsInstalledStatus = 1 and IsDeckInside = 0 and FurnitureStatus >= 2  and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((ArchTowerNeeded = 0) OR (ArchTowerNeeded = 1 AND ArchTowerStatus = 2)) AND ((QFrontNeeded = 0) OR (QFrontNeeded = 1 AND QFrontStatus = 2))").Length
        lblSouthReady.Text = SReady

        Return False
    End Function
    Public Function GetPastDue() As String
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        Dim MBehind As Int16 = liveboats.Select("BuildLoc ='M' and CompleteStatus < 2 and ShrinkwrapStatus < 2 and DueDate <= '" & TodaysDate & "'").Length
        lblMainBehind.Text = MBehind

        Dim SBehind As Int16 = liveboats.Select("BuildLoc ='S' and CompleteStatus < 2 and ShrinkwrapStatus < 2 and DueDate <= '" & TodaysDate & "'").Length
        lblSouthBehind.Text = SBehind

        Dim MAhead As Int16 = liveboats.Select("BuildLoc ='M' and ShrinkwrapStatus = 2 and DueDate >'" & TodaysDate & "'").Length
        lblMainAhead.Text = MAhead

        Dim SAhead As Int16 = liveboats.Select("BuildLoc ='S' and ShrinkwrapStatus = 2 and DueDate >'" & TodaysDate & "'").Length
        lblSouthAhead.Text = SAhead

        lblMainDiff.Text = Convert.ToInt16(lblMainAhead.Text) - Convert.ToInt16(lblMainBehind.Text)
        lblSouthDiff.Text = Convert.ToInt16(lblSouthAhead.Text) - Convert.ToInt16(lblSouthBehind.Text)
        lblTotalBehind.Text = Convert.ToInt16(lblMainBehind.Text) + Convert.ToInt16(lblSouthBehind.Text)
        lblTotalAhead.Text = Convert.ToInt16(lblMainAhead.Text) + Convert.ToInt16(lblSouthAhead.Text)
        lblScore.Text = Convert.ToInt16(lblTotalAhead.Text) - Convert.ToInt16(lblTotalBehind.Text)

        Return False
    End Function
    Public Function GetHealth() As String

        lblHealthS.Text = lblSouthReady.Text
        lblHealthM.Text = Convert.ToInt32(lblFloorsMReady.Text) + Convert.ToInt32(lblRailsGreen.Text) + Convert.ToInt32(lblRailsPulledMFramed.Text) + Convert.ToInt32(lblRailsPulledMNotFramed.Text) + Convert.ToInt32(lblReadyNeedsFramedM.Text)
        'lblHealthM.Text = Convert.ToInt32(lblFloorsMReady.Text) + Convert.ToInt32(lblRailsGreen.Text)

        Return False
    End Function
    Public Function GetRails() As String
        Dim railsGreen As Int16 = railRacks.Select("InUse = '1' and HasAllRails = '1' and BuildLoc = 'M' and (FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((CentertubeNeeded = 1 and CentertubeStatus >= 1) or CentertubeNeeded = 0))").Length
        Dim railsYellow As Int16 = railRacks.Select("InUse = '1' and Requested = '1' and HasAllRails ='0' and BuildLoc ='S' and (FurnitureStatus < 2 or FiberglassStatus < 2 or CoversStatus < 1 or TubesStatus < 2 or RailsStatus < 1 or ((CentertubeNeeded = 1 and CentertubeStatus < 2) or CentertubeNeeded = 0))").Length
        Dim railsBlue As Int16 = railRacks.Select("InUse = '1' and HasAllRails = '0' and BuildLoc = 'M' and (FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((CentertubeNeeded = 1 and CentertubeStatus >= 1) or CentertubeNeeded = 0))").Length
        Dim railsOrange As Int16 = railRacks.Select("(InUse = '1' and HasAllRails = '1' and BuildLoc ='S' and FurnitureStatus = 2 and FiberglassStatus = 2 and CoversStatus >= 1 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2) and ((CentertubeNeeded = 1 and CentertubeStatus >= 1) or CentertubeNeeded = 0)").Length
        Dim railsTan As Int16 = railRacks.Select("(InUse = '1' and Requested ='0' and HasAllRails = '0' and BuildLoc ='S' and FurnitureStatus = 2 and FiberglassStatus = 2 and CoversStatus >= 1 and TubesStatus = 2) and ((CentertubeNeeded = 1 and CentertubeStatus >= 1) or CentertubeNeeded = 0)").Length
        Dim railsEmpty As Int16 = railRacks.Select("InUse <> '1'").Length

        lblRailsGreen.Text = railsGreen
        lblRailsBlue.Text = railsBlue
        lblRailsYellow.Text = railsYellow
        lblRailsOrange.Text = railsOrange
        lblEmptySlots.Text = railsEmpty
        lblRailsTan.Text = railsTan

        Dim hasAllRailsM As Int16 = railRacks.Select("BuildLoc = 'M' and InUse = '1' and HasAllRails = '1'").Length
        Dim hasAllRailsS As Int16 = railRacks.Select("BuildLoc = 'S' and InUse = '1' and HasAllRails = '1' and BuildLoc = 'S'").Length

        lblAllRailsM.Text = hasAllRailsM
        lblAllRailsS.Text = hasAllRailsS
        lblAllRailsTotal.Text = Convert.ToInt32(lblAllRailsM.Text) + Convert.ToInt32(lblAllRailsS.Text)

        Dim hasSomeRailsM As Int16 = railRacks.Select("InUse = '1' and HasAllRails = '0' and BuildLoc = 'M' and (PF_Received = 1 or PR_Received = 1 or SF_Received = 1 or SR_Received = 1 or PM_Received = 1 or SM_Received = 1 or T_Received = 1)").Length
        Dim hasSomeRailsS As Int16 = railRacks.Select("InUse = '1' and HasAllRails = '0' and BuildLoc = 'S' and (PF_Received = 1 or PR_Received = 1 or SF_Received = 1 or SR_Received = 1 or PM_Received = 1 or SM_Received = 1 or T_Received = 1)").Length

        lblPartialRailsM.Text = hasSomeRailsM
        lblPartialRailsS.Text = hasSomeRailsS
        lblPartialRailsTotal.Text = Convert.ToInt32(lblPartialRailsM.Text) + Convert.ToInt32(lblPartialRailsS.Text)

        Dim readyNeedsFramedM As Int16 = greenlights.Select("BuildLoc = 'M' and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2 AND FramesInstalledStatus < 2").Length
        Dim readyNeedsFramedS As Int16 = greenlights.Select("BuildLoc = 'S' and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2 AND FramesInstalledStatus < 2").Length

        lblReadyNeedsFramedM.Text = readyNeedsFramedM
        lblReadyNeedsFramedS.Text = readyNeedsFramedS

        Dim pulledNeedsFramedM As Int16 = greenlights.Select("RailsStatus = 1 and FramesInstalledStatus < 2 and GaugeStatus = 2 and HarnessStatus = 2 and BuildLoc = 'M'").Length
        Dim pulledNeedsFramedS As Int16 = greenlights.Select("RailsStatus = 1 and FramesInstalledStatus < 2 and GaugeStatus = 2 and HarnessStatus = 2 and BuildLoc = 'S'").Length
        lblRailsPulledMNotFramed.Text = pulledNeedsFramedM
        lblRailsPulledSNotFramed.Text = pulledNeedsFramedS

        Dim readyNeedsPaneledM = greenlights.Select("RailsStatus = 1 and FramesInstalledStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and BuildLoc = 'M' and ProdNo > '2100000'").Length
        Dim readyNeedsPaneledS = greenlights.Select("RailsStatus = 1 and FramesInstalledStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and BuildLoc = 'S' and ProdNo > '2100000'").Length

        lblRailsPulledMFramed.Text = readyNeedsPaneledM
        lblRailsPulledSFramed.Text = readyNeedsPaneledS

        lblRailsPulledTotalNotFramed.Text = Convert.ToInt32(lblRailsPulledMNotFramed.Text) + Convert.ToInt32(lblRailsPulledSNotFramed.Text)
        lblRailsPulledTotalFramed.Text = Convert.ToInt32(lblRailsPulledMFramed.Text) + Convert.ToInt32(lblRailsPulledSFramed.Text)
        lblReadyNeedsFramedTotal.Text = Convert.ToInt32(lblReadyNeedsFramedM.Text) + Convert.ToInt32(lblReadyNeedsFramedS.Text)


        Return False
    End Function
    Public Function GetWip() As String
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        lblOfflineM.Text = offline.Select("BuildLoc = 'M'").Length
        lblOfflineS.Text = offline.Select("BuildLoc = 'S'").Length
        lblOfflineTotal.Text = Convert.ToInt32(lblOfflineM.Text) + Convert.ToInt32(lblOfflineS.Text)

        lblFrameStacksM.Text = liveboats.Select("TubesStatus = '2' and FramesInstalledStatus > 1 and FloorsInstalledStatus < 2 and CompleteStatus < 2 and BuildLoc ='M'").Length
        lblFrameStacksS.Text = liveboats.Select("TubesStatus = '2' and FramesInstalledStatus > 1 and FloorsInstalledStatus < 2 and CompleteStatus < 2 and BuildLoc ='S'").Length
        lblFrameStacksTotal.Text = Convert.ToInt32(lblFrameStacksM.Text) + Convert.ToInt32(lblFrameStacksS.Text)

        lblInProgressM.Text = liveboats.Select("FramesInstalledStatus = 2 and FloorsInstalledStatus = 2 and ShrinkwrapStatus < 2 and BuildLoc = 'M' and FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((ArchTowerNeeded = 0) OR (ArchTowerNeeded = 1 AND ArchTowerStatus = 2)) AND ((QFrontNeeded = 0) OR (QFrontNeeded = 1 AND QFrontStatus = 2))").Length
        lblInProgressS.Text = lblWip.Text
        lblInProgressTotal.Text = Convert.ToInt32(lblInProgressM.Text) + Convert.ToInt32(lblInProgressS.Text)

        lblMainPastDueWIP.Text = liveboats.Select("BuildLoc = 'M' and CompleteStatus < 2 and ShrinkwrapStatus < 2 and FramesInstalledStatus = 2 and DueDate <= '" & ThisDay & "'").Length
        lblSouthPastDueWIP.Text = liveboats.Select("BuildLoc = 'S' and CompleteStatus < 2 and ShrinkwrapStatus < 2 and RailsInstalledStatus = 2 and DueDate <= '" & ThisDay & "'").Length
        lblTotalPastDueWIP.Text = Convert.ToInt32(lblMainPastDueWIP.Text) + Convert.ToInt32(lblSouthPastDueWIP.Text)


        'cmd60.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M'"
        'cmd61.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S'"

        Return False

    End Function
    Public Function GetFurnStats() As String

        'lblFurnEmptySpaces.Text = materiallocations.Select("Usable = 1 and InUse = 0 ").Length
        'lblFurnDisabledSpaces.Text = materiallocations.Select("Usable = 0").Length
        lblFurnGreen.Text = materiallocationswgls.Select("FurnitureStatus = 2").Length
        lblFurnYellowRed.Text = materiallocationswgls.Select("FurnitureStatus = 3").Length
        lblFurnYellow.Text = materiallocationswgls.Select("FurnitureStatus = 1").Length

        Return False
    End Function
    Public Function GetVeadaInfo() As String

        RGAsM.Text = rgas.Select("RGA_Gen_By <> 'JROMERO'").Length
        RGAsS.Text = rgas.Select("RGA_Gen_By = 'JROMERO'").Length

        BOsM.Text = bos.Select("Added_By <> 'JROMERO'").Length
        BOsS.Text = bos.Select("Added_By = 'JROMERO'").Length

        RGAsTotal.Text = Convert.ToInt32(RGAsM.Text) + Convert.ToInt32(RGAsS.Text)
        BOsTotal.Text = Convert.ToInt32(BOsM.Text) + Convert.ToInt32(BOsS.Text)

        Return False
    End Function
End Class

