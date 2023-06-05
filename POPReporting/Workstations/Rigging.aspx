<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Rigging.aspx.vb" Inherits="Workstations_Rigging"  Debug="true"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     
     
    <title>RIGGING</title>
    
       <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form2" runat="server">
     <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">RIGGING</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />&nbsp;&nbsp;<asp:Button ID="btnCantSee" runat="server" Text="If You Don't See Your Boat" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="wstoolsbar.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
        <asp:GridView ID="gvRigging" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
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
                <asp:ImageField DataImageUrlField="EngineStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="ENG">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                 <%-- <asp:ImageField DataImageUrlField="EngineStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="ENG">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>--%>
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label>
                         <br />
                        <asp:Label ID="Label5" runat="server" Text="Rack Location: "></asp:Label><asp:Label ID="Label3" runat="server" Text='<%# Eval("SlotKey")%>' CssClass="newStyle5"></asp:Label>
                         <br />
                        <asp:Label ID="Label6" runat="server" Text="To Be Loaded On: "></asp:Label><asp:Label ID="Label4" runat="server" Text='<%# Eval("ActualLoadDate", "{0:d}")%>' CssClass="newStyle5"></asp:Label>
                         <asp:HiddenField ID="international" runat="server" Value='<%#Eval("IsInternational") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
               <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="Custom">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                      <asp:TemplateField HeaderText="Options">
                    <ItemTemplate>
                        <asp:GridView ID="gvRiggingOptions" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsRigging">
                            <Columns>
                                <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsFabOptionsRigging" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter))">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRigging" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                <asp:Parameter DefaultValue="Rigging" Name="Workcenter" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                  <asp:BoundField DataField="CurrentStatus" HeaderText="Current Status" />
                 <asp:TemplateField HeaderText="Comments">
                    <ItemTemplate>
                        <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsMacola" ShowHeader="false" Width="500px">
                            <Columns>
                                <asp:BoundField DataField="item_no" HeaderText="Item #" SortExpression="item_no" />
                                <asp:BoundField DataField="item_desc_1" HeaderText="Desc" SortExpression="item_desc_1" />
                                <asp:BoundField DataField="cmt" HeaderText="Comment" SortExpression="cmt" ItemStyle-Width="150px">
                                    <ItemStyle Font-Bold="True" Width="150px"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsMacola" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT OEORDLIN_SQL.item_no, OEORDLIN_SQL.ord_no, line_no, IMITMIDX_SQL.item_desc_1, [qty_ordered], OEORDLIN_SQL.user_def_fld_3, OEORDLIN_SQL.prod_cat, cmt FROM [OEORDLIN_SQL] Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no Left Join OELINCMT_SQL on (OEORDLIN_SQL.ord_no = OELINCMT_SQL.ord_no And OEORDLIN_SQL.line_no = OELINCMT_SQL.line_seq_no) WHERE (OEORDLIN_SQL.ord_no = @ord_no) and OEORDLIN_SQL.item_no not like 'CommentProd%' and OEORDLIN_SQL.item_no not like 'VOLDIS' and (OEORDLIN_SQL.prod_cat like '%EN3' or OEORDLIN_SQL.prod_cat like '%EN7' or OEORDLIN_SQL.prod_cat like '%EN8' or OEORDLIN_SQL.prod_cat like '%EN9' or OEORDLIN_SQL.prod_cat like '%ELU%') Order By IMITMIDX_SQL.item_desc_1">
                            <SelectParameters>
                                <asp:Parameter Name="ord_no" Type="String"/>
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        Line #: <asp:Label ID="lblPoLineNo" runat="server" Text=""></asp:Label>&nbsp;On PO # &nbsp;<asp:Label ID="lblEngPO" runat="server" Text=""></asp:Label><br />
                        ETA:&nbsp; <asp:Label ID="lblETA" runat="server" Text=""></asp:Label><br />
                        <asp:Label runat="server" Text="Notes" Font-Bold="true"></asp:Label>
                         <asp:GridView ID="gvNotes" runat="server" DataSourceID="sdsBoatNotes" Width="500px" ShowHeader="false" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="Note" DataFormatString="&lt;div style=&quot;text-transform:capitalize&quot;&gt;{0}&lt;/div&gt;" HtmlEncode="false" ShowHeader="False">
                                    <ItemStyle Width="100px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:d}" ShowHeader="False">
                                    <ItemStyle Width="80px" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsBoatNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Note], [Date] FROM [BML_POPREPORTING_NOTES] WHERE ([ProdNo] = @ProdNo) and Resolved is Null and Workstation = 'Rigging' ORDER BY [Date]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRigging" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>               
                <asp:TemplateField HeaderText="Rigging">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRigging" runat="server"  Enabled =' <%# Eval("RiggingStatus") >= 1%>' ImageUrl='<%# Eval("RiggingStatus", "../Images/complete_status{0}.png")%>' CommandArgument='<%# Container.DataItemIndex & ";" & Eval("BuildLoc") & ";" & Eval("SharkhideNeeded") & ";" & Eval("RiggingNeeded") & ";" & Eval("WavetamerNeeded") %>'  CommandName="gotoupdatenew"/>                                           
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotostatus"/></br>
                         <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "../Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />
                        <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesRigging") = 1%>' ImageUrl='<%# Eval("NotesRigging", "../Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes"/></br>
                        <asp:ImageButton ID="btnTubeDamage" runat="server" ImageUrl='<%# Eval("HasTubeDamage", "../Images/tubedamage{0}.png")%>' CommandArgument='<%# Eval("ProdNo") & ";" & Eval("ItemNo")%>' CommandName = "gototubedamage" />
                    </ItemTemplate>
                </asp:TemplateField>               
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, EngineStatus, Engine, BML_POPREPORTING_GREENLIGHTS.PopNo, BML_POPREPORTING_GREENLIGHTS.CusNo, BML_POPREPORTING_GREENLIGHTS.CusName, Case when Left(BML_POPREPORTING_Greenlights.CusName,7) = 'POLARIS' then 1 else 0 end as IsInternational, BML_POPREPORTING_GREENLIGHTS.SONo, BML_POPREPORTING_GREENLIGHTS.IsCustom, BML_POPREPORTING_GREENLIGHTS.RiggingNeeded, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRigging, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, HasTubeDamage, BML_POPREPORTING_GREENLIGHTS.RiggingNeeded , BML_POPREPORTING_GREENLIGHTS.SharkhideNeeded, BML_POPREPORTING_GREENLIGHTS.WaveTamerNeeded, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.TrimStatus ='1' Then 'Trim' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then '12' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then '11' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then '10' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then '9' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then '8' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then '6' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then '7' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then '5' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then '4' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then '3' When BML_POPREPORTING_GREENLIGHTS.TrimStatus ='1' Then '2.5' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then '2' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then '1' End as CurrentStatusSort, SlotKey,  ActualLoadDate, Case When ActualLoadDate is NULL then '0' ELSE '1' End As ScheduledToLoad, EngineStatus, Engine FROM BML_POPREPORTING_GREENLIGHTS Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo left join Yard_Master_Locations on BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo  WHERE(BML_POPREPORTING_GREENLIGHTS.CompleteStatus &gt;= @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.RiggingStatus &lt;= @RiggingStatus) AND (BML_POPREPORTING_GREENLIGHTS.RiggingNeeded = '1') AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchBoat + '%') AND(BML_POPREPORTING_GREENLIGHTS.ProdNo > '1900000') ORDER BY ScheduledToLoad desc, ActualLoadDate, CASE WHEN BML_POPREPORTING_GREENLIGHTS.FinalInspection is NULL Then 1 Else 0 END, CurrentStatusSort desc">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                 <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                 <asp:ControlParameter ControlID="ddlShowSelect" Name="RiggingStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                <asp:Parameter Name="RiggingNeeded" DefaultValue="1" Type="Int32"  />
                 <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />  
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html> 