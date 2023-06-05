<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GaugesRcv.aspx.vb" Inherits="Barcode_GaugesRcv" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gauge Panel Receiving</title>
    <style>
        #barcodescanner {
        font-family:Calbri;
        font-size:70px;
        width:1000px;
        text-align:center;        
        }

    </style>

</head>
<body>
    <form id="form1" runat="server">
    <div id="barcodescanner">
        <asp:Label ID="Label1" runat="server" Text="Gauge Panel Receiving" Font-Size="40px"></asp:Label> <br />         
        <br />
        <br />
        &nbsp;&nbsp;<br />
        <asp:TextBox ID="tbProd" runat="server" Font-Size="60px" Height="144px" Width="463px" style="text-align: center"></asp:TextBox>
        &nbsp;
        <asp:Button ID="btnClear" runat="server" Font-Size="30px" Height="90px" style="margin-top: 0px" Text="X" Width="92px" />
        <br />
    &nbsp;
        <br />       
        <asp:Button ID="Button1" runat="server" Text="RECEIVE" Height="159px" Width="654px" Font-Size="30pt" />
        <br />
        <br />
        <asp:GridView runat="server" ID="gvGaugesToday" DataSourceID="sdsGaugesToday" AutoGenerateColumns="False" DataKeyNames="ProdNo" Caption="Received Today" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" Width="100%">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo"></asp:BoundField>
                <asp:BoundField DataField="GaugeLastUpdated" HeaderText="Gauge Rcvd" SortExpression="GaugeLastUpdated"></asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC"></FooterStyle>

            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>

            <PagerStyle HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black"></PagerStyle>

            <RowStyle BackColor="White"></RowStyle>

            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

            <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

            <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>

            <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

            <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
        </asp:GridView>
        <asp:SqlDataSource runat="server" ID="sdsGaugesToday" ConnectionString='<%$ ConnectionStrings:bml_dataConnectionString %>' SelectCommand="SELECT ProdNo, BuildLoc, GaugeLastUpdated FROM [BML_POPREPORTING_GREENLIGHTS] WHERE [GaugeStatus] = @GaugeStatus AND convert(date, GaugeLastUpdated, 102) = convert(varchar(10), getdate(), 102) Order By GaugeLastUpdated Desc">
            <SelectParameters>
                <asp:Parameter DefaultValue="2" Name="GaugeStatus" Type="Int32"></asp:Parameter>                
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
