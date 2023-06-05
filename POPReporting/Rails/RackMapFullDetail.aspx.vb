
Partial Class Rails_RackMapFullDetail
    Inherits System.Web.UI.Page

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        dl1.DataBind()


    End Sub

    Protected Sub dl1A_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles dl1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then

            Dim Status As String = e.Item.DataItem("RailsStatus").ToString
            Dim TotalCount As Integer = 0
            ''If e.Item.DataItem("RailsStatus") = -1 And
            ''   e.Item.DataItem("InUse") = 1 And
            ''  e.Item.BackColor = Drawing.Color.Yellow Then
            ''e.Item.BorderColor = Drawing.Color.Red
            ''Else
            'If e.Item.DataItem("Requested") = "1" And
            '       e.Item.DataItem("InUse") = "1" And
            '       e.Item.DataItem("BuildLoc") = "S" And
            '       (e.Item.DataItem("FurnitureStatus") < 2 Or e.Item.DataItem("FiberglassStatus") < 2 Or e.Item.DataItem("CoversStatus") < 1 Or e.Item.DataItem("TubesStatus") < 2 Or e.Item.DataItem("RailsStatus") < 1 Or ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0)) Then
            '    e.Item.BackColor = Drawing.Color.Yellow
            'End If

            'If e.Item.DataItem("Requested") = "1" And
            '       e.Item.DataItem("HasAllRails") = "1" And
            '       e.Item.DataItem("FurnitureStatus") = "2" And
            '       e.Item.DataItem("FiberglassStatus") = "2" And
            '       e.Item.DataItem("CoversStatus") >= 1 And
            '       e.Item.DataItem("TubesStatus") = 2 And
            '       ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) And
            '    e.Item.DataItem("InUse") = "1" Then
            '    e.Item.BackColor = Drawing.Color.Orange
            'ElseIf e.Item.DataItem("HasAllRails") = "0" And
            '       e.Item.DataItem("InUse") = "1" And
            '       e.Item.DataItem("BuildLoc") = "M" And
            '       (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
            '       e.Item.DataItem("FiberglassStatus") = "2" And
            '       e.Item.DataItem("CoversStatus") >= 1 And
            '       e.Item.DataItem("TubesStatus") = 2 And
            '       ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
            '    e.Item.BackColor = Drawing.Color.LightBlue
            'ElseIf e.Item.DataItem("HasAllRails") = "1" And
            '       e.Item.DataItem("InUse") = "1" And
            '       e.Item.DataItem("BuildLoc") = "M" And
            '      (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
            '       e.Item.DataItem("FiberglassStatus") = "2" And
            '       e.Item.DataItem("CoversStatus") >= 1 And
            '       e.Item.DataItem("TubesStatus") = 2 And
            '       ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
            '    e.Item.BackColor = Drawing.Color.LightGreen
            'End If
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
                   e.Item.DataItem("InUse").ToString = "1" And
                   (e.Item.DataItem("HasAllRails").ToString = "0") And
                    e.Item.DataItem("ProdLineID").ToString = "1" Then
                    'Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    'sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:yellow;")
                    'yellowByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "yellow")
                    e.Item.BackColor = Drawing.Color.Yellow

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
                    'Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    'sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:Orange;")
                    e.Item.BackColor = Drawing.Color.Orange
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
                    'Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    'sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:Wheat;")
                    e.Item.BackColor = Drawing.Color.Wheat
                    'cyanByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light cyan")

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
                    '    ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                    '    Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    '    sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:Orange;")
                    '    'e.Item.BackColor = Drawing.Color.Orange
                    '    'cyanByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light cyan")
                ElseIf e.Item.DataItem("HasAllRails") = "0" And
                    (e.Item.DataItem("ProdLineID") = "3" Or e.Item.DataItem("ProdLineID") = "2") And
                    (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                    e.Item.DataItem("FiberglassStatus") = "2" And
                    e.Item.DataItem("CoversStatus") >= 1 And
                    e.Item.DataItem("TubesStatus") = 2 And
                    e.Item.DataItem("GaugeStatus").ToString = "2" And
                   e.Item.DataItem("HarnessStatus").ToString = "2" And
                    ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                    'Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    'sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:LightBlue;")
                    e.Item.BackColor = Drawing.Color.LightBlue
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
                    e.Item.BackColor = Drawing.Color.LightGreen
                    'Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                    'sBlock.Attributes.Add("style", "width: 19rem; height: 8rem; background-color:LightGreen;")
                    'lightGreenByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light green")

                End If

            End If

        End If
    End Sub


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
    Protected Sub dl1_ItemCommand(source As Object, e As DataListCommandEventArgs) Handles dl1.ItemCommand
        If e.CommandName = "gotoorderdetails" Then 'handles when the ? button is clicked
            dl1.DataBind()
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetailsFull.aspx?SONo=" & SONo
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1');", True)
        End If
    End Sub


End Class
