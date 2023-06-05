
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration


Partial Class OverviewTubes
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

        gvOverviewTubes.DataBind()

    End Sub

    Protected Sub gvOverviewTubes_DataBound(sender As Object, e As EventArgs) Handles gvOverviewTubes.DataBound
        AddSuperHeader(gvOverviewTubes)
    End Sub

    Protected Sub gvOverviewTubes_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOverviewTubes.RowDataBound
        Dim gvOverviewTubes = DirectCast(sender, GridView)
        Dim tblSeamerCtr As Table = CType(e.Row.FindControl("tblSeamerCtr"), Table)
        Dim tblBafflesCtr As Table = CType(e.Row.FindControl("tblBafflesCtr"), Table)

        If e.Row.RowType = DataControlRowType.DataRow Then

            e.Row.Cells(0).ToolTip = "Prod #"
            e.Row.Cells(1).ToolTip = "SO #"
            e.Row.Cells(2).ToolTip = "Due Date"
            e.Row.Cells(3).ToolTip = "Furniture"
            e.Row.Cells(4).ToolTip = "Fiberglass"
            e.Row.Cells(5).ToolTip = "Covers"
            e.Row.Cells(6).ToolTip = "Rails"
            e.Row.Cells(7).ToolTip = "Tubes"
            e.Row.Cells(8).ToolTip = "Centertubes"
            e.Row.Cells(9).ToolTip = "Boat/Customer"
            'e.Row.Cells(10).ToolTip = "Roller - P"
            'e.Row.Cells(11).ToolTip = "Roller - S"
            'e.Row.Cells(12).ToolTip = "Roller - C"
            'e.Row.Cells(13).ToolTip = "Seamer - P"
            'e.Row.Cells(14).ToolTip = "Seamer - S"
            'e.Row.Cells(15).ToolTip = "Seamer - C"
            'e.Row.Cells(16).ToolTip = "Baffles - P"
            'e.Row.Cells(17).ToolTip = "Baffles - S"
            'e.Row.Cells(18).ToolTip = "Baffles - C"
            'e.Row.Cells(19).ToolTip = "Round Seamer - P"
            'e.Row.Cells(20).ToolTip = "Round Seamer - S"
            'e.Row.Cells(21).ToolTip = "Round Seamer - C"
            'e.Row.Cells(22).ToolTip = "Brackets - P"
            'e.Row.Cells(23).ToolTip = "Brackets - S"
            'e.Row.Cells(24).ToolTip = "Brackets - C"


            If e.Row.DataItem("CenterTubeNeeded") = 0 Then
                tblSeamerCtr.Visible = False
                tblBafflesCtr.Visible = False
            End If

            If e.Row.DataItem("BuildLoc") = "S" Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If


    End Sub


    Protected Sub gvOverviewTubes_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvOverviewTubes.RowCommand

        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            gvOverviewTubes.DataBind()
            Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command
            Dim workstation As String = "Overview"
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If
        If e.CommandName = "gotoorderdetails" Then 'handles when the ? button is clicked
            gvOverviewTubes.DataBind()
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

    End Sub


    Protected Sub btnClearProdNo_Click(sender As Object, e As EventArgs) Handles btnClearProdNo.Click
        tbSearchProdNo.Text = ""
    End Sub

    Protected Sub btnClearnCusName_Click(sender As Object, e As EventArgs) Handles btnClearnCusName.Click
        tbSearchCusName.Text = ""
    End Sub

    Protected Sub btnClearModel_Click(sender As Object, e As EventArgs) Handles btnClearModel.Click
        tbSearchModel.Text = ""
    End Sub

    Private Shared Sub AddSuperHeader(gridView As GridView)

        'all of this code adds a header above the gv header so that I can display the totals.
        Dim myTable = DirectCast(gridView.Controls(0), Table)
        Dim myNewRow = New GridViewRow(0, -1, DataControlRowType.Header, DataControlRowState.Normal)
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())

        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell("Roller", 3))
        myNewRow.Cells.Add(MakeCell("Seamer", 3))
        myNewRow.Cells.Add(MakeCell("Baffles", 3))
        myNewRow.Cells.Add(MakeCell("Round Seamer", 3))
        myNewRow.Cells.Add(MakeCell("Brackets", 3))
        myNewRow.Cells.Add(MakeCell("Air Check 1", 3))
        myNewRow.Cells.Add(MakeCell("Repair 1", 3))
        myNewRow.Cells.Add(MakeCell("Air Check 2", 3))
        myNewRow.Cells.Add(MakeCell("Repair 2", 3))
        myNewRow.Cells.Add(MakeCell("Audit", 3))
        myNewRow.Cells.Add(MakeCell("Final Outers", 2))
        myNewRow.Cells.Add(MakeCell("Chines", 3))
        myNewRow.Cells.Add(MakeCell("Transom", 3))
        myTable.Rows.AddAt(0, myNewRow)

        'Row 2

        Dim myNewRow2 = New GridViewRow(-1, -1, DataControlRowType.Header, DataControlRowState.Normal)
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell("Port", 1))
        myNewRow2.Cells.Add(MakeCell("Strb"))
        myNewRow2.Cells.Add(MakeCell("Center"))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell(0, 1))
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        ' myTable.Rows.AddAt(1, myNewRow2)


    End Sub

    Private Shared Function MakeCell(Optional text As String = Nothing, Optional span As Integer = 1) As TableHeaderCell
        Return New TableHeaderCell() With {.ColumnSpan = span, .Text = If(text, String.Empty), .CssClass = "table-subheader"}
    End Function

    Protected Sub form1_Load(sender As Object, e As EventArgs) Handles form1.Load
        'AddSuperHeader(gvOverviewTubes)
    End Sub
End Class
