<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OverviewYardMaster.aspx.vb" Inherits="YardMaster_OverviewYardMaster" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Overview - Yard Master</title>
    <style>
        .area {
            float: left;
            text-align: center;
            border-style: double;
            vertical-align: central;
            font-size: 20px;
            font-family: Calibri;
            font-weight: bold;
        }

        .boatinfodlr {
            font-family: Calibri;
            font-size: 14px;
            text-align: center;
        }

        .boatinfoprod {
            font-family: Calibri;
            font-size: 18px;
            font-weight: bold;
        }

        .boatinfoboat {
            font-family: Calibri;
            font-size: 16px;
            font-weight: bold;
        }

        .boatinfoboattuberepair {
            font-family: Calibri;
            font-size: 16px;
            font-weight: bold;
            color: red;
            background-color:white;
        }

        .slot {
            font-family: Calibri;
            font-size: 18px;
            font-weight: bold;
            color: Black;
            vertical-align: top;
        }

        .title {
            font-family: Calibri;
            font-size: 22px;
            font-weight: bold;
            color: Black;
            vertical-align: top;
            text-align: center;
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">

            <ContentTemplate>
                <asp:Label ID="lblTitle" CssClass="title" runat="server" Text="BENNINGTON YARD MASTER OVERVIEW"></asp:Label><br />
                <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                <asp:Label ID="Label1" CssClass="title" runat="server" Text="Find A Boat - (Please include 2 digit year) Prod #:"></asp:Label>
                <asp:TextBox ID="tbBoat" runat="server"></asp:TextBox><asp:Button ID="btnSearch" runat="server" Text="Search" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblDealerSearch" CssClass="title" runat="server" Text="Find All Boats For Dealer Named:" Visible="False"></asp:Label>
                <asp:Label ID="Label2" CssClass="boatinfoboattuberepair" runat="server" Text="REPAIR or REPLACE in Red is a Tube Issue."></asp:Label>


                <asp:Table Caption="Analysis - still working on this" runat="server" CssClass="boatinfodlr" BorderStyle="solid" Visible="True" GridLines="both">
                    <asp:TableHeaderRow>
                        <asp:TableHeaderCell>
                            # Of Boats In YM
                        </asp:TableHeaderCell>
                        <asp:TableHeaderCell>
                            # In Serial List
                        </asp:TableHeaderCell>
                        <asp:TableHeaderCell>
                            # In Serial Not Yard & Not Loaded
                        </asp:TableHeaderCell>
                        <asp:TableHeaderCell>
                            Demos
                        </asp:TableHeaderCell>
                        <asp:TableHeaderCell>
                            Stock
                        </asp:TableHeaderCell>
                        <asp:TableHeaderCell ColumnSpan="6">
                        Waiting on Prod
                        </asp:TableHeaderCell>
                          <asp:TableHeaderCell ColumnSpan="2">
                        Waiting on Transo
                        </asp:TableHeaderCell>
                          <asp:TableHeaderCell ColumnSpan="1">
                        Waiting on Dealer
                        </asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                    <asp:TableRow>
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell>Rigging</asp:TableCell>
                        <asp:TableCell>Wavetamer</asp:TableCell>
                        <asp:TableCell>Sharkhide</asp:TableCell>
                        <asp:TableCell>Tube Repairs</asp:TableCell>
                        <asp:TableCell>Tube Replace</asp:TableCell>
                        <asp:TableCell>RedTags</asp:TableCell>
                        <asp:TableCell>Pickups</asp:TableCell> 
                        <asp:TableCell>Loaded Not Inv'd</asp:TableCell> 
                        <asp:TableCell></asp:TableCell>                        
                    </asp:TableRow>

                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblTotalnumboats" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblIMLSMST" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblIMLSMSTNotLoaded" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell><asp:Label ID="lbldemos" runat="server" Text=""></asp:Label></asp:TableCell>
                        <asp:TableCell><asp:Label ID="lblstock" runat="server" Text=""></asp:Label></asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblrigging" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblwt" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblSharkhide" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblrepairs" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblreorders" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblredtags" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblPickups" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblScheduled" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell> <asp:Label ID="lblwaitingdealer" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        

                    </asp:TableRow>

                </asp:Table>




                <asp:DropDownList ID="ddlDealers" runat="server" DataSourceID="sdsDealers" DataTextField="CusName" DataValueField="CusName" AutoPostBack="False" Visible="False"></asp:DropDownList><asp:Button ID="btnSearchDealer" runat="server" Text="Search" Visible="False" />
                <asp:SqlDataSource ID="sdsDealers" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [CusName] FROM [BML_POPREPORTING_GREENLIGHTS] Order By CusName"></asp:SqlDataSource>



                <asp:DataList ID="dl1" CssClass="area" runat="server" DataSourceID="sdsRack1" RepeatDirection="Horizontal" RepeatColumns="12" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 1" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">
                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnClear" runat="server" Text="Clear" Visible="false" />

                <asp:SqlDataSource ID="sdsRack1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged, CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 1  order by Row,Slot"></asp:SqlDataSource>

                <asp:DataList ID="dl2" CssClass="area" runat="server" DataSourceID="sdsRack2" RepeatDirection="Horizontal" RepeatColumns="16" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 2" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                        <br />


                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 2 order by Row,Slot"></asp:SqlDataSource>

                <asp:DataList ID="dl3" CssClass="area" runat="server" DataSourceID="sdsRack3" RepeatDirection="Horizontal" RepeatColumns="16" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 3" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px" Visible="True">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack3" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 3 order by Row,Slot"></asp:SqlDataSource>



                <asp:DataList ID="dl4" CssClass="area" runat="server" DataSourceID="sdsRack4" RepeatDirection="Horizontal" RepeatColumns="7" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 4" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack4" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 4 order by Row,Slot"></asp:SqlDataSource>


                <asp:DataList ID="dl5" CssClass="area" runat="server" DataSourceID="sdsRack5" RepeatDirection="Horizontal" RepeatColumns="13" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 5" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack5" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 5 order by Row,Slot"></asp:SqlDataSource>
                <asp:DataList ID="dl6" CssClass="area" runat="server" DataSourceID="sdsRack6" RepeatDirection="Horizontal" RepeatColumns="10" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 6" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack6" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 6 order by Row,Slot"></asp:SqlDataSource>
                <asp:DataList ID="dl7" CssClass="area" runat="server" DataSourceID="sdsRack7" RepeatDirection="Horizontal" RepeatColumns="16" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 7" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack7" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate,ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 7 order by Row,Slot"></asp:SqlDataSource>
                <asp:DataList ID="dl8" CssClass="area" runat="server" DataSourceID="sdsRack8" RepeatDirection="Horizontal" RepeatColumns="17" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 8" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack8" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 8 order by Row,Slot"></asp:SqlDataSource>

                <asp:DataList ID="dl9" CssClass="area" runat="server" DataSourceID="sdsRack9" RepeatDirection="Horizontal" RepeatColumns="17" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 9" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />

                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack9" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 9 order by Row,Slot"></asp:SqlDataSource>

                <asp:DataList ID="dl10" CssClass="area" runat="server" DataSourceID="sdsRack10" RepeatDirection="Horizontal" RepeatColumns="15" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 10" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack10" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 10 order by Row,Slot"></asp:SqlDataSource>

                <asp:DataList ID="dl11" CssClass="area" runat="server" DataSourceID="sdsRack11" RepeatDirection="Horizontal" RepeatColumns="14" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 11" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack11" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 11 order by Row,Slot"></asp:SqlDataSource>

                <asp:DataList ID="dl12" CssClass="area" runat="server" DataSourceID="sdsRack12" RepeatDirection="Horizontal" RepeatColumns="8" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 12" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack12" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate,ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 12 order by Row,Slot"></asp:SqlDataSource>

                <asp:DataList ID="dl13" CssClass="area" runat="server" DataSourceID="sdsRack13" RepeatDirection="Horizontal" RepeatColumns="13" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 13" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack13" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired,RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 13 order by Row,Slot"></asp:SqlDataSource>

                 <asp:DataList ID="dl14" CssClass="area" runat="server" DataSourceID="sdsRack14" RepeatDirection="Horizontal" RepeatColumns="11" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 14" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack14" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired,RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 14 order by Row,Slot"></asp:SqlDataSource>



                  <asp:DataList ID="dl15" CssClass="area" runat="server" DataSourceID="sdsRack15" RepeatDirection="Horizontal" RepeatColumns="14" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 15" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack15" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired,RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 15 order by Row,Slot"></asp:SqlDataSource>



                  <%-- <asp:DataList ID="dl16" CssClass="area" runat="server" DataSourceID="sdsRack16" RepeatDirection="Horizontal" RepeatColumns="5" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Rack 16" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsRack16" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired,RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 16 order by Row,Slot"></asp:SqlDataSource>
--%>











                <asp:DataList ID="dlG1" CssClass="area" runat="server" DataSourceID="sdsG1" RepeatDirection="Horizontal" RepeatColumns="20" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Ground 1" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsG1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired,RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 100 order by Row,Slot"></asp:SqlDataSource>

                <asp:DataList ID="dlG2" CssClass="area" runat="server" DataSourceID="sdsG2" RepeatDirection="Horizontal" RepeatColumns="25" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Ground 2" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsG2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired,RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 200 order by Row,Slot"></asp:SqlDataSource>

                <asp:DataList ID="dlG3" CssClass="area" runat="server" DataSourceID="sdsG3" RepeatDirection="Horizontal" RepeatColumns="15" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Ground 3" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsG3" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged, CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 300 order by Row,Slot"></asp:SqlDataSource>
                <asp:DataList ID="dlG4" CssClass="area" runat="server" DataSourceID="sdsG4" RepeatDirection="Horizontal" RepeatColumns="15" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Ground 4" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsG4" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired,RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged,CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 400 order by Row,Slot"></asp:SqlDataSource>

                <asp:DataList ID="dlG5" CssClass="area" runat="server" DataSourceID="sdsG5" RepeatDirection="Horizontal" RepeatColumns="25" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Ground 5" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsG5" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged, CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate, HoldFlag, Hold FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 500 order by Row,Slot"></asp:SqlDataSource>

                
                <asp:DataList ID="dlG6" CssClass="area" runat="server" DataSourceID="sdsG6" RepeatDirection="Horizontal" RepeatColumns="20" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Ground 6" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsG6" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged, CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate, HoldFlag, Hold FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 600 order by Row,Slot"></asp:SqlDataSource>


                  
                <asp:DataList ID="dlG7" CssClass="area" runat="server" DataSourceID="sdsG7" RepeatDirection="Horizontal" RepeatColumns="20" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Ground 7" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsG7" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged, CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate, HoldFlag, Hold FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 700 order by Row,Slot"></asp:SqlDataSource>


                 <asp:DataList ID="dlG8" CssClass="area" runat="server" DataSourceID="sdsG8" RepeatDirection="Horizontal" RepeatColumns="20" BorderStyle="Outset" SeparatorStyle-Height="100px" Caption="Ground 8" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="300px" ItemStyle-Height="200px">

                    <ItemTemplate>
                        <asp:Label ID="lbl" CssClass="slot" runat="server" Text='<%# Eval("Slot")%>'></asp:Label><br />
                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDlr" CssClass="boatinfodlr" runat="server" Text='<%# Eval("CusName")%>'></asp:Label><br />
                        <asp:Label ID="lblBoat" CssClass="boatinfoboat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label><br />
                        <asp:Label ID="lblDueDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "Due: " & Eval("DueDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblLoadDate" CssClass="boatinfoboat" runat="server" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' Text='<%# "To Load: " & Eval("ActualLoadDate", "{0:d}")%>'></asp:Label><br />
                        <asp:Label ID="lblCurrentStatus" CssClass="boatinfoboat" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label>
                        <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label><br />
                        <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="sdsG8" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Yard_Master_Locations.ProdNo, Slot, Filled, CusName, ItemNo, DueDate, ActionRequired, RepairedFlag, ReplacedFlag, BML_POPREPORTING_GREENLIGHTS.IsRedTagged, CASE WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End AS CurrentStatus, ActualLoadDate, HoldFlag, Hold FROM [Yard_Master_Locations] left join BML_POPREPORTING_GREENLIGHTS on Yard_Master_Locations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where Rack = 800 order by Row,Slot"></asp:SqlDataSource>


            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>

