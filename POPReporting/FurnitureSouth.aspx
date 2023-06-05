<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureSouth.aspx.vb" Inherits="FurnitureSouth" debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture South</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./scripts/css/bootstrap.min.css" />
   
</head>
<body>
    <form id="form1" runat="server">
        <div class="w-100">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Label ID="Label3" runat="server" Text="Orange = Received. Yellow = Not Received"></asp:Label>
                    <div class="w-100 float-left">
                        
                        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsSouthWIP">
                            <ItemTemplate>
                                <div id="thiscard" runat="server" class="card text-center float-left border-dark" style="width:300px;font-size:12px;">
                                    <h6 class="card-header">
                                        <asp:Label ID="lblProd" CssClass="title float-left" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><asp:Label ID="lblModel" CssClass="title w-15 float-right" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                        <%--<asp:ImageButton ID="ImageButton1" Visible='<%# IIf(Eval("IsPilot").ToString() = "", 0, Eval("IsPilot")) = 1%>' runat="server" ImageUrl="../Images/rackmapPilot1.png" />
                                        <asp:Label ID="lblProd" CssClass="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>
                                        <asp:Label ID="lblBoat" CssClass="boatinfoboat float-right" runat="server" Text='<%# Eval("ItemNo")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>--%>
                                    </h6>
                                    <div class="card-title">
                                        <h6><asp:Label ID="lblColor" runat="server" Text=""></asp:Label></h6>
                                    </div>

                                    <div class="card-body">
                                        <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT AutoID, RGA_Item_Desc, Color, Accent, Qty, Date_Added, BenRcvd, DeliveredToLine FROM RGAs WHERE (BenRcvd is Null or DeliveredToLine is Null) and ProdNo = ?ProdNo">
                                            <SelectParameters>
                                                     <asp:ControlParameter ControlID="lblProd" Name="ProdNo" PropertyName="Text" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:GridView ID="gvRGAs" runat="server" AutoGenerateColumns="False" cssClass="table table-sm" BorderStyle="None" DataSourceID="sdsRGAs" OnRowDataBound="gvRGAs_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderText="RGAs">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label2" runat="server" Text='<%#Eval("RGA_Item_Desc") %>'></asp:Label>
                                                        <%--<br /><asp:Label ID="Label3" runat="server" Text='<%#Eval("Color") %>'></asp:Label>--%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>                                                
                                                <asp:BoundField DataField="Qty" HeaderText="Qty">
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:BoundField>

                                                <asp:BoundField DataField="Date_Added" DataFormatString="{0:d}" HeaderText="Added">

                                                    <ItemStyle Width="35px" />
                                                </asp:BoundField>

                                            <asp:TemplateField HeaderText="In Boat">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnDelivered" runat="server" Text="Delivered" Visible='<%# IIf(Eval("BenRcvd").ToString() = "", 0, Eval("BenRcvd")) = 1%>' CssClass="btn btn-dark btn-sm p-1" CommandName="setdelivered" CommandArgument='<%#Eval("AutoID")%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>

                                            </Columns>
                                        </asp:GridView>
                                        <asp:GridView ID="gvBOs" runat="server" cssClass="table table-sm w-auto" AutoGenerateColumns="False" BorderStyle="None" DataSourceID="sdsBOs" OnRowDataBound="gvBOs_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderText="BO's">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label4" runat="server" Text='<%#Eval("BO_Item_Desc") %>'></asp:Label>
                                                        <%--<br /><asp:Label ID="Label5" runat="server" Text='<%#Eval("Color") %>'></asp:Label>--%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                
                                                <asp:BoundField DataField="Date_Added" DataFormatString="{0:d}" HeaderText="Added">

                                                    <ItemStyle Width="35px" />
                                                </asp:BoundField>

                                             <asp:TemplateField HeaderText="In Boat">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnDelivered" runat="server" Text="Delivered" Visible='<%# IIf(Eval("Cleared").ToString() = "", 0, Eval("Cleared")) = 1%>' CssClass="btn btn-dark btn-sm p-1" CommandName="setbodelivered" CommandArgument='<%#Eval("AutoID")%>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"/>
                                                </asp:TemplateField>

                                            </Columns>
                                        </asp:GridView>

                                        <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT AutoID, ProdNo, Color, Accent, BO_Item_Desc, DeliveredToLine, Cleared, Date_Added FROM Backorders WHERE (Cleared = '0' or DeliveredToLine is Null) and Trim(ProdNo) = ?ProdNo">
                                            <SelectParameters>
                                                   <asp:ControlParameter ControlID="lblProd" Name="ProdNo" PropertyName="Text" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                        <asp:GridView ID="gvOrderLines" runat="server" AutoGenerateColumns="False" cssClass="table table-sm w-auto" BorderStyle="None" ShowHeader="False" Caption="Furn Hardware" OnRowCommand="gvOrderLines_RowCommand" OnRowDataBound="gvOrderLines_RowDataBound" >
                                            <Columns>
                                                <asp:BoundField DataField="PartDesc" HeaderText="Part Desc">                                                           
                                                    <ItemStyle HorizontalAlign="Center"/>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Qty" HeaderText="Qty">
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:BoundField>
                                               <%-- <asp:TemplateField HeaderText="Ready">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="btnReady" runat="server" ImageUrl='<%# Eval("HardwareReady", "./Images/hwr_rdy{0}.png")%>' CommandArgument='<%# Container.DataItemIndex & ";" & Eval("ProdNo") & ";" & Eval("PartDesc") & ";" & Eval("ItemNo") & ";" & Eval("Color") & ";" & Eval("Job")%>'  CommandName="gotoReady"  Width="30" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>--%>
                                               <asp:TemplateField HeaderText="In Boat">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnDelivered" runat="server" Text="Delivered" CssClass="btn btn-dark btn-sm p-1" CoommandArgument='<%# Container.DataItemIndex & ";" & Eval("ProdNo") & ";" & Eval("PartDesc") & ";" & Eval("ItemNo") & ";" & Eval("Color") & ";" & Eval("Job")%>' CommandName="setdelivered" />                                                        
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                       <%-- <asp:SqlDataSource ID="sdsVendorInfo" runat="server" ConnectionString="<%$ ConnectionStrings:SPECS_ExternalConnectionString %>" ProviderName="<%$ ConnectionStrings:SPECS_ExternalConnectionString.ProviderName %>" SelectCommand="SELECT OrderLines.ProdNo, ItemNo,StockCode, PartStockCode,PartDesc,PartLineDesc,Color,BO_Flag,RGA_Flag,Qty,RcvdFlag,Job,HardwareReady,CASE When RCVDFlag = 0 Then '0' When RCVDFlag < Qty Then '1' When RCVDFlag = Qty Then '2' END as RCVDGraphic FROM OrderLines left join Live_Boats on OrderLines.ProdNo = Live_Boats.ProdNo WHERE (PartDesc Like '%RECL%' or PartDesc Like '%BASS SEAT%' or PartDesc Like '%BOW GATE BENCH%' or PartDesc Like '%OTTOMAN%' or PartDesc Like '%REFRESHMENT TABLE%' or PartDesc Like '%HELM SEAT%' or PartDesc Like 'LOOSE%' ) AND  OrderLines.ProdNo = ?ProdNo">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblProd" Name="ProdNo" PropertyName="Text" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>--%>

                                        <asp:GridView ID="gvNotes" runat="server" DataSourceID="sdsBoatNotes" ShowHeader="false" CssClass="table table-sm" AutoGenerateColumns="False" Caption="Open Prod Notes">
                                            <Columns>
                                                <asp:BoundField DataField="Note" DataFormatString="&lt;div style=&quot;text-transform:capitalize&quot;&gt;{0}&lt;/div&gt;" HtmlEncode="false" ShowHeader="False">
                                                   
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Date" DataFormatString="{0:d}" ShowHeader="False">
                                                   
                                                </asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="sdsBoatNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Note], [Date] FROM [BML_POPREPORTING_NOTES] WHERE ([ProdNo] = @ProdNo) and Resolved is Null and Note not like 'South Frame Ready' and Note not like '%Engine%' and Note not like '%Lower Unit%' ORDER BY [Date]">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblProd" Name="ProdNo" PropertyName="Text" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>

                                    <div class="card-footer">
                                        <h6><asp:Label ID="Label1" runat="server" Text='<%# Eval("CurrentStatus")%>'></asp:Label></h6>
                                    </div>

                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    
                    
                    </div>

                    <asp:SqlDataSource ID="sdsSouthWIP" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus,CASE When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' End as CurrentStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([IsDeckInside] = '1') and ShrinkwrapStatus < 2 and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S') Order By ProdNo"></asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>


    </form>
</body>
</html>
