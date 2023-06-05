<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadScheduling.aspx.vb" Inherits="LoadScheduling" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet.css" rel="stylesheet" />
    <title>LOAD SCHEDULING</title>
    <style>
        .yellow {
            margin-left: 10px;
            background-color: yellow;
            font-family: Calibri;
            font-size: 16px;
        }

        .boatinfoboattuberepair {
            font-family: Calibri;
            font-size: 16px;
            font-weight: bold;
            color: red;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">LOAD SCHEDULING</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Table ID="Table1" runat="server" CssClass="auto-style1" Width="966px" GridLines="None">
                            <asp:TableRow runat="server">
                                <asp:TableCell runat="server" HorizontalAlign="center">
                                    <asp:Label ID="lblLoadsScheduled" runat="server" CssClass="newStyle4" Text=""></asp:Label><span class="newStyle3"><span class="newStyle3">&nbsp;# Loads Scheduled For Selected Day</span>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <span class="newStyle3"></span>
                                    <asp:Label ID="lblTotalInYard" runat="server" Visible="false" CssClass="newStyle4" Text=""></asp:Label><span class="newStyle3"><span class="newStyle3"></span>
                                </asp:TableCell>
                                <asp:TableCell>
               
                                </asp:TableCell>
                                <asp:TableCell RowSpan="2">
                                    <asp:Image runat="server" img src="Images/logo-small.png" /></asp:Image>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle3">
                            <asp:Label ID="Label1" runat="server" Text="Date To Schedule"></asp:Label></span><asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
                    </asp:TableCell>
                    <asp:TableCell>

                        <br />
                        <br />
                        <asp:Button ID="bntEdit" runat="server" Text="Edit Schedule" OnClientClick="javascript:window.open('EditLoadSchedule.aspx');" />&nbsp;&nbsp;<asp:Button ID="btnSave" runat="server" Text="Save Screen" Font-Size="20" Font-Bold="True" /><asp:Label ID="Label2" CssClass="yellow" runat="server" Text="Yellow Boats Are Cladded/Gas Assist/Cust Ship"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <%--change this back to sdsBoatsNotScheduledForLoads instead of sdsGetDealers to limit it to only dealers with finished goods. This didn't work bc it would cause any dealer with only 1 boat in Fin Goods to not show up.--%>
            <asp:GridView ID="gvBoatsToSchedule" CssClass="newStyle1" runat="server" DataSourceID="sdsBoatsNotScheduledForLoads" AutoGenerateColumns="False" DataKeyNames="cus_no">
                <Columns>
                    <asp:TemplateField HeaderText="Select">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbSelectDlr" runat="server" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="cus_name" HeaderText="Dealer" />
                    <asp:BoundField DataField="cus_no" HeaderText="Dlr #" />
                    <asp:TemplateField HeaderText="Racked Boats">
                        <ItemTemplate>
                            <asp:GridView ID="gvDlrBoats" runat="server" DataSourceID="sdsDlrBoats" AutoGenerateColumns="False" Width="800px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" OnRowDataBound="gvDlrBoats_RowDataBound">
                                <AlternatingRowStyle BackColor="#CCCCCC" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Select">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbSelectBoat" runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="30px" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="mfg_ser_lot_no" HeaderText="Prod #">
                                        <ItemStyle Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="item_no" HeaderText="Boat">
                                        <ItemStyle Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ser_lot_no" HeaderText="Serial #">
                                        <ItemStyle Width="170px" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Load #">
                                        <ItemTemplate>
                                            <asp:TextBox ID="tbLoadNo" runat="server" Width="40px"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Split Load">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbSplitLoad" runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Stop #">
                                        <ItemTemplate>
                                            <asp:TextBox ID="tbStopNo" runat="server" Width="40px"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Notes">
                                        <ItemStyle Width="300px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Red Tags">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnRedTag" Visible="False" runat="server" ImageUrl="Images/tag1.png" CommandArgument='<%# Eval("mfg_ser_lot_no")%>' CommandName="gotoredtag" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tube Issues">
                                        <ItemTemplate>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Hot?">
                                        <ItemTemplate>
                                            <asp:Image ID="imgHot" runat="server" ImageUrl="./Images/hot.png" Visible="false" />
                                            <asp:Label ID="lblHotShipDate" runat="server" Text=""></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Hold?">
                                        <ItemTemplate>
                                             <asp:Image ID="imgHold" runat="server" ImageUrl="./Images/hold.png" Visible="False"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Current Status">
                                        <ItemTemplate>
                                        </ItemTemplate>
                                        <ItemStyle Width="300px" />
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Ship Instruction">
                                        <ItemTemplate>
                                            <asp:Label ID="lblShipInstruction"
                                                Text=""
                                                runat="server" />
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
                            <asp:SqlDataSource ID="sdsDlrBoats" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT IMLSMST_SQL.item_no, IMLSMST_SQL.mfg_ser_lot_no, IMLSMST_SQL.ser_lot_no FROM IMLSMST_SQL Inner join PPORDFIL_SQL on IMLSMST_SQL.mfg_ser_lot_no = PPORDFIL_SQL.user_def_fld_1 Where (LTRIM(IMLSMST_SQL.mfg_ser_lot_no) like '1%' OR LTRIM(IMLSMST_SQL.mfg_ser_lot_no) like '2%') AND (PPORDFIL_SQL.cus_no = @cus_no) Order By IMLSMST_SQL.mfg_ser_lot_no">
                                <SelectParameters>
                                    <asp:Parameter Name="cus_no" DefaultValue="559236" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <br />
                            <asp:GridView ID="gvProductionBoats" runat="server" DataSourceID="sdsProductionBoats" BackColor="#CCCCCC" Width="800px" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" AutoGenerateColumns="False" OnRowDataBound="gvProductionBoats_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Select">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbSelectProdBoat" runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="30px" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #">
                                        <ItemStyle Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ItemNo" HeaderText="Boat">
                                        <ItemStyle Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentStatus" HeaderText="Current Status">
                                        <ItemStyle Width="170px" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Needs Rigged">
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# IIf(Eval("RiggingNeeded") = "1", "YES", "")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Load #">
                                        <ItemTemplate>
                                            <asp:TextBox ID="tbLoadNo" runat="server" Width="40px"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Split Load">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbSplitLoad" runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Stop #">
                                        <ItemTemplate>
                                            <asp:TextBox ID="tbStopNo" runat="server" Width="40px"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Red Tag">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnRedTag" Visible='<%#IIf(Eval("IsRedTagged").ToString() = "", 0, Eval("IsRedTagged")) = 1%>' runat="server" ImageUrl='<%# Eval("IsRedTagged", "Images/tag{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tube Issues">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTubeDamage" CssClass="boatinfoboattuberepair" runat="server" Text='<%# Eval("ActionRequired")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Hot?">
                                        <ItemTemplate>
                                            <asp:Image ID="imgHot" runat="server" ImageUrl="./Images/hot.png" Visible='<%#IIf(Eval("Disabled").ToString() Is DBNull.Value, "2", Eval("Disabled").ToString) = "0"%>' />
                                            <asp:Label ID="lblHotShipDate" runat="server" Text='<%#Eval("DropDeadShipDate", "{0:d}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Hold?">
                                        <ItemTemplate>                                           
                                        <asp:Image ID="imgHold" runat="server" ImageUrl="./Images/hold.png" Visible='<%# Eval("HoldFlag") = 1%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Notes">
                                        <ItemStyle Width="300px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Ship Instruction">
                                        <ItemTemplate>
                                            <asp:Label ID="lblProdShipInstruction"
                                                Text=""
                                                runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#CCCCCC" />
                                <HeaderStyle BackColor="Blue" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                <RowStyle BackColor="White" />
                                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#808080" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#383838" />
                            </asp:GridView>
                            <br />
                            <asp:SqlDataSource ID="sdsProductionBoats" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, IsRedTagged, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.RiggingNeeded, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, HotList.DropDeadShipDate, HotList.Disabled, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' End as CurrentStatus, Case when Tubes_DamageReported.ActionRequired is NULL and RepairedFlag = 0 and ReplacedFlag = 0 then 'Needs Evaluated' else Tubes_DamageReported.ActionRequired end as ActionRequired , Hold, HoldFlag From BML_POPREPORTING LEFT JOIN BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING.ProdNo = Load_Scheduling.ProdNo Left Join (Select Distinct Tubes_DamageReported.ProdNo, ReplacedFlag, RepairedFlag, ActionRequired From Tubes_DamageReported where RepairedFlag = 0 and ReplacedFlag = 0) Tubes_DamageReported on BML_POPREPORTING.ProdNo = Tubes_DamageReported.ProdNo Left Join HotList on BML_POPREPORTING.ProdNo = HotList.ProdNo Where BML_POPREPORTING.CusNo = @cus_no and BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus = '2' and Load_Scheduling.ProdNo is Null Order By BML_POPREPORTING.ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="cus_no" DefaultValue="" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Shipper">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlShippers" runat="server">
                                <asp:ListItem> </asp:ListItem>
                               <%-- <asp:ListItem>Amino</asp:ListItem>--%>
                                <%--<asp:ListItem Value="Big_Kid">Big Kid</asp:ListItem>--%>
                                <asp:ListItem Value="First_Choice">First Choice</asp:ListItem>
                                <asp:ListItem Value="G_Diamond">G. Diamond</asp:ListItem>
                                <%--<asp:ListItem Value="Indiana_Transport">Indiana Transport</asp:ListItem>--%>
                                <asp:ListItem Value="Jeff_Haul">Jeff Hall Trucking</asp:ListItem>
                                  <asp:ListItem Value="LP_Logistics">LP Logistics</asp:ListItem>
                                <asp:ListItem>Maverick</asp:ListItem>
                                <asp:ListItem Value="Maverick_Flatbed">Maverick Flatbed</asp:ListItem>
                               <%-- <asp:ListItem Value="Maverick_Stinger">Maverick Stinger</asp:ListItem>--%>
                                <asp:ListItem Value="Peg_Leg">Peg Leg</asp:ListItem>
                                <asp:ListItem Value="PickUp">PickUp</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsBoatsNotScheduledForLoads" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT Distinct ARCUSFIL_SQL.cus_no, ARCUSFIL_SQL.cus_name FROM ARCUSFIL_SQL Right join PPORDFIL_SQL on ARCUSFIL_SQL.cus_no = PPORDFIL_SQL.cus_no Full Outer join IMLSMST_SQL on PPORDFIL_SQL.user_def_fld_1 = IMLSMST_SQL.mfg_ser_lot_no Where (IMLSMST_SQL.mfg_ser_lot_no like '1%' or IMLSMST_SQL.mfg_ser_lot_no like '2%') Order By ARCUSFIL_SQL.cus_name ">
                <SelectParameters>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsGetDealers" ConnectionString='<%$ ConnectionStrings:bml_dataConnectionString %>' SelectCommand="SELECT Distinct(CusNo) as cus_no, CusName as cus_name FROM BML_POPREPORTING order by cus_name"></asp:SqlDataSource>

        </div>
    </form>
    <script src="./scripts/jquery-3.5.0.min.js"></script>
    <script src="./scripts/fontawesome.js"></script>
</body>
</html>
