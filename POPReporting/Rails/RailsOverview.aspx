<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RailsOverview.aspx.vb" Inherits="Rails_RailsOverview" MaintainScrollPositionOnPostback="true" Debug="true"  %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>RAILS OVERVIEW</title>
 <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
.railbuttons {
   

     
}
.railbuttons input[type=checkbox]:checked{
  
}
.checkedTrue {
    width:75px;
    background-color:lightgreen;
    float:left;
    text-align:center;
    padding-right:2px;
    border-radius:4px;
    border:1px solid #D0D0D0;
        }

.checkedFalse {
    width:75px;
       float:left;
       text-align:center;
       padding-right:2px;
        
        }

.checked1True {
    width:75px;
    background-color:green;
    float:left;
    text-align:center;
    padding-right:2px;
    border-radius:4px;
    border:1px solid #D0D0D0;
        }

.checked1False {
    width:75px;
       float:left;
       text-align:center;
       padding-right:2px;
        
        }
.inout {
        float:left;
        }
.locs {
      color:blue;
      font-weight:bold;
       }
    </style>

    <script type = "text/javascript">
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
         </script>  
</head>
<body>
    <form id="form1" runat="server">
 <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">RAILS OVERVIEW</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <!-- #include file ="../Rails/toolbar-railsprod.aspx" -->
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
                             <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                             <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>                            
                             </br>
                             <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("WeldDate", "{0:d}")%>'></asp:Label>
                              <br />
                             <asp:Label ID="Label1" runat="server" CssClass="locs" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' Text='<%# "Loc:  " & Eval("RailsSlot")%>'></asp:Label>
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                    <asp:TemplateField HeaderText="Custom">
                         <ItemTemplate>
                             <asp:Label ID="lblCustDrawNo" runat="server" CssClass="newStyle6" Text='<%# Eval("CustDrawNo")%>'></asp:Label>                            
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>                                  
                    
                     <asp:TemplateField HeaderText="Options">
                         <ItemTemplate>
                             <asp:Label ID="Label4" runat="server" Text='<%# Eval("PanelColor") %>'></asp:Label>
                             <br />
                             <asp:GridView ID="gvFabOptionsRails" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsPopReportingFabOptions" CssClass="newStyle3">
                                 <Columns>
                                     <asp:BoundField DataField="Option_Desc" HeaderText="Fab Options" SortExpression="Option_Desc" ShowHeader="False" >
                                     <ControlStyle BorderStyle="None" />
                                     <FooterStyle BorderStyle="None" />
                                     <HeaderStyle BorderStyle="None" Height="10px" />
                                     <ItemStyle BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Middle" />
                                     </asp:BoundField>
                                 </Columns>                                 
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsPopReportingFabOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [PopNo], [Option_Item], [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE ([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter) ORDER BY [Option_Desc]">
                                 <SelectParameters>
                                     <asp:Parameter Name="ProdNo" Type="String" />
                                     <asp:Parameter DefaultValue="RailsPrep" Name="Workcenter" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                         </ItemTemplate>
                         <ItemStyle Font-Size="12pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
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
                                     </asp:TemplateField>
                                      <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                                    </asp:ImageField>   
                                 </Columns>
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [FurnitureStatus],[FiberglassStatus], [CoversStatus], [RailsStatus], [TubesStatus], [CentertubeStatus], [CentertubeNeeded],cast(GaugeStatus as varchar) + cast(HarnessStatus as varchar) as ElectricalStatus FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                                 <SelectParameters>
                                     <asp:ControlParameter ControlID="gvAllFieldsR" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Rails">
                         <ItemTemplate>
                             <div class="newstyle2">
                                 <asp:Label class="inout" ID="lblOut" runat="server" Text="Out" Width="30px"></asp:Label>
                                 <div class='<%# "checked" & Convert.ToBoolean(Eval("PF_Produced"))%>'> <asp:CheckBox class="railbuttons" ID="cbPF" runat="server" Text="PF" Font-Size="30pt" Checked='<%# Convert.ToBoolean(Eval("PF_Produced"))%>' /></div>
                                 <div class='<%# "checked" & Convert.ToBoolean(Eval("SF_Produced"))%>'> <asp:CheckBox class="railbuttons" ID="cbSF" runat="server" Text="SF" Font-Size="30" Checked='<%# Convert.ToBoolean(Eval("SF_Produced"))%>' /></div>
                                 <div class='<%# "checked" & Convert.ToBoolean(Eval("PR_Produced"))%>'> <asp:CheckBox class="railbuttons" ID="cbPR" runat="server" Text="PR" Font-Size="30" Checked='<%# Convert.ToBoolean(Eval("PR_Produced"))%>' /></div>
                                 <div class='<%# "checked" & Convert.ToBoolean(Eval("SR_Produced"))%>'> <asp:CheckBox class="railbuttons" ID="cbSR" runat="server" Text="SR" Font-Size="30" Checked='<%# Convert.ToBoolean(Eval("SR_Produced"))%>' /></div>
                                 <div class='<%# "checked" & Convert.ToBoolean(Eval("T_Produced"))%>'> <asp:CheckBox class="railbuttons" ID="cbT" runat="server" Text="T" Font-Size="30" Visible='<%# IIf(Eval("NeedsTransom").ToString() = "", 0, Eval("NeedsTransom")) = 1%>' Checked='<%# Convert.ToBoolean(Eval("T_Produced"))%>' /></div>
                                 <div class='<%# "checked" & Convert.ToBoolean(Eval("PM_Produced"))%>'> <asp:CheckBox class="railbuttons" ID="cbPM" runat="server" Text="PM" Font-Size="30" Visible='<%# IIf(Eval("NeedsPortMid").ToString() = "", 0, Eval("NeedsPortMid")) = 1%>' Checked ='<%# Convert.ToBoolean(Eval("PM_Produced"))%>' /></div>
                                 <div class='<%# "checked" & Convert.ToBoolean(Eval("SM_Produced"))%>'> <asp:CheckBox class="railbuttons" ID="cbSM" runat="server" Text="SM" Font-Size="30" Visible='<%# IIf(Eval("NeedsStrbMid").ToString() = "", 0, Eval("NeedsStrbMid")) = 1%>' Checked='<%# Convert.ToBoolean(Eval("SM_Produced"))%>' /></div>
                                 <br />
                                 <br />
                                 <br />
                                 <asp:Label class="inout" ID="lblIn" runat="server" Text="In" Width="30px"></asp:Label> 
                                 <div class='<%# "checked1" & Convert.ToBoolean(Eval("PF_Received"))%>'> <asp:CheckBox class="railbuttons" ID="CheckBox1" runat="server" Text="PF" Font-Size="30pt" Checked='<%# Convert.ToBoolean(Eval("PF_Received"))%>'/></div>
                                 <div class='<%# "checked1" & Convert.ToBoolean(Eval("SF_Received"))%>'>  <asp:CheckBox class="railbuttons" ID="CheckBox2" runat="server" Text="SF" Font-Size="30" Checked='<%# Convert.ToBoolean(Eval("SF_Received"))%>'/></div>
                                  <div class='<%# "checked1" & Convert.ToBoolean(Eval("PR_Received"))%>'> <asp:CheckBox class="railbuttons" ID="CheckBox3" runat="server" Text="PR" Font-Size="30" Checked='<%# Convert.ToBoolean(Eval("PR_Received"))%>'/></div>
                                  <div class='<%# "checked1" & Convert.ToBoolean(Eval("SR_Received"))%>'> <asp:CheckBox class="railbuttons" ID="CheckBox4" runat="server" Text="SR" Font-Size="30" Checked='<%# Convert.ToBoolean(Eval("SR_Received"))%>'/></div>
                                  <div class='<%# "checked1" & Convert.ToBoolean(Eval("T_Received"))%>'> <asp:CheckBox class="railbuttons" ID="CheckBox5" runat="server" Text="T" Font-Size="30" Visible='<%# IIf(Eval("NeedsTransom").ToString() = "", 0, Eval("NeedsTransom")) = 1%>' Checked='<%# Convert.ToBoolean(Eval("T_Received"))%>'/></div>
                                  <div class='<%# "checked1" & Convert.ToBoolean(Eval("PM_Received"))%>'> <asp:CheckBox class="railbuttons" ID="CheckBox6" runat="server" Text="PM" Font-Size="30" Visible='<%# IIf(Eval("NeedsPortMid").ToString() = "", 0, Eval("NeedsPortMid")) = 1%>' Checked ='<%# Convert.ToBoolean(Eval("PM_Received"))%>'/></div>
                                  <div class='<%# "checked1" & Convert.ToBoolean(Eval("SM_Received"))%>'> <asp:CheckBox class="railbuttons" ID="CheckBox7" runat="server" Text="SM" Font-Size="30" Visible='<%# IIf(Eval("NeedsStrbMid").ToString() = "", 0, Eval("NeedsStrbMid")) = 1%>' Checked='<%# Convert.ToBoolean(Eval("SM_Received"))%>' /></div>
                                 &nbsp;</div>                             
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" Width="520px" />
                     </asp:TemplateField>                     
                     
                     <asp:TemplateField HeaderText="Repair/Reorder">
                         <ItemTemplate>                                                                                                                                             
                             <asp:ImageButton ID="btnUpdateRepair" runat="server" ImageUrl='<%# Eval("RepairFlag", "../Images/repair{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotorepair"/> 
                             <asp:ImageButton ID="btnUpdateReorder" runat="server" ImageUrl='<%# Eval("ReorderFlag", "../Images/reorder{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoreorder"/> 
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
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRailsPrep, BML_POPREPORTING.PanelColor, Rails_Tracking.WeldDate, Rails_Tracking.HasAllRails, Rails_Tracking.CustDrawNo, Rails_Tracking.PF_Produced, Rails_Tracking.SF_Produced, Rails_Tracking.PR_Produced, Rails_Tracking.SR_Produced, Rails_Tracking.T_Produced, Rails_Tracking.PM_Produced, Rails_Tracking.SM_Produced, Rails_Tracking.PF_Received, Rails_Tracking.SF_Received, Rails_Tracking.PR_Received, Rails_Tracking.SR_Received, Rails_Tracking.T_Received, Rails_Tracking.PM_Received, Rails_Tracking.SM_Received, Rails_Tracking.NeedsTransom, Rails_Tracking.NeedsPortMid, Rails_Tracking.NeedsStrbMid, Rails_Tracking.RailsNeeded, Rails_Tracking.RepairFlag, Rails_Tracking.ReorderFlag, Rails_KittingLocations.RailsSlot, Rails_KittingLocations.InUse FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo INNER JOIN Rails_Tracking ON BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo LEFT JOIN Rails_KittingLocations on BML_POPREPORTING.ProdNo = Rails_KittingLocations.ProdNo WHERE (Rails_Tracking.WeldDate &lt;= @WeldDate) AND (Rails_Tracking.HasAllRails = @HasAllRails) AND (BML_POPREPORTING_GREENLIGHTS.RailsStatus < 2) And (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') ORDER BY Rails_Tracking.WeldDate desc, BML_POPREPORTING.ProdNo asc">
                <SelectParameters>                    
                     <asp:ControlParameter ControlID="ddlDateSelected" Name="WeldDate" PropertyName="SelectedValue" DbType="Date" />                  
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="HasAllRails" PropertyName="SelectedValue" Type="Int32" />                     
                     <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />  
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
