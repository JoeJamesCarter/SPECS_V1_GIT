<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RackLabelsByArea.aspx.vb" Inherits="Materials_RackLabelsByArea" %>

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
        }
        .Component {
            font-family:Calibri;
            font-size:20px;
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
        <asp:Label ID="Label1" runat="server" cssClass="Header" Text="Rack Label Printing By Area" Width="287px" ForeColor="Blue"></asp:Label>
      
        <asp:Label ID="Label8" runat="server" cssClass="Header" Text="From Inv On:"></asp:Label>
        
        <asp:DropDownList ID="ddlPhyInvDates" runat="server" DataSourceID="sdsInventoryDates" DataTextField="enteredDate" DataFormatString="{0:d}" DataValueField="enteredDate" Enabled="False" CssClass="Component">
        </asp:DropDownList>
        &nbsp;<asp:Label ID="Label7" runat="server" cssClass="Header" Text="Area : "></asp:Label>
        
        <asp:DropDownList ID="ddlAreas" runat="server" CssClass="Header" DataSourceID="sdsAreas" DataTextField="Area" DataValueField="Area" AppendDataBoundItems="true" AutoPostBack="True" >
            <asp:ListItem>
                
            </asp:ListItem>
        </asp:DropDownList>
        
        &nbsp;<asp:Label ID="Label6" runat="server" Text="Printer:" CssClass="Header"></asp:Label>
        <asp:DropDownList ID="ddlPrinters" runat="server" Font-Size="30pt" AutoPostBack="True" DataSourceID="sdsPrinters" DataTextField="PrinterName" DataValueField="IP" AppendDataBoundItems="true">
                <asp:ListItem></asp:ListItem>           
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsPrinters" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Printers] ORDER BY [DisplayOrder]"></asp:SqlDataSource>
        &nbsp;      
           &nbsp;<asp:SqlDataSource ID="sdsInventoryDates" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT DISTINCT Convert(date,enteredDate) as enteredDate FROM [Inventory_Tags]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsAreas" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT DISTINCT [Area] FROM [Inventory] ORDER BY [Area]"></asp:SqlDataSource>
        <br /><asp:Button ID="btnSelectAll" runat="server" Text="Select All" CssClass="Component" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="btnDeselectAll" runat="server" Text="Deselect All" CssClass="Component" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="btnPrint" Font-Size="16px" runat="server" Text="Print Selected" OnClientClick="print(); return false;" Height="33px" Width="150px" Font-Bold="True" CssClass="Component" Enabled="False" />     
              
        <asp:GridView ID="gvItemsInArea" runat="server" AutoGenerateColumns="False" CssClass="Component" DataSourceID="sdsItemsInArea" Width="1166px">
            <Columns>
                <asp:TemplateField HeaderText="Select">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbSelect" runat="server" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="itemNumber" HeaderText="Item #" />
                <asp:TemplateField HeaderText="Print">
                    <ItemTemplate>
                        <asp:Button ID="btnPrint" runat="server" Text="Print" CommandArgument="<%# Container.DataItemIndex %>" CommandName="printone" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="item_desc_1" HeaderText="Desc From Macola" />
                <asp:BoundField DataField="item_desc_2" HeaderText="Vend Part #" />
                <asp:TemplateField HeaderText="Vendor">
                    <ItemTemplate>
                        <asp:Label ID="lblVendor" runat="server" Text="Label"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="uom" HeaderText="UOM" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsItemsInArea" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT Distinct(itemNumber), item_desc_1, item_desc_2, uom FROM Inventory.dbo.Inventory_Tags Left join Inventory_ItemMaster on itemNumber = Inventory_ItemMaster.item_no WHERE (([areaID] = @areaID) AND ([itemNumber] NOT LIKE 'UNUSED') AND ([itemNumber] NOT LIKE 'VOIDED') AND ([itemNumber] NOT LIKE 'VOID')) ORDER BY [itemNumber]">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlAreas" Name="areaID" PropertyName="SelectedValue" Type="Double" />            
            </SelectParameters>
        </asp:SqlDataSource>

        <br />
        <br />
        <br />
        <br />
                

        <br />
                

        <br />
              
        <br />

       
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

