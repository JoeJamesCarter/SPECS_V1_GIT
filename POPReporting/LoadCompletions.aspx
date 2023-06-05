<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadCompletions.aspx.vb" Inherits="LoadCompletions" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet.css" rel="stylesheet" />
    <title>LOAD COMPLETIONS</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">LOAD COMPLETIONS</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Table ID="Table1" runat="server" CssClass="auto-style1" Width="1100px" GridLines="None">
                            <asp:TableRow runat="server">
                                <asp:TableCell runat="server" HorizontalAlign="center">
                                    <asp:Label ID="lblBoatsPutOnTrailers" runat="server" CssClass="newStyle4" Text=""></asp:Label><span class="newStyle3"><span class="newStyle3">&nbsp;# Boats Put On Trailers For Selected Day</span><br></br>
                                        <asp:Label ID="lblTrailersLoaded" runat="server" CssClass="newStyle4" Text=""></asp:Label><span class="newStyle3"><span class="newStyle3">&nbsp;# Loads Completed For Selected Day</span><br></br>
                                </asp:TableCell>
                                <asp:TableCell runat="server">
                                    <span class="newStyle3"></span>
                                    <asp:Button ID="btnPrint" runat="server" Text="Printable Version" />
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
                            <asp:Label ID="Label1" runat="server" Text="Load Date:"></asp:Label><asp:Label ID="lblDateSet" runat="server" Text=""></asp:Label></span><asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
                    </asp:TableCell>
                    <asp:TableCell>                       
                        
                        
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <asp:GridView ID="gvBoatsScheduled" CssClass="newStyle1" runat="server" DataSourceID="sdsBoatsScheduledForLoads" AutoGenerateColumns="False" CellPadding="5" DataKeyNames="loadno">
                <Columns>
                    <asp:BoundField DataField="LoadNo" HeaderText="Load #" />
                    <asp:TemplateField HeaderText="Planned Boats">
                        <ItemTemplate>
                            <asp:GridView ID="gvDlrBoats" runat="server" DataSourceID="sdsDlrBoats" AutoGenerateColumns="False" Width="1100px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" OnRowDataBound="gvDlrBoats_RowDataBound" OnRowCommand="gvDlrBoats_RowCommand">
                                <AlternatingRowStyle BackColor="#CCCCCC" />
                                <Columns>
                                    <asp:BoundField DataField="StopNo" HeaderText="Stop #">
                                        <ItemStyle Width="70px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CusName" HeaderText="Dealer">
                                        <ItemStyle Width="450px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #">
                                        <ItemStyle Width="50px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SONo" HeaderText="SO #">
                                        <ItemStyle Width="50px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ItemNo" HeaderText="Boat">
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentStatus" HeaderText="Status">
                                        <ItemStyle Width="150px" />
                                    </asp:BoundField>
                                     <asp:TemplateField HeaderText="Red Tags">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnRedTag" Visible='<%#Eval("IsRedTagged") = 1%>' runat="server" ImageUrl="Images/tag1.png" CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
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
                                             <asp:Image ID="imgHold" runat="server" ImageUrl="./Images/hold.png" Visible='<%#Eval("HoldFlag") = 1 %>'/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Shipper" HeaderText="Shipper">
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SlotKey" HeaderText="Location">
                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Engine S/N">
                                        <ItemStyle Width="150px" />
                                        <ItemTemplate>
                                            <asp:GridView ID="gvEngineData" runat="server" DataSourceID="sdsEngineData" AutoGenerateColumns="False" GridLines="Horizontal" ShowHeader="False" Width="305px">
                                                <Columns>
                                                    <asp:BoundField DataField="item_no">
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="cmt">
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsEngineData" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_no], [item_desc_1], [cmt] FROM [OEORDLIN_SQL] Left Join OELINCMT_SQL on OEORDLIN_SQL.ord_no = OELINCMT_SQL.ord_no WHERE ((OEORDLIN_SQL.ord_no = @ord_no) AND (OELINCMT_SQL.line_seq_no = OEORDLIN_SQL.line_no) AND ([prod_cat] like '%EN%'))">
                                                <SelectParameters>
                                                    <asp:Parameter Name="ord_no" Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </ItemTemplate>

                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Engine on Load">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbEngineOnLoad" runat="server" Checked='<%# IIf(Eval("EngineOnLoad").ToString() = "", 0, Eval("EngineOnLoad"))%>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Pulled">
                                        <ItemTemplate>
                                            <asp:Button ID="btnLoaded" runat="server" Text="Pulled" CommandArgument='<%# Eval("ProdNo")%>' Visible='<%# IIf(Eval("Loaded").ToString() = "", 0, Eval("Loaded")) = 0%>' CommandName="loadaboat" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="On Trailer">
                                        <ItemTemplate>
                                            <asp:Button ID="btnOnTrailer" runat="server" Text="On Trailer" CommandArgument="<%# Container.DataItemIndex %>" Visible='<%# IIf(Eval("OnTrailer").ToString() = "", 0, Eval("OnTrailer")) = 0%>' CommandName="ontrailer" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="TrailerNo" HeaderText="Trailer #">
                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
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
                            <asp:SqlDataSource ID="sdsDlrBoats" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Load_Scheduling.LoadNo, Load_Scheduling.StopNo, Load_Scheduling.ProdNo,Load_Scheduling.ActualLoadDate,Load_Scheduling.Shipper,Load_Scheduling.Split,Load_Scheduling.Loaded, Load_Scheduling.BoatPriority, OnTrailer, TrailerNo, LoadComplete, EngineOnLoad, Load_Scheduling.Notes, AcctNotes, IsRedTagged, BML_POPREPORTING_GREENLIGHTS.CusName,BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.SONo, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' End as CurrentStatus, Rack, Row, Slot, SlotKey, HoldFlag FROM Load_Scheduling Left Join BML_POPREPORTING_GREENLIGHTS on Load_Scheduling.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Yard_Master_Locations on Load_Scheduling.ProdNo = Yard_Master_Locations.ProdNo Where Load_Scheduling.LoadNo = @loadno and ActualLoadDate = @selecteddate Order By Load_Scheduling.BoatPriority, Load_Scheduling.LoadNo, Load_Scheduling.StopNo">
                                <SelectParameters>
                                    <asp:Parameter Name="loadno" DefaultValue="" Type="String" />
                                    <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Mark Load Complete">
                        <ItemTemplate>
                            Trailer #:<br />
                            <asp:TextBox ID="tbTrailerNo" Text="" runat="server" Height="39px" Width="72px" Font-Bold="True" Font-Size="30" Style="text-align: center"></asp:TextBox>
                            <br>Load Notes:<br />
                                <asp:TextBox ID="tbNotes" runat="server" TextMode="MultiLine" Text='<%#Eval("Notes")%>'></asp:TextBox>
                                <br></br>                               
                                Notes to Accounting:
                                 <br />
                                <asp:TextBox ID="tbAcctNotes" runat="server" TextMode="MultiLine" Text='<%#Eval("AcctNotes")%>'></asp:TextBox>
                                <br></br>
                                <asp:Button ID="btnLoadComplete" runat="server" CommandArgument="<%# Container.DataItemIndex %>" CommandName="markcomplete" Text="Mark Load Complete" Visible='<%# IIf(Eval("LoadComplete").ToString() = "", 0, Eval("LoadComplete")) = 0%>' />
                            </br>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsBoatsScheduledForLoads" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct Load_Scheduling.LoadNo, Load_Scheduling.LoadPriority, LoadComplete, Notes,AcctNotes FROM Load_Scheduling Where Load_Scheduling.ActualLoadDate = @selecteddate Order By Load_Scheduling.LoadPriority,Load_Scheduling.LoadNo">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <br />
            <asp:GridView ID="gvBoatsScheduledPrev" CssClass="newStyle1" runat="server" DataSourceID="sdsBoatsScheduledPrev" AutoGenerateColumns="False" CellPadding="5" DataKeyNames="loadno">
                <Columns>
                    <asp:BoundField DataField="ActualLoadDate" HeaderText="Planned To Load" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="LoadNo" HeaderText="Load #" />
                    <asp:TemplateField HeaderText="Previous Planned Boats Not Loaded">
                        <ItemTemplate>
                            <asp:GridView ID="gvDlrBoatsPrev" runat="server" DataSourceID="sdsDlrBoatsPrev" AutoGenerateColumns="False" Width="1014px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" OnRowDataBound="gvDlrBoatsPrev_RowDataBound" OnRowCommand="gvDlrBoatsPrev_RowCommand">
                                <AlternatingRowStyle BackColor="#CCCCCC" />
                                <Columns>
                                    <asp:BoundField DataField="StopNo" HeaderText="Stop #">
                                        <ItemStyle Width="70px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CusName" HeaderText="Dealer">
                                        <ItemStyle Width="450px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #">
                                        <ItemStyle Width="50px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SONo" HeaderText="SO #">
                                        <ItemStyle Width="50px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ItemNo" HeaderText="Boat">
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentStatus" HeaderText="Status">
                                        <ItemStyle Width="150px" />
                                    </asp:BoundField>
                                     <asp:TemplateField HeaderText="Red Tags">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnRedTag" Visible="False" runat="server" ImageUrl="Images/tag1.png" CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotoredtag" />
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
                                    <asp:BoundField DataField="Shipper" HeaderText="Shipper">
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SlotKey" HeaderText="Location">
                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Engine S/N">
                                        <ItemStyle Width="150px" />
                                        <ItemTemplate>
                                            <asp:GridView ID="gvEngineDataPrev" runat="server" DataSourceID="sdsEngineDataPrev" AutoGenerateColumns="False" GridLines="Horizontal" ShowHeader="False" Width="305px">
                                                <Columns>
                                                    <asp:BoundField DataField="item_no">
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="cmt">
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsEngineDataPrev" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_no], [item_desc_1], [cmt] FROM [OEORDLIN_SQL] Left Join OELINCMT_SQL on OEORDLIN_SQL.ord_no = OELINCMT_SQL.ord_no WHERE ((OEORDLIN_SQL.ord_no = @ord_no) AND (OELINCMT_SQL.line_seq_no = OEORDLIN_SQL.line_no) AND ([prod_cat] like '%EN%'))">
                                                <SelectParameters>
                                                    <asp:Parameter Name="ord_no" Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </ItemTemplate>

                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Pulled">
                                        <ItemTemplate>
                                            <asp:Button ID="btnLoadedPrev" runat="server" Text="Pulled" CommandArgument='<%# Eval("ProdNo")%>' Visible='<%# IIf(Eval("Loaded").ToString() = "", 0, Eval("Loaded")) = 0%>' CommandName="loadaprevboat" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="On Trailer">
                                        <ItemTemplate>
                                            <asp:Button ID="btnOnTrailer" runat="server" Text="On Trailer" CommandArgument='<%# Eval("ProdNo")%>' Visible='<%# IIf(Eval("OnTrailer").ToString() = "", 0, Eval("OnTrailer")) = 0%>' CommandName="prevontrailer" />
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
                            <asp:SqlDataSource ID="sdsDlrBoatsPrev" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Load_Scheduling.LoadNo, Load_Scheduling.StopNo, Load_Scheduling.ProdNo,Load_Scheduling.ActualLoadDate,Load_Scheduling.Shipper,Load_Scheduling.Split,Load_Scheduling.Loaded,OnTrailer, LoadComplete, Load_Scheduling.Notes, AcctNotes, BML_POPREPORTING_GREENLIGHTS.SONo, BML_POPREPORTING_GREENLIGHTS.CusName,BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' End as CurrentStatus, SlotKey FROM Load_Scheduling Left Join BML_POPREPORTING_GREENLIGHTS on Load_Scheduling.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Yard_Master_Locations on Load_Scheduling.ProdNo = Yard_Master_Locations.ProdNo Where Load_Scheduling.ActualLoadDate = Convert(datetime,@plannedloaddate,121) and Load_Scheduling.LoadNo = @loadno Order By Load_Scheduling.LoadNo, Load_Scheduling.StopNo">
                                <SelectParameters>
                                    <asp:Parameter Name="plannedloaddate" DbType="String" />
                                    <asp:Parameter Name="loadno" DefaultValue="" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Mark Load Complete">
                        <ItemTemplate>
                            Trailer #:<br />
                            <asp:TextBox ID="tbTrailerNoPrev" Text='<%# Eval("TrailerNo")%>' runat="server" Height="39px" Width="72px" Font-Bold="True" Font-Size="30"></asp:TextBox>
                            <br></br>
                            <asp:Button ID="btnLoadComplete" runat="server" Text="Mark Load Complete" CommandArgument='<%# Eval("LoadNo")%>' Visible='<%# IIf(Eval("LoadComplete").ToString() = "", 0, Eval("LoadComplete")) = 0%>' CommandName="markprevcomplete" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsBoatsScheduledPrev" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct Load_Scheduling.LoadNo,Load_Scheduling.ActualLoadDate, Load_Scheduling.LoadPriority, OnTrailer, TrailerNo, LoadComplete, Load_Scheduling.Notes,AcctNotes FROM Load_Scheduling Where Loaded = 0 and ProdNo > 179999 and ActualLoadDate < @selecteddate and ActualLoadDate > '2018-01-31' Order By Load_Scheduling.LoadPriority, Load_Scheduling.ActualLoadDate, Load_Scheduling.LoadNo ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>
    </form>
</body>
</html>
