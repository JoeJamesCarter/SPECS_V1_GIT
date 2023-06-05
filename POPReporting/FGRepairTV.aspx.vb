Imports System.Data
Imports System.Data.SqlClient
Imports MySql.Data.MySqlClient
Imports AjaxControlToolkit
Partial Class FGRepairTV
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

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub
    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        PopulateDataTables()
    End Sub

    Private Sub FGRepairTV_Load(sender As Object, e As EventArgs) Handles Me.Load
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


        If Not IsPostBack Then
            PopulateDataTables()
        End If

        'attempt to auto refresh/update without an update panel so that the buttons will work.
        'Dim objScriptManager As ToolkitScriptManager = CType(Me.FindControl("ScriptManager1"), ToolkitScriptManager)
        'objScriptManager.AsyncPostBackTimeout = 30000

    End Sub

    Private Sub gvMain1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvMain1.RowCommand, gvMain2.RowCommand, gvMain3.RowCommand, gvMain4.RowCommand, gvMain5.RowCommand, gvSouth1.RowCommand, gvSouth2.RowCommand, gvSouth3.RowCommand, gvSouth4.RowCommand, gvSouth5.RowCommand
        If e.CommandName = "gotoStartRepair" Then
            Dim prod As String = e.CommandArgument
            'MesgBox(prod.ToString)

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            Dim TodaysDate As Date = Date.Now

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FiberglassInspStatus = 4, FiberglassInsp = '" & TodaysDate & "' where ProdNo =  '" & prod & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            PopulateDataTables()
            gvMain1.DataBind()
            gvMain2.DataBind()
            gvMain3.DataBind()
            gvMain4.DataBind()
            gvMain5.DataBind()

            gvSouth1.DataBind()
            gvSouth2.DataBind()
            gvSouth3.DataBind()
            gvSouth4.DataBind()
            gvSouth5.DataBind()
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
        sqldataadapter.SelectCommand = New SqlCommand("SELECT RTrim(t1.ProdNo) as ProdNo, RailsStatus, HasAllRails, Left(t1.BaseVinylColor,3) as BaseVinylColor From BML_POPREPORTING t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Left Join Rails_Tracking t3 on t1.ProdNo = t3.ProdNo Where FurnitureStatus = 0 and t2.BuildLoc = 'M' and FiberglassInspStatus = 3 order by ProdNo", conn1)
        sqldataadapter.Fill(boatsRedFurnM)

        sqldataadapter.SelectCommand = New SqlCommand("SELECT RTrim(t1.ProdNo) as ProdNo, RailsStatus, HasAllRails, Left(t1.BaseVinylColor,3) as BaseVinylColor From BML_POPREPORTING t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Left Join Rails_Tracking t3 on t1.ProdNo = t3.ProdNo Where FurnitureStatus = 0 and t2.BuildLoc = 'S' and FiberglassInspStatus = 3 order by ProdNo", conn1)
        sqldataadapter.Fill(boatsRedFurnS)

        conn1.Close()
        conn1.Dispose()



        For Each row As DataRow In boatsRedFurnM.Rows

            Dim prod As String = row("ProdNo").ToString
            Dim ProdNo As String = row("ProdNo").ToString
            Dim color As String = row("BaseVinylColor").ToString
            Dim hasallrails As Integer = row("HasAllRails")
            Dim railsstatus As Integer = row("RailsStatus")

            Dim prodShort As String = Right(prod, 5)
            Dim view As DataView = veadaShipDataMain.DefaultView
            view.RowFilter = "ProdNo = " + prod
            If view.Count > 0 Then
                MShippedNotRcvd.Rows.Add(prodShort, color, ProdNo)
            Else
                If hasallrails = 1 Or railsstatus >= 1 Then
                    MNotShipped.Rows.Add(prodShort, color, ProdNo)
                Else
                    MMissingSomeRails.Rows.Add(prodShort, color, ProdNo)
                End If

            End If

        Next

        For Each row As DataRow In boatsRedFurnS.Rows

            Dim prod As String = row("ProdNo").ToString
            Dim ProdNo As String = row("ProdNo").ToString
            Dim color As String = row("BaseVinylColor").ToString
            Dim hasallrails As Integer = row("HasAllRails")
            Dim railsstatus As Integer = row("RailsStatus")

            Dim prodShort As String = Right(prod, 5)
            Dim view As DataView = veadaShipDataSouth.DefaultView
            view.RowFilter = "ProdNo = " + prod
            If view.Count > 0 Then
                SShippedNotRcvd.Rows.Add(prodShort, color, ProdNo)
            Else
                If hasallrails = 1 Or railsstatus >= 1 Then
                    SNotShipped.Rows.Add(prodShort, color, ProdNo)
                Else
                    SMissingSomeRails.Rows.Add(prodShort, color, ProdNo)
                End If
            End If

        Next

        gvMain1.DataBind()
        gvMain2.DataBind()

        gvMain3.DataSource = MShippedNotRcvd
        gvMain3.DataBind()

        gvSouth1.DataBind()
        gvSouth2.DataBind()
        gvSouth3.DataSource = SShippedNotRcvd
        gvSouth3.DataBind()

        gvMain4.DataSource = MNotShipped
        gvMain4.DataBind()

        gvSouth4.DataSource = SNotShipped
        gvSouth4.DataBind()

        gvMain5.DataSource = MMissingSomeRails
        gvMain5.DataBind()

        gvSouth5.DataSource = SMissingSomeRails
        gvSouth5.DataBind()


        'If MainPri1.Items.Count = 0 Then
        '    MainPri1.Visible = False
        '    lblMainPri1.Visible = False
        'Else
        '    MainPri1.Visible = True
        '    lblMainPri1.Visible = True
        'End If

        'If MainPri2.Items.Count = 0 Then
        '    MainPri2.Visible = False
        '    lblMainPri2.Visible = False
        'Else
        '    MainPri2.Visible = True
        '    lblMainPri2.Visible = True
        'End If

        'If MainPri3.Items.Count = 0 Then
        '    MainPri3.Visible = False
        '    lblMainPri3.Visible = False
        'Else
        '    MainPri3.Visible = True
        '    lblMainPri3.Visible = True
        'End If

        'If MainPri4.Items.Count = 0 Then
        '    MainPri4.Visible = False
        '    lblMainPri4.Visible = False
        'Else
        '    MainPri4.Visible = True
        '    lblMainPri4.Visible = True
        'End If

        'If MainPri5.Items.Count = 0 Then
        '    MainPri5.Visible = False
        '    lblMainPri5.Visible = False
        'Else
        '    MainPri5.Visible = True
        '    lblMainPri5.Visible = True
        'End If

        ''South

        'If SouthPri1.Items.Count = 0 Then
        '    SouthPri1.Visible = False
        '    lblSouthPri1.Visible = False
        'Else
        '    SouthPri1.Visible = True
        '    lblSouthPri1.Visible = True
        'End If

        'If SouthPri2.Items.Count = 0 Then
        '    SouthPri2.Visible = False
        '    lblSouthPri2.Visible = False
        'Else
        '    SouthPri2.Visible = True
        '    lblSouthPri2.Visible = True
        'End If

        'If SouthPri3.Items.Count = 0 Then
        '    SouthPri3.Visible = False
        '    lblSouthPri3.Visible = False
        'Else
        '    SouthPri3.Visible = True
        '    lblSouthPri3.Visible = True
        'End If

        'If SouthPri4.Items.Count = 0 Then
        '    SouthPri4.Visible = False
        '    lblSouthPri4.Visible = False
        'Else
        '    SouthPri4.Visible = True
        '    lblSouthPri4.Visible = True
        'End If

        'If SouthPri5.Items.Count = 0 Then
        '    SouthPri5.Visible = False
        '    lblSouthPri5.Visible = False
        'Else
        '    SouthPri5.Visible = True
        '    lblSouthPri5.Visible = True
        'End If




        Return False
    End Function

End Class
