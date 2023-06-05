<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MaintainHotList.aspx.vb" Inherits="MaintainHotList" MaintainScrollPositionOnPostback="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Maintain Hot List</title>
    <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="newStyle1">
        <asp:Label ID="Label1" runat="server" Text="Maintain Hot List - Visible to Keri, Terry, Chelsi and Kim Only." CssClass="newStyle4"></asp:Label>
        <br />
        <br />
        <asp:DropDownList ID="ddlShow" runat="server" AutoPostBack="True">
            <asp:ListItem Value="0">Hide Disabled</asp:ListItem>
            <asp:ListItem Value="2">Show All</asp:ListItem>

        </asp:DropDownList>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="Add New Prod # - 7 Digits" CssClass="newStyle4"></asp:Label>
        <br />
        <asp:DetailsView ID="DetailsView1" runat="server" CssClass="newStyle6" DataSourceID="sdsHotList" DefaultMode="Insert" Height="50px" Width="218px">
            <Fields>
                <asp:CommandField ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
        <br />
        <asp:GridView ID="gvHotList" runat="server" DataSourceID="sdsHotList" AutoGenerateColumns="False" DataKeyNames="ProdNo">
            <Columns>
                <asp:CommandField ShowEditButton ="True" ShowDeleteButton="True" >
                <ItemStyle Width="100px" />
                </asp:CommandField>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod # (7 Digits)" ReadOnly="True" SortExpression="ProdNo" />
                <asp:BoundField DataField="Disabled" HeaderText="Disabled (0 to show, 2 to hide)" SortExpression="Disabled" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                 <asp:BoundField DataField="DropDeadShipDate" HeaderText="Drop Dead Target Ship Date" DataFormatString="{0:d}" ReadOnly="False" SortExpression="DropDeadShipDate" />
                <asp:BoundField DataField="ShowDesc" HeaderText="Boat Show" ReadOnly="False" SortExpression="ShowDesc" />
                 <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:GridView ID="gvNotes" runat="server" DataSourceID="sdsBoatNotes" Width="500px" ShowHeader="false" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="Note" DataFormatString="&lt;div style=&quot;text-transform:capitalize&quot;&gt;{0}&lt;/div&gt;" HtmlEncode="false" ShowHeader="False">
                                    <ItemStyle Width="300px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:d}" ShowHeader="False">
                                    <ItemStyle Width="80px" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsBoatNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Note], [Date] FROM [BML_POPREPORTING_NOTES] WHERE ([ProdNo] = @ProdNo) ORDER BY [Date]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvHotList" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
        <asp:SqlDataSource ID="sdsHotList" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [HotList] WHERE [ProdNo] = @ProdNo" InsertCommand="INSERT INTO [HotList] ([ProdNo], [Disabled],[DropDeadShipDate],[ShowDesc]) VALUES (@ProdNo, @Disabled, @DropDeadShipDate, @ShowDesc)" SelectCommand="SELECT * FROM [HotList] WHERE ([Disabled] &lt;= @show) ORDER BY [ProdNo]" UpdateCommand="UPDATE [HotList] SET [Disabled] = @Disabled, [DropDeadShipDate] = @DropDeadShipDate, [ShowDesc] = @ShowDesc WHERE [ProdNo] = @ProdNo">
            <DeleteParameters>
                <asp:Parameter Name="ProdNo" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ProdNo" Type="String" />
                <asp:Parameter Name="Disabled" Type="Int32" />
                <asp:Parameter Name="DropDeadShipDate" Type="String" />
                <asp:Parameter Name="ShowDesc" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlShow" Name="show" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Disabled" Type="Int32" />
                <asp:Parameter Name="ProdNo" Type="String" />
                <asp:Parameter Name="DropDeadShipDate" Type="String" />
                <asp:Parameter Name="ShowDesc" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
