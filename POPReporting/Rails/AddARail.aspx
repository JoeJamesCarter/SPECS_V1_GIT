<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddARail.aspx.vb" Inherits="Rails_AddARail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ADD A RAIL TO INVENTORY</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <span class="newStyle7">ADD A RAIL</span><br />
        <asp:Label ID="Label1" runat="server" Text="Model"></asp:Label>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<asp:TextBox ID="tbModel" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Rail"></asp:Label>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<asp:DropDownList ID="ddlRail" runat="server">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>PF</asp:ListItem>
            <asp:ListItem>SF</asp:ListItem>
            <asp:ListItem>PR</asp:ListItem>
            <asp:ListItem>SR</asp:ListItem>
            <asp:ListItem>PM</asp:ListItem>
            <asp:ListItem>SM</asp:ListItem>
            <asp:ListItem>T</asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="Color:"></asp:Label><asp:RadioButtonList ID="rblColor" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem>Clear</asp:ListItem>
            <asp:ListItem>Blackout</asp:ListItem>
        </asp:RadioButtonList>
        <br />
        <asp:Label ID="Label6" runat="server" Text="Power Top"></asp:Label><asp:CheckBox ID="cbPT" runat="server" />
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="Custom"></asp:Label><asp:CheckBox ID="cbCustom" runat="server" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label2" runat="server" Text="Custom Drawing #"></asp:Label>:&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="tbCusDrawNo" runat="server"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Button ID="btnSave" runat="server" Text="SAVE" />
    </div>
    </form>
</body>
</html>
