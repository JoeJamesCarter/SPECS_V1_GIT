<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SidelineETA.aspx.vb" Inherits="Workstations_SidelineETA" MaintainScrollPositionOnPostback="true" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sideline ETA's</title>
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
    
        <h1><span class="newStyle1">Sideline ETA's:
        </span>
        <asp:Label ID="lblToday" runat="server" Text="Label" CssClass="newStyle1"></asp:Label>
        &nbsp; Building:<asp:DropDownList ID="ddlBldg" runat="server" AutoPostBack="True">
                <asp:ListItem Value="%">All</asp:ListItem>
                <asp:ListItem Value="M">Main</asp:ListItem>
                <asp:ListItem Value="S">South</asp:ListItem>
                <asp:ListItem Value="V">Value</asp:ListItem>
            </asp:DropDownList>
        &nbsp;
            <asp:Label ID="lblBoatsOffline" runat="server" Text="Label"></asp:Label>
&nbsp;Offline
            <asp:Label ID="lblM" runat="server" Text="Label"></asp:Label>
&nbsp;M -
            <asp:Label ID="lblS" runat="server" Text="Label"></asp:Label>
&nbsp;S</h1>
          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatMiscNotes" CssClass="auto-style1" Width="1024px" Caption="Miscellaneous Notes" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
            <Columns>
                <asp:BoundField DataField="Note" HeaderText="Misc Note" SortExpression="Note" >
                <ItemStyle Font-Size="14pt" Width="825px" />
                </asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" >
                <ItemStyle Font-Size="14pt" Width="260px" />
                </asp:BoundField> 
                <asp:TemplateField HeaderText="ETA">
                                     <ItemTemplate>
                                         <asp:TextBox ID="tbETA" runat="server" Text='<%# Eval("ETA") %>' Width="226px" Height="36px"></asp:TextBox>
                                     </ItemTemplate>                                     
                                     <ItemStyle Width="226px" />
                </asp:TemplateField>                                         
                <asp:TemplateField HeaderText="Update">
                     <ItemTemplate>                      
                    <asp:Button ID="btnUpdateETA" runat="server" CommandArgument= '<%# Eval("Auto")%>' CommandName ="clearmiscnote"  Text="Update" />
                          </ItemTemplate>
                                     <HeaderStyle HorizontalAlign="Center" />
                     <ItemStyle HorizontalAlign="Center" Width="50px" />
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
        <asp:SqlDataSource ID="sdsBoatMiscNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT MISC_NOTES.Auto, MISC_NOTES.Note, MISC_NOTES.Date, MISC_NOTES.Cleared,MISC_NOTES.DateCleared, MISC_NOTES.ETA,MISC_NOTES.ETADate FROM [MISC_NOTES] WHERE MISC_NOTES.Cleared = 0 ORDER BY [Auto]">
           
        </asp:SqlDataSource>
        <br />
       
        <asp:GridView ID="gvProdsOffline" runat="server" AutoGenerateColumns="False" CssClass="auto-style1" DataKeyNames="ProdNo" DataSourceID="sdsOffline" Width="1024px">
            <Columns>                
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo"  >                  

                <ItemStyle HorizontalAlign="Center" Width="80px" Font-Bold="True" Font-Size="16pt" />
                </asp:BoundField>

                <asp:BoundField DataField="ItemNo" HeaderText="Model" ReadOnly="True" SortExpression="ItemNo"  >
                <ItemStyle HorizontalAlign="Center" Width="120px" Font-Bold="True" Font-Size="16pt" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Status">
                     <ItemTemplate>
                      <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>'/>
                    </ItemTemplate>
                     <ItemStyle HorizontalAlign="Center" Width="70px" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Sidelined Reasons">
                    <ItemTemplate>
                        <asp:GridView ID="gvReasons" runat="server" DataKeyNames="Auto" DataSourceID="sdsOfflineReasons" AutoGenerateColumns="False" style="text-align: left" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" OnRowCommand="gvReasons_RowCommand">
                            <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>
                                <asp:BoundField DataField="Auto" Visible="True" HeaderText ="ID" />
                                <asp:BoundField DataField="OfflineNote" HeaderText="Reasons" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="500px" Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" HeaderText="Date" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="500px" Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                 <asp:TemplateField HeaderText="ETA">
                                     <ItemTemplate>
                                         <asp:TextBox ID="tbETA" runat="server" Text='<%# Eval("ETA") %>' Width="226px" Height="36px"></asp:TextBox>
                                     </ItemTemplate>                                     
                </asp:TemplateField>                          
                               <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <asp:Button ID="btnUpdateETA" runat="server" CommandArgument="<%# Container.DataItemIndex %>" CommandName="updateeta" Text="Update" />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
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
        </asp:GridView>
        <asp:SqlDataSource ID="sdsOffline" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.ProdNo AS Expr1 FROM BML_POPREPORTING_OFFLINE INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING_OFFLINE.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus <> @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') Order By BML_POPREPORTING_OFFLINE.ProdNo" >
            <SelectParameters>
                <asp:Parameter Name="IsBoatOffline" Type="Int16" DefaultValue="1" />
                 <asp:Parameter Name="CompleteStatus" Type="Int16" DefaultValue="2" />
                 <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" /> 
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
