<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GatesRackMap.aspx.vb" Inherits="Gates_GatesRackMap" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gate Map </title>
    <link rel="stylesheet" href="../scripts/css/bootstrap.min.css" />
    <link href="../scripts/css/toastr.css" rel="stylesheet" />
    <script src="../scripts/jquery-3.5.0.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
    <script src="../scripts/toastr.min.js"></script>

    <style>
        .title {
        }

        .boatprodinfo {
        }

        .thiscard {
         
            text-align: center;
            float: left;
            font-size: 150px;
        }

        .myButton {
            box-shadow: inset 0px 1px 0px 0px #ffffff;
            background: linear-gradient(to bottom, #f9f9f9 5%, #e9e9e9 100%);
            background-color: #f9f9f9;
            border-radius: 6px;
            border: 1px solid #dcdcdc;            
            cursor: pointer;
            color: #666666;
            font-family: Arial;
            font-size: 15px;
            font-weight: bold;
            
            text-align:center;
            text-decoration: none;
            text-shadow: 0px 1px 0px #ffffff;
            
            
        }

            .myButton:hover {
                background: linear-gradient(to bottom, #e9e9e9 5%, #f9f9f9 100%);
                background-color: #e9e9e9;
            }

            .myButton:active {
                position: relative;
                top: 1px;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="w-100">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="float-left">
                          <asp:Label ID="Label3" runat="server" Text="Priority Order - Main (Green, Blue)  South (Orange, Yellow, Tan)"></asp:Label><asp:HyperLink CssClass="ml-4" ID="HyperLink1" runat="server" NavigateUrl="Maintenance.aspx" Target="_blank">Click Here to Help Maintain Gates By Model</asp:HyperLink></br>
                        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsRacks">
                            <ItemTemplate>
                                <div id="thiscard" runat="server" class="card text-center float-left border-dark" style="width:23rem;height:12rem;">
                                    <h5 class="card-header">
                                        <asp:Label ID="lblRailsSlot" CssClass="title float-left" runat="server" Text='<%# Eval("RailsSlot")%>'></asp:Label><asp:Label ID="lblBldg" CssClass="title float-left" runat="server" Text='<%# "-" & Eval("BuildLoc")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>
                                        <asp:ImageButton ID="ImageButton1" Visible='<%# IIf(Eval("IsPilot").ToString() = "", 0, Eval("IsPilot")) = 1%>' runat="server" ImageUrl="../Images/rackmapPilot1.png" />
                                        <asp:Label ID="lblProd" class="boatinfoprod" runat="server" Text='<%# Eval("ProdNo")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>
                                        <asp:Label ID="lblBoat" class="boatinfoboat float-right" runat="server" Text='<%# Eval("ItemNo")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>

                                    </h5>
                                    <div class="card-title">

                                        <asp:Table runat="server" HorizontalAlign="Center" BorderStyle="solid" GridLines="Both">
                                            <asp:TableRow>
                                                <asp:TableCell ColumnSpan="3"></asp:TableCell>
                                                <asp:TableCell ColumnSpan="4"><strong>AFT</strong></asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow>
                                                <asp:TableCell>BOW</asp:TableCell>
                                                <asp:TableCell>PORT</asp:TableCell>
                                                <asp:TableCell>STRB</asp:TableCell>
                                                <asp:TableCell>PORT</asp:TableCell>
                                                <asp:TableCell>CTR</asp:TableCell>
                                                <asp:TableCell>STRB</asp:TableCell>
                                                <asp:TableCell>STUB</asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow>
                                                <asp:TableCell HorizontalAlign="Center">
                                                    <asp:Image ID="Image5" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("BowCtrRcvStatus"))%>' Visible='<%#IIf(Eval("BowCtr").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Button ID="btnB" CssClass="myButton" runat="server" Text='<%#Eval("BowCtr") %>' CommandArgument='<%#Eval("ProdNo") %>' CommandName="bowctr" Visible='<%#IIf(Eval("BowCtr").ToString() = "", 0, 1) = 1 %>'/>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="Center">
                                                    <asp:Image ID="Image4" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("PortRcvStatus"))%>' Visible='<%#IIf(Eval("Port").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Button ID="btnP" CssClass="myButton" runat="server" Text='<%#Eval("Port") %>' CommandArgument='<%#Eval("ProdNo") %>' CommandName="port" Visible='<%#IIf(Eval("Port").ToString() = "", 0, 1) = 1 %>' />
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="Center">
                                                    <asp:Image ID="Image6" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("StrbRcvStatus"))%>' Visible='<%#IIf(Eval("Strb").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Button ID="btnS" CssClass="myButton" runat="server" Text='<%#Eval("Strb") %>' CommandArgument='<%#Eval("ProdNo") %>' CommandName="strb" Visible='<%#IIf(Eval("Strb").ToString() = "", 0, 1) = 1 %>' />
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="Center">
                                                    <asp:Image ID="Image7" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("AftPortRcvStatus"))%>' Visible='<%#IIf(Eval("AftPort").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Button ID="btnAP" CssClass="myButton" runat="server" Text='<%#Eval("AftPort") %>' CommandArgument='<%#Eval("ProdNo") %>' CommandName="aftport" Visible='<%#IIf(Eval("AftPort").ToString() = "", 0, 1) = 1 %>' />
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="Center">
                                                    <asp:Image ID="Image3" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("AftCtrRcvStatus"))%>' Visible='<%#IIf(Eval("AftCtr").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Button ID="btnAC" CssClass="myButton" runat="server" Text='<%#Eval("AftCtr") %>' CommandArgument='<%#Eval("ProdNo") %>' CommandName="aftctr" Visible='<%#IIf(Eval("AftCtr").ToString() = "", 0, 1) = 1 %>' />
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="Center">
                                                    <asp:Image ID="Image2" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("AftStrbRcvStatus"))%>' Visible='<%#IIf(Eval("AftStrb").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Button ID="btnAS" CssClass="myButton" runat="server" Text='<%#Eval("AftStrb") %>' CommandArgument='<%#Eval("ProdNo") %>' CommandName="aftstrb"  Visible='<%#IIf(Eval("AftStrb").ToString() = "", 0, 1) = 1 %>' />
                                                </asp:TableCell>
                                                 <asp:TableCell HorizontalAlign="Center">
                                                    <asp:Image ID="Image8" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("StubRcvdStatus"))%>' Visible='<%#IIf(Eval("Stub").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Button ID="btnStub" CssClass="myButton" runat="server" Text='<%#Eval("Stub") %>' CommandArgument='<%#Eval("ProdNo") %>' CommandName="stub"  Visible='<%#IIf(Eval("Stub").ToString() = "", 0, 1) = 1 %>' />
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow>

                                                <asp:TableCell>
                                                    <asp:Label ID="lblBWidth" runat="server" Text=""></asp:Label></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblPWidth" runat="server" Text=""></asp:Label></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblSWidth" runat="server" Text=""></asp:Label></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblAPWidth" runat="server" Text=""></asp:Label></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblACWidth" runat="server" Text=""></asp:Label></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblASWidth" runat="server" Text=""></asp:Label></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblStubWidth" runat="server" Text=""></asp:Label></asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>

                                        <asp:Table runat="server" HorizontalAlign="Center" Visible="False">
                                            <asp:TableRow>
                                                <asp:TableCell HorizontalAlign="Center">
                                                   <%-- <asp:Label ID="Label4" runat="server" Text="Due: " Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("DueDate", "{0:d}")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>'></asp:Label>--%>
                                                    <%--<asp:Label ID="lblBlackOut" runat="server" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' Text='<%# IIf(Eval("Blackout").ToString() = "1", " - BO", "")%>'></asp:Label>--%>
                                                </asp:TableCell>
                                                <asp:TableCell ColumnSpan="2">
                                                    <asp:Image ID="imgPort" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("PortRcvStatus"))%>' Visible='<%#IIf(Eval("Port").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Label ID="Label2" runat="server" Text='<%#Eval("Port") %>'></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>

                                            <asp:TableRow>
                                                <asp:TableCell Height="28px">
                                                    <asp:Image ID="imgAftPort" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("AftPortRcvStatus"))%>' Visible='<%#IIf(Eval("AftPort").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Label ID="Label5" runat="server" Text='<%#Eval("AftPort") %>'></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell RowSpan="3">
                                                    <asp:Image ID="Image1" CssClass="mt-1" runat="server" />
                                                </asp:TableCell>
                                                <asp:TableCell></asp:TableCell>
                                            </asp:TableRow>

                                            <asp:TableRow>
                                                <asp:TableCell>
                                                    <asp:Image ID="imgAftCtrRcvStatus" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("AftCtrRcvStatus"))%>' Visible='<%#IIf(Eval("AftCtr").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Label ID="Label6" runat="server" Text='<%#Eval("AftCtr") %>'></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="Center">
                                                    <asp:Image ID="imgBowCtrRcvStatus" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("BowCtrRcvStatus"))%>' Visible='<%#IIf(Eval("BowCtr").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("BowCtr") %>'></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow>
                                                <asp:TableCell Height="28px">
                                                    <asp:Image ID="imgAftStrb" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("AftStrbRcvStatus"))%>' Visible='<%#IIf(Eval("AftStrb").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Label ID="Label8" runat="server" Text='<%#Eval("AftStrb") %>'></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell></asp:TableCell>
                                                <asp:TableCell></asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow>
                                                <asp:TableCell></asp:TableCell>
                                                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                                                    <asp:Image ID="imgStrb" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("StrbRcvStatus"))%>' Visible='<%#IIf(Eval("Strb").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Label ID="Label7" runat="server" Text='<%#Eval("Strb") %>'></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow>
                                                <asp:TableCell></asp:TableCell>
                                                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                                                    <asp:Image ID="Image9" runat="server" ImageUrl='<%#String.Format("../Images/{0}.png", Eval("StubRcvdStatus"))%>' Visible='<%#IIf(Eval("Stub").ToString() = "", 0, 1) = 1 %>' />
                                                    <asp:Label ID="Label4" runat="server" Text='<%#Eval("Stub") %>'></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>

                                        </asp:Table>
                                        <strong>
                                            <asp:Label ID="lblBlackOut" runat="server" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' Text='<%# IIf(Eval("Blackout").ToString() = "1", " BO", "")%>'></asp:Label></strong>
                                        <strong>
                                            <asp:Label ID="Label13" runat="server" Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' Text='<%# IIf(Eval("Protech").ToString() = "Y", " - ProTech", "")%>'></asp:Label></strong>
                                          <asp:ImageButton ID="imgHasAllGates" ToolTip="Has All Gates" runat="server" CssClass="float-right" ImageUrl='<%# Eval("HasAllGates", "../Images/hasallgates{0}.png")%>' Visible='<%# IIf(Eval("InUse").ToString() = "", 0, Eval("InUse")) = 1%>' />                                        
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                     
                    </div>
                    <asp:SqlDataSource ID="sdsRacks" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT RailsSlot, Case When Protech = 1 then 'Y' else 'N' end as Protech, NumGates, RTrim(BowCtr) as BowCtr, Rtrim(BowPort) as BowPort, RTrim(BowStrb) as BowStrb, RTrim(Port) as Port, Rtrim(Strb) as Strb, Rtrim(AftPort) as AftPort, RTrim(AftStrb) as AftStrb, RTrim(AftCtr) as AftCtr ,BowCtrRcvStatus,BowCtrRcv,PortRcvStatus,PortRcv,StrbRcvStatus,
                         StrbRcv,AftPortRcvStatus,AftPortRcv,AftCtrRcvStatus,AftCtrRcv,AftStrbRcvStatus,AftStrbRcv, RTrim(Stub) as Stub, StubRcvdStatus, StubRcvd, HasAllGates,
                         Rails_KittingLocations.ProdNo as ProdNo, DateIn, Rails_KittingLocations.InUse, CusName, CusNo, BML_POPREPORTING_GREENLIGHTS.ItemNo, IsPilot, DueDate, RailsStatus, BuildLoc, Blackout, Powertop, 
                         FurnitureStatus, FiberglassStatus, CoversStatus, TubesStatus, CentertubeNeeded, CentertubeStatus, GaugeStatus, HarnessStatus, HasAllRails, Rails_Tracking.Requested as Requested
                         FROM [Rails_KittingLocations] 
                         left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo 
                         left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo 
                         Left Join Gates_ByProd on Rails_KittingLocations.ProdNo = Gates_ByProd.ProdNo Where InUse = 1 order by RailsSlot"></asp:SqlDataSource>



                    <%--<asp:SqlDataSource ID="sdsRacks" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT RailsSlot, Gates_ByProd.*, Rails_KittingLocations.ProdNo as ProdNo, DateIn,InUse, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.IsPilot, BML_POPREPORTING_GREENLIGHTS.DueDate, RailsStatus, BML_POPREPORTING_GREENLIGHTS.BuildLoc, Blackout, FurnitureStatus, FiberglassStatus, CoversStatus, TubesStatus, CentertubeNeeded, CentertubeStatus, GaugeStatus, HarnessStatus, HasAllGates FROM [Rails_KittingLocations] left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Left Join Gates_ByProd on Rails_KittingLocations.ProdNo = Gates_ByProd.ProdNo order by RailsSlot"></asp:SqlDataSource>--%>
                    <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT GatesSlot, Gates_ByProd.*, Gates_KittingLocations.ProdNo,DateIn,InUse, CusName, CusNo, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.IsPilot, BML_POPREPORTING_GREENLIGHTS.DueDate, RailsStatus, BML_POPREPORTING_GREENLIGHTS.BuildLoc, Blackout, Powertop, FurnitureStatus, FiberglassStatus, CoversStatus, TubesStatus, CentertubeNeeded, CentertubeStatus, GaugeStatus, HarnessStatus, HasAllGates FROM [Gates_KittingLocations] left join BML_POPREPORTING_GREENLIGHTS on Gates_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Gates_KittingLocations.ProdNo = Rails_Tracking.ProdNo Left Join Gates_ByProd on Gates_KittingLocations.ProdNo = Gates_ByProd.ProdNo order by GatesSlot"></asp:SqlDataSource>--%>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
