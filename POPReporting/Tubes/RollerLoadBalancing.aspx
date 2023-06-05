<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RollerLoadBalancing.aspx.vb" Inherits="Tubes_RollerLoadBalancing" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Roller Load Balancing</title>

    <script src="../scripts/jquery-ui-1.10.4.custom/js/jquery-1.10.2.js"></script>
    <script src="../scripts/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
    <link href="../scripts/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.css" rel="stylesheet" />

    <style>
        #toolbar {
            font-family: Calibri;
            font-size: 20px;
            float: left;
            margin-right: 15px;
        }

        #calendar {
            font-family: Calibri;
            font-size: 14px;
            float: left;
        }

        .blue {
            font-family: Calibri;
            font-size: 16px;
            float: left;           
        }

        .green {
            font-family: Calibri;
            font-size: 16px;
            float: left;
            margin-left: 15px;
        }

        #footer {
            position: fixed;
            font-size:10px;
            bottom: 0;
            font-family:Calibri;
            width: 100%;
        }

        #sortableBlue {
            font-size: 20px;
            width: 550px;
            cursor: pointer;
            font-family: Calibri;
            background-color: lightblue;
        }

        #sortableGreen {
            font-size: 20px;
            width: 550px;
            cursor: pointer;
            font-family: Calibri;
            background-color: lightgreen;
        }

        .Perf {
            font-family: Calibri;
            font-size: 16px;
            color: blue;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            var oldList, newList, item;
            $("#sortableBlue, #sortableGreen").sortable({
                connectWith: ".connectedSortable",
                appendTo: 'body',
                items: 'li',
                start: function (event, ui) {
                    item = ui.item;
                    newList = oldList = ui.item.parent().parent();
                },
                beforeStop: function (event, ui) {
                    if (oldList.attr('id') == 'blue' && (newList.attr('id') == 'blue')) {
                        $(this).sortable('cancel');
                    }

                    if (oldList.attr('id') == 'green' && (newList.attr('id') == 'green')) {
                        $(this).sortable('cancel');
                    }

                },
                stop: function (event, ui) {
                    //alert("First Moved " + item.text() + item.attr('id') + " from " + oldList.attr('id') + " to " + newList.attr('id'));
                    //alert(ui.item.index());

                    document.getElementById("<%= tbProd.ClientID%>").value = item.attr('id');
                    document.getElementById("<%= tbTo.ClientID%>").value = newList.attr('id');
                    document.getElementById("<%= tbFrom.ClientID%>").value = oldList.attr('id');
                    document.getElementById("<%= tbTubeType.ClientID%>").value = item.attr('data-tubetype');                    
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


</head>
<body>
    <form id="form1" runat="server">
        <div id="toolbar">
            <asp:Label ID="Label1" runat="server" Text="TUBE ROLLER LOAD BALANCING"></asp:Label>
            <asp:Calendar ID="tubeCalendar" runat="server"></asp:Calendar><br />
            Blue Outers:
            <asp:Label ID="lblBlueOuters" runat="server" Text=""></asp:Label><asp:Label ID="Label9" runat="server" Text=" Tubes - "></asp:Label><asp:Label ID="lblBlueOuterSections" runat="server" Text=""></asp:Label><asp:Label ID="Label11" runat="server" Text=" Sections"></asp:Label><br />
            Blue Centers:            
            <asp:Label ID="lblBlueCenters" runat="server" Text=""></asp:Label><asp:Label ID="Label13" runat="server" Text=" Tubes - "></asp:Label><asp:Label ID="lblBlueCenterSections" runat="server" Text=""></asp:Label><asp:Label ID="Label15" runat="server" Text=" Sections"></asp:Label><br />
             Blue Express:            
            <asp:Label ID="lblBlueExpress" runat="server" Text=""></asp:Label><asp:Label ID="Label16" runat="server" Text=" Tubes - "></asp:Label><asp:Label ID="lblBlueExpressSections" runat="server" Text=""></asp:Label><asp:Label ID="Label18" runat="server" Text=" Sections"></asp:Label><br />
            <br />
            <strong>Blue Total:
            <asp:Label ID="lblBlueTotal" runat="server" Text=""></asp:Label><asp:Label ID="Label17" runat="server" Text=" Tubes - "></asp:Label><asp:Label ID="lblBlueTotalSections" runat="server" Text=""></asp:Label><asp:Label ID="Label23" runat="server" Text=" Sections"></asp:Label></strong><br />
            <br />
             Green Outers:
            <asp:Label ID="lblGreenOuters" runat="server" Text=""></asp:Label><asp:Label ID="Label10" runat="server" Text=" Tubes - "></asp:Label><asp:Label ID="lblGreenOuterSections" runat="server" Text=""></asp:Label><asp:Label ID="Label12" runat="server" Text=" Sections"></asp:Label><br />
            Green Centers:            
            <asp:Label ID="lblGreenCenters" runat="server" Text=""></asp:Label><asp:Label ID="Label19" runat="server" Text=" Tubes - "></asp:Label><asp:Label ID="lblGreenCenterSections" runat="server" Text=""></asp:Label><asp:Label ID="Label21" runat="server" Text=" Sections"></asp:Label><br />
            Green Express:            
            <asp:Label ID="lblGreenExpress" runat="server" Text=""></asp:Label><asp:Label ID="Label22" runat="server" Text=" Tubes - "></asp:Label><asp:Label ID="lblGreenExpressSections" runat="server" Text=""></asp:Label><asp:Label ID="Label24" runat="server" Text=" Sections"></asp:Label><br />
            <br />
             <strong>Green Total:
            <asp:Label ID="lblGreenTotal" runat="server" Text=""></asp:Label><asp:Label ID="Label20" runat="server" Text=" Tubes - "></asp:Label><asp:Label ID="lblGreenTotalSections" runat="server" Text=""></asp:Label><asp:Label ID="Label26" runat="server" Text=" Sections"></asp:Label></strong><br />
            <br />

        </div>

        <div id="blue" class="blue">
            <asp:ListView ID="lvblue" runat="server" DataSourceID="sdsBlue">
                <LayoutTemplate>
                    <ul id="sortableBlue" class="connectedSortable">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li class="<%#Eval("BuildLoc")%>" id="<%#Eval("ProdNo")%>" data-tubetype="<%#Eval("TubeType")%>">
                        <asp:Label ID="prod" class="ProdNo" runat="server" Text='<%#Eval("ProdNo")%>'></asp:Label>-
                    <asp:Label ID="Label5" class="ItemNo" runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label>
                        -
                    <asp:Label ID="lblTubeType" class="ItemNo" runat="server" Text='<%#Eval("TubeType")%>'></asp:Label>
                        <asp:Label ID="Label6" class="Perf" runat="server" Text='<%#Eval("PerfPkg")%> '></asp:Label>
                        <asp:Label ID="fab1" class="Perf" runat="server" Text=""></asp:Label>
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <br />
            <asp:SqlDataSource ID="sdsBlue" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BuildLoc, PerfPkg, CenterScheduled, CenterScheduledFlag, Case When OuterScheduled = @TubeDate Then 'Outer' When CenterScheduled = @TubeDate Then 'Center' End as TubeType FROM [BML_POPREPORTING] Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where TubesStatus < 2 and (OuterScheduledFlag = '1' and OuterScheduled = @TubeDate and OuterRoller = 'Blue') or(CenterScheduledFlag ='1' and CenterScheduled = @TubeDate and CenterRoller = 'Blue') Order By Case When OuterScheduled = @TubeDate Then OuterScheduleOrder When CenterScheduled = @TubeDate Then CenterScheduleOrder end">
                <SelectParameters>
                    <asp:ControlParameter ControlID="tubeCalendar" Name="TubeDate" PropertyName="SelectedDate" DbType="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>

        <div id="green" class="green">
            <asp:ListView ID="lvgreen" runat="server" DataSourceID="sdsGreen">
                <LayoutTemplate>
                    <ul id="sortableGreen" class="connectedSortable">
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li class="<%#Eval("BuildLoc")%>" id="<%#Eval("ProdNo")%>" data-tubetype="<%#Eval("TubeType")%>">
                        <asp:Label ID="prod" class="ProdNo" runat="server" Text='<%#Eval("ProdNo")%>'></asp:Label>-
                    <asp:Label ID="Label5" class="ItemNo" runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label>
                        -
                    <asp:Label ID="lblTubeType" class="ItemNo" runat="server" Text='<%#Eval("TubeType")%>'></asp:Label>
                        <asp:Label ID="Label6" class="Perf" runat="server" Text='<%#Eval("PerfPkg")%> '></asp:Label>
                        <asp:Label ID="fab1" class="Perf" runat="server" Text=""></asp:Label>
                    </li>
                </ItemTemplate>
            </asp:ListView>
            <br />
            <asp:SqlDataSource ID="sdsGreen" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BuildLoc, PerfPkg, CenterScheduled, CenterScheduledFlag, Case When OuterScheduled = @TubeDate Then 'Outer' When CenterScheduled = @TubeDate Then 'Center' End as TubeType FROM [BML_POPREPORTING] Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where TubesStatus < 2 and (OuterScheduledFlag = '1' and OuterScheduled = @TubeDate and OuterRoller = 'Green') or(CenterScheduledFlag ='1' and CenterScheduled = @TubeDate and CenterRoller = 'Green') Order By Case When OuterScheduled = @TubeDate Then OuterScheduleOrder When CenterScheduled = @TubeDate Then CenterScheduleOrder end">
                <SelectParameters>
                    <asp:ControlParameter ControlID="tubeCalendar" Name="TubeDate" PropertyName="SelectedDate" DbType="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <br />
        <div id="footer">
            <strong><asp:Label ID="Label8" runat="server" Text="System Fields - Leave These Alone" Width="145px"></asp:Label></strong><br /><br />
            <asp:Label ID="Label3" runat="server" Text="Prod #:" Width="40px"></asp:Label><asp:TextBox ID="tbProd" runat="server" Width="52px"></asp:TextBox><br />
            <asp:Label ID="Label4" runat="server" Text="From:" Width="40px"></asp:Label><asp:TextBox ID="tbFrom" runat="server" Width="52px"></asp:TextBox><br />
            <asp:Label ID="Label7" runat="server" Text="To:" Width="40px"></asp:Label><asp:TextBox ID="tbTo" runat="server" Width="52px"></asp:TextBox><br />
            <asp:Label ID="Label2" runat="server" Text="Type:" Width="40px"></asp:Label><asp:TextBox ID="tbTubeType" runat="server" Width="52px"></asp:TextBox><br />
            <br />
            <br />
            <br />
            <br />
            <asp:Button ID="btnSave" runat="server" Text="System Auto Save" />
        </div>


    </form>
</body>
</html>
