<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureOnlineIssues.aspx.vb" Inherits="FurnitureOnlineIssues" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FURNITURE ONLINE ISSUES</title>
    <link href="StyleSheet.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">FURNITURE ONLINE ISSUES</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-furnitureonlineissues.aspx" -->
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
                        <asp:ImageButton ID="btnUpdateNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" Visible="False" />
                        <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesFurniturePrep") = 1%>' ImageUrl='<%# Eval("NotesFurniturePrep", "./Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="./Images/Custom{0}.png" HeaderText="Custom">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Veada">
                    <ItemTemplate>
                        <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT AutoID, RGA_Item_Desc, Color, Accent, Qty, Date_Added, BenRcvd, DeliveredToLine FROM RGAs WHERE (BenRcvd is Null or DeliveredToLine is Null) and ProdNo = ?ProdNo">
                            <SelectParameters>
                                <asp:Parameter Name="ProdNo" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="gvOrderLines" runat="server" AutoGenerateColumns="False" BorderStyle="None" DataSourceID="sdsRGAs" OnRowCommand="gvOrderLines_RowCommand" OnRowDataBound="gvOrderLines_RowDataBound" >
                            <Columns>

                                <asp:BoundField DataField="RGA_Item_Desc" HeaderText="RGA Desc">
                                    <ItemStyle Width="400px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Color" HeaderText="Color">

                                    <ItemStyle Width="400px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Qty" HeaderText="Qty">
                                    <ItemStyle Width="50px" HorizontalAlign="Center" />
                                </asp:BoundField>

                                <asp:BoundField DataField="Date_Added" DataFormatString="{0:M/dd/yy}" HeaderText="Date Added" >

                                <ItemStyle Width="35px" />
                                </asp:BoundField>

                                <asp:TemplateField HeaderText="Delivered To Boat">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelivered" runat="server" Text="Delivered" Visible='<%# IIf(Eval("BenRcvd").ToString() = "", 0, Eval("BenRcvd")) = 1%>' CommandName="setdelivered" CommandArgument='<%#Eval("AutoID")%>' Height="47px" Width="83px" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                         <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT AutoID, ProdNo, Color, Accent, BO_Item_Desc, DeliveredToLine, Cleared, Date_Added FROM Backorders WHERE (Cleared = '0' or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                            <SelectParameters>
                                <asp:Parameter Name="ProdNo" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                          <asp:GridView ID="gvIntRGAs" runat="server" AutoGenerateColumns="False" BorderStyle="None" DataSourceID="sdsIntRGAs" OnRowCommand="gvIntRGAs_RowCommand" OnRowDataBound="gvIntRGAs_RowDataBound" >
                            <Columns>

                                <asp:BoundField DataField="Part" HeaderText="Internal RGA Desc">
                                    <ItemStyle Width="400px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Color" HeaderText="Color">

                                    <ItemStyle Width="400px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Qty" HeaderText="Qty">
                                    <ItemStyle Width="50px" HorizontalAlign="Center" />
                                </asp:BoundField>

                                <asp:BoundField DataField="DateEntered" DataFormatString="{0:M/dd/yy}" HeaderText="Date Added" >

                                <ItemStyle Width="35px" />
                                </asp:BoundField>

                                <asp:TemplateField HeaderText="Delivered To Boat">
                                    <ItemTemplate>
                                        <asp:Button ID="btnIntDelivered" runat="server" Text="Delivered" Visible='<%# IIf(Eval("Resolved").ToString() = "", 0, Eval("Resolved")) = 2%>' CommandName="setintdelivered" CommandArgument='<%#Eval("AutoID")%>' Height="47px" Width="83px" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                         <asp:SqlDataSource ID="sdsIntRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="Select AutoID, ProdNo, Model, Part, Color, Qty, Reason, DamagedBy, Status, DateEntered, Resolved, DateResolved, DeliveredToLine, CASE When Resolved = '0' Then 'Not Started' WHEN Resolved = '1' Then 'In Progress' WHEN Resolved = '3' Then 'Needs Sent Back' WHEN Resolved = '2' Then 'Complete' END as VeadaStatus FROM InternalRGAs WHERE (DeliveredToLine is Null) and ProdNo = @ProdNo">
                            <SelectParameters>
                                <asp:Parameter Name="ProdNo" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <asp:GridView ID="gvBOs" runat="server" AutoGenerateColumns="False" BorderStyle="None" DataSourceID="sdsBOs" OnRowCommand="gvBOs_RowCommand" OnRowDataBound="gvBOs_RowDataBound" >
                            <Columns>

                                <asp:BoundField DataField="BO_Item_Desc" HeaderText="BO Desc">
                                    <ItemStyle Width="400px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Color" HeaderText="Color">

                                    <ItemStyle Width="450px" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="Date_Added" DataFormatString="{0:M/dd/yy}" HeaderText="Date Added" >

                                <ItemStyle Width="35px" />
                                </asp:BoundField>

                                <asp:TemplateField HeaderText="Delivered To Boat">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelivered" runat="server" Text="Delivered" Visible='<%# IIf(Eval("Cleared").ToString() = "", 0, Eval("Cleared")) = 1%>' CommandName="setbodelivered" CommandArgument='<%#Eval("AutoID")%>' Height="47px" Width="83px" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="20px" />
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>

                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:BoundField DataField="CurrentStatus" HeaderText="Current Status">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
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

        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.SONo,  BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING_GREENLIGHTS.NotesFurniturePrep, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.BuildLoc, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.TrimStatus ='1' Then 'Trim' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus FROM BML_POPREPORTING CROSS JOIN BML_POPREPORTING_GREENLIGHTS WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') AND (BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus > 0) and (BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus < 2) ORDER BY BML_POPREPORTING.ProdNo">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                <asp:ControlParameter ControlID="ddlShowSelect" Name="Resolved" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />
            </SelectParameters>
        </asp:SqlDataSource>


    </form>
</body>
</html>
