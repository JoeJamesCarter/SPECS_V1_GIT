﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Gauges.aspx.vb" Inherits="Gauges" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GAUGES</title>
    <link href="StyleSheet.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">GAUGES</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-bldgfilter.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
            <asp:GridView ID="gvAllFieldsG" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo">
                <Columns>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo">
                        <ItemStyle VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Boat/Customer">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                            <br />
                            <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("CusName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="./Images/Custom{0}.png" HeaderText="Custom">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                    <asp:ImageField DataImageUrlField="IsPilot" DataImageUrlFormatString="./Images/Pilot{0}.png" HeaderText="Pilot">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                    <asp:TemplateField HeaderText="Options">
                        <ItemTemplate>
                            <asp:GridView ID="gvGaugeOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="LinePop" DataSourceID="sdsPopReportingGaugeOptions">
                                <Columns>
                                    <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsPopReportingGaugeOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([Workcenter] = @Workcenter) AND ([ProdNo] = @ProdNo))">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="String" />
                                    <asp:Parameter DefaultValue="Gauges" Name="Workcenter" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Green Lights">
                        <ItemTemplate>
                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReportingByProdNo">
                                <Columns>
                                    <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="F">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="FG">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="C">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="R">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="T">
                                    </asp:ImageField>
                                    <asp:TemplateField HeaderText="CT">
                                         <ItemTemplate>
                                             <asp:ImageButton ID="imgButtonCentertube" runat="server" ImageUrl='<%# Eval("CentertubeStatus", "./Images/{0}.png")%>' Visible='<%#Eval("CentertubeNeeded") = 1%>'/>
                                         </ItemTemplate>
                                     </asp:TemplateField>
                                    <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                                    </asp:ImageField>                                    
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [FurnitureStatus],[FiberglassStatus], [CoversStatus], [RailsStatus], [TubesStatus],[CentertubeStatus],[CentertubeNeeded],cast(GaugeStatus as varchar) + cast(HarnessStatus as varchar) as ElectricalStatus FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvAllFieldsG" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>                 
                    <asp:TemplateField HeaderText="Update">
                        <ItemTemplate>
                            <div class="newStyle2">
                                <asp:RadioButtonList ID="rblGaugeStatus" runat="server" SelectedValue='<%# Bind("GaugeStatus")%>' RepeatDirection="Horizontal" Width="274px">
                                    <asp:ListItem Value="0">None</asp:ListItem>                                    
                                    <asp:ListItem Value="3">On Order</asp:ListItem>
                                    <asp:ListItem Value="2">Received</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="newStyle2">
                                <asp:Button ID="btnUpdateGaugeStatus" runat="server" Text="Update" CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateGStatus" />
                            </div>
                        </ItemTemplate>
                        <ItemStyle VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:ImageField DataImageUrlField="GaugeStatus" DataImageUrlFormatString="./Images/{0}checkmark.png" HeaderText="Complete">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                    <asp:TemplateField HeaderText="Notes">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnUpdateNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />
                            <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesGauge") = 1%>' ImageUrl='<%# Eval("NotesGauge", "./Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />
                        </ItemTemplate>
                        <ItemStyle VerticalAlign="Middle" />
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle VerticalAlign="Top" BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.SONo,  BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING_GREENLIGHTS.NotesGauge, BML_POPREPORTING_GREENLIGHTS.GaugeStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded FROM BML_POPREPORTING CROSS JOIN BML_POPREPORTING_GREENLIGHTS WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.GaugeStatus &lt;= @GaugeStatus or BML_POPREPORTING_GREENLIGHTS.GaugeStatus = 3) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') ORDER BY Convert(integer,BML_POPREPORTING.ProdNo)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="GaugeStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2"  />
                    <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" /> 
                </SelectParameters>
            </asp:SqlDataSource>

    </form>
</body>
</html>
