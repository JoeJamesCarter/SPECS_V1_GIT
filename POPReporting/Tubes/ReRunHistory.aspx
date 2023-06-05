<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReRunHistory.aspx.vb" Inherits="Tubes_ReRunHistory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TUBE RERUN HISTORY</title>
    
       <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="TUBE RERUN HISTORY" CssClass="newStyle7"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text="Prod #:"></asp:Label>
&nbsp;<asp:TextBox ID="tbSearch" runat="server" AutoPostBack="True"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnSearch" runat="server" Text="Search" />
            &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnClear" runat="server" Text="Clear" />
            <br />
            <asp:GridView ID="gvTubeReruns" runat="server" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" CssClass="newStyle1" DataSourceID="sdsTubeReruns" ForeColor="Black">
                <Columns>
                    <asp:BoundField DataField="ProdNo" HeaderText="ProdNo" SortExpression="ProdNo" />
                    <asp:BoundField DataField="Tube" HeaderText="Tube" SortExpression="Tube" />                                       
                    <asp:BoundField DataField="DateReported" HeaderText="Date Reported" SortExpression="DateReported" DataFormatString="{0:D}" />                                                   
                    <asp:TemplateField HeaderText ="Port ReRolled">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("ROLLERP") %>' Visible =' <%# Eval("Tube") = "PORT"%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Strb ReRolled">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("ROLLERS") %>' Visible =' <%# Eval("Tube") = "STRB"%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Ctr ReRolled">
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("ROLLERC") %>' Visible =' <%# Eval("Tube") = "CTR"%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Damage Reported">
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%#Eval("PortDmgDesc")%>' Visible = ' <%# Eval("Tube") = "PORT"%>'></asp:Label>
                            <asp:Label ID="Label7" runat="server" Text='<%#Eval("StrbDmgDesc")%>' Visible = ' <%# Eval("Tube") = "STRB"%>'></asp:Label>
                            <asp:Label ID="Label8" runat="server" Text='<%#Eval("CtrDmgDesc")%>' Visible = ' <%# Eval("Tube") = "CTR"%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>                    
                     <asp:BoundField DataField="ReRolled" HeaderText="Ready for Reinstall" SortExpression="ReRolled" DataFormatString="{0:U}" />
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
            <asp:SqlDataSource ID="sdsTubeReruns" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Tubes_DamageReported.ProdNo, [Tube], [PortDmgDesc], [StrbDmgDesc], [CtrDmgDesc], [DateReported], [Replaced], [ReplacedFlag], [ReRolledStatus], [ReRolled], [IsScrap], RollerP, RollerS, RollerC FROM [Tubes_DamageReported] Left join Tubes on Tubes_DamageReported.ProdNo = Tubes.ProdNo WHERE ([ActionRequired] = @ActionRequired) And ReRolledStatus = '1' AND (Tubes_DamageReported.ProdNo LIKE '%' + @Search + '%') ORDER BY [ReRolled] DESC">
                <SelectParameters>
                    <asp:Parameter DefaultValue="REPLACE" Name="ActionRequired" Type="String" />
                    <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '2%' Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
