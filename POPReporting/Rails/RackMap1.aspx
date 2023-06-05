﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RackMap1.aspx.vb" Inherits="Rails_RackMap1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rack Map 1</title>
    <link rel="stylesheet" href="../scripts/css/bootstrap.min.css" />
    <link href="../scripts/css/toastr.css" rel="stylesheet" />
    <script src="../scripts/jquery-3.5.0.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
    <script src="../scripts/toastr.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="w-100">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="float-left">
                        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsRacks">
                            <ItemTemplate>
                                <div id="thiscard" runat="server" class="card text-center float-left border-dark" style="width: 19rem; height: 8rem">
                                    <h5 class="card-header">
                                        <asp:Label ID="lblRailsSlot" CssClass="title float-left" runat="server" Text='<%# Eval("RailsSlot")%>'></asp:Label><asp:Label ID="lblBldg" CssClass="title w-15 float-left" runat="server" Text='<%# "-" & Eval("ProdLineDesc")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>
                                        <asp:ImageButton ID="ImageButton1" Visible='<%# IIf(Eval("IsPilot").ToString() = "", 0, Eval("IsPilot")) = 1%>' runat="server" ImageUrl="../Images/rackmapPilot1.png" />
                                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>
                                        <asp:Label ID="lblBoat" CssClass="boatinfoboat float-right" runat="server" Text='<%# Eval("ItemNo")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>
                                    </h5>
                                    <div class="card-title">
                                        <asp:GridView ID="gvRailsData" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRailsData" OnRowDataBound="gvRailsData_RowDataBound" HorizontalAlign="Center" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'>
                                            <Columns>
                                                <asp:TemplateField HeaderText="PF">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgPFReceived" runat="server" ImageUrl='<%# Eval("PF_Received", "../Images/RailsRcv_{0}.png")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SF">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgSFReceived" runat="server" ImageUrl='<%# Eval("SF_Received", "../Images/RailsRcv_{0}.png")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="PR">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgPRReceived" runat="server" ImageUrl='<%# Eval("PR_Received", "../Images/RailsRcv_{0}.png")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="SR">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgSRReceived" runat="server" ImageUrl='<%# Eval("SR_Received", "../Images/RailsRcv_{0}.png")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="T">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgTransomReceived" runat="server" ImageUrl='<%# Eval("T_Received", "../Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsTransom").ToString() = "", 0, Eval("NeedsTransom")) = 1%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="PM">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgPMReceived" runat="server" ImageUrl='<%# Eval("PM_Received", "../Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsPortMid").ToString() = "", 0, Eval("NeedsPortMid")) = 1%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SM">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgSMReceived" runat="server" ImageUrl='<%# Eval("SM_Received", "../Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsStrbMid").ToString() = "", 0, Eval("NeedsStrbMid")) = 1%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="CustDrawNo" HeaderText="D#" />
                                                <asp:TemplateField HeaderText="Framed?">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imgFrames" runat="server" ImageUrl='<%# Eval("FramesInstalledStatus", "../Images/{0}.png")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:Table runat="server" Width="100%">
                                            <asp:TableRow>
                                                <asp:TableCell>
                                                    <asp:Label ID="Label4" runat="server" Text="Due: " Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("DueDate", "{0:d}")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>
                                                    <asp:Label ID="lblBlackOut" runat="server" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' Text='<%# IIf(Eval("Blackout").ToString() = "1", " - BO", "")%>'></asp:Label>
                                                    <asp:Label ID="Label1" runat="server" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' Text='<%# IIf(Eval("Powertop").ToString() = "1", " - PTop", "")%>'></asp:Label>
                                                    <strong><asp:Label ID="Label2" runat="server" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' Text='<%# IIf(Eval("Protech").ToString() = "Y", " - ProTech", "")%>'></asp:Label></strong>
                                                    <asp:ImageButton ID="imgHasAllGates" ToolTip="Has All Gates" runat="server" CssClass="float-right" ImageUrl='<%# Eval("HasAllGates", "../Images/hasallgates{0}.png")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' />
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </div>
                                    <asp:SqlDataSource ID="sdsRailsData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [PF_Received], [PR_Received],[SF_Received], [SR_Received], [T_Received], [PM_Received], [SM_Received], [NeedsTransom], [NeedsPortMid], [NeedsStrbMid],[CustDrawNo],[FramesInstalledStatus] FROM [Rails_Tracking] Left Join BML_POPREPORTING_GREENLIGHTS on Rails_Tracking.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (Rails_Tracking.ProdNo = @ProdNo)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lblProd" Name="ProdNo" PropertyName="Text" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        </div>
                        
                            <asp:SqlDataSource ID="sdsRacks" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT RailsSlot, HasAllGates, Case When Protech = 1 then 'Y' else 'N' end as Protech, Rails_KittingLocations.ProdNo,DateIn,InUse, CusName, CusNo, BML_POPREPORTING_GREENLIGHTS.ItemNo, TrimStatus, BML_POPREPORTING_GREENLIGHTS.IsPilot, BML_POPREPORTING_GREENLIGHTS.DueDate, RailsStatus, BML_POPREPORTING_GREENLIGHTS.BuildLoc, Blackout, Powertop, FurnitureStatus, FiberglassStatus, CoversStatus, TubesStatus, CentertubeNeeded, CentertubeStatus, GaugeStatus, HarnessStatus, HasAllRails,Rails_Tracking.Requested, ArchTowerNeeded, ArchTowerStatus, BML_POPREPORTING_GREENLIGHTS.ProdLineID, ProdLineDesc FROM [Rails_KittingLocations] left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo left join Gates_ByProd on Rails_KittingLocations.ProdNo = Gates_ByProd.ProdNo Left Join ProductionLines on BML_POPREPORTING_GREENLIGHTS.ProdLineID = ProductionLines.ProdLineID Where RailsSlot < 197  order by RailsSlot"></asp:SqlDataSource>
                           <%-- <asp:GridView ID="gvReadyInProdOrder" runat="server" AutoGenerateColumns="false" Caption="Green/Orange In Prod # Order">
                                <Columns>
                                    <asp:BoundField DataField="slot" HeaderText="Slot" SortExpression="slot" ItemStyle-Width="40px">
                                        <ItemStyle Font-Bold="True" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="prod" HeaderText="Prod #" SortExpression="prod">
                                        <ItemStyle Font-Bold="True" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>--%>
                        
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        
        



    </form>
</body>
</html>
