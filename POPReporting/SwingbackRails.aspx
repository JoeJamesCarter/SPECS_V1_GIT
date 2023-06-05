<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SwingbackRails.aspx.vb" Inherits="SwingbackRails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SB Rails</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./scripts/css/bootstrap.min.css" />
    <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div id="container">
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">SB RAILS</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-bldgfilter.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
        <asp:GridView ID="gvAllFieldsF" runat="server" AutoGenerateColumns="False" DataSourceID="sdsSBRails" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo">
                    <ItemStyle VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Boat/Customer/Due">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                        <br />
                        <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("CusName") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("DueDate", "{0:d}")%>' CssClass="duedate"></asp:Label>
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
                        <asp:GridView ID="gvFurnitureOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="LinePop" DataSourceID="sdsPopReportingRails">
                            <Columns>
                                <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsPopReportingRails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [BML_POPREPORTINGFABOPTIONS] WHERE [Workcenter] = @Workcenter AND [ProdNo] = @ProdNo">
                            <SelectParameters>
                                <asp:Parameter Name="ProdNo" Type="String" />
                                <asp:Parameter DefaultValue="RailsPrep" Name="Workcenter" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Green Lights">
                    <ItemTemplate>
                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReportingByProdNo" >
                            <Columns>
                                <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="F">
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="R">
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="HasAllRails" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Has All Rails">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:ImageField>

                                <asp:ImageField DataImageUrlField="SwingbackStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="SB">
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="FloorsInstalledStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Floored?">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:ImageField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo, [FurnitureStatus],Case When HasAllRails = 1 then 2 else 0 end as HasAllRails, [CoversStatus], [RailsStatus], [TubesStatus],[SwingbackStatus],[FloorsInstalledStatus] FROM [BML_POPREPORTING_GREENLIGHTS] t1 Left Join Rails_Tracking t2 on t1.ProdNo = t2.ProdNo  WHERE (t1.ProdNo = @ProdNo)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvAllFieldsF" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br>
                        </br>
                        <asp:GridView ID="gvRailsData" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRailsData">
                                 <Columns>
                                     <asp:ImageField DataImageUrlField="PF_Received" DataImageUrlFormatString="./Images/RailsRcv_{0}.png" HeaderText="PF">
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="SF_Received" DataImageUrlFormatString="./Images/RailsRcv_{0}.png" HeaderText="SF">
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="PR_Received" DataImageUrlFormatString="./Images/RailsRcv_{0}.png" HeaderText="PR">
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="SR_Received" DataImageUrlFormatString="./Images/RailsRcv_{0}.png" HeaderText="SR">
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:ImageField>
                                     <asp:TemplateField HeaderText="T">
                                         <ItemTemplate>
                                             <asp:ImageButton ID="imgTransomReceived" runat="server" ImageUrl='<%# Eval("T_Received", "./Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsTransom").ToString() = "", 0, Eval("NeedsTransom")) = 1%>' />
                                         </ItemTemplate>
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="PM">
                                         <ItemTemplate>
                                             <asp:ImageButton ID="imgPMReceived" runat="server" ImageUrl='<%# Eval("PM_Received", "./Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsPortMid").ToString() = "", 0, Eval("NeedsPortMid")) = 1%>' />
                                         </ItemTemplate>
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="SM">
                                         <ItemTemplate>
                                             <asp:ImageButton ID="imgSMReceived" runat="server" ImageUrl='<%# Eval("SM_Received", "./Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsStrbMid").ToString() = "", 0, Eval("NeedsStrbMid")) = 1%>' />
                                         </ItemTemplate>
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:TemplateField>
                                     <asp:BoundField DataField="CustDrawNo" HeaderText="D#" />
                                 </Columns>
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsRailsData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [PF_Received], [PR_Received],[SF_Received], [SR_Received], [T_Received], [PM_Received], [SM_Received], [NeedsTransom], [NeedsPortMid], [NeedsStrbMid],[CustDrawNo] FROM [Rails_Tracking] WHERE ([ProdNo] = @ProdNo)">
                                 <SelectParameters>
                                     <asp:ControlParameter ControlID="gvAllFieldsF" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>    
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="Rails">
                    <ItemTemplate>
                        
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Update">
                    <ItemTemplate>
                        <div class="newStyle2">
                            <asp:RadioButtonList ID="rbList" runat="server" SelectedValue='<%# Bind("SBRailsStatus")%>' RepeatDirection="Horizontal" CellSpacing="2" CellPadding="2">
                                <asp:ListItem Value="0">Not Started</asp:ListItem>
                                <asp:ListItem Value="2">Ready</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div class="newStyle2">
                            <asp:Button ID="btnUpdateSwingbackStatus" runat="server" Text="Update" CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateSBRailStatus" />
                        </div>
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />
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

        <asp:SqlDataSource ID="sdsSBRails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo, t1.ItemNo, t1.CusName, t1.IsCustom, t1.IsPilot, t2.BoatHasNotes, t2.FurnitureStatus, t2.FurniturePrepLastUpdated, t2.SBRailsStatus, t2.SBRails, t1.DueDate, t1.SONo, t2.BuildLoc, t3.Series, t4.HasAllRails, t2.SwingbackStatus, t2.FurnitureStatus + t2.RailsStatus as Rank FROM BML_POPREPORTING t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY t3 on t1.ProdNo = t3.ProdNo Left Join Rails_Tracking t4 on t1.ProdNo = t4.ProdNo Where FurnitureStatus > 0 and SBNeeded = 1 and SwingbackStatus < 2 and SBRailsStatus &lt; @SBRailsStatus and CompleteStatus < 2 AND (t3.Series = 'S' OR t3.Series = 'SX' OR t3.Series = 'L' OR t3.Series = 'LX' OR t3.Series = 'LT' ) AND (t1.ProdNo LIKE '%' + @Search + '%') AND (t1.ItemNo LIKE '%' + @SearchBoat + '%') AND (t2.BUILDLOC LIKE  '%' + @BuildLocation + '%') ORDER BY Rank desc, t1.ProdNo">
             <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="SBRailsStatus" PropertyName="SelectedValue" Type="Int32" />                     
                    <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />  
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />  
                </SelectParameters>

        </asp:SqlDataSource>
        
    </form>
    <script src="./scripts/jquery-3.5.0.min.js"></script>
    <script src="./scripts/bootstrap.min.js"></script>
</body>
</html>
