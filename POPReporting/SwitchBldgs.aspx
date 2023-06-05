<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SwitchBldgs.aspx.vb" Inherits="Workstations_SwitchBldgs" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SWITCH BUILDINGS</title>
    <link href="StyleSheet.css" rel="stylesheet" />
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">SWITCH LINES</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-switch.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
            <asp:GridView ID="gvAllFieldsFG" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo">
                <Columns>
                     <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                     <ItemStyle VerticalAlign="Middle" />
                     </asp:BoundField>
                     <asp:TemplateField HeaderText="Boat/Customer">
                         <ItemTemplate>
                             <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                             <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>
                             <br />
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
                    <asp:BoundField runat="server" DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:d}">
                             <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                     <asp:BoundField DataField="NumTubes" HeaderText="# Tubes" >
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:BoundField>
                    <asp:TemplateField HeaderText="# Order Lines" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                        <ItemTemplate>
                            <asp:HiddenField runat="server" ID="hdnSONo" Value='<%#Eval("SONo") %>' />
                            <asp:Label runat="server" ID="lblSOLineCount"></asp:Label>
                            
                           <%-- <asp:GridView runat="server" ID="gvSoCount" AutoGenerateColumns="False" DataSourceID="sdsOrderLineCount" ShowHeader="false" GridLines="None">
                                <Columns>
                                    <asp:BoundField DataField="total" ReadOnly="True" ItemStyle-HorizontalAlign="center" ItemStyle-VerticalAlign="Middle"></asp:BoundField>                                  
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource runat="server" ID="sdsOrderLineCount" ConnectionString='<%$ ConnectionStrings:dataConnectionString %>' SelectCommand="SELECT Count(item_no) as total FROM [oeordlin_sql] WHERE ([ord_no] = @ord_no)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hdnSONo" PropertyName="Value" Name="ord_no" Type="String"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- <asp:BoundField runat="server" DataField="ProdLineID" HeaderText="Prod Line">
                             <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>--%>
                     <asp:TemplateField HeaderText="Options">
                         <ItemTemplate>
                             <asp:Label ID="Label4" runat="server" Text='<%# SplitBVatDash(Eval("BaseVinylColor"))%>'></asp:Label>
                             <asp:GridView ID="gvFiberglassOptions" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataKeyNames="LinePop" DataSourceID="sdsPopReportingFiberglassOptions">
                                 <Columns>
                                     <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" >
                                     <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                     </asp:BoundField>
                                 </Columns>
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsPopReportingFiberglassOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([Workcenter] = @Workcenter) AND ([ProdNo] = @ProdNo))">
                                 <SelectParameters>
                                      <asp:Parameter Name="ProdNo" Type="String" />
                                      <asp:Parameter DefaultValue="Fiberglass" Name="Workcenter" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                         </ItemTemplate>

                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />

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
                        <asp:Image ID="Centertube" Visible=' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "./Images/{0}.png") %>'  runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                </asp:ImageField>
                                 </Columns>
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [FurnitureStatus],[FiberglassStatus], [CoversStatus], [RailsStatus], [TubesStatus], [CentertubeStatus], [CentertubeNeeded],cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                                 <SelectParameters>
                                     <asp:ControlParameter ControlID="gvAllFieldsFG" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                         </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                     <asp:TemplateField HeaderText="Update">
                         <ItemTemplate>
                             <div class="newStyle2">
                            <%-- <asp:RadioButtonList ID="rblBuildLoc" runat="server" SelectedValue='<%# Bind("BuildLoc")%>' RepeatDirection="Horizontal">
                                 <asp:ListItem Value="M">Main</asp:ListItem>
                                 <asp:ListItem Value="V">Value</asp:ListItem> 
                                 <asp:ListItem Value="S">South</asp:ListItem>                                  
                                 <asp:ListItem Value="P">Paint</asp:ListItem> 
                             </asp:RadioButtonList>--%>
                                 <asp:RadioButtonList runat="server" ID="rblProdLine" RepeatDirection="Horizontal" DataSourceID="sdsProdLines" DataTextField="ProdLineDesc" DataValueField="ProdLineID" SelectedValue='<%#Eval("ProdLineID") %>' ></asp:RadioButtonList>
                                  <asp:SqlDataSource runat="server" ID="sdsProdLines" ConnectionString='<%$ ConnectionStrings:bml_dataConnectionString %>' SelectCommand="SELECT * FROM [ProductionLines] WHERE ([Disabled] = 0) and ProdLineID <> '%' ORDER BY [ProdLineDesc]">                                
                            </asp:SqlDataSource>

                                 </div>
                             <div class="newStyle2">
                                 <%--<asp:Button ID="btnUpdateBuildLoc" runat="server" Text="Update"  CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateBuildLoc"/>--%>
                                 <asp:Button ID="btnUpdateProdLine" runat="server" Text="Update"  CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateProdLine"/>
                             </div>
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" />
                     </asp:TemplateField>                   
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
           
            <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING_TUBEPRIORITY.Series, BML_POPREPORTING_GREENLIGHTS.DueDate, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesFrames, BML_POPREPORTING_GREENLIGHTS.BuildLoc, Case When BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 then 3 else 2 End As NumTubes, ProdLineID FROM BML_POPREPORTING CROSS JOIN BML_POPREPORTING_GREENLIGHTS LEFT JOIN BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus = @FloorsInstalledStatus) AND (BML_POPREPORTING_TUBEPRIORITY.Series Like '%' + @Series) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') ORDER BY BML_POPREPORTING.ProdNo">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                     <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="FloorsInstalledStatus" PropertyName="SelectedValue" Type="Int32" />
                     <asp:ControlParameter ControlID="ddlSeries" Name="Series" PropertyName="SelectedValue" Type="String" />
                     <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />
                     <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                </SelectParameters>
        </asp:SqlDataSource>

 
    </form>
</body>
</html>