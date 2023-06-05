Imports System.Data
Imports System.Data.SqlClient

Partial Class PhyInv_WIP2
    Inherits System.Web.UI.Page

    Public soLines As New DataTable
    Public allComponents As New DataTable

    Public components As New DataTable
    Public components2 As New DataTable
    Public components3 As New DataTable
    Public components4 As New DataTable
    Public components5 As New DataTable
    Public components6 As New DataTable
    Public components7 As New DataTable


    Public selections As New DataTable
    Public rtrSelections As New DataTable

    Public compKits As New DataTable
    Public comp2Kits As New DataTable
    Public comp3Kits As New DataTable
    Public comp4Kits As New DataTable
    Public comp5Kits As New DataTable
    Public comp6Kits As New DataTable
    Public comp7Kits As New DataTable


    Public Class GlobalVariables
        Public Shared stationID As String

    End Class

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Try
            Dim BoatSONo As String
            BoatSONo = Request.QueryString("SONo")

            If BoatSONo.Length > 0 Then
                hdnSONo.Value = BoatSONo
                hdnSONoSkip2LeadingZeros.Value = Right(BoatSONo, Len(BoatSONo) - 2)
                getOrderLines(BoatSONo)
            End If
        Catch
        End Try

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        Dim stationID = SplitBValSlash(user)

        If Not IsPostBack Then
            gvSelections.DataBind()
        End If


    End Sub

    Protected Function SplitBValSlash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("\")(1)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function

    Public Function getOrderLines(BoatSONo As String) As String

        Dim SqlDataAdapter As New SqlDataAdapter
        Dim SqlDataAdapter1 As New SqlDataAdapter

        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1

        conn1.Open()

        SqlDataAdapter.SelectCommand = New SqlCommand("SELECT OEORDLIN_SQL.item_no as parent_item_no, IMITMIDX_SQL.item_desc_1 as parent_item_desc, [qty_ordered] as parent_qty, pur_or_mfg as parent_pOrM, '0' as bom_level FROM [OEORDLIN_SQL] Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = '" & hdnSONo.Value & "' ) and (mat_cost_type != 'DIF' and mat_cost_type != 'DIS' and mat_cost_type != 'DIV' and mat_cost_type != 'DLR' and mat_cost_type != 'ENG' and mat_cost_type != 'EMZ' and mat_cost_type != 'FR1' and mat_cost_type != 'FRE' and mat_cost_type != 'FRT' and mat_cost_type != 'GRO' and mat_cost_type != 'OP1' and mat_cost_type != 'SHO' and mat_cost_type != 'SPA' and mat_cost_type != 'SPE' and mat_cost_type != 'TRA' and mat_cost_type != 'TRD' and mat_cost_type != 'TRL' and mat_cost_type != 'VOL' and mat_cost_type != 'WAR' and mat_cost_type != 'WXP' and mat_cost_type != 'WXS' and mat_cost_type != 'ZZZ' and mat_cost_type != '999') Order By OEORDLIN_SQL.item_desc_1", conn1)
        SqlDataAdapter.Fill(soLines)

        If soLines.Rows.Count <= 0 Then 'completed boat - get lines from history instead
            Try
                SqlDataAdapter.SelectCommand = New SqlCommand("SELECT OELINHST_SQL.item_no as parent_item_no, IMITMIDX_SQL.item_desc_1 as parent_item_desc, [qty_ordered] as parent_qty, pur_or_mfg as parent_pOrM, '0' as bom_level FROM [OELINHST_SQL] Left Join IMITMIDX_SQL on OELINHST_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = '" & hdnSONo.Value & "' ) and (mat_cost_type != 'DIF' and mat_cost_type != 'DIS' and mat_cost_type != 'DIV' and mat_cost_type != 'DLR' and mat_cost_type != 'ENG' and mat_cost_type != 'EMZ' and mat_cost_type != 'FR1' and mat_cost_type != 'FRE' and mat_cost_type != 'FRT' and mat_cost_type != 'GRO' and mat_cost_type != 'OP1' and mat_cost_type != 'SHO' and mat_cost_type != 'SPA' and mat_cost_type != 'SPE' and mat_cost_type != 'TRA' and mat_cost_type != 'TRD' and mat_cost_type != 'TRL' and mat_cost_type != 'VOL' and mat_cost_type != 'WAR' and mat_cost_type != 'WXP' and mat_cost_type != 'WXS' and mat_cost_type != 'ZZZ' and mat_cost_type != '999') Order By OELINHST_SQL.item_desc_1", conn1)
                SqlDataAdapter.Fill(soLines)
            Catch
                MesgBox("Something went wrong retreiving the BOM.")
            End Try

        End If


        'test if any order lines have corresponding kits

        If soLines.Rows.Count > 0 Then
            Try
                For Each row As DataRow In soLines.Rows
                    Dim parent As String = row("parent_item_no").ToString
                    'MesgBox(parent)
                    SqlDataAdapter1.SelectCommand = New SqlCommand("SELECT IMKITFIL_SQL.item_no as item_no, seq_no, IMKITFIL_SQL.comp_item_no as comp_item_no, item_desc_1 as comp_item_desc, qty_per_par as qty_per_par FROM [IMKITFIL_SQL] Left Join IMITMIDX_SQL on IMKITFIL_SQL.comp_item_no = IMITMIDX_SQL.item_no WHERE IMKITFIL_SQL.item_no = '" & parent & "'  Order By seq_no", conn1)
                    SqlDataAdapter1.Fill(compKits)
                Next

            Catch
                'MesgBox(Err)
            End Try

        End If

        gvOrderLines.DataSource = soLines
        gvOrderLines.DataBind()

        Return False
    End Function

    Private Sub tbProd_TextChanged(sender As Object, e As EventArgs) Handles tbProd.TextChanged
        tbSO.Text = ""
    End Sub

    Private Sub btnLoad_Click(sender As Object, e As EventArgs) Handles btnLoad.Click
        clickLoad()
    End Sub

    Public Function getCurrentSpecsStatus(Prod As String) As String

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr

        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Select CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus FROM BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & Prod & "'"
        cmd.Connection = conn

        conn.Open()

        Dim currentstatus As String = cmd.ExecuteScalar().ToString()

        Return currentstatus
    End Function

    Public Function insertPartRecord(Prod As String, item_no As String, item_desc As String, qty As Decimal, status As Integer) As String

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim Today As Date = Date.Now
        Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)

        conn.ConnectionString = connstr
        cmd.Connection = conn

        Prod = RTrim(Prod)
        item_no = RTrim(item_no)
        item_desc = RTrim(item_desc)

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        Dim stationID = SplitBValSlash(user)

        Dim auditor As String = RTrim(stationID)

        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("prod", Prod)
        cmd.Parameters.AddWithValue("item_no", item_no)
        cmd.Parameters.AddWithValue("item_desc", item_desc)
        cmd.Parameters.AddWithValue("qty", qty)
        cmd.Parameters.AddWithValue("auditor", auditor)
        cmd.Parameters.AddWithValue("today", Today.Date)
        cmd.Parameters.AddWithValue("daytime", Today)
        cmd.Parameters.AddWithValue("status", status)


        cmd.CommandText = "Insert Into WIP_Parts (ProdNo, PartDateAudited, Auditor, PartDateTimeAudited, ItemNo, ItemDesc, Qty, PartStatus) VALUES (@prod, @today, @auditor, @daytime, @item_no, @item_desc, @qty, @status)"
        cmd.Connection = conn


        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()
        gvSelections.DataBind()

        Return False

    End Function

    Public Function deletePartRecord(Prod As String, item_no As String) As String

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim Today As Date = Date.Now
        Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)

        conn.ConnectionString = connstr
        cmd.Connection = conn

        Prod = RTrim(Prod)
        item_no = RTrim(item_no)

        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("prod", Prod)
        cmd.Parameters.AddWithValue("item_no", item_no)
        cmd.Parameters.AddWithValue("today", Today.Date)


        cmd.CommandText = "Delete From WIP_Parts Where ProdNo = @prod and ItemNo = @item_no and PartDateAudited = @today "
        cmd.Connection = conn

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()
        gvSelections.DataBind()


        Return False
    End Function
    Public Function insertBoatRecord(Prod As String) As String


        Return False

    End Function

    Public Function clickLoad() As String
        If tbSO.Text.Length > 0 Then
            Dim So As String = tbSO.Text
            So = " " + " " + So 'needs two leading spaces to match macola...
            hdnSONo.Value = So
            hdnSONoSkip2LeadingZeros.Value = Right(So, Len(So) - 2)
            Try
                getOrderLines(So)
            Catch
            End Try

        Else 'lookup so from prod to proceed
            If tbProd.Text.Length > 0 And tbProd.Text.Length = 7 Then
                hdnProdNo.Value = tbProd.Text

                Dim SOfromProd As String
                Dim conn As New SqlConnection()
                Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
                Dim cmd As New SqlCommand
                conn.ConnectionString = connstr

                cmd.CommandType = CommandType.Text
                cmd.CommandText = "Select src_ord_no from PPORDFIL_SQL where user_def_fld_1 =  '" & tbProd.Text.ToString & "'"
                cmd.Connection = conn

                conn.Open()
                SOfromProd = cmd.ExecuteScalar()
                conn.Close()

                hdnSONo.Value = SOfromProd
                tbSO.Text = SOfromProd
                hdnSONoSkip2LeadingZeros.Value = Right(SOfromProd, Len(SOfromProd) - 2)

                Try
                    getOrderLines(SOfromProd)
                Catch
                End Try

                Try
                    lblCurrentSpecsStatus.Text = getCurrentSpecsStatus(hdnProdNo.Value)
                Catch
                End Try

            Else
                MesgBox("Please double check the production # you entered.")
                'gvExplode.DataBind()
            End If


        End If

        Return False
    End Function
    Public Function getSelections(Prod As String) As DataTable

        Dim Today As Date = Date.Now
        Dim SqlDataAdapter As New SqlDataAdapter
        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1

        conn1.Open()

        SqlDataAdapter.SelectCommand = New SqlCommand("SELECT ItemNo, PartStatus FROM [WIP_Parts] WHERE ProdNo =  '" & Prod & "' And PartDateAudited = '" & Today & "'", conn1)
        'And ItemNo = '" & Part & "'
        SqlDataAdapter.Fill(selections)

        conn1.Close()

        Return selections
    End Function

    Private Sub gvOrderLines_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOrderLines.RowDataBound

        Dim sqlDataAdapter As New SqlDataAdapter
        Dim sqlDataAdapter1 As New SqlDataAdapter

        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1
        conn1.Open()

        If e.Row.RowType = DataControlRowType.Header Then
            rtrSelections = getSelections(hdnProdNo.Value)
        End If

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim item_no As String = e.Row.DataItem("parent_item_no")
            Dim gvLevel1 As GridView = DirectCast(e.Row.FindControl("gvLevel1"), GridView)

            Dim btnIncompleteLevel As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel"), ImageButton)
            Dim btnCompleteLevel As ImageButton = DirectCast(e.Row.FindControl("btnCompleteLevel"), ImageButton)
            Dim btnMissingLevel As ImageButton = DirectCast(e.Row.FindControl("btnMissingLevel"), ImageButton)
            Dim btnCollapse As ImageButton = DirectCast(e.Row.FindControl("btnCollapse"), ImageButton)



            sqlDataAdapter.SelectCommand = New SqlCommand("Select bmprdstr_sql.item_no , seq_no, comp_item_no, item_desc_1 as comp_item_desc, qty_per_par FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & item_no & "' order by seq_no", conn1)
            sqlDataAdapter.Fill(components)

            If components.Rows.Count > 0 Then
                'btnCollapse.Visible = True
                btnIncompleteLevel.Visible = True
            End If

            'test if any component lines have corresponding kits
            'Are there any parts that have kits...that contain parts that have kits themselves?
            '[1:12 PM] Ryan Erb
            'No kits within kits just options

            If components.Rows.Count > 0 Then
                Try
                    For Each row As DataRow In soLines.Rows
                        Dim parent As String = row("comp_item_no").ToString
                        'MesgBox(parent)
                        sqlDataAdapter1.SelectCommand = New SqlCommand("SELECT IMKITFIL_SQL.item_no as item_no, seq_no, IMKITFIL_SQL.comp_item_no as comp_item_no, item_desc_1 as comp_item_desc, qty_per_par as qty_per_par FROM [IMKITFIL_SQL] Left Join IMITMIDX_SQL on IMKITFIL_SQL.comp_item_no = IMITMIDX_SQL.item_no WHERE IMKITFIL_SQL.item_no = '" & parent & "'  Order By seq_no", conn1)
                        sqlDataAdapter1.Fill(comp2Kits)
                    Next

                Catch
                    'MesgBox(Err)
                End Try

            End If

            'Button color classes
            Dim itemRow = rtrSelections.Select("ItemNo = '" & Trim(item_no) & "'")

            If itemRow.Length > 0 Then

                For j = 0 To itemRow.Length - 1

                    Dim selectedItemStatus As String = itemRow(j)(1).ToString()
                    btnMissingLevel.CssClass = "white"
                    btnIncompleteLevel.CssClass = "white"
                    btnCompleteLevel.CssClass = "white"

                    If selectedItemStatus = 1 Then
                        btnMissingLevel.CssClass = "green"
                    ElseIf selectedItemStatus = 2 Then 'partial
                        btnIncompleteLevel.CssClass = "green"
                    ElseIf selectedItemStatus = 3 Then 'complete
                        btnCompleteLevel.CssClass = "green"
                    End If

                Next
            End If

            components.Merge(compKits)

            gvLevel1.DataSource = components
            gvLevel1.DataBind()

            components.Clear()

        End If

        conn1.Close()
    End Sub
    Protected Sub gvLevel1_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim sqlDataAdapter As New SqlDataAdapter
        Dim sqlDataAdapter1 As New SqlDataAdapter

        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1
        conn1.Open()

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim item_no As String = e.Row.DataItem("comp_item_no")
            Dim gvLevel2 As GridView = DirectCast(e.Row.FindControl("gvLevel2"), GridView)

            Dim btnIncompleteLevel1 As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel1"), ImageButton)
            Dim btnCompleteLevel1 As ImageButton = DirectCast(e.Row.FindControl("btnCompleteLevel1"), ImageButton)
            Dim btnMissingLevel1 As ImageButton = DirectCast(e.Row.FindControl("btnMissingLevel1"), ImageButton)
            Dim btnCollapse As ImageButton = DirectCast(e.Row.FindControl("btnCollapse1"), ImageButton)
            ' Dim btnPartial As ImageButton = DirectCast(e.Row.FindControl("btnPartial1"), ImageButton)

            sqlDataAdapter.SelectCommand = New SqlCommand("Select bmprdstr_sql.item_no , seq_no, comp_item_no, item_desc_1 as comp_item_desc, qty_per_par FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & item_no & "' order by seq_no", conn1)
            sqlDataAdapter.Fill(components2)

            If components2.Rows.Count > 0 Then
                'btnCollapse.Visible = True
                btnIncompleteLevel1.Visible = True
                'Else
                '   btnPartial.Visible = False
            End If

            'don't have to check for this at higher levels unless things change so I left the code here.
            'test if any component lines have corresponding kits

            'If components2.Rows.Count > 0 Then
            '    Try
            '        For Each row As DataRow In soLines.Rows
            '            Dim parent As String = row("comp_item_no").ToString
            '            'MesgBox(parent)
            '            sqlDataAdapter1.SelectCommand = New SqlCommand("SELECT IMKITFIL_SQL.item_no as item_no, seq_no, IMKITFIL_SQL.comp_item_no as comp_item_no, item_desc_1 as comp_item_desc, qty_per_par as qty_per_par FROM [IMKITFIL_SQL] Left Join IMITMIDX_SQL on IMKITFIL_SQL.comp_item_no = IMITMIDX_SQL.item_no WHERE IMKITFIL_SQL.item_no = '" & parent & "'  Order By seq_no", conn1)
            '            sqlDataAdapter1.Fill(comp2Kits)
            '        Next

            '    Catch
            '        'MesgBox(Err)
            '    End Try

            'End If

            'Button color classes
            Dim itemRow = rtrSelections.Select("ItemNo = '" & Trim(item_no) & "'")

            If itemRow.Length > 0 Then

                For j = 0 To itemRow.Length - 1

                    Dim selectedItemStatus As String = itemRow(j)(1).ToString()
                    btnMissingLevel1.CssClass = "white"
                    btnIncompleteLevel1.CssClass = "white"
                    btnCompleteLevel1.CssClass = "white"

                    If selectedItemStatus = 1 Then
                        btnMissingLevel1.CssClass = "green"
                    ElseIf selectedItemStatus = 2 Then 'partial
                        btnIncompleteLevel1.CssClass = "green"
                    ElseIf selectedItemStatus = 3 Then 'complete
                        btnCompleteLevel1.CssClass = "green"
                    End If

                Next
            End If

            'components2.Merge(comp2Kits)
            gvLevel2.DataSource = components2
            gvLevel2.DataBind()

            components2.Clear()
        End If

        conn1.Close()
    End Sub

    Protected Sub gvLevel2_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim sqlDataAdapter As New SqlDataAdapter
        Dim sqlDataAdapter1 As New SqlDataAdapter

        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1
        conn1.Open()

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim item_no As String = e.Row.DataItem("comp_item_no")
            Dim gvLevel3 As GridView = DirectCast(e.Row.FindControl("gvLevel3"), GridView)
            Dim btnIncompleteLevel2 As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel2"), ImageButton)
            Dim btnCompleteLevel2 As ImageButton = DirectCast(e.Row.FindControl("btnCompleteLevel2"), ImageButton)
            Dim btnMissingLevel2 As ImageButton = DirectCast(e.Row.FindControl("btnMissingLevel2"), ImageButton)

            Dim btnCollapse As ImageButton = DirectCast(e.Row.FindControl("btnCollapse2"), ImageButton)
            Dim btnPartial As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel2"), ImageButton)


            sqlDataAdapter.SelectCommand = New SqlCommand("Select bmprdstr_sql.item_no , seq_no, comp_item_no, item_desc_1 as comp_item_desc, qty_per_par FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & item_no & "' order by seq_no", conn1)
            sqlDataAdapter.Fill(components3)


            If components3.Rows.Count > 0 Then
                ' btnCollapse.Visible = True
            Else
                btnPartial.Visible = False
            End If


            'Button color classes
            Dim itemRow = rtrSelections.Select("ItemNo = '" & Trim(item_no) & "'")

            If itemRow.Length > 0 Then

                For j = 0 To itemRow.Length - 1

                    Dim selectedItemStatus As String = itemRow(j)(1).ToString()
                    btnMissingLevel2.CssClass = "white"
                    btnIncompleteLevel2.CssClass = "white"
                    btnCompleteLevel2.CssClass = "white"

                    If selectedItemStatus = 1 Then
                        btnMissingLevel2.CssClass = "green"
                    ElseIf selectedItemStatus = 2 Then 'partial
                        btnIncompleteLevel2.CssClass = "green"
                    ElseIf selectedItemStatus = 3 Then 'complete
                        btnCompleteLevel2.CssClass = "green"
                    End If

                Next
            End If


            'test if any component lines have corresponding kits

            'If components3.Rows.Count > 0 Then
            '    Try
            '        For Each row As DataRow In soLines.Rows
            '            Dim parent As String = row("comp_item_no").ToString
            '            'MesgBox(parent)
            '            sqlDataAdapter1.SelectCommand = New SqlCommand("SELECT IMKITFIL_SQL.item_no as item_no, seq_no, IMKITFIL_SQL.comp_item_no as comp_item_no, item_desc_1 as comp_item_desc, qty_per_par as qty_per_par FROM [IMKITFIL_SQL] Left Join IMITMIDX_SQL on IMKITFIL_SQL.comp_item_no = IMITMIDX_SQL.item_no WHERE IMKITFIL_SQL.item_no = '" & parent & "'  Order By seq_no", conn1)
            '            sqlDataAdapter1.Fill(comp3Kits)
            '        Next

            '    Catch
            '        'MesgBox(Err)
            '    End Try

            'End If

            'components3.Merge(comp3Kits)

            gvLevel3.DataSource = components3
            gvLevel3.DataBind()


            components3.Clear()

        End If

        conn1.Close()
    End Sub


    Protected Sub gvLevel3_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim sqlDataAdapter As New SqlDataAdapter
        Dim sqlDataAdapter1 As New SqlDataAdapter

        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1
        conn1.Open()

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim item_no As String = e.Row.DataItem("comp_item_no")
            Dim gvLevel4 As GridView = DirectCast(e.Row.FindControl("gvLevel4"), GridView)

            Dim btnIncompleteLevel3 As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel3"), ImageButton)
            Dim btnCompleteLevel3 As ImageButton = DirectCast(e.Row.FindControl("btnCompleteLevel3"), ImageButton)
            Dim btnMissingLevel3 As ImageButton = DirectCast(e.Row.FindControl("btnMissingLevel3"), ImageButton)
            Dim btnCollapse As ImageButton = DirectCast(e.Row.FindControl("btnCollapse3"), ImageButton)
            Dim btnPartial As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel3"), ImageButton)

            sqlDataAdapter.SelectCommand = New SqlCommand("Select bmprdstr_sql.item_no , seq_no, comp_item_no, item_desc_1 as comp_item_desc, qty_per_par FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & item_no & "' order by seq_no", conn1)
            sqlDataAdapter.Fill(components4)


            If components4.Rows.Count > 0 Then
                ' btnCollapse.Visible = True
            Else
                btnPartial.Visible = False
            End If

            'test if any component lines have corresponding kits

            'If components4.Rows.Count > 0 Then
            '    Try
            '        For Each row As DataRow In soLines.Rows
            '            Dim parent As String = row("comp_item_no").ToString
            '            'MesgBox(parent)
            '            sqlDataAdapter1.SelectCommand = New SqlCommand("SELECT IMKITFIL_SQL.item_no as item_no, seq_no, IMKITFIL_SQL.comp_item_no as comp_item_no, item_desc_1 as comp_item_desc, qty_per_par as qty_per_par FROM [IMKITFIL_SQL] Left Join IMITMIDX_SQL on IMKITFIL_SQL.comp_item_no = IMITMIDX_SQL.item_no WHERE IMKITFIL_SQL.item_no = '" & parent & "'  Order By seq_no", conn1)
            '            sqlDataAdapter1.Fill(comp4Kits)
            '        Next

            '    Catch
            '        'MesgBox(Err)
            '    End Try

            'End If

            'components4.Merge(comp4Kits)


            'Button color classes
            Dim itemRow = rtrSelections.Select("ItemNo = '" & Trim(item_no) & "'")

            If itemRow.Length > 0 Then

                For j = 0 To itemRow.Length - 1

                    Dim selectedItemStatus As String = itemRow(j)(1).ToString()
                    btnMissingLevel3.CssClass = "white"
                    btnIncompleteLevel3.CssClass = "white"
                    btnCompleteLevel3.CssClass = "white"

                    If selectedItemStatus = 1 Then
                        btnMissingLevel3.CssClass = "green"
                    ElseIf selectedItemStatus = 2 Then 'partial
                        btnIncompleteLevel3.CssClass = "green"
                    ElseIf selectedItemStatus = 3 Then 'complete
                        btnCompleteLevel3.CssClass = "green"
                    End If

                Next
            End If

            gvLevel4.DataSource = components4
            gvLevel4.DataBind()

            components4.Clear()

        End If

        conn1.Close()
    End Sub

    Protected Sub gvLevel4_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim sqlDataAdapter As New SqlDataAdapter
        Dim sqlDataAdapter1 As New SqlDataAdapter

        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1
        conn1.Open()

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim item_no As String = e.Row.DataItem("comp_item_no")
            Dim gvLevel5 As GridView = DirectCast(e.Row.FindControl("gvLevel5"), GridView)
            Dim btnIncompleteLevel4 As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel4"), ImageButton)
            Dim btnCompleteLevel4 As ImageButton = DirectCast(e.Row.FindControl("btnCompleteLevel4"), ImageButton)
            Dim btnMissingLevel4 As ImageButton = DirectCast(e.Row.FindControl("btnMissingLevel4"), ImageButton)
            Dim btnCollapse As ImageButton = DirectCast(e.Row.FindControl("btnCollapse4"), ImageButton)
            Dim btnPartial As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel4"), ImageButton)


            sqlDataAdapter.SelectCommand = New SqlCommand("Select bmprdstr_sql.item_no , seq_no, comp_item_no, item_desc_1 as comp_item_desc, qty_per_par FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & item_no & "' order by seq_no", conn1)
            sqlDataAdapter.Fill(components5)

            If components5.Rows.Count > 0 Then
                '   btnCollapse.Visible = True
            Else
                btnPartial.Visible = False
            End If


            'test if any component lines have corresponding kits

            'If components5.Rows.Count > 0 Then
            '    Try
            '        For Each row As DataRow In soLines.Rows
            '            Dim parent As String = row("comp_item_no").ToString
            '            'MesgBox(parent)
            '            sqlDataAdapter1.SelectCommand = New SqlCommand("SELECT IMKITFIL_SQL.item_no as item_no, seq_no, IMKITFIL_SQL.comp_item_no as comp_item_no, item_desc_1 as comp_item_desc, qty_per_par as qty_per_par FROM [IMKITFIL_SQL] Left Join IMITMIDX_SQL on IMKITFIL_SQL.comp_item_no = IMITMIDX_SQL.item_no WHERE IMKITFIL_SQL.item_no = '" & parent & "'  Order By seq_no", conn1)
            '            sqlDataAdapter1.Fill(comp5Kits)
            '        Next

            '    Catch
            '        'MesgBox(Err)
            '    End Try

            'End If

            'components5.Merge(comp5Kits)


            'Button color classes
            Dim itemRow = rtrSelections.Select("ItemNo = '" & Trim(item_no) & "'")

            If itemRow.Length > 0 Then

                For j = 0 To itemRow.Length - 1

                    Dim selectedItemStatus As String = itemRow(j)(1).ToString()
                    btnMissingLevel4.CssClass = "white"
                    btnIncompleteLevel4.CssClass = "white"
                    btnCompleteLevel4.CssClass = "white"

                    If selectedItemStatus = 1 Then
                        btnMissingLevel4.CssClass = "green"
                    ElseIf selectedItemStatus = 2 Then 'partial
                        btnIncompleteLevel4.CssClass = "green"
                    ElseIf selectedItemStatus = 3 Then 'complete
                        btnCompleteLevel4.CssClass = "green"
                    End If

                Next
            End If

            gvLevel5.DataSource = components5
            gvLevel5.DataBind()
            components5.Clear()

        End If

        conn1.Close()
    End Sub


    Protected Sub gvLevel5_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim sqlDataAdapter As New SqlDataAdapter
        Dim sqlDataAdapter1 As New SqlDataAdapter

        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1
        conn1.Open()

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim item_no As String = e.Row.DataItem("comp_item_no")
            Dim gvLevel6 As GridView = DirectCast(e.Row.FindControl("gvLevel6"), GridView)

            Dim btnIncompleteLevel5 As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel5"), ImageButton)
            Dim btnCompleteLevel5 As ImageButton = DirectCast(e.Row.FindControl("btnCompleteLevel5"), ImageButton)
            Dim btnMissingLevel5 As ImageButton = DirectCast(e.Row.FindControl("btnMissingLevel5"), ImageButton)

            Dim btnCollapse As ImageButton = DirectCast(e.Row.FindControl("btnCollapse5"), ImageButton)
            Dim btnPartial As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel5"), ImageButton)

            sqlDataAdapter.SelectCommand = New SqlCommand("Select bmprdstr_sql.item_no , seq_no, comp_item_no, item_desc_1 as comp_item_desc, qty_per_par FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & item_no & "' order by seq_no", conn1)
            sqlDataAdapter.Fill(components6)


            If components6.Rows.Count > 0 Then
                '    btnCollapse.Visible = True
            Else
                btnPartial.Visible = False
            End If


            'test if any component lines have corresponding kits

            'If components6.Rows.Count > 0 Then
            '    Try
            '        For Each row As DataRow In soLines.Rows
            '            Dim parent As String = row("comp_item_no").ToString
            '            'MesgBox(parent)
            '            sqlDataAdapter1.SelectCommand = New SqlCommand("SELECT IMKITFIL_SQL.item_no as item_no, seq_no, IMKITFIL_SQL.comp_item_no as comp_item_no, item_desc_1 as comp_item_desc, qty_per_par as qty_per_par FROM [IMKITFIL_SQL] Left Join IMITMIDX_SQL on IMKITFIL_SQL.comp_item_no = IMITMIDX_SQL.item_no WHERE IMKITFIL_SQL.item_no = '" & parent & "'  Order By seq_no", conn1)
            '            sqlDataAdapter1.Fill(comp6Kits)
            '        Next

            '    Catch
            '        'MesgBox(Err)
            '    End Try

            'End If

            'components6.Merge(comp6Kits)


            'Button color classes
            Dim itemRow = rtrSelections.Select("ItemNo = '" & Trim(item_no) & "'")

            If itemRow.Length > 0 Then

                For j = 0 To itemRow.Length - 1

                    Dim selectedItemStatus As String = itemRow(j)(1).ToString()
                    btnMissingLevel5.CssClass = "white"
                    btnIncompleteLevel5.CssClass = "white"
                    btnCompleteLevel5.CssClass = "white"

                    If selectedItemStatus = 1 Then
                        btnMissingLevel5.CssClass = "green"
                    ElseIf selectedItemStatus = 2 Then 'partial
                        btnIncompleteLevel5.CssClass = "green"
                    ElseIf selectedItemStatus = 3 Then 'complete
                        btnCompleteLevel5.CssClass = "green"
                    End If

                Next
            End If

            gvLevel6.DataSource = components6
            gvLevel6.DataBind()
            components6.Clear()

        End If

        conn1.Close()
    End Sub


    Protected Sub gvLevel6_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim sqlDataAdapter As New SqlDataAdapter
        Dim sqlDataAdapter1 As New SqlDataAdapter
        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1
        conn1.Open()

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim item_no As String = e.Row.DataItem("comp_item_no")
            Dim gvLevel7 As GridView = DirectCast(e.Row.FindControl("gvLevel7"), GridView)

            Dim btnIncompleteLevel6 As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel6"), ImageButton)
            Dim btnCompleteLevel6 As ImageButton = DirectCast(e.Row.FindControl("btnCompleteLevel6"), ImageButton)
            Dim btnMissingLevel6 As ImageButton = DirectCast(e.Row.FindControl("btnMissingLevel6"), ImageButton)
            Dim btnPartial As ImageButton = DirectCast(e.Row.FindControl("btnIncompleteLevel6"), ImageButton)

            sqlDataAdapter.SelectCommand = New SqlCommand("Select bmprdstr_sql.item_no , seq_no, comp_item_no, item_desc_1 as comp_item_desc, qty_per_par FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & item_no & "' order by seq_no", conn1)
            sqlDataAdapter.Fill(components7)

            gvLevel7.DataSource = components7
            gvLevel7.DataBind()

            If components7.Rows.Count > 0 Then

            Else
                btnPartial.Visible = False
            End If


            'test if any component lines have corresponding kits

            'If components7.Rows.Count > 0 Then
            '    Try
            '        For Each row As DataRow In soLines.Rows
            '            Dim parent As String = row("comp_item_no").ToString
            '            'MesgBox(parent)
            '            sqlDataAdapter1.SelectCommand = New SqlCommand("SELECT IMKITFIL_SQL.item_no as item_no, seq_no, IMKITFIL_SQL.comp_item_no as comp_item_no, item_desc_1 as comp_item_desc, qty_per_par as qty_per_par FROM [IMKITFIL_SQL] Left Join IMITMIDX_SQL on IMKITFIL_SQL.comp_item_no = IMITMIDX_SQL.item_no WHERE IMKITFIL_SQL.item_no = '" & parent & "'  Order By seq_no", conn1)
            '            sqlDataAdapter1.Fill(comp7Kits)
            '        Next

            '    Catch
            '        'MesgBox(Err)
            '    End Try

            'End If

            'components7.Merge(comp7Kits)


            'Button color classes
            Dim itemRow = rtrSelections.Select("ItemNo = '" & Trim(item_no) & "'")

            If itemRow.Length > 0 Then

                For j = 0 To itemRow.Length - 1

                    Dim selectedItemStatus As String = itemRow(j)(1).ToString()
                    btnMissingLevel6.CssClass = "white"
                    btnIncompleteLevel6.CssClass = "white"
                    btnCompleteLevel6.CssClass = "white"

                    If selectedItemStatus = 1 Then
                        btnMissingLevel6.CssClass = "green"
                    ElseIf selectedItemStatus = 2 Then 'partial
                        btnIncompleteLevel6.CssClass = "green"
                    ElseIf selectedItemStatus = 3 Then 'complete
                        btnCompleteLevel6.CssClass = "green"
                    End If

                Next
            End If

            components7.Clear()

        End If

        conn1.Close()
    End Sub

    Protected Sub gvLevel1_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        If e.CommandName = "Partial1" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvComponents As GridView = DirectCast(sender.Rows(Key).FindControl("gvComponents"), GridView)
            Dim btnCollapse1 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse1"), ImageButton)
            Dim btnMarkChildrenComplete1 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete1"), Button)
            Dim btnMissingLevel1 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel1"), ImageButton)
            Dim btnCompleteLevel1 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel1"), ImageButton)
            Dim btnIncompleteLevel1 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel1"), ImageButton)
            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 2

            Dim gvLevel2 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel2"), GridView)
            gvLevel2.Visible = True
            btnCollapse1.Visible = True
            btnMarkChildrenComplete1.Visible = True

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno1"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc1"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty1"), Label).Text

            btnCompleteLevel1.CssClass = "white"
            btnIncompleteLevel1.CssClass = "green"
            btnMissingLevel1.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)
            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If


        If e.CommandName = "Missing1" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel1 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel1"), ImageButton)
            Dim btnCompleteLevel1 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel1"), ImageButton)
            Dim btnIncompleteLevel1 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel1"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno1"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc1"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty1"), Label).Text

            qty = qty * -1

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 1
            btnMissingLevel1.CssClass = "green"
            btnCompleteLevel1.CssClass = "white"
            btnIncompleteLevel1.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If

        If e.CommandName = "Complete1" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel1 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel1"), ImageButton)
            Dim btnCompleteLevel1 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel1"), ImageButton)
            Dim btnIncompleteLevel1 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel1"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno1"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc1"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty1"), Label).Text

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 3
            btnMissingLevel1.CssClass = "white"
            btnCompleteLevel1.CssClass = "green"
            btnIncompleteLevel1.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()
        End If

        If e.CommandName = "collapse1" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel2 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel2"), GridView)
            Dim btnCollapse1 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse1"), ImageButton)
            Dim btnMarkChildrenComplete1 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete1"), Button)

            gvLevel2.Visible = False
            btnCollapse1.Visible = False
            btnMarkChildrenComplete1.Visible = False
        End If

        If e.CommandName = "CompleteChildren1" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel2 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel2"), GridView)

            For Each row As GridViewRow In gvLevel2.Rows
                'Dim str As String = TryCast(row.FindControl

                Dim btnMissingLevel As ImageButton = DirectCast(row.FindControl("btnMissingLevel2"), ImageButton)
                Dim btnCompleteLevel As ImageButton = DirectCast(row.FindControl("btnCompleteLevel2"), ImageButton)
                Dim btnIncompleteLevel As ImageButton = DirectCast(row.FindControl("btnIncompleteLevel2"), ImageButton)


                Dim item_no As String = TryCast(row.FindControl("lblitemno2"), Label).Text
                Dim item_desc As String = TryCast(row.FindControl("lblitemdesc2"), Label).Text
                Dim qty As Decimal = TryCast(row.FindControl("lblqty2"), Label).Text

                Dim prodNo As String = tbProd.Text
                Dim status As Integer = 3

                deletePartRecord(prodNo, item_no)
                insertPartRecord(prodNo, item_no, item_desc, qty, status)

                btnMissingLevel.CssClass = "white"
                btnCompleteLevel.CssClass = "green"
                btnIncompleteLevel.CssClass = "white"
            Next

        End If


    End Sub

    Protected Sub gvLevel2_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        If e.CommandName = "Partial2" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvComponents As GridView = DirectCast(sender.Rows(Key).FindControl("gvComponents"), GridView)
            Dim btnCollapse2 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse2"), ImageButton)
            Dim btnMissingLevel2 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel2"), ImageButton)
            Dim btnMarkChildrenComplete2 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete2"), Button)
            Dim btnCompleteLevel2 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel2"), ImageButton)
            Dim btnIncompleteLevel2 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel2"), ImageButton)
            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 2

            Dim gvLevel3 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel3"), GridView)
            gvLevel3.Visible = True
            btnCollapse2.Visible = True
            btnMarkChildrenComplete2.Visible = True

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno2"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc2"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty2"), Label).Text

            btnCompleteLevel2.CssClass = "white"
            btnIncompleteLevel2.CssClass = "green"
            btnMissingLevel2.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)
            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If


        If e.CommandName = "Missing2" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel2 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel2"), ImageButton)
            Dim btnCompleteLevel2 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel2"), ImageButton)
            Dim btnIncompleteLevel2 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel2"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno2"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc2"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty2"), Label).Text

            qty = qty * -1

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 1
            btnMissingLevel2.CssClass = "green"
            btnCompleteLevel2.CssClass = "white"
            btnIncompleteLevel2.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If

        If e.CommandName = "Complete2" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel2 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel2"), ImageButton)
            Dim btnCompleteLevel2 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel2"), ImageButton)
            Dim btnIncompleteLevel2 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel2"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno2"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc2"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty2"), Label).Text

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 3
            btnMissingLevel2.CssClass = "white"
            btnCompleteLevel2.CssClass = "green"
            btnIncompleteLevel2.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()
        End If

        If e.CommandName = "collapse2" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel3 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel3"), GridView)
            Dim btnCollapse2 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse2"), ImageButton)
            gvLevel3.Visible = False
            btnCollapse2.Visible = False
        End If

        If e.CommandName = "CompleteChildren2" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel3 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel3"), GridView)

            For Each row As GridViewRow In gvLevel3.Rows
                'Dim str As String = TryCast(row.FindControl

                Dim btnMissingLevel As ImageButton = DirectCast(row.FindControl("btnMissingLevel3"), ImageButton)
                Dim btnCompleteLevel As ImageButton = DirectCast(row.FindControl("btnCompleteLevel3"), ImageButton)
                Dim btnIncompleteLevel As ImageButton = DirectCast(row.FindControl("btnIncompleteLevel3"), ImageButton)


                Dim item_no As String = TryCast(row.FindControl("lblitemno3"), Label).Text
                Dim item_desc As String = TryCast(row.FindControl("lblitemdesc3"), Label).Text
                Dim qty As Decimal = TryCast(row.FindControl("lblqty3"), Label).Text

                Dim prodNo As String = tbProd.Text
                Dim status As Integer = 3

                deletePartRecord(prodNo, item_no)
                insertPartRecord(prodNo, item_no, item_desc, qty, status)

                btnMissingLevel.CssClass = "white"
                btnCompleteLevel.CssClass = "green"
                btnIncompleteLevel.CssClass = "white"
            Next

        End If
    End Sub

    Protected Sub gvLevel3_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        If e.CommandName = "Partial3" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvComponents As GridView = DirectCast(sender.Rows(Key).FindControl("gvComponents"), GridView)
            Dim btnCollapse3 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse3"), ImageButton)
            Dim btnMarkChildrenComplete3 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete3"), Button)
            Dim btnMissingLevel3 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel3"), ImageButton)
            Dim btnCompleteLevel3 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel3"), ImageButton)
            Dim btnIncompleteLevel3 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel3"), ImageButton)
            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 2

            Dim gvLevel4 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel4"), GridView)
            gvLevel4.Visible = True
            btnCollapse3.Visible = True
            btnMarkChildrenComplete3.Visible = True

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno3"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc3"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty3"), Label).Text

            btnCompleteLevel3.CssClass = "white"
            btnIncompleteLevel3.CssClass = "green"
            btnMissingLevel3.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)
            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If


        If e.CommandName = "Missing3" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel3 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel3"), ImageButton)
            Dim btnCompleteLevel3 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel3"), ImageButton)
            Dim btnIncompleteLevel3 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel3"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno3"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc3"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty3"), Label).Text

            qty = qty * -1

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 1
            btnMissingLevel3.CssClass = "green"
            btnCompleteLevel3.CssClass = "white"
            btnIncompleteLevel3.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If

        If e.CommandName = "Complete3" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel3 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel3"), ImageButton)
            Dim btnCompleteLevel3 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel3"), ImageButton)
            Dim btnIncompleteLevel3 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel3"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno3"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc3"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty3"), Label).Text

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 3
            btnMissingLevel3.CssClass = "white"
            btnCompleteLevel3.CssClass = "green"
            btnIncompleteLevel3.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()
        End If

        If e.CommandName = "collapse3" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel4 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel4"), GridView)
            Dim btnCollapse3 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse3"), ImageButton)
            Dim btnMarkChildrenComplete3 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete3"), Button)
            gvLevel4.Visible = False
            btnCollapse3.Visible = False
            btnMarkChildrenComplete3.Visible = False
        End If


        If e.CommandName = "CompleteChildren3" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel4 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel4"), GridView)

            For Each row As GridViewRow In gvLevel4.Rows
                'Dim str As String = TryCast(row.FindControl

                Dim btnMissingLevel As ImageButton = DirectCast(row.FindControl("btnMissingLevel4"), ImageButton)
                Dim btnCompleteLevel As ImageButton = DirectCast(row.FindControl("btnCompleteLevel4"), ImageButton)
                Dim btnIncompleteLevel As ImageButton = DirectCast(row.FindControl("btnIncompleteLevel4"), ImageButton)


                Dim item_no As String = TryCast(row.FindControl("lblitemno4"), Label).Text
                Dim item_desc As String = TryCast(row.FindControl("lblitemdesc4"), Label).Text
                Dim qty As Decimal = TryCast(row.FindControl("lblqty4"), Label).Text

                Dim prodNo As String = tbProd.Text
                Dim status As Integer = 3

                deletePartRecord(prodNo, item_no)
                insertPartRecord(prodNo, item_no, item_desc, qty, status)

                btnMissingLevel.CssClass = "white"
                btnCompleteLevel.CssClass = "green"
                btnIncompleteLevel.CssClass = "white"
            Next

        End If

    End Sub

    Protected Sub gvLevel4_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        If e.CommandName = "Partial4" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvComponents As GridView = DirectCast(sender.Rows(Key).FindControl("gvComponents"), GridView)
            Dim btnCollapse4 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse4"), ImageButton)
            Dim btnMarkChildrenComplete4 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete4"), Button)
            Dim btnMissingLevel4 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel4"), ImageButton)
            Dim btnCompleteLevel4 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel4"), ImageButton)
            Dim btnIncompleteLevel4 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel4"), ImageButton)
            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 2

            Dim gvLevel5 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel5"), GridView)
            gvLevel5.Visible = True
            btnCollapse4.Visible = True
            btnMarkChildrenComplete4.Visible = True

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno4"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc4"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty4"), Label).Text

            btnCompleteLevel4.CssClass = "white"
            btnIncompleteLevel4.CssClass = "green"
            btnMissingLevel4.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)
            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If


        If e.CommandName = "Missing4" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel4 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel4"), ImageButton)
            Dim btnCompleteLevel4 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel4"), ImageButton)
            Dim btnIncompleteLevel4 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel4"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno4"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc4"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty4"), Label).Text

            qty = qty * -1

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 1
            btnMissingLevel4.CssClass = "green"
            btnCompleteLevel4.CssClass = "white"
            btnIncompleteLevel4.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If

        If e.CommandName = "Complete4" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel4 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel4"), ImageButton)
            Dim btnCompleteLevel4 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel4"), ImageButton)
            Dim btnIncompleteLevel4 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel4"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno4"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc4"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty4"), Label).Text

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 3
            btnMissingLevel4.CssClass = "white"
            btnCompleteLevel4.CssClass = "green"
            btnIncompleteLevel4.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()
        End If

        If e.CommandName = "collapse4" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel5 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel5"), GridView)
            Dim btnCollapse4 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse4"), ImageButton)
            Dim btnMarkChildrenComplete4 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete4"), Button)
            gvLevel5.Visible = False
            btnCollapse4.Visible = False
            btnMarkChildrenComplete4.Visible = False
        End If

        If e.CommandName = "CompleteChildren4" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel5 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel5"), GridView)

            For Each row As GridViewRow In gvLevel5.Rows
                'Dim str As String = TryCast(row.FindControl

                Dim btnMissingLevel As ImageButton = DirectCast(row.FindControl("btnMissingLevel5"), ImageButton)
                Dim btnCompleteLevel As ImageButton = DirectCast(row.FindControl("btnCompleteLevel5"), ImageButton)
                Dim btnIncompleteLevel As ImageButton = DirectCast(row.FindControl("btnIncompleteLevel5"), ImageButton)


                Dim item_no As String = TryCast(row.FindControl("lblitemno5"), Label).Text
                Dim item_desc As String = TryCast(row.FindControl("lblitemdesc5"), Label).Text
                Dim qty As Decimal = TryCast(row.FindControl("lblqty5"), Label).Text

                Dim prodNo As String = tbProd.Text
                Dim status As Integer = 3

                deletePartRecord(prodNo, item_no)
                insertPartRecord(prodNo, item_no, item_desc, qty, status)

                btnMissingLevel.CssClass = "white"
                btnCompleteLevel.CssClass = "green"
                btnIncompleteLevel.CssClass = "white"
            Next

        End If

    End Sub

    Protected Sub gvLevel5_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        If e.CommandName = "Partial5" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvComponents As GridView = DirectCast(sender.Rows(Key).FindControl("gvComponents"), GridView)
            Dim btnCollapse5 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse5"), ImageButton)
            Dim btnMarkChildrenComplete5 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete5"), Button)
            Dim btnMissingLevel5 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel5"), ImageButton)
            Dim btnCompleteLevel5 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel5"), ImageButton)
            Dim btnIncompleteLevel5 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel5"), ImageButton)
            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 2

            Dim gvLevel6 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel6"), GridView)
            gvLevel6.Visible = True
            btnCollapse5.Visible = True
            btnMarkChildrenComplete5.Visible = True

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno5"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc5"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty5"), Label).Text

            btnCompleteLevel5.CssClass = "white"
            btnIncompleteLevel5.CssClass = "green"
            btnMissingLevel5.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)
            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If


        If e.CommandName = "Missing5" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel5 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel5"), ImageButton)
            Dim btnCompleteLevel5 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel5"), ImageButton)
            Dim btnIncompleteLevel5 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel5"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno5"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc5"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty5"), Label).Text

            qty = qty * -1

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 1
            btnMissingLevel5.CssClass = "green"
            btnCompleteLevel5.CssClass = "white"
            btnIncompleteLevel5.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If

        If e.CommandName = "Complete5" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel5 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel5"), ImageButton)
            Dim btnCompleteLevel5 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel5"), ImageButton)
            Dim btnIncompleteLevel5 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel5"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno5"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc5"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty5"), Label).Text

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 3
            btnMissingLevel5.CssClass = "white"
            btnCompleteLevel5.CssClass = "green"
            btnIncompleteLevel5.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()
        End If

        If e.CommandName = "collapse5" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel6 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel6"), GridView)
            Dim btnCollapse5 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse5"), ImageButton)
            Dim btnMarkChildrenComplete5 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete5"), Button)
            gvLevel6.Visible = False
            btnCollapse5.Visible = False
            btnMarkChildrenComplete5.Visible = False
        End If

        If e.CommandName = "CompleteChildren5" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel6 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel6"), GridView)

            For Each row As GridViewRow In gvLevel6.Rows
                'Dim str As String = TryCast(row.FindControl

                Dim btnMissingLevel As ImageButton = DirectCast(row.FindControl("btnMissingLevel6"), ImageButton)
                Dim btnCompleteLevel As ImageButton = DirectCast(row.FindControl("btnCompleteLevel6"), ImageButton)
                Dim btnIncompleteLevel As ImageButton = DirectCast(row.FindControl("btnIncompleteLevel6"), ImageButton)


                Dim item_no As String = TryCast(row.FindControl("lblitemno6"), Label).Text
                Dim item_desc As String = TryCast(row.FindControl("lblitemdesc6"), Label).Text
                Dim qty As Decimal = TryCast(row.FindControl("lblqty6"), Label).Text

                Dim prodNo As String = tbProd.Text
                Dim status As Integer = 3

                deletePartRecord(prodNo, item_no)
                insertPartRecord(prodNo, item_no, item_desc, qty, status)

                btnMissingLevel.CssClass = "white"
                btnCompleteLevel.CssClass = "green"
                btnIncompleteLevel.CssClass = "white"
            Next

        End If

    End Sub

    Protected Sub gvLevel6_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        If e.CommandName = "Partial6" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvComponents As GridView = DirectCast(sender.Rows(Key).FindControl("gvComponents"), GridView)
            Dim btnCollapse6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse6"), ImageButton)
            Dim btnMarkChildrenComplete6 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete6"), Button)
            Dim btnMissingLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel6"), ImageButton)
            Dim btnCompleteLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel6"), ImageButton)
            Dim btnIncompleteLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel6"), ImageButton)
            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 2

            Dim gvLevel7 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel7"), GridView)
            gvLevel7.Visible = True
            btnCollapse6.Visible = True
            btnMarkChildrenComplete6.Visible = True

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno6"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc6"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty6"), Label).Text

            btnCompleteLevel6.CssClass = "white"
            btnIncompleteLevel6.CssClass = "green"
            btnMissingLevel6.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)
            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If


        If e.CommandName = "Missing6" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel6"), ImageButton)
            Dim btnCompleteLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel6"), ImageButton)
            Dim btnIncompleteLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel6"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno6"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc6"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty6"), Label).Text

            qty = qty * -1

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 1
            btnMissingLevel6.CssClass = "green"
            btnCompleteLevel6.CssClass = "white"
            btnIncompleteLevel6.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If

        If e.CommandName = "Complete6" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel6"), ImageButton)
            Dim btnCompleteLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel6"), ImageButton)
            Dim btnIncompleteLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel6"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno6"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc6"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty6"), Label).Text

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 3
            btnMissingLevel6.CssClass = "white"
            btnCompleteLevel6.CssClass = "green"
            btnIncompleteLevel6.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()
        End If

        If e.CommandName = "collapse6" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel7 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel7"), GridView)
            Dim btnCollapse6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse6"), ImageButton)
            Dim btnMarkChildrenComplete7 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete7"), Button)
            gvLevel7.Visible = False
            btnCollapse6.Visible = False
            btnMarkChildrenComplete7.Visible = False
        End If

        If e.CommandName = "CompleteChildren6" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel7 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel7"), GridView)

            For Each row As GridViewRow In gvLevel7.Rows
                'Dim str As String = TryCast(row.FindControl

                Dim btnMissingLevel As ImageButton = DirectCast(row.FindControl("btnMissingLevel7"), ImageButton)
                Dim btnCompleteLevel As ImageButton = DirectCast(row.FindControl("btnCompleteLevel7"), ImageButton)
                Dim btnIncompleteLevel As ImageButton = DirectCast(row.FindControl("btnIncompleteLevel7"), ImageButton)


                Dim item_no As String = TryCast(row.FindControl("lblitemno7"), Label).Text
                Dim item_desc As String = TryCast(row.FindControl("lblitemdesc7"), Label).Text
                Dim qty As Decimal = TryCast(row.FindControl("lblqty7"), Label).Text

                Dim prodNo As String = tbProd.Text
                Dim status As Integer = 3

                deletePartRecord(prodNo, item_no)
                insertPartRecord(prodNo, item_no, item_desc, qty, status)

                btnMissingLevel.CssClass = "white"
                btnCompleteLevel.CssClass = "green"
                btnIncompleteLevel.CssClass = "white"
            Next

        End If

    End Sub

    Protected Sub gvLevel7_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        If e.CommandName = "Partial7" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvComponents As GridView = DirectCast(sender.Rows(Key).FindControl("gvComponents"), GridView)
            Dim btnCollapse7 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse7"), ImageButton)
            Dim btnMarkChildrenComplete7 As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete7"), Button)
            Dim btnMissingLevel7 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel7"), ImageButton)
            Dim btnCompleteLevel7 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel7"), ImageButton)
            Dim btnIncompleteLevel7 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel7"), ImageButton)
            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 2

            Dim gvLevel7 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel7"), GridView)
            gvLevel7.Visible = True
            btnCollapse7.Visible = True
            btnMarkChildrenComplete7.Visible = True

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno7"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc7"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty7"), Label).Text

            btnCompleteLevel7.CssClass = "white"
            btnIncompleteLevel7.CssClass = "green"
            btnMissingLevel7.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)
            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If


        If e.CommandName = "Missing7" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel6"), ImageButton)
            Dim btnCompleteLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel6"), ImageButton)
            Dim btnIncompleteLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel6"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno6"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc6"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty6"), Label).Text

            qty = qty * -1

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 1
            btnMissingLevel6.CssClass = "green"
            btnCompleteLevel6.CssClass = "white"
            btnIncompleteLevel6.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If

        If e.CommandName = "Complete7" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel6"), ImageButton)
            Dim btnCompleteLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel6"), ImageButton)
            Dim btnIncompleteLevel6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel6"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno6"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc6"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty6"), Label).Text

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 3
            btnMissingLevel6.CssClass = "white"
            btnCompleteLevel6.CssClass = "green"
            btnIncompleteLevel6.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()
        End If

        If e.CommandName = "collapse7" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel7 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel7"), GridView)
            Dim btnCollapse6 As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse7"), ImageButton)
            gvLevel7.Visible = False
            btnCollapse6.Visible = False
        End If

    End Sub

    Private Sub gvOrderLines_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvOrderLines.RowCommand
        If e.CommandName = "Partial" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvComponents As GridView = DirectCast(sender.Rows(Key).FindControl("gvComponents"), GridView)
            Dim btnCollapse As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse"), ImageButton)
            Dim btnMarkChildrenComplete As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete"), Button)
            Dim btnMissingLevel As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel"), ImageButton)
            Dim btnCompleteLevel As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel"), ImageButton)
            Dim btnIncompleteLevel As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel"), ImageButton)
            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 2

            Dim gvLevel1 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel1"), GridView)
            gvLevel1.Visible = True
            btnCollapse.Visible = True
            btnMarkChildrenComplete.Visible = True

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty"), Label).Text

            btnCompleteLevel.CssClass = "white"
            btnIncompleteLevel.CssClass = "green"
            btnMissingLevel.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)
            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If


        If e.CommandName = "Missing" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel"), ImageButton)
            Dim btnCompleteLevel As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel"), ImageButton)
            Dim btnIncompleteLevel As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty"), Label).Text

            qty = qty * -1

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 1
            btnMissingLevel.CssClass = "green"
            btnCompleteLevel.CssClass = "white"
            btnIncompleteLevel.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()

        End If

        If e.CommandName = "Complete" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim btnMissingLevel As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnMissingLevel"), ImageButton)
            Dim btnCompleteLevel As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCompleteLevel"), ImageButton)
            Dim btnIncompleteLevel As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnIncompleteLevel"), ImageButton)

            Dim item_no As String = CType(sender.Rows(Key).FindControl("lblitemno"), Label).Text.ToString
            Dim item_desc As String = CType(sender.Rows(Key).FindControl("lblitemdesc"), Label).Text.ToString
            Dim qty As Decimal = CType(sender.Rows(Key).FindControl("lblqty"), Label).Text

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 3
            btnMissingLevel.CssClass = "white"
            btnCompleteLevel.CssClass = "green"
            btnIncompleteLevel.CssClass = "white"

            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)
            gvSelections.DataBind()
        End If

        If e.CommandName = "collapse" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel1 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel1"), GridView)
            Dim btnCollapse As ImageButton = DirectCast(sender.Rows(Key).FindControl("btnCollapse"), ImageButton)
            Dim btnMarkChildrenComplete As Button = DirectCast(sender.Rows(Key).FindControl("btnMarkChildrenComplete"), Button)

            gvLevel1.Visible = False
            btnCollapse.Visible = False
            btnMarkChildrenComplete.Visible = False
        End If

        If e.CommandName = "CompleteChildren" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim gvLevel1 As GridView = DirectCast(sender.rows(Key).FindControl("gvLevel1"), GridView)

            For Each row As GridViewRow In gvLevel1.Rows
                'Dim str As String = TryCast(row.FindControl

                Dim btnMissingLevel As ImageButton = DirectCast(row.FindControl("btnMissingLevel1"), ImageButton)
                Dim btnCompleteLevel As ImageButton = DirectCast(row.FindControl("btnCompleteLevel1"), ImageButton)
                Dim btnIncompleteLevel As ImageButton = DirectCast(row.FindControl("btnIncompleteLevel1"), ImageButton)


                Dim item_no As String = TryCast(row.FindControl("lblitemno1"), Label).Text
                Dim item_desc As String = TryCast(row.FindControl("lblitemdesc1"), Label).Text
                Dim qty As Decimal = TryCast(row.FindControl("lblqty1"), Label).Text

                Dim prodNo As String = tbProd.Text
                Dim status As Integer = 3

                deletePartRecord(prodNo, item_no)
                insertPartRecord(prodNo, item_no, item_desc, qty, status)

                Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)

                btnMissingLevel.CssClass = "white"
                btnCompleteLevel.CssClass = "green"
                btnIncompleteLevel.CssClass = "white"
            Next

        End If

    End Sub
    Private Sub gvSelections_RowDeleted(sender As Object, e As GridViewDeletedEventArgs) Handles gvSelections.RowDeleted
        gvOrderLines.DataBind()
        tbSO.Text = ""
        clickLoad()

    End Sub

    Private Sub gvSelections_RowUpdated(sender As Object, e As GridViewUpdatedEventArgs) Handles gvSelections.RowUpdated
        gvOrderLines.DataBind()
        tbSO.Text = ""
        clickLoad()
    End Sub

    Private Sub btnExpandAll_Click(sender As Object, e As EventArgs) Handles btnExpandAll.Click

        Dim SONo As String = tbSO.Text
        Dim ProdNo As String = tbProd.Text

        Dim url As String = "./ExpandedBOM.aspx?SONo=" & SONo & "&ProdNo=" & ProdNo
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,toolbars=0');popUpObj.focus()}</script>")
    End Sub

    Private Sub btnCompleteAll_Click(sender As Object, e As EventArgs) Handles btnCompleteAll.Click

        Dim gvOrderLines As GridView = DirectCast(FindControl("gvOrderLines"), GridView)

        For Each row As GridViewRow In gvOrderLines.Rows
            'Dim str As String = TryCast(row.FindControl

            Dim btnMissingLevel As ImageButton = DirectCast(row.FindControl("btnMissingLevel"), ImageButton)
            Dim btnCompleteLevel As ImageButton = DirectCast(row.FindControl("btnCompleteLevel"), ImageButton)
            Dim btnIncompleteLevel As ImageButton = DirectCast(row.FindControl("btnIncompleteLevel"), ImageButton)


            Dim item_no As String = TryCast(row.FindControl("lblitemno"), Label).Text
            Dim item_desc As String = TryCast(row.FindControl("lblitemdesc"), Label).Text
            Dim qty As Decimal = TryCast(row.FindControl("lblqty"), Label).Text

            Dim prodNo As String = tbProd.Text
            Dim status As Integer = 3

            ' MesgBox(item_desc)
            deletePartRecord(prodNo, item_no)
            insertPartRecord(prodNo, item_no, item_desc, qty, status)

            'Dim gvSelections As GridView = DirectCast(FindControl("gvSelections"), GridView)

            btnMissingLevel.CssClass = "white"
            btnCompleteLevel.CssClass = "green"
            btnIncompleteLevel.CssClass = "white"
        Next

    End Sub
End Class
