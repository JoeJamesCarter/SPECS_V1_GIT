<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PhyInvTubeInfo.aspx.vb" Inherits="Barcode_Tubes_PhyInvTubeInfo" Debug="true" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Phy Inv Tube Inquiry</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../../scripts/css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="w-100">
            <div id="tubeinfo" class="form-inline w-100 bg-light m-2">
                <label class="h3 p-2 w-100 mb-2 bg-dark text-light text-center">Lookup Tube Info</label>
                <%--<asp:Label ID="Label24" runat="server" cssclass="h3 w-100" Text="Lookup Tube Info #:"></asp:Label><br />--%>
                <asp:Label ID="Label1" runat="server" class="h4 w-25 mt-2" Text="Prod #:"></asp:Label>
                <asp:TextBox ID="tbTubeInfo" runat="server" CssClass="h4 mt-2"></asp:TextBox>

                <div id="top" class="w-100 mt-4 mb-4">
                    <asp:Label ID="lblProdNo" runat="server" CssClass="h5 m-2"></asp:Label>
                    <asp:Label ID="lblTubeType" runat="server" CssClass="h5 m-2" Text=""></asp:Label>
                    <asp:Label ID="lblPSC" runat="server" CssClass="h5 m-2" Text=""></asp:Label>
                    <asp:Label ID="lblModel" runat="server" CssClass="h5 m-2" Text=""></asp:Label>
                </div>

                <div id="centers" runat="server" class="w-50 float-left border border-success p-1 align-self-start">

                    <asp:Label ID="Label3" CssClass="font-weight-bold w-50 d-inline-block" runat="server" Text="Type : "></asp:Label>
                    <asp:Label ID="lblShape" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label2" runat="server" CssClass="font-weight-bold w-50 d-inline-block" Text="Length: "></asp:Label>
                    <asp:Label ID="lblCLength" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label4" runat="server" CssClass="font-weight-bold w-50 d-inline-block" Text="Storage:"></asp:Label>
                    <asp:Label ID="lblStorage" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label5" runat="server" CssClass="font-weight-bold w-50 d-inline-block" Text="10 Wide? :"></asp:Label>
                    <asp:Label ID="lblTenWide" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label7" runat="server" CssClass="font-weight-bold w-50 d-inline-block" Text="Drawing: "></asp:Label>
                    <asp:Label ID="lblCDrawingNo" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label8" runat="server" CssClass="font-weight-bold w-50 d-inline-block" Text="Fuel:"></asp:Label>
                    <asp:Label ID="lblCFuel" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label9" runat="server" CssClass="font-weight-bold w-50 d-inline-block" Text="Tube Upg:"></asp:Label>
                    <asp:Label ID="lblTubeUpg" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label11" runat="server" CssClass="font-weight-bold w-50 d-inline-block" Text="Strakes:"></asp:Label>
                    <asp:Label ID="lblCStrakes" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label10" runat="server" CssClass="font-weight-bold w-50 d-inline-block" Text="Upsweep:"></asp:Label>
                    <asp:Label ID="lblUpsweep" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label6" runat="server" CssClass="font-weight-bold w-50 d-inline-block" Text="Brackets:"></asp:Label>
                    <asp:Label ID="lblCBracket" runat="server" CssClass="w-50" Text=""></asp:Label>
                     <br />
                    <asp:Label ID="Label16" CssClass="font-weight-bold d-inline-block w-50  " runat="server" Text="Center Chine Stock:"></asp:Label>
                    <asp:Label ID="lblCtrStockLength" runat="server" Text="" CssClass="w-50"></asp:Label>
                    <asp:Label ID="lblCtrStockType" runat="server" Text="" CssClass="w-50"></asp:Label>
                    <asp:Label ID="lblCtrStockCorF" runat="server" Text="" CssClass="w-50"></asp:Label>
                </div>

                <div id="outers" runat="server" class="w-50 float-left border border-success p-1 align-self-start">

                    <asp:Label ID="Label12" CssClass="font-weight-bold d-inline-block w-50" runat="server" Text="Length: "></asp:Label>
                    <asp:Label ID="lblOLength" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label13" CssClass="font-weight-bold d-inline-block w-50" runat="server" Text="Style: "></asp:Label>
                    <asp:Label ID="lblStyle" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label14" CssClass="font-weight-bold d-inline-block w-50" runat="server" Text="Diameter:"></asp:Label>
                    <asp:Label ID="lblDiameter" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <%-- <br />
                    <asp:Label ID="Label15" CssClass="font-weight-bold d-inline-block w-50" runat="server" Text="Ladder:"></asp:Label>
                    <asp:Label ID="lblLadder" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label16" CssClass="font-weight-bold d-inline-block w-50" runat="server" Text="Keel:"></asp:Label>
                    <asp:Label ID="lblKeel" runat="server" CssClass="w-50" Text=""></asp:Label>--%>
                    <br />
                    <asp:Label ID="Label17" CssClass="font-weight-bold d-inline-block w-50" runat="server" Text="Splash:"></asp:Label>
                    <asp:Label ID="lblSplash" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label18" CssClass="font-weight-bold d-inline-block w-50" runat="server" Text="Strakes:"></asp:Label>
                    <asp:Label ID="lblOStrakes" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <%-- <br />
                    <asp:Label ID="Label19" CssClass="font-weight-bold d-inline-block w-50" runat="server" Text="Strb Trans:"></asp:Label>
                    <asp:Label ID="lblStrbTrans" runat="server" CssClass="w-50" Text=""></asp:Label>--%>
                    <br />
                    <asp:Label ID="Label20" CssClass="font-weight-bold d-inline-block w-50" runat="server" Text="Comments:"></asp:Label>
                    <asp:Label ID="lblComments" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <br />
                    <asp:Label ID="Label21" CssClass="font-weight-bold d-inline-block w-50" runat="server" Text="Blackout:"></asp:Label>
                    <asp:Label ID="lblBlack" runat="server" CssClass="w-50" Text=""></asp:Label>
                    <%-- <br />
                    <asp:Label ID="Label23" CssClass="font-weight-bold d-inline-block w-50 " runat="server" Text="Drawing: "></asp:Label>
                    <asp:Label ID="lblODrawingNo" runat="server" Text="" CssClass="w-50"></asp:Label>--%>
                    <br />
                    <asp:Label ID="Label25" CssClass="font-weight-bold d-inline-block w-50 " runat="server" Text="Fuel:"></asp:Label>
                    <asp:Label ID="lblOFuel" runat="server" Text="" CssClass="w-50"></asp:Label>
                    <br />
                    <asp:Label ID="Label22" CssClass="font-weight-bold d-inline-block w-50  " runat="server" Text="Brackets:"></asp:Label>
                    <asp:Label ID="lblOBracket" runat="server" Text="" CssClass="w-50"></asp:Label>
                    <br />
                    <asp:Label ID="Label15" CssClass="font-weight-bold d-inline-block w-50  " runat="server" Text="Inside Chine/Foil Stock:"></asp:Label>
                    <asp:Label ID="lblInsideStockLength" runat="server" Text="" CssClass="w-50"></asp:Label>
                    <asp:Label ID="lblInsideStockType" runat="server" Text="" CssClass="w-50"></asp:Label>
                    <asp:Label ID="lblInsideStockCorF" runat="server" Text="" CssClass="w-50"></asp:Label>
                    <br />
                    <asp:Label ID="Label19" CssClass="font-weight-bold d-inline-block w-50  " runat="server" Text="Outside Chine/Foil Stock:"></asp:Label>
                    <asp:Label ID="lblOutsideStockLength" runat="server" Text="" CssClass="w-50"></asp:Label>
                    <asp:Label ID="lblOutsideStockType" runat="server" Text="" CssClass="w-50"></asp:Label>
                    <asp:Label ID="lblOutsideStockCorF" runat="server" Text="" CssClass="w-50"></asp:Label>
                </div>

                <div id="tagdata" class=" pl-1 w-50 float-left bg-light text-dark mb-1">
                    <%--<label>Solid Green is Selected For This Tube</label>--%>
                    <asp:GridView ID="gvTagPredictions" class="float-left w-auto border-0" AutoGenerateColumns="False" runat="server" GridLines="Horizontal">
                        <Columns>
                            <asp:TemplateField HeaderText="Possible Tube Tags">
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td rowspan="2">
                                                <asp:Button ID="btnTag" runat="server" Text='<%#Eval("TagNo") %>' CommandArgument='<%#Eval("TagNo") %>' CommandName="selecttubetags" />
                                            </td>
                                            <td>
                                                <asp:Label runat="server" Text='<%#Eval("PartNo") %>'></asp:Label><br />
                                                <asp:Label runat="server" Text='<%#Eval("PartDesc") %>'></asp:Label>&nbsp;<asp:Label runat="server" Text='<%#Eval("Thickness") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    
                      <asp:GridView ID="gvCtrTagPredictions" class="float-left w-auto border-0" AutoGenerateColumns="False" runat="server" GridLines="Horizontal">
                        <Columns>
                            <asp:TemplateField HeaderText="Possible Center Tags">
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td rowspan="2">
                                                <asp:Button ID="btnTag" runat="server" Text='<%#Eval("TagNo") %>' CommandArgument='<%#Eval("TagNo") %>' CommandName="selecttubetags" />
                                            </td>
                                            <td>
                                                <asp:Label runat="server" Text='<%#Eval("PartNo") %>'></asp:Label><br />
                                                <asp:Label runat="server" Text='<%#Eval("PartDesc") %>'></asp:Label>&nbsp;<asp:Label runat="server" Text='<%#Eval("Thickness") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:GridView ID="gvChines" AutoGenerateColumns="False" class="float-left w-auto border-0 mb-1" runat="server" GridLines="Horizontal">
                        <Columns>
                            <asp:TemplateField HeaderText="Possible Chine/Foil Tags">
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td rowspan="2">
                                                <asp:Button ID="btnTag" runat="server" Text='<%#Eval("TagNo") %>' CommandArgument='<%#Eval("TagNo") %>' CommandName="selecttubetags"  />
                                            </td>
                                            <td>
                                                <asp:Label runat="server" Text='<%#Eval("PartNo") %>'></asp:Label><br />
                                                <asp:Label runat="server" Text='<%#Eval("PartDesc") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                     <asp:GridView ID="gvStorage" AutoGenerateColumns="False" class="float-left w-auto border-0 mb-1" runat="server" GridLines="Horizontal">
                        <Columns>
                            <asp:TemplateField HeaderText="Possible Storage Tags">
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td rowspan="2">
                                                <asp:Button ID="btnTag" runat="server" Text='<%#Eval("TagNo") %>' CommandArgument='<%#Eval("TagNo") %>' CommandName="selecttubetags"  />
                                            </td>
                                            <td>
                                                <asp:Label runat="server" Text='<%#Eval("PartNo") %>'></asp:Label><br />
                                                <asp:Label runat="server" Text='<%#Eval("PartDesc") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:GridView ID="gvFuel" AutoGenerateColumns="False" class="float-left w-auto border-0 mb-1" runat="server" GridLines="Horizontal">
                        <Columns>
                            <asp:TemplateField HeaderText="Possible Fuel Tags">
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td rowspan="2">
                                                <asp:Button ID="btnTag" runat="server" Text='<%#Eval("TagNo") %>' CommandArgument='<%#Eval("TagNo") %>' CommandName="selecttubetags"  />
                                            </td>
                                            <td>
                                                <asp:Label runat="server" Text='<%#Eval("PartNo") %>'></asp:Label><br />
                                                <asp:Label runat="server" Text='<%#Eval("PartDesc") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <%--  <asp:Button ID="btnClear" runat="server" Text="Clear Screen" />--%>
                </div>
            </div>

        </div>

    </form>
    <script src="../../scripts/jquery-3.5.0.min.js"></script>
    <script src="../../scripts/bootstrap.min.js"></script>
</body>
</html>
