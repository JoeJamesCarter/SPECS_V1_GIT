Imports System.Data
Imports System.Data.SqlClient
Imports MySql.Data.MySqlClient
Partial Class FGDelivery
    Inherits System.Web.UI.Page

    Public veadaShipDataMain As New DataTable
    Public veadaShipDataSouth As New DataTable
    Public boatsRedFurnM As New DataTable
    Public boatsRedFurnS As New DataTable
    Public MShippedNotRcvd As New DataTable
    Public SShippedNotRcvd As New DataTable
    Public MNotShipped As New DataTable
    Public SNotShipped As New DataTable
    Public MMissingSomeRails As New DataTable
    Public SMissingSomeRails As New DataTable
    Public FabOptionsPrerigs As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub
    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        PopulateDataTables()
        MainPri1.DataBind()
        MainPri2.DataBind()
        MainPri3.DataBind()
        MainPri4.DataBind()
        MainPri5.DataBind()

        SouthPri1.DataBind()
        SouthPri2.DataBind()
        SouthPri3.DataBind()
        SouthPri4.DataBind()
        SouthPri5.DataBind()


    End Sub

    Private Sub FGRepairTV_Load(sender As Object, e As EventArgs) Handles Me.Load
        ' If Not IsPostBack Then
        MShippedNotRcvd.Columns.Add("ProdNoShort")
            SShippedNotRcvd.Columns.Add("ProdNoShort")
            MNotShipped.Columns.Add("ProdNoShort")
            SNotShipped.Columns.Add("ProdNoShort")
            MMissingSomeRails.Columns.Add("ProdNoShort")
            SMissingSomeRails.Columns.Add("ProdNoShort")

            MShippedNotRcvd.Columns.Add("BaseVinylColor")
            SShippedNotRcvd.Columns.Add("BaseVinylColor")
            MNotShipped.Columns.Add("BaseVinylColor")
            SNotShipped.Columns.Add("BaseVinylColor")
            MMissingSomeRails.Columns.Add("BaseVinylColor")
            SMissingSomeRails.Columns.Add("BaseVinylColor")

            MShippedNotRcvd.Columns.Add("ProdNo")
            SShippedNotRcvd.Columns.Add("ProdNo")
            MNotShipped.Columns.Add("ProdNo")
            SNotShipped.Columns.Add("ProdNo")
            MMissingSomeRails.Columns.Add("ProdNo")
        SMissingSomeRails.Columns.Add("ProdNo")

        MShippedNotRcvd.Columns.Add("ItemNo")
        SShippedNotRcvd.Columns.Add("ItemNo")
        MNotShipped.Columns.Add("ItemNo")
        SNotShipped.Columns.Add("ItemNo")
        MMissingSomeRails.Columns.Add("ItemNo")
        SMissingSomeRails.Columns.Add("ItemNo")

        ' End If
        If Not IsPostBack Then
            PopulateDataTables()
        End If

    End Sub


    Private Sub MainPri1_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles MainPri1.ItemCommand, MainPri2.ItemCommand, MainPri3.ItemCommand, MainPri4.ItemCommand, MainPri5.ItemCommand, SouthPri1.ItemCommand, SouthPri2.ItemCommand, SouthPri3.ItemCommand, SouthPri4.ItemCommand, SouthPri5.ItemCommand
        If e.CommandName = "gotoBringIn" Then
            Dim prod As String = e.CommandArgument
            'MesgBox(prod.ToString)

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            Dim TodaysDate As Date = Date.Now

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FiberglassInspStatus = 1, FiberglassInsp = '" & TodaysDate & "' where ProdNo =  '" & prod & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            PopulateDataTables()
            MainPri1.DataBind()
            MainPri2.DataBind()
            MainPri3.DataBind()
            MainPri4.DataBind()
            MainPri5.DataBind()

            SouthPri1.DataBind()
            SouthPri2.DataBind()
            SouthPri3.DataBind()
            SouthPri4.DataBind()
            SouthPri5.DataBind()


        End If

    End Sub

    Private Sub MainPri5_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles MainPri5.ItemDataBound, SouthPri5.ItemDataBound, MainPri1.ItemDataBound, MainPri2.ItemDataBound, MainPri3.ItemDataBound, MainPri4.ItemDataBound, SouthPri2.ItemDataBound, SouthPri2.ItemDataBound, SouthPri3.ItemDataBound, SouthPri4.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then

            Dim ProdNo As String = DataBinder.Eval(e.Item.DataItem, "ProdNo")
            Dim lblPrerig As Label = DirectCast(e.Item.FindControl("lblPrerig"), Label)

            Dim prerigrecord As DataRow()

            Try
                prerigrecord = FabOptionsPrerigs.Select("ProdNo = '" & ProdNo & "'")
                lblPrerig.Text = prerigrecord(0)(1)
            Catch

            End Try


        End If

    End Sub

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
        Dim mysqldataadapter As New MySqlDataAdapter
        Dim conn As New MySqlConnection()
        Dim connstr As String = "server=veada-mysql-082019.cz8vw0a6whxb.us-east-1.rds.amazonaws.com;user id=BennDataPartner;password=DISH4087sky$$;persistsecurityinfo=True;database=vea_0819_dbshare"
        conn.ConnectionString = connstr

        conn.Open()
        mysqldataadapter.SelectCommand = New MySqlCommand("Select Trim(Convert(ProdNo, CHAR)) as ProdNo, Shipped, TruckNum FROM BennShipping_Shipped where ProdNo > '2100000' and Line like 'S%' order by ProdNo ", conn)
        mysqldataadapter.Fill(veadaShipDataMain)

        mysqldataadapter.SelectCommand = New MySqlCommand("Select Trim(Convert(ProdNo, CHAR)) as ProdNo, Shipped, TruckNum FROM BennShipping_Shipped where ProdNo > '2100000' and Line not like 'S%' order by ProdNo ", conn)
        mysqldataadapter.Fill(veadaShipDataSouth)

        conn.Close()
        conn.Dispose()

        Dim sqldataadapter As New SqlDataAdapter
        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1

        'Try
        conn1.Open()
        sqldataadapter.SelectCommand = New SqlCommand("SELECT RTrim(t1.ProdNo) as ProdNo, RailsStatus, HasAllRails, Left(t1.BaseVinylColor,3) as BaseVinylColor, t1.ItemNo From BML_POPREPORTING t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Left Join Rails_Tracking t3 on t1.ProdNo = t3.ProdNo Where FurnitureStatus = 0 and t2.BuildLoc = 'M' and FiberglassInspStatus = 0 and FiberglassStatus = 2 order by ProdNo", conn1)
        sqldataadapter.Fill(boatsRedFurnM)

        sqldataadapter.SelectCommand = New SqlCommand("SELECT RTrim(t1.ProdNo) as ProdNo, RailsStatus, HasAllRails, Left(t1.BaseVinylColor,3) as BaseVinylColor, t1.ItemNo From BML_POPREPORTING t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Left Join Rails_Tracking t3 on t1.ProdNo = t3.ProdNo Where FurnitureStatus = 0 and t2.BuildLoc = 'S'  and FiberglassInspStatus = 0 and FiberglassStatus = 2 order by ProdNo", conn1)
        sqldataadapter.Fill(boatsRedFurnS)

        Dim sqldataadapter1 As New SqlDataAdapter
        sqldataadapter1.SelectCommand = New SqlCommand("SELECT RTrim(t1.ProdNo) as ProdNo, Case when Option_Desc like '%YAM%' then 'YAM' when Option_Desc like '%MER%' then 'MER' End as PreRig From BML_POPREPORTING t1 Left Join BML_POPREPORTINGFABOPTIONS t2 on t1.ProdNo = t2.ProdNo Where Workcenter = 'Fiberglass' and Option_Desc Like  '%PRERIG%' order by ProdNo", conn1)
        sqldataadapter1.Fill(FabOptionsPrerigs)


        conn1.Close()
        conn1.Dispose()




        For Each row As DataRow In boatsRedFurnM.Rows

            Dim prod As String = row("ProdNo").ToString
            Dim color As String = row("BaseVinylColor").ToString
            Dim itemno As String = row("ItemNo").ToString
            Dim hasallrails As Integer = row("HasAllRails")
            Dim railsstatus As Integer = row("RailsStatus")

            Dim prodShort As String = Right(prod, 5)
            Dim view As DataView = veadaShipDataMain.DefaultView
            view.RowFilter = "ProdNo = " + prod
            If view.Count > 0 Then
                MShippedNotRcvd.Rows.Add(prodShort, color, prod, itemno)
            Else
                If hasallrails = 1 Or railsstatus >= 1 Or railsstatus = -1 Then
                    MNotShipped.Rows.Add(prodShort, color, prod, itemno)
                Else
                    MMissingSomeRails.Rows.Add(prodShort, color, prod, itemno)
                End If

            End If

        Next

        For Each row As DataRow In boatsRedFurnS.Rows

            Dim prod As String = row("ProdNo").ToString
            Dim color As String = row("BaseVinylColor").ToString
            Dim itemno As String = row("ItemNo").ToString
            Dim hasallrails As Integer = row("HasAllRails")
            Dim railsstatus As Integer = row("RailsStatus")

            Dim prodShort As String = Right(prod, 5)
            Dim view As DataView = veadaShipDataSouth.DefaultView
            view.RowFilter = "ProdNo = " + prod
            If view.Count > 0 Then
                SShippedNotRcvd.Rows.Add(prodShort, color, prod, itemno)
            Else
                If hasallrails = 1 Or railsstatus >= 1 Then
                    SNotShipped.Rows.Add(prodShort, color, prod, itemno)
                Else
                    SMissingSomeRails.Rows.Add(prodShort, color, prod, itemno)
                End If
            End If

        Next

        MainPri3.DataSource = MShippedNotRcvd
        MainPri3.DataBind()

        SouthPri3.DataSource = SShippedNotRcvd
        SouthPri3.DataBind()

        MainPri4.DataSource = MNotShipped
        MainPri4.DataBind()

        SouthPri4.DataSource = SNotShipped
        SouthPri4.DataBind()

        MainPri5.DataSource = MMissingSomeRails
        MainPri5.DataBind()

        SouthPri5.DataSource = SMissingSomeRails
        SouthPri5.DataBind()

        Return False
    End Function

End Class
