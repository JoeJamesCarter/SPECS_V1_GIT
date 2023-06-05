<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HelmKittingMap.aspx.vb" Inherits="HelmKittingMap" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Helm Kits</title>
    <link rel="stylesheet" href="scripts/css/bootstrap.min.css" />
    <link href="scripts/css/toastr.css" rel="stylesheet" />
    <script src="scripts/jquery-3.5.0.min.js"></script>
    <script src="scripts/bootstrap.min.js"></script>
    <script src="scripts/toastr.min.js"></script>

    <style>
        .green {
            background-color: lightgreen;
            margin: 2px;
            float: left;
        }

        .blue {
            background-color: lightblue;
            margin: 2px;
            float: left;
        }

        .purple {
            background-color: lavender;
            margin: 2px;
            float: left;
        }

        .yellow {
            background-color: lemonchiffon;
            margin: 2px;
            float: left;
        }

        .tan {
            background-color: wheat;
            margin: 2px;
            float: left;
        }

        .silver {
            background-color: silver;
            margin: 2px;
            float: left;
        }

        .peach {
            background-color: peachpuff;
            margin: 2px;
            float: left;
        }
         .white {
            background-color: white;
            margin: 2px;
            float: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid m-1">

            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                    <div class="jumbotron-fluid display-3">
                        <div class="container-fluid">
                            <div class="row" >
                                <div class="display-4">
                                    <asp:Label ID="Label2" runat="server" Text=" Kits Completed Today  - " ></asp:Label>
                                    <asp:Label ID="Label3" runat="server" Text="Main: "></asp:Label>
                                    <asp:Label ID="lblMainCompleted" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Label ID="Label5" runat="server" Text="Value: "></asp:Label>
                                    <asp:Label ID="lblValueCompleted" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Label ID="Label4" runat="server" Text="South: "></asp:Label>
                                    <asp:Label ID="lblSouthCompleted" runat="server" Text=""></asp:Label>
                              
                                <div class="h4">
                                    <asp:Label ID="Label6" runat="server" Text="Green = Has Furniture and Rails." CssClass="green"></asp:Label>
                                    <asp:Label ID="Label7" runat="server" Text="Blue = Has Furniture, Has Rails Pulled to Panel." CssClass="blue"></asp:Label>
                                    <asp:Label ID="Label11" runat="server" Text="Silver = Has Furniture and Rails But Not Pulled to Panel.  " CssClass="silver"></asp:Label>
                                    <asp:Label ID="Label8" runat="server" Text="Purple = Furniture Yellow and Has All Rails." CssClass="purple"></asp:Label>
                                    <asp:Label ID="Label12" runat="server" Text="Peach = Furniture Green, Missing Rails and Tubes." CssClass="peach"></asp:Label>
                                    <asp:Label ID="Label9" runat="server" Text="Yellow = Furniture Red But Shipped, Might Have All Rails. " CssClass="yellow"></asp:Label>
                                    <asp:Label ID="Label10" runat="server" Text="Tan = Furniture Yellow and Missing Rails. " CssClass="tan"></asp:Label>
                                </div>
                                      </div>
                            </div>
                            <div class="row display-4">Main & Value</div>
                            <div class="row bg-light">
                                <div>
                                    <asp:GridView ID="gvgreenM" runat="server" class="green" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>-                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label14" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvblueM" runat="server" class="blue" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>-                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label14" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvSilverM" runat="server" class="silver" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>-                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div>
                                    <asp:GridView ID="gvpurpleM" runat="server" class="purple" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvPeachM" runat="server" class="peach" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvyellowM" runat="server" class="yellow" AutoGenerateColumns="False" ShowHeader="False" AllowPaging="True" PageSize="6">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div>
                                    <asp:GridView ID="gvtanM" runat="server" class="tan" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvWhiteM" runat="server" class="white" AutoGenerateColumns="False" ShowHeader="False" AllowPaging="True" PageSize="6">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                            </div>
                            <hr />
                            <div class="row display-4">South</div>
                            <div class="row">
                                <div>
                                    <asp:GridView ID="gvgreenS" runat="server" class="green" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    - 
                                            <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div>
                                    <asp:GridView ID="gvblueS" runat="server" class="blue" AutoGenerateColumns="false" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>


                                <div>
                                    <asp:GridView ID="gvSilverS" runat="server" class="silver" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvpurpleS" runat="server" class="purple" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvPeachS" runat="server" class="peach" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvyellowS" runat="server" class="yellow" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvtanS" runat="server" class="tan" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvWhiteS" runat="server" class="white" AutoGenerateColumns="False" ShowHeader="False" AllowPaging="True" PageSize="6">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>

                            </div>


                        </div>
                    </div>

                    <div class="float-lef row w-75 ml-2t">
                        <div class="bg-dark text-light w-100 display-4 mb-1 text-center">
                        </div>
                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="sdsMain" Visible="false">
                            <ItemTemplate>
                                <div id="thiscard" runat="server" class="card text-center float-left border-dark mr-1 mb-1" style="width: 19rem; height: 6rem">
                                    <h5 class="card-header">
                                        <asp:Label ID="lblProd" CssClass="title display-5 w-15 float-left" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><asp:Label ID="lblBldg" CssClass="title display-5 w-15 float-left" runat="server" Text='<%# "-" & Eval("BuildLoc")%>'></asp:Label>
                                        <asp:Label ID="lblBoat" CssClass="boatinfoboat float-right display-5" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                    </h5>
                                    <%-- <asp:Label ID="Label4" runat="server" cssClass="display-5" Text='<%# SplitBVatDash(Eval("BaseVinylColor"))%>'></asp:Label><br />--%>
                                    <div>
                                        <asp:Label ID="Label1" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label><asp:Image ID="FGI" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" />
                                        <%--  <asp:Button ID="btnBuildSheet" CssClass="btn btn-light btn-sm text-align-center mr-4" runat="server" Text="Print Build Sheet" />--%>
                                        <%--<asp:Button ID="btnKitComplete" CssClass="btn btn-light btn-sm text-align-center ml-4" runat="server" Text="Mark As Kitted" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoupdate" />
                                        <asp:ImageButton ID="ImageButton1" Visible='<%# IIf(Eval("IsPilot").ToString() = "", 0, Eval("IsPilot")) = 1%>' runat="server" ImageUrl="Images/rackmapPilot1.png" />--%>
                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:Repeater>
                        <%-- </div>
                        <div class="float-left">--%>
                        <div class="bg-dark text-light w-100 display-4 mb-1 text-center">
                        </div>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsPopReporting" Visible="false">
                            <ItemTemplate>
                                <div id="thiscard" runat="server" class="card text-center float-left border-dark mr-1 mb-1" style="width: 19rem; height: 6rem">
                                    <h5 class="card-header">
                                        <asp:Label ID="lblProd" CssClass="title display-5 w-15 float-left" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><asp:Label ID="lblBldg" CssClass="title display-5 w-15 float-left" runat="server" Text='<%# "-" & Eval("BuildLoc")%>'></asp:Label>
                                        <asp:Label ID="lblBoat" CssClass="boatinfoboat float-right display-5" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                    </h5>
                                    <%-- <asp:Label ID="Label4" runat="server" cssClass="display-5" Text='<%# SplitBVatDash(Eval("BaseVinylColor"))%>'></asp:Label><br />--%>
                                    <div>
                                        <asp:Label ID="Label1" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label><asp:Image ID="FGI" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" />
                                        <%--<asp:Button ID="btnBuildSheet" CssClass="btn btn-light btn-sm text-align-center mr-4" runat="server" Text="Print Build Sheet" />--%>
                                       <%-- <asp:Button ID="btnKitComplete" CssClass="btn btn-light btn-sm text-align-center ml-4" runat="server" Text="Mark As Kitted" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoupdate" />
                                        <asp:ImageButton ID="ImageButton1" Visible='<%# IIf(Eval("IsPilot").ToString() = "", 0, Eval("IsPilot")) = 1%>' runat="server" ImageUrl="Images/rackmapPilot1.png" CssClass="float-right" />--%>
                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:Repeater>
                    </div>


                 

                    <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING_GREENLIGHTS.IsPilot, FiberglassInspStatus, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.NotesHelmKitting, BML_POPREPORTING_GREENLIGHTS.BuildLoc,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded,cast(FurnitureStatus as integer) + cast(FiberglassStatus as integer) + cast(CoversStatus as integer) + cast(RailsStatus as integer) + cast(TubesStatus as integer) + cast(CenterTubeStatus as integer) + cast(GaugeStatus as integer) + cast(HarnessStatus as integer) as GreenStatusTotal, cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, Case When FiberglassInspStatus = 2 Then 5 Else FiberglassInspStatus End As SortOrder, HasAllRails, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) And FiberglassStatus = 2 AND (BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus &lt; 2) AND GaugeStatus = 2 AND HarnessStatus = 2 AND (BML_POPREPORTING_GREENLIGHTS.FiberglassInspStatus &gt; 0) And BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' ORDER BY ProdNo">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="sdsMain" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING_GREENLIGHTS.IsPilot, FiberglassInspStatus, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.NotesHelmKitting, BML_POPREPORTING_GREENLIGHTS.BuildLoc,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded,cast(FurnitureStatus as integer) + cast(FiberglassStatus as integer) + cast(CoversStatus as integer) + cast(RailsStatus as integer) + cast(TubesStatus as integer) + cast(CenterTubeStatus as integer) + cast(GaugeStatus as integer) + cast(HarnessStatus as integer) as GreenStatusTotal, cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, Case When FiberglassInspStatus = 2 Then 5 Else FiberglassInspStatus End As SortOrder, HasAllRails, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) And FiberglassStatus = 2 AND (BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus &lt; 2) AND GaugeStatus = 2 AND HarnessStatus = 2  AND (BML_POPREPORTING_GREENLIGHTS.FiberglassInspStatus &gt; 0) And (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' or BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V') ORDER By ProdNo">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

    </form>
</body>
</html>
