<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RailsPrepTest.aspx.vb" Inherits="RailsPrepTest" MaintainScrollPositionOnPostback="true" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>RAILS - Testing</title>
 <link href="StyleSheet.css" rel="stylesheet" />

<style>
.checkedTrue {
    font-size:12px;
    width:75px;
    background-color:red;
    float:left;
    text-align:center;
    padding-right:2px;
    border-radius:4px;
    border:1px solid #D0D0D0;
        }

.checkedFalse {
    font-size:12px;
    width:75px;
       float:left;
       text-align:center;
       padding-right:2px;
        
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
                        <span class="newStyle7">RAILS - Testing</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <!-- #include file ="toolbar-railsprep.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
        <asp:GridView ID="gvAllFieldsR" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo">
                <Columns>
                     <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                     <ItemStyle VerticalAlign="Middle" />
                     </asp:BoundField>
                     <asp:TemplateField HeaderText="Boat/Customer">
                         <ItemTemplate>
                             <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                             <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>                            
                             <br>
                             <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("CusName") %>'></asp:Label>
                            <asp:GridView ID="gvRailsData" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRailsData" OnRowDataBound="gvRailsData_RowDataBound">
                                 <Columns>
                                     <asp:ImageField DataImageUrlField="PF_Received" DataImageUrlFormatString="./Images/RailsRcv_{0}.png" HeaderText="PF">
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="SF_Received" DataImageUrlFormatString="./Images/RailsRcv_{0}.png" HeaderText="SF">
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="PR_Received" DataImageUrlFormatString="./Images/RailsRcv_{0}.png" HeaderText="PR">
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="SR_Received" DataImageUrlFormatString="./Images/RailsRcv_{0}.png" HeaderText="SR">
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:ImageField>
                                     <asp:TemplateField HeaderText="T">
                                         <ItemTemplate>
                                             <asp:ImageButton ID="imgTransomReceived" runat="server" ImageUrl='<%# Eval("T_Received", "./Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsTransom").ToString() = "", 0, Eval("NeedsTransom")) = 1%>' />
                                         </ItemTemplate>
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="PM">
                                         <ItemTemplate>
                                             <asp:ImageButton ID="imgPMReceived" runat="server" ImageUrl='<%# Eval("PM_Received", "./Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsPortMid").ToString() = "", 0, Eval("NeedsPortMid")) = 1%>' />
                                         </ItemTemplate>
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="SM">
                                         <ItemTemplate>
                                             <asp:ImageButton ID="imgSMReceived" runat="server" ImageUrl='<%# Eval("SM_Received", "./Images/RailsRcv_{0}.png")%>' Visible='<%# IIf(Eval("NeedsStrbMid").ToString() = "", 0, Eval("NeedsStrbMid")) = 1%>' />
                                         </ItemTemplate>
                                         <ItemStyle HorizontalAlign="Center" />
                                     </asp:TemplateField>
                                     <asp:BoundField DataField="CustDrawNo" HeaderText="D#" />
                                 </Columns>
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsRailsData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [PF_Received], [PR_Received],[SF_Received], [SR_Received], [T_Received], [PM_Received], [SM_Received], [NeedsTransom], [NeedsPortMid], [NeedsStrbMid],[CustDrawNo] FROM [Rails_Tracking] WHERE ([ProdNo] = @ProdNo)">
                                 <SelectParameters>
                                     <asp:ControlParameter ControlID="gvAllFieldsR" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>                                                         
                             <asp:Label ID="Label1" runat="server" CssClass="locs" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' Text='<%# "Loc:  " & Eval("RailsSlot")%>'></asp:Label>
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="./Images/Custom{0}.png" HeaderText="Custom">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                    <asp:ImageField DataImageUrlField="IsPilot" DataImageUrlFormatString="./Images/Pilot{0}.png" HeaderText="Pilot">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
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
                                     <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="F">
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="FG">
                                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="C">
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="R">
                                     </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="T">
                                     </asp:ImageField>
                                      <asp:TemplateField HeaderText="CT">
                                         <ItemTemplate>
                                             <asp:ImageButton ID="imgButtonCentertube" runat="server" ImageUrl='<%# Eval("CentertubeStatus", "./Images/{0}.png")%>' Visible='<%#Eval("CentertubeNeeded") = 1%>'/>
                                         </ItemTemplate>
                                     </asp:TemplateField>
                                      <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                                    </asp:ImageField>   
                                 </Columns>
                             </asp:GridView>
                             <br />
                            
                             <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [FurnitureStatus],[FiberglassStatus], [CoversStatus], [RailsStatus], [TubesStatus], [CentertubeStatus], [CentertubeNeeded],cast(GaugeStatus as varchar) + cast(HarnessStatus as varchar) as ElectricalStatus FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                                 <SelectParameters>
                                     <asp:ControlParameter ControlID="gvAllFieldsR" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Update">
                         <ItemTemplate>
                             <div class="newStyle2">
                             <asp:RadioButtonList ID="rblRailsStatus" runat="server" SelectedValue='<%# Bind("RailsStatus")%>' RepeatDirection="Horizontal">
                                 <asp:ListItem Value="0">Not Started</asp:ListItem>
                                 <asp:ListItem Value="-1">Next</asp:ListItem>
                                 <asp:ListItem Value="1">Pulled</asp:ListItem>
                                 <asp:ListItem Value="2">Ready</asp:ListItem>
                             </asp:RadioButtonList>
                                 </div>
                             <div class="newStyle2">
                                 <asp:Button ID="btnUpdateRailsStatus" runat="server" Text="Update"  CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateRStatus"/>
                             </div>
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="./Images/{0}checkmark.png" HeaderText="Complete">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                     <asp:TemplateField HeaderText="Notes">
                         <ItemTemplate>
                             <asp:ImageButton ID="btnUpdateNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto"/>                                           
                             <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesRailsPrep") = 1%>' ImageUrl='<%# Eval("NotesRailsPrep", "./Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto"/>                                          
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" />
                     </asp:TemplateField>
                     
                     <asp:TemplateField HeaderText="Missing Rails">
                        <ItemTemplate>
                        <%--<div class='<%# "checked" & Convert.ToBoolean(IIf(Eval("PF").ToString() = "", 0, Eval("PF")))%>'><asp:CheckBox class="railbuttons" ID="cbPF" runat="server" Text="PF" Font-Size="30pt" Checked='<%# Convert.ToBoolean(IIf(Eval("PF").ToString() = "", 0, Eval("PF")))%>' AutoPostBack="True" OnCheckedChanged="cbPF_OnCheckedChanged" /></div>
                        <div class='<%# "checked" & Convert.ToBoolean(IIf(Eval("SF").ToString() = "", 0, Eval("SF")))%>'> <asp:CheckBox class="railbuttons" ID="cbSF" runat="server" Text="SF" Font-Size="30" Checked='<%# Convert.ToBoolean(IIf(Eval("SF").ToString() = "", 0, Eval("SF")))%>' AutoPostBack="True" OnCheckedChanged="cbSF_OnCheckedChanged"/></div>
                        <div class='<%# "checked" & Convert.ToBoolean(IIf(Eval("PR").ToString() = "", 0, Eval("PR")))%>'> <asp:CheckBox class="railbuttons" ID="cbPR" runat="server" Text="PR" Font-Size="30" Checked='<%# Convert.ToBoolean(IIf(Eval("PR").ToString() = "", 0, Eval("PR")))%>' AutoPostBack="True" OnCheckedChanged="cbPR_OnCheckedChanged"/></div>
                        <div class='<%# "checked" & Convert.ToBoolean(IIf(Eval("SR").ToString() = "", 0, Eval("SR")))%>'> <asp:CheckBox class="railbuttons" ID="cbSR" runat="server" Text="SR" Font-Size="30" Checked='<%# Convert.ToBoolean(IIf(Eval("SR").ToString() = "", 0, Eval("SR")))%>' AutoPostBack="True" OnCheckedChanged="cbSR_OnCheckedChanged"/></div>
                        <div class='<%# "checked" & Convert.ToBoolean(IIf(Eval("T").ToString() = "", 0, Eval("T")))%>'> <asp:CheckBox class="railbuttons" ID="cbT" runat="server" Text="T" Font-Size="30" Visible='<%# IIf(Eval("NeedsTransom").ToString() = "", 0, Eval("NeedsTransom")) = 1%>' Checked='<%# Convert.ToBoolean(IIf(Eval("T").ToString() = "", 0, Eval("T")))%>' AutoPostBack="True" OnCheckedChanged="cbT_OnCheckedChanged"/></div>
                        <div class='<%# "checked" & Convert.ToBoolean(IIf(Eval("PM").ToString() = "", 0, Eval("PM")))%>'> <asp:CheckBox class="railbuttons" ID="cbPM" runat="server" Text="PM" Font-Size="30" Visible='<%# IIf(Eval("NeedsPortMid").ToString() = "", 0, Eval("NeedsPortMid")) = 1%>' Checked ='<%# Convert.ToBoolean(IIf(Eval("PM").ToString() = "", 0, Eval("PM")))%>' AutoPostBack="True" OnCheckedChanged="cbPM_OnCheckedChanged"/></div>
                        <div class='<%# "checked" & Convert.ToBoolean(IIf(Eval("SM").ToString() = "", 0, Eval("SM")))%>'> <asp:CheckBox class="railbuttons" ID="cbSM" runat="server" Text="SM" Font-Size="30" Visible='<%# IIf(Eval("NeedsStrbMid").ToString() = "", 0, Eval("NeedsStrbMid")) = 1%>' Checked='<%# Convert.ToBoolean(IIf(Eval("SM").ToString() = "", 0, Eval("SM")))%>' AutoPostBack="True" OnCheckedChanged="cbSM_OnCheckedChanged"/></div>--%>

                        </ItemTemplate>
                         <ItemStyle Width="500px" VerticalAlign="Middle" />
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
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRailsPrep, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING.PanelColor, (CASE WHEN cast(FurnitureStatus as integer) = 3 THEN 2 ELSE cast(FurnitureStatus as Integer) END)  + cast(FiberglassStatus as integer) +  (CASE WHEN cast(CoversStatus as integer) = 3 THEN 2 ELSE cast(CoversStatus as Integer) END)  + cast(RailsStatus as integer) + cast(TubesStatus as integer)  + cast(GaugeStatus as integer) + cast(HarnessStatus as integer) + (CASE WHEN cast(BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded as integer) = 1 THEN cast(CentertubeStatus as integer) ELSE 2 END) as GreenStatusTotal, Rails_MissingOrDamaged.PF,Rails_MissingOrDamaged.PR, Rails_MissingOrDamaged.SF, Rails_MissingOrDamaged.SR, Rails_MissingOrDamaged.PM, Rails_MissingOrDamaged.SM, Rails_MissingOrDamaged.T, NeedsTransom, NeedsPortMid, NeedsStrbMid, Rails_KittingLocations.RailsSlot, Rails_KittingLocations.InUse FROM BML_POPREPORTING CROSS JOIN BML_POPREPORTING_GREENLIGHTS LEFT JOIN RAILS_TRACKING on BML_POPREPORTING.PRODNO = RAILS_TRACKING.ProdNo LEFT JOIN RAILS_MISSINGORDAMAGED on BML_POPREPORTING.PRODNO = RAILS_MISSINGORDAMAGED.ProdNo LEFT JOIN Rails_KittingLocations on BML_POPREPORTING.ProdNo = Rails_KittingLocations.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.RailsStatus &lt;= @RailsStatus) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') ORDER BY GreenStatusTotal desc, BML_POPREPORTING.ProdNo asc">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                     <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="RailsStatus" PropertyName="SelectedValue" Type="Int32" />                     
                     <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />  
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
