<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadBoatsSetPriority.aspx.vb" Inherits="LoadBoatsSetPriority" Debug="True"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
         <link href="StyleSheet.css" rel="stylesheet" />
    <title>SET LOAD PRIORITY</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">SET LOAD PRIORITY</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:table id="Table1" runat="server" cssclass="auto-style1" width="966px" gridlines="None">
                            <asp:TableRow runat="server">
                                <asp:TableCell runat="server" HorizontalAlign="center">
                                    <asp:Label ID="lblLoadsScheduled" runat="server" CssClass="newStyle4" Text=""></asp:Label><span class="newStyle3">&nbsp;# Loads Planned For Selected Day</span>
                                </asp:TableCell>
                                <asp:TableCell runat="server"><span class="newStyle3"></span>                                     
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
                 <asp:TemplateField HeaderText="Load Priority">
                     <ItemTemplate>
                         <asp:DropDownList ID="ddlLoadPriority" runat="server" SelectedValue='<%# IIf(Eval("LoadPriority").ToString() = "", 0, Eval("LoadPriority"))%>' AutoPostBack="False">
                             <asp:ListItem>0</asp:ListItem>
                             <asp:ListItem>1</asp:ListItem>
                             <asp:ListItem>2</asp:ListItem>
                             <asp:ListItem>3</asp:ListItem>
                             <asp:ListItem>4</asp:ListItem>
                             <asp:ListItem>5</asp:ListItem>
                             <asp:ListItem>6</asp:ListItem>
                             <asp:ListItem>7</asp:ListItem>
                             <asp:ListItem>8</asp:ListItem>
                             <asp:ListItem>9</asp:ListItem>
                             <asp:ListItem>10</asp:ListItem>
                             <asp:ListItem>11</asp:ListItem>
                             <asp:ListItem>12</asp:ListItem>
                             <asp:ListItem>13</asp:ListItem>
                             <asp:ListItem>14</asp:ListItem>
                             <asp:ListItem>15</asp:ListItem>
                             <asp:ListItem>16</asp:ListItem>
                             <asp:ListItem>17</asp:ListItem>
                             <asp:ListItem>18</asp:ListItem>
                             <asp:ListItem>19</asp:ListItem>
                             <asp:ListItem>20</asp:ListItem>
                             <asp:ListItem>21</asp:ListItem>
                             <asp:ListItem>22</asp:ListItem>
                             <asp:ListItem>23</asp:ListItem>
                             <asp:ListItem>24</asp:ListItem>
                             <asp:ListItem>25</asp:ListItem>
                         </asp:DropDownList>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:BoundField DataField="LoadNo" HeaderText="Load #" />
                <asp:TemplateField HeaderText="Planned Boats">
                    <ItemTemplate>
                        <asp:GridView ID="gvDlrBoats" runat="server" DataSourceID="sdsDlrBoats" AutoGenerateColumns="False" Width="1014px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" OnRowDataBound="gvDlrBoats_RowDataBound">
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
                                 <asp:TemplateField HeaderText="Boat Priority">
                     <ItemTemplate>
                         <asp:DropDownList ID="ddlBoatPriority"  SelectedValue='<%# IIf(Eval("BoatPriority").ToString() = "", 0, Eval("BoatPriority"))%>' runat="server">
                             <asp:ListItem>0</asp:ListItem>
                             <asp:ListItem>1</asp:ListItem>
                             <asp:ListItem>2</asp:ListItem>
                             <asp:ListItem>3</asp:ListItem>
                             <asp:ListItem>4</asp:ListItem>
                             <asp:ListItem>5</asp:ListItem>
                             <asp:ListItem>6</asp:ListItem>
                         </asp:DropDownList>
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
                         <asp:SqlDataSource ID="sdsDlrBoats" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Load_Scheduling.LoadNo, Load_Scheduling.StopNo, Load_Scheduling.ProdNo,Load_Scheduling.ActualLoadDate,Load_Scheduling.Shipper,Load_Scheduling.Split,Load_Scheduling.Loaded, Load_Scheduling.BoatPriority, BML_POPREPORTING_GREENLIGHTS.CusName,BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' End as CurrentStatus, SlotKey FROM Load_Scheduling Left Join BML_POPREPORTING_GREENLIGHTS on Load_Scheduling.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Yard_Master_Locations on Load_Scheduling.ProdNo = Yard_Master_Locations.ProdNo Where Load_Scheduling.LoadNo = @loadno and ActualLoadDate = @selecteddate Order By Load_Scheduling.BoatPriority, Load_Scheduling.LoadNo, Load_Scheduling.StopNo">
                <SelectParameters>                                                                                       
                     <asp:Parameter Name="loadno" DefaultValue="" Type="String" />
                    <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />                   
                </SelectParameters>
        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField> 
                 <asp:TemplateField HeaderText="Save">
                     <ItemTemplate>
                         <asp:Button ID="btnSave" runat="server" Text="Save" CommandName="setpriority" CommandArgument='<%# Container.DataItemIndex%>' />
                     </ItemTemplate>
                 </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsBoatsScheduledForLoads" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct Load_Scheduling.LoadNo,LoadPriority FROM Load_Scheduling Where Load_Scheduling.ActualLoadDate = @selecteddate Order By LoadPriority,Load_Scheduling.LoadNo ">
                <SelectParameters> 
                     <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />                                                                                                                 
                </SelectParameters>
        </asp:SqlDataSource>
       </div>
    </form>
</body>
</html>