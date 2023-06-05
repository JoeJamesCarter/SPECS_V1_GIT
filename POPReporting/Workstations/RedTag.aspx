<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RedTag.aspx.vb" Inherits="Workstations_RedTag" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">


    <title>RED TAGS</title>

    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .duedate {
            font-size: 12px;
            font-weight: bold;
            font-family: calibri;
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1200px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">RED TAGS</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="wstoolbar-bldgfilter.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
        <asp:GridView ID="gvRedTags" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20" Width="100%">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo">
                    <ItemStyle Font-Bold="True" Width="50px" />
                </asp:BoundField>
                <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="F">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="FG">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="C">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="R">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="T">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label>
                        <br />
                        <asp:Label ID="lblDue" runat="server" CssClass="duedate" Text="Due: "></asp:Label><asp:Label ID="lblduedate" runat="server" Text='<%# Eval("DueDate", "{0:d}")%>' CssClass="duedate"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Location/Load Info" ItemStyle-Width="200px">
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text="Current Status: "></asp:Label><asp:Label ID="Label8" runat="server" Text='<%# Eval("CurrentStatus")%>' CssClass="newStyle5"></asp:Label>
                        <br />
                        <asp:Label ID="Label5" runat="server" Text="Rack Location: "></asp:Label><asp:Label ID="Label3" runat="server" Text='<%# Eval("SlotKey")%>' CssClass="newStyle5"></asp:Label>
                        <br />
                        <asp:Label ID="Label6" runat="server" Text="To Be Loaded On: "></asp:Label><asp:Label ID="Label4" runat="server" Text='<%# Eval("ActualLoadDate", "{0:d}")%>' CssClass="newStyle5"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="C">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="IsPilot" DataImageUrlFormatString="../Images/pilot{0}.png" HeaderText="P">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Red Tag" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnRedTag" runat="server" ImageUrl='<%# Eval("IsRedTagged", "../Images/tag{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoredtag" Enabled="False" />
                    </ItemTemplate>
                    <ItemStyle Width="30px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Reason" ItemStyle-Width="50">
                    <ItemTemplate>
                        <asp:GridView ID="gvRedTagReasons" runat="server" GridLines="Both" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsRedTagReasons" OnRowCommand="gvRedTagReasons_RowCommand" OnRowDataBound="gvRedTagReasons_RowDataBound" DataKeyNames="Auto" Width="100%">
                            <Columns>
                                 <asp:BoundField DataField="ProdNo" HeaderText="Date" SortExpression="ProdNo" ShowHeader="False" Visible="True" ItemStyle-Width="20px">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Auto" HeaderText="Date" SortExpression="Auto" ShowHeader="False" Visible="True" ItemStyle-Width="20px">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" ShowHeader="False" DataFormatString="{0:d}" ItemStyle-Width="50px">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="RedTagNote" HeaderText="Reason" SortExpression="RedTagNote" ShowHeader="False" ItemStyle-Width="100px">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" ItemStyle-Width="30px">
                                    <ItemTemplate>
                                        <asp:Button ID="btnClear" runat="server" Text="CLEAR" CommandArgument='<%# Eval("Auto") & ";" & Eval("ProdNo") %>' CommandName="gotoclear" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Purch Cmts" ItemStyle-Width="200px" >
                                    <ItemTemplate>
                                        <asp:GridView runat="server" ID="gvRedTagComments" DatasourceID="sdsRedTagComments" AutoGenerateColumns="False" Width="100%" GridLines="Horizontal">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Purchasing Comments">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" Text='<%#Eval("RedTagComments") %>'></asp:Label><br />
                                                        <asp:Label runat="server" Text='<%#Eval("EnteredBy") %>'></asp:Label><br />
                                                        <asp:Label runat="server" Text='<%#Eval("CmtDate", "{0:d}") %>'></asp:Label><br />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                           
                                                </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource runat="server" ID="sdsRedTagComments" ConnectionString='<%$ ConnectionStrings:bml_dataConnectionString %>' SelectCommand="SELECT * FROM [RedTagComments] WHERE ([RedTagAutoID] = @Auto) ORDER BY [CommentID]">
                                            <SelectParameters>
                                                 <asp:ControlParameter ControlID="gvRedTagReasons" Name="Auto" PropertyName="SelectedValue" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsRedTagReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT ProdNo, [Date], [RedTagNote], Auto FROM [BML_POPREPORTING_REDTAGS] WHERE ([ProdNo] = @ProdNo) and DateCleared is Null">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRedTags" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>

                    <ItemStyle Width="50px"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Backorders" ItemStyle-Width="50">
                    <ItemTemplate>
                        <asp:GridView ID="gvBOs" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsBOs" DataKeyNames="AutoID">
                            <Columns>
                                <asp:BoundField DataField="BO_Item_Desc" HeaderText="BO" SortExpression="BO_Item_Desc" ShowHeader="False">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [BO_Item_Desc],[AutoID] FROM [VEADA_BACKORDERS] WHERE ([ProdNo] = @ProdNo) AND (Cleared != '1')">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvBOs" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="RGA's" ItemStyle-Width="50px">
                    <ItemTemplate>
                        <asp:GridView ID="gvRGAs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRGAs" DataKeyNames="AutoID" CellPadding="3" Width="300px" GridLines="Horizontal" Font-Size="12pt">
                            <Columns>
                                <asp:BoundField DataField="AutoID" Visible="False" />
                                <asp:BoundField DataField="RGA_Item_Desc" HeaderText="Part" SortExpression="RGA_Item_Desc">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                </asp:BoundField>
                                <asp:ImageField DataImageUrlField="BenRcvd" DataImageUrlFormatString="../Images/rgarcvd{0}.png" HeaderText="Rcvd">
                                </asp:ImageField>
                                <asp:BoundField DataField="BenRcvdDate" DataFormatString="{0:d}" HeaderText="Date" />
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnStatus" runat="server" ImageUrl='<%# Eval("Status", "../Images/needed{0}.png")%>' CommandArgument='<%#Eval("AutoID")%>' CommandName="gotostatusupdate" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle Font-Size="12pt" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [RGA_Item_Desc],[AutoID],[BenRcvd],[BenRcvdDate],[Status] FROM [VEADA_RGAS] WHERE ([ProdNo] = @ProdNo)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRGAs" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Open Notes" ItemStyle-Width="200px">
                    <ItemTemplate>
                        <asp:GridView ID="gvNotes" runat="server" DataSourceID="sdsBoatNotes" Width="100%" ShowHeader="false" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="Note" DataFormatString="&lt;div style=&quot;text-transform:capitalize&quot;&gt;{0}&lt;/div&gt;" HtmlEncode="false" ShowHeader="False">
                                    <ItemStyle Width="300px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:d}" ShowHeader="False">
                                    <ItemStyle Width="80px" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsBoatNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Note], [Date] FROM [BML_POPREPORTING_NOTES] WHERE ([ProdNo] = @ProdNo) and Resolved is Null ORDER BY [Date]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRedTags" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "../Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />
                    </ItemTemplate>
                    <ItemStyle Width="30px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnClear" runat="server" Text="CLEAR" CommandArgument="<%# Container.DataItemIndex %>" Visible="false" CommandName="gotoclear" />
                        &nbsp;
                        <asp:Button ID="btnBO" runat="server" Text="PPBO" CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoppbo" />
                    </ItemTemplate>
                    <ItemStyle Width="30px" />
                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct(BML_POPREPORTING_GREENLIGHTS.ProdNo), DueDate, BuildLoc, BML_POPREPORTING_GREENLIGHTS.PopNo, BML_POPREPORTING_GREENLIGHTS.CusNo, BML_POPREPORTING_GREENLIGHTS.CusName, BML_POPREPORTING_GREENLIGHTS.SONo, BML_POPREPORTING_GREENLIGHTS.IsCustom , BML_POPREPORTING_GREENLIGHTS.IsPilot, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.IsRedTagged, BML_POPREPORTING_GREENLIGHTS.NotesShrinkwrap, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, Slot, SlotKey, ActualLoadDate, Case When ActualLoadDate is NULL then '0' ELSE '1' End As ScheduledToLoad, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus  FROM BML_POPREPORTING_GREENLIGHTS Left Join BML_POPREPORTING_REDTAGS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_REDTAGS.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo left join Yard_Master_Locations on BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo WHERE  (BML_POPREPORTING_GREENLIGHTS.IsRedTagged = '1') AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%')  AND (Auto &gt;= 4474)  ORDER BY BML_POPREPORTING_GREENLIGHTS.ProdNo">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                <asp:ControlParameter ControlID="ddlShowSelect" Name="ShrinkwrapStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
