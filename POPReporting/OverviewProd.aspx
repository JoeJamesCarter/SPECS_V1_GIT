<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OverviewProd.aspx.vb" Inherits="OverviewProd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report Card v.2</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="StyleSheet.css" rel="stylesheet" />
    <link rel="stylesheet" href="./scripts/css/bootstrap.min.css" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="h3 text-center w-100 bg-success font-weight-bold text-light">OVERVIEW - PRODUCTION</div>
            <div id="greenedToday" class="m-2 float-left">
                <table class="table table-sm text-right table-bordered">
                    <caption class="bg-dark text-light text-center">
                        <i class="fas fa-traffic-light mr-1"></i>Materials Greened<br />
                        Today</caption>
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Main</th>
                            <th scope="col">South</th>
                            <th scope="col">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th class="text-left" scope="row">F</th>
                            <td>
                                <asp:Label ID="lblFMain" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFSouth" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">FG</th>
                            <td>
                                <asp:Label ID="lblFGMain" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFGSouth" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFGTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">C</th>
                            <td>
                                <asp:Label ID="lblCMain" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCSouth" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">R</th>
                            <td>
                                <asp:Label ID="lblRMain" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblRSouth" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblRTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>


                        <tr>
                            <th class="text-left" scope="row">T</th>
                            <td>
                                <asp:Label ID="lblTMain" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblTSouth" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblTTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">CT</th>
                            <td>
                                <asp:Label ID="lblCTMain" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCTSouth" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCTTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">G</th>
                            <td>
                                <asp:Label ID="lblGMain" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblGSouth" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblGTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">H</th>
                            <td>
                                <asp:Label ID="lblHMain" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblHSouth" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblHTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">A/T</th>
                            <td></td>
                            <td></td>
                            <td>
                                <asp:Label ID="lblATTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">Q FG</th>
                            <td></td>
                            <td></td>
                            <td>
                                <asp:Label ID="lblQFTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                    </tbody>
                </table>
            </div>

            <div id="stocklevels" class=" m-2 float-left">
                <table class="table table-sm text-right table-bordered">
                    <caption class="bg-dark text-light text-center">
                        Stock Levels
                        <br />
                        (M-No Floor, S-No Rails)</caption>
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Main</th>
                            <th scope="col">South</th>
                            <th scope="col">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th class="text-left" scope="row">F</th>
                            <td>
                                <asp:Label ID="lblFurnStockM" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFurnStockS" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFurnStockTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">FG</th>
                            <td>
                                <asp:Label ID="lblFGStockM" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFGStockS" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFGStockTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">C</th>
                            <td>
                                <asp:Label ID="lblCanvasStockM" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCanvasStockS" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCanvasStockTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">R</th>
                            <td>
                                <asp:Label ID="lblRailsStockM" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblRailsStockS" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblRailsStockTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>


                        <tr>
                            <th class="text-left" scope="row">T</th>
                            <td>
                                <asp:Label ID="lblTubeStockM" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblTubeStockS" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblTubeStockTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">CT</th>
                            <td>
                                <asp:Label ID="lblCTStockM" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCTStockS" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCTStockTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">G</th>
                            <td>
                                <asp:Label ID="lblGaugeStockM" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblGaugeStockS" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblGaugeStockTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">H</th>
                            <td>
                                <asp:Label ID="lblHarnessStockM" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblHarnessStockS" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblHarnessStockTotal" runat="server" Text="Label"></asp:Label></td>

                        </tr>

                        <tr>
                            <th class="text-left" scope="row">A/T</th>
                            <td></td>
                            <td></td>
                            <td>
                                <asp:Label ID="lblATStockTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                        <tr>
                            <th class="text-left" scope="row">Q FG</th>
                            <td></td>
                            <td></td>
                            <td>
                                <asp:Label ID="lblQFrontStockTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>

                    </tbody>
                </table>

            </div>

            <div id="completedbyworkstation" class="m-2 float-left">

                <table class="table table-sm text-right table-bordered">
                    <caption class="bg-dark text-light text-center">
                        Completed Today
                        <br />
                        By Workstation</caption>
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Main</th>
                            <th scope="col">South</th>
                            <th scope="col">Total</th>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Frames</th>
                            <td>
                                <asp:Label ID="lblFramesMComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFramesSComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFramesTotalComplete" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Floors</th>
                            <td>
                                <asp:Label ID="lblFloorsMComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFloorsSComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFloorsTotalComplete" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Trim</th>
                            <td>
                                <asp:Label ID="lblTrimMComplete" runat="server" Text=""></asp:Label></td>
                            <td>
                                <asp:Label ID="lblTrimSComplete" runat="server" Text=""></asp:Label></td>
                            <td>
                                <asp:Label ID="lblTrimTotalComplete" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Rails</th>
                            <td>
                                <asp:Label ID="lblRailsMComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblRailsSComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblRailsTotalComplete" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Furniture</th>
                            <td>
                                <asp:Label ID="lblFurnitureMComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFurnitureSComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFurnitureTotalComplete" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Helm</th>
                            <td>
                                <asp:Label ID="lblHelmMComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblHelmSComplete" runat="server" Text=""></asp:Label></td>
                            <td>
                                <asp:Label ID="lblHelmTotalComplete" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Inspection</th>
                            <td>
                                <asp:Label ID="lblCleaningMComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCleaningSComplete" runat="server" Text=""></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCleaningTotalComplete" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Final</th>
                            <td>
                                <asp:Label ID="lblInspectionMComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblInspectionSComplete" runat="server" Text=""></asp:Label></td>
                            <td>
                                <asp:Label ID="lblInspectionTotalComplete" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left bg-success text-light" scope="row">Shrinkwrap</th>
                            <td class="bg-success">
                                <asp:Label ID="lblShrinkMComplete" runat="server" Text="Label" CssClass="text-light font-weight-bold"></asp:Label>
                            </td>
                            <td class="bg-success">
                                <asp:Label ID="lblShrinkSComplete" runat="server" Text="Label" CssClass="text-light font-weight-bold"></asp:Label>
                            </td>
                            <td class="bg-success">
                                <asp:Label ID="lblShrinkTotalComplete" runat="server" Text="Label" CssClass="text-light font-weight-bold"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Rigging</th>
                            <td>
                                <asp:Label ID="lblRiggingMComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblRiggingSComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblRiggingTotalComplete" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Wave Tamer</th>
                            <td>
                                <asp:Label ID="lblWTMComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblWTSComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblWTTotalComplete" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Sharkhide</th>
                            <td>
                                <asp:Label ID="lblSharkhideMComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblSharkhideSComplete" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblSharkhideTotalComplete" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Complete</th>
                            <td>
                                <asp:Label ID="lblCompleteM" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCompleteS" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCompleteTotal" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>

            </div>

            <div id="readybyworkstation" class="m-2 float-left">
                <table class="table table-sm text-right table-bordered">
                    <caption class="bg-dark text-light text-center">
                        Ready By
                        <br />
                        Workstation</caption>
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Main</th>
                            <th scope="col">South</th>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Frames</th>
                            <td>
                                <asp:Label ID="lblFramesMReady" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFramesSReady" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Floors</th>
                            <td>
                                <asp:Label ID="lblFloorsMReady" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFloorsSReady" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Trim</th>
                            <td>
                                <asp:Label ID="lblTrimMReady" runat="server" Text=""></asp:Label></td>
                            <td>
                                <asp:Label ID="lblTrimSReady" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Rails</th>
                            <td>
                                <asp:Label ID="lblRailsMReady" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblRailsSReady" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Furniture</th>
                            <td>
                                <asp:Label ID="lblFurnitureMReady" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFurnitureSReady" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Helm</th>
                            <td>
                                <asp:Label ID="lblHelmMReady" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblHelmSReady" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Inspection</th>
                            <td>
                                <asp:Label ID="lblCleaningMReady" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblCleaningSReady" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Final</th>
                            <td>
                                <asp:Label ID="lblFinalInspectionMReady" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblFinalInspectionSReady" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left bg-success text-light" scope="row">Shrinkwrap</th>
                            <td class="bg-success">
                                <asp:Label ID="lblShrinkMReady" runat="server" Text="Label" class="text-light font-weight-bold"></asp:Label>
                            </td>
                            <td class="bg-success">
                                <asp:Label ID="lblShrinkSReady" runat="server" Text="Label" class="text-light font-weight-bold"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Rigging</th>
                            <td>
                                <asp:Label ID="lblRiggingMReady" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblRiggingSReady" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Wave Tamer</th>
                            <td>
                                <asp:Label ID="lblWTMReady" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblWTSReady" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Sharkhide</th>
                            <td>
                                <asp:Label ID="lblSharkhideMReady" runat="server" Text="Label"></asp:Label></td>
                            <td>
                                <asp:Label ID="lblSharkhideSReady" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                    </thead>

                </table>
            </div>

            <div id="southstats" class="m-2 float-left">
                <table class="table table-sm text-right table-bordered">
                    <caption class="bg-dark text-light text-center">
                        South<br/> Daily Stats</caption>
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Total</th>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Brought In</th>
                            <td>
                                <asp:Label ID="lblBroughtIn" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">South WIP</th>
                            <td>
                                <asp:Label ID="lblWip" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Decks</th>
                            <td>
                                <asp:Label ID="lblDecks" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th class="text-left" scope="row">Ready To Bring In</th>
                            <td>
                                <asp:Label ID="lblSouthReady" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                    </thead>
                </table>
                <br />
                 <table class ="table table-sm text-right table-bordered">
                    <caption class="bg-dark text-light text-center">WIP / Offline / Frame Stack</caption>                    
                        <tr>
                            <th></th>
                            <th scope="col">Main</th>
                            <th scope="col">South</th>
                            <th scope="col">Total</th>
                        </tr>
                    <tr>
                        <th scope="row">WIP</th>
                        <td><asp:Label ID="lblInProgressM" runat="server" Text="Label"></asp:Label></td>
                        <td><asp:Label ID="lblInProgressS" runat="server" Text="Label"></asp:Label></td>
                        <td><asp:Label ID="lblInProgressTotal" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                     <tr>
                        <th scope="row">WIP Past Due</th>
                        <td><asp:Label ID="lblMainPastDueWIP" runat="server" Text="Label"></asp:Label></td>
                        <td><asp:Label ID="lblSouthPastDueWIP" runat="server" Text="Label"></asp:Label></td>
                        <td><asp:Label ID="lblTotalPastDueWIP" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                     <tr>
                        <th scope="row">Offline</th>
                        <td><asp:Label ID="lblOfflineM" runat="server" Text="Label"></asp:Label></td>
                        <td><asp:Label ID="lblOfflineS" runat="server" Text="Label"></asp:Label></td>
                        <td><asp:Label ID="lblOfflineTotal" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                     <tr>
                        <th scope="row">Frame Stack</th>
                        <td><asp:Label ID="lblFrameStacksM" runat="server" Text="Label"></asp:Label></td>
                        <td><asp:Label ID="lblFrameStacksS" runat="server" Text="Label"></asp:Label></td>
                        <td><asp:Label ID="lblFrameStacksTotal" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                    
                </table>
                <br />
                <table class="table table-sm text-right table-bordered">
                    <caption class="bg-dark text-light text-center">Past Due</caption>
                    <thead>
                        <tr>
                            <th scope="col" colspan="2">Behind</th>
                            <th scope="col" colspan="2">Ahead</th>
                            <th scope="col" colspan="2">Variance</th>
                        </tr>
                        <tr>
                            <th scope="row" class="text-left">M</th>
                            <td>
                                <asp:Label ID="lblMainBehind" runat="server" Text="Label"></asp:Label>
                            </td>
                            <th scope="row" class="text-left">M</th>
                            <td>
                                <asp:Label ID="lblMainAhead" runat="server" Text="Label"></asp:Label>
                            </td>
                            <th scope="row" class="text-left">M</th>
                            <td>
                                <asp:Label ID="lblMainDiff" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-left">S</th>
                            <td>
                                <asp:Label ID="lblSouthBehind" runat="server" Text="Label"></asp:Label></td>
                            <th scope="row" class="text-left">S</th>
                            <td>
                                <asp:Label ID="lblSouthAhead" runat="server" Text="Label"></asp:Label></td>
                            <th scope="row" class="text-left">S</th>
                            <td>
                                <asp:Label ID="lblSouthDiff" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                        <tr>
                            <th scope="row" class="text-left">Total</th>
                            <td>
                                <asp:Label ID="lblTotalBehind" runat="server" Text="Label"></asp:Label></td>
                            <th scope="row" class="text-left">Total</th>
                            <td>
                                <asp:Label ID="lblTotalAhead" runat="server" Text="Label"></asp:Label></td>
                            <th scope="row" class="text-left">Score</th>
                            <td>
                                <asp:Label ID="lblScore" runat="server" Text="Label"></asp:Label></td>
                        </tr>
                    </thead>
                </table>
            </div>

             
            <div id="railsstats" class="m-2 float-left">
                <table class="table table-sm text-right table-bordered">
                    <caption class="bg-dark text-light text-center">Rail Racks</caption>                    
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Qty</th>
                        </tr>
                        <tr><th scope="row" class="text-left">M - All Green</th><td style="background-color:lightgreen"><asp:Label ID="lblRailsGreen" runat="server" Text=""></asp:Label></td></tr>
                        <tr><th scope="row" class="text-left">M - All Green/Rails Missing</th><td style="background-color:lightblue"><asp:Label ID="lblRailsBlue" runat="server" Text=""></asp:Label></td></tr>
                        <tr><th scope="row" class="text-left">S - Req'd/Ready To Panel</th><td style="background-color:orange"><asp:Label ID="lblRailsOrange" runat="server" Text=""></asp:Label></td></tr>
                        <tr><th scope="row" class="text-left">S - Req'd/Not Ready</th><td style="background-color:yellow"><asp:Label ID="lblRailsYellow" runat="server" Text=""></asp:Label></td></tr>
                        <tr><th scope="row" class="text-left">S - All Green/Rails Missing</th><td style="background-color:tan"><asp:Label ID="lblRailsTan" runat="server" Text=""></asp:Label></td></tr>
                        <tr><th scope="row" class="text-left"># Empty Slots</th><td><asp:Label ID="lblEmptySlots" runat="server" Text=""></asp:Label></td></tr>
                    
                </table>
                <br />
                 <table class="table table-sm text-right table-bordered">
                    <caption class="bg-dark text-light text-center">Rail Sets In Stock</caption>                    
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Main</th>
                            <th scope="col">South</th>
                            <th scope="col">Total</th>
                        </tr>
                        <tr><th scope="row" class="text-left">All</th>
                            <td ><asp:Label ID="lblAllRailsM" runat="server" Text=""></asp:Label></td>
                            <td><asp:Label ID="lblAllRailsS" runat="server" Text=""></asp:Label></td>
                            <td><asp:Label ID="lblAllRailsTotal" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr><th scope="row" class="text-left">Partial</th>
                            <td><asp:Label ID="lblPartialRailsM" runat="server" Text=""></asp:Label></td>
                            <td><asp:Label ID="lblPartialRailsS" runat="server" Text=""></asp:Label></td>
                            <td><asp:Label ID="lblPartialRailsTotal" runat="server" Text=""></asp:Label></td>
                        </tr>                        
                </table>
                <br />
                   <table class="table table-sm text-right">
                   
                    <tr>
                        <td colspan="3">
                            <asp:Image ID="health" runat="server" ImageUrl="images/health.png" />
                        </td>
                    </tr>
                    <tr>
                        <td class="w-25 text-center font-weight-bold">
                            <asp:Label ID="lblHealthM" runat="server" Text="" CssClass="h3" ToolTip="Sum of Ready in Floors, Rails Ready to Pull (rack map light green), Rails Pulled (Framed or Not) and Ready Being Framed."></asp:Label>
                        </td>
                        <td class="w-50"></td>
                        <td class="w-25 text-center font-weight-bold">
                            <asp:Label ID="lblHealthS" runat="server" Text="Label" CssClass="h3"></asp:Label>
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="3">
                            <table class= "table-sm text-right table-bordered">
                                 <tr>
                                    <td></td>
                                     <th class="text-left" scope="row">Main</th>
                                    <th class="text-left" scope="row">South</th>
                                      <th class="text-left" scope="row">Total</th>
                                </tr>
                                <tr>
                                    <th class="text-left" scope="row">Rails Pulled<br />Not Framed</th>                                    
                                    <td><asp:Label ID="lblRailsPulledMNotFramed" runat="server" Text="Label"></asp:Label></td>
                                    <td><asp:Label ID="lblRailsPulledSNotFramed" runat="server" Text="Label"></asp:Label></td>
                                    <td><asp:Label ID="lblRailsPulledTotalNotFramed" runat="server" Text="Label"></asp:Label></td>
                                </tr>
                                  <tr>
                                    <th class="text-left" scope="row">Rails Pulled<br />Framed</th>                                    
                                    <td><asp:Label ID="lblRailsPulledMFramed" runat="server" Text="Label"></asp:Label></td>
                                    <td><asp:Label ID="lblRailsPulledSFramed" runat="server" Text="Label"></asp:Label></td>
                                    <td><asp:Label ID="lblRailsPulledTotalFramed" runat="server" Text="Label"></asp:Label></td>
                                </tr> 
                                  <tr>
                                    <th class="text-left" scope="row">Paneled<br />Rdy to Frame</th>                                    
                                    <td><asp:Label ID="lblReadyNeedsFramedM" runat="server" Text="Label"></asp:Label></td>
                                    <td><asp:Label ID="lblReadyNeedsFramedS" runat="server" Text="Label"></asp:Label></td>
                                    <td><asp:Label ID="lblReadyNeedsFramedTotal" runat="server" Text="Label"></asp:Label></td>
                                </tr> 
                            </table>

                        </td>
                    </tr>


                </table>
            </div>
            
            <div id="furnstats" class="m-2 float-left">
                   <table class="table table-sm text-right table-bordered">
                    <caption class="bg-dark text-light text-center">Furniture Racks</caption>                    
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Qty</th>
                        </tr>
                        <tr><th scope="row" class="text-left">Empty</th><td><asp:Label ID="lblFurnEmptySpaces" runat="server" Text=""></asp:Label></td></tr>
                        <tr><th scope="row" class="text-left">Other</th><td style="background-color:black;color:white"><asp:Label ID="lblFurnDisabledSpaces" runat="server" Text=""></asp:Label></td></tr>
                        <tr><th scope="row" class="text-left">Green Sets</th><td style="background-color:green;color:white"><asp:Label ID="lblFurnGreen" runat="server" Text=""></asp:Label></td></tr>
                        <tr><th scope="row" class="text-left">Yellow/Red Sets</th><td style="background-color:yellow; border-color:red; border-width:2px"><asp:Label ID="lblFurnYellowRed" runat="server" Text=""></asp:Label></td></tr>
                        <tr><th scope="row" class="text-left">Yellow Sets (BO/RGA)</th><td style="background-color:yellow"><asp:Label ID="lblFurnYellow" runat="server" Text=""></asp:Label></td></tr>
                    
                </table>
                <br />
                <table class="table table-sm text-right table-bordered">
                    <caption class="bg-dark text-light text-center">Veada Issues</caption>                    
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Main</th>
                            <th scope="col">South</th>
                            <th scope="col">Total</th>
                        </tr>
                    <tr>
                        <th scope="row" class="text-left">RGA's</th>
                        <td><asp:Label ID="RGAsM" runat="server" Text="Label"></asp:Label></td>
                        <td><asp:Label ID="RGAsS" runat="server" Text="Label"></asp:Label></td>
                        <td><asp:Label ID="RGAsTotal" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                    <tr>
                        <th scope="row" class="text-left">BO's</th>
                        <td><asp:Label ID="BOsM" runat="server" Text="Label"></asp:Label></td>
                        <td> <asp:Label ID="BOsS" runat="server" Text="Label"></asp:Label></td>
                        <td><asp:Label ID="BOsTotal" runat="server" Text="Label"></asp:Label></td>
                    </tr>

                    </table>
             
            </div>

         
        </div>
    </form>

    <script src="./scripts/jquery-3.5.0.min.js"></script>
    <script src="./scripts/fontawesome.js"></script>
    <script src="./scripts/bootstrap.min.js"></script>
</body>
</html>
