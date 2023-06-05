<%@ Page Language="VB" AutoEventWireup="false" CodeFile="KitReceiving.aspx.vb" Inherits="KitReceiving" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     
    <title>KIT RECEIVING</title>
            
       <link href="StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .newStyle1 {
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
     <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">KIT RECEIVING</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-kitrcv.aspx" -->
                    </asp:TableCell>                  
        
                </asp:TableRow>
            </asp:Table>          
            </div>
        <asp:GridView ID="gvRails" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                <ItemStyle Font-Bold="True" />
                </asp:BoundField>
                <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="F">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="FG">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="C">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="R">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="T">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                 <asp:TemplateField HeaderText="CT">
                    <ItemTemplate>
                        <asp:Image ID="Centertube" Visible=' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "Images/{0}.png")%>'  runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:ImageField>
                 <asp:TemplateField HeaderText="Q Front">
                    <ItemTemplate>
                        <asp:Image ID="QFront" Visible=' <%# Eval("QFrontNeeded") = 1%>' ImageUrl='<%# Eval("QFrontStatus", "Images/{0}.png")%>'  runat="server" />
                    </ItemTemplate>
                     <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="PF|SF">
                    <ItemTemplate>
                        <asp:Image ID="QFrontRails" Visible='<%# Eval("QFrontNeeded") = 1%>' ImageUrl='<%# Eval("QFrontRailsStatus", "Images/{0}.png")%>'  runat="server" />
                    </ItemTemplate>
                     <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="A/T">
                    <ItemTemplate>
                        <asp:Image ID="ArchTower" Visible=' <%# Eval("ArchTowerNeeded") = 1%>' ImageUrl='<%# Eval("ArchTowerStatus", "Images/{0}.png")%>'  runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField> 
                 <asp:ImageField DataImageUrlField="HelmBuildStatus" DataImageUrlFormatString="Images/helm{0}.png" HeaderText="HELM" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:ImageField>
                <asp:TemplateField HeaderText="Bimini">
                    <ItemTemplate>
                        <asp:Image ID="BimRcvd" Visible=' <%# Eval("ArchTowerNeeded") = 0 or Eval("ArchTowerStatus") = 4 %>' ImageUrl='<%# Eval("BiminiRcvdStatus", "Images/{0}.png")%>'  runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>
                 <asp:ImageField DataImageUrlField="Kitting1Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K1">
                    </asp:ImageField>
                    <asp:ImageField DataImageUrlField="Kitting2Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K2">
                    </asp:ImageField>
                    <asp:ImageField DataImageUrlField="Kitting3Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K3">
                    </asp:ImageField>
                    <asp:ImageField DataImageUrlField="Kitting4Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K4">
                    </asp:ImageField>
                 <asp:ImageField DataImageUrlField="KittingSouthStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="KS">
                    </asp:ImageField>
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
               <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="Images/Custom{0}.png" HeaderText="Custom">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                <asp:ImageField DataImageUrlField="IsPilot" DataImageUrlFormatString="Images/Pilot{0}.png" HeaderText="Pilot">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                <asp:TemplateField HeaderText="Options">
                    <ItemTemplate>
                        <asp:GridView ID="gvRailsOptions" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsRails">
                            <Columns>
                                <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsFabOptionsRails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter))">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                <asp:Parameter DefaultValue="RailsInstall" Name="Workcenter" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>                                    
                <asp:TemplateField HeaderText="Assembly">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnAssembly" runat="server" ImageUrl='<%# Eval("Kit1RcvStatus", "Images/kitrcv{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="assembly" ToolTip='<%# Eval("Kit1Rcv")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Furniture">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnFurniture" runat="server" ImageUrl='<%# Eval("Kit3RcvStatus", "Images/kitrcv{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="furniture" ToolTip='<%# Eval("Kit3Rcv")%>'/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Final">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnFinal" runat="server" ImageUrl='<%# Eval("Kit4RcvStatus", "Images/kitrcv{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="final" ToolTip='<%# Eval("Kit4Rcv")%>'/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="South">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnSouth" runat="server" ImageUrl='<%# Eval("Kit5RcvStatus", "Images/kitrcv{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="south" ToolTip='<%# Eval("Kit5Rcv")%>'/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Trim">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnTrim" runat="server" ImageUrl='<%# Eval("Kit2RcvStatus", "Images/kitrcv{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="trim" ToolTip='<%# Eval("Kit2Rcv")%>'/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />                        
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRails, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CenterTubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded, BML_POPREPORTING_GREENLIGHTS.Kitting1Status, BML_POPREPORTING_GREENLIGHTS.Kitting2Status, BML_POPREPORTING_GREENLIGHTS.Kitting3Status, BML_POPREPORTING_GREENLIGHTS.Kitting4Status, KittingSouthStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus,cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus,(CASE WHEN cast(Rails_Tracking.PF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.PF_Received as varchar) END) + (CASE WHEN cast(Rails_Tracking.SF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.SF_Received as varchar) END) as QFrontRailsStatus, BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus,BiminiRcvdStatus, Kit1RcvStatus, Kit1Rcv, Kit2RcvStatus, Kit2Rcv, Kit3RcvStatus, Kit3Rcv, Kit4RcvStatus, Kit4Rcv, Kit5RcvStatus, Kit5Rcv FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo LEFT JOIN RAILS_TRACKING on BML_POPREPORTING.PRODNO = RAILS_TRACKING.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.TrimStatus = 2)  And (BML_POPREPORTING_GREENLIGHTS.AllKitsRcvd = @AllKitsRcvd) And (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') ORDER BY BML_POPREPORTING_GREENLIGHTS.ProdNo">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                 <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                 <asp:ControlParameter ControlID="ddlShowSelect" Name="AllKitsRcvd" PropertyName="SelectedValue" Type="Int32" DefaultValue="0" />
                 <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" /> 
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" /> 
            </SelectParameters>
        </asp:SqlDataSource>

    </form>
</body>
</html>