<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PrePaidBackOrder.aspx.vb" Inherits="Workstations_PrePaidBackOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pre-Paid Backorder</title>
    <script>
        function RefreshParent() {
            window.opener.document.getElementById('btnRefresh').click();
            window.close();
        }
        window.onbeforeunload = RefreshParent
    </script>

    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .capitalize {
            text-transform: capitalize
        }

        .newStyle11 {
            font-family: Calibri;
            font-size: 20px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h2><span class="newStyle11">Create A Prepaid Back Order</span></h2>

            <asp:GridView ID="gvRedTagReasons" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRedTagReasons" DataKeyNames="Auto" Width="540px" CssClass="newStyle11">
                <Columns>
                    <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date Tagged">
                        <ItemStyle Font-Names="Calibri" Font-Size="14pt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="RedTagNote" HeaderText="Reason" SortExpression="RedTagNote" ShowHeader="False">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="capitalize" Font-Names="Calibri" Font-Size="14pt" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            <br />
            <h3><span class="newStyle11">Back Orders</span></h3>
            <asp:SqlDataSource ID="sdsRedTagReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [RedTagNote],[Auto],[DATE] FROM [BML_POPREPORTING_REDTAGS] WHERE ([ProdNo] = @ProdNo)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvRedTagReasons" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="gvBOs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBOs" DataKeyNames="AutoID" Width="540px" CssClass="newStyle11">
                <Columns>
                    <asp:BoundField DataField="BO_Item_Desc" HeaderText="BackOrder" SortExpression="BO_Item_Desc" ShowHeader="False">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Calibri" Font-Size="14pt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Date_Cleared" HeaderText="Date Cleared">
                        <ItemStyle Font-Names="Calibri" Font-Size="14pt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Cleared_By" HeaderText="Cleared By">
                        <ItemStyle Font-Names="Calibri" Font-Size="14pt" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsBOs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [BO_Item_Desc],[AutoID],[Date_Cleared],[Cleared_By] FROM [VEADA_BACKORDERS] WHERE ([ProdNo] = @ProdNo)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvBOs" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>


            <h3>
                <br />
                <span class="newStyle11">RGA&#39;s</span></h3>


            <asp:GridView ID="gvRGAs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRGAs" DataKeyNames="AutoID" CellPadding="3" Width="540px" GridLines="Horizontal" Font-Size="12pt" CssClass="newStyle11">
                <Columns>
                    <asp:BoundField DataField="AutoID" Visible="False" />
                    <asp:BoundField DataField="RGA_Item_Desc" HeaderText="Part" SortExpression="RGA_Item_Desc">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="300px" Font-Names="Calibri" Font-Size="14pt" />
                    </asp:BoundField>
                    <asp:ImageField DataImageUrlField="BenRcvd" DataImageUrlFormatString="../Images/rgarcvd{0}.png" HeaderText="Rcvd">
                        <ItemStyle HorizontalAlign="Center" Font-Names="Calibri" Font-Size="14pt" />
                    </asp:ImageField>
                    <asp:BoundField DataField="BenRcvdDate" DataFormatString="{0:d}" HeaderText="Date">
                        <ItemStyle Font-Names="Calibri" Font-Size="14pt" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnStatus" runat="server" ImageUrl='<%# Eval("Status", "../Images/needed{0}.png")%>' CommandArgument='<%#Eval("AutoID")%>' CommandName="gotostatusupdate" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Font-Names="Calibri" Font-Size="14pt" />
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle Font-Size="12pt" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [RGA_Item_Desc],[AutoID],[BenRcvd],[BenRcvdDate],[Status] FROM [VEADA_RGAS] WHERE ([ProdNo] = @ProdNo)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvRGAs" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>


            <br />
            <h3><span class="newStyle11">What Parts are On Prepaid Backorder?</span></h3>
            <br />
            <asp:TextBox ID="tbNote" runat="server" Height="225px" TextMode="MultiLine" Width="540px"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="Send" />

        </div>
    </form>
</body>
</html>
