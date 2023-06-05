<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditLoadSchedule.aspx.vb" Inherits="EditLoadSchedule" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
         <link href="StyleSheet.css" rel="stylesheet" />
    <title>EDIT LOAD SCHEDULE</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">EDIT LOAD SCHEDULE</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:table id="Table1" runat="server" cssclass="auto-style1" width="966px" gridlines="None">
                            <asp:TableRow runat="server">
                                <asp:TableCell runat="server" HorizontalAlign="center">
                                    <asp:Label ID="lblLoadsScheduled" runat="server" CssClass="newStyle4" Text=""></asp:Label><span class="newStyle3"><span class="newStyle3">&nbsp;# Loads Scheduled For Selected Day</span>
                                </asp:TableCell>
                                <asp:TableCell runat="server"><span class="newStyle3"></span>
                                    <asp:Label ID="lblTotalInYard" runat="server" Visible="false" CssClass="newStyle4" Text=""></asp:Label><span class="newStyle3"><span class="newStyle3"></span>
                                </asp:TableCell>
            <asp:TableCell>
               
              </asp:TableCell>
            <asp:TableCell rowspan="2">
             <asp:Image runat="server" img src="Images/logo-small.png" /></asp:Image>
              </asp:TableCell>                                       
        </asp:TableRow>
        <asp:TableRow>
            </asp:TableRow>
        
       
        </asp:table>

                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle3"><asp:Label ID="Label1" runat="server" Text="Date To Schedule"></asp:Label></span><asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
                    </asp:TableCell>
                    <asp:TableCell>                       
                        
                        <br />
                        <br />
                        <asp:Button ID="btnSaveEdits" runat="server" Text="Save Screen" Font-Size="20" Font-Bold="True" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table> 
        <br />
        <asp:GridView ID="gvBoatsScheduled" CssClass="newStyle1"  runat="server" DataSourceID="sdsBoatsScheduledForLoads"  Width="1000px" AutoGenerateColumns="False" CellPadding="5" DataKeyNames="loadno">
            <Columns>
                 <asp:TemplateField HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbSelectDlr" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                </asp:TemplateField>
                 <asp:BoundField DataField="LoadNo" HeaderText="Load #" >
                 <ItemStyle Width="30px" />
                 </asp:BoundField>
                <asp:TemplateField HeaderText="Planned Boats">
                    <ItemTemplate>
                        <asp:GridView ID="gvDlrBoats" runat="server" DataSourceID="sdsDlrBoats" AutoGenerateColumns="False" Width="1000px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" DataKeyNames="ProdNo">
                            <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>
                                <asp:TemplateField HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbSelectBoat" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Stop #">
                                    <ItemTemplate>
                                        <asp:TextBox ID="tbStopNo" runat="server" Width="40px" Text='<%# Eval("StopNo")%>'></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                </asp:TemplateField>                                
                                <asp:TemplateField HeaderText="Split?">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbSplitLoad" runat="server" Checked='<%# Eval("Split")%>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="30px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="CusName" HeaderText="Dealer" >
                                <ItemStyle Width="350px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" >
                                <ItemStyle Width="20px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ItemNo" HeaderText="Boat" >
                                <ItemStyle Width="100px" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Shipper">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlShippers" runat="server" SelectedValue='<%# Eval("Shipper")%>'>
                                            <asp:ListItem> </asp:ListItem>
                                             <asp:ListItem>Amino</asp:ListItem>
                                            <asp:ListItem Value="Big_Kid">Big Kid</asp:ListItem>
                                            <asp:ListItem Value="First_Choice">First Choice</asp:ListItem>
                                             <asp:ListItem Value="G_Diamond">G. Diamond</asp:ListItem>
                                            <asp:ListItem Value="Indiana_Transport">Indiana Transport</asp:ListItem>
                                            <asp:ListItem Value="Jeff_Haul">Jeff Hall Trucking</asp:ListItem>
                                               <asp:ListItem Value="LP_Logistics">LP Logistics</asp:ListItem>
                                            <asp:ListItem>Maverick</asp:ListItem>
                                            <asp:ListItem Value="Maverick_Flatbed">Maverick Flatbed</asp:ListItem>
                                            <%--<asp:ListItem Value="Maverick_Stinger">Maverick Stinger</asp:ListItem>--%>
                                            <asp:ListItem Value="Peg_Leg">Peg Leg</asp:ListItem>
                                            <asp:ListItem Value="PickUp">PickUp</asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandArgument='<%# Eval("ProdNo")%>' CommandName ="unscheduleaboat"/>
                                    </ItemTemplate>
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
                         <asp:SqlDataSource ID="sdsDlrBoats" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Load_Scheduling.LoadNo, Load_Scheduling.StopNo, Load_Scheduling.ProdNo,Load_Scheduling.ActualLoadDate,Load_Scheduling.Shipper,Load_Scheduling.Split, BML_POPREPORTING_GREENLIGHTS.CusName,BML_POPREPORTING_GREENLIGHTS.ItemNo FROM Load_Scheduling Left Join BML_POPREPORTING_GREENLIGHTS on Load_Scheduling.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where Load_Scheduling.LoadNo = @loadno and ActualLoadDate = @selecteddate Order By Load_Scheduling.LoadNo">
                <SelectParameters>                                                                                       
                     <asp:Parameter Name="loadno" DefaultValue="" Type="String" /> 
                    <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />                    
                </SelectParameters>
        </asp:SqlDataSource>

                    </ItemTemplate>
                </asp:TemplateField>                      
               
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsBoatsScheduledForLoads" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct Load_Scheduling.LoadNo FROM Load_Scheduling Where Load_Scheduling.ActualLoadDate = @selecteddate Order By Load_Scheduling.LoadNo ">
                <SelectParameters> 
                     <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />                                                                                                                 
                </SelectParameters>
        </asp:SqlDataSource>
         
    
    </div>
    </form>
</body>
</html>
