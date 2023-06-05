<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SeamerSelect.aspx.vb" Inherits="Barcode_StationSelection_SeamerSelect" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Select Your Workstation
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" PostBackUrl="http://seamer1:Chicago1@specs1/Live/PopReporting/Barcode/Tubes/Seamer.aspx" Text="1" />
            <br />
            <br />
            <asp:Button ID="Button2" runat="server" PostBackUrl="http://seamer2:Chicago1@specs1/Live/PopReporting/Barcode/Tubes/Seamer.aspx" Text="2" />
            <br />
            <br />
            <asp:Button ID="Button3" runat="server" PostBackUrl="http://seamer3:Chicago1@specs1/Live/PopReporting/Barcode/Tubes/Seamer.aspx" Text="3" />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
