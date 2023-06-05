<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ProdPics.aspx.vb" Inherits="ProdPics" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Production Pictures on the Web</title>
    <style>
        .Thumbs {
            height:600px;
            width:800px;
            padding:10px;
        }
         .Full {
            height:600px;
            width:800px;
        }
        .InputBox {
            font-family:Calibri;
            font-size:50px;

        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" CssClass="InputBox" runat="server" Text="Full Prod #:"></asp:Label><asp:TextBox ID="tbProdNo" CssClass="InputBox" runat="server"></asp:TextBox>
        <asp:Button ID="btnRetreive" CssClass="InputBox" runat="server" Text="Retreive Photos" /><br />
        <asp:Image ID="Image1" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image2" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image3" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image4" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image5" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image6" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image7" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image8" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image9" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image10" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image11" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image12" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image13" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image14" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image15" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image16" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image17" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image18" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image19" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image20" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image21" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image22" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image23" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image24" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image25" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image26" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image27" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image28" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image29" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image30" CssClass="Thumbs" runat="server" />

        
        
    </div>
    </form>
</body>
</html>
