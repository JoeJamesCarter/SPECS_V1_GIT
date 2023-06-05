<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Dashboard.aspx.vb" Inherits="Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SPECS DASHBOARD</title>
    <link href="StyleSheet.css" rel="stylesheet" />

    <style>
        #body {
            width: 100%;
        }

        .sections {
            font-family: Calibri;
            font-size: 16px;
            margin: 6px;
            width: 470px;
            float:left;            
            border-style:double;
        }

        .auto-style1 {
            text-align: center;
        }


        .buttons {
            box-shadow: 0px 0px 0px 0px #3dc21b;
            background-color:green ;
            border-radius: 8px;
            border: 1px solid #18ab29;
            display: inline-block;
            cursor: pointer;
            color: #ffffff;
            font-family: Calibri;
            font-size: 15px;
            width: 220px;
            margin-left:5px;
            margin-right: 5px;
            margin-bottom: 10px;
            text-decoration: none;
            text-shadow: 0px 1px 0px #2f6627;
        }

            .buttons:hover {
                background-color: #44c767;
                color: white;
            }

            .buttons:active {
                position: relative;
                top: 1px;
            }

        .dividertext {
            font-family: Calibri;
            display: block;
            font-size: 18px;
            width: 100%;            
            background-color: white;
            color: black;        
            font-weight:bold;
            text-align:center;
        }
    </style>
    <script>
        function navAway(url) {
            window.open(url);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="header">
            <asp:Image runat="server" img src="Images/logo-small.png" CssClass="auto-style1" Height="76px" /></asp:Image><br />
            <asp:Label ID="Label1" runat="server" Text="MASTER DASHBOARD" CssClass="newStyle4"></asp:Label>
        </div>
        <div id="admintools" class="sections">
            <asp:Label ID="Label2" runat="server" Text="TOOLS/OVERVIEWS" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button1" CssClass="buttons" runat="server" Text="Report Card" OnClientClick="navAway('ReportCard.aspx')" ToolTip="One place to look at the health of the line." />
            <asp:Button ID="Button11" CssClass="buttons" runat="server" Text="Overview w/Daily Counts" OnClientClick="navAway('Overview.aspx')" ToolTip="Shows all the boats and the daily counts of how many boats when through each material and station." />
            <asp:Button ID="Button12" CssClass="buttons" runat="server" Text="Overview w/Search" OnClientClick="navAway('OverviewSearch.aspx')" ToolTip="Searchable Overview" />
            <asp:Button ID="Button95" CssClass="buttons" runat="server" Text="Overview W/Auto Refresh" OnClientClick="navAway('Overview-RO.aspx')" />
            <asp:Button ID="Button96" CssClass="buttons" runat="server" Text="Overview w/Dates" OnClientClick="navAway('OverviewByDate.aspx')" />
            <asp:Button ID="Button51" CssClass="buttons" runat="server" Text="Yard Master" OnClientClick="navAway('YardMaster/OverviewYardMaster.aspx')" ToolTip="Shows Wheret The Boats Are in the Yard." />
            <asp:Button ID="Button13" CssClass="buttons" runat="server" Text="History" OnClientClick="navAway('History.aspx')" ToolTip="Shows What Boast went through any give station on any day and when." />
            <asp:Button ID="Button114" CssClass="buttons" runat="server" Text="Past Due" OnClientClick="navAway('PastDue.aspx')" />
            <asp:Button ID="Button115" CssClass="buttons" runat="server" Text="Pilots" OnClientClick="navAway('Workstations/Pilots.aspx')" />
            <asp:Button ID="Button116" CssClass="buttons" runat="server" Text="Swith Buildings" OnClientClick="navAway('SwitchBldgs.aspx')" />
            <asp:Button ID="Button117" CssClass="buttons" runat="server" Text="Engine Allocations" OnClientClick="navAway('EngineAllocations.aspx')" />
            <asp:Button ID="Button118" CssClass="buttons" runat="server" Text="Overview w/Dates" OnClientClick="navAway('OverviewByDate.aspx')" />
            <asp:Button ID="Button119" CssClass="buttons" runat="server" Text="Hot List" OnClientClick="navAway('HotList.aspx')" ToolTip="watch the progress of a select group of boats deemed high priority." />
            <asp:Button ID="Button120" CssClass="buttons" runat="server" Text="Prod Pictures" OnClientClick="navAway('ProdPics.aspx')" />
        </div>

        <div id="offline" class="sections">
            <asp:Label ID="Label24" runat="server" Text="SIDE LINED" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button101" CssClass="buttons" runat="server" Text="Boats Offline" OnClientClick="navAway('Workstations/BoatsOffline.aspx')" />
            <asp:Button ID="Button102" CssClass="buttons" runat="server" Text="Boats Offline" OnClientClick="navAway('Workstations/BoatsOffline.aspx')" />
            <asp:Button ID="Button104" CssClass="buttons" runat="server" Text="Side Line ETA's" OnClientClick="navAway('Workstations/SidelineETA.aspx')" />
        </div>

        <div id="furniture" class="sections">
            <asp:Label ID="Label12" runat="server" Text="FURNITURE" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button3" CssClass="buttons" runat="server" Text="Furniture" OnClientClick="navAway('FurniturePrep.aspx')" ToolTip="For Greening Furniture. No Order Lines. " />
            <asp:Button ID="Button4" CssClass="buttons" runat="server" Text="Furniture With Lines" OnClientClick="navAway('FurniturePrepWLines.aspx')" ToolTip="Used to receiving Furniture and create bo's and rga's with 1 click. Got too big, so I divivded it into Main and South." />
            <asp:Button ID="Button5" CssClass="buttons" runat="server" Text="Furniture With Lines Main" OnClientClick="navAway('FurniturePrepWLinesMain.aspx')" ToolTip="Used to receiving Main Furniture and create bo's and rga's with 1 click." />
            <asp:Button ID="Button6" CssClass="buttons" runat="server" Text="Furniture With Lines South" OnClientClick="navAway('FurniturePrepWLinesSouth.aspx')" ToolTip="Used to receiving South Furniture and create bo's and rga's with 1 click." />
            <asp:Button ID="Button8" CssClass="buttons" runat="server" Text="Furniture Racks" OnClientClick="navAway('FurnitureLocations.aspx')" ToolTip="Shows Furniture racks, what prod #'s are in them, which contain the Aft Furniture." />
            <asp:Button ID="Button7" CssClass="buttons" runat="server" Text="Furniture Map" OnClientClick="navAway('FurnitureMap.aspx')" ToolTip="Shows Veada RGAs and Backorders and whether or not the items have been receieved relative to where the boats are online. Orange we have, Yellow we don't. If they tracked what they took the the line, things would disappear from here." />
            <asp:Button ID="Button9" CssClass="buttons" runat="server" Text="Furniture Issues On the Line" OnClientClick="navAway('FurnitureOnlineIssues.aspx')" ToolTip="Written to track boats on the line that have Veada RGA's or Backorders and Track when the pieces got delivered to the line. Not in Use." />
            <asp:Button ID="Button10" CssClass="buttons" runat="server" Text="Furniture Pick List" OnClientClick="navAway('Workstations/FurniturePickList.aspx')" ToolTip="Used By Forklift Driver to Find the Furniture By Rack Location the lines needs." />

        </div>

        <div id="greenlights" class="sections">
            <asp:Label ID="Label3" runat="server" Text="GREEN LIGHTS" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button14" CssClass="buttons" runat="server" Text="Fiberglass" OnClientClick="navAway('FiberglassPrep.aspx')" />
            <asp:Button ID="Button15" CssClass="buttons" runat="server" Text="Canvas" OnClientClick="navAway('CoversPrep.aspx')" />
            <asp:Button ID="Button16" CssClass="buttons" runat="server" Text="Rails" OnClientClick="navAway('RailsPrepTest.aspx')" />
            <asp:Button ID="Button21" CssClass="buttons" runat="server" Text="Rails QX" OnClientClick="navAway('RailsPrepQX.aspx')" />
            <asp:Button ID="Button17" CssClass="buttons" runat="server" Text="Tubes" OnClientClick="navAway('Tubes.aspx')" />
            <asp:Button ID="Button18" CssClass="buttons" runat="server" Text="Center Tubes" OnClientClick="navAway('Centertubes.aspx')" />
            <asp:Button ID="Button19" CssClass="buttons" runat="server" Text="Gauges" OnClientClick="navAway('Gauges.aspx')" />
            <asp:Button ID="Button20" CssClass="buttons" runat="server" Text="Harnesses" OnClientClick="navAway('Harnesses.aspx')" />
            <asp:Button ID="Button82" CssClass="buttons" runat="server" Text="Bimini Rcv To Load Schedule" OnClientClick="navAway('LoadScheduleBiminisWRcv.aspx')" />
            <asp:Button ID="Button83" CssClass="buttons" runat="server" Text="Bimini Rcv" OnClientClick="navAway('BiminiRcv.aspx')" />
        </div>

        <div id="kitting" class="sections">
            <asp:Label ID="Label20" runat="server" Text="KITTING" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button22" CssClass="buttons" runat="server" Text="Kitting 1" OnClientClick="navAway('Kitting1.aspx')" />
            <asp:Button ID="Button23" CssClass="buttons" runat="server" Text="Kitting 2" OnClientClick="navAway('Kitting2.aspx')" />
            <asp:Button ID="Button24" CssClass="buttons" runat="server" Text="Kitting 3" OnClientClick="navAway('Kitting3.aspx')" />
            <asp:Button ID="Button25" CssClass="buttons" runat="server" Text="Kitting 4" OnClientClick="navAway('Kitting4.aspx')" />
            <asp:Button ID="Button26" CssClass="buttons" runat="server" Text="South Kit Rcv" OnClientClick="navAway('KitReceiving.aspx')" />
        </div>

        <div id="glbarcode" class="sections">
            <asp:Label ID="Label19" runat="server" Text="GREEN LIGHTS BARCODE" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button32" CssClass="buttons" runat="server" Text="Canvas" OnClientClick="navAway('Barcode/Canvas.aspx')" />
            <asp:Button ID="Button33" CssClass="buttons" runat="server" Text="Gauges" OnClientClick="navAway('Barcode/GaugeRcv.aspx')" />
            <asp:Button ID="Button34" CssClass="buttons" runat="server" Text="Harnesses" OnClientClick="navAway('Barcode/HarnessRcv.aspx')" />
            <asp:Button ID="Button35" CssClass="buttons" runat="server" Text="Kitting 2" OnClientClick="navAway('Barcode/Kitting2.aspx')" ToolTip="First automated kitting station, barcode completions" />
        </div>

        <div id="workstations" class="sections">
            <asp:Label ID="Label4" runat="server" Text="WORKSTATIONS" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button61" CssClass="buttons" runat="server" Text="Flooring" OnClientClick="navAway('Workstations/Flooring.aspx')" />
            <asp:Button ID="Button63" CssClass="buttons" runat="server" Text="Trim" OnClientClick="navAway('Workstations/Trim.aspx')" />
            <asp:Button ID="Button64" CssClass="buttons" runat="server" Text="Canvas" OnClientClick="navAway('Workstations/Flooring.aspx')" />
            <asp:Button ID="Button65" CssClass="buttons" runat="server" Text="Gates" OnClientClick="navAway('Workstations/Gates.aspx')" />
            <asp:Button ID="Button66" CssClass="buttons" runat="server" Text="Rails" OnClientClick="navAway('Workstations/Rails.aspx')" />
            <asp:Button ID="Button67" CssClass="buttons" runat="server" Text="Furniture" OnClientClick="navAway('Workstations/Furniture.aspx')" />
            <asp:Button ID="Button68" CssClass="buttons" runat="server" Text="Gates" OnClientClick="navAway('Workstations/Gates.aspx')" />
            <asp:Button ID="Button69" CssClass="buttons" runat="server" Text="Helms" OnClientClick="navAway('Workstations/Helms.aspx')" />
            <asp:Button ID="Button70" CssClass="buttons" runat="server" Text="Helm Build" OnClientClick="navAway('Workstations/HelmBuild.aspx')" />
            <asp:Button ID="Button71" CssClass="buttons" runat="server" Text="Inspection" OnClientClick="navAway('Workstations/Cleaning.aspx')" />
            <asp:Button ID="Button72" CssClass="buttons" runat="server" Text="Final Inspection" OnClientClick="navAway('Workstations/Final.aspx')" />
            <asp:Button ID="Button73" CssClass="buttons" runat="server" Text="Rigging" OnClientClick="navAway('Workstations/Rigging.aspx')" />
            <asp:Button ID="Button77" CssClass="buttons" runat="server" Text="Photos" OnClientClick="navAway('Workstations/Photos.aspx')" />
            <asp:Button ID="Button74" CssClass="buttons" runat="server" Text="Shrinkwrap" OnClientClick="navAway('Workstations/Shrinkwrap.aspx')" />
            <asp:Button ID="Button75" CssClass="buttons" runat="server" Text="Wavetamer" OnClientClick="navAway('Workstations/Wavetamer.aspx')" />
            <asp:Button ID="Button76" CssClass="buttons" runat="server" Text="Sharkhide" OnClientClick="navAway('Workstations/Sharkhide.aspx')" />
            <asp:Button ID="Button78" CssClass="buttons" runat="server" Text="Red Tags" OnClientClick="navAway('Workstations/RedTag.aspx')" />
            <asp:Button ID="Button80" CssClass="buttons" runat="server" Text="Furniture Hardware" OnClientClick="navAway('Workstations/FurnitureHardware.aspx')" />
            <asp:Button ID="Button81" CssClass="buttons" runat="server" Text="Bimini Feet Locations" OnClientClick="navAway('Workstations/Bimini_Feet.aspx')" />
        </div>

        <div id="south" class="sections">
            <asp:Label ID="Label25" runat="server" Text="SOUTH BUILDING" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button105" CssClass="buttons" runat="server" Text="Decks Outside" OnClientClick="navAway('Workstations/Decks.aspx')" />
            <asp:Button ID="Button106" CssClass="buttons" runat="server" Text="Rails South" OnClientClick="navAway('Workstations/RailsSouth.aspx')" />
            <asp:Button ID="Button107" CssClass="buttons" runat="server" Text="South WIP" OnClientClick="navAway('Workstations/SouthWIP.aspx')" />
            <asp:Button ID="Button109" CssClass="buttons" runat="server" Text="Decks Missing Rails" OnClientClick="navAway('Workstations/DecksNoRails.aspx')" />
            <asp:Button ID="Button110" CssClass="buttons" runat="server" Text="South Map" OnClientClick="navAway('Workstations/South Map.aspx')" ToolTip="Shows all WIP by current workstation" />


        </div>



        <div id="insidesales" class="sections">
            <asp:Label ID="Label6" runat="server" Text="INSIDE SALES" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button111" CssClass="buttons" runat="server" Text="Scheduling Tools" OnClientClick="navAway('Scheduling/Starthere.aspx')" />
            <asp:Button ID="Button112" CssClass="buttons" runat="server" Text="Planned Allocations" OnClientClick="navAway('Scheduling/AllocationsPlanned.aspx')" />
            <asp:Button ID="Button113" CssClass="buttons" runat="server" Text="Actual Allocations" OnClientClick="navAway('Allocations.aspx')" />
        </div>

        <div id="srt" class="sections">
            <asp:Label ID="Label7" runat="server" Text="SUPPLIER READINESS" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button49" CssClass="buttons" runat="server" Text="SRT" OnClientClick="navAway('SRT/SupplierReadinessTracking.aspx')" />
            <asp:Button ID="Button50" CssClass="buttons" runat="server" Text="SRT Read Only" OnClientClick="navAway('SRT/SupplierReadinessTrackingRO.aspx')" />
        </div>

        <div id="pdi" class="sections">
            <asp:Label ID="Label8" runat="server" Text="PROD DEV IDEAS" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button39" CssClass="buttons" runat="server" Text="Product Dev Ideas" OnClientClick="navAway('PDI/ProductDesignIdeas.aspx')" />
            <asp:Button ID="Button40" CssClass="buttons" runat="server" Text="Product Dev Ideas History" OnClientClick="navAway('PDI/ProductDesignIdeasHistory.aspx')" />
        </div>

        <div id="rails" class="sections">
            <asp:Label ID="Label9" runat="server" Text="RAILS" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button2" CssClass="buttons" runat="server" Text="Rack Map" OnClientClick="navAway('Rails/RackMap.aspx')" />
            <asp:Button ID="Button41" CssClass="buttons" runat="server" Text="Produced" OnClientClick="navAway('Rails/Production.aspx')" />
            <asp:Button ID="Button42" CssClass="buttons" runat="server" Text="Receiving" OnClientClick="navAway('Rails/Receiving.aspx')" />
            <asp:Button ID="Button45" CssClass="buttons" runat="server" Text="Receiving Q Fronts" OnClientClick="navAway('Rails/ReceivingQFronts.aspx')" />
            <asp:Button ID="Button43" CssClass="buttons" runat="server" Text="Extra Inventory" OnClientClick="navAway('Rails/RailsInventory.aspx')" />
            <asp:Button ID="Button44" CssClass="buttons" runat="server" Text="Rails Overview" OnClientClick="navAway('Rails/RailsOverview.aspx')" />
            <asp:Button ID="Button46" CssClass="buttons" runat="server" Text="Reorders Tracking" OnClientClick="navAway('Rails/ReordersTracking.aspx')" />
            <asp:Button ID="Button47" CssClass="buttons" runat="server" Text="Repairs Tracking" OnClientClick="navAway('Rails/RepairsTracking.aspx')" />
            <asp:Button ID="Button48" CssClass="buttons" runat="server" Text="Scheduling" OnClientClick="navAway('Rails/Scheduling.aspx')" ToolTip="West building tool for scheudling what rails will be built and when." />

        </div>

        <div id="tubes" class="sections">
            <asp:Label ID="Label10" runat="server" Text="TUBES" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button52" CssClass="buttons" runat="server" Text="Green Roller" OnClientClick="navAway('Tubes/GreenRoller.aspx')" />
            <asp:Button ID="Button53" CssClass="buttons" runat="server" Text="Blue Roller" OnClientClick="navAway('Tubes/BlueRoller.aspx')" />
            <asp:Button ID="Button54" CssClass="buttons" runat="server" Text="Center Inspection" OnClientClick="navAway('Tubes/CenterInspection.aspx')" />
            <asp:Button ID="Button55" CssClass="buttons" runat="server" Text="Tube Repairs" OnClientClick="navAway('Tubes/Repairs.aspx')" />
            <asp:Button ID="Button56" CssClass="buttons" runat="server" Text="Tube Replacements Roller" OnClientClick="navAway('Tubes/Replacements.aspx')" />
            <asp:Button ID="Button57" CssClass="buttons" runat="server" Text="Evaluate Daamge" OnClientClick="navAway('Tubes/EvaluateDamage.aspx')" />
            <asp:Button ID="Button58" CssClass="buttons" runat="server" Text="Tube Scheduling" OnClientClick="navAway('Tubes/TubeScheduling.aspx')" />
            <asp:Button ID="Button59" CssClass="buttons" runat="server" Text="Outer Schedule Edits" OnClientClick="navAway('Tubes/EditOuterSchedule.aspx')" />
            <asp:Button ID="Button60" CssClass="buttons" runat="server" Text="Center Schedule Edits" OnClientClick="navAway('Tubes/EditCenterSchedule.aspx')" />
            <asp:Button ID="Button121" CssClass="buttons" runat="server" Text="Evaluate Damage Reported" OnClientClick="navAway('Tubes/EvaluateDamage.aspx')" />
            <asp:Button ID="Button122" CssClass="buttons" runat="server" Text="Tube Repairs" OnClientClick="navAway('Tubes/Repairs.aspx')" />
            <asp:Button ID="Button123" CssClass="buttons" runat="server" Text="Tube Replacements" OnClientClick="navAway('Tubes/Replacements.aspx')" />
        </div>

        <div id="tubesdisplays" class="sections">
            <asp:Label ID="Label18" runat="server" Text="TUBES DISPLAYS" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button124" CssClass="buttons" runat="server" Text="Seamer" OnClientClick="navAway('Tubes/Displays/Seamer.aspx')" />
            <asp:Button ID="Button125" CssClass="buttons" runat="server" Text="Baffles" OnClientClick="navAway('Tubes/Displays/Baffles.aspx')" />
            <asp:Button ID="Button126" CssClass="buttons" runat="server" Text="Round Seamer" OnClientClick="navAway('Tubes/Displays/RoundSeamer.aspx')" />
            <asp:Button ID="Button127" CssClass="buttons" runat="server" Text="Brackets" OnClientClick="navAway('Tubes/Displays/Brackets.aspx')" />
        </div>

        <div id="tubesbarcode" class="sections">
            <asp:Label ID="Label11" runat="server" Text="TUBES BARCODE" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button27" CssClass="buttons" runat="server" Text="Baffles" OnClientClick="navAway('Barcode/Tubes/Seamer.aspx')" />
            <asp:Button ID="Button28" CssClass="buttons" runat="server" Text="Seamer" OnClientClick="navAway('Barcode/Tubes/Baffles.aspx')" />
            <asp:Button ID="Button29" CssClass="buttons" runat="server" Text="Round Seamer" OnClientClick="navAway('Barcode/Tubes/RoundSeamer.aspx')" />
            <asp:Button ID="Button30" CssClass="buttons" runat="server" Text="Final Outers" OnClientClick="navAway('Barcode/Tubes/FinalOuters.aspx')" />
        </div>

        <div id="ladders" class="sections">
            <asp:Label ID="Label13" runat="server" Text="LADDERS" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button87" CssClass="buttons" runat="server" Text="Reorders & Repairs" OnClientClick="navAway('LadderRepairsReorders.aspx')" />
            <asp:Button ID="Button88" CssClass="buttons" runat="server" Text="Ladder Demand" OnClientClick="navAway('Ladders.aspx')" />
        </div>
        <div id="gates" class="sections">
            <asp:Label ID="Label14" runat="server" Text="GATES" CssClass="newStyle6"></asp:Label><br />

        </div>

        <div id="invcontrol" class="sections">
            <asp:Label ID="Label15" runat="server" Text="INV CONTROL MEMOS" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button84" CssClass="buttons" runat="server" Text="Submit Inv Control Memo" OnClientClick="navAway('memo.aspx')" />
            <asp:Button ID="Button85" CssClass="buttons" runat="server" Text="Inventory Control Memos" OnClientClick="navAway('ICMemos.aspx')" />
            <asp:Button ID="Button86" CssClass="buttons" runat="server" Text="Inv Control History" OnClientClick="navAway('ICMemosRO.aspx')" />
        </div>
        <div id="phyinv" class="sections">
            <asp:Label ID="Label16" runat="server" Text="PHY INVENTORY TOOLS" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button31" CssClass="buttons" runat="server" Text="Barcode Ready/Complete" OnClientClick="navAway('Barcode/InventoryTracking.aspx')" />
            <asp:Button ID="Button97" CssClass="buttons" runat="server" Text="Digital Whiteboard" OnClientClick="navAway('Inventory.aspx')" />
            <asp:Button ID="Button98" CssClass="buttons" runat="server" Text="Whiteboard Control" OnClientClick="navAway('InventoryTracking.aspx')" />
            <asp:Button ID="Button100" CssClass="buttons" runat="server" Text="Inv Clearing Requests" OnClientClick="navAway('InventoryClearingRequests.aspx')" />
            <asp:Button ID="Button99" CssClass="buttons" runat="server" Text="Final Clearing Auditors" OnClientClick="navAway('InventoryClearing.aspx')" />

        </div>

        <div id="loadscheduing" class="sections">
            <asp:Label ID="Label5" runat="server" Text="LOAD SCHEDULING" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button89" CssClass="buttons" runat="server" Text="Load Scheduling" OnClientClick="navAway('LoadScheduling.aspx')" />
        </div>
        <div id="shipping" class="sections">
            <asp:Label ID="Label17" runat="server" Text="SHIPPING" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button90" CssClass="buttons" runat="server" Text="Load Boats" OnClientClick="navAway('LoadBoats.aspx')" />
            <asp:Button ID="Button93" CssClass="buttons" runat="server" Text="Load Boats Priority" OnClientClick="navAway('LoadBoatsSetPriority.aspx')" ToolTip="Used to tell Shipping the order to Load" />
            <asp:Button ID="Button91" CssClass="buttons" runat="server" Text="Load Schedule" OnClientClick="navAway('LoadSchedule.aspx')" />
            <asp:Button ID="Button92" CssClass="buttons" runat="server" Text="Set Estimated Delivery Dates" OnClientClick="navAway('LoadEstDeliverDates.aspx')" ToolTip="Maverick Tool to set Estimated Delivery Dates" />
            <asp:Button ID="Button94" CssClass="buttons" runat="server" Text="Load Completions - Coming Soon" OnClientClick="navAway('')" />
        </div>

        <div id="warranty" class="sections">
            <asp:Label ID="Label23" runat="server" Text="WARRANTY" CssClass="dividertext"></asp:Label><br />

        </div>
        <div id="materials" class="sections">
            <asp:Label ID="Label22" runat="server" Text="MATERIALS" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button36" CssClass="buttons" runat="server" Text="Maintain Parts By Location" OnClientClick="navAway('Materials/MaintainPartsByLocation..aspx')" />
            <asp:Button ID="Button37" CssClass="buttons" runat="server" Text="Label Generation" OnClientClick="navAway('Materials/MaterialLabels.aspx')" />
            <asp:Button ID="Button38" CssClass="buttons" runat="server" Text="Assign Locations To Items" OnClientClick="navAway('Materials/SetupItemLocations.aspx')" />
        </div>

        <div id="readonly" class="sections">
            <asp:Label ID="Label21" runat="server" Text="READ ONLY PAGES" CssClass="dividertext"></asp:Label><br />
            <asp:Button ID="Button62" CssClass="buttons" runat="server" Text="Flooring" OnClientClick="navAway('Workstations/Flooring-RO.aspx')" />
            <asp:Button ID="Button79" CssClass="buttons" runat="server" Text="Red Tags" OnClientClick="navAway('Workstations/RedTagRO.aspx')" />
            <asp:Button ID="Button103" CssClass="buttons" runat="server" Text="Boats Offline" OnClientClick="navAway('Workstations/BoatsOfflineRO.aspx')" />
            <asp:Button ID="Button108" CssClass="buttons" runat="server" Text="South WIP" OnClientClick="navAway('Workstations/SouthWIPRO.aspx')" />
        </div>

    </form>
</body>
</html>
