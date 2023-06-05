<head>
    <style type="text/css">
        .auto-style1 {}
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
    <asp:table id="Table1" runat="server" cssclass="auto-style1" width="966px" gridlines="None">
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" HorizontalAlign="center">
                <asp:Label ID="lblBoatsScheduled" runat="server" CssClass="newStyle4" Text="Label"></asp:Label><span class="newStyle3"><span class="newStyle3">&nbsp;# Scheduled</span>
            </asp:TableCell>
            <asp:TableCell runat="server"><span class="newStyle3"></span>
                </asp:TableCell>
            <asp:TableCell>
             <span class="newStyle3">Search By Prod #&nbsp;&nbsp;</span><asp:textbox runat="server" id="tbSearch"></asp:textbox>
    <asp:button runat="server" text="Clear" id="btnClear" onclick="btnClear_Click" /></span></br>
                <span class="newStyle3">Search By Model:
    <asp:textbox id="tbSearchBoat" runat="server"></asp:textbox>
    <asp:button id="Button1" runat="server" text="Clear" onclick="btbClear2_Click" /></span></br>
                <span class="newStyle3">Show&nbsp;
            <asp:DropDownList ID="ddlShowSelect" runat="server" AutoPostBack="True">
                <asp:ListItem Value="0">Hide Scheduled</asp:ListItem>                
                <asp:ListItem Value="1">Show Scheduled</asp:ListItem>                
            </asp:DropDownList></span>
              </asp:TableCell>
            <asp:TableCell rowspan="2">
             <asp:Image runat="server" img src="../Images/logo-small.png" /></asp:Image>
              </asp:TableCell>                                       
        </asp:TableRow>
        <asp:TableRow>
            </asp:TableRow>
       
        
       
        </asp:table>

</div>
