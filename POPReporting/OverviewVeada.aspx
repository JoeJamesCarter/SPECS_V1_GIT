<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OverviewVeada.aspx.vb" Inherits="OverviewProd" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Overview Veada</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="StyleSheet.css" rel="stylesheet" />
    <link rel="stylesheet" href="./scripts/css/bootstrap.min.css" />
    <style>
        #mainupcoming {
            float: left;
        }

        #southupcoming {
            float: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="h3 text-center w-100 bg-success font-weight-bold text-light">
                VEADA OVERVIEW
                <asp:Label ID="lblToday" runat="server" Text=""></asp:Label>
            </div>
            <div class="row ml-2">
                <div id="main" class="ml-2 mr-2 float-left w-auto">
                    <h5>
                        <asp:Label ID="Label1" runat="server" Text="Label">MAIN</asp:Label></h5>
                    <table width="180px" class="table table-sm">
                        <tbody>
                            <tr>
                                <td></td>
                                <td class="text-center">Actual</td>
                                <td class="text-center">Goal</td>
                                <td class="text-center">Variance</td>
                            </tr>
                            <tr>
                                <td>WIP w/Furn Inst</td>
                                <td class="text-center">
                                    <asp:Label ID="lblMWIPWfurn" runat="server" Text="" ToolTip="Furn Installed, Not Shrinked"></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblMWipGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblMWipVariance" runat="server" Text=""></asp:Label></td>
                            </tr>
                            <tr>
                                <td># Sets In Racks </td>
                                <td class="text-center">
                                    <asp:Label ID="lblFurnRackM" runat="server" Text="" ToolTip="Furn Not Red, Not Installed"></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblMRackGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblMRackVariance" runat="server" Text="Label"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Shipped Not Rcvd</td>
                                <td class="text-center">
                                    <asp:Label ID="lblShipNotRcvdM" runat="server" Text="" ToolTip="Furn Red, Shipped"></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblMTruckGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblMTruckVariance" runat="server" Text=""></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Current Total</td>
                                <td class="text-center">
                                    <asp:Label ID="lblMainCurrentTotal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblMainGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblMainVariance" runat="server" Text=""></asp:Label></td>
                            </tr>


                        </tbody>
                    </table>

                </div>

                 <div id="value" class="ml-2 mr-2 float-left w-auto">
                    <h5>
                        <asp:Label ID="Label12" runat="server" Text="Label">VALUE*</asp:Label></h5>
                    <table width="180px" class="table table-sm">
                        <tbody>
                            <tr>
                                <td></td>
                                <td class="text-center">Actual</td>
                                <%--<td class="text-center">Goal</td>
                                <td class="text-center">Variance</td>--%>
                            </tr>
                            <tr>
                                <td>WIP w/Furn Inst</td>
                                <td class="text-center">
                                    <asp:Label ID="lblVWIPWfurn" runat="server" Text="" ToolTip="Furn Installed, Not Shrinked"></asp:Label></td>
                               <%-- <td class="text-center">
                                    <asp:Label ID="lblVWipGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblVWipVariance" runat="server" Text=""></asp:Label></td>--%>
                            </tr>
                            <tr>
                                <td># Sets In Racks </td>
                                <td class="text-center">
                                    <asp:Label ID="lblFurnRackV" runat="server" Text="" ToolTip="Furn Not Red, Not Installed"></asp:Label></td>
                               <%-- <td class="text-center">
                                    <asp:Label ID="lblVRackGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblVRackVariance" runat="server" Text=""></asp:Label></td>--%>
                            </tr>
                            <tr>
                                <td>Shipped Not Rcvd</td>
                                <td class="text-center">
                                    <asp:Label ID="lblShipNotRcvdV" runat="server" Text="" ToolTip="Furn Red, Shipped"></asp:Label></td>
                              <%--  <td class="text-center">
                                    <asp:Label ID="lblVTruckGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblVTruckVariance" runat="server" Text=""></asp:Label></td>--%>
                            </tr>
                            <tr>
                                <td>Current Total</td>
                                <td class="text-center">
                                    <asp:Label ID="lblValueCurrentTotal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblValueGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblValueVariance" runat="server" Text=""></asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="2" class="font-italic">
                                    *Value Actuals added to Main to determine Main Variance
                                </td>                                
                            </tr>
                            <tr class="font-italic">
                                    <td colspan="2">while we determine the Value line targets.
                                        </td>
                                </tr>

                        </tbody>
                    </table>

                </div>

                <div id="south" class="ml-4 float-left w-auto">
                    <h5>
                        <asp:Label ID="Label2" runat="server" Text="Label">SOUTH</asp:Label></h5>

                    <table width="180px" class="table table-sm">
                        <tbody>
                            <tr>
                                <td></td>
                                <td>Actual</td>
                                <td>Goal</td>
                                <td>Variance</td>
                            </tr>
                            <tr>
                                <td>WIP w/ Furn Inst</td>
                                <td class="text-center">
                                    <asp:Label ID="lblSWIPWfurn" runat="server" Text="" ToolTip="Furn Installed, Not Shrinked"></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblSWipGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblSWipVariance" runat="server" Text=""></asp:Label></td>

                            </tr>
                            <tr>
                                <td># Sets In Racks</td>
                                <td class="text-center">
                                    <asp:Label ID="lblFurnRackS" runat="server" Text="" ToolTip="Furn Not Red, Not Installed"></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblSRackGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblSRackVariance" runat="server" Text=""></asp:Label></td>

                            </tr>
                            <tr>
                                <td>Shipped Not Rcvd</td>
                                <td class="text-center">
                                    <asp:Label ID="lblShipNotRcvdS" runat="server" Text="" ToolTip="Furn Red, Shipped"></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblSTruckGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblSTruckVariance" runat="server" Text=""></asp:Label></td>

                            </tr>
                            <tr>
                                <td>Current Total</td>
                                <td class="text-center">
                                    <asp:Label ID="lblSouthCurrentTotal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblSouthGoal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="lblSouthVariance" runat="server" Text=""></asp:Label></td>
                            </tr>

                        </tbody>
                    </table>



                </div>

                <%-- <div id="totals" class="ml-2 float-left w-25">
                    <h5>
                        <asp:Label ID="Label3" runat="server" Text="Label">TOTALS</asp:Label></h5>

                    <table width="180px" class="table table-sm">
                        <tbody>
                            <tr>
                                <td>Total Sets in WIP</td>
                                <td>
                                    <asp:Label ID="lblTotalSetsInWip" runat="server" Text=""></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Total # In Racks</td>
                                <td>
                                    <asp:Label ID="lblFurnRackTotal" runat="server" Text="" ToolTip="Furn Not Red, Not Installed"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Total on Trucks</td>
                                <td>
                                    <asp:Label ID="lblTotalOnTrucks" runat="server" Text=""></asp:Label></td>
                            </tr>


                        </tbody>
                    </table>

                </div>--%>
            </div>
            <hr />
            <div class="row ml-2 mt-2 w-100">
                <div class="float-left w-25">
                    <h5>
                        <asp:Label ID="Label14" runat="server" Text="Label">MAIN</asp:Label></h5>
                    <table width="180px" class="table table-sm">
                        <tbody>

                            <tr>
                                <td>
                                    <asp:Label ID="Label6" runat="server" Text="Label">Greened Today</asp:Label></td>
                                <td>
                                    <asp:Label ID="lblFMain" runat="server" Text="Label"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label9" runat="server" Text="Shrinked Today"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lblShrinkMComplete" runat="server" Text=""></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="float-left w-25">
                    <h5>
                        <asp:Label ID="Label17" runat="server" Text="Label">VALUE</asp:Label></h5>
                    <table width="180px" class="table table-sm">
                        <tbody>

                            <tr>
                                <td>
                                    <asp:Label ID="Label18" runat="server" Text="Label">Greened Today</asp:Label></td>
                                <td>
                                    <asp:Label ID="lblFValue" runat="server" Text=""></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label21" runat="server" Text="Shrinked Today"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lblShrinkVComplete" runat="server" Text=""></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="float-left w-25">
                    <h5>
                        <asp:Label ID="Label15" runat="server" Text="Label">SOUTH</asp:Label></h5>
                    <table width="180px" class="table table-sm">
                        <tbody>

                            <td>
                                <asp:Label ID="Label8" runat="server" Text="Label">Greened Today</asp:Label></td>
                            <td>
                                <asp:Label ID="lblFSouth" runat="server" Text="Label"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label10" runat="server" Text="Shrinked Today"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lblShrinkSComplete" runat="server" Text=""></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="float-left w-25">
                    <h5>
                        <asp:Label ID="Label16" runat="server" Text="Label">TOTALS</asp:Label></h5>
                    <table width="180px" class="table table-sm">
                        <tbody>

                            <tr>
                                <td>
                                    <asp:Label ID="Label4" runat="server" Text="Label">Greened Today</asp:Label></td>
                                <td>
                                    <asp:Label ID="lblFTotal" runat="server" Text="Label"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Text="Shrinked Today" CssClass="mr-2"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lblShrinkTotalComplete" runat="server" Text=""></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>



            </div>


            <div class="row ml-2">

                <div id="baselines" class="row ml-2 mt-2">
                    <asp:GridView ID="gvBaseLines" runat="server" Caption="Shrink/Baseline History" AutoGenerateColumns="false" CssClass="table table-sm" Visible="false">
                        <Columns>
                            <asp:BoundField DataField="DateShrinked" HeaderText="Shrinked">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="MBaseline" HeaderText="Main Baseline">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="MShrinked" HeaderText="Main Shrinked">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SBaseline" HeaderText="South Baseline">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SShrinked" HeaderText=" South Shrinked">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <hr />
            <div id="hide" class="row ml-2">
                <div id="late" class="mt-2 ml-2 w-25 float-left">
                    <h5>
                        <asp:Label ID="Label5" runat="server" Text="Today's Baselines"></asp:Label></h5>
                    <table class="table table-sm">
                        <tbody>
                            <tr>
                                <td>Main:</td>
                                <td>
                                    <asp:Label ID="lblTodaysMainBL" runat="server" Text=""></asp:Label></td>
                            </tr>
                            <tr>
                                <td>South:</td>
                                <td>
                                    <asp:Label ID="lblTodaysSouthBL" runat="server" Text=""></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="mt-2 w-25 float-left">
                    <h5>
                        <asp:Label ID="Label19" runat="server" Text="Daily Goals = B/L + Goal" ToolTip="Prod > BaseLine + Goal and Furniture is Not Red"></asp:Label></h5>
                    <table class="table table-sm">
                        <tbody>
                            <tr>
                                <td>Main:</td>
                                <td>
                                    <asp:Label ID="lblMDailyGoal" runat="server" Text=""></asp:Label></td>
                            </tr>
                            <tr>
                                <td>South:</td>
                                <td>
                                    <asp:Label ID="lblSDailyGoal" runat="server" Text=""></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <hr />
            <div class="row ml-2 mt-4">
                <div class="float-left ml-2 w-auto">

                    <h5>
                        <asp:Label ID="Label13" runat="server" Text="CURRENT STATUS" ToolTip="Min to Max Prod # Due Today"></asp:Label></h5>
                    <table class="table table-sm">
                        <tbody>
                            <tr>
                                <td></td>
                                <td class="text-center">GOAL</td>
                                <td class="text-center">NOT SHIPPED</td>
                                <td class="text-center">SHIPPED AHEAD</td>
                            </tr>
                            <tr>
                                <td>Main:</td>
                                <td class="text-center">
                                    <asp:Label ID="lblMGoal" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="lblBOM" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="lblMAhead" runat="server" Text=""></asp:Label></td>
                            </tr>
                            <%-- <tr>
                                <td>Value:</td>
                                <td class="text-center">
                                    <asp:Label ID="lblVGoal" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="lblBOV" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="lblVAhead" runat="server" Text=""></asp:Label></td>
                            </tr>--%>
                            <tr>
                                <td>South:</td>
                                <td class="text-center">
                                    <asp:Label ID="lblSGoal" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="lblBOS" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="lblSAhead" runat="server" Text=""></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class=" ml-4 w-auto float-left">
                    <h5>
                        <asp:Label ID="Label3" runat="server" Text="BO's/RGA's"></asp:Label></h5>
                    <table class="table table-sm">
                        <tbody>
                            <tr>
                                <td></td>
                                <td>BO Boats</td>
                                <td>BO Lines</td>
                                <td>RGA Boats</td>
                                <td>RGA Lines</td>
                            </tr>
                            <tr>
                                <td>Main:</td>
                                <td class="text-center">
                                    <asp:Label ID="BOBoatsM" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="BOsM" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="RGAboatsM" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="RGAsM" runat="server" Text=""></asp:Label></td>
                            </tr>
                             <tr>
                                <td>Value:</td>
                                <td class="text-center">
                                    <asp:Label ID="BOBoatsV" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="BOsV" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="RGAboatsV" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="RGAsV" runat="server" Text=""></asp:Label></td>
                            </tr>
                            <tr>
                                <td>South:</td>
                                <td class="text-center">
                                    <asp:Label ID="BoBoatsS" runat="server" Text=""></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="BOsS" runat="server" Text="Label"></asp:Label></td>
                                <td class="ml-4 text-center">
                                    <asp:Label ID="RGABoatsS" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="RGAsS" runat="server" Text="Label"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Totals</td>
                                <td class="text-center">
                                    <asp:Label ID="BoBoatsTotal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="BOsTotal" runat="server" Text="Label"></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="RGABoatsTotal" runat="server" Text=""></asp:Label></td>
                                <td class="text-center">
                                    <asp:Label ID="RGAsTotal" runat="server" Text="Label"></asp:Label></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>

            <hr />
            <div class="row ml-2">
                <h5 class="ml-2">Past Due Sets - Prod #'s <= Daily Goal and Not Showing Shipped</h5>
            </div>
            <div class="row ml-2 w-100">

                <div class="ml-2  float-left w-50">

                    <asp:GridView ID="gvLate" runat="server" CssClass="table table-sm" AutoGenerateColumns="true" Caption="Main/Value">
                    </asp:GridView>
                </div>
                <%-- <div class="ml-2  float-left w-25">

                    <asp:GridView ID="gvLateV" runat="server" CssClass="table table-sm w-100" AutoGenerateColumns="true" Caption="Main">
                    </asp:GridView>
                </div>--%>
                <div class="float-left w-25 ml-4">
                    <asp:GridView ID="gvLateS" runat="server" CssClass="table table-sm" AutoGenerateColumns="true" Caption="South">
                    </asp:GridView>
                </div>
            </div>
            <asp:Label ID="Label7" runat="server" CssClass="h5" Text="Veada's Counts Scanned Out Per Day"></asp:Label>
            <asp:GridView ID="gvMainShipped" runat="server" AutoGenerateColumns="True" AllowSorting="true" Caption="Main Scanned Out" CssClass="float-left m-2">
                <Columns>
                </Columns>
            </asp:GridView>
            <%-- <asp:GridView ID="gvValueShipped" runat="server" AutoGenerateColumns="True" AllowSorting="true" Caption="Value Scanned Out" CssClass="float-left m-2">
                <Columns>
                </Columns>
            </asp:GridView>--%>

            <asp:GridView ID="gvSouthShipped" runat="server" AutoGenerateColumns="True" AllowSorting="true" Caption="South Scanned Out" CssClass="float-left m-2">
                <Columns>
                </Columns>
            </asp:GridView>

            <asp:GridView ID="gvTotalsShipped" runat="server" AutoGenerateColumns="true" AllowSorting="true" Caption="Total Scanned Out" CssClass="float-left m-2">
                <Columns>

                    <%--<asp:BoundField DataField="ProdNo" />
                    <asp:BoundField DataField="BuildLoc" />
                    <asp:BoundField DataField="Shipped" />
                    <asp:BoundField DataField="TruckNum" />
                    <asp:BoundField DataField="FurnitureStatus" SortExpression="FurnitureStatus" />--%>
                </Columns>
            </asp:GridView>

            <%--Uncomment these and the databind to help find baseline + goal--%>
            <asp:Button ID="bntShowUpcoming" runat="server" Text="Show/Hide Upcoming Boats List" />
            <hr />
            
            <div id="upcoming">
                <div class="row ml-2 w-100">
                    <asp:Label ID="upcomingLbl" runat="server" CssClass="h4" visible="false" Text="Upcoming Boats To Help Find Baseline + Goal"></asp:Label>
                </div>
                <div class="row ml-2 w-100">
                    <div id="mainupcoming">
                        <asp:GridView ID="gvTest2" runat="server" Visible="false">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div id="southupcoming">
                        <asp:GridView ID="gvTest3" runat="server" Visible="false">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
     
    </form>

    <script src="./scripts/jquery-3.5.0.min.js"></script>
    <script src="./scripts/fontawesome.js"></script>
    <script src="./scripts/bootstrap.min.js"></script>
</body>
</html>
