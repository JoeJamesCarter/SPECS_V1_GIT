<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Gates.aspx.vb" Inherits="Workstations_Gates" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     
    <title>GATES</title>
            
       <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
     <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">GATES</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="wstoolbar-southtotal.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
        <asp:GridView ID="gvGates" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
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
                <asp:ImageField DataImageUrlField="FloorsInstalledStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="Floored?">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
               <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="Custom">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                 <asp:ImageField DataImageUrlField="IsPilot" DataImageUrlFormatString="../Images/Pilot{0}.png" HeaderText="Pilot">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                <asp:TemplateField HeaderText="Gates">
                    <ItemTemplate>
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
                        <asp:GridView ID="gvGateOptions" runat="server" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsGateData" Width="100%" CellPadding ="2" CellSpacing="5">
                            <Columns>
                                <asp:BoundField DataField="Gate1" HeaderText="Gate 1" SortExpression="Gate1" ShowHeader="False" >                                   
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Gate2" HeaderText="Gate 2" SortExpression="Gate2" ShowHeader="False" >                                   
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Gate3" HeaderText="Gate3" SortExpression="Gate3" ShowHeader="False" >                                   
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Gate4" HeaderText="Gate4" SortExpression="Gate4" ShowHeader="False" >                                   
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Gate5" HeaderText="Gate5" SortExpression="Gate5" ShowHeader="False">                                   
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGateData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [GATE1],[GATE2],[GATE3],[GATE4],[GATE5] FROM [GATE_DATA] WHERE [Model] = @Model">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvGates" Name="Model" PropertyName="SelectedValue" Type="String" />                                
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Gates">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateGates" runat="server"  Enabled =' <%# Eval("GatesStatus") >= 1%>' ImageUrl='<%# Eval("GatesStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>"  CommandName="gotoupdate"/>                                           
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:TemplateField HeaderText="Offline">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnOffline" runat="server" Enabled =' <%# Eval("GatesStatus") >= 1%>' ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotostatus"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "../Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />                        
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRails, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.GatesStatus, BML_POPREPORTING_GREENLIGHTS.Gates,cast(FurnitureStatus as integer) + cast(FiberglassStatus as integer) + cast(CoversStatus as integer) + cast(RailsStatus as integer) + cast(TubesStatus as integer) as GreenStatusTotal FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.GatesStatus &lt;= @GatesStatus) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') ORDER BY CASE WHEN BML_POPREPORTING_GREENLIGHTS.FloorsInstalled is NULL Then 1 Else 0 END, BML_POPREPORTING_GREENLIGHTS.FloorsInstalled asc">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                 <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                 <asp:ControlParameter ControlID="ddlShowSelect" Name="GatesStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                 <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" /> 
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" /> 
            </SelectParameters>
        </asp:SqlDataSource>

    </form>
</body>
</html>