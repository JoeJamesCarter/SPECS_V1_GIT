<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddAGate.aspx.vb" Inherits="Gates_AddAGate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ADD A GATE TO INVENTORY</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <span class="newStyle7">ADD A GATE</span><br />
        <asp:Label ID="Label1" runat="server" Text="Model"></asp:Label>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<asp:TextBox ID="tbModel" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Gate"></asp:Label>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<asp:DropDownList ID="ddlGate" runat="server">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem Value="BowCtr">Bow Ctr</asp:ListItem>
            <asp:ListItem Value="Port">Port</asp:ListItem>
            <asp:ListItem Value="Strb">Strb</asp:ListItem>
            <asp:ListItem Value="AftPort">Aft Port</asp:ListItem>
            <asp:ListItem Value ="AftCtr">Aft Ctr</asp:ListItem>
            <asp:ListItem Value ="AftStrb">Aft Strb</asp:ListItem>
            <asp:ListItem>T</asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="Color:"></asp:Label><asp:RadioButtonList ID="rblColor" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem>Clear</asp:ListItem>
            <asp:ListItem>Blackout</asp:ListItem>
        </asp:RadioButtonList>
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
