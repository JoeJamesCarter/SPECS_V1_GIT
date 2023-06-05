<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadSchedule.aspx.vb" Inherits="LoadSchedule" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet.css" rel="stylesheet" />
    <title>LOAD SCHEDULE</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">LOAD SCHEDULE</span><br />
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
                    <asp:TableCell></asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <asp:GridView ID="gvBoatsScheduled" CssClass="newStyle1" runat="server" DataSourceID="sdsBoatsScheduledForLoads" AutoGenerateColumns="False" CellPadding="5" DataKeyNames="loadno">
                <Columns>
                    <asp:BoundField DataField="LoadNo" HeaderText="Load #" />
                    <asp:BoundField DataField="LoadPriority" HeaderText="Load Priority" />                    
                    <asp:TemplateField HeaderText="Planned Boats">
                        <ItemTemplate>
                            <asp:GridView ID="gvDlrBoats" runat="server" DataSourceID="sdsDlrBoats" AutoGenerateColumns="False" Width="1014px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" OnRowDataBound="gvDlrBoats_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="StopNo" HeaderText="Stop #">
                                        <ItemStyle Width="70px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CusName" HeaderText="Dealer">
                                        <ItemStyle Width="800px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #">
                                        <ItemStyle Width="50px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ItemNo" HeaderText="Boat">
                                        <ItemStyle Width="60px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CurrentStatus" HeaderText="Status">
                                        <ItemStyle Width="150px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Shipper" HeaderText="Shipper">
                                        <ItemStyle Width="400px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SlotKey" HeaderText="Location">
                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BuildLoc" HeaderText="Building">
                                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="BIM Built?">
                                        <ItemTemplate>
                                            <asp:Image ID="BimBuilt" ImageUrl='<%# Eval("BiminiStatus", "./Images/gates{0}.png")%>' runat="server" ToolTip='<%# Eval("Bimini")%>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="BIM Rcvd?">
                                        <ItemTemplate>
                                            <asp:Image ID="BimRcvd" ImageUrl='<%# Eval("BiminiRcvdStatus", "./Images/{0}.png")%>' runat="server" ToolTip='<%# Eval("BiminiRcvd")%>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                                    </asp:TemplateField>                                    
                                <asp:BoundField DataField="EngineOnLoad" HeaderText="Engine On Load">
                                        <ItemStyle Width="200px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MissingEngine" HeaderText="Missing Engine">
                                        <ItemStyle Width="200px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="MissingBimini" HeaderText="Missing Bimini">
                                        <ItemStyle Width="200px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DateOnTrailer" DataFormatString="{0:d}" HeaderText="Date on Trailer">
                                        <ItemStyle Width="200px" HorizontalAlign="Center" />
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
                            <asp:SqlDataSource ID="sdsDlrBoats" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Load_Scheduling.LoadNo, Load_Scheduling.StopNo, Load_Scheduling.ProdNo,Load_Scheduling.ActualLoadDate,Load_Scheduling.Shipper,Load_Scheduling.Split, OnTrailer, DateOnTrailer, Case when MissingBimini = 1 then 'Y' end as MissingBimini, Case when MissingEngine = 1 then 'Y' end as MissingEngine, Case when EngineOnLoad = 1 then 'Y' end as EngineOnLoad, BML_POPREPORTING_GREENLIGHTS.CusName,BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' End as CurrentStatus, Load_Scheduling.DateLoaded, Rack,Row,Slot,SlotKey, BML_POPREPORTING_GREENLIGHTS.BiminiRcvdStatus, BML_POPREPORTING_GREENLIGHTS.BiminiStatus, BML_POPREPORTING_GREENLIGHTS.Bimini, BML_POPREPORTING_GREENLIGHTS.BiminiRcvd, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM Load_Scheduling Left Join BML_POPREPORTING_GREENLIGHTS on Load_Scheduling.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Yard_Master_Locations on Load_Scheduling.ProdNo = Yard_Master_Locations.ProdNo Where Load_Scheduling.LoadNo = @loadno and ActualLoadDate = @selecteddate Order By Load_Scheduling.LoadNo, Load_Scheduling.StopNo">
                                <SelectParameters>
                                    <asp:Parameter Name="loadno" DefaultValue="" Type="String" />
                                    <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="TrailerNo" HeaderText="Trailer #" />
                    <asp:BoundField DataField="DateLoadComplete" HeaderText="Sent to Accounting" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsBoatsScheduledForLoads" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct Load_Scheduling.LoadNo, Load_Scheduling.LoadPriority, DateLoadComplete, TrailerNo FROM Load_Scheduling Where Load_Scheduling.ActualLoadDate = @selecteddate Order By Load_Scheduling.LoadPriority,Load_Scheduling.LoadNo ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />
                </SelectParameters>
            </asp:SqlDataSource>


        </div>
    </form>
</body>
</html>
