<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CenterSchedule.aspx.vb" Inherits="Tubes_CenterSchedule" Debug="True" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tubes - Center Schedule</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .tubeschedule {
            font-family:Calibri;
            font-size:16px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="Label1" runat="server" CssClass="newStyle4" Text="Center Tube Schedule"></asp:Label>
&nbsp;<asp:DropDownList ID="ddlCenterDates" runat="server" AutoPostBack="True" DataSourceID="sdsCenterDates" DataTextField="CenterScheduled" DataValueField="CenterScheduled" DataTextFormatString="{0:d}" CssClass="newStyle6">
        </asp:DropDownList>
        <br />
        <asp:SqlDataSource ID="sdsCenterDates" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [CenterScheduled] FROM [Tubes] WHERE ([CenterScheduled] IS NOT NULL) ORDER BY [CenterScheduled] Desc"></asp:SqlDataSource>
        <br />
    
        <asp:GridView ID="gvCenters" runat="server" DataSourceID="sdsCenterTubes" AutoGenerateColumns="False" DataKeyNames="ProdNo" CssClass="tubeschedule" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="1045px">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="PrintOrder" HeaderText="" SortExpression="PrintOrder" />
                <asp:BoundField DataField="ShortProdNo" HeaderText="PROD #" ReadOnly="True" SortExpression="ShortProdNo" />
                <asp:BoundField DataField="Length" HeaderText="LEN" SortExpression="Length" />
                <asp:BoundField DataField="Rope" HeaderText="NL ROPE" SortExpression="Rope" />
                <asp:BoundField DataField="Center" HeaderText="CENTER" SortExpression="Center" />
                <asp:BoundField DataField="Storage" HeaderText="STORAGE" SortExpression="Storage" />
                <asp:BoundField DataField="TenWide" HeaderText="10 WIDE" SortExpression="TenWide" />
                <asp:BoundField DataField="DrawingNo" HeaderText="DRAWING #" SortExpression="DrawingNo" />
                <%--<asp:BoundField DataField="Bracket" HeaderText="BRKT" SortExpression="Bracket" />  --%>              
                <asp:BoundField DataField="Fuel" HeaderText="FUEL" SortExpression="Fuel" />                
                <asp:BoundField DataField="Strakes" HeaderText="STRAKES" SortExpression="Strakes" >
                <ItemStyle Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="TubeUpg" HeaderText="TUBE UPG" SortExpression="TubeUpg" >
                <ItemStyle Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="Upsweep_SldTrans" HeaderText="UPSWEEP/SLD TRANS" SortExpression="Upsweep_SldTrans" ItemStyle-Width="100px" />                              
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
          <asp:SqlDataSource ID="sdsCenterTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Tubes.ProdNo, [CenterScheduledFlag], [CenterScheduled], [CenterRoller], [CenterSections], [CenterScheduleOrder], [CenterScheduleOrder] + 1 as PrintOrder, ShortProdNo, Length, Center, Storage, TenWide, DrawingNo, Bracket, Fuel, Strakes, TubeUpg, Upsweep_SldTrans, Rope FROM [Tubes] Left Join CenterTubeDetails on Tubes.ProdNo = CenterTubeDetailS.ProdNo WHERE ([CenterScheduled] = @CenterScheduled) ORDER BY [CenterScheduled], [CenterScheduleOrder]">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCenterDates" DbType="Date" Name="CenterScheduled" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <asp:GridView ID="gvCSCenterTubes" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" CssClass="tubeschedule" DataKeyNames="TubeID" DataSourceID="sdsCSCenterTubes" ForeColor="Black" GridLines="Vertical" Width="1045px" Caption="Customer Service Tubes">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="TubeID" HeaderText="CS Tube #" InsertVisible="False" ReadOnly="True" SortExpression="TubeID" />
                <asp:BoundField DataField="OENo" HeaderText="OE #" SortExpression="OENo" />
                <asp:BoundField DataField="Dealer" HeaderText="Dealer" SortExpression="Dealer" />
                <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
                <asp:BoundField DataField="ModelYear" HeaderText="MY" SortExpression="ModelYear" />
                <asp:BoundField DataField="Length" HeaderText="Length" SortExpression="Length" />
                <asp:BoundField DataField="Center" HeaderText="Center" SortExpression="Center" />
                <asp:BoundField DataField="TenWide" HeaderText="TenWide" SortExpression="TenWide" />
                <asp:BoundField DataField="Storage" HeaderText="Storage" SortExpression="Storage" />
                <asp:BoundField DataField="CtrDrawingNo" HeaderText="Drawing #" SortExpression="CtrDrawingNo" />
                <asp:BoundField DataField="CtrBracket" HeaderText="Bracket" SortExpression="CtrBracket" />
                <asp:BoundField DataField="CtrFuel" HeaderText="Fuel" SortExpression="CtrFuel" />
                <asp:BoundField DataField="CtrStrakes" HeaderText="Strakes" SortExpression="CtrStrakes" />
                <asp:BoundField DataField="TubeUpg" HeaderText="Tube Upg" SortExpression="TubeUpg" />
                <asp:BoundField DataField="Upsweep" HeaderText="Upsweep" SortExpression="Upsweep" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsCSCenterTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [TubeID], [OENo], [Dealer], [Model], [ModelYear], [Length], [Center], [TenWide], [Storage], [CtrDrawingNo], [CtrBracket], [CtrFuel], [CtrStrakes], [TubeUpg], [Upsweep] FROM [CS_Tubes] WHERE (([CenterScheduled] = @CenterScheduled) AND ([Ctr] = @Center)) ORDER BY [TubeID]">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCenterDates" DbType="Date" Name="CenterScheduled" PropertyName="SelectedValue" />
                <asp:Parameter DefaultValue="1" Name="Center" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
