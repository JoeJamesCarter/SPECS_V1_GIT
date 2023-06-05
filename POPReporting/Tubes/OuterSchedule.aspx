<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OuterSchedule.aspx.vb" Inherits="Tubes_OuterSchedule" debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tubes - Outer Schedule Edit/Print</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .tubeschedule {
            font-family:Calibri;
            font-size:11px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="Label1" runat="server" CssClass="newStyle4" Text="Outer Tube Schedule"></asp:Label>
&nbsp;<asp:DropDownList ID="ddlOuterDates" runat="server" AutoPostBack="True" DataSourceID="sdsOuterDates" DataTextField="OuterScheduled" DataValueField="OuterScheduled" DataTextFormatString="{0:d}" CssClass="newStyle6">
        </asp:DropDownList>
        <br />
        <asp:SqlDataSource ID="sdsOuterDates" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [OuterScheduled] FROM [Tubes] WHERE ([OuterScheduled] IS NOT NULL) ORDER BY [OuterScheduled] Desc"></asp:SqlDataSource>
        <br />
    
        <asp:GridView ID="gvOuters" runat="server" DataSourceID="sdsOuterTubes" AutoGenerateColumns="False" DataKeyNames="ProdNo" CssClass="tubeschedule" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="1045px">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="OuterScheduleOrder" HeaderText="" SortExpression="OuterScheduleOrder" />
                <asp:BoundField DataField="ShortProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ShortProdNo" />
                <asp:BoundField DataField="Style" HeaderText="Style" SortExpression="OuterScheduleOrder" />
                <asp:BoundField DataField="Diameter" HeaderText="DIA" SortExpression="Diameter" />
                <asp:BoundField DataField="Front" HeaderText="FRT" SortExpression="Diameter" />
                <asp:BoundField DataField="Rope" HeaderText="ROPE" SortExpression="Rope" />
                <asp:BoundField DataField="TubeModel" HeaderText="Model" SortExpression="TubeModel" />
                <asp:BoundField DataField="Ladder" HeaderText="LAD" SortExpression="TubeModel" />
                <asp:BoundField DataField="Bracket" HeaderText="BRKT" SortExpression="Bracket" />
                <asp:BoundField DataField="Keel" HeaderText="Keel" SortExpression="Keel" />
                <asp:BoundField DataField="Fuel" HeaderText="Fuel" SortExpression="Fuel" />
                <asp:BoundField DataField="Splash" HeaderText="Splash" SortExpression="Splash" />
                <asp:BoundField DataField="Strakes" HeaderText="Strakes" SortExpression="Strakes" />
                <asp:BoundField DataField="StrakesComments" HeaderText="Strakes Comments" SortExpression="Strakes Comments" />
                <asp:BoundField DataField="StrbTrans" HeaderText="StrbTrans" SortExpression="StrbTrans" />
                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                <asp:BoundField DataField="Black" HeaderText="Black" SortExpression="Black" />
                <asp:BoundField DataField="MegaPan" HeaderText="MegaPan" SortExpression="MegaPan" />
                <asp:BoundField DataField="DrawingNo" HeaderText="Drawing #" SortExpression="DrawingNo" />
                
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
        <asp:SqlDataSource ID="sdsOuterTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Tubes.ProdNo, [OuterScheduledFlag], [OuterScheduled], [OuterRoller], [OuterSections], [OuterScheduleOrder] + 1 as OuterScheduleOrder, ShortProdNo, Style, Diameter, Front, TubeModel, Ladder, Bracket, Keel, Fuel, Splash, Strakes, StrakesComments, StrbTrans, Comments, Black, DrawingNo, MegaPan, Rope FROM [Tubes] Left Join OuterTubeDetails on Tubes.ProdNo = OuterTubeDetailS.ProdNo WHERE ([OuterScheduled] = @OuterScheduled) ORDER BY [OuterScheduled], [OuterScheduleOrder]">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlOuterDates" DbType="Date" Name="OuterScheduled" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <br />
        <asp:GridView ID="gvCSOuterTubes" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" CssClass="tubeschedule" DataKeyNames="TubeID" DataSourceID="sdsCSOuterTubes" ForeColor="Black" GridLines="Vertical" Width="1045px" Caption="Customer Service Tubes">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="TubeID" HeaderText="Tube ID" SortExpression="TubeID" />
                <asp:BoundField DataField="Dealer" HeaderText="Dealer" SortExpression="Dealer" />
                <asp:BoundField DataField="Style" HeaderText="Style" SortExpression="Style" />
                <asp:BoundField DataField="Diameter" HeaderText="Diameter" SortExpression="Diameter" />
                <asp:BoundField DataField="Front" HeaderText="Front" SortExpression="Front" />
                <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
                <asp:BoundField DataField="ModelYear" HeaderText="Year" SortExpression="ModelYear" />
                <asp:BoundField DataField="Ladder" HeaderText="Ladder" SortExpression="Ladder" />
                <asp:BoundField DataField="Bracket" HeaderText="Bracket" SortExpression="Bracket" />
                <asp:BoundField DataField="Keel" HeaderText="Keel" SortExpression="Keel" />
                <asp:TemplateField HeaderText ="Tube">
                    <ItemTemplate>
                        <asp:Label ID="lblTube" runat="server" Text="Label"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>                
                <asp:BoundField DataField="Fuel" HeaderText="Fuel" SortExpression="Fuel" />
                <asp:BoundField DataField="Splash" HeaderText="Splash" SortExpression="Splash" />
                <asp:BoundField DataField="Strakes" HeaderText="Strakes" SortExpression="Strakes" />
                <asp:BoundField DataField="StrakesComments" HeaderText="Strakes Cmts" SortExpression="StrakesComments" />
                <asp:BoundField DataField="StrbTrans" HeaderText="Strb Trans" SortExpression="StrbTrans" />
                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                <asp:BoundField DataField="OENo" HeaderText="OE #" SortExpression="OENo" />
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
        <asp:SqlDataSource ID="sdsCSOuterTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [TubeID], [OENo], [Dealer], [Model], [ModelYear], [Ladder], [Bracket], [Keel], [Port], [Strb], [Fuel], [Splash], [Strakes], [StrakesComments], [StrbTrans], [Comments], [Black], [DrawingNo], [Style], [Diameter], [Front] FROM [CS_Tubes] WHERE (([OuterScheduled] = @OuterScheduled) AND (([Port] = @Port) OR ([Strb] = @Strb))) ORDER BY [TubeID]">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlOuterDates" DbType="Date" Name="OuterScheduled" PropertyName="SelectedValue" />
                <asp:Parameter DefaultValue="1" Name="Port" Type="Int32" />
                <asp:Parameter DefaultValue="1" Name="Strb" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
