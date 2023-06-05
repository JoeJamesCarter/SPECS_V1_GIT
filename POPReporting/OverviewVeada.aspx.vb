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
    Public shipData As New DataTable
    Public dtGLwShip As New DataTable
    Public uniqueShipDates As New DataTable
    Public mProdAndBldg As New DataTable
    Public vProdAndBldg As New DataTable
    Public sProdAndBldg As New DataTable
    Public lastMBaseline As String
    Public lastVBaseline As String
    Public lastSBaseLine As String
    Public lateMain As New DataTable
    Public lateValue As New DataTable
    Public lateSouth As New DataTable
    Public shipCountsByBuildingByDayMain As New DataTable
    Public shipCountsByBuildingByDayValue As New DataTable
    Public shipCountsByBuildingByDaySouth As New DataTable
    Public ShipCountsByByDayTotals As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub OverviewProd_Load(sender As Object, e As EventArgs) Handles Me.Load

        lblMainGoal.Text = 190
        lblSouthGoal.Text = 90

        lblMWipGoal.Text = 35
        lblSWipGoal.Text = 24

        lblMRackGoal.Text = 134
        lblSRackGoal.Text = 56

        lblMTruckGoal.Text = 21
        lblSTruckGoal.Text = 10


        PopulateDataTables()
        GetStats()
        GetVeadaInfo()
        GetBaseLines()
        'LogResults()

        'lblMTruckVariance.Text = Convert.ToInt32(lblShipNotRcvdM.Text) - Convert.ToInt32(lblMTruckGoal.Text)
        'lblMTruckVariance.Text = (Convert.ToInt32(lblShipNotRcvdM.Text) + Convert.ToInt32(lblShipNotRcvdV.Text)) - Convert.ToInt32(lblMTruckGoal.Text)
        'lblSTruckVariance.Text = Convert.ToInt32(lblShipNotRcvdS.Text) - Convert.ToInt32(lblSTruckGoal.Text)

        'lblMRackVariance.Text = Convert.ToInt32(lblFurnRackM.Text) - Convert.ToInt32(lblMRackGoal.Text)
        'lblMRackVariance.Text = (Convert.ToInt32(lblFurnRackM.Text) + Convert.ToInt32(lblFurnRackV.Text)) - Convert.ToInt32(lblMRackGoal.Text) 'Temporarily count Value In Racks towards Main Building Variance when we try to get dialed in to determine what the real goals are.
        'lblSRackVariance.Text = Convert.ToInt32(lblFurnRackS.Text) - Convert.ToInt32(lblSRackGoal.Text)

        'lblMWipVariance.Text = Convert.ToInt32(lblMWIPWfurn.Text) - Convert.ToInt32(lblMWipGoal.Text)
        'lblMWipVariance.Text = (Convert.ToInt32(lblMWIPWfurn.Text) + Convert.ToInt32(lblVWIPWfurn.Text)) - Convert.ToInt32(lblMWipGoal.Text) 'Temporary same as above
        'lblSWipVariance.Text = Convert.ToInt32(lblSWIPWfurn.Text) - Convert.ToInt32(lblSWipGoal.Text)

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name.ToUpper

        'If user = "POLARISIND/LMAYS" Or user = "POLARISIND/KRIMBA" Then
        'gvBaseLines.Visible = True
        ' End If

    End Sub

    Public Function PopulateDataTables() As String

        Dim sqldataadapter As New SqlDataAdapter
        Dim sqldataadapter1 As New SqlDataAdapter
        Dim sqldataadapter2 As New SqlDataAdapter
        Dim sqldataadapter3 As New SqlDataAdapter
        Dim sqldataadapter4 As New SqlDataAdapter
        Dim sqldataadapter5 As New SqlDataAdapter
        Dim sqldataadapter6 As New SqlDataAdapter

        Dim mysqldataadapter As New MySqlDataAdapter
        Dim mysqldataadapter1 As New MySqlDataAdapter
        'Dim mysqldataadapter2 As New MySqlDataAdapter
        'Dim mysqldataadapter3 As New MySqlDataAdapter
        Dim mysqldataadapter4 As New MySqlDataAdapter
        Dim mysqldataadapter5 As New MySqlDataAdapter

        Dim conn As New SqlConnection()
        Dim conn2 As New MySqlConnection
        'Dim conn3 As New MySqlConnection

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim connstr2 As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"
        conn2.ConnectionString = connstr2

        ' Dim connstr3 As String = "server=veada-mysql-082019.cz8vw0a6whxb.us-east-1.rds.amazonaws.com;user id=BennDataPartner;password=DISH4087sky$$;persistsecurityinfo=True;database=vea_0819_dbshare"
        'conn3.ConnectionString = connstr3

        conn.Open()
        sqldataadapter.SelectCommand = New SqlCommand("SELECT t2.ProdNo, t2.FurnitureStatus,Convert(date,t2.FurniturePrepLastUpdated) as FurniturePrepLastUpdated,t2.FiberglassStatus,Convert(date,t2.FiberglassLastUpdated) as FiberglassLastUpdated,t2.CoversStatus,Convert(date,t2.CoversLastUpdated) as CoversLastUpdated,t2.RailsStatus,Convert(date,t2.RailsLastUpdated) as RailsLastUpdated,t2.TubesStatus,Convert(date,t2.TubesLastUpdated) as TubesLastUpdated,t2.FramesInstalledStatus,Convert(date,t2.FramesInstalled) as FramesInstalled,t2.FloorsInstalledStatus,Convert(date,t2.FloorsInstalled) as FloorsInstalled,t2.RailsInstalledStatus,Convert(date,t2.RailsInstalled) as RailsInstalled,t2.FurnitureInstalledStatus,Convert(date,t2.FurnitureInstalled) as FurnitureInstalled,t2.HelmInstalledStatus,Convert(date,t2.HelmInstalled) as HelmInstalled,t2.CleaningStatus,Convert(date,t2.Cleaning) as Cleaning,t2.FinalInspectionStatus,Convert(date,t2.FinalInspection) as FinalInspection,t2.ShrinkwrapStatus,Convert(date,t2.ShrinkWrap) as ShrinkWrap,t2.WavetamerStatus,Convert(date,t2.WaveTamerInstalled) as WaveTamer, t2.SharkhideStatus,Convert(date,t2.SharkhideInstalled) as Sharkhide, t2.CompleteStatus,Convert(date,t2.Complete) as Complete,t2.IsBoatOffline,t2.CentertubeStatus,Convert(date,t2.Centertube) as Centertube,t2.HelmKittingStatus,Convert(date,t2.HelmKitting) as HelmKitting,t2.HelmBuildStatus,Convert(date,t2.HelmBuild) as HelmBuild, t2.RiggingStatus, Convert(date, t2.Rigging) as Rigging, t2.ItemNo,t2.SONo,t2.DueDate,t2.PanelColor,t2.SharkhideNeeded,t2.WavetamerNeeded,t2.CentertubeNeeded,t2.IsCustom,t2.IsRedTagged,t2.BuildLoc,t2.GaugeStatus,Convert(date,t2.GaugeLastUpdated) as GaugeLastUpdated,t2.HarnessStatus,Convert(date,t2.HarnessLastUpdated) as HarnessLastUpdated,t2.Kitting1Status,Convert(date,t2.Kitting1) as Kitting1,t2.Kitting2Status,Convert(date,t2.Kitting2) as Kitting2,t2.Kitting3Status,Convert(date,t2.Kitting3) as Kitting3,t2.Kitting4Status,Convert(date,t2.Kitting4) as Kitting4,t2.GatesStatus,Convert(date,t2.Gates) as Gates,t2.BiminiStatus,Convert(date,t2.Bimini) as Bimini,t2.QFrontNeeded,t2.QFrontStatus,Convert(date,t2.QFront) as QFront,t2.ArchTowerNeeded,t2.ArchTowerStatus,Convert(date,t2.ArchTower) as ArchTower,t2.SBNeeded,t2.SwingbackStatus,Convert(date,t2.Swingback) as Swingback,t2.FurnHwrStatus,Convert(date,t2.FurnHwr) as FurnHwr,t2.BiminiRcvdStatus,Convert(date,t2.BiminiRcvd) as BiminiRcvd,t2.NeedsLadder,t2.LadderStatus,Convert(date,t2.Ladder) as Ladder,t2.TenWidePort,t2.TenWideStrb,t2.TrimStatus,Convert(date,t2.Trim) as Trim,t2.PhotosStatus,Convert(date,t2.Photos) as Photos,t2.HasTubeDamage,t2.FiberglassInspStatus,Convert(date,t2.FiberglassInsp) as FiberglassInsp,t2.IsDeckInside,Convert(date,t2.DeckLocModified) as DeckLocModified,t2.FurnHwrDelStatus,Convert(date,t2.FurnHwrDel) as FurnHwrDel From BML_POPREPORTING_GREENLIGHTS t2 Where ProdNo > 2100000 and CompleteStatus < 2 Order By t2.ProdNo", conn)
        sqldataadapter.Fill(greenlights)

        'sqldataadapter1.SelectCommand = New SqlCommand("Select t1.*, t2.FurnitureStatus, t2.FiberglassStatus, t2.CoversStatus, t2.RailsStatus, t2.TubesStatus, t2.CentertubeStatus, t2.CentertubeNeeded, t2.GaugeStatus, t2.HarnessStatus, t2.FramesInstalledStatus, BuildLoc, Requested, HasAllRails, PF_Received, PR_Received, SF_Received, SR_Received, PM_Received, SM_Received, T_Received From Rails_KittingLocations t1 left join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Left Join Rails_Tracking t4 on t1.ProdNo = t4.ProdNo", conn)
        'sqldataadapter1.Fill(railRacks)

        'sqldataadapter2.SelectCommand = New SqlCommand("Select Distinct t1.ProdNo, t2.BuildLoc From BML_POPREPORTING_OFFLINE t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo where CompleteStatus < 2 and Cleared = 0 AND OfflineNote <> ''", conn)
        'sqldataadapter2.Fill(offline)

        sqldataadapter3.SelectCommand = New SqlCommand("Select Distinct(t1.ProdNo), t1.Usable, t1.InUse, t2.FurnitureStatus, t2.CompleteStatus  from Material_Locations t1 Left join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = Substring(t2.ProdNo,3,5) Where InUse = 1 and Usable = 1 and CompleteStatus < 2", conn)
        sqldataadapter3.Fill(materiallocationswgls)

        sqldataadapter4.SelectCommand = New SqlCommand("Select * from Material_Locations", conn)
        sqldataadapter4.Fill(materiallocations)

        sqldataadapter5.SelectCommand = New SqlCommand("SELECT t2.ProdNo, t2.FurnitureStatus,Convert(date,t2.FurniturePrepLastUpdated) as FurniturePrepLastUpdated,t2.FiberglassStatus,Convert(date,t2.FiberglassLastUpdated) as FiberglassLastUpdated,t2.CoversStatus,Convert(date,t2.CoversLastUpdated) as CoversLastUpdated,t2.RailsStatus,Convert(date,t2.RailsLastUpdated) as RailsLastUpdated,t2.TubesStatus,Convert(date,t2.TubesLastUpdated) as TubesLastUpdated,t2.FramesInstalledStatus,Convert(date,t2.FramesInstalled) as FramesInstalled,t2.FloorsInstalledStatus,Convert(date,t2.FloorsInstalled) as FloorsInstalled,t2.RailsInstalledStatus,Convert(date,t2.RailsInstalled) as RailsInstalled,t2.FurnitureInstalledStatus,Convert(date,t2.FurnitureInstalled) as FurnitureInstalled,t2.HelmInstalledStatus,Convert(date,t2.HelmInstalled) as HelmInstalled,t2.CleaningStatus,Convert(date,t2.Cleaning) as Cleaning,t2.FinalInspectionStatus,Convert(date,t2.FinalInspection) as FinalInspection,t2.ShrinkwrapStatus,Convert(date,t2.ShrinkWrap) as ShrinkWrap,t2.WavetamerStatus,Convert(date,t2.WaveTamerInstalled) as WaveTamer, t2.SharkhideStatus,Convert(date,t2.SharkhideInstalled) as Sharkhide, t2.CompleteStatus,Convert(date,t2.Complete) as Complete,t2.IsBoatOffline,t2.CentertubeStatus,Convert(date,t2.Centertube) as Centertube,t2.HelmKittingStatus,Convert(date,t2.HelmKitting) as HelmKitting,t2.HelmBuildStatus,Convert(date,t2.HelmBuild) as HelmBuild, t2.RiggingStatus, Convert(date, t2.Rigging) as Rigging, t2.ItemNo,t2.SONo, Convert(varchar,t2.DueDate, 101) as DueDate, t2.PanelColor,t2.SharkhideNeeded,t2.WavetamerNeeded,t2.CentertubeNeeded,t2.IsCustom,t2.IsRedTagged,t2.BuildLoc,t2.GaugeStatus,Convert(date,t2.GaugeLastUpdated) as GaugeLastUpdated,t2.HarnessStatus,Convert(date,t2.HarnessLastUpdated) as HarnessLastUpdated,t2.Kitting1Status,Convert(date,t2.Kitting1) as Kitting1,t2.Kitting2Status,Convert(date,t2.Kitting2) as Kitting2,t2.Kitting3Status,Convert(date,t2.Kitting3) as Kitting3,t2.Kitting4Status,Convert(date,t2.Kitting4) as Kitting4,t2.GatesStatus,Convert(date,t2.Gates) as Gates,t2.BiminiStatus,Convert(date,t2.Bimini) as Bimini,t2.QFrontNeeded,t2.QFrontStatus,Convert(date,t2.QFront) as QFront,t2.ArchTowerNeeded,t2.ArchTowerStatus,Convert(date,t2.ArchTower) as ArchTower,t2.SBNeeded,t2.SwingbackStatus,Convert(date,t2.Swingback) as Swingback,t2.FurnHwrStatus,Convert(date,t2.FurnHwr) as FurnHwr,t2.BiminiRcvdStatus,Convert(date,t2.BiminiRcvd) as BiminiRcvd,t2.NeedsLadder,t2.LadderStatus,Convert(date,t2.Ladder) as Ladder,t2.TenWidePort,t2.TenWideStrb,t2.TrimStatus,Convert(date,t2.Trim) as Trim,t2.PhotosStatus,Convert(date,t2.Photos) as Photos,t2.HasTubeDamage,t2.FiberglassInspStatus,Convert(date,t2.FiberglassInsp) as FiberglassInsp,t2.IsDeckInside,Convert(date,t2.DeckLocModified) as DeckLocModified,t2.FurnHwrDelStatus,Convert(date,t2.FurnHwrDel) as FurnHwrDel From BML_POPREPORTING t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Order By t2.ProdNo", conn)
        sqldataadapter5.Fill(liveboats)

        conn2.Open()

        'conn3.Open()

        mysqldataadapter.SelectCommand = New MySqlCommand("Select t1.*, BuildLoc from RGAs t1 Left Join BuildLoc t2 on t1.ProdNo = t2.ProdNo where BenRcvd is null and RgaNo is not null", conn2)
        mysqldataadapter.Fill(rgas)

        mysqldataadapter.SelectCommand = New MySqlCommand("Select t1.*, BuildLoc from Backorders t1 Left Join BuildLoc t2 on t1.ProdNo = t2.ProdNo where Cleared = 0", conn2)
        mysqldataadapter.Fill(bos)

        ' mysqldataadapter2.SelectCommand = New MySqlCommand("Select ProdNo,CAST(Shipped AS DATE) as Shipped, 1 as ShippedFlag, Line, TruckNum FROM BennShipping_Shipped Where ProdNo > 2100000 Order By ProdNo asc", conn3)
        'mysqldataadapter2.Fill(shipData)

        'mysqldataadapter3.SelectCommand = New MySqlCommand("SELECT Count(ProdNo) as 'Total Scanned', Right(date(CAST(Shipped AS DATE)),12) as Date FROM vea_0819_dbshare.BennShipping_Shipped Where TruckNum Not Like 'Bld%' Group By CAST(Shipped AS DATE) Order By Shipped Desc", conn3)
        'mysqldataadapter3.Fill(shipCountsByBuildingByDayMain)

        'mysqldataadapter3.SelectCommand = New MySqlCommand("SELECT Count(ProdNo) as 'Total Scanned', Right(date(CAST(Shipped AS DATE)),12) as Date FROM vea_0819_dbshare.BennShipping_Shipped Where TruckNum Not Like 'Bld%' Group By CAST(Shipped AS DATE) Order By Shipped Desc", conn3)
        'mysqldataadapter3.Fill(shipCountsByBuildingByDayValue)

        'mysqldataadapter4.SelectCommand = New MySqlCommand("SELECT Count(ProdNo) As 'Total Scanned', Right(date(CAST(Shipped AS DATE)),12) as Date FROM vea_0819_dbshare.BennShipping_Shipped Where TruckNum Like 'Bld%' Group By CAST(Shipped AS DATE) Order By Shipped Desc ", conn3)
        'mysqldataadapter4.Fill(shipCountsByBuildingByDaySouth)

        'mysqldataadapter5.SelectCommand = New MySqlCommand("SELECT Count(ProdNo) as 'Total Scanned' , Right(date(CAST(Shipped AS DATE)),12) as Date FROM vea_0819_dbshare.BennShipping_Shipped Group By CAST(Shipped AS DATE) Order By Shipped Desc ", conn3)
        'mysqldataadapter5.Fill(ShipCountsByByDayTotals)

        sqldataadapter.SelectCommand = New SqlCommand("SELECT ProdNo, BuildLoc From BML_POPREPORTING_GREENLIGHTS Where (BuildLoc = 'M' or BuildLoc ='V') and ProdNo > 2099999 Order By ProdNo", conn) 'have to include V so we don't miss all those boats finding the next prod # x # ahead.
        sqldataadapter.Fill(mProdAndBldg)
        mProdAndBldg.PrimaryKey = New DataColumn() {mProdAndBldg.Columns("ProdNo")}

        sqldataadapter.SelectCommand = New SqlCommand("SELECT ProdNo, BuildLoc From BML_POPREPORTING_GREENLIGHTS Where BuildLoc = 'V' and ProdNo > 2099999 Order By ProdNo", conn)
        sqldataadapter.Fill(vProdAndBldg)
        vProdAndBldg.PrimaryKey = New DataColumn() {vProdAndBldg.Columns("ProdNo")}

        sqldataadapter.SelectCommand = New SqlCommand("SELECT ProdNo, BuildLoc From BML_POPREPORTING_GREENLIGHTS Where BuildLoc = 'S' and ProdNo > 2099999 Order By ProdNo", conn)
        sqldataadapter.Fill(sProdAndBldg)
        sProdAndBldg.PrimaryKey = New DataColumn() {sProdAndBldg.Columns("ProdNo")}

        sqldataadapter.SelectCommand = New SqlCommand("SELECT Distinct(Convert(date, ShrinkWrap)) as DateShrinked From BML_POPREPORTING_GREENLIGHTS Where Convert(date,ShrinkWrap) > '11/12/2020' Order By DateShrinked ", conn)
        sqldataadapter.Fill(uniqueShipDates)

        uniqueShipDates.Columns.Add("MBaseline")
        uniqueShipDates.Columns.Add("MShrinked")
        uniqueShipDates.Columns.Add("SBaseline")
        uniqueShipDates.Columns.Add("SShrinked")

        lateMain.Columns.Add("Prod No")
        lateMain.Columns.Add("Model")
        lateMain.Columns.Add("Due Date")
        lateMain.Columns.Add("BuildLoc")

        lateSouth.Columns.Add("Prod No")
        lateSouth.Columns.Add("Model")
        lateSouth.Columns.Add("Due Date")

        liveboats.PrimaryKey = New DataColumn() {liveboats.Columns("ProdNo")}
        ' shipData.PrimaryKey = New DataColumn() {shipData.Columns("ProdNo")}
        dtGLwShip.PrimaryKey = New DataColumn() {dtGLwShip.Columns("ProdNo")}

        'liveboats.Merge(shipData)

        dtGLwShip.Merge(liveboats)
        dtGLwShip.Merge(shipData)

        'Dim view As DataRow() = dtGLwShip.Select("FurnitureStatus = 0", "ProdNo")
        'gvTest.DataSource = view
        'gvTest.DataBind()


        gvMainShipped.DataSource = shipCountsByBuildingByDayMain
        gvMainShipped.DataBind()

        gvSouthShipped.DataSource = shipCountsByBuildingByDaySouth
        gvSouthShipped.DataBind()

        gvTotalsShipped.DataSource = ShipCountsByByDayTotals
        gvTotalsShipped.DataBind()

        gvBaseLines.DataSource = uniqueShipDates
        gvBaseLines.DataBind()

        conn.Close()
        conn2.Close()
        'conn3.Close()

        'gvTest2.Visible = True
        'gvTest2.DataSource = rgas
        'gvTest2.DataBind()
        'MesgBox(greenlights.Rows.Count)
        'MesgBox(railRacks.Rows.Count)

        conn.Dispose()
        Return False

    End Function
    Public Function GetStats() As String
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        lblToday.Text = ThisDay

        'Received Today
        'Main
        Dim FGreenedM As Int16 = greenlights.Select("BuildLoc = 'M' and FurnitureStatus = '2' and FurniturePrepLastUpdated = '" & ThisDay & "'").Length
        lblFMain.Text = FGreenedM
        'Value
        Dim FGreenedV As Int16 = greenlights.Select("BuildLoc = 'V' and FurnitureStatus = '2' and FurniturePrepLastUpdated = '" & ThisDay & "'").Length
        lblFValue.Text = FGreenedV
        'South
        Dim FGreenedS As Int16 = greenlights.Select("BuildLoc = 'S' and FurnitureStatus = '2' and FurniturePrepLastUpdated = '" & ThisDay & "'").Length
        lblFSouth.Text = FGreenedS
        'Totals
        lblFTotal.Text = Convert.ToInt32(lblFMain.Text) + Convert.ToInt32(lblFSouth.Text) + Convert.ToInt32(lblFValue.Text)

        'Completed Thru Shrink Today
        'Main
        Dim ShrinkMComplete As Int16 = greenlights.Select("BuildLoc = 'M' and ShrinkwrapStatus = 2 and Shrinkwrap  ='" & ThisDay & "' ").Length
        lblShrinkMComplete.Text = ShrinkMComplete

        'Value
        Dim ShrinkVComplete As Int16 = greenlights.Select("BuildLoc = 'V' and ShrinkwrapStatus = 2 and Shrinkwrap  ='" & ThisDay & "' ").Length
        lblShrinkVComplete.Text = ShrinkVComplete

        'South
        Dim ShrinkSComplete As Int16 = greenlights.Select("BuildLoc = 'S' and ShrinkwrapStatus = 2 and Shrinkwrap  ='" & ThisDay & "' ").Length
        lblShrinkSComplete.Text = ShrinkSComplete

        'Totals
        lblShrinkTotalComplete.Text = Convert.ToInt32(lblShrinkMComplete.Text) + Convert.ToInt32(lblShrinkSComplete.Text) + Convert.ToInt32(lblShrinkVComplete.Text)


        'Current Rack Levels
        'Main
        Dim FStockM As Int16 = greenlights.Select("BuildLoc = 'M' and FurnitureStatus > 0 and FurnitureInstalledStatus < 2 and CompleteStatus < 2 ").Length
        lblFurnRackM.Text = FStockM

        'Value
        Dim FStockV As Int16 = greenlights.Select("BuildLoc = 'V' and FurnitureStatus > 0 and FurnitureInstalledStatus < 2 and CompleteStatus < 2 ").Length
        lblFurnRackV.Text = FStockV

        'South
        Dim FStockS As Int16 = greenlights.Select("BuildLoc = 'S' and FurnitureStatus > 0 and FurnitureInstalledStatus < 2 and CompleteStatus < 2 ").Length
        lblFurnRackS.Text = FStockS
        'Totals
        'lblFurnRackTotal.Text = Convert.ToInt32(lblFurnRackM.Text) + Convert.ToInt32(lblFurnRackS.Text)

        'Shipped But Not Received


        'Dim ShippedNoRcvdM As Int16 = dtGLwShip.Select("BuildLoc = 'M' and FurnitureStatus = 0 and ShippedFlag is not NULL").Length
        'lblShipNotRcvdM.Text = ShippedNoRcvdM

        'Dim ShippedNoRcvdV As Int16 = dtGLwShip.Select("BuildLoc = 'V' and FurnitureStatus = 0 and ShippedFlag is not NULL").Length
        'lblShipNotRcvdV.Text = ShippedNoRcvdV

        'Dim ShippedNoRcvdS As Int16 = dtGLwShip.Select("BuildLoc = 'S' and FurnitureStatus = 0 and ShippedFlag is not NULL").Length
        'lblShipNotRcvdS.Text = ShippedNoRcvdS


        'WIP W Furn Installed
        lblMWIPWfurn.Text = greenlights.Select("FurnitureInstalledStatus = 2 and ShrinkwrapStatus < 2 and CompleteStatus < 2 and BuildLoc = 'M'").Length
        lblVWIPWfurn.Text = greenlights.Select("FurnitureInstalledStatus = 2 and ShrinkwrapStatus < 2 and CompleteStatus < 2 and BuildLoc = 'V'").Length
        lblSWIPWfurn.Text = greenlights.Select("FurnitureInstalledStatus = 2 and ShrinkwrapStatus < 2 and CompleteStatus < 2 and BuildLoc = 'S'").Length

        'lblMainCurrentTotal.Text = FStockM + ShippedNoRcvdM + Convert.ToInt32(lblMWIPWfurn.Text)
        'lblMainCurrentTotal.Text = FStockM + ShippedNoRcvdM + Convert.ToInt32(lblMWIPWfurn.Text) + FStockV + ShippedNoRcvdV + Convert.ToInt32(lblVWIPWfurn.Text) 'Temporarilly adding value to this to calculate the variance.

        'lblValueCurrentTotal.Text = FStockV + ShippedNoRcvdV + Convert.ToInt32(lblVWIPWfurn.Text)
        'lblSouthCurrentTotal.Text = FStockS + ShippedNoRcvdS + Convert.ToInt32(lblSWIPWfurn.Text)

        ' lblMainVariance.Text = Convert.ToInt32(lblMainCurrentTotal.Text) - Convert.ToInt32(lblMainGoal.Text)
        'lblSouthVariance.Text = Convert.ToInt32(lblSouthCurrentTotal.Text) - Convert.ToInt32(lblSouthGoal.Text)

        'lblTotalSetsInWip.Text = Convert.ToInt32(lblMWIPWfurn.Text) + Convert.ToInt32(lblSWIPWfurn.Text)
        'lblTotalOnTrucks.Text = ShippedNoRcvdM + ShippedNoRcvdS

        Return False

    End Function
    Public Function GetVeadaInfo() As String

        RGAsM.Text = rgas.Select("BuildLoc = 'M'").Length
        RGAsV.Text = rgas.Select("BuildLoc = 'V'").Length
        RGAsS.Text = rgas.Select("BuildLoc = 'S'").Length

        Dim nullBldgTotal As Integer = rgas.Select("BuildLoc <> 'M' and BuildLoc <> 'V' and BuildLoc <> 'S'").Length

        BOsM.Text = bos.Select("BuildLoc = 'M'").Length
        BOsV.Text = bos.Select("BuildLoc = 'V'").Length
        BOsS.Text = bos.Select("BuildLoc = 'S'").Length

        RGAsTotal.Text = Convert.ToInt32(RGAsM.Text) + Convert.ToInt32(RGAsS.Text) + Convert.ToInt32(RGAsV.Text) + nullBldgTotal
        BOsTotal.Text = Convert.ToInt32(BOsM.Text) + Convert.ToInt32(BOsS.Text) + Convert.ToInt32(BOsV.Text)


        Dim dtDistinctRGAS As DataTable = GetDistinctRecords(rgas, {"ProdNo", "BuildLoc"})

        RGAboatsM.Text = dtDistinctRGAS.Select("BuildLoc = 'M'").Length
        RGAboatsV.Text = dtDistinctRGAS.Select("BuildLoc = 'V'").Length
        RGABoatsS.Text = dtDistinctRGAS.Select("BuildLoc = 'S'").Length

        Dim dtDistinctBOs As DataTable = GetDistinctRecords(bos, {"ProdNo", "BuildLoc"})

        BOBoatsM.Text = dtDistinctBOs.Select("BuildLoc = 'M'").Length
        BOBoatsV.Text = dtDistinctBOs.Select("BuildLoc = 'V'").Length
        BoBoatsS.Text = dtDistinctBOs.Select("BuildLoc = 'S'").Length

        BoBoatsTotal.Text = dtDistinctBOs.Rows.Count
        RGABoatsTotal.Text = dtDistinctRGAS.Rows.Count

        Return False
    End Function

    Public Shared Function GetDistinctRecords(ByVal dt As DataTable, ByVal Columns As String()) As DataTable
        Dim dtUniqRecords As DataTable = New DataTable()
        dtUniqRecords = dt.DefaultView.ToTable(True, Columns)
        Return dtUniqRecords
    End Function

    'Public Function GetFurnStats() As String

    '    lblFurnEmptySpaces.Text = materiallocations.Select("Usable = 1 and InUse = 0 ").Length
    '    lblFurnDisabledSpaces.Text = materiallocations.Select("Usable = 0").Length
    '    lblFurnGreen.Text = materiallocationswgls.Select("FurnitureStatus = 2").Length
    '    lblFurnYellowRed.Text = materiallocationswgls.Select("FurnitureStatus = 3").Length
    '    lblFurnYellow.Text = materiallocationswgls.Select("FurnitureStatus = 1").Length

    '    Return False
    'End Function
    Public Function GetBaseLines() As String

        '11/13/2020 EOD baseline = 2103849 for Main and 2103669 for South
        'each day increments from here + the number of boats that building shrunk to get a new Baseline.

        Dim mStartBaseline As Integer = 2103849
        Dim sStartBaseline As Integer = 2103669
        Dim prevMBaseLine As Integer
        Dim prevSBaseLine As Integer

        Dim prevMShrinked As Integer
        Dim prevSShrinked As Integer

        Dim mBaseLineBldg As DataRow()
        Dim sBaseLineBldg As DataRow()


        Dim mShrink As Int16
        Dim sShrink As Int16
        Dim vShrink As Int16

        For Each row As DataRow In uniqueShipDates.Rows

            If row("DateShrinked") = "11/13/2020" Then
                row("MBaseLine") = mStartBaseline
                row("SBaseLine") = sStartBaseline
                mShrink = greenlights.Select("BuildLoc = 'M' and ShrinkwrapStatus = 2 and ShrinkWrap = '" & row("DateShrinked") & "'").Length 'how many today
                ' vShrink = greenlights.Select("BuildLoc ='V' and ShrinkwrapStatus = 2 and ShrinkWrap = '" & row("DateShrinked") & "'").Length 'how many today
                mShrink = mShrink ' + vShrink

                row("MShrinked") = mShrink
                sShrink = greenlights.Select("BuildLoc = 'S' and ShrinkwrapStatus = 2 and ShrinkWrap = '" & row("DateShrinked") & "'").Length
                row("SShrinked") = sShrink
                prevMBaseLine = row("MBaseLine")
                prevSBaseLine = row("SBaseLine")
                prevMShrinked = mShrink
                prevSShrinked = sShrink

            Else
                mShrink = greenlights.Select("BuildLoc = 'M' and ShrinkwrapStatus = 2 and ShrinkWrap = '" & row("DateShrinked") & "'").Length
                vShrink = greenlights.Select("BuildLoc = 'V' and ShrinkwrapStatus = 2 and ShrinkWrap = '" & row("DateShrinked") & "'").Length
                row("MShrinked") = mShrink + vShrink
                sShrink = greenlights.Select("BuildLoc = 'S' and ShrinkwrapStatus = 2 and ShrinkWrap = '" & row("DateShrinked") & "'").Length
                row("SShrinked") = sShrink

                'find the index of the prevMBaseLine and advance prevMShrinked spots to get new baseline
                Dim indexOfPrevMBaseLine As Integer = mProdAndBldg.Rows.IndexOf(mProdAndBldg.Rows.Find(prevMBaseLine))
                Dim indexOfPrevSBaseLine As Integer = sProdAndBldg.Rows.IndexOf(sProdAndBldg.Rows.Find(prevSBaseLine))

                Dim indexofNextMBaseLine As Integer = indexOfPrevMBaseLine + prevMShrinked
                Dim indexofNextSBaseLine As Integer = indexOfPrevSBaseLine + prevSShrinked

                'MesgBox(prevMBaseLine)
                'MesgBox(indexOfPrevMBaseLine)
                'MesgBox(indexofNextMBaseLine)

                'prevMBaseLine = prevMBaseLine + prevMShrinked ' goal - start at this # and move prevMShrinked (39) to the right in the table of Main boats only so that south prod #'s are eliminated.
                'prevSBaseLine = prevSBaseLine + prevSShrinked  'find it in sprod and then advance data rows

                prevMBaseLine = mProdAndBldg(indexofNextMBaseLine)(0) ' goal - start at this # and move prevMShrinked (39) to the right in the table of Main boats only so that south prod #'s are eliminated.
                prevSBaseLine = sProdAndBldg(indexofNextSBaseLine)(0)  'find it in sprod and then advance data rows

                'mBaseLineBldg = mProdAndBldg.Select("ProdNo >= '" & prevMBaseLine & "'")
                'sBaseLineBldg = sProdAndBldg.Select("ProdNo >= '" & prevSBaseLine & "'")

                'MesgBox(prevMBaseLine)
                mBaseLineBldg = mProdAndBldg.Select("ProdNo >= '" & prevMBaseLine & "'")
                sBaseLineBldg = sProdAndBldg.Select("ProdNo >= '" & prevSBaseLine & "'")

                If (mBaseLineBldg(0)(0)) = prevMBaseLine Then
                    row("MBaseLine") = prevMBaseLine
                    prevMShrinked = row("mShrinked")
                Else
                    row("MBaseLine") = mBaseLineBldg(0)(0)
                    prevMBaseLine = mBaseLineBldg(0)(0)
                    prevMShrinked = row("mShrinked")
                End If

                If (sBaseLineBldg(0)(0)) = prevSBaseLine Then
                    row("SBaseLine") = prevSBaseLine
                    prevSShrinked = row("sShrinked")
                Else
                    row("SBaseLine") = sBaseLineBldg(0)(0)
                    prevSBaseLine = sBaseLineBldg(0)(0)
                    prevSShrinked = row("sShrinked")
                End If

            End If

        Next

        lastMBaseline = prevMBaseLine
        lastSBaseLine = prevSBaseLine

        Dim mainView As DataView = mProdAndBldg.DefaultView
        mainView.RowFilter = "ProdNo >= '" & prevMBaseLine & "'"

        Dim southView As DataView = sProdAndBldg.DefaultView
        southView.RowFilter = "ProdNo >= '" & prevSBaseLine & "'"

        gvTest2.DataSource = mainView
        gvTest2.DataBind()

        gvTest3.DataSource = southView
        gvTest3.DataBind()

        lblMDailyGoal.Text = mainView(Convert.ToInt32(lblMainGoal.Text))(0)
        lblMGoal.Text = mainView(Convert.ToInt32(lblMainGoal.Text))(0)
        lblSDailyGoal.Text = southView(Convert.ToInt32(lblSouthGoal.Text))(0)
        lblSGoal.Text = southView(Convert.ToInt32(lblSouthGoal.Text))(0)

        lblTodaysMainBL.Text = lastMBaseline
        lblTodaysSouthBL.Text = lastSBaseLine


        gvBaseLines.DataBind()

        'lblMAhead.Text = dtGLwShip.Select("ProdNo > '" & lblMDailyGoal.Text & "' and (ShippedFlag = 1 or FurnitureStatus > 0) and BuildLoc = 'M'").Length
        'lblSAhead.Text = dtGLwShip.Select("ProdNo > '" & lblSDailyGoal.Text & "' and (ShippedFlag = 1 or FurnitureStatus > 0) and BuildLoc = 'S'").Length

        For Each glRow As DataRow In liveboats.Rows
            If glRow("ProdNo") <= lblMDailyGoal.Text And glRow("ProdNo").ToString > "2100000" And glRow("FurnitureStatus").ToString = "0" And (glRow("BuildLoc").ToString = "M" Or glRow("BuildLoc").ToString = "V") Then

                Dim MShipped As Int16 = shipData.Select("ProdNo = '" & glRow("ProdNo") & "' ").Length

                If MShipped = 0 Then 'only late if it hasn't shipped
                    lateMain.Rows.Add(glRow("ProdNo"), glRow("ItemNo"), glRow("DueDate"), glRow("BuildLoc"))
                End If

            End If

            If glRow("ProdNo") <= lblSDailyGoal.Text.ToString And glRow("ProdNo").ToString > "2100000" And glRow("FurnitureStatus").ToString = 0 And glRow("BuildLoc").ToString = "S" Then
                Dim SShipped As Int16 = shipData.Select("ProdNo = '" & glRow("ProdNo") & "' ").Length

                If SShipped = 0 Then
                    lateSouth.Rows.Add(glRow("ProdNo"), glRow("ItemNo"), glRow("DueDate"))
                End If
            End If

        Next

        gvLate.DataSource = lateMain
        gvLate.DataBind()

        'gvLateV.DataSource = lateValue
        'gvLateV.DataBind()

        gvLateS.DataSource = lateSouth
        gvLateS.DataBind()

        lblBOM.Text = gvLate.Rows.Count
        'lblBOV.Text = gvLateV.Rows.Count
        lblBOS.Text = gvLateS.Rows.Count

        Return False


    End Function

    Public Function LogResults() As String
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        Dim Logged As Date = TodaysDate

        Dim mWip As Int16 = Convert.ToInt32(lblMWIPWfurn.Text)
        Dim mRacks As Int16 = Convert.ToInt32(lblFurnRackM.Text)
        Dim mShipped As Int16 = Convert.ToInt32(lblShipNotRcvdM.Text)
        Dim mTotal As Int16 = Convert.ToInt32(lblMainCurrentTotal.Text)
        Dim mWipGoal As Int16 = Convert.ToInt32(lblMWipGoal.Text)
        Dim mRacksGoal As Int16 = Convert.ToInt32(lblMRackGoal.Text)
        Dim mShippedGoal As Int16 = Convert.ToInt32(lblMTruckGoal.Text)
        Dim mTotalGoal As Int16 = Convert.ToInt32(lblMainGoal.Text)

        Dim mGreened As Int16 = Convert.ToInt32(lblFMain.Text)
        Dim mShrinked As Int16 = Convert.ToInt32(lblShrinkMComplete.Text)
        Dim mBaseline As Int16 = Convert.ToInt32(lblTodaysMainBL.Text)
        Dim mGoal As Int16 = Convert.ToInt32(lblMDailyGoal.Text)
        Dim mNotShipped As Int16 = Convert.ToInt32(lblBOM.Text)
        Dim mShippedAhead As Int16 = Convert.ToInt32(lblMAhead.Text)
        Dim mboBoats As Int16 = Convert.ToInt32(lblMAhead.Text)
        Dim mboLines As Int16 = Convert.ToInt32(BOsM.Text)
        Dim mRGABoats As Int16 = Convert.ToInt32(RGAboatsM.Text)
        Dim mRGALines As Int16 = Convert.ToInt32(RGAsM.Text)

        Dim sWip As Int16 = Convert.ToInt32(lblSWIPWfurn.Text)
        Dim sRacks As Int16 = Convert.ToInt32(lblFurnRackS.Text)
        Dim sShipped As Int16 = Convert.ToInt32(lblShipNotRcvdS.Text)
        Dim sTotal As Int16 = Convert.ToInt32(lblSouthCurrentTotal.Text)
        Dim sWipGoal As Int16 = Convert.ToInt32(lblSWipGoal.Text)
        Dim sRacksGoal As Int16 = Convert.ToInt32(lblSRackGoal.Text)
        Dim sShippedGoal As Int16 = Convert.ToInt32(lblSTruckGoal.Text)
        Dim sTotalGoal As Int16 = Convert.ToInt32(lblSouthGoal.Text)

        Dim sGreened As Int16 = Convert.ToInt32(lblFSouth.Text)
        Dim sShrinked As Int16 = Convert.ToInt32(lblShrinkSComplete.Text)
        Dim sBaseline As Int16 = Convert.ToInt32(lblTodaysSouthBL.Text)
        Dim sGoal As Int16 = Convert.ToInt32(lblSDailyGoal.Text)
        Dim sNotShipped As Int16 = Convert.ToInt32(lblBOS.Text)
        Dim sShippedAhead As Int16 = Convert.ToInt32(lblSAhead.Text)
        Dim sboBoats As Int16 = Convert.ToInt32(lblSAhead.Text)
        Dim sboLines As Int16 = Convert.ToInt32(BOsS.Text)
        Dim sRGABoats As Int16 = Convert.ToInt32(RGABoatsS.Text)
        Dim sRGALines As Int16 = Convert.ToInt32(RGAsS.Text)


        Return False
    End Function



    Protected Sub bntShowUpcoming_Click(sender As Object, e As EventArgs) Handles bntShowUpcoming.Click
        If upcomingLbl.Visible = True Then
            upcomingLbl.Visible = False
            gvTest2.Visible = False
            gvTest3.Visible = False
        Else
            upcomingLbl.Visible = True
            gvTest2.Visible = True
            gvTest3.Visible = True
        End If

    End Sub
End Class

