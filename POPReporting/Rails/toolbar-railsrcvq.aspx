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
     <asp:SqlDataSource ID="sdsWeldDate" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct WeldDate FROM [Rails_Tracking] where Convert(date,WeldDate) &gt;= '09/1/2017' Order By WeldDate Desc"></asp:SqlDataSource>
    <asp:table id="Table1" runat="server" cssclass="auto-style1" width="966px" gridlines="None">
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" HorizontalAlign="center">                
            </asp:TableCell>
            <asp:TableCell runat="server"><span class="newStyle3">Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddlDateSelected" DataSourceID="sdsWeldDate" runat="server" DataTextFormatString="{0:d}"  DataTextField = "WeldDate" DataValueField = "WeldDate" AutoPostBack="True">
            </asp:DropDownList></span>
                <span class="newStyle3">
                    <asp:DropDownList ID="ddlRailsStatus" runat="server" AutoPostBack="True">
                        <asp:ListItem Value="0">Red</asp:ListItem>
                        <asp:ListItem Value="1">Yellow</asp:ListItem>                
                        <asp:ListItem Value="2">Green</asp:ListItem>             
                    </asp:DropDownList></span>
                </asp:TableCell>
            <asp:TableCell>
             <span class="newStyle3">Search By Prod #&nbsp;&nbsp;</span><asp:textbox runat="server" id="tbSearch"></asp:textbox>
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
            <span class="newStyle3">
            <asp:DropDownList ID="ddlShowSelect" runat="server" AutoPostBack="True">
                <asp:ListItem Value="0">Incomplete</asp:ListItem>                
                <asp:ListItem Value="1">Show Complete</asp:ListItem>                
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




