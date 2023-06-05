<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OverviewByDealer.aspx.vb" Inherits="OverviewByDealer" Debug="true" MaintainScrollPositionOnPostback="True" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Overview By Dealer</title>
    <link href="StyleSheet.css" rel="stylesheet" />
    <style>
        .boatinfoboattuberepair {
            font-family: Calibri;
            font-size: 16px;
            font-weight: bold;
            color: red;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
           <%-- <asp:Label runat="server" CssClass="newStyle4" Text="Overview By Dealer"></asp:Label>&nbsp;<asp:Label ID="Label1" runat="server" Text="  Light green means in progress or could be started" CssClass="newStyle6"></asp:Label>&nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="MaintainDlrRtnFromCovidDates.aspx" CssClass="newStyle1">Maintain Dlr Return Dates</asp:HyperLink>--%>
            <%--<asp:DataList ID="DataList1" runat="server">
                <ItemTemplate>
                    <asp:Label ID="lblCusNo" runat="server" CssClass="newStyle4" Text='<%#Eval("CusNo")%>'></asp:Label>
                    <asp:Label ID="Label2" runat="server" CssClass="newStyle4" Text='<%#Eval("CusName") %>'></asp:Label>
                </ItemTemplate>
            </asp:DataList>--%>
            <asp:DataList ID="dlDealersWBoats" runat="server" CssClass="newStyle1" RepeatColumns="1" BorderStyle="Solid" SeparatorStyle-Height="40px" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" BackColor="#CCCCCC" BorderColor="#999999" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" GridLines="Both">
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <ItemStyle BorderWidth="2px" BorderStyle="Solid" Height="100px" Width="150px" BackColor="White"></ItemStyle>
                <ItemTemplate>
                    <asp:Label ID="lblCusNo" runat="server" CssClass="newStyle4" Text='<%#Eval("CusNo")%>'></asp:Label>
                    <asp:Label ID="lblCusName" runat="server" CssClass="newStyle4" Text='<%# Eval("CusName") %>'></asp:Label>
                    <%--<asp:Label ID="Label2" runat="server" Text="Planning to Return: " CssClass="newStyle4"></asp:Label>&nbsp<asp:Label ID="lblPlanningtoReturn" runat="server" Text="" CssClass="newStyle7"></asp:Label>--%>
                    <asp:GridView ID="gvCompletedBoats" runat="server" AutoGenerateColumns="false" Caption="Finished" OnRowDataBound="gvCompletedBoats_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="mfg_ser_lot_no" HeaderText="Prod #" />
                            <asp:TemplateField HeaderText="Hot?">
                                <ItemTemplate>
                                    <asp:Image ID="imgHot" runat="server" ImageUrl="./Images/Hot.png" SortExpression="Hot" Visible="false" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Hold?">
                                <ItemTemplate>
                                    <asp:Image ID="imgHold" runat="server" ImageUrl="./Images/Hold.png" SortExpression="Hold" Visible="false" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="item_no" HeaderText="Model" />
                            <asp:BoundField DataField="ser_lot_no" HeaderText="S/N" />
                            <%-- <asp:TemplateField HeaderText="Tube Issues?">
                                <ItemTemplate>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RedTag?">
                                <ItemTemplate>

                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Planned Load Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblPlanned" runat="server" Text=""></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date Loaded">
                                <ItemTemplate>
                                    <asp:Label ID="lblLoaded" runat="server" Text=""></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Shipper">
                                <ItemTemplate>
                                    <asp:Label ID="lblShipper" runat="server" Text=""></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                    <asp:GridView ID="gvWip" runat="server" AutoGenerateColumns="False" Caption="WIP" OnRowDataBound="gvWip_RowDataBound" OnRowCommand="gvWip_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            <asp:TemplateField HeaderText="Hot?">
                                <ItemTemplate>
                                    <asp:Image ID="imgHot" runat="server" ImageUrl='<%# Eval("HotFlag", "./Images/Hot.png")%>' SortExpression="Hot" Visible='<%# Eval("HotFlag") = "1" %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:TemplateField>
                           <%-- <asp:TemplateField HeaderText="Hold?">
                                <ItemTemplate>
                                    <asp:Image ID="imgHold" runat="server" ImageUrl='<%# Eval("HoldFlag", "./Images/Hold.png")%>' SortExpression="Hot" Visible='<%# Eval("HoldFlag") = "1" %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:TemplateField>--%>

                            <asp:BoundField DataField="ItemNo" HeaderText="Model" />
                            <asp:BoundField DataField="Notes" HeaderText="S/N" />
                            <asp:BoundField DataField="DueDate" DataFormatString="{0:d}" HeaderText="Due Date" />
                            <asp:BoundField DataField="CurrentStatus" DataFormatString="{0:d}" HeaderText="Current Status" />

                            <asp:TemplateField HeaderText="F">
                                <ItemTemplate>
                                    <asp:Image ID="imgFurnitureStatus" runat="server" ImageUrl='<%# Eval("FurnitureStatus", "./Images/{0}.png") %>' AlternateText='Furniture' ToolTip='Furniture' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:TemplateField>
                            <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="FG" AlternateText="Fiberglass">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:ImageField>
                            <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="C">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:ImageField>
                            <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="R">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:ImageField>
                            <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="T">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:ImageField>

                            <asp:TemplateField HeaderText="CT">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnCentertube" Enabled="false" runat="server" Visible=' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "./Images/{0}.png")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            </asp:ImageField>
                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                </ItemTemplate>
                                <ItemStyle Width="10px" />
                            </asp:TemplateField>
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
                            <asp:TemplateField>
                                <ItemTemplate>
                                </ItemTemplate>
                                <ItemStyle Width="10px" />
                            </asp:TemplateField>

                            <%-- <asp:ImageField DataImageUrlField="Kitting1Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K1">
                            </asp:ImageField>
                            <asp:ImageField DataImageUrlField="Kitting2Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K2">
                            </asp:ImageField>
                            <asp:ImageField DataImageUrlField="Kitting3Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K3">
                            </asp:ImageField>
                            <asp:ImageField DataImageUrlField="Kitting4Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K4">
                            </asp:ImageField>
                            <asp:TemplateField HeaderText="KS">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnKitSouth" Enabled="false" runat="server" Visible=' <%#  IIf(Eval("BuildLoc").ToString() = "", "", Eval("BuildLoc")) = "S"%>' ImageUrl='<%# Eval("KittingSouthStatus", "./Images/{0}.png")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField ItemStyle-BackColor="#99CCFF">
                                <ItemTemplate>
                                </ItemTemplate>
                                <ItemStyle Width="10px" />
                            </asp:TemplateField>--%>
                            <asp:ImageField DataImageUrlField="HelmBuildStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Helm">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:ImageField>
                            <asp:ImageField DataImageUrlField="GatesStatus" DataImageUrlFormatString="./Images/gates{0}.png" HeaderText="Gates">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:ImageField>
                            <asp:ImageField DataImageUrlField="BiminiRcvdStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Bimini">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:ImageField>
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
                            <asp:TemplateField HeaderText="FGI">
                                <ItemTemplate>
                                    <asp:Image ID="imgFiberglassInspStatus" runat="server" ImageUrl='<%# Eval("FiberglassInspStatus", "./Images/{0}.png")%>' AlternateText='Fiberglass' ToolTip='<%# "FG Inspected-" + Eval("FiberglassInsp")%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Frames">
                                <ItemTemplate>
                                    <asp:Image ID="imgFramesInstalledStatus" runat="server" ImageUrl='<%# Eval("FramesInstalledStatus", "./Images/{0}.png")%>' SortExpression="FramesInstalledStatus" AlternateText='Frames' ToolTip='<%# "Frames-" + Eval("FramesInstalled")%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Red Tag">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "Images/tag{0}.png")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tube Issues">
                                <ItemTemplate>
                                    <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="PlannedLoadDate" HeaderText="Planned Load Date" />
                            <asp:BoundField DataField="DateLoaded" HeaderText="Date Loaded" />
                            <asp:BoundField DataField="Shipper" HeaderText="Shipper" />
                        </Columns>
                    </asp:GridView>
                </ItemTemplate>

                <SelectedItemStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />

                <SeparatorStyle Height="20px"></SeparatorStyle>
            </asp:DataList>



        </div>
    </form>
</body>
</html>
