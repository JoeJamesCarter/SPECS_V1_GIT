<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pilots.aspx.vb" Inherits="Workstations_Pilots" Debug="true" MaintainScrollPositionOnPostback="True" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>PILOTS</title>

    <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">PILOTS</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-decks.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
        <asp:GridView ID="gvRails" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo">
                    <ItemStyle Font-Bold="True" />
                </asp:BoundField>
                <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="F">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="FG">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="C">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="R">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="T">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="CT">
                    <ItemTemplate>
                        <asp:Image ID="Centertube" Visible=' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "../Images/{0}.png") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:ImageField>
                <asp:TemplateField HeaderText="Rails">
                    <ItemTemplate>
                        <asp:GridView ID="gvRailsData" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRailsData" OnRowDataBound="gvRailsData_RowDataBound">
                            <Columns>
                                <asp:ImageField DataImageUrlField="PF_Received" DataImageUrlFormatString="../Images/RailsRcv_{0}.png" HeaderText="PF">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="SF_Received" DataImageUrlFormatString="../Images/RailsRcv_{0}.png" HeaderText="SF">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="PR_Received" DataImageUrlFormatString="../Images/RailsRcv_{0}.png" HeaderText="PR">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="SR_Received" DataImageUrlFormatString="../Images/RailsRcv_{0}.png" HeaderText="SR">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:ImageField>
                                <asp:TemplateField HeaderText="T">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgTransomReceived" runat="server" ImageUrl='<%# Eval("T_Received", "../Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsTransom").ToString() = "", 0, Eval("NeedsTransom")) = 1%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PM">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgPMReceived" runat="server" ImageUrl='<%# Eval("PM_Received", "../Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsPortMid").ToString() = "", 0, Eval("NeedsPortMid")) = 1%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SM">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgSMReceived" runat="server" ImageUrl='<%# Eval("SM_Received", "../Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsStrbMid").ToString() = "", 0, Eval("NeedsStrbMid")) = 1%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="CustDrawNo" HeaderText="D#" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsRailsData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [PF_Received], [PR_Received],[SF_Received], [SR_Received], [T_Received], [PM_Received], [SM_Received], [NeedsTransom], [NeedsPortMid], [NeedsStrbMid],[CustDrawNo] FROM [Rails_Tracking] WHERE ([ProdNo] = @ProdNo)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label>
                        <br />
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("DueDate", "{0:M/d}")%>' CssClass="newStyle5"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="Custom">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="IsPilot" DataImageUrlFormatString="../Images/Pilot{0}.png" HeaderText="Pilot">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:BoundField DataField="CurrentStatus" HeaderText="Current Status" />
                <asp:TemplateField HeaderText="Build Dates - Sideline Reasons">
                    <ItemTemplate>
                        <asp:GridView ID="gvBuildDates" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsInternalBuildDates">
                            <Columns>
                                <asp:BoundField DataField="WeldDate" HeaderText="Rails Weld" SortExpression="WeldDate" DataFormatString="{0:M/d}" />
                                <asp:BoundField DataField="OuterScheduled" HeaderText="Outer Tubes" DataFormatString="{0:M/d}" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsInternalBuildDates" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [WeldDate], OuterScheduled, Rails_Tracking.ProdNo FROM [Rails_Tracking] Left join Tubes on Rails_Tracking.ProdNo = Tubes.ProdNo WHERE (Rails_Tracking.ProdNo = @ProdNo)">
                            <SelectParameters>
                                <asp:Parameter Name="ProdNo" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <asp:GridView ID="gvReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsOfflineReasons" Width="600px" AutoGenerateColumns="False" Style="text-align: left">
                            <Columns>
                                <asp:BoundField DataField="Auto" Visible="False" />
                                <asp:BoundField DataField="OfflineNote" HeaderText="Issues">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:M/d}" HeaderText="Added">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ETA" HeaderText="ETA">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ETADate" HeaderText="ETA Entered">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>

                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsOfflineReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date, BML_POPREPORTING_OFFLINE.Cleared, BML_POPREPORTING_OFFLINE.ETA, BML_POPREPORTING_OFFLINE.ETADate FROM BML_POPREPORTING_OFFLINE WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) Order By BML_POPREPORTING_OFFLINE.Date">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:ImageButton ID="btnRedTag" runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoredtag" />

                        <asp:GridView ID="gvOpenRedTags" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatTags" CssClass="newStyle1 auto-style1" Caption="Open Red Tags" Width="600px">
            <Columns>
                <asp:BoundField DataField="RedTagNote" HeaderText="Note" SortExpression="Note" />
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
               <%-- <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnClearRedTag" runat="server" Text="Clear Red Tag" CommandArgument='<%#Eval("Auto") %>' CommandName="clearredtag" />
                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsBoatTags" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [RedTagNote], [Date], Auto FROM [BML_POPREPORTING_REDTAGS] WHERE ([ProdNo] = @ProdNo) and DateCleared is NULL ORDER BY [Auto]">
            <SelectParameters>
                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:GridView ID="gvNotes" runat="server" DataSourceID="sdsBoatNotes" Width="500px" ShowHeader="True" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="Date" DataFormatString="{0:d}" ShowHeader="True" HeaderText="Entered">
                                    <ItemStyle Width="80px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Note" DataFormatString="&lt;div style=&quot;text-transform:capitalize&quot;&gt;{0}&lt;/div&gt;" HtmlEncode="false" ShowHeader="True">
                                    <ItemStyle Width="300px" />
                                </asp:BoundField>
                               
                                <asp:BoundField DataField="ResolvedDate" DataFormatString="{0:d}" HeaderText="Resolved">
                                    <ItemStyle Width="80px" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsBoatNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Note], [Date], ResolvedDate FROM [BML_POPREPORTING_NOTES] WHERE ([ProdNo] = @ProdNo) ORDER BY [Date]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Order Comments">
                    <ItemTemplate>
                        <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsMacola" ShowHeader="false">
                            <Columns>
                                <asp:BoundField DataField="cmt" HeaderText="cmt" SortExpression="cmt" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsMacola" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [cmt] FROM [OELINCMT_SQL] WHERE ([ord_no] = @ord_no)">
                            <SelectParameters>
                                <asp:Parameter Name="ord_no" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "../Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, BML_POPREPORTING_GREENLIGHTS.PopNo, BML_POPREPORTING_GREENLIGHTS.DueDate, BML_POPREPORTING_GREENLIGHTS.SONo, BML_POPREPORTING_GREENLIGHTS.CusNo, BML_POPREPORTING_GREENLIGHTS.CusName, BML_POPREPORTING_GREENLIGHTS.IsCustom, BML_POPREPORTING_GREENLIGHTS.IsPilot, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRails, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CenterTubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded,cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus, BML_POPREPORTING_GREENLIGHTS.IsRedTagged FROM BML_POPREPORTING_GREENLIGHTS WHERE (BML_POPREPORTING_GREENLIGHTS.IsPilot = 1) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '23%' or BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '20%' or BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '21%' or BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '22%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') AND (BML_POPREPORTING_GREENLIGHTS.ProdNo > 2200000) and IsInvoiced = 0 ORDER BY BML_POPREPORTING_GREENLIGHTS.ProdNo">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                <asp:ControlParameter ControlID="ddlShowSelect" Name="RailsInstalledStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="1" />
                <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />
            </SelectParameters>
        </asp:SqlDataSource>

    </form>
</body>
</html>
