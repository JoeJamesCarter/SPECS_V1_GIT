<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Kitting3.aspx.vb" Inherits="Barcode_Kitting3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Kitting 3</title>
    <style>
        #barcodescanner {
        font-family:Calbri;
        font-size:70px;
        width:1000px;
        text-align:center;        
        }

    </style>

</head>
<body>
    <form id="form1" runat="server">
    <div id="barcodescanner">
        <asp:Label ID="Label1" runat="server" Text="Kitting 3" Font-Size="40px"></asp:Label> <br />
               
        <br />
        <br />
        &nbsp;&nbsp;<br />
        <asp:TextBox ID="tbProd" runat="server" Font-Size="60px" Height="144px" Width="463px" style="text-align: center"></asp:TextBox>
        &nbsp;
        <asp:Button ID="btnClear" runat="server" Font-Size="30px" Height="90px" style="margin-top: 0px" Text="X" Width="92px" />
        <br />
    &nbsp;
        <br />       
        <asp:Button ID="Button1" runat="server" Text="KITTED" Height="159px" Width="654px" Font-Size="30pt" />
        <br />
    </div>
    </form>
</body>
</html>


