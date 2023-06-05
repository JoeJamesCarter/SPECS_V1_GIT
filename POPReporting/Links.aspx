<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Links.aspx.vb" Inherits="Links" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Links for All Users</title>
    <style type="text/css">
        .auto-style1 {            
            font-family:Calibri;
            font-size:16px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <asp:GridView ID="gvGreenLights" DataSourceID="sdsGreenlightLinks" CssClass="auto-style1" runat="server" Caption="SPECS Links" AutoGenerateColumns="False" Width="100%" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Page" >
                <ItemStyle Width="275px" />
                </asp:BoundField>
                <asp:BoundField DataField="Category" HeaderText="Category" >
                <ItemStyle Width="100px" />
                </asp:BoundField>
                <asp:HyperLinkField HeaderText="Link" Target="_blank" Text="Link" DataNavigateUrlFields="URL" DataTextField="URL" >
                <ItemStyle Width="300px" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="Description" HeaderText="Description" >
                <ItemStyle Width="300px" />
                </asp:BoundField>
                <asp:BoundField DataField="AccessLevel" HeaderText="Access Level" >
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
            </Columns>
             <FooterStyle BackColor="#CCCCCC" />
             <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
             <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
             <RowStyle BackColor="White" />
             <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
             <SortedAscendingCellStyle BackColor="#F1F1F1" />
             <SortedAscendingHeaderStyle BackColor="#808080" />
             <SortedDescendingCellStyle BackColor="#CAC9C9" />
             <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsGreenlightLinks" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Name],[Category],[Description], [AccessLevel],[URL] FROM [Links] Where (Category <> 'Scheduling' and Category <> 'Rails Cut Sheets') Order By Category, Name">
                            <SelectParameters>                                
                                <asp:Parameter DefaultValue="Greenlights" Name="Category" Type="String" />
                            </SelectParameters>
                </asp:SqlDataSource>                        
    </form>
</body>
</html>
