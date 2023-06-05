Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration


Partial Class OverviewKitting
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

        gvOverview.DataBind()

    End Sub

    Private Shared Sub AddSuperHeader(gridView As GridView)
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd6 As New SqlCommand
        Dim cmd7 As New SqlCommand
        Dim cmd8 As New SqlCommand
        Dim cmd9 As New SqlCommand
        Dim cmd10 As New SqlCommand
        Dim cmd11 As New SqlCommand
        Dim cmd12 As New SqlCommand
        Dim cmd13 As New SqlCommand
        Dim cmd14 As New SqlCommand
        Dim cmd15 As New SqlCommand
        Dim cmd16 As New SqlCommand
        Dim cmd17 As New SqlCommand
        Dim cmd18 As New SqlCommand
        Dim cmd19 As New SqlCommand


        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim furnitureprepcount As Int16 = 0
        Dim fiberglassprepcount As Int16 = 0
        Dim coverscount As Int16 = 0
        Dim railsprepcount As Int16 = 0
        Dim tubesprepcount As Int16 = 0

        Dim framescount As Int16 = 0
        Dim floorscount As Int16 = 0
        Dim railscount As Int16 = 0
        Dim furniturecount As Int16 = 0
        Dim helmcount As Int16 = 0
        Dim cleaningcount As Int16 = 0
        Dim finalcount As Int16 = 0
        Dim shrinkwrapcount As Int16 = 0
        Dim wavetamercount As Int16 = 0
        Dim sharkhidecount As Int16 = 0
        Dim completecount As Int16 = 0
        Dim offlinecount As Int16 = 0
        Dim centertubecount As Int16 = 0
        Dim riggingcount As Int16 = 0

        cmd.CommandType = CommandType.Text
        cmd2.CommandType = CommandType.Text
        cmd3.CommandType = CommandType.Text
        cmd4.CommandType = CommandType.Text
        cmd5.CommandType = CommandType.Text
        cmd6.CommandType = CommandType.Text
        cmd7.CommandType = CommandType.Text
        cmd8.CommandType = CommandType.Text
        cmd9.CommandType = CommandType.Text
        cmd10.CommandType = CommandType.Text
        cmd11.CommandType = CommandType.Text
        cmd12.CommandType = CommandType.Text
        cmd13.CommandType = CommandType.Text
        cmd14.CommandType = CommandType.Text
        cmd15.CommandType = CommandType.Text
        cmd16.CommandType = CommandType.Text
        cmd17.CommandType = CommandType.Text
        cmd18.CommandType = CommandType.Text
        cmd19.CommandType = CommandType.Text



        cmd.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd8.Connection = conn
        cmd9.Connection = conn
        cmd10.Connection = conn
        cmd11.Connection = conn
        cmd12.Connection = conn
        cmd13.Connection = conn
        cmd14.Connection = conn
        cmd15.Connection = conn
        cmd16.Connection = conn
        cmd17.Connection = conn
        cmd18.Connection = conn
        cmd19.Connection = conn





        cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus = 2 and Convert(date,FurniturePrepLastUpdated) ='" & ThisDay & "'"
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FiberglassStatus = 2 and Convert(date,FiberglassLastUpdated) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CoversStatus = 2 and Convert(date,CoversLastUpdated) ='" & ThisDay & "'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsStatus = 2 and Convert(date,RailsLastUpdated) ='" & ThisDay & "'"
        cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = 2 and Convert(date,TubesLastUpdated) ='" & ThisDay & "'"

        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 2 and BuildLoc = M and Convert(date,FramesInstalled) ='" & ThisDay & "'"
        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 2 and BuildLoc = M and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
        cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = 2 and BuildLoc = M and Convert(date,RailsInstalled) ='" & ThisDay & "'"
        cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureInstalledStatus = 2 and BuildLoc = M and Convert(date,FurnitureInstalled) ='" & ThisDay & "'"
        cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmInstalledStatus = 2 and BuildLoc = M and Convert(date,HelmInstalled) ='" & ThisDay & "'"
        cmd11.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 2 and BuildLoc = M and Convert(date,Cleaning) ='" & ThisDay & "'"
        cmd12.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = M and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
        cmd13.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where WavetamerStatus = 2 and BuildLoc = M and Convert(date,WaveTamerInstalled) ='" & ThisDay & "'"
        cmd14.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FinalInspectionStatus = 2 and BuildLoc = M and Convert(date,FinalInspection) ='" & ThisDay & "'"
        cmd15.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where SharkhideStatus = 2 and BuildLoc = M and Convert(date,SharkhideInstalled) ='" & ThisDay & "'"
        cmd16.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CompleteStatus = 2 and BuildLoc = M and Convert(date,Complete) ='" & ThisDay & "'"
        cmd17.CommandText = "Select Count (*) FROM BML_POPREPORTING_OFFLINE where StatusSetTo = 'Offline' and BuildLoc = M and Convert(date,Date) ='" & ThisDay & "'"
        cmd18.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = '2' and BuildLoc = M and Convert(date,Centertube) ='" & ThisDay & "'"
        cmd19.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus = '2' and BuildLoc = M and Convert(date,Rigging) ='" & ThisDay & "'"



        'conn.Open()
        ' furnitureprepcount = Convert.ToInt16(cmd.ExecuteScalar())
        'fiberglassprepcount = Convert.ToInt16(cmd2.ExecuteScalar())
        'coverscount = Convert.ToInt16(cmd3.ExecuteScalar())
        'railsprepcount = Convert.ToInt16(cmd4.ExecuteScalar())
        'tubesprepcount = Convert.ToInt16(cmd5.ExecuteScalar())
        'framescount = Convert.ToInt16(cmd6.ExecuteScalar())
        'floorscount = Convert.ToInt16(cmd7.ExecuteScalar())
        'railscount = Convert.ToInt16(cmd8.ExecuteScalar())
        'furniturecount = Convert.ToInt16(cmd9.ExecuteScalar())
        'helmcount = Convert.ToInt16(cmd10.ExecuteScalar())
        'cleaningcount = Convert.ToInt16(cmd11.ExecuteScalar())
        'shrinkwrapcount = Convert.ToInt16(cmd12.ExecuteScalar())
        'wavetamercount = Convert.ToInt16(cmd13.ExecuteScalar())
        'finalcount = Convert.ToInt16(cmd14.ExecuteScalar())
        'sharkhidecount = Convert.ToInt16(cmd15.ExecuteScalar())
        'completecount = Convert.ToInt16(cmd16.ExecuteScalar())
        'offlinecount = Convert.ToInt16(cmd17.ExecuteScalar())
        'centertubecount = Convert.ToInt16(cmd18.ExecuteScalar())

        'conn.Close()

        'all of this code adds a header above the gv header so that I can display the totals.
        Dim myTable = DirectCast(gridView.Controls(0), Table)
        Dim myNewRow = New GridViewRow(0, -1, DataControlRowType.Header, DataControlRowState.Normal)
        myNewRow.Cells.Add(MakeCell("Totals", 1))
        myNewRow.Cells.Add(MakeCell(furnitureprepcount, 1))
        myNewRow.Cells.Add(MakeCell(fiberglassprepcount, 1))
        myNewRow.Cells.Add(MakeCell(coverscount, 1))
        myNewRow.Cells.Add(MakeCell(railsprepcount, 1))
        myNewRow.Cells.Add(MakeCell(tubesprepcount, 1))
        myNewRow.Cells.Add(MakeCell(centertubecount, 1))
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell(framescount, 1))
        myNewRow.Cells.Add(MakeCell(floorscount, 1))
        myNewRow.Cells.Add(MakeCell(railscount, 1))
        myNewRow.Cells.Add(MakeCell(furniturecount, 1))
        myNewRow.Cells.Add(MakeCell(helmcount, 1))
        myNewRow.Cells.Add(MakeCell(cleaningcount, 1))
        myNewRow.Cells.Add(MakeCell(finalcount, 1))
        myNewRow.Cells.Add(MakeCell(shrinkwrapcount, 1))
        myNewRow.Cells.Add(MakeCell(riggingcount, 1))
        myNewRow.Cells.Add(MakeCell(wavetamercount, 1))
        myNewRow.Cells.Add(MakeCell(sharkhidecount, 1))
        myNewRow.Cells.Add(MakeCell(completecount, 1))
        myNewRow.Cells.Add(MakeCell(offlinecount, 1))
        myNewRow.Cells.Add(MakeCell("Notes", 1))
        myTable.Rows.AddAt(0, myNewRow)

    End Sub

    Private Shared Function MakeCell(Optional text As String = Nothing, Optional span As Integer = 1) As TableHeaderCell
        Return New TableHeaderCell() With {.ColumnSpan = span, .Text = If(text, String.Empty), .CssClass = "table-subheader"}
    End Function


    Protected Sub gvOverview_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOverview.RowDataBound
        Dim gvOverview = DirectCast(sender, GridView)
        If e.Row.RowType = DataControlRowType.DataRow Then
            'AddSuperHeader(gvOverview)
            e.Row.Cells(0).ToolTip = "Prod #"
            e.Row.Cells(1).ToolTip = "SO #"
            e.Row.Cells(2).ToolTip = "Due Date"
            e.Row.Cells(3).ToolTip = "Furniture"
            e.Row.Cells(4).ToolTip = "Fiberglass"
            e.Row.Cells(5).ToolTip = "Covers"
            e.Row.Cells(6).ToolTip = "Rails"
            e.Row.Cells(7).ToolTip = "Tubes"
            e.Row.Cells(8).ToolTip = "Center Tubes"
            e.Row.Cells(9).ToolTip = "Gauge/Harness"

            e.Row.Cells(10).ToolTip = "Kitting 1"
            e.Row.Cells(11).ToolTip = "Kitting 2"
            e.Row.Cells(12).ToolTip = "Kitting 3"
            e.Row.Cells(13).ToolTip = "Kitting 4"
            e.Row.Cells(14).ToolTip = "Kitting South"

            e.Row.Cells(15).ToolTip = "Helm"
            e.Row.Cells(16).ToolTip = "Gates"
            e.Row.Cells(17).ToolTip = "Bimini"


            e.Row.Cells(18).ToolTip = "Boat/Customer"
            e.Row.Cells(19).ToolTip = "Frames"
            e.Row.Cells(20).ToolTip = "Floors"
            e.Row.Cells(21).ToolTip = "Rails"
            e.Row.Cells(22).ToolTip = "Furniture"
            e.Row.Cells(23).ToolTip = "Helm"
            e.Row.Cells(24).ToolTip = "Inspection"
            e.Row.Cells(25).ToolTip = "Final Inspection"
            e.Row.Cells(26).ToolTip = "Shrinkwrap"
            e.Row.Cells(27).ToolTip = "Rigging"
            e.Row.Cells(28).ToolTip = "Wavetamer"
            e.Row.Cells(29).ToolTip = "Sharkhide"
            e.Row.Cells(30).ToolTip = "Complete"
            e.Row.Cells(31).ToolTip = "Offline"
            e.Row.Cells(32).ToolTip = "Notes"

            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If

    End Sub


    Protected Sub gvOverview_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvOverview.RowCommand
        If e.CommandName = "gotoorderdetails" Then 'handles when the ? button is clicked
            gvOverview.DataBind()
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            gvOverview.DataBind()
            Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command
            Dim workstation As String = "Overview"
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotooffline" Then
            gvOverview.DataBind()
            Dim Selected As String = e.CommandArgument 'get the row that is clicked
            Dim workstation As String = "Overview" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotostatus" Then
            gvOverview.DataBind()
            Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command
            Dim workstation As String = "Overview" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
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

    Protected Sub btnClearSO_Click(sender As Object, e As EventArgs) Handles btnClearSO.Click
        tbSONo.Text = ""
    End Sub
End Class
