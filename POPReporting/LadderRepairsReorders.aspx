<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LadderRepairsReorders.aspx.vb" Inherits="LadderRepairsReorders" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ladder Repairs & Reorders</title>
      <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" CssClass="newStyle7" Text="Ladder Reorders & Repairs            "></asp:Label>
        <asp:DropDownList ID="ddlComplete" runat="server" AutoPostBack="True">
            <asp:ListItem Value="1">Hide Complete</asp:ListItem>
            <asp:ListItem Value="2">Show All</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:Table ID="DailyStats" cssClass="newStyle1" runat="server" Width="1430px" GridLines="Both" BorderStyle="Solid" BorderWidth="2px" Caption="Unresolved Totals">
            <asp:TableHeaderRow Font-Bold="True">
                <asp:TableHeaderCell ColumnSpan="2" cssClass="newStyle7">10 WIDES</asp:TableHeaderCell>
                <asp:TableHeaderCell ColumnSpan="6" cssClass="newStyle7">8/8.5</asp:TableHeaderCell>
                <asp:TableHeaderCell RowSpan="4"><asp:Button ID="btnSave" runat="server" Text="SAVE" Font-Size="16" Font-Bold="True" /></asp:TableHeaderCell>
            </asp:TableHeaderRow>
            <asp:TableHeaderRow>
                <asp:TableHeaderCell ColumnSpan="2" cssClass="newStyle6" BackColor="Silver">REORDERS</asp:TableHeaderCell>
                <asp:TableHeaderCell ColumnSpan="2" cssClass="newStyle6" BackColor ="#CCCCCC">REPAIRS</asp:TableHeaderCell>
                <asp:TableHeaderCell ColumnSpan="3" cssClass="newStyle6" BackColor="Silver">REORDERS</asp:TableHeaderCell>
            </asp:TableHeaderRow>
            <asp:TableHeaderRow Height="77px">                
                <asp:TableHeaderCell BackColor="#FFFFCC">Silver: <asp:TextBox ID="tbTopSilverReorderQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbTOPBlackReorderQty" runat="server" Width="30px"></asp:TextBox><br></br><asp:Label ID="Label2" runat="server" cssClass="newStyle6" Text="Top"></asp:Label></asp:TableHeaderCell>
                <asp:TableHeaderCell BackColor="#FFFFCC">Silver: <asp:TextBox ID="tbBottomSilverReorderQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbBottomBlackReorderQty" runat="server" Width="30px"></asp:TextBox><br></br><asp:Label ID="Label4" runat="server" cssClass="newStyle6" Text="Bottom"></asp:Label></asp:TableHeaderCell>
                <asp:TableHeaderCell BackColor="#99CCFF"><br></br><asp:Label ID="Label5" runat="server" cssClass="newStyle6" Text="Left"></asp:Label></asp:TableHeaderCell>                
                <asp:TableHeaderCell BackColor="#99CCFF"><br></br><asp:Label ID="Label6" runat="server" cssClass="newStyle6" Text="Right"></asp:Label></asp:TableHeaderCell>
                <asp:TableHeaderCell BackColor="#FFFFCC">Silver: <asp:TextBox ID="tbLeftSilverReorderQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbLeftBlackReorderQty" runat="server" Width="30px"></asp:TextBox><br></br><asp:Label ID="Label7" runat="server" cssClass="newStyle6" Text="Left"></asp:Label></asp:TableHeaderCell>
                <asp:TableHeaderCell BackColor="#FFFFCC">Silver: <asp:TextBox ID="tbCenterSilverReorderQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbCenterBlackReorderQty" runat="server" Width="30px"></asp:TextBox><br></br><asp:Label ID="Label8" runat="server" cssClass="newStyle6" Text="Center"></asp:Label></asp:TableHeaderCell>
                <asp:TableHeaderCell BackColor="#FFFFCC">Silver: <asp:TextBox ID="tbRightSilverReorderQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbRightBlackReorderQty" runat="server" Width="30px"></asp:TextBox><br></br><asp:Label ID="Label9" runat="server" cssClass="newStyle6" Text="Right"></asp:Label></asp:TableHeaderCell>
            </asp:TableHeaderRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Center">Silver: <asp:Label ID="lblDailySilverTopsReorder" cssClass="newStyle6" runat="server" Text="#"></asp:Label>     Black: <asp:Label ID="lblDailyBlackTopsReorder" cssClass="newStyle6" runat="server" Text="#"></asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">Silver: <asp:Label ID="lblDailySilverBottomReorder" cssClass="newStyle6" runat="server" Text="#"></asp:Label>     Black: <asp:Label ID="lblDailyBlackBottomReorder" cssClass="newStyle6" runat="server" Text="#"></asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">Silver: <asp:Label ID="lblDailySilverRepairLeft" cssClass="newStyle6" runat="server" Text="#"></asp:Label>     Black: <asp:Label ID="lblDailyBlackRepairLeft" cssClass="newStyle6" runat="server" Text="#"></asp:Label></asp:TableCell>                 
                <asp:TableCell HorizontalAlign="Center">Silver: <asp:Label ID="lblDailySilverRepairRight" cssClass="newStyle6"  runat="server" Text="#"></asp:Label>     Black: <asp:Label ID="lblDailyBlackRepairRight" cssClass="newStyle6" runat="server" Text="#"></asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">Silver: <asp:Label ID="lblDailySilverReorderLeft" cssClass="newStyle6" runat="server" Text="#"></asp:Label>     Black: <asp:Label ID="lblDailyBlackReorderLeft" cssClass="newStyle6" runat="server" Text="#"></asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">Silver: <asp:Label ID="lblDailySilverReorderCenter" cssClass="newStyle6" runat="server" Text="#"></asp:Label>     Black: <asp:Label ID="lblDailyBlackReorderCenter" cssClass="newStyle6" runat="server" Text="#"></asp:Label></asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">Silver: <asp:Label ID="lblDailySilverReorderRight" cssClass="newStyle6" runat="server" Text="#"></asp:Label>     Black: <asp:Label ID="lblDailyBlackReorderRight" cssClass="newStyle6" runat="server" Text="#"></asp:Label></asp:TableCell>
            </asp:TableRow>
        </asp:Table>   
        <br />
        <asp:GridView ID="gvReorders" runat="server" cssClass="newStyle1" AutoGenerateColumns="False" DataKeyNames="AutoID" DataSourceID="sdsLadderReorders" Width="550px" Caption="Reorders" BorderStyle="Solid" AllowSorting="True">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>                
                <asp:BoundField DataField="Part" HeaderText="Part" SortExpression="Part" />               
                <asp:BoundField DataField="Color" HeaderText="Color" SortExpression="Color" />
                <asp:BoundField DataField="DateAdded" HeaderText="Date Added" SortExpression="DateAdded" />
                <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnResolved" runat="server" Text="Mark Resolved" CommandArgument='<%# Eval("AutoID")%>' CommandName="gotoMarkResolved" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>               
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsLadderReorders" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [LadderTransactions] WHERE ([Resolved] &lt; @Resolved) and Type = 'Reorder' ORDER BY Part, Color, convert(date,[DateAdded])">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlComplete" DefaultValue="2" Name="Resolved" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <br />
        <asp:Label ID="Label3" CssClass="newStyle1" runat="server" Text="Select Repair Date: "></asp:Label>
        <asp:DropDownList ID="ddlDateRepairsAdded" runat="server" DataSourceID="sdsUniqueRepairDates" DataTextField="DateAdded" DataValueField="DateAdded" DataTextFormatString="{0:d}" AutoPostBack="True"></asp:DropDownList>
        <asp:SqlDataSource ID="sdsUniqueRepairDates" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct(convert(date,[DateAdded])) as DateAdded FROM [LadderTransactions] WHERE ([Type] = @Type) ORDER BY [DateAdded] DESC">
            <SelectParameters>
                <asp:Parameter DefaultValue="Repair" Name="Type" Type="String" />                
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="gvRepairs" runat="server" cssClass="newStyle1" AutoGenerateColumns="False" DataKeyNames="AutoID" DataSourceID="sdsLadderRepairs" Width="412px" Caption="Repairs" BorderStyle="Solid" AllowSorting="True">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>                
                <asp:BoundField DataField="Part" HeaderText="Part" SortExpression="Part" />               
                <asp:BoundField DataField="Color" HeaderText="Color" SortExpression="Color" />
                <asp:BoundField DataField="DateAdded" HeaderText="Date Added" SortExpression="DateAdded" />
                <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField  HeaderText="Reorder as Needed" Visible="False">
                    <ItemTemplate>
                        Qty:  <asp:TextBox ID="tbQtyToReorder" runat="server" Width="30px"></asp:TextBox>
                        <asp:Button ID="btnReorder" runat="server" Text="Resolve Repair & Mark Reorders" CommandArgument='<%# Eval("AutoID")%>' CommandName="gotoMarkReordered" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>               
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsLadderRepairs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [LadderTransactions] WHERE ([Resolved] &lt; @Resolved) and convert(date,DateAdded) = @DateAdded and Type = 'Repair' ORDER BY Part, Color, convert(date,[DateAdded])">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlComplete" DefaultValue="2" Name="Resolved" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddlDateRepairsAdded" DbType="String" Name="DateAdded" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
