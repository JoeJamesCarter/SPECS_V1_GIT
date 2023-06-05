<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RigABoatICantSee.aspx.vb" Inherits="Workstations_RigABoatICantSee" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rig a Boat I Can't See</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="This page is to be used when you need to mark rigging as complete and you can't see the boat in your list because it was invoiced early." CssClass="newStyle6"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" CssClass="newStyle4" Text="Enter Full Prod # with the Year: (ie. 1900001)"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbProdNo" runat="server" Height="38px" Width="139px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnRigged" runat="server" CssClass="newStyle6" Text="Mark As Rigged" />
    </div>
    </form>
</body>
</html>
