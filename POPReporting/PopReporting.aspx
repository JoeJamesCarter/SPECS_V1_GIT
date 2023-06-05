<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PopReporting.aspx.vb" Inherits="PopReporting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style2 {
            font-size: medium;
        }
        .newStyle1 {
            color: #FFFFFF;
        }
        .newStyle2 {
            color: #000000;
        }
        .auto-style5 {
            text-align: left;
        }
        .auto-style6 {
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class="auto-style6">
        <h2>GREEN LIGHT REPORTING</h2>
        </div>
        <div class="auto-style5">
            <br />
            <span class="auto-style2">Select Your Workstation:</span>&nbsp;
        </div>
        <div>
            <asp:DropDownList ID="ddlWorkstations" runat="server" AutoPostBack="True">
                <asp:ListItem>Choose a Workstation</asp:ListItem>
                <asp:ListItem Value = "Covers">Covers</asp:ListItem>
                <asp:ListItem Value = "Fiberglass">Fiberglass</asp:ListItem>
                <asp:ListItem Value = "Furniture">Furniture</asp:ListItem>               
                <asp:ListItem Value = "Rails">Rails</asp:ListItem>
                <asp:ListItem Value = "Tubes">Tubes</asp:ListItem>                              
            </asp:DropDownList>
        </div>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" DataSourceID="sdsProdNoSelected" ForeColor="Black" Width="979px" DataKeyNames="user_def_fld_1">
            <Columns>
                <asp:BoundField DataField="user_def_fld_1" HeaderText="Prod #" SortExpression="user_def_fld_1" />
                <asp:BoundField DataField="item_no" HeaderText="Item #" SortExpression="item_no" />
                <asp:BoundField DataField="item_desc_1" HeaderText="Description" SortExpression="item_desc_1" />
                <asp:BoundField DataField="user_def_fld_5" HeaderText="Prod Notes" SortExpression="user_def_fld_5" />
                <asp:BoundField DataField="due_dt" HeaderText="Build Date" SortExpression="due_dt" />
                <asp:BoundField DataField="ord_no" HeaderText="Order #" SortExpression="ord_no" />
                <asp:BoundField DataField="src_ord_no" HeaderText="SO #" SortExpression="src_ord_no" />
                <asp:BoundField DataField="cus_name" HeaderText="Customer" SortExpression="cus_name" />
                <asp:ButtonField ButtonType="Button" CommandName="UpdateTubes" HeaderText="Tubes" ShowHeader="True" Text="Tubes Ready" />
                <asp:ButtonField ButtonType="Button" CommandName="UpdateRails" HeaderText="Rails" ShowHeader="True" Text="Rails Ready" />
                <asp:ButtonField ButtonType="Button" CommandName="UpdateCovers" HeaderText="Covers" ShowHeader="True" Text="Covers Ready" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsProdNoSelected" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [ord_no], [item_no], [item_desc_1], [due_dt], [src_ord_no], [user_def_fld_1], [user_def_fld_5], [cus_name] FROM [PPORDFIL_SQL] WHERE (([user_def_fld_1] IS NOT NULL) AND ([ord_status] &lt;&gt; @ord_status) AND ([last_trx_dt] = @last_trx_dt))">
            <SelectParameters>
                <asp:Parameter DefaultValue="C" Name="ord_status" Type="String" />
                <asp:Parameter DefaultValue="0" Name="last_trx_dt" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsPPORDFIL" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_no], [item_desc_1], [user_def_fld_5], [user_def_fld_1], [ord_no], [cus_name], [src_ord_no], [due_dt] FROM [PPORDFIL_SQL] WHERE (([last_trx_dt] = @last_trx_dt) AND ([user_def_fld_1] IS NOT NULL) AND ([ord_status] &lt;&gt; @ord_status)) ORDER BY [user_def_fld_1]">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="last_trx_dt" Type="Int32" />
                <asp:Parameter DefaultValue="C" Name="ord_status" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
   
        <asp:Label ID="lblFurnitureStatus" runat="server" Text="How Much Furniture Is Here?" Visible="False"></asp:Label>
        <asp:RadioButtonList ID="rblFurnitureStatus" runat="server" Visible="False">
            <asp:ListItem Value="0">None</asp:ListItem>
            <asp:ListItem Value="1">Some</asp:ListItem>
            <asp:ListItem Value="2">All</asp:ListItem>
        </asp:RadioButtonList>
        <asp:Button ID="btnUpdateFurnitureStatus" runat="server" Text="Update" Visible="False" />
        <br />
        <asp:Label ID="lblFiberglassStatus" runat="server" Text="How Much Fiberglass Is Here?" Visible="False"></asp:Label>
        <asp:RadioButtonList ID="rblFiberglassStatus" runat="server" Visible="False">
            <asp:ListItem Value="0">None</asp:ListItem>
            <asp:ListItem Value="1">Some</asp:ListItem>
            <asp:ListItem Value="2">All</asp:ListItem>
        </asp:RadioButtonList>
        <asp:Button ID="btnUpdateFiberglassStatus" runat="server" Text="Update" Visible="False" />
    
        <br />
    
        <asp:Button ID="btnTubesReady" runat="server" Text="Tubes Ready" Visible="False" />
        <asp:Button ID="btnRailsReady" runat="server" Text="Rails Ready" Visible="False" />
        <asp:Button ID="btnCoversReady" runat="server" Text="Covers Ready" Visible="False" />
        <br />
        <br />
        </div>
    </form>
</body>
</html>
