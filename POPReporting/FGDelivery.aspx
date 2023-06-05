<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FGDelivery.aspx.vb" Inherits="FGDelivery" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="scripts/css/bootstrap.min.css" />
    <link href="scripts/css/toastr.css" rel="stylesheet" />
    <script src="scripts/jquery-3.5.0.min.js"></script>
    <script src="scripts/bootstrap.min.js"></script>
    <script src="scripts/toastr.min.js"></script>
    <title>FG Repair Priority</title>
     <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        .fgcolor {  
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                <ContentTemplate>--%>
                    <div class="w-50 float-left">
                        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>

                        <div>
                            <asp:Label class="text-dark ml-4 p-2 font-weight-bold" runat="server">MAIN</asp:Label>
                        </div>


                        <div class="p-4 item-hl ">
                            <asp:Label class=" bg-dark text-light p-2" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'M' - Furniture Green - (Has All Rails or Rails Pulled and/or Paneled) - Canvas is at least yellow" runat="server">Priority #1</asp:Label><br />
                            <br />
                            <asp:Repeater ID="MainPri1" runat="server" DataSourceID="sdsBoatsMFurnGreen">
                                <ItemTemplate>                                    
                                   <table border="0">
                                        <tr>
                                            <td>
                                           <asp:Button ID="ButtonM1" CssClass="btn-lg pl-4 pr-4 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label> - <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>  - <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                            </td>
                                            
                                        </tr>
                                    </table>
                                    
                                    
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>


                        <div class="p-4 item-hl ">
                            <asp:Label class=" bg-dark text-light p-2" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'M' - Furniture Yellow - (Has All Rails or Rails Pulled and/or Paneled) - Canvas is at least yellow" runat="server">Priority #2</asp:Label><br />
                            <br />
                            <asp:Repeater ID="MainPri2" runat="server" DataSourceID="sdsBoatsMFurnYellow">
                                <ItemTemplate>
                                 <table border="0">
                                        <tr>
                                            <td>
                                            <asp:Button ID="ButtonM2" CssClass="btn-lg pl-4 pr-4 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label> - <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>  - <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                            </td>
                                            
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:Repeater>

                        </div>

                        <div class="p-4 item-hl ">
                            <asp:Label class=" bg-dark text-light p-2" ToolTip="Furniture Red, but Veada shows Shipped" runat="server">Priority #3</asp:Label><br />
                            <br />
                            <asp:Repeater ID="MainPri3" runat="server">
                                <ItemTemplate>
                                    <table border="0">
                                        <tr>
                                            <td>
                                            <asp:Button ID="ButtonM3" CssClass="btn-lg pl-4 pr-4 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label> - <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>  - <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                            </td>
                                            
                                        </tr>
                                    </table>
                                    
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>

                        <div class="p-4 item-hl ">
                            <asp:Label class=" bg-dark text-light p-2" ToolTip="Has All Rails, But Furniture is Red and Not Shipped." runat="server">Priority #4</asp:Label><br />

                            <br />
                            <asp:Repeater ID="MainPri4" runat="server">
                                <ItemTemplate>
                                  <table border="0">
                                        <tr>
                                            <td>
                                            <asp:Button ID="ButtonM4" CssClass="btn-lg pl-4 pr-4 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label> - <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>  - <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                            </td>
                                            
                                        </tr>
                                    </table>
                                    
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>

                        <div class="p-4 item-hl ">
                            <asp:Label class=" bg-dark text-light p-2" ToolTip="Missing Some or All Rails" runat="server">Priority #5</asp:Label><br />
                            <br />
                            <asp:Repeater ID="MainPri5" runat="server">
                                <ItemTemplate>
                                   <table border="0">
                                        <tr>
                                            <td>
                                            <asp:Button ID="ButtonM5" CssClass="btn-lg pl-4 pr-4 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label> - <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>  - <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>                                                
                                            </td>
                                            
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:Repeater>

                        </div>
                    </div>
                    <div class="w-50 float-left">
                    <div>
                        <asp:Label class=" text-dark ml-4 p-2 font-weight-bold" runat="server">SOUTH</asp:Label>
                    </div>
                        <div>
                            <div class="p-4 item-hl  mt-4">
                                <asp:Label class=" bg-dark text-light p-2" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'S' - Furniture Green - (Has All Rails or Rails Pulled and/or Paneled) - Canvas is at least yellow - Framing/Flooring/Trim Complete" runat="server">Priority #1</asp:Label><br />
                                <br />
                                <asp:Repeater ID="SouthPri1" runat="server" DataSourceID="sdsBoatsSFurnGreen">
                                    <ItemTemplate>
                                    <table border="0">
                                        <tr>
                                            <td>
                                            <asp:Button ID="ButtonS1" CssClass="btn-lg pl-4 pr-4 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                            </td>
                                            <td>
                                               <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label> -  <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>  - <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                            </td>
                                            
                                        </tr>
                                    </table>
                                    
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <div class="p-4 item-hl ">
                                <asp:Label class=" bg-dark text-light p-2" ToolTip="Fiberglass Green -  Helm Not Built - Building = 'S' - Furniture Yellow - (Has All Rails or Rails Pulled and/or Paneled) - Canvas is at least yellow - Framing/Flooring/Trim Complete" runat="server">Priority #2</asp:Label><br />
                                <br />
                                <asp:Repeater ID="SouthPri2" runat="server" DataSourceID="sdsBoatsSFurnYellow">
                                    <ItemTemplate>
                                        <table border="0">
                                        <tr>
                                            <td>
                                            <asp:Button ID="ButtonS2" CssClass="btn-lg pl-4 pr-4 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label> - <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>  - <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                            </td>
                                            
                                        </tr>
                                    </table>
                                    
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                            <div class="p-4 item-hl ">
                                <asp:Label class=" bg-dark text-light p-2" ToolTip="Furniture Red, but Veada shows Shipped" runat="server">Priority #3</asp:Label><br />
                                <br />
                                <asp:Repeater ID="SouthPri3" runat="server">
                                    <ItemTemplate>
                                        <table border="0">
                                        <tr>
                                            <td>
                                            <asp:Button ID="ButtonS3" CssClass="btn-lg pl-4 pr-4 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label> - <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>  - <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                            </td>
                                            
                                        </tr>
                                    </table>
                                    </ItemTemplate>
                                </asp:Repeater>

                            </div>

                            <div class="p-4 item-hl ">
                                <asp:Label class=" bg-dark text-light p-2" ToolTip="Has All Rails, But Furniture is Red and Not Shipped." runat="server">Priority #4</asp:Label><br />
                                <br />
                                <asp:Repeater ID="SouthPri4" runat="server">
                                    <ItemTemplate>
                                       <table border="0">
                                        <tr>
                                            <td>
                                            <asp:Button ID="ButtonS4" CssClass="btn-lg pl-4 pr-4 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label> - <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>  - <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                            </td>
                                            
                                        </tr>
                                    </table>
                                    </ItemTemplate>
                                </asp:Repeater>

                            </div>

                            <div class="p-4 item-hl ">
                                <asp:Label class=" bg-dark text-light p-2" ToolTip="Missing Some or All Rails" runat="server">Priority #5</asp:Label><br />
                                <br />
                                <asp:Repeater ID="SouthPri5" runat="server">
                                    <ItemTemplate>
                                         <table border="0">
                                        <tr>
                                            <td>
                                            <asp:Button ID="ButtonS5" CssClass="btn-lg pl-4 pr-4 m-2" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoBringIn" runat="server" Text='<%# Eval("ProdNoShort") %>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" class="fgcolor" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label> - <asp:Label ID="lblFGColor" class="fgcolor" runat="server" Text='<%# Eval("BaseVinylColor")%>'></asp:Label>  - <asp:Label ID="lblPrerig" class="fgcolor" runat="server" Text=""></asp:Label>
                                            </td>
                                            
                                        </tr>
                                    </table>
                                    
                                    </ItemTemplate>
                                </asp:Repeater>

                            </div>
                        </div>

                    </div>
                    </div>
                 <%--   </div>--%>

                    <asp:SqlDataSource ID="sdsBoatsMFurnGreen" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT  t1.ProdNo as ProdNo, Substring(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor, t1.ItemNo as ItemNo FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 0 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'M' and FurnitureStatus = 2 and (HasAllRails = 1 or RailsStatus > 0 or RailsStatus = -1) and CoversStatus >= 1 and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsBoatsSFurnGreen" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT  t1.ProdNo as ProdNo, SubString(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor, t1.ItemNo as ItemNo FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 0 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'S' and FurnitureStatus = 2 and (HasAllRails = 1 or RailsStatus > 0 or RailsStatus = -1) and CoversStatus >= 1 and FramesInstalledStatus = 2 and TrimStatus = 2 and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsBoatsMFurnYellow" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo as ProdNo, Substring(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor, t1.ItemNo as ItemNo FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 0 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'M' and FurnitureStatus = 1 and (HasAllRails = 1 or RailsStatus > 0 or RailsStatus = -1) and CoversStatus >= 1 and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsBoatsSFurnYellow" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.ProdNo as ProdNo, SubString(t1.ProdNo,3,5) as ProdNoShort, Left(BaseVinylColor,3) as BaseVinylColor, t1.ItemNo as ItemNo FROM BML_POPREPORTING_GREENLIGHTS t1 left join Rails_Tracking on t1.ProdNo = Rails_Tracking.ProdNo Where FiberglassStatus = 2 and FiberglassInspStatus = 0 and HelmBuildStatus = 0 and t1.ProdNo > 2100000 and BuildLoc = 'S' and FurnitureStatus = 1 and (HasAllRails = 1 or RailsStatus > 0 or RailsStatus = -1) and CoversStatus >= 1 and FramesInstalledStatus = 2 and TrimStatus = 2 and CompleteStatus < 2 order by t1.ProdNo"></asp:SqlDataSource>

               <%-- </ContentTemplate>
            </asp:UpdatePanel>--%>
     





    </form>
</body>
</html>
