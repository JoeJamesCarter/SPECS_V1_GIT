<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Receiving.aspx.vb" Inherits="Gates_Receiving" MaintainScrollPositionOnPostback="true" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gates Receiving - SPECS</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <link href="../scripts/css/toastr.css" rel="stylesheet" />
    <script src="../scripts/jquery-3.5.0.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
    <script src="../scripts/toastr.min.js"></script> 
    <style>
        .green {
            background-color:green;
            color:white;
            font-weight:bold;
            font-family:Calibri;
            font-size:20px;
            width:100px;
            margin-left:10px;
        }

          .white {
            background-color:white;
            color:Black;
            font-weight:bold;
            font-family:Calibri;
            font-size:20px;
            width:100px;
            margin-left:10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="newStyle6">        
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">GATES RECEIVING</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <!-- #include file ="../Gates/toolbar-gatesrcv.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
        <asp:GridView ID="gvAllFieldsR" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo">
                <Columns>
                     <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                     <ItemStyle VerticalAlign="Middle" />
                     </asp:BoundField>
                     <asp:TemplateField HeaderText="Boat/Weld Date">
                         <ItemTemplate>
                             <asp:Label ID="lblItemNo" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                             <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>                                                                                     
                             <br>                             
                             <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("WeldDate", "{0:d}")%>'></asp:Label>
                             <br />
                             <asp:Label ID="Label1" runat="server" CssClass="locs" Text='<%# "Loc:  " & Eval("GatesSlot")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>
                             <br>                             
                             <asp:Button ID="btnEditRailReqs" runat="server" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoEditRailReqs" Text="Edit Requirements" Visible="false" />
                             </br>                             
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                                   
                      <asp:ImageField DataImageUrlField="IsPilot" DataImageUrlFormatString="../Images/Pilot{0}.png" HeaderText="Pilot">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>    
                     <asp:TemplateField HeaderText="Green Lights">
                         <ItemTemplate>
                             <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReportingByProdNo">
                                 <Columns>
                                     <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="F">
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="FG">
                                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="C">
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="R">
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="T">
                                     </asp:ImageField>
                                     <asp:TemplateField HeaderText="CT">
                                         <ItemTemplate>
                                             <asp:ImageButton ID="imgButtonCentertube" runat="server" ImageUrl='<%# Eval("CentertubeStatus", "../Images/{0}.png")%>' Visible='<%#Eval("CentertubeNeeded") = 1%>'/>
                                         </ItemTemplate>
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:TemplateField>
                                      <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                                    </asp:ImageField>   
                                 </Columns>
                             </asp:GridView>
                           
                             <strong><asp:Label ID="Label10" runat="server" Text="Blackout" Visible='<%# IIf(Eval("Blackout").ToString() = "", 0, Eval("Blackout")) = 1%>' ></asp:Label></strong>
                             <br />
                             <strong><asp:Label ID="Label2" runat="server" Text="Protech" Visible='<%# IIf(Eval("Protech").ToString() = "", 0, Eval("Protech")) = 1%>' ></asp:Label></strong>
                             <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [FurnitureStatus],[FiberglassStatus], [CoversStatus], [RailsStatus], [TubesStatus], [CentertubeStatus], [CentertubeNeeded],cast(GaugeStatus as varchar) + cast(HarnessStatus as varchar) as ElectricalStatus FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                                 <SelectParameters>
                                     <asp:ControlParameter ControlID="gvAllFieldsR" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>


                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                    <asp:TemplateField HeaderText="Options">
                        <ItemTemplate>
                             <asp:GridView ID="gvFabOptionsGates" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsGates" CssClass="newStyle3">
                                 <Columns>
                                     <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" >
                                     <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                     </asp:BoundField>
                                 </Columns>
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsFabOptionsGates" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter))">
                                 <SelectParameters>
                                     <asp:Parameter Name="ProdNo" Type="String" />
                                     <asp:Parameter DefaultValue="Gates" Name="Workcenter" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                        </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Gates">
                         <ItemTemplate >
                             <div class="newstyle2">
                                 <asp:Label ID="Label4" runat="server" Text="Bow Ctr" Visible='<%# IIf(Eval("BowCtr").ToString() = "", 0, 1)%>' ></asp:Label><asp:Button ID="btnBowCtr" runat="server" Text='<%#Eval("BowCtr") %>' Visible='<%# IIf(Eval("BowCtr").ToString() = "", 0, 1)%>' CssClass ="white" CommandArgument='<%#Eval("ProdNo") %>' CommandName="bowctr"/>
                                 <asp:Label ID="Label5" runat="server" Text="Port" Visible='<%# IIf(Eval("Port").ToString() = "", 0, 1)%>' ></asp:Label><asp:Button ID="btnPort" runat="server" Text='<%#Eval("Port") %>' Visible='<%# IIf(Eval("Port").ToString() = "", 0, 1)%>' CssClass ="white" CommandArgument='<%#Eval("ProdNo") %>' CommandName="port"/>
                                 <asp:Label ID="Label6" runat="server" Text="Strb" Visible='<%# IIf(Eval("Strb").ToString() = "", 0, 1)%>' ></asp:Label><asp:Button ID="btnStrb" runat="server" Text='<%#Eval("Strb") %>'  Visible='<%# IIf(Eval("Strb").ToString() = "", 0, 1)%>' CssClass ="white" CommandArgument='<%#Eval("ProdNo") %>' CommandName="strb"/>
                                 <asp:Label ID="Label7" runat="server" Text="Aft Port" Visible='<%# IIf(Eval("AftPort").ToString() = "", 0, 1)%>' ></asp:Label><asp:Button ID="btnAftPort" runat="server" Text='<%#Eval("AftPort") %>' Visible='<%# IIf(Eval("AftPort").ToString() = "", 0, 1)%>' CssClass ="white" CommandArgument='<%#Eval("ProdNo") %>' CommandName="aftport"/>
                                 <asp:Label ID="Label8" runat="server" Text="Aft Ctr" Visible='<%# IIf(Eval("AftCtr").ToString() = "", 0, 1)%>' ></asp:Label><asp:Button ID="btnAftCtr" runat="server" Text='<%#Eval("AftCtr") %>' Visible='<%# IIf(Eval("AftCtr").ToString() = "", 0, 1)%>' CssClass ="white" CommandArgument='<%#Eval("ProdNo") %>' CommandName="aftctr"/>
                                 <asp:Label ID="Label9" runat="server" Text="Aft Strb" Visible='<%# IIf(Eval("AftStrb").ToString() = "", 0, 1)%>' ></asp:Label><asp:Button ID="btnAftStrb" runat="server" Text='<%#Eval("AftStrb") %>' Visible='<%# IIf(Eval("AftStrb").ToString() = "", 0, 1)%>' CssClass ="white" CommandArgument='<%#Eval("ProdNo") %>' CommandName="aftstrb"/>                              
                                 <asp:Label ID="Label11" runat="server" Text="Stub" Visible='<%# IIf(Eval("Stub").ToString() = "", 0, 1)%>' ></asp:Label><asp:Button ID="btnStub" runat="server" Text='<%#Eval("Stub") %>' Visible='<%# IIf(Eval("Stub").ToString() = "", 0, 1)%>' CssClass ="white" CommandArgument='<%#Eval("ProdNo") %>' CommandName="stub"/>                              
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" Width="800px" />
                     </asp:TemplateField>                                         
                     <asp:TemplateField HeaderText="Repair/Reorder">
                         <ItemTemplate>                                                                                                                                             
                             <asp:ImageButton ID="btnUpdateRepair" runat="server" ImageUrl='<%# Eval("RepairFlag", "../Images/repair{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotorepair"/> 
                             <asp:ImageButton ID="btnUpdateReorder" runat="server" ImageUrl='<%# Eval("ReorderFlag", "../Images/reorder{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoreorder"/>
                             <asp:ImageButton ID="btnToggleRequested" runat="server" ImageUrl='<%# Eval("Requested", "../Images/requested{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="togglerequested"/>
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" />
                     </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle VerticalAlign="Top" BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>            
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRailsPrep, BML_POPREPORTING.PanelColor, Rails_Tracking.WeldDate, GatesSlot, InUse, RTrim(BowCtr) as BowCtr, Rtrim(Port) as Port, Rtrim(Strb) as Strb, Rtrim(AftPort) as AftPort, Rtrim(AftCtr) as AftCtr, Rtrim(AftStrb) as AftStrb, BowCtrRcvStatus, BowCtrRcv, PortRcvStatus, PortRcv, StrbRcvStatus, StrbRcv, AftPortRcvStatus, AftPortRcv, AftCtrRcvStatus, AftCtrRcv, AftStrbRcvStatus, AftStrbRcv, RTrim(Stub) as Stub, StubRcvdStatus, StubRcvd, Gates_ByProd.RepairFlag, Gates_ByProd.ReorderFlag, Gates_ByProd.Requested, Blackout, Protech FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo INNER JOIN Rails_Tracking ON BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo Left Join Gates_KittingLocations on BML_POPREPORTING.ProdNo = Gates_KittingLocations.ProdNo Left Join Gates_ByProd on BML_POPREPORTING.ProdNo = Gates_ByProd.ProdNo  WHERE (Rails_Tracking.WeldDate &lt;= @WeldDate) AND (Gates_ByProd.HasAllGates = @HasAllGates) And (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND ((BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING.ItemNo NOT LIKE '%QX%')) AND Convert(date,Rails_Tracking.WeldDate) &gt;= '08/1/2020' ORDER BY Rails_Tracking.WeldDate desc, BML_POPREPORTING.ProdNo asc">
                <SelectParameters>                    
                     <asp:ControlParameter ControlID="ddlDateSelected" Name="WeldDate" PropertyName="SelectedValue" DbType="Date" />                  
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="HasAllGates" PropertyName="SelectedValue" Type="Int32" />                                        
                     <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />  
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                </SelectParameters>
        </asp:SqlDataSource>            
           
    </form>
</body>
</html>

