
Imports System.Data
Imports System.Data.SqlClient
Imports MySql.Data.MySqlClient
Partial Class Fiberglass_Trucks
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

    Private Sub Fiberglass_Trucks_Load(sender As Object, e As EventArgs) Handles Me.Load
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


        If Not IsPostBack Then
            PopulateDataTables()
            'rcv.CssClass = "btn btn-sm btn-primary m-2"
            'insp.CssClass = "btn btn-sm btn-dark m-2"
            'loading.CssClass = "btn btn-sm btn-dark m-2"
            'MainView.ActiveViewIndex = 0
        End If

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd1 As New SqlCommand
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0

        conn.ConnectionString = connstr
        cmd1.CommandType = CommandType.Text
        cmd1.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FiberglassStatus = 2 and Convert(date,FiberglassLastUpdated) ='" & ThisDay & "'"

        cmd1.Connection = conn
        conn.Open()

        recordcount = Convert.ToInt16(cmd1.ExecuteScalar())
        lblRcvdToday.Text = recordcount

        conn.Close()

    End Sub

    'Private Sub loading_Click(sender As Object, e As EventArgs) Handles loading.Click
    '    loading.CssClass = "btn btn-sm btn-primary m-2"
    '    rcv.CssClass = "btn btn-sm btn-dark m-2"
    '    insp.CssClass = "btn btn-sm btn-dark m-2"

    '    MainView.ActiveViewIndex = 2
    'End Sub

    'Private Sub rcv_Click(sender As Object, e As EventArgs) Handles rcv.Click
    '    loading.CssClass = "btn btn-sm btn-dark m-2"
    '    rcv.CssClass = "btn btn-sm btn-primary m-2"
    '    insp.CssClass = "btn btn-sm btn-dark m-2"
    '    MainView.ActiveViewIndex = 0
    'End Sub

    Private Sub insp_Click(sender As Object, e As EventArgs) Handles insp.Click
        'loading.CssClass = "btn btn-sm btn-dark m-2"
        'rcv.CssClass = "btn btn-sm btn-dark m-2"
        rpr.CssClass = "btn btn-sm btn-dark m-2"
        ship.CssClass = "btn btn-sm btn-dark m-2"
        insp.CssClass = "btn btn-sm btn-primary m-2"
        shiphistory.CssClass = "btn btn-sm btn-dark m-2"
        MainView.ActiveViewIndex = 1
    End Sub

    Private Sub rpr_Click(sender As Object, e As EventArgs) Handles rpr.Click
        'loading.CssClass = "btn btn-sm btn-dark m-2"
        'rcv.CssClass = "btn btn-sm btn-dark m-2"
        rpr.CssClass = "btn btn-sm m-2 btn-primary"
        insp.CssClass = "btn btn-sm btn-dark m-2"
        ship.CssClass = "btn btn-sm btn-dark m-2"
        shiphistory.CssClass = "btn btn-sm btn-dark m-2"
        MainView.ActiveViewIndex = 3
    End Sub

    Private Sub ship_Click(sender As Object, e As EventArgs) Handles ship.Click
        'loading.CssClass = "btn btn-sm btn-dark m-2"
        'rcv.CssClass = "btn btn-sm btn-dark m-2"
        rpr.CssClass = "btn btn-sm btn-dark m-2"
        insp.CssClass = "btn btn-sm btn-dark m-2"
        ship.CssClass = "btn btn-sm btn-primary m-2"
        shiphistory.CssClass = "btn btn-sm btn-dark m-2"
        MainView.ActiveViewIndex = 4
    End Sub

    Private Sub shiphistory_Click(sender As Object, e As EventArgs) Handles shiphistory.Click
        'loading.CssClass = "btn btn-sm btn-dark m-2"
        'rcv.CssClass = "btn btn-sm btn-dark m-2"
        rpr.CssClass = "btn btn-sm btn-dark m-2"
        insp.CssClass = "btn btn-sm btn-dark m-2"
        ship.CssClass = "btn btn-sm btn-dark m-2"
        shiphistory.CssClass = "btn btn-sm btn-primary m-2"
        MainView.ActiveViewIndex = 5
    End Sub

    Protected Function SplitBVatDash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("-"c)(0)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function
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
        'Dim connstr As String = "server=veada-mysql-082019.cz8vw0a6whxb.us-east-1.rds.amazonaws.com;user id=BennDataPartner;password=DISH4087sky$$;persistsecurityinfo=True;database=vea_0819_dbshare"
        Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"
        conn.ConnectionString = connstr

        conn.Open()
        'mysqldataadapter.SelectCommand = New MySqlCommand("Select Trim(Convert(ProdNo, CHAR)) as ProdNo, Shipped, TruckNum FROM BennShipping_Shipped where ProdNo > '2100000' and Line like 'S%' order by ProdNo ", conn)
        mysqldataadapter.SelectCommand = New MySqlCommand("Select ProdNo,MAX(CAST(Shipped AS DATE)) as Shipped, TruckNum FROM SPECS_External.LocalBennShipping_Shipped Where ProdNo > 2100000  group by ProdNo Order By ProdNo asc", conn)
        mysqldataadapter.Fill(veadaShipDataMain)

        'mysqldataadapter.SelectCommand = New MySqlCommand("Select Trim(Convert(ProdNo, CHAR)) as ProdNo, Shipped, TruckNum FROM BennShipping_Shipped where ProdNo > '2100000' and Line not like 'S%' order by ProdNo ", conn)
        mysqldataadapter.SelectCommand = New MySqlCommand("Select ProdNo,MAX(CAST(Shipped AS DATE)) as Shipped, TruckNum FROM SPECS_External.LocalBennShipping_Shipped Where ProdNo > 2100000  group by ProdNo Order By ProdNo asc", conn)
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


    Protected Sub btnRcv_Click(sender As Object, e As EventArgs) Handles btnRcv.Click
        Dim prod1 As String = Trim(tbProdNo1.Text)
        Dim prod2 As String = Trim(tbProdNo2.Text)
        Dim prod3 As String = Trim(tbProdNo3.Text)

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0

        conn.ConnectionString = connstr

        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FiberglassStatus = 2 and Convert(date,FiberglassLastUpdated) ='" & ThisDay & "'"
        cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FiberglassStatus = 2 , FiberglassLastUpdated = '" & TodaysDate & "' where ProdNo =  '" & prod1 & "'"
        cmd2.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FiberglassStatus = 2 , FiberglassLastUpdated = '" & TodaysDate & "' where ProdNo =  '" & prod2 & "'"
        cmd3.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FiberglassStatus = 2 , FiberglassLastUpdated = '" & TodaysDate & "' where ProdNo =  '" & prod3 & "'"

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn

        conn.Open()

        If prod1.Length = 7 Then
            cmd1.ExecuteNonQuery()
        ElseIf prod1.Length > 0 Then
            MesgBox("Prod # has to be a length of 7 digits, starting with the year. Example 2199999")
        End If

        If prod2.Length = 7 Then
            cmd2.ExecuteNonQuery()
        ElseIf prod2.Length > 0 Then
            MesgBox("Prod # has to be a length of 7 digits, starting with the year. Example 2199999")
        End If

        If prod3.Length = 7 Then
            cmd3.ExecuteNonQuery()
        ElseIf prod3.Length > 0 Then
            MesgBox("Prod # has to be a length of 7 digits, starting with the year. Example 2199999")
        End If

        'ToDo :  
        'Show location in grid also

        cmd.ExecuteNonQuery()
        recordcount = Convert.ToInt16(cmd.ExecuteScalar())
        lblRcvdToday.Text = recordcount
        gvLast10Rcvd.DataBind()

        conn.Close()

        tbProdNo1.Text = ""
        tbProdNo2.Text = ""
        tbProdNo3.Text = ""

    End Sub

    Private Sub gvHelmBuild_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvHelmBuild.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If

    End Sub

    Private Sub gvHelmBuild_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvHelmBuild.RowCommand
        'This code is for the update button
        If e.CommandName = "UpdateFGStatus" Then
            'This code is for the update button
            ' Dim Key As String = e.CommandArgument 'get the row that is clicked
            'Dim SelectedProdNo As Integer = gvHelmBuild.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command

            Dim SelectedProdNo As String = e.CommandArgument

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FiberglassInspStatus = 4, FiberglassInsp = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn

            conn.Open()

            cmd.ExecuteNonQuery()

            gvHelmBuild.DataBind()

            conn.Close()
        End If
    End Sub

    Private Sub gvShip_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvShip.RowCommand
        If e.CommandName = "UpdateShipStatus" Then
            'This code is for the update button
            Dim SelectedProdNo As String = Trim(e.CommandArgument) 'get the row that is clicked
            'Dim SelectedProdNo As Integer = gvShip.Rows(Key).Cells(0).Text

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET HelmShipStatus = 2, HelmShip = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn

            conn.Open()

            cmd.ExecuteNonQuery()

            gvShip.DataBind()

            conn.Close()
        End If
    End Sub

    Private Sub btnRefreshShip_Click(sender As Object, e As EventArgs) Handles btnRefreshShip.Click
        gvShip.DataBind()
    End Sub

    Private Sub btnRefreshHistory_Click(sender As Object, e As EventArgs) Handles btnRefreshHistory.Click
        gvShipHistory.DataBind()
    End Sub
End Class


