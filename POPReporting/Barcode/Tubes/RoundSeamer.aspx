<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RoundSeamer.aspx.vb" Inherits="Barcode_Tubes_RoundSeamer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Round Seamer</title>
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
        <asp:Label ID="Label3" runat="server" Text="ROUND SEAMER: "></asp:Label>
        <asp:Label ID="Label1" runat="server" Text="ROUND SEAMER" Font-Size="40px"></asp:Label> <br />
               
        <br />
        <br />
        &nbsp;&nbsp;<br />
        <asp:TextBox ID="tbProd" runat="server" Font-Size="60px" Height="144px" Width="463px" style="text-align: center"></asp:TextBox>
        &nbsp;
        <asp:Button ID="btnClear" runat="server" Font-Size="30px" Height="90px" style="margin-top: 0px" Text="X" Width="92px" />
        <br />
        <asp:Label ID="Label2" runat="server" Text="Last Transaction:"></asp:Label>
        <br />
        <asp:Label ID="lblLast" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btnInProgress" runat="server" Text="In Progress" Height="159px" Width="378px" Font-Size="30pt" BackColor="Yellow" Visible="False" />
     
        <br />
     
        <asp:Button ID="btnComplete" runat="server" Text="Complete" Height="159px" Width="379px" Font-Size="30pt" BackColor="#009900" Visible="False" />
        <br />
    </div>
    </form>
</body>
</html>
