<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Scheduling.aspx.vb" Inherits="Rails_Scheduling" MaintainScrollPositionOnPostback="true" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rails Weld Schedule</title>
     <link href="../StyleSheet.css" rel="stylesheet" />
</head>

<body>
    <form id="form1" runat="server">
        <div class="newStyle6">
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">RAILS SCHEDULING</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <!-- #include file ="../Rails/toolbar-railsscheduling.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle3"><asp:Label ID="Label1" runat="server" Text="Date To Schedule"></asp:Label></span><asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
                    </asp:TableCell>
                    <asp:TableCell>
                        <span class="newStyle3">First: </span><asp:TextBox ID="tbFirst" runat="server"></asp:TextBox> <span class="newStyle3">Last: </span><asp:TextBox ID="tbLast" runat="server"></asp:TextBox>&nbsp;&nbsp;<asp:Button ID="btnSelect" runat="server" Text="Multi-Select" />&nbsp;&nbsp;<asp:Button ID="btnDeselectAll" runat="server" Text="Deselect All" />
                        <br />
                        <br />
                        <asp:Button ID="btnApplyDate" runat="server" Text="Apply Date to Selected" />&nbsp;&nbsp;<asp:Button ID="btnNumSelected" runat="server" Text="How Many Are Selected?" />
                        <br />
                        <br />
                        <asp:Button ID="btnSave" runat="server" Text="Save Screen" Font-Size="20" Font-Bold="True" />&nbsp;&nbsp;<asp:Label ID="lblNumSelected" runat="server" Text=""></asp:Label># Selected
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table> 
                     
                <asp:Label runat="server" Text="Yellow Prod #'s are Custom, Blue Models are Pilots." CssClass="newStyle6"></asp:Label>
           
            &nbsp;Dark Grey Select Boxes are South Boats.</div>
    <div>
        <br /><asp:GridView ID="gvRailsSchedule" CssClass="newStyle1" runat="server" DataSourceID="sdsRailsTracking" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:TemplateField HeaderText="Select">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbSelect" runat="server" style="text-align: center" />
                    </ItemTemplate>
                    <ItemStyle Width="50px" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" >
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Model">
                    <ItemTemplate>
                        <asp:Label ID="lblModel" runat="server" Text='<%# Eval("ItemNo") %>'></asp:Label>
                        <asp:ImageButton ID="btnOrderDetails" runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" ImageUrl="../Images/getboatdetails.png" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Custom Rail Drawing">
                    <ItemTemplate>
                        <asp:TextBox ID="tbCustomNo" runat="server" Text='<%# Eval("CustDrawNo")%>'></asp:TextBox>
                    </ItemTemplate>
                    <ItemStyle Width="100px" />
                </asp:TemplateField>
                <asp:BoundField DataField="Blackout" HeaderText="Blackout" >
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="Powertop" HeaderText="Power Top" >
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Weld Date">
                    <ItemTemplate>
                        <asp:TextBox ID="tbWeldDate" runat="server"  Text='<%# Eval("WeldDate", "{0:d}")%>'></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Rails Needed">
                    <ItemTemplate>
                        <asp:TextBox ID="tbNumRailsNeeded" runat="server"  Text='<%# Eval("RailsNeeded")%>' Width="30px"></asp:TextBox>
                    </ItemTemplate>
                     <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Port Mid">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbPM" runat="server" Checked='<%# IIf(Eval("NeedsPortMid").ToString() = "", 0, Eval("NeedsPortMid")) = 1%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Strb Mid">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbSM" runat="server" Checked='<%# IIf(Eval("NeedsStrbMid").ToString() = "", 0, Eval("NeedsStrbMid")) = 1%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Transom">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbT" runat="server" Checked='<%# IIf(Eval("NeedsTransom").ToString() = "", 0, Eval("NeedsTransom")) = 1%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Protech">
                    <ItemTemplate>
                       <asp:CheckBox ID="cbprotech" runat="server" Checked='<%# IIf(Eval("Protech").ToString() = "", 0, Eval("Protech")) = 1%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>        
    </div>
        <asp:SqlDataSource ID="sdsRailsTracking" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rails_Tracking.ProdNo, Rails_Tracking.SONo, Rails_Tracking.ItemNo,  Rails_Tracking.WeldDate,  Rails_Tracking.RailsNeeded, Rails_Tracking.Blackout, Rails_Tracking.Powertop, Rails_Tracking.Shatter, Rails_Tracking.CustDrawNo, Rails_Tracking.Scheduled, Rails_Tracking.NeedsPortMid,Rails_Tracking.NeedsStrbMid,Rails_Tracking.NeedsTransom, Protech, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.IsCustom, BML_POPREPORTING_GREENLIGHTS.IsPilot, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM Rails_Tracking LEFT JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING_GREENLIGHTS.ProdNo = Rails_Tracking.ProdNo Right Join BML_POPREPORTING on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo WHERE(Rails_Tracking.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.RailsStatus <> 2) AND (Rails_Tracking.Scheduled = @Scheduled) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchBoat + '%') order by Rails_Tracking.ProdNo ">
                <SelectParameters>                                                     
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="Scheduled" PropertyName="SelectedValue" Type="Int32" />                     
                     <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />
                     <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
