<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Bimini_Feet.aspx.vb" Inherits="Workstations_Bimini_Feet" Debug ="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bimini Feet Locations</title>
<link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
     <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">BIMINI FEET</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="wstoolbar-southtotal.aspx" -->                       
                    </asp:TableCell>
                    <asp:TableCell>
                         <asp:Button ID="btnEdiDims" runat="server" Text="Edit Dimensions" />  
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>  
                
            </div>
        <asp:GridView ID="gvBiminiFt" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
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
                <asp:TemplateField HeaderText="Options">
                    <ItemTemplate>
                        <asp:GridView ID="gvRailsOptions" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsRails">
                            <Columns>
                                <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsFabOptionsRails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = 'RailsPrep' or Workcenter ='RailsInstall') AND (Option_Desc Like '%DBL BIM%' or Option_Desc Like '%DOUBLE BIM%' or Option_Desc Like '%BLACKOUT%' or Option_Desc Like '%POWER TOP%' or Option_Desc Like '%PWR TOP%' or Option_Desc Like '%EPT%' or Option_Desc Like '%CABLE STAYS%'))">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvBiminiFt" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                <asp:Parameter DefaultValue="RailsInstall" Name="Workcenter" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>                       
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Dimensions" Visible="False">
                    <ItemTemplate>
                        <asp:GridView ID="gvSingleDimensions" runat="server" AutoGenerateColumns="False" DataKeyNames="MODEL,MODEL_YEAR" Visible="False" DataSourceID="sdsSingleDimensions" Width="100%">
                            <Columns>                               
                                <asp:BoundField DataField="PORT_REAR" HeaderText="PR" SortExpression="PORT_REAR" >
                                <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PORT_MID" HeaderText="PM" SortExpression="PORT_MID" >
                                <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="STRB_REAR" HeaderText="SR" SortExpression="STRB_REAR" >
                                <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="STRB_MID" HeaderText="SM" SortExpression="STRB_MID" >
                                <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>                                
                            </Columns>
                        </asp:GridView>
                         <asp:GridView ID="gvDoubleDimensions" runat="server" AutoGenerateColumns="False" DataKeyNames="MODEL,MODEL_YEAR" Visible="False" DataSourceID="sdsDoubleDimensions" Width="100%">
                            <Columns>                                                               
                                <asp:BoundField DataField="PORT_DBL_BIM" HeaderText="P DBL BIM" SortExpression="PORT_DBL_BIM" >
                                <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="STRB_DBL_BIM" HeaderText="S DBL BIM" SortExpression="STRB_DBL_BIM" >
                                <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="PORT_REAR" HeaderText="PR" SortExpression="PORT_REAR" >
                                <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>                                
                                <asp:BoundField DataField="STRB_REAR" HeaderText="SR" SortExpression="STRB_REAR" >
                                <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:GridView ID="gvPowertopDimensions" runat="server" AutoGenerateColumns="False" DataKeyNames="MODEL,MODEL_YEAR" DataSourceID="sdsPowertopDimensions" Visible="False" Width="100%">
                            <Columns>                                                               
                                <asp:BoundField DataField="PORT_POWER_TOP" HeaderText="P POWER TOP" SortExpression="PORT_POWER_TOP" >
                                <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="STRB_POWER_TOP" HeaderText="S POWER TOP" SortExpression="STRB_POWER_TOP" >
                                <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsSingleDimensions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Bimini_Feet_Dimensions] WHERE (([MODEL] = @MODEL) AND ([MODEL_YEAR] = @MODEL_YEAR))">
                            <SelectParameters>
                                <asp:Parameter Name="MODEL" Type="String" />
                                <asp:Parameter Name="MODEL_YEAR" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsDoubleDimensions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Bimini_Feet_Dimensions] WHERE (([MODEL] = @MODEL) AND ([MODEL_YEAR] = @MODEL_YEAR))">
                            <SelectParameters>
                                <asp:Parameter Name="MODEL" Type="String" />
                                <asp:Parameter Name="MODEL_YEAR" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsPowertopDimensions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Bimini_Feet_Dimensions] WHERE (([MODEL] = @MODEL) AND ([MODEL_YEAR] = @MODEL_YEAR))">
                            <SelectParameters>
                                <asp:Parameter Name="MODEL" Type="String" />
                                <asp:Parameter Name="MODEL_YEAR" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateBiminis" runat="server"  Enabled =' <%# Eval("BiminiFeetStatus") >= 1%>' ImageUrl='<%# Eval("BiminiFeetStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>"  CommandName="gotoupdate"/>                                           
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Strb">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateBiminisStrb" runat="server"  Enabled =' <%# Eval("BiminiFeetStrbStatus") >= 1%>' ImageUrl='<%# Eval("BiminiFeetStrbStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>"  CommandName="gotoupdatestrb"/>                                           
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:TemplateField HeaderText="Offline">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnOffline" runat="server" Enabled =' <%# Eval("BiminiFeetStatus") >= 1%>' ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotostatus"/>
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
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, (CASE WHEN BML_POPREPORTING.ItemNo Like '2221%' THEN Right(BML_POPREPORTING.ItemNo, Len(BML_POPREPORTING.ItemNo) - 2) ELSE BML_POPREPORTING.ItemNo END) as ItemNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.BIMINIFEETSTATUS,BML_POPREPORTING_GREENLIGHTS.BiminiFeetStrbStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRails, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.RailsStatus >= 1) AND (BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus <= 2) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.BiminiFeetStatus &lt;= @BiminiFeetStatus or BML_POPREPORTING_GREENLIGHTS.BiminiFeetStrbStatus &lt;= @BiminiFeetStrbStatus) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING.ItemNo Not Like '%QX%') AND (BML_POPREPORTING.ItemNo Not Like '%RXS%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') ORDER BY BML_POPREPORTING_GREENLIGHTS.ProdNo">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                 <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                 <asp:ControlParameter ControlID="ddlShowSelect" Name="BiminiFeetStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                <asp:ControlParameter ControlID="ddlShowSelect" Name="BiminiFeetStrbStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                 <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" /> 
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" /> 
            </SelectParameters>
        </asp:SqlDataSource>

    </form>
</body>
</html>