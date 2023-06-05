<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InventoryTracking.aspx.vb" Inherits="InventoryTracking" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Tracking</title>
</head>
<body>
    <form id="form1" runat="server">
    <div><h3><asp:Label ID="Label1" runat="server" Text="PHYSICAL INVENTORY WHITEBOARD CONTROL"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
        </h3><asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True" Visible="True">
       <asp:ListItem Value="0">Not Started</asp:ListItem>
                            <asp:ListItem Value="1">Clearing Requested</asp:ListItem>
                            <asp:ListItem Value="2">Cleared</asp:ListItem>
                            <asp:ListItem Value="3">CallAcct</asp:ListItem>
                            <asp:ListItem Value="4">Keyed</asp:ListItem>
                            <asp:ListItem Value="5">Review 1</asp:ListItem>
                            <asp:ListItem Value="6">Review 2</asp:ListItem>                            
                            <asp:ListItem Value="7">Errors</asp:ListItem>
                            <asp:ListItem Value="8">Report Ready</asp:ListItem>                            
                            <asp:ListItem Value="9">Complete</asp:ListItem>   
        <asp:ListItem></asp:ListItem>            
        </asp:DropDownList> 
        <br />
        <asp:GridView ID="gvAreas" runat="server" SqlDataSource="sdsInventoryAreas" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="sdsInventoryAreas" ForeColor="Black" GridLines="Vertical" Width="1336px" ShowEditButton="True" >
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="Area" HeaderText="Area" />
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal" Width="1135px"  SelectedValue='<%# Bind("Status")%>' >
                            <asp:ListItem Value="0">Not Started</asp:ListItem>
                            <asp:ListItem Value="1">Clearing Requested</asp:ListItem>
                            <asp:ListItem Value="2">Cleared</asp:ListItem>
                            <asp:ListItem Value="3">CallAcct</asp:ListItem>
                            <asp:ListItem Value="4">Keyed</asp:ListItem>
                            <asp:ListItem Value="5">Review 1</asp:ListItem>
                            <asp:ListItem Value="6">Review 2</asp:ListItem>                            
                            <asp:ListItem Value="7">Errors</asp:ListItem>
                            <asp:ListItem Value="8">Report Ready</asp:ListItem>                            
                            <asp:ListItem Value="9">Complete</asp:ListItem>
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
        <asp:SqlDataSource ID="sdsInventoryAreas" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT Area, Status FROM Inventory Where Status = @Status order by Cast(Area as int) ">  
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlStatus" Name="Status" PropertyName="SelectedValue" Type="Int32"/>
        </SelectParameters>
        </asp:SqlDataSource>                  
  
    </div>
    </form>
</body>
</html>
