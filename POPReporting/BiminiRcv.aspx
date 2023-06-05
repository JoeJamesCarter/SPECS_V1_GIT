<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BiminiRcv.aspx.vb" Inherits="BiminiRcv" Debug="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BIMINI RECEIVING</title>
    <link href="StyleSheet.css" rel="stylesheet" />

</head>

<body>   
    <form id="form1" runat="server">
  <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="800px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">BIMINI RECEIVING</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-biminircv.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
            <asp:GridView ID="gvBiminis" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo">
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
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="./Images/Custom{0}.png" HeaderText="Custom">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                    <asp:ImageField DataImageUrlField="Blackout" DataImageUrlFormatString="./Images/blackout{0}.png" HeaderText="Black">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                    <asp:TemplateField HeaderText="Options">
                        <ItemTemplate>
                             <asp:GridView ID="gvBiminiOptions" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsBiminis">
                            <Columns>
                                <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsFabOptionsBiminis" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter))">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvBiminis" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                <asp:Parameter DefaultValue="Tops" Name="Workcenter" Type="String" />                                
                            </SelectParameters>
                        </asp:SqlDataSource>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Green Lights" Visible="false">
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
                                    <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="BiminiRcvdStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="BIM">
                                         <ItemStyle HorizontalAlign="Center" />
                                    </asp:ImageField>                                    
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [FurnitureStatus],[FiberglassStatus], [CoversStatus], [RailsStatus], [TubesStatus],[CentertubeStatus],[CentertubeNeeded],cast(GaugeStatus as varchar) + cast(HarnessStatus as varchar) as ElectricalStatus, [BiminiRcvdStatus] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvBiminis" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Std Top">
                    <ItemTemplate>                        
                        <asp:GridView ID="gvStdTop" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsStdTop">
                            <Columns>
                                <asp:BoundField DataField="StdTop" HeaderText="Option_Desc" SortExpression="StdTop" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsStdTop" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [StdTop] FROM [Standard_Tops] WHERE (Standard_Tops.ItemNo) = @ItemNo">
                            <SelectParameters>
                            <asp:Parameter Name="ItemNo" Type="String"/>                                          
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                    <asp:TemplateField HeaderText="Comments">
                    <ItemTemplate>
                        <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsMacola" ShowHeader="false">
                            <Columns>
                                <asp:BoundField DataField="cmt" HeaderText="cmt" SortExpression="cmt" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsMacola" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [cmt] FROM [OELINCMT_SQL] WHERE ([ord_no] = @ord_no)">
                            <SelectParameters>
                                <asp:Parameter Name="ord_no" Type="String"/>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>                 
                    <asp:TemplateField HeaderText="Update">
                        <ItemTemplate>
                            <div class="newStyle2">
                                <asp:RadioButtonList ID="rblBiminiRcvdStatus" runat="server" SelectedValue='<%# Bind("BiminiRcvdStatus")%>' RepeatDirection="Horizontal" Width="200px">
                                    <asp:ListItem Value="0">None</asp:ListItem>                                                                        
                                    <asp:ListItem Value="2">Received</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="newStyle2">
                                <asp:Button ID="btnUpdateBiminiRcvdStatus" runat="server" Text="Update" CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateBiminiRcvdStatus" />
                            </div>
                        </ItemTemplate>
                        <ItemStyle VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:ImageField DataImageUrlField="BiminiRcvdStatus" DataImageUrlFormatString="./Images/{0}checkmark.png" HeaderText="Complete">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                    <asp:TemplateField HeaderText="Notes">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnUpdateNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />                            
                        </ItemTemplate>
                        <ItemStyle VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Bimini Built" DataField="Bimini" >                               
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Bimini Rcvd" DataField="BiminiRcvd" >                               
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

            <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, BML_POPREPORTING_GREENLIGHTS.SONo,  BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.CusName, BML_POPREPORTING_GREENLIGHTS.BaseVinylColor, BML_POPREPORTING_GREENLIGHTS.IsCustom, BML_POPREPORTING_GREENLIGHTS.IsPilot, BML_POPREPORTING_GREENLIGHTS.NotesGauge, BML_POPREPORTING_GREENLIGHTS.GaugeStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded,BML_POPREPORTING_GREENLIGHTS.BiminiRcvd, BML_POPREPORTING_GREENLIGHTS.BiminiRcvdStatus,BML_POPREPORTING_GREENLIGHTS.Bimini, Rails_Tracking.Blackout, BML_POPREPORTING_GREENLIGHTS.ProdLineID, ProdLineDesc FROM BML_POPREPORTING_GREENLIGHTS Left Join Rails_Tracking on BML_POPREPORTING_GREENLIGHTS.ProdNo = Rails_Tracking.ProdNo Left Join ProductionLines on BML_POPREPORTING_GREENLIGHTS.ProdLineID = ProductionLines.ProdLineID WHERE (BML_POPREPORTING_GREENLIGHTS.BiminiRcvdStatus &lt;= @BiminiRcvdStatus) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchBoat + '%') AND ((BML_POPREPORTING_GREENLIGHTS.ItemNo Not LIKE '%WT%' AND BML_POPREPORTING_GREENLIGHTS.ItemNo Not LIKE '%TIO%' AND BML_POPREPORTING_GREENLIGHTS.ItemNo Not Like '%BA%'  AND BML_POPREPORTING_GREENLIGHTS.ItemNo Not Like '%RA%'  AND BML_POPREPORTING_GREENLIGHTS.ItemNo Not Like '%WA%') or BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus = 4) AND (BML_POPREPORTING_GREENLIGHTS.ProdLineID LIKE  '%' + @ProdLineID + '%') AND (BML_POPREPORTING_GREENLIGHTS.ProdNo > 2100000) AND ((Convert(date,BML_POPREPORTING_GREENLIGHTS.Bimini) > '02-17-19' ) OR (BML_POPREPORTING_GREENLIGHTS.Bimini is null)) ORDER BY Convert(integer,BML_POPREPORTING_GREENLIGHTS.ProdNo)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="BiminiRcvdStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2"  />
                    <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlProdLine" Name="ProdLineID" PropertyName="SelectedValue" DbType="String" /> 
                </SelectParameters>
            </asp:SqlDataSource>

    </form>
</body>
</html>
