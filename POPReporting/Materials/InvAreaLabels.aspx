<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InvAreaLabels.aspx.vb" Inherits="Materials_InvAreaLabels" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Area 4x6 Rack Labels</title>
    <style type="text/css">
        .inputs {}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:Label ID="Label6" runat="server" CssClass="inputs" Text="Printer:"></asp:Label>
             <asp:DropDownList ID="ddlPrinters" runat="server" Font-Size="30pt" AutoPostBack="True" DataSourceID="sdsPrinters" DataTextField="PrinterName" DataValueField="IP" AppendDataBoundItems="true">
                <asp:ListItem></asp:ListItem>           
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsPrinters" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Printers] ORDER BY [DisplayOrder]"></asp:SqlDataSource>
            <br />
            <br />
            Area:&nbsp;&nbsp;&nbsp;
             <asp:TextBox ID="tbAreaNo" runat="server" CssClass="inputs" Height="78px" Width="390px"></asp:TextBox>
            &nbsp;&nbsp;
            <asp:Button ID="btnClear" runat="server" Text="Clear" />
            <br />
            <br />
            <br />
            <asp:Button ID="btnPrint" runat="server" Font-Bold="True" Font-Size="60px" Height="147px" OnClientClick="print(); return false;" Text="Print" Visible="True" Width="1266px" />
            <br />

            <div id="output"></div>
            <script>

                function print() {
                    var areaNo = document.getElementById("tbAreaNo").value;
                    areaNo = areaNo.trim(); //required to make the barcode scanable.
                   
                    var ip_addr = ""
                    var e = document.getElementById("ddlPrinters");
                    ip_addr = e.options[e.selectedIndex].value;

                    var zpl = "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" +
                        "^XA" +
                        "^MMT " +
                        "^PW812" +
                        "^LL1218" +
                        "^LS0" +
                        "^FT471,1218^A0B,455,633^FH\^FD" + areaNo + " ^FS" +
                        "^BY7,3,127^FT721,821^BCB,,Y,N" +
                        "^FD>; "+ areaNo +"^FS"+
                        "^PQ1,0,1,Y^XZ"

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
                    //request.setRequestHeader("Content-Length", zpl.length);

                    // Actually sends the request to the server.
                    if (areaNo.length > 0 && ip_addr.length > 0) {
                       request.send(zpl);
                    }

                    //request.send(zpl);

                }

            </script>
        </div>
    </form>
</body>
</html>
