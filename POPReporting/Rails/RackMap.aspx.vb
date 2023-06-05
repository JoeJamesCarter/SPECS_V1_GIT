Imports System.Data
Imports System.Data.SqlClient

Partial Class Rails_RackMap
    Inherits System.Web.UI.Page

    Public covidReturnDates As New DataTable
    Public lightGreenByProdNo As New DataTable
    Public ds As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        lightGreenByProdNo.Clear()
        'gvReadyInProdOrder.DataSource = ds
        'gvReadyInProdOrder.DataBind()

        Repeater1.DataBind()
        lightGreenByProdNo.DefaultView.Sort = "prod"
        'gvReadyInProdOrder.DataSource = lightGreenByProdNo
        'gvReadyInProdOrder.DataBind()
    End Sub

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything

        Dim sqldataadapter As New SqlDataAdapter
        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1

        'Try
        conn1.Open()
        sqldataadapter.SelectCommand = New SqlCommand("SELECT RTrim(DlrNo) as CusNo, DateReturning From DlrReturnsFromCovid Where DateReturning > getDate()", conn1)
        sqldataadapter.Fill(covidReturnDates)

        conn1.Close()
        conn1.Dispose()

        Return False
    End Function



    Protected Sub gvRailsData_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                If e.Row.DataItem("CustDrawNo") = "" Then
                    e.Row.Cells(7).BackColor = System.Drawing.Color.White
                Else
                    e.Row.Cells(7).BackColor = System.Drawing.Color.Yellow
                End If
            Catch ex As Exception

            End Try

        End If
    End Sub

    Private Sub Repeater1_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then

            Dim Status As String = e.Item.DataItem("RailsStatus").ToString
            Dim CusNo As String = e.Item.DataItem("CusNo").ToString
            'Dim acceptingResults() As ListItem
            Dim notAcceptingBoats As Integer = 0

            'Try
            'acceptingResults = covidReturnDates.Select("CusNo =  '" & CusNo & "'")
            'If acceptingResults.Length > 0 Then
            'notAcceptingBoats = 1
            'MesgBox(acceptingResults.Length)
            'End If
            '   Catch
            '  End Try


            'If e.Item.DataItem("RailsStatus") = -1 And
            '   e.Item.DataItem("InUse") = 1 And
            '  e.Item.BackColor = Drawing.Color.Yellow Then
            'e.Item.BorderColor = Drawing.Color.Red
            'Else
            If e.Item.DataItem("InUse").ToString = "1" Then

                If e.Item.DataItem("Requested").ToString = "1" And
                   (e.Item.DataItem("HasAllRails").ToString = "0") And
                   e.Item.DataItem("ProdLineID").ToString = "1" Then
                    '(e.Item.DataItem("FurnitureStatus") < 2 Or e.Item.DataItem("FiberglassStatus") < 2 Or e.Item.DataItem("CoversStatus") < 1 Or e.Item.DataItem("TubesStatus") < 2 Or ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0) Or e.Item.DataItem("GaugeStatus") < 2 Or e.Item.DataItem("HarnessStatus") < 2) Then
                    Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:yellow;")
                    'yellowByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "yellow")


                ElseIf (e.Item.DataItem("Requested").ToString = "1") And
                   e.Item.DataItem("HasAllRails").ToString = "1" And
                   e.Item.DataItem("ProdLineID").ToString = "1" And
                   (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                   e.Item.DataItem("FiberglassStatus") = "2" And
                   e.Item.DataItem("CoversStatus") >= 1 And
                   e.Item.DataItem("TubesStatus") = 2 And
                   e.Item.DataItem("TrimStatus").ToString = "2" And
                     e.Item.DataItem("GaugeStatus").ToString = "2" And
                   e.Item.DataItem("HarnessStatus").ToString = "2" And
                   ((e.Item.DataItem("ArchTowerNeeded") = 1 And e.Item.DataItem("ArchTowerStatus") = 2) Or e.Item.DataItem("ArchTowerNeeded") = 0) And
                   ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                    Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:Orange;")
                    'e.Item.BackColor = Drawing.Color.Orange
                    'orangeByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "orange")

                ElseIf e.Item.DataItem("Requested").ToString = "0" And
                    e.Item.DataItem("HasAllRails").ToString = "0" And
                    e.Item.DataItem("ProdLineID").ToString = "1" And
                    e.Item.DataItem("FurnitureStatus") = "2" And
                    e.Item.DataItem("FiberglassStatus") = "2" And
                    e.Item.DataItem("CoversStatus") >= 1 And
                    e.Item.DataItem("TubesStatus") = 2 And
                      e.Item.DataItem("GaugeStatus").ToString = "2" And
                   e.Item.DataItem("HarnessStatus").ToString = "2" And
                    ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                    Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:Wheat;")
                    'e.Item.BackColor = Drawing.Color.Orange
                    'cyanByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light cyan")

                ElseIf e.Item.DataItem("HasAllRails") = "0" And
                    (e.Item.DataItem("ProdLineID") = "3" Or e.Item.DataItem("ProdLineID") = "2") And
                    (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                    e.Item.DataItem("FiberglassStatus") = "2" And
                    e.Item.DataItem("CoversStatus") >= 1 And
                    e.Item.DataItem("TubesStatus") = 2 And
                      e.Item.DataItem("GaugeStatus").ToString = "2" And
                   e.Item.DataItem("HarnessStatus").ToString = "2" And
                    ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                    Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:LightBlue;")
                    'e.Item.BackColor = Drawing.Color.LightBlue
                    'blueByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light blue")

                ElseIf notAcceptingBoats = 0 And
                    e.Item.DataItem("HasAllRails") = "1" And
                    (e.Item.DataItem("ProdLineID") = "3" Or e.Item.DataItem("ProdLineID") = "2") And
                    (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                    e.Item.DataItem("FiberglassStatus") = "2" And
                    e.Item.DataItem("CoversStatus") >= 1 And
                    e.Item.DataItem("TubesStatus") = 2 And
                      e.Item.DataItem("GaugeStatus").ToString = "2" And
                   e.Item.DataItem("HarnessStatus").ToString = "2" And
                    ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                    'e.Item.BackColor = Drawing.Color.LightGreen
                    Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:LightGreen;")
                    'lightGreenByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light green")

                End If

            End If

        End If
    End Sub



    Private Sub Rails_RackMap1_Load(sender As Object, e As EventArgs) Handles Me.Load
        lightGreenByProdNo.Columns.Add("slot")
        lightGreenByProdNo.Columns.Add("prod")
        lightGreenByProdNo.Columns.Add("color")

        ds.Columns.Add("slot")
        ds.Columns.Add("prod")
        ds.Columns.Add("color")
    End Sub

    'Private Sub gvReadyInProdOrder_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReadyInProdOrder.RowDataBound
    '    If e.Row.RowType = DataControlRowType.DataRow Then
    '        Try
    '            If e.Row.DataItem("color") = "light green" Then
    '                e.Row.Cells(0).BackColor = System.Drawing.Color.LightGreen
    '            ElseIf e.Row.DataItem("color") = "orange" Then
    '                e.Row.Cells(0).BackColor = System.Drawing.Color.Orange
    '            End If
    '        Catch ex As Exception

    '        End Try

    '    End If
    'End Sub


End Class
