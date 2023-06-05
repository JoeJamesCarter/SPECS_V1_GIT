<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HelmShip.aspx.vb" Inherits="Barcode_HelmShip" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Helm Shipping</title>
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
            <asp:Label ID="Label1" runat="server" Text="Helm Shipping" Font-Size="40px"></asp:Label>
            <br />
            <asp:Label ID="Label2" runat="server" Text="# Shipped Today: "></asp:Label><asp:Label ID="lblHelmsShippedToday" runat="server" Text=""></asp:Label>
            <br />
            <br />
            &nbsp;&nbsp;<br />
            <asp:TextBox ID="tbProd" runat="server" Font-Size="60px" Height="144px" Width="463px" Style="text-align: center"></asp:TextBox>
            &nbsp;
            <asp:Button ID="btnClear" runat="server" Font-Size="30px" Height="90px" Style="margin-top: 0px" Text="X" Width="92px" />
            <br />
            &nbsp;
            <br />            
            <br />
            <asp:GridView runat="server" ID="gvShippedToday" AutoGenerateColumns="False" DataSourceID="sdsHelmsShipped" Caption="Shipped Today">
                <Columns>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo"></asp:BoundField>
                    <asp:BoundField DataField="HelmShip" HeaderText="Scanned" SortExpression="HelmShip"></asp:BoundField>        
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="sdsHelmsShipped" ConnectionString='<%$ ConnectionStrings:bml_dataConnectionString %>' SelectCommand="SELECT [ProdNo],[ItemNo], [HelmShip], [HelmShipStatus] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([HelmShipStatus] = 2) and Convert(date,HelmShip) = convert(date,getDate()) ORDER BY [HelmShip]">               
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
