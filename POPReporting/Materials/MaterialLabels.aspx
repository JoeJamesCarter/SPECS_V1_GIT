<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MaterialLabels.aspx.vb" Inherits="Materials_MaterialLabels" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Material Labels</title>
    <style>
        #scannerscreen {
            width:2000px;
            font-family:Calibri;
            font-size:60px;            
        }
        .inputs {
            font-family:Calibri;
            font-size:50px;
            margin-right: 13px;
            font-weight:bold;
        }
        .title {
            font-family:Calibri;
            font-size:50px;
            font-weight:bold;
           margin:0 auto;
        }
         #labelText {
            width:1000px;
            text-align:center;
        }
        .Header {
            font-family:Calibri;
            font-size:20px;
            font-weight:bold;
            Width:50%;            
        }
        .Component {
            font-family:Calibri;
            font-size:20px;                      
            Width:50%;
        }

          .smaller {
            font-family:Calibri;
            font-size:15px;                                  
        }
    </style>

   </head>
<body>
    <form id="form1" runat="server">
    <div id="scannerscreen">
<asp:Label ID="Label1" runat="server" cssClass="title" Text="Part # Lookup & Label Printing" Width="1261px" ForeColor="Blue"></asp:Label>
        <hr />
        <asp:Label ID="Label2" runat="server" cssClass="inputs" Text="Ben Part #"></asp:Label>&nbsp;&nbsp;<asp:TextBox ID="tbBenPart" cssClass="inputs" runat="server" Width="257px" BorderStyle="Solid" AutoPostBack="True"></asp:TextBox>
        &nbsp;&nbsp;<asp:Label ID="Label3" runat="server" cssClass="inputs" Text="Vendor Part #"></asp:Label>&nbsp;&nbsp; <asp:TextBox ID="tbVendPart" runat="server" Width="257px" cssClass="inputs" BorderStyle="Solid" AutoPostBack="True"></asp:TextBox>
              
        &nbsp;&nbsp;
                      
        &nbsp;&nbsp;&nbsp;&nbsp;
                      
        <br />
        
        <br />
        <asp:Label ID="lblResults" runat="server" Text="Results" cssClass="inputs"></asp:Label>
        <asp:GridView ID="gvResults" runat="server" DataSourceID="sdsMacola" AutoGenerateColumns="False" Width="1261px" Font-Size="30pt">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="item_no" HeaderText="Item #" />
                <asp:BoundField DataField="item_desc_1" HeaderText="Desc" />
                <asp:BoundField DataField="item_desc_2" HeaderText="Vendor #" />
            </Columns>
        </asp:GridView>
        <br />
        <asp:GridView ID="gvLocations" runat="server" AutoGenerateColumns="False" Width="1261px" DataKeyNames="Item_No" DataSourceID="sdsLocationsByPart" Caption="Locations" Font-Size="30pt">
            <Columns>
                <asp:BoundField DataField="Item_No" HeaderText="Item #" ReadOnly="True" SortExpression="Item_No" Visible="False" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Loc1" HeaderText="M-Back" SortExpression="Loc1" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Loc2" HeaderText="M-Middle" SortExpression="Loc2" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Loc3" HeaderText="Loc3" SortExpression="Loc3" Visible="False" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Loc4" HeaderText="S" SortExpression="Loc4" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsLocationsByPart" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Item_No], [Loc1], [Loc2], [Loc3], [Loc4] FROM [LocationsByPart] WHERE ([Item_No] = @Item_No)">
            <SelectParameters>
                <asp:ControlParameter ControlID="tbBenPart" Name="Item_No" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Label ID="Label5" runat="server" cssClass="inputs" Text="Qty:"></asp:Label>
        &nbsp;<asp:TextBox ID="tbQty" runat="server"  cssClass="inputs" Width="126px" BorderStyle="Solid"></asp:TextBox>&nbsp;<asp:Label ID="Label7" runat="server" CssClass="inputs" Text="# Labels:"></asp:Label>
        &nbsp; <asp:TextBox ID="tbNumLabels" cssClass="inputs" BorderStyle="Solid" runat="server" Width="95px"></asp:TextBox>
        &nbsp;&nbsp;
                

        <br />

        <br />
       <asp:DropDownList ID="ddlPrinters" runat="server" Font-Size="30pt" AutoPostBack="True" DataSourceID="sdsPrinters" DataTextField="PrinterName" DataValueField="IP" AppendDataBoundItems="true">
                <asp:ListItem></asp:ListItem>           
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsPrinters" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Printers] ORDER BY [DisplayOrder]"></asp:SqlDataSource>
        <br />
        <br />
        <br />
                

        <asp:Button ID="btnPrint" Font-Size="60px" runat="server" Text="Print" Visible="false" OnClientClick="print(); return false;" Height="147px" Width="1266px" Font-Bold="True" />     


        <br />
                

        <br />
        <asp:Button ID="btnClear" runat="server" Text="Clear" Height="147px" Width="1266px" Font-Size="50pt" Font-Bold="True" />
              
        <br />

        <asp:SqlDataSource ID="sdsMacola" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_no], [item_desc_1],[item_desc_2] FROM [IMITMIDX_SQL] WHERE [activity_cd] = 'A' and (([item_no] LIKE  '%' + @item_no + '%') or ([item_desc_2]  LIKE  '%' + @vend_part + '%'))">
           <SelectParameters>
             <asp:ControlParameter ControlID="tbBenPart" Name="item_no" DefaultValue = 'ZXY' Type="String" />
               <asp:ControlParameter ControlID="tbVendPart" Name="vend_part" DefaultValue = 'ZXY' Type="String" />
             </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br /> 
        
        <asp:TextBox ID="selectedVendorNo" runat="server" Enabled="false"></asp:TextBox>
        <asp:TextBox ID="selectedDesc" runat="server" Enabled ="false"></asp:TextBox>

        <asp:TextBox ID="tbLoc1" runat="server" Enabled ="false"></asp:TextBox>
        <asp:TextBox ID="tbLoc2" runat="server" Enabled ="false"></asp:TextBox>
        <asp:TextBox ID="tbLoc3" runat="server" Enabled ="false"></asp:TextBox>
        <asp:TextBox ID="tbLoc4" runat="server" Enabled ="false"></asp:TextBox>

    </div>
        
        
       <div id="output"></div>
        <script>

            function print() {
                var benpart = document.getElementById("tbBenPart").value;
                var vendpart = document.getElementById("selectedVendorNo").value;
                var desc = document.getElementById("selectedDesc").value;
                var qty = document.getElementById("tbQty").value;
                var bcqty = document.getElementById("tbQty").value;
                var numlabels = document.getElementById("tbNumLabels").value;

                var loc1 = document.getElementById("tbLoc1").value;
                var loc2 = document.getElementById("tbLoc2").value;
                var loc3 = document.getElementById("tbLoc3").value;
                var loc4 = document.getElementById("tbLoc4").value;

                var ip_addr = ""
             
                var e = document.getElementById("ddlPrinters");                
                ip_addr = e.options[e.selectedIndex].value;
                
                //escape quotes and single quotes
                vendpart = vendpart.replace(/(&quot\;)/g, "\"")
                vendpart = vendpart.replace(/(&#39\;)/g, "'")
                desc = desc.replace(/(&quot\;)/g, "\"")
                desc = desc.replace(/(&#39\;)/g, "'")

                //format qty with comma and remove comma from barcode if it is entered
                qty = qty.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                bcqty = bcqty.replace(/,/g, "");
                benpart = benpart.trim();
               
                //try to avoid massive label printing if they make a mistake on numlabels.
                //if (numlabels > 100) {
                //    numlabels = 10
                //}

                if (ip_addr === "10.5.110.17") { //2x1
                    var zpl = "_CT~~CD,~CC^~CT~^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ^XA^MMT^PW406^LL0203^LS0^FT5,49^A0N,23,24^FH\^FDBen #:^FS^FT3,94^A0N,23,24^FH\^FDVen #:^FS^FT73,95^A0N,23,24^FH\^FD" + vendpart + "^FS^FT5,181^A0N,23,24^FH\^FDQty:^FS^FT64,135^A0N,23,24^FH\^FD" + desc + "^FS^FT5,133^A0N,23,24^FH\^FDDesc:^FS^FT49,181^A0N,23,24^FH\^FD" + bcqty + "^FS^FT79,48^A0N,23,24^FH\^FD" + benpart + "^FS^PQ" + numlabels + ",0,1,Y^XZZ"
                }
                else if(ip_addr ==="10.0") {

                    var zpl = "CT~~CD,~CC^~CT~^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ^XA^MMT^PW863^LL1168^LS0^FO157,846^GB172,285,8^FS^FO51,9^GB757,1147,8^FS^FT103,889^A0R,28,28^FH\^FDDate:^FS^FT182,861^A0R,28,28^FH\^FDSouth:^FS^BY2,3,124^FT621,207^B3R,N,,Y,N^FD0" + benpart +
                        "^FS^FT651,23^A0R,68,67^FH\^FDBen #:^FS^FT396,238^A0R,68,67^FH\^FD" + vendpart + "FS^FT260,1022^A0R,28,28^FH\^FD" + loc1 + "^FS^FT394,25^A0R,68,67^FH\^FDVend #:^FS^FT529,211^A0R,51,50^FH\^FDdesc^FS^FT221,1025^A0R,28,28^FH\^FD" + loc2 + "^FS^FT180,1025^A0R,28,28^FH\^FD" + loc4 +
                        "^FS^FT298,931^A0R,28,28^FH\^FDLocations^FS^FT614,594^A0R,203,201^FH\^FD" + benpart + "^FS^FT524,29^A0R,68,67^FH\^FDDesc:^FS^BY2,3,119^FT127,26^B3R,N,,Y,N^FD" + bcqty + "^FS^FT261,860^A0R,28,28^FH\^FDM (Back):^FS^SL0^FT104,962^A0R,28,28^FC%,{,#^FD%m/%d/%y^FS^FT269,29^A0R,68,67^FH\^FDQty:^FS^FT222,862^A0R,28,28^FH\^FDM (Middle):^FS^FT149,268^A0R,203,201^FH\^FD" + qty + "^FS^PQ" + numlabels + ",0,1,Y^XZ"
                }
                    //first design
                    //else {
                    //    var zpl = "CT~~CD,~CC^~CT~^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ^XA^MMT^PW863^LL1208^LS0^FO124,883^GB171,285,8^FS^FT77,966^A0R,28,28^FH\^FDDate:^FS^FT148,898^A0R,28,28^FH\^FDSouth:^FS^FT226,1059^A0R,28,28^FH\^FD" + loc1 + "^FS^BY1,3,135^FT664,266^B3R,N,,Y,N^FD" + benpart +
                    //        "^FS^FT187,1062^A0R,28,28^FH\^FD" + loc2 + "^FS^FT402,262^A0R,68,67^FH\^FD" + vendpart + "^FS^FT679,83^A0R,68,67^FH\^FDBen #:^FS^FT147,1062^A0R,28,28^FH\^FD" + loc4 + "^FS^FT264,968^A0R,28,28^FH\^FDLocations^FS^FT533,262^A0R,51,50^FH\^FD" + desc + "^FS^FT403,83^A0R,68,67^FH\^FDVen #:^FS^FT228,898^A0R,28,28^FH\^FDM (Back):^FS^FT641,605^A0R,203,201^FH\^FD" + benpart +
                    //        "^FS^SL0^FT77,1039^A0R,28,28^FC%,{,#^FD%m/%d/%y^FS^FT189,899^A0R,28,28^FH\^FDM (Middle):^FS^FT275,90^A0R,68,67^FH\^FDQty:^FS^FT528,80^A0R,68,67^FH\^FDDesc:^FS^BY2,3,119^FT132,87^B3R,N,,Y,N^FD" + bcqty + "^FS^FT153,320^A0R,203,201^FH\^FD" + qty + "^FS^PQ" + numlabels + ",0,1,Y^XZ"
                    //}

                else {
                    var zpl = "^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ^XA^MMT^PW863^LL1208^LS0^FO124,883^GB171,285,8^FS^FT148,898^A0R,28,28^FH\^FDSouth:^FS^FT226,1059^A0R,28,28^FH\^FD" + loc1 + "^FS^BY2,3,160^FT647,252^B3R,N,,Y,N^FD" + benpart +
                        "^FS^FT187,1062^A0R,28,28^FH\^FD" + loc2 + "^FS^FT411,257^A0R,51,50^FH\^FD" + vendpart + "^FS^FT731,72^A0R,68,67^FH\^FDBen #^FS^FT147,1062^A0R,28,28^FH\^FD" + loc4 + "^FS^FT264,968^A0R,28,28^FH\^FDLocations^FS^FT507,50^A0R,85,84^FH\^FD" + desc +
                        "^FS^FT411,78^A0R,51,50^FH\^FDVend #^FS^FT228,898^A0R,28,28^FH\^FDM (Back):^FS^FT664,631^A0R,186,201^FH\^FD" + benpart + "^FS^SL0^FT45,887^A0R,68,67^FC%,{,#^FD%m/%d/%y^FS^FT189,899^A0R,28,28^FH\^FDM (Middle):^FS^FT282,78^A0R,68,67^FH\^FDQty^FS^BY2,3,119^FT140,75^B3R,N,,Y,N^FD" + bcqty + "^FS^FT155,316^A0R,203,201^FH\^FD" + qty + "^FS^PQ" + numlabels + ",0,1,Y^XZ"
                }
                //var ip_addr = "10.5.110.17";
                var output = document.getElementById("output");
                var url = "http://" + ip_addr + "/pstprnt";
                //alert(url)
                var method = "POST";
                var async = true;
                var request = new XMLHttpRequest();

                request.onload = function () {
                    var status = request.status; // HTTP response status, e.g., 200 for "200 OK"
                    var data = request.responseText; // Returned data, e.g., an HTML document.
                    output.innerHTML = "Status: " + status + "<br>" + data;
                }

                request.open(method, url, async);
                request.setRequestHeader("Content-Length", zpl.length);

                // Actually sends the request to the server.
                if (qty.length > 0 && ip_addr.length > 0) {
                    request.send(zpl);
                }

            }

        </script>
    </form>
</body>
</html>

