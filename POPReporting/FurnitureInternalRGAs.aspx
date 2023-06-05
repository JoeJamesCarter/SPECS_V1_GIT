<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureInternalRGAs.aspx.vb" Inherits="FurnitureInternalRGAs" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Internal Veada Repairs</title>
    <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                    <asp:TableRow>
                        <asp:TableCell>
                            <span class="newStyle7">Internal Veada Repairs</span><br />
                            <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                        </asp:TableCell>
                        <asp:TableCell>
                       <!-- #include file ="toolbar-internalrgas.aspx" -->
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </div>
            <br />
            <asp:GridView ID="gvInternalRGAs" runat="server" DataSourceID="sdsInternalRGAs" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="AutoID" AutoGenerateColumns="False" Width="1687px">
                <Columns>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                    <asp:BoundField DataField="Model" HeaderText="Model" />
                    <asp:BoundField DataField="Part" HeaderText="Part Description" />
                    <asp:BoundField DataField="Color" HeaderText="Color" />
                    <asp:BoundField DataField="Qty" HeaderText="Qty">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Reason" HeaderText="RGA Reason" />
                    <asp:BoundField DataField="DamagedBy" HeaderText="Damaged By" Visible="False" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:BoundField DataField="DateEntered" DataFormatString="{0:d}" HeaderText="Date Entered" />
                    <asp:TemplateField HeaderText="Update">
                        <ItemTemplate>
                             <div class="newStyle2">
                            <asp:RadioButtonList ID="rblStatus" runat="server" Width="150px" SelectedValue='<%# Eval("Resolved") %>'>
                                <asp:ListItem Value="0">Not Started</asp:ListItem>
                                <asp:ListItem Value="1">In Progress</asp:ListItem>
                                <asp:ListItem Value="3">Needs Sent Back</asp:ListItem>
                                <asp:ListItem Value="2">Complete</asp:ListItem>
                            </asp:RadioButtonList>
                                  </div>
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandArgument='<%# Container.DataItemIndex & ";" & Eval("AutoID")%>'  CommandName = "gotoUpdate" />

                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="DateResolved" HeaderText="Date Resolved" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsInternalRGAs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT AutoID, InternalRGAs.ProdNo, Model, Part, Color, Qty, Reason, DamagedBy, Status, DateEntered, Resolved, DateResolved, BuildLoc, FramesInstalled FROM [InternalRGAs] Left Join BML_POPREPORTING_GREENLIGHTS on InternalRGAs.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') And (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (InternalRGAs.Model LIKE '%' + @SearchBoat + '%') AND Resolved &lt;= @Resolved ORDER BY CASE WHEN BML_POPREPORTING_GREENLIGHTS.FramesInstalled is NULL Then 1 Else 0 END, BML_POPREPORTING_GREENLIGHTS.FramesInstalled asc">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="Resolved" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                     <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />
                    <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />
                     <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
    </form>
</body>
</html>
