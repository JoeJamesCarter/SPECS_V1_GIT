<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HelmKittingTV.aspx.vb" Inherits="HelmKittingTV" %>

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
        }

        .blue {
            background-color: lightblue;
            margin: 2px;
        }

        .purple {
            background-color: lavender;
            margin: 2px;
        }

        .yellow {
            background-color: lemonchiffon;
            margin: 2px;
        }

        .tan {
            background-color: wheat;
            margin: 2px;
        }

        .silver {
            background-color: silver;
            margin: 2px;
        }

        .peach {
            background-color: peachpuff;
            margin: 2px;
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

                    <div class="ml-1">

                        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                        <div>
                            <asp:Label ID="Label6" runat="server" Text="Green = Has Furniture and All Rails." CssClass="green"></asp:Label>
                            <asp:Label ID="Label7" runat="server" Text="Blue = Has Furniture, Has All Rails." CssClass="blue"></asp:Label>
                            <asp:Label ID="Label11" runat="server" Text="Silver = Has Furniture and Rails, No Tubes.  " CssClass="silver"></asp:Label>
                            <asp:Label ID="Label8" runat="server" Text="Purple = Furniture Yellow and Has All Rails." CssClass="purple"></asp:Label>
                            <asp:Label ID="Label12" runat="server" Text="Peach = Furniture Green, Missing Rails and Tubes." CssClass="peach"></asp:Label>
                            <asp:Label ID="Label9" runat="server" Text="Yellow = Furniture Red But Shipped, Might Have All Rails. " CssClass="yellow"></asp:Label>
                            <asp:Label ID="Label10" runat="server" Text="Tan = Furniture Yellow and Missing Rails. " CssClass="tan"></asp:Label>
                        </div>

                        <div class="float-left">
                            <asp:GridView ID="gvgreenM" runat="server" class="green" Caption="Main" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnGreenM" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:GridView ID="gvblueM" runat="server" class="blue" Caption="Main" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnBlueM" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>

                            <asp:GridView ID="gvSilverM" runat="server" class="silver" Caption="Main" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnSilverM" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>

                            <asp:GridView ID="gvpurpleM" runat="server" class="purple" Caption="Main " AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnPurpleM" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>

                            <asp:GridView ID="gvPeachM" runat="server" class="peach" Caption="Main " AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnPeachM" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>
                            <asp:GridView ID="gvyellowM" runat="server" class="yellow" Caption="Main" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnYellowM" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:GridView ID="gvtanM" runat="server" class="tan" Caption="Main" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnTanM" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                        
                        <div class="float-left">
                            <asp:GridView ID="gvGreenV" runat="server" class="green" Caption="Value" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnGreenV" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:GridView ID="gvblueV" runat="server" class="blue" Caption="Value" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnBlueV" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>

                            <asp:GridView ID="gvsilverV" runat="server" class="silver" Caption="Value" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnSilverV" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>

                            <asp:GridView ID="gvpurpleV" runat="server" class="purple" Caption="Value " AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnPurpleV" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>

                            <asp:GridView ID="gvPeachV" runat="server" class="peach" Caption="Value " AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnPeachV" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>
                            <asp:GridView ID="gvyellowV" runat="server" class="yellow" Caption="Value" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnYellowV" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:GridView ID="gvtanV" runat="server" class="tan" Caption="Value" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnTanV" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                        <div class="float-left">
                            <asp:GridView ID="gvgreenS" runat="server" class="green" Caption="South" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnGreenM" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>
                            <asp:GridView ID="gvblueS" runat="server" class="blue" Caption="South" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnBlueM" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>

                            <asp:GridView ID="gvSilverS" runat="server" class="silver" Caption="South" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnSilverS" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>

                            <asp:GridView ID="gvpurpleS" runat="server" class="purple" Caption="South" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnPurpleS" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>

                            <asp:GridView ID="gvPeachS" runat="server" class="peach" Caption="South" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnPeachS" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>
                            <asp:GridView ID="gvyellowS" runat="server" class="yellow" Caption="South" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnYellowS" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>
                            <asp:GridView ID="gvtanS" runat="server" class="tan" Caption="South" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="btnTanS" runat="server" CssClass="btn btn-light btn-sm text-align-center" Text='<%#Eval("Prod") %>' CommandArgument='<%#Eval("Prod") %>' CommandName="gotoupdate" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                            </asp:GridView>



                        </div>



                        <div class="float-lef row w-75 ml-2t">
                            <div class="bg-dark text-light w-100 display-4 mb-1 text-center">
                                <asp:Label ID="Label3" runat="server" Text="Main Helm Kits" CssClass="display-5"></asp:Label>
                                <asp:Label ID="Label2" runat="server" Text="   -   # Completed Today: " CssClass="ml5"></asp:Label><asp:Label ID="lblMainCompleted" runat="server" Text=""></asp:Label>
                            </div>
                            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="sdsMain">
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
                                            <asp:Button ID="btnKitComplete" CssClass="btn btn-light btn-sm text-align-center ml-4" runat="server" Text="Mark As Kitted" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoupdate" />
                                            <asp:ImageButton ID="ImageButton1" Visible='<%# IIf(Eval("IsPilot").ToString() = "", 0, Eval("IsPilot")) = 1%>' runat="server" ImageUrl="Images/rackmapPilot1.png" />
                                        </div>
                                    </div>

                                </ItemTemplate>
                            </asp:Repeater>

                                 <div class="bg-dark text-light w-100 display-4 mb-1 text-center">
                                <asp:Label ID="lblV" runat="server" Text="Value Helm Kits" CssClass="display-5"></asp:Label>
                                <asp:Label ID="lblVComp" runat="server" Text="   -   # Completed Today: " CssClass="ml5"></asp:Label><asp:Label ID="lblValueCompleted" runat="server" Text=""></asp:Label>
                            </div>
                            <asp:Repeater ID="Repeater3" runat="server" DataSourceID="sdsValue">
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
                                            <asp:Button ID="btnKitComplete" CssClass="btn btn-light btn-sm text-align-center ml-4" runat="server" Text="Mark As Kitted" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoupdate" />
                                            <asp:ImageButton ID="ImageButton1" Visible='<%# IIf(Eval("IsPilot").ToString() = "", 0, Eval("IsPilot")) = 1%>' runat="server" ImageUrl="Images/rackmapPilot1.png" />
                                        </div>
                                    </div>

                                </ItemTemplate>
                            </asp:Repeater>


                            <div class="bg-dark text-light w-100 display-4 mb-1 text-center">
                                <asp:Label ID="Label4" runat="server" Text="South Helm Kits" CssClass="display-5"></asp:Label>
                                <asp:Label ID="Label5" runat="server" Text="   -   # Completed Today: " CssClass="ml5"></asp:Label><asp:Label ID="lblSouthCompleted" runat="server" Text=""></asp:Label>
                            </div>
                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsPopReporting">
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
                                            <asp:Button ID="btnKitComplete" CssClass="btn btn-light btn-sm text-align-center ml-4" runat="server" Text="Mark As Kitted" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoupdate" />
                                            <asp:ImageButton ID="ImageButton1" Visible='<%# IIf(Eval("IsPilot").ToString() = "", 0, Eval("IsPilot")) = 1%>' runat="server" ImageUrl="Images/rackmapPilot1.png" CssClass="float-right" />
                                        </div>
                                    </div>

                                </ItemTemplate>
                            </asp:Repeater>
                        </div>


                    </div>

                    <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING_GREENLIGHTS.IsPilot, FiberglassInspStatus, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.NotesHelmKitting, BML_POPREPORTING_GREENLIGHTS.BuildLoc,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded,cast(FurnitureStatus as integer) + cast(FiberglassStatus as integer) + cast(CoversStatus as integer) + cast(RailsStatus as integer) + cast(TubesStatus as integer) + cast(CenterTubeStatus as integer) + cast(GaugeStatus as integer) + cast(HarnessStatus as integer) as GreenStatusTotal, cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, Case When FiberglassInspStatus = 2 Then 5 Else FiberglassInspStatus End As SortOrder, HasAllRails, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) And FiberglassStatus = 2 AND GaugeStatus = 2 AND HarnessStatus = 2  AND (BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus &lt; 2) And BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' ORDER BY ProdNo">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="sdsMain" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING_GREENLIGHTS.IsPilot, FiberglassInspStatus, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.NotesHelmKitting, BML_POPREPORTING_GREENLIGHTS.BuildLoc,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded,cast(FurnitureStatus as integer) + cast(FiberglassStatus as integer) + cast(CoversStatus as integer) + cast(RailsStatus as integer) + cast(TubesStatus as integer) + cast(CenterTubeStatus as integer) + cast(GaugeStatus as integer) + cast(HarnessStatus as integer) as GreenStatusTotal, cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, Case When FiberglassInspStatus = 2 Then 5 Else FiberglassInspStatus End As SortOrder, HasAllRails, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) And FiberglassStatus = 2 AND GaugeStatus = 2 AND HarnessStatus = 2  AND (BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus &lt; 2) And BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' ORDER By ProdNo">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="sdsValue" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING_GREENLIGHTS.IsPilot, FiberglassInspStatus, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.NotesHelmKitting, BML_POPREPORTING_GREENLIGHTS.BuildLoc,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded,cast(FurnitureStatus as integer) + cast(FiberglassStatus as integer) + cast(CoversStatus as integer) + cast(RailsStatus as integer) + cast(TubesStatus as integer) + cast(CenterTubeStatus as integer) + cast(GaugeStatus as integer) + cast(HarnessStatus as integer) as GreenStatusTotal, cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, Case When FiberglassInspStatus = 2 Then 5 Else FiberglassInspStatus End As SortOrder, HasAllRails, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) And FiberglassStatus = 2 AND GaugeStatus = 2 AND HarnessStatus = 2  AND (BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus &lt; 2) And BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' ORDER By ProdNo">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        </div>
    </form>
</body>
</html>
