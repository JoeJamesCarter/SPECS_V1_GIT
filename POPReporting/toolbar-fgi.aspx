﻿

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
                <asp:Label ID="lblBoatsStarted" runat="server" CssClass="newStyle4" Text="Label"></asp:Label><span class="newStyle3"> - Started&nbsp;&nbsp;</span>
            </asp:TableCell>
            <asp:TableCell runat="server"><span class="newStyle3">Days In Advance To Show&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddlDaysInAdvance" runat="server" AutoPostBack="True">
            </asp:DropDownList></span>
                </asp:TableCell>
            <asp:TableCell>
             <span class="newStyle3">Search By Prod #&nbsp;&nbsp;</span><asp:textbox runat="server" id="tbSearch"></asp:textbox>
    <asp:button runat="server" text="Clear" id="btnClear" onclick="btnClear_Click" /></span>
              </asp:TableCell> 
            <asp:TableCell rowspan ="2">
             <asp:Image runat="server" img src="Images/logo-small.png" /></asp:Image>
              </asp:TableCell>                                 
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell HorizontalAlign="left">               
            <asp:Label ID="lblReadytoStart" runat="server" CssClass="greensmall" Text="Label"></asp:Label><span class="small"> - Ready To Go Online&nbsp;&nbsp;</span><br />
                <asp:Label ID="lblios" runat="server" CssClass="greensmall" Text="Label"></asp:Label><span class="small"> - Are IOs&nbsp;&nbsp;</span>
                </asp:TableCell>
            <asp:TableCell>
            <span class="newStyle3">Select Which Prod #&#39;s to Show&nbsp;
            <asp:DropDownList ID="ddlShowSelect" runat="server" AutoPostBack="True">
                <asp:ListItem Value="1">Ready To Inspect</asp:ListItem>  
                <asp:ListItem Value="0">Not Started</asp:ListItem>                                              
                <asp:ListItem Value="3">Inspected</asp:ListItem> 
                <asp:ListItem Value="4">Repair In Process</asp:ListItem> 
                <asp:ListItem Value="2">Repaired/Ready</asp:ListItem>  
            </asp:DropDownList></span>
            </asp:TableCell>
            <asp:TableCell>
                <span class="newStyle3">Search By Model:
    <asp:textbox id="tbSearchBoat" runat="server"></asp:textbox>
    <asp:button id="btbClear2" runat="server" text="Clear" onclick="btbClear2_Click" /></span>
            </asp:TableCell>
        </asp:TableRow>     
        </asp:table>

</div>





