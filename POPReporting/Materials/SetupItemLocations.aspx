<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SetupItemLocations.aspx.vb" Inherits="Materials_SetupItemLocations" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SETUP ITEM LOCATIONS</title>
     <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label3" runat="server" CssClass="newStyle7" Text="Setup Locations for Parts"></asp:Label></br></br>
        <asp:Label ID="Label1" runat="server" CssClass="newStyle7"  Text="Ben #" Width="150px"></asp:Label><asp:TextBox ID="tbBenPartNo" CssClass="newStyle7" runat="server" AutoPostBack="True" Height="145px" Width="668px"></asp:TextBox><br /><br />
        <asp:Label ID="Label2" runat="server" CssClass="newStyle7"  Text="Location" Width="150px"></asp:Label><asp:TextBox ID="tbLoc" CssClass="newStyle7" runat="server" Height="140px" Width="674px"></asp:TextBox><br /><br />

        <asp:DetailsView ID="DetailsView1" CssClass="newStyle7" runat="server" AutoGenerateRows="False" DataKeyNames="Item_No" DataSourceID="sdsPartsLocs" Height="50px" Width="950px">
            <Fields>
                <asp:BoundField DataField="Item_No" HeaderText="Ben Part #" ReadOnly="True" SortExpression="Item_No" />
                <asp:BoundField DataField="Desc1" HeaderText="Desc1" SortExpression="Desc1" />
                <asp:BoundField DataField="Desc2" HeaderText="Desc2" SortExpression="Desc2" />
                <asp:BoundField DataField="Loc1" HeaderText="Loc1" SortExpression="Loc1" />
                <asp:BoundField DataField="Loc2" HeaderText="Loc2" SortExpression="Loc2" />
                <asp:BoundField DataField="Loc3" HeaderText="Loc3" SortExpression="Loc3" />
                <asp:BoundField DataField="Loc4" HeaderText="Loc4" SortExpression="Loc4" />
            </Fields>
        </asp:DetailsView></br></br></br>
        <asp:Button ID="btnClear" CssClass="newStyle7" runat="server" Text="Clear" Height="105px" Width="950px" /><br /><br /></br></br></br>
        <asp:SqlDataSource ID="sdsPartsLocs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [LocationsByPart] WHERE ([Item_No] = @Item_No)">
            <SelectParameters>
                <asp:ControlParameter ControlID="tbBenPartNo" Name="Item_No" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="btnSave" CssClass="newStyle7" runat="server" Text="Save" Height="107px" Width="950px" />
    </div>
    </form>
</body>
</html>
