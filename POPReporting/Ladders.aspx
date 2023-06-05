<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Ladders.aspx.vb" Inherits="Ladders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>LADDERS</title>
    <link href="StyleSheet.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="Table2" runat="server" Width="1650px">
            <asp:TableRow ViewStateMode="Inherit" VerticalAlign="Top">
                <asp:TableCell>
                     <asp:Table ID="DailyStats" cssClass="newStyle1" runat="server" Width="1430px" GridLines="Both" BorderStyle="Solid" BorderWidth="2px">
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
                <asp:TableHeaderCell BackColor="#FFFFCC">Silver: <asp:TextBox ID="tbTopSilverReorderQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbTOPBlackReorderQty" runat="server" Width="30px"></asp:TextBox></br><asp:Label ID="Label1" runat="server" cssClass="newStyle6" Text="Top"></asp:Label></asp:TableHeaderCell>
                <asp:TableHeaderCell BackColor="#FFFFCC">Silver: <asp:TextBox ID="tbBottomSilverReorderQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbBottomBlackReorderQty" runat="server" Width="30px"></asp:TextBox></br><asp:Label ID="Label4" runat="server" cssClass="newStyle6" Text="Bottom"></asp:Label></asp:TableHeaderCell>
                <asp:TableHeaderCell BackColor="#99CCFF">Silver: <asp:TextBox ID="tbLeftSilverRepairQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbLeftBlackRepairQty" runat="server" Width="30px"></asp:TextBox></br><asp:Label ID="Label5" runat="server" cssClass="newStyle6" Text="Left"></asp:Label></asp:TableHeaderCell>                
                <asp:TableHeaderCell BackColor="#99CCFF">Silver: <asp:TextBox ID="tbRightSilverRepairQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbRightBlackRepairQty" runat="server" Width="30px"></asp:TextBox></br><asp:Label ID="Label6" runat="server" cssClass="newStyle6" Text="Right"></asp:Label></asp:TableHeaderCell>
                <asp:TableHeaderCell BackColor="#FFFFCC">Silver: <asp:TextBox ID="tbLeftSilverReorderQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbLeftBlackReorderQty" runat="server" Width="30px"></asp:TextBox></br><asp:Label ID="Label7" runat="server" cssClass="newStyle6" Text="Left"></asp:Label></asp:TableHeaderCell>
                <asp:TableHeaderCell BackColor="#FFFFCC">Silver: <asp:TextBox ID="tbCenterSilverReorderQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbCenterBlackReorderQty" runat="server" Width="30px"></asp:TextBox></br><asp:Label ID="Label8" runat="server" cssClass="newStyle6" Text="Center"></asp:Label></asp:TableHeaderCell>
                <asp:TableHeaderCell BackColor="#FFFFCC">Silver: <asp:TextBox ID="tbRightSilverReorderQty" runat="server" Width="30px"></asp:TextBox>  Black: <asp:TextBox ID="tbRightBlackReorderQty" runat="server" Width="30px"></asp:TextBox></br><asp:Label ID="Label9" runat="server" cssClass="newStyle6" Text="Right"></asp:Label></asp:TableHeaderCell>
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
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Table ID="tblMins" cssClass="newStyle1" runat="server" Caption="Minimum Qtys" Width="650px" BorderStyle="Solid" BorderWidth="2px" GridLines="Both" Visible="False">
            <asp:TableHeaderRow>
                <asp:TableHeaderCell>Part</asp:TableHeaderCell>
                <asp:TableHeaderCell>Min Qty</asp:TableHeaderCell>
                <asp:TableHeaderCell>Current Count</asp:TableHeaderCell>
                <asp:TableHeaderCell>Variance</asp:TableHeaderCell>
                <asp:TableHeaderCell></asp:TableHeaderCell>
            </asp:TableHeaderRow>
             <asp:TableRow><asp:TableCell Width="140px">Top (10 Wide)</asp:TableCell>
                 <asp:TableCell Width="90px" HorizontalAlign="Center"><asp:Label ID="lblMin10Top" runat="server" Text=""></asp:Label></asp:TableCell>
                 <asp:TableCell Width="110px" HorizontalAlign="Center"><asp:TextBox ID="tbCurrent10Top" runat="server" Width="50"></asp:TextBox></asp:TableCell>
                 <asp:TableCell Width="90px" HorizontalAlign="Center"><asp:Label ID="lblVariance10Top" runat="server" Text=""></asp:Label></asp:TableCell>     
                 <asp:TableCell RowSpan="6" HorizontalAlign="Center" VerticalAlign="Middle">
                     <asp:Button ID="btnSaveCalc" runat="server" Text="Save & Calculate" /></br></br>
                     <asp:Button ID="btnReorderMins" runat="server" Text="Reorder Minimums" />
                 </asp:TableCell>        
             </asp:TableRow>
             <asp:TableRow><asp:TableCell>Bottom (10 Wide)</asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:Label ID="lblMin10Bottom" runat="server" Text=""></asp:Label></asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:TextBox ID="tbCurrent10Bottom" runat="server" Width="50"></asp:TextBox></asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:Label ID="lblVariance10Bottom" runat="server" Text=""></asp:Label></asp:TableCell>
             </asp:TableRow>
            <asp:TableRow><asp:TableCell>Left (8/8.5)</asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:Label ID="lblMinLeft" runat="server" Text=""></asp:Label></asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:TextBox ID="tbCurrentLeft" runat="server" Width="50"></asp:TextBox></asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:Label ID="lblVarianceLeft" runat="server" Text=""></asp:Label></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow><asp:TableCell>Center (8/8.5)</asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:Label ID="lblMinCenter" runat="server" Text=""></asp:Label></asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:TextBox ID="tbCurrentCenter" runat="server" Width="50"></asp:TextBox></asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:Label ID="lblVarianceCenter" runat="server" Text=""></asp:Label></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow><asp:TableCell>Right (8/8.5)</asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:Label ID="lblMinRight" runat="server" Text=""></asp:Label></asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:TextBox ID="tbCurrentRight" runat="server" Width="50"></asp:TextBox></asp:TableCell>
                 <asp:TableCell HorizontalAlign="Center"><asp:Label ID="lblVarianceRight" runat="server" Text=""></asp:Label></asp:TableCell>
            </asp:TableRow>       
        </asp:Table>   
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">LADDERS</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-bldgfilter.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
        
            <br />
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
                            <asp:GridView ID="gvRailOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="LinePop" DataSourceID="sdsPopReportingRailOptions">
                                <Columns>
                                    <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsPopReportingRailOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([Workcenter] = @Workcenter) AND ([ProdNo] = @ProdNo) AND (([OPTION_DESC] Like 'BLACK%') AND ([OPTION_DESC] Not Like '%BLACKOUT S/G%')))">
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
                    <asp:BoundField DataField="CurrentStatus" HeaderText="Current Status" >                   
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Update">
                        <ItemTemplate>
                            <div class="newStyle2">
                                <asp:RadioButtonList ID="rblLadderStatus" runat="server" SelectedValue='<%# IIf(Eval("LadderStatus").ToString() = "", 0, Eval("LadderStatus")) %>' RepeatDirection="Horizontal" Width="274px">
                                    <asp:ListItem Value="0">None</asp:ListItem>                                                                        
                                    <asp:ListItem Value="2">Built</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="newStyle2">
                                <asp:Button ID="btnUpdateLadderStatus" runat="server" Text="Update" CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateLadderStatus" />
                            </div>
                        </ItemTemplate>
                        <ItemStyle VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:ImageField DataImageUrlField="LadderStatus" DataImageUrlFormatString="./Images/{0}checkmark.png" HeaderText="Complete">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
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

            <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.SONo,  BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING_GREENLIGHTS.GaugeStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.LadderStatus, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus FROM BML_POPREPORTING CROSS JOIN BML_POPREPORTING_GREENLIGHTS WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus &lt; 2) AND (BML_POPREPORTING.DueDate &lt;= @DueDate ) AND (BML_POPREPORTING_GREENLIGHTS.LadderStatus &lt;= @LadderStatus) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') AND (BML_POPREPORTING_GREENLIGHTS.NeedsLadder = 1) ORDER BY CASE WHEN BML_POPREPORTING_GREENLIGHTS.RailsInstalled is NULL Then 1 Else 0 END, BML_POPREPORTING_GREENLIGHTS.RailsInstalled asc, Convert(integer,BML_POPREPORTING.ProdNo)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="LadderStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2"  />
                    <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" /> 
                </SelectParameters>
            </asp:SqlDataSource>

    </form>
</body>
</html>
