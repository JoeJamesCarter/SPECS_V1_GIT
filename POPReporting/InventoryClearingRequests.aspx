<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InventoryClearingRequests.aspx.vb" Inherits="InventoryClearingRequests" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Clearing Requests</title>
</head>
<body>
    <form id="form1" runat="server">
    <div><h3><asp:Label ID="Label1" runat="server" Text="PHYSICAL INVENTORY CLEARING REQUESTS"></asp:Label></h3><asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True">
        <asp:ListItem Value="1">Hide Requested</asp:ListItem>
        <asp:ListItem Value="2">Show All</asp:ListItem>       
        <asp:ListItem></asp:ListItem>
        </asp:DropDownList> 
        <asp:GridView ID="gvAreas" runat="server" SqlDataSource="sdsInventoryAreas" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="sdsInventoryAreas" ForeColor="Black" GridLines="Vertical" Width="525px" ShowEditButton="True" >
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="Area" HeaderText="Area" />
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal" Width="770px"  SelectedValue='<%# Bind("Status")%>' >
                            <asp:ListItem Value="0">Not Started</asp:ListItem>                           
                            <asp:ListItem Value="1">Clearing Requested</asp:ListItem>                            
                        </asp:RadioButtonList>                       
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Update">
                    <ItemTemplate>
                         <asp:Button ID="btnSave" runat="server" Text="Update"  CommandArgument="<%# Container.DataItemIndex %>" CommandName="updatestatus"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <RowStyle Font-Names="Calibri" Font-Size="16pt" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsInventoryAreas" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT Area, Status FROM Inventory Where Status &lt; @Status order by Cast(Area as int) ">  
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlStatus" Name="Status" PropertyName="SelectedValue" Type="Int32" DefaultValue="1" />
            </SelectParameters>         
        </asp:SqlDataSource>                  
  
    </div>
    </form>
</body>
</html>
