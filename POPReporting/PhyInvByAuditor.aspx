<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PhyInvByAuditor.aspx.vb" Inherits="PhyInvByAuditor" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Physical Inventory Area Status By Auditor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./scripts/css/bootstrap.min.css" />

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
            background-color: lightblue;
            color: black;
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
            <div class="container p-2">
            <div class="row m-2" runat="server">
                <label for="ddlAuditors" class="mr-2">Auditor:</label>
                <asp:DropDownList ID="ddlAuditors" runat="server" AutoPostBack="True" DataSourceID="sdsAuditors" DataTextField="Auditor" DataValueField="Auditor"></asp:DropDownList>
                <asp:SqlDataSource ID="sdsAuditors" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT Distinct(Auditor) FROM [Inventory] ORDER BY [Auditor]"></asp:SqlDataSource>
            </div>

            <div class="row" runat="server">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="120000" OnTick="Timer1_Tick"></asp:Timer>
                        <asp:DataList ID="DataList1" runat="server" DataSourceID="sdsInventoryAreas" RepeatDirection="Vertical" RepeatColumns="1" BorderStyle="Outset" SeparatorStyle-Height="2px" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="4" DataKeyField="Area" CellPadding="4" CellSpacing="4">
                            <ItemStyle BorderStyle="Solid" BorderWidth="2px" />
                            <ItemTemplate>

                                <table class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <th scope="row"><%#Eval("Area") & "-" & Eval("Building")  %></th>
                                            <td><%# Eval("AreaDesc") %></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text="AUDITOR: "></asp:Label>&nbsp;&nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Eval("Auditor") %>' /></td>
                                            <td>
                                                <asp:Label ID="Label6" runat="server" Text="WRITER: "></asp:Label>&nbsp;&nbsp;<asp:Label ID="Label7" runat="server" Text='<%# Eval("Writer") %>' /></td>
                                        </tr>
                                        <th scope="row" colspan="2" class="text-center">
                                            <asp:Label ID="lblCurrentStatus" class="h8" runat="server" Text="Current Status: "></asp:Label>
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
                                          <th scope="row" colspan="2" class="text-center">CLEARING
                                        </th>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" Text="Requested:"></asp:Label>&nbsp;&nbsp;<asp:Label ID="ClearRequestedLabel" runat="server" Text='<%# Eval("ClearRequested") %>' /></td>
                                            <td>Accepted:&nbsp;&nbsp;<asp:Label ID="TimeAcceptedLabel" runat="server" Text='<%# Eval("TimeAccepted") %>' /></td>
                                        </tr>
                                        <tr>
                                            <td>Clearing Auditor:&nbsp;&nbsp;<asp:Label ID="Label4" runat="server" Text='<%# Eval("ClearingAuditor") %>' /><br />
                                            </td>
                                            <td>Time Cleared:&nbsp;&nbsp;<asp:Label ID="TimeClearedLabel" runat="server" Text='<%# Eval("TimeCleared") %>' />
                                            </td>
                                        </tr>
                                        <th scope="row" colspan="2" class="text-center">ADDITIONAL INFO
                                        </th>
                                        <tr>
                                            <td>Call Acct Requested:
                                            </td>
                                            <td>
                                                <asp:Label ID="callAcctReqLabel" runat="server" Text='<%# Eval("callAcctReq") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Keying Completed:
                                            </td>

                                            <td>
                                                <asp:Label ID="keyEntryDoneLabel" runat="server" Text='<%# Eval("keyEntryDone") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Accounting #1 Review Completion: 
                                            </td>

                                            <td>
                                                <asp:Label ID="review1DoneLabel" runat="server" Text='<%# Eval("review1Done") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Accounting #2 Review Completion:
                                            </td>

                                            <td>
                                                <asp:Label ID="review2DoneLabel" runat="server" Text='<%# Eval("review2Done") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Report Ran:
                                            </td>

                                            <td>
                                                <asp:Label ID="ReportRanLabel" runat="server" Text='<%# Eval("ReportRan") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Area Complete:
                                            </td>
                                            <td>
                                                <asp:Label ID="AreaCompleteLabel" runat="server" Text='<%# Eval("AreaComplete") %>' />
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </ItemTemplate>
                            <SeparatorStyle Height="2px" />
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsInventoryAreas" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT * FROM [Inventory] WHERE ([Auditor] = @Auditor) ORDER BY [Area]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlAuditors" Name="Auditor" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
            </div>
    </form>
    <script src="./scripts/jquery-3.5.0.min.js"></script>
    <script src="./scripts/bootstrap.min.js"></script>
</body>
</html>
