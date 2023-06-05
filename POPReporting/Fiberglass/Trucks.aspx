<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Trucks.aspx.vb" Inherits="Fiberglass_Trucks" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="../scripts/css/bootstrap.min.css" />
    <link href="../scripts/css/toastr.css" rel="stylesheet" />
    <script src="../scripts/jquery-3.5.0.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
    <script src="../scripts/toastr.min.js"></script>
    <title>FG Trucks</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        .fgcolor {
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container ml-2">
            <div class="row w-100">
                <%--<asp:Button Text="Receiving" BorderStyle="None" CssClass="btn btn-sm btn-dark m-2" ID="rcv" runat="server" Visible="False" />--%>
                <asp:Button Text="Inspection" BorderStyle="None" CssClass="btn btm-sm btn-dark m-2" ID="insp" runat="server" />
                <asp:Button Text="Repair" BorderStyle="None" CssClass="btn btm-sm btn-dark m-2" ID="rpr" runat="server" />
                <asp:Button Text="Shipping" BorderStyle="None" CssClass="btn btm-sm btn-dark m-2" ID="ship" runat="server" />
                <asp:Button Text="Ship History" BorderStyle="None" CssClass="btn btm-sm btn-dark m-2" ID="shiphistory" runat="server" />
                <%-- <asp:Button Text="Loading" BorderStyle="None" CssClass="btn btn-sm btn-dark m-2" ID="loading" runat="server" />--%>
            </div>
            <div class="row">
                <asp:MultiView ID="MainView" runat="server">
                    <asp:View runat="server" ID="View1">
                        <div class="container ml-2">
                            <div class="row w-100 h4 text-center">
                                <asp:Label ID="Label3" CssClass="bg-dark text-light w-100 p-2" runat="server" Text="FG Receiving - Up to 3 at a time"></asp:Label><br />
                            </div>
                            <div class="row w-100">
                                <asp:Label ID="Label5" runat="server" CssClass="h5 ml-2" Text="# Received Today:"></asp:Label><asp:Label ID="lblRcvdToday" CssClass="h5 ml-2 text-primary" runat="server" Text="Count Here"></asp:Label>
                            </div>
                            <div class="row w-100 mt-2 mb-1">
                                <asp:Label ID="Label6" runat="server" CssClass="h5 ml-4" Text="Full Prod # (7 Digits):"></asp:Label><asp:TextBox ID="tbProdNo1" CssClass="ml-4" runat="server"></asp:TextBox>
                            </div>
                            <div class="row w-100">
                                <asp:Label ID="Label14" runat="server" CssClass="h5 ml-4" Text="Full Prod # (7 Digits):"></asp:Label><asp:TextBox ID="tbProdNo2" CssClass="ml-4" runat="server"></asp:TextBox>
                            </div>
                            <div class="row w-100">
                                <asp:Label ID="Label18" runat="server" CssClass="h5 ml-4" Text="Full Prod # (7 Digits):"></asp:Label><asp:TextBox ID="tbProdNo3" CssClass="ml-4" runat="server"></asp:TextBox>
                            </div>
                            <div class="row w-100 ml-2 mt-4">
                                <asp:Button ID="btnRcv" runat="server" Text="Receive" />
                                <hr />
                            </div>
                            <div class="row w-100">
                                <asp:Label ID="Label7" CssClass="h5 ml-4 mt-4" runat="server" Text="Lastest Activity"></asp:Label>
                            </div>
                            <div class="row w-100">
                                <asp:GridView ID="gvLast10Rcvd" runat="server" DataSourceID="sdsFGRcvd" AutoGenerateColumns="true" Width="300px"></asp:GridView>
                                <asp:SqlDataSource ID="sdsFGRcvd" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [BaseVinylColor] as Color FROM [BML_POPREPORTING_GREENLIGHTS] WHERE [FiberglassStatus] = @FiberglassStatus AND Convert(Date,FiberglassLastUpdated) = convert(varchar(10), getdate(), 102) ORDER BY [FiberglassLastUpdated] DESC">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="2" Name="FiberglassStatus" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </div>
                    </asp:View>

                    <asp:View runat="server" ID="View2">
                        <div class="container">
                            <div class="row w-100 h4 text-center">
                                <asp:Label ID="Label2" CssClass="bg-dark text-light w-100 p-1" runat="server" Text="Deliver to FG Inspection"></asp:Label><br />
                            </div>
                            <div class="row">
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <div class="w-50 col float-left">
                                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>

                                    <div>
                                        <asp:Label class="text-dark ml-2 p-2 font-weight-bold" runat="server">MAIN</asp:Label>
                                    </div>


                                    <div class="p-1 item-hl ">
                                        <asp:Label class=" bg-dark text-light p-2" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'M' - Furniture Green - (Has All Rails or Rails Pulled and/or Paneled) - Canvas is at least yellow" runat="server">Priority #1</asp:Label><br />
                                        <br />
                                        <asp:Repeater ID="MainPri1" runat="server" DataSourceID="sdsBoatsMFurnGreen">
                                            <ItemTemplate>
                                                <table border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="ButtonM1" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                            -
                                                <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>
                                                            -
                                                <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                                        </td>

                                                    </tr>
                                                </table>


                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>


                                    <div class="p-1 item-hl ">
                                        <asp:Label class=" bg-dark text-light p-2" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'M' - Furniture Yellow - (Has All Rails or Rails Pulled and/or Paneled) - Canvas is at least yellow" runat="server">Priority #2</asp:Label><br />
                                        <br />
                                        <asp:Repeater ID="MainPri2" runat="server" DataSourceID="sdsBoatsMFurnYellow">
                                            <ItemTemplate>
                                                <table border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="ButtonM2" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                            -
                                                <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>
                                                            -
                                                <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                                        </td>

                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                    </div>

                                    <div class="p-1 item-hl ">
                                        <asp:Label class=" bg-dark text-light p-2" ToolTip="Furniture Red, but Veada shows Shipped" runat="server">Priority #3</asp:Label><br />
                                        <br />
                                        <asp:Repeater ID="MainPri3" runat="server">
                                            <ItemTemplate>
                                                <table border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="ButtonM3" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                            -
                                                <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>
                                                            -
                                                <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                                        </td>

                                                    </tr>
                                                </table>

                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                    <div class="p-1 item-hl ">
                                        <asp:Label class=" bg-dark text-light p-2" ToolTip="Has All Rails, But Furniture is Red and Not Shipped." runat="server">Priority #4</asp:Label><br />

                                        <br />
                                        <asp:Repeater ID="MainPri4" runat="server">
                                            <ItemTemplate>
                                                <table border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="ButtonM4" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                            -
                                                <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>
                                                            -
                                                <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                                        </td>

                                                    </tr>
                                                </table>

                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                    <div class="p-1 item-hl ">
                                        <asp:Label class=" bg-dark text-light p-2" ToolTip="Missing Some or All Rails" runat="server">Priority #5</asp:Label><br />
                                        <br />
                                        <asp:Repeater ID="MainPri5" runat="server">
                                            <ItemTemplate>
                                                <table border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="ButtonM5" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                            -
                                                <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>
                                                            -
                                                <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                                        </td>

                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                    </div>
                                </div>


                                <div class="w-50 col float-left">
                                    <div>
                                        <asp:Label class=" text-dark ml-4 p-2 font-weight-bold" runat="server">SOUTH</asp:Label>
                                    </div>

                                    <div class="p-1 item-hl  mt-4">
                                        <asp:Label class=" bg-dark text-light p-2" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'S' - Furniture Green - (Has All Rails or Rails Pulled and/or Paneled) - Canvas is at least yellow - Framing/Flooring/Trim Complete" runat="server">Priority #1</asp:Label><br />
                                        <br />
                                        <asp:Repeater ID="SouthPri1" runat="server" DataSourceID="sdsBoatsSFurnGreen">
                                            <ItemTemplate>
                                                <table border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="ButtonS1" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                            - 
                                                    <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>
                                                            -
                                                    <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                                        </td>

                                                    </tr>
                                                </table>

                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <div class="p-1 item-hl ">
                                        <asp:Label class=" bg-dark text-light p-2" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'S' - Furniture Yellow - (Has All Rails or Rails Pulled and/or Paneled) - Canvas is at least yellow - Framing/Flooring/Trim Complete" runat="server">Priority #2</asp:Label><br />
                                        <br />
                                        <asp:Repeater ID="SouthPri2" runat="server" DataSourceID="sdsBoatsSFurnYellow">
                                            <ItemTemplate>
                                                <table border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="ButtonS2" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                            -
                                                    <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>
                                                            -
                                                    <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                                        </td>

                                                    </tr>
                                                </table>

                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                    <div class="p-1 item-hl ">
                                        <asp:Label class=" bg-dark text-light p-2" ToolTip="Furniture Red, but Veada shows Shipped" runat="server">Priority #3</asp:Label><br />
                                        <br />
                                        <asp:Repeater ID="SouthPri3" runat="server">
                                            <ItemTemplate>
                                                <table border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="ButtonS3" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                            -
                                                    <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>
                                                            -
                                                    <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                                        </td>

                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                    </div>

                                    <div class="p-1 item-hl ">
                                        <asp:Label class=" bg-dark text-light p-2" ToolTip="Has All Rails, But Furniture is Red and Not Shipped." runat="server">Priority #4</asp:Label><br />
                                        <br />
                                        <asp:Repeater ID="SouthPri4" runat="server">
                                            <ItemTemplate>
                                                <table border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="ButtonS4" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                            -
                                                    <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>
                                                            -
                                                    <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                                        </td>

                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                    </div>

                                    <div class="p-1 item-hl ">
                                        <asp:Label class=" bg-dark text-light p-2" ToolTip="Missing Some or All Rails" runat="server">Priority #5</asp:Label><br />
                                        <br />
                                        <asp:Repeater ID="SouthPri5" runat="server">
                                            <ItemTemplate>
                                                <table border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="ButtonS5" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                            -
                                                    <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>
                                                            -
                                                    <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                                        </td>

                                                    </tr>
                                                </table>

                                            </ItemTemplate>
                                        </asp:Repeater>

                                    </div>
                                </div>
                                <asp:SqlDataSource ID="sdsBoatsMFurnGreen" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT  t1.ProdNo as ProdNo, Substring(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor, t1.ItemNo as ItemNo FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 0 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'M' and FurnitureStatus = 2 and (HasAllRails = 1 or RailsStatus > 0 or RailsStatus = -1) and CoversStatus >= 1 and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="sdsBoatsSFurnGreen" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT  t1.ProdNo as ProdNo, SubString(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor, t1.ItemNo as ItemNo FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 0 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'S' and FurnitureStatus = 2 and (HasAllRails = 1 or RailsStatus > 0 or RailsStatus = -1) and CoversStatus >= 1 and FramesInstalledStatus = 2 and TrimStatus = 2 and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="sdsBoatsMFurnYellow" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo as ProdNo, Substring(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor, t1.ItemNo as ItemNo FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 0 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'M' and FurnitureStatus = 1 and (HasAllRails = 1 or RailsStatus > 0 or RailsStatus = -1) and CoversStatus >= 1 and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>
                                <asp:SqlDataSource ID="sdsBoatsSFurnYellow" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo as ProdNo, SubString(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor, t1.ItemNo as ItemNo FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 0 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'S' and FurnitureStatus = 1 and (HasAllRails = 1 or RailsStatus > 0 or RailsStatus = -1) and CoversStatus >= 1 and FramesInstalledStatus = 2 and TrimStatus = 2 and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>
                            </div>
                        </div>
                    </asp:View>

                    <asp:View runat="server" ID="View3">
                        <div class="container">
                            <div class="row w-100 h4 text-center">
                                <asp:Label ID="Label4" CssClass="bg-dark text-light w-100 ml-2 p-1" runat="server" Text="Shipping to Main/South"></asp:Label><br />
                            </div>
                            <div class="row w-100">
                                <div class="col w-50">
                                    <asp:Label ID="Label8" runat="server" CssClass="h6" Text="# Empty Racks (M)"></asp:Label><asp:Label ID="lblEmptyMain" CssClass="h6" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="col w-50">
                                    <asp:Label ID="Label10" runat="server" CssClass="h6" Text="# Empty Racks (S)"></asp:Label><asp:Label ID="lblEmptySouth" CssClass="h6" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="row w-100">
                                <div class="col w-50">
                                    <div class="row">
                                        <asp:Label ID="Label9" runat="server" CssClass="p-1 m-1 bg-dark text-light" ToolTip="Green Furn, Green Rails, Helm Built but not Shipped" Text="Priority 1:"></asp:Label>
                                    </div>
                                    <div class="row">
                                        <asp:GridView ID="gvMPri1" runat="server" DataSourceID="sdsMPri1" AutoGenerateColumns="False" ShowHeader="false" GridLines="Horizontal">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnMLoad1" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoLoad" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label15" runat="server" Text='<%#Eval("ItemNo") %>'></asp:Label>
                                                        - 
                                                        <asp:Label ID="Label16" runat="server" Text='<%#Eval("BaseVinylColor") %>'></asp:Label><br />
                                                        <asp:Label ID="Label17" runat="server" CssClass="text-primary font-weight-bold" Text="Loc:"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsMPri1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo, t1.ItemNo, Substring(t1.ProdNo,3,5) as ProdNoShort, Left(t2.BaseVinylColor,3) as BaseVinylColor FROM [BML_POPREPORTING] t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo WHERE (t2.BuildLoc = @BuildLoc) and HelmInstalledStatus = 0 and FurnitureStatus = 2 and RailsStatus = 2 and HelmBuildStatus = 2 and HelmShipStatus = 0 Order By t1.ProdNo">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="M" Name="BuildLoc" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>

                                    <div class="row">
                                        <asp:Label ID="Label12" CssClass="p-1 m-1 bg-dark text-light" runat="server" Text="Priority 2:"></asp:Label>
                                    </div>
                                    <div class="row">
                                        <asp:GridView ID="gvMPri2" runat="server" DataSourceID="sdsMPri2" AutoGenerateColumns="False" ShowHeader="False">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnMLoad1" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoLoad" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label15" runat="server" Text='<%#Eval("ItemNo") %>'></asp:Label>
                                                        - 
                                                        <asp:Label ID="Label16" runat="server" Text='<%#Eval("BaseVinylColor") %>'></asp:Label><br />
                                                        <asp:Label ID="Label17" runat="server" CssClass="text-primary  font-weight-bold" Text="Loc:"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsMPri2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo, t1.ItemNo, Substring(t1.ProdNo,3,5) as ProdNoShort, Left(t2.BaseVinylColor,3) as BaseVinylColor FROM [BML_POPREPORTING] t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Left Join Rails_Tracking t3 on t1.ProdNo = t3.ProdNo WHERE (t2.BuildLoc = @BuildLoc) and HelmInstalledStatus = 0 and FurnitureStatus = 2 and (HasAllRails = 1 and RailsStatus <= 1) and HelmBuildStatus = 2 and HelmShipStatus = 0 Order By t1.ProdNo ">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="M" Name="BuildLoc" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                </div>

                                <div class="col w-50">
                                    <div class="row">
                                        <asp:Label ID="Label11" CssClass="p-1 m-1 bg-dark text-light" runat="server" Text="Priority 1:"></asp:Label>
                                    </div>
                                    <div class="row">
                                        <asp:GridView ID="gvSPri1" runat="server" DataSourceID="sdsSPri1" AutoGenerateColumns="False" ShowHeader="False">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnMLoad1" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoLoad" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label15" runat="server" Text='<%#Eval("ItemNo") %>'></asp:Label>
                                                        - 
                                                        <asp:Label ID="Label16" runat="server" Text='<%#Eval("BaseVinylColor") %>'></asp:Label><br />
                                                        <asp:Label ID="Label17" CssClass="text-primary font-weight-bold" runat="server" Text="Loc:"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsSPri1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo, t1.ItemNo, Substring(t1.ProdNo,3,5) as ProdNoShort, Left(t2.BaseVinylColor,3) as BaseVinylColor FROM [BML_POPREPORTING] t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo WHERE (t2.BuildLoc = @BuildLoc) and HelmInstalledStatus = 0 and FurnitureStatus = 2 and RailsStatus = 2 and HelmBuildStatus = 2 and HelmShipStatus = 0 Order By t1.ProdNo ">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="S" Name="BuildLoc" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                    <div class="row">
                                        <asp:Label ID="Label13" CssClass="p-1 m-1 bg-dark text-light" runat="server" Text="Priority 2:"></asp:Label>
                                    </div>
                                    <div class="row">
                                        <asp:GridView ID="gvSPri2" runat="server" DataSourceID="sdsSPri2" AutoGenerateColumns="False" ShowHeader="False">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnMLoad1" CssClass="btn-sm pl-2 pr-2 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoLoad" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label15" runat="server" Text='<%#Eval("ItemNo") %>'></asp:Label>
                                                        - 
                                                        <asp:Label ID="Label16" runat="server" Text='<%#Eval("BaseVinylColor") %>'></asp:Label><br />
                                                        <asp:Label ID="Label17" CssClass="text-primary font-weight-bold" runat="server" Text="Loc:"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsSPri2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo, t1.ItemNo, Substring(t1.ProdNo,3,5) as ProdNoShort, Left(t2.BaseVinylColor,3) as BaseVinylColor FROM [BML_POPREPORTING] t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo Left Join Rails_Tracking t3 on t1.ProdNo = t3.ProdNo WHERE (t2.BuildLoc = @BuildLoc) and HelmInstalledStatus = 0 and FurnitureStatus = 2 and (HasAllRails = 1 and RailsStatus <= 1) and HelmBuildStatus = 2 and HelmShipStatus = 0 Order By t1.ProdNo ">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="S" Name="BuildLoc" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                </div>

                            </div>
                            <div class="row w-100">
                                <div class="col w-50"></div>
                                <div class="col w-50"></div>
                            </div>
                        </div>
                    </asp:View>
                    <asp:View runat="server" ID="View4">
                        <div class="container">
                            <div class="row w-100 h4 text-center">
                                <asp:Label ID="Label19" CssClass="bg-dark text-light w-100 p-1" runat="server" Text="Deliver to FG Repair"></asp:Label><br />
                            </div>
                            <div>
                                <asp:Label runat="server" Text="Light Gray = South Bldg Boat, White = Main."></asp:Label>
                            </div>
                            <div class="row">
                                <asp:GridView ID="gvHelmBuild" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Prod #">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProd" runat="server" Text='<%# Eval("ProdNo") %>' CssClass="newStyle6"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Model">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Options">
                                            <ItemTemplate>
                                                <asp:Label ID="Label4" runat="server" Text='<%# SplitBVatDash(Eval("BaseVinylColor"))%>'></asp:Label>
                                                <asp:GridView ID="gvHelmBuildOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsHelmBuild">
                                                    <Columns>
                                                        <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False">
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="sdsFabOptionsHelmBuild" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter or [Workcenter] = @Workcenter2))">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="gvHelmBuild" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                                        <asp:Parameter DefaultValue="Helms" Name="Workcenter" Type="String" />
                                                        <asp:Parameter DefaultValue="Flooring" Name="Workcenter2" Type="String" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Deliver To Repair">
                                            <ItemTemplate>
                                                <div class="newStyle2 text-center">
                                                    <asp:Button ID="btnUpdateFiberglassStatus" runat="server" Text="Delivered" CommandArgument='<%# Eval("ProdNo") %>' CommandName="UpdateFGStatus" />
                                                </div>
                                            </ItemTemplate>
                                            <ItemStyle VerticalAlign="Middle" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerSettings PageButtonCount="20" />
                                    <RowStyle Height="50px" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Tubes.OuterScheduled, BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassInspStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.NotesHelmBuild, BML_POPREPORTING_GREENLIGHTS.BuildLoc, (CASE WHEN cast(FurnitureStatus as integer) = 3 THEN 2 ELSE cast(FurnitureStatus as Integer) END)  + cast(FiberglassStatus as integer) +  (CASE WHEN cast(CoversStatus as integer) = 3 THEN 2 ELSE cast(CoversStatus as Integer) END)  + cast(RailsStatus as integer) + cast(TubesStatus as integer)  + cast(GaugeStatus as integer) + cast(HarnessStatus as integer) + cast(FloorsInstalledStatus as integer)  + cast(Rails_Tracking.HasAllRails as integer) + cast(Rails_Tracking.Requested as integer) + (CASE WHEN cast(BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded as integer) = 1 THEN cast(CentertubeStatus as integer) ELSE 2 END) as GreenStatusTotal, cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, Rails_Tracking.HasAllRails FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join TUBES on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join Rails_Tracking on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.FiberglassInspStatus = 3) ORDER BY FiberglassInsp"></asp:SqlDataSource>
                            </div>
                        </div>
                    </asp:View>
                    <asp:View runat="server" ID="View5">
                        <div class="container">
                            <div class="row w-100 h4 text-center">
                                <asp:Label ID="Label20" CssClass="bg-dark text-light w-100 p-1" runat="server" Text="Consoles to Ship"></asp:Label><br />
                            </div>
                            <div class="row">
                                <asp:Button runat="server" ID="btnRefreshShip" Text="Refresh" />
                            </div>
                            <asp:Label runat="server" Text="Green = Built, Yellow = In Progress, Red = Not Started (Please Report Red Helms to Joe)"></asp:Label><br />
                            <asp:Label runat="server" Text="B1 = Helm is Built and Not Shipped or Installed. Rails dot is hidden because they ship all South Consoles upon completion."></asp:Label><br />                           
                            <asp:Label runat="server" Text="B2/B3 = Rails Are Yellow or Green and Helm Not Shipped or Installed."></asp:Label>

                            <div class="row">
                                <asp:GridView ID="gvShip" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsMainShip" CellPadding="4" PageSize="20" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" ForeColor="Black">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Prod #">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProd" runat="server" Text='<%# Eval("ProdNo") %>' CssClass="newStyle6"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Model">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Color">
                                            <ItemTemplate>
                                                <asp:Label ID="Label4" runat="server" Text='<%# SplitBVatDash(Eval("BaseVinylColor"))%>'></asp:Label>
                                                <asp:GridView ID="gvHelmBuildOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsHelmBuild">
                                                    <Columns>
                                                        <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False">
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="sdsFabOptionsHelmBuild" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter or [Workcenter] = @Workcenter2))">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="gvHelmBuild" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                                        <asp:Parameter DefaultValue="Helms" Name="Workcenter" Type="String" />
                                                        <asp:Parameter DefaultValue="Flooring" Name="Workcenter2" Type="String" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Line">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBuildLoc" runat="server" Text='<%# Eval("ProdLineDesc") %>' CssClass="newStyle6"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Helm">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnHelm" Enabled="false" runat="server" ImageUrl='<%# Eval("HelmBuildStatus", "../Images/{0}.png")%>' ToolTip='<%# "Helm - " + Eval("HelmBuild")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Rails">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnRails" Enabled="false" runat="server" ImageUrl='<%# Eval("RailsStatus", "../Images/{0}.png")%>' Visible='<%# If(Eval("ProdLineDesc") = "B2" Or Eval("ProdLineDesc") = "B3", 1, 0) %>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Mark As Shipped">
                                            <ItemTemplate>
                                                <div class="newStyle2 text-center">
                                                    <asp:Button ID="btnUpdateShipStatus" runat="server" Text="Shipped" CommandArgument='<%#Eval("ProdNo") %>' CommandName="UpdateShipStatus" />
                                                </div>
                                            </ItemTemplate>
                                            <ItemStyle VerticalAlign="Middle" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCCCC"></FooterStyle>

                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>

                                    <PagerSettings PageButtonCount="20" />
                                    <PagerStyle HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black"></PagerStyle>

                                    <RowStyle Height="50px" BackColor="White" />
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                                    <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

                                    <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>

                                    <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

                                    <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsMainShip" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, HelmBuildStatus, RailsStatus, BML_POPREPORTING_GREENLIGHTS.BuildLoc, HelmBuild, BML_POPREPORTING.ItemNo, BML_POPREPORTING.BaseVinylColor, Rails_Tracking.Requested as Requested, Rails_Tracking.HasAllRails, 'B' + ProdLineID as ProdLineDesc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Rails_Tracking on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo WHERE HelmInstalledStatus < 2 and (((BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' or BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V') AND BML_POPREPORTING_GREENLIGHTS.RailsStatus > 0 AND HelmShipStatus < 2 ) or (BML_POPREPORTING_GREENLIGHTS.BuildLoc ='S' and HelmBuildStatus = 2 and HelmShipStatus < 2)) ORDER BY ProdNo"></asp:SqlDataSource>
                            </div>
                        </div>
                    </asp:View>
                     <asp:View runat="server" ID="View6">
                        <div class="container">
                            <div class="row w-100 h4 text-center">
                                <asp:Label ID="Label21" CssClass="bg-dark text-light w-100 p-1" runat="server" Text="Ship History"></asp:Label><br />
                            </div>
                            <div class="row">
                                <asp:Button runat="server" ID="btnRefreshHistory" Text="Refresh" />
                            </div>
                            <div>
                                <br />
                                <asp:GridView runat="server" ID="gvShipHistory" Caption="Helms Shipped By Date Shipped Descending" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsHelmShipHistory" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                                    <AlternatingRowStyle BackColor="#CCCCCC"></AlternatingRowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo"></asp:BoundField>
                                        <asp:BoundField DataField="ItemNo" HeaderText="Model" SortExpression="ItemNo"></asp:BoundField>
                                        <asp:BoundField DataField="HelmShip" HeaderText="Date Shipped" SortExpression="HelmShip"></asp:BoundField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCCCC"></FooterStyle>
                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>
                                    <PagerStyle HorizontalAlign="Center" BackColor="#999999" ForeColor="Black"></PagerStyle>
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>
                                    <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>
                                    <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>
                                    <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>
                                    <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
                                </asp:GridView>
                                <asp:SqlDataSource runat="server" ID="sdsHelmShipHistory" ConnectionString='<%$ ConnectionStrings:bml_dataConnectionString %>' SelectCommand="SELECT [ProdNo], [ItemNo], [HelmShip] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([HelmShipStatus] = @HelmShipStatus) and Convert(date,HelmShip) > '04/01/2022' ORDER BY [HelmShip] DESC, [ProdNo]">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="2" Name="HelmShipStatus" Type="Int32"></asp:Parameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </div>
                    </asp:View>
                </asp:MultiView>
            </div>

        </div>
    </form>
</body>
</html>
