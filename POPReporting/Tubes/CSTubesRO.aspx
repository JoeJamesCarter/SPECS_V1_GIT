<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CSTubesRO.aspx.vb" Inherits="Tubes_CSTubesRO" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer Service Tubes</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .floatleft {
            font-family: Calibri;
            font-size: 18px;
            float: left;
            vertical-align: middle;
        }

        #addnew {
            width: 400px;
        }

        #outertubedetails {
            width: 400px;
            float: left;
        }

        #centertubedetails {
            float: left;
            width: 400px;
        }

        #left {
            float: left;
            width: 500px;
            background-color: lightgray;
            margin-right: 6px;
        }

        #right {
            float: left;
            width: 1508px;
        }

        #contents {
            height: 1327px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="contents" runat="server">
            <div id="right">

                <asp:Label ID="Label34" runat="server" CssClass="newStyle4" Text="CUSTOMER SERVICE TUBES TO SCHEDULE"></asp:Label>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="ddlShow" runat="server" CssClass="newStyle1" AutoPostBack="True">
                <asp:ListItem Value="1">Not Rolled</asp:ListItem>   
                <asp:ListItem Value="2">Rolled</asp:ListItem>                             
            </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label108" runat="server" CssClass="newStyle1" Text="Search By CS Tube ID#:"></asp:Label>
