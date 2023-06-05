<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GatesInventory.aspx.vb" Inherits="Gates_GatesInventory" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GATES INVENTORY</title>
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
                        <span class="newStyle7">GATES - EXTRA INVENTORY</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnAddAGate" runat="server" Text="Add A Gate" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <!-- #include file ="../Gates/toolbar-gateinventory.aspx" -->
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
                    <asp:TemplateField HeaderText="Gate">
                         <ItemTemplate>
                             <asp:Label ID="lblGate" runat="server" CssClass="newStyle6" Text='<%# Eval("Gate")%>'></asp:Label>
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
                     <asp:TemplateField HeaderText="Mark Used">
                         <ItemTemplate>                                                                                                                                             
                             <asp:ImageButton ID="btnUpdateUsed" runat="server" ImageUrl='<%# Eval("Used", "../Images/extrarailused{0}.png")%>' CommandArgument='<%# Eval("AutoID") %>' CommandName="gotoupdateused" /> 
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Gate ID #">
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
        <asp:SqlDataSource ID="sdsRailsInventory" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Gates_ExtraInventory.AutoID, Gates_ExtraInventory.Model, Gates_ExtraInventory.Gate, Gates_ExtraInventory.Clear, Gates_ExtraInventory.Blackout, Gates_ExtraInventory.Custom, Gates_ExtraInventory.CustomDrawNo, Gates_ExtraInventory.Used, Gates_ExtraInventory.UsedDate, Gates_ExtraInventory.ProdNoUsedFor FROM Gates_ExtraInventory WHERE (Gates_ExtraInventory.Used = @Used) And (Gates_ExtraInventory.Blackout &gt;= @Blackout) And (Gates_ExtraInventory.Clear &gt;= @Clear) And (Gates_ExtraInventory.Custom &gt;= @Custom) And (Gates_ExtraInventory.Gate LIKE '%' + @Search + '%') AND (Gates_ExtraInventory.Model LIKE '%' + @SearchBoat + '%' or Gates_ExtraInventory.Model is Null) ORDER BY Gates_ExtraInventory.Model, Gates_ExtraInventory.CustomDrawNo">
                <SelectParameters>                                      
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="Used" PropertyName="SelectedValue" Type="Int32" />                     
                     <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />  
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlBO" Name="Blackout" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlClear" Name="Clear" PropertyName="SelectedValue" Type="Int32" />                      
                    <asp:ControlParameter ControlID="ddlCustoms" Name="Custom" PropertyName="SelectedValue" Type="Int32" />  
                </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>