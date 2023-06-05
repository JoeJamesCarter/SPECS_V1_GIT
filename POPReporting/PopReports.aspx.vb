Imports System.Data
Imports System.Data.SqlClient

Partial Class PopReports
    Inherits System.Web.UI.Page
    Public ordLines As New DataTable

    Private Sub form1_Load(sender As Object, e As EventArgs) Handles form1.Load
        PopulateDataTables()
    End Sub
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
        Dim sqldataadapter As New SqlDataAdapter


        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString

        conn.ConnectionString = connstr

        conn.Open()

        sqldataadapter.SelectCommand = New SqlCommand("SELECT OEORDLIN_SQL.ord_no as ord_no, OEORDLIN_SQL.item_no, OEORDLIN_SQL.item_desc_1, OEORDLIN_SQL.qty_ordered, OEORDLIN_SQL.line_no, IMITMIDX_SQL.mat_cost_type, IMITMIDX_SQL.prod_cat FROM (OEORDHDR_SQL INNER JOIN OEORDLIN_SQL ON OEORDHDR_SQL.ord_no = OEORDLIN_SQL.ord_no) INNER JOIN IMITMIDX_SQL ON OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE (((IMITMIDX_SQL.mat_cost_type)<> 'WIP' And (IMITMIDX_SQL.mat_cost_type)<>'DIS') AND ((IMITMIDX_SQL.prod_cat)<>'C1' And (IMITMIDX_SQL.prod_cat)<>'C2' And (IMITMIDX_SQL.prod_cat)<>'C3' And (IMITMIDX_SQL.prod_cat)<>'C4' And (IMITMIDX_SQL.prod_cat)<>'C5' And (IMITMIDX_SQL.prod_cat)<>'C6' And (IMITMIDX_SQL.prod_cat)<>'C7' And (IMITMIDX_SQL.prod_cat)<>'C8' And (IMITMIDX_SQL.prod_cat)<>'C10' And (IMITMIDX_SQL.prod_cat)<>'GRO') AND ((IMITMIDX_SQL.end_item_cd) Is Null Or (IMITMIDX_SQL.end_item_cd)<>'K'))", conn)
        sqldataadapter.Fill(ordLines)

        conn.Close()
        conn.Dispose()

        Return False

    End Function

    Protected Sub gvPopReports_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvPopReports.RowDataBound

        Dim ord_no As String = e.Row.Cells(1).Text
        Dim gvOptions As GridView = DirectCast(e.Row.FindControl("gvOptions"), GridView)
        Dim orderLines() As DataRow = ordLines.Select("ord_no =  '" & ord_no & "'")
        'MesgBox(ordLines(1)(0))
        Dim panelColor() As DataRow = ordLines.Select("ord_no =  '" & ord_no & "' AND prod_cat = 'H1'")
        'gvOptions.DataSource = orderLines

    End Sub
End Class
