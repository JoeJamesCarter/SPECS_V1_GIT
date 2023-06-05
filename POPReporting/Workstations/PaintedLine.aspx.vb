Imports System.Data
Imports System.Data.SqlClient
Partial Class Workstations_PaintedLine
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    'Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

    'gvOverview.DataBind()

    'End Sub

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

        Dim cmd20 As New SqlCommand
        Dim cmd21 As New SqlCommand
        Dim cmd22 As New SqlCommand
        Dim cmd23 As New SqlCommand
        Dim cmd24 As New SqlCommand
        Dim cmd25 As New SqlCommand
        Dim cmd26 As New SqlCommand
        Dim cmd27 As New SqlCommand
        Dim cmd28 As New SqlCommand
        Dim cmd29 As New SqlCommand
        Dim cmd30 As New SqlCommand
        Dim cmd31 As New SqlCommand
        Dim cmd32 As New SqlCommand
        Dim cmd33 As New SqlCommand
        Dim cmd34 As New SqlCommand
        Dim cmd35 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim furnitureprepcount As Int16 = 0
        Dim fiberglassprepcount As Int16 = 0
        Dim coverscount As Int16 = 0
        Dim railsprepcount As Int16 = 0
        Dim tubesprepcount As Int16 = 0

        Dim framescountM As Int16 = 0
        Dim floorscountM As Int16 = 0
        Dim trimcountM As Int16 = 0
        Dim railscountM As Int16 = 0
        Dim furniturecountM As Int16 = 0
        Dim helmcountM As Int16 = 0
        Dim cleaningcountM As Int16 = 0
        Dim finalcountM As Int16 = 0
        Dim shrinkwrapcountM As Int16 = 0
        Dim wavetamercountM As Int16 = 0
        Dim sharkhidecountM As Int16 = 0
        Dim completecountM As Int16 = 0
        Dim offlinecount As Int16 = 0
        Dim centertubecountM As Int16 = 0
        Dim riggingcountM As Int16 = 0


        Dim framescountS As Int16 = 0
        Dim floorscountS As Int16 = 0
        Dim trimcountS As Int16 = 0
        Dim railscountS As Int16 = 0
        Dim furniturecountS As Int16 = 0
        Dim helmcountS As Int16 = 0
        Dim cleaningcountS As Int16 = 0
        Dim finalcountS As Int16 = 0
        Dim shrinkwrapcountS As Int16 = 0
        Dim wavetamercountS As Int16 = 0
        Dim sharkhidecountS As Int16 = 0
        Dim completecountS As Int16 = 0
        Dim offlinecountS As Int16 = 0
        Dim centertubecountS As Int16 = 0
        Dim riggingcountS As Int16 = 0


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


        cmd20.CommandType = CommandType.Text
        cmd21.CommandType = CommandType.Text
        cmd22.CommandType = CommandType.Text
        cmd23.CommandType = CommandType.Text
        cmd24.CommandType = CommandType.Text
        cmd25.CommandType = CommandType.Text
        cmd26.CommandType = CommandType.Text
        cmd27.CommandType = CommandType.Text
        cmd29.CommandType = CommandType.Text
        cmd30.CommandType = CommandType.Text
        cmd31.CommandType = CommandType.Text
        cmd32.CommandType = CommandType.Text
        cmd33.CommandType = CommandType.Text
        cmd34.CommandType = CommandType.Text
        cmd35.CommandType = CommandType.Text

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

        cmd20.Connection = conn
        cmd21.Connection = conn
        cmd22.Connection = conn
        cmd23.Connection = conn
        cmd24.Connection = conn
        cmd25.Connection = conn
        cmd26.Connection = conn
        cmd27.Connection = conn
        cmd28.Connection = conn
        cmd29.Connection = conn
        cmd30.Connection = conn
        cmd31.Connection = conn
        cmd32.Connection = conn
        cmd33.Connection = conn
        cmd34.Connection = conn
        cmd35.Connection = conn

        cmd22.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = '2' and BuildLoc = 'P' and Convert(date,RailsInstalled) ='" & ThisDay & "'"
        cmd23.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureInstalledStatus = '2' and BuildLoc = 'P' and Convert(date,FurnitureInstalled) ='" & ThisDay & "'"
        cmd24.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmInstalledStatus = '2' and BuildLoc = 'P' and Convert(date,HelmInstalled) ='" & ThisDay & "'"
        cmd25.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = '2' and BuildLoc = 'P' and Convert(date,Cleaning) ='" & ThisDay & "'"
        cmd26.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and BuildLoc = 'P' and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

        cmd28.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FinalInspectionStatus = '2'  and BuildLoc = 'P' and Convert(date,FinalInspection) ='" & ThisDay & "'"

        conn.Open()

        railscountS = Convert.ToInt16(cmd22.ExecuteScalar())
        furniturecountS = Convert.ToInt16(cmd23.ExecuteScalar())
        helmcountS = Convert.ToInt16(cmd24.ExecuteScalar())
        cleaningcountS = Convert.ToInt16(cmd25.ExecuteScalar())
        shrinkwrapcountS = Convert.ToInt16(cmd26.ExecuteScalar())
        finalcountS = Convert.ToInt16(cmd28.ExecuteScalar())

        conn.Close()

        'all of this code adds a header above the gv header so that I can display the totals.
        Dim myTable = DirectCast(gridView.Controls(0), Table)

        'Row

        Dim myNewRow2 = New GridViewRow(0, -1, DataControlRowType.Header, DataControlRowState.Normal)
        myNewRow2.Cells.Add(MakeCell("Completed Today", 1))
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
        myNewRow2.Cells.Add(MakeCell(railscountS, 1))
        myNewRow2.Cells.Add(MakeCell(furniturecountS, 1))
        myNewRow2.Cells.Add(MakeCell(helmcountS, 1))
        myNewRow2.Cells.Add(MakeCell(cleaningcountS, 1))
        myNewRow2.Cells.Add(MakeCell(finalcountS, 1))
        myNewRow2.Cells.Add(MakeCell(shrinkwrapcountS, 1))
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myTable.Rows.AddAt(1, myNewRow2)


    End Sub

    Private Shared Function MakeCell(Optional text As String = Nothing, Optional span As Integer = 1) As TableHeaderCell
        Return New TableHeaderCell() With {.ColumnSpan = span, .Text = If(text, String.Empty), .CssClass = "table-subheader"}
    End Function


    Protected Sub gvOverview_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOverview.RowDataBound
        Dim gvOverview = DirectCast(sender, GridView)
        If e.Row.RowType = DataControlRowType.Header Then
            AddSuperHeader(gvOverview)
        End If

        If e.Row.RowType = DataControlRowType.DataRow Then
            'AddSuperHeader(gvOverview)
            e.Row.Cells(0).ToolTip = "Prod #"
            e.Row.Cells(1).ToolTip = "Furniture"
            e.Row.Cells(2).ToolTip = "Fiberglass"
            e.Row.Cells(3).ToolTip = "Covers"
            e.Row.Cells(4).ToolTip = "Rails"
            e.Row.Cells(5).ToolTip = "Tubes"
            e.Row.Cells(6).ToolTip = "Centertubes"
            e.Row.Cells(7).ToolTip = "Gauge/Harness"
            e.Row.Cells(8).ToolTip = "Boat/Customer/Due Date"
            e.Row.Cells(9).ToolTip = "Custom"
            e.Row.Cells(10).ToolTip = "Pilot"
            e.Row.Cells(11).ToolTip = "Rails"
            e.Row.Cells(12).ToolTip = "Furniture"
            e.Row.Cells(13).ToolTip = "Helm"
            e.Row.Cells(14).ToolTip = "Inspection"
            e.Row.Cells(15).ToolTip = "Final Inspection"
            e.Row.Cells(16).ToolTip = "Shrinkwrap"
            e.Row.Cells(17).ToolTip = "Offline"
            e.Row.Cells(18).ToolTip = "Notes"
        End If

        If e.Row.RowType = DataControlRowType.DataRow Then
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



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load


    End Sub



End Class