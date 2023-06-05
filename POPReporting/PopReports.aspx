<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PopReports.aspx.vb" Inherits="PopReports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PRODUCTION SCHEDULE</title>
    <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="newStyle1">
            <asp:TextBox ID="tbThruDate" runat="server" TextMode="Date" AutoPostBack="True"></asp:TextBox>
            <asp:GridView ID="gvPopReports" runat="server" DataSourceID="sdsPopReports">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:GridView ID="gvOptions" runat="server">
                            </asp:GridView>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsPopReports" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [PPORDFIL_SQL].[user_def_fld_1], [PPORDFIL_SQL].[ord_no], [due_dt], [PPORDFIL_SQL].[user_def_fld_5],OEORDHDR_SQL.ord_no, OEORDHDR_SQL.cus_no, OEORDHDR_SQL.bill_to_name,OEORDHDR_SQL.user_def_fld_1, OEORDHDR_SQL.oe_po_no, OEORDHDR_SQL.slspsn_no FROM [PPORDFIL_SQL] INNER JOIN OEORDHDR_SQL ON PPORDFIL_SQL.src_ord_no = OEORDHDR_SQL.ord_no WHERE (([PPORDFIL_SQL].[user_def_fld_1] NOT LIKE '%' + @user_def_fld_1 + '%') AND ([PPORDFIL_SQL].[user_def_fld_1] NOT LIKE '%' + @user_def_fld_12 + '%') AND ([PPORDFIL_SQL].[user_def_fld_1] NOT LIKE '%' + @user_def_fld_13 + '%') AND ([due_dt] &lt;= @due_dt) AND ([PPORDFIL_SQL].[ord_type] = @ord_type) AND (([ord_status] = @ord_status) OR ([ord_status] = @ord_status2)) AND ([src_pkg_id] = @src_pkg_id) AND ([ord_qty] - [report_qty] > 0))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="D*" Name="user_def_fld_1" Type="String" />
                    <asp:Parameter DefaultValue="H*" Name="user_def_fld_12" Type="String" />
                    <asp:Parameter DefaultValue="F*" Name="user_def_fld_13" Type="String" />
                    <asp:ControlParameter ControlID="tbThruDate" Name="due_dt" PropertyName="Text" Type="DateTime" />
                    <asp:Parameter DefaultValue="P" Name="ord_type" Type="String" />
                    <asp:Parameter DefaultValue="R" Name="ord_status" Type="String" />
                    <asp:Parameter DefaultValue="I" Name="ord_status2" Type="String" />
                    <asp:Parameter DefaultValue="OE" Name="src_pkg_id" Type="String" />                    
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
