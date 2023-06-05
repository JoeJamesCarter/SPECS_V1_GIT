
Imports System.Data
Imports System.Data.SqlClient
Imports MySql.Data.MySqlClient

Partial Class KittingLabels_HelmKittingLbl
    Inherits System.Web.UI.Page

    Public Prerigs As New DataTable
    Public bomChildren As New DataTable
    Public kittedBomChildren As New DataTable
    Public partsNotKitted As New DataTable


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub KittingLabels_HelmKittingLbl_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim BoatSoNo As String
        Dim ProdNo As String
        Dim Boat As String

        BoatSoNo = Request.QueryString("SONo")
        ProdNo = Request.QueryString("ProdNo")
        Boat = Request.QueryString("Boat")

        lblProdNoKitLbl.Text = ProdNo

        Dim Model As String = Boat 'GetModel(ProdNo)
        lblModelKitLbl.Text = Boat

        Dim prerigPart As String

        getPartsNotKitted()


        If Not IsPostBack Then
            prerigPart = GetPrerig(BoatSoNo)
            hdnPrerigPart.Value = prerigPart
        Else
            'getPartsNotKitted()
            hideNotKittedParts()
            'gvPreRigParts.DataBind()

        End If
    End Sub

    Private Sub gvPreRigParts_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvPreRigParts.RowCommand
        If e.CommandName = "markasnotkittedhere" Then
            'This code is for the update button
            Dim PartNo As String = e.CommandArgument 'get the row that is clicked
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.Parameters.AddWithValue("@Part", PartNo)
            cmd.Parameters.AddWithValue("@Today", TodaysDate)

            cmd.CommandText = "Insert Into HelmKittingPartsNotKitted (PartNo, DateAdded) Values (@Part, @Today)"

            Try
                conn.Open()
                cmd.ExecuteNonQuery()
                conn.Close()
                'hideNotKittedParts()
            Catch ex As Exception

            End Try

        End If

    End Sub


    Public Function getPartsNotKitted() As String
        Dim SqlDataAdapter As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr

        partsNotKitted.Clear()

        SqlDataAdapter.SelectCommand = New SqlCommand("SELECT PartNo as comp_item_no, 1 as NotKittedFlag From HelmKittingPartsNotKitted order by PartNo", conn)
        SqlDataAdapter.Fill(partsNotKitted)

        Return True
    End Function

    Public Function GetPrerig(BoatSoNo As String) As String


        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr

        cmd.CommandType = CommandType.Text
        cmd.CommandText = "SELECT Count(OEORDLIN_SQL.item_desc_1) FROM [OEORDLIN_SQL] WHERE [ord_no] = '" & BoatSoNo & "'  and item_desc_1 like '%EXT AFT%'"
        cmd.Connection = conn

        Dim optionalEAD As Integer = 0
        Dim standardEAD As String = 0

        conn.Open()

        optionalEAD = cmd.ExecuteScalar()

        If optionalEAD > 0 Then
            lblEAD.Text = "YES"
        Else 'check if standard
            standardEAD = CheckStdsForEAD(lblProdNoKitLbl.Text, lblModelKitLbl.Text)
            lblEAD.Text = "YES"
        End If

        If optionalEAD = 0 And standardEAD = 0 Then
            lblEAD.Visible = False
            lblEADHdr.Visible = False
            lblEAD.Text = "NO"
        End If


        Dim SqlDataAdapter As New SqlDataAdapter


        'sometimes there is more than one prerig part on an order.  I narrowed it down to PPY, PPM, PPV, PPS, PPH to get the highest level prerig
        SqlDataAdapter.SelectCommand = New SqlCommand("SELECT RTrim(OEORDLIN_SQL.item_no) as PreRig, IMITMIDX_SQL.item_desc_1 as Description FROM [OEORDLIN_SQL] Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE [ord_no] = '" & BoatSoNo & "'  and mat_cost_type = 'PRE' and imitmidx_sql.prod_cat like 'PP%'", conn)
        'SqlDataAdapter.SelectCommand = New SqlCommand("SELECT RTrim(OEORDLIN_SQL.item_no) as PreRig, IMITMIDX_SQL.item_desc_1 as Description FROM [OEORDLIN_SQL] Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE [ord_no] = '" & BoatSoNo & "'  and ((mat_cost_type = 'PRE') or (mat_cost_type ='A4' and (imitmidx_sql.prod_cat = 'PL2' or imitmidx_sql.prod_cat = 'PL1')))", conn)


        SqlDataAdapter.Fill(Prerigs)
        gvPrerigs.DataSource = Prerigs
        gvPrerigs.DataBind()

        For Each row As GridViewRow In gvPrerigs.Rows
            If Not IsPostBack Then
                GetBOM(row.Cells(0).Text)
            End If

        Next

        Return True

    End Function

    Public Function GetBOM(prerigPart As String) As String

        Dim SqlDataAdapter As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()

        SqlDataAdapter.SelectCommand = New SqlCommand("Select bmprdstr_sql.comp_item_no, imitmidx_sql.item_desc_1, 0 as NotKittedFlag FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where (imitmidx_sql.mat_cost_type = 'OPP' and (imitmidx_sql.prod_cat = 07 or imitmidx_sql.prod_cat = 08 or imitmidx_sql.prod_cat = 16 or imitmidx_sql.prod_cat = 17 )) and bmprdstr_sql.item_no = '" & prerigPart & "'", conn)
        SqlDataAdapter.Fill(bomChildren)

        bomChildren.PrimaryKey = New DataColumn() {bomChildren.Columns("comp_item_no")}
        partsNotKitted.PrimaryKey = New DataColumn() {partsNotKitted.Columns("comp_item_no")}

        hideNotKittedParts()

        Dim view As DataView = bomChildren.DefaultView
        view.RowFilter = "NotKittedFlag = 0 "

        gvPreRigParts.DataSource = view
        gvPreRigParts.DataBind()

        Return False

    End Function

    Public Function hideNotKittedParts() As String
        'MesgBox("hide Not kitted")
        getPartsNotKitted()

        For Each row As DataRow In bomChildren.Rows

            Dim partno As String = Trim(row("comp_item_no"))
            Dim view As DataView = partsNotKitted.DefaultView

            view.RowFilter = "comp_item_no = " + partno

            If view.Count > 0 Then
                row.Delete()
                'row("NotKittedFlag") = 1
            End If
        Next
        gvPreRigParts.DataBind()
        Return False
    End Function

    'Public Function GetModel(ProdNo As String) As String

    '    Dim conn As New SqlConnection()
    '    Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
    '    Dim cmd As New SqlCommand
    '    conn.ConnectionString = connstr

    '    cmd.CommandType = CommandType.Text
    '    cmd.CommandText = "SELECT ItemNo From BML_POPREPORTING_GREENLIGHTS WHERE ProdNo = '" & ProdNo & "'"
    '    cmd.Connection = conn

    '    conn.Open()

    '    Dim model As String = cmd.ExecuteScalar().ToString()

    '    Return model

    'End Function

    Public Function CheckStdsForEAD(ProdNo As String, Model As String) As String
        Dim conn As New MySqlConnection()
        Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=webRO;password=6YAnDqMRU82SYYnz;persistsecurityinfo=True;database=Eos"
        Dim cmd As New MySqlCommand
        conn.ConnectionString = connstr

        Dim tbltoCheck As String = "Eos.standards_matrix_20" & Left(ProdNo, 2)

        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@tbltoCheck", tbltoCheck)
        cmd.Parameters.AddWithValue("@Model", Model)


        cmd.CommandText = "Select Count(*) FROM " + tbltoCheck + " where Substring(Model, 1, length(model) -2) = @Model and (STANDARD = 'S117' or STANDARD = 'S200' or STANDARD = 'S228');"
        cmd.Connection = conn

        conn.Open()
        Dim optionalEADCount As Int16
        optionalEADCount = cmd.ExecuteScalar
        conn.Close()

        Return optionalEADCount
    End Function




End Class
