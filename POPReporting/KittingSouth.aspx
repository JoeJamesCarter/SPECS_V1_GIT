<%@ Page Language="VB" AutoEventWireup="false" CodeFile="KittingSouth.aspx.vb" Inherits="KittingSouth" Debug="true" MaintainScrollPositionOnPostback="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>KITTING SOUTH</title>
    <link href="StyleSheet.css" rel="stylesheet" />   
    <style>
        @media print {
            #results {
                background-color: white;
                height: 100%;
                width: 100%;
                position: fixed;
                top: 0;
                left: 0;
                margin: 0;
            }
        }

            #left {
                float: left;
                width: 1374px;
            }

            #right {
                float:left;              
            }
              .duedate {
            font-size: 12px;
            font-weight: bold;
            font-family: calibri;
        }
       
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">KITTING</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" /><br /><asp:Button ID="btnPrint" runat="server" Text="Print" /><br />
                        <asp:Button ID="btnMaintain" runat="server" Text="Maintain Parts List" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-bldgfilter.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
    
        <div id="left">
            <asp:GridView ID="gvKitting" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo">
                <Columns>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo">
                        <ItemStyle VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Boat/Customer">
                       
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                            <br />
                            <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("CusName") %>'></asp:Label><br />                                             
                            <asp:Label ID="Label7" runat="server" CssClass="newStyle5" Text="Due Date: "></asp:Label><asp:Label ID="Label6" runat="server" Text='<%# Eval("DueDate", "{0:d}")%>' CssClass="newStyle6"></asp:Label>
                            <br />
                                 <br />
                             <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReportingByProdNo">
                                <Columns>
                                    <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="F">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="FG">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="C">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="R">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="T">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="Kitting1Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K1">
                                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="Kitting2Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K2">
                                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="Kitting3Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K3">
                                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="Kitting4Status" DataImageUrlFormatString="./Images/{0}.png" HeaderText="K4">
                                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="KittingSouthStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="KS">
                                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                     <asp:ImageField DataImageUrlField="FramesInstalledStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Framed?">
                                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [FurnitureStatus],[FiberglassStatus], [CoversStatus], [RailsStatus], [TubesStatus], [KITTING1STATUS], [KITTING2STATUS], [KITTING3STATUS], [KITTING4STATUS], [KITTINGSOUTHSTATUS], [FRAMESINSTALLEDSTATUS] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvKitting" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <br />
                             <br />
                        <asp:Label ID="Label1" runat="server" Text="Base Vinyl:   "></asp:Label><asp:Label ID="lblBV" runat="server" Text=""></asp:Label><br />
                        <asp:Label ID="Label4" runat="server" Text="Int Acct:   "></asp:Label><asp:Label ID="lblAccent" runat="server" Text=""></asp:Label><br />
                        <asp:Label ID="Label5" runat="server" Text="Trim Acct:   "></asp:Label><asp:Label ID="lblTrim" runat="server" Text=""></asp:Label><br />
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
                            <asp:GridView ID="gvHelmKittingOptions" runat="server" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsSouthKitting" width ="550px">
                            <Columns>
                                <asp:BoundField DataField="component_item" HeaderText="Option_Desc" SortExpression="component_item" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                  <asp:BoundField DataField="item_desc_1" HeaderText="Desc" SortExpression="item_desc_1" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="300px" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="Abbreviation" HeaderText="Abbreviation" SortExpression="Abbreviation" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="120px" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="calc_qty" HeaderText="Qty" SortExpression="calc_qty" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="uom" HeaderText="uom" SortExpression="uom" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>                            
                        <asp:SqlDataSource ID="sdsSouthKitting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.component_item, t1.calc_qty, t2.uom, t2.item_desc_1, NotKitted, Abbreviation FROM KittingSouth_PURPRDBOM t1 Left Join Inventory_ItemMaster t2 on t1.component_item = t2.item_no Left join KittingSouthParts t3 on t1.component_item = t3.PartNo Where ([ProdNo] = @ProdNo) and NotKitted = 0 Order By Abbreviation, item_desc_1">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvKitting" Name="ProdNo" PropertyName="SelectedValue" Type="String" />                                
                            </SelectParameters>
                        </asp:SqlDataSource>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Green Lights" Visible ="False">
                        <ItemTemplate>
                           
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>                    
                    <asp:TemplateField HeaderText="Update">
                        <ItemTemplate>
                            <div class="newStyle2">
                                <asp:RadioButtonList ID="rblKittingStatus" runat="server" SelectedValue='<%# Bind("Kitting3Status")%>' RepeatDirection="Vertical" Width="174px" style="text-align: center">
                                    <asp:ListItem Value="0">None</asp:ListItem>                                                                  
                                    <asp:ListItem Value="2">All</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="newStyle2"><br />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnUpdateKittingStatus" runat="server" Text="Update" CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateKittingStatus" style="text-align: center" />
                            </div>
                        </ItemTemplate>
                        <ItemStyle VerticalAlign="Middle" Width="100px" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:ImageField DataImageUrlField="Kitting3Status" DataImageUrlFormatString="./Images/{0}checkmark.png" HeaderText="Complete">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                    <asp:TemplateField HeaderText="Notes">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnUpdateNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />
                            <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%# Eval("NotesKitting") = 1%>' ImageUrl='<%# Eval("NotesKitting", "Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />
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
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus,BML_POPREPORTING_GREENLIGHTS.IsPilot, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesKitting, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CenterTubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded,cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, BML_POPREPORTING_GREENLIGHTS.Kitting3Status, BML_POPREPORTING_GREENLIGHTS.DueDate FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.KittingSouthStatus &lt;= @KittingSouthStatus) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC =  'S') AND Kit5RcvStatus = 0 AND FramesInstalledStatus = 2 ORDER BY BML_POPREPORTING.ProdNo asc">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                 <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                 <asp:ControlParameter ControlID="ddlShowSelect" Name="KittingSouthStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                 <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" /> 
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />                
            </SelectParameters>
        </asp:SqlDataSource>
            </div>    
          <div id="right">
        <asp:GridView ID="gvPartsNeeded" runat="server" AutoGenerateColumns="False" DataKeyNames="component_item" DataSourceID="sdsTotals" CssClass="newStyle1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" Caption="SUM OF PARTS REQUIRED FOR KITS/YELLOW = WATCH" CellPadding="3" ForeColor="Black" GridLines="Both" Width="525px">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>                
                <asp:BoundField DataField="component_item" HeaderText="Item #" ReadOnly="True" SortExpression="component_item" />
                <asp:BoundField DataField="item_desc_1" HeaderText="Desc" ReadOnly="True" SortExpression="item_desc_1" />
                 <asp:BoundField DataField="qty" HeaderText="Qty" ReadOnly="True" SortExpression="qty" />
                <asp:BoundField DataField="uom" HeaderText="UOM" ReadOnly="True" SortExpression="uom" />
                <asp:TemplateField HeaderText ="Recent Counts">
                    <ItemTemplate>
                        <asp:GridView ID="gvCCs" runat="server" AutoGenerateColumns="False" cssClass="newStyle1" DataSourceID ="sdsCCs">
                            <Columns>
                                <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" />
                                <asp:BoundField DataField="Counted" HeaderText="Counted" SortExpression="Counted" />
                                <asp:BoundField DataField="Area" HeaderText="Area" SortExpression="Area" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsCCs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 3 [Qty], [Counted], [Area] FROM [CycleCounts] WHERE ([PartNo] = @PartNo) ORDER BY [Counted] DESC">
                            <SelectParameters>
                                <asp:Parameter Name="PartNo" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
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
            <asp:SqlDataSource ID="sdsTotals" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct(component_item), Sum(calc_qty) as qty, t2.item_desc_1, t2.uom, Watch, Tally FROM [KittingSouth_PURPRDBOM] t1 Left join KittingSouthParts t3 on t1.component_item = t3.PartNo Left Join Inventory_ItemMaster t2 on t1.component_item = t2.item_no where t1.ProdNo in (SELECT Distinct(BML_POPREPORTING.ProdNo) FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE t3.Tally = '1' And t3.NotKitted = '0' AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC =  'S') AND Kit5RcvStatus = 0 AND FramesInstalledStatus = 2) group by component_item, t2.item_desc_1, t2.uom, t3.Watch, t3.Tally order by component_item">               
        </asp:SqlDataSource>

               <asp:GridView ID="gvPartsNeededNotKittedSouthWip" runat="server" AutoGenerateColumns="False" DataKeyNames="component_item" DataSourceID="sdsTotalsNotKitted" CssClass="newStyle1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" Caption="PARTS REQD FOR CURRENT SOUTH WIP PRE FINAL INSP" CellPadding="3" ForeColor="Black" GridLines="Both" Width="525px">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>                
                <asp:BoundField DataField="component_item" HeaderText="Item #" ReadOnly="True" SortExpression="component_item" />
                <asp:BoundField DataField="item_desc_1" HeaderText="Desc" ReadOnly="True" SortExpression="item_desc_1" />
                 <asp:BoundField DataField="qty" HeaderText="Qty" ReadOnly="True" SortExpression="qty" />
                <asp:BoundField DataField="uom" HeaderText="UOM" ReadOnly="True" SortExpression="uom" />
                <asp:TemplateField HeaderText ="Recent Counts">
                    <ItemTemplate>
                        <asp:GridView ID="gvCCsNotKitted" runat="server" AutoGenerateColumns="False" cssClass="newStyle1" DataSourceID ="sdsCCsNotKitted">
                            <Columns>
                                <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" />
                                <asp:BoundField DataField="Counted" HeaderText="Counted" SortExpression="Counted" />
                                <asp:BoundField DataField="Area" HeaderText="Area" SortExpression="Area" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsCCsNotKitted" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 3 [Qty], [Counted], [Area] FROM [CycleCounts] WHERE ([PartNo] = @PartNo) ORDER BY [Counted] DESC">
                            <SelectParameters>
                                <asp:Parameter Name="PartNo" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
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
            <asp:SqlDataSource ID="sdsTotalsNotKitted" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct(component_item), Sum(calc_qty) as qty, t2.item_desc_1, t2.uom, Watch, Tally FROM [KittingSouth_PURPRDBOM] t1 Left join KittingSouthParts t3 on t1.component_item = t3.PartNo Left Join Inventory_ItemMaster t2 on t1.component_item = t2.item_no where t1.ProdNo in (SELECT Distinct(BML_POPREPORTING.ProdNo) FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE t3.Tally = '1' And t3.NotKitted = '1' AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC =  'S') AND IsDeckInside = 1 AND FinalInspectionStatus < 2) group by component_item, t2.item_desc_1, t2.uom, t3.Watch, t3.Tally order by component_item">               
        </asp:SqlDataSource>

          </div>
    </form>
</body>
</html>