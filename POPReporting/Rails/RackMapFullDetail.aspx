<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RackMapFullDetail.aspx.vb" Inherits="Rails_RackMapFullDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rail Racks - Full Details</title>
    <style>
        .area {
            float: left;
            text-align: center;
            border-style: double;
            vertical-align: central;
            font-size: 14px;
            font-family: Calibri;
            font-weight: bold;
        }

        .boatinfodlr {
            font-family: Calibri;
            font-size: 10px;
        }

        .boatinfoprod {
            font-family: Calibri;
            font-size: 20px;
            font-weight: bold;
            margin-left: 10px;
            float: left;
        }

        .boatinfoboat {
            font-family: Calibri;
            font-size: 20px;
            font-weight: bold;
            float: right;
            margin-right: 10px;
        }

        .slot {
            font-family: Calibri;
            font-size: 16px;
            font-weight: bold;
            color: Black;
            vertical-align: top;
        }

        .title {
            font-family: Calibri;
            font-size: 20px;
            font-weight: bold;
            color: Black;
            vertical-align: top;
            text-align: center;
            width: 100%;
        }

        .duedate {
            font-size: 18px;
            font-weight: bold;
            font-family: calibri;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                <ContentTemplate>
                    <asp:Label ID="lblTitle" CssClass="title" runat="server" Text="BENNINGTON RAIL RACK OVERVIEW - Green = Main w/All Parts & Rails,      Blue = All Parts Missing Rails,     Yellow = Requested Missing Parts or Rails,     Orange = Requested w/All Parts & All Rails,   P Means Pilot"></asp:Label><br />
                    <asp:Label runat="server" Text="Limit to Prod Line:"></asp:Label>
                    <asp:DropDownList runat="server" ID="ddlProdLine" AutoPostBack="True" DataSourceID="sdsProdLines" DataTextField="ProdLineDesc" DataValueField="ProdLineID"></asp:DropDownList>
                    <asp:SqlDataSource runat="server" ID="sdsProdLines" ConnectionString='<%$ ConnectionStrings:bml_dataConnectionString %>' SelectCommand="SELECT * FROM [ProductionLines] WHERE ([Disabled] = 0) ORDER BY [ProdLineDesc]"></asp:SqlDataSource>
                                       
                    <asp:DropDownList runat="server" ID="ddlHasAllRails" AutoPostBack="true">
                        <asp:ListItem Text="All" Value="%"></asp:ListItem>
                        <asp:ListItem Text="Missing Rails" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Has All Rails" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:Label runat="server" ID="lblNumLocsVisible" Text=''></asp:Label>

                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                    <asp:DataList ID="dl1" CssClass="area" runat="server" DataSourceID="sdsRacks" RepeatDirection="Horizontal" RepeatColumns="10" BorderStyle="Outset" SeparatorStyle-Height="20px" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="112px" Width="217px" />
                        <ItemTemplate>
                            <asp:Label ID="lblRailsSlot" CssClass="title" runat="server" Text='<%# Eval("RailsSlot")%>'></asp:Label><asp:Label ID="lblBldg" CssClass="title" runat="server" Text='<%# "-" & Eval("ProdLineDesc")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>&nbsp;&nbsp;<asp:ImageButton ID="ImageButton2" ImageUrl='../Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" /><asp:ImageButton ID="ImageButton1" Visible='<%# IIf(Eval("IsPilot").ToString() = "", 0, Eval("IsPilot")) = 1%>' runat="server" ImageUrl="../Images/rackmapPilot1.png" /><br />
                            <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>
                            <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label><br />

                            <asp:GridView ID="gvGreenlights" runat="server" AutoGenerateColumns="False" HorizontalAlign="Center" DataSourceID="sdsPopReportingByProdNo" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'>
                                <Columns>
                                    <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="F">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="FG">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="C">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="R">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="T">
                                    </asp:ImageField>
                                    <asp:TemplateField HeaderText="CT">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgButtonCentertube" runat="server" ImageUrl='<%# Eval("CentertubeStatus", "../Images/{0}.png")%>' Visible='<%#Eval("CentertubeNeeded") = 1%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                                    </asp:ImageField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [SONo], [FurnitureStatus],[FiberglassStatus], [CoversStatus], [RailsStatus], [TubesStatus],[CentertubeStatus],[CentertubeNeeded],cast(GaugeStatus as varchar) + cast(HarnessStatus as varchar) as ElectricalStatus  FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblProd" Name="ProdNo" PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <br></br>
                            <asp:GridView ID="gvRailsData" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRailsData" OnRowDataBound="gvRailsData_RowDataBound" HorizontalAlign="Center" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'>
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
                            <asp:Label ID="Label4" runat="server" CssClass="duedate" Text="Due: " Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label><asp:Label ID="Label3" runat="server" Text='<%# Eval("DueDate", "{0:d}")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' CssClass="duedate"></asp:Label><asp:Label ID="lblBlackOut" CssClass="duedate" runat="server" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' Text='<%# IIf(Eval("Blackout").ToString() = "1", " - BO", "")%>'></asp:Label>
                            <asp:Label ID="Label1" CssClass="duedate" runat="server" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' Text='<%# IIf(Eval("Powertop").ToString() = "1", " - PT", "")%>'></asp:Label>
                            <asp:SqlDataSource ID="sdsRailsData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [PF_Received], [PR_Received],[SF_Received], [SR_Received], [T_Received], [PM_Received], [SM_Received], [NeedsTransom], [NeedsPortMid], [NeedsStrbMid],[CustDrawNo],[FramesInstalledStatus] FROM [Rails_Tracking] Left Join BML_POPREPORTING_GREENLIGHTS on Rails_Tracking.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (Rails_Tracking.ProdNo = @ProdNo)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblProd" Name="ProdNo" PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>


                        </ItemTemplate>
                        <SeparatorStyle Height="100px" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsRacks" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT RailsSlot, Rails_KittingLocations.ProdNo,DateIn,InUse, BML_POPREPORTING_GREENLIGHTS.SONo, CusName,BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.IsPilot, BML_POPREPORTING_GREENLIGHTS.DueDate, RailsStatus, BML_POPREPORTING_GREENLIGHTS.BuildLoc, Blackout, Powertop, FurnitureStatus, FiberglassStatus, CoversStatus, TubesStatus, CentertubeNeeded, CentertubeStatus, GaugeStatus, HarnessStatus, TrimStatus, HasAllRails, ArchTowerNeeded, ArchTowerStatus, Requested, BML_POPREPORTING_GREENLIGHTS.ProdLineID, ProdLineDesc FROM [Rails_KittingLocations] left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Left Join ProductionLines on BML_POPREPORTING_GREENLIGHTS.ProdLineID = ProductionLines.ProdLineID Where (BML_POPREPORTING_GREENLIGHTS.ProdLineID LIKE  '%' + @ProdLineID + '%') and (Rails_Tracking.HasAllRails LIKE  '%' + @HasAllRails + '%') and InUse = 1  order by RailsSlot">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlProdLine" Name="ProdLineID" PropertyName="SelectedValue" DbType="String" /> 
                            <asp:ControlParameter ControlID="ddlHasAllRails" Name="HasAllRails" PropertyName="SelectedValue" DbType="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
    </form>
</body>
</html>

