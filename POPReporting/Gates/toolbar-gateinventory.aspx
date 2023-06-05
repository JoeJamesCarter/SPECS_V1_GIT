

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
            </asp:TableCell>
            <asp:TableCell runat="server">
<span class="newStyle3"><asp:Label ID="lblNumGates" runat="server" Text=""></asp:Label>&nbsp;<asp:Label runat="server" Text="Gates In Inventory"></asp:Label></span>
                </asp:TableCell>
            <asp:TableCell>
             <span class="newStyle3">Search By Rail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><asp:textbox runat="server" id="tbSearch"></asp:textbox>
    <asp:button runat="server" text="Clear" id="btnClear" onclick="btnClear_Click" /></span>
              </asp:TableCell>
            <asp:TableCell rowspan="2">
             <asp:Image runat="server" img src="../Images/logo-small.png" /></asp:Image>
              

              </asp:TableCell>                                       
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell HorizontalAlign="center">               
            
                </asp:TableCell>
            <asp:TableCell>
            <span class="newStyle3">Select Which Gate #&#39;s to Show&nbsp
                <asp:DropDownList ID="ddlShowSelect" runat="server" AutoPostBack="True">
                <asp:ListItem Value="0">Unused</asp:ListItem>                
                <asp:ListItem Value="1">Used</asp:ListItem>                
            </asp:DropDownList></span>
            </asp:TableCell>
            <asp:TableCell>
                <span class="newStyle3">Search By Model:
    <asp:textbox id="tbSearchBoat" runat="server"></asp:textbox>
    <asp:button id="btbClear2" runat="server" text="Clear" onclick="btbClear2_Click" /></span>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell HorizontalAlign="center">               
            
                </asp:TableCell>
            <asp:TableCell>
           
            </asp:TableCell>
            <asp:TableCell>
                <span class="newStyle3"> <span class="newStyle3">BO:&nbsp
                <asp:DropDownList ID="ddlBO" runat="server" AutoPostBack="True">
                <asp:ListItem Value="0">All</asp:ListItem>                
                <asp:ListItem Value="1">BO</asp:ListItem>                
            </asp:DropDownList></span>
                    <span class="newStyle3"> <span class="newStyle3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Clear:&nbsp
                <asp:DropDownList ID="ddlClear" runat="server" AutoPostBack="True">
                <asp:ListItem Value="0">All</asp:ListItem>                
                <asp:ListItem Value="1">Clear</asp:ListItem>                
            </asp:DropDownList></span>             
                     <span class="newStyle3"> <span class="newStyle3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Customs:&nbsp
                <asp:DropDownList ID="ddlCustoms" runat="server" AutoPostBack="True">
                <asp:ListItem Value="0">All</asp:ListItem>                
                <asp:ListItem Value="1">Customs</asp:ListItem>                
            </asp:DropDownList></span>
            </asp:TableCell>
        </asp:TableRow>             
        </asp:table>

</div>




