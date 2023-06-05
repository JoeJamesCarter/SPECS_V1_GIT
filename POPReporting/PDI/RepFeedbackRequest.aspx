<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RepFeedbackRequest.aspx.vb" Inherits="PDI_RepFeedbackRequest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Request Sales Rep Feedback</title>
     <link href="../StyleSheet.css" rel="stylesheet" />
    <script>
        window.onunload = function () {
            window.opener.document.getElementById('btnRefresh').click();

        }

     </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="Request Sales Rep Feedback" CssClass="newStyle7"></asp:Label>
    </div>
        <asp:Label ID="lblModelYear0" runat="server" Text="Product Dev ID#:" CssClass="newStyle6"></asp:Label>
&nbsp;&nbsp;
        <asp:Label ID="lblModelYear" runat="server" Text="Label" CssClass="newStyle6"></asp:Label>
&nbsp;-
        <asp:Label ID="lblItemID" runat="server" Text="Label" CssClass="newStyle6"></asp:Label>
        <br />
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" CssClass="newStyle1" DataKeyNames="ModelYear,AutoID" DataSourceID="sdsProjects" ForeColor="Black" GridLines="Vertical" Height="50px" Width="501px">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <EditRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <Fields>               
                <asp:BoundField DataField="RequestedBy" HeaderText="Requested By" SortExpression="RequestedBy" />                                
                <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                <asp:BoundField DataField="Series" HeaderText="Series" SortExpression="Series" />
                <asp:BoundField DataField="InitialDescription" HeaderText="Initial Description" SortExpression="InitialDescription" />
                <asp:BoundField DataField="NarrowedDescription" HeaderText="More Detailed Description" SortExpression="NarrowedDescription" />                
            </Fields>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        </asp:DetailsView>
        <asp:SqlDataSource ID="sdsProjects" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [ProductDesignIdeas] WHERE (([ModelYear] = @ModelYear) AND ([AutoID] = @AutoID))">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblModelYear" Name="ModelYear" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="lblItemID" Name="AutoID" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text="Additional Detail To Send:"></asp:Label>
        <br />
        <br />
        <asp:TextBox ID="tbAdditionalnfo" runat="server" Height="120px" TextMode="MultiLine" Width="490px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" CssClass="newStyle6" Text="Send To:"></asp:Label>
        &nbsp;<asp:Button ID="btnAll" runat="server" Text="All Reps and Associates" />
&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnReps" runat="server" Text="Reps Only" />
&nbsp;&nbsp;
        <asp:Button ID="btnAssociates" runat="server" CausesValidation="False" Text="Associates" />
&nbsp;&nbsp;
        <asp:Button ID="btnNone" runat="server" Text="Deselect All" />
        <br />
&nbsp;<asp:CheckBoxList ID="cbReps" runat="server" CssClass="newStyle1" Width="147px">
            <asp:ListItem Value="mspencer@nexicom.net">Bob Spencer</asp:ListItem>
            <asp:ListItem Value="mdidaniel@aol.com">Daniel Hahn</asp:ListItem>
            <asp:ListItem Value="nauticalbuff2@gmail.com">Susan Buff</asp:ListItem>
            <asp:ListItem Value="jcall@benningtonmarine.com">Jason Call</asp:ListItem>
            <asp:ListItem Value="jonathanfizer@yahoo.com">Jon Fizer</asp:ListItem>
            <asp:ListItem Value="tpayne4m@gmail.com">Tim Payne</asp:ListItem>
            <asp:ListItem Value="tcooper@benningtonmarine.com">Tom Cooper</asp:ListItem>
            <asp:ListItem Value="krimbaugh@benningtonmarine.com">Alex Cook</asp:ListItem>
            <asp:ListItem Value="ameeks023@gmail.com">Austin Meeks</asp:ListItem>
            <asp:ListItem Value="dmartin041@gmai.com">Daniel Martin</asp:ListItem>
            <asp:ListItem Value="sgirten@benningtonmarine.com">Sam Girten</asp:ListItem>            
        </asp:CheckBoxList>
        <br />
        <br />
        <br />
        <asp:Button ID="btnSend" runat="server" Text="Send" CssClass="newStyle6" Height="41px" Width="98px" />
        <br />
        <br />
    </form>
</body>
</html>
