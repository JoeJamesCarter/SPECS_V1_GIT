<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RedTagRGAStatusUpdate.aspx.vb" Inherits="Workstations_RedTagRGAStatusUpdate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script>
        function RefreshParent() {
            window.opener.document.getElementById('btnRefresh').click();
            window.close();
        }
        window.onbeforeunload = RefreshParent
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="lblAutoID" runat="server" Text="Label" Visible="False"></asp:Label>
        <br />
        <h2><strong>RGA Item Status Update</strong></h2>
        <br />
        <asp:Label ID="lblRGAPart" runat="server" Text="Label" Width="500px" Font-Bold="True" Font-Size="14pt" ForeColor="#FF3300"></asp:Label>
        <br />
        <br />
        <strong>RGA Line Status</strong><br />
        <asp:RadioButtonList ID="rblStatus" runat="server">
            <asp:ListItem Value="0">None</asp:ListItem>
            <asp:ListItem Value="1">Installed</asp:ListItem>
            <asp:ListItem Value="2">Needs Shipped</asp:ListItem>
            <asp:ListItem Value="3">Missing</asp:ListItem>
        </asp:RadioButtonList>
        <strong>
        <br />
        Notes:</strong>
        <asp:TextBox ID="tbNote" runat="server" Height="103px" TextMode="MultiLine" Width="370px"></asp:TextBox>
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;ie. If the part got put in a different boat on the load etc.<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dealer may see what goes in this box.<br />
        <br />
        <strong>Updated By:&nbsp;&nbsp;&nbsp;&nbsp; </strong>
        <asp:TextBox ID="tbUpdatedBy" runat="server"></asp:TextBox>
&nbsp;first intial, last name<br />
        <br />
        <strong>Last Updated: </strong>&nbsp;<asp:TextBox ID="tbLastUpdated" runat="server" ReadOnly="True" Enabled="False"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnSave" runat="server" Text="Save" />
    
    </div>
    </form>
</body>
</html>
