<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HotListProdNos.aspx.vb" Inherits="HotListProdNos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="gvHotList" runat="server" AutoGenerateColumns="False" DataKeyNames="PopNo" DataSourceID="sdsHotList">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" />               
                <asp:BoundField DataField="CusNo" HeaderText="Dealer #" SortExpression="CusNo" />
                <asp:BoundField DataField="CusName" HeaderText="Dealer" SortExpression="CusName" />
                <asp:BoundField DataField="ItemNo" HeaderText="Model" SortExpression="ItemNo" />               
                <asp:BoundField DataField="DueDate" HeaderText="Due Date" SortExpression="DueDate" />                
                <asp:BoundField DataField="IsCustom" HeaderText="Custom" SortExpression="IsCustom" />
                <asp:BoundField DataField="SONo" HeaderText="SO #" SortExpression="SONo" />                
                <asp:BoundField DataField="IsPilot" HeaderText="Pilot" SortExpression="IsPilot" />

                <asp:TemplateField HeaderText="Hide From Hot List">
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("Disabled") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>

            </Columns>

        </asp:GridView>
        <asp:SqlDataSource ID="sdsHotList" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" InsertCommand="INSERT INTO [HOSTLIST] ([ProdNo], [Disabled]) VALUES (@ProdNo, @Disabled)" SelectCommand="SELECT HOTLIST.ProdNo, BML_POPREPORTING_GREENLIGHTS.CusNo, BML_POPREPORTING_GREENLIGHTS.CusName, BML_POPREPORTING_GREENLIGHTS.SONo, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.IsCustom, BML_POPREPORTING_GREENLIGHTS.IsPilot, BML_POPREPORTING_GREENLIGHTS.DueDate FROM [HOTLIST] Left Join BML_POPREPORTING_GREENLIGHTS on HOTLIST.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([Disabled] = 0)" UpdateCommand="UPDATE [HOTLIST] SET [Disabled] = @Disabled WHERE [ProdNo] = @ProdNo">
            <DeleteParameters>
                <asp:Parameter Name="PopNo" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ProdNo" Type="String" />               
                <asp:Parameter Name="Disabled" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter Name="Disabled" Type="String" />
            </SelectParameters>
            <UpdateParameters>                
                <asp:Parameter Name="Disabled" Type="Int32" />                
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
