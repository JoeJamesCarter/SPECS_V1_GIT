<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Plan.aspx.vb" Inherits="ProdPlans_Plan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Prod Plan By Calendar Year</title>
     <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Calendar Year: "></asp:Label><asp:DropDownList ID="ddlCalYear" runat="server">
                <asp:ListItem>2020</asp:ListItem>                
            </asp:DropDownList>
        </div>
        <div id="Jan">
           
            <asp:DataList ID="January" runat="server" RepeatColumns="7" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" CellPadding="6">
                <ItemTemplate>
                    <asp:Label ID="lblDay" runat="server" Text="test"></asp:Label>
                </ItemTemplate>
            </asp:DataList>

        </div>
        <div id="Feb">

        </div>
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
    </form>
</body>
</html>
