<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RailsInventory.aspx.vb" Inherits="Rails_RailsInventory" MaintainScrollPositionOnPostback="true" Debug="true"  %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>RAILS INVENTORY</title>
 <link href="../StyleSheet.css" rel="stylesheet" />


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
                        <span class="newStyle7">RAILS INVENTORY</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnAddARail" runat="server" Text="Add A Rail" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <!-- #include file ="../Rails/toolbar-railsinventory.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
        <asp:GridView ID="gvAllFieldsR" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRailsInventory" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="AutoID">
                <Columns>                     
                     <asp:TemplateField HeaderText="Boat">
                         <ItemTemplate>
                             <asp:Label ID="lblModel" runat="server" CssClass="newStyle6" Text='<%# Eval("Model")%>'></asp:Label>
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rail">
                         <ItemTemplate>
                             <asp:Label ID="lblRail" runat="server" CssClass="newStyle6" Text='<%# Eval("Rail")%>'></asp:Label>
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Drawing">
                         <ItemTemplate>
                             <asp:Label ID="lblDrawingNo" runat="server" CssClass="newStyle6" Text=""></asp:Label>                             
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                    <asp:TemplateField HeaderText="Custom">
                         <ItemTemplate>
                             <asp:CheckBox ID="cbCustom" runat="server" Checked='<%# Eval("Custom")%>' Enabled="False" />                         
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField> 
                    <asp:TemplateField HeaderText="Custom Drawing">
                         <ItemTemplate>                             
                             <asp:Label ID="lblCustDrawNo" runat="server" CssClass="newStyle6" Text='<%# Eval("CustomDrawNo")%>'></asp:Label>                            
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField> 
                     <asp:TemplateField HeaderText="Clear">
                         <ItemTemplate>
                             <asp:CheckBox ID="cbClear" Checked='<%# Eval("Clear")%>' runat="server" Enabled="False" />
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Blackout">
                         <ItemTemplate>
                             <asp:CheckBox ID="cbBO" runat="server" Checked='<%# Eval("Blackout")%>' Enabled="False" />
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Powertop">
                         <ItemTemplate>
                             <asp:CheckBox ID="cbPT" runat="server" Checked='<%# Eval("Powertop")%>' Enabled="False" />
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Mark Used">
                         <ItemTemplate>                                                                                                                                             
                             <asp:ImageButton ID="btnUpdateUsed" runat="server" ImageUrl='<%# Eval("Used", "../Images/extrarailused{0}.png")%>' CommandArgument='<%# Eval("AutoID") %>' CommandName="gotoupdateused" /> 
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Rail ID #">
                           <ItemTemplate>
                             <asp:Label ID="lblAutoID" runat="server" CssClass="newStyle6" Text='<%# Eval("AutoID")%>'></asp:Label>
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
        <asp:SqlDataSource ID="sdsRailsInventory" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rails_ExtraInventory.AutoID, Rails_ExtraInventory.Model, Rails_ExtraInventory.Rail, Rails_ExtraInventory.Clear, Rails_ExtraInventory.Blackout, Rails_ExtraInventory.Powertop, Rails_ExtraInventory.Custom, Rails_ExtraInventory.CustomDrawNo, Rails_ExtraInventory.Used, Rails_ExtraInventory.UsedDate, Rails_ExtraInventory.ProdNoUsedFor, CASE When Rails_ExtraInventory.Rail = 'PF' Then 'PortFront' WHEN Rails_ExtraInventory.Rail = 'PR' Then 'PortRear' When Rails_ExtraInventory.Rail = 'SF' Then 'StrbFront' When Rails_ExtraInventory.Rail = 'SR' Then 'StrbRear' When Rails_ExtraInventory.Rail = 'PM' Then 'PortMid' When Rails_ExtraInventory.Rail = 'SM' Then 'StrbMid' When Rails_ExtraInventory.Rail = 'T' Then 'Transom' END as RailType FROM Rails_ExtraInventory WHERE (Rails_ExtraInventory.Used = @Used) And (Rails_ExtraInventory.Blackout &gt;= @Blackout) And (Rails_ExtraInventory.Clear &gt;= @Clear) And (Rails_ExtraInventory.Powertop &gt;= @Powertop) And (Rails_ExtraInventory.Custom &gt;= @Custom) And (Rails_ExtraInventory.Rail LIKE '%' + @Search + '%') AND (Rails_ExtraInventory.Model LIKE '%' + @SearchBoat + '%' or Rails_ExtraInventory.Model is Null) ORDER BY Rails_ExtraInventory.Model, Rails_ExtraInventory.CustomDrawNo">
                <SelectParameters>                                      
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="Used" PropertyName="SelectedValue" Type="Int32" />                     
                     <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />  
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlBO" Name="Blackout" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlClear" Name="Clear" PropertyName="SelectedValue" Type="Int32" />  
                    <asp:ControlParameter ControlID="ddlPT" Name="Powertop" PropertyName="SelectedValue" Type="Int32" />  
                    <asp:ControlParameter ControlID="ddlCustoms" Name="Custom" PropertyName="SelectedValue" Type="Int32" />  
                </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>