<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReportCard.aspx.vb" Inherits="ReportCard" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report Card</title>
    <link href="StyleSheet.css" rel="stylesheet" />

    <style>
        #materials {
            float: left;
        }

        #stock {
            float: left;
        }

        #workstations {
            float: left;
        }

        #soutstats {
            float: left;
        }

        #southstats {
            float: left;
        }

        #veadargabo {
            float: left;
        }

        #offline {
            float: left;
        }

        #readybyworkstation {
            float: left;
        }

        #pastdue {
            float: left;
        }

        .rcgrid {
            padding: 10px;
        }

        #rackmapstats {
            float: left;
        }

        #yardstats {
        }
    </style>
    <link rel="stylesheet" href="./scripts/css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <asp:Label runat="server" Text="B1 = Was S, B2 = Was V, B3 = Was M. I know they aren't in order. Big job to change that."></asp:Label>
            <div class="row">
                <div id="materials" class="rcgrid col w-10">
                    <asp:Table ID="tblMaterials" runat="server" GridLines="Both" CellPadding="2" CellSpacing="2" BorderStyle="Solid" Font-Names="Calibri" Font-Size="16">
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell>Materials Greened Today</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B3</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B2</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B1</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Total</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                        <asp:TableRow>
                            <asp:TableCell>Furniture</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFMain" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFValue" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFSouth" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Fiberglass</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFGMain" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFGValue" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFGSouth" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFGTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Canvas</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCMain" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCValue" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCSouth" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Rails Panelled</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRMain" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRValue" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRSouth" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Tubes</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTMain" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTValue" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTSouth" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Centertubes</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCTMain" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCTValue" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCTSouth" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCTTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Gauge Panels</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblGMain" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblGValue" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblGSouth" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblGTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Harnesses</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHMain" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHValue" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHSouth" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Arches/Towers</asp:TableCell>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblATTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Q Front Fiberglass</asp:TableCell>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblQFTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Helms Built</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblMHelmsBuilt" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblVHelmsBuilt" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblSHelmsBuilt" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHelmsBuiltTotal" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="5">&nbsp;</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="5" HorizontalAlign="Center">
                                <asp:Table ID="Table3" runat="server" GridLines="Both" CellPadding="2" CellSpacing="2" BorderStyle="Solid" Font-Names="Calibri" Font-Size="16" HorizontalAlign="Left" Width="300px">
                                    <asp:TableHeaderRow>
                                        <asp:TableHeaderCell>B1 Stats</asp:TableHeaderCell>
                                        <asp:TableHeaderCell>Total</asp:TableHeaderCell>
                                    </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Brought In Today</asp:TableCell><asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblBroughtIn" runat="server" Text="Label"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>B1 In Progress</asp:TableCell><asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblWip" runat="server" Text="Label"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Decks Outside</asp:TableCell><asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblDecks" runat="server" Text="Label"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Ready To Bring In</asp:TableCell><asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblSouthReady" runat="server" Text="Label"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="5">&nbsp;</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="5">
                                <asp:Table runat="server" GridLines="Both" Width="294px" CellPadding="2" CellSpacing="2" BorderStyle="Solid" Font-Names="Calibri" Font-Size="16">
                                    <asp:TableRow runat="server">
                                        <asp:TableCell Style="text-align: center" colspan="2"><strong>Behind</strong></asp:TableCell>
                                        <asp:TableCell Style="text-align: center" colspan="2"><strong>Ahead</strong></asp:TableCell>
                                        <asp:TableCell Style="text-align: center" colspan="2"><strong>Difference</strong></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow runat="server">
                                        <asp:TableCell Style="text-align: center"><strong>B3</strong></asp:TableCell>
                                        <asp:TableCell Style="text-align: center">
                                            <asp:Label ID="lblMain" runat="server" Text="Label"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Style="text-align: center"><strong>B3</strong></asp:TableCell>
                                        <asp:TableCell Style="text-align: center">
                                            <asp:Label ID="lblMainAhead" runat="server" Text="Label"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Style="text-align: center"><strong>B3</strong></asp:TableCell>
                                        <asp:TableCell Style="text-align: center">
                                            <asp:Label ID="lblMainDiff" runat="server" Text="Label"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow runat="server">
                                        <asp:TableCell Style="text-align: center"><strong>B2</strong></asp:TableCell>
                                        <asp:TableCell Style="text-align: center">
                                            <asp:Label ID="lblValue" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Style="text-align: center"><strong>B2</strong></asp:TableCell>
                                        <asp:TableCell Style="text-align: center">
                                            <asp:Label ID="lblValueAhead" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Style="text-align: center"><strong>B2</strong></asp:TableCell>
                                        <asp:TableCell Style="text-align: center">
                                            <asp:Label ID="lblValueDiff" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow runat="server">
                                        <asp:TableCell Style="text-align: center"><strong>B1</strong></asp:TableCell>
                                        <asp:TableCell Style="text-align: center">
                                            <asp:Label ID="lblSouth" runat="server" Text="Label"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Style="text-align: center"><strong>B1</strong></asp:TableCell>
                                        <asp:TableCell Style="text-align: center">
                                            <asp:Label ID="lblSouthAhead" runat="server" Text="Label"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Style="text-align: center"><strong>B1</strong></asp:TableCell>
                                        <asp:TableCell Style="text-align: center">
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
                                        <asp:TableCell Style="text-align: center">
                                            <asp:Label ID="lblScore" runat="server" Text="Label"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
                <div id="stock" class="rcgrid col w-10">
                    <asp:Table ID="Table5" runat="server" GridLines="Both" CellPadding="2" CellSpacing="2" BorderStyle="Solid" Font-Names="Calibri" Font-Size="16">
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell>Stock Levels (B3 or B2 not Floored, B1 not Railed)</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B3</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B2</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B1</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Total</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                        <asp:TableRow>
                            <asp:TableCell>F</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFurnStockM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFurnStockV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFurnStockS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFurnStockTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>FG</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFGStockM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFGStockV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFGStockS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFGStockTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>C</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCanvasStockM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCanvasStockV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCanvasStockS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCanvasStockTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>R</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsStockM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsStockV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsStockS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsStockTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>T</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTubeStockM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTubeStockV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTubeStockS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTubeStockTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>CT</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCTStockM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCTStockV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCTStockS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCTStockTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>G</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblGaugeStockM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblGaugeStockV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblGaugeStockS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblGaugeStockTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>H</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHarnessStockM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHarnessStockV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHarnessStockS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHarnessStockTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>A/T</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right"></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblATStockTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Q Front FG</asp:TableCell>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblQFrontStockTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="4">&nbsp;</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell>Veada Issues</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B3</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B2</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B1</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Total</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                        <asp:TableRow>
                            <asp:TableCell>RGAs</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="RGAsM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="RGAsV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="RGAsS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="RGAsTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Backorders</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="BOsM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="BOsV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="BOsS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="BOsTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="4">&nbsp;</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell>Miscellaneous</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B3</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B2</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B1</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Total</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                        <asp:TableRow>
                            <asp:TableCell>Offline</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblOfflineM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblOfflineV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblOfflineS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblOfflineTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Frame Stacks</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFrameStacksM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFrameStacksV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFrameStacksS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFrameStacksTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>In Progress</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblInProgressM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblInProgressV" runat="server" Text=""></asp:Label>
                            </asp:TableCell><asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblInProgressS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblInProgressTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Past Due WIP</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblMainPastDueWIP" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblValuePastDueWIP" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblSouthPastDueWIP" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTotalPastDueWIP" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Rails Pulled To Panel (Not Framed)</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsPulledMNotFramed" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsPulledVNotFramed" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsPulledSNotFramed" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsPulledTotalNotFramed" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Rails Pulled To Panel (Framed)</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsPulledMFramed" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsPulledVFramed" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsPulledSFramed" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsPulledTotalFramed" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Ready - Being Framed</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblReadyNeedsFramedM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblReadyNeedsFramedV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblReadyNeedsFramedS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblReadyNeedsFramedTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>

                <div id="workstations" class="rcgrid col w-10">
                    <asp:Table ID="Table1" runat="server" GridLines="Both" CellPadding="2" CellSpacing="2" BorderStyle="Solid" Font-Names="Calibri" Font-Size="16" HorizontalAlign="Left">
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell>Completed By Workstation</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B3</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B2</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B1</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Total</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                        <asp:TableRow>
                            <asp:TableCell>Frames</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFramesMComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFramesVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFramesSComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFramesTotalComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Floors</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFloorsMComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFloorsVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFloorsSComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFloorsTotalComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Trim</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTrimMComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTrimVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTrimSComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTrimTotalComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Rails</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsMComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsSComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsTotalComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Furniture</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFurnitureMComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFurnitureVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFurnitureSComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFurnitureTotalComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Helm</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHelmMComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHelmVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHelmSComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHelmTotalComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Inspection</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCleaningMComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCleaningVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCleaningSComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCleaningTotalComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Final Inspection</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblInspectionMComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblInspectionVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblInspectionSComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblInspectionTotalComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell BackColor="#009933">Shrinkwrap</asp:TableCell>
                            <asp:TableCell BackColor="#009933" HorizontalAlign="Right">
                                <asp:Label ID="lblShrinkMComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell BackColor="#009933" HorizontalAlign="Right">
                                <asp:Label ID="lblShrinkVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell BackColor="#009933" HorizontalAlign="Right">
                                <asp:Label ID="lblShrinkSComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell BackColor="#009933" HorizontalAlign="Right">
                                <asp:Label ID="lblShrinkTotalComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Rigging</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRiggingMComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRiggingVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRiggingSComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRiggingTotalComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Wave Tamer</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblWTMComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblWTVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblWTSComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblWTTotalComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Sharkhide</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblSharkhideMComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblSharkhideVComplete" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblSharkhideSComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblSharkhideTotalComplete" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Fully Complete</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCompleteM" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCompleteV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCompleteS" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCompleteTotal" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="5">&nbsp;</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell>Furn Rack Map Stats (B2/B3 Only)</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B3</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B2</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B1</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Total</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                        <asp:TableRow>
                            <asp:TableCell># Empty Spaces</asp:TableCell>
                            <asp:TableCell ColumnSpan="3"></asp:TableCell>
                            <asp:TableCell Style="text-align: right">
                                <asp:Label ID="lblFurnEmptySpaces" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell># Spaces Used for Other Storage</asp:TableCell>
                            <asp:TableCell ColumnSpan="3"></asp:TableCell>
                            <asp:TableCell Style="text-align: right">
                                <asp:Label ID="lblFurnDisabledSpaces" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell># of Boats w/Green Sets</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right"><asp:Label runat="server" ID="lblFurnGreenB3"></asp:Label></asp:TableCell>
                             <asp:TableCell HorizontalAlign="Right"><asp:Label runat="server" ID="lblFurnGreenB2"></asp:Label></asp:TableCell>
                             <asp:TableCell></asp:TableCell>
                            <asp:TableCell Style="text-align: right">
                                <asp:Label ID="lblFurnGreen" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell># of Boats w/Yellow/Red Ring Sets</asp:TableCell>
                             <asp:TableCell HorizontalAlign="Right"><asp:Label ID="lblFurnYellowRedB3" runat="server" Text=""></asp:Label></asp:TableCell>
                             <asp:TableCell HorizontalAlign="Right"><asp:Label ID="lblFurnYellowRedB2" runat="server" Text=""></asp:Label></asp:TableCell>
                             <asp:TableCell></asp:TableCell>
                            <asp:TableCell Style="text-align: right">
                                <asp:Label ID="lblFurnYellowRed" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell># of Boats w/Yellow Sets (BO/RGA'S)</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right"><asp:Label ID="lblFurnYellowB3" runat="server" Text=""></asp:Label></asp:TableCell>
                             <asp:TableCell HorizontalAlign="Right"><asp:Label ID="lblFurnYellowB2" runat="server" Text=""></asp:Label></asp:TableCell>
                             <asp:TableCell></asp:TableCell>
                            <asp:TableCell Style="text-align: Right">
                                <asp:Label ID="lblFurnYellow" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell># of Boats In WIP w Furn Installed</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right"><asp:Label ID="lblWIPWFurnB3" runat="server" Text=""></asp:Label></asp:TableCell>
                             <asp:TableCell HorizontalAlign="Right"><asp:Label ID="lblWIPWFurnB2" runat="server" Text=""></asp:Label></asp:TableCell>
                             <asp:TableCell></asp:TableCell>
                            <asp:TableCell Style="text-align: right">
                                <asp:Label ID="lblWIPWFurn" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Total # of Furn Sets In WIP and Racks</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right"><asp:Label ID="lblFurnWIPandRacksB3" runat="server" Text=""></asp:Label><asp:Label ID="Label2" runat="server" Text=""></asp:Label></asp:TableCell>
                             <asp:TableCell HorizontalAlign="Right"><asp:Label ID="lblFurnWIPandRacksB2" runat="server" Text=""></asp:Label></asp:TableCell>
                             <asp:TableCell></asp:TableCell>
                            <asp:TableCell Style="text-align: right">
                                <strong>
                                    <asp:Label ID="lblFurnWIPandRacks" runat="server" Text=""></asp:Label></strong>
                            </asp:TableCell>
                        </asp:TableRow>

                    </asp:Table>

                </div>
                <div id="readybyworkstation" class="rcgrid col w-10">
                    <asp:Table ID="Table2" runat="server" GridLines="Both" CellPadding="2" CellSpacing="2" BorderStyle="Solid" Font-Names="Calibri" Font-Size="16" HorizontalAlign="Left" Style="margin-left: 0px">
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell>Ready By Workstation</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B3</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B2</asp:TableHeaderCell>
                            <asp:TableHeaderCell>B1</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                        <asp:TableRow>
                            <asp:TableCell>Frames</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFramesMReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFramesVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFramesSReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Floors</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFloorsMReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFloorsVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFloorsSReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Trim</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTrimMReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTrimVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblTrimSReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Rails</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsMReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRailsSReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Furniture</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFurnitureMReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFurnitureVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFurnitureSReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Helm</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHelmMReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHelmVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblHelmSReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Inspection</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCleaningMReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCleaningVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblCleaningSReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Final Inspection</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFinalInspectionMReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFinalInspectionVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblFinalInspectionSReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell BackColor="#009933">Shrinkwrap</asp:TableCell>
                            <asp:TableCell BackColor="#009933" HorizontalAlign="Right">
                                <asp:Label ID="lblShrinkMReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell BackColor="#009933" HorizontalAlign="Right">
                                <asp:Label ID="lblShrinkVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell BackColor="#009933" HorizontalAlign="Right">
                                <asp:Label ID="lblShrinkSReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Rigging</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRiggingMReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRiggingVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblRiggingSReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Wave Tamer</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblWTMReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblWTVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblWTSReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Sharkhide</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblSharkhideMReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblSharkhideVReady" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Right">
                                <asp:Label ID="lblSharkhideSReady" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="4">&nbsp;&nbsp;</asp:TableCell></asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="4">
                                <asp:Table ID="yardTbl" runat="server" CellPadding="2" CellSpacing="2" BorderStyle="Solid" Font-Names="Calibri" Font-Size="16" GridLines="Both" Visible="false">
                                    <asp:TableRow>
                                        <asp:TableCell><strong>Yard Stats</strong></asp:TableCell>
                                        <asp:TableCell>Total</asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Finished Goods:</asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblFinGoods" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Wavetamer:</asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblWTInYard" runat="server" Text=""></asp:Label></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Sharkhide:</asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblSHInYard" runat="server" Text=""></asp:Label></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Red Tags (B3):</asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblRedTagsMInYard" runat="server" Text=""></asp:Label></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Red Tags (B2):</asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblRedTagsVInYard" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Red Tags (B1):</asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblRedTagsSInYard" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Eng Rig:</asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblRigInYard" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Tube Replacements:</asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblTubeRpl" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Tube Repairs:</asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblTubeRpr" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>In Yard:</asp:TableCell>
                                        <asp:TableCell HorizontalAlign="Right">
                                            <asp:Label ID="lblInYard" runat="server" Text=""></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>



                <div id="rackmapstats" class="rcgrid col w-10">
                    <asp:Table ID="tblRackMapStats" runat="server" CellPadding="2" CellSpacing="2" BorderStyle="Solid" Font-Names="Calibri" Font-Size="16" GridLines="Both">
                        <asp:TableRow>
                            <asp:TableCell>
                        <strong>Rails Rack Map Stats</strong>
                            </asp:TableCell>
                            <asp:TableCell>
                        <strong>Qty</strong>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B3 - All Green/Ready To Panel</asp:TableCell>
                            <asp:TableCell BackColor="LightGreen" Style="text-align: center">
                                <asp:Label ID="lblRailsGreen" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B3 - All Green/Rail Issue(s) Only</asp:TableCell>
                            <asp:TableCell BackColor="LightBlue" Style="text-align: center">
                                <asp:Label ID="lblRailsBlue" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B2 - All Green/Ready To Panel</asp:TableCell>
                            <asp:TableCell BackColor="LightGreen" Style="text-align: center">
                                <asp:Label ID="lblRailsVGreen" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B2 - All Green/Rail Issue(s) Only</asp:TableCell>
                            <asp:TableCell BackColor="LightBlue" Style="text-align: center">
                                <asp:Label ID="lblRailsVBlue" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B1 - Requested/Ready To Panel</asp:TableCell>
                            <asp:TableCell BackColor="Orange" Style="text-align: center">
                                <asp:Label ID="lblRailsOrange" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B1 - Requested/Not Ready</asp:TableCell>
                            <asp:TableCell BackColor="Yellow" Style="text-align: center">
                                <asp:Label ID="lblRailsYellow" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B1 - All Green/Rail Issue(s) Only</asp:TableCell>
                            <asp:TableCell BackColor="Tan" Style="text-align: center">
                                <asp:Label ID="lblRailsTan" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B3 - # Have All Rails</asp:TableCell>
                            <asp:TableCell Style="text-align: center">
                                <asp:Label ID="lblHasAllRailsM" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B2 - # Have All Rails</asp:TableCell>
                            <asp:TableCell Style="text-align: center">
                                <asp:Label ID="lblHasAllRailsV" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B1   - # Have All Rails</asp:TableCell>
                            <asp:TableCell Style="text-align: center">
                                <asp:Label ID="lblHasAllRailsS" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Total # Have All Rails</asp:TableCell>
                            <asp:TableCell Style="text-align: center">
                                <asp:Label ID="lblHasAllRails" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B3 - # Have Partial Rails</asp:TableCell>
                            <asp:TableCell Style="text-align: center">
                                <asp:Label ID="lblMSomeRails" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B2 - # Have Partial Rails</asp:TableCell>
                            <asp:TableCell Style="text-align: center">
                                <asp:Label ID="lblValueSomeRails" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>B1 - # Have Partial Rails</asp:TableCell>
                            <asp:TableCell Style="text-align: center">
                                <asp:Label ID="lblSouthSomeRails" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Total # Have Partial Rails</asp:TableCell>
                            <asp:TableCell Style="text-align: center">
                                <asp:Label ID="lblTotalSomeRails" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell># Empty Slots</asp:TableCell>
                            <asp:TableCell Style="text-align: center">
                                <asp:Label ID="lblEmtpySlots" runat="server" Text=""></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                    </asp:Table>
                    <br />
                    <asp:Table runat="server" BorderWidth="0" BorderStyle="Dotted" BorderColor="Green" Width="310px">
                        <asp:TableRow>
                            <asp:TableCell ColumnSpan="3" HorizontalAlign="Center" VerticalAlign="Top">
                                <asp:Image ID="health" runat="server" ImageUrl="images/health.png" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="Center" CssClass="newStyle7">B1</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center" CssClass="newStyle7">B2</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center" CssClass="newStyle7">B3</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="Center" VerticalAlign="Top">
                                <asp:Label ID="lblHealthS" CssClass="newStyle7" runat="server" Text="Label"></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center" VerticalAlign="Top">
                                <asp:Label ID="lblHealthV" CssClass="newStyle7" runat="server" Text="" ToolTip="Sum of Ready in Floors, Rails Ready to Pull (rack map light green), Rails Pulled (Framed or Not) and Ready Being Framed."></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center" VerticalAlign="Top">
                                <asp:Label ID="lblHealthM" CssClass="newStyle7" runat="server" Text="Label" ToolTip="Sum of Ready in Floors, Rails Ready to Pull (rack map light green), Rails Pulled (Framed or Not) and Ready Being Framed."></asp:Label>
                            </asp:TableCell>


                        </asp:TableRow>
                    </asp:Table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
