<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Customs.aspx.vb" Inherits="Customs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet.css" rel="stylesheet" />
    <title>Customs and Comments</title>
    <style type="text/css">
       
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="CUSTOMS AND COMMENTS" CssClass="newStyle7" Width="1200"></asp:Label>                    
        <asp:GridView ID="gvOpenOrders" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPPORDFIL" CssClass="newStyle1" Width="1201px">
            <Columns>
                <asp:BoundField DataField="user_def_fld_1" HeaderText="Prod #" SortExpression="user_def_fld_1" />
                <asp:BoundField DataField="src_ord_no" HeaderText="SO #" SortExpression="src_ord_no" />
                <asp:BoundField DataField="item_no" HeaderText="Model" SortExpression="item_no" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="due_dt" HeaderText="Due" SortExpression="due_dt" DataFormatString="{0:d}" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Macola Comments">
                    <ItemTemplate>
                          <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsMacola" ShowHeader="false" Width="100%">
                            <Columns>
                                <asp:BoundField DataField="cmt" HeaderText="cmt" SortExpression="cmt" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsMacola" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [cmt] FROM [OELINCMT_SQL] WHERE ([ord_no] = @ord_no)">
                            <SelectParameters>
                                <asp:Parameter Name="ord_no" Type="String"/>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>               
                <asp:TemplateField HeaderText ="Wind Screen">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbWindscreen" runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>                
                <asp:TemplateField HeaderText ="Open Arch">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbOpenArch" runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText ="Cladded Arch">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbCladdedArch" runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText ="Arch Installed">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbInstArch" runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPPORDFIL" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT PPORDFIL_SQL.item_no, PPORDFIL_SQL.item_desc_1, PPORDFIL_SQL.due_dt, PPORDFIL_SQL.user_def_fld_1, PPORDFIL_SQL.last_trx_dt, PPORDFIL_SQL.ord_status, PPORDFIL_SQL.src_ord_no FROM [PPORDFIL_SQL] Left Join [OEORDLIN_SQL] on PPORDFIL_SQL.src_ord_no = OEORDLIN_SQL.ord_no WHERE (([last_trx_dt] IS NULL) AND (PPORDFIL_SQL.user_def_fld_1 IS NOT NULL) AND (OEORDLIN_SQL.item_no = '905101' or OEORDLIN_SQL.item_no = '900882' or OEORDLIN_SQL.item_no = '900883' or OEORDLIN_SQL.item_no = '902895')) ORDER BY PPORDFIL_SQL.user_def_fld_1"></asp:SqlDataSource>


    </div>
    </form>
</body>
</html>
