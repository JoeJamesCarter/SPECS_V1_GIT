<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BoatsOffline.aspx.vb" Inherits="Workstations_BoatsOffline" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Boats Offline Now</title>
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
            <asp:Label ID="lblBoatsOffline" runat="server" Text="Label"></asp:Label>
&nbsp;Offline
            <asp:Label ID="lblM" runat="server" Text="Label"></asp:Label>&nbsp;M -
              <asp:Label ID="lblV" runat="server" Text="Label"></asp:Label>&nbsp;V-
            <asp:Label ID="lblS" runat="server" Text="Label"></asp:Label>&nbsp;S&nbsp; &nbsp;&nbsp;  </h1> 
            <asp:HyperLink ID="HyperLink1" runat="server" BorderStyle="Solid" NavigateUrl="../Misc_Notes.aspx" BorderWidth="1px" Target="_blank">Add Misc Note</asp:HyperLink>
      
       
      
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatMiscNotes" CssClass="auto-style1" Width="1196px" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" Caption="Miscellaneous Notes" CellPadding="4" CellSpacing="2" ForeColor="Black">
            <Columns>
                <asp:BoundField DataField="Note" HeaderText="Misc Note" SortExpression="Note" >
                <ItemStyle Font-Size="14pt" Width="400px" />
                </asp:BoundField>
                <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="" SortExpression="Date" >
                <ItemStyle Font-Size="14pt" Width="250px" HorizontalAlign="Center" />
                </asp:BoundField>
                 <asp:BoundField DataField="ETA" HeaderText="ETA"  >
                <ItemStyle Font-Size="14pt" Width="224px" HorizontalAlign="Center"/>
                </asp:BoundField>                 
                 <asp:BoundField DataField="ETADate" HeaderText="ETA Entered">
                <ItemStyle Font-Size="14pt" Width="250px" HorizontalAlign="Center"/>
                </asp:BoundField>                        
                <asp:TemplateField HeaderText="Clear">
                     <ItemTemplate>
                      <asp:ImageButton ID="btnClear" runat="server" ImageUrl='<%# Eval("Cleared", "../Images/cleared{0}.png")%>' CommandArgument='<%# Eval("Auto")%>' CommandName ="clearmiscnote" />
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
        <br />
        <asp:SqlDataSource ID="sdsBoatMiscNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT MISC_NOTES.Auto, MISC_NOTES.Note, MISC_NOTES.Date, MISC_NOTES.Cleared,MISC_NOTES.DateCleared, MISC_NOTES.ETA,MISC_NOTES.ETADate FROM [MISC_NOTES] WHERE MISC_NOTES.Cleared = 0 ORDER BY [Auto]">
           
        </asp:SqlDataSource>
    
        <asp:GridView ID="gvProdsOffline" runat="server" AutoGenerateColumns="False" CssClass="auto-style1" DataKeyNames="ProdNo" DataSourceID="sdsOffline" Width="1024px" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo"  >                  

                <ItemStyle HorizontalAlign="Center" Width="80px" Font-Bold="True" Font-Size="16pt" />
                </asp:BoundField>

                <asp:BoundField DataField="ItemNo" HeaderText="Model" ReadOnly="True" SortExpression="ItemNo"  >
                <ItemStyle HorizontalAlign="Center" Width="120px" Font-Bold="True" Font-Size="16pt" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Status">
                     <ItemTemplate>
                      <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName ="gotooffline" />
                    </ItemTemplate>
                     <ItemStyle HorizontalAlign="Center" Width="70px" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Sidelined Reasons">
                    <ItemTemplate>
                        <asp:GridView ID="gvReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsOfflineReasons" Width="850px" AutoGenerateColumns="False" style="text-align: left">
                            <Columns>
                                <asp:BoundField DataField="Auto" Visible="False" />
                                <asp:BoundField DataField="OfflineNote" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="200px" Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:d}" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="120px" Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="ETA" HeaderText="ETA" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="300px" Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ETADate" HeaderText="ETA Entered" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="230px" Font-Size="14pt" HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:BoundField>     
                                 <asp:TemplateField HeaderText="Clear">
                     <ItemTemplate>
                      <asp:ImageButton ID="btnClear" runat="server" ImageUrl='<%# Eval("Cleared", "../Images/cleared{0}.png")%>' CommandArgument='<%# Eval("Auto")%>' CommandName ="clearsidelineitem" />
                    </ItemTemplate>
                                     <HeaderStyle HorizontalAlign="Center" />
                     <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>                            
                            </Columns>
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
        <asp:SqlDataSource ID="sdsOffline" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.ProdNo AS Expr1 FROM BML_POPREPORTING_OFFLINE INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING_OFFLINE.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus <> @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') Order By BML_POPREPORTING_OFFLINE.ProdNo" >
            <SelectParameters>
                <asp:Parameter Name="IsBoatOffline" Type="Int16" DefaultValue="1" />
                 <asp:Parameter Name="CompleteStatus" Type="Int16" DefaultValue="2" />
                 <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" /> 
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="gvCompletewOpenIssues" runat="server" AutoGenerateColumns="False" CssClass="auto-style1" DataKeyNames="ProdNo" DataSourceID="sdsDoneWUnclearedIssues" Width="1024px" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" Caption="Completed Boats with Uncleared Side Line Items">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo"  >                  

                <ItemStyle HorizontalAlign="Center" Width="80px" Font-Bold="True" Font-Size="16pt" />
                </asp:BoundField>

                <asp:BoundField DataField="ItemNo" HeaderText="Model" ReadOnly="True" SortExpression="ItemNo"  >
                <ItemStyle HorizontalAlign="Center" Width="120px" Font-Bold="True" Font-Size="16pt" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Status">
                     <ItemTemplate>
                      <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName ="gotooffline" />
                    </ItemTemplate>
                     <ItemStyle HorizontalAlign="Center" Width="70px" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Sidelined Reasons">
                    <ItemTemplate>
                        <asp:GridView ID="gvCompleteReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsCompletewOfflineReasons" Width="850px" AutoGenerateColumns="False" style="text-align: left">
                            <Columns>
                                <asp:BoundField DataField="Auto" Visible="False" />
                                <asp:BoundField DataField="OfflineNote" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="200px" Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:d}" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="120px" Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="ETA" HeaderText="ETA" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="300px" Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ETADate" HeaderText="ETA Entered" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="230px" Font-Size="14pt" HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:BoundField>     
                                 <asp:TemplateField HeaderText="Clear">
                     <ItemTemplate>
                      <asp:ImageButton ID="btnClear" runat="server" ImageUrl='<%# Eval("Cleared", "../Images/cleared{0}.png")%>' CommandArgument='<%# Eval("Auto")%>' CommandName ="clearcompletesidelineitem" />
                    </ItemTemplate>
                                     <HeaderStyle HorizontalAlign="Center" />
                     <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>                            
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsCompletewOfflineReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date, BML_POPREPORTING_OFFLINE.Cleared, BML_POPREPORTING_OFFLINE.ETA, BML_POPREPORTING_OFFLINE.ETADate FROM BML_POPREPORTING_OFFLINE WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) Order By BML_POPREPORTING_OFFLINE.Date">
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

        <asp:SqlDataSource ID="sdsDoneWUnclearedIssues" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.ProdNo AS Expr1 FROM BML_POPREPORTING_OFFLINE Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING_OFFLINE.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) and (BML_POPREPORTING_OFFLINE.OfflineNote <> '') and (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') Order By BML_POPREPORTING_OFFLINE.ProdNo" >
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
