<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AttachForms.aspx.vb" Inherits="Warranty_AttachForms" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attach Forms</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="Label">Attach a PDF of the Initial and Final Inspection Sheets.</asp:Label>
        <asp:FileUpload ID="FileUpload1" runat="server" Width="243px" />
    &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnUpload" runat="server" Text="Upload" />
    </div>
    </form>
</body>
</html>
