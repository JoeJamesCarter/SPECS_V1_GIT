<%@ Page Language="VB" AutoEventWireup="false" CodeFile="POGeneration.aspx.vb" Inherits="FurnitureOrdering_POGeneration" EnableEventValidation = "false" MaintainScrollPositionOnPostback="true" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {}
        .auto-style2 {
            text-align: left;
        }
        .auto-style3 {
            text-align: left;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="newStyle1">
    
        <asp:Calendar ID="calDueDate" runat="server"></asp:Calendar>
        <br />
        <asp:Label ID="Label1" runat="server" Text="SERIES:" CssClass="newStyle6"></asp:Label>
        <asp:DropDownList ID="ddlSeries" runat="server" AutoPostBack="True" CssClass="auto-style1" Height="16px" Width="137px">
            <asp:ListItem Value="%">ALL</asp:ListItem>
            <asp:ListItem>S/L</asp:ListItem>
            <asp:ListItem>G/LX/R/Q</asp:ListItem>
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnExport" runat="server" Text="Export For Veada" />
        &nbsp;&nbsp;
        <asp:Button ID="btnExportPO" runat="server" Text="Export For PO Import" />
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnSave" runat="server" Text="Save" Enabled="False" Visible="False" />
        <br />
        <br />
        <div id="furnorders" runat="server">
        <asp:GridView ID="gvFurnOrders" runat="server" AutoGenerateColumns="False" DataSourceID="sdsLiveBoats" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" DataKeyNames="production_no" CssClass="auto-style2">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:BoundField DataField="production_no" HeaderText="PROD #" SortExpression="production_no" >
                <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="due_dt" HeaderText="DUE DATE" SortExpression="due_dt" DataFormatString="{0:M/d/yy}" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="BaseSeries" HeaderText="BASE SERIES" SortExpression="BaseSeries" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="boat_item" HeaderText="MODEL" SortExpression="boat_item" >                                               
                <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                 <asp:TemplateField HeaderText ="CANVAS">
                    <ItemTemplate>
                        <asp:Label ID="lblCanvas" runat="server" Text=""></asp:Label>
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Top" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="BV">
                    <ItemTemplate>
                        <asp:Label ID="lblBVDesc" runat="server" Text='<%#Eval("base_vinyl_desc") %>'></asp:Label>&nbsp;&nbsp;<asp:Label ID="lblBVItem" runat="server" Text='<%#Eval("base_vinyl_item") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Top" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="ACCENT">
                    <ItemTemplate>
                        <asp:Label ID="lblAccentDesc" runat="server" Text='<%#Eval("vinyl_accent_desc") %>'></asp:Label>&nbsp;&nbsp;<asp:Label ID="lblACCItem" runat="server" Text='<%#Eval("vinyl_accent_item") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Top" />
                </asp:TemplateField>                
                <asp:BoundField DataField="stitch_desc" HeaderText="STITCH" SortExpression="stitch_desc" >
                <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:TemplateField HeaderText ="FURN DESC">
                    <ItemTemplate>
                        <asp:Label ID="lblFurnDesc" runat="server" Text='<%#Eval("pillowtop_desc") %>'></asp:Label>&nbsp;&nbsp;<asp:Label ID="lblFunItem" runat="server" Text='<%#Eval("pillowtop_item") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Top" Width="400px" />
                </asp:TemplateField>  
                <asp:TemplateField HeaderText ="TRIM">
                    <ItemTemplate>
                        <asp:Label ID="lblTrimDesc" runat="server" Text='<%#Eval("trim_accent_desc") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Top" Width="75px" />
                </asp:TemplateField>                
                <asp:BoundField DataField="flooring_1_desc" HeaderText="FLOORING" SortExpression="flooring_1_desc" >                
                <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>               
                 <asp:TemplateField HeaderText="BLDG">
                    <ItemTemplate>
                    <asp:Label ID="lblBldg" runat="server" Text="" CssClass="auto-style3"></asp:Label>
                        </ItemTemplate>
                    <ItemStyle VerticalAlign="Top" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="LINES">
                    <ItemTemplate>
                        <asp:GridView ID="gvLineItems" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvLineItems_RowDataBound" Width="700px" ShowFooter="True" CssClass="auto-style2" OnDataBound="gvLineItems_DataBound" ShowHeader="True">
                            <Columns>                                
                                <asp:BoundField DataField="component_desc" HeaderText="DESC" SortExpression="component_desc" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="300px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="calc_qty" HeaderText="QTY" SortExpression="calc_qty" DataFormatString="{0:0}" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="30px" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText ="LAST COST" ItemStyle-Width="75px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="last_cost" runat="server" Text='<%#Eval("last_cost", "{0:F}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                             
                                <asp:TemplateField HeaderText="LAST TOTAL">
                                    <FooterTemplate>
                                        <asp:Label ID="lblLastTotal" runat="server" Text="Label" CssClass="auto-style3"></asp:Label>
                                    </FooterTemplate>
                                    <ItemTemplate>
                                        
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                               
                                <asp:BoundField DataField="std_cost" HeaderText="STD COST" SortExpression="std_cost" DataFormatString="{0:F}" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="75px" HorizontalAlign="Right" />
                                </asp:BoundField>
                               
                                <asp:TemplateField HeaderText="STD TOTAL">
                                     <FooterTemplate>
                                        <asp:Label ID="lblStdTotal" runat="server" Text="Label" CssClass="auto-style3"></asp:Label>
                                    </FooterTemplate>
                                    <ItemTemplate>

                                    </ItemTemplate>
                                     <FooterStyle HorizontalAlign="Right" />
                                     <HeaderStyle HorizontalAlign="Center" />
                                     <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="VARIANCE">
                                     <FooterTemplate>
                                         <asp:Label ID="lblVariance" runat="server" Text="Label"></asp:Label>
                                     </FooterTemplate>
                                    <ItemTemplate>

                                    </ItemTemplate>
                                     <FooterStyle HorizontalAlign="Right" />
                                     <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        
                    </ItemTemplate>
                   
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                   
                </asp:TemplateField>

                <asp:TemplateField HeaderText="VEADA PARENT">
                    <ItemTemplate>                       
                        <asp:Label ID="lblVeadaParentPart" runat="server" Text="" CssClass="newStyle7"></asp:Label>
                        <asp:Label ID="lblVeadaParentColor" runat="server" Text="" CssClass="newStyle7"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="PO COST">
                    <ItemTemplate>
                        <asp:Label ID="lblPOCostForImport" runat="server" Text=""></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="STD COST">
                    <ItemTemplate>
                        <asp:Label ID="lblStdCostForImport" runat="server" Text=""></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="CUSTOM">
                    <ItemTemplate>
                        <asp:Label ID="lblCustomForImport" runat="server" Text=""></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="VEND #">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%#Eval("vendor") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="PODate">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# DateTime.Today.ToString("M/d/yy")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="BUYER #">
                    <ItemTemplate>
                        <asp:Label ID="lblBuyerNo" runat="server" Text=""></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="LOC">
                    <ItemTemplate>
                        <asp:Label ID="lblLocation" runat="server" Text="1"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                 <asp:TemplateField HeaderText="QTY">
                    <ItemTemplate>
                        <asp:Label ID="lblQty" runat="server" Text="1"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>                

               
                <asp:TemplateField HeaderText="BatchID">
                    <ItemTemplate>
                    <asp:Label ID="lblBatchID" runat="server"  Text='<%# DateTime.Now.ToString("Mdyy_hh:mm:ss") & "_"%>'></asp:Label>
                        </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                </asp:TemplateField>             
             
                <asp:TemplateField HeaderText="Recliner" Visible="False" ItemStyle-Width="260" ItemStyle-Height="314">
                    <ItemTemplate>
                        
                        <asp:Image ID="Img1" runat="server" Visible="true" ImageAlign="Left" ImageUrl="http://specs1/Live/PopReporting/FurnitureImages/placeholder_sizer_recl.png"/>
                    </ItemTemplate>

<ItemStyle Height="314px" Width="260px"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Bench" Visible ="false">
                    <ItemTemplate>
                        
                        <asp:Image ID="Img2" runat="server" visible="true" ImageAlign="Left" ImageUrl="http://specs1/Live/PopReporting/FurnitureImages/placeholder_sizer.png" />                        
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
            <asp:SqlDataSource ID="sdsLiveBoats" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [user_def_fld_1] as production_no, user_def_fld_1, src_ord_no, PPORDFIL_SQL.due_dt, SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 ) as BaseSeries, left([boat_item],len(boat_item)-2) as boat_item, vendor, [flooring_1_desc], Substring([base_vinyl_desc],11, 100) as base_vinyl_desc, Substring([vinyl_accent_desc],12,100) as vinyl_accent_desc, base_vinyl_item, vinyl_accent_item, pillowtop_item, [stitch_desc], [pillowtop_desc], Substring([trim_accent_desc],12,100) as trim_accent_desc FROM [PPORDFIL_SQL] OUTER APPLY (SELECT TOP 1 * From BML_PURPRDBOM Where BML_PURPRDBOM.production_no = PPORDFIL_SQL.user_def_fld_1) as BML_PURPRDBOM WHERE ([due_dt] = @due_dt) AND (((SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'S' OR (SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'L' and boat_item not like '%X%')) AND (@BaseSeries ='S/L' or @BaseSeries = '%')) OR ((SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'Q' OR SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'R' OR SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'G' OR (SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'L' And boat_item like '%X%')) AND (@BaseSeries ='G/LX/R/Q' or @BaseSeries = '%'))) ORDER BY [user_def_fld_1]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="calDueDate" Name="due_dt" PropertyName="SelectedDate" Type="DateTime" />
                    <asp:ControlParameter ControlID="ddlSeries" Name="BaseSeries" PropertyName="SelectedValue" DbType="String" /> 
                </SelectParameters>
            </asp:SqlDataSource>
       <%-- <asp:SqlDataSource ID="sdsBML_PURPRODBOM" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT production_no, src_ord_no, left([boat_item],len(boat_item)-2) as boat_item, [parent_item], [component_desc], [calc_qty], [vendor], [flooring_1_desc], Substring([base_vinyl_desc],11, 100) as base_vinyl_desc, Substring([vinyl_accent_desc],12,100) as vinyl_accent_desc, base_vinyl_item, vinyl_accent_item, pillowtop_item, [stitch_desc], [pillowtop_desc], Substring([trim_accent_desc],12,100) as trim_accent_desc, ([last_cost] * [calc_qty]) as std_cost, ([last_cost] * [calc_qty]) as last_cost, [tot_std_cost], [tot_last_cost], [bom_level], [due_dt], SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 ) as BaseSeries FROM [BML_PURPRDBOM] LEFT JOIN PPORDFIL_SQL on BML_PURPRDBOM.production_no = PPORDFIL_SQL.user_def_fld_1 WHERE (([vendor_name] = @vendor_name AND [p_or_m] = @p_or_m  AND due_dt = @SelectedDate) AND ([mat_cost_type] = @mat_cost_type OR [prod_cat] = @prod_cat) AND (((SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'S') AND @BaseSeries ='S') OR ((SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'Q' OR SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'R' OR SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'G') AND @BaseSeries ='G/R/Q'))) ORDER BY [production_no]">
            <SelectParameters>
                <asp:ControlParameter ControlID="calDueDate" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />                                                                                                                                 
                <asp:Parameter DefaultValue="VEADA IND INC" Name="vendor_name" Type="String" />
                <asp:Parameter DefaultValue="FUR" Name="mat_cost_type" Type="String" />
                <asp:Parameter DefaultValue="H5" Name="prod_cat" Type="String" />                
                <asp:Parameter DefaultValue="P" Name="p_or_m" Type="String" />
                <asp:ControlParameter ControlID="ddlSeries" Name="BaseSeries" PropertyName="SelectedValue" DbType="String" /> 
            </SelectParameters>
        </asp:SqlDataSource>--%>

    </div>
    </div>
    </form>
</body>
</html>
