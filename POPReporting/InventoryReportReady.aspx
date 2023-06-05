<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InventoryReportReady.aspx.vb" Inherits="InventoryReportReady" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Reports Ready</title>
</head>
<body>
    <form id="form1" runat="server">
    <div><h3><asp:Label ID="Label1" runat="server" Text="PHYSICAL INVENTORY REPORTS READY"></asp:Label>&nbsp;- Joel Click&#39;s Off After His Review - Signaling Request For Final Signature</h3> 
        <asp:Button runat="server" ID="btnRefresh" Text="Refresh" />
        <asp:GridView ID="gvAreas" runat="server" SqlDataSource="sdsInventoryAreas" AutoGenerateColumns="False" DataSourceID="sdsInventoryAreas" Width="432px" ShowEditButton="True" >
            <Columns>
                <asp:BoundField DataField="Area" HeaderText="Area" />                

                <asp:TemplateField HeaderText="Errors?">
                    <ItemTemplate>
                         <asp:Button ID="btnErrors" runat="server" Text="Errors Found"  CommandArgument="<%# Container.DataItemIndex %>" CommandName="updatestatustoerrors" Height="82px" Width="145px"/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Ready For Signature">
                    <ItemTemplate>
                         <asp:Button ID="btnSave" runat="server" Text="Ready For Signature"  CommandArgument="<%# Container.DataItemIndex %>" CommandName="updatestatus" Height="82px" Width="145px"/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
            <RowStyle Font-Names="Calibri" Font-Size="16pt" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsInventoryAreas" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT Area, Status FROM Inventory Where Status = 6 or Status = 7 order by Cast(Area as int) ">  
                   
        </asp:SqlDataSource>                  
  
    </div>
    </form>
</body>
</html>
