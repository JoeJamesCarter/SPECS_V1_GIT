Imports System.Data
Imports System.Data.SqlClient
Partial Class Rails_RackMap2
    Inherits System.Web.UI.Page

    Public covidReturnDates As New DataTable
    Public lightGreenByProdNo As New DataTable
    Public lightGreenValueByProdNo As New DataTable
    Public orangeByProdNo As New DataTable
    Public yellowByProdNo As New DataTable
    Public blueByProdNo As New DataTable
    Public blueValueByProdNo As New DataTable
    Public cyanByProdNo As New DataTable

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
        lightGreenValueByProdNo.DefaultView.Sort = "prod"
        blueByProdNo.DefaultView.Sort = "prod"
        orangeByProdNo.DefaultView.Sort = "prod"
        yellowByProdNo.DefaultView.Sort = "prod"

        gvReadyInProdOrder.DataSource = lightGreenByProdNo
        gvReadyInProdOrder.DataBind()

        gvValueGreen.DataSource = lightGreenValueByProdNo
        gvValueGreen.DataBind()

        gvValueBlue.DataSource = blueValueByProdNo
        gvValueBlue.DataBind()

        gvYellow.DataSource = yellowByProdNo
        gvYellow.DataBind()

        gvBlue.DataSource = blueByProdNo
        gvBlue.DataBind()

        gvOrange.DataSource = orangeByProdNo
        gvOrange.DataBind()

        gvCyan.DataSource = cyanByProdNo
        gvCyan.DataBind()

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

            Dim notAcceptingBoats As Integer = 0

            If e.Item.DataItem("InUse").ToString = "1" Then

                If e.Item.DataItem("Requested").ToString = "1" And
                   e.Item.DataItem("InUse").ToString = "1" And
                   (e.Item.DataItem("HasAllRails").ToString = "0") And
                    e.Item.DataItem("ProdLineID").ToString = "1" Then
                    '(e.Item.DataItem("FurnitureStatus") < 2 Or e.Item.DataItem("FiberglassStatus") < 2 Or e.Item.DataItem("CoversStatus") < 1 Or e.Item.DataItem("TubesStatus") < 2 Or ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0)) Then
                    Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:yellow;")
                    yellowByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("Protech"), "yellow", e.Item.DataItem("HelmBuildStatus"), e.Item.DataItem("SwingbackStatus"), e.Item.DataItem("GatesFlag"))

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
                   ((e.Item.DataItem("ArchTowerNeeded") = 1 And e.Item.DataItem("ArchTowerStatus") >= 2) Or e.Item.DataItem("ArchTowerNeeded") = 0) And
                   ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                    Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:Orange;")
                    'e.Item.BackColor = Drawing.Color.Orange
                    orangeByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("Protech"), "orange", e.Item.DataItem("HelmBuildStatus"), e.Item.DataItem("SwingbackStatus"), e.Item.DataItem("GatesFlag"))

                ElseIf e.Item.DataItem("Requested").ToString = "0" And
                    (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("HasAllRails").ToString = "1") And
                    e.Item.DataItem("ProdLineID").ToString = "1" And
                    e.Item.DataItem("FurnitureStatus") = "2" And
                    e.Item.DataItem("FiberglassStatus") = "2" And
                    e.Item.DataItem("CoversStatus") >= 1 And
                    e.Item.DataItem("TubesStatus") = 2 And
                    e.Item.DataItem("GaugeStatus").ToString = "2" And
                    e.Item.DataItem("HarnessStatus").ToString = "2" And
                    ((e.Item.DataItem("ArchTowerNeeded") = 1 And e.Item.DataItem("ArchTowerStatus") >= 2) Or e.Item.DataItem("ArchTowerNeeded") = 0) And
                    ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                    Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:Wheat;")
                    'e.Item.BackColor = Drawing.Color.Orange
                    cyanByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("Protech"), "wheat", e.Item.DataItem("HelmBuildStatus"), e.Item.DataItem("SwingbackStatus"), e.Item.DataItem("GatesFlag"))

                    'ElseIf e.Item.DataItem("Requested").ToString = "0" And
                    '    e.Item.DataItem("HasAllRails").ToString = "1" And
                    '    e.Item.DataItem("BuildLoc").ToString = "S" And
                    '    e.Item.DataItem("FurnitureStatus") = "2" And
                    '    e.Item.DataItem("FiberglassStatus") = "2" And
                    '    e.Item.DataItem("CoversStatus") >= 1 And
                    '    e.Item.DataItem("TubesStatus") = 2 And
                    '    e.Item.DataItem("GaugeStatus") = 2 And
                    '    e.Item.DataItem("HarnessStatus") = 2 And
                    '     e.Item.DataItem("TrimStatus").ToString = "2" And
                    '     ((e.Item.DataItem("ArchTowerStatus") = 1 And e.Item.DataItem("ArchTowerStatus") = 2) Or e.Item.DataItem("ArchTowerNeeded") = 0 Or e.Item.DataItem("ArchTowerStatus") = 4) And
                    '    ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                    '    Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    '    sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:Orange;")
                    '    'e.Item.BackColor = Drawing.Color.Orange
                    '    'cyanByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light cyan")
                    '    orangeByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("Protech"), "orange", e.Item.DataItem("HelmBuildStatus"))

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
                    If e.Item.DataItem("BuildLoc") = "M" Then
                        blueByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("Protech"), "light blue", e.Item.DataItem("HelmBuildStatus"), e.Item.DataItem("SwingbackStatus"), e.Item.DataItem("GatesFlag"))
                    ElseIf e.Item.DataItem("BuildLoc") = "V" Then
                        blueValueByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("Protech"), "light blue", e.Item.DataItem("HelmBuildStatus"), e.Item.DataItem("SwingbackStatus"), e.Item.DataItem("GatesFlag"))
                    End If


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

                    If e.Item.DataItem("ProdLineID") = "3" Then
                        lightGreenByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("Protech"), "light green", e.Item.DataItem("HelmBuildStatus"), e.Item.DataItem("SwingbackStatus"), e.Item.DataItem("GatesFlag"))
                    ElseIf e.Item.DataItem("ProdLineID") = "2" Then
                        lightGreenValueByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("Protech"), "light green", e.Item.DataItem("HelmBuildStatus"), e.Item.DataItem("SwingbackStatus"), e.Item.DataItem("GatesFlag"))
                    End If

                End If

                End If

        End If
    End Sub



    Private Sub Rails_RackMap2_Load(sender As Object, e As EventArgs) Handles Me.Load
        lightGreenByProdNo.Columns.Add("slot")
        lightGreenByProdNo.Columns.Add("prod")
        lightGreenByProdNo.Columns.Add("model")
        lightGreenByProdNo.Columns.Add("protech")
        lightGreenByProdNo.Columns.Add("color")
        lightGreenByProdNo.Columns.Add("helmbuilt")
        lightGreenByProdNo.Columns.Add("sbbuilt")
        lightGreenByProdNo.Columns.Add("HasAllGates")

        lightGreenValueByProdNo.Columns.Add("slot")
        lightGreenValueByProdNo.Columns.Add("prod")
        lightGreenValueByProdNo.Columns.Add("model")
        lightGreenValueByProdNo.Columns.Add("protech")
        lightGreenValueByProdNo.Columns.Add("color")
        lightGreenValueByProdNo.Columns.Add("helmbuilt")
        lightGreenValueByProdNo.Columns.Add("sbbuilt")
        lightGreenValueByProdNo.Columns.Add("HasAllGates")

        blueByProdNo.Columns.Add("slot")
        blueByProdNo.Columns.Add("prod")
        blueByProdNo.Columns.Add("model")
        blueByProdNo.Columns.Add("protech")
        blueByProdNo.Columns.Add("color")
        blueByProdNo.Columns.Add("helmbuilt")
        blueByProdNo.Columns.Add("sbbuilt")
        blueByProdNo.Columns.Add("HasAllGates")

        blueValueByProdNo.Columns.Add("slot")
        blueValueByProdNo.Columns.Add("prod")
        blueValueByProdNo.Columns.Add("model")
        blueValueByProdNo.Columns.Add("protech")
        blueValueByProdNo.Columns.Add("color")
        blueValueByProdNo.Columns.Add("helmbuilt")
        blueValueByProdNo.Columns.Add("sbbuilt")
        blueValueByProdNo.Columns.Add("HasAllGates")

        'actually wheat
        cyanByProdNo.Columns.Add("slot")
        cyanByProdNo.Columns.Add("prod")
        cyanByProdNo.Columns.Add("model")
        cyanByProdNo.Columns.Add("protech")
        cyanByProdNo.Columns.Add("color")
        cyanByProdNo.Columns.Add("helmbuilt")
        cyanByProdNo.Columns.Add("sbbuilt")
        cyanByProdNo.Columns.Add("HasAllGates")


        yellowByProdNo.Columns.Add("slot")
        yellowByProdNo.Columns.Add("prod")
        yellowByProdNo.Columns.Add("model")
        yellowByProdNo.Columns.Add("protech")
        yellowByProdNo.Columns.Add("color")
        yellowByProdNo.Columns.Add("helmbuilt")
        yellowByProdNo.Columns.Add("sbbuilt")
        yellowByProdNo.Columns.Add("HasAllGates")


        orangeByProdNo.Columns.Add("slot")
        orangeByProdNo.Columns.Add("prod")
        orangeByProdNo.Columns.Add("model")
        orangeByProdNo.Columns.Add("protech")
        orangeByProdNo.Columns.Add("color")
        orangeByProdNo.Columns.Add("helmbuilt")
        orangeByProdNo.Columns.Add("sbbuilt")
        orangeByProdNo.Columns.Add("HasAllGates")


        ds.Columns.Add("slot")
        ds.Columns.Add("prod")
        ds.Columns.Add("model")
        ds.Columns.Add("protech")
        ds.Columns.Add("color")
        ds.Columns.Add("helmbuilt")
        ds.Columns.Add("sbbuilt")



    End Sub

    Private Sub gvReadyInProdOrder_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReadyInProdOrder.RowDataBound, gvBlue.RowDataBound, gvOrange.RowDataBound, gvYellow.RowDataBound, gvCyan.RowDataBound, gvValueBlue.RowDataBound, gvValueGreen.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                If e.Row.DataItem("color") = "light green" Then
                    e.Row.Cells(0).BackColor = System.Drawing.Color.LightGreen
                ElseIf e.Row.DataItem("color") = "orange" Then
                    e.Row.Cells(0).BackColor = System.Drawing.Color.Orange

                ElseIf e.Row.DataItem("color") = "yellow" Then
                    e.Row.Cells(0).BackColor = System.Drawing.Color.Yellow

                ElseIf e.Row.DataItem("color") = "light blue" Then
                    e.Row.Cells(0).BackColor = System.Drawing.Color.LightBlue

                ElseIf e.Row.DataItem("color") = "wheat" Then
                    e.Row.Cells(0).BackColor = System.Drawing.Color.Wheat
                End If

            Catch ex As Exception

            End Try

        End If
    End Sub


End Class

