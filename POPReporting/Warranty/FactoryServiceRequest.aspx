<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FactoryServiceRequest.aspx.vb" Inherits="Warranty_FactoryServiceRequest" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bennington Factory Return/Service Request</title>
    <style type="text/css">
        .newStyle1 {
            font-family: Calibri;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            float:left;
            width: 866px;
        }
        .newStyle2 {
            font-family: Calibri;
            font-size: 12px;
            font-weight: bold;
            
        }
        .auto-style1 {
        }
    </style>
</head>
<body>
    <div id="requestform" class ="newStyle2">    
    <form id="form1" runat="server">    
        <span class="newStyle1">Bennington Factory Return/Service Request</span>&nbsp;<br />
        <br />
        <asp:Label ID="Label7" runat="server" Text="Repair Will Be:" style="text-decoration: underline"></asp:Label>
        <asp:CheckBoxList ID="cbWhoPays" runat="server" RepeatDirection="Horizontal" style="font-weight: 700">
            <asp:ListItem Value="Charged">Charged To Responsible Party:</asp:ListItem>
            <asp:ListItem Value="Warranty">Warranty:</asp:ListItem>
        </asp:CheckBoxList>

        <strong>
        <br />
        <asp:Label ID="lblSerial" runat="server" Text="Boat Serial #:" Width="125px"></asp:Label>
        </strong>ETW <asp:TextBox ID="tbSerialNo" runat="server"></asp:TextBox>        
        <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Boat Model:" Width="150px" style="text-align: left"></asp:Label>
        <asp:TextBox ID="tbModel" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="Dealer:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbDealer" runat="server"></asp:TextBox>        
        <asp:Label ID="Label6" runat="server" Text="Consumer's Name:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbConsumerName" runat="server" Width="340px"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Font-Bold="True" Text="Primary Contact:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbPrimary" runat="server"></asp:TextBox>        
        <asp:Label ID="Label4" runat="server" CssClass="newStyle2" Text="Primary's Email:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbPrimaryEmail" runat="server" TextMode="Email" Width="340px"></asp:TextBox>
        <br />        
        <asp:Label ID="Label5" runat="server" Text="Primary's Phone:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbPrimaryPhone" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label8" runat="server" Text="Service To Perform (Must Be Specific):" Width="150px"></asp:Label>
        <asp:TextBox ID="tbService" runat="server" Height="61px" TextMode="MultiLine" Width="672px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label13" runat="server" Text="Special Instructions:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbSpecial" runat="server" Height="61px" TextMode="MultiLine" Width="670px"></asp:TextBox>
        <br />
        <br />
        <span class="auto-style1">How Boat Will Be Returned To Bennington?:</span>
        <asp:CheckBoxList ID="cbReturnedBy" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Value="DealerOrConsumer">Dealer/Consumer</asp:ListItem>
            <asp:ListItem Value="BenDriver">Bennington Driver</asp:ListItem>
            <asp:ListItem Value="BAS">Bennington Arranged Shipper</asp:ListItem>
        </asp:CheckBoxList>
        <br />
        <span class="auto-style1">Transport Trailer Belongs To:</span><asp:CheckBoxList ID="cbWhoseTrailer" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Value="Bennington">Bennington</asp:ListItem>
            <asp:ListItem Value="Shipper">Shipper</asp:ListItem>
            <asp:ListItem Value="Consumer">Consumer</asp:ListItem>
            <asp:ListItem>Dealer</asp:ListItem>
        </asp:CheckBoxList>
        <br />
        <asp:Label ID="Label22" runat="server" Text=" Trailer ID (Consumer/Dealer):" Width="150px"></asp:Label>
        <asp:TextBox ID="tbTrailerID" runat="server" Width="99px"></asp:TextBox>
        <br />
        <asp:Label ID="Label9" runat="server" Text="Pick-Up Address:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbPUAddress" runat="server" Width="676px"></asp:TextBox>       
        <br />
        <asp:Label ID="Label10" runat="server" Text="Pickup Contact:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbPUContact" runat="server" Width="340px"></asp:TextBox><br />
        <asp:Label ID="Label11" runat="server" Text="Phone:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbPhone" runat="server" Width="148px"></asp:TextBox>
        <br />
        <hr />
        <asp:Label ID="Label19" runat="server" Text="Label" style="text-decoration: underline">Bennington Use Only</asp:Label>
        <br />
        <br />
        <asp:Label ID="Label14" runat="server" Font-Bold="True" Text="Original Prod #:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbOrigProdNo" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label15" runat="server" Text="Requested By:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbRequestor" runat="server"></asp:TextBox>
         <asp:Label ID="Label16" runat="server" Text="Email:" Width="150px" style="text-align: left"></asp:Label>&nbsp;<asp:TextBox ID="tbEmail" runat="server" Width="340px"></asp:TextBox>
        <br />       
        <asp:Label ID="Label18" runat="server" Text="Approved By:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbApprovedBy" runat="server"></asp:TextBox>
        <asp:Label ID="Label24" runat="server" Text="Label" Width="150">Date Approved:</asp:Label>&nbsp;<asp:TextBox ID="tbDateApproved" runat="server" TextMode="Date"></asp:TextBox>
        <br />
        <asp:Label ID="Label17" runat="server" Text="Phone:" Width="150px" style="text-align: left"></asp:Label>        
        <asp:TextBox ID="tbReqPhone" runat="server" Width="270px"></asp:TextBox>
        <br />
        <asp:Label ID="Label12" runat="server" Text="Target Return Date:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbTarget" runat="server" TextMode="Date" MaxLength="10"></asp:TextBox>
        <asp:Label ID="Label23" runat="server" Text="Date Entered:" Width="150px"></asp:Label>
        <asp:TextBox ID="tbDateEntered" runat="server" TextMode="Date" MaxLength="10" ReadOnly="True"></asp:TextBox>
        <br />
        <hr />
        <br />
        <asp:Label ID="Label20" runat="server" Text="Label">I understand that unless specifically requested by Bennington and NOTED ABOVE, Bimini frames, Bimini canvas and outboard motors are to be removed prior to shipment.  All fresh water and I/O engine cooling systems MUST be drained and “Winterized” prior to shipment.  Bennington will not be responsible for damage that is the result of freezing temperatures that may occur during transport, storage or repair. 

I understand that all items not need for the boat repair and any loose or personal items must be removed prior to shipment of the boat back to Bennington.  IE: Life jackets, removable cup holders, fishing gear, personal electronics, coolers, Porta Potties, registration paperwork, etc.  Bennington will not be responsible for any items left in the boat when shipped.

I understand that prior to shipment boat must be appropriately covered to protect the boat from damage due to weather, dirt or other elements during transportation and storage prior to service.  Bennington will not be responsible for any damage that is the result of failure to adequately cover and protect the boat.  The Playpen Cover should be stowed in boat – DO NOT TRANSPORT WITH COVER INSTALLED

Signature below accepts the conditions listed above.
</asp:Label>
        <br />
        <br />
        <br />
        <br />
        ________________________________________________________________________________________<br />
        <asp:Label ID="Label21" runat="server" CssClass="newStyle2" Text="Authorized Dealer Signature"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date<br />
        <br />
        <br />
        <br />
        _________________________________________________________________________________________<br />
        Consumer Signature&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date<br />
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
        <br />
        <br />

    </form>
    </div>
</body>
</html>

