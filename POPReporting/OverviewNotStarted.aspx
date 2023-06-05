<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OverviewNotStarted.aspx.vb" Inherits="OverviewNotStarted" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Overview - Boats Not Started</title>
    <style type="text/css">
        .newStyle1 {
            font-family: calibri;
            font-size: 14px;
        }

        .newStyle2 {
            font-family: Calibri;
            font-weight: bold;
            font-size: large;
        }

        .table-subheader {
            font-family: Calibri;
            color: green;
            font-size: 18px;
            font-weight: bold;
        }

        .newStyle7 {
            font-family: calibri;
            font-size: 14px;
            font-weight: bold;
            width: 100%;
        }

        .auto-style1 {
        }

        .auto-style2 {
            margin-left: 4px;
        }

        .auto-style3 {
        }

        .auto-style4 {
        }

        .nottakingboats {
            background-color: yellow;
        }
    </style>

</head>
<body>


    <form id="form1" runat="server">
        <div>

            <div class="newStyle7">

                <asp:Table ID="Table1" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Image ID="Image1" runat="server" ImageUrl="Images/logo-smaller.png" />
                        </asp:TableCell>
                        <asp:TableCell>
                            Search By Prod #:<asp:TextBox ID="tbSearchProdNo" runat="server" AutoPostBack="True" CssClass="auto-style1" Height="22px" Width="83px"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnClearProdNo" runat="server" Text="Clear" />
                        </asp:TableCell>
                        <asp:TableCell>
                            SO #<asp:TextBox ID="tbSONo" runat="server" AutoPostBack="True" CssClass="auto-style2" Width="83px"></asp:TextBox>
                            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnClearSO" runat="server" Text="Clear" />
                        </asp:TableCell>
                        <asp:TableCell>
                            Customer:
                <asp:TextBox ID="tbSearchCusName" runat="server" AutoPostBack="True" CssClass="auto-style3" Height="22px" Width="83px"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnClearnCusName" runat="server" Text="Clear" />
                        </asp:TableCell>
                        <asp:TableCell>
                            Boat Model:
                <asp:TextBox ID="tbSearchModel" runat="server" AutoPostBack="True" CssClass="auto-style4" Height="22px" Width="83px"></asp:TextBox>
                            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnClearModel" runat="server" Text="Clear" />
                        </asp:TableCell>
                        <asp:TableCell>
                            &nbsp;&nbsp; Show:
                <asp:DropDownList ID="ddlBldg" runat="server" AutoPostBack="True">
                    <asp:ListItem Value="%">All</asp:ListItem>
                    <asp:ListItem Value="M">Main</asp:ListItem>
                    <asp:ListItem Value="V">Value</asp:ListItem>
                    <asp:ListItem Value="S">South</asp:ListItem>
                    <asp:ListItem Value="P">Paint</asp:ListItem>
                </asp:DropDownList>
                        </asp:TableCell>
                        <asp:TableCell>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                        </asp:TableCell>
                        <%--<asp:TableCell>
                             Main
                            <asp:Chart ID="Chart1" runat="server" DataSourceID="sdsMain" Height="187px" Width="331px" ImageLocation="Charts/ChartPic_#SEQ(300,3)" ImageStorageMode="UseImageLocation">
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
                            <asp:SqlDataSource ID="sdsMain" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Series, Count(BML_POPREPORTING.ProdNo) as Total FROM BML_POPREPORTING LEFT JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo WHERE BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 AND BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus < 2 AND BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'M' Group By Series"></asp:SqlDataSource>

                        </asp:TableCell>
                        <asp:TableCell>
                            South
                            <asp:Chart ID="Chart3" runat="server" DataSourceID="sdsWIP" Height="187px" Width="331px" ImageLocation="Charts/ChartPic_#SEQ(300,3)" ImageStorageMode="UseImageLocation">
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
                            <asp:SqlDataSource ID="sdsWIP" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Series, Count(BML_POPREPORTING.ProdNo) as Total FROM BML_POPREPORTING LEFT JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo WHERE BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 AND BML_POPREPORTING_GREENLIGHTS.BUILDLOC ='S' and BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus < 2 and IsDeckInside = 0 Group By Series"></asp:SqlDataSource>

                        </asp:TableCell>--%>

                        <%-- <asp:TableCell>
                            <asp:Chart ID="Chart4" runat="server" DataSourceID="sdsIOTwinOther" Height="187px" Width="331px" ImageLocation="Charts/ChartPic_#SEQ(300,3)" ImageStorageMode="UseImageLocation">
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
                            <asp:SqlDataSource ID="sdsIOTwinOther" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Case When BML_POPREPORTING.ItemNo like '%IO%' Then 'IO' When BML_POPREPORTING.ItemNo like '%X2%' then 'Twin' Else 'Other' END as ModelType, Count(Case When BML_POPREPORTING.ItemNo like '%IO%' Then 'IO' When BML_POPREPORTING.ItemNo like '%X2%' then 'Twin' Else 'Other' END) as Total FROM BML_POPREPORTING LEFT JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2) AND ((BML_POPREPORTING_GREENLIGHTS.BUILDLOC ='S' and (BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus <2 and IsDeckInside = 0)) OR (BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus < 2) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'M')) Group By Case When BML_POPREPORTING.ItemNo like '%IO%' Then 'IO' When BML_POPREPORTING.ItemNo like '%X2%' then 'Twin' Else 'Other' END "></asp:SqlDataSource>
                        </asp:TableCell>--%>
                        <asp:TableCell>
                            <asp:Label ID="Label4" runat="server" Text="# Decks Outside:"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="NumDecksOutside" runat="server" Text=""></asp:Label><br />
                            <asp:Label ID="Label6" runat="server" Text="# South Ready To Bring In:"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblReadyCount" runat="server" Text=""></asp:Label><br />
                            <asp:Label ID="Label5" runat="server" Text="# South Decks Brought In Today:"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="NumDecksBroughtIn" runat="server" Text=""></asp:Label>
                        </asp:TableCell>

                    </asp:TableRow>
                </asp:Table>

                <br />
                <asp:GridView ID="gvOverview" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsPopReporting" CellPadding="5" PageSize="100" AllowPaging="True">
                    <Columns>
                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo">
                            <ItemStyle Font-Bold="True" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SONo" HeaderText="SO #">
                            <ItemStyle Font-Bold="True" />
                        </asp:BoundField>
                        <asp:ImageField DataImageUrlField="IsCustom" HeaderText="C" DataImageUrlFormatString="./Images/ovcustom{0}.png">
                        </asp:ImageField>
                        <asp:ImageField DataImageUrlField="IsPilot" HeaderText="P" DataImageUrlFormatString="./Images/ovpilot{0}.png">
                        </asp:ImageField>
                        <asp:BoundField DataField="DateDue" HeaderText="Due Date" DataFormatString="{0:d}">
                            <ItemStyle Font-Bold="True" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="F">
                            <ItemTemplate>
                                <asp:Image ID="imgFurnitureStatus" runat="server" ImageUrl='<%# Eval("FurnitureStatus", "./Images/{0}.png") %>' AlternateText='Furniture' ToolTip='<%# "F-" + Eval("FurniturePrepLastUpdated")%>' /><br />
                                <asp:Label ID="lblVeadaDate" runat="server" Text="Label"></asp:Label><br />
                                <asp:Label ID="lblVeadaTruck" runat="server" Text="Label"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="FG">
                            <ItemTemplate>
                                <asp:Image ID="imgFiberglassStatus" runat="server" ImageUrl='<%# Eval("FiberglassStatus", "./Images/{0}.png")%>' AlternateText='Fiberglass' ToolTip='<%# "FG-" + Eval("FiberglassLastUpdated")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="C">
                            <ItemTemplate>
                                <asp:Image ID="imgCoverStatus" runat="server" ImageUrl='<%# Eval("CoversStatus", "./Images/{0}.png")%>' AlternateText='Canvas' ToolTip='<%# "C-" + Eval("CoversLastUpdated")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="R">
                            <ItemTemplate>
                                <asp:Image ID="imgRailsStatus" runat="server" ImageUrl='<%# Eval("RailsStatus", "./Images/{0}.png")%>' AlternateText='Rails' ToolTip='<%# "R-" + Eval("RailsLastUpdated")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="T">
                            <ItemTemplate>
                                <asp:Image ID="imgTubeStatus" runat="server" ImageUrl='<%# Eval("TubesStatus", "./Images/{0}.png")%>' AlternateText='Tubes' ToolTip='<%# "T-" + Eval("TubesLastUpdated")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="CT">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnCentertube" Enabled="false" runat="server" Visible=' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("CentertubeStatus")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="G|H">
                            <ItemTemplate>
                                <asp:Image ID="imgElectricalStatus" runat="server" ImageUrl='<%# Eval("ElectricalStatus", "./Images/{0}.png")%>' AlternateText='Gauge/Harness' ToolTip='<%# "G-" + Eval("GaugeLastUpdated") + "  H-" + Eval("HarnessLastUpdated")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Q Front">
                            <ItemTemplate>
                                <asp:Image ID="QFront" Visible=' <%# Eval("QFrontNeeded") = 1%>' ImageUrl='<%# Eval("QFrontStatus", "./Images/{0}.png")%>' runat="server" ToolTip='<%# "Q Front-" + Eval("QFront")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Q PF|SF">
                            <ItemTemplate>
                                <asp:Image ID="QFrontRails" Visible='<%# Eval("QFrontNeeded") = 1%>' ImageUrl='<%# Eval("QFrontRailsStatus", "./Images/{0}.png")%>' runat="server" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="A/T">
                            <ItemTemplate>
                                <asp:Image ID="ArchTower" Visible=' <%# Eval("ArchTowerNeeded") = 1 And Eval("ArchTowerStatus") < 4%>' ImageUrl='<%# Eval("ArchTowerStatus", "./Images/{0}.png")%>' runat="server" ToolTip='<%# "A/T-" + Eval("ArchTower")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="HELM">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnHelm" Enabled="false" runat="server" ImageUrl='<%# Eval("HelmBuildStatus", "./Images/{0}.png")%>' ToolTip='<%# "Helm - " + Eval("HelmBuild")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="FGI">
                            <ItemTemplate>
                                <asp:Image ID="imgFiberglassInspStatus" runat="server" ImageUrl='<%# Eval("FiberglassInspStatus", "./Images/{0}.png")%>' AlternateText='Fiberglass' ToolTip='<%# "FG Inspected-" + Eval("FiberglassInsp")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Bimini">
                            <ItemTemplate>
                                <asp:Image ID="Bimini" Visible=' <%# Eval("ArchTowerNeeded") = 0 Or Eval("ArchTowerStatus") = 4%>' ImageUrl='<%# Eval("BiminiRcvdStatus", "./Images/{0}.png")%>' runat="server" ToolTip='<%# "Bimini-" + Eval("BiminiRcvd")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SB">
                            <ItemTemplate>
                                <asp:Image ID="Swingback" Visible=' <%# Eval("SBShowFlag") = 1%>' ImageUrl='<%# Eval("SwingbackStatus", "./Images/{0}.png") %>' runat="server" ToolTip='<%# "Swingback -" + Eval("Swingback")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Eng">
                            <ItemTemplate>
                                <asp:Image ID="Engine" Visible=' <%# Eval("RiggingNeeded") = 1%>' ImageUrl='<%# Eval("EngineStatus", "./Images/{0}.png") %>' runat="server" ToolTip='<%# "Engine -" + Eval("Engine")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Kit Status">
                            <ItemTemplate>
                                <asp:Table runat="server" BorderStyle="Solid" GridLines="both">
                                    <asp:TableHeaderRow>
                                        <asp:TableCell>
                                                K1
                                        </asp:TableCell>
                                        <asp:TableCell>
                                                K2
                                        </asp:TableCell>
                                        <asp:TableCell>
                                                K3
                                        </asp:TableCell>
                                        <asp:TableCell>
                                                K4
                                        </asp:TableCell>
                                    </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>
                                            <asp:Image ID="imgK1Status" runat="server" ImageUrl='<%# Eval("Kitting1Status", "./Images/{0}.png")%>' ToolTip='<%# "K1-" + Eval("Kitting1")%>' />
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Image ID="imgK2Status" runat="server" ImageUrl='<%# Eval("Kitting2Status", "./Images/{0}.png")%>' ToolTip='<%# "K2-" + Eval("Kitting2")%>' />
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Image ID="imgK3Status" runat="server" ImageUrl='<%# Eval("Kitting3Status", "./Images/{0}.png")%>' ToolTip='<%# "K3-" + Eval("Kitting3")%>' />
                                        </asp:TableCell>
                                        <asp:TableCell>
                                            <asp:Image ID="imgK4Status" runat="server" ImageUrl='<%# Eval("Kitting4Status", "./Images/{0}.png")%>' ToolTip='<%# "K1-" + Eval("Kitting4")%>' />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <asp:Label ID="Label3" runat="server" Text="All Kits Rcvd (S):" Visible=' <%# Eval("BuildLoc") = "S"%>'></asp:Label>
                                <asp:Image ID="AllKitsRcvd1" ImageUrl='<%# Eval("AllKitsRcvd", "./Images/{0}.png")%>' Visible=' <%# Eval("BuildLoc") = "S"%>' runat="server" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Indiv Rails">
                            <ItemTemplate>
                                <asp:GridView ID="gvRailsData" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRailsData" OnRowDataBound="gvOverview_RowDataBound">
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
                                        <asp:TemplateField HeaderText="Requested">
                                            <ItemTemplate>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <br />
                                <asp:Label ID="lblCovidNotTaking" CssClass="nottakingboats" runat="server" Text=""></asp:Label>
                                <asp:SqlDataSource ID="sdsRailsData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [PF_Received], [PR_Received],[SF_Received], [SR_Received], [T_Received], [PM_Received], [SM_Received], [NeedsTransom], [NeedsPortMid], [NeedsStrbMid],[CustDrawNo], [Requested], [RailsStatus], [BuildLoc] FROM [Rails_Tracking]left join BML_POPREPORTING_GREENLIGHTS on Rails_Tracking.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (Rails_Tracking.ProdNo = @ProdNo)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvOverview" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Frames">
                            <ItemTemplate>
                                <asp:Image ID="imgFramesInstalledStatus" runat="server" ImageUrl='<%# Eval("FramesInstalledStatus", "./Images/{0}.png")%>' SortExpression="FramesInstalledStatus" AlternateText='Frames' ToolTip='<%# "Frames-" + Eval("FramesInstalled")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" CssClass="newStyle2" Text='<%# Eval("ItemNo") %>'></asp:Label>
                                <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                                <asp:ImageButton ID="ImageButton3" runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotofullorderdetails" ImageUrl="./Images/getfullboatdetails.png" />
                                <br />
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>'><br/></asp:Label>Dlr #:
                                <asp:Label ID="lblCusNo" runat="server" Text='<%# Eval("CusNo") %>' Visible="true"></asp:Label>
                                <br />

                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Floors">
                            <ItemTemplate>
                                <asp:Image ID="imgFloorsInstalledStatus" runat="server" ImageUrl='<%# Eval("FloorsInstalledStatus", "./Images/complete_status{0}.png")%>' AlternateText='Floors' ToolTip='<%# "Floors-" + Eval("FloorsInstalled")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:ImageField DataImageUrlField="TrimStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Trim">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:TemplateField HeaderText="Notes">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotonotes" />
                            </ItemTemplate>
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
                                <asp:SqlDataSource ID="sdsBoatNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Note], [Date] FROM [BML_POPREPORTING_NOTES] WHERE ([ProdNo] = @ProdNo) and Resolved is NULL ORDER BY [Date]">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvOverview" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Macola Rig Cmts"> 
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
                                <br />
                                <asp:Label ID="Label8" runat="server" Text="" Visible='<%# Eval("RiggingNeeded") = 1 %>'>Line #:</asp:Label>
                                <asp:Label ID="lblPoLineNo" runat="server" Text="" Visible='<%# Eval("RiggingNeeded") = 1 %>'></asp:Label><asp:Label ID="Label9" runat="server" Text="On PO #" Visible='<%# Eval("RiggingNeeded") = 1 %>'></asp:Label><asp:Label ID="lblEngPO" runat="server" Text="" Visible='<%# Eval("RiggingNeeded") = 1 %>'></asp:Label><br />
                                <asp:Label ID="Label7" runat="server" Text="ETA:" Visible='<%# Eval("RiggingNeeded") = 1 %>'></asp:Label>
                                <asp:Label ID="lblETA" runat="server" Text="" Visible='<%# Eval("RiggingNeeded") = 1 %>'></asp:Label>


                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerSettings PageButtonCount="15" />
                    <RowStyle Height="50px" />
                </asp:GridView>

                <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.ItemNo, BML_POPREPORTING.SharkhideNeeded, BML_POPREPORTING.WavetamerNeeded, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FurniturePrepLastUpdated, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus ,  BML_POPREPORTING_GREENLIGHTS.FiberglassInspStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassInsp, BML_POPREPORTING_GREENLIGHTS.FiberglassLastUpdated, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.SONo, BML_POPREPORTING_GREENLIGHTS.CoversLastUpdated, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.RailsLastUpdated, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.TubesLastUpdated, BML_POPREPORTING_GREENLIGHTS.Centertube, BML_POPREPORTING_GREENLIGHTS.GaugeLastUpdated, BML_POPREPORTING_GREENLIGHTS.HarnessLastUpdated, BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus, BML_POPREPORTING_GREENLIGHTS.HelmBuild, BML_POPREPORTING_GREENLIGHTS.GaugeStatus, BML_POPREPORTING_GREENLIGHTS.HarnessStatus, BML_POPREPORTING_GREENLIGHTS.QFront,BML_POPREPORTING_GREENLIGHTS.ArchTower, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalled, BML_POPREPORTING_GREENLIGHTS.Trim, BML_POPREPORTING_GREENLIGHTS.TrimStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.RiggingNeeded, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.SONo, Convert(date,BML_POPREPORTING_GREENLIGHTS.DueDate) as DateDue, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes,cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded, BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus, KITTING1STATUS, KITTING2STATUS, KITTING3STATUS, KITTING4STATUS, Kitting1, Kitting2, Kitting3, Kitting4, (CASE WHEN cast(Rails_Tracking.PF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.PF_Received as varchar) END) + (CASE WHEN cast(Rails_Tracking.SF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.SF_Received as varchar) END) as QFrontRailsStatus, BML_POPREPORTING_GREENLIGHTS.GaugeLastUpdated, BML_POPREPORTING_GREENLIGHTS.HarnessLastUpdated, AllKitsRcvd, BiminiRcvdStatus, BiminiRcvd, BML_POPREPORTING_GREENLIGHTS.SwingbackStatus, (CASE WHEN BML_POPREPORTING.ItemNo Like '%SB%' Then 1 ELSE 0 END) as SBShowFlag, Swingback, EngineStatus, Engine FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo LEFT JOIN RAILS_TRACKING on BML_POPREPORTING.PRODNO = RAILS_TRACKING.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.CusName LIKE '%' + @SearchCusName + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchModel + '%')AND (BML_POPREPORTING_GREENLIGHTS.SoNo LIKE '%' + @SearchSO + '%') AND ((BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'M' and FloorsInstalledStatus < 2 ) OR (BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'V' and FloorsInstalledStatus < 2 ) or (BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'S' and RailsInstalledStatus < 2 and IsDeckInside = 0) or (BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'P' and RailsInstalledStatus < 2 and IsDeckInside = 0)) AND BML_POPREPORTING_GREENLIGHTS.BUILDLOC  Like '%' + @BuildLocation + '%' ORDER BY Convert(integer,BML_POPREPORTING.ProdNo)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tbSearchProdNo" Name="Search" DefaultValue='%' Type="String" />
                        <asp:ControlParameter ControlID="tbSearchCusName" Name="SearchCusName" DefaultValue='%' Type="String" />
                        <asp:ControlParameter ControlID="tbSearchModel" Name="SearchModel" DefaultValue='%' Type="String" />
                        <asp:ControlParameter ControlID="tbSoNo" Name="SearchSO" DefaultValue='%' Type="String" />
                        <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </div>
    </form>

</body>
</html>
