<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BoatLocations.aspx.vb" Inherits="YardMaster_BoatLocations" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Boat Locations</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .Initial {
            display: block;
            padding: 4px 18px 4px 18px;
            float: left;
            background: url("../Images/InitialImage.png") no-repeat right top;
            color: Black;
            font-weight: bold;
        }

            .Initial:hover {
                color: White;
                background: url("../Images/SelectedButton.png") no-repeat right top;
            }

        .Clicked {
            float: left;
            display: block;
            background: url("../Images/SelectedButton.png") no-repeat right top;
            padding: 4px 18px 4px 18px;
            color: Black;
            font-weight: bold;
            color: White;
        }

        #left {
            float: left;
            width: 40%;
        }

        #right {
            text-align: center;
            width: 40%;
            float: left;
        }

        #actions {
            float: left;
            width: 20%;
            height: 600px;
            font-family: Calibri;
            font-size: 30px;
        }

        .gvLocs {
            margin-left: 5px;
            float: left;
            font-weight: normal;
            font-family: Calibri;
        }

        .auto-style1 {
            width: 1376px;
        }

        .selectionResults {
            font-family: Calibri;
            font-size: 25px;
            font-weight: bold;
        }

        .selectionResultValue {
            font-family: Calibri;
            font-size: 25px;
            font-weight: bold;
            color: blue;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="left">
            <table>
                <tr>
                    <td>
                        <asp:Button Text="Search" BorderStyle="None" CssClass="Initial" ID="Search" runat="server" OnClick="Search_Click" />
                        <asp:Button Text="Incomplete" BorderStyle="None" CssClass="Initial" ID="Incomplete" runat="server" OnClick="Incomplete_Click" />
                        <asp:Button Text="Tube Repair/Replace" BorderStyle="None" CssClass="Initial" ID="Tubes" runat="server" OnClick="Tubes_Click" />
                        <asp:Button Text="Pick Ups/Drop Offs" BorderStyle="None" CssClass="Initial" ID="Transport" runat="server" OnClick="Transport_Click" />
                        <asp:MultiView ID="MainView" runat="server">
                            <asp:View ID="View5" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td class="auto-style1">
                                            <h3>Slots:
                        <asp:DropDownList ID="ddlShowAllSlots" runat="server" AutoPostBack="True">
                            <asp:ListItem Value="0">Hide Filled</asp:ListItem>
                            <asp:ListItem Value="1">Show All</asp:ListItem>
                        </asp:DropDownList>
                                                &nbsp;&nbsp;
                   
                                            </h3>
                                            <h3>
                                                <asp:Label ID="lblSearch" runat="server" Text="Search By"></asp:Label>
                                                &nbsp; Prod #:&nbsp;<asp:TextBox ID="tbSearchProdNo" runat="server" Width="76px"></asp:TextBox>
                                                &nbsp;
                          <asp:Button ID="btnClearSearch" runat="server" Text="Clear" />
                                            </h3>
                                            <h3>
                                                <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsSearchResults" ForeColor="Black" GridLines="Vertical" Width="350px">
                                                    <AlternatingRowStyle BackColor="#CCCCCC" />
                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                        <asp:BoundField DataField="ItemNo" HeaderText="Model" />
                                                        <asp:BoundField DataField="BuildLoc" HeaderText="Bldg">
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="CurrentStatus" HeaderText="Next" />
                                                      
                                                        <asp:BoundField DataField="SlotKey" HeaderText="Location">
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Clear Location">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnTaken" runat="server" Text="Clear" CommandArgument="<%# Container.DataItemIndex %>" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' CommandName="clearloc" />
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                         <asp:BoundField DataField="ActionRequired" HeaderText="Open Tube Issues">
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="sdsSearchResults" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.CusName, SlotKey, Rack, Row, Filled, BuildLoc, ActionRequired, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus From BML_POPREPORTING_GREENLIGHTS Left Join Yard_Master_Locations on BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported) Tubes_DamageReported on Yard_Master_Locations.ProdNo = Tubes_DamageReported.ProdNo and (ReplacedFlag = 0 and RepairedFlag = 0) Where (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') and (BML_POPREPORTING_GREENLIGHTS.IsInvoiced = 0) and (BML_POPREPORTING_GREENLIGHTS.TubesStatus = 2) Order By BML_POPREPORTING_GREENLIGHTS.ProdNo">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="tbSearchProdNo" DefaultValue="A%" Name="Search" Type="String" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </h3>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>


                            <asp:View ID="View3" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <asp:Label ID="lblIncomplete" runat="server" Text="Through Shrink"></asp:Label>
                                                <asp:GridView ID="gvIncomplete" CssClass="newStyle1" runat="server" DataSourceID="sdsIncomplete" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="350px" DataKeyNames="ProdNo">
                                                    <AlternatingRowStyle BackColor="#CCCCCC" />
                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" />

                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                        <asp:BoundField DataField="ItemNo" HeaderText="Model" />
                                                        <asp:BoundField DataField="CurrentStatus" HeaderText="Next" />
                                                        <asp:BoundField DataField="ActualLoadDate" DataFormatString="{0:d}" HeaderText="To Be Loaded" />
                                                        <asp:BoundField DataField="SlotKey" HeaderText="Location" />
                                                    </Columns>
                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="sdsIncomplete" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, SlotKey, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End as CurrentStatus, ActualLoadDate From BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo Left Join Yard_Master_Locations on BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Where BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus = 2 and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 Order By ActualLoadDate desc, BML_POPREPORTING_GREENLIGHTS.ProdNo"></asp:SqlDataSource>

                                            </h3>
                                        </td>
                                    </tr>
                                </table>

                            </asp:View>
                            <asp:View ID="View4" runat="server">

                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <asp:Label ID="Label1" runat="server" Text="Tubes Needing Repair or Replace"></asp:Label>
                                                <asp:GridView ID="gvTubeDamage" CssClass="newStyle1" runat="server" DataSourceID="sdsTubeDamage" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="350px" DataKeyNames="ProdNo">
                                                    <AlternatingRowStyle BackColor="#CCCCCC" />
                                                    <Columns>

                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                        <asp:BoundField DataField="ItemNo" HeaderText="Model" />
                                                        <asp:BoundField DataField="CurrentStatus" HeaderText="Next" />
                                                        <asp:BoundField DataField="ActualLoadDate" DataFormatString="{0:d}" HeaderText="To Be Loaded" />
                                                        <asp:BoundField DataField="ActionRequired" HeaderText="Action Required" />
                                                        <asp:BoundField DataField="SlotKey" HeaderText="Location" />
                                                        <asp:TemplateField HeaderText="Clear Location">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnTaken" runat="server" Text="Clear" CommandArgument="<%# Container.DataItemIndex %>" Visible='<%# IIf(Eval("Filled").ToString() = "", 0, Eval("Filled")) = 1%>' CommandName="clearloc" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="sdsTubeDamage" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Tubes_DamageReported.*, ItemNo, SlotKey, Filled, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End as CurrentStatus, ActualLoadDate From Tubes_DamageReported Left Join BML_POPREPORTING_GREENLIGHTS on Tubes_DamageReported.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Yard_Master_Locations on Tubes_DamageReported.ProdNo = Yard_Master_Locations.ProdNo Left Join Load_Scheduling on Tubes_DamageReported.ProdNo = Load_Scheduling.ProdNo Where ((RepairReqdFlag = '1' and RepairedFlag = '0') or (ReplaceReqdFlag = '1' and ReplacedFlag = '0'))  Order By case when ActualLoadDate is null then 1 else 0 end, ActualLoadDate asc, BML_POPREPORTING_GREENLIGHTS.ProdNo"></asp:SqlDataSource>

                                            </h3>
                                        </td>
                                    </tr>
                                </table>


                            </asp:View>
                            <asp:View ID="View6" runat="server">

                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <asp:Label ID="Label2" runat="server" Text="Pick Up and Drop Off Requests"></asp:Label><br />
                                                <asp:Button ID="btnTaken" runat="server" Text="Refresh" CommandName="refresh" CssClass="btn pl-2" /><br />
                                                <br />
                                                <asp:Label ID="Label3" CssClass="newStyle1" runat="server" Text="This will clear the delivery request and clear the slot the boat was taken from in the yard if applicable."></asp:Label><br />
                                                <asp:GridView ID="gvTranspoM" runat="server" CssClass="newStyle1" AutoGenerateColumns="False" DataSourceID="sdsTransportReqsM">
                                                    <Columns>
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" />
                                                        <asp:BoundField DataField="AutoID" HeaderText="Req ID" SortExpression="AutoID" />
                                                        <asp:BoundField DataField="Structure" HeaderText="" SortExpression="Structure" />
                                                        <asp:BoundField DataField="DateReqd" HeaderText="Requested" SortExpression="DateReqd" />
                                                        <asp:BoundField DataField="SlotKey" HeaderText="Yard Location" SortExpression="SlotKey" />
                                                        <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                                                        <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" />
                                                        <asp:BoundField DataField="ToOrFrom" HeaderText="To Or From" SortExpression="ToOrFrom" />
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnTaken" runat="server" Text="Clear" CommandArgument="<%# Container.DataItemIndex %>" CommandName="clearlocandreq" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>

                                                <asp:SqlDataSource ID="sdsTransportReqsM" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo, t1.AutoID, [Structure], [DateReqd], [Action], [ToOrFrom], BuildLoc, SlotKey, Filled FROM [TransportReqs] t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo left join Yard_Master_Locations t3 on t1.ProdNo = t3.ProdNo  WHERE ([Status] = @Status) ORDER BY [DateReqd]">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="1" Name="Status" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>

                                            </h3>
                                        </td>
                                    </tr>
                                </table>


                            </asp:View>

                        </asp:MultiView>
                    </td>
                </tr>
            </table>

        </div>
        <div id="right">
            <table>
                <tr>
                    <td>
                        <asp:Button Text="Rack 1" BorderStyle="None" CssClass="Initial" ID="btnRack1" runat="server" OnClick="Rack1_Click" />
                        <asp:Button Text="Rack 2" BorderStyle="None" CssClass="Initial" ID="btnRack2" runat="server" OnClick="Rack2_Click" />
                        <asp:Button Text="Rack 3" BorderStyle="None" CssClass="Initial" ID="btnRack3" runat="server" OnClick="Rack3_Click" />
                        <asp:Button Text="Rack 4" BorderStyle="None" CssClass="Initial" ID="btnRack4" runat="server" OnClick="Rack4_Click" />
                        <asp:Button Text="Rack 5" BorderStyle="None" CssClass="Initial" ID="btnRack5" runat="server" OnClick="Rack5_Click" />
                        <asp:Button Text="Rack 6" BorderStyle="None" CssClass="Initial" ID="btnRack6" runat="server" OnClick="Rack6_Click" />
                        <asp:Button Text="Rack 7" BorderStyle="None" CssClass="Initial" ID="btnRack7" runat="server" OnClick="Rack7_Click" />
                        <asp:Button Text="Rack 8" BorderStyle="None" CssClass="Initial" ID="btnRack8" runat="server" OnClick="Rack8_Click" />
                        <asp:Button Text="Rack 9" BorderStyle="None" CssClass="Initial" ID="btnRack9" runat="server" OnClick="Rack9_Click" />
                        <asp:Button Text="Rack 10" BorderStyle="None" CssClass="Initial" ID="btnRack10" runat="server" OnClick="Rack10_Click" />
                        <asp:Button Text="Rack 11" BorderStyle="None" CssClass="Initial" ID="btnRack11" runat="server" OnClick="Rack11_Click" />
                        <asp:Button Text="Rack 12" BorderStyle="None" CssClass="Initial" ID="btnRack12" runat="server" OnClick="Rack12_Click" />
                        <asp:Button Text="Rack 13" BorderStyle="None" CssClass="Initial" ID="btnRack13" runat="server" OnClick="Rack13_Click" />

                        <asp:Button Text="Rack 14" BorderStyle="None" CssClass="Initial" ID="btnRack14" runat="server" OnClick="Rack14_Click" />
                        <asp:Button Text="Rack 15" BorderStyle="None" CssClass="Initial" ID="btnRack15" runat="server" OnClick="Rack15_Click" />
                        <asp:Button Text="Rack 16" BorderStyle="None" CssClass="Initial" ID="btnRack16" runat="server" OnClick="Rack16_Click" />


                        <asp:Button Text="Ground 1" BorderStyle="None" CssClass="Initial" ID="btnGround1" runat="server" OnClick="Ground1_Click" />
                        <asp:Button Text="Ground 2" BorderStyle="None" CssClass="Initial" ID="btnGround2" runat="server" OnClick="Ground2_Click" />
                        <asp:Button Text="Ground 3" BorderStyle="None" CssClass="Initial" ID="btnGround3" runat="server" OnClick="Ground3_Click" />
                        <asp:Button Text="Ground 4" BorderStyle="None" CssClass="Initial" ID="btnGround4" runat="server" OnClick="Ground4_Click" />
                        <asp:Button Text="Ground 5" BorderStyle="None" CssClass="Initial" ID="btnGround5" runat="server" OnClick="Ground5_Click" />
                        <asp:Button Text="Ground 6" BorderStyle="None" CssClass="Initial" ID="btnGround6" runat="server" OnClick="Ground6_Click" />
                        <asp:Button Text="Ground 7" BorderStyle="None" CssClass="Initial" ID="btnGround7" runat="server" OnClick="Ground7_Click" />
                        <asp:Button Text="Ground 8" BorderStyle="None" CssClass="Initial" ID="btnGround8" runat="server" OnClick="Ground8_Click" />
                        <asp:MultiView ID="LocationView" runat="server">

                            <asp:View ID="Rack1" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack1SlotsinA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack1SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 1">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack1SlotsinB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack1SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 1">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack1SlotsinC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack1SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 1">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack1SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '1' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack1SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '1' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack1SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '1' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="Rack2" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack2SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack2SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 2">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack2SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack2SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 2">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack2SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack2SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 2">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack2SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '2' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack2SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '2' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack2SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '2' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="Rack3" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack3SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack3SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 3">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack3SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack3SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 3">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack3SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack3SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 3">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack3SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '3' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack3SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '3' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack3SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '3' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>


                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="Rack4" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack4SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack4SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 4">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack4SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack4SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 4">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack4SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack4SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 4">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack4SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '4' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack4SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '4' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack4SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '4' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>


                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="Rack5" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack5SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack5SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 5">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack5SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack5SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 5">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack5SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack5SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 5">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack5SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '5' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack5SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '5' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack5SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '5' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>


                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="Rack6" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack6SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack6SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 6">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack6SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack6SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 6">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack6SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack6SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 6">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack6SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '6' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack6SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '6' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack6SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '6' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="Rack7" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack7SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack7SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 7">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack7SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack7SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 7">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack7SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack7SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 7">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack7SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '7' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack7SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '7' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack7SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '7' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="Rack8" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack8SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack8SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 8">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack8SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack8SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 8">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack8SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack8SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 8">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack8SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '8' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack8SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '8' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack8SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '8' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>


                            <asp:View ID="Rack9" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack9SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack9SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 9">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack9SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack9SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 9">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack9SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack9SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 9">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack9SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '9' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack9SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '9' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack9SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '9' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>

                            <asp:View ID="Rack10" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack10SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack10SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 10">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack10SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack10SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 10">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack10SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack10SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 10">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack10SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '10' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack10SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '10' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack10SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '10' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>


                            <asp:View ID="Rack11" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack11SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack11SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 11">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack11SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack11SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 11">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack11SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack11SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 11">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack11SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '11' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack11SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '11' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack11SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '11' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>

                            <asp:View ID="Rack12" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack12SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack12SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 12">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack12SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack12SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 12">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack12SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack12SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 12">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack12SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '12' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack12SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '12' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack12SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '12' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>


                            <asp:View ID="Rack13" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack13SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack13SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 13">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack13SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack13SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 13">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack13SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack13SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 13">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack13SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '13' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack13SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '13' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack13SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '13' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>

                            <asp:View ID="Rack14" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack14SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack14SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 14">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack14SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack14SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 14">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack14SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack14SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 14">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack14SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '14' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack14SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '14' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack14SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '14' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>


                            <asp:View ID="Rack15" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack15SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack15SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 15">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack15SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack15SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 15">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack15SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack15SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 15">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack15SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '15' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack15SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '15' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack15SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '15' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>


                            <asp:View ID="Rack16" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvRack16SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack16SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 16">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>

                                                <asp:GridView ID="gvRack16SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack16SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 16">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                                <asp:GridView ID="gvRack16SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack16SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey" Caption="Rack 16">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Row C" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsRack16SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '16' and Row = 'A' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack16SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '16' and Row = 'B' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsRack16SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '16' and Row = 'C' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>




                            <asp:View ID="Ground1" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvGround1" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround1" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Ground 1" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsGround1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '100' and Row = 'G' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="Ground2" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvGround2" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround2" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Ground 2" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsGround2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '200' and Row = 'G' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="Ground3" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvGround3" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround3" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Ground 3" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsGround3" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '300' and Row = 'G' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="Ground4" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvGround4" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround4" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Ground 4" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsGround4" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '400' and Row = 'G' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="Ground5" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvGround5" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround5" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Ground 5" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsGround5" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '500' and Row = 'G' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </td>
                                    </tr>
                                </table>
                            </asp:View>

                            <asp:View ID="Ground6" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvGround6" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround6" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Ground 6" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsGround6" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '600' and Row = 'G' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </td>
                                    </tr>
                                </table>
                            </asp:View>


                            <asp:View ID="Ground7" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvGround7" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround7" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Ground 7" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsGround7" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '700' and Row = 'G' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </td>
                                    </tr>
                                </table>
                            </asp:View>



                            <asp:View ID="Ground8" runat="server">
                                <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                                    <tr>
                                        <td>
                                            <h3>
                                                <br />
                                                <asp:GridView ID="gvGround8" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround8" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" HeaderText="Ground 8" />
                                                        <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                                    </Columns>

                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />

                                                </asp:GridView>
                                            </h3>
                                            <asp:SqlDataSource ID="sdsGround8" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '800' and Row = 'G' and Filled &lt;= @filled Order By Row, Slot">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlShowAllSlots" Name="filled" PropertyName="SelectedValue" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </td>
                                    </tr>
                                </table>
                            </asp:View>


                        </asp:MultiView>
                    </td>
                </tr>
            </table>
        </div>
        <div id="actions">


            <br />
            <br />
            <br />
            <br />
            <asp:Label ID="lblSelected" CssClass="selectionResults" runat="server" Text="Selected:" Font-Bold="True"></asp:Label>
            <br />
            <asp:Label ID="lblProd" CssClass="selectionResults" runat="server" Text="Prod #:    " Font-Bold="True"></asp:Label>
            <asp:Label ID="lblProdSet" CssClass="selectionResultValue" runat="server" Text="" Font-Bold="True"></asp:Label>
            <br />
            <asp:Label ID="lblLoc" CssClass="selectionResults" runat="server" Text="Location:    " Font-Bold="True"></asp:Label>
            <asp:Label ID="lblLocSet" CssClass="selectionResultValue" runat="server" Text="" Font-Bold="True"></asp:Label>

            <br />
            <br />
            <br />
            <br />
            <asp:Button ID="btnSave" runat="server" Text="Save" Width="100px" />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />

        </div>
    </form>
</body>
</html>
