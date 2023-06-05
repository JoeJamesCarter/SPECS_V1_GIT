<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RepairsTracking.aspx.vb" Inherits="Rails_RepairsTracking" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>RAILS Repair Tracking</title>
 <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
.railbuttons {
    margin:4px;
    margin-bottom:4px;
    width:20px;
    background-color:#EFEFEF;
    border-radius:4px;
    border:1px solid #D0D0D0;
    overflow:auto;    
}
.railbuttons input[type=checkbox]:checked{
    margin:4px;
    margin-bottom:4px;
    background:#98FB98;
    border-radius:4px;
    border:1px solid #98FB98;
    overflow:auto;    
}
    </style>

    <script type = "text/javascript">
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
         </script>  
</head>
<body>
    <form id="form1" runat="server">
 <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">RAILS REPAIRS</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <!-- #include file ="../Rails/toolbar-railsrepair.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
        <asp:GridView ID="gvAllFieldsR" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRepairRails" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo" Width="1215px">
                <Columns>
                     <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                     <ItemStyle VerticalAlign="Middle" />
                     </asp:BoundField>
                     <asp:TemplateField HeaderText="Boat/Req Date">
                         <ItemTemplate>
                             <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo")%>'></asp:Label>
                             <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>                                                                                                                                                                                                     
                             <br>                                                                                                                                                                                                                                 
                             <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text= '<%# "Req: " + Eval("DateReq", "{0:d}")%>'></asp:Label><asp:Label ID="lblAutoID" runat="server" Text= '<%# Eval("Auto")%>' Visible="False"></asp:Label><br />
                             <asp:Label ID="lblCustDrawNo" runat="server" CssClass="newStyle5" Visible='<%# IIf(Eval("CustDrawNo").ToString() = "", 0, 1) = 1%>' Text='<%# "Custom: " + Eval("CustDrawNo")%>'></asp:Label> 
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="250px" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Rail">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="200px" />
                     </asp:TemplateField>                 
                    
                     <asp:TemplateField HeaderText="Options">
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
                         </ItemTemplate>
                         <ItemStyle Font-Size="12pt" HorizontalAlign="Center" VerticalAlign="Middle" Width="300px" />
                     </asp:TemplateField>                     
                     <asp:TemplateField HeaderText="Status">
                         <ItemTemplate>
                             <div class="newstyle2">
                                 <asp:RadioButtonList ID="rblRepairStatus" runat="server" RepeatDirection="Horizontal" SelectedValue='<%# Bind("Status")%>' Width="411px">
                                      <asp:ListItem Value="0">Not Started</asp:ListItem>
                                     <asp:ListItem Value="1">Scrapped/Reordered</asp:ListItem>
                                     <asp:ListItem Value="2">Sent</asp:ListItem>
                                 </asp:RadioButtonList>
                                </div>                             
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" Width="200px" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Repair/Reorder">
                         <ItemTemplate>                                                                                                                                             
                             <asp:ImageButton ID="btnUpdateRepair" runat="server" ImageUrl='<%# Eval("RepairFlag", "../Images/repair{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotorepair"/>                              
                         <asp:ImageButton ID="btnUpdateReorder" runat="server" ImageUrl='<%# Eval("ReorderFlag", "../Images/reorder{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoreorder"/> 
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" />
                     </asp:TemplateField>                     
                     <asp:TemplateField HeaderText="Update">
                         <ItemTemplate>
                             <asp:Button ID="btnUpdateRailsStatus" runat="server" CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateRRStatus" style="text-align: right" Text="Update" />
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
        <asp:SqlDataSource ID="sdsRepairRails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rails_RepairsReorders.Auto, Rails_RepairsReorders.ProdNo, Rails_RepairsReorders.PF, Rails_RepairsReorders.SF, Rails_RepairsReorders.PR, Rails_RepairsReorders.SR, Rails_RepairsReorders.PM, Rails_RepairsReorders.SM, Rails_RepairsReorders.T, Rails_RepairsReorders.Note, Rails_RepairsReorders.DateReq, Rails_RepairsReorders.Status, Rails_RepairsReorders.Type, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.SONo, Rails_Tracking.CustDrawNo, Rails_Tracking.WeldDate, Rails_Tracking.RepairFlag, Rails_Tracking.ReorderFlag FROM Rails_RepairsReorders LEFT JOIN BML_POPREPORTING_GREENLIGHTS ON Rails_RepairsReorders.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo LEFT JOIN Rails_Tracking on Rails_RepairsReorders.ProdNo = Rails_Tracking.ProdNo WHERE (Rails_RepairsReorders.Status = @Status) AND (Rails_RepairsReorders.Type = 'Repair') And (Rails_RepairsReorders.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchBoat + '%') AND (Rails_RepairsReorders.ProdNo > '21000001') and (CompleteStatus < 2) ORDER BY Rails_RepairsReorders.DateReq asc">
                <SelectParameters>                                                           
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="Status" PropertyName="SelectedValue" Type="Int32" />                     
                     <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />  
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
