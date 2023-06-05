<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddFurnCombos.aspx.vb" Inherits="FurnitureOrdering_AddFurnCombs" Debug="True" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Furniture Combinations</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .newStyle1 {}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="newStyle1"> 
            <asp:Label ID="Label2" runat="server" CssClass="newStyle7" Text="Add Required Furniture Combinations"></asp:Label><br /><br />
              <asp:Label ID="Label1" runat="server" Text="Select Model Year:" CssClass="newStyle6"></asp:Label>
              <asp:DropDownList ID="ddlModelYear" runat="server" Enabled="True" AutoPostBack="True">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem>20</asp:ListItem>
                <asp:ListItem>21</asp:ListItem>
              </asp:DropDownList>
            <br />
             <br />

            <asp:DetailsView ID="dvAddFurnCombox" runat="server" Height="50px" Width="799px" AutoGenerateRows="False" CssClass="newStyle1" DataKeyNames="MODEL_YEAR,SERIES_PART,BASE_VINYL_PART,PRIMARY_ACCENT_PART" DataSourceID="sdsFurnCombos" DefaultMode="Insert">
                <Fields>
                    <asp:TemplateField HeaderText ="Catalog Page">
                        <ItemTemplate>
                             <asp:TextBox ID="tbCatalogPg" runat="server"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CATALOG_PAGE" HeaderText="CATALOG_PAGE" SortExpression="CATALOG_PAGE" />
                    <asp:TemplateField HeaderText="SERIES">
                        <ItemTemplate>
                         <asp:DropDownList ID="ddlSeries" runat="server" DataSourceID="sdsSeries" DataTextField="SERIES" DataValueField="SERIES" AutoPostBack="true" AppendDataBoundItems="False" OnSelectedIndexChanged="ddlSeries_SelectedIndexChanged">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsSeries" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(SERIES) FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY [SERIES]">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="FUR" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            </ItemTemplate>
                    </asp:TemplateField>                    
                    <asp:TemplateField HeaderText="FURN STYLE">
                        <ItemTemplate>
                          <asp:DropDownList ID="ddlPatterns" runat="server" DataSourceID="sdsPatterns" DataTextField="PATTERN" DataValueField="SERIES_PART" AppendDataBoundItems="False" AutoPostBack="True" OnSelectedIndexChanged="ddlPatterns_SelectedIndexChanged">
                               <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsPatterns" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [MACOLA_PART] as SERIES_PART, [SERIES], [CATALOG_DESC] as PATTERN FROM [Furniture_Catalog_Descs] WHERE (([PART_TYPE] = @PART_TYPE) AND ([SERIES] = @SERIES) AND (MODEL_YEAR = @MODEL_YEAR)) ORDER BY [SERIES]">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="FUR" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlSeries" Name="SERIES" PropertyName="SelectedValue" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="FURN PART #">
                        <ItemTemplate>
                            <asp:TextBox ID="tbFurniturePart" runat="server" Enabled="False"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                                        
                    <asp:TemplateField HeaderText ="PRIMARY BASE VINYL">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlBaseVinyl" runat="server" DataSourceID="sdsBVs" DataTextField="PRIMARY_BASE_VINYL" DataValueField="BASE_VINYL_PART" AutoPostBack="True" OnSelectedIndexChanged="ddlBaseVinyl_SelectedIndexChanged" AppendDataBoundItems="False">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsBVs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT CATALOG_DESC as PRIMARY_BASE_VINYL, MACOLA_PART as BASE_VINYL_PART FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY [CATALOG_DESC]">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="BV" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                                 </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="BASE VINYL PART #">
                        <ItemTemplate>
                            <asp:TextBox ID="tbBVPart" runat="server" Enabled="False"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                                        
                    <asp:TemplateField HeaderText ="PRIMARY ACCENT">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlIntAccents" runat="server" DataSourceID="sdsIAs" DataTextField="ACCENT" DataValueField="PRIMARY_ACCENT_PART" OnSelectedIndexChanged="ddlIntAccents_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="False">
                                <asp:ListItem></asp:ListItem>
                             </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsIAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as ACCENT, MACOLA_PART as PRIMARY_ACCENT_PART FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="ACC" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="ACCENT PART #">
                        <ItemTemplate>
                            <asp:TextBox ID="tbAccentPart" runat="server" Enabled="False"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="ACCENT 2">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlAcc2" runat="server" DataSourceID="sdsAcc2" DataTextField="ACCENT_2" DataValueField="ACCENT_2" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsAcc2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as ACCENT_2 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="ACC2" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="ACCENT 3">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlAcc3" runat="server" DataSourceID="sdsAcc3" DataTextField="ACCENT_3" DataValueField="ACCENT_3" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsAcc3" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as ACCENT_3 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="ACC3" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="LUMBAR">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlLumbar" runat="server" DataSourceID="sdsLumbar" DataTextField="LUMBAR" DataValueField="LUMBAR" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsLumbar" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as LUMBAR FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="LUM" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="LUMBAR 2">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlLumbar2" runat="server" DataSourceID="sdsLumbar2" DataTextField="LUMBAR_2" DataValueField="LUMBAR_2" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsLumbar2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as LUMBAR_2 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="LUM2" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="TOP STITCH">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlTopStitch" runat="server" DataSourceID="sdsTopStitch" DataTextField="TOP_STITCH" DataValueField="TOP_STITCH" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsTopStitch" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as TOP_STITCH FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="TOPSTITCH" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="SEAT PAN OVERLAY">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlSeatPanOverlay" runat="server" DataSourceID="sdsSeatPanOverlay" DataTextField="SEAT_PAN_OVERLAY" DataValueField="SEAT_PAN_OVERLAY" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsSeatPanOverlay" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as SEAT_PAN_OVERLAY FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="SEATPANOVERLAY" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                                </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="MONOGRAM">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlMonogram" runat="server" DataSourceID="sdsMonogram" DataTextField="Monogram" DataValueField="Monogram" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsMonogram" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Monogram FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="MONOGRAM" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="MONOGRAM 2">
                        <ItemTemplate>
                               <asp:DropDownList ID="ddlMonogram2" runat="server" DataSourceID="sdsMonogram2" DataTextField="Monogram_2" DataValueField="Monogram_2" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsMonogram2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Monogram_2 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="MONOGRAM2" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="MONOGRAM WING">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlMonogramWing" runat="server" DataSourceID="sdsMonogramWing" DataTextField="Monogram_Wing" DataValueField="Monogram_Wing" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsMonogramWing" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Monogram_Wing FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="MONOGRAMWING" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="RECLINER MONOGRAM">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlRecliner_Monogram" runat="server" DataSourceID="sdsRecliner_Monogram" DataTextField="Recliner_Monogram" DataValueField="Recliner_Monogram" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsRecliner_Monogram" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Recliner_Monogram FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="RECLMONOGRAM" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText ="RECLINER MONOGRAM 2">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlRecliner_Monogram2" runat="server" DataSourceID="sdsRecliner_Monogram2" DataTextField="Recliner_Monogram_2" DataValueField="Recliner_Monogram_2" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsRecliner_Monogram2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Recliner_Monogram_2 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="RECLMONOGRAM" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="WELT COLOR">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlWelt_Color" runat="server" DataSourceID="sdsWelt_Color" DataTextField="Welt_Color" DataValueField="Welt_Color" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsWelt_Color" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Welt_Color FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="WELT" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="WELT COLOR 2">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlWelt_Color2" runat="server" DataSourceID="sdsWelt_Color2" DataTextField="Welt_Color_2" DataValueField="Welt_Color_2" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsWelt_Color2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Welt_Color_2 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="WELT2" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="BENCCH MONO PANEL">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlBenchMonoPanel" runat="server" DataSourceID="sdsBenchMonoPanel" DataTextField="BENCH_MONO_PANEL" DataValueField="BENCH_MONO_PANEL" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsBenchMonoPanel" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as BENCH_MONO_PANEL FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="BENCHMONOPANEL" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="RECLINER ACCENT">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlReclinerAccent" runat="server" DataSourceID="sdsReclinerAccent" DataTextField="RECLINER_ACCENT" DataValueField="RECLINER_ACCENT" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsReclinerAccent" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as RECLINER_ACCENT FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="RECLACCENT" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="RECLINER TOP STITCH">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlReclinerTopStitch" runat="server" DataSourceID="sdsReclinerTopStitch" DataTextField="RECLINER_TOP_STITCH" DataValueField="RECLINER_TOP_STITCH" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsReclinerTopStitch" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as RECLINER_TOP_STITCH FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="RECLTOPSTITCH" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="DIAMOND ACCENT">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlDiamondAccent" runat="server" DataSourceID="sdsDiamondAccent" DataTextField="DIAMOND_ACCENT" DataValueField="DIAMOND_ACCENT" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsDiamondAccent" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as DIAMOND_ACCENT FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="DIAMONDACCENT" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="DIAMOND THREAD">
                        <ItemTemplate>
                              <asp:DropDownList ID="ddlDiamondThread" runat="server" DataSourceID="sdsDiamondThread" DataTextField="Diamond_Thread" DataValueField="Diamond_Thread" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsDiamondThread" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Diamond_Thread FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="DIAMONDThread" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                                </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="X STITCH">
                        <ItemTemplate>
                              <asp:DropDownList ID="ddlXStitch" runat="server" DataSourceID="sdsXStitch" DataTextField="X_Stitch" DataValueField="X_Stitch" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsXStitch" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as X_Stitch FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="XStitch" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="BENCH IMG URL">
                        <ItemTemplate>
                            <asp:TextBox ID="tbBenchURL" runat="server" TextMode="MultiLine" Width="400px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="RECLINER IMG URL">
                        <ItemTemplate>
                            <asp:TextBox ID="tbReclinerURL" runat="server" TextMode="MultiLine" Width="400px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="NOTES">
                        <ItemTemplate>
                            <asp:TextBox ID="tbNotes" runat="server" TextMode="MultiLine" Width="400px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="CATALOG GROUP">
                       <ItemTemplate>
                            <asp:DropDownList ID="ddlGroups" runat="server" DataSourceID="sdsGroups" DataTextField="CATALOG_GROUP" DataValueField="CATALOG_GROUP" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsGroups" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as CATALOG_GROUP FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="CAT_GROUPS" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                       </ItemTemplate>
                   </asp:TemplateField>
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <asp:SqlDataSource ID="sdsFurnCombos" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [Furniture_Combinations] WHERE [MODEL_YEAR] = @MODEL_YEAR AND [SERIES_PART] = @SERIES_PART AND [BASE_VINYL_PART] = @BASE_VINYL_PART AND [PRIMARY_ACCENT_PART] = @PRIMARY_ACCENT_PART" InsertCommand="INSERT INTO [Furniture_Combinations] ([MODEL_YEAR], [CATALOG_PAGE], [SERIES], [SERIES_PART], [PRIMARY_BASE_VINYL], [BASE_VINYL_PART], [ACCENT], [PRIMARY_ACCENT_PART], [PATTERN], [ACCENT_2], [ACCENT_3], [LUMBAR], [LUMBAR_2], [TOP_STITCH], [SEAT_PAN_OVERLAY], [MONOGRAM], [MONOGRAM_2], [MONOGRAM_WING], [RECLINER_MONOGRAM], [RECLINER_MONOGRAM_2], [WELT_COLOR], [WELT_COLOR_2], [BENCH_MONO_PANEL], [RECLINER_ACCENT], [RECLINER_TOP_STITCH], [DIAMOND_ACCENT], [DIAMOND_THREAD], [X_STITCH], [BENCH_IMG_URL], [RECLINER_IMG_URL], [NOTES],[CATALOG_GROUP], [ADDED]) VALUES (@MODEL_YEAR, @CATALOG_PAGE, @SERIES, @SERIES_PART, @PRIMARY_BASE_VINYL, @BASE_VINYL_PART, @ACCENT, @PRIMARY_ACCENT_PART, @PATTERN, @ACCENT_2, @ACCENT_3, @LUMBAR, @LUMBAR_2, @TOP_STITCH, @SEAT_PAN_OVERLAY, @MONOGRAM, @MONOGRAM_2, @MONOGRAM_WING, @RECLINER_MONOGRAM, @RECLINER_MONOGRAM_2, @WELT_COLOR, @WELT_COLOR_2, @BENCH_MONO_PANEL, @RECLINER_ACCENT, @RECLINER_TOP_STITCH, @DIAMOND_ACCENT, @DIAMOND_THREAD, @X_STITCH, @BENCH_IMG_URL, @RECLINER_IMG_URL, @NOTES, @CATALOG_GROUP, @ADDED)" SelectCommand="SELECT * FROM [Furniture_Combinations]" UpdateCommand="UPDATE [Furniture_Combinations] SET [AUTO_ID] = @AUTO_ID, [CATALOG_PAGE] = @CATALOG_PAGE, [SERIES] = @SERIES, [PRIMARY_BASE_VINYL] = @PRIMARY_BASE_VINYL, [ACCENT] = @ACCENT, [PATTERN] = @PATTERN, [ACCENT_2] = @ACCENT_2, [ACCENT_3] = @ACCENT_3, [LUMBAR] = @LUMBAR, [LUMBAR_2] = @LUMBAR_2, [TOP_STITCH] = @TOP_STITCH, [SEAT_PAN_OVERLAY] = @SEAT_PAN_OVERLAY, [MONOGRAM] = @MONOGRAM, [MONOGRAM_2] = @MONOGRAM_2, [MONOGRAM_WING] = @MONOGRAM_WING, [RECLINER_MONOGRAM] = @RECLINER_MONOGRAM, [RECLINER_MONOGRAM_2] = @RECLINER_MONOGRAM_2, [WELT_COLOR] = @WELT_COLOR, [WELT_COLOR_2] = @WELT_COLOR_2, [BENCH_MONO_PANEL] = @BENCH_MONO_PANEL, [RECLINER_ACCENT] = @RECLINER_ACCENT, [RECLINER_TOP_STITCH] = @RECLINER_TOP_STITCH, [DIAMOND_ACCENT] = @DIAMOND_ACCENT, [DIAMOND_THREAD] = @DIAMOND_THREAD, [X_STITCH] = @X_STITCH, [BENCH_IMG_URL] = @BENCH_IMG_URL, [RECLINER_IMG_URL] = @RECLINER_IMG_URL, [NOTES] = @NOTES, [ADDED] = @ADDED WHERE [MODEL_YEAR] = @MODEL_YEAR AND [SERIES_PART] = @SERIES_PART AND [BASE_VINYL_PART] = @BASE_VINYL_PART AND [PRIMARY_ACCENT_PART] = @PRIMARY_ACCENT_PART">
                <DeleteParameters>
                    <asp:Parameter Name="MODEL_YEAR" Type="Int32" />
                    <asp:Parameter Name="SERIES_PART" Type="String" />
                    <asp:Parameter Name="BASE_VINYL_PART" Type="String" />
                    <asp:Parameter Name="PRIMARY_ACCENT_PART" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="MODEL_YEAR" Type="Int32" />
                    <asp:Parameter Name="CATALOG_PAGE" Type="Int32" />
                    <asp:Parameter Name="SERIES" Type="String" />
                    <asp:Parameter Name="SERIES_PART" Type="String" />
                    <asp:Parameter Name="PRIMARY_BASE_VINYL" Type="String" />
                    <asp:Parameter Name="BASE_VINYL_PART" Type="String" />
                    <asp:Parameter Name="ACCENT" Type="String" />
                    <asp:Parameter Name="PRIMARY_ACCENT_PART" Type="String" />
                    <asp:Parameter Name="PATTERN" Type="String" />
                    <asp:Parameter Name="ACCENT_2" Type="String" />
                    <asp:Parameter Name="ACCENT_3" Type="String" />
                    <asp:Parameter Name="LUMBAR" Type="String" />
                    <asp:Parameter Name="LUMBAR_2" Type="String" />
                    <asp:Parameter Name="TOP_STITCH" Type="String" />
                    <asp:Parameter Name="SEAT_PAN_OVERLAY" Type="String" />
                    <asp:Parameter Name="MONOGRAM" Type="String" />
                    <asp:Parameter Name="MONOGRAM_2" Type="String" />
                    <asp:Parameter Name="MONOGRAM_WING" Type="String" />
                    <asp:Parameter Name="RECLINER_MONOGRAM" Type="String" />
                    <asp:Parameter Name="RECLINER_MONOGRAM_2" Type="String" />
                    <asp:Parameter Name="WELT_COLOR" Type="String" />
                    <asp:Parameter Name="WELT_COLOR_2" Type="String" />
                    <asp:Parameter Name="BENCH_MONO_PANEL" Type="String" />
                    <asp:Parameter Name="RECLINER_ACCENT" Type="String" />
                    <asp:Parameter Name="RECLINER_TOP_STITCH" Type="String" />
                    <asp:Parameter Name="DIAMOND_ACCENT" Type="String" />
                    <asp:Parameter Name="DIAMOND_THREAD" Type="String" />
                    <asp:Parameter Name="X_STITCH" Type="String" />
                    <asp:Parameter Name="BENCH_IMG_URL" Type="String" />
                    <asp:Parameter Name="RECLINER_IMG_URL" Type="String" />
                    <asp:Parameter Name="NOTES" Type="String" />
                    <asp:Parameter Name="CATALOG_GROUP" Type="String" />
                    <asp:Parameter Name="ADDED" Type="DateTime" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="AUTO_ID" Type="Int32" />
                    <asp:Parameter Name="CATALOG_PAGE" Type="Int32" />
                    <asp:Parameter Name="SERIES" Type="String" />
                    <asp:Parameter Name="PRIMARY_BASE_VINYL" Type="String" />
                    <asp:Parameter Name="ACCENT" Type="String" />
                    <asp:Parameter Name="PATTERN" Type="String" />
                    <asp:Parameter Name="ACCENT_2" Type="String" />
                    <asp:Parameter Name="ACCENT_3" Type="String" />
                    <asp:Parameter Name="LUMBAR" Type="String" />
                    <asp:Parameter Name="LUMBAR_2" Type="String" />
                    <asp:Parameter Name="TOP_STITCH" Type="String" />
                    <asp:Parameter Name="SEAT_PAN_OVERLAY" Type="String" />
                    <asp:Parameter Name="MONOGRAM" Type="String" />
                    <asp:Parameter Name="MONOGRAM_2" Type="String" />
                    <asp:Parameter Name="MONOGRAM_WING" Type="String" />
                    <asp:Parameter Name="RECLINER_MONOGRAM" Type="String" />
                    <asp:Parameter Name="RECLINER_MONOGRAM_2" Type="String" />
                    <asp:Parameter Name="WELT_COLOR" Type="String" />
                    <asp:Parameter Name="WELT_COLOR_2" Type="String" />
                    <asp:Parameter Name="BENCH_MONO_PANEL" Type="String" />
                    <asp:Parameter Name="RECLINER_ACCENT" Type="String" />
                    <asp:Parameter Name="RECLINER_TOP_STITCH" Type="String" />
                    <asp:Parameter Name="DIAMOND_ACCENT" Type="String" />
                    <asp:Parameter Name="DIAMOND_THREAD" Type="String" />
                    <asp:Parameter Name="X_STITCH" Type="String" />
                    <asp:Parameter Name="BENCH_IMG_URL" Type="String" />
                    <asp:Parameter Name="RECLINER_IMG_URL" Type="String" />
                    <asp:Parameter Name="NOTES" Type="String" />
                    <asp:Parameter Name="MODEL_YEAR" Type="Int32" />
                    <asp:Parameter Name="SERIES_PART" Type="String" />
                    <asp:Parameter Name="BASE_VINYL_PART" Type="String" />
                    <asp:Parameter Name="PRIMARY_ACCENT_PART" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
