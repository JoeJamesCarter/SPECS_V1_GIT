<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ChineFoilDailySchedule.aspx.vb" Inherits="Tubes_ChineFoilDailySchedule" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chines/Foils Daily Cut Sheet</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .content {
            font-family:Calibri;
            font-size:20px;
            position:fixed;
        }
        #cal {
            float: left;
            width: 550px;
            height: 100%;
        }

        #results {
            width: 500px;
            height: auto;
        }

        @media print {

            #centers {
                visibility: hidden;
            }
            #outers {
                visibility: hidden;
            }
            #results {
                visibility: visible;
                background-color: white;
                height: 100%;
                width: 100%;
                position: absolute;
                top: 0;
                left: 0;
                margin: 0;
                padding: 15px;
                font-size: 18px;
                line-height: 18px;
            }
            #btnPrint {
                visibility: hidden;
            }

            #lblBelow {
                visibility: hidden;
            }

            #dividerline {
                visibility: hidden;
            }
        }

        #outers {
            width: 70%;
            float: left;
        }

        #centers {
            float: left;
            width: 70%;
        }

        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="content">
            <div id="cal">
                <asp:Calendar ID="calSelectedDate" runat="server"></asp:Calendar>
                <br />
                <asp:Button ID="btnCalc" runat="server" Text="Calculate Cut Sheet" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnMaintain" runat="server" Text="Maintain Datasource" />
                <br />
                <br />

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="CUTSHEET" runat="server" Text="CUT SHEET   - " CssClass="newStyle7"></asp:Label><asp:Label ID="lblSelectedDate" runat="server" Text="" CssClass="newStyle7"></asp:Label><br />
                <br />
                <asp:GridView ID="gvOuterSummary" runat="server" Caption="Outers Summary" Width="415px">
                </asp:GridView>

                <br />
                <br />
                <asp:GridView ID="gvCentersSummary" runat="server" Caption="Centers Summary" Width="413px">
                </asp:GridView>

                <br />
                <br />

                <div id="results">
                    <asp:Label ID="lblBelow" runat="server" CssClass="newStyle4" Text="Below are Top 2 Grids Consolidated For Prod"></asp:Label>
                    <hr id="dividerline" class="newStyle6" />
                    <asp:Label ID="CUTSHEET0" runat="server" Text="CHINE/FOIL CUT LIST" CssClass="newStyle7" Width="500px"></asp:Label><br />
                    <br />
                    <asp:Label ID="lblSelectedDate0" runat="server" Text="" CssClass="newStyle7" Width="500"></asp:Label>

                    <br />
                    <br />
                    <asp:GridView ID="gvaltered" runat="server" Caption="Outer & Centers Summary w/Lengths (Sealed in Blue)" Width="500">
                    </asp:GridView>
                    <br />
                    <br />
                    <asp:GridView ID="gvStockRequiredSummary" runat="server" Caption="Stock Required Summary (Sealed in Blue)" Width="500">
                    </asp:GridView>
                    <br />
                    <asp:Button ID="btnPrint" runat="server" Text="Right Click On the Page and Click Print" Enabled="false" />
                    <br />
                    <br />
                    <br />

                </div>
            </div>

            <div id="outers">
                <asp:Label ID="Label3" runat="server" Text="Outer Tubes"></asp:Label>
                <asp:GridView ID="gvOuters" runat="server" AutoGenerateColumns="False" DataSourceID="sdsOtrTubesForSelectedDay" Width="1673px" AllowSorting="True">
                    <Columns>
                        <asp:BoundField DataField="OuterScheduleOrderPlus1" HeaderText="Sched Order" SortExpression="OuteScheduleOrderPlus1" />
                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" />
                        <asp:BoundField DataField="TubeModel" HeaderText="Model (for tubes)" SortExpression="TubeModel" />
                        <asp:BoundField DataField="Style" HeaderText="Style" SortExpression="Style" />
                        <asp:BoundField DataField="IO" HeaderText="IO" SortExpression="IO" />
                        <asp:BoundField DataField="PerfPkg" HeaderText="Perf Pkg" SortExpression="PerfPkg" />
                        <asp:BoundField DataField="OtrTubeLength" HeaderText="Outer Length" SortExpression="OtrTubeLength" />

                        <asp:BoundField DataField="Strakes" HeaderText="Outer Strakes" SortExpression="Strakes" />

                        <asp:TemplateField HeaderText="Inside">
                            <ItemTemplate>
                                <asp:Label ID="OtrTubes_Inner" runat="server" Text=""></asp:Label>

                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Inside Qty">
                            <ItemTemplate>
                                <asp:Label ID="lblInsideQty" runat="server" Text=""></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Inside Stock">
                            <ItemTemplate>
                                <asp:Label ID="InsideStock" runat="server" Text=""></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="<-------->">
                            <ItemTemplate>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Outside">
                            <ItemTemplate>
                                <asp:Label ID="OtrTubes_Outer" runat="server" Text=""></asp:Label>

                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Outside Qty">
                            <ItemTemplate>
                                <asp:Label ID="lblOutsideQty" runat="server" Text=""></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Outside Stock">
                            <ItemTemplate>
                                <asp:Label ID="OutsideStock" runat="server" Text=""></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsOtrTubesForSelectedDay" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT p1.ProdNo, [OuterScheduled], Left(TubeModel,2) as OtrTubeLength, TubeModel, Case when TubeModel Like '%IO%' Then 1 Else 0 End As IO, Strakes, Style, OuterScheduleOrder + 1 as OuterScheduleOrderPlus1, Case when TubeModel like '%RT%' then 'RT' When p3.PerfPkg is Null Then '' else PerfPkg end as PerfPkg FROM [Tubes] as p1 left join OuterTubeDetails as p2 on p1.ProdNo = p2.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY as p3 on p1.ProdNo = p3.ProdNo WHERE ([OuterScheduled] = @OuterScheduled) order by OuterScheduleOrderPlus1">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="calSelectedDate" DbType="Date" Name="OuterScheduled" PropertyName="SelectedDate" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <br />
            <div id="centers">
                <asp:Label ID="Label4" runat="server" Text="Center Tubes"></asp:Label>
                <asp:GridView ID="gvCenters" runat="server" DataSourceID="sdsCtrTubesForSelectedDay" AutoGenerateColumns="False" Width="1331px">
                    <Columns>
                        <asp:BoundField DataField="CenterScheduleOrderPlus1" HeaderText="Sched Order" />
                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                        <asp:BoundField DataField="BoatWidth" HeaderText="Boat Width" />
                        <asp:BoundField DataField="TubeModel" HeaderText="Tube Model" />
                        <asp:BoundField DataField="IO" HeaderText="IO" />
                        <asp:BoundField DataField="PerfPkg" HeaderText="PerfPkg" />
                        <asp:BoundField DataField="CtrTubeLength" HeaderText="CtrTubeLength" />
                        <asp:BoundField DataField="Strakes" HeaderText="Center Strakes" />
                        <asp:TemplateField HeaderText="Center Chines Length">
                            <ItemTemplate>
                                <asp:Label ID="lblCenterLength" runat="server" Text='<%#Eval("CtrChinesLength") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="QTY">
                            <ItemTemplate>
                                <asp:Label ID="lglCtrQty" runat="server" Text="2"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Center Stock">
                            <ItemTemplate>
                                <asp:Label ID="lblCenterStock" runat="server" Text=""></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsCtrTubesForSelectedDay" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT p1.ProdNo, [CenterScheduled], p3.Length as CtrTubeLength, p2.Strakes, Center, CenterScheduleOrder + 1 as CenterScheduleOrderPlus1, Case when TubeModel like '%RT%' then 'RT' When p3.PerfPkg is Null Then '' else PerfPkg end as PerfPkg, Case when TubeModel like '%X1%' or TubeModel like '%X2%' Then 10 else 8.5 end as BoatWidthFromModel, p4.BoatWidth, CtrChinesLength, p3.IO, p5.TubeModel FROM [Tubes] as p1 left join CenterTubeDetails as p2 on p1.ProdNo = p2.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY as p3 on p1.ProdNo = p3.ProdNo Left join OuterTubeDetails as p5 on p1.ProdNo = p5.ProdNo Left Join Tubes_ChinesFoilsConfigs as p4 on (p3.Length = p4.TubeLengthJustFt and p3.IO = p4.IO and p3.PerfPkg = p4.Perf and p4.BoatWidth = Case when TubeModel like '%X1%' or TubeModel like '%X2%' Then 10 else 8.5 end) WHERE ([CenterScheduled] = @CenterScheduled) order by CenterScheduleOrderPlus1">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="calSelectedDate" DbType="Date" Name="CenterScheduled" PropertyName="SelectedDate" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>


        </div>
    </form>
</body>
</html>
