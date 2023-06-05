<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadBoats.aspx.vb" Inherits="LoadBoats" Debug="True" MaintainScrollPositionOnPostback="True"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
         <link href="StyleSheet.css" rel="stylesheet" />
    <title>LOAD BOATS</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">LOAD BOATS</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:table id="Table1" runat="server" cssclass="auto-style1" width="966px" gridlines="None">
                            <asp:TableRow runat="server">
                                <asp:TableCell runat="server" HorizontalAlign="center">
                                    <asp:Label ID="lblLoadsScheduled" runat="server" CssClass="newStyle4" Text=""></asp:Label><span class="newStyle3"><span class="newStyle3">&nbsp;# Boats Not Loaded For Selected Day</span>
                                </asp:TableCell>
                                <asp:TableCell runat="server"><span class="newStyle3"></span>
                                    <asp:Button ID="btnPrint" runat="server" Text="Printable Version" />                                     
                                </asp:TableCell>
            <asp:TableCell>
               
              </asp:TableCell>
            <asp:TableCell rowspan="2">
             <asp:Image runat="server" img src="Images/logo-small.png" /></asp:Image>
              </asp:TableCell>                                       
        </asp:TableRow>
        <asp:TableRow>
            </asp:TableRow>
        
       
        </asp:table>

                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle3"><asp:Label ID="Label1" runat="server" Text="Load Date:"></asp:Label><asp:Label ID="lblDateSet" runat="server" Text=""></asp:Label></span><asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
                    </asp:TableCell>
                    <asp:TableCell>                       
                        
                        
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table> 
        <br />
        <asp:GridView ID="gvBoatsScheduled" CssClass="newStyle1"  runat="server" DataSourceID="sdsBoatsScheduledForLoads" AutoGenerateColumns="False" CellPadding="5" DataKeyNames="loadno">
            <Columns>
                 <asp:BoundField DataField="LoadNo" HeaderText="Load #" />
                <asp:TemplateField HeaderText="Planned Boats">
                    <ItemTemplate>
                        <asp:GridView ID="gvDlrBoats" runat="server" DataSourceID="sdsDlrBoats" AutoGenerateColumns="False" Width="1014px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" OnRowDataBound="gvDlrBoats_RowDataBound" OnRowCommand="gvDlrBoats_RowCommand">
                            <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>
                                <asp:BoundField DataField="StopNo" HeaderText="Stop #" >
                                <ItemStyle Width="70px" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CusName" HeaderText="Dealer" >
                                <ItemStyle Width="450px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" >
                                <ItemStyle Width="50px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ItemNo" HeaderText="Boat" >                                
                                <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CurrentStatus" HeaderText="Status">
                                <ItemStyle Width="150px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Shipper" HeaderText="Shipper" >
                                <ItemStyle Width="200px" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="SlotKey" HeaderText="Location" >
                                <ItemStyle Width="100px" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Pulled">
                                    <ItemTemplate>
                                         <asp:Button ID="btnLoaded" runat="server" Text="Pulled" CommandArgument='<%# Eval("ProdNo")%>' Visible='<%# IIf(Eval("Loaded").ToString() = "", 0, Eval("Loaded")) = 0%>' CommandName ="loadaboat"/>
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
                         <asp:SqlDataSource ID="sdsDlrBoats" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Load_Scheduling.LoadNo, Load_Scheduling.StopNo, Load_Scheduling.ProdNo,Load_Scheduling.ActualLoadDate,Load_Scheduling.Shipper,Load_Scheduling.Split,Load_Scheduling.Loaded, Load_Scheduling.BoatPriority, BML_POPREPORTING_GREENLIGHTS.CusName,BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, IsRedTagged, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' End as CurrentStatus, Rack, Row, Slot, SlotKey, RepairReqdFlag, ReplaceReqdFlag, RepairedFlag, ReplacedFlag FROM Load_Scheduling Left Join BML_POPREPORTING_GREENLIGHTS on Load_Scheduling.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Yard_Master_Locations on Load_Scheduling.ProdNo = Yard_Master_Locations.ProdNo Left join (Select * From Tubes_DamageReported Where ((ActionRequired = 'REPAIR' and RepairedFlag = 0) or (ActionRequired = 'REPLACE' and ReplacedFlag = 0))) as TD on (TD.ProdNo = Load_Scheduling.ProdNo)  Where Load_Scheduling.LoadNo = @loadno and ActualLoadDate = @selecteddate Order By Load_Scheduling.BoatPriority, Load_Scheduling.LoadNo, Load_Scheduling.StopNo">
                <SelectParameters>                                                                                       
                     <asp:Parameter Name="loadno" DefaultValue="" Type="String" />
                    <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />                   
                </SelectParameters>
        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>                      
               
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsBoatsScheduledForLoads" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct Load_Scheduling.LoadNo, Load_Scheduling.LoadPriority FROM Load_Scheduling Where Load_Scheduling.ActualLoadDate = @selecteddate Order By Load_Scheduling.LoadPriority,Load_Scheduling.LoadNo ">
                <SelectParameters> 
                     <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />                                                                                                                 
                </SelectParameters>
        </asp:SqlDataSource>
         
         <br />
        <asp:GridView ID="gvBoatsScheduledPrev" CssClass="newStyle1"  runat="server" DataSourceID="sdsBoatsScheduledPrev" AutoGenerateColumns="False" CellPadding="5" DataKeyNames="loadno">
            <Columns>
                 <asp:BoundField DataField="ActualLoadDate" HeaderText="Planned To Load" DataFormatString="{0:d}" />
                 <asp:BoundField DataField="LoadNo" HeaderText="Load #" />
                <asp:TemplateField HeaderText="Previous Planned Boats Not Loaded">
                    <ItemTemplate>
                       <asp:GridView ID="gvDlrBoatsPrev" runat="server" DataSourceID="sdsDlrBoatsPrev" AutoGenerateColumns="False" Width="1014px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" OnRowDataBound="gvDlrBoatsPrev_RowDataBound" OnRowCommand="gvDlrBoatsPrev_RowCommand">
                            <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>
                                <asp:BoundField DataField="StopNo" HeaderText="Stop #" >
                                <ItemStyle Width="70px" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CusName" HeaderText="Dealer" >
                                <ItemStyle Width="450px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" >
                                <ItemStyle Width="50px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ItemNo" HeaderText="Boat" >                                
                                <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CurrentStatus" HeaderText="Status">
                                <ItemStyle Width="150px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Shipper" HeaderText="Shipper" >
                                <ItemStyle Width="200px" />
                                </asp:BoundField>
                                  <asp:BoundField DataField="SlotKey" HeaderText="Location" >
                                <ItemStyle Width="100px" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Pulled">
                                    <ItemTemplate>
                                         <asp:Button ID="btnLoadedPrev" runat="server" Text="Pulled" CommandArgument='<%# Eval("ProdNo")%>' Visible='<%# IIf(Eval("Loaded").ToString() = "", 0, Eval("Loaded")) = 0%>' CommandName ="loadaprevboat"/>
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
                         <asp:SqlDataSource ID="sdsDlrBoatsPrev" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Load_Scheduling.LoadNo, Load_Scheduling.StopNo, Load_Scheduling.ProdNo,Load_Scheduling.ActualLoadDate,Load_Scheduling.Shipper,Load_Scheduling.Split,Load_Scheduling.Loaded, BML_POPREPORTING_GREENLIGHTS.CusName,BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, IsRedTagged, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' End as CurrentStatus, SlotKey, RepairReqdFlag, ReplaceReqdFlag, RepairedFlag, ReplacedFlag FROM Load_Scheduling Left Join BML_POPREPORTING_GREENLIGHTS on Load_Scheduling.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Yard_Master_Locations on Load_Scheduling.ProdNo = Yard_Master_Locations.ProdNo Left join (Select * From Tubes_DamageReported Where ((ActionRequired = 'REPAIR' and RepairedFlag = 0) or (ActionRequired = 'REPLACE' and ReplacedFlag = 0))) as TD on (TD.ProdNo = Load_Scheduling.ProdNo) Where Load_Scheduling.ActualLoadDate = Convert(datetime,@plannedloaddate,121) and Load_Scheduling.LoadNo = @loadno Order By Load_Scheduling.LoadNo, Load_Scheduling.StopNo">
                <SelectParameters>                                                                                                            
                    <asp:Parameter Name="plannedloaddate" DBType="String" />
                    <asp:Parameter Name="loadno" DefaultValue="" Type="String" />                    
                </SelectParameters>
        </asp:SqlDataSource>

                    </ItemTemplate>
                </asp:TemplateField>                      
               
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsBoatsScheduledPrev" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct Load_Scheduling.LoadNo,Load_Scheduling.ActualLoadDate, Load_Scheduling.LoadPriority FROM Load_Scheduling Where Loaded = 0 and ProdNo > 179999 and ActualLoadDate < @selecteddate and ActualLoadDate > '2018-01-31' Order By Load_Scheduling.LoadPriority, Load_Scheduling.ActualLoadDate, Load_Scheduling.LoadNo ">              
         <SelectParameters> 
                     <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />                                                                                                                 
                </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>