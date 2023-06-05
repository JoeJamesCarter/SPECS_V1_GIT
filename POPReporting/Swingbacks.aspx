<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Swingbacks.aspx.vb" Inherits="Swingbacks" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SWINGBACKS</title>
    <link href="StyleSheet.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">SWINGBACKS</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-bldgfilter.aspx" -->
                    </asp:TableCell>
                    <asp:TableCell ToolTip="Orange is Floored and Has All Rails. Green is Framed and has all the rails or rails are yellow or green.">
                        <span class="newStyle1">Priority: Orange, Green, White</span>                        
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
            <asp:GridView ID="gvAllFieldsF" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo">
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
                    <asp:BoundField DataField="BuildLoc" HeaderText="Prod Line" SortExpression="BuildLoc">
                        <ItemStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Options">
                        <ItemTemplate>
                            <asp:GridView ID="gvFurnitureOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="LinePop" DataSourceID="sdsPopReportingFurnitureOptions">
                                <Columns>
                                    <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsPopReportingFurnitureOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [BML_POPREPORTINGFABOPTIONS] WHERE ((([Workcenter] = @Workcenter) or [Workcenter] = 'RailsPrep') AND ([ProdNo] = @ProdNo))">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="String" />
                                    <asp:Parameter DefaultValue="FurniturePrep" Name="Workcenter" Type="String" />
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
                                    <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                                    </asp:ImageField>  
                                       <asp:ImageField DataImageUrlField="SwingbackStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="SB">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="FloorsInstalledStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Floored?">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="SBRailsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="SB Rails?">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:ImageField>
                                </Columns>
                            </asp:GridView><br />
                            <asp:GridView ID="gvRailsData" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRailsData" OnRowDataBound="gvRailsData_RowDataBound">
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
                            <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [FurnitureStatus],[FiberglassStatus], [CoversStatus], [RailsStatus], [TubesStatus],[SwingbackStatus],[FloorsInstalledStatus], SBRailsStatus, SBRails, cast(GaugeStatus as varchar) + cast(HarnessStatus as varchar) as ElectricalStatus FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvAllFieldsF" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Label ID="Label4" runat="server" Text="Veada Ship Date: "></asp:Label><asp:Label ID="lblVeadaDate" runat="server" Text=""></asp:Label><br />
                            <asp:Label ID="Label5" runat="server" Text="Veada Truck: "></asp:Label><asp:Label ID="lblVeadaTruck" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>                    
                    <asp:TemplateField HeaderText="Update">
                        <ItemTemplate>
                            <div class="newStyle2">
                                <asp:RadioButtonList ID="rblFurnitureStatus" runat="server" SelectedValue='<%# Bind("SwingbackStatus")%>' RepeatDirection="Horizontal" Width="374px">
                                    <asp:ListItem Value="0">None</asp:ListItem>
                                    <asp:ListItem Value="1">In Progress</asp:ListItem>    
                                    <asp:ListItem Value="3">On Hold</asp:ListItem>    
                                    <asp:ListItem Value="2">Ready</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="newStyle2">
                                <asp:Button ID="btnUpdateSwingbackStatus" runat="server" Text="Update" CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateSBStatus" />
                            </div>
                        </ItemTemplate>
                        <ItemStyle VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <%--<asp:ImageField DataImageUrlField="SwingbackStatus" DataImageUrlFormatString="./Images/{0}checkmark.png" HeaderText="Complete">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>--%>
                    <asp:TemplateField HeaderText="Notes">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnUpdateNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />                            
                        </ItemTemplate>
                        <ItemStyle VerticalAlign="Middle" />
                    </asp:TemplateField>
                     <%--<asp:BoundField DataField="GreenStatusTotal" HeaderText="Rank" SortExpression="GreenStatusTotal">
                        <ItemStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                    </asp:BoundField>--%>
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

            <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.SONo, FiberglassStatus, CoversStatus, RailsStatus, GaugeStatus, HarnessStatus, FLoorsInstalledStatus, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, BML_POPREPORTING.DueDate, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING_GREENLIGHTS.NotesFurniturePrep, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.SwingbackStatus, BML_POPREPORTING_TUBEPRIORITY.Series,  cast(GaugeStatus as varchar) + cast(HarnessStatus as varchar) as ElectricalStatus, (CASE WHEN cast(FurnitureStatus as integer) = 3 THEN 2 ELSE cast(FurnitureStatus as Integer) END)  + cast(FiberglassStatus as integer) +  (CASE WHEN cast(CoversStatus as integer) = 3 THEN 2 ELSE cast(CoversStatus as Integer) END)  + cast(RailsStatus as integer) + cast(TubesStatus as integer)  + cast(GaugeStatus as integer) + cast(HarnessStatus as integer) + cast(FloorsInstalledStatus as integer)  + cast(HasAllRails as integer) + cast(SwingbackStatus as integer) + cast(SBRailsStatus as integer) + (CASE WHEN cast(BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded as integer) = 1 THEN cast(CentertubeStatus as integer) ELSE 2 END) as GreenStatusTotal, HasAllRails FROM BML_POPREPORTING CROSS JOIN BML_POPREPORTING_GREENLIGHTS LEFT JOIN BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo Left Join Rails_Tracking on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.SwingbackStatus &lt;= @SwingbackStatus or BML_POPREPORTING_GREENLIGHTS.SwingbackStatus = 3) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.SBNeeded = 1) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') ORDER BY GreenStatusTotal desc, ElectricalStatus desc, BML_POPREPORTING_GREENLIGHTS.ProdNo">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="SwingbackStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2"  />
                    <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" /> 
                </SelectParameters>
            </asp:SqlDataSource>

    </form>
</body>
</html>