<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CatalogMaint.aspx.vb" Inherits="FurnitureCatalog_CatalogMaint" Debug="true" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture Catalog Maintenance</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lblTitle" runat="server" Text="FURNITURE CATALOG MAINTENANCE" CssClass="newStyle7"></asp:Label>&nbsp;
            <asp:Label ID="Label3" runat="server" Text="FILTERS" CssClass="newStyle6"></asp:Label>
            <asp:Label ID="Label1" runat="server" Text="Model Year : " CssClass="newStyle1"></asp:Label>
            <asp:DropDownList ID="ddlModelYearFilter" runat="server" Enabled="True" AutoPostBack="True">
                <asp:ListItem>21</asp:ListItem>
                <asp:ListItem>20</asp:ListItem>                
            </asp:DropDownList>
            <asp:Label ID="Label2" runat="server" Text="Series : " CssClass="newStyle1"></asp:Label><asp:DropDownList ID="ddlSeriesFilter" runat="server" DataSourceID="sdsSeriesFilter" DataTextField="SERIES" DataValueField="SERIES" AutoPostBack="true" AppendDataBoundItems="true">
                <asp:ListItem></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsSeriesFilter" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(SERIES) FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) ORDER BY [SERIES]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="FUR" Name="PART_TYPE" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnAddNew" runat="server" Text="Add New Lines" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnModDropDowns" runat="server" Text="Modify Drop Down Selections" />
            <asp:GridView ID="gvFurnCatalog2" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="sdsFurnCatalog" CssClass="newStyle1" Width="100%" DataKeyNames="AUTO_ID">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:TemplateField HeaderText="Model Year" SortExpression="MODEL_YEAR">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlModelYear" runat="server" SelectedValue='<%#Eval("MODEL_YEAR")%>' Enabled="False">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>21</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblModelYear" runat="server" Text='<%#Eval("Model_Year") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Catalog Pg" SortExpression="CATALOG_PAGE">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbCatalogPg" runat="server" Text='<%#Eval("CATALOG_PAGE") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblCatalogPg" runat="server" Text='<%#Eval("CATALOG_PAGE") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Series" SortExpression="SERIES">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlSeries" runat="server" SelectedValue='<%# Eval("SERIES") %>' DataSourceID="sdsSeries" DataTextField="SERIES" DataValueField="SERIES" OnSelectedIndexChanged="ddlSeries_SelectedIndexChanged" AutoPostBack="true" AppendDataBoundItems="False">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsSeries" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(SERIES) FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY [SERIES]">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="FUR" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblSeries" runat="server" Text='<%#Eval("SERIES") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Furniture Style" SortExpression="PATTERN_DESC">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlPatterns" runat="server" DataSourceID="sdsPatterns" DataTextField="PATTERN" DataValueField="SERIES_PART" AppendDataBoundItems="False" AutoPostBack="True" OnSelectedIndexChanged="ddlPatterns_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsPatterns" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [MACOLA_PART] as SERIES_PART, [SERIES], [CATALOG_DESC] as PATTERN FROM [Furniture_Catalog_Descs] WHERE (([PART_TYPE] = @PART_TYPE) AND ([SERIES] = @SERIES) AND (MODEL_YEAR = @MODEL_YEAR)) ORDER BY [SERIES]">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="FUR" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlSeries" Name="SERIES" PropertyName="SelectedValue" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblFurnStyle" runat="server" Text='<%#Eval("PATTERN_DESC") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Furniture Part" SortExpression="SERIES_PART">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbFurniturePart" runat="server" Text='<%#Eval("SERIES_PART") %>' Enabled="false"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblFurnPart" runat="server" Text='<%#Eval("SERIES_PART") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Base Vinyl" SortExpression="BASE_VINYL_DESC">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlBaseVinyl" runat="server" DataSourceID="sdsBVs" DataTextField="PRIMARY_BASE_VINYL" DataValueField="BASE_VINYL_PART" SelectedValue='<%# Eval("BASE_VINYL_PART") %>' AutoPostBack="True" OnSelectedIndexChanged="ddlBaseVinyl_SelectedIndexChanged">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsBVs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT CATALOG_DESC as PRIMARY_BASE_VINYL, MACOLA_PART as BASE_VINYL_PART FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY [CATALOG_DESC]">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="BV" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblBV" runat="server" Text='<%# Eval("BASE_VINYL_DESC") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Base Vinyl Part" SortExpression="BASE_VINYL_PART">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbBVPart" runat="server" Text='<%#Eval("BASE_VINYL_PART") %>' Enabled="false"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblBVPart" runat="server" Text='<%#Eval("BASE_VINYL_PART") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Accent" SortExpression="ACCENT_DESC">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlIntAccents" runat="server" DataSourceID="sdsIAs" DataTextField="ACCENT" DataValueField="PRIMARY_ACCENT_PART" SelectedValue='<%# Eval("PRIMARY_ACCENT_PART") %>' OnSelectedIndexChanged="ddlIntAccents_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                            <asp:SqlDataSource ID="sdsIAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as ACCENT, MACOLA_PART as PRIMARY_ACCENT_PART FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="ACC" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblAccent" runat="server" Text='<%#Eval("ACCENT_DESC") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Accent Part" SortExpression="PRIMARY_ACCENT_PART">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbAccentPart" runat="server" Text='<%#Eval("PRIMARY_ACCENT_PART") %>' Enabled="false"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblAccentPart" runat="server" Text='<%#Eval("PRIMARY_ACCENT_PART") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Accent 2" SortExpression="ACCENT_2">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlAcc2" runat="server" DataSourceID="sdsAcc2" DataTextField="ACCENT_2" DataValueField="ACCENT_2" SelectedValue='<%# Eval("ACCENT_2") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsAcc2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as ACCENT_2 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="ACC2" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblAccent2" runat="server" Text='<%#Eval("ACCENT_2") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Accent 3" SortExpression="ACCENT_3">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlAcc3" runat="server" DataSourceID="sdsAcc3" DataTextField="ACCENT_3" DataValueField="ACCENT_3" SelectedValue='<%# Eval("ACCENT_3") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsAcc3" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as ACCENT_3 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="ACC3" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblAccent3" runat="server" Text='<%#Eval("ACCENT_3") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Lumbar" SortExpression="LUMBAR">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlLumbar" runat="server" DataSourceID="sdsLumbar" DataTextField="LUMBAR" DataValueField="LUMBAR" SelectedValue='<%# Eval("LUMBAR") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsLumbar" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as LUMBAR FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="LUM" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblLumbar" runat="server" Text='<%#Eval("LUMBAR") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Lumbar 2" SortExpression="LUMBAR_22">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlLumbar2" runat="server" DataSourceID="sdsLumbar2" DataTextField="LUMBAR_2" DataValueField="LUMBAR_2" SelectedValue='<%# Eval("LUMBAR_2") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsLumbar2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as LUMBAR_2 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="LUM2" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblLumbar2" runat="server" Text='<%#Eval("LUMBAR_2") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Top Stitch" SortExpression="TOP_STITCH">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlTopStitch" runat="server" DataSourceID="sdsTopStitch" DataTextField="TOP_STITCH" DataValueField="TOP_STITCH" SelectedValue='<%# Eval("TOP_STITCH") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsTopStitch" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as TOP_STITCH FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="TOPSTITCH" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblTopStitch" runat="server" Text='<%#Eval("TOP_STITCH") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Seat Pan Overlay" SortExpression="SEAT_PAN_OVERLAY">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlSeatPanOverlay" runat="server" DataSourceID="sdsSeatPanOverlay" DataTextField="SEAT_PAN_OVERLAY" DataValueField="SEAT_PAN_OVERLAY" SelectedValue='<%# Eval("SEAT_PAN_OVERLAY") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsSeatPanOverlay" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as SEAT_PAN_OVERLAY FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="SEATPANOVERLAY" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblSeatPanOverlay" runat="server" Text='<%#Eval("SEAT_PAN_OVERLAY") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Monogram" SortExpression="MONOGRAM">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlMonogram" runat="server" DataSourceID="sdsMonogram" DataTextField="Monogram" DataValueField="Monogram" SelectedValue='<%# Eval("Monogram") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsMonogram" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Monogram FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="MONOGRAM" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblMonogram" runat="server" Text='<%#Eval("MONOGRAM") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Monogram 2" SortExpression="MONOGRAM_2">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlMonogram2" runat="server" DataSourceID="sdsMonogram2" DataTextField="Monogram_2" DataValueField="Monogram_2" SelectedValue='<%# Eval("Monogram_2") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsMonogram2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Monogram_2 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="MONOGRAM2" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblMonogram2" runat="server" Text='<%#Eval("MONOGRAM_2") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Monogram Wing" SortExpression="MONOGRAM_WING">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlMonogramWing" runat="server" DataSourceID="sdsMonogramWing" DataTextField="Monogram_Wing" DataValueField="Monogram_Wing" SelectedValue='<%# Eval("Monogram_Wing") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsMonogramWing" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Monogram_Wing FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="MONOGRAMWING" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblMonogramWing" runat="server" Text='<%#Eval("MONOGRAM_WING") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Recliner Monogram" SortExpression="RECLINER_MONOGRAM">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlRecliner_Monogram" runat="server" DataSourceID="sdsRecliner_Monogram" DataTextField="Recliner_Monogram" DataValueField="Recliner_Monogram" SelectedValue='<%# Eval("Recliner_Monogram") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsRecliner_Monogram" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Recliner_Monogram FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="RECLMONOGRAM" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblReclMonogram" runat="server" Text='<%#Eval("Recliner_Monogram") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Recliner Monogram 2" SortExpression="RECLINER_MONOGRAM_2">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlRecliner_Monogram2" runat="server" DataSourceID="sdsRecliner_Monogram2" DataTextField="Recliner_Monogram_2" DataValueField="Recliner_Monogram_2" SelectedValue='<%# Eval("Recliner_Monogram_2") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsRecliner_Monogram2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Recliner_Monogram_2 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="RECLMONOGRAM" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblReclMonogram2" runat="server" Text='<%#Eval("Recliner_Monogram_2") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Welt" SortExpression="WELT_COLOR">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlWelt_Color" runat="server" DataSourceID="sdsWelt_Color" DataTextField="Welt_Color" DataValueField="Welt_Color" SelectedValue='<%# Eval("Welt_Color") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsWelt_Color" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Welt_Color FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="WELT" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblWelt" runat="server" Text='<%#Eval("Welt_Color") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Welt 2" SortExpression="WELT_COLOR_2">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlWelt_Color2" runat="server" DataSourceID="sdsWelt_Color2" DataTextField="Welt_Color_2" DataValueField="Welt_Color_2" SelectedValue='<%# Eval("Welt_Color_2") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsWelt_Color2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Welt_Color_2 FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="WELT2" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblWelt2" runat="server" Text='<%#Eval("Welt_Color_2") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Bench Mono Panel" SortExpression="BENCH_MONO_PANEL">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlBenchMonoPanel" runat="server" DataSourceID="sdsBenchMonoPanel" DataTextField="BENCH_MONO_PANEL" DataValueField="BENCH_MONO_PANEL" SelectedValue='<%# Eval("BENCH_MONO_PANEL") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsBenchMonoPanel" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as BENCH_MONO_PANEL FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="BENCHMONOPANEL" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblBenchMonoPanel" runat="server" Text='<%#Eval("BENCH_MONO_PANEL") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Recliner Accent" SortExpression="RECLINER_ACCENT">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlReclinerAccent" runat="server" DataSourceID="sdsReclinerAccent" DataTextField="RECLINER_ACCENT" DataValueField="RECLINER_ACCENT" SelectedValue='<%# Eval("RECLINER_ACCENT") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsReclinerAccent" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as RECLINER_ACCENT FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="RECLACCENT" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblReclAccent" runat="server" Text='<%#Eval("RECLINER_ACCENT") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Recliner TopStitch" SortExpression="RECLINER_TOP_STITCH">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlReclinerTopStitch" runat="server" DataSourceID="sdsReclinerTopStitch" DataTextField="RECLINER_TOP_STITCH" DataValueField="RECLINER_TOP_STITCH" SelectedValue='<%# Eval("RECLINER_TOP_STITCH") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsReclinerTopStitch" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as RECLINER_TOP_STITCH FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="RECLTOPSTITCH" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblReclinerTopStitch" runat="server" Text='<%#Eval("RECLINER_TOP_STITCH") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Diamond Accent" SortExpression="DIAMOND_ACCENT">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlDiamondAccent" runat="server" DataSourceID="sdsDiamondAccent" DataTextField="DIAMOND_ACCENT" DataValueField="DIAMOND_ACCENT" SelectedValue='<%# Eval("DIAMOND_ACCENT") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsDiamondAccent" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as DIAMOND_ACCENT FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="DIAMONDACCENT" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblDiamondAccent" runat="server" Text='<%#Eval("DIAMOND_ACCENT") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Diamond Thread" SortExpression="DIAMOND_THREAD">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlDiamondThread" runat="server" DataSourceID="sdsDiamondThread" DataTextField="Diamond_Thread" DataValueField="Diamond_Thread" SelectedValue='<%# Eval("Diamond_Thread") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsDiamondThread" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as Diamond_Thread FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="DIAMONDThread" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblDiamondThread" runat="server" Text='<%#Eval("Diamond_Thread") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="X Stitch" SortExpression="X_STITCH">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlXStitch" runat="server" DataSourceID="sdsXStitch" DataTextField="X_Stitch" DataValueField="X_Stitch" SelectedValue='<%# Eval("X_Stitch") %>' AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsXStitch" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as X_Stitch FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="XStitch" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblXStitch" runat="server" Text='<%#Eval("X_Stitch") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Notes">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbNotes" runat="server" Text='<%#Eval("NOTES") %>' TextMode="MultiLine" Width="300px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="tbNotesRO" runat="server" Text='<%#Eval("NOTES") %>' TextMode="MultiLine" Width="300px" Enabled="false"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bench Image URL">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbBenchURL" Text='<%#Eval("BENCH_IMG_URL") %>' runat="server" TextMode="MultiLine" Height="80px" Width="200px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="tbBenchURL" Text='<%#Eval("BENCH_IMG_URL") %>' runat="server" TextMode="MultiLine" Height="80px" Width="200px" Enabled="false"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Recliner Image URL">
                        <EditItemTemplate>
                            <asp:TextBox ID="tbReclinerUrl" Text='<%#Eval("RECLINER_IMG_URL") %>' runat="server" TextMode="MultiLine" Height="80px" Width="200px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="tbReclinerUrl" Text='<%#Eval("RECLINER_IMG_URL") %>' runat="server" TextMode="MultiLine" Height="80px" Width="200px" Enabled="false"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CATALOG GROUP" SortExpression="CATALOG_GROUP">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlGroups" runat="server" DataSourceID="sdsGroups" DataTextField="CATALOG_GROUP" DataValueField="CATALOG_GROUP" SelectedValue='<%# Eval("CATALOG_GROUP") %>' AppendDataBoundItems="True">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsGroups" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(CATALOG_DESC) as CATALOG_GROUP FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY CATALOG_DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="CAT_GROUPS" Name="PART_TYPE" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblCatGroup" runat="server" Text='<%#Eval("CATALOG_GROUP") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

            </asp:GridView>

            <br />
            <asp:SqlDataSource ID="sdsFurnCatalog" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [Furniture_Combinations] WHERE [AUTO_ID] = @AUTO_ID" InsertCommand="INSERT INTO [Furniture_Combinations] ([MODEL_YEAR], [CATALOG_PAGE], [SERIES], [SERIES_PART], [PRIMARY_BASE_VINYL], [BASE_VINYL_PART], [ACCENT], [PRIMARY_ACCENT_PART], [PATTERN], [ACCENT_2], [ACCENT_3], [LUMBAR], [LUMBAR_2], [TOP_STITCH], [SEAT_PAN_OVERLAY], [MONOGRAM], [MONOGRAM_2], [MONOGRAM_WING], [RECLINER_MONOGRAM], [RECLINER_MONOGRAM_2], [WELT_COLOR], [WELT_COLOR_2], [BENCH_MONO_PANEL], [RECLINER_ACCENT], [RECLINER_TOP_STITCH], [DIAMOND_ACCENT], [DIAMOND_THREAD], [X_STITCH], [BENCH_IMG_URL], [RECLINER_IMG_URL]) VALUES (@MODEL_YEAR, @CATALOG_PAGE, @SERIES, @SERIES_PART, @PRIMARY_BASE_VINYL, @BASE_VINYL_PART, @ACCENT, @PRIMARY_ACCENT_PART, @PATTERN, @ACCENT_2, @ACCENT_3, @LUMBAR, @LUMBAR_2, @TOP_STITCH, @SEAT_PAN_OVERLAY, @MONOGRAM, @MONOGRAM_2, @MONOGRAM_WING, @RECLINER_MONOGRAM, @RECLINER_MONOGRAM_2, @WELT_COLOR, @WELT_COLOR_2, @BENCH_MONO_PANEL, @RECLINER_ACCENT, @RECLINER_TOP_STITCH, @DIAMOND_ACCENT, @DIAMOND_THREAD, @X_STITCH, @BENCH_IMG_URL, @RECLINER_IMG_URL)" SelectCommand="SELECT p1.*, p2.MACOLA_PART as BASE_VINYL_PART, p3.MACOLA_PART as PRIMARY_ACCENT_PART, p2.CATALOG_DESC as BASE_VINYL_DESC, p3.CATALOG_DESC as ACCENT_DESC, p4.CATALOG_DESC as PATTERN_DESC, p4.MACOLA_PART as SERIES_PART FROM Furniture_Combinations as p1 Left Join Furniture_Catalog_Descs as p2 on p2.MACOLA_PART = p1.BASE_VINYL_PART and p2.PART_TYPE = 'BV' Left Join Furniture_Catalog_Descs as p3 on p3.MACOLA_PART = p1.PRIMARY_ACCENT_PART and p3.PART_TYPE = 'ACC' Left Join Furniture_Catalog_Descs as p4 on (p4.MACOLA_PART = p1.SERIES_PART and p4.Series = p1.SERIES) and p4.PART_TYPE = 'FUR' Where (p1.SERIES Like @SERIESFILTER and p1.MODEL_YEAR like @MYFILTER) ORDER BY [SERIES]" UpdateCommand="UPDATE [Furniture_Combinations] SET [MODEL_YEAR] = @MODEL_YEAR, [CATALOG_PAGE] = @CATALOG_PAGE, [SERIES] = @SERIES, [SERIES_PART] = @SERIES_PART, [PRIMARY_BASE_VINYL] = @PRIMARY_BASE_VINYL, [BASE_VINYL_PART] = @BASE_VINYL_PART, [ACCENT] = @ACCENT, [PRIMARY_ACCENT_PART] = @PRIMARY_ACCENT_PART, [PATTERN] = @PATTERN, [ACCENT_2] = @ACCENT_2, [ACCENT_3] = @ACCENT_3, [LUMBAR] = @LUMBAR, [LUMBAR_2] = @LUMBAR_2, [TOP_STITCH] = @TOP_STITCH, [SEAT_PAN_OVERLAY] = @SEAT_PAN_OVERLAY, [MONOGRAM] = @MONOGRAM, [MONOGRAM_2] = @MONOGRAM_2, [MONOGRAM_WING] = @MONOGRAM_WING, [RECLINER_MONOGRAM] = @RECLINER_MONOGRAM, [RECLINER_MONOGRAM_2] = @RECLINER_MONOGRAM_2, [WELT_COLOR] = @WELT_COLOR, [WELT_COLOR_2] = @WELT_COLOR_2, [BENCH_MONO_PANEL] = @BENCH_MONO_PANEL, [RECLINER_ACCENT] = @RECLINER_ACCENT, [RECLINER_TOP_STITCH] = @RECLINER_TOP_STITCH, [DIAMOND_ACCENT] = @DIAMOND_ACCENT, [DIAMOND_THREAD] = @DIAMOND_THREAD, [X_STITCH] = @X_STITCH, [BENCH_IMG_URL] = @BENCH_IMG_URL, [RECLINER_IMG_URL] = @RECLINER_IMG_URL, [NOTES] = @NOTES, [CATALOG_GROUP] = @CATALOG_GROUP WHERE [AUTO_ID] = @AUTO_ID">
                <DeleteParameters>
                    <asp:Parameter Name="AUTO_ID" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlSeriesFilter" Name="SERIESFILTER" PropertyName="SelectedValue" Type="String" DefaultValue="%" />
                    <asp:ControlParameter ControlID="ddlModelYearFilter" Name="MYFILTER" PropertyName="SelectedValue" Type="String" DefaultValue="%" />
                </SelectParameters>
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
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="AUTO_ID" Type="Int32" />
                    <asp:Parameter Name="MODEL_YEAR" Type="Int32" />
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
                    <asp:Parameter Name="SERIES_PART" Type="String" />
                    <asp:Parameter Name="BASE_VINYL_PART" Type="String" />
                    <asp:Parameter Name="PRIMARY_ACCENT_PART" Type="String" />
                    <asp:Parameter Name="NOTES" Type="String" />
                    <asp:Parameter Name="CATALOG_GROUP" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
