<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InventoryTracking.aspx.vb" Inherits="Barcode_InventoryTracking" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Tracking</title>
    <style>
        #barcodescanner {
        font-family:Calbri;
        font-size:70px;
        width:1000px;
        text-align:center;        
        }
        .barcode {
        font-family:Calbri;
        font-size:40px;        
        text-align:center; 
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <div id="barcodescanner">
        <asp:Label ID="Label3" class="barcode" runat="server" Text="Inventory Tracking "></asp:Label>                      
        <br />
        &nbsp;&nbsp;<br />
        <asp:TextBox ID="tbArea" runat="server" Font-Size="60px" Height="144px" Width="463px" style="text-align: center"></asp:TextBox>
        &nbsp;
        <asp:Button ID="btnClear" runat="server" Font-Size="30px" Height="90px" style="margin-top: 0px" Text="X" Width="92px" />
        <br />
        <asp:Label ID="lbl1" class="barcode" runat="server" Text="Area: "></asp:Label><asp:Label ID="lblArea" class="barcode" runat="server" Text=""></asp:Label>
        <asp:Label ID="lbl2" class="barcode" runat="server" Text="Current Status: "></asp:Label><asp:Label ID="lblCurrentStatus"  class="barcode" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <asp:Button ID="btnRunReport" runat="server" Text="Run Report" Height="159px" Width="378px" Font-Size="30pt" BackColor="Yellow" />     
        <br />
        <br />
        <asp:Button ID="btnErrors" runat="server" Text="Errors" Height="159px" Width="378px" Font-Size="30pt" BackColor="Red" />     
        <br />
        <br />     
        <asp:Button ID="btnComplete" runat="server" Text="Complete" Height="159px" Width="379px" Font-Size="30pt" BackColor="#009900"/>
        <br />
    </div>
    </form>
</body>
</html>