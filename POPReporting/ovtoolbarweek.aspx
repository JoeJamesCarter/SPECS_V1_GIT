
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

    Protected Sub DropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim lastday As Date
        Dim firstday As Date
        firstday = DropDownList1.SelectedValue
        lastday = firstday.AddDays(5).ToString("yyyy-MM-dd")
        lblLastDay.Text = lastday
        lblFirstDay.Text = firstday.ToString("MM/dd/yyyy")

    End Sub
</script>






  





    <div class="auto-style1">
        <span class="newStyle3">&nbsp;Workstation Reporting&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Days In Advance To Show&nbsp; <asp:DropDownList ID="ddlDaysInAdvance" runat="server" AutoPostBack="True">
            </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Week of:&nbsp;&nbsp;<asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem Value="2016-04-18">4/18/16</asp:ListItem>
            <asp:ListItem Value="2016-04-25">4/25/16</asp:ListItem>
            <asp:ListItem Value="2016-05-02">5/2/16</asp:ListItem>
        </asp:DropDownList>
        &nbsp;Select Which Prod #&#39;s to Show
            <asp:DropDownList ID="ddlShowSelect" runat="server" AutoPostBack="True">
                <asp:ListItem Value="2">Show All</asp:ListItem>
                <asp:ListItem Value="1">Hide Complete</asp:ListItem>
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<asp:TextBox ID="tbSearchBoat" runat="server" AutoPostBack="True" Visible="False"></asp:TextBox>
        &nbsp;&nbsp;<asp:Button ID="btnClear3" runat="server" Text="Clear" OnClick="btnClear3_Click" Visible="False" />
        <asp:TextBox ID="tbSearch" runat="server" AutoPostBack="True" Visible="False"></asp:TextBox>
        &nbsp;
        <asp:Button ID="btnClear2" runat="server" Text="Clear" OnClick="btnClear2_Click" Visible="False" />
        <asp:Label ID="lblFirstDay" runat="server" Text="Label"></asp:Label> &nbsp;to 
        <asp:Label ID="lblLastDay" runat="server" Text="Label"></asp:Label>
        </span></div>



































































































































































































































