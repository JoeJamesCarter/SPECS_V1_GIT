<head>
    <style type="text/css">
        .auto-style1 {
        }

        .totalsgrid {
            font-family: calibri;
            font-size: 18px;
            color: green;
        }
    </style>
</head>
<script runat="server">

    Protected Sub btnClear_Click(sender As Object, e As EventArgs)
        tbSearch.Text = ""
    End Sub

    Protected Sub btbClear2_Click(sender As Object, e As EventArgs)
        tbSearchBoat.Text = ""
    End Sub




</script>
<div>
    <asp:table id="Table1" runat="server" cssclass="auto-style1" width="1456px">
        <asp:TableRow runat="server">
            <asp:TableCell rowspan="2" cssClass="totalsgrid" runat="server" HorizontalAlign="center">
                <asp:Table runat="server" gridlines="Both" width="220px">
                    <asp:TableRow runat="server">
                        <asp:TableCell style="text-align: center" colspan="2"><strong>BEHIND</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center" colspan="2"><strong>AHEAD</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center" colspan="2"><strong>DIFFERENCE</strong></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow runat="server">
                        <asp:TableCell style="text-align: center"><strong>M</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblMain" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center"><strong>M</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblMainAhead" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center"><strong>M</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblMainDiff" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow runat="server">
                        <asp:TableCell Style="text-align: center"><strong>V</strong></asp:TableCell>
                        <asp:TableCell Style="text-align: center">
                            <asp:Label ID="lblValue" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell Style="text-align: center"><strong>V</strong></asp:TableCell>
                        <asp:TableCell Style="text-align: center">
                            <asp:Label ID="lblValueAhead" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell Style="text-align: center"><strong>V</strong></asp:TableCell>
                        <asp:TableCell Style="text-align: center">
                            <asp:Label ID="lblValueDiff" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow runat="server">
                        <asp:TableCell style="text-align: center"><strong>S</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblSouth" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center"><strong>S</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblSouthAhead" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center"><strong>S</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblSouthDiff" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow runat="server">
                        <asp:TableCell><strong>Total</strong></asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblTotalBehind" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell><strong>Total</strong></asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblShrinkedAhead" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell><strong>Score</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblScore" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>

                </asp:Table>


            </asp:TableCell>
            <asp:TableCell runat="server">
                <span class="newStyle3">
                    <asp:DropDownList ID="ddlDaysInAdvance" Visible="False" runat="server" AutoPostBack="True">
                    </asp:DropDownList></span>
            </asp:TableCell>
            <asp:TableCell>
             <span class="newStyle3">Search By Prod #&nbsp;&nbsp;</span><asp:textbox runat="server" id="tbSearch"></asp:textbox>
    <asp:button runat="server" text="Clear" id="btnClear" onclick="btnClear_Click" /></span>
              </asp:TableCell>
            <asp:TableCell>
                <span class="newStyle3">Building</span>
            </asp:TableCell>
            <asp:TableCell rowspan="2">
             <asp:Image runat="server" img src="Images/logo-small.png" /></asp:Image>
              </asp:TableCell>
            <asp:TableCell rowspan="2">
                <asp:Table runat="server" gridlines="Both" width="500px">
                    <asp:TableRow runat="server">
                        <asp:TableCell style="text-align: center"></asp:TableCell>
                        <asp:TableCell colspan="12" CssClass="totalsgrid" style="text-align: center"><strong>By Series</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center"></asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" colspan="10" style="text-align: center"><strong># Missing Materials</strong></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow runat="server">
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center"></asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">QXS</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">QX</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">Q</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">RX</asp:Label>
                        </asp:TableCell>
                         <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">RT</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">R</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">LX</asp:Label>
                        </asp:TableCell>
                          <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">LXS</asp:Label>
                        </asp:TableCell>
                         <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">LT</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">L</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">SX</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">S</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">SV</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label runat="server" CssClass="totalsgrid" Text="Label">Not Green</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">F</asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">FG</asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">C</asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">R</asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">T</asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">CT</asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">G</asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">H</asp:TableCell>
                    </asp:TableRow>

                    <asp:TableRow runat="server">
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center"><strong>M</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblQXSm" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblQXm" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblQm" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblRXm" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblRTm" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblRm" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblLXm" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                         <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblLXSm" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblLTm" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblLm" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblSXm" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblSm" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblSVm" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblNGm" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblFm" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblFGm" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblCm" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblRailsm" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblTm" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblCTm" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblGaugesm" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblHm" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>

                       <asp:TableRow runat="server">
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center;"><strong>V</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblQXSv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblQXv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblQv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblRXv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                             <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblRTv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblRv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblLXv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                                            <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblLXSv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>

                            <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblLTv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblLv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblSXv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblSval" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblSVv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblNGv" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblFv" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblFGv" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblCv" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblRailsv" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblTv" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblCTv" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblGaugesv" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblHv" runat="server" Text=""></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>

                    <asp:TableRow runat="server">
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center; background-color: lightgrey;"><strong>S</strong></asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblQXSs" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblQXs" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblQs" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblRXs" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                         <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblRTs" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblRs" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblLXs" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                                         <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblLXSs" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>

                         <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblLTs" runat="server" CssClass="totalsgrid" Text=""></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblLs" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblSXs" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblSs" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblSVs" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblNGs" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblFs" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblFGs" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblCs" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblRailss" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblTs" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblCTs" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblGaugess" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center; background-color: lightgrey;">
                            <asp:Label ID="lblHs" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>

                    <asp:TableRow runat="server">
                        <asp:TableCell CssClass="totalsgrid" style="text-align: center"><strong>Total</strong></asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblQXStotal" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblQX" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblQ" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblRX" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                         <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblRT" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblR" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblLX" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblLXStotal" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                         <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblLT" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblL" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblSX" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblS" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblSV" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell style="text-align: center">
                            <asp:Label ID="lblNotGreen" runat="server" CssClass="totalsgrid" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblFtotal" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblFGtotal" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblCtotal" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblRailstotal" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblTtotal" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblCTtotal" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblGtotal" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell cssClass="totalsgrid" style="text-align: center">
                            <asp:Label ID="lblHtotal" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">

            <asp:TableCell>
                <span class="newStyle3">
                    <asp:DropDownList ID="ddlShowSelect" runat="server" Visible="False" AutoPostBack="True">
                        <asp:ListItem Value="1">Ready</asp:ListItem>
                        <asp:ListItem Value="2">Done</asp:ListItem>
                    </asp:DropDownList></span>
            </asp:TableCell>
            <asp:TableCell>
                <span class="newStyle3">Search By Model:
    <asp:textbox id="tbSearchBoat" runat="server"></asp:textbox>
                    <asp:button id="btbClear2" runat="server" text="Clear" onclick="btbClear2_Click" />
                </span>
            </asp:TableCell>
            <asp:TableCell>
                <asp:DropDownList runat="server" ID="ddlBldg" AutoPostBack="True">
                    <asp:ListItem Value="%">All</asp:ListItem>
                    <asp:ListItem Value="M">Main</asp:ListItem>
                    <asp:ListItem Value="V">Value</asp:ListItem>
                    <asp:ListItem Value="S">South</asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
        </asp:TableRow>
    </asp:table>

</div>
