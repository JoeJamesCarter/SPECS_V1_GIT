Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class YardMaster_OverviewYardMaster
    Inherits System.Web.UI.Page

    Public yardData As New DataTable
    Public IMLSMST As New DataTable
    Public loadData As New DataTable
    Public notLoadedData As New DataTable


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

        dl1.DataBind()
        dl2.DataBind()
        dl3.DataBind()
        dl4.DataBind()
        dl5.DataBind()
        dl6.DataBind()
        dl8.DataBind()
        dl9.DataBind()
        dl10.DataBind()
        dl11.DataBind()
        dl12.DataBind()
        dl13.DataBind()
        dlG1.DataBind()
        dlG2.DataBind()
        dlG3.DataBind()
        dlG4.DataBind()
        dlG5.DataBind()
        dlG6.DataBind()
        dlG7.DataBind()
        dlG8.DataBind()
        Analyze()
    End Sub


    Protected Sub dl1A_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles dl1.ItemDataBound, dl2.ItemDataBound, dl3.ItemDataBound, dl4.ItemDataBound, dl5.ItemDataBound, dl6.ItemDataBound, dl7.ItemDataBound, dl8.ItemDataBound, dl9.ItemDataBound, dl10.ItemDataBound, dl11.ItemDataBound, dl12.ItemDataBound, dl13.ItemDataBound, dlG1.ItemDataBound, dlG2.ItemDataBound, dlG3.ItemDataBound, dlG4.ItemDataBound, dlG5.ItemDataBound, dlG6.ItemDataBound, dlG7.ItemDataBound, dlG8.ItemDataBound

        If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then
            Dim Status As String = e.Item.DataItem("CurrentStatus").ToString
            Dim ActionRequired As String = e.Item.DataItem("ActionRequired").ToString
            Dim RepairedFlag As String = e.Item.DataItem("RepairedFlag").ToString
            Dim ReplacedFlag As String = e.Item.DataItem("ReplacedFlag").ToString

            If e.Item.DataItem("Filled") = 0 Then
                e.Item.BackColor = Drawing.Color.White
            ElseIf (e.Item.DataItem("Filled") = "1" And (Trim(ActionRequired) = "REPAIR" Or Trim(ActionRequired) = "REPLACE") And (RepairedFlag = "0" And ReplacedFlag = "0")) Then
                e.Item.BackColor = Drawing.Color.Red
                e.Item.ForeColor = Drawing.Color.White

            ElseIf e.Item.DataItem("Filled") = "1" And Len(Status) = 0 Then
                e.Item.BackColor = Drawing.Color.White
                e.Item.ForeColor = Drawing.Color.Black


            ElseIf (e.Item.DataItem("Filled") = "1" And (Status = "Sharkhide" Or Status = "Wavetamer" Or Status = "Rigging")) Then
                e.Item.BackColor = Drawing.Color.Red
                e.Item.ForeColor = Drawing.Color.White
            End If

            Dim prod As String = tbBoat.Text

            Try
                If e.Item.DataItem("Filled") = "1" And Trim(e.Item.DataItem("ProdNo")) = prod Then
                    e.Item.BackColor = Drawing.Color.Green
                    e.Item.ForeColor = Drawing.Color.White
                End If
            Catch ex As Exception

            End Try
        End If

    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click

        dl1.DataBind()
        dl2.DataBind()
        dl3.DataBind()
        dl4.DataBind()
        dl5.DataBind()
        dl6.DataBind()
        dl7.DataBind()
        dl8.DataBind()
        dl9.DataBind()
        dl10.DataBind()
        dl11.DataBind()
        dl12.DataBind()
        dl13.DataBind()
        dlG1.DataBind()
        dlG2.DataBind()
        dlG3.DataBind()
        dlG4.DataBind()
        dlG5.DataBind()
        dlG6.DataBind()
        dlG7.DataBind()
        dlG8.DataBind()


    End Sub
    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbBoat.Text = ""
        ddlDealers.SelectedIndex = -1

        dl1.DataBind()
        dl2.DataBind()
        dl3.DataBind()
        dl4.DataBind()
        dl5.DataBind()
        dl6.DataBind()
        dl7.DataBind()
        dl8.DataBind()
        dl9.DataBind()
        dl10.DataBind()
        dl11.DataBind()
        dl12.DataBind()
        dl13.DataBind()
        dlG1.DataBind()
        dlG2.DataBind()
        dlG3.DataBind()
        dlG4.DataBind()
        dlG5.DataBind()
        dlG6.DataBind()
        dlG7.DataBind()
        dlG8.DataBind()


    End Sub
    Protected Sub btnSearchDealer_Click(sender As Object, e As EventArgs) Handles btnSearchDealer.Click
        dl1.DataBind()
        dl2.DataBind()
        dl3.DataBind()
        dl4.DataBind()
        dl5.DataBind()
        dl6.DataBind()
        dl7.DataBind()
        dl8.DataBind()
        dl9.DataBind()
        dl10.DataBind()
        dl11.DataBind()
        dl12.DataBind()
        dl13.DataBind()
        dlG1.DataBind()
        dlG2.DataBind()
        dlG3.DataBind()
        dlG4.DataBind()
        dlG5.DataBind()
        dlG6.DataBind()
        dlG7.DataBind()
        dlG8.DataBind()

    End Sub
    Protected Sub dl1_ItemCommand(source As Object, e As DataListCommandEventArgs) Handles dl1.ItemCommand, dl2.ItemCommand, dl3.ItemCommand, dl4.ItemCommand, dl5.ItemCommand, dl6.ItemCommand, dl7.ItemCommand, dl8.ItemCommand, dl9.ItemCommand, dl10.ItemCommand, dl11.ItemCommand, dl12.ItemCommand, dl13.ItemCommand, dlG1.ItemCommand, dlG2.ItemCommand, dlG3.ItemCommand, dlG4.ItemCommand, dlG5.ItemCommand, dlG6.ItemCommand, dlG7.ItemCommand, dlG8.ItemCommand

        If e.CommandName = "gotoredtag" Then 'handles when the notes button is clicked

            Dim Prod As String = e.CommandArgument 'get the row that is clicked
            Dim workstation As String = "YardMaster " 'to pass in the workstation that makes the note.

            Dim url As String = "../RedTags.aspx?ws=" & workstation & "&ProdNo=" & Prod

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)

        End If

    End Sub

    Private Sub YardMaster_OverviewYardMaster_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim sqldataadapter As New SqlDataAdapter
        Dim sqldataadapter2 As New SqlDataAdapter
        Dim sqldataadapter3 As New SqlDataAdapter

        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1

        Dim conn2 As New SqlConnection()
        Dim connstr2 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn2.ConnectionString = connstr2

        conn1.Open()

        'sqldataadapter.SelectCommand = New SqlCommand("Select Case Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,Case When BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 3 order by BML_POPREPORTING_GREENLIGHTS.ProdNo", conn1)
        sqldataadapter.SelectCommand = New SqlCommand("Select t3.Loaded, t3.DateLoaded, t1.*, Case When t2.SharkhideStatus = '1' Then 'Sharkhide' When t2.WavetamerStatus ='1' Then 'Wavetamer' When t2.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, t2.CusNo, t2.IsRedTagged, t3.Shipper, t4.ReplaceReqdFlag, t4.RepairReqdFlag, t4.ReplacedFlag, t4.RepairedFlag from Yard_Master_Locations t1 left join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Left Join Load_Scheduling t3 on t2.ProdNo = t3.ProdNo Left Join Tubes_DamageReported t4 on t1.ProdNo = t4.ProdNo and ((ReplaceReqdFlag = 1 and ReplacedFlag = 0) or (RepairReqdFlag = 1 and RepairedFlag = 0)) where t1.Filled = 1", conn1)
        sqldataadapter.Fill(yardData)

        sqldataadapter3.SelectCommand = New SqlCommand("Select * From Load_Scheduling Where Loaded = 1 Order By ProdNo", conn1)
        sqldataadapter3.Fill(loadData)

        sqldataadapter3.SelectCommand = New SqlCommand("Select * From Load_Scheduling Where Loaded = 0 Order By ProdNo", conn1)
        sqldataadapter3.Fill(notLoadedData)

        conn1.Close()

        conn2.Open()
        sqldataadapter2.SelectCommand = New SqlCommand("Select ser_lot_no as SerialNo, mfg_ser_lot_no as ProdNo, orig_ord_no as PopNo, cus_no, cus_name From dbo.IMLSMST_Sql Left Join PPORDFIL_SQL on IMLSMST_SQL.orig_ord_no = PPORDFIL_SQL.ord_no where pkg_id ='PP' order by mfg_ser_lot_no", conn2)
        sqldataadapter2.Fill(IMLSMST)


        conn2.Close()

        'MesgBox(yardData.Rows.Count)
        'MesgBox(IMLSMST.Rows.Count)
        Analyze()
    End Sub

    Protected Function Analyze() As String
        Dim lbTotalNumBoats As Label = CType(FindControl("lblTotalnumboats"), Label)
        Dim wavetamer As Integer = 0
        Dim sharkhide As Integer = 0
        Dim rigging As Integer = 0
        Dim redtag As Integer = 0
        Dim pickups As Integer = 0
        Dim reorder As Integer = 0
        Dim repair As Integer = 0
        Dim loadednotinvoiced As Integer = 0
        Dim notloaded As Integer = 0
        Dim stock As Integer = 0

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        cmd.Connection = conn
        conn.ConnectionString = connstr
        conn.Open()
        cmd.CommandText = "Select Count (*) FROM Yard_Master_Locations where Filled = 1"
        lblTotalnumboats.Text = cmd.ExecuteScalar
        conn.Close()


        Dim lblSharkhide As Label = CType(FindControl("lblSharkhide"), Label)
        Dim lblwt As Label = CType(FindControl("lblwt"), Label)
        Dim lblrigging As Label = CType(FindControl("lblrigging"), Label)
        Dim lblredtags As Label = CType(FindControl("lblredtags"), Label)
        Dim lblScheduled As Label = CType(FindControl("lblScheduled"), Label)
        Dim lblInIMLSMST As Label = CType(FindControl("lblIMLSMST"), Label)
        Dim lblIMLSMSTNotLoaded As Label = CType(FindControl("lblIMLSMSTNotLoaded"), Label)
        Dim lblStock As Label = CType(FindControl("lblstock"), Label)

        lblInIMLSMST.Text = IMLSMST.Rows.Count

        For Each row As DataRow In yardData.Rows
            If row("CurrentStatus").ToString Is Nothing Then

            ElseIf row("CurrentStatus").ToString = "Rigging" Then
                rigging += 1
            ElseIf row("CurrentStatus").ToString = "Wavetamer" Then
                wavetamer += 1
            ElseIf row("CurrentStatus").ToString = "Sharkhide" Then
                sharkhide += 1
            End If


            If row("CusNo").ToString = "50" Or row("CusNo").ToString = "000000000050" Then
                stock += 1
            End If

            If row("IsRedTagged").ToString = "1" Then
                redtag += 1
            End If

            Try
                If row("Shipper").ToString Is Nothing Then

                ElseIf Trim(row("Shipper")) = "PickUp" Then
                    pickups += 1
                End If
            Catch
            End Try


            Try
                If row("replacereqdflag") = 1 And row("replacedflag") = 0 Then
                    reorder += 1
                End If
            Catch ex As Exception

            End Try

            Try
                If row("repairreqdflag") = 1 And row("repairedflag") = 0 Then
                    repair += 1
                End If
            Catch ex As Exception

            End Try

        Next

        lblSharkhide.Text = sharkhide
        lblwt.Text = wavetamer
        lblrigging.Text = rigging
        lblredtags.Text = redtag
        lblPickups.Text = pickups
        lblreorders.Text = reorder
        lblrepairs.Text = repair


        For Each invRow In IMLSMST.Rows

            Dim prodtolookfor As String = invRow("ProdNo")

            Dim existsInYardMaster() As DataRow = yardData.Select("ProdNo =  '" & prodtolookfor & "'")

            If existsInYardMaster.Length = 0 Then 'not in yard but in the IMLSMST
                Dim isitloaded() As DataRow = loadData.Select("ProdNo =  '" & prodtolookfor & "'")
                If isitloaded.Length > 0 Then
                    loadednotinvoiced += 1
                End If

            ElseIf existsInYardMaster.Length > 0 Then
                Dim isitnotloaded() As DataRow = notLoadedData.Select("ProdNo =  '" & prodtolookfor & "'")
                If isitnotloaded.Length > 0 Then 'in serial table, not in yard and not loaded
                    notloaded += 1
                End If
            End If

            Try
                If invRow("cus_name") Like "*PONTOON BOAT, LLC*" Then
                    stock += 1
                End If
            Catch
            End Try


        Next

        lblStock.Text = stock

        lblScheduled.Text = loadednotinvoiced
        lblIMLSMSTNotLoaded.Text = notloaded

        Return False


    End Function
End Class
