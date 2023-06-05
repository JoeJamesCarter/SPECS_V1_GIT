<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadCompletionRptForAcct.aspx.vb" Inherits="LoadCompletionRptForAcct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
 
                            <asp:Label ID="Label1" runat="server" CssClass="newStyle7" Text="Load #:"></asp:Label>
&nbsp;
                            <asp:Label ID="lblLoadNo" runat="server" CssClass="newStyle7"></asp:Label>
                            <br />
                            <asp:Label ID="Label2" runat="server" CssClass="newStyle7" Text="Marked As Loaded:"></asp:Label>
&nbsp;
                            <asp:Label ID="lblMarkedAsLoaded" runat="server" CssClass="newStyle7"></asp:Label>
                            <br />
 
                            <asp:GridView ID="gvDlrBoats" runat="server" DataSourceID="sdsDlrBoats" CssClass="newStyle1" AutoGenerateColumns="False" Width="1100px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
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
                                    <asp:BoundField DataField="Shipper" HeaderText="Shipper">
                                        <ItemStyle Width="200px" />
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

                                    <asp:BoundField DataField="TrailerNo" HeaderText="Trailer #">
                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                    </asp:BoundField>

                                    <asp:BoundField DataField="DateOnTrailer" HeaderText="Date On Trailer" >
                                    <ItemStyle Width="100px" HorizontalAlign="Center" />
                                    </asp:BoundField>

                                     <asp:BoundField DataField="DateLoadComplete" HeaderText="Date Load Completed" DataFormatString="{0:d}">
                                    <ItemStyle Width="100px" HorizontalAlign="Center" />
                                    </asp:BoundField>

                                    <asp:BoundField DataField="AcctNotes" HeaderText="Notes" />

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
                            <asp:SqlDataSource ID="sdsDlrBoats" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Load_Scheduling.LoadNo, Load_Scheduling.StopNo, Load_Scheduling.ProdNo,Load_Scheduling.ActualLoadDate,Load_Scheduling.Shipper,Load_Scheduling.Split,Load_Scheduling.Loaded, Load_Scheduling.BoatPriority, OnTrailer, TrailerNo, LoadComplete, EngineOnLoad, Load_Scheduling.AcctNotes, DateOnTrailer, DateLoadComplete, BML_POPREPORTING_GREENLIGHTS.CusName,BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.SONo, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' End as CurrentStatus, Rack, Row, Slot, SlotKey FROM Load_Scheduling Left Join BML_POPREPORTING_GREENLIGHTS on Load_Scheduling.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Yard_Master_Locations on Load_Scheduling.ProdNo = Yard_Master_Locations.ProdNo Where Load_Scheduling.LoadNo = @loadno and ActualLoadDate = @selecteddate Order By Load_Scheduling.BoatPriority, Load_Scheduling.LoadNo, Load_Scheduling.StopNo">
                                <SelectParameters>
                                    <asp:Parameter Name="loadno" DefaultValue="" Type="String" />
                                    <asp:Parameter Name="selecteddate" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                    
                            <br />
                            <br />
                            <br />
                            <asp:Button ID="btnSave" runat="server" Text="Save For Accounting" />
                    
    </div>
    </form>
</body>
</html>
