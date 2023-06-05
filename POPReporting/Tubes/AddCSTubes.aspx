<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddCSTubes.aspx.vb" Inherits="Tubes_AddCSTubes" Debug="true" %>

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
            <div style="width: 431px" id="left">

                <div id="addnew" runat="server">
                    <asp:Label ID="Label2" runat="server" CssClass="newStyle4" Text="ADD CS TUBE(S)"></asp:Label>

                    <br />
                    <br />
                    <asp:Label ID="Label3" runat="server" CssClass="newStyle1" Text="OE #*" Width="100px"></asp:Label>
                    <asp:TextBox
                        ID="tbOE" runat="server" CssClass="newStyle1"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label4" runat="server" CssClass="newStyle1" Text="Dealer:*" Width="100px"></asp:Label>
                    <asp:TextBox ID="tbDealer" runat="server" CssClass="newStyle1"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label5" runat="server" CssClass="newStyle1" Text="Customer:" Width="100px"></asp:Label>
                    <asp:TextBox ID="tbCustomer" runat="server" CssClass="newStyle1"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label10" runat="server" CssClass="newStyle1" Text="Model:*" Width="100px"></asp:Label>
                    <asp:TextBox ID="tbModel" runat="server" CssClass="newStyle1"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label6" runat="server" CssClass="newStyle1" Text="Model Year:" Width="100px"></asp:Label>
                    <asp:TextBox ID="tbModelYear" runat="server" CssClass="newStyle1"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Label ID="Label7" runat="server" CssClass="floatleft" Text="Tube(s):" Width="100px" Height="27px"></asp:Label>
                    &nbsp;&nbsp;
            <asp:CheckBoxList ID="cbTubes" runat="server" AutoPostBack="True" CssClass="newStyle7" RepeatDirection="Horizontal" Width="188px" Height="16px">
                <asp:ListItem>P</asp:ListItem>
                <asp:ListItem>S</asp:ListItem>
                <asp:ListItem>C</asp:ListItem>
            </asp:CheckBoxList>
                    <br />
                    <asp:Label ID="Label8" runat="server" CssClass="newStyle1" Text="# Outer Tube Sections:" Width="192px"></asp:Label>
                    <asp:DropDownList ID="ddlOuterSections" runat="server">
                        <asp:ListItem>0</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:Label ID="Label9" runat="server" CssClass="newStyle1" Text="# Center Tube Sections:" Width="192px"></asp:Label>
                    <asp:DropDownList ID="ddlCenterSections" runat="server">
                        <asp:ListItem>0</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <br />
                </div>

                <div id="outertubedetails" runat="server">

                    <asp:Label ID="Label12" runat="server" CssClass="newStyle4" Text="OUTER TUBE(S) DETAIL"></asp:Label>

                    <br />
                    <br />
                    <asp:Label ID="Label11" runat="server" CssClass="newStyle1" Text="Style:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbStyle" runat="server" CssClass="newStyle1" Width="112px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label13" runat="server" CssClass="newStyle1" Text="Diameter:" Width="160px"></asp:Label>
                    <asp:DropDownList ID="ddlDiameter" runat="server" Width="50px">
                        <asp:ListItem>0</asp:ListItem>
                        <asp:ListItem>23</asp:ListItem>
                        <asp:ListItem>25</asp:ListItem>
                        <asp:ListItem>32</asp:ListItem>
                    </asp:DropDownList>

                    <br />
                    <asp:Label ID="Label14" runat="server" CssClass="newStyle1" Text="Front:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbFront" runat="server" CssClass="newStyle1" Width="112px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label1" runat="server" CssClass="newStyle1" Text="Ladder:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbLadder" runat="server" CssClass="newStyle1" Width="66px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label15" runat="server" CssClass="newStyle1" Text="Bracket:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbBrackets" runat="server" CssClass="newStyle1" Width="31px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label16" runat="server" CssClass="newStyle1" Text="Keel:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbKeel" runat="server" CssClass="newStyle1" Width="31px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label17" runat="server" CssClass="newStyle1" Text="Fuel:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbFuel" runat="server" CssClass="newStyle1" Width="112px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label18" runat="server" CssClass="newStyle1" Text="Splash:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbSplash" runat="server" CssClass="newStyle1" Width="112px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label21" runat="server" CssClass="newStyle1" Text="Strakes:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbStrakes" runat="server" CssClass="newStyle1" Width="112px"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label19" runat="server" CssClass="newStyle1" Text="Strakes Comments:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbStrakesComments" runat="server" CssClass="newStyle1" Width="200px"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label35" runat="server" CssClass="newStyle1" Text="Strb Trans:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbStrbTrans" runat="server" CssClass="newStyle1" Width="200px"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label20" runat="server" CssClass="newStyle1" Text="Comments:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbComments" runat="server" CssClass="newStyle1" Width="200px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label36" runat="server" CssClass="newStyle1" Text="Black:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbBlack" runat="server" CssClass="newStyle1" Width="200px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label37" runat="server" CssClass="newStyle1" Text="Drawing #:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbDrawingNo" runat="server" CssClass="newStyle1" Width="112px"></asp:TextBox>

                    <br />

                    <asp:Label ID="Label38" runat="server" CssClass="newStyle1" Text="Outer Roller:" Width="160px"></asp:Label>
                    <asp:DropDownList ID="ddlOuterRoller" runat="server" Width="80px">
                        <asp:ListItem>Blue</asp:ListItem>
                        <asp:ListItem>Green</asp:ListItem>
                    </asp:DropDownList>

                    <br />

                </div>
                <div id="centertubedetails" runat="server">

                    <asp:Label ID="Label22" runat="server" CssClass="newStyle4" Text="CENTER TUBE DETAIL"></asp:Label>

                    <br />
                    <br />
                    <asp:Label ID="Label23" runat="server" CssClass="newStyle1" Text="Length:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbLength" runat="server" CssClass="newStyle1" Width="40px"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label33" runat="server" CssClass="newStyle1" Text="Center:" Width="160px"></asp:Label>
                    <asp:DropDownList ID="ddlCenter" runat="server" Width="116px">
                        <asp:ListItem></asp:ListItem>
                        <asp:ListItem>ELLIPTICAL</asp:ListItem>
                        <asp:ListItem>EXP</asp:ListItem>
                        <asp:ListItem>IO</asp:ListItem>
                        <asp:ListItem>ROUND</asp:ListItem>
                       
                    </asp:DropDownList>

                    <br />
                    <asp:Label ID="Label24" runat="server" CssClass="newStyle1" Text="Storage:" Width="160px"></asp:Label>
                    <asp:DropDownList ID="ddlStorage" runat="server" Width="97px">
                        <asp:ListItem></asp:ListItem>
                        <asp:ListItem>STOR</asp:ListItem>
                        <asp:ListItem>NO</asp:ListItem>
                    </asp:DropDownList>

                    <br />
                    <asp:Label ID="Label25" runat="server" CssClass="newStyle1" Text="10 Wide:" Width="160px"></asp:Label>
                    <asp:DropDownList ID="ddlTenWide" runat="server" Width="89px">
                        <asp:ListItem></asp:ListItem>
                        <asp:ListItem>10 WIDE</asp:ListItem>
                    </asp:DropDownList>

                    <br />
                    <asp:Label ID="Label26" runat="server" CssClass="newStyle1" Text="Drawing #:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbCtrDrawingNo" runat="server" CssClass="newStyle1" Width="112px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label27" runat="server" CssClass="newStyle1" Text="Bracket:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbCtrBracket" runat="server" CssClass="newStyle1" Width="52px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label28" runat="server" CssClass="newStyle1" Text="Fuel:" Width="160px"></asp:Label>
                    <asp:DropDownList ID="ddlCenterFuel" runat="server" Width="80px">
                        <asp:ListItem></asp:ListItem>
                        <asp:ListItem>Fuel</asp:ListItem>
                        <asp:ListItem>No Fuel</asp:ListItem>
                        <asp:ListItem>Center</asp:ListItem>
                    </asp:DropDownList>

                    <br />
                    <asp:Label ID="Label29" runat="server" CssClass="newStyle1" Text="Strakes:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbCenterStrakes" runat="server" CssClass="newStyle1" Width="200px"></asp:TextBox>

                    <br />
                    <asp:Label ID="Label30" runat="server" CssClass="newStyle1" Text="Tupe Upg:" Width="160px"></asp:Label>
                    <asp:TextBox ID="tbTubeUpg" runat="server" CssClass="newStyle1" Width="112px"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label32" runat="server" CssClass="newStyle1" Text="Upsweep/Sld Trans:" Width="160px"></asp:Label>

                    <asp:TextBox ID="tbUpsweep" runat="server" CssClass="newStyle1" Width="200px"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label39" runat="server" CssClass="newStyle1" Text="Center Roller:" Width="160px"></asp:Label>
                    <asp:DropDownList ID="ddlCenterRoller" runat="server" Width="80px">
                        <asp:ListItem>Green</asp:ListItem>
                        <asp:ListItem>Blue</asp:ListItem>
                    </asp:DropDownList>

                    <br />

                    <br />
                    <br />
                </div>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="newStyle6" Height="38px" Width="107px" />
            </div>
            <div id="right">

                <asp:Label ID="Label34" runat="server" CssClass="newStyle4" Text="CUSTOMER SERVICES TUBES TO SCHEDULE"></asp:Label>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="ddlShow" runat="server" CssClass="newStyle1" AutoPostBack="True">
                <asp:ListItem Value="0">Hide Scheduled</asp:ListItem>
                <asp:ListItem Value="1">Show Scheduled</asp:ListItem>
            </asp:DropDownList>
                <br />
                <br />
                <asp:GridView ID="gvCSOuters" runat="server" Width="1899px" Caption="CS Outer Tubes" CssClass="newStyle1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" DataKeyNames="TubeID" DataSourceID="sdsCSOuterTubes" AllowSorting="True" AllowPaging="True">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
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

                <asp:SqlDataSource ID="sdsCSOuterTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [CS_Tubes] WHERE [TubeID] = @TubeID" InsertCommand="INSERT INTO [CS_Tubes] ([OENo], [Dealer], [Customer], [Model], [ModelYear], [Style], [Diameter], [Front], [Port], [Strb], [Ctr], [Ladder], [Fuel], [Strakes], [Splash], [StrakesComments], [Comments], [Black], [StrbTrans], [DrawingNo], [OuterScheduled], [OuterRoller]) VALUES (@OENo, @Dealer, @Customer, @Model, @ModelYear, @Style, @Diameter, @Front, @Port, @Strb, @Ctr, @Ladder, @Fuel, @Strakes, @Splash, @StrakesComments, @Comments, @Black, @StrbTrans, @DrawingNo, @OuterScheduled, @OuterRoller)" SelectCommand="SELECT [TubeID], [OENo], [Dealer], [Customer], [Model], [ModelYear], [Style], [Diameter], [Front], [Port], [Strb], [Ctr], [Ladder], [Fuel], [Strakes], [Splash], [StrakesComments], [Comments], [Black], [StrbTrans], [DrawingNo], [OuterScheduled], [OuterRoller], [OuterSections], [OuterScheduledFlag] FROM [CS_Tubes] WHERE (([Port] = @Port) OR ([Strb] = @Strb)) And (OuterScheduledFlag = @show) ORDER BY [TubeID] desc" UpdateCommand="UPDATE [CS_Tubes] SET [OENo] = @OENo, [Dealer] = @Dealer, [Customer] = @Customer, [Model] = @Model, [ModelYear] = @ModelYear, [Style] = @Style, [Diameter] = @Diameter, [Front] = @Front, [Port] = @Port, [Strb] = @Strb, [Ctr] = @Ctr, [Ladder] = @Ladder, [Fuel] = @Fuel, [Strakes] = @Strakes, [Splash] = @Splash, [StrakesComments] = @StrakesComments, [Comments] = @Comments, [Black] = @Black, [StrbTrans] = @StrbTrans, [DrawingNo] = @DrawingNo, [OuterScheduled] = @OuterScheduled, [OuterScheduledFlag] = @OuterScheduledFlag, [OuterRoller] = @OuterRoller WHERE [TubeID] = @TubeID">
                    <DeleteParameters>
                        <asp:Parameter Name="TubeID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="OENo" Type="Int32" />
                        <asp:Parameter Name="Dealer" Type="String" />
                        <asp:Parameter Name="Customer" Type="String" />
                        <asp:Parameter Name="Model" Type="String" />
                        <asp:Parameter Name="ModelYear" Type="Int32" />
                        <asp:Parameter Name="Style" Type="String" />
                        <asp:Parameter Name="Diameter" Type="Int32" />
                        <asp:Parameter Name="Front" Type="String" />
                        <asp:Parameter Name="Port" Type="Int32" />
                        <asp:Parameter Name="Strb" Type="Int32" />
                        <asp:Parameter Name="Ctr" Type="Int32" />
                        <asp:Parameter Name="Ladder" Type="String" />
                        <asp:Parameter Name="Fuel" Type="String" />
                        <asp:Parameter Name="Strakes" Type="String" />
                        <asp:Parameter Name="Splash" Type="String" />
                        <asp:Parameter Name="StrakesComments" Type="String" />
                        <asp:Parameter Name="Comments" Type="String" />
                        <asp:Parameter Name="Black" Type="String" />
                        <asp:Parameter Name="StrbTrans" Type="String" />
                        <asp:Parameter Name="DrawingNo" Type="String" />
                        <asp:Parameter DbType="Date" Name="OuterScheduled" />
                        <asp:Parameter Name="OuterRoller" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="Port" Type="Int32" />
                        <asp:Parameter DefaultValue="1" Name="Strb" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlShow" DefaultValue="0" Name="show" PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="OENo" Type="Int32" />
                        <asp:Parameter Name="Dealer" Type="String" />
                        <asp:Parameter Name="Customer" Type="String" />
                        <asp:Parameter Name="Model" Type="String" />
                        <asp:Parameter Name="ModelYear" Type="Int32" />
                        <asp:Parameter Name="Style" Type="String" />
                        <asp:Parameter Name="Diameter" Type="Int32" />
                        <asp:Parameter Name="Front" Type="String" />
                        <asp:Parameter Name="Port" Type="Int32" />
                        <asp:Parameter Name="Strb" Type="Int32" />
                        <asp:Parameter Name="Ctr" Type="Int32" />
                        <asp:Parameter Name="Ladder" Type="String" />
                        <asp:Parameter Name="Fuel" Type="String" />
                        <asp:Parameter Name="Strakes" Type="String" />
                        <asp:Parameter Name="Splash" Type="String" />
                        <asp:Parameter Name="StrakesComments" Type="String" />
                        <asp:Parameter Name="Comments" Type="String" />
                        <asp:Parameter Name="Black" Type="String" />
                        <asp:Parameter Name="StrbTrans" Type="String" />
                        <asp:Parameter Name="DrawingNo" Type="String" />
                        <asp:Parameter DbType="Date" Name="OuterScheduled" />
                        <asp:Parameter Name="OuterRoller" Type="String" />
                        <asp:Parameter Name="OuterScheduledFlag" Type="Int32" />
                        <asp:Parameter Name="TubeID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <br />
                <br />
                <asp:GridView ID="gvCSCenters" runat="server" Width="1899px" Caption="CS Center Tubes" CssClass="newStyle1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" DataKeyNames="TubeID" DataSourceID="sdsCSCenterTubes" AllowPaging="True">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
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

                <asp:SqlDataSource ID="sdsCSCenterTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [CS_Tubes] WHERE [TubeID] = @TubeID" InsertCommand="INSERT INTO [CS_Tubes] ([OENo], [Dealer], [Customer], [Model], [ModelYear], [Length], [Center], [Storage], [TenWide], [CtrDrawingNo], [CtrBracket], [CtrFuel], [CtrStrakes], [TubeUpg], [Upsweep], [CenterScheduled]) VALUES (@OENo, @Dealer, @Customer, @Model, @ModelYear, @Length, @Center, @Storage, @TenWide, @CtrDrawingNo, @CtrBracket, @CtrFuel, @CtrStrakes, @TubeUpg, @Upsweep, @CenterScheduled)" SelectCommand="SELECT [TubeID], [OENo], [Dealer], [Customer], [Model], [ModelYear], [Length], [Center], [Storage], [TenWide], [CtrDrawingNo], [CtrBracket], [CtrFuel], [CtrStrakes], [TubeUpg], [Upsweep], [CenterScheduled], [CenterRoller], [CenterSections], [CenterScheduledFlag] FROM [CS_Tubes] WHERE ([Ctr] = @Ctr) And (CenterScheduledFlag = @show) ORDER BY [TubeID] desc" UpdateCommand="UPDATE [CS_Tubes] SET [OENo] = @OENo, [Dealer] = @Dealer, [Customer] = @Customer, [Model] = @Model, [ModelYear] = @ModelYear, [Length] = @Length, [Center] = @Center, [Storage] = @Storage, [TenWide] = @TenWide, [CtrDrawingNo] = @CtrDrawingNo, [CtrBracket] = @CtrBracket, [CtrFuel] = @CtrFuel, [CtrStrakes] = @CtrStrakes, [TubeUpg] = @TubeUpg, [Upsweep] = @Upsweep, [CenterScheduled] = @CenterScheduled, [CenterRoller] = @CenterRoller, [CenterSections] = @CenterSections, [CenterScheduledFlag] = @CenterScheduledFlag WHERE [TubeID] = @TubeID">
                    <DeleteParameters>
                        <asp:Parameter Name="TubeID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="OENo" Type="Int32" />
                        <asp:Parameter Name="Dealer" Type="String" />
                        <asp:Parameter Name="Customer" Type="String" />
                        <asp:Parameter Name="Model" Type="String" />
                        <asp:Parameter Name="ModelYear" Type="Int32" />
                        <asp:Parameter Name="Length" Type="Int32" />
                        <asp:Parameter Name="Center" Type="String" />
                        <asp:Parameter Name="Storage" Type="String" />
                        <asp:Parameter Name="TenWide" Type="String" />
                        <asp:Parameter Name="CtrDrawingNo" Type="String" />
                        <asp:Parameter Name="CtrBracket" Type="String" />
                        <asp:Parameter Name="CtrFuel" Type="String" />
                        <asp:Parameter Name="CtrStrakes" Type="String" />
                        <asp:Parameter Name="TubeUpg" Type="String" />
                        <asp:Parameter Name="Upsweep" Type="String" />
                        <asp:Parameter DbType="Date" Name="CenterScheduled" />
                        <asp:Parameter Name="Upsweep" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="Ctr" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlShow" DefaultValue="0" Name="show" PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="OENo" Type="Int32" />
                        <asp:Parameter Name="Dealer" Type="String" />
                        <asp:Parameter Name="Customer" Type="String" />
                        <asp:Parameter Name="Model" Type="String" />
                        <asp:Parameter Name="ModelYear" Type="Int32" />
                        <asp:Parameter Name="Length" Type="Int32" />
                        <asp:Parameter Name="Center" Type="String" />
                        <asp:Parameter Name="Storage" Type="String" />
                        <asp:Parameter Name="TenWide" Type="String" />
                        <asp:Parameter Name="CtrDrawingNo" Type="String" />
                        <asp:Parameter Name="CtrBracket" Type="String" />
                        <asp:Parameter Name="CtrFuel" Type="String" />
                        <asp:Parameter Name="CtrStrakes" Type="String" />
                        <asp:Parameter Name="TubeUpg" Type="String" />
                        <asp:Parameter Name="Upsweep" Type="String" />
                        <asp:Parameter DbType="Date" Name="CenterScheduled" />
                        <asp:Parameter Name="CenterRoller" Type="String" />
                        <asp:Parameter Name="CenterSections" Type="String" />
                        <asp:Parameter Name="CenterScheduledFlag" Type="Int32" />
                        <asp:Parameter Name="TubeID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <br />
                <br />

            </div>
        </div>
    </form>
</body>
</html>
