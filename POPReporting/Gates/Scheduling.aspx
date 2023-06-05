<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Scheduling.aspx.vb" Inherits="Gates_Scheduling" MaintainScrollPositionOnPostback="true" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GATES SCHEDULING</title>
    <link href = "../StyleSheet.css" rel="stylesheet" />     

</head>

<body>
            <form id = "form1" runat="server">
        <div>
        <asp:Table ID = "tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">GATES SCHEDULING</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <!-- #include file ="../Gates/toolbar-gatesscheduling.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle3">
                            <asp:Label ID="Label1" runat="server" Text="Date To Schedule"></asp:Label></span><asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
                    </asp:TableCell>
                    <asp:TableCell>
                        <span class="newStyle3">
                            <asp:Label ID="Label2" runat="server" Text="Check the Yellow Customs. They only lines that need saved are the ones that you change. If you find a problem with a standard gate, change it, but please tell Keri. When the gates dept clicks off a boat, each gate shown here will decrement from inventory."></asp:Label></span>&nbsp;&nbsp;&nbsp;<asp:Button ID="btnExportGateLabels" runat="server" Text="Export Labels" /></br></br>
                            <asp:Label runat="server">Red means that the drawing does not exists in the master list of drawings and needs to be fixed.</asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            
            </asp:Table>
        </div>
        <div>
            <br />
            <asp:GridView ID="gvGatesSchedule" CssClass="newStyle1" runat="server" DataSourceID="sdsGatesTracking" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #">
                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Model">
                        <ItemTemplate>
                            <asp:Label ID="lblModel" runat="server" Text='<%# Eval("ItemNo") %>'></asp:Label>
                            <asp:ImageButton ID="btnOrderDetails" runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" ImageUrl="../Images/getboatdetails.png" />
                        </ItemTemplate>
                        <ItemStyle Width="150px" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="Blackout" HeaderText="Blackout">
                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="# Mfg Gates">
                        <ItemTemplate>
                           <%-- <asp:TextBox ID="tbNumGates" runat="server" Text='<%#Eval("NumGates") %>' Width="20px"></asp:TextBox>--%>
                            <asp:Label ID="lblNumGates" runat="server" Text='<%#Eval("NumGates") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Bow Ctr">
                        <ItemTemplate>                          
                            <asp:DropDownList ID="ddlGate1" runat="server" AppendDataBoundItems="true" OnDataBinding="myDDList_DataBinding1" DataSourceID="sdsGatesList" DataTextField="DrawingNo" DataValueField="DrawingNo" SelectedValue='<%# Trim(Eval("BowCtr").ToString())%>' >
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <ItemStyle Font-Names="Calibri" Font-Size="16pt" HorizontalAlign="Center" Width="75px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Port">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlGate2" runat="server" DataSourceID="sdsGatesList" DataTextField="DrawingNo" AppendDataBoundItems="true" DataValueField="DrawingNo" OnDataBinding="myDDList_DataBinding1" SelectedValue='<%#Trim(Eval("Port").ToString()) %>'>
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <ItemStyle Font-Names="Calibri" Font-Size="16pt" HorizontalAlign="Center" Width="75px" />
                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="Strb">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlGate3" runat="server" DataSourceID="sdsGatesList" DataTextField="DrawingNo" AppendDataBoundItems="true" DataValueField="DrawingNo" OnDataBinding="myDDList_DataBinding1" SelectedValue='<%# Trim(Eval("Strb").ToString()) %>'>
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <ItemStyle Font-Names="Calibri" Font-Size="16pt" HorizontalAlign="Center" Width="75px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Aft Port">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlGate4" runat="server" DataSourceID="sdsGatesList" DataTextField="DrawingNo" AppendDataBoundItems="true" DataValueField="DrawingNo" OnDataBinding="myDDList_DataBinding1" SelectedValue='<%#Trim(Eval("AftPort").ToString()) %>'>
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <ItemStyle Font-Names="Calibri" Font-Size="16pt" HorizontalAlign="Center" Width="75px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Aft Ctr">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlGate5" runat="server" DataSourceID="sdsGatesList" DataTextField="DrawingNo" AppendDataBoundItems="true" DataValueField="DrawingNo" OnDataBinding="myDDList_DataBinding1" SelectedValue='<%#Trim(Eval("AftCtr").ToString()) %>'>
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <ItemStyle Font-Names="Calibri" Font-Size="16pt" HorizontalAlign="Center" Width="75px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Aft Strb">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlGate6" runat="server" DataSourceID="sdsGatesList" DataTextField="DrawingNo" AppendDataBoundItems="true" DataValueField="DrawingNo" OnDataBinding="myDDList_DataBinding1" SelectedValue='<%#Trim(Eval("AftStrb").ToString()) %>'>
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <ItemStyle Font-Names="Calibri" Font-Size="16pt" HorizontalAlign="Center" Width="75px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Save">
                        <ItemTemplate>
                            <asp:Button ID="btnSaveRow" runat="server" Text="Save Changes" CommandArgument="<%# Container.DataItemIndex %>" CommandName="savegatechanges" />
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

            <asp:GridView ID="gvExportedLabels" CssClass="newStyle1" runat="server"></asp:GridView>
        </div>

        <asp:SqlDataSource ID="sdsGatesList" runat="server" ConnectionString="<%$ ConnectionStrings:ProductInfoConnectionString %>" SelectCommand="SELECT Distinct(DrawingNo) FROM [Drawings] Where InActiveFlag = 0 and Category = 'GATE' Order By DrawingNo"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsGatesTracking" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rails_Tracking.ProdNo, Rails_Tracking.SONo, Rails_Tracking.ItemNo,  Rails_Tracking.WeldDate, Rails_Tracking.Blackout, Rails_Tracking.CustDrawNo, Rails_Tracking.Scheduled, BML_POPREPORTING_GREENLIGHTS.IsCustom, BowCtr, Port, Strb, AftPort, AftCtr, AftStrb, NumGates FROM Rails_Tracking Left JOIN BML_POPREPORTING_GREENLIGHTS on Rails_Tracking.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo LEFT JOIN Gates_ByProd on Rails_Tracking.ProdNo = Gates_ByProd.ProdNo WHERE (Convert(date,Rails_Tracking.WeldDate) = @Calendar) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchBoat + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo NOT LIKE '%QX%') ORDER BY Rails_Tracking.ProdNo">
        

            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Calendar" PropertyName="SelectedDate" />
                <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='1%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
                  
    </form>
</body>
</html>
