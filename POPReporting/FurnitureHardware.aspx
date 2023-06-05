<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureHardware.aspx.vb" Inherits="FurnitureHardware" MaintainScrollPositionOnPostback="true" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FURNITURE HARDWARE</title>
    <link href="StyleSheet.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">FURNITURE HWR</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <!-- #include file ="toolbar-frames.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
            <asp:GridView ID="gvAllFieldsF" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo">
                <Columns>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo">
                        <ItemStyle VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Boat/Customer">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                            <br />
                            <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("CusName") %>'></asp:Label>
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
                                      <asp:ImageField DataImageUrlField="FurnHwrStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="HWR">
                                           <ItemStyle HorizontalAlign="Center" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="FramesInstalledStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Framed?">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:ImageField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [FurnitureStatus],[FiberglassStatus], [CoversStatus], [RailsStatus], [TubesStatus],[FurnHwrStatus], [FramesInstalledStatus] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvAllFieldsF" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvFurnitureOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="LinePop" DataSourceID="sdsPopReportingFurnitureOptions">
                                <Columns>
                                    <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsPopReportingFurnitureOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([Workcenter] = @Workcenter) AND ([ProdNo] = @ProdNo))">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="String" />
                                    <asp:Parameter DefaultValue="FurniturePrep" Name="Workcenter" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                             <asp:ImageButton ID="btnUpdateNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />
                            <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesFurniturePrep") = 1%>' ImageUrl='<%# Eval("NotesFurniturePrep", "./Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="./Images/Custom{0}.png" HeaderText="Custom">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>                                       
                    <asp:TemplateField HeaderText="Veada">
                        <ItemTemplate>
                            <asp:SqlDataSource ID="sdsVendorInfo" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT OrderLines.ProdNo, ItemNo,StockCode, PartStockCode,PartDesc,PartLineDesc,Color,BO_Flag,RGA_Flag,Qty,RcvdFlag,Job,HardwareReady,CASE When RCVDFlag = 0 Then '0' When RCVDFlag < Qty Then '1' When RCVDFlag = Qty Then '2' END as RCVDGraphic FROM OrderLines left join Live_Boats on OrderLines.ProdNo = Live_Boats.ProdNo WHERE (PartDesc Like '%RECL%' or PartDesc Like '%BASS SEAT%' or PartDesc Like '%BOW GATE BENCH%' or PartDesc Like '%OTTOMAN%' or PartDesc Like '%REFRESHMENT TABLE%' or PartDesc Like '%HELM SEAT%' ) AND  OrderLines.ProdNo = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvOrderLines" runat="server" AutoGenerateColumns="False" BorderStyle="None" Width="100%" DataSourceID="sdsVendorInfo" ShowHeader="False" OnRowCommand="gvOrderLines_RowCommand" OnRowDataBound="gvOrderLines_RowDataBound">
                                <Columns>
                                    
                                    <asp:BoundField DataField="PartDesc" HeaderText="Part Desc" >
                                    <ItemStyle Width="500px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Color" HeaderText="Color" >
                                    
                                    <ItemStyle Width="400px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Qty" HeaderText="Qty" >
                                    <ItemStyle Width="50px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Ready">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnReady" runat="server" CommandArgument='<%# Container.DataItemIndex & ";" & Eval("ProdNo") & ";" & Eval("PartDesc") & ";" & Eval("ItemNo") & ";" & Eval("Color") & ";" & Eval("Job")%>'  CommandName="gotoReady" ImageUrl='<%# Eval("HardwareReady", "./Images/hwr_rdy{0}.png")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>                                       
                  
                    <asp:BoundField DataField="CurrentStatus" HeaderText="Current Status" >   
                  
                     <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                  
                     <asp:TemplateField HeaderText="Update">
                        <ItemTemplate>
                            <div class="newStyle2">
                                <asp:RadioButtonList ID="rblFurnitureStatus" runat="server" SelectedValue='<%# Bind("FurnHwrStatus")%>' RepeatDirection="Horizontal" Width="274px">
                                    <asp:ListItem Value="0">None</asp:ListItem>
                                    <asp:ListItem Value="1">Parts Received</asp:ListItem>                                    
                                    <asp:ListItem Value="2">Ready</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="newStyle2">
                                <asp:Button ID="btnUpdateFurnitureStatus" runat="server" Text="Update" CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateFStatus" />
                            </div>
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

            <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.SONo,  BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING_GREENLIGHTS.NotesFurniturePrep, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.BuildLoc,BML_POPREPORTING_GREENLIGHTS.FurnHwrStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus FROM BML_POPREPORTING CROSS JOIN BML_POPREPORTING_GREENLIGHTS WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus &lt; 2) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.FurnHwrStatus &lt;= @FurnHwrStatus) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'M' or BML_POPREPORTING_GREENLIGHTS.BUILDLOC = 'V') and BML_POPREPORTING_GREENLIGHTS.FurnitureStatus > 0 ORDER BY  BML_POPREPORTING_GREENLIGHTS.HelmInstalled asc, CASE WHEN BML_POPREPORTING_GREENLIGHTS.FramesInstalled is NULL Then 1 Else 0 END">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="FurnHwrStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2"  />
                    <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" /> 
                </SelectParameters>
            </asp:SqlDataSource>

    </form>
</body>
</html>
