
    <style type="text/css">
        .newStyle3 {
            font-family: Calibri;
            font-size: 16px;
        }
        .auto-style1 {
            width: 1331px;
        }
    </style>

<script runat="server">
 

    Protected Sub btnClear2_Click(sender As Object, e As EventArgs)
      tbSearch.Text = ""  
    End Sub
    
    Protected Sub btnClear3_Click(sender As Object, e As EventArgs)
        tbSearchBoat.Text = ""
    End Sub
   
</script>





    <div class="auto-style1">
        <span class="newStyle3">&nbsp;Workstation Reporting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Days In Advance To Show&nbsp; <asp:DropDownList ID="ddlDaysInAdvance" runat="server" AutoPostBack="True">
            </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select Which Prod #&#39;s to Show
            <asp:DropDownList ID="ddlShowSelect" runat="server" AutoPostBack="True">
                <asp:ListItem Value="2">Show All</asp:ListItem>
                <asp:ListItem Value="1">Hide Complete</asp:ListItem>
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Building: &nbsp; <asp:DropDownList runat="server" ID ="ddlBldg" AutoPostBack="True">
                    <asp:ListItem Value="%">All</asp:ListItem>                
                    <asp:ListItem Value="M">Main</asp:ListItem> 
                  <asp:ListItem Value="V">Value</asp:ListItem> 
                    <asp:ListItem Value="S">South</asp:ListItem> 
                 </asp:DropDownList><asp:TextBox ID="tbSearchBoat" runat="server" AutoPostBack="True" Visible="False"></asp:TextBox>
        &nbsp;&nbsp;<asp:Button ID="btnClear3" runat="server" Text="Clear" OnClick="btnClear3_Click" Visible="False" />
        <asp:TextBox ID="tbSearch" runat="server" AutoPostBack="True" Visible="False"></asp:TextBox>
        &nbsp;
        <asp:Button ID="btnClear2" runat="server" Text="Clear" OnClick="btnClear2_Click" Visible="False" />
        </span></div>




















