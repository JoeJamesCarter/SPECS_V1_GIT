<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FGRepairTV.aspx.vb" Inherits="FGRepairTV" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="scripts/css/bootstrap.min.css" />
    <link href="scripts/css/toastr.css" rel="stylesheet" />
    <script src="scripts/jquery-3.5.0.min.js"></script>
    <script src="scripts/bootstrap.min.js"></script>
    <script src="scripts/toastr.min.js"></script>
    <title>FG Repair Priority</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
                 <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div>
                        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                        <div class="w-100 display-1 font-weight-bold text-center text-primary p-2">Fiberglass Repair Priority Order</div>
                        <div class="w-100 display-3 font-weight-bold text-center text-secondary p-2">Inspected and Ready for Repair</div>
                        <div id="Main" class="w-50 float-left display-1  h-100 ">
                            <asp:Label class="float-left display-1 w-100 pl-4 bg-dark text-light text-center" runat="server">MAIN</asp:Label>
                            <table class="w-100">
                                <tr>
                                    <td class="w-50">
                                        <asp:Label ID="lblMainPri1" class="display-1 text-dark p-1 font-weight-bold float-left" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'M' - Furniture Green - (Has All Rails or Rails Pulled and/or Paneled)" runat="server">Priority #1</asp:Label>
                                    </td>
                                    <td>
                                        <asp:GridView ID="gvMain1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatsMFurnGreen" GridLines="None">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="ButtonM1" CssClass="display-1 font-weight-bold text-primary" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoStartRepair" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BaseVinylColor" />

                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>

                            <table class="w-100">
                                <tr>
                                    <td class="w-50">
                                        <asp:Label ID="lblMainPri2" class="display-1 text-dark float-left p-1 font-weight-bold" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'M' - Furniture Yellow - (Has All Rails or Rails Pulled and/or Paneled)" runat="server">Priority #2</asp:Label></td>
                                    <td>

                                        <asp:GridView ID="gvMain2" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatsMFurnYellow" GridLines="None">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="ButtonM1" CssClass="display-1 font-weight-bold text-primary" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoStartRepair" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BaseVinylColor" />

                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>

                            <table class="w-100">
                                <tr>
                                    <td class="w-50">
                                        <asp:Label ID="lblMainPri3" class="display-1 text-dark float-left p-1 font-weight-bold" ToolTip="Furniture Red, but Veada shows Shipped" runat="server">Priority #3</asp:Label></td>
                                    <td>

                                        <asp:GridView ID="gvMain3" runat="server" AutoGenerateColumns="False" GridLines="None">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="ButtonM1" CssClass="display-1 font-weight-bold text-primary" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoStartRepair" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BaseVinylColor" />                                                

                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>

                            <table class="w-100">
                                <tr>
                                    <td class="w-50">
                                        <asp:Label ID="lblMainPri4" class="display-1 text-dark float-left p-1 font-weight-bold" ToolTip="Has All Rails, But Furniture is Red and Not Shipped." runat="server">Priority #4</asp:Label></td>
                                    <td>

                                        <asp:GridView ID="gvMain4" runat="server" AutoGenerateColumns="False" GridLines="None">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="ButtonM1" CssClass="display-1 font-weight-bold text-primary" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoStartRepair" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BaseVinylColor" />

                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>

                            <table class="w-100">
                                <tr>
                                    <td class="w-50">
                                        <asp:Label ID="lblMainPri5" class="display-1 text-dark float-left p-1 font-weight-bold" ToolTip="Missing Some or All Rails" runat="server">Priority #5</asp:Label></td>
                                    <td>

                                        <asp:GridView ID="gvMain5" runat="server" AutoGenerateColumns="False" GridLines="None">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="ButtonM1" CssClass="display-1 font-weight-bold text-primary" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoStartRepair" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BaseVinylColor" />

                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div id="South" class="float-left display-4 w-50">
                            <asp:Label class="display-1 w-100 float-left pl-4 bg-dark text-light text-center" runat="server">SOUTH</asp:Label>

                            <table class="w-100">
                                <tr>
                                    <td class="w-50">
                                        <asp:Label ID="lblSouthPri1" class="display-1 text-dark w-100 p-1 text-center font-weight-bold" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'S' - Furniture Green - (Has All Rails or Rails Pulled and/or Paneled)" runat="server">Priority #1</asp:Label></td>
                                    <td>

                                        <asp:GridView ID="gvSouth1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatsSFurnGreen" GridLines="None">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="ButtonM1" CssClass="display-1 font-weight-bold text-primary" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoStartRepair" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BaseVinylColor" />

                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>

                            <table class="w-100">
                                <tr>
                                    <td class="w-50">
                                        <asp:Label ID="lblSouthPri2" class="display-1 text-dark w-100 p-1 text-center font-weight-bold" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'S' - Furniture Yellow - (Has All Rails or Rails Pulled and/or Paneled) - Canvas is at least yellow - Framing/Flooring/Trim Complete" runat="server">Priority #2</asp:Label></td>
                                    <td>

                                        <asp:GridView ID="gvSouth2" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatsSFurnYellow" GridLines="None">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="ButtonM1" CssClass="display-1 font-weight-bold text-primary" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoStartRepair" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BaseVinylColor" />

                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>

                            <table class="w-100">
                                <tr>
                                    <td class="w-50">
                                        <asp:Label ID="lblSouthPri3" class="display-1 text-dark w-100 p-1 text-center font-weight-bold" ToolTip="Furniture Red, but Veada shows Shipped" runat="server">Priority #3</asp:Label></td>
                                    <td>

                                        <asp:GridView ID="gvSouth3" runat="server" AutoGenerateColumns="False" GridLines="None">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="ButtonM1" CssClass="display-1 font-weight-bold text-primary" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoStartRepair" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BaseVinylColor" />

                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>

                            <table class="w-100">
                                <tr>
                                    <td class="w-50">
                                        <asp:Label ID="lblSouthPri4" class="display-1 text-dark w-100 p-1 text-center font-weight-bold" ToolTip="Has All Rails, But Furniture is Red and Not Shipped." runat="server">Priority #4</asp:Label></td>
                                    <td>

                                        <asp:GridView ID="gvSouth4" runat="server" AutoGenerateColumns="False" GridLines="None">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="ButtonM1" CssClass="display-1 font-weight-bold text-primary" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoStartRepair" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BaseVinylColor" />

                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>

                            <table class="w-100">
                                <tr>
                                    <td class="w-50">
                                        <asp:Label ID="lblSouthPri5" class="display-1 text-dark w-100 p-1 text-center font-weight-bold" ToolTip="Missing Some or All Rails" runat="server">Priority #5</asp:Label><br />
                                    </td>
                                    <td>

                                        <asp:GridView ID="gvSouth5" runat="server" AutoGenerateColumns="False" GridLines="None">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="ButtonM1" CssClass="display-1 font-weight-bold text-primary" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoStartRepair" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BaseVinylColor" />

                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>

                        </div>



                        <asp:SqlDataSource ID="sdsBoatsMFurnGreen" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT  t1.ProdNo, Substring(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor  FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 3 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'M' and FurnitureStatus = 2 and (HasAllRails = 1 or RailsStatus > 0) and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsBoatsSFurnGreen" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT  t1.ProdNo, SubString(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor  FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 3 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'S' and FurnitureStatus = 2 and (HasAllRails = 1 or RailsStatus > 0) and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsBoatsMFurnYellow" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo, Substring(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor  FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 3 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'M' and FurnitureStatus = 1 and (HasAllRails = 1 or RailsStatus > 0) and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsBoatsSFurnYellow" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo, SubString(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor  FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 3 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'S' and FurnitureStatus = 1 and (HasAllRails = 1 or RailsStatus > 0) and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>
                </ContentTemplate>

            </asp:UpdatePanel>
        </div>







    </form>
</body>
</html>
