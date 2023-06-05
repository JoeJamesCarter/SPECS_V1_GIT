<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureOpenOrders.aspx.vb" Inherits="FurnitureOrdering_FurnitureOpenOrders" debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Open Orders Furniture Images</title>     
        <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <asp:DropDownList ID="ddlSeries" runat="server" AutoPostBack="True" CssClass="auto-style1" Height="16px" Width="137px">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>S</asp:ListItem>
            <asp:ListItem>G/R/Q</asp:ListItem>
        </asp:DropDownList>
            <asp:GridView ID="gvOpenOrders" runat="server" DataSourceID="sdsBML_PURPRODBOM" CssClass="newStyle1">
                <Columns>
                    <asp:TemplateField HeaderText="Recliner">
                        <ItemTemplate>
                            <asp:Image ID="img1" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bench">
                        <ItemTemplate>
                            <asp:Image ID="img2" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Custom">
                        <ItemTemplate>
                            <asp:Label ID="lblCustom" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Veada BOM">
                        <ItemTemplate>
                            <asp:Label ID="lblVeadaParent" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
             </asp:GridView>
             <asp:SqlDataSource ID="sdsBML_PURPRODBOM" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [production_no], left([boat_item],len(boat_item)-2) as boat_item, Substring([base_vinyl_desc],11, 100) as base_vinyl_desc, Substring([vinyl_accent_desc],12,100) as vinyl_accent_desc, base_vinyl_item, vinyl_accent_item, pillowtop_item, [stitch_desc], [pillowtop_desc], SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 ) as BaseSeries FROM [BML_PURPRDBOM] LEFT JOIN PPORDFIL_SQL on BML_PURPRDBOM.production_no = PPORDFIL_SQL.user_def_fld_1 WHERE (([vendor_name] = @vendor_name AND [p_or_m] = @p_or_m  AND bom_level = '3') AND ([mat_cost_type] = @mat_cost_type OR [prod_cat] = @prod_cat) AND (((SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'S') AND @BaseSeries ='S') OR ((SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'Q' OR SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'R' OR SUBSTRING(boat_item, PATINDEX('%[a-z]%',boat_item),1 )= 'G') AND @BaseSeries ='G/R/Q'))) AND pillowtop_item is not NULL AND production_no > 1999999 ORDER BY [production_no]">
            <SelectParameters>                
                <asp:Parameter DefaultValue="VEADA IND INC" Name="vendor_name" Type="String" />
                <asp:Parameter DefaultValue="FUR" Name="mat_cost_type" Type="String" />
                <asp:Parameter DefaultValue="H5" Name="prod_cat" Type="String" />                
                <asp:Parameter DefaultValue="P" Name="p_or_m" Type="String" />
                <asp:ControlParameter ControlID="ddlSeries" Name="BaseSeries" PropertyName="SelectedValue" DbType="String" /> 
            </SelectParameters>
        </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
