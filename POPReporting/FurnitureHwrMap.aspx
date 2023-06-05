<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureHwrMap.aspx.vb" Inherits="FurnitureHwrMap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture w/Hardware Delivery Map</title>
    <style>
        .area {
            text-align: center;
            vertical-align: Top;
            font-size: 15px;
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
            font-size: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
           
      
            <asp:Button ID="Button1" runat="server" Text="Button" Visible="False" />
                    <asp:Label runat="server" CssClass="title" Text="Furniture Hardware Map"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label1" runat="server" Text="# Marked Complete Today : " CssClass="title"></asp:Label><asp:Label ID="lblTodaysCount" runat="server" Text="" CssClass="title"></asp:Label>

                    <asp:DataList ID="dlHelms" CssClass="area" runat="server" DataSourceID="sdsHelms" RepeatDirection="Horizontal" SeparatorStyle-Height="15px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" Caption="HELMS" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" CssClass="subtitle" Text='<%# Eval("ProdNo") & " - " & Eval("ItemNo")%>'></asp:Label>
                            <asp:SqlDataSource ID="sdsVendorInfo" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT OrderLines.ProdNo, ItemNo,StockCode, PartStockCode,PartDesc,PartLineDesc,Color,BO_Flag,RGA_Flag,Qty,RcvdFlag,Job,HardwareReady,CASE When RCVDFlag = 0 Then '0' When RCVDFlag < Qty Then '1' When RCVDFlag = Qty Then '2' END as RCVDGraphic FROM OrderLines left join Live_Boats on OrderLines.ProdNo = Live_Boats.ProdNo WHERE (PartDesc Like '%RECL%' or PartDesc Like '%BASS SEAT%' or PartDesc Like '%BOW GATE BENCH%' or PartDesc Like '%OTTOMAN%' or PartDesc Like '%REFRESHMENT TABLE%' or PartDesc Like '%HELM SEAT%' ) AND OrderLines.ProdNo = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvOrderLines" runat="server" AutoGenerateColumns="False" BorderStyle="None" Width="400px" DataSourceID="sdsVendorInfo" ShowHeader="False">
                                <Columns>
                                    <asp:BoundField DataField="PartDesc" HeaderText="Part Desc"></asp:BoundField>
                                    <asp:BoundField DataField="Color" HeaderText="Color"></asp:BoundField>
                                    <asp:BoundField DataField="Qty" HeaderText="Qty">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>                                    
                                    <asp:TemplateField HeaderText="Ready">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnReady" runat="server" ImageUrl='<%# Eval("HardwareReady", "./Images/hwr_rdy{0}.png")%>' /><br />                                             
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <br>
                                <asp:ImageButton ID="btnOffline" runat="server" Visible='<%# IIf(Eval("IsBoatOffline") > 0, True, False) %>' ImageUrl='<%# Eval("IsBoatOffline", "./Images/boatstatus{0}.png")%>' />
                            <br></br>
                            <asp:Button ID="btnDone" runat="server" CommandArgument='<%# Eval("ProdNo") %>' CommandName="markdone" Text="Complete" />
                            </br>
                        </ItemTemplate>
                        <SeparatorStyle Height="15px" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsHelms" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, IsBoatOffline, FurnitureInstalled FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([HelmInstalledStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') And (FurnHwrDelStatus = 0) Order By FurnitureInstalled"></asp:SqlDataSource>


                    <asp:DataList ID="dlInspection" CssClass="area" runat="server" DataSourceID="sdsInspection" RepeatColumns="4" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="INSPECTION" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" CssClass="subtitle" Text='<%# Eval("ProdNo") & " - " & Eval("ItemNo")%>'></asp:Label>
                            <asp:SqlDataSource ID="sdsVendorInfo" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT OrderLines.ProdNo, ItemNo,StockCode, PartStockCode,PartDesc,PartLineDesc,Color,BO_Flag,RGA_Flag,Qty,RcvdFlag,Job,HardwareReady,CASE When RCVDFlag = 0 Then '0' When RCVDFlag < Qty Then '1' When RCVDFlag = Qty Then '2' END as RCVDGraphic FROM OrderLines left join Live_Boats on OrderLines.ProdNo = Live_Boats.ProdNo WHERE (PartDesc Like '%RECL%' or PartDesc Like '%BASS SEAT%' or PartDesc Like '%BOW GATE BENCH%' or PartDesc Like '%OTTOMAN%' or PartDesc Like '%REFRESHMENT TABLE%' or PartDesc Like '%HELM SEAT%' ) AND  OrderLines.ProdNo = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvOrderLines" runat="server" AutoGenerateColumns="False" BorderStyle="None" Width="400px" DataSourceID="sdsVendorInfo" ShowHeader="False">
                                <Columns>
                                    <asp:BoundField DataField="PartDesc" HeaderText="Part Desc"></asp:BoundField>
                                    <asp:BoundField DataField="Color" HeaderText="Color"></asp:BoundField>
                                    <asp:BoundField DataField="Qty" HeaderText="Qty">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Ready">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnReady" runat="server" ImageUrl='<%# Eval("HardwareReady", "./Images/hwr_rdy{0}.png")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                             <br>
                                    <asp:ImageButton ID="btnOffline" runat="server" Visible='<%# IIf(Eval("IsBoatOffline") > 0, True, False) %>' ImageUrl='<%# Eval("IsBoatOffline", "./Images/boatstatus{0}.png")%>' />
                             </br>
                            <asp:Button ID="btnDone1" runat="server" Text="Complete" CommandArgument='<%#Eval("ProdNo") %>' CommandName="markdone" />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsInspection" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, HelmInstalled FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([CleaningStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M') And (FurnHwrDelStatus = 0) Order By HelmInstalled"></asp:SqlDataSource>

                    <asp:DataList ID="dlFinal" CssClass="area" runat="server" DataSourceID="sdsFinal" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="FINAL INSPECTION" CellPadding="6" RepeatColumns="4">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" CssClass="subtitle" Text='<%# Eval("ProdNo") & " - " & Eval("ItemNo")%>'></asp:Label><br />
                            <asp:SqlDataSource ID="sdsVendorInfo" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT OrderLines.ProdNo, ItemNo,StockCode, PartStockCode,PartDesc,PartLineDesc,Color,BO_Flag,RGA_Flag,Qty,RcvdFlag,Job,HardwareReady,CASE When RCVDFlag = 0 Then '0' When RCVDFlag < Qty Then '1' When RCVDFlag = Qty Then '2' END as RCVDGraphic FROM OrderLines left join Live_Boats on OrderLines.ProdNo = Live_Boats.ProdNo WHERE (PartDesc Like '%RECL%' or PartDesc Like '%BASS SEAT%' or PartDesc Like '%BOW GATE BENCH%' or PartDesc Like '%OTTOMAN%' or PartDesc Like '%REFRESHMENT TABLE%' or PartDesc Like '%HELM SEAT%' ) AND  OrderLines.ProdNo = ?ProdNo">
                                <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvOrderLines" runat="server" AutoGenerateColumns="False" BorderStyle="None" Width="400px" DataSourceID="sdsVendorInfo" ShowHeader="False">
                                <Columns>
                                    <asp:BoundField DataField="PartDesc" HeaderText="Part Desc"></asp:BoundField>
                                    <asp:BoundField DataField="Color" HeaderText="Color"></asp:BoundField>
                                    <asp:BoundField DataField="Qty" HeaderText="Qty">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Ready">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnReady" runat="server" ImageUrl='<%# Eval("HardwareReady", "./Images/hwr_rdy{0}.png")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                             <br>
                                  <asp:ImageButton ID="btnOffline" runat="server" Visible='<%# IIf(Eval("IsBoatOffline") > 0, True, False) %>' ImageUrl='<%# Eval("IsBoatOffline", "./Images/boatstatus{0}.png")%>' />
                             </br>
                            <asp:Button ID="btnDone2" runat="server" Text="Complete" CommandArgument='<%#Eval("ProdNo") %>' CommandName="markdone" />
                        </ItemTemplate>
                        <SeparatorStyle Height="20px" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsFinal" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, Cleaning, IsBoatOffline FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([FinalInspectionStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M')  And (FurnHwrDelStatus = 0) Order By Cleaning"></asp:SqlDataSource>
                    </div>
    </form>
</body>
</html>

