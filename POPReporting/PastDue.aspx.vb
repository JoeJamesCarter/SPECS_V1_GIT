Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.IO

Partial Class PastDue
    Inherits System.Web.UI.Page

    Public PastDueBoats As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
        Dim TodaysDate As Date = Date.Now
        Dim Yesterday As Date = Date.Now.AddDays(-1)
        Dim ThisDay As Date = TodaysDate.Date

        Dim sqldataadapter As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        conn.ConnectionString = connstr

        conn.Open()

        sqldataadapter.SelectCommand = New SqlCommand("Select BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING_TUBEPRIORITY.Series, BML_POPREPORTING_GREENLIGHTS.BuildLoc, FurnitureStatus, FiberglassStatus, CoversStatus, RailsStatus, TubesStatus, CentertubeStatus, GaugeStatus, HarnessStatus FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate < '" & TodaysDate & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'", conn)
        sqldataadapter.Fill(PastDueBoats)

        conn.Close()
        conn.Dispose()
        Return False

    End Function
    Protected Function SetPastdueCountsBySeries() As String
        Dim QXSs() As DataRow = PastDueBoats.Select("Series =  'QXS' and BuildLoc ='S'")
        Dim QXSm() As DataRow = PastDueBoats.Select("Series =  'QXS' and BuildLoc ='M'")
        Dim QXSv() As DataRow = PastDueBoats.Select("Series =  'QXS' and BuildLoc ='V'")

        lblQXSs.Text = QXSs.Length
        lblQXSm.Text = QXSm.Length
        lblQXSv.Text = QXSv.Length

        Dim QXs() As DataRow = PastDueBoats.Select("Series =  'QX' and BuildLoc ='S'")
        Dim QXm() As DataRow = PastDueBoats.Select("Series =  'QX' and BuildLoc ='M'")
        Dim QXv() As DataRow = PastDueBoats.Select("Series =  'QX' and BuildLoc ='V'")

        lblQXs.Text = QXs.Length
        lblQXm.Text = QXm.Length
        lblQXv.Text = QXv.Length

        Dim Qs() As DataRow = PastDueBoats.Select("Series =  'Q' and BuildLoc ='S'")
        Dim Qm() As DataRow = PastDueBoats.Select("Series =  'Q' and BuildLoc ='M'")
        Dim Qv() As DataRow = PastDueBoats.Select("Series =  'Q' and BuildLoc ='V'")

        lblQs.Text = Qs.Length
        lblQm.Text = Qm.Length
        lblQv.Text = Qv.Length

        Dim RXs() As DataRow = PastDueBoats.Select("Series =  'RX' and BuildLoc ='S'")
        Dim RXm() As DataRow = PastDueBoats.Select("Series =  'RX' and BuildLoc ='M'")
        Dim RXv() As DataRow = PastDueBoats.Select("Series =  'RX' and BuildLoc ='V'")

        lblRXs.Text = RXs.Length
        lblRXm.Text = RXm.Length
        lblRXv.Text = RXv.Length


        Dim RTs() As DataRow = PastDueBoats.Select("Series =  'RT' and BuildLoc ='S'")
        Dim RTm() As DataRow = PastDueBoats.Select("Series =  'RT' and BuildLoc ='M'")
        Dim RTv() As DataRow = PastDueBoats.Select("Series =  'RT' and BuildLoc ='V'")

        lblRTs.Text = RTs.Length
        lblRTm.Text = RTm.Length
        lblRTv.Text = RTv.Length

        Dim Rs() As DataRow = PastDueBoats.Select("Series =  'R' and BuildLoc ='S'")
        Dim Rm() As DataRow = PastDueBoats.Select("Series =  'R' and BuildLoc ='M'")
        Dim Rv() As DataRow = PastDueBoats.Select("Series =  'R' and BuildLoc ='V'")

        lblRs.Text = Rs.Length
        lblRm.Text = Rm.Length
        lblRv.Text = Rv.Length

        Dim LXs() As DataRow = PastDueBoats.Select("Series =  'LX' and BuildLoc ='S'")
        Dim LXm() As DataRow = PastDueBoats.Select("Series =  'LX' and BuildLoc ='M'")
        Dim LXv() As DataRow = PastDueBoats.Select("Series =  'LX' and BuildLoc ='V'")

        lblLXs.Text = LXs.Length
        lblLXm.Text = LXm.Length
        lblLXv.Text = LXv.Length


        'LXS CHANGES THAT MAY BE NEEDED> NOT SURE WHERE TO MAKE THESE LABELS EXIST> JJC

        Dim LXSs() As DataRow = PastDueBoats.Select("Series =  'LXS' and BuildLoc ='S'")
        Dim LXSm() As DataRow = PastDueBoats.Select("Series =  'LXS' and BuildLoc ='M'")
        Dim LXSv() As DataRow = PastDueBoats.Select("Series =  'LXS' and BuildLoc ='V'")

        lblLXSs.Text = LXSs.Length
        lblLXSm.Text = LXSm.Length
        lblLXSv.Text = LXSv.Length

        Dim LTs() As DataRow = PastDueBoats.Select("Series =  'LT' and BuildLoc ='S'")
        Dim LTm() As DataRow = PastDueBoats.Select("Series =  'LT' and BuildLoc ='M'")
        Dim LTv() As DataRow = PastDueBoats.Select("Series =  'LT' and BuildLoc ='V'")

        lblLTs.Text = LTs.Length
        lblLTm.Text = LTm.Length
        lblLTv.Text = LTv.Length

        Dim Ls() As DataRow = PastDueBoats.Select("Series =  'L' and BuildLoc ='S'")
        Dim Lm() As DataRow = PastDueBoats.Select("Series =  'L' and BuildLoc ='M'")
        Dim Lv() As DataRow = PastDueBoats.Select("Series =  'L' and BuildLoc ='V'")

        lblLs.Text = Ls.Length
        lblLm.Text = Lm.Length
        lblLv.Text = Lv.Length

        Dim SXs() As DataRow = PastDueBoats.Select("Series =  'SX' and BuildLoc ='S'")
        Dim SXm() As DataRow = PastDueBoats.Select("Series =  'SX' and BuildLoc ='M'")
        Dim SXv() As DataRow = PastDueBoats.Select("Series =  'SX' and BuildLoc ='V'")

        lblSXs.Text = SXs.Length
        lblSXm.Text = SXM.Length
        lblSXv.Text = SXv.Length

        Dim Ss() As DataRow = PastDueBoats.Select("Series =  'S' and BuildLoc ='S'")
        Dim Sm() As DataRow = PastDueBoats.Select("Series =  'S' and BuildLoc ='M'")
        Dim Sv() As DataRow = PastDueBoats.Select("Series =  'S' and BuildLoc ='V'")

        lblSs.Text = Ss.Length
        lblSm.Text = Sm.Length
        lblSval.Text = Sv.Length

        Dim SVs() As DataRow = PastDueBoats.Select("Series =  'SV' and BuildLoc ='S'")
        Dim SVm() As DataRow = PastDueBoats.Select("Series =  'SV' and BuildLoc ='M'")
        Dim SVv() As DataRow = PastDueBoats.Select("Series =  'SV' and BuildLoc ='V'")

        lblSVs.Text = SVs.Length
        lblSVm.Text = SVm.Length
        lblSVv.Text = SVv.Length

        Dim Fs() As DataRow = PastDueBoats.Select("FurnitureStatus < 2 and BuildLoc ='S'")
        Dim Fm() As DataRow = PastDueBoats.Select("FurnitureStatus < 2  and BuildLoc ='M'")
        Dim Fv() As DataRow = PastDueBoats.Select("FurnitureStatus  < 2  and BuildLoc ='V'")

        lblFs.Text = Fs.Length
        lblFm.Text = Fm.Length
        lblFv.Text = Fv.Length

        Dim FGs() As DataRow = PastDueBoats.Select("FiberglassStatus < 2 and BuildLoc ='S'")
        Dim FGm() As DataRow = PastDueBoats.Select("FiberglassStatus < 2  and BuildLoc ='M'")
        Dim FGv() As DataRow = PastDueBoats.Select("FiberglassStatus  < 2  and BuildLoc ='V'")

        lblFGs.Text = FGs.Length
        lblFGm.Text = FGm.Length
        lblFGv.Text = FGv.Length

        Dim Cs() As DataRow = PastDueBoats.Select("CoversStatus < 2 and BuildLoc ='S'")
        Dim Cm() As DataRow = PastDueBoats.Select("CoversStatus < 2  and BuildLoc ='M'")
        Dim Cv() As DataRow = PastDueBoats.Select("CoversStatus  < 2  and BuildLoc ='V'")

        lblCs.Text = Cs.Length
        lblCm.Text = Cm.Length
        lblCv.Text = Cv.Length

        Dim Railss() As DataRow = PastDueBoats.Select("RailsStatus < 2 and BuildLoc ='S'")
        Dim Railsm() As DataRow = PastDueBoats.Select("RailsStatus < 2  and BuildLoc ='M'")
        Dim Railsv() As DataRow = PastDueBoats.Select("RailsStatus  < 2  and BuildLoc ='V'")

        lblRailss.Text = Railss.Length
        lblRailsm.Text = Railsm.Length
        lblRailsv.Text = Railsv.Length

        Dim Ts() As DataRow = PastDueBoats.Select("TubesStatus < 2 and BuildLoc ='S'")
        Dim Tm() As DataRow = PastDueBoats.Select("TubesStatus < 2  and BuildLoc ='M'")
        Dim Tv() As DataRow = PastDueBoats.Select("TubesStatus  < 2  and BuildLoc ='V'")

        lblTs.Text = Ts.Length
        lblTm.Text = Tm.Length
        lblTv.Text = Tv.Length

        Dim CTs() As DataRow = PastDueBoats.Select("CenterTubeStatus < 2 and BuildLoc ='S'")
        Dim CTm() As DataRow = PastDueBoats.Select("CenterTubeStatus < 2  and BuildLoc ='M'")
        Dim CTv() As DataRow = PastDueBoats.Select("CenterTubeStatus  < 2  and BuildLoc ='V'")

        lblCTs.Text = CTs.Length
        lblCTm.Text = CTm.Length
        lblCTv.Text = CTv.Length

        Dim Gs() As DataRow = PastDueBoats.Select("GaugeStatus < 2 and BuildLoc ='S'")
        Dim Gm() As DataRow = PastDueBoats.Select("GaugeStatus < 2  and BuildLoc ='M'")
        Dim Gv() As DataRow = PastDueBoats.Select("GaugeStatus  < 2  and BuildLoc ='V'")

        lblGaugess.Text = Gs.Length
        lblGaugesm.Text = Gm.Length
        lblGaugesv.Text = Gv.Length

        Dim Hs() As DataRow = PastDueBoats.Select("HarnessStatus < 2 and BuildLoc ='S'")
        Dim Hm() As DataRow = PastDueBoats.Select("HarnessStatus < 2  and BuildLoc ='M'")
        Dim Hv() As DataRow = PastDueBoats.Select("HarnessStatus  < 2  and BuildLoc ='V'")

        lblHs.Text = Hs.Length
        lblHm.Text = Hm.Length
        lblHv.Text = Hv.Length


    End Function

    Protected Sub gvRails_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvRails.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rails" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rails" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        PopulateDataTables()
        SetPastdueCountsBySeries()

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

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
        Dim cmd36 As New SqlCommand

        Dim cmd37 As New SqlCommand
        Dim cmd38 As New SqlCommand
        Dim cmd39 As New SqlCommand
        Dim cmd40 As New SqlCommand
        Dim cmd41 As New SqlCommand
        Dim cmd42 As New SqlCommand
        Dim cmd43 As New SqlCommand
        Dim cmd44 As New SqlCommand
        Dim cmd45 As New SqlCommand
        Dim cmd46 As New SqlCommand

        Dim cmd47 As New SqlCommand
        Dim cmd48 As New SqlCommand
        Dim cmd49 As New SqlCommand
        Dim cmd50 As New SqlCommand
        Dim cmd51 As New SqlCommand
        Dim cmd52 As New SqlCommand
        Dim cmd53 As New SqlCommand
        Dim cmd54 As New SqlCommand


        Dim TodaysDate As Date = Date.Now
        Dim Yesterday As Date = Date.Now.AddDays(-1)
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String
        Dim southcount As Int16
        Dim maincount As Int16
        Dim valuecount As Int16
        Dim totalbehind As Int16

        If ddlDaysInAdvance.Items.Count = 0 Then  'stop it from repopulating everytime the grid rebinds
            DaystoShow = ThisDay.AddDays(5).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("3 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(7).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("5 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(12).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("10 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(17).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("15 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(22).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("20 Days", DaystoShow))
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd3.CommandType = CommandType.Text
        cmd4.CommandType = CommandType.Text

        'to get the count of the prod #'s completed that day

        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and DueDate >'" & TodaysDate & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & TodaysDate & "'  and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & TodaysDate & "'  and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"

        cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'QX' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'Q' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'R' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2  and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'G' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'SXP' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'SX' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "'  and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd11.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'S' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd12.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where ((BML_POPREPORTING_Greenlights.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus = '0') Or (BML_POPREPORTING_Greenlights.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus = '1')) and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2  and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "'"

        cmd47.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'QXS' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd13.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'QX' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd14.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'Q' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd48.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'RX' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd15.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'R' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd16.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'G' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd17.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'SXP' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd18.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'SX' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd19.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'S' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd49.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'SV' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"

        cmd20.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where (BML_POPREPORTING_Greenlights.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus = '0') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "'"
        cmd50.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where (BML_POPREPORTING_Greenlights.BuildLoc = 'V' and BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus = '0') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "'"

        'cmd50.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'QXS' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd21.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'QX' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd22.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'Q' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd51.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'RX' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd23.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'R' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd24.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'G' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd25.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'SXP' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd26.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'SX' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd27.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'S' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd52.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where BML_POPREPORTING_TUBEPRIORITY.SERIES = 'SV' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"

        cmd28.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where (BML_POPREPORTING_Greenlights.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus = '1') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "'"

        cmd29.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.FurnitureStatus <> 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd30.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.FiberglassStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd31.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.CoversStatus <> 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd32.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.RailsStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "'"
        cmd33.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.TubesStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "'"
        cmd34.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and (BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.CentertubeStatus < 2) and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd35.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.GaugeStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd36.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.HarnessStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"

        cmd37.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.FurnitureStatus <> 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd38.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.FiberglassStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd39.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.CoversStatus <> 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd40.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.RailsStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd41.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.TubesStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd42.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and(BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.CentertubeStatus < 2)and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd43.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.GaugeStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd44.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.HarnessStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & Yesterday & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"

        cmd45.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = 'M' and DueDate >'" & TodaysDate & "'"
        cmd46.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = 'S' and DueDate >'" & TodaysDate & "'"

        cmd53.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & TodaysDate & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"
        cmd54.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = 'V' and DueDate >'" & TodaysDate & "' and BML_POPREPORTING_GREENLIGHTS.ProdNo > '2100000'"


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
        cmd36.Connection = conn
        cmd37.Connection = conn
        cmd38.Connection = conn
        cmd39.Connection = conn
        cmd40.Connection = conn
        cmd41.Connection = conn
        cmd42.Connection = conn
        cmd43.Connection = conn
        cmd44.Connection = conn
        cmd45.Connection = conn
        cmd46.Connection = conn
        cmd47.Connection = conn
        cmd48.Connection = conn
        cmd49.Connection = conn
        cmd50.Connection = conn
        cmd51.Connection = conn
        cmd52.Connection = conn
        cmd53.Connection = conn
        cmd54.Connection = conn


        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        'recordcount = Convert.ToInt16(cmd4.ExecuteScalar())
        'lblBoatsStarted.Text = recordcount

        maincount = Convert.ToInt16(cmd3.ExecuteScalar())
        southcount = Convert.ToInt16(cmd4.ExecuteScalar())
        valuecount = Convert.ToInt16(cmd53.ExecuteScalar())

        lblMain.Text = maincount
        lblValue.Text = valuecount
        lblSouth.Text = southcount
        lblQX.text = cmd5.ExecuteScalar()
        lblQ.text = cmd6.ExecuteScalar()
        lblR.text = cmd7.ExecuteScalar()
        'lblG.text = cmd8.ExecuteScalar()
        'lblSXP.text = cmd9.ExecuteScalar()
        lblSX.text = cmd10.ExecuteScalar()
        lblS.text = cmd11.ExecuteScalar()
        lblNotGreen.Text = cmd12.ExecuteScalar

        'lblQXSm.text = cmd47.ExecuteScalar()
        'lblQXm.text = cmd13.ExecuteScalar()
        'lblQm.Text = cmd14.ExecuteScalar
        'lblRXm.text = cmd48.ExecuteScalar
        'lblRm.text = cmd15.ExecuteScalar
        'lblGm.text = cmd16.ExecuteScalar
        'lblSXPm.text = cmd17.ExecuteScalar
        'lblSXm.text = cmd18.ExecuteScalar
        'lblSm.Text = cmd19.ExecuteScalar
        'lblSVm.text = cmd49.ExecuteScalar
        lblNGm.Text = cmd20.ExecuteScalar
        lblNGv.TExt = cmd50.ExecuteScalar

        'lblQXSs.text = cmd50.ExecuteScalar()
        'lblQXs.Text = cmd21.ExecuteScalar()
        'lblQs.Text = cmd22.ExecuteScalar
        'lblRXs.text = cmd51.ExecuteScalar
        'lblRs.text = cmd23.ExecuteScalar
        'lblGs.text = cmd24.ExecuteScalar
        'lblSXPs.text = cmd25.ExecuteScalar
        'lblSXs.text = cmd26.ExecuteScalar
        'lblSs.Text = cmd27.ExecuteScalar
        'lblSVs.text = cmd52.ExecuteScalar
        lblNGs.text = cmd28.ExecuteScalar

        'lblFm.text = cmd29.ExecuteScalar
        ' lblFGm.text = cmd30.ExecuteScalar
        'lblCm.text = cmd31.ExecuteScalar
        'lblRailsm.text = cmd32.ExecuteScalar
        'lblTm.text = cmd33.ExecuteScalar
        'lblCTm.text = cmd34.ExecuteScalar
        'lblGaugesm.text = cmd35.ExecuteScalar
        'lblHm.text = cmd36.ExecuteScalar

        'lblFs.text = cmd37.ExecuteScalar
        'lblFGs.text = cmd38.ExecuteScalar
        'lblCs.text = cmd39.ExecuteScalar
        'lblRailss.text = cmd40.ExecuteScalar
        'lblTs.text = cmd41.ExecuteScalar
        'lblCTs.text = cmd42.ExecuteScalar
        'lblGaugess.text = cmd43.ExecuteScalar
        'lblHs.text = cmd44.ExecuteScalar

        lblFtotal.Text = Convert.ToInt16(lblFm.Text) + Convert.ToInt16(lblFs.Text) + Convert.ToInt16(lblFv.text)
        lblFGtotal.Text = Convert.ToInt16(lblFGm.Text) + Convert.ToInt16(lblFGs.Text) + Convert.ToInt16(lblFGv.text)
        lblCtotal.Text = Convert.ToInt16(lblCm.Text) + Convert.ToInt16(lblCs.Text) + Convert.ToInt16(lblCv.Text)
        lblRailstotal.Text = Convert.ToInt16(lblRailsm.Text) + Convert.ToInt16(lblRailss.Text) + Convert.ToInt16(lblRailsv.Text)
        lblTtotal.Text = Convert.ToInt16(lblTm.Text) + Convert.ToInt16(lblTs.Text) + Convert.ToInt16(lblTv.Text)
        lblCTtotal.Text = Convert.ToInt16(lblCTm.Text) + Convert.ToInt16(lblCTs.Text) + Convert.ToInt16(lblCTv.Text)
        lblGtotal.Text = Convert.ToInt16(lblGaugesm.Text) + Convert.ToInt16(lblGaugess.Text) + Convert.ToInt16(lblGaugesv.Text)
        lblHtotal.Text = Convert.ToInt16(lblHm.Text) + Convert.ToInt16(lblHs.Text) + Convert.ToInt16(lblHv.Text)

        lblQXStotal.Text = Convert.ToInt16(lblQXSs.Text) + Convert.ToInt16(lblQXSm.Text) + Convert.ToInt16(lblQXSv.Text)
        lblRX.Text = Convert.ToInt16(lblRXs.Text) + Convert.ToInt16(lblRXm.Text) + Convert.ToInt16(lblRXv.Text)
        lblRT.Text = Convert.ToInt16(lblRTs.Text) + Convert.ToInt16(lblRTm.Text) + Convert.ToInt16(lblRTv.Text)
        lblLT.Text = Convert.ToInt16(lblLTs.Text) + Convert.ToInt16(lblLTm.Text) + Convert.ToInt16(lblLTv.Text)
        lblLX.Text = Convert.ToInt16(lblLXs.Text) + Convert.ToInt16(lblLXm.Text) + Convert.ToInt16(lblLXv.Text)
        lblLXStotal.Text = Convert.ToInt16(lblLXSs.Text) + Convert.ToInt16(lblLXSm.Text) + Convert.ToInt16(lblLXSv.Text)
        lblL.Text = Convert.ToInt16(lblLs.Text) + Convert.ToInt16(lblLm.Text) + Convert.ToInt16(lblLv.Text)
        lblSV.Text = Convert.ToInt16(lblSVs.Text) + Convert.ToInt16(lblSVm.Text) + Convert.ToInt16(lblSVv.Text)

        lblShrinkedAhead.Text = cmd2.ExecuteScalar

        lblTotalBehind.Text = maincount + southcount + valuecount
        lblMainAhead.Text = cmd45.ExecuteScalar
        lblValueAhead.text = cmd54.ExecuteScalar
        lblSouthAhead.text = cmd46.ExecuteScalar

        lblMainDiff.Text = Convert.ToInt16(lblMainAhead.Text) - Convert.ToInt16(lblMain.Text)
        lblvalueDiff.text = Convert.ToInt16(lblValueAhead.text) - Convert.ToInt16(lblValue.Text)
        lblSouthDiff.text = Convert.ToInt16(lblSouthAhead.text) - Convert.ToInt16(lblSouth.Text)
        lblScore.text = Convert.ToInt16(lblShrinkedAhead.Text) - Convert.ToInt16(lblTotalBehind.Text)
        'MesgBox(recordcount)
        conn.Close()

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvRails.DataBind()
    End Sub

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As EventArgs)
        ExportExcel("PastDueExport", gvRails)
    End Sub

    Public Sub ExportExcel(ByVal filename As String, ByVal gv As GridView)
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=" & filename & ".xls")
        Response.ContentType = "application/vnd.ms-excel"
        Dim sw As New StringWriter()
        Dim htw As New HtmlTextWriter(sw)
        gv.RenderControl(htw)
        Response.Write(sw.ToString())
        Response.[End]()
    End Sub

    Protected Sub gvRails_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRails.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsRails"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If
    End Sub


End Class
