Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports MySql.Data.MySqlClient

Partial Class FurnitureSouth
    Inherits System.Web.UI.Page

    Public Prodlist As New DataTable
    Public RGAList As New DataTable
    Public BOList As New DataTable
    Public HwrLines As New DataTable

    Private Sub FurnitureSouth_Load(sender As Object, e As EventArgs) Handles Me.Load
        Prodlist.Columns.Add("ProdNo")
        getData()
    End Sub

    Public Function getData() As String
        'Dim mysqldataadapter As New MySqlDataAdapter
        'Dim mysqldataadapter2 As New MySqlDataAdapter
        Dim mysqldataadapter3 As New MySqlDataAdapter

        Dim conn As New MySqlConnection()
        Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

        conn.ConnectionString = connstr


        'conn.Open()
        'If Not IsPostBack Then
        '    mysqldataadapter.SelectCommand = New MySqlCommand("SELECT Trim(ProdNo) as ProdNo, AutoID, RGA_Item_Desc, Color, Accent, Qty, Date_Added, BenRcvd, DeliveredToLine FROM RGAs WHERE BenRcvd is Null", conn)
        '    mysqldataadapter.Fill(RGAList)
        '    'MesgBox(RGAList.Rows.Count)
        '    mysqldataadapter2.SelectCommand = New MySqlCommand("SELECT AutoID, Trim(ProdNo) as ProdNo, Color, Accent, BO_Item_Desc, DeliveredToLine, Cleared, Date_Added FROM Backorders WHERE Cleared = 0", conn)
        '    mysqldataadapter2.Fill(BOList)
        '    'MesgBox(BOList.Rows.Count)
        'End If

        mysqldataadapter3.SelectCommand = New MySqlCommand("SELECT Trim(OrderLines.ProdNo) as ProdNo, ItemNo,StockCode, PartStockCode,PartDesc,PartLineDesc,Color,BO_Flag,RGA_Flag,Qty,RcvdFlag,Job,HardwareReady,CASE When RCVDFlag = 0 Then '0' When RCVDFlag < Qty Then '1' When RCVDFlag = Qty Then '2' END as RCVDGraphic FROM OrderLines left join Live_Boats on OrderLines.ProdNo = Live_Boats.ProdNo WHERE OrderLines.ProdNo > 2100000 and (PartDesc Like '%RECL%' or PartDesc Like '%BASS SEAT%' or PartDesc Like '%BOW GATE BENCH%' or PartDesc Like '%OTTOMAN%' or PartDesc Like '%REFRESHMENT TABLE%' or PartDesc Like '%HELM SEAT%' or PartDesc Like 'LOOSE%' )", conn)
        mysqldataadapter3.Fill(HwrLines)

        conn.Close()
        conn.Dispose()

        Return True
    End Function

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

    End Sub

    Private Sub Repeater1_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        Dim lblColor As Label = DirectCast(e.Item.FindControl("lblColor"), Label)
        Dim prod As String = e.Item.DataItem("ProdNo")
        Dim gvOrderLines As GridView = DirectCast(e.Item.FindControl("gvOrderLines"), GridView)
        Dim gvBOs As GridView = DirectCast(e.Item.FindControl("gvBOs"), GridView)
        Dim gvRGAs As GridView = DirectCast(e.Item.FindControl("gvRGAs"), GridView)

        Prodlist.Rows.Add(prod)
        Try
            lblColor.Text = getColor(prod)
        Catch
        End Try

        Dim view As DataView = HwrLines.DefaultView
        view.RowFilter = "ProdNo = '" & Trim(prod) & "'"

        'Dim view1 As DataView = RGAList.DefaultView
        'view1.RowFilter = "ProdNo = '" & Trim(prod) & "'"

        'Dim view2 As DataView = BOList.DefaultView
        'view2.RowFilter = "ProdNo = '" & Trim(prod) & "'"

        gvOrderLines.DataSource = view
        gvOrderLines.DataBind()

        'gvRGAs.DataSource = view1
        'gvBOs.DataSource = view2

        'gvRGAs.DataBind()
        'gvBOs.DataBind()


    End Sub

    Public Function getColor(ProdNo As String) As String

        Dim view As DataView = HwrLines.DefaultView
        view.RowFilter = "ProdNo = '" & Trim(ProdNo) & "'"
        Dim Color As String = view(1)(6).ToString
        Return Color

    End Function


    Protected Sub gvOrderLines_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "gotoReady" Then
            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim SelectedProd As Integer = Line(1)
            Dim SelectedPart As String = Line(2)
            Dim SelectedModel As String = Line(3)
            Dim SelectedColor As String = Line(4)
            Dim SelectedJob As String = Line(5)

            Dim TodaysDate As Date = Date.Now

            Dim ctrl As Control = e.CommandSource
            Dim CurrentRow As GridViewRow = ctrl.NamingContainer

            Dim img As Image = CType(CurrentRow.Cells(3).FindControl("btnReady"), Image)
            Dim hwrvalue = img.ImageUrl
            hwrvalue = Mid(hwrvalue, 17, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.


            Dim flag As Integer = 0

            If hwrvalue = 0 Then
                flag = 1
            ElseIf hwrvalue = 1 Then
                flag = 0
            End If


            Dim conn As New MySqlConnection()
            Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

            Dim cmd As New MySqlCommand
            Dim cmd1 As New MySqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text

            cmd.CommandText = "Update OrderLines Set HardwareReady = '" & flag & "' where ProdNo = '" & SelectedProd & "' and PartDesc = '" & SelectedPart & "' and Color = '" & SelectedColor & "' and Job = '" & SelectedJob & "'"

            cmd.Connection = conn

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            'MesgBox(flag)

            DataBind()
        End If

        'If e.CommandName = "setdelivered" Then
        '    Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
        '    Dim Line() As String = Selected.Split(";")
        '    Dim id As Integer = Convert.ToInt16(Line(0))
        '    Dim SelectedProd As Integer = Line(1)
        '    Dim SelectedPart As String = Line(2)
        '    Dim SelectedModel As String = Line(3)
        '    Dim SelectedColor As String = Line(4)
        '    Dim SelectedJob As String = Line(5)

        '    Dim TodaysDate As Date = Date.Now

        '    Dim conn As New MySqlConnection()
        '    Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

        '    Dim cmd As New MySqlCommand
        '    Dim cmd1 As New MySqlCommand

        '    conn.ConnectionString = connstr

        '    cmd.CommandType = CommandType.Text

        '    cmd.CommandText = "Update OrderLines Set HardwareReady = '" & flag & "' where ProdNo = '" & SelectedProd & "' and PartDesc = '" & SelectedPart & "' and Color = '" & SelectedColor & "' and Job = '" & SelectedJob & "'"

        '    cmd.Connection = conn

        '    conn.Open()
        '    cmd.ExecuteNonQuery()
        '    conn.Close()
        '    'MesgBox(flag)

        '    DataBind()
        'End If
    End Sub

    Protected Sub gvOrderLines_RowDataBound(sender As Object, e As GridViewRowEventArgs)

    End Sub

    Protected Sub gvRGAs_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim BenRcvd As Integer = 0
            Dim Delivered As Integer = 0


            If e.Row.DataItem("BenRcvd") Is DBNull.Value Then
                BenRcvd = 0
            Else
                BenRcvd = Convert.ToInt16(e.Row.DataItem("BenRcvd"))
            End If

            If e.Row.DataItem("DeliveredToLine") Is DBNull.Value Then
                Delivered = 0
            Else
                Delivered = Convert.ToInt16(e.Row.DataItem("DeliveredToLine"))
            End If

            If BenRcvd = 0 Then
                e.Row.BackColor = Drawing.Color.Yellow
            ElseIf BenRcvd = 1 And Delivered = 0 Then
                e.Row.BackColor = Drawing.Color.Orange

            End If
        End If
    End Sub

    Protected Sub gvBOs_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim Cleared As Integer = 0
            Dim Delivered As Integer = 0


            If e.Row.DataItem("Cleared") Is DBNull.Value Then
                Cleared = 0
            Else
                Cleared = Convert.ToInt16(e.Row.DataItem("Cleared"))
            End If

            If e.Row.DataItem("DeliveredToLine") Is DBNull.Value Then
                Delivered = 0
            Else
                Delivered = Convert.ToInt16(e.Row.DataItem("DeliveredToLine"))
            End If

            If Cleared = 0 Then
                e.Row.BackColor = Drawing.Color.LightBlue
            ElseIf Cleared = 1 And Delivered = 0 Then
                e.Row.BackColor = Drawing.Color.Orange

            End If
        End If
    End Sub
End Class
