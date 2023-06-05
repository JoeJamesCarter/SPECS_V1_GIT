<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Brackets.aspx.vb" Inherits="Tubes_Displays_Brackets" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Brackets TV</title>
    <link href="http://localhost:43824/StyleSheet.css" rel="stylesheet" />
    <style>
        .area {
            float: left;
            text-align: center;
            border-style: double;
            vertical-align: central;
            font-size: 14px;
            font-family: Calibri;
            font-weight: bold;
        }

        .boatinfodlr {
            font-family: Calibri;
            font-size: 10px;
        }

        .boatinfoprod {
            font-family: Calibri;
            font-size: 50px;
            font-weight: bold;
            margin-left: 10px;
            text-align: center;
        }

        .boatinfoboat {
            font-family: Calibri;
            font-size: 20px;
            font-weight: bold;
            float: right;
            margin-right: 10px;
        }

        .slot {
            font-family: Calibri;
            font-size: 16px;
            font-weight: bold;
            color: Black;
            vertical-align: top;
        }

        .title {
            font-family: Calibri;
            font-size: 20px;
            font-weight: bold;
            color: Black;
            vertical-align: top;
            text-align: center;
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                <ContentTemplate>
                    <asp:Label ID="lblTitle" CssClass="boatinfoprod" runat="server" Text="BENNINGTON TUBE BRACKETS OVERVIEW"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblPort" runat="server" CssClass="boatinfoprod" Text="P:"></asp:Label><asp:Label ID="lblStrb" runat="server" CssClass="boatinfoprod" Text=" S:"></asp:Label><asp:Label ID="lblCtr" runat="server" CssClass="boatinfoprod" Text=" C:"></asp:Label><br />
                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                    <asp:DataList ID="dl1" CssClass="area" runat="server" DataSourceID="sdsPopReporting" RepeatDirection="Horizontal" RepeatColumns="8" BorderStyle="Outset" SeparatorStyle-Height="20px" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="112px" Width="217px" VerticalAlign="Top" />
                        <ItemTemplate>
                            <asp:Label ID="Label1" CssClass="boatinfoprod" runat="server" Text='<%# Mid(Eval("ProdNo"),3,5)%>'></asp:Label>
                            <asp:Table runat="server" BorderWidth="0" BorderStyle="Solid" GridLines="Both" Width="300px" HorizontalAlign="Center">
                                <asp:TableRow>
                                    <asp:TableCell HorizontalAlign="Center" Font-Bold="True">
                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("BracketsPStatus", "../../Images/tubes_port{0}.png")%>' />
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center" Font-Bold="True">
                                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl='<%# Eval("BracketsSStatus", "../../Images/tubes_strb{0}.png")%>' />
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center" Font-Bold="True" Style='<%# CheckCtrVisible(Eval("CenterSections")) %>'>
                                        <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl='<%# Eval("BracketsCStatus", "../../Images/tubes_ctr{0}.png")%>' />
                                    </asp:TableCell>
                                </asp:TableRow>

                            </asp:Table>
                        </ItemTemplate>
                        <SeparatorStyle Height="20px" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, Tubes.BracketsPStatus, BracketsP, BracketsPID, BracketsSStatus, BracketsS, BracketsSID, BracketsCStatus, BracketsC, BracketsCID, Tubes.OuterSections, Tubes.CenterSections, Tubes.OuterScheduled, Tubes.CenterScheduled, Tubes.OuterScheduleOrder, Tubes.CenterScheduleOrder, Tubes.OuterRoller, Tubes.CenterRoller, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRoundSeamer, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.RerunP, BML_POPREPORTING_GREENLIGHTS.RerunSB, BML_POPREPORTING_GREENLIGHTS.RerunCtr,BML_POPREPORTING_TUBEPRIORITY.Length, (CASE WHEN Tubes.BracketsPStatus = -1 THEN 0 WHEN BracketsPStatus = 0 then 1 ELSE Tubes.BracketsPStatus END) + (Case WHEN Tubes.BracketsSStatus = -1 THEN 0 When BracketsSStatus = 0 Then 1 ELSE Tubes.BracketsSStatus END) + (CASE WHEN Tubes.BracketsCStatus = -1 THEN 0 WHEN Tubes.BracketsCStatus = 0 THEN 1 ELSE Tubes.BafflesSectPM2Status END) as TubeStatusTotal FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo INNER JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo LEFT JOIN TUBES ON BML_POPREPORTING.ProdNo = Tubes.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.TubesStatus &lt; 1 or (BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.CentertubeStatus &lt; 1)) AND (((Tubes.BracketsPStatus/OuterSections != 2) OR (Tubes.BracketsSStatus/OuterSections != 2) OR (Tubes.BracketsCStatus/NULLIF(CenterSections,0) != 2)) AND (Tubes.BracketsPStatus =-1 OR Tubes.BracketsSStatus = -1 OR Tubes.BracketsCStatus =-1 )) ORDER BY TubeStatusTotal desc"></asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>

        </div>
    </form>
</body>
</html>
