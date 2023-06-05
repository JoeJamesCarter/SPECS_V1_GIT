Imports System.Data
Imports System.Data.SqlClient

Partial Class OverviewByDealer
    Inherits System.Web.UI.Page

    Public boatsFinished As New DataTable
    Public distinctDlrsFinished As New DataTable
    Public boatsInWIP As New DataTable
    Public distinctDlrsInWIP As New DataTable
    Public distinctDlrs As New DataTable
    Public loadInfo As New DataTable
    Public tubedamage As New DataTable
    Public holdList As New DataTable
    Public hotList As New DataTable


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub OverviewByDealer_Load(sender As Object, e As EventArgs) Handles Me.Load
        PopulateDataTables()

        distinctDlrsFinished = GetDistinctRecords(boatsFinished, {"CusNo", "CusName"})
        distinctDlrsInWIP = GetDistinctRecords(boatsInWIP, {"CusNo", "CusName"})

        'dlDealersWithBoats.DataSource = distinctDlrsFinished
        'dlDealersWithBoats.DataBind()


        Dim dtAll As New DataTable
        dtAll.Merge(distinctDlrsFinished)
        dtAll.Merge(distinctDlrsInWIP)

        Dim dealers As New DataTable
        dealers = GetDistinctRecords(dtAll, {"CusNo", "CusName"})
        dealers.DefaultView.Sort = "CusName"

        'DataList1.DataSource = dealers
        'DataList1.DataBind()

        dlDealersWBoats.DataSource = dealers
        dlDealersWBoats.DataBind()

    End Sub

    Public Function PopulateDataTables() As String

        Dim sqldataadapter As New SqlDataAdapter
        Dim sqldataadapter1 As New SqlDataAdapter
        Dim sqldataadapter2 As New SqlDataAdapter
        Dim sqldataadapter3 As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim conn1 As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        conn1.ConnectionString = connstr1

        'Try
        conn.Open()
        sqldataadapter.SelectCommand = New SqlCommand("SELECT IMLSMST_SQL.item_no, IMLSMST_SQL.mfg_ser_lot_no, IMLSMST_SQL.ser_lot_no, RTrim(PPORDFIL_SQL.cus_no) as CusNo, RTrim(ARCUSFIL_SQL.cus_name) as CusName FROM IMLSMST_SQL Inner join PPORDFIL_SQL on IMLSMST_SQL.mfg_ser_lot_no = PPORDFIL_SQL.user_def_fld_1 left join ARCUSFIL_SQL on PPORDFIL_SQL.cus_no = ARCUSFIL_SQL.cus_no Where (IMLSMST_SQL.mfg_ser_lot_no like '1%' OR IMLSMST_SQL.mfg_ser_lot_no like '2%') Order By ARCUSFIL_SQL.cus_name", conn)
        sqldataadapter.Fill(boatsFinished)
        conn.Close()
        'MesgBox(boatsFinished.Rows.Count)

        conn1.Open()

        sqldataadapter1.SelectCommand = New SqlCommand("SELECT t1.ProdNo, RTrim(t1.CusNo) as CusNo, RTrim(t1.CusName) as CusName, t2.*,cast(t2.GaugeStatus as varchar) + cast(t2.HarnessStatus as varchar) as ElectricalStatus, t3.PF_Received, t3.PR_Received ,t3.SF_Received, t3.SR_Received, t3.T_Received, t3.PM_Received, t3.SM_Received, t3.NeedsTransom, t3.NeedsPortMid, t3.NeedsStrbMid,t3.CustDrawNo,(CASE WHEN cast(t3.PF_Received as varchar) = 1 THEN '2' ELSE cast(t3.PF_Received as varchar) END) + (CASE WHEN cast(t3.SF_Received as varchar) = 1 THEN '2' ELSE cast(t3.SF_Received as varchar) END) as QFrontRailsStatus, CASE When t2.CompleteStatus = '2' Then 'Complete' WHEN t2.SharkhideStatus = '1' Then 'Sharkhide' When t2.WavetamerStatus ='1' Then 'Wavetamer' When t2.RiggingStatus ='1' Then 'Rigging' When t2.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When t2.CleaningStatus ='1' Then 'Inspection' When t2.FinalInspectionStatus ='1' Then 'Final' When t2.HelmInstalledStatus ='1' Then 'Helm' When t2.FurnitureInstalledStatus ='1' Then 'Furniture' When ((t2.RailsInstalledStatus ='1' and t2.BuildLoc= 'M') or (t2.RailsInstalledStatus ='1' and IsDeckInside ='1' and t2.BuildLoc ='S')) Then 'Rails' When t2.FloorsInstalledStatus ='1' Then 'Floors' When t2.TrimStatus ='1' Then 'Trim' When t2.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus, t4.ActualLoadDate as PlannedLoadDate, t4.DateLoaded, t4.Shipper, Case When t5.Disabled is not null Then '1' else '0' End as HotFlag, t6.ActionRequired, t7.DateReturning as Returning, HoldFlag, HoldPer, Hold  FROM BML_POPREPORTING t1 left join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Left join Rails_Tracking t3 on t1.ProdNo = t3.ProdNo Left Join Load_Scheduling t4 on t1.ProdNo = t4.ProdNo left join HotList t5 on t1.ProdNo = t5.ProdNo Left join Tubes_DamageReported t6 on t1.ProdNo = t6.ProdNo Left Join DlrReturnsFromCovid t7 on t1.CusNo = t7.DlrNo Order By t1.ProdNo", conn1)
        'Where ((t2.BuildLoc ='M' and t2.FloorsInstalledStatus = 2) or (t2.BuildLoc = 'S' and IsDeckInside = '1')) 
        sqldataadapter1.Fill(boatsInWIP)


        sqldataadapter2.SelectCommand = New SqlCommand("SELECT * From Load_Scheduling Order By ProdNo", conn1)
        sqldataadapter2.Fill(loadInfo)

        'MesgBox(loadInfo.Rows.Count)

        'sqldataadapter3.SelectCommand = New SqlCommand("SELECT t2.ProdNo, Hold, HoldFlag, HoldPer,  0 as HotFlag From BML_POPREPORTING_GREENLIGHTS t1 Where ShrinkwrapStatus =2 and t1.ProdNo > 1900000 ", conn1)
        sqldataadapter3.SelectCommand = New SqlCommand("SELECT t1.ProdNo, Hold, Cast(HoldFlag as varchar) as HoldFlag, HoldPer From BML_POPREPORTING_GREENLIGHTS t1 Where ShrinkwrapStatus =2 and t1.ProdNo > 2100000 ", conn1)
        sqldataadapter3.Fill(holdList)


        sqldataadapter3.SelectCommand = New SqlCommand("SELECT * From HotList", conn1)
        sqldataadapter3.Fill(hotList)


        conn1.Close()

        'Catch
        'End Try

        conn.Close()
        conn.Dispose()

        conn1.Close()
        conn1.Dispose()

        Return False

    End Function

    Public Shared Function GetDistinctRecords(ByVal dt As DataTable, ByVal Columns As String()) As DataTable
        Dim dtUniqRecords As DataTable = New DataTable()
        dtUniqRecords = dt.DefaultView.ToTable(True, Columns)
        Return dtUniqRecords
    End Function

    Protected Sub dlDealersWBoats_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles dlDealersWBoats.ItemDataBound
        Dim cusno As String = DirectCast(e.Item.FindControl("lblCusNo"), Label).Text.ToString
        Dim gvCompletedBoats As GridView = DirectCast(e.Item.FindControl("gvCompletedBoats"), GridView)
        Dim gvWip As GridView = DirectCast(e.Item.FindControl("gvWip"), GridView)
        'Dim gvRails As GridView = DirectCast(e.Item.FindControl("gvRails"), GridView)
        Dim lblPlannedRtn As Label = DirectCast(e.Item.FindControl("lblPlanningtoReturn"), Label)

        Dim finBoatsView As DataView = boatsFinished.DefaultView
        finBoatsView.RowFilter = "CusNo = " & cusno
        gvCompletedBoats.DataSource = finBoatsView
        gvCompletedBoats.DataBind()

        Dim wipBoatsView As DataView = boatsInWIP.DefaultView
        wipBoatsView.RowFilter = "CusNo = " & cusno

        'For Each rowView As DataRowView In wipBoatsView
        '    Dim row As DataRow = rowView.Row
        '    Try
        '        Dim returning As String = row("Returning").ToString
        '        returning = Left(returning, Len(returning) - 12)
        '        lblPlannedRtn.Text = returning
        '    Catch
        '    End Try

        'Next


        gvWip.DataSource = wipBoatsView
        gvWip.DataBind()



    End Sub

    Protected Sub gvWip_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If

            Try
                If (e.Row.DataItem("BuildLoc") = "M" Or e.Row.DataItem("BuildLoc") = "V") And
                   (e.Row.DataItem("FurnitureStatus") = "2" Or e.Row.DataItem("FurnitureStatus") = "3") And
                   e.Row.DataItem("FiberglassStatus") = "2" And
                   e.Row.DataItem("CoversStatus") >= 1 And
                   e.Row.DataItem("RailsStatus") = 2 And
                   e.Row.DataItem("TubesStatus") = 2 And
                   e.Row.DataItem("FramesInstalledStatus") = 2 And
                   e.Row.DataItem("GaugeStatus") = 2 And
                   e.Row.DataItem("HarnessStatus") = 2 And
                   ((e.Row.DataItem("CenterTubeNeeded") = 1 And e.Row.DataItem("CenterTubeStatus") = 2) Or e.Row.DataItem("CentertubeNeeded") = 0) Then
                    e.Row.Cells(0).BackColor = Drawing.Color.LightGreen

                ElseIf (e.Row.DataItem("BuildLoc") = "S") And
                   (e.Row.DataItem("FurnitureStatus") = "2" Or e.Row.DataItem("FurnitureStatus") = "3") And
                   e.Row.DataItem("FiberglassStatus") = "2" And
                   e.Row.DataItem("CoversStatus") >= 1 And
                   e.Row.DataItem("RailsStatus") = 2 And
                   e.Row.DataItem("TubesStatus") = 2 And
                   e.Row.DataItem("FramesInstalledStatus") = 2 And
                   e.Row.DataItem("TrimStatus") = 2 And
                   e.Row.DataItem("GaugeStatus") = 2 And
                   e.Row.DataItem("HarnessStatus") = 2 And
                   ((e.Row.DataItem("CenterTubeNeeded") = 1 And e.Row.DataItem("CenterTubeStatus") = 2) Or e.Row.DataItem("CentertubeNeeded") = 0) And
                    ((e.Row.DataItem("QFrontNeeded") = 1 And e.Row.DataItem("QFrontStatus") = 2) Or e.Row.DataItem("QFrontNeeded") = 0) And
                   ((e.Row.DataItem("ArchTowerNeeded") = 1 And e.Row.DataItem("ArchTowerStatus") = 2) Or e.Row.DataItem("ArchTowerNeeded") = 0) Then
                    e.Row.Cells(0).BackColor = Drawing.Color.LightGreen

                End If

            Catch ex As Exception

            End Try
        End If
    End Sub

    Protected Sub gvCompletedBoats_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim planned As Label = CType(e.Row.FindControl("lblPlanned"), Label)
            Dim actual As Label = CType(e.Row.FindControl("lblLoaded"), Label)
            Dim shipper As Label = CType(e.Row.FindControl("lblShipper"), Label)
            Dim prodno As String = Trim(e.Row.DataItem("mfg_ser_lot_no"))
            Dim imgHot As Image = CType(e.Row.FindControl("imgHot"), Image)
            Dim imgHold As Image = CType(e.Row.FindControl("imgHold"), Image)

            Dim loadInfoView As DataView = loadInfo.DefaultView
            loadInfoView.RowFilter = "ProdNo = " & prodno

            Dim holdInfoView As DataView = holdList.DefaultView
            holdInfoView.RowFilter = "ProdNo = " & prodno

            Dim hotListInfo As DataView = hotList.DefaultView
            hotListInfo.RowFilter = "ProdNo = " & prodno

            'If e.Row.Cells(0).Text Like "2005367*" Then
            '    MesgBox(holdInfoView(0)(2).ToString)
            '    MesgBox(holdInfoView(0)(4).ToString)
            '    'MesgBox(holdInfoView(0)(1).ToString)
            '    'MesgBox(holdInfoView(0)(1).ToString)
            'End If

            If holdInfoView.Count = 1 Then
                If holdInfoView(0)(2).ToString = "1" Then
                    imgHold.Visible = True
                End If

            End If

            If hotListInfo.Count = 1 Then
                If hotListInfo(0)(2).ToString = "1" Then
                    imgHot.Visible = True
                End If

            End If

            If loadInfoView.Count = 1 Then

                Dim actualText As String = loadInfoView(0)("DateOnTrailer").ToString
                Dim plannedText As String = loadInfoView(0)(3).ToString

                'Try
                If actualText Is Nothing Then
                    actual.Text = ""
                Else
                    actual.Text = actualText
                End If

                If loadInfoView(0)(3).ToString Is Nothing Then
                    planned.Text = ""
                Else
                    planned.Text = plannedText
                End If

                If loadInfoView(0)(4) Is Nothing Then
                    shipper.Text = ""
                Else
                    shipper.Text = loadInfoView(0)(4).ToString()
                End If

                'Catch
                'End Try


            End If


        End If
    End Sub
    Protected Sub gvWip_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "gotoredtag" Then 'handles when the notes button is clicked

            'Dim Prod As String = e.CommandArgument 'get the row that is clicked
            'Dim workstation As String = "OVByDealer" 'to pass in the workstation that makes the note.

            'Dim url As String = "../RedTags.aspx?ws=" & workstation & "&ProdNo=" & Prod

            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If
    End Sub
End Class
