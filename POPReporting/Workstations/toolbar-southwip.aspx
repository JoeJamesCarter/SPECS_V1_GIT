<head>
    <style type="text/css">
        .auto-style1 {
        }
    </style>
</head>
<script runat="server">

    Protected Sub btnClear_Click(sender As Object, e As EventArgs)
        tbSearch.Text = ""
    End Sub

    Protected Sub btbClear2_Click(sender As Object, e As EventArgs)
        tbSearchBoat.Text = ""
    End Sub




</script>
<div>
    <asp:table id="Table1" runat="server" cssclass="auto-style1" width="1042px" gridlines="None">
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" HorizontalAlign="center">
            </asp:TableCell>
            <asp:TableCell runat="server">
                <span class="newStyle3">Days In Advance To Show&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddlDaysInAdvance" runat="server" AutoPostBack="True">
                </asp:DropDownList></span>
            </asp:TableCell>
            <asp:TableCell>
             <span class="newStyle3">Search By Prod #&nbsp;&nbsp;</span><asp:textbox runat="server" id="tbSearch"></asp:textbox>
    <asp:button runat="server" text="Clear" id="btnClear" onclick="btnClear_Click" /></span>
              </asp:TableCell>
            <asp:TableCell>
                <%--<span class="newStyle3">Prod Line</span>--%>
            </asp:TableCell>
            <asp:TableCell rowspan="2">
             <asp:Image runat="server" img src="../Images/logo-small.png" /></asp:Image>
              </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell HorizontalAlign="center">
                <asp:Label ID="lblSouthDecks" runat="server" CssClass="newStyle4" Text="Label"></asp:Label>
                <span class="newStyle3">&nbsp;In Progress</span><br />
                <asp:Label ID="lblReady" runat="server" CssClass="newStyle4" Text="Label"></asp:Label>
                <span class="newStyle3">&nbsp;Ready&nbsp;</span><asp:Label ID="lblIO" runat="server" CssClass="newStyle4" Text="Label"></asp:Label>
                <span class="newStyle3">-IO &&nbsp;</span><asp:Label ID="lblQX" runat="server" CssClass="newStyle4" Text="Label"></asp:Label>
                <span class="newStyle3">-QX</span>
            </asp:TableCell>
            <asp:TableCell>
                <span class="newStyle3">Select Which Prod #&#39;s to Show&nbsp;
            <asp:DropDownList ID="ddlShowSelect" runat="server" AutoPostBack="True">
                <asp:ListItem Value="2">In Progress</asp:ListItem>
            </asp:DropDownList></span>
            </asp:TableCell>
            <asp:TableCell>
                <span class="newStyle3">Search By Model:
    <asp:textbox id="tbSearchBoat" runat="server"></asp:textbox>
                    <asp:button id="btbClear2" runat="server" text="Clear" onclick="btbClear2_Click" />
                </span>
            </asp:TableCell>
            <asp:TableCell>
               <%-- <asp:DropDownList runat="server" ID="ddlBldg" AutoPostBack="True">
                    <asp:ListItem Value="%">All</asp:ListItem>
                    <asp:ListItem Value="M">Main</asp:ListItem>
                    <asp:ListItem Value="P">Paint</asp:ListItem>
                    <asp:ListItem Value="S">South</asp:ListItem>
                    <asp:ListItem Value="V">Value</asp:ListItem>
                </asp:DropDownList>

                 <asp:DropDownList runat="server" ID ="ddlProdLine" AutoPostBack="True" DataSourceID="sdsProdLines" DataTextField="ProdLineDesc" DataValueField="ProdLineID"></asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="sdsProdLines" ConnectionString='<%$ ConnectionStrings:bml_dataConnectionString %>' SelectCommand="SELECT * FROM [ProductionLines] WHERE ([Disabled] = 0) ORDER BY [ProdLineDesc]"></asp:SqlDataSource>--%>

            </asp:TableCell>
        </asp:TableRow>
    </asp:table>

</div>
