<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Wavetamer.aspx.vb" Inherits="Workstations_Wavetamer" MaintainScrollPositionOnPostback="true"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     
     
    <title>WAVETAMER</title>
    
       <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form2" runat="server">
     <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">WAVETAMER</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="wstoolsbar.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
        <asp:GridView ID="gvWavetamer" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
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
                        <asp:ImageButton ID="btnCentertube" enabled= "false" runat="server" Visible = ' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "../Images/{0}.png")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label>
                         <br />
                        <asp:Label ID="Label5" runat="server" Text="Rack Location: "></asp:Label><asp:Label ID="Label3" runat="server" Text='<%# Eval("Slot")%>' CssClass="newStyle5"></asp:Label>
                         <br />
                        <asp:Label ID="Label6" runat="server" Text="To Be Loaded On: "></asp:Label><asp:Label ID="Label4" runat="server" Text='<%# Eval("ActualLoadDate", "{0:d}")%>' CssClass="newStyle5"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
               <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="Custom">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                      <asp:TemplateField HeaderText="Options">
                    <ItemTemplate>
                        <asp:GridView ID="gvWavetamerOptions" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsWavetamer">
                            <Columns>
                                <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsFabOptionsWavetamer" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter))">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvWavetamer" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                <asp:Parameter DefaultValue="Wavetamer" Name="Workcenter" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Wavetamer">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateWavetamer" runat="server"  Enabled =' <%# Eval("WavetamerStatus") >= 1%>' ImageUrl='<%# Eval("WavetamerStatus", "../Images/complete_status{0}.png")%>' CommandArgument='<%# Container.DataItemIndex & ";" & Eval("BuildLoc") & ";" & Eval("SharkhideNeeded") & ";" & Eval("RiggingNeeded") %>' CommandName="gotoupdatenew"/>                                           
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:TemplateField HeaderText="Offline">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotostatus"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "../Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />
                        <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesWavetamer") = 1%>' ImageUrl='<%# Eval("NotesWavetamer", "../Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes"/>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Tube Damage">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnTubeDamage" runat="server" ImageUrl='<%# Eval("HasTubeDamage", "../Images/tubedamage{0}.png")%>' CommandArgument='<%# Eval("ProdNo") & ";" & Eval("ItemNo")%>' CommandName = "gototubedamage" />
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText ="Red Tag">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnRedTag" runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoredtag" />
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="" Visible="false">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateWavetamerTest" runat="server"  Enabled =' <%# Eval("WavetamerStatus") >= 1%>' ImageUrl='<%# Eval("WavetamerStatus", "../Images/complete_status{0}.png")%>' CommandArgument='<%# Container.DataItemIndex & ";" & Eval("BuildLoc") & ";" & Eval("SharkhideStatus") & ";" & Eval("RiggingNeeded") %>'  CommandName="gotoupdatetest"/>                                           
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesWavetamer, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, HasTubeDamage, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.IsRedTagged, Slot, BML_POPREPORTING_GREENLIGHTS.SharkhideNeeded, BML_POPREPORTING_GREENLIGHTS.WaveTamerNeeded, BML_POPREPORTING_GREENLIGHTS.RiggingNeeded, ActualLoadDate, Case When ActualLoadDate is NULL then '0' ELSE '1' End As ScheduledToLoad, BML_POPREPORTING_GREENLIGHTS.RiggingNeeded FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo left join Yard_Master_Locations on BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus &gt;= @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.WavetamerStatus &lt;= @WavetamerStatus) AND (BML_POPREPORTING.WaveTamerNeeded = @WaveTamerNeeded) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%')  ORDER BY ScheduledToLoad desc, ActualLoadDate, CASE WHEN BML_POPREPORTING_GREENLIGHTS.ShrinkWrap is NULL Then 1 Else 0 END, BML_POPREPORTING_GREENLIGHTS.ShrinkWrap asc">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                 <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                 <asp:ControlParameter ControlID="ddlShowSelect" Name="WavetamerStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                <asp:Parameter Name="WaveTamerNeeded" DefaultValue="1" Type="Int32"  />
                 <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />  
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html> 