q<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReorderV2.aspx.vb" Inherits="Rails_ReorderV2" Debug="true" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rail Reorderingl Reordering</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../scripts/css/bootstrap.min.css" />

    <style>
        .cbList label {
            margin-left: 6px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row text-light bg-dark h4 text-center w-100">
                <asp:Label ID="Label1" runat="server" CssClass="m-2" Text="RAILS REORDERING"></asp:Label>
                <asp:Label ID="Label3" runat="server" CssClass="m-2" Text="PROD #"></asp:Label>
                <asp:Label ID="lblProdNo" runat="server" CssClass="m-2" Text=""></asp:Label>
                <asp:HiddenField ID="hdnWorkstation" runat="server" />
            </div>
            <div class="row">
                <div class="col-2">
                    <asp:Label ID="Label2" runat="server" CssClass="h5" Text="Select Rail:"></asp:Label>
                    <asp:DropDownList ID="ddlRail" runat="server" CssClass="m-1">
                        <asp:ListItem></asp:ListItem>
                        <asp:ListItem>PF</asp:ListItem>
                        <asp:ListItem>SF</asp:ListItem>
                        <asp:ListItem>PR</asp:ListItem>
                        <asp:ListItem>SR</asp:ListItem>
                        <asp:ListItem>PM</asp:ListItem>
                        <asp:ListItem>SM</asp:ListItem>
                        <asp:ListItem>T</asp:ListItem>
                    </asp:DropDownList>

                </div>
                <div class="col-2 text-left">
                    <asp:Label ID="Label4" runat="server" CssClass="h5 pb-2" Text="Primary Reason:"></asp:Label>
                    <asp:RadioButtonList ID="rblPrimaryReason" runat="server" CssClass="cbList" AutoPostBack="true">
                        <asp:ListItem Value="Not Received">Not Received</asp:ListItem>
                        <asp:ListItem Value="Damaged">Damaged</asp:ListItem>
                        <asp:ListItem Value="Built Incorrectly">Built Incorrectly</asp:ListItem>
                        <asp:ListItem Value="Reassigned">Reassigned</asp:ListItem>
                    </asp:RadioButtonList>


                </div>
                <div class="col-2">
                    <asp:Label ID="lblDamaged" runat="server" CssClass="h5 pb-2" Text="Damaged:"></asp:Label>
                    <asp:RadioButtonList ID="rblDamaged" runat="server" CssClass="cbList" CellPadding="1" AutoPostBack="true">
                        <asp:ListItem>By West</asp:ListItem>
                        <asp:ListItem>By AACOA</asp:ListItem>
                        <asp:ListItem>By Bender</asp:ListItem>
                        <asp:ListItem>By Panel Team</asp:ListItem>
                        <asp:ListItem>By Line</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:Label ID="lblBuiltInc" runat="server" CssClass="h5 pb-2" Text="Built Incorrectly:"></asp:Label>
                    <asp:CheckBoxList ID="cblBuiltIncorrectly" runat="server" CssClass="cbList" CellPadding="1" AutoPostBack="true">
                        <asp:ListItem>Bad Weld</asp:ListItem>
                        <asp:ListItem>Insert Needed</asp:ListItem>
                        <asp:ListItem>Insert Not Needed</asp:ListItem>
                        <asp:ListItem>Labeled Incorrectly</asp:ListItem>
                        <asp:ListItem>Over Sanded</asp:ListItem>
                        <asp:ListItem>Should Be Custom</asp:ListItem>
                        <asp:ListItem>Too Long</asp:ListItem>
                        <asp:ListItem>Too Short</asp:ListItem>
                        <asp:ListItem>Weld Missing</asp:ListItem>                        
                        <asp:ListItem>Wrong Model</asp:ListItem>
                    </asp:CheckBoxList>
                </div>
            </div>
            <div class="row w-50">
                <div class="col-12">
                    <asp:Label ID="Label5" runat="server" CssClass="h5 pr-2" Text="Additional Details:"></asp:Label>
                    <asp:TextBox ID="tbDetail" runat="server" TextMode="MultiLine"></asp:TextBox>
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary pl-3 mt-1 align-top" Text="Submit" />
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <asp:Label ID="Label6" CssClass="h5 pr-2" runat="server" Text="Note To Log: "></asp:Label>&nbsp;&nbsp;
                <asp:Label ID="lblNote" CssClass="h5 pr-2" runat="server" Text=""></asp:Label><br />
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-12">
                    <asp:GridView ID="GridView1" runat="server" DataSourceID="sdsRailRepairs" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="ProdNo" HeaderText="Prod #">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DateReq" HeaderText="Date Requested">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle Width="200px" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PF" HeaderText="PF">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SF" HeaderText="SF">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PR" HeaderText="PR">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SR" HeaderText="SR">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="T" HeaderText="T">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PM" HeaderText="PM">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SM" HeaderText="SM">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Note" HeaderText="Notes">
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AddtDetail" HeaderText="Details">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Status" HeaderText="Status">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="StatusDate" HeaderText="Status Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ReReceived" HeaderText="Re-Rcvd">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ReReceivedDate" HeaderText="Re-Rcvd Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle Width="200px" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col">
                    <span class="newStyle4 text-light bg-dark">Reorders - Open and History</span>
                    <br />
                    <asp:GridView ID="GridView2" runat="server" DataSourceID="sdsRailsReorders" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            <asp:BoundField DataField="DateReq" HeaderText="Date Requested">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PF" HeaderText="PF">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SF" HeaderText="SF">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PR" HeaderText="PR">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SR" HeaderText="SR">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="T" HeaderText="T">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PM" HeaderText="PM">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SM" HeaderText="SM">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Note" HeaderText="Notes">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AddtDetail" HeaderText="Details">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Status" HeaderText="Status">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="StatusDate" HeaderText="Status Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ReReceived" HeaderText="Re-Rcvd">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ReReceivedDate" HeaderText="Re-Rcvd Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle Width="200px" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <br />
                    <span class="newStyle4 text-light bg-dark">Possible Inventoried Rails For This Boat - (Watch for Powertop on Rears)</span>
                    <br />
                    <asp:GridView ID="GvExtraRails" DataSourceID="sdsPossibleExtraRails" AutoGenerateColumns="False" runat="server">
                        <Columns>
                            <asp:BoundField DataField="Rail" HeaderText="Rail">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Blackout">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbBlackout" runat="server" Checked='<%# Eval("Blackout") %>' Enabled="False" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Power Top">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbPowertop" runat="server" Checked='<%# Eval("Powertop") %>' Enabled="False" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Drawing" HeaderText="Standard Drawing #">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Custom">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbCustom" runat="server" Checked='<%# Eval("Custom") %>' Enabled="False" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="CustomDrawNo" HeaderText="Custom Drawing #">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AutoID" HeaderText="Rail ID #">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <br />
            <div class="row">
                <asp:Button ID="btnClose" runat="server" CssClass="btn btn-dark" Text="Close" />
            </div>
            <asp:SqlDataSource ID="sdsRailRepairs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [PF], [SF], [PR], [SR], [T], [PM], [SM], [Note], [DateReq], [Status], [StatusDate], [ReReceived], [ReReceivedDate],[TYPE], [AddtDetail] FROM [Rails_RepairsReorders] WHERE (ProdNo = @ProdNo) and Type = 'Repair' ORDER BY [Auto]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsRailsReorders" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [PF], [SF], [PR], [SR], [T], [PM], [SM], [Note], [DateReq], [Status], [StatusDate], [ReReceived], [ReReceivedDate],[TYPE], [AddtDetail] FROM [Rails_RepairsReorders] WHERE (ProdNo = @ProdNo) and Type = 'Reorder' ORDER BY [Auto]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsRailsNeeded" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [NeedsTransom], [NeedsPortMid], [NeedsStrbMid] FROM [Rails_Tracking] WHERE (Rails_Tracking.ProdNo = @ProdNo) ORDER BY [Auto]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsPossibleExtraRails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [AutoID], [Rail],[Clear],[Blackout],[Powertop],[Custom],[CustomDrawNo],[Drawing] FROM [Rails_ExtraInventory] WHERE Used= '0' and (Drawing = @SR or Drawing = @PF or Drawing = @SF or Drawing = @PR or Drawing = @PM or Drawing = @SM or Drawing = @T) and Blackout = @Blackout ORDER BY [Rail]">
                <SelectParameters>
                    <asp:Parameter Name="SR" Type="String" />
                    <asp:Parameter Name="PF" Type="String" />
                    <asp:Parameter Name="SF" Type="String" />
                    <asp:Parameter Name="PR" Type="String" />
                    <asp:Parameter Name="PM" Type="String" />
                    <asp:Parameter Name="SM" Type="String" />
                    <asp:Parameter Name="T" Type="String" />
                    <asp:Parameter Name="Blackout" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
        </div>
    </form>
    <script src="../scripts/jquery-3.5.0.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
</body>
</html>
