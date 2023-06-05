<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MaterialLabel.aspx.vb" Inherits="Materials_MaterialLabel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #label {
            width:1000px;
            text-align:center;
        }
        .Header {
            font-family:Calibri;
            font-size:20px;
            font-weight:bold;
            Width:50%;            
        }
        .Component {
            font-family:Calibri;
            font-size:20px;                      
            Width:50%;
        }
       
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="label">

        <asp:Table ID="Table1" runat="server" Width="900px" GridLines="Both">

            <asp:TableRow >
                <asp:TableCell cssClass="Header">
                    Part #
                </asp:TableCell>
                <asp:TableCell cssClass="Header" >
                    Description
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell>
<asp:Label ID="lblItemNo" cssClass="Component" runat="server" Text=""></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
<asp:Label ID="lblItemDesc1"  cssClass="Component" runat="server" Text=""></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell cssClass="Header">Vendor Part #</asp:TableCell>
                <asp:TableCell cssClass="Header">Qty</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell>
<asp:Label ID="lblItemDesc2"  cssClass="Component" runat="server" Text=""></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
 <asp:Label ID="lblQty"  cssClass="Component" runat="server" Text=""></asp:Label>
                </asp:TableCell>
            </asp:TableRow>

            
        </asp:Table>

        <br />
        <br />
        <br />

        <asp:Button ID="btnPrint" runat="server" Text="Print" />
     
    </div>
    </form>
</body>
</html>
