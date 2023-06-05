<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CoversRGAs.aspx.vb" Inherits="CoversRGAs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CANVAS RGA's</title>
    <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Canvas RGA's" CssClass="newStyle7"></asp:Label>
            <br />
            <br />
             <asp:Label ID="Label4" runat="server" Text="Open Canvas RGA Items" CssClass="newStyle4"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnSelectAll" runat="server" Text="Select All" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="bntCreatePrint" runat="server" Text="Create RGA From Selected Items " /><br />
            <br />
            <asp:GridView ID="gvOpenRGAItems" runat="server" AutoGenerateColumns="False" DataKeyNames="AutoID" DataSourceID="sdsOpenCanvasRGAItems" CssClass="newStyle1" Width="1198px">
                <Columns>
                    <asp:TemplateField HeaderText="Select">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbSelect" runat="server" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" />
                    <asp:BoundField DataField="DateAdded" HeaderText="Date Added" SortExpression="DateAdded" />
                    <asp:BoundField DataField="AutoID" HeaderText="Item ID" InsertVisible="False" ReadOnly="True" SortExpression="AutoID" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsOpenCanvasRGAItems" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [CanvasRGAs] WHERE ([RGANo] IS NULL) ORDER BY [ProdNo]"></asp:SqlDataSource>
            <br />
              <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Open Canvas RGA's" CssClass="newStyle4"></asp:Label>
            <br />
            <br />
            <asp:GridView ID="gvOpenRGAs" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="AutoID" DataSourceID="sdsOpenRGAs" Width="1195px">
                <Columns>
                    <asp:BoundField DataField="RGANo" HeaderText="RGA #" SortExpression="RGANo" />
                    <asp:BoundField DataField="RGAGenDate" HeaderText="RGA Generated" SortExpression="RGAGenDate" />
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" />
                    <asp:BoundField DataField="DateAdded" HeaderText="Date Added" SortExpression="DateAdded" />
                      <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Canvas Status">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:ImageField>                   
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsOpenRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT *, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.CoversLastUpdated FROM [CanvasRGAs] Left Join BML_POPREPORTING_GREENLIGHTS On CanvasRGAs.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([RGANo] IS NOT NULL) AND CoversStatus <> 2"></asp:SqlDataSource>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Canvas RGA History" CssClass="newStyle4"></asp:Label>
            <br />
            <br />
            <asp:GridView ID="gvCanvasRGAHistory" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="AutoID" DataSourceID="sdsCanvasRGAHistory" Width="1403px">
                <Columns>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" />
                    <asp:BoundField DataField="DateAdded" HeaderText="Date Added" SortExpression="DateAdded" />
                    <asp:BoundField DataField="RGANo" HeaderText="RGA #" SortExpression="RGANo" />
                    <asp:BoundField DataField="RGAGenDate" HeaderText="RGA Generated" SortExpression="RGAGenDate" />                    
                    <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Canvas Status">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:ImageField>                   
                    <asp:BoundField DataField="CoversLastUpdated" HeaderText="Canvas Received" SortExpression="CoversLastUpdated" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsCanvasRGAHistory" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT *, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.CoversLastUpdated FROM [CanvasRGAs] Left Join BML_POPREPORTING_GREENLIGHTS On CanvasRGAs.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([RGANo] IS NOT NULL) AND CoversStatus = 2 ORDER BY [RGANo]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
