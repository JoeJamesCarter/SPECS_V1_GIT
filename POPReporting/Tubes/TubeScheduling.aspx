<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TubeScheduling.aspx.vb" Inherits="Tubes_TubeScheduling" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tube Scheduling By Drag and Drop</title>
    <style>
        #toolbar {
            width: 351px;
            font-family: Calibri;
            font-size: 15px;
            float: left;
            height: 300px;
        }

        .areas {
            width: 450px;
            float: left;
            font-family: Calibri;
            font-size: 20px;
            margin-right: 10px;
            margin-left: 10px;
        }

        .day {
            width: 640px;
            float: left;
            font-family: Calibri;
            font-size: 20px;
            margin-right: 10px;
            margin-left: 5px;
            margin: 0,auto;
        }

        #sortableMainOuters, #sortableValueOuters, #sortableSouthOuters, #sortableMainCenters, #sortableValueCenters, #sortableSouthCenters, #sortableDayOuters, #sortableDayCenters {
            border-right: #000 1px solid;
            padding-right: 2px;
            border-top: #000 1px solid;
            padding-left: 2px;
            font-size: 12px;
            margin-bottom: 5px;
            padding-bottom: 2px;
            border-left: #000 1px solid;
            width: 410px;
            cursor: pointer;
            padding-top: 2px;
            border-bottom: #000 1px solid;
            font-family: Calibri;
            background-color: #eee
        }

        .ProdNo {
            font-family: Calibri;
            font-size: 20px;
        }

        .ItemNo {
            font-family: Calibri;
            font-size: 20px;
        }

        .Perf {
            font-family: Calibri;
            font-size: 13px;
            color: blue;
        }

        .S {
            border: 1px solid #fbd850;
            background-color: lightgray;
            color: #000000;
            font-family: Calibri;
            font-size: 20px;
        }

        .M {
            border: 1px solid #cccccc;
            background-color: white;
            color: #000000;
            font-family: Calibri;
            font-size: 20px;
        }

        .V {
            border: 1px solid #cccccc;
            background-color: lightcyan;
            color: #000000;
            font-family: Calibri;
            font-size: 20px;
        }

        #fields {
            width: 600px;
        }

        .red {
            font-family: Calibri;
            font-size: 14px;
            color: red;
        }

        .counts {
            font-size: 30px;
            width: 400px;
        }

        #btnUnlock {
            position: fixed;
        }
    </style>

    <script src="../scripts/jquery-ui-1.10.4.custom/js/jquery-1.10.2.js"></script>
    <script src="../scripts/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
    <link href="../scripts/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.css" rel="stylesheet" />

    <script type="text/javascript">
        $(function () {
            var oldList, newList, item;
            $("#sortableMainOuters, #sortableSouthOuters, #sortableValueOuters, #sortableMainCenters, #sortableValueCenters, #sortableSouthCenters, #sortableDayOuters, #sortableDayCenters").sortable({
                connectWith: ".connectedSortable",
                appendTo: 'body',
                items: 'li',
                start: function (event, ui) {
                    item = ui.item;
                    newList = oldList = ui.item.parent().parent();
                },
                beforeStop: function (event, ui) {
                    if ((oldList.attr('id') == 'main' || oldList.attr('id') == 'south' || oldList.attr('id') == 'value') && (newList.attr('id') == 'daycenters' || newList.attr('id') == 'maincenters' || newList.attr('id') == 'southcenters' || newList.attr('id') == 'valuecenters')) {
                        $(this).sortable('cancel');
                    }

                    if ((oldList.attr('id') == 'maincenters' || oldList.attr('id') == 'southcenters' || oldList.attr('id') == 'valuecenters') && (newList.attr('id') == 'dayouters' || newList.attr('id') == 'main' || newList.attr('id') == 'south' || newList.attr('id') == 'value' || newList.attr('id') == 'southcenters' || newList.attr('id') == 'maincenters' || newList.attr('id') == 'valuecenters')) {
                        $(this).sortable('cancel');
                    }

                    if (oldList.attr('id') == 'main' && (newList.attr('id') == 'south')) {
                        $(this).sortable('cancel');
                    }

                    if (oldList.attr('id') == 'main' && (newList.attr('id') == 'value')) {
                        $(this).sortable('cancel');
                    }

                    if (oldList.attr('id') == 'south' && (newList.attr('id') == 'main')) {
                        $(this).sortable('cancel');
                    }

                    if (oldList.attr('id') == 'south' && (newList.attr('id') == 'value')) {
                        $(this).sortable('cancel');
                    }

                    if (oldList.attr('id') == 'value' && (newList.attr('id') == 'main')) {
                        $(this).sortable('cancel');
                    }

                    if (oldList.attr('id') == 'value' && (newList.attr('id') == 'south')) {
                        $(this).sortable('cancel');
                    }

                    if (oldList.attr('id') == 'daycenters' && (newList.attr('id') == 'main')) {
                        $(this).sortable('cancel');
                    }
                    if (oldList.attr('id') == 'daycenters' && (newList.attr('id') == 'south')) {
                        $(this).sortable('cancel');
                    }

                    if (oldList.attr('id') == 'daycenters' && (newList.attr('id') == 'value')) {
                        $(this).sortable('cancel');
                    }

                    if (oldList.attr('id') == 'dayouters' && (newList.attr('id') == 'maincenters')) {
                        $(this).sortable('cancel');
                    }
                    if (oldList.attr('id') == 'dayouters' && (newList.attr('id') == 'southcenters')) {
                        $(this).sortable('cancel');
                    }

                    if (oldList.attr('id') == 'dayouters' && (newList.attr('id') == 'valuecenters')) {
                        $(this).sortable('cancel');
                    }

                },
                stop: function (event, ui) {
                    //alert("First Moved " + item.text() + item.attr('id') + " from " + oldList.attr('id') + " to " + newList.attr('id'));
                    //alert(ui.item.index());

                    document.getElementById("<%= tbProdNo.ClientID%>").value = item.attr('id');
                     document.getElementById("<%= tbTo.ClientID%>").value = newList.attr('id');
                     document.getElementById("<%= tbFrom.ClientID%>").value = oldList.attr('id');
                     document.getElementById("<%= tbOrder.ClientID%>").value = ui.item.index();
                     document.getElementById('btnSave').click();
                 },
                 receive: function (event, ui) {
                     event.preventDefault();
                 },
                 change: function (event, ui) {
                     if (ui.sender) newList = ui.placeholder.parent().parent();
                 },
                 update: function () {
                     var placeholder = $(this).children('.placeholder');
                     ($(this).children().length > 1) ? placeholder.hide() : placeholder.show();
                 }
             }).disableSelection();
         });

    </script>

    <script>


        function UnLock() {

            $("#main").stop().animate({ "marginTop": ($(window).scrollTop()) + "px", "marginLeft": ($(window).scrollLeft()) + "px" }, "fast");
            $("#value").stop().animate({ "marginTop": ($(window).scrollTop()) + "px", "marginLeft": ($(window).scrollLeft()) + "px" }, "fast");
            $("#south").stop().animate({ "marginTop": ($(window).scrollTop()) + "px", "marginLeft": ($(window).scrollLeft()) + "px" }, "fast");
            $("#maincenters").stop().animate({ "marginTop": ($(window).scrollTop()) + "px", "marginLeft": ($(window).scrollLeft()) + "px" }, "fast");
            $("#southcenters").stop().animate({ "marginTop": ($(window).scrollTop()) + "px", "marginLeft": ($(window).scrollLeft()) + "px" }, "fast");
            return false;
        }

    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div id="toolbar">
            <asp:Label ID="Label3" runat="server" CssClass="counts" Text="TUBE SCHEDULING"></asp:Label>
            <asp:Calendar ID="calDateSelected" runat="server"></asp:Calendar>
            <br />
            <asp:Label ID="Label18" CssClass="counts" runat="server" Text="Main:"></asp:Label><asp:Label CssClass="counts" ID="mCount" runat="server" Text=""></asp:Label><br />
            <asp:Label ID="Label31" CssClass="counts" runat="server" Text="Value:"></asp:Label><asp:Label CssClass="counts" ID="vCount" runat="server" Text=""></asp:Label><br />
            <asp:Label ID="Label19" CssClass="counts" runat="server" Text="South:"></asp:Label><asp:Label CssClass="counts" ID="sCount" runat="server" Text=""></asp:Label><br /><br />
            
            <asp:Label ID="Label36" CssClass="counts" runat="server" Text="Outers:"></asp:Label><asp:Label CssClass="counts" ID="OutersCount" runat="server" Text=""></asp:Label><br />
            <br />

            <asp:Label ID="Label23" CssClass="counts" runat="server" Text="Centers:"></asp:Label><asp:Label CssClass="counts" ID="centerCount" runat="server" Text=""></asp:Label><br />
            <asp:Label ID="Label20" CssClass="counts" runat="server" Text="ESP:"></asp:Label><asp:Label CssClass="counts" ID="espCount" runat="server" Text=""></asp:Label><br />
            <asp:Label ID="Label22" CssClass="counts" runat="server" Text="SPS:"></asp:Label><asp:Label CssClass="counts" ID="spsCount" runat="server" Text=""></asp:Label><br />
            <asp:Label ID="Label21" CssClass="counts" runat="server" Text="Express:"></asp:Label><asp:Label CssClass="counts" ID="expCount" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnUnlock" runat="server" Text="Move To Scroll Bar" OnClientClick="javascript: return UnLock()" />


        </div>

        <div id="south" class="areas">
            <asp:Label ID="Label2" runat="server" Text="B1"></asp:Label><br />
            <asp:Label ID="Label11" runat="server" Text="Outers"></asp:Label><br />
            <asp:ListView ID="lvsouth" runat="server" DataSourceID="sdsSouthOutersNotScheduled">
                <LayoutTemplate>
                    <ul id="sortableSouthOuters" class="connectedSortable">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li class="<%#Eval("BuildLoc")%>" id="<%#Eval("ProdNo")%>">
                        <asp:Label ID="Label7" class="ProdNo" runat="server" Text='<%#Eval("ProdNo")%>'></asp:Label>-
                    <asp:Label ID="Label5" class="ItemNo" runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label>-
                    <asp:Label ID="Label27" class="BuildLoc" runat="server" Text='<%#Eval("BuildLoc")%>'></asp:Label>-
                    <asp:Label ID="Label6" class="Perf" runat="server" Text='<%#Eval("PerfPkg")%> '></asp:Label>
                        <asp:Label ID="Label4" class="red" runat="server" Visible=' <%# Eval("CentertubeNeeded") = 1 and Eval("CenterScheduledFlag") = 1%>' Text='<%# "C: " + Eval("CenterScheduled")%>'></asp:Label>
                        <asp:Label ID="fab1" class="Perf" runat="server" Text=""></asp:Label>
                        <asp:Label ID="Label24" runat="server" Text="F ="></asp:Label>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# String.Format("../Images/{0}.png", Eval("FurnitureStatus"))%>' />
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <br />
            <asp:SqlDataSource ID="sdsSouthOutersNotScheduled" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, FurnitureStatus, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BuildLoc, PerfPkg, CenterScheduled, CenterScheduledFlag FROM [BML_POPREPORTING] Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where OuterScheduledFlag = 0 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and TubesStatus < 2 and BML_POPREPORTING_GREENLIGHTS.RollerStatusP < 2 Order By BML_POPREPORTING.ProdNo"></asp:SqlDataSource>
        </div>

        <div id="value" class="areas">
            <asp:Label ID="Label32" runat="server" Text="B2"></asp:Label><br />
            <asp:Label ID="Label33" runat="server" Text="Outers"></asp:Label><br />
            <asp:ListView ID="lvvalue" runat="server" DataSourceID="sdsValueOutersNotScheduled">
                <LayoutTemplate>
                    <ul id="sortableValueOuters" class="connectedSortable">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li class="<%#Eval("BuildLoc")%>" id="<%#Eval("ProdNo")%>">
                        <asp:Label ID="prod" class="ProdNo" runat="server" Text='<%#Eval("ProdNo")%>'></asp:Label>-
                    <asp:Label ID="Label5" class="ItemNo" runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label>-
                    <asp:Label ID="Label25" class="BuildLoc" runat="server" Text='<%#Eval("BuildLoc")%>'></asp:Label>-
                    <asp:Label ID="Label6" class="Perf" runat="server" Text='<%#Eval("PerfPkg")%> '></asp:Label>
                        <asp:Label ID="Label4" class="red" runat="server" Visible=' <%# Eval("CentertubeNeeded") = 1 And Eval("CenterScheduledFlag") = 1%>' Text='<%# "C: " + Eval("CenterScheduled")%>'></asp:Label>
                        <asp:Label ID="fab1" class="Perf" runat="server" Text=""></asp:Label>
                        <asp:Label ID="Label24" runat="server" Text="F ="></asp:Label>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# String.Format("../Images/{0}.png", Eval("FurnitureStatus"))%>' />
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <br />
            <asp:SqlDataSource ID="sdsValueOutersNotScheduled" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, FurnitureStatus, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BuildLoc, PerfPkg, CenterScheduled, CenterScheduledFlag FROM [BML_POPREPORTING] Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where OuterScheduledFlag = 0 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and TubesStatus < 2 and BML_POPREPORTING_GREENLIGHTS.RollerStatusP < 2 Order By BML_POPREPORTING.ProdNo"></asp:SqlDataSource>
        </div>

        <div id="main" class="areas">
            <asp:Label ID="Label1" runat="server" Text="B3"></asp:Label><br />
            <asp:Label ID="Label8" runat="server" Text="Outers"></asp:Label><br />
            <asp:ListView ID="lvmain" runat="server" DataSourceID="sdsMainOutersNotScheduled">
                <LayoutTemplate>
                    <ul id="sortableMainOuters" class="connectedSortable">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li class="<%#Eval("BuildLoc")%>" id="<%#Eval("ProdNo")%>">
                        <asp:Label ID="prod" class="ProdNo" runat="server" Text='<%#Eval("ProdNo")%>'></asp:Label>-
                    <asp:Label ID="Label5" class="ItemNo" runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label>-
                    <asp:Label ID="Label25" class="BuildLoc" runat="server" Text='<%#Eval("BuildLoc")%>'></asp:Label>-
                    <asp:Label ID="Label6" class="Perf" runat="server" Text='<%#Eval("PerfPkg")%> '></asp:Label>
                        <asp:Label ID="Label4" class="red" runat="server" Visible=' <%# Eval("CentertubeNeeded") = 1 And Eval("CenterScheduledFlag") = 1%>' Text='<%# "C: " + Eval("CenterScheduled")%>'></asp:Label>
                        <asp:Label ID="fab1" class="Perf" runat="server" Text=""></asp:Label>
                        <asp:Label ID="Label24" runat="server" Text="F ="></asp:Label>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# String.Format("../Images/{0}.png", Eval("FurnitureStatus"))%>' />
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <br />
            <asp:SqlDataSource ID="sdsMainOutersNotScheduled" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, FurnitureStatus, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BuildLoc, PerfPkg, CenterScheduled, CenterScheduledFlag FROM [BML_POPREPORTING] Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where OuterScheduledFlag = 0 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and TubesStatus < 2 and BML_POPREPORTING_GREENLIGHTS.RollerStatusP < 2 Order By BML_POPREPORTING.ProdNo"></asp:SqlDataSource>
            <div id="fields">
                <asp:Label ID="lblProdNo" runat="server" Text="ProdNo: "></asp:Label><asp:TextBox ID="tbProdNo" runat="server"></asp:TextBox><br />
                <asp:Label ID="lblOrder" runat="server" Text="Order: "></asp:Label><asp:TextBox ID="tbOrder" runat="server"></asp:TextBox><br />
                <asp:Label ID="lblFrom" runat="server" Text="From: "></asp:Label><asp:TextBox ID="tbFrom" runat="server"></asp:TextBox><br />
                <asp:Label ID="lblTo" runat="server" Text="To: "></asp:Label><asp:TextBox ID="tbTo" runat="server"></asp:TextBox>
                <asp:Button ID="btnSave" runat="server" Text="AutoSave" />
                <br />
            </div>
        </div>


        <div id="dayouters" class="areas">
            <asp:Label ID="Label16" runat="server" Text="PLANNED"></asp:Label><br />
            <asp:Label ID="Label17" runat="server" Text="Outers"></asp:Label><br />
            <asp:ListView ID="lvplannedouters" runat="server" DataSourceID="sdsPlannedOuters" DataKeyNames="ProdNo">
                <LayoutTemplate>
                    <ul id="sortableDayOuters" class="connectedSortable">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <EmptyDataTemplate>
                    <ul id="sortableDayOuters" class="connectedSortable">
                        <li class="ui-state-highlight placeholder">Drop Outers for this Day Here.</li>
                        <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                    </ul>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <li class="<%#Eval("BuildLoc")%>" id="<%#Eval("ProdNo")%>">
                        <asp:Label ID="Label7" class="ProdNo" runat="server" Text='<%#Eval("ProdNo")%>'></asp:Label>-
                    <asp:Label ID="Label5" class="ItemNo" runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label>-
                    <asp:Label ID="Label26" class="BuildLoc" runat="server" Text='<%#Eval("BuildLoc")%>'></asp:Label>-

                    <asp:Label ID="Label6" class="Perf" runat="server" Text='<%#Eval("PerfPkg")%> '></asp:Label>
                        <asp:Label ID="Label4" class="red" runat="server" Visible=' <%# Eval("CentertubeNeeded") = 1 And Eval("CenterScheduledFlag") = 1%>' Text='<%# "C: " + Eval("CenterScheduled")%>'></asp:Label>
                        <asp:Label ID="fab1" class="Perf" runat="server" Text=""></asp:Label>
                        <asp:Label ID="Label24" runat="server" Text="F ="></asp:Label>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# String.Format("../Images/{0}.png", Eval("FurnitureStatus"))%>' />
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <br />
            <asp:SqlDataSource ID="sdsPlannedOuters" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, FurnitureStatus, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BuildLoc, PerfPkg, CenterScheduled, CenterScheduledFlag FROM [BML_POPREPORTING] Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where OuterScheduledFlag = 1 and OuterScheduled = @TubeDate Order By OuterScheduleOrder">
                <SelectParameters>
                    <asp:ControlParameter ControlID="calDateSelected" Name="TubeDate" PropertyName="SelectedDate" DbType="String" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>

        <div id="southcenters" class="areas">
            <asp:Label ID="Label12" runat="server" Text="B1"></asp:Label><br />
            <asp:Label ID="Label13" runat="server" Text="Centers"></asp:Label><br />
            <asp:ListView ID="lvsouthcenters" runat="server" DataSourceID="sdsSouthCentersNotScheduled">
                <LayoutTemplate>
                    <ul id="sortableSouthCenters" class="connectedSortable">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li class="<%#Eval("BuildLoc")%>" id="<%#Eval("ProdNo")%>">
                        <asp:Label ID="Label7" class="ProdNo" runat="server" Text='<%#Eval("ProdNo")%>'></asp:Label>-
                    <asp:Label ID="Label5" class="ItemNo" runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label>-
                    <asp:Label ID="Label30" class="BuildLoc" runat="server" Text='<%#Eval("BuildLoc")%>'></asp:Label>-
                    <asp:Label ID="Label6" class="Perf" runat="server" Text='<%#Eval("PerfPkg")%> '></asp:Label>
                        <asp:Label ID="Label4" class="red" runat="server" Visible=' <%# Eval("CentertubeNeeded") = 1 and Eval("CenterScheduledFlag") = 1%>' Text='<%# "C: " + Eval("CenterScheduled")%>'></asp:Label>
                        <asp:Label ID="fab1" class="Perf" runat="server" Text=""></asp:Label>
                        <asp:Label ID="Label24" runat="server" Text="F ="></asp:Label>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# String.Format("../Images/{0}.png", Eval("FurnitureStatus"))%>' />
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <br />
            <asp:SqlDataSource ID="sdsSouthCentersNotScheduled" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, FurnitureStatus, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BuildLoc, PerfPkg, CenterScheduled, CenterScheduledFlag, FurnitureStatus FROM [BML_POPREPORTING] Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where CenterScheduledFlag = 0 and BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.RollerStatusCtr < 2 and BML_POPREPORTING.ItemNo not like '2_RT%' Order By BML_POPREPORTING.ProdNo"></asp:SqlDataSource>

        </div>

        <div id="valuecenters" class="areas">
            <asp:Label ID="Label34" runat="server" Text="B2"></asp:Label><br />
            <asp:Label ID="Label35" runat="server" Text="Centers"></asp:Label><br />
            <asp:ListView ID="lvvaluecenters" runat="server" DataSourceID="sdsValueCentersNotScheduled">
                <LayoutTemplate>
                    <ul id="sortableValueCenters" class="connectedSortable">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li class="<%#Eval("BuildLoc")%>" id="<%#Eval("ProdNo")%>">
                        <asp:Label ID="Label7" class="ProdNo" runat="server" Text='<%#Eval("ProdNo")%>'></asp:Label>-
                    <asp:Label ID="Label5" class="ItemNo" runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label>-
                    <asp:Label ID="Label28" class="BuildLoc" runat="server" Text='<%#Eval("BuildLoc")%>'></asp:Label>-
                    <asp:Label ID="Label6" class="Perf" runat="server" Text='<%#Eval("PerfPkg")%> '></asp:Label>
                        <asp:Label ID="Label4" class="red" runat="server" Visible=' <%# Eval("CentertubeNeeded") = 1 and Eval("CenterScheduledFlag") = 1%>' Text='<%# "C: " + Eval("CenterScheduled")%>'></asp:Label>
                        <asp:Label ID="fab1" class="Perf" runat="server" Text=""></asp:Label>
                        <asp:Label ID="Label24" runat="server" Text="F ="></asp:Label>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# String.Format("../Images/{0}.png", Eval("FurnitureStatus"))%>' />
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <br />
            <asp:SqlDataSource ID="sdsValueCentersNotScheduled" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, FurnitureStatus, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BuildLoc, PerfPkg, CenterScheduled, CenterScheduledFlag FROM [BML_POPREPORTING] Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where CenterScheduledFlag = 0 and BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' Order By BML_POPREPORTING.ProdNo"></asp:SqlDataSource>

        </div>

        <div id="maincenters" class="areas">
            <asp:Label ID="Label10" runat="server" Text="B3"></asp:Label><br />
            <asp:Label ID="Label9" runat="server" Text="Centers"></asp:Label><br />
            <asp:ListView ID="lvmaincenters" runat="server" DataSourceID="sdsMainCentersNotScheduled">
                <LayoutTemplate>
                    <ul id="sortableMainCenters" class="connectedSortable">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li class="<%#Eval("BuildLoc")%>" id="<%#Eval("ProdNo")%>">
                        <asp:Label ID="Label7" class="ProdNo" runat="server" Text='<%#Eval("ProdNo")%>'></asp:Label>-
                    <asp:Label ID="Label5" class="ItemNo" runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label>-
                    <asp:Label ID="Label28" class="BuildLoc" runat="server" Text='<%#Eval("BuildLoc")%>'></asp:Label>-
                    <asp:Label ID="Label6" class="Perf" runat="server" Text='<%#Eval("PerfPkg")%> '></asp:Label>
                        <asp:Label ID="Label4" class="red" runat="server" Visible=' <%# Eval("CentertubeNeeded") = 1 and Eval("CenterScheduledFlag") = 1%>' Text='<%# "C: " + Eval("CenterScheduled")%>'></asp:Label>
                        <asp:Label ID="fab1" class="Perf" runat="server" Text=""></asp:Label>
                        <asp:Label ID="Label24" runat="server" Text="F ="></asp:Label>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# String.Format("../Images/{0}.png", Eval("FurnitureStatus"))%>' />
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <br />
            <asp:SqlDataSource ID="sdsMainCentersNotScheduled" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, FurnitureStatus, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BuildLoc, PerfPkg, CenterScheduled, CenterScheduledFlag FROM [BML_POPREPORTING] Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where CenterScheduledFlag = 0 and BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' Order By BML_POPREPORTING.ProdNo"></asp:SqlDataSource>

        </div>

        <div id="daycenters" class="areas">
            <asp:Label ID="Label14" runat="server" Text="PLANNED"></asp:Label><br />
            <asp:Label ID="Label15" runat="server" Text="Centers"></asp:Label><br />
            <asp:ListView ID="lvplannedcenters" runat="server" DataSourceID="sdsPlannedCenters" DataKeyNames="ProdNo">
                <LayoutTemplate>
                    <ul id="sortableDayCenters" class="connectedSortable">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <EmptyDataTemplate>
                    <ul id="sortableDayCenters" class="connectedSortable">
                        <li class="ui-state-highlight placeholder">Drop Centers for this Day Here.</li>
                        <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                    </ul>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <li class="<%#Eval("BuildLoc")%>" id="<%#Eval("ProdNo")%>">
                        <asp:Label ID="Label7" class="ProdNo" runat="server" Text='<%#Eval("ProdNo")%>'></asp:Label>-
                    <asp:Label ID="Label5" class="ItemNo" runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label>-
                    <asp:Label ID="Label29" class="BuildLoc" runat="server" Text='<%#Eval("BuildLoc")%>'></asp:Label>-
                    <asp:Label ID="Label6" class="Perf" runat="server" Text='<%#Eval("PerfPkg")%> '></asp:Label>
                        <asp:Label ID="Label4" class="red" runat="server" Visible=' <%# Eval("CentertubeNeeded") = 1 And Eval("OuterScheduledFlag") = 1%>' Text='<%# "O: " + Eval("OuterScheduled")%>'></asp:Label>
                        <asp:Label ID="fab1" class="Perf" runat="server" Text=""></asp:Label>
                        <asp:Label ID="Label24" runat="server" Text="F ="></asp:Label>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# String.Format("../Images/{0}.png", Eval("FurnitureStatus"))%>' />
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <br />
            <asp:SqlDataSource ID="sdsPlannedCenters" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, FurnitureStatus, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BuildLoc, PerfPkg, CenterScheduled, CenterScheduledFlag, OuterScheduledFlag, OuterScheduled FROM [BML_POPREPORTING] Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where CenterScheduledFlag = 1 and BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and CenterScheduled = @TubeDate Order By CenterScheduleOrder">
                <SelectParameters>
                    <asp:ControlParameter ControlID="calDateSelected" Name="TubeDate" PropertyName="SelectedDate" DbType="String" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>
        

    </form>
</body>
</html>
