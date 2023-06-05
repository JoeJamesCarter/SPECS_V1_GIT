Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports MySql.Data.MySqlClient

Partial Class FurnitureMap
    Inherits System.Web.UI.Page

    Public rgaProdNoList As New DataTable
    Public rgaProdNoListReceivedNotDeliveredToLine As New DataTable
    Public boProdNoList As New DataTable
    Public boProdNoListReceivedNotDeliveredToLine As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
        Dim mysqldataadapter As New MySqlDataAdapter
        Dim mysqldataadapter2 As New MySqlDataAdapter
        Dim mysqldataadapter3 As New MySqlDataAdapter
        Dim mysqldataadapter4 As New MySqlDataAdapter

        Dim conn As New MySqlConnection()
        Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

        conn.ConnectionString = connstr

        conn.Open()

        mysqldataadapter.SelectCommand = New MySqlCommand("Select distinct ProdNo FROM RGAs where BenRcvd is Null and DeliveredToLine is null and ProdNo > 185300", conn)
        mysqldataadapter.Fill(rgaProdNoList)

        mysqldataadapter2.SelectCommand = New MySqlCommand("Select distinct ProdNo FROM Backorders where Cleared = 0 and DeliveredToLine is Null and ProdNo > 185300", conn)
        mysqldataadapter2.Fill(boProdNoList)

        mysqldataadapter3.SelectCommand = New MySqlCommand("Select distinct ProdNo FROM RGAs where BenRcvd = 1 and DeliveredtoLine is Null and ProdNo > 185300", conn)
        mysqldataadapter3.Fill(rgaProdNoListReceivedNotDeliveredToLine)


        mysqldataadapter4.SelectCommand = New MySqlCommand("Select distinct ProdNo FROM Backorders where Cleared = 1 and DeliveredToLine is null and ProdNo > 185300 ", conn)
        mysqldataadapter4.Fill(boProdNoListReceivedNotDeliveredToLine)

        conn.Close()
        conn.Dispose()
        Return False

    End Function

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        PopulateDataTables()
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        PopulateDataTables()
        dlFrames.DataBind()
        dlFloors.DataBind()
        dlRails.DataBind()
        dlFurniture.DataBind()
        dlHelms.DataBind()
        dlInspection.DataBind()
        dlFinal.DataBind()
        'dlShrink.DataBind()
        'dlRigging.DataBind()
        'dlWavetamer.DataBind()
        'dlSharkhide.DataBind()
    End Sub

    Protected Sub dlFrames_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles dlFrames.ItemDataBound, dlFloors.ItemDataBound, dlRails.ItemDataBound, dlHelms.ItemDataBound, dlFurniture.ItemDataBound, dlInspection.ItemDataBound, dlFinal.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then

            Dim prod As String = e.Item.DataItem("ProdNo")

            Dim rgaResult() As DataRow = rgaProdNoList.Select("ProdNo =  '" & prod & "'")
            Dim rgaNotDeliveredToBoatResult() As DataRow = rgaProdNoListReceivedNotDeliveredToLine.Select("ProdNo =  '" & prod & "'")

            If rgaResult.Length > 0 Then

                'e.Item.BackColor = Drawing.Color.Yellow

                Dim a As SqlDataSource = CType(e.Item.FindControl("sdsRGAs"), SqlDataSource)

                Try
                    a.SelectParameters(0).DefaultValue = prod

                Catch ex As Exception

                End Try

            End If

            If rgaNotDeliveredToBoatResult.Length > 0 Then

                'e.Item.BackColor = Drawing.Color.Orange

                Dim a As SqlDataSource = CType(e.Item.FindControl("sdsRGAs"), SqlDataSource)

                Try
                    a.SelectParameters(0).DefaultValue = prod

                Catch ex As Exception

                End Try

            End If


            Dim boResult() As DataRow = boProdNoList.Select("ProdNo =  '" & prod & "'")
            Dim boProdNoListReceivedNotDeliveredToLineResult() As DataRow = boProdNoListReceivedNotDeliveredToLine.Select("ProdNo =  '" & prod & "'")

            If boResult.Length > 0 Then
                Dim b As SqlDataSource = CType(e.Item.FindControl("sdsBOs"), SqlDataSource)
                ' e.Item.BackColor = Drawing.Color.LightBlue

                Try
                    b.SelectParameters(0).DefaultValue = prod
                Catch ex As Exception

                End Try

            End If

            If boProdNoListReceivedNotDeliveredToLineResult.Length > 0 Then
                Dim b As SqlDataSource = CType(e.Item.FindControl("sdsBOs"), SqlDataSource)
                'e.Item.BackColor = Drawing.Color.LightBlue

                Try
                    b.SelectParameters(0).DefaultValue = prod
                Catch ex As Exception

                End Try

            End If


            Dim c As SqlDataSource = CType(e.Item.FindControl("sdsIntRGAs"), SqlDataSource)
            Try
                c.SelectParameters(0).DefaultValue = prod
            Catch ex As Exception

            End Try

        End If


    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim i As Integer = 0
        For Each row As DataRow In rgaProdNoList.Rows
            Dim ProdNo = rgaProdNoList.Rows(i)(0)
            'MesgBox(ProdNo)
            i = i + 1
        Next

        Dim j As Integer = 0
        For Each row As DataRow In boProdNoList.Rows
            Dim ProdNo = boProdNoList.Rows(j)(0)
            'MesgBox(ProdNo)
            j = j + 1
        Next

        Dim k As Integer = 0
        For Each row As DataRow In rgaProdNoListReceivedNotDeliveredToLine.Rows
            Dim ProdNo = rgaProdNoListReceivedNotDeliveredToLine.Rows(k)(0)
            If ProdNo = "188323" Then
                MesgBox(ProdNo)
            End If

            k = k + 1
        Next

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

    Protected Sub gvIntRGAs_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim Resolved As Integer = 0
            Dim Delivered As Integer = 0

            If e.Row.DataItem("Resolved") Is DBNull.Value Then
                Resolved = 0
            Else
                Resolved = Convert.ToInt16(e.Row.DataItem("Resolved"))
            End If


            If e.Row.DataItem("DeliveredToLine") Is DBNull.Value Then
                Delivered = 0
            Else
                Delivered = Convert.ToInt16(e.Row.DataItem("DeliveredToLine"))
            End If

            If Resolved = 0 Or Resolved = 1 Then
                e.Row.BackColor = Drawing.Color.Yellow
            ElseIf Resolved = 2 And Delivered = 0 Then
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
