<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Photos.aspx.vb" Inherits="Photos" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PHOTOS</title>
 <link href="StyleSheet.css" rel="stylesheet" />

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
                        <span class="newStyle7">PHOTOS</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                           <!-- #include file ="toolbar-bldgfilter.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
        <asp:GridView ID="gvAllFieldsR" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo" Width="1327px">
                <Columns>
                     <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                     <ItemStyle VerticalAlign="Middle" />
                     </asp:BoundField>
                     <asp:TemplateField HeaderText="Boat/Customer">
                         <ItemTemplate>
                             <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                             <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>                            
                             <br>
                             <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("CusName") %>'></asp:Label>                            
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="./Images/Custom{0}.png" HeaderText="Custom">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                    <asp:ImageField DataImageUrlField="IsPilot" DataImageUrlFormatString="./Images/Pilot{0}.png" HeaderText="Pilot">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                     <asp:TemplateField HeaderText="Options">
                         <ItemTemplate>
                             <asp:Label ID="Label4" runat="server" Text='<%# Eval("PanelColor") %>'></asp:Label>
                             <br />
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
                         <ItemStyle Font-Size="12pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>                    
                     <asp:TemplateField HeaderText="Update">
                         <ItemTemplate>
                             <div class="newStyle2">
                             <asp:RadioButtonList ID="rblPhotosStatus" runat="server" SelectedValue='<%# Bind("PhotosStatus")%>' RepeatDirection="Horizontal">
                                 <asp:ListItem Value="0">Not Started</asp:ListItem>                                
                                 <asp:ListItem Value="1">In Progress</asp:ListItem>
                                 <asp:ListItem Value="2">Done</asp:ListItem>
                             </asp:RadioButtonList>
                                 </div>
                             <div class="newStyle2">
                                 <asp:Button ID="btnUpdatePhotosStatus" runat="server" Text="Update"  CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdatePStatus"/>
                             </div>
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:ImageField DataImageUrlField="PhotosStatus" DataImageUrlFormatString="./Images/{0}checkmark.png" HeaderText="Complete">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                     <asp:TemplateField HeaderText="Notes">
                         <ItemTemplate>
                             <asp:ImageButton ID="btnUpdateNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto"/>                                                                                
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
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRailsPrep, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING.PanelColor, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspection, BML_POPREPORTING_GREENLIGHTS.PhotosStatus FROM BML_POPREPORTING CROSS JOIN BML_POPREPORTING_GREENLIGHTS WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.PhotosStatus &lt;= @PhotosStatus)  AND (BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus &lt;= 2) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') ORDER BY CASE WHEN BML_POPREPORTING_GREENLIGHTS.FinalInspection is NULL Then 1 Else 0 END, BML_POPREPORTING_GREENLIGHTS.FinalInspection asc">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                     <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="PhotosStatus" PropertyName="SelectedValue" Type="Int32" />                     
                     <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />  
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                     <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />
                </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>

