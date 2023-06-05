<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OrderDetailsFull.aspx.vb" Inherits="OrderDetailsFull" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ALL BOAT DETAILS</title>
    <style type="text/css">
        #content {
            width: 100%;
        }

        .newStyle1 {
            font-family: calibri;
            font-size: 16px;
        }

        .auto-style2 {
            width: 100%;
        }

        .boatinfoprod {
            font-family: Calibri;
            font-size: 30px;
            font-weight: bold;
            margin-left: 10px;
            float: left;
        }

        .boatinfo {
            font-family: Calibri;
            font-size: 16px;
            margin-left: 10px;
            float: left;
        }

        .spacer {
            font-family: Calibri;
            width: 100px;
        }

        #greenlights {
        }

        #boatinfo {
            float: left;
            width: 500px;
        }

        #MacLines {
            margin-top: 10px;
            width: 400px;
            float: left;
        }

        #notes {
            margin-top: 10px;
            margin-left: 20px;
            width: 620px;
            float: left;
        }

        #boatbasicdetails {
            float: left;
            width: 450px;
            margin-bottom: 10px;
        }

        #content {
            width: 100%;
        }

        caption {
            background-color: #5D7B9D;
            color: White;
            font-size: 14pt;
        }

        #header {
            width: 100%;
        }

        #workstationdates {
            float: left;
            width: 100%
        }

        #tubesandrailrorp {
            width: 600px;
            margin-top: 40px;
            margin-left: 10px;
        }

        #prodpics {
            float: left;
            width: 100%;
        }

        .Thumbs {
            height: 600px;
            width: 800px;
            padding: 10px;
        }

        .Full {
            height: 600px;
            width: 800px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">


        <div id="content">
            <table class="auto-style2">
                <tr>
                    <td>
                        <asp:GridView ID="GridView3" Visible="false" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" CssClass="newStyle1" Width="359px">
                            <Columns>
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ItemNo" HeaderText="Boat" SortExpression="ItemNo">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PanelColor" HeaderText="Panel Color">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="IsPilot" HeaderText="Pilot?">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="IsCustom" HeaderText="Custom?">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>

            <div id="title">
                <asp:Table runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:DataList ID="dlTitle" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting">
                                <ItemTemplate>
                                    <asp:Label ID="lblProd" runat="server" Text='<%#(Eval("ProdNo")) %>' CssClass="boatinfoprod"></asp:Label>&nbsp;&nbsp;&nbsp;<asp:Label ID="Label2" runat="server" Text='<%#(Eval("ItemNo")) %>' CssClass="boatinfoprod"></asp:Label>&nbsp;&nbsp;&nbsp;<asp:Label ID="Label3" runat="server" Text='<%#"Bldg:" & (Eval("BuildLoc")) %>' CssClass="boatinfoprod"></asp:Label>&nbsp;&nbsp;&nbsp;<asp:Label ID="Label8" runat="server" Text='<%#"Yard Loc:" & (Eval("SlotKey")) %>' CssClass="boatinfoprod"></asp:Label>
                                </ItemTemplate>
                            </asp:DataList>
                        </asp:TableCell>
                        <asp:TableCell>

                            <asp:GridView ID="gvGreenlights" runat="server" AutoGenerateColumns="False" HorizontalAlign="Center" DataSourceID="sdsPopReportingByProdNo" CssClass="boatinfo">
                                <Columns>
                                    <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="F">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="FG">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="C">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="R">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="T">
                                    </asp:ImageField>
                                    <asp:TemplateField HeaderText="CT">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgButtonCentertube" runat="server" ImageUrl='<%# Eval("CentertubeStatus", "Images/{0}.png")%>' Visible='<%#Eval("CentertubeNeeded") = 1%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                                    </asp:ImageField>
                                    <asp:TemplateField HeaderText="A/T">
                                        <ItemTemplate>
                                            <asp:Image ID="ArchTower" Visible=' <%# Eval("ArchTowerNeeded") = 1%>' ImageUrl='<%# Eval("ArchTowerStatus", "./Images/{0}.png")%>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Q Front">
                                        <ItemTemplate>
                                            <asp:Image ID="QFront" Visible=' <%# Eval("QFrontNeeded") = 1%>' ImageUrl='<%# Eval("QFrontStatus", "./Images/{0}.png")%>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Q PF|SF">
                                        <ItemTemplate>
                                            <asp:Image ID="QFrontRails" Visible='<%# Eval("QFrontNeeded") = 1%>' ImageUrl='<%# Eval("QFrontRailsStatus", "./Images/{0}.png")%>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <br />
                            <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, BML_POPREPORTING_GREENLIGHTS.SONo, BuildLoc, [FurnitureStatus], [FurniturePrepLastUpdated], [FiberglassStatus], [FiberglassLastUpdated], [CoversStatus], [CoversLastUpdated], [RailsStatus], [RailsLastUpdated], [TubesStatus], [TubesLastUpdated], [CentertubeStatus], [Centertube], [GaugeLastUpdated] , [HarnessLastUpdated], [CentertubeNeeded],cast(GaugeStatus as varchar) + cast(HarnessStatus as varchar) as ElectricalStatus, ArchTowerNeeded, ArchTowerStatus, ArchTower, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, WeldDate, (CASE WHEN cast(Rails_Tracking.PF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.PF_Received as varchar) END) + (CASE WHEN cast(Rails_Tracking.SF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.SF_Received as varchar) END) as QFrontRailsStatus, OuterScheduled, CenterScheduled FROM BML_POPREPORTING_GREENLIGHTS LEFT JOIN RAILS_TRACKING on BML_POPREPORTING_GREENLIGHTS.ProdNo = RAILS_TRACKING.ProdNo Left Join Tubes on BML_POPREPORTING_GREENLIGHTS.ProdNo = Tubes.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.ProdNo = @ProdNo)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:GridView ID="gvRailsData" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRailsData" OnRowDataBound="gvRailsData_RowDataBound" HorizontalAlign="Center" CssClass="boatinfo">
                                <Columns>
                                    <asp:ImageField DataImageUrlField="PF_Received" DataImageUrlFormatString="Images/RailsRcv_{0}.png" HeaderText="PF">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="SF_Received" DataImageUrlFormatString="Images/RailsRcv_{0}.png" HeaderText="SF">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="PR_Received" DataImageUrlFormatString="Images/RailsRcv_{0}.png" HeaderText="PR">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="SR_Received" DataImageUrlFormatString="Images/RailsRcv_{0}.png" HeaderText="SR">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:ImageField>
                                    <asp:TemplateField HeaderText="T">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgTransomReceived" runat="server" ImageUrl='<%# Eval("T_Received", "Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsTransom").ToString() = "", 0, Eval("NeedsTransom")) = 1%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PM">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgPMReceived" runat="server" ImageUrl='<%# Eval("PM_Received", "Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsPortMid").ToString() = "", 0, Eval("NeedsPortMid")) = 1%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SM">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgSMReceived" runat="server" ImageUrl='<%# Eval("SM_Received", "Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsStrbMid").ToString() = "", 0, Eval("NeedsStrbMid")) = 1%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="CustDrawNo" HeaderText="D#" />
                                    <asp:TemplateField HeaderText="Framed?" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgFrames" runat="server" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png")%>' HorizontalAlign="Center" ToolTip='<%# "Framed-" + Eval("FramesInstalled")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                            <asp:SqlDataSource ID="sdsRailsData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [PF_Received], [PR_Received],[SF_Received], [SR_Received], [T_Received], [PM_Received], [SM_Received], [NeedsTransom], [NeedsPortMid], [NeedsStrbMid],[CustDrawNo],[FramesInstalledStatus], FramesInstalled FROM [Rails_Tracking] Left Join BML_POPREPORTING_GREENLIGHTS on Rails_Tracking.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (Rails_Tracking.ProdNo = @ProdNo)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:GridView ID="gvRigging" runat="server" ShowHeader="false" GridLines="none" AutoGenerateColumns="False" DataSourceID="sdsFlags">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnIsCustom" runat="server" Visible='<%# Eval("IsCustom") = 1%>' ImageUrl="Images/custom.png" /><asp:ImageButton ID="bntPilot" runat="server" Visible='<%# Eval("IsPilot") = 1%>' ImageUrl="Images/pilot.png" />
                                            <asp:ImageButton ID="btnRigging" runat="server" Visible='<%# Eval("RiggingNeeded") = 1%>' ImageUrl="Images/rigging.png" />
                                            <asp:ImageButton ID="btnWT" runat="server" Visible='<%# Eval("WavetamerNeeded") = 1%>' ImageUrl="Images/wavetamer.png" />
                                            <asp:ImageButton ID="btnShark" runat="server" Visible='<%# Eval("SharkhideNeeded") = 1%>' ImageUrl="Images/sharkhide.png" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsFlags" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT IsCustom, IsPilot, WavetamerNeeded, SharkhideNeeded, RiggingNeeded FROM BML_POPREPORTING_GREENLIGHTS WHERE (BML_POPREPORTING_GREENLIGHTS.SONo = @ord_no)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Button ID="btnDrawing" runat="server" Text="Drawing" />
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Button ID="btnHelp" runat="server" Text="Have a SPECS Question/Suggestion?" />
                        </asp:TableCell>

                    </asp:TableRow>
                </asp:Table>

            </div>

            <div id="workstationdates">
                <br />
                <asp:GridView ID="gvOverview" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsWorkstationDates" CellPadding="5" PageSize="45" AllowPaging="True" Caption="Workstation Completions">
                    <Columns>
                        <asp:ImageField DataImageUrlField="FloorsInstalledStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Floors">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:ImageField DataImageUrlField="TrimStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Trim">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:ImageField DataImageUrlField="RailsInstalledStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Rails">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:ImageField DataImageUrlField="FurnitureInstalledStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Furniture">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:ImageField DataImageUrlField="HelmInstalledStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Helm">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:ImageField DataImageUrlField="CleaningStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Inspection">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:ImageField DataImageUrlField="FinalInspectionStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Final">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:ImageField DataImageUrlField="ShrinkwrapStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Shrink-Wrap">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:TemplateField HeaderText="Rigging">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnRigging" Enabled="false" runat="server" Visible=' <%# Eval("RiggingNeeded") = 1%>' ImageUrl='<%# Eval("RiggingStatus", "./Images/complete_status{0}.png")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Wavetamer">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnWaveTamer" Enabled="false" runat="server" Visible=' <%# Eval("WavetamerNeeded") = 1%>' ImageUrl='<%# Eval("WavetamerStatus", "./Images/complete_status{0}.png")%>' AlternateText='Wavetamer' ToolTip='Wavetamer' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sharkhide">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnSharkhide" Enabled="false" runat="server" Visible=' <%# Eval("SharkhideNeeded") = 1%>' ImageUrl='<%# Eval("SharkhideStatus", "./Images/complete_status{0}.png")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:ImageField DataImageUrlField="CompleteStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Complete">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:TemplateField HeaderText="Offline">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "./Images/boatstatus{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotooffline" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tube Damage">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnTubeDamage" runat="server" ImageUrl='<%# Eval("HasTubeDamage", "./Images/tubedamage{0}.png")%>' CommandArgument='<%# Eval("ProdNo") & ";" & Eval("ItemNo")%>' CommandName="gototubedamage" />
                            </ItemTemplate>
                        </asp:TemplateField>
                          <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName = "gotonotes" />
                    </ItemTemplate>
                </asp:TemplateField>
                    </Columns>
                    <PagerSettings PageButtonCount="15" />
                    <RowStyle Height="50px" />
                </asp:GridView>

                <asp:SqlDataSource ID="sdsWorkstationDates" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, BML_POPREPORTING_GREENLIGHTS.PopNo, BML_POPREPORTING_GREENLIGHTS.CusNo, BML_POPREPORTING_GREENLIGHTS.CusName, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.SharkhideNeeded, BML_POPREPORTING_GREENLIGHTS.WavetamerNeeded, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FurniturePrepLastUpdated, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.TrimStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, FinalInspection, Complete, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.RiggingNeeded, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, HasTubeDamage, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.SONo, Convert(date,BML_POPREPORTING_GREENLIGHTS.DueDate) as DateDue, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes,cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded, BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus,(CASE WHEN cast(Rails_Tracking.PF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.PF_Received as varchar) END) + (CASE WHEN cast(Rails_Tracking.SF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.SF_Received as varchar) END) as QFrontRailsStatus, FloorsInstalled, RailsInstalled, HelmInstalled, FurnitureInstalled, Trim, Cleaning, SharkhideInstalled, Shrinkwrap, WavetamerInstalled FROM BML_POPREPORTING_GREENLIGHTS LEFT JOIN RAILS_TRACKING on BML_POPREPORTING_GREENLIGHTS.PRODNO = RAILS_TRACKING.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.ProdNo = @ProdNo) ORDER BY Convert(integer,BML_POPREPORTING_GREENLIGHTS.ProdNo)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
            </div>

            <div id="boatbasicdetails">
                <asp:DataList ID="dlBasicBoatDetails" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting">
                    <ItemTemplate>
                        <asp:Label ID="lblProd" runat="server" Text='<%#(Eval("ProdNo")) %>' Visible="false"></asp:Label>
                        <asp:Table runat="server">
                        </asp:Table>

                        </div>
                            <div id="boatinfo">
                                <asp:FormView ID="BuildInfo" runat="server" DataSourceID="sdsGetPPORDFILInfo" Width="1200px" CssClass="boatinfo">
                                    <ItemTemplate>
                                        <asp:Table ID="Table1" runat="server">
                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">
                                                    Model:
                                                </asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("item_no")%>'></asp:Label>&nbsp;-&nbsp;
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("item_desc_1") %>'></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell CssClass="spacer"></asp:TableCell>
                                            </asp:TableHeaderRow>

                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Dealer:</asp:TableCell>

                                                <asp:TableCell CssClass="data">
                                                    <asp:Label ID="Dealer" runat="server" Text='<%# Eval("cus_name") %>'></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>

                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Build Date:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("due_dt", "{0:d}")%>'></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>


                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">POP#:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("ord_no") %>'></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>

                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">SO#:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("src_ord_no") %>'></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>

                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">S/N:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:Label ID="Label4" runat="server" Text='<%#Eval("user_def_fld_5") %>'></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>

                                            <asp:TableHeaderRow>
                                                <asp:TableCell>
                                                    **********
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    ********************************
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>


                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Panel Color:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:GridView ID="gvPanelColor" ShowHeader="false" GridLines="None" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGetPanelColor">
                                                        <Columns>
                                                            <asp:BoundField DataField="item_desc_1" HeaderText="Panel Color" SortExpression="item_desc_1" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:TableCell>
                                                <asp:TableCell CssClass="spacer"></asp:TableCell>

                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Accent Panel:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:GridView ID="gvAccentPanel" ShowHeader="false" GridLines="None" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGetAccentPanel">
                                                        <Columns>
                                                            <asp:BoundField DataField="item_desc_1" HeaderText="Accent Panel" SortExpression="item_desc_1" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:TableCell>
                                                <asp:TableCell CssClass="spacer"></asp:TableCell>
                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Trim Accent:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:GridView ID="gvTrimAccent" ShowHeader="false" GridLines="None" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTrimAccent">
                                                        <Columns>
                                                            <asp:BoundField DataField="item_desc_1" HeaderText="Trim Accent" SortExpression="item_desc_1" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Base Vinyl:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:GridView ID="gvBaseVinyl" runat="server" ShowHeader="false" GridLines="none" AutoGenerateColumns="False" DataSourceID="sdsBaseVinyl">
                                                        <Columns>
                                                            <asp:BoundField DataField="item_desc_1" HeaderText="Interior Accent" SortExpression="item_desc_1" />
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblBVPart" runat="server" Text='<%#Eval("item_no") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:TableCell>
                                                <asp:TableCell CssClass="spacer"></asp:TableCell>

                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Interior Accent:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:GridView ID="gvInteriorAccent" runat="server" ShowHeader="false" GridLines="none" AutoGenerateColumns="False" DataSourceID="sdsInteriorAccent">
                                                        <Columns>
                                                            <asp:BoundField DataField="item_desc_1" HeaderText="Interior Accent" SortExpression="item_desc_1" />
                                                            <asp:TemplateField>
                                                            <ItemTemplate>
                                                                    <asp:Label ID="lblIntAccPart" runat="server" Text='<%#Eval("item_no") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:TableCell>
                                                <asp:TableCell CssClass="spacer"></asp:TableCell>

                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Furniture:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:GridView ID="gvFurniture" runat="server" ShowHeader="false" GridLines="None" AutoGenerateColumns="False" DataSourceID="sdsFurniture">
                                                        <Columns>
                                                            <asp:BoundField DataField="item_desc_1" HeaderText="Canvas" SortExpression="item_desc_1" />
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                    <asp:Label ID="lblFurnPart" runat="server" Text='<%#Eval("item_no") %>'></asp:Label>
                                                                </ItemTemplate>
                                                        </asp:TemplateField>
                                                        </Columns>                                                    
                                                        
                                                    </asp:GridView>
                                                </asp:TableCell>
                                                <asp:TableCell CssClass="spacer"></asp:TableCell>

                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Canvas:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:GridView ID="gvCanvas" runat="server" ShowHeader="false" GridLines="none" AutoGenerateColumns="False" DataSourceID="sdsCanvas">
                                                        <Columns>
                                                            <asp:BoundField DataField="item_desc_1" HeaderText="Canvas" SortExpression="item_desc_1" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Flooring:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:GridView ID="gvFlooring" runat="server" ShowHeader="false" GridLines="None" AutoGenerateColumns="False" DataSourceID="sdsFlooring">
                                                        <Columns>
                                                            <asp:BoundField DataField="item_desc_1" HeaderText="Pre-Rig" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:TableCell>
                                                <asp:TableCell ColumnSpan="3" HorizontalAlign="Center">
                                                    
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Graphics:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:GridView ID="gvGraphics" runat="server" ShowHeader="false" GridLines="None" AutoGenerateColumns="False" DataSourceID="sdsGraphics">
                                                        <Columns>
                                                            <asp:BoundField DataField="item_desc_1" HeaderText="Graphics" SortExpression="item_desc_1" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Pre-Rig</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:GridView ID="gvPreRig" runat="server" ShowHeader="false" GridLines="None" AutoGenerateColumns="False" DataSourceID="sdsPreRig">
                                                        <Columns>
                                                            <asp:BoundField DataField="item_desc_1" HeaderText="Pre-Rig" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow>
                                                <asp:TableCell CssClass="descriptions">Engine:</asp:TableCell>
                                                <asp:TableCell CssClass="data">
                                                    <asp:GridView ID="gvEngine" runat="server" ShowHeader="false" GridLines="None" AutoGenerateColumns="False" DataSourceID="sdsEngine">
                                                        <Columns>
                                                            <asp:BoundField DataField="item_desc_1" HeaderText="Engine" SortExpression="item_desc_1" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow>
                                                <asp:TableCell>

                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>
                                        </asp:Table>
                                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataSourceID="sdsOEOLINCMT" Caption="Macola Comments" Width="400px">
                                            <Columns>
                                                <asp:BoundField DataField="cmt" HeaderText="Comments" SortExpression="cmt" />
                                            </Columns>
                                        </asp:GridView>
                                        <asp:GridView ID="gvOECMTHST" runat="server" ShowHeader="false" AutoGenerateColumns="False" CssClass="newStyle1" DataSourceID="sdsOECMTHST" Caption="Macola Comment History" Width="400px">
                                            <Columns>
                                                <asp:BoundField DataField="cmt" HeaderText="Comments" SortExpression="cmt" />
                                            </Columns>
                                        </asp:GridView>

                                    </ItemTemplate>
                                </asp:FormView>
                                <asp:SqlDataSource ID="sdsGetPPORDFILInfo" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [ord_no], [item_desc_2], [item_desc_1], [item_no], [due_dt], [cus_no], [cus_name], [src_ord_no], [user_def_fld_1], [user_def_fld_5] FROM [PPORDFIL_SQL] WHERE ([user_def_fld_1] = @ProdNo)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="lblProd" Name="ProdNo" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sdsGetPanelColor" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat)) UNION Select [item_desc_1] FROM [OELINHST_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                        <asp:Parameter DefaultValue="H1" Name="prod_cat" Type="String" />
                                    </SelectParameters>

                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="sdsGetAccentPanel" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat)) UNION Select [item_desc_1] FROM [OELINHST_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                        <asp:Parameter DefaultValue="H3A" Name="prod_cat" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="sdsTrimAccent" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat)) UNION Select [item_desc_1] FROM [OELINHST_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                        <asp:Parameter DefaultValue="H1P" Name="prod_cat" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="sdsBaseVinyl" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1],[item_no] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat)) UNION Select [item_desc_1],[item_no] FROM [OELINHST_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                        <asp:Parameter DefaultValue="H1V" Name="prod_cat" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="sdsCanvas" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat)) UNION Select [item_desc_1] FROM [OELINHST_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                        <asp:Parameter DefaultValue="H5" Name="prod_cat" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="sdsGraphics" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat)) UNION Select [item_desc_1] FROM [OELINHST_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                        <asp:Parameter DefaultValue="H3G" Name="prod_cat" Type="String" />
                                        <asp:Parameter DefaultValue="H3U" Name="prod_cat1" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="sdsPreRig" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT OEORDLIN_SQL.item_desc_1 FROM [OEORDLIN_SQL] Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = @ord_no AND IMITMIDX_SQL.mat_cost_type = 'PRE') UNION Select OELINHST_SQL.item_desc_1 FROM [OELINHST_SQL] Left Join IMITMIDX_SQL on OELINHST_SQL.item_no = IMITMIDX_SQL.item_no WHERE (OELINHST_SQL.ord_no = @ord_no AND IMITMIDX_SQL.mat_cost_type = 'PRE')">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="sdsPerfPkg" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT OEORDLIN_SQL.item_desc_1 FROM [OEORDLIN_SQL] Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = @ord_no AND (IMITMIDX_SQL.mat_cost_type = 'A2T' or IMITMIDX_SQL.mat_cost_type = 'A2P') UNION Select OELINHST_SQL.item_desc_1 FROM [OELINHST_SQL] Left Join IMITMIDX_SQL on OELINHST_SQL.item_no = IMITMIDX_SQL.item_no WHERE (OELINHST_SQL.ord_no = @ord_no AND (IMITMIDX_SQL.mat_cost_type = 'A2T' or IMITMIDX_SQL.mat_cost_type = 'A2P')">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="sdsFurniture" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT OEORDLIN_SQL.item_desc_1, OEORDLIN_SQL.item_no FROM [OEORDLIN_SQL] Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = @ord_no AND IMITMIDX_SQL.mat_cost_type = 'A0V') UNION Select OELINHST_SQL.item_desc_1, OELINHST_SQL.item_no FROM [OELINHST_SQL] Left Join IMITMIDX_SQL on OELINHST_SQL.item_no = IMITMIDX_SQL.item_no WHERE (OELINHST_SQL.ord_no = @ord_no AND IMITMIDX_SQL.mat_cost_type = 'A0V')">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="sdsInteriorAccent" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1],[item_no] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat)) UNION Select [item_desc_1],[item_no] FROM [OELINHST_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                        <asp:Parameter DefaultValue="H1I" Name="prod_cat" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="sdsEngine" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat)) UNION Select [item_desc_1] FROM [OELINHST_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                        <asp:Parameter DefaultValue="EN%" Name="prod_cat" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="sdsFlooring" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT OEORDLIN_SQL.item_desc_1 FROM [OEORDLIN_SQL] Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = @ord_no AND IMITMIDX_SQL.mat_cost_type = 'A1') UNION Select OELINHST_SQL.item_desc_1 FROM [OELINHST_SQL] Left Join IMITMIDX_SQL on OELINHST_SQL.item_no = IMITMIDX_SQL.item_no WHERE (OELINHST_SQL.ord_no = @ord_no AND IMITMIDX_SQL.mat_cost_type = 'A1')">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <div id="MacLines">
                <asp:GridView ID="gvOrderLinesMac" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataSourceID="sdsOEORDLIN" Width="100%" Caption="Order Lines From Macola">
                    <Columns>
                        <asp:BoundField DataField="item_no" HeaderText="Item #" SortExpression="item_no">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="item_desc_1" HeaderText="Desc" SortExpression="item_desc_1">
                            <ItemStyle Width="200px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="qty_ordered" HeaderText="Qty" SortExpression="qty_ordered" DataFormatString="{0:#,#.###}">
                            <ItemStyle Width="30px" HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <asp:GridView ID="gvOELINHST" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataSourceID="sdsOELINHST" Width="100%" Caption="Order Lines From Macola - Invoiced">
                    <Columns>
                        <asp:BoundField DataField="item_no" HeaderText="Item #" SortExpression="item_no">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="item_desc_1" HeaderText="Desc" SortExpression="item_desc_1">
                            <ItemStyle Width="200px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="qty_ordered" HeaderText="Qty" SortExpression="qty_ordered" DataFormatString="{0:#,#.###}">
                            <ItemStyle Width="30px" HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <br />

                <asp:GridView ID="gvKittedParts" runat="server" Caption="Kitted Parts" CssClass="newStyle1" DataSourceID="sdsKitting" AutoGenerateColumns="False" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="comp_item_no" HeaderText="Item #">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="item_desc_1" HeaderText="Desc">
                            <ItemStyle Width="200px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="qty_per_par" HeaderText="Qty" DataFormatString="{0:#,#.###}">
                            <ItemStyle Width="30px" HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <br />
            </div>
            <div id="notes">
                <asp:GridView ID="gvNotes" runat="server" DataSourceID="sdsBoatNotes" Width="600px" ShowHeader="false" AutoGenerateColumns="False" CssClass="newStyle1" Caption="SPECS Notes">
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
                        <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:GridView ID="gvReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsOfflineReasons" Width="600px" AutoGenerateColumns="False" CssClass="newStyle1" Style="text-align: left" Caption="Side Lined Reasons - Open Issues in Yellow">
                    <Columns>
                        <asp:BoundField DataField="Auto" Visible="False" />
                        <asp:BoundField DataField="OfflineNote">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Date" DataFormatString="{0:d}">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ETA" HeaderText="ETA">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ETADate" HeaderText="ETA Entered">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DateCleared" HeaderText="Cleared">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsOfflineReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date, BML_POPREPORTING_OFFLINE.Cleared, DateCleared, BML_POPREPORTING_OFFLINE.ETA, BML_POPREPORTING_OFFLINE.ETADate FROM BML_POPREPORTING_OFFLINE WHERE (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) Order By Cleared, BML_POPREPORTING_OFFLINE.Date">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:GridView ID="gvRedTags" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20" Width="600px" Caption="Red Tags" ShowHeader="false">
                    <Columns>
                        <asp:TemplateField HeaderText="Red Tag">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnRedTag" runat="server" ImageUrl='<%# Eval("IsRedTagged", "Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo") %>' Enabled="True" CommandName="gotoredtag"  />
                            </ItemTemplate>
                            <ItemStyle Width="20%" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Reason" ItemStyle-Width="80%">
                            <ItemTemplate>
                                <asp:GridView ID="gvRedTagReasons" runat="server" GridLines="Both" ShowHeader="True" AutoGenerateColumns="False" DataSourceID="sdsRedTagReasons" Width="100%">
                                    <Columns>
                                         <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" ShowHeader="False">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Date" HeaderText="Entered" SortExpression="Date" ShowHeader="False">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="RedTagNote" HeaderText="Reason" SortExpression="RedTagNote" ShowHeader="False">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DateCleared" HeaderText="Cleared" SortExpression="DateCleared" ShowHeader="True">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsRedTagReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT ProdNo, [Date], [RedTagNote], [DateCleared] FROM [BML_POPREPORTING_REDTAGS] WHERE ([ProdNo] = @ProdNo)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>

                            <ItemStyle Width="75%"></ItemStyle>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />
                 <asp:GridView ID="gvRGAs" runat="server" DataSourceID="sdsRGAs" AutoGenerateColumns="False" Width="600px" Caption="Veada RGA's - Open Items " CssClass="newStyle1" Style="text-align: left" OnRowDataBound="gvRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Date_Added" DataFormatString="{0:d}" HeaderText="Date Added" />     
                                    <asp:BoundField DataField="Date_Picked_Up" DataFormatString="{0:d}" HeaderText="Veada Picked Up" />     
                                    <asp:BoundField DataField="RGA_Item_Desc" />
                                    <asp:BoundField DataField="VeadaStatus" HeaderText="Veada Status" />
                                    <asp:BoundField DataField="BenRcvdDate" DataFormatString="{0:d}" HeaderText="Ben Rcvd" />                                    
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,RGA_Item_Desc,Qty,BenRcvd,BenRcvdDate,DeliveredToLine,Date_Added, Date_Picked_Up, CASE When RGAs.Loaded = '1' Then 'Loaded' WHEN RGAs.Sewing = '1' Then 'Sewing' WHEN RGAs.Cutting = '1' Then 'Cutting' WHEN RGAs.Torn_Down = '1' Then 'Torn Down' END as VeadaStatus FROM RGAs WHERE Trim(ProdNo) = ?ProdNo Order By BenRcvd">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                           <asp:GridView ID="gvIntRGAs" runat="server" DataSourceID="sdsIntRGAs" AutoGenerateColumns="False" Width="600px" Caption="Internal Veada RGA's" CssClass="newStyle1" Style="text-align: left" OnRowDataBound="gvIntRGAs_RowDataBound"> 
                                <Columns>
                                    <asp:BoundField DataField="Part" />
                                    <asp:BoundField DataField="VeadaStatus" HeaderText="Veada Status" />
                                </Columns>
                            </asp:GridView>
                           <asp:SqlDataSource ID="sdsIntRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="Select AutoID, ProdNo, Model, Part, Color, Qty, Reason, DamagedBy, Status, DateEntered, Resolved, DateResolved, DeliveredToLine, CASE When Resolved = '0' Then 'Not Started' WHEN Resolved = '1' Then 'In Progress' WHEN Resolved = '3' Then 'Needs Sent Back' WHEN Resolved = '2' Then 'Complete' END as VeadaStatus FROM InternalRGAs WHERE ProdNo = @ProdNo">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvBOs" runat="server" DataSourceID="sdsBOs" AutoGenerateColumns="False" CellPadding="2" CellSpacing="2" Width="600px" BorderColor="#3366FF" Caption="Veada BO's - Open Issues in Yellow" CssClass="newStyle1" Style="text-align: left" OnRowDataBound="gvBOs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Date_Added" DataFormatString="{0:d}" HeaderText="Date Added" />
                                    <asp:BoundField DataField="BO_Item_Desc" />
                                    <asp:BoundField DataField="Date_Cleared" DataFormatString="{0:d}" HeaderText="Date Cleared" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,BO_Item_Desc,DeliveredToLine,Cleared,Date_Cleared, Date_Added FROM Backorders WHERE Trim(ProdNo) = ?ProdNo Order By Cleared">
                                <SelectParameters>
                                   <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                <asp:PlaceHolder ID="phRecliner" runat="server"></asp:PlaceHolder>
                <asp:PlaceHolder ID="phBench" runat="server"></asp:PlaceHolder>
            </div>
          
            <div id="tubesandrailrorp">                
                <asp:GridView ID="gvTubeDamageHistory" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTubeDamageHistory" Width="1000px" Caption="Tube Damage Reported" CssClass="newStyle1">
                    <Columns>
                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" />
                        <asp:BoundField DataField="Tube" HeaderText="Tube" SortExpression="Tube" />

                        <asp:TemplateField HeaderText="Predicted Action">
                            <ItemTemplate>
                                <asp:Label ID="Label13" runat="server" Text='<%#Eval("PortPredictedAction")%>'></asp:Label>
                                <asp:Label ID="Label14" runat="server" Text='<%#Eval("StrbPredictedAction")%>'></asp:Label>
                                <asp:Label ID="Label15" runat="server" Text='<%#Eval("CtrPredictedAction")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Damage Desc">
                            <ItemTemplate>
                                <asp:Label ID="Label13" runat="server" Text='<%#Eval("PortDmgDesc")%>'></asp:Label>
                                <asp:Label ID="Label14" runat="server" Text='<%#Eval("StrbDmgDesc")%>'></asp:Label>
                                <asp:Label ID="Label15" runat="server" Text='<%#Eval("CtrDmgDesc")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ReportedBy" HeaderText="Reported By" SortExpression="ReportedBy" />
                        <asp:BoundField DataField="DateReported" HeaderText="Date Reported" SortExpression="DateReported" />
                        <asp:BoundField DataField="EvaluatedBy" HeaderText="Evaluated By" SortExpression="EvaluatedBy" />
                        <asp:BoundField DataField="DateEvaluated" HeaderText="Date Evaluated" SortExpression="DateEvaluated" />
                        <asp:BoundField DataField="ActionRequired" HeaderText="Action Required" SortExpression="ActionRequired" />
                        <asp:BoundField DataField="Repaired" HeaderText="Repaired" SortExpression="Repaired" />
                        <asp:BoundField DataField="Replaced" HeaderText="Replaced" SortExpression="Replaced" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsTubeDamageHistory" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Tubes_DamageReported] WHERE ([ProdNo] = @ProdNo) ORDER BY [DateReported]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:GridView ID="gvRailRepairs" runat="server" DataSourceID="sdsRailRepairs" CssClass="newStyle1 auto-style1" Width="1000px" AutoGenerateColumns="False" Caption="Rail Repairs">
                    <Columns>
                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                        <asp:BoundField DataField="DateReq" HeaderText="Date Requested">
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
                <asp:GridView ID="gvRailReorders" runat="server" DataSourceID="sdsRailsReorders" CssClass="newStyle1 auto-style1" Width="1000px" AutoGenerateColumns="False" Caption="Rail Reorders">
                    <Columns>
                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                        <asp:BoundField DataField="DateReq" HeaderText="Date Requested">
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
                <asp:SqlDataSource ID="sdsRailRepairs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [PF], [SF], [PR], [SR], [T], [PM], [SM], [Note], [DateReq], [Status], [StatusDate], [ReReceived], [ReReceivedDate],[TYPE] FROM [Rails_RepairsReorders] WHERE (ProdNo = @ProdNo) and Type = 'Repair' ORDER BY [Auto]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="sdsRailsReorders" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [PF], [SF], [PR], [SR], [T], [PM], [SM], [Note], [DateReq], [Status], [StatusDate], [ReReceived], [ReReceivedDate],[TYPE] FROM [Rails_RepairsReorders] WHERE (ProdNo = @ProdNo) and Type = 'Reorder' ORDER BY [Auto]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnProdNo" Name="ProdNo" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <div id="prodpics">
                <br />
                <asp:Button ID="btnRetreiveProdPocs" runat="server" Text="Show Prod Pics" /><br /><br />
                <asp:Image ID="Image1" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image2" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image3" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image4" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image5" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image6" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image7" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image8" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image9" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image10" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image11" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image12" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image13" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image14" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image15" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image16" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image17" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image18" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image19" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image20" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image21" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image22" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image23" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image24" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image25" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image26" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image27" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image28" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image29" CssClass="Thumbs" runat="server" />
                <asp:Image ID="Image30" CssClass="Thumbs" runat="server" />

            </div>
            <br />
        </div>

        <asp:HiddenField ID="hdnSONo" runat="server" />
        <asp:HiddenField ID="hdnSONoSkip2LeadingZeros" runat="server" />
        <asp:HiddenField ID="hdnBoatYear" runat="server" />
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, [ItemNo], [PanelColor], [IsPilot], [IsCustom], BuildLoc, IsRedTagged, SlotKey FROM [BML_POPREPORTING_GREENLIGHTS] Left JOIN Yard_Master_Locations on BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo WHERE ([SONo] = @SONo)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnSONo" Name="SONo" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsOEORDLIN" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT OEORDLIN_SQL.item_no, [ord_no], IMITMIDX_SQL.item_desc_1, [qty_ordered], OEORDLIN_SQL.user_def_fld_3, OEORDLIN_SQL.prod_cat FROM [OEORDLIN_SQL] Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = @ord_no) Order By IMITMIDX_SQL.item_desc_1">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnSONo" Name="ord_no" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
          <asp:SqlDataSource ID="sdsOELINHST" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT OELINHST_SQL.item_no, [ord_no], IMITMIDX_SQL.item_desc_1, [qty_ordered], OELINHST_SQL.user_def_fld_3 FROM [OELINHST_SQL] Left Join IMITMIDX_SQL on OELINHST_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = @ord_no) Order By IMITMIDX_SQL.item_desc_1">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnSONo" Name="ord_no" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="sdsOEOLINCMT" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [cmt] FROM [OELINCMT_SQL] WHERE ([ord_no] = @ord_no) Order By  line_seq_no desc, OELINCMT_SQL.cmt_seq_no">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnSONo" Name="ord_no" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="sdsOECMTHST" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [cmt] FROM [OECMTHST_SQL] WHERE ([real_ord_no] = @ord_no) Order By  line_seq_no desc, OECMTHST_SQL.cmt_seq_no">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnSONo" Name="ord_no" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="sdsKitting" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT IMKITFIL_SQL.comp_item_no, IMKITFIL_SQL.qty_per_par, IMITMIDX_SQL.item_desc_1 From [IMKITFIL_SQL] Left join OEORDLIN_SQL on OEORDLIN_SQL.item_no = IMKITFIL_SQl.item_no left join IMITMIDX_SQL on IMKITFIL_SQL.comp_item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = @ord_no) and right(IMITMIDX_SQL.item_desc_1,3) <>'DIS'">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnSONo" Name="ord_no" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hdnBoatModel" runat="server" />
        <asp:HiddenField ID="hdnCustomDrawingNo" runat="server" />
        <asp:HiddenField ID="hdnSerialPart" runat="server" />
        <asp:HiddenField ID="hdnProdNo" runat="server" />
        <asp:HiddenField ID="hdnBVPart" runat="server" />
        <asp:HiddenField ID="hdnFurnPart" runat="server" />
        <asp:HiddenField ID="hdnAccentPart" runat="server" />
        <br />
    </form>
</body>
</html>

