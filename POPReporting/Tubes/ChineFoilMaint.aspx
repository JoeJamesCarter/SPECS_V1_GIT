<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ChineFoilMaint.aspx.vb" Inherits="Tubes_ChineFoilMaint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CHINE/FOIL DAILY SCHEDULE DATASOURCE MAINTENANCE</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>

        #stocksizes {
            width:650px;
            float:left;
        }

        #configs {
            float:left;
        }

         #addconfig {
             float:left;
            width: 350px;            
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="stocksizes">
            <asp:Label ID="Label1" runat="server" Text="Add A New Stock Size" CssClass="newStyle7"></asp:Label>
            <asp:DetailsView ID="dvStockSizes" runat="server" Height="159px" Width="308px" AutoGenerateRows="False" DataKeyNames="AutoID" DataSourceID="sdsStockSizes" DefaultMode="Insert" CssClass="newStyle1">
                <Fields>
                    <asp:BoundField DataField="AutoID" HeaderText="AutoID" InsertVisible="False" ReadOnly="True" SortExpression="AutoID" />
                    <asp:BoundField DataField="StockLength" HeaderText="StockLength" SortExpression="StockLength" />
                    <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                    <asp:BoundField DataField="ChineOrFoil" HeaderText="ChineOrFoil" SortExpression="ChineOrFoil" />
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Edit Existing Stock Sizes" CssClass="newStyle7"></asp:Label>
            <asp:GridView ID="gvEditStockSizes" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AutoID" DataSourceID="sdsStockSizes" Width="578px" CssClass="newStyle1">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="AutoID" HeaderText="AutoID" InsertVisible="False" ReadOnly="True" SortExpression="AutoID" />
                    <asp:BoundField DataField="StockLength" HeaderText="StockLength" SortExpression="StockLength" />
                    <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                    <asp:BoundField DataField="ChineOrFoil" HeaderText="ChineOrFoil" SortExpression="ChineOrFoil" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsStockSizes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [Tubes_ChineFoilStockSizes] WHERE [AutoID] = @AutoID" InsertCommand="INSERT INTO [Tubes_ChineFoilStockSizes] ([StockLength], [Type], [ChineOrFoil]) VALUES (@StockLength, @Type, @ChineOrFoil)" SelectCommand="SELECT * FROM [Tubes_ChineFoilStockSizes] ORDER BY [StockLength], [ChineOrFoil], [Type]" UpdateCommand="UPDATE [Tubes_ChineFoilStockSizes] SET [StockLength] = @StockLength, [Type] = @Type, [ChineOrFoil] = @ChineOrFoil WHERE [AutoID] = @AutoID">
                <DeleteParameters>
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="StockLength" Type="Int32" />
                    <asp:Parameter Name="Type" Type="String" />
                    <asp:Parameter Name="ChineOrFoil" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="StockLength" Type="Int32" />
                    <asp:Parameter Name="Type" Type="String" />
                    <asp:Parameter Name="ChineOrFoil" Type="String" />
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        <div id="addconfig">
 <asp:Label ID="Label3" runat="server" Text="Add New Config" CssClass="newStyle7"></asp:Label>
            <asp:DetailsView ID="dvConfigs" runat="server" Height="50px" Width="281px" AutoGenerateRows="False" CssClass="newStyle1" DataKeyNames="BoatWidth,TubeLength,Config,Perf,IO" DataSourceID="sdsConfigs" DefaultMode="Insert">
                <Fields>
                    <asp:BoundField DataField="BoatWidth" HeaderText="BoatWidth" ReadOnly="True" SortExpression="BoatWidth" />
                    <asp:BoundField DataField="TubeLength" HeaderText="TubeLength" ReadOnly="True" SortExpression="TubeLength" />
                    <asp:BoundField DataField="TubeLengthJustFt" HeaderText="TubeLengthJustFt" SortExpression="TubeLengthJustFt" />
                    <asp:BoundField DataField="Config" HeaderText="Config" ReadOnly="True" SortExpression="Config" />
                    <asp:BoundField DataField="NumTubes" HeaderText="NumTubes" SortExpression="NumTubes" />
                    <asp:BoundField DataField="Perf" HeaderText="Perf" ReadOnly="True" SortExpression="Perf" />
                    <asp:BoundField DataField="IO" HeaderText="IO" ReadOnly="True" SortExpression="IO" />
                    <asp:BoundField DataField="UpsweptChines" HeaderText="UpsweptChines" SortExpression="UpsweptChines" />
                    <asp:BoundField DataField="CtrChinesLength" HeaderText="CtrChinesLength" SortExpression="CtrChinesLength" />
                    <asp:BoundField DataField="OtrsInnerLength" HeaderText="OtrsInnerLength" SortExpression="OtrsInnerLength" />
                    <asp:BoundField DataField="OtrsInnerType" HeaderText="OtrsInnerType" SortExpression="OtrsInnerType" />
                    <asp:BoundField DataField="OtrsOuter" HeaderText="OtrsOuter" SortExpression="OtrsOuter" />
                    <asp:BoundField DataField="OtrsOuterType" HeaderText="OtrsOuterType" SortExpression="OtrsOuterType" />
                    <asp:BoundField DataField="TenWide" HeaderText="TenWide" SortExpression="TenWide" />
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
        </div>
        <div id="configs">           
            
            <asp:Label ID="Label4" runat="server" Text="Edit Existing Chine/Foil Configs" CssClass="newStyle7"></asp:Label>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="BoatWidth,TubeLength,Config,Perf,IO" DataSourceID="sdsConfigs">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="BoatWidth" HeaderText="BoatWidth" ReadOnly="True" SortExpression="BoatWidth" />
                    <asp:BoundField DataField="TubeLength" HeaderText="TubeLength" ReadOnly="True" SortExpression="TubeLength" />
                    <asp:BoundField DataField="TubeLengthJustFt" HeaderText="TubeLengthJustFt" SortExpression="TubeLengthJustFt" />
                    <asp:BoundField DataField="Config" HeaderText="Config" ReadOnly="True" SortExpression="Config" />
                    <asp:BoundField DataField="NumTubes" HeaderText="NumTubes" SortExpression="NumTubes" />
                    <asp:BoundField DataField="Perf" HeaderText="Perf" ReadOnly="True" SortExpression="Perf" />
                    <asp:BoundField DataField="IO" HeaderText="IO" ReadOnly="True" SortExpression="IO" />
                    <asp:BoundField DataField="UpsweptChines" HeaderText="UpsweptChines" SortExpression="UpsweptChines" />
                    <asp:BoundField DataField="CtrChinesLength" HeaderText="CtrChinesLength" SortExpression="CtrChinesLength" />
                    <asp:BoundField DataField="OtrsInnerLength" HeaderText="OtrsInnerLength" SortExpression="OtrsInnerLength" />
                    <asp:BoundField DataField="OtrsInnerType" HeaderText="OtrsInnerType" SortExpression="OtrsInnerType" />
                    <asp:BoundField DataField="OtrsOuter" HeaderText="OtrsOuter" SortExpression="OtrsOuter" />
                    <asp:BoundField DataField="OtrsOuterType" HeaderText="OtrsOuterType" SortExpression="OtrsOuterType" />
                    <asp:BoundField DataField="TenWide" HeaderText="TenWide" SortExpression="TenWide" />
                </Columns>
            </asp:GridView>
            <br />
            <asp:SqlDataSource ID="sdsConfigs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [Tubes_ChinesFoilsConfigs] WHERE [BoatWidth] = @BoatWidth AND [TubeLength] = @TubeLength AND [Config] = @Config AND [Perf] = @Perf AND [IO] = @IO" InsertCommand="INSERT INTO [Tubes_ChinesFoilsConfigs] ([BoatWidth], [TubeLength], [TubeLengthJustFt], [Config], [NumTubes], [Perf], [IO], [UpsweptChines], [CtrChinesLength], [OtrsInnerLength], [OtrsInnerType], [OtrsOuter], [OtrsOuterType], [TenWide]) VALUES (@BoatWidth, @TubeLength, @TubeLengthJustFt, @Config, @NumTubes, @Perf, @IO, @UpsweptChines, @CtrChinesLength, @OtrsInnerLength, @OtrsInnerType, @OtrsOuter, @OtrsOuterType, @TenWide)" SelectCommand="SELECT * FROM [Tubes_ChinesFoilsConfigs] ORDER BY [TubeLength]" UpdateCommand="UPDATE [Tubes_ChinesFoilsConfigs] SET [TubeLengthJustFt] = @TubeLengthJustFt, [NumTubes] = @NumTubes, [UpsweptChines] = @UpsweptChines, [CtrChinesLength] = @CtrChinesLength, [OtrsInnerLength] = @OtrsInnerLength, [OtrsInnerType] = @OtrsInnerType, [OtrsOuter] = @OtrsOuter, [OtrsOuterType] = @OtrsOuterType, [TenWide] = @TenWide WHERE [BoatWidth] = @BoatWidth AND [TubeLength] = @TubeLength AND [Config] = @Config AND [Perf] = @Perf AND [IO] = @IO">
                <DeleteParameters>
                    <asp:Parameter Name="BoatWidth" Type="Double" />
                    <asp:Parameter Name="TubeLength" Type="String" />
                    <asp:Parameter Name="Config" Type="String" />
                    <asp:Parameter Name="Perf" Type="String" />
                    <asp:Parameter Name="IO" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="BoatWidth" Type="Double" />
                    <asp:Parameter Name="TubeLength" Type="String" />
                    <asp:Parameter Name="TubeLengthJustFt" Type="String" />
                    <asp:Parameter Name="Config" Type="String" />
                    <asp:Parameter Name="NumTubes" Type="Int32" />
                    <asp:Parameter Name="Perf" Type="String" />
                    <asp:Parameter Name="IO" Type="Int32" />
                    <asp:Parameter Name="UpsweptChines" Type="Int32" />
                    <asp:Parameter Name="CtrChinesLength" Type="String" />
                    <asp:Parameter Name="OtrsInnerLength" Type="String" />
                    <asp:Parameter Name="OtrsInnerType" Type="String" />
                    <asp:Parameter Name="OtrsOuter" Type="String" />
                    <asp:Parameter Name="OtrsOuterType" Type="String" />
                    <asp:Parameter Name="TenWide" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="TubeLengthJustFt" Type="String" />
                    <asp:Parameter Name="NumTubes" Type="Int32" />
                    <asp:Parameter Name="UpsweptChines" Type="Int32" />
                    <asp:Parameter Name="CtrChinesLength" Type="String" />
                    <asp:Parameter Name="OtrsInnerLength" Type="String" />
                    <asp:Parameter Name="OtrsInnerType" Type="String" />
                    <asp:Parameter Name="OtrsOuter" Type="String" />
                    <asp:Parameter Name="OtrsOuterType" Type="String" />
                    <asp:Parameter Name="TenWide" Type="String" />
                    <asp:Parameter Name="BoatWidth" Type="Double" />
                    <asp:Parameter Name="TubeLength" Type="String" />
                    <asp:Parameter Name="Config" Type="String" />
                    <asp:Parameter Name="Perf" Type="String" />
                    <asp:Parameter Name="IO" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
