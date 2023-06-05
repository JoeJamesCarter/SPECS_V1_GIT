<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EngineAllocations.aspx.vb" Inherits="EngineAllocations" Debug="true" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Engine Allocations</title>
    <style>
        .area {
            text-align: center;
            vertical-align: central;
            font-size: 20px;
            font-family: Calibri;
            font-weight: bold;
        }

            .area caption {
                display: table-caption;
                text-align: left;
                color: blue;
            }

        .title {
            font-family: Calibri;
            font-weight: bold;
            font-size: 30px;
        }

        .subtitle {
            font-family: Calibri;
            font-weight: bold;
            font-size: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:Button ID="Button1" runat="server" Text="Button" Visible="False" />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                <ContentTemplate>
                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                    <asp:Label runat="server" CssClass="title" Text="Boats That Need Rigged - South are Gray, Main are White"></asp:Label><br />
                    <asp:DataList ID="dlSouthWip" CssClass="area" runat="server" DataSourceID="sdsSouthWip" RepeatColumns="8" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="ONLINE IN MAIN AND SOUTH" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="350px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label><br />
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                            <asp:Label ID="Label1" runat="server" Text='<%# "Current Status:  " & Eval("CurrentStatus")%>'></asp:Label><br /><br />
                            <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsMacola" ShowHeader="false" CellPadding="2" CellSpacing="2" HorizontalAlign="Center">
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
                        <SeparatorStyle Height="20px" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsSouthWip" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.ItemNo, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.RiggingStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.RiggingNeeded = 1) ORDER BY BML_POPREPORTING_GREENLIGHTS.ProdNo">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />                                                      
                        </SelectParameters>
                    </asp:SqlDataSource>


                     <asp:DataList ID="dlRailsSouth" CssClass="area" runat="server" DataSourceID="sdsRailsSouth" RepeatColumns="8" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="READY FOR SOUTH TO BRING IN" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="350px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label><br />
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                            <asp:Label ID="Label1" runat="server" Text='<%# "Current Status:  " & Eval("CurrentStatus")%>'></asp:Label><br /><br />
                            <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsMacola" ShowHeader="false" CellPadding="2" CellSpacing="2" HorizontalAlign="Center">
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
                        <SeparatorStyle Height="20px" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsRailsSouth" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRails, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CenterTubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded, BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus, cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus, BML_POPREPORTING_GREENLIGHTS.SwingbackStatus, (CASE WHEN cast(Rails_Tracking.PF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.PF_Received as varchar) END) + (CASE WHEN cast(Rails_Tracking.SF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.SF_Received as varchar) END) as QFrontRailsStatus, (CASE WHEN BML_POPREPORTING.ItemNo Like '%SSB%' or BML_POPREPORTING.ItemNo Like '%GSB%' Then 1 ELSE 0 END) as SBShowFlag, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo LEFT JOIN RAILS_TRACKING on BML_POPREPORTING.PRODNO = RAILS_TRACKING.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus = 1) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'S') AND (BML_POPREPORTING_GREENLIGHTS.FurnitureStatus &gt;= 2) AND (BML_POPREPORTING_GREENLIGHTS.FiberglassStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.CoversStatus &gt;= 1) AND (BML_POPREPORTING_GREENLIGHTS.RailsStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.GaugeStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.HarnessStatus = 2) AND ((BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded = 0) OR (BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded = 1 AND BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus = 2)) AND ((BML_POPREPORTING_GREENLIGHTS.QFrontNeeded = 0) OR (BML_POPREPORTING_GREENLIGHTS.QFrontNeeded = 1 AND BML_POPREPORTING_GREENLIGHTS.QFrontStatus = 2)) AND BML_POPREPORTING_GREENLIGHTS.RiggingNeeded = '1' ORDER BY BML_POPREPORTING_GREENLIGHTS.ProdNo">
                        <SelectParameters>
                             <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />                                
                        </SelectParameters>
                    </asp:SqlDataSource>



                    <asp:DataList ID="dlDecks" CssClass="area" runat="server" DataSourceID="sdsDecks" RepeatColumns="8" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="DECKS OUTSIDE" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="350px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label><br />
                            <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsMacola" ShowHeader="false" CellPadding="2" CellSpacing="2" HorizontalAlign="Center">
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
                        <SeparatorStyle Height="20px" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsDecks" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRails, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CenterTubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded, BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus,cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus,(CASE WHEN cast(Rails_Tracking.PF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.PF_Received as varchar) END) + (CASE WHEN cast(Rails_Tracking.SF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.SF_Received as varchar) END) as QFrontRailsStatus, BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus,BiminiRcvdStatus, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo LEFT JOIN RAILS_TRACKING on BML_POPREPORTING.PRODNO = RAILS_TRACKING.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus = 1) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'S') AND BML_POPREPORTING_GREENLIGHTS.RiggingNeeded = '1' ORDER BY BML_POPREPORTING_GREENLIGHTS.ProdNo">
                        <SelectParameters>
                             <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />                                
                        </SelectParameters>
                    </asp:SqlDataSource>
                    
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
    </form>
</body>
</html>


