<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HarnessRcv.aspx.vb" Inherits="Barcode_HarnessRcv" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harness Receiving</title>
    <style>
        #barcodescanner {
            font-family: Calbri;
            font-size: 70px;
            width: 1000px;
            text-align: center;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div id="barcodescanner">
            <asp:Label ID="Label1" runat="server" Text="Harness Receiving" Font-Size="40px"></asp:Label>
            <br />
            <asp:Label ID="Label3" runat="server" Text=" B1: " Font-Size="30px"></asp:Label><asp:Label ID="lblB1Total" runat="server" Text=""></asp:Label>
            <asp:Label ID="Label4" runat="server" Text=" B2: " Font-Size="30px"></asp:Label><asp:Label ID="lblB2Total" runat="server" Text=""></asp:Label>
            <asp:Label ID="Label6" runat="server" Text=" B3: " Font-Size="30px"></asp:Label><asp:Label ID="lblB3Total" runat="server" Text=""></asp:Label>
            <asp:Label ID="Label2" runat="server" Text=" Total: " Font-Size="30px"></asp:Label><asp:Label ID="lblHarnessRcvToday" runat="server" Text=""></asp:Label>

            <br />
            &nbsp;&nbsp;<br />
            <asp:TextBox ID="tbProd" runat="server" Font-Size="60px" Height="144px" Width="463px" Style="text-align: center"></asp:TextBox>
            &nbsp;
        <asp:Button ID="btnClear" runat="server" Font-Size="30px" Height="90px" Style="margin-top: 0px" Text="X" Width="92px" />
            <br />
            &nbsp;
        <br />
            <asp:Button ID="Button1" runat="server" Text="RECEIVE" Height="159px" Width="654px" Font-Size="30pt" />
            <br />
             <br />
            <asp:GridView runat="server" ID="gvHarnessesToday" DataSourceID="sdsHarnesses" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" Width="100%" AutoGenerateColumns="false" Font-Size="30px">
                 <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo"></asp:BoundField>
                <asp:BoundField DataField="HarnessLastUpdated" HeaderText="Harness Rcvd" SortExpression="HarnessLastUpdated"></asp:BoundField>
                     <asp:BoundField DataField="ProdLineDesc" HeaderText="Line" SortExpression="ProdLineDesc"></asp:BoundField>
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
            <asp:SqlDataSource runat="server" ID="sdsHarnesses" ConnectionString='<%$ ConnectionStrings:bml_dataConnectionString %>' SelectCommand="SELECT *, ProdLineDesc FROM [BML_POPREPORTING_GREENLIGHTS] Left join ProductionLines on BML_POPREPORTING_GREENLIGHTS.ProdLineID = ProductionLines.ProdLineID WHERE (([HarnessStatus] = @HarnessStatus) AND convert(date, HarnessLastUpdated, 102) = convert(varchar(10), getdate(), 102) )">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="HarnessStatus" Type="Int32"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
