<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TubeRerun.aspx.vb" Inherits="Tubes_TubeRerun" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tube Re-Run</title>
    <link href="StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .newStyle1 {
            font-family: Calibri;
            font-size: 24px;
            font-weight: bold;
            background-color: black;
            color: white;
            width: 890px;
            text-align: center;
        }


        .newStyle2 {
            font-family: Calibri;
            font-size: 18px;
            font-weight: bold;
        }

        .newStyle4 {
            font-weight: 700;
        }
    </style>

    <script>
        function RefreshParent() {
            window.opener.document.getElementById('btnRefresh').click();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="newStyle1">Tube/Section Rerun for Production #:
                <asp:Label ID="lblProdNo" runat="server" Text="" CssClass="newStyle2"></asp:Label></div>
            <span class="newStyle2">
                <br />

                Type:
        <asp:RadioButtonList ID="rblType" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="ddlPort_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem>Tube</asp:ListItem>
            <asp:ListItem>Section</asp:ListItem>
        </asp:RadioButtonList>
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                        <span class="newStyle2">
                            <br />
                            <asp:Label ID="lblTubes" runat="server" Text="Tubes To Rerun"></asp:Label>
                            <br />
                            <br />
                            <asp:RadioButtonList ID="rblWhichTubes" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblWhichTubes_SelectedIndexChanged">
                                <asp:ListItem Value="Port">Re-Run Port Only</asp:ListItem>
                                <asp:ListItem Value="Starboard">Re-Run Starboard Only</asp:ListItem>
                                <asp:ListItem Value="Both">Re-Run Both Port and Starboard</asp:ListItem>
                                <asp:ListItem Value="Center">Re-Run Center</asp:ListItem>
                                <asp:ListItem Value="All">Re-Run All Tubes</asp:ListItem>
                            </asp:RadioButtonList>
                            <br />
                            <br />
                            <asp:Label ID="lblTubeRerunReasons" runat="server" Text="Tube Rerun Reasons"></asp:Label>
                            <br />
                            <br />
                            <asp:Label ID="lblPort" runat="server" Text="Port" Width="100px"></asp:Label>
                            <asp:DropDownList ID="ddlPort" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPort_SelectedIndexChanged">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>Built Wrong/Could Be Reused</asp:ListItem>
                                <asp:ListItem>Built Wrong/Unusable</asp:ListItem>
                                <asp:ListItem>Damaged After Leaving North</asp:ListItem>
                                <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                <asp:ListItem>Missing</asp:ListItem>
                                <asp:ListItem>Used for Another Boat</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>                                                    
                        <asp:Label ID="lblPortUsedFor" runat="server" Text="Used For Prod #:" Width="130px"></asp:Label>
                            <asp:TextBox ID="tbPortUsedFor" runat="server"></asp:TextBox>
                            <asp:Label ID="lblPortOther" runat="server" Text="Other:" Width="130px"></asp:Label>
                            <asp:TextBox ID="tbPortOther" runat="server" Width="315px"></asp:TextBox>
                            <asp:Label ID="lblPortWrong" runat="server" Text="What's Wrong?" Width="130px"></asp:Label>
                            <asp:TextBox ID="tbPortWrong" runat="server" Width="315px"></asp:TextBox>
                            <asp:CheckBox ID="cbUseForBoth" runat="server" Text="Use this Reason for All Tubes" />
                            <br />
                            <asp:Label ID="lblStrb" runat="server" Text="Starboard:" Width="100px"></asp:Label>
                            <asp:DropDownList ID="ddlStrb" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPort_SelectedIndexChanged">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>Built Wrong/Could Be Reused</asp:ListItem>
                                <asp:ListItem>Built Wrong/Unusable</asp:ListItem>
                                <asp:ListItem>Damaged After Leaving North</asp:ListItem>
                                <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                <asp:ListItem>Missing</asp:ListItem>
                                <asp:ListItem>Used for Another Boat</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label ID="lblStrbUsedFor" runat="server" Text="Used For Prod #:" Width="130px"></asp:Label>
                            <asp:TextBox ID="tbStrbUsedFor" runat="server"></asp:TextBox>
                            <asp:Label ID="lblStrbOther" runat="server" Text="Other:" Width="130px"></asp:Label>
                            <asp:TextBox ID="tbStrbOther" runat="server" Width="315px"></asp:TextBox>
                            <asp:Label ID="lblStrbWrong" runat="server" Text="What's Wrong?" Width="130px"></asp:Label>
                            <asp:TextBox ID="tbStrbWrong" runat="server" Width="315px"></asp:TextBox>
                            <br />
                            <asp:Label ID="lblCtr" runat="server" Text="Center:" Width="100px"></asp:Label>
                            <asp:DropDownList ID="ddlCtr" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPort_SelectedIndexChanged">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>Built Wrong/Could Be Reused</asp:ListItem>
                                <asp:ListItem>Built Wrong/Unusable</asp:ListItem>
                                <asp:ListItem>Damaged After Leaving North</asp:ListItem>
                                <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                <asp:ListItem>Missing</asp:ListItem>
                                <asp:ListItem>Used for Another Boat</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label ID="lblCtrUsedFor" runat="server" Text="Used For Prod #:" Width="130px"></asp:Label>
                            <asp:TextBox ID="tbCtrUsedFor" runat="server"></asp:TextBox>
                            <asp:Label ID="lblCtrOther" runat="server" Text="Other:" Width="130px"></asp:Label>
                            <asp:TextBox ID="tbCtrOther" runat="server" Width="315px"></asp:TextBox>                            
                            <asp:Label ID="lblCtrWrong" runat="server" Text="What's Wrong?" Width="130px"></asp:Label>
                            <asp:TextBox ID="tbCtrWrong" runat="server" Width="315px"></asp:TextBox>
                                <br />
                                <br />
                            <span class="newStyle4">
                                <asp:Button ID="btnTubeSubmit" runat="server" OnClientClick="RefreshParent();" Text="Submit" />
                            </span>
                        
                    </asp:View>
                    <asp:View ID="View2" runat="server">
                        <br />
                        <asp:Label ID="lblSections" runat="server" Text="Sections To Re-Run:"></asp:Label>
                        <br />
                        <br />
                        <asp:CheckBoxList ID="cblSections" runat="server" RepeatColumns="4" RepeatDirection="Horizontal" Width="596px" AutoPostBack="True">
                            <asp:ListItem Value="PF">Port Front</asp:ListItem>
                            <asp:ListItem Value="PM">Port Mid</asp:ListItem>
                            <asp:ListItem Value="PM2">Port Mid 2</asp:ListItem>
                            <asp:ListItem Value="PR">Port Rear</asp:ListItem>
                            <asp:ListItem Value="SF">Strb Front</asp:ListItem>
                            <asp:ListItem Value="SM">Strb Mid</asp:ListItem>
                            <asp:ListItem Value="SM2">Strb Mid 2</asp:ListItem>
                            <asp:ListItem Value="SR">Strb Rear</asp:ListItem>
                            <asp:ListItem Value="CF">Ctr Front</asp:ListItem>
                            <asp:ListItem Value="CM">Ctr Mid</asp:ListItem>
                            <asp:ListItem Value="CM2">Ctr Mid 2</asp:ListItem>
                            <asp:ListItem Value="CR">Ctr Rear</asp:ListItem>
                        </asp:CheckBoxList>
                        <br />
                        <asp:Label ID="lblSectionRerunReasons" runat="server" Text="Section Rerun Reasons"></asp:Label>
                        <br />
                        <br />
                        <asp:Table ID="Table1" runat="server">
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="lblPF" runat="server" Text="Port Front"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlPF" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblPM" runat="server" Text="Port Mid"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlPM" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblPM2" runat="server" Text="Port Mid 2"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlPM2" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblPR" runat="server" Text="Port Rear"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlPR" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="lblSF" runat="server" Text="Strb Front"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlSF" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblSM" runat="server" Text="Strb Mid"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlSM" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblSM2" runat="server" Text="Strb Mid 2"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlSM2" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblSR" runat="server" Text="Strb Rear"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlSR" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="lblCF" runat="server" Text="Ctr Front"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlCF" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblCM" runat="server" Text="Ctr Mid"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlCM" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblCM2" runat="server" Text="Ctr Mid 2"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlCM2" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblCR" runat="server" Text="Ctr Rear"></asp:Label>
                                    <br />
                                    <asp:DropDownList ID="ddlCR" runat="server" AutoPostBack="True">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Damaged/Scrap</asp:ListItem>
                                        <asp:ListItem>Missing</asp:ListItem>
                                        <asp:ListItem>Should Be Round</asp:ListItem>
                                        <asp:ListItem>Should Be Elliptical</asp:ListItem>
                                        <asp:ListItem>Should Be .080</asp:ListItem>
                                        <asp:ListItem>Should Be .100</asp:ListItem>
                                        <asp:ListItem>Should Be .125</asp:ListItem>
                                        <asp:ListItem>Wrong Length</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                            </asp:TableRow>

                        </asp:Table>
                        <br />
                        <asp:Label ID="lblSectionNotesIfOther" runat="server" Text="Section Notes (if Reason is Other)"></asp:Label>
                        <span class="newStyle2"><span class="newStyle4">
                        <br />
                        <br />
                        <asp:Table ID="Table2" runat="server">
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="lblPFSectionOther" runat="server" Text="Port Front"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="tbPFSectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblPMSectionOther" runat="server" Text="Port Mid"></asp:Label>
                                    <br />
                                  <asp:TextBox ID="tbPMSectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblPM2SectionOther" runat="server" Text="Port Mid 2"></asp:Label>
                                    <br />
                                   <asp:TextBox ID="tbPM2SectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblPRSectionOther" runat="server" Text="Port Rear"></asp:Label>
                                    <br />
                                   <asp:TextBox ID="tbPRSectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="lblSFSectionOther" runat="server" Text="Strb Front"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="tbSFSectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblSMSectionOther" runat="server" Text="Strb Mid"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="tbSMSectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblSM2SectionOther" runat="server" Text="Strb Mid 2"></asp:Label>
                                    <br />
                                   <asp:TextBox ID="tbSM2SectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblSRSectionOther" runat="server" Text="Strb Rear"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="tbSRSectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="lblCFSectionOther" runat="server" Text="Ctr Front"></asp:Label>
                                    <br />
                                   <asp:TextBox ID="tbCFSectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblCMSectionOther" runat="server" Text="Ctr Mid"></asp:Label>
                                    <br />
                                   <asp:TextBox ID="tbCMSectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblCM2SectionOther" runat="server" Text="Ctr Mid 2"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="tbCM2SectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblCRSectionOther" runat="server" Text="Ctr Rear"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="tbCRSectionOther" runat="server" TextMode="MultiLine"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <br />
                        <br />
                        <asp:Button ID="btnSectionSubmit" runat="server" OnClientClick="RefreshParent();" Text="Submit" />
                        </span></span>
                    </asp:View>


                </asp:MultiView>

            </span>

            <br />
            <br />
            <br />

            <div class="newStyle1">
                Re-Run History
                 
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="gvRerunReasons">
                    <Columns>
                        <asp:BoundField DataField="RerunSBReason" HeaderText="SB Re-Run Reason" SortExpression="RerunSBReason" />
                        <asp:BoundField DataField="ReRunSBReqDate" HeaderText="Date Requested" SortExpression="ReRunSBReqDate" />
                        <asp:TemplateField>
                            <HeaderStyle BackColor="White" />
                            <ItemStyle BackColor="White" BorderStyle="None" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="RerunPortReason" HeaderText="Port Re-Run Reason" SortExpression="RerunPortReason" />
                        <asp:BoundField DataField="ReRunPortReqDate" HeaderText="Date Requested" SortExpression="ReRunPortReqDate" />
                        <asp:TemplateField>
                            <HeaderStyle BackColor="White" />
                            <ItemStyle BackColor="White" BorderStyle="None" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="RerunCtrReason" HeaderText="Center Re-Run Reason" SortExpression="RerunCtrReason" />
                        <asp:BoundField DataField="ReRunCtrReqDate" HeaderText="Date Requested" SortExpression="ReRunCtrReqDate" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="gvRerunReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [RerunSBReason], [ReRunSBReqDate], [ReRunPortReqDate], [RerunPortReason], [ReRunCtrReqDate], [RerunCtrReason] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>


            </div>
            <br />
            <asp:Button ID="btnClose" runat="server" Text="Close" />
    </form>
</body>
</html>
