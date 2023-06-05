<%@ Page Language="VB" AutoEventWireup="false" CodeFile="StandardDrawings.aspx.vb" Inherits="Drawings_StandardDrawings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Standard Drawing Cross Reference</title>
    <style type="text/css">
        .auto-style1 {}
        .auto-style2 {}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h1>Engineering Drawings for Standard Boats</h1>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [BML_POPREPORTING_STANDARD] WHERE [Auto] = @Auto" InsertCommand="INSERT INTO [BML_POPREPORTING_STANDARD] ([Year], [Model], [DrawingNo]) VALUES (@Year, @Model, @DrawingNo)" SelectCommand="SELECT * FROM [BML_POPREPORTING_STANDARD] ORDER BY [Model]" UpdateCommand="UPDATE [BML_POPREPORTING_STANDARD] SET [Year] = @Year, [Model] = @Model, [DrawingNo] = @DrawingNo WHERE [Auto] = @Auto">
            <DeleteParameters>
                <asp:Parameter Name="Auto" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Year" Type="Int32" />
                <asp:Parameter Name="Model" Type="String" />
                <asp:Parameter Name="DrawingNo" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Year" Type="Int32" />
                <asp:Parameter Name="Model" Type="String" />
                <asp:Parameter Name="DrawingNo" Type="String" />
                <asp:Parameter Name="Auto" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        Add A New Model/Drawing<asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" CssClass="auto-style2" DataKeyNames="Auto" DataSourceID="sdsPopReporting" ForeColor="Black" Height="50px" Width="395px">
            <EditRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <Fields>
                <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
                <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
                <asp:BoundField DataField="DrawingNo" HeaderText="DrawingNo" SortExpression="DrawingNo" />
                <asp:CommandField ShowEditButton="True" ShowInsertButton="True" />
            </Fields>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
        </asp:DetailsView>
        <br />
        <br />
        Edit/Delete Existing Model/Drawing<br />
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" CssClass="auto-style1" DataKeyNames="Auto" DataSourceID="sdsPopReporting" ForeColor="Black" Width="397px">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
                <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
                <asp:BoundField DataField="DrawingNo" HeaderText="Drawing #" SortExpression="DrawingNo" />
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
    
    </div>
    </form>
</body>
</html>
