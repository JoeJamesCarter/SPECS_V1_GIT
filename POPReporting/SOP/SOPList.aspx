<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SOPList.aspx.vb" Inherits="SOP_SOPList" Debug="True"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SOP List</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body class="newStyle1">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Available SOP's"></asp:Label>
            <br />
            <asp:DetailsView ID="dvSOPs" runat="server" Height="50px" Width="368px" AutoGenerateRows="False" CssClass="newStyle1" DataKeyNames="SOP_ID" DataSourceID="sdsSOP" DefaultMode="Insert">
                <Fields>
                    <asp:BoundField DataField="SOP_ID" HeaderText="SOP_ID" InsertVisible="False" ReadOnly="True" SortExpression="SOP_ID" />
                    <asp:BoundField DataField="ModelYear" HeaderText="ModelYear" SortExpression="ModelYear" />
                    <asp:BoundField DataField="Series" HeaderText="Series" SortExpression="Series" />
                    <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
                    <asp:BoundField DataField="SeriesModel" HeaderText="SeriesModel" SortExpression="SeriesModel" />
                    <asp:BoundField DataField="DrawingNo" HeaderText="DrawingNo" SortExpression="DrawingNo" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:BoundField DataField="PartNo" HeaderText="PartNo" SortExpression="PartNo" />
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <br />
            <asp:GridView ID="gvSOPs" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="SOP_ID" DataSourceID="sdsSOP">
                <Columns>
                    <asp:CommandField ShowEditButton="True" />
                    <asp:BoundField DataField="SOP_ID" HeaderText="SOP_ID" InsertVisible="False" ReadOnly="True" SortExpression="SOP_ID" />
                    <asp:BoundField DataField="ModelYear" HeaderText="ModelYear" SortExpression="ModelYear" />
                    <asp:BoundField DataField="Series" HeaderText="Series" SortExpression="Series" />
                    <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
                    <asp:BoundField DataField="SeriesModel" HeaderText="SeriesModel" SortExpression="SeriesModel" />
                    <asp:BoundField DataField="DrawingNo" HeaderText="DrawingNo" SortExpression="DrawingNo" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:BoundField DataField="PartNo" HeaderText="PartNo" SortExpression="PartNo" />
                    <asp:TemplateField HeaderText="Edit">
                        <ItemTemplate>
                            <asp:Button ID="btnEditDetails" runat="server" Text="Edit SO Kit/Tools/Instructions"  CommandArgument='<%# Eval("SOP_ID")%>' CommandName = "gotoeditsop" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>                  

            <asp:SqlDataSource ID="sdsSOP" runat="server" ConnectionString="<%$ ConnectionStrings:SOPConnectionString %>"  DeleteCommand="DELETE FROM [SOP_Log] WHERE [SOP_ID] = @original_SOP_ID" InsertCommand="INSERT INTO [SOP_Log] ([ModelYear], [Series], [Model], [SeriesModel], [DrawingNo], [Description], [PartNo]) VALUES (@ModelYear, @Series, @Model, @SeriesModel, @DrawingNo, @Description, @PartNo)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [SOP_Log] ORDER BY [SOP_ID]" UpdateCommand="UPDATE [SOP_Log] SET [ModelYear] = @ModelYear, [Series] = @Series, [Model] = @Model, [SeriesModel] = @SeriesModel, [DrawingNo] = @DrawingNo, [Description] = @Description, [PartNo] = @PartNo WHERE [SOP_ID] = @original_SOP_ID">
                <DeleteParameters>
                    <asp:Parameter Name="original_SOP_ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ModelYear" Type="Int32" />
                    <asp:Parameter Name="Series" Type="String" />
                    <asp:Parameter Name="Model" Type="String" />
                    <asp:Parameter Name="SeriesModel" Type="String" />
                    <asp:Parameter Name="DrawingNo" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="PartNo" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ModelYear" Type="Int32" />
                    <asp:Parameter Name="Series" Type="String" />
                    <asp:Parameter Name="Model" Type="String" />
                    <asp:Parameter Name="SeriesModel" Type="String" />
                    <asp:Parameter Name="DrawingNo" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="PartNo" Type="String" />
                    <asp:Parameter Name="original_SOP_ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

          

        </div>
    </form>
</body>
</html>
