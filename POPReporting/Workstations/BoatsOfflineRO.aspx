<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BoatsOfflineRO.aspx.vb" Inherits="Workstations_BoatsOfflineRO" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Boats Offline Now Read Only</title>
    <style type="text/css">
        .auto-style1 {
            font-family: Calibri;
        }

        .newStyle1 {
            font-family: Calibri;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                    <h1><span class="newStyle1">Boats That Are Offline Now:
                    </span>
                        <asp:Label ID="lblToday" runat="server" Text="Label" CssClass="newStyle1"></asp:Label>
                        &nbsp; Building:<asp:DropDownList ID="ddlBldg" runat="server" AutoPostBack="True">
                            <asp:ListItem Value="%">All</asp:ListItem>
                            <asp:ListItem Value="M">Main</asp:ListItem>
                            <asp:ListItem Value="V">Value</asp:ListItem>
                            <asp:ListItem Value="S">South</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;
            <asp:Label ID="lblBoatsOffline" runat="server" Text="Label"></asp:Label>&nbsp;Offline
            <asp:Label ID="lblM" runat="server" Text="Label"></asp:Label>&nbsp;M -
            <asp:Label ID="lblV" runat="server" Text="Label"></asp:Label>&nbsp;V-
            <asp:Label ID="lblS" runat="server" Text="Label"></asp:Label>&nbsp;S</h1>
                    <asp:GridView ID="GridView1" CssClass="auto-style1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatMiscNotes" Width="1065px" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" Caption="Miscellaneous Notes" CellSpacing="2">
                        <Columns>
                            <asp:BoundField DataField="Note" HeaderText="Offline Note" SortExpression="Note">
                                <ItemStyle Font-Size="14pt" Width="480px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:d}">
                                <ItemStyle Font-Size="14pt" Width="100px" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ETA" HeaderText="ETA">
                                <ItemStyle Font-Size="14pt" Width="224px" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ETADate" HeaderText="ETA Entered">
                                <ItemStyle Font-Size="14pt" Width="250px" HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                    <br />
                    <asp:SqlDataSource ID="sdsBoatMiscNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT MISC_NOTES.Auto, MISC_NOTES.Note, MISC_NOTES.Date, MISC_NOTES.Cleared,MISC_NOTES.DateCleared, MISC_NOTES.ETA,MISC_NOTES.ETADate FROM [MISC_NOTES] WHERE MISC_NOTES.Cleared = 0 ORDER BY [Auto]"></asp:SqlDataSource>

                    <asp:GridView ID="gvProdsOffline" runat="server" AutoGenerateColumns="False" CssClass="auto-style1" DataKeyNames="ProdNo" DataSourceID="sdsOffline" Width="1024px" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2">
                        <Columns>
                            <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo">

                                <ItemStyle HorizontalAlign="Center" Width="80px" Font-Bold="True" Font-Size="16pt" />
                            </asp:BoundField>

                            <asp:BoundField DataField="ItemNo" HeaderText="Model" ReadOnly="True" SortExpression="ItemNo">
                                <ItemStyle HorizontalAlign="Center" Width="120px" Font-Bold="True" Font-Size="16pt" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Side-lined Reasons">
                                <ItemTemplate>
                                    <asp:GridView ID="gvReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsOfflineReasons" AutoGenerateColumns="False" Width="834px" Style="text-align: left" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                                        <Columns>
                                            <asp:BoundField DataField="Auto" Visible="False" />
                                            <asp:BoundField DataField="OfflineNote" HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="200px" Font-Size="14pt" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Date" HeaderText="" DataFormatString="{0:d}">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="120px" Font-Size="14pt" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ETA" HeaderText="ETA">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="300px" Font-Size="14pt" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ETADate" HeaderText="ETA Entered">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="170px" Font-Size="14pt" HorizontalAlign="Center" VerticalAlign="Top" />
                                            </asp:BoundField>
                                        </Columns>
                                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                        <SortedDescendingHeaderStyle BackColor="#242121" />
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="sdsOfflineReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date, BML_POPREPORTING_OFFLINE.Cleared, BML_POPREPORTING_OFFLINE.ETA, BML_POPREPORTING_OFFLINE.ETADate FROM BML_POPREPORTING_OFFLINE WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) Order By BML_POPREPORTING_OFFLINE.Date">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="gvProdsOffline" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsOffline" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct BML_POPREPORTING_GREENLIGHTS.ProdNo,BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM BML_POPREPORTING_OFFLINE LEFT JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING_OFFLINE.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus <> @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') AND BML_POPREPORTING_GREENLIGHTS.ProdNo IN(Select Distinct(ProdNo) from BML_POPREPORTING_OFFLINE Where BML_POPREPORTING_OFFLINE.Cleared = 0 AND BML_POPREPORTING_OFFLINE.OfflineNote <> '') Order By BML_POPREPORTING_GREENLIGHTS.ProdNo">
                        <SelectParameters>
                            <asp:Parameter Name="IsBoatOffline" Type="Int16" DefaultValue="1" />
                            <asp:Parameter Name="CompleteStatus" Type="Int16" DefaultValue="2" />
                            <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ContentTemplate>

            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
