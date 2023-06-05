<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Tubes.aspx.vb" Inherits="Tubes" MaintainScrollPositionOnPostback="true" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TUBES</title>
    <link href="StyleSheet.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1350px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">TUBES</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="toolbar-tubes.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:Label ID="Label9" runat="server" CssClass="newStyle4" Text="Reruns (In North)"></asp:Label>
        </div>
        <asp:GridView ID="gvNorthReruns" runat="server" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" CssClass="newStyle1" DataSourceID="sdsNorthReruns" ForeColor="Black" Width="1500px" DataKeyNames="AutoID">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" />
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                        <br></br>
                        <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("CusName") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tube" SortExpression="Tube">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("Tube") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Damage" SortExpression="PortDmgDesc">
                    <ItemTemplate>
                        <asp:Label ID="Label16" runat="server" Text='<%#Eval("PortDmgDesc")%>'></asp:Label>
                        <asp:Label ID="Label17" runat="server" Text='<%#Eval("StrbDmgDesc")%>'></asp:Label>
                        <asp:Label ID="Label18" runat="server" Text='<%#Eval("CtrDmgDesc")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="DateReported" HeaderText="Date Reported" SortExpression="DateReported">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Re-Rolled">
                    <ItemTemplate>
                        <asp:Label ID="Label19" runat="server" Text='<%# Eval("ReRolled") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="FinalPStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Port">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                 <asp:ImageField DataImageUrlField="FinalCStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Center">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FinalSStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Strb">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerPReRun" runat="server" Enabled='<%# Eval("FinalPStatus") >= -1%>' Visible='<%# Eval("Tube") = "PORT" %>' ImageUrl="./Images/complete_status1.png" CommandArgument='<%# Container.DataItemIndex & ";" & Eval("AutoID") %>' CommandName="gotoupdatePRerun" ToolTip="Clear this Repair." />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Center">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerCReRun" runat="server" Enabled='<%# Eval("FinalCStatus") >= -1%>' Visible='<%# Eval("Tube") = "CTR" %>' ImageUrl="./Images/complete_status1.png" CommandArgument='<%# Container.DataItemIndex & ";" & Eval("AutoID") %>' CommandName="gotoupdateCRerun" ToolTip="Clear this Repair." />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Starboard">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerSRerun" runat="server" Enabled=' <%# Eval("FinalSStatus") >= 1-0%>' Visible='<%# Eval("Tube") = "STRB" %>' ImageUrl="./Images/complete_status1.png" CommandArgument='<%# Container.DataItemIndex & ";" & Eval("AutoID") %>' CommandName="gotoupdateSRerun" ToolTip="Clear this Repair." />
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
        <asp:SqlDataSource ID="sdsNorthReruns" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Tubes_DamageReported.*, CusName, ItemNo, FinalPStatus, FinalSStatus, FinalCStatus FROM [Tubes_DamageReported] Left join BML_POPREPORTING_GREENLIGHTS on Tubes_DamageReported.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Tubes on Tubes_DamageReported.ProdNo = Tubes.ProdNo WHERE (([ReportedBy] = @ReportedBy) AND ([ActionRequired] = @ActionRequired)) and ReplacedFlag = 0 ORDER BY [ProdNo]">
            <SelectParameters>
                <asp:Parameter DefaultValue="specstube1" Name="ReportedBy" Type="String" />
                <asp:Parameter DefaultValue="REPLACE" Name="ActionRequired" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Label5" runat="server" CssClass="newStyle4" Text="Replacement Tubes (After North)"></asp:Label>
        <br />
        <asp:GridView ID="gvReplacements" runat="server" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" CssClass="newStyle1" DataSourceID="sdsReplacements" ForeColor="Black" Width="1500px" DataKeyNames="AutoID">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" />
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                        <br></br>
                        <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("CusName") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tube" SortExpression="Tube">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("Tube") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Damage" SortExpression="PortDmgDesc">
                    <ItemTemplate>
                        <asp:Label ID="Label16" runat="server" Text='<%#Eval("PortDmgDesc")%>'></asp:Label>
                        <asp:Label ID="Label17" runat="server" Text='<%#Eval("StrbDmgDesc")%>'></asp:Label>
                        <asp:Label ID="Label18" runat="server" Text='<%#Eval("CtrDmgDesc")%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="DateReported" HeaderText="Date Reported" SortExpression="DateReported">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Re-Rolled">
                    <ItemTemplate>
                        <asp:Label ID="Label19" runat="server" Text='<%# Eval("ReRolled") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="FinalPStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Port">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>

                <asp:ImageField DataImageUrlField="FinalSStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Strb">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerPReRun" runat="server" Enabled='<%# Eval("FinalPStatus") >= 0%>' Visible='<%# Eval("Tube") = "PORT" %>' ImageUrl='<%# Eval("FinalPStatus", "./Images/complete_status{0}.png")%>' CommandArgument='<%# Container.DataItemIndex & ";" & Eval("AutoID") %>' CommandName="gotoupdatePRPLRerun" ToolTip="Mark this Individual Tube As Green, May still need to green the pair in the grid below." />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Starboard">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerSRerun" runat="server" Enabled=' <%# Eval("FinalSStatus") >= 0%>' Visible='<%# Eval("Tube") = "STRB" %>' ImageUrl='<%# Eval("FinalSStatus", "./Images/complete_status{0}.png")%>' CommandArgument='<%# Container.DataItemIndex & ";" & Eval("AutoID") %>' CommandName="gotoupdateSRPLRerun" ToolTip="Mark this Individual Tube As Green. May still need to green the pair in the grid below." />
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
        <asp:SqlDataSource ID="sdsReplacements" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Tubes_DamageReported.*, CusName, ItemNo, FinalPStatus, FinalSStatus, FloorsInstalledStatus FROM [Tubes_DamageReported] Left join BML_POPREPORTING_GREENLIGHTS on Tubes_DamageReported.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Left Join Tubes on Tubes_DamageReported.ProdNo = Tubes.ProdNo WHERE [ReportedBy] <> @ReportedBy AND [ActionRequired] = @ActionRequired And ReplacedFlag = 0 and (FinalPStatus < 2 or FinalSStatus < 2)  ORDER BY [ProdNo]">
            <SelectParameters>
                <asp:Parameter DefaultValue="specstube1" Name="ReportedBy" Type="String" />
                <asp:Parameter DefaultValue="REPLACE" Name="ActionRequired" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:Label ID="Label11" runat="server" CssClass="newStyle4" Text="Customer Service"></asp:Label>
        <br />
        <asp:GridView ID="gvCSTubes" runat="server" AutoGenerateColumns="False" DataKeyNames="TubeID" DataSourceID="sdsCSTubes" CssClass="newStyle1" CaptionAlign="Left" CellPadding="1" CellSpacing="1" Width="1750px">
            <Columns>
                <asp:BoundField DataField="TubeID" HeaderText="CS Tube #" InsertVisible="False" ReadOnly="True" SortExpression="TubeID">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="DLR/OE #">
                    <ItemTemplate>
                        <asp:Label ID="lblDealer" runat="server" Text='<%#Eval("Dealer")%>'></asp:Label><br />
                        <asp:Label ID="lblOE" runat="server" Text='<%#Eval("OENo")%>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="Model" HeaderText="Length" SortExpression="Model">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Tube">
                    <ItemTemplate>
                        <asp:Label ID="lblTube" runat="server" Text=""></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Bottom" />
                </asp:TemplateField>
                <asp:BoundField DataField="ModelYear" HeaderText="Model Year" SortExpression="ModelYear">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="OuterSections" HeaderText="# Sections">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Style" HeaderText="Style" SortExpression="Style">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Diameter" HeaderText="Diameter" SortExpression="Diameter">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Front" HeaderText="Front" SortExpression="Front">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Ladder" HeaderText="Ladder" SortExpression="Ladder">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Keel" HeaderText="Keel" SortExpression="Keel">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Fuel" HeaderText="Fuel" SortExpression="Fuel">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Splash" HeaderText="Splash" SortExpression="Splash">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Strakes" HeaderText="Strakes" SortExpression="Strakes">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="StrakesComments" HeaderText="Strakes Comments" SortExpression="StrakesComments">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Black" HeaderText="Black" SortExpression="Black">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="StrbTrans" HeaderText="Strb Trans" SortExpression="StrbTrans">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateCSPRoller" runat="server" Enabled=' <%# Eval("FinalPStatus") <= 1%>' Visible=' <%# Eval("Port") = 1%>' ImageUrl='<%# Eval("FinalPStatus", "./Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCSPort" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Strb">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateCSSRoller" runat="server" Enabled=' <%# Eval("FinalSStatus") <= 1%>' Visible=' <%# Eval("Strb") = 1%>' ImageUrl='<%# Eval("FinalSStatus", "./Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCSStrb" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
        <asp:SqlDataSource ID="sdsCSTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [TubeID], [OENo], [Dealer], [Customer], [Model], [ModelYear], [Style], [Diameter], [Front], [Ladder], [Bracket], [Keel], [Fuel], [Splash], [Strakes], [StrakesComments], [Black], [StrbTrans], [Comments], [DrawingNo], [Length], [OuterScheduled],[Port],[Strb], [FinalPStatus],[FinalSStatus],[OuterSections] FROM [CS_Tubes] WHERE Convert(date,OuterScheduled) &lt;= GETDATE() AND (([FinalPStatus] <> 2 and Port = 1) OR ([FinalSStatus] <> 2 and Strb = 1)) ORDER BY [OuterScheduleOrder]">
            <SelectParameters>
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Label1" runat="server" CssClass="newStyle4" Text="Production"></asp:Label>
        <asp:GridView ID="gvAllFieldsT" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" Height="177px" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="ProdNo" Width="1500px">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo">
                    <ItemStyle VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                        <br></br>
                        <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("CusName") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="./Images/Custom{0}.png" HeaderText="Custom">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Options">
                    <ItemTemplate>
                        <asp:GridView ID="gvFabOptionsTubes" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsPopReportingFabOptions" CssClass="newStyle3">
                            <Columns>
                                <asp:BoundField DataField="Option_Desc" HeaderText="Fab Options" SortExpression="Option_Desc" ShowHeader="False">
                                    <ControlStyle BorderStyle="None" />
                                    <FooterStyle BorderStyle="None" />
                                    <HeaderStyle BorderStyle="None" Height="10px" />
                                    <ItemStyle BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsPopReportingFabOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [PopNo], [Option_Item], [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE ([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter) ORDER BY [Option_Desc]">
                            <SelectParameters>
                                <asp:Parameter Name="ProdNo" Type="String" />
                                <asp:Parameter DefaultValue="Tubes" Name="Workcenter" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle Font-Size="12pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Green Lights">
                    <ItemTemplate>
                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReportingByProdNo">
                            <Columns>
                                <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="F">
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="FG">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="C">
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="R">
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="T">
                                </asp:ImageField>
                                <asp:TemplateField HeaderText="CT">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgButtonCentertube" runat="server" ImageUrl='<%# Eval("CentertubeStatus", "./Images/{0}.png")%>' Visible='<%#Eval("CentertubeNeeded") = 1%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsPopReportingByProdNo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING.CentertubeNeeded FROM BML_POPREPORTING_GREENLIGHTS INNER JOIN BML_POPREPORTING ON BML_POPREPORTING_GREENLIGHTS.PopNo = BML_POPREPORTING.PopNo WHERE (BML_POPREPORTING_GREENLIGHTS.ProdNo = @ProdNo)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvAllFieldsT" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Update">
                    <ItemTemplate>
                        <div class="newStyle2">
                            <asp:RadioButtonList ID="rblTubesStatus" runat="server" SelectedValue='<%# Bind("TubesStatus")%>' RepeatDirection="Horizontal">
                                <asp:ListItem Value="0">Not Started</asp:ListItem>
                                <asp:ListItem Value="1">Welded</asp:ListItem>
                                <asp:ListItem Value="2">Ready</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div class="newStyle2">
                            <asp:Button ID="btnUpdateTubesStatus" runat="server" Text="Update" CommandArgument="<%# Container.DataItemIndex %>" CommandName="UpdateTStatus" />
                        </div>
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="./Images/{0}checkmark.png" HeaderText="Complete">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FinalPStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Port">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>

                <asp:ImageField DataImageUrlField="FinalSStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Strb">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>

                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />
                        <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesTubes") = 1%>' ImageUrl='<%# Eval("NotesTubes", "./Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="goto" />
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Tube Damage">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnTubeDamage" runat="server" ImageUrl='<%# Eval("HasTubeDamage", "./Images/tubedamage{0}.png")%>' CommandArgument='<%# Eval("ProdNo") & ";" & Eval("ItemNo")%>' CommandName="gototubedamage" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle VerticalAlign="Top" BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo,  BML_POPREPORTING.IsCustom, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesTubes, BML_POPREPORTING_GREENLIGHTS.BuildLoc, HasTubeDamage, FinalPStatus, FinalSStatus FROM BML_POPREPORTING CROSS JOIN BML_POPREPORTING_GREENLIGHTS LEFT JOIN Tubes on BML_POPREPORTING_GREENLIGHTS.ProdNo = Tubes.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.TubesStatus = @TubesStatus) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') ORDER BY Convert(integer,BML_POPREPORTING.ProdNo)">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                <asp:ControlParameter ControlID="ddlShowSelect" Name="TubesStatus" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />

            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
