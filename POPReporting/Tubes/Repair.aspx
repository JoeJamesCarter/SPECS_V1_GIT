<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Repair.aspx.vb" Inherits="Tubes_Repair" MaintainScrollPositionOnPostback="true"  %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>REPAIR</title>
  
       <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
          <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">REPAIR</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="../Workstations/wstoolsbar.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
        <asp:HiddenField ID="hdnStatus" runat="server" />  
        <asp:GridView ID="gvRepair" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                <ItemStyle Font-Bold="True" />
                </asp:BoundField>
                <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="F">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="FG">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="C">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="R">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="T">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="CT">
                    <ItemTemplate>
                        <asp:Image ID="Centertube" Visible=' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "../Images/{0}.png") %>'  runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
               <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="Custom">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                <asp:TemplateField HeaderText="Options">
                         <ItemTemplate>
                             <asp:GridView ID="gvOverrides" runat="server" Gridlines="None" DataSourceID="sdsOverrides" showheader= "False" ForeColor="Red" AutoGenerateColumns="False" DataKeyNames="ProdNo">
                                 <Columns>
                                     <asp:BoundField DataField="Override" HeaderText="Override" SortExpression="Override" >
                                     <ItemStyle HorizontalAlign="Center" />
                                     </asp:BoundField>
                                 </Columns>
                             </asp:GridView>
                              <asp:SqlDataSource ID="sdsOverrides" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [Override], [Chines] FROM [BML_POPREPORTING_TUBEOVERRIDES] WHERE (([Repair] = @Repair) AND ([ProdNo] = @ProdNo))">
                                 <SelectParameters>
                                     <asp:Parameter Name="ProdNo" Type="String" />
                                     <asp:Parameter DefaultValue="1" Name="Repair" Type="Int32" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                             <asp:GridView ID="gvTubeRepair" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsPopReportingTubeRepair" CssClass="newStyle3">
                                 <Columns>
                                     <asp:TemplateField HeaderText="Ladder" ShowHeader="False" SortExpression="Ladder">
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" Text='<%# GetLadderValue(Eval("Ladder"))%>'></asp:Label>
                                             </br>
                                             <asp:Label ID="Label2" runat="server" Text='<%#GetRopeeyeValue(Eval("RopeEye"))%>'></asp:Label>                                                                                       
                                         </ItemTemplate>
                                         <ControlStyle BorderStyle="None" />
                                         <FooterStyle BorderStyle="None" />
                                         <HeaderStyle BorderStyle="None" Height="10px" />
                                         <ItemStyle BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Middle" />
                                     </asp:TemplateField>                                     
                                     
                                 </Columns>                                 
                             </asp:GridView>
                             <asp:GridView ID="gvTubeFabOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsPopReportingFabOptions">
                                 <Columns>
                                     <asp:BoundField DataField="Option_Desc" />
                                 </Columns>
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsPopReportingFabOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([Workcenter] = @Workcenter) AND ([ProdNo] = @ProdNo)) ORDER BY [Option_Desc]">
                                 <SelectParameters>
                                     <asp:Parameter DefaultValue="" Name="ProdNo" Type="String" />
                                     <asp:Parameter DefaultValue="Repair" Name="Workcenter" Type="String" />                                     
                                 </SelectParameters>
                             </asp:SqlDataSource>
                             <asp:SqlDataSource ID="sdsPopReportingTubeRepair" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [Ladder], [RopeEye] FROM [BML_POPREPORTING_TUBEPRIORITY] WHERE ([ProdNo] = @ProdNo)">
                                 <SelectParameters>
                                     <asp:Parameter Name="ProdNo" Type="String" />                                     
                                 </SelectParameters>
                             </asp:SqlDataSource>
                         </ItemTemplate>
                         <ItemStyle Font-Size="12pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                <asp:BoundField HeaderText="Tube Length" DataField="Length" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRepairP" runat="server"  Enabled =' <%# Eval("RepairStatusP") >= 1%>' ImageUrl='<%# Eval("RepairStatusP", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateP"/>                                           
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Starboard">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRepairS" runat="server"  Enabled =' <%# Eval("RepairStatusS") >= 1%>' ImageUrl='<%# Eval("RepairStatusS", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateS"/>                                           
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Center">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRepairCtr" Enabled =' <%# Eval("RepairStatusCtr") >= 1%>'  runat="server" Visible =' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("RepairStatusCtr", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCtr"/>                                           
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:TemplateField HeaderText="Offline">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotostatus" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "../Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />
                        <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesRepair") = 1%>' ImageUrl='<%# Eval("NotesRepair", "../Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes"/>                 
                         </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus,BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.RepairStatusS, BML_POPREPORTING_GREENLIGHTS.RepairStatusP, BML_POPREPORTING_GREENLIGHTS.RepairStatusCtr, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRepair, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.RerunP, BML_POPREPORTING_GREENLIGHTS.RerunSB, BML_POPREPORTING_GREENLIGHTS.RerunCtr,BML_POPREPORTING_TUBEPRIORITY.Length FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo INNER JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.TubesStatus &lt; @TubesStatus) AND (BML_POPREPORTING_GREENLIGHTS.RepairStatusS &lt;= @RepairStatus OR BML_POPREPORTING_GREENLIGHTS.RepairStatusP &lt;= @RepairStatus OR (BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = '1' AND BML_POPREPORTING_GREENLIGHTS.RepairStatusCtr &lt;= @RepairStatus)) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%')  ORDER BY CASE WHEN BML_POPREPORTING_GREENLIGHTS.Brackets is NULL Then 1 Else 0 END, BML_POPREPORTING_GREENLIGHTS.Brackets asc">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                 <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                 <asp:ControlParameter ControlID="ddlShowSelect" Name="RepairStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                 <asp:ControlParameter ControlID="hdnStatus" Name="TubesStatus" Type="Int32" DefaultValue="2" />
                 <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />  
            </SelectParameters>
        </asp:SqlDataSource>               
    </form>
</body>
</html>