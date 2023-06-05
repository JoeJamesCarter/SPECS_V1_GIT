<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureLocationsByBoat.aspx.vb" Inherits="FurnitureLocationsByBoat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture Rack Locations</title>
    <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <asp:GridView ID="gvBoats" runat="server" DataSourceID="sdsBoatswLocs" CssClass="newStyle3" ForeColor="Black" DataKeyNames="ProdNo" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="BOAT" >
                <ItemStyle Width="50px" Font-Bold="True" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="RACKS">
                    <ItemTemplate>
                      
                        <asp:SqlDataSource ID="sdsRacks" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Slot, LocKey FROM [Material_Locations] WHERE (([ProdNo] = @ProdNo) AND ([InUse] = 1)) Order By Rack, Slot">
                             <SelectParameters>
                                      <asp:Parameter Name="ProdNo" Type="String" />                                     
                                 </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:DataList ID="dlLocs" runat="server" DataSourceID="sdsRacks" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="0">
                            <ItemTemplate>
                                <asp:Label ID="lblKey" runat="server" Text='<%# Eval("LocKey")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:DataList>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

        </asp:GridView>
        <asp:SqlDataSource ID="sdsBoatswLocs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct(ProdNo) FROM [Material_Locations] WHERE (([Usable] =1) AND ([InUse] = 1)) Order By ProdNo">                                
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