&nbsp;
                <asp:TextBox ID="tbSearch" runat="server" AutoPostBack="True"></asp:TextBox>
                &nbsp;&nbsp;
                <asp:Button ID="btnClear" runat="server" Text="Clear Search" />
                <br />
                <br />
                <asp:GridView ID="gvCSOuters" runat="server" Width="1899px" Caption="CS Outer Tubes" CssClass="newStyle1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" DataKeyNames="TubeID" DataSourceID="sdsCSOuterTubes" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>                        
                        <asp:BoundField DataField="TubeID" HeaderText="CS Tube #" InsertVisible="False" ReadOnly="True" SortExpression="TubeID" />
                        <asp:BoundField DataField="OENo" HeaderText="OE #" SortExpression="OENo" />
                        <asp:BoundField DataField="Dealer" HeaderText="Dealer" SortExpression="Dealer" />
                        <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
                        <asp:TemplateField HeaderText="Length">
                            <ItemTemplate>
                                <asp:Label ID="Label31" runat="server" Text='<%#Bind("Model")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbModel" runat="server" Text='<%#Bind("Model")%>' Width="100px"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="ModelYear" HeaderText="MY" SortExpression="ModelYear" />

                        <asp:TemplateField HeaderText="Style">
                            <ItemTemplate>
                                <asp:Label ID="Label100" runat="server" Text='<%#Bind("Style")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbStyle" runat="server" Text='<%#Bind("Style")%>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>

                        <asp:BoundField DataField="Diameter" HeaderText="Diameter" SortExpression="Diameter" />

                        <asp:TemplateField HeaderText="Front">
                            <ItemTemplate>
                                <asp:Label ID="Label101" runat="server" Text='<%#Bind("Front")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbFront" runat="server" Text='<%#Bind("Front")%>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Port" HeaderText="Port" SortExpression="Port" />
                        <asp:BoundField DataField="Strb" HeaderText="Strb" SortExpression="Strb" />

                        <asp:TemplateField HeaderText="Ladder">
                            <ItemTemplate>
                                <asp:Label ID="Label102" runat="server" Text='<%#Bind("Ladder")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbLadder" runat="server" Text='<%#Bind("Ladder")%>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Fuel">
                            <ItemTemplate>
                                <asp:Label ID="Label103" runat="server" Text='<%#Bind("Fuel")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbFuel" runat="server" Text='<%#Bind("Fuel")%>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <asp:BoundField DataField="Strakes" HeaderText="Strakes" SortExpression="Strakes">

                            <ItemStyle Width="200px" />
                        </asp:BoundField>

                        <asp:TemplateField HeaderText="Splash">
                            <ItemTemplate>
                                <asp:Label ID="Label104" runat="server" Text='<%#Bind("Splash")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbSplash" runat="server" Text='<%#Bind("Splash")%>' Width="50px"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <asp:BoundField DataField="StrakesComments" HeaderText="Strakes Comments" SortExpression="StrakesComments" />
                        <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                        <asp:BoundField DataField="Black" HeaderText="Black" SortExpression="Black" />
                        <asp:BoundField DataField="StrbTrans" HeaderText="Strb Trans" SortExpression="StrbTrans">
                            <ItemStyle Width="150px" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Drawing #">
                            <ItemTemplate>
                                <asp:Label ID="Label105" runat="server" Text='<%#Bind("DrawingNo")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbDrawingNo" runat="server" Text='<%#Bind("DrawingNo")%>' Width="100px"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Scheduled">
                            <ItemTemplate>
                                <asp:Label ID="Label106" runat="server" Text='<%#Bind("OuterScheduled", "{0:d}")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Calendar ID="calOuterScheduled" runat="server"></asp:Calendar>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Roller">
                            <ItemTemplate>
                                <asp:Label ID="Label107" runat="server" Text='<%#Bind("OuterRoller")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlOuterRoller" SelectedValue='<%#Trim(Eval("OuterRoller"))%>' runat="server">
                                    <asp:ListItem>Blue</asp:ListItem>
                                    <asp:ListItem>Green</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="OuterSections" HeaderText="# Sections" SortExpression="OuterSections" />
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

                <asp:SqlDataSource ID="sdsCSOuterTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [TubeID], [OENo], [Dealer], [Customer], [Model], [ModelYear], [Style], [Diameter], [Front], [Port], [Strb], [Ctr], [Ladder], [Fuel], [Strakes], [Splash], [StrakesComments], [Comments], [Black], [StrbTrans], [DrawingNo], [OuterScheduled], [OuterRoller], [OuterSections], [OuterScheduledFlag] FROM [CS_Tubes] WHERE (([Port] = @Port And RollerPStatus = @Show) OR ([Strb] = @Strb and RollerSStatus = @show)) And TubeID like @search ORDER BY [TubeID]" >                
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="Port" Type="Int32" />
                        <asp:Parameter DefaultValue="1" Name="Strb" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlShow" DefaultValue="2" Name="show" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="tbSearch" DefaultValue="%" Name="search" Type ="String"/>
                    </SelectParameters>                    
                </asp:SqlDataSource>

                <br />
                <br />
                <asp:GridView ID="gvCSCenters" runat="server" Width="1899px" Caption="CS Center Tubes" CssClass="newStyle1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" DataKeyNames="TubeID" DataSourceID="sdsCSCenterTubes">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>                        
                        <asp:BoundField DataField="TubeID" HeaderText="CS C Tube ID" InsertVisible="False" ReadOnly="True" SortExpression="TubeID" />
                        <asp:BoundField DataField="OENo" HeaderText="OE #" SortExpression="OENo" />
                        <asp:BoundField DataField="Dealer" HeaderText="Dealer" SortExpression="Dealer" />
                        <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
                        <asp:BoundField DataField="Model" HeaderText="Length" SortExpression="Model" />
                        <asp:BoundField DataField="ModelYear" HeaderText="MY" SortExpression="ModelYear" />
                        <asp:BoundField DataField="Length" HeaderText="Length" SortExpression="Length" />
                        <asp:TemplateField HeaderText="Center" SortExpression="Center">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Center") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Center") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Storage" SortExpression="Storage">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlStorage" runat="server" Width="97px" SelectedValue='<%#Bind("Storage")%>'>
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem>STOR</asp:ListItem>
                                    <asp:ListItem>NO</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Storage") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TenWide" SortExpression="TenWide">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlTenWide" runat="server" Width="97px" SelectedValue='<%#Bind("TenWide")%>'>
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem>10 WIDE</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("TenWide") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CtrDrawingNo" HeaderText="Drawing #" SortExpression="CtrDrawingNo" />
                        <asp:BoundField DataField="CtrBracket" HeaderText="Bracket" SortExpression="CtrBracket" />
                        <asp:TemplateField HeaderText="Fuel" SortExpression="CtrFuel">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlCenterFuel" runat="server" Width="80px" SelectedValue='<%#Bind("CtrFuel")%>'>
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem>Fuel</asp:ListItem>
                                    <asp:ListItem>No Fuel</asp:ListItem>
                                    <asp:ListItem>Center</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("CtrFuel") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CtrStrakes" HeaderText="Strakes" SortExpression="CtrStrakes" />
                        <asp:BoundField DataField="TubeUpg" HeaderText="Tube Upg" SortExpression="TubeUpg" />
                        <asp:BoundField DataField="Upsweep" HeaderText="Upsweep" SortExpression="Upsweep" />
                        <asp:TemplateField HeaderText="Scheduled">
                            <ItemTemplate>
                                <asp:Label ID="Label106" runat="server" Text='<%#Bind("CenterScheduled", "{0:d}")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Calendar ID="calCenterScheduled" runat="server"></asp:Calendar>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Roller">
                            <ItemTemplate>
                                <asp:Label ID="Label107" runat="server" Text='<%#Bind("CenterRoller")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlCenterRoller" SelectedValue='<%#Trim(Eval("CenterRoller"))%>' runat="server">
                                    <asp:ListItem>Blue</asp:ListItem>
                                    <asp:ListItem>Green</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CenterSections" HeaderText="# Sections" />
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

                <asp:SqlDataSource ID="sdsCSCenterTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [TubeID], [OENo], [Dealer], [Customer], [Model], [ModelYear], [Length], [Center], [Storage], [TenWide], [CtrDrawingNo], [CtrBracket], [CtrFuel], [CtrStrakes], [TubeUpg], [Upsweep], [CenterScheduled], [CenterRoller], [CenterSections], [CenterScheduledFlag] FROM [CS_Tubes] WHERE ([Ctr] = @Ctr) And (RollerCStatus = @show) And TubeID like @search ORDER BY [TubeID]">
                
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="Ctr" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlShow" DefaultValue="0" Name="show" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="tbSearch" DefaultValue="%" Name="search" Type ="String"/>
                    </SelectParameters>                
                </asp:SqlDataSource>

                <br />
                <br />

            </div>
        </div>
    </form>
</body>
</html>
