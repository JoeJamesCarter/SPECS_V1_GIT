<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PhyInvWest.aspx.vb" Inherits="PhyInv_PhyInvWest" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Phy Inv Tag Issues</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../scripts/css/bootstrap.min.css" />

    <style>
        .clearing {
            text-align: right;
            font-family: Arial;
            font-size: 70px;
            font-weight: bold;
        }

        .counting {
            background-color: white;
            font-weight: bold;
        }

        .clearreqd {
            background-color: orange;
            font-weight: bold;
        }

        .cleared {
            background-color: darkgrey;
            font-weight: bold;
        }

        .keyed {
            background-color: blue;
            color: white;
            font-weight: bold;
        }

        .errors {
            background-color: red;
            font-weight: bold;
            color: white;
        }

        .reportready {
            background-color: yellow;
            font-weight: bold;
        }

        .done {
            background-color: green;
            color: white;
            font-weight: bold;
        }

        .review1 {
            background-color: lightcyan;
            color: black;
            font-weight: bold;
        }

        .review2 {
            background-color: purple;
            color: white;
            font-weight: bold;
        }

        .callacct {
            background-color: darkred;
            color: white;
            font-weight: bold;
        }

        .blinkingText {
            animation: blinkingText 1.2s infinite;
        }

        @keyframes blinkingText {
            0% {
                color: #fff;
            }

            49% {
                color: #fff;
            }

            60% {
                color: transparent;
            }

            99% {
                color: transparent;
            }

            100% {
                color: #fff;
            }
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">


            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="60000" OnTick="Timer1_Tick"></asp:Timer>
                    <asp:DataList ID="DataList1" runat="server" DataSourceID="sdsInventoryAreas" RepeatDirection="Horizontal" RepeatColumns="5" BorderStyle="Outset" SeparatorStyle-Height="2px" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="4" DataKeyField="Area" CellPadding="2" CellSpacing="2">
                        <ItemStyle BorderStyle="Solid" BorderWidth="3px" />
                        <ItemTemplate>
                            <table class="table table-bordered w-20">
                                <tbody>
                                    <tr>
                                        <th scope="row" colspan="2"><%#Eval("Area") & "-" & Eval("Building") & "    " & Eval("AreaDesc") %></th>                                        
                                    </tr>
                                    <tr >
                                        <td colspan="2">
                                            <asp:Label ID="Label6" runat="server" Text="WRITER: "></asp:Label>&nbsp;&nbsp;<asp:Label ID="Label7" runat="server" Text='<%# Eval("Writer") %>' /></br>
                                            <asp:Label ID="Label1" runat="server" Text="AUDITOR: "></asp:Label>&nbsp;&nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Eval("Auditor") %>' />
                                        </td>
                                    </tr>
                                    <th scope="row" colspan="2" class="text-center">
                                        <asp:Label ID="lblCurrentStatus" class="h6" runat="server" Text="Current Status: "></asp:Label>
                                        <asp:Label ID="StatusLabel" runat="server" Text='<%# Eval("Status").ToString.ToUpper %>' />
                                    </th>
                                    <tr>
                                        <td colspan="2">
                                            <asp:GridView ID="gvIssues" runat="server" Width="100%" AutoGenerateColumns="False">
                                                <Columns>
                                                    <asp:BoundField DataField="id" HeaderText="Tag" />
                                                    <asp:BoundField DataField="errorName" HeaderText="Error" />
                                                    <asp:BoundField DataField="errorDescription" HeaderText="Error Detail" />
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>                                   
                                    <tr>
                                        <td>Auditor:&nbsp;&nbsp;<asp:Label ID="Label4" runat="server" Text='<%# Eval("ClearingAuditor") %>' /><br />
                                        </td>
                                        <td>Cleared:&nbsp;&nbsp;<asp:Label ID="TimeClearedLabel" runat="server" Text='<%# Eval("TimeCleared") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Call Acct Requested:
                                        </td>
                                        <td>
                                            <asp:Label ID="callAcctReqLabel" runat="server" Text='<%# Eval("callAcctReq") %>' />
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </ItemTemplate>
                        <SeparatorStyle Height="1px" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsInventoryAreas" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT * FROM [Inventory] WHERE (Building = 'W') ORDER BY [Area]"></asp:SqlDataSource>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>


    </form>
    <script src="./scripts/jquery-3.5.0.min.js"></script>
    <script src="./scripts/bootstrap.min.js"></script>
</body>
</html>
