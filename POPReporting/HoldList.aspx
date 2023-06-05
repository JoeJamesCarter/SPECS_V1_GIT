<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HoldList.aspx.vb" Inherits="HoldList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hold List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="StyleSheet.css" rel="stylesheet" />
    <link rel="stylesheet" href="./scripts/css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="container">
            <div class="w-100">
                <asp:Label ID="Label1" runat="server" class="h1 text-left float-left" Text="BOATS TO HOLD"></asp:Label>
                <asp:Image ID="Image2" CssClass="float-right" runat="server" ImageUrl="./Images/logo-small.png" />
            </div>


            <div id="addboat" runat="server" class="form-inline w-100 bg-light m-2">
                <label for="tbProdNo" class="mr-2 font-weight-bold">Prod #:</label>
                <asp:TextBox ID="tbProdNo" runat="server" CssClass="form-control w-10" TextMode="Number" MinLength="7" MaxLength="7"></asp:TextBox>
                 
                 <asp:Button ID="btnSearch" CssClass="btn btn-dark m-2" runat="server" Text="Search" UseSubmitBehavior="False" />
                <label for="ddlHoldPer" class="ml-1 font-weight-bold ml-2">On Hold Per:</label>                
                <asp:DropDownList ID="ddlHoldPer" runat="server">
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem>Sales</asp:ListItem>
                    <asp:ListItem>Accounting</asp:ListItem>
                    <asp:ListItem>Dealer Req</asp:ListItem>
                    <asp:ListItem>Demo</asp:ListItem>
                    <asp:ListItem>Misc</asp:ListItem>
                </asp:DropDownList>
                
                <label for="tbNotes" class="ml-2 font-weight-bold">Reason:</label>                
                <asp:TextBox ID="tbNotes" runat="server" CssClass="form-control ml-2"></asp:TextBox>
               
                <asp:Button ID="btnSetHoldFlag" CssClass="btn btn-dark m-2" runat="server" Text="Hold" UseSubmitBehavior="False" />
            </div>
            <div id="boatinfo" runat="server">
                 <asp:Label ID="lblDlrNo" runat="server" CssClass="ml-2" Text="Enter Prod # & Click Search. Verify Boat. Set On Hold Per and Reason. Click Hold."></asp:Label>
                <asp:Label ID="lblDlr" runat="server" CssClass="ml-1" Text=""></asp:Label>
                <asp:Label ID="lblModel" runat="server" CssClass="ml-4 font-weight-bold" Text=""></asp:Label>
            </div>

            <hr />
            <div class="w-100">
                <asp:GridView ID="gvHoldList" Width="100%" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsHoldBoats" AllowSorting="True" GridLines="Horizontal" Caption="Boats On Shipping Hold">
                    <Columns>
                        <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" >
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnRelease" CssClass="btn btn-dark m-2" runat="server" Text="Release To Ship" CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotorelease" UseSubmitBehavior="False" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="ItemNo" HeaderText="Model" SortExpression="ItemNo" />
                        <asp:BoundField DataField="CusNo" HeaderText="Dlr #" SortExpression="CusNo" />
                        <asp:BoundField DataField="CusName" HeaderText="Dealer" SortExpression="CusName" />
                        <asp:BoundField DataField="SONo" HeaderText="SO #" SortExpression="SONo" />
                        <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:d}" SortExpression="DueDate" />
                        <asp:BoundField DataField="HoldPer" HeaderText="Hold Per" SortExpression="HoldPer" />
                        <asp:BoundField DataField="HoldNote" HeaderText="Notes" SortExpression="HoldNote" />


                    </Columns>

                </asp:GridView>

                <asp:SqlDataSource ID="sdsHoldBoats" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [CusNo], [CusName], [SONo], [DueDate], [ItemNo], [HoldPer], [HoldNote] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([HoldFlag] = @HoldFlag) ORDER BY [ProdNo]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="HoldFlag" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </form>
    <script src="./scripts/jquery-3.5.0.min.js"></script>
    <script src="./scripts/bootstrap.min.js"></script>
</body>
</html>
