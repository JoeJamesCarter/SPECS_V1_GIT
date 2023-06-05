<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Decks.aspx.vb" Inherits="Workstations_Decks" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

         <title> DECKS - OUTSIDE</title>

    <link href = "../StyleSheet.css" rel="stylesheet" />
</head>
<body>
         <form id = "form1" runat="server">
        <div>
         <asp:Table ID = "tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">DECKS - OUTSIDE</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-decks.aspx" -->
                    </asp:TableCell>
                    <%-- <asp:TableCell>
                        <asp:Chart ID="Chart3" runat="server" DataSourceID="sdsWIP" Height="187px" Width="331px" ImageLocation="../Charts/ChartPic_#SEQ(300,3)" ImageStorageMode="UseImageLocation">
            <Series>
                <asp:Series Name="Series1" ChartType="Pie" XValueMember="Series" YValueMembers="Total" IsValueShownAsLabel="True" LabelForeColor="White" LabelBorderWidth="2" Label="#VALX #PERCENT{p0}" LegendText ="#VALX (#VALY)" ></asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
            </ChartAreas>
         <Legends>
             <asp:Legend>

             </asp:Legend>
         </Legends>
        </asp:Chart>
        <asp:SqlDataSource ID="sdsWIP" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Series, Count(BML_POPREPORTING.ProdNo) as Total FROM BML_POPREPORTING LEFT JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2) AND (BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2) AND (BML_POPREPORTING_GREENLIGHTS.IsDeckInside = 0) AND (BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus < 2) AND (BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.TrimStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'S') Group By Series"></asp:SqlDataSource></div>
 
                    </asp:TableCell>--%>
                    <%--<asp:TableCell>
             <asp:Chart ID="Chart4" runat="server" DataSourceID="sdsIOTwinOther" Height="187px" Width="331px" ImageLocation="../Charts/ChartPic_#SEQ(300,3)" ImageStorageMode="UseImageLocation">
            <Series>
                <asp:Series Name="Series1" ChartType="Pie" IsValueShownAsLabel="True" LabelForeColor="White" LabelBorderWidth="2" Label="#VALX #PERCENT{p0}" LegendText ="#VALX (#VALY)" XValueMember="ModelType" YValueMembers="Total"></asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
            </ChartAreas>
         <Legends>
             <asp:Legend>

             </asp:Legend>
         </Legends>
        </asp:Chart>
        <asp:SqlDataSource ID="sdsIOTwinOther" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Case When BML_POPREPORTING.ItemNo like '%IO%' Then 'IO' When BML_POPREPORTING.ItemNo like '%X2%' then 'Twin' Else 'Other' END as ModelType, Count(Case When BML_POPREPORTING.ItemNo like '%IO%' Then 'IO' When BML_POPREPORTING.ItemNo like '%X2%' then 'Twin' Else 'Other' END) as Total FROM BML_POPREPORTING LEFT JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2) AND (BML_POPREPORTING_GREENLIGHTS.IsDeckInside = 0) AND (BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus = 1) AND (BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.TrimStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'S') Group By Case When BML_POPREPORTING.ItemNo like '%IO%' Then 'IO' When BML_POPREPORTING.ItemNo like '%X2%' then 'Twin' Else 'Other' END "></asp:SqlDataSource></div>
       
        </asp:TableCell>--%>
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
                <asp:TemplateField HeaderText="Q Front">
                    <ItemTemplate>
                        <asp:Image ID="QFront" Visible=' <%# Eval("QFrontNeeded") = 1%>' ImageUrl='<%# Eval("QFrontStatus", "../Images/{0}.png") %>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PF|SF">
                    <ItemTemplate>
                        <asp:Image ID="QFrontRails" Visible='<%# Eval("QFrontNeeded") = 1%>' ImageUrl='<%# Eval("QFrontRailsStatus", "../Images/{0}.png") %>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="A/T">
                    <ItemTemplate>
                        <asp:Image ID="ArchTower" Visible=' <%# Eval("ArchTowerNeeded") = 1%>' ImageUrl='<%# Eval("ArchTowerStatus", "../Images/{0}.png") %>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="HelmBuildStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="HELM" ItemStyle-HorizontalAlign="Center">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:ImageField>
                <asp:TemplateField HeaderText="Bimini">
                    <ItemTemplate>
                        <asp:Image ID="BimRcvd" Visible=' <%# Eval("ArchTowerNeeded") = 0 or Eval("ArchTowerStatus") = 4 %>' ImageUrl='<%# Eval("BiminiRcvdStatus", "../Images/{0}.png")%>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Kits">
                    <ItemTemplate>
                        <asp:Image ID="AllKitsRcvd" ImageUrl='<%# Eval("AllKitsRcvd", "../Images/{0}.png")%>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="SB">
                    <ItemTemplate>
                        <asp:Image ID="Swingback" Visible=' <%# Eval("SBNeeded") = 1%>' ImageUrl='<%# Eval("SwingbackStatus", "../Images/{0}.png") %>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="Custom">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="IsPilot" DataImageUrlFormatString="../Images/Pilot{0}.png" HeaderText="Pilot">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Options">
                    <ItemTemplate>
                        <asp:GridView ID="gvRailsOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsRails" OnRowDataBound="gvRailsOptions_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsFabOptionsRails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc], [Option_Item] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter))">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                <asp:Parameter DefaultValue="RailsInstall" Name="Workcenter" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Update">
                    <ItemTemplate>
                        <div class="newStyle2">
                            <asp:RadioButtonList ID="rblDeckLoc" runat="server" SelectedValue='<%# Bind("IsDeckInside")%>' RepeatDirection="Horizontal">
                                <asp:ListItem Value="0">Outside</asp:ListItem>
                                <asp:ListItem Value="1">Inside</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div class="newStyle2">
                            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnUpdateDeckLoc" runat="server" Text="Update" CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateBringOnline" />
                        </div>
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Middle" Width="300px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:GridView ID="gvNotes" runat="server" DataSourceID="sdsBoatNotes" Width="500px" ShowHeader="false" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="Note" DataFormatString="&lt;div style=&quot;text-transform:capitalize&quot;&gt;{0}&lt;/div&gt;" HtmlEncode="false" ShowHeader="False">
                                    <ItemStyle Width="300px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:d}" ShowHeader="False">
                                    <ItemStyle Width="80px" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsBoatNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Note], [Date] FROM [BML_POPREPORTING_NOTES] WHERE ([ProdNo] = @ProdNo) ORDER BY [Date]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
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
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, SwingbackStatus, SBNeeded, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRails, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CenterTubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded, BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus,cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus,(CASE WHEN cast(Rails_Tracking.PF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.PF_Received as varchar) END) + (CASE WHEN cast(Rails_Tracking.SF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.SF_Received as varchar) END) as QFrontRailsStatus, BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus,BiminiRcvdStatus, AllKitsRcvd, IsDeckInside FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo LEFT JOIN RAILS_TRACKING on BML_POPREPORTING.PRODNO = RAILS_TRACKING.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.TrimStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus <> 2) AND (IsDeckInside = @IsDeckInside) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') ORDER BY BML_POPREPORTING_GREENLIGHTS.ProdNo">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                <asp:ControlParameter ControlID="ddlShowSelect" Name="IsDeckInside" PropertyName="SelectedValue" Type="Int32" DefaultValue="1" />
                <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />
            </SelectParameters>
        </asp:SqlDataSource>

    </form>
</body>
</html>
