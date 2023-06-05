<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SouthKitColorSwaps.aspx.vb" Inherits="Materials_SouthKitColorSwaps" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>South Kit Color Swap Maintenance</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../scripts/css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class=" form-group w-100 float-left">
                <asp:Label ID="Label1" runat="server" class="h1 text-left float-left" Text="South Kit Color Swaps"></asp:Label>
                <asp:Image ID="Image2" CssClass="float-right" runat="server" ImageUrl="../Images/logo-small.png" />
            </div>
            <div id="addswap" runat="server" class="w-100 m-2">
                <div class="form-group">
                    <label for="tbPartNo" runat="server" class="mr-2 font-weight-bold">Option Part #:</label>
                    <asp:TextBox ID="tbPartNo" runat="server" AutoPostBack="True"></asp:TextBox>
                    <asp:Label ID="lblOptionDesc" runat="server" Text=""></asp:Label>
                    <asp:Label ID="Label2" runat="server" CssClass="mr-2 font-weight-bold" Text="OR"></asp:Label>
                    <asp:CheckBox ID="cbBlackout" CssClass="ml-2" runat="server" Text="   Applies to All Blackout Option #'s" />
                </div>
                <div class="form-group w-100">
                    <label for="tbFromPart" class="font-weight-bold">Swap From This Part:</label>
                    <asp:TextBox ID="tbFromPart" runat="server" AutoPostBack="True"></asp:TextBox>
                     <asp:Label ID="lblFromPartDesc" runat="server" Text=""></asp:Label>                    
                </div>
                <div class="form-group w-100">
                    <label for="tbToPart" class="mr-4 font-weight-bold">Swap To This Part:</label>
                    <asp:TextBox ID="tbToPart" runat="server" AutoPostBack="True"></asp:TextBox>
                    <asp:Label ID="lblToPartDesc" runat="server" Text=""></asp:Label>
                </div>            
                
                <asp:Button ID="btnAddSwap" CssClass="btn btn-dark m-2" runat="server" Text="Add Swap" UseSubmitBehavior="False" />
            </div>
            <div id="partswaps">
                <asp:GridView ID="gvSwaps" runat="server" AutoGenerateColumns="False" DataKeyNames="AutoID" DataSourceID="sdsSwaps">
                    <Columns>
                        <asp:BoundField DataField="AutoID" HeaderText="AutoID" InsertVisible="False" ReadOnly="True" SortExpression="AutoID" />
                        <asp:BoundField DataField="AllBlackoutParts" HeaderText="All Blackout Parts" SortExpression="AllBlackoutParts" />
                        <asp:BoundField DataField="PartNo" HeaderText="Part #" SortExpression="PartNo" />
                        <asp:BoundField DataField="PartDesc" HeaderText="Part Desc" SortExpression="PartDesc" />
                        <asp:BoundField DataField="FromPartNo" HeaderText="From Part #" SortExpression="FromPartNo" />
                        <asp:BoundField DataField="FromPartDesc" HeaderText="From Part Desc" SortExpression="FromPartDesc" />
                        <asp:BoundField DataField="ToPartNo" HeaderText="To Part #" SortExpression="ToPartNo" />
                        <asp:BoundField DataField="ToPartDesc" HeaderText="To Part Desc" SortExpression="ToPartDesc" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsSwaps" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [SouthKitColorSwapParts]"></asp:SqlDataSource>
            </div>


        </div>
    </form>
    <script src="../scripts/jquery-3.5.0.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
</body>
</html>
