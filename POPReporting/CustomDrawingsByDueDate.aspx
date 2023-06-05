<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CustomDrawingsByDueDate.aspx.vb" Inherits="CustomDrawingsByDueDate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Custom Drawings By Due Date</title>
    <link href="StyleSheet.css" rel="stylesheet" />
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label2" runat="server" CssClass="newStyle3" Text="Customs Drawings By Due Date"></asp:Label></br>
        <asp:Label ID="Label1" runat="server" CssClass="newStyle3" Text="Selected Due Date"></asp:Label>
        <asp:DropDownList ID="DropDownList1" cssClass="newStyle1" runat="server" DataSourceID="sdsPPDueDates" DataTextField="due_dt" DataValueField="due_dt" AutoPostBack="True"></asp:DropDownList>        
        <br />
        <asp:GridView ID="GridView1" cssClass="newStyle1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPPORDLIN" Width="1110px">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ord_no" HeaderText="ord_no" SortExpression="ord_no" />
                <asp:BoundField DataField="item_no" HeaderText="item_no" SortExpression="item_no" />
                <asp:BoundField DataField="due_dt" HeaderText="due_dt" SortExpression="due_dt" />
                <asp:BoundField DataField="user_def_fld_1" HeaderText="user_def_fld_1" SortExpression="user_def_fld_1" />
                <asp:BoundField DataField="cus_no" HeaderText="cus_no" SortExpression="cus_no" />
                <asp:BoundField DataField="cus_name" HeaderText="cus_name" SortExpression="cus_name" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPPORDLIN" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [ord_no], [item_no], due_dt, [user_def_fld_1], [cus_no], [cus_name] FROM [PPORDFIL_SQL] WHERE [due_dt] = @due_dt">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="due_dt" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsPPDueDates" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT Distinct due_dt FROM [PPORDFIL_SQL] Order By due_dt desc"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
