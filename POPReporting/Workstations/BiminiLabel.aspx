<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BiminiLabel.aspx.vb" Inherits="Workstations_BiminiLabel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style>
        #biminilabel {
            width:800px;
            text-align:center;
        }
        .ProdNo {
            font-family:Calibri;
            font-size:150px;
            font-weight:bold;            
        }
        .Model {
            font-family:Calibri;
            font-size:100px;
            font-weight:bold;            
        }
        .CusName {
            font-family:Calibri;
            font-size:50px;
            font-weight:bold;            
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="biminilabel">
        <asp:Label ID="lblProdNo" cssClass="ProdNo" runat="server" Text=""></asp:Label><asp:Label ID="lblBO" cssClass="CusName" runat="server" Text=""></asp:Label>
        <br />
        <asp:Label ID="lblModel" cssClass="Model" runat="server" Text=""></asp:Label>
        <br />
        <asp:Label ID="lblCusName" cssClass="CusName" runat="server" Text=""></asp:Label>
         <br /> 
        <asp:Label ID="lblSerial" cssClass="CusName" runat="server" Text=""></asp:Label>        
        
    </div>
    </form>
</body>
</html>
