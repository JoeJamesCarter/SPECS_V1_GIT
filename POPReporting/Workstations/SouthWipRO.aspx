<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SouthWipRO.aspx.vb" Inherits="Workstations_SouthWipRO" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>SOUTH - WIP RO</title>

    <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">SOUTH-WIP RO</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-southwip.aspx" -->
                    </asp:TableCell>
                    <asp:TableCell>
                         <asp:CheckBox ID="cbRails" runat="server" Text="Show Rails Data - (Click Refresh)" AutoPostBack ="True"/>
                    </asp:TableCell>

                    <%--  <asp:TableCell>
                        <asp:Chart ID="Chart1" runat="server" DataSourceID="sdsWIP" Height="187px" Width="331px">
                            <Series>
                                <asp:Series Name="Series1" ChartType="Pie" XValueMember="Series" YValueMembers="Total" IsValueShownAsLabel="True" LabelForeColor="White" LabelBorderWidth="2" Label="#VALX #PERCENT{p0}" LegendText="#VALX (#VALY)"></asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend>
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                        <asp:SqlDataSource ID="sdsWIP" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Series, Count(BML_POPREPORTING.ProdNo) as Total FROM BML_POPREPORTING LEFT JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2) AND (BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus = 2 or IsDeckInside = 1) AND (BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'S') Group By Series"></asp:SqlDataSource>
        </div>

        </asp:TableCell>
        <asp:TableCell>
            <asp:Chart ID="Chart2" runat="server" DataSourceID="sdsIOTwinOther" Height="187px" Width="331px">
                <Series>
                    <asp:Series Name="Series1" ChartType="Pie" IsValueShownAsLabel="True" LabelForeColor="White" LabelBorderWidth="2" Label="#VALX #PERCENT{p0}" LegendText="#VALX (#VALY)" XValueMember="ModelType" YValueMembers="Total"></asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                </ChartAreas>
                <Legends>
                    <asp:Legend>
                    </asp:Legend>
                </Legends>
            </asp:Chart>
            <asp:SqlDataSource ID="sdsIOTwinOther" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Case When BML_POPREPORTING.ItemNo like '%IO%' Then 'IO' When BML_POPREPORTING.ItemNo like '%X2%' then 'Twin' Else 'Other' END as ModelType, Count(Case When BML_POPREPORTING.ItemNo like '%IO%' Then 'IO' When BML_POPREPORTING.ItemNo like '%X2%' then 'Twin' Else 'Other' END) as Total FROM BML_POPREPORTING LEFT JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2) AND (BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus = 2 or IsDeckInside = 1) AND (BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'S') Group By Case When BML_POPREPORTING.ItemNo like '%IO%' Then 'IO' When BML_POPREPORTING.ItemNo like '%X2%' then 'Twin' Else 'Other' END "></asp:SqlDataSource>
            
            </div>
      
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
                <asp:TemplateField HeaderText="A/T">
                    <ItemTemplate>
                        <asp:Image ID="ArchTower" Visible=' <%# Eval("ArchTowerNeeded") = 1%>' ImageUrl='<%# Eval("ArchTowerStatus", "../Images/{0}.png") %>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="HelmBuildStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="HELM" ItemStyle-HorizontalAlign="Center">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:ImageField>
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
                <asp:BoundField DataField="CurrentStatus" HeaderText="Current Status" />
                <asp:TemplateField HeaderText="Sidelined Reasons">
                    <ItemTemplate>
                        <asp:GridView ID="gvReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsOfflineReasons" Width="600px" AutoGenerateColumns="False" Style="text-align: left">
                            <Columns>
                                <asp:BoundField DataField="Auto" Visible="False" />
                                <asp:BoundField DataField="OfflineNote">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:d}">
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
                                <asp:TemplateField HeaderText="Clear">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnClear" runat="server" ImageUrl='<%# Eval("Cleared", "../Images/cleared{0}.png")%>' CommandArgument='<%# Eval("Auto")%>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <br />
                        <div id="railgrids" runat="server">
                            <asp:GridView ID="GridView1" runat="server" DataSourceID="sdsRailRepairs" CssClass="newStyle1 auto-style1" Width="1000px" AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                    <asp:BoundField DataField="DateReq" HeaderText="Repair Requested">
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PF" HeaderText="PF">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SF" HeaderText="SF">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PR" HeaderText="PR">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SR" HeaderText="SR">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="T" HeaderText="T">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PM" HeaderText="PM">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SM" HeaderText="SM">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Note" HeaderText="Notes" />
                                    <asp:BoundField DataField="Status" HeaderText="Status">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StatusDate" HeaderText="Status Date">
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ReReceived" HeaderText="Re-Rcvd">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ReReceivedDate" HeaderText="Re-Rcvd Date">
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <br />
                            <asp:GridView ID="GridView2" runat="server" DataSourceID="sdsRailsReorders" CssClass="newStyle1 auto-style1" Width="1000px" AutoGenerateColumns="False" OnRowDataBound="GridView2_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                    <asp:BoundField DataField="DateReq" HeaderText="Reorder Requested">
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PF" HeaderText="PF">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SF" HeaderText="SF">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PR" HeaderText="PR">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SR" HeaderText="SR">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="T" HeaderText="T">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PM" HeaderText="PM">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SM" HeaderText="SM">
                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Note" HeaderText="Notes" />
                                    <asp:BoundField DataField="Status" HeaderText="Status">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StatusDate" HeaderText="Status Date">
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ReReceived" HeaderText="Re-Rcvd">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ReReceivedDate" HeaderText="Re-Rcvd Date">
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <asp:SqlDataSource ID="sdsOfflineReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date, BML_POPREPORTING_OFFLINE.Cleared, BML_POPREPORTING_OFFLINE.ETA, BML_POPREPORTING_OFFLINE.ETADate FROM BML_POPREPORTING_OFFLINE WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) Order By BML_POPREPORTING_OFFLINE.Date">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsRailRepairs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [PF], [SF], [PR], [SR], [T], [PM], [SM], [Note], [DateReq], [Status], [StatusDate], [ReReceived], [ReReceivedDate],[TYPE] FROM [Rails_RepairsReorders] WHERE (ProdNo = @ProdNo) and Type = 'Repair' ORDER BY [Auto]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="sdsRailsReorders" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [PF], [SF], [PR], [SR], [T], [PM], [SM], [Note], [DateReq], [Status], [StatusDate], [ReReceived], [ReReceivedDate],[TYPE] FROM [Rails_RepairsReorders] WHERE (ProdNo = @ProdNo) and Type = 'Reorder' ORDER BY [Auto]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Open Notes">
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
                        <asp:SqlDataSource ID="sdsBoatNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Note], [Date] FROM [BML_POPREPORTING_NOTES] WHERE ([ProdNo] = @ProdNo) and Resolved is Null ORDER BY [Date]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotooffline" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="70px" />
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
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRails, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CenterTubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded, BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus,cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus = @RailsInstalledStatus or IsDeckInside = 1) AND (BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.ProdLineID = 1) ORDER BY BML_POPREPORTING_GREENLIGHTS.ProdNo">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                <asp:ControlParameter ControlID="ddlShowSelect" Name="RailsInstalledStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="1" />
                <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />                

            </SelectParameters>
        </asp:SqlDataSource>

    </form>
</body>
</html>
