Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.Windows.Forms
Imports System.Threading



Partial Class ProdOrders_Production_Order
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub ddlProdNo_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlProdNo.SelectedIndexChanged

        Dim SelectedProdNo As Integer = ddlProdNo.SelectedValue 'find the prod # in that row to use in the update command
        Dim conn As New SqlConnection()
        Dim conn2 As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        Dim connstr2 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString


        Dim cmd As New SqlCommand
        Dim cmd0 As New SqlCommand

        conn.ConnectionString = connstr
        conn2.ConnectionString = connstr2

        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Select ord_no FROM dbo.PPORDFIL_SQL where user_def_fld_1 =  '" & SelectedProdNo & "'"
        cmd0.CommandText = "Select src_ord_no FROM dbo.PPORDFIL_SQL where user_def_fld_1 =  '" & SelectedProdNo & "'"

        cmd.Connection = conn
        cmd0.Connection = conn

        conn.Open()
        hdnPopNo.Value = cmd.ExecuteScalar()
        hdnSoNo.Value = cmd0.ExecuteScalar()
       

        Dim MySQLAdapter As New SqlDataAdapter
        Dim OEORDLINTEMP As New DataTable
        Dim ds As New DataSet()
        Dim dt As New DataTable()


        Try
            MySQLAdapter.SelectCommand = New SqlCommand("Select item_no,item_desc_1 from dbo.OEORDLIN_SQL where (item_no Not Like 'VOLDIS' and item_no Not Like 'COMMENTPROD' and item_no Not Like '905101' and item_no Not Like '909091' and item_no Not Like 'SERIAL%' and item_desc_1 Not Like 'Discover Boat%' and item_desc_1 Not Like '%Promo%') and OEORDLIN_SQL.ord_no = '" & hdnSoNo.Value & "'", conn)
            MySQLAdapter.Fill(OEORDLINTEMP)
            ' dbGridview1.DataSource = OEORDLINTEMP
            'dbGridview1.DataBind()

            MySQLAdapter.Dispose()
            conn.Close()
        Finally
            MySQLAdapter.Dispose()
            conn.Close()
            conn.Dispose()
        End Try

        Dim MySQLAdapter2 As New SqlDataAdapter
        Dim FABOPTIONSTEMP As New DataTable

        Try
            conn2.Open()
            MySQLAdapter.SelectCommand = New SqlCommand("Select distinct Option_Item as item_no from dbo.BML_POPREPORTINGFABOPTIONS where dbo.BML_POPREPORTINGFABOPTIONS.PopNo = '" & hdnPopNo.Value & "'", conn2)
            MySQLAdapter.Fill(FABOPTIONSTEMP)
            'dbGridview2.DataSource = FABOPTIONSTEMP
            'dbGridview2.DataBind()

            MySQLAdapter2.Dispose()
            conn2.Close()
        Finally
            MySQLAdapter2.Dispose()
            conn2.Close()
            conn2.Dispose()
        End Try

        'find the difference between the items on the order and the items on the fab report.  Return the difference.
        Dim t1ItemNo = OEORDLINTEMP.AsEnumerable().Select(Function(r) r.Field(Of String)("item_no"))
        Dim t2ItemNo = FABOPTIONSTEMP.AsEnumerable().Select(Function(r) r.Field(Of String)("item_no"))
        Dim uniqueItemNo = t1ItemNo.Except(t2ItemNo).ToList()
        Dim tblResult = (From row In OEORDLINTEMP.AsEnumerable()
                  Join item_no In uniqueItemNo
                  On row.Field(Of String)("item_no") Equals item_no
                  Select row).CopyToDataTable()

        dbGridView3.DataSource = tblResult
        dbGridView3.DataBind()
        ClientScript.RegisterStartupScript([GetType](), "print", "window.print();", True)

    End Sub
    
    Protected Sub btnBuildDate_Click(sender As Object, e As EventArgs) Handles btnBuildDate.Click
        Dim duedate As String = tbBuildDate.Text
        Dim MySqlAdapter3 As New SqlDataAdapter
        Dim orderswiththisbuilddate As New DataTable
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        conn.Open()
        Try
            MySqlAdapter3.SelectCommand = New SqlCommand("Select ord_no, src_ord_no, user_def_fld_1 from dbo.PPORDFIL_SQL where ord_status ='R' and last_trx_dt='0' and user_def_fld_1 is not null and due_dt = '" & duedate & "' order by user_def_fld_1", conn)

            MySqlAdapter3.Fill(orderswiththisbuilddate)
            'dbGridview1.DataSource = orderswiththisbuilddate
            'dbGridview1.DataBind()

            MySQLAdapter3.Dispose()
            conn.Close()
        Finally
            MySQLAdapter3.Dispose()
            conn.Close()
            conn.Dispose()
        End Try

        Dim i As Integer = 0

        For Each row As DataRow In orderswiththisbuilddate.Rows
            Dim prodnum = orderswiththisbuilddate.Rows(i)(2)

            'ddlProdNo.SelectedValue = prodnum
            form1.DataBind()

            'ddlProdNo_SelectedIndexChanged(ddlProdNo, EventArgs.Empty)

            i = i + 1

        Next row
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        sdsCanvas.DataBind()
        sdsBaseVinyl.DataBind()

    End Sub
    
    
End Class
