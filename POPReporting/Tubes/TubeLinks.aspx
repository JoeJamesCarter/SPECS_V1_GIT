<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TubeLinks.aspx.vb" Inherits="Tubes_TubeLinks" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SPECS Tube Links</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Image ID="Image1" runat="server" ImageUrl="../Images/logo-small.png" />
        &nbsp;<br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="Tube Scheduling Tools" CssClass="newStyle4"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Live/PopReporting/Tubes/TubeScheduling.aspx" Target="_blank">Scheduling with Drag/Drop</asp:HyperLink>
      
    </div>
    </form>
</body>
</html>
