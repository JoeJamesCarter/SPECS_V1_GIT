Imports System.Data
Imports System.Data.SqlClient
Partial Class Transport
    Inherits System.Web.UI.Page

    Public boatdetails As New DataTable
    Public openRequests As New DataTable

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class

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

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Dim lblProdNo As Label
        Dim BoatNotesProdNo As String
        Dim workstation As String
        Dim direction As String

        BoatNotesProdNo = Request.QueryString("ProdNo")
        workstation = Request.QueryString("ws")
        'direction = Request.QueryString("direction")

        If workstation = "Floors" Then
            direction = "to"
            lblType.Text = "Frame"

        ElseIf workstation = "Decks" Then
            direction = "to"
            lblType.Text = "Deck"

        ElseIf workstation = "Trim" Then
            direction = "from"
            lblType.Text = "Deck"

        ElseIf workstation = "Shrinkwrap" Then
            direction = "from"
            lblType.Text = "Boat"
        Else
            direction = "either"
            lblType.Text = "Boat"
        End If

        lblProdNo.Text = BoatNotesProdNo
        lblProd.Text = BoatNotesProdNo

        lblWS.Text = workstation
        lblReq.Text = workstation


        If direction = "to" Then
            cblPickupOrDropOff.SelectedValue = "DropOff"
            lblRequest.Text = "Dropped Off To "
        ElseIf direction = "from" Then
            cblPickupOrDropOff.SelectedValue = "PickUp"
            lblRequest.Text = "Picked Up From "
        End If


        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)

        'lblReqdBy.Text = GlobalVariables.stationID

        PopulateDataTables()


    End Sub

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything


        Dim sqldataadapter As New SqlDataAdapter
        Dim sqldataadapter1 As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        'Try
        conn.Open()

        sqldataadapter.SelectCommand = New SqlCommand("SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, FramesInstalledStatus, FloorsInstalledStatus, TrimStatus, RailsStatus, ShrinkwrapStatus, IsDeckInside, BuildLoc, ItemNo, SlotKey, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus From BML_POPREPORTING_GREENLIGHTS Left Join Yard_Master_Locations t2 on BML_POPREPORTING_GREENLIGHTS.ProdNo = t2.ProdNo where BML_POPREPORTING_GREENLIGHTS.ProdNo =  '" & lblProdNo.Text & "'", conn)
        sqldataadapter.Fill(boatdetails)

        sqldataadapter.SelectCommand = New SqlCommand("SELECT ProdNo, DateReqd From TransportReqs where ToOrFrom =  '" & lblReq.Text & "' and Status = 0 order by ProdNo", conn)
        sqldataadapter.Fill(openRequests)

        lblBoatModel.Text = boatdetails(0)(8).ToString
        lblBuildLoc.Text = boatdetails(0)(7).ToString
        lblYardLoc.Text = boatdetails(0)(9).ToString
        lblCurrentStatus.Text = boatdetails(0)(10).ToString

        'Dim framed As String = boatdetails(0)(1).ToString
        'Dim floored As String = boatdetails(0)(2).ToString
        'Dim trimmed As String = boatdetails(0)(3).ToString
        'Dim railed As String = boatdetails(0)(4).ToString
        'Dim shrink As String = boatdetails(0)(5).ToString
        'Dim buildloc As String = boatdetails(0)(7).ToString

        'If shrink = "2" Or railed = "2" Then
        '    lblType.Text = "Boat"
        'ElseIf trimmed = "2" And buildloc = "S" And railed = "1" Then
        '    lblType.Text = "Deck"
        'ElseIf framed = "2" And floored = "1" Then
        '    lblType.Text = "Frame"
        'End If


        conn.Close()
        conn.Dispose()

        gvRequestedBoats.DataSource = openRequests
        gvRequestedBoats.DataBind()

        Return False

    End Function

    Private Sub cblPickupOrDropOff_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cblPickupOrDropOff.SelectedIndexChanged
        If cblPickupOrDropOff.SelectedValue = "DropOff" Then
            lblRequest.Text = "Dropped Off To "
        ElseIf cblPickupOrDropOff.SelectedValue = "PickUp" Then
            lblRequest.Text = "Picked Up From "
        End If
        lblRequest.DataBind()


    End Sub

    Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        Dim prod As String = lblProdNo.Text
        Dim stucture As String = lblType.Text
        Dim daterequested As Date = Date.Now
        Dim workstation As String = lblReq.Text
        Dim direction As String = cblPickupOrDropOff.SelectedValue


        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@Prod", prod)
        cmd.Parameters.AddWithValue("@Type", stucture)
        cmd.Parameters.AddWithValue("@DateReqd", daterequested)
        cmd.Parameters.AddWithValue("@Action", direction)
        cmd.Parameters.AddWithValue("@ToOrFrom", workstation)
        cmd.Parameters.AddWithValue("@Status", 1)

        cmd.CommandText = "Insert Into TransportReqs(ProdNo, Structure, DateReqd, Action, ToOrFrom, Status) Values (@Prod, @Type, @DateReqd, @Action, @ToOrFrom, @Status) "

        conn.Open()
        cmd.ExecuteNonQuery()
        MesgBox("Request Sent")
        conn.Close()

    End Sub

    Protected Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")
    End Sub
End Class
