<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Transport.aspx.vb" Inherits="Transport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Request Boat Pickup or Delivery</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./scripts/css/bootstrap.min.css" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="container h5">
            <asp:Label ID="Label3" runat="server" CssClass="h4" Text="Request A Boat Drop Off Or Pickup"></asp:Label>   <asp:Button ID="btnClose" class="btn btn-outline-success m-4" runat="server" Text="Close" />
            <div class="row mt-4" runat="server">
                <asp:Table runat="server" CssClass="w-100 p-2 table table-bordered">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label2" runat="server" Text="Prod #: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblProdNo" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label4" runat="server" Text="To Be Built In: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblBuildLoc" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label6" runat="server" Text="Model: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblBoatModel" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label7" runat="server" Text="Structure: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblType" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>                   
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label5" runat="server" Text="Yard Location: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblYardLoc" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="w-10">
                            <asp:Label ID="Label8" runat="server" Text="Next To Complete: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblCurrentStatus" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label9" runat="server" Text="Requested By"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblWS" runat="server" Text=""></asp:Label>
                        </asp:TableCell>                        
                    </asp:TableRow>                  
                    <asp:TableRow CssClass="text-center">
                     <asp:TableCell ColumnSpan="2">
                         <asp:RadioButtonList ID="cblPickupOrDropOff" runat="server" RepeatDirection ="Horizontal" CssClass="w-100" AutoPostBack="true">
                             <asp:ListItem Value="DropOff">&nbsp;&nbsp;Drop Off</asp:ListItem>
                             <asp:ListItem Value="PickUp">&nbsp;&nbsp;Pick Up</asp:ListItem>
                         </asp:RadioButtonList></asp:TableCell>                        
                    </asp:TableRow>
                     <asp:TableRow>
                       <asp:TableCell ColumnSpan="2" CssClass="h3 text-center">
                           <asp:Label ID="Label10" runat="server" Text="Requesting Prod #: "></asp:Label>
                           <asp:Label ID="lblProd" runat="server" Text=""></asp:Label><br />
                           <asp:Label ID="Label11" runat="server" Text=" Be "></asp:Label>
                           <asp:Label ID="lblRequest" runat="server" Text=" * Select Drop Off or Pick Up *"></asp:Label><br/>                           
                           <asp:Label ID="lblReq" runat="server" Text=""></asp:Label>
                       </asp:TableCell>
                   </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="2" CssClass="text-center">
                            <asp:Button ID="btnSubmit" class="btn btn-success m-4" runat="server" Text="Submit" /></asp:TableCell>
                    </asp:TableRow>                 

                </asp:Table>

            </div>

            <div class="row m-2 w-50" runat="server">
                <asp:GridView ID="gvRequestedBoats" runat="server" Width="100%" caption="My Open Requests"></asp:GridView>             
            </div>
        </div>



    </form>
    <script src="./scripts/jquery-3.5.0.min.js"></script>
    <script src="./scripts/bootstrap.min.js"></script>
</body>
</html>
