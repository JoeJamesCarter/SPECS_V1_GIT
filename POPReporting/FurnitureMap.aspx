<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureMap.aspx.vb" Inherits="FurnitureMap" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture Map</title>
    <style>
        .area {
            text-align: center;
            vertical-align: central;
            font-size: 20px;
            font-family: Calibri;
            font-weight: bold;
        }

            .area caption {
                display: table-caption;
                text-align: left;
                color: blue;
            }

        .title {
            font-family: Calibri;
            font-weight: bold;
            font-size: 30px;
        }

        .subtitle {
            font-family: Calibri;
            font-weight: bold;
            font-size: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:Button ID="Button1" runat="server" Text="Button" Visible="False" />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                <ContentTemplate>
                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                    <asp:Label runat="server" CssClass="title" Text="Boats Online with Backorders or RGA's"></asp:Label>&nbsp;&nbsp;&nbsp;<asp:Label ID="Label1" CssClass="subtitle" runat="server" Text="Yellow = Open RGA, Orange = RGA Received and Not Yet Delivered to Line, Blue = Open Backorder Not Received Shows Veada's Current RGA Status of Received, Torn Down, Cut, Sewn, Loaded."></asp:Label>
                    <asp:DataList ID="dlFrames" CssClass="area" runat="server" DataSourceID="sdsFrames" RepeatColumns="20" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="FRAMES" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:GridView ID="gvRGAs" runat="server" DataSourceID="sdsRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="RGA_Item_Desc" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,RGA_Item_Desc,Qty,BenRcvd,DeliveredToLine,CASE When RGAs.Loaded = '1' Then 'Loaded' WHEN RGAs.Sewing = '1' Then 'Sewing' WHEN RGAs.Cutting = '1' Then 'Cutting' WHEN RGAs.Torn_Down = '1' Then 'Torn Down' END as VeadaStatus FROM RGAs WHERE (BenRcvd is Null or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                           <asp:GridView ID="gvIntRGAs" runat="server" DataSourceID="sdsIntRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvIntRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Part" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                           <asp:SqlDataSource ID="sdsIntRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="Select AutoID, ProdNo, Model, Part, Color, Qty, Reason, DamagedBy, Status, DateEntered, Resolved, DateResolved, DeliveredToLine, CASE When Resolved = '0' Then 'Not Started' WHEN Resolved = '1' Then 'In Progress' WHEN Resolved = '3' Then 'Needs Sent Back' WHEN Resolved = '2' Then 'Complete' END as VeadaStatus FROM InternalRGAs WHERE (DeliveredToLine is Null) and ProdNo = @ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvBOs" runat="server" DataSourceID="sdsBOs" AutoGenerateColumns="False" ShowHeader="False" CellPadding="2" CellSpacing="2" Width="200px" BorderColor="#3366FF" OnRowDataBound="gvBOs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="BO_Item_Desc" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,BO_Item_Desc,DeliveredToLine,Cleared FROM Backorders WHERE (Cleared = '0' or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsFrames" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([FramesInstalledStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlFloors" CssClass="area" runat="server" DataSourceID="sdsFloors" RepeatColumns="20" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="FLOORS" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:GridView ID="gvRGA" runat="server" DataSourceID="sdsRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="RGA_Item_Desc" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,RGA_Item_Desc,Qty,BenRcvd,DeliveredToLine,CASE When RGAs.Loaded = '1' Then 'Loaded' WHEN RGAs.Sewing = '1' Then 'Sewing' WHEN RGAs.Cutting = '1' Then 'Cutting' WHEN RGAs.Torn_Down = '1' Then 'Torn Down' END as VeadaStatus FROM RGAs WHERE (BenRcvd is Null or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                           <asp:GridView ID="gvIntRGAs" runat="server" DataSourceID="sdsIntRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvIntRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Part" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                           <asp:SqlDataSource ID="sdsIntRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="Select AutoID, ProdNo, Model, Part, Color, Qty, Reason, DamagedBy, Status, DateEntered, Resolved, DateResolved, DeliveredToLine, CASE When Resolved = '0' Then 'Not Started' WHEN Resolved = '1' Then 'In Progress' WHEN Resolved = '3' Then 'Needs Sent Back' WHEN Resolved = '2' Then 'Complete' END as VeadaStatus FROM InternalRGAs WHERE (DeliveredToLine is Null) and ProdNo = @ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvBOs" runat="server" DataSourceID="sdsBOs" AutoGenerateColumns="False" ShowHeader="False" CellPadding="2" CellSpacing="2" Width="200px" BorderColor="#3366FF" OnRowDataBound="gvBOs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="BO_Item_Desc" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,BO_Item_Desc,DeliveredToLine,Cleared FROM Backorders WHERE (Cleared = '0' or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsFloors" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([FloorsInstalledStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlRails" CssClass="area" runat="server" DataSourceID="sdsRails" RepeatColumns="20" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="RAILS" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:GridView ID="gvRGAs" runat="server" DataSourceID="sdsRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="RGA_Item_Desc" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,RGA_Item_Desc,Qty,BenRcvd,DeliveredToLine,CASE When RGAs.Loaded = '1' Then 'Loaded' WHEN RGAs.Sewing = '1' Then 'Sewing' WHEN RGAs.Cutting = '1' Then 'Cutting' WHEN RGAs.Torn_Down = '1' Then 'Torn Down' END as VeadaStatus FROM RGAs WHERE (BenRcvd is Null or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                           <asp:GridView ID="gvIntRGAs" runat="server" DataSourceID="sdsIntRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvIntRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Part" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                           <asp:SqlDataSource ID="sdsIntRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="Select AutoID, ProdNo, Model, Part, Color, Qty, Reason, DamagedBy, Status, DateEntered, Resolved, DateResolved, DeliveredToLine, CASE When Resolved = '0' Then 'Not Started' WHEN Resolved = '1' Then 'In Progress' WHEN Resolved = '3' Then 'Needs Sent Back' WHEN Resolved = '2' Then 'Complete' END as VeadaStatus FROM InternalRGAs WHERE (DeliveredToLine is Null) and ProdNo = @ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvBOs" runat="server" DataSourceID="sdsBOs" AutoGenerateColumns="False" ShowHeader="False" CellPadding="2" CellSpacing="2" Width="200px" BorderColor="#3366FF" OnRowDataBound="gvBOs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="BO_Item_Desc" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,BO_Item_Desc,DeliveredToLine,Cleared FROM Backorders WHERE (Cleared = '0' or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsRails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([RailsInstalledStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlFurniture" CssClass="area" runat="server" DataSourceID="sdsFurniture" RepeatColumns="20" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="FURNITURE" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:GridView ID="gvRGAs" runat="server" DataSourceID="sdsRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="RGA_Item_Desc" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,RGA_Item_Desc,Qty,BenRcvd,DeliveredToLine,CASE When RGAs.Loaded = '1' Then 'Loaded' WHEN RGAs.Sewing = '1' Then 'Sewing' WHEN RGAs.Cutting = '1' Then 'Cutting' WHEN RGAs.Torn_Down = '1' Then 'Torn Down' END as VeadaStatus FROM RGAs WHERE (BenRcvd is Null or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                           <asp:GridView ID="gvIntRGAs" runat="server" DataSourceID="sdsIntRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvIntRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Part" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                           <asp:SqlDataSource ID="sdsIntRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="Select AutoID, ProdNo, Model, Part, Color, Qty, Reason, DamagedBy, Status, DateEntered, Resolved, DateResolved, DeliveredToLine, CASE When Resolved = '0' Then 'Not Started' WHEN Resolved = '1' Then 'In Progress' WHEN Resolved = '3' Then 'Needs Sent Back' WHEN Resolved = '2' Then 'Complete' END as VeadaStatus FROM InternalRGAs WHERE (DeliveredToLine is Null) and ProdNo = @ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvBOs" runat="server" DataSourceID="sdsBOs" AutoGenerateColumns="False" ShowHeader="False" CellPadding="2" CellSpacing="2" Width="200px" BorderColor="#3366FF" OnRowDataBound="gvBOs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="BO_Item_Desc" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo, Color,Accent,BO_Item_Desc,DeliveredToLine, Cleared FROM Backorders WHERE (Cleared = '0' or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsFurniture" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([FurnitureInstalledStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlHelms" CssClass="area" runat="server" DataSourceID="sdsHelms" RepeatColumns="20" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="HELMS" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:GridView ID="gvRGAs" runat="server" DataSourceID="sdsRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="RGA_Item_Desc" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,RGA_Item_Desc,Qty,BenRcvd,DeliveredToLine,CASE When RGAs.Loaded = '1' Then 'Loaded' WHEN RGAs.Sewing = '1' Then 'Sewing' WHEN RGAs.Cutting = '1' Then 'Cutting' WHEN RGAs.Torn_Down = '1' Then 'Torn Down' END as VeadaStatus FROM RGAs WHERE (BenRcvd is Null or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                           <asp:GridView ID="gvIntRGAs" runat="server" DataSourceID="sdsIntRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvIntRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Part" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                           <asp:SqlDataSource ID="sdsIntRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="Select AutoID, ProdNo, Model, Part, Color, Qty, Reason, DamagedBy, Status, DateEntered, Resolved, DateResolved, DeliveredToLine, CASE When Resolved = '0' Then 'Not Started' WHEN Resolved = '1' Then 'In Progress' WHEN Resolved = '3' Then 'Needs Sent Back' WHEN Resolved = '2' Then 'Complete' END as VeadaStatus FROM InternalRGAs WHERE (DeliveredToLine is Null) and ProdNo = @ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvBOs" runat="server" DataSourceID="sdsBOs" AutoGenerateColumns="False" ShowHeader="False" CellPadding="2" CellSpacing="2" Width="200px" BorderColor="#3366FF" OnRowDataBound="gvBOs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="BO_Item_Desc" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,BO_Item_Desc,DeliveredToLine,Cleared FROM Backorders WHERE (Cleared = '0' or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsHelms" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([HelmInstalledStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') Order By ProdNo"></asp:SqlDataSource>


                    <asp:DataList ID="dlInspection" CssClass="area" runat="server" DataSourceID="sdsInspection" RepeatColumns="20" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="INSPECTION" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:GridView ID="gvRGAs" runat="server" DataSourceID="sdsRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="RGA_Item_Desc" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,RGA_Item_Desc,Qty,BenRcvd,DeliveredToLine,CASE When RGAs.Loaded = '1' Then 'Loaded' WHEN RGAs.Sewing = '1' Then 'Sewing' WHEN RGAs.Cutting = '1' Then 'Cutting' WHEN RGAs.Torn_Down = '1' Then 'Torn Down' END as VeadaStatus FROM RGAs WHERE (BenRcvd is Null or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvIntRGAs" runat="server" DataSourceID="sdsIntRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvIntRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Part" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                           <asp:SqlDataSource ID="sdsIntRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="Select AutoID, ProdNo, Model, Part, Color, Qty, Reason, DamagedBy, Status, DateEntered, Resolved, DateResolved, DeliveredToLine, CASE When Resolved = '0' Then 'Not Started' WHEN Resolved = '1' Then 'In Progress' WHEN Resolved = '3' Then 'Needs Sent Back' WHEN Resolved = '2' Then 'Complete' END as VeadaStatus FROM InternalRGAs WHERE (DeliveredToLine is Null) and ProdNo = @ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvBOs" runat="server" DataSourceID="sdsBOs" AutoGenerateColumns="False" ShowHeader="False" CellPadding="2" CellSpacing="2" Width="200px" BorderColor="#3366FF" OnRowDataBound="gvBOs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="BO_Item_Desc" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,BO_Item_Desc,DeliveredToLine,Cleared FROM Backorders WHERE (Cleared = '0' or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsInspection" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CleaningStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([CleaningStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlFinal" CssClass="area" runat="server" DataSourceID="sdsFinal" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="FINAL INSPECTION" CellPadding="6" RepeatColumns="20">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label><br />
                            <asp:GridView ID="gvRGAs" runat="server" DataSourceID="sdsRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="RGA_Item_Desc" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo,Color,Accent,RGA_Item_Desc,Qty,BenRcvd,DeliveredToLine,CASE When RGAs.Loaded = '1' Then 'Loaded' WHEN RGAs.Sewing = '1' Then 'Sewing' WHEN RGAs.Cutting = '1' Then 'Cutting' WHEN RGAs.Torn_Down = '1' Then 'Torn Down' END as VeadaStatus FROM RGAs WHERE (BenRcvd is Null or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvIntRGAs" runat="server" DataSourceID="sdsIntRGAs" AutoGenerateColumns="False" ShowHeader="False" Width="200px" OnRowDataBound="gvIntRGAs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Part" />
                                    <asp:BoundField DataField="VeadaStatus" />
                                </Columns>
                            </asp:GridView>
                           <asp:SqlDataSource ID="sdsIntRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="Select AutoID, ProdNo, Model, Part, Color, Qty, Reason, DamagedBy, Status, DateEntered, Resolved, DateResolved, DeliveredToLine, CASE When Resolved = '0' Then 'Not Started' WHEN Resolved = '1' Then 'In Progress' WHEN Resolved = '3' Then 'Needs Sent Back' WHEN Resolved = '2' Then 'Complete' END as VeadaStatus FROM InternalRGAs WHERE (DeliveredToLine is Null) and ProdNo = @ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvBOs" runat="server" DataSourceID="sdsBOs" AutoGenerateColumns="False" ShowHeader="False" CellPadding="2" CellSpacing="2" Width="200px" BorderColor="#3366FF" OnRowDataBound="gvBOs_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="BO_Item_Desc" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT ProdNo, Color,Accent,BO_Item_Desc,DeliveredToLine, Cleared FROM Backorders WHERE (Cleared = 0 or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                        <SeparatorStyle Height="20px" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsFinal" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([FinalInspectionStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlShrink" CssClass="area" runat="server" DataSourceID="sdsShrink" RepeatColumns="20" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="SHRINKWRAP" Visible="False">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsShrink" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([ShrinkwrapStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlRigging" CssClass="area" runat="server" DataSourceID="sdsRigging" RepeatColumns="20" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="RIGGING" Visible="False">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotodetails" />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsRigging" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.RiggingStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([RiggingStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlWavetamer" CssClass="area" runat="server" DataSourceID="sdsWavetamer" RepeatColumns="20" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="WAVETAMER" Visible="False">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotodetails" />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsWavetamer" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([WavetamerStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlSharkhide" CssClass="area" runat="server" DataSourceID="sdsSharkhide" RepeatColumns="20" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="SHARKHIDE" Visible="False">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotodetails" />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsSharkhide" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([SharkhideStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') Order By ProdNo"></asp:SqlDataSource>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
    </form>
</body>
</html>


