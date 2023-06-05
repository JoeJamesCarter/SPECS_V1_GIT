<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HelmBuildSheet.aspx.vb" Inherits="Workstations_HelmBuildSheet" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Helm Build Sheet</title>

    <link rel="stylesheet" href="../scripts/css/bootstrap.min.css" />
    <link href="../scripts/css/toastr.css" rel="stylesheet" />
    <script src="../scripts/jquery-3.5.0.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>

    <style type="text/css">
        #body {
            font-family: Calibri;
            width: 800px;
        }

        #footer {
            width: 800px;
            font-family: Calibri;
            font-size: 20px;
            font-weight: bold;
        }

        .cols {
            float: left;
            width: 259px;
            height: 1051px;
        }

        .rightcol {
            float: left;
            width: 320px;
            height: 1051px;
        }

        .categories {
            font-family: Calibri;
            font-size: 20px;
            text-decoration: underline;
            font-style: italic;
            font-weight:bold;
        }

        .prerigs {
            padding-left: 30px;
            font-family: Calibri;
            font-size: 18px;
            display: inline-block;
            background-color: yellow;
        }

        .options {
            padding-left: 30px;
            font-family: Calibri;
            font-size: 18px;
            display: inline-block;
            width: 300px;
         
        }

        .otheroptions {
            font-family: Calibri;
            font-size: 16px;
        }

        .titles {
            font-family: Calibri;
            font-size: 20px;
            font-weight: bold;
        }

        .selected {
            background-color: yellow;
        }

        .barcode {
            font-family: 'IDAutomationSC39S Demo';
            font-size: 14px;
            float: right;
            bottom: 0;
            position: absolute;
        }

        .barcodeinst {
            font-family: 'Calibri';
            font-size: 14px;
            float: right;
            bottom: 0;
            position: absolute;
            margin-bottom: 45px;
            margin-left: 10px;
        }
    </style>
    <%-- <script src="../scripts/jquery-2.1.0.min.js"></script>--%>

    <script type='text/javascript'>
        window.onload = function () {
            $('[name^="cb"]:checked').prev().addClass('selected');
        }
    </script>

    <script type='text/javascript'>
        window.onclick = function () {
            $('[name^="cb"]:not(:checked').prev().removeClass('selected');
            $('[name^="cb"]:checked').prev().addClass('selected');
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">


        <div class="container">
            <div class="row">
                <div id="col1" class="col">
                    <div class="row">
                        <asp:Label ID="lblProdTitle" class="titles mr-1" runat="server" Text="Production #"></asp:Label>
                        <asp:Label ID="lblProdNo" class="categories" runat="server"></asp:Label>
                    </div>                    
                    <div class="row">
                        <asp:Label ID="lblPrerig" CssClass="categories w-100" runat="server" Text="Pre-Rig"></asp:Label>

                        <asp:GridView ID="GridView1" CssClass="prerigs" runat="server" AutoGenerateColumns="False" ShowHeader="false" DataSourceID="sdsOEORDLIN" Width="251px" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="item_desc_1" HeaderText="item_desc_1" SortExpression="item_desc_1" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsOEORDLIN" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT OEORDLIN_SQL.item_no, OEORDLIN_SQL.item_desc_1, [mat_cost_type], IMITMIDX_SQL.prod_cat FROM [OEORDLIN_SQL] Left Join [IMITMIDX_SQL] on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = @ord_no) and (([mat_cost_type] = 'PRE') OR (([mat_cost_type] = 'A4' AND (IMITMIDX_SQL.prod_cat = 'PL2' OR IMITMIDX_SQL.prod_cat = 'PL1'))))">
                            <SelectParameters>
                                <asp:Parameter Name="ord_no" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="row">
                        <asp:Label ID="lblOtherPrerig" class="options" runat="server" Text="Other"></asp:Label>
                        <asp:Label ID="lblOtherPrerigValue" class="otheroptions" runat="server" Text=""></asp:Label>
                    </div>

                    <div class="row">
                        <asp:Label ID="lblSteering" CssClass="categories" runat="server" Text="Steering"></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="lblNonTilt" class="options" runat="server" Text="Non-Tilt"></asp:Label>
                        <asp:CheckBox ID="cbNonTilt" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblTilt" class="options" runat="server" Text="Tilt"></asp:Label>
                        <asp:CheckBox ID="cbTilt" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblSeaStarHyd" class="options" runat="server" Text="Sea-Star Hydraulic"></asp:Label>
                        <asp:CheckBox ID="cbSeaStarHyd" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblPowerAssist" class="options" runat="server" Text="Power Asst"></asp:Label>
                        <asp:CheckBox ID="cbPowerAssist" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblVeradoSteering" class="options" runat="server" Text="Verado"></asp:Label>
                        <asp:CheckBox ID="cbVeradoSteering" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblOtherSteering" class="options" runat="server" Text="Other"></asp:Label>
                        <asp:Label ID="lblOtherSteeringValue" class="otheroptions" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="lblSteeringWheel" CssClass="categories" runat="server" Text="Steering Wheel"></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="lblSSCorvina" class="options" runat="server" Text="SS Corvina"></asp:Label>
                        <asp:CheckBox ID="cbSSCorvina" runat="server" />
                    </div>

                    <div class="row">
                        <asp:Label ID="lblZwoodBeige" class="options" runat="server" Text="ZWood Beige"></asp:Label>
                        <asp:CheckBox ID="cbZWoodBeige" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblGlossBlack" class="options" runat="server" Text="Gloss Black"></asp:Label>
                        <asp:CheckBox ID="cbGlossBlack" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblStandard" class="options" runat="server" Text="Standard"></asp:Label>
                        <asp:CheckBox ID="cbStandard" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblSXPCtrCap" class="options" runat="server" Text="SX/P Ctr Cap"></asp:Label>
                        <asp:CheckBox ID="cbSXPCtrCap" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lbleOtherWheel" class="options" runat="server" Text="Other"></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="lblFlooring" CssClass="categories" runat="server" Text="Flooring"></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="lblVinyl" class="options" runat="server" Text="Vinyl"></asp:Label>
                        <asp:CheckBox ID="cbVinyl" Checked="true" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblGraphGPS" CssClass="categories" runat="server" Text="Graph/GPS"></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="lblStriker" class="options" runat="server" Text="Striker"></asp:Label>
                        <asp:CheckBox ID="cbStriker" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblSimrad" class="options" runat="server" Text="Simrad"></asp:Label>
                        <asp:CheckBox ID="cbSimrad" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblNoGraph" class="options" runat="server" Text="No Graph"></asp:Label>
                        <asp:CheckBox ID="cbNoGraph" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblOtherGraph" class="options" runat="server" Text="Other"></asp:Label>
                        <asp:Label ID="lblOtherGraphValue" class="otheroptions" runat="server"></asp:Label>
                    </div>

                    <div class="row">
                        <asp:Label ID="lblFiberglass" CssClass="categories" runat="server" Text="Fiberglass"></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="lblTaupe" class="options" runat="server" Text="Taupe"></asp:Label>
                        <asp:CheckBox ID="cbTaupe" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="Label5" class="options" runat="server" Text="Ivory"></asp:Label>
                        <asp:CheckBox ID="cbIvory" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="Label6" class="options" runat="server" Text="Silver"></asp:Label>
                        <asp:CheckBox ID="cbSilver" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="Label7" class="options" runat="server" Text="Graphite"></asp:Label>
                        <asp:CheckBox ID="cbGraphite" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="Label8" class="options" runat="server" Text="Ice White"></asp:Label>
                        <asp:CheckBox ID="cbIceWhite" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblShroud" CssClass="categories" runat="server" Text="Shroud"></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="Label2" class="options" runat="server" Text="Espresso"></asp:Label>
                        <asp:CheckBox ID="cbShroudEspresso" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="Label3" class="options" runat="server" Text="Carbon"></asp:Label>
                        <asp:CheckBox ID="cbShroudCarbon" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblTrimAccent" CssClass="categories" runat="server" Text="Trim Accent"></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="lblZwdBeigeTrim" class="options" runat="server" Text="ZWD Beige"></asp:Label>
                        <asp:CheckBox ID="cbZWDBeigeTrim" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblZWDSlateTrim" class="options" runat="server" Text="ZWD Slate"></asp:Label>
                        <asp:CheckBox ID="cbZWDSlateTrim" runat="server" />
                    </div>

                </div>
                <div id="col2" class="col"> 
                     <div class="row">
                        <asp:Label ID="lblModelTitle" class="titles" runat="server" Text="Model:"></asp:Label>&nbsp;<asp:Label ID="lblModel" runat="server" class="categories"></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="lblSpeaker" CssClass="categories" runat="server" Text="Speaker"></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="lblUltimate" class="options" runat="server" Text="Ultimate"></asp:Label><asp:CheckBox ID="cbUltimate" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblKickerLighted" class="options" runat="server" Text="Kicker Lighted"></asp:Label>
                        <asp:CheckBox ID="cbKickerLighted" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblKicker" class="options" runat="server" Text="Kicker"></asp:Label>
                        <asp:CheckBox ID="cbKicker" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblRoswell" class="options" runat="server" Text="Roswell"></asp:Label>
                        <asp:CheckBox ID="cbRoswell" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblRadio" CssClass="categories" runat="server" Text="Radio"></asp:Label>
                    </div>
                    <div class="row">
                        <asp:Label ID="lblKMC45" class="options" runat="server" Text="KMC45"></asp:Label>
                        <asp:CheckBox ID="cbKMC45" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblRockford" class="options" runat="server" Text="Rockford"></asp:Label>
                        <asp:CheckBox ID="cbRockford" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblRockfordAmp" class="options" runat="server" Text="Rockford Amp/Sub"></asp:Label>
                        <asp:CheckBox ID="cbRockfordAmp" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblKickerAmp" class="options" runat="server" Text="Kicker Amp/Sub"></asp:Label>
                        <asp:CheckBox ID="cbKickerAmp" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="blSatOrSirusUpg" class="options" runat="server" Text="Sat or Sirus Upg"></asp:Label>
                        <asp:CheckBox ID="cbSatOrSirusUpg" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblMisc" CssClass="categories" runat="server" Text="Misc"></asp:Label>
                    </div>                   
                    <div class="row">
                        <asp:Label ID="lblPowerTop" class="options" runat="server" Text="Power Top"></asp:Label>
                        <asp:CheckBox ID="cbPowerTop" runat="server" />
                    </div>
                   <%-- <div class="row">
                        <asp:Label ID="lblKD" class="options" runat="server" Text="K/D"></asp:Label>
                        <asp:CheckBox ID="cbKD" runat="server" />
                    </div>--%>
                    <div class="row">
                        <asp:Label ID="lblElevatedHelm" class="options" runat="server" Text="Elevated Helm"></asp:Label>
                        <asp:CheckBox ID="cbElevatedHelm" runat="server" />
                    </div>
                   <%-- <div class="row">
                        <asp:Label ID="Label14" class="options" runat="server" Text="Elv Helm w/Door G"></asp:Label>
                        <asp:CheckBox ID="cbElvHelmwDoor" runat="server" />
                    </div>--%>
                    <div class="row">
                        <asp:Label ID="lblSink" class="options" runat="server" Text="Sink"></asp:Label>
                        <asp:CheckBox ID="cbSink" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblPickUp" class="options" runat="server" Text="Pickup"></asp:Label>
                        <asp:CheckBox ID="cbPickup" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblLiveWell" class="options" runat="server" Text="Live Well"></asp:Label>
                        <asp:CheckBox ID="cbLivewell" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblWashdown" class="options" runat="server" Text="Washdown"></asp:Label>
                        <asp:CheckBox ID="cbWashdown" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblRefricCups" class="options" runat="server" Text="Refrig Cups"></asp:Label>
                        <asp:CheckBox ID="cbRefrigCups" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblMasterPwrSwitch" class="options" runat="server" Text="Master Pwr Switch"></asp:Label>
                        <asp:CheckBox ID="cbMasterPwrSwitch" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblRGBSwitches" class="options" runat="server" Text="RGB Switches"></asp:Label>
                        <asp:CheckBox ID="cbRGBSwitches" runat="server" />
                    </div>
                    <div class="row">
                        <asp:Label ID="lblFuelTank" class="options" runat="server" Text="Fuel Tank"></asp:Label>
                        <asp:CheckBox ID="cbFuelTank" runat="server" />
                    </div>                   
                    <div class="row">
                        <asp:Label ID="lblSpeedo" class="options" runat="server" Text="Speedo"></asp:Label>
                        <asp:CheckBox ID="cbSpeedo" runat="server" />
                    </div>
                      <div class="row">
                        <asp:Label ID="Label12" class="options" runat="server" Text="Glove Box"></asp:Label>
                        <asp:CheckBox ID="cbGloveBox" runat="server" />
                    </div>
                      <div class="row">
                        <asp:Label ID="Label13" class="options" runat="server" Text="Cupholder w/Pocket"></asp:Label>
                        <asp:CheckBox ID="cbCupPocket" runat="server" />
                    </div>
                      <div class="row">
                        <asp:Label ID="Label14" class="options" runat="server" Text="Glass Windshield"></asp:Label>
                        <asp:CheckBox ID="cbGlassWS" runat="server" />
                    </div>
                    <%--<div class="row">
                        <asp:Label ID="lblGrabHandle" class="options" runat="server" Text="BowRider/Grab Handle"></asp:Label>
                        <asp:CheckBox ID="cbHandle" runat="server" />
                    </div>--%>
                    <%--<div class="row">
                        <asp:Label ID="Label12" class="options" runat="server" Text="Merc Active Trim"></asp:Label>
                        <asp:CheckBox ID="cbMercActiveTrim" runat="server" />
                    </div>--%>
                   <%-- <div class="row">
                        <asp:Label ID="Label13" class="options" runat="server" Text="Chaise Console w/Door G"></asp:Label>
                        <asp:CheckBox ID="cbGChaiseConsole" runat="server" />
                    </div>--%>
                   <%-- <div class="row">
                        <asp:Label ID="lblMercZero" class="options" runat="server" Text="Merc Zero Effort Control"></asp:Label>
                        <asp:CheckBox ID="cbMercZero" runat="server" />
                    </div>--%>
                    <div class="row">
                        <asp:Label ID="Label17" CssClass="categories w-100" runat="server" Text="Engines"></asp:Label>

                        <asp:GridView ID="GridView2" CssClass="prerigs" runat="server" AutoGenerateColumns="False" ShowHeader="false" DataSourceID="sdsOEORDLINEngs" Width="251px" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="item_desc_1" HeaderText="item_desc_1" SortExpression="item_desc_1" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsOEORDLINEngs" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT OEORDLIN_SQL.item_no, OEORDLIN_SQL.item_desc_1, [mat_cost_type], IMITMIDX_SQL.prod_cat FROM [OEORDLIN_SQL] Left Join [IMITMIDX_SQL] on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE ord_no = @ord_no and (mat_cost_type = 'ENG' or mat_cost_type = 'ENI')">
                            <SelectParameters>
                                <asp:Parameter Name="ord_no" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="row"></div>
                </div>
                <div id="col3" class="col mt-5">
                    <div class="row"><asp:Label ID="lblCaps" CssClass="categories" runat="server" Text="Dash Panel Caps"></asp:Label></div>
                    <div class="row"> <asp:Label ID="Label1" class="options" runat="server" Text="Underwater Lights"></asp:Label>
                    <asp:CheckBox ID="cbUnderWaterLights" runat="server" /></div>
                    <div class="row"><asp:Label ID="Label4" class="options" runat="server" Text="Ext. Side Lights"></asp:Label>
                    <asp:CheckBox ID="cbExtSideLights" runat="server" /></div>
                    <div class="row"><asp:Label ID="Label9" class="options" runat="server" Text="Livewell"></asp:Label>
                    <asp:CheckBox ID="cbLivewellCap" runat="server" /></div>
                    <div class="row"><asp:Label ID="Label11" class="options" runat="server" Text="Bilge Pump"></asp:Label>
                    <asp:CheckBox ID="cbBilge" runat="server" /></div>
                    <div class="row"><asp:Label ID="Label10" class="options" runat="server" Text="Docking Lights"></asp:Label>
                    <asp:CheckBox ID="cbDocking" runat="server" /></div>
                    <div class="row"></div>

                   
                </div>
            </div>
                   


            <div id="last" class="container">
                <div class="row">
                    <div class="col-sm"><div class="row"><strong><asp:Label ID="lblGraphGPS0" CssClass="categories" runat="server" Text="Comments"></asp:Label></strong></div>
                     <div class="row"><asp:TextBox ID="TextBox1" runat="server" Height="177px" TextMode="MultiLine" Width="262px"></asp:TextBox></div>
                    </div>                    
                    <div class="col-sm"></div>
                    <div class="col-sm">                        
                        <div class="row"> <strong><asp:Label ID="lblPrepInitials" class="footer" runat="server" Text="Prep Initials"></asp:Label></strong>______ </div>
                        <div class="row"><strong><asp:Label ID="lblBuildInitials" class="footer" runat="server" Text="Build Initials"></asp:Label></strong>______ </div>
                        <div class="row"><strong><asp:Label runat="server" class="barcodeinst">Scan to Mark Helm As Ready for Production</asp:Label></strong></div>
                        <div class="row"><asp:Label ID="lblBarcode" class="barcode" runat="server"></asp:Label></div>
                    </div>
                </div>
                </div>
                </div>



    </form>
</body>
</html>
