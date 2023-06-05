<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HelmKittingLbl.aspx.vb" Inherits="KittingLabels_HelmKittingLbl" Debug="true" EnableEventValidation ="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Helm Kitting Labels</title>
    <link rel="stylesheet" href="../scripts/css/bootstrap.min.css" />
    <link href="../scripts/css/toastr.css" rel="stylesheet" />
    <script src="../scripts/jquery-3.5.0.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
    <style>
        .hiddendiv {
            display: none;
        }

        .optionswider {
            display: inline;
            width: 150px;
        }
    </style>
    <script type="text/javascript">
        //Hide col 3 of the helm build sheet. She doesn't need it and I wanted to remove the barcode
        //ToDo - Pass vars for Prod and Model to load url

        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }

        var SO = getUrlVars()["SONo"];
        var Prod = getUrlVars()["ProdNo"];
        var Boat = getUrlVars()["Boat"];

        

        $(document).ready(function () {
            console.log("window loaded");
            console.log(Prod)
            console.log(Boat)

            $('#buildsheethtml').load('../Workstations/HelmBuildSheet.aspx?ProdNo=' + Prod + '&Model='+ Boat +'').OuterHtml;

            $.ajax({
                url: '../Workstations/HelmBuildSheet.aspx?ProdNo=' + Prod + '&Model=' + Boat + '',
                type: "GET",
                dataType: "html",
                success: function (res) {
                    $("#last").html($(res).find("#last")
                        .addClass('hiddendiv'))
                    $("#col3").html($(res).find("#col3")
                        .addClass('hiddendiv'))

                    $(".options").removeAttr("style");
                    $(".options").addClass("optionswider");
                    $(".options").removeClass("options");

                    $("input:checkbox").not(":checked").hide();
                    $("input:checkbox:not(:checked)").prev().remove(); //label
                    $("input:checkbox:not(:checked)").prev().remove(); //and line breaks                    

                    $("#lblOtherPrerig").remove();
                    $("#lbleOtherWheel").remove();
                    $("#lblOtherSteering").remove();
                    $("#lblOtherGraph").remove();
                    $("#lblGraphGPS0").remove();
                    $("#TextBox1").remove();
                   // $("#lblPrerig").remove();
                    //$(".prerigs").remove();
                    $("#lblModelTitle").remove();
                    $("#lblModel").remove();
                    $("#lblProdTitle").remove();
                    $("#lblProdNo").remove();

                    $("input:checkbox").hide(); //no real need to show them at this point                                      

                    $('#col2').contents().appendTo($("#col1")); //Put them all in one col and remove the other 2.
                    $('#col2').remove();
                    $('#col3').remove();

                }

            });
        });



    </script>
</head>
<body>
    <form id="form1" runat="server">

        <div class="container">
            <div class="row">
                <div class="col float-left w-25">
                    <div class="row">
                        <table class="table table-sm">
                            <tbody>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" CssClass="pl-1" Text="Prod #"></asp:Label>
                                        <asp:Label ID="lblProdNoKitLbl" runat="server" CssClass="pl-1" Text=""></asp:Label>-
                                    <asp:Label ID="lblModelKitLbl" runat="server" CssClass="pl-1" Text=""></asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <asp:Label ID="Label3" runat="server" CssClass="pl-1" Text="Fuel Capacity:"></asp:Label>
                                        <asp:Label ID="lblFuelCap" runat="server" Text=""></asp:Label>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblEADHdr" runat="server" CssClass="pl-1" Text="Ext Aft Deck?"></asp:Label><asp:Label ID="lblEAD" runat="server" CssClass="pl-1" Text=""></asp:Label></td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" CssClass="pl-1" Text="Cable Length:"></asp:Label><asp:Label ID="lblCblLen" runat="server" CssClass="pl-1" Text=""></asp:Label></td>

                                </tr>


                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div id="buildsheethtml" runat="server"></div>
                    </div>
                </div>
                <div class="col float-left w-50">
                    <div class="row">
                        <asp:GridView ID="gvPrerigs" CssClass="table table-sm w-auto" GridLines="Horizontal" runat="server"></asp:GridView>                        
                    </div>
                    <div class="row">
                        <asp:GridView ID="gvPreRigParts" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" ForeColor="Black" GridLines="Vertical">
                            <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>
                                <asp:BoundField DataField="comp_item_no" HeaderText="Part #" />
                                <asp:BoundField DataField="item_desc_1" HeaderText="Desc" />
                                <asp:TemplateField Visible ="False">
                                    <ItemTemplate>
                                        <asp:Button ID="btnRemove" CssClass="button" runat="server" CommandArgument='<%#Eval("comp_item_no") %>' CommandName ="markasnotkittedhere" Text="I Don't Kit This" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="Gray" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
                    </div>
                </div>

            </div>
            <asp:HiddenField ID="hdnPrerigPart" runat="server" />
            <asp:GridView ID="gvTest" runat="server" caption="test"></asp:GridView>
            <asp:GridView ID="gvTest2" runat="server"></asp:GridView>
            <asp:GridView ID="gvTest3" runat="server"></asp:GridView>
            

        </div>



    </form>

</body>
</html>
