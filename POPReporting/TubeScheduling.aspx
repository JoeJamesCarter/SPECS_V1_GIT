<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TubeScheduling.aspx.vb" Inherits="TubeScheduling" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TUBE SCHEDULING</title>
 <link href="StyleSheet.css" rel="stylesheet" />
    <script src="scripts/jquery-2.1.0.min.js"></script>
    <script src="scripts/jquery.tablednd.js"></script>
    <script src="scripts/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
    <link href="scripts/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" />  


</head>
<body>
    
    <form id="form1" runat="server">

 <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">TUBE SCHEDULING</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolsbar.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
        <asp:GridView ID="gvAllFieldsT" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo">
                <Columns>
                     <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                     <ItemStyle VerticalAlign="Middle" />
                     </asp:BoundField>
                     <asp:TemplateField HeaderText="Boat/Customer">
                         <ItemTemplate>
                             <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                             <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>                             
                             <br>                             
                             </br>
                             <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("CusName") %>'></asp:Label>
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="./Images/Custom{0}.png" HeaderText="Custom">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                     <asp:TemplateField HeaderText="Options">
                         <ItemTemplate>
                             <asp:GridView ID="gvFabOptionsTubes" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsPopReportingFabOptions" CssClass="newStyle3">
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
                                     <asp:Parameter DefaultValue="Tubes" Name="Workcenter" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                         </ItemTemplate>
                         <ItemStyle Font-Size="12pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Green Lights">
                         <ItemTemplate>
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
                                     <asp:TemplateField HeaderText="CT">
                                         <ItemTemplate>
                                             <asp:ImageButton ID="imgButtonCentertube" runat="server" ImageUrl='<%# Eval("CentertubeStatus", "./Images/{0}.png")%>' Visible='<%#Eval("CentertubeNeeded") = 1%>'/>
                                         </ItemTemplate>
                                     </asp:TemplateField>
                                 </Columns>
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING.CentertubeNeeded FROM BML_POPREPORTING_GREENLIGHTS INNER JOIN BML_POPREPORTING ON BML_POPREPORTING_GREENLIGHTS.PopNo = BML_POPREPORTING.PopNo WHERE (BML_POPREPORTING_GREENLIGHTS.ProdNo = @ProdNo)">
                                 <SelectParameters>
                                     <asp:ControlParameter ControlID="gvAllFieldsT" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="./Images/{0}checkmark.png" HeaderText="Complete">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                     <asp:TemplateField HeaderText="Notes">
                         <ItemTemplate>
                             <asp:ImageButton ID="btnUpdateNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto"/>                                           
                             <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesTubes") = 1%>' ImageUrl='<%# Eval("NotesTubes", "./Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto"/>                                          
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
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo,  BML_POPREPORTING.IsCustom, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesTubes FROM BML_POPREPORTING CROSS JOIN BML_POPREPORTING_GREENLIGHTS WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.TubesStatus &lt;= @TubesStatus) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') ORDER BY BML_POPREPORTING.ProdNo">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                     <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="TubesStatus" PropertyName="SelectedValue" Type="Int32" />
                     <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '1%' Type="String" />
                     <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />  
                </SelectParameters>
        </asp:SqlDataSource>
    </form>
       

</body>
</html>