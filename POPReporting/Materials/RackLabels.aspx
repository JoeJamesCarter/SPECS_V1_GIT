<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RackLabels.aspx.vb" Inherits="Materials_RackLabels" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rack Labels</title>
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
<asp:Label ID="Label1" runat="server" cssClass="title" Text="Rack Label Printing" Width="1261px" ForeColor="Blue"></asp:Label>
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
                <asp:BoundField DataField="uom" HeaderText="UOM" />
                <asp:TemplateField HeaderText="Vendor">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
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
        <asp:Label ID="Label6" runat="server" cssClass="inputs" Text="Printer:"></asp:Label>
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

        <asp:SqlDataSource ID="sdsMacola" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_no], [item_desc_1],[item_desc_2], [uom] FROM [IMITMIDX_SQL] WHERE [activity_cd] = 'A' and (([item_no] LIKE  '%' + @item_no + '%') or ([item_desc_2]  LIKE  '%' + @vend_part + '%'))">
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
        <asp:TextBox ID="selectedVendor" runat="server" Enabled ="false"></asp:TextBox>
        <asp:TextBox ID="selectedUOM" Enabled ="false" runat="server"></asp:TextBox>
        <asp:TextBox ID="tbLoc1" runat="server" Enabled ="false"></asp:TextBox>
        <asp:TextBox ID="tbLoc2" runat="server" Enabled ="false"></asp:TextBox>
        <asp:TextBox ID="tbLoc3" runat="server" Enabled ="false"></asp:TextBox>
        <asp:TextBox ID="tbLoc4" runat="server" Enabled ="false"></asp:TextBox>

    </div>
        
        
       <div id="output"></div>
        <script>

            function print() {
                var benpart = document.getElementById("tbBenPart").value;
                benpart = benpart.trim(); //required to make the barcode scanable.
                var desc = document.getElementById("selectedDesc").value;
                var vendor = document.getElementById("selectedVendor").value;                
                var vendorno = document.getElementById("selectedVendorNo").value;                
                var uom = document.getElementById("selectedUOM").value;

                //var loc1 = document.getElementById("tbLoc1").value;
                //var loc2 = document.getElementById("tbLoc2").value;
                //var loc3 = document.getElementById("tbLoc3").value;
                //var loc4 = document.getElementById("tbLoc4").value;

                var ip_addr = ""
                var e = document.getElementById("ddlPrinters");
                ip_addr = e.options[e.selectedIndex].value;

                //escape quotes and single quotes                
                desc = desc.replace(/(&quot\;)/g, "\"")
                desc = desc.replace(/(&#39\;)/g, "'")               
                
                //var zpl = "^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR2,2~SD8^JUS^LRN^CI0^XZ^XA^MMT^PW772^LL0406^LS0^BY2,3,135^FT295,236^B3I,N,,Y,N^FD" + benpart + "^FS^FT766,45^A0I,39,38^FH\^FD" + vendor + "^FS^FT772,107^A0I,39,38^FH\^FD" + vendorno + "^FS^FT769,163^A0I,39,38^FH\^FD" + desc + "^FS^FT770,252^A0I,135,134^FH\^FD" + benpart + "^FS^FT127,75^A0I,28,28^FH\^FDUOM:^FS^FT141,32^A0I,28,28^FH\^FD" + uom + "^FS^PQ1,0,1,Y^XZ"
                var zpl = "^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR2,2~SD8^JUS^LRN^CI0^XZ^XA^MMT^PW772^LL0406^LS0^BY2,3,135^FT295,236^B3I,N,,Y,N^FD" + benpart + "^FS^FT766,45^A0I,39,38^FH\^FD" + vendor + "^FS^FT772,107^A0I,39,38^FH\^FD" + vendorno + "^FS^FT769,163^A0I,39,38^FH\^FD" + desc + "^FS^FT770,252^A0I,135,134^FH\^FD" + benpart + "^FS^FT127,75^A0I,28,28^FH\^FD^FS^FT68,75^A0I,28,35^FH\^FD" + uom +" ^FS^PQ1,0,1,Y^XZ"
                //var ip_addr = "10.5.110.58";
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
                if (benpart.length > 0 && ip_addr.length > 0) {
                    request.send(zpl);
                }

            }

        </script>
    </form>
</body>
</html>

