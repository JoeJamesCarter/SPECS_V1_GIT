<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureSelectionsMaint.aspx.vb" Inherits="FurnitureCatalog_FurnitureSelectionsMaint" Debug="True" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture Catalog Selections Maintenance</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body class="newStyle1">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="FURNITURE CATALOG SELECTION MAINTENANCE" CssClass="newStyle7"></asp:Label>
            <br />
            <hr />
            <br />
            <asp:SqlDataSource ID="sdsAddSelection" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [Furniture_Catalog_Descs] WHERE [MODEL_YEAR] = @MODEL_YEAR AND [MACOLA_PART] = @MACOLA_PART AND [CATALOG_DESC] = @CATALOG_DESC" InsertCommand="INSERT INTO [Furniture_Catalog_Descs] ([MODEL_YEAR], [MACOLA_PART], [MACOLA_PART_2], [SERIES], [CATALOG_DESC], [PART_TYPE]) VALUES (@MODEL_YEAR, @MACOLA_PART, @MACOLA_PART_2, @SERIES, @CATALOG_DESC, @PART_TYPE)" SelectCommand="SELECT * FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE)" UpdateCommand="UPDATE [Furniture_Catalog_Descs] SET [MACOLA_PART_2] = @MACOLA_PART_2, [SERIES] = @SERIES, [BOAT_WIDTH] = @BOAT_WIDTH, [PART_TYPE] = @PART_TYPE WHERE [MODEL_YEAR] = @MODEL_YEAR AND [MACOLA_PART] = @MACOLA_PART AND [CATALOG_DESC] = @CATALOG_DESC">
                <DeleteParameters>
                    <asp:Parameter Name="MODEL_YEAR" Type="Int32" />
                    <asp:Parameter Name="MACOLA_PART" Type="Int32" />
                    <asp:Parameter Name="CATALOG_DESC" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="MODEL_YEAR" Type="Int32" />
                    <asp:Parameter Name="MACOLA_PART" Type="Int32" />
                    <asp:Parameter Name="MACOLA_PART_2" Type="Int32" />
                    <asp:Parameter Name="SERIES" Type="String" />
                    <asp:Parameter Name="CATALOG_DESC" Type="String" />
                    <asp:Parameter Name="PART_TYPE" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlPartTypeFilter" Name="PART_TYPE" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="MACOLA_PART_2" Type="Int32" />
                    <asp:Parameter Name="SERIES" Type="String" />
                    <asp:Parameter Name="BOAT_WIDTH" Type="Int32" />
                    <asp:Parameter Name="PART_TYPE" Type="String" />
                    <asp:Parameter Name="MODEL_YEAR" Type="Int32" />
                    <asp:Parameter Name="MACOLA_PART" Type="Int32" />
                    <asp:Parameter Name="CATALOG_DESC" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="Label6" runat="server" Text="INSERT NEW DROPDOWN OPTIONS" CssClass="newStyle7"></asp:Label><br /><br />
            <asp:DetailsView ID="dvInsertSelection" runat="server" Height="50px" Width="634px" AutoGenerateRows="False" DataKeyNames="MODEL_YEAR,MACOLA_PART,CATALOG_DESC" DataSourceID="sdsAddSelection" DefaultMode="Insert" CssClass="newStyle1">
                <Fields>
                    <asp:TemplateField HeaderText="Model Year">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlModelYearInsert" runat="server" Enabled="True" AutoPostBack="True">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>21</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DropDown Type">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlTypes" runat="server" DataSourceID="sdsTypes" DataTextField="PART_TYPE" DataValueField="PART_TYPE" AppendDataBoundItems="True" AutoPostBack="true" OnSelectedIndexChanged="ddlTypes_SelectedIndexChanged">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsTypes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(PART_TYPE) FROM [Furniture_Catalog_Descs] WHERE (MODEL_YEAR = @MODEL_YEAR) ORDER BY [PART_TYPE]">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlModelYearInsert" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MACOLA PART">
                        <ItemTemplate>
                            <asp:TextBox ID="tbMacolaPartInsert" runat="server"></asp:TextBox>
                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="MACOLA PART 2 (Use for Type = FUR when same image repesents 2 part #'s, 10 wide and 8.5).">
                        <ItemTemplate>
                            <asp:TextBox ID="tbMacolaPart2Insert" runat="server"></asp:TextBox>
                        </ItemTemplate>

                    </asp:TemplateField>



                    <asp:TemplateField HeaderText="Series (Only Used for Type = FUR)">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlSeries0" runat="server" DataSourceID="sdsSeries0" DataTextField="SERIES" DataValueField="SERIES" AppendDataBoundItems="False">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsSeries0" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT DISTINCT(SERIES) FROM [Furniture_Catalog_Descs] WHERE ([PART_TYPE] = @PART_TYPE) AND (MODEL_YEAR = @MODEL_YEAR) ORDER BY [SERIES]">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlTypes" Name="PART_TYPE" PropertyName="SelectedValue" Type="String" />
                                    <asp:ControlParameter ControlID="ddlModelYearInsert" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText ="Catalog Desc">
                        <ItemTemplate>
                            <asp:TextBox ID="tbCatalogDesc" runat="server"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <br />
            <hr />
            <br />
            <asp:Label ID="Label5" runat="server" Text="MODIFY/DELETE EXISTING DROPDOWN OPTIONS" CssClass="newStyle7"></asp:Label><br /><br />
            <asp:Label ID="Label3" runat="server" Text="Model Year : " CssClass="newStyle6"></asp:Label>
            <asp:DropDownList ID="ddlModelYear" runat="server" Enabled="True" AutoPostBack="True">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem>20</asp:ListItem>
                <asp:ListItem>21</asp:ListItem>
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;<asp:Label ID="Label4" runat="server" Text="Selection Type : " CssClass="newStyle6"></asp:Label>
            <asp:DropDownList ID="ddlPartTypeFilter" runat="server" DataSourceID="sdsSelectionTypesFilter" DataTextField="PART_TYPE" DataValueField="PART_TYPE" AppendDataBoundItems="True" AutoPostBack="True">
                <asp:ListItem>

                </asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsSelectionTypesFilter" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct(PART_TYPE) FROM [Furniture_Catalog_Descs] ORDER BY [PART_TYPE]"></asp:SqlDataSource>
            <br />
            <br />
            
            <asp:GridView ID="gvPrimaryBV" runat="server" DataSourceID="sdsFurnitureCatalogDescBV" AutoGenerateColumns="False" CssClass="newStyle1">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:TemplateField HeaderText="Macola Part #">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#Eval("MACOLA_PART") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tbMacolaPart" runat="server" Text='<%# Bind("MACOLA_PART") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Macola Secondary Part #">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#Eval("MACOLA_PART_2") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tbMacolaPart2" runat="server" Text='<%# Bind("MACOLA_PART_2") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Series">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#Eval("SERIES") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlSeries" runat="server" DataSourceID="sdsSeries" DataTextField="SERIES" DataValueField="SERIES" AppendDataBoundItems="True" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsSeries" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct(SERIES) FROM [Furniture_Catalog_Descs] Where SERIES is not Null ORDER BY [SERIES]"></asp:SqlDataSource>
                        </EditItemTemplate>

                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Boat Width">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#Eval("BOAT_WIDTH") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tbBoatWidth" runat="server" Text='<%# Bind("BOAT_WIDTH") %>'></asp:TextBox>
                        </EditItemTemplate>

                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Catalog Desc">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#Eval("CATALOG_DESC") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tbCatalogDesc" runat="server" Text='<%# Bind("CATALOG_DESC") %>'></asp:TextBox>
                        </EditItemTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Type">
                        <ItemTemplate>
                            <asp:Label ID="lblPartTypeRO" runat="server" Text='<%#Eval("PART_TYPE") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlPartTypes" runat="server" DataSourceID="sdsSelectionTypes" DataTextField="PART_TYPE" DataValueField="PART_TYPE" AppendDataBoundItems="True" SelectedValue='<%# Eval("PART_TYPE") %>'>
                                <asp:ListItem>

                                </asp:ListItem>
                            </asp:DropDownList>

                        </EditItemTemplate>

                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <br />
            <asp:SqlDataSource ID="sdsFurnitureCatalogDescBV" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [Furniture_Catalog_Descs] WHERE [MACOLA_PART] = @MACOLA_PART AND [CATALOG_DESC] = @CATALOG_DESC" InsertCommand="INSERT INTO [Furniture_Catalog_Descs] ([MACOLA_PART], [SERIES], [CATALOG_DESC], [PART_TYPE]) VALUES (@MACOLA_PART, @SERIES, @CATALOG_DESC, @PART_TYPE)" SelectCommand="SELECT * FROM [Furniture_Catalog_Descs] Where PART_TYPE = @PART_TYPE and MODEL_YEAR = @MODEL_YEAR ORDER BY [CATALOG_DESC] " UpdateCommand="UPDATE [Furniture_Catalog_Descs] SET [SERIES] = @SERIES, [PART_TYPE] = @PART_TYPE WHERE [MACOLA_PART] = @MACOLA_PART AND [CATALOG_DESC] = @CATALOG_DESC">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="ddlPartTypeFilter" Name="PART_TYPE" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="MACOLA_PART" Type="Int32" />
                    <asp:Parameter Name="CATALOG_DESC" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="MODEL_YEAR" Type="Int32" />
                    <asp:Parameter Name="MACOLA_PART" Type="Int32" />
                    <asp:Parameter Name="SERIES" Type="String" />
                    <asp:Parameter Name="CATALOG_DESC" Type="String" />
                    <asp:Parameter Name="PART_TYPE" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SERIES" Type="String" />
                    <asp:Parameter Name="PART_TYPE" Type="String" />
                    <asp:Parameter Name="MACOLA_PART" Type="Int32" />
                    <asp:Parameter Name="CATALOG_DESC" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsSelectionTypes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct(PART_TYPE) FROM [Furniture_Catalog_Descs] ORDER BY [PART_TYPE]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
