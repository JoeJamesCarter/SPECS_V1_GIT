Imports System.Data
Imports System.Data.SqlClient
Partial Class PhyInv_ExpandedBOM
    Inherits System.Web.UI.Page
    Public soLines As New DataTable
    Public components1P As New DataTable
    Public components2 As New DataTable
    Public components3 As New DataTable
    Public components4 As New DataTable
    Public components5 As New DataTable
    Public components6 As New DataTable
    Public components7 As New DataTable

    Public allComponents As New DataTable
    Public negatingParts As New DataTable

    Public bomParents As New DataTable
    Public components As New DataTable
    Public selections As New DataTable
    Public rtrSelections As New DataTable

    Public CountOfFound As Integer = 0

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

            Dim ProdNo As String
            ProdNo = Request.QueryString("ProdNo")

            lblProdNo.Text = ProdNo

            hdnSONo.Value = BoatSONo

            If BoatSONo.Length > 0 Then
                hdnSONo.Value = BoatSONo
                hdnSONoSkip2LeadingZeros.Value = Right(BoatSONo, Len(BoatSONo) - 2)
                GetBOM(BoatSONo)
            End If
        Catch
        End Try

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
        CountOfFound = 0

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
    Public Function GetBOM(BoatSONo As String) As String

        Dim so_item_no As String
        Dim so_item_desc As String
        Dim so_item_qty As String
        Dim bom_level As String
        Dim bomparent_itemno As String
        Dim bomparent_qty As String
        Dim seq_no As String
        Dim bomparent_desc As String
        Dim component_desc As String
        Dim component_qty As String
        Dim component_item As String
        Dim parent_item_no As String
        Dim parent_item_desc As String
        Dim parent_qty As String
        Dim parent_seqno As String

        Dim sopOrM As String
        Dim comp_pOrM As String

        Dim SqlDataAdapter As New SqlDataAdapter
        Dim SqlDataAdapter2 As New SqlDataAdapter
        Dim SqlDataAdapter3 As New SqlDataAdapter
        Dim SqlDataAdapter4 As New SqlDataAdapter
        Dim SqlDataAdapter5 As New SqlDataAdapter
        Dim SqlDataAdapter6 As New SqlDataAdapter
        Dim SqlDataAdapter7 As New SqlDataAdapter

        Dim SqlDataAdapter1P As New SqlDataAdapter


        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1

        conn1.Open()

        SqlDataAdapter.SelectCommand = New SqlCommand("SELECT OEORDLIN_SQL.item_no as parent_item_no, IMITMIDX_SQL.item_desc_1 as parent_item_desc, [qty_ordered] as parent_qty, pur_or_mfg as parent_pOrM, '0' as bom_level, OEORDLIN_SQL.item_no as bomparent_itemno, OEORDLIN_SQL.item_desc_1 as bomparent_desc, OEORDLIN_SQL.qty_ordered as bomparent_qty FROM [OEORDLIN_SQL] Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = '" & hdnSONo.Value & "' ) and (mat_cost_type != 'DIF' and mat_cost_type != 'DIS' and mat_cost_type != 'DIV' and mat_cost_type != 'DLR' and mat_cost_type != 'ENG' and mat_cost_type != 'EMZ' and mat_cost_type != 'FR1' and mat_cost_type != 'FRE' and mat_cost_type != 'FRT' and mat_cost_type != 'GRO' and mat_cost_type != 'OP1' and mat_cost_type != 'SHO' and mat_cost_type != 'SPA' and mat_cost_type != 'SPE' and mat_cost_type != 'TRA' and mat_cost_type != 'TRD' and mat_cost_type != 'TRL' and mat_cost_type != 'VOL' and mat_cost_type != 'WAR' and mat_cost_type != 'WXP' and mat_cost_type != 'WXS' and mat_cost_type != 'ZZZ' and mat_cost_type != '999') Order By OEORDLIN_SQL.item_desc_1", conn1)
        SqlDataAdapter.Fill(soLines)

        If soLines.Rows.Count <= 0 Then 'completed boat - get lines from history instead
            Try
                SqlDataAdapter.SelectCommand = New SqlCommand("SELECT OELINHST_SQL.item_no as parent_item_no, IMITMIDX_SQL.item_desc_1 as parent_item_desc, [qty_ordered] as parent_qty, pur_or_mfg as parent_pOrM, '0' as bom_level, OELINHST_SQL.item_no as bomparent_itemno, OELINHST_SQL.item_desc_1 as bomparent_desc, OELINHST_SQL.qty_ordered as bomparent_qty FROM [OELINHST_SQL] Left Join IMITMIDX_SQL on OELINHST_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = '" & hdnSONo.Value & "' ) and (mat_cost_type != 'DIF' and mat_cost_type != 'DIS' and mat_cost_type != 'DIV' and mat_cost_type != 'DLR' and mat_cost_type != 'ENG' and mat_cost_type != 'EMZ' and mat_cost_type != 'FR1' and mat_cost_type != 'FRE' and mat_cost_type != 'FRT' and mat_cost_type != 'GRO' and mat_cost_type != 'OP1' and mat_cost_type != 'SHO' and mat_cost_type != 'SPA' and mat_cost_type != 'SPE' and mat_cost_type != 'TRA' and mat_cost_type != 'TRD' and mat_cost_type != 'TRL' and mat_cost_type != 'VOL' and mat_cost_type != 'WAR' and mat_cost_type != 'WXP' and mat_cost_type != 'WXS' and mat_cost_type != 'ZZZ' and mat_cost_type != '999') Order By OELINHST_SQL.item_desc_1", conn1)
                SqlDataAdapter.Fill(soLines)
            Catch
                MesgBox("Something went wrong retreiving the BOM.")
            End Try

        End If

        allComponents.Columns.Add("parent_item_no")
        allComponents.Columns.Add("parent_item_desc")
        allComponents.Columns.Add("parent_qty").DataType = System.Type.GetType("System.Decimal")

        allComponents.Columns.Add("parent_pOrM")


        allComponents.Columns.Add("bom_level")
        allComponents.Columns.Add("bomparent_item")

        allComponents.Columns.Add("bomparent_desc")
        allComponents.Columns.Add("bomparent_qty").DataType = System.Type.GetType("System.Decimal")
        'allComponents.Columns.Add("bomparent_seqno")
        allComponents.Columns.Add("component_item")
        allComponents.Columns.Add("component_desc")
        allComponents.Columns.Add("compenent_qty").DataType = System.Type.GetType("System.Decimal")
        'allComponents.Columns.Add("component_seqno")
        allComponents.Columns.Add("compPorM")
        allComponents.Columns.Add("parent_seqno")
        'for the loop later during explosion

        bomParents.Columns.Add("bomparent_item")
        bomParents.Columns.Add("bomparent_desc")
        bomParents.Columns.Add("bomparent_qty")
        'bomParents.Columns.Add("bomparent_seqno")

        components.Columns.Add("component_item")
        components.Columns.Add("component_desc")
        components.Columns.Add("component_qty")
        'components.Columns.Add("component_seqno")

        negatingParts.Columns.Add("part")
        negatingParts.Columns.Add("sum")


        'write p parts to allComponents since they don't explode

        For Each soRow As DataRow In soLines.Rows
            If soRow("parent_pOrm") = "P" Then
                parent_item_no = soRow("parent_item_no").ToString
                parent_item_desc = soRow("parent_item_desc").ToString
                'component_item = soRow("comp_item_no").ToString
                'bomparent_qty = row3("bomparent_qty").ToString
                sopOrM = soRow("parent_PorM").ToString
                bom_level = "0"
                bomparent_itemno = soRow("bomparent_itemno").ToString
                bomparent_desc = soRow("bomparent_desc").ToString
                'component_desc = soRow("component_desc").ToString
                'component_qty = soRow("component_qty").ToString
                parent_qty = soRow("parent_qty").ToString
                parent_seqno = 0
                'bomparent_seqno = 0
                'component_seqno = 0
                'bomparent_qty = soRow("component_qty").ToString
                ' comp_pOrM = soRow("comp_pOrM").ToString

                allComponents.Rows.Add(parent_item_no, parent_item_desc, parent_qty, sopOrM, bom_level, bomparent_itemno, bomparent_desc, parent_qty, parent_item_no, parent_item_desc, parent_qty, sopOrM)
            End If

        Next


        'gvSOLines.DataSource = soLines
        'gvSOLines.DataBind()


        'loop the m parts and explode them

        For Each row As DataRow In soLines.Rows

            If (row("parent_pOrM").ToString = "M") Then
                so_item_no = row("parent_item_no").ToString
                so_item_desc = row("parent_item_desc").ToString
                so_item_desc = so_item_desc.Replace("""", " in ")
                so_item_desc = so_item_desc.Replace("'", " ft ")
                bomparent_qty = row("bomparent_qty")
                'component_qty = row("component_qty").ToString
                so_item_qty = row("parent_qty").ToString
                parent_qty = row("parent_qty").ToString
                sopOrM = row("parent_pOrM").ToString

                SqlDataAdapter2.SelectCommand = New SqlCommand("Select bmprdstr_sql.item_no as parent_item_no,  '" & so_item_desc & "' As parent_item_desc, '" & so_item_qty & "' as parent_qty,'" & sopOrM & "' as parent_pOrM,  bmprdstr_sql.item_no as bomparent_itemno, '" & so_item_desc & "' as bomparent_desc, '" & parent_qty & "' as bomparent_qty , comp_item_no, item_desc_1 As component_desc, sum(qty_per_par) *  '" & so_item_qty & "' as component_qty, pur_or_mfg as comp_pOrM, '1' as bom_level, seq_no FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & so_item_no & "'group by comp_item_no, bmprdstr_sql.item_no, item_desc_1, seq_no,pur_or_mfg,qty_per_par order by seq_no", conn1)
                SqlDataAdapter2.Fill(components2)

            End If

        Next
        gvComponents2.DataSource = components2
        gvComponents2.DataBind()
        'Exit Function
        'write every row to new table

        For Each innerRow As DataRow In components2.Rows
            If innerRow("comp_pOrM") = "P" Then
                parent_item_no = innerRow("parent_item_no").ToString
                parent_item_desc = innerRow("parent_item_desc").ToString
                parent_item_desc = parent_item_desc.Replace("""", " in ")
                parent_item_desc = parent_item_desc.Replace("'", " ft ")
                component_item = innerRow("comp_item_no").ToString
                parent_qty = innerRow("parent_qty").ToString
                seq_no = innerRow("seq_no").ToString
                sopOrM = innerRow("parent_PorM").ToString
                bom_level = "1"
                bomparent_itemno = innerRow("bomparent_itemno").ToString
                bomparent_desc = innerRow("parent_item_desc").ToString
                bomparent_qty = innerRow("bomparent_qty").ToString
                'component_qty = innerRow("component_qty").ToString
                comp_pOrM = innerRow("comp_pOrM").ToString
                component_item = innerRow("comp_item_no").ToString
                component_qty = innerRow("component_qty").ToString
                component_desc = innerRow("component_desc").ToString
                component_desc = component_desc.Replace("""", " in ")
                component_desc = component_desc.Replace("'", " ft ")

                allComponents.Rows.Add(parent_item_no, parent_item_desc, parent_qty, sopOrM, bom_level, bomparent_itemno, bomparent_desc, bomparent_qty, component_item, component_desc, component_qty, comp_pOrM, seq_no)
            End If

        Next
        'Exit Function
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'filter c2 to just the Mfg parts to explode them into c3

        Dim c2M_View As DataView = components2.DefaultView
        c2M_View.RowFilter = "comp_pOrM = 'M'"

        For Each rowView As DataRowView In c2M_View
            Dim row2 As DataRow = rowView.Row
            bomparent_itemno = row2("comp_item_no").ToString
            bomparent_desc = row2("component_desc").ToString
            bomparent_desc = bomparent_desc.Replace("""", " in ")
            bomparent_desc = bomparent_desc.Replace("'", " ft ")

            parent_item_no = row2("parent_item_no").ToString
            parent_item_desc = row2("parent_item_desc").ToString
            parent_qty = row2("parent_qty").ToString
            sopOrM = row2("parent_PorM").ToString

            bomparent_qty = row2("component_qty").ToString
            component_qty = row2("component_qty").ToString

            SqlDataAdapter3.SelectCommand = New SqlCommand("Select '" & parent_item_no & "' as parent_item_no, '" & parent_item_desc & "' as parent_item_desc, '" & parent_qty & "' as parent_qty, '" & sopOrM & "' as parent_pOrM, bmprdstr_sql.item_no as bomparent_itemno, '" & bomparent_desc & "' as bomparent_desc,  '" & bomparent_qty & "' as bomparent_qty , comp_item_no, item_desc_1 As component_desc, Sum(qty_per_par) * '" & component_qty & "' as component_qty, pur_or_mfg as comp_pOrM, '2' as bom_level,seq_no FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & bomparent_itemno & "' group by comp_item_no, bmprdstr_sql.item_no, item_desc_1, seq_no, pur_or_mfg order by seq_no ", conn1)
            SqlDataAdapter3.Fill(components3)
        Next

        'write all of c3 to allComponents and bind

        For Each row3 As DataRow In components3.Rows
            If row3("comp_pOrM") = "P" Then
                parent_item_no = row3("parent_item_no").ToString
                parent_item_desc = row3("parent_item_desc").ToString
                component_item = row3("comp_item_no").ToString
                'bomparent_qty = row3("bomparent_qty").ToString
                sopOrM = row3("parent_PorM").ToString
                bom_level = "2"
                bomparent_itemno = row3("bomparent_itemno").ToString
                bomparent_desc = row3("bomparent_desc").ToString
                component_desc = row3("component_desc").ToString
                component_qty = row3("component_qty").ToString
                parent_qty = row3("parent_qty").ToString
                bomparent_qty = row3("bomparent_qty").ToString
                comp_pOrM = row3("comp_pOrM").ToString
                'bomparent_seqno = row3("bomparent_seqno").ToString

                allComponents.Rows.Add(parent_item_no, parent_item_desc, parent_qty, sopOrM, bom_level, bomparent_itemno, bomparent_desc, bomparent_qty, component_item, component_desc, component_qty, comp_pOrM, seq_no)
            End If

        Next

        gvComponents3.DataSource = components3
        gvComponents3.DataBind()
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

        'filter c3 to just the Mfg parts to explode them into c4

        Dim c3M_View As DataView = components3.DefaultView
        c3M_View.RowFilter = "comp_pOrM = 'M'"

        For Each rowView As DataRowView In c3M_View
            Dim row3 As DataRow = rowView.Row
            bomparent_itemno = row3("comp_item_no").ToString
            bomparent_desc = row3("component_desc").ToString
            bomparent_desc = bomparent_desc.Replace("""", " in ")
            bomparent_desc = bomparent_desc.Replace("'", " ft ")

            parent_item_no = row3("parent_item_no").ToString
            parent_item_desc = row3("parent_item_desc").ToString
            parent_qty = row3("parent_qty").ToString
            sopOrM = row3("parent_PorM").ToString

            bomparent_qty = row3("component_qty").ToString
            component_qty = row3("component_qty").ToString

            SqlDataAdapter3.SelectCommand = New SqlCommand("Select '" & parent_item_no & "' as parent_item_no, '" & parent_item_desc & "' as parent_item_desc, '" & parent_qty & "' as parent_qty, '" & sopOrM & "' as parent_pOrM, bmprdstr_sql.item_no as bomparent_itemno, '" & bomparent_desc & "' as bomparent_desc,  '" & component_qty & "'  as bomparent_qty , comp_item_no, item_desc_1 As component_desc, Sum(qty_per_par) * '" & component_qty & "' as component_qty, pur_or_mfg as comp_pOrM, '3' as bom_level, seq_no FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & bomparent_itemno & "' group by comp_item_no, bmprdstr_sql.item_no, item_desc_1, seq_no, pur_or_mfg order by seq_no", conn1)
            SqlDataAdapter3.Fill(components4)
        Next

        'write all of c3 to allComponents and bind

        For Each row4 As DataRow In components4.Rows
            If row4("comp_pOrM") = "P" Then
                parent_item_no = row4("parent_item_no").ToString
                parent_item_desc = row4("parent_item_desc").ToString
                component_item = row4("comp_item_no").ToString
                'bomparent_qty = row3("bomparent_qty").ToString
                sopOrM = row4("parent_PorM").ToString
                bom_level = "3"
                bomparent_itemno = row4("bomparent_itemno").ToString
                bomparent_desc = row4("bomparent_desc").ToString
                component_desc = row4("component_desc").ToString
                component_qty = row4("component_qty").ToString
                parent_qty = row4("parent_qty").ToString
                bomparent_qty = row4("bomparent_qty").ToString
                comp_pOrM = row4("comp_pOrM").ToString
                seq_no = row4("seq_no").ToString

                allComponents.Rows.Add(parent_item_no, parent_item_desc, parent_qty, sopOrM, bom_level, bomparent_itemno, bomparent_desc, bomparent_qty, component_item, component_desc, component_qty, comp_pOrM, seq_no)
            End If

        Next

        gvComponents4.DataSource = components4
        gvComponents4.DataBind()

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

        'filter c4 to just the Mfg parts to explode them into c5

        Dim c4M_View As DataView = components4.DefaultView
        c4M_View.RowFilter = "comp_pOrM = 'M'"

        For Each rowView As DataRowView In c4M_View
            Dim row4 As DataRow = rowView.Row
            bomparent_itemno = row4("comp_item_no").ToString
            bomparent_desc = row4("component_desc").ToString
            bomparent_desc = bomparent_desc.Replace("""", " in ")
            bomparent_desc = bomparent_desc.Replace("'", " ft ")

            parent_item_no = row4("parent_item_no").ToString
            parent_item_desc = row4("parent_item_desc").ToString
            parent_qty = row4("parent_qty").ToString
            sopOrM = row4("parent_PorM").ToString

            bomparent_qty = row4("component_qty").ToString
            component_qty = row4("component_qty").ToString

            SqlDataAdapter4.SelectCommand = New SqlCommand("Select '" & parent_item_no & "' as parent_item_no, '" & parent_item_desc & "' as parent_item_desc, '" & parent_qty & "' as parent_qty, '" & sopOrM & "' as parent_pOrM, bmprdstr_sql.item_no as bomparent_itemno, '" & bomparent_desc & "' as bomparent_desc,  '" & component_qty & "'  as bomparent_qty , comp_item_no, item_desc_1 As component_desc, Sum(qty_per_par) * '" & component_qty & "' as component_qty, pur_or_mfg as comp_pOrM, '4' as bom_level, seq_no FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & bomparent_itemno & "' group by comp_item_no, bmprdstr_sql.item_no, item_desc_1, seq_no, pur_or_mfg order by seq_no", conn1)
            SqlDataAdapter4.Fill(components5)
        Next

        'write all of c3 to allComponents and bind

        For Each row5 As DataRow In components5.Rows
            If row5("comp_pOrM") = "P" Then
                parent_item_no = row5("parent_item_no").ToString
                parent_item_desc = row5("parent_item_desc").ToString
                component_item = row5("comp_item_no").ToString
                'bomparent_qty = row3("bomparent_qty").ToString
                sopOrM = row5("parent_PorM").ToString
                bom_level = "4"
                bomparent_itemno = row5("bomparent_itemno").ToString
                bomparent_desc = row5("bomparent_desc").ToString
                component_desc = row5("component_desc").ToString
                component_qty = row5("component_qty").ToString
                parent_qty = row5("parent_qty").ToString
                bomparent_qty = row5("bomparent_qty").ToString
                comp_pOrM = row5("comp_pOrM").ToString
                seq_no = row5("seq_no").ToString
                allComponents.Rows.Add(parent_item_no, parent_item_desc, parent_qty, sopOrM, bom_level, bomparent_itemno, bomparent_desc, bomparent_qty, component_item, component_desc, component_qty, comp_pOrM, seq_no)
            End If

        Next

        'gvComponents5.DataSource = components5
        'gvComponents5.DataBind()

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'filter c5 to just the Mfg parts to explode them into c6

        Dim c5M_View As DataView = components5.DefaultView
        c5M_View.RowFilter = "comp_pOrM = 'M'"

        For Each rowView As DataRowView In c5M_View
            Dim row5 As DataRow = rowView.Row
            bomparent_itemno = row5("comp_item_no").ToString
            bomparent_desc = row5("component_desc").ToString
            bomparent_desc = bomparent_desc.Replace("""", " in ")
            bomparent_desc = bomparent_desc.Replace("'", " ft ")

            parent_item_no = row5("parent_item_no").ToString
            parent_item_desc = row5("parent_item_desc").ToString
            parent_qty = row5("parent_qty").ToString
            sopOrM = row5("parent_PorM").ToString

            bomparent_qty = row5("bomparent_qty").ToString
            component_qty = row5("component_qty").ToString

            SqlDataAdapter4.SelectCommand = New SqlCommand("Select '" & parent_item_no & "' as parent_item_no, '" & parent_item_desc & "' as parent_item_desc, '" & parent_qty & "' as parent_qty, '" & sopOrM & "' as parent_pOrM, bmprdstr_sql.item_no as bomparent_itemno, '" & bomparent_desc & "' as bomparent_desc,  '" & component_qty & "'  as bomparent_qty , comp_item_no, item_desc_1 As component_desc, Sum(qty_per_par) * '" & component_qty & "' as component_qty, pur_or_mfg as comp_pOrM, '5' as bom_level, seq_no FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & bomparent_itemno & "' group by comp_item_no, bmprdstr_sql.item_no, item_desc_1, seq_no, pur_or_mfg order by seq_no", conn1)
            SqlDataAdapter4.Fill(components6)
        Next

        'write all of c3 to allComponents and bind

        For Each row6 As DataRow In components6.Rows
            If row6("comp_pOrM") = "P" Then
                parent_item_no = row6("parent_item_no").ToString
                parent_item_desc = row6("parent_item_desc").ToString
                component_item = row6("comp_item_no").ToString
                'bomparent_qty = row3("bomparent_qty").ToString
                sopOrM = row6("parent_PorM").ToString
                bom_level = "5"
                bomparent_itemno = row6("bomparent_itemno").ToString
                bomparent_desc = row6("bomparent_desc").ToString
                component_desc = row6("component_desc").ToString
                component_qty = row6("component_qty").ToString
                parent_qty = row6("parent_qty").ToString
                bomparent_qty = row6("parent_qty").ToString
                comp_pOrM = row6("comp_pOrM").ToString
                seq_no = row6("seq_no").ToString
                allComponents.Rows.Add(parent_item_no, parent_item_desc, parent_qty, sopOrM, bom_level, bomparent_itemno, bomparent_desc, bomparent_qty, component_item, component_desc, component_qty, comp_pOrM, seq_no)
            End If

        Next

        'gvComponents6.DataSource = components6
        'gvComponents6.DataBind()

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'filter c6 to just the Mfg parts to explode them into c7

        Dim c6M_View As DataView = components6.DefaultView
        c6M_View.RowFilter = "comp_pOrM = 'M'"

        For Each rowView As DataRowView In c6M_View
            Dim row6 As DataRow = rowView.Row
            bomparent_itemno = row6("comp_item_no").ToString
            bomparent_desc = row6("component_desc").ToString
            bomparent_desc = bomparent_desc.Replace("""", " in ")
            bomparent_desc = bomparent_desc.Replace("'", " ft ")

            parent_item_no = row6("parent_item_no").ToString
            parent_item_desc = row6("parent_item_desc").ToString
            parent_qty = row6("parent_qty").ToString
            sopOrM = row6("parent_PorM").ToString

            bomparent_qty = row6("bomparent_qty").ToString
            component_qty = row6("component_qty").ToString

            SqlDataAdapter4.SelectCommand = New SqlCommand("Select '" & parent_item_no & "' as parent_item_no, '" & parent_item_desc & "' as parent_item_desc, '" & parent_qty & "' as parent_qty, '" & sopOrM & "' as parent_pOrM, bmprdstr_sql.item_no as bomparent_itemno, '" & bomparent_desc & "' as bomparent_desc,  '" & component_qty & "'  as bomparent_qty , comp_item_no, item_desc_1 As component_desc, Sum(qty_per_par) * '" & component_qty & "' as component_qty, pur_or_mfg as comp_pOrM, '6' as bom_level, seq_no FROM bmprdstr_sql left join imitmidx_sql on bmprdstr_sql.comp_item_no =  imitmidx_sql.item_no where bmprdstr_sql.item_no = '" & bomparent_itemno & "' group by comp_item_no, bmprdstr_sql.item_no, item_desc_1, seq_no, pur_or_mfg order by seq_no", conn1)
            SqlDataAdapter4.Fill(components6)
        Next

        'write all of c3 to allComponents and bind

        For Each row7 As DataRow In components6.Rows
            If row7("comp_pOrM") = "P" Then
                parent_item_no = row7("parent_item_no").ToString
                parent_item_desc = row7("parent_item_desc").ToString
                component_item = row7("comp_item_no").ToString
                'bomparent_qty = row3("bomparent_qty").ToString
                sopOrM = row7("parent_PorM").ToString
                bom_level = "6"
                bomparent_itemno = row7("bomparent_itemno").ToString
                bomparent_desc = row7("bomparent_desc").ToString
                component_desc = row7("component_desc").ToString
                component_qty = row7("component_qty").ToString
                parent_qty = row7("parent_qty").ToString
                bomparent_qty = row7("parent_qty").ToString
                comp_pOrM = row7("comp_pOrM").ToString
                seq_no = row7("seq_no")

                allComponents.Rows.Add(parent_item_no, parent_item_desc, parent_qty, sopOrM, bom_level, bomparent_itemno, bomparent_desc, bomparent_qty, component_item, component_desc, component_qty, comp_pOrM, seq_no)
            End If

        Next

        'toDo explode anything M at level 7?

        'gvComponents7.DataSource = components7
        'gvComponents7.DataBind()


        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

        Dim gvDistinctParents As GridView = FindControl("gvDistinctParents")

        Dim dataView As New DataView(allComponents)
        'dataView.Sort = "parent_item_no,component_item"

        dataView.Sort = "bomparent_item"

        'if you need to see all the data to test, uncomment these 2 lines
        gvAllLevels.DataSource = dataView
        gvAllLevels.DataBind()

        conn1.Close()
        conn1.Dispose()

        Dim dtDistinctParents As DataTable = GetDistinctRecords(allComponents, {"parent_item_no", "parent_item_desc", "parent_qty"})
        Dim dvDistinctParents As New DataView(dtDistinctParents)
        dvDistinctParents.Sort = "parent_item_desc"


        Return False
    End Function


    Public Shared Function GetDistinctRecords(ByVal dt As DataTable, ByVal Columns As String()) As DataTable
        Dim dtUniqRecords As DataTable = New DataTable()
        dtUniqRecords = dt.DefaultView.ToTable(True, Columns)
        Return dtUniqRecords
    End Function

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click

        Dim SearchTerm As String = tbSearch.Text
        If SearchTerm.Length > 0 Then
            gvAllLevels.DataBind()
        End If

    End Sub

    Private Sub gvAllLevels_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllLevels.RowDataBound

        Dim SearchTerm As String = Trim(tbSearch.Text).ToUpper
        Dim FilterTerm As String = Trim(tbFilter.Text).ToUpper


        If e.Row.RowType = DataControlRowType.DataRow Then

            If SearchTerm.Length > 0 Then

                If e.Row.Cells(0).Text.Contains(SearchTerm) Then
                    e.Row.Cells(0).BackColor = Drawing.Color.Yellow
                    CountOfFound = CountOfFound + 1
                End If

                If e.Row.Cells(1).Text.Contains(SearchTerm) Then
                    e.Row.Cells(1).BackColor = Drawing.Color.Yellow
                    CountOfFound = CountOfFound + 1
                End If

                If e.Row.Cells(5).Text.Contains(SearchTerm) Then
                    e.Row.Cells(5).BackColor = Drawing.Color.Yellow
                    CountOfFound = CountOfFound + 1
                End If

                If e.Row.Cells(6).Text.Contains(SearchTerm) Then
                    e.Row.Cells(6).BackColor = Drawing.Color.Yellow
                    CountOfFound = CountOfFound + 1
                End If

                If e.Row.Cells(8).Text.Contains(SearchTerm) Then
                    e.Row.Cells(8).BackColor = Drawing.Color.Yellow
                    CountOfFound = CountOfFound + 1
                End If

                If e.Row.Cells(9).Text.Contains(SearchTerm) Then
                    e.Row.Cells(9).BackColor = Drawing.Color.Yellow
                    CountOfFound = CountOfFound + 1
                End If

            End If
        End If


        If FilterTerm.Length > 0 Then

            If e.Row.Cells(0).Text.Contains(FilterTerm) Then
                e.Row.Cells(0).BackColor = Drawing.Color.Yellow
                CountOfFound = CountOfFound + 1
            End If

            If e.Row.Cells(1).Text.Contains(FilterTerm) Then
                e.Row.Cells(1).BackColor = Drawing.Color.Yellow
                CountOfFound = CountOfFound + 1
            End If

            If e.Row.Cells(5).Text.Contains(FilterTerm) Then
                e.Row.Cells(5).BackColor = Drawing.Color.Yellow
                CountOfFound = CountOfFound + 1
            End If

            If e.Row.Cells(6).Text.Contains(FilterTerm) Then
                e.Row.Cells(6).BackColor = Drawing.Color.Yellow
                CountOfFound = CountOfFound + 1
            End If

            If e.Row.Cells(8).Text.Contains(FilterTerm) Then
                e.Row.Cells(8).BackColor = Drawing.Color.Yellow
                CountOfFound = CountOfFound + 1
            End If

            If e.Row.Cells(9).Text.Contains(FilterTerm) Then
                e.Row.Cells(9).BackColor = Drawing.Color.Yellow
                CountOfFound = CountOfFound + 1
            End If


            If e.Row.Cells(0).BackColor = Drawing.Color.Yellow Or e.Row.Cells(1).BackColor = Drawing.Color.Yellow Or e.Row.Cells(5).BackColor = Drawing.Color.Yellow Or e.Row.Cells(6).BackColor = Drawing.Color.Yellow Or e.Row.Cells(8).BackColor = Drawing.Color.Yellow Or e.Row.Cells(9).BackColor = Drawing.Color.Yellow Then
            Else
                e.Row.Visible = False
            End If


        End If





        lblCountOfFound.Text = CountOfFound

    End Sub

    Private Sub btnClearSearch_Click(sender As Object, e As EventArgs) Handles btnClearSearch.Click
        tbSearch.Text = ""
        tbFilter.Text = ""
        gvAllLevels.DataBind()
    End Sub
End Class
