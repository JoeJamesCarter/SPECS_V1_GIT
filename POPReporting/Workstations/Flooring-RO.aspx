<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Flooring-RO.aspx.vb" Inherits="Workstations_Flooring_RO" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>FLOORING</title>

    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .duedate {
            font-size: 12px;
            font-weight: bold;
            font-family: calibri;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">FLOORING</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="wstoolbar-frames.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">

            <ContentTemplate>

                <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                <asp:GridView ID="gvFloors" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
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

                        <asp:TemplateField HeaderText="A/T">
                            <ItemTemplate>
                                <asp:Image ID="ArchTower" Visible=' <%# Eval("ArchTowerNeeded") = 1%>' ImageUrl='<%# Eval("ArchTowerStatus", "../Images/{0}.png") %>' runat="server" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="FGI">
                            <ItemTemplate>
                                <asp:Image ID="imgFiberglassInspStatus" runat="server" ImageUrl='<%# Eval("FiberglassInspStatus", "../Images/{0}.png")%>' AlternateText='Fiberglass' ToolTip='<%# "FG Inspected-" + Eval("FiberglassInsp")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="HELM">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnHelm" Enabled="false" runat="server" ImageUrl='<%# Eval("HelmBuildStatus", "../Images/{0}.png")%>' ToolTip='<%# "Helm - " + Eval("HelmBuild")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                                      
                        <asp:TemplateField HeaderText="SB">
                            <ItemTemplate>
                                <asp:Image ID="Swingback" Visible=' <%# Eval("SBShowFlag") = 1%>' ImageUrl='<%# Eval("SwingbackStatus", "../Images/{0}.png") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:ImageField DataImageUrlField="FramesInstalledStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="Framed?">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:TemplateField HeaderText="Boat/Customer">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                                <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                                <br />
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label>
                                <br />
                                <asp:Label ID="Label4" runat="server" CssClass="duedate" Text="Due: "></asp:Label><asp:Label ID="Label3" runat="server" Text='<%# Eval("DueDate", "{0:d}")%>' CssClass="duedate"></asp:Label>
                                <br />
                                <asp:ImageButton ID="btnTransport" runat="server" ImageUrl='<%# Eval("Status", "../Images/requested{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gototransport" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="Custom">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:TemplateField HeaderText="Options">
                            <ItemTemplate>
                                <asp:GridView ID="gvFlooringOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsFloors">
                                    <Columns>
                                        <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:BoundField>                                        
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsFabOptionsFloors" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter))">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="gvFloors" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                        <asp:Parameter DefaultValue="Flooring" Name="Workcenter" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                               <%--  Tube Diameter:<asp:Label ID="lblDiameter" runat="server" Text=""></asp:Label><br />
                                 Perf Pkg:<asp:Label ID="lblPerf" runat="server" Text=""></asp:Label><br />
                                 HP:<asp:Label ID="lblHP" runat="server" Text=""></asp:Label><br />--%>
                                 

                                <asp:GridView ID="gvFabOptionsSSLadder" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsPopReportingFabOptionsSSLadder" Width="100%" CssClass="newStyle3">
                                    <Columns>
                                        <asp:BoundField DataField="Option_Desc" HeaderText="Fab Options" SortExpression="Option_Desc" ShowHeader="False">
                                            <ControlStyle BorderStyle="None" />
                                            <FooterStyle BorderStyle="None" />
                                            <HeaderStyle BorderStyle="None" Height="10px" />
                                            <ItemStyle BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Middle" BackColor="Yellow" Font-Bold="True" ForeColor="Black" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsPopReportingFabOptionsSSLadder" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [PopNo], [Option_Item], [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE ([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter) AND (Option_Item Like '906641%' or Option_Item Like '906649%' or Option_Item Like '111111%') ORDER BY [Option_Desc]">
                                    <SelectParameters>
                                        <asp:Parameter Name="ProdNo" Type="String" />
                                        <asp:Parameter DefaultValue="RailsInstall" Name="Workcenter" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                              
                                <asp:GridView ID="gvTubeData" runat="server" GridLines="Both" ShowHeader="True" AutoGenerateColumns="False" DataSourceID="sdsTubeData" Width="100%" Caption="Cap Tag Tube Info">
                                    <Columns>
                                        <asp:BoundField DataField="Diameter" HeaderText="Diameter" ShowHeader="True">
                                            <ControlStyle BorderStyle="None" />
                                            <FooterStyle BorderStyle="None" />
                                            <HeaderStyle BorderStyle="None" Height="10px" />
                                            <ItemStyle BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:BoundField>                                     
                                       
                                        <asp:BoundField DataField="MegaPan" HeaderText="MegaPan" ShowHeader="True">
                                            <ControlStyle BorderStyle="None" />
                                            <FooterStyle BorderStyle="None" />
                                            <HeaderStyle BorderStyle="None" Height="10px" />
                                            <ItemStyle BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:BoundField>                                     

                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsTubeData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Diameter, Style, Case When MegaPan = 'M' then 'Yes' else 'No' end as MegaPan FROM [OuterTubeDetails] WHERE ([ProdNo] = @ProdNo) ">
                                    <SelectParameters>
                                        <asp:Parameter Name="ProdNo" Type="String" />                                        
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                  <asp:GridView ID="gvPossibleTags" runat="server" Caption="Capacity Tags"></asp:GridView>

                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Floors">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnUpdateFloors" runat="server" Enabled=' <%# Eval("FloorsInstalledStatus") >= 1%>' ImageUrl='<%# Eval("FloorsInstalledStatus", "../Images/framescomplete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Offline">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnOffline" runat="server" Enabled=' <%# Eval("FloorsInstalledStatus") >= 1%>' ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotostatus" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Notes">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "../Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />
                                <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesFloors") = 1%>' ImageUrl='<%# Eval("NotesFloors", "../Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerSettings PageButtonCount="20" />
                    <RowStyle Height="50px" />
                </asp:GridView>
                <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.SoNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesFloors, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, BML_POPREPORTING_GREENLIGHTS.BuildLoc,BML_POPREPORTING_GREENLIGHTS.CenterTubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded, BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus, cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus, BML_POPREPORTING_GREENLIGHTS.SwingbackStatus, BML_POPREPORTING_GREENLIGHTS.DueDate, (CASE WHEN BML_POPREPORTING.ItemNo Like '%SB%' Then 1 ELSE 0 END) as SBShowFlag, FiberglassInspStatus, FiberglassInsp, HelmBuildStatus, HelmBuild, (CASE WHEN Status is Null Then 0 ELSE Status END) as Status FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join TransportReqs on BML_POPREPORTING.ProdNo = TransportReqs.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus = @FloorsInstalledStatus) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.BuildLoc LIKE '%' + @BuildLocation + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND ((BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S') or ((BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' or BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V') and (BML_POPREPORTING_GREENLIGHTS.FurnitureStatus &gt;= 2) AND (BML_POPREPORTING_GREENLIGHTS.FiberglassStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.CoversStatus &gt;= 1) AND (BML_POPREPORTING_GREENLIGHTS.RailsStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.GaugeStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.HarnessStatus = 2))) ORDER BY BML_POPREPORTING_GREENLIGHTS.ProdNo">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                        <asp:ControlParameter ControlID="ddlShowSelect" Name="FloorsInstalledStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                        <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                        <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                        <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ContentTemplate>

        </asp:UpdatePanel>
    </form>
</body>
</html>
