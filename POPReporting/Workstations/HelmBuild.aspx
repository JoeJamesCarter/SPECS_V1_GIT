<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HelmBuild.aspx.vb" Inherits="Workstations_HelmBuild" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>HELMS - BUILD</title>

    <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">HELMS - BUILD</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="wstoolbar-southtotal.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
        <asp:GridView ID="gvHelmBuild" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo">
                    <ItemStyle Font-Bold="True" />
                </asp:BoundField>
                <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="F">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="FG">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FiberglassInspStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="FGI">
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
                        <asp:Image ID="Centertube" Visible=' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "../Images/{0}.png") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:ImageField>
                <asp:TemplateField HeaderText="Floored?">
                    <ItemTemplate>
                        <asp:Image ID="Floors" ImageUrl='<%# Eval("FloorsInstalledStatus", "../Images/{0}.png")%>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Helm Kit">
                    <ItemTemplate>
                        <asp:Image ID="HelmKit" ImageUrl='<%# Eval("HelmKittingStatus", "../Images/{0}.png")%>' runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label>
                        <br />
                        <asp:ImageButton ID="ImageButton2" ImageUrl='../Images/buildsheet.png' runat="server" CommandArgument='<%# Eval("ProdNo") & ";" & Eval("ItemNo")%>' CommandName="gotobuildsheet" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="Custom">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Options">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# SplitBVatDash(Eval("BaseVinylColor"))%>'></asp:Label>
                        <asp:GridView ID="gvHelmBuildOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsHelmBuild">
                            <Columns>
                                <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsFabOptionsHelmBuild" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter))">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvHelmBuild" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                <asp:Parameter DefaultValue="Rails" Name="Workcenter" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Comments">
                    <ItemTemplate>
                        <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsMacola" ShowHeader="false">
                            <Columns>
                                <asp:BoundField DataField="cmt" HeaderText="cmt" SortExpression="cmt" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsMacola" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [cmt] FROM [OELINCMT_SQL] WHERE ([ord_no] = @ord_no)">
                            <SelectParameters>
                                <asp:Parameter Name="ord_no" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Helms">
                    <ItemTemplate>
                        <div class="newStyle2">
                            <asp:RadioButtonList ID="rblHelmBuildStatus" runat="server" SelectedValue='<%# Bind("HelmBuildStatus")%>' RepeatDirection="Horizontal">
                                <asp:ListItem Value="0">Not Started</asp:ListItem>
                                <asp:ListItem Value="1">In Progress</asp:ListItem>
                                <asp:ListItem Value="2">Complete</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <asp:Button ID="btnUpdateHelm" runat="server" Text="Update" CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdate" />
                        <%--  <asp:ImageButton ID="btnUpdateHelm" runat="server" ImageUrl='<%# Eval("HelmBuildStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>"  CommandName="gotoupdate"/>                                           --%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Offline">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnOffline" runat="server" Enabled=' <%# Eval("HelmBuildStatus") >= 1%>' ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotostatus" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "../Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />
                        <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesHelmBuild") = 1%>' ImageUrl='<%# Eval("NotesHelmBuild", "../Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassInspStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.NotesHelmBuild, BML_POPREPORTING_GREENLIGHTS.BuildLoc, (CASE WHEN cast(FurnitureStatus as integer) = 3 THEN 2 ELSE cast(FurnitureStatus as Integer) END)  + cast(FiberglassStatus as integer) +  (CASE WHEN cast(CoversStatus as integer) = 3 THEN 2 ELSE cast(CoversStatus as Integer) END)  + cast(RailsStatus as integer) + cast(TubesStatus as integer)  + cast(GaugeStatus as integer) + cast(HarnessStatus as integer) + (CASE WHEN cast(BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded as integer) = 1 THEN cast(CentertubeStatus as integer) ELSE 2 END) as GreenStatusTotal, cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, Case When HelmKittingStatus = 1 then 0 else HelmKittingStatus End As HelmKittingStatus FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus &lt;= @HelmBuildStatus) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%')  ORDER BY GreenStatusTotal desc, FramesInstalledStatus desc, BML_POPREPORTING.ProdNo asc">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                <asp:ControlParameter ControlID="ddlShowSelect" Name="HelmBuildStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
