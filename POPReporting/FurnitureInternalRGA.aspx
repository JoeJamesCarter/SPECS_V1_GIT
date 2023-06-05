<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureInternalRGA.aspx.vb" Inherits="FurnitureInternalRGA" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add An Internal RGA</title>
    <style>
        .title {
            font-family: Calibri;
            font-size: 20px;
        }

        .fields {
            font-family: Calibri;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label9" runat="server" CssClass="title" Text="Add an Internal RGA"></asp:Label><br />
            <br />
            <asp:Label ID="Label1" CssClass="fields" runat="server" Text="Prod #:" Width="100px"></asp:Label><asp:TextBox ID="tbProdNo" runat="server" Enabled="false"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" CssClass="fields" runat="server" Text="Model:" Width="100px"></asp:Label><asp:TextBox ID="tbModel" runat="server" Width="243px" Enabled="false"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" CssClass="fields" runat="server" Text="Part:" Width="100px"></asp:Label><asp:TextBox ID="tbPart" runat="server" Width="431px"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" CssClass="fields" runat="server" Text="Color:" Width="100px"></asp:Label><asp:TextBox ID="tbColor" runat="server" Width="429px"></asp:TextBox>
            <br />
            <asp:Label ID="Label6" CssClass="fields" runat="server" Text="Qty:" Width="100px"></asp:Label><asp:TextBox ID="tbQty" runat="server" Width="30px"></asp:TextBox>
            <br />
            <asp:Label ID="Label5" CssClass="fields" runat="server" Text="RGA Reason:" Width="100px"></asp:Label><asp:TextBox ID="tbReason" runat="server" Width="429px"></asp:TextBox>
            <br />
            <asp:Label ID="Label7" CssClass="fields" runat="server" Text="Damaged By:" Width="100px"></asp:Label><asp:DropDownList ID="ddlWho" runat="server" Height="16px" Width="122px">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem>Benni</asp:ListItem>
                <asp:ListItem>Veada</asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:Label ID="Label8" CssClass="fields" runat="server" Text="Boat Status" Width="100px"></asp:Label><asp:DropDownList ID="ddlStatus" runat="server" Height="16px" Width="122px">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem>ONLINE</asp:ListItem>
                <asp:ListItem>OFFLINE</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="btnSave" runat="server" Text="Add Internal RGA" />
        </div>
    </form>
</body>
</html>
