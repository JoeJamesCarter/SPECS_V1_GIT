<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RoundSeamer.aspx.vb" Inherits="Tubes_Displays_RoundSeamer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Round Seamer TV</title>
    <link href="http://localhost:43824/StyleSheet.css" rel="stylesheet" />
      <style>      
      
         .area {
            float:left;
            text-align:center;
            border-style:double;
            vertical-align:central;
            font-size:14px;
            font-family:Calibri;
            font-weight:bold;
        }
      
        .boatinfodlr {
            font-family:Calibri;
            font-size:10px;
        }
         .boatinfoprod {
            font-family:Calibri;
            font-size:50px;
            font-weight:bold;
            margin-left:10px;            
            text-align:center;
        }
          .boatinfoboat {
            font-family:Calibri;
            font-size:20px;
            font-weight:bold;
            float:right;
            margin-right:10px;
        }
        
         .slot {
            font-family:Calibri;
            font-size:16px;
            font-weight:bold;
            color:Black;
            vertical-align:top;            
        }
         .title {
            font-family:Calibri;
            font-size:20px;
            font-weight:bold;
            color:Black;
            vertical-align:top;  
            text-align:center;   
            width:100%;
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
                <asp:Label ID="lblTitle" CssClass="boatinfoprod" runat="server" Text="BENNINGTON TUBE ROUND SEAMER OVERVIEW"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblPort" runat="server" CssClass="boatinfoprod" Text="P:"></asp:Label><asp:Label ID="lblStrb" runat="server" CssClass="boatinfoprod" Text=" S:"></asp:Label><asp:Label ID="lblCtr" runat="server" CssClass="boatinfoprod" Text=" C:"></asp:Label><br />
        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" ontick="Timer1_Tick"></asp:Timer>                     
        <asp:DataList ID="dl1" CssClass ="area" runat="server" DataSourceID="sdsPopReporting" RepeatDirection="Horizontal"  RepeatColumns="8" BorderStyle="Outset" SeparatorStyle-Height="20px" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" >            
            <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="112px" Width="217px" VerticalAlign="Top" />
            <ItemTemplate> 
                <asp:Label ID="Label1" cssClass="boatinfoprod" runat="server" Text='<%# Mid(Eval("ProdNo"),3,5)%>'></asp:Label>
                <asp:Table runat="server" BorderWidth="0" BorderStyle="Solid" GridLines="Both" Width="300px" HorizontalAlign="Center">
                     <asp:TableRow>                        
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="True">
                            <asp:ImageButton ID="ImageButton1" runat="server"  ImageUrl='<%# Eval("RoundSeamerPStatus", "../../Images/tubes_port{0}.png")%>'/>                                           
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="True">
                            <asp:ImageButton ID="ImageButton2" runat="server"  ImageUrl='<%# Eval("RoundSeamerSStatus", "../../Images/tubes_strb{0}.png")%>'/>                                           
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="True" style='<%# CheckCtrVisible(Eval("CenterSections")) %>'>
                            <asp:ImageButton ID="ImageButton3" runat="server"  ImageUrl='<%# Eval("RoundSeamerCStatus", "../../Images/tubes_ctr{0}.png")%>'/>                                           
                        </asp:TableCell>
                     
                    </asp:TableRow>
                        
                      
                    </asp:Table>
            </ItemTemplate>
            <SeparatorStyle Height="20px" />
            </asp:DataList>
                <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, Tubes.RoundSeamerPStatus, RoundSeamerP, RoundSeamerPID, RoundSeamerSStatus, RoundSeamerS, RoundSeamerSID, RoundSeamerCStatus, RoundSeamerC, RoundSeamerCID, Tubes.OuterSections, Tubes.CenterSections, Tubes.OuterScheduled, Tubes.CenterScheduled, Tubes.OuterScheduleOrder, Tubes.CenterScheduleOrder, Tubes.OuterRoller, Tubes.CenterRoller, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRoundSeamer, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.RerunP, BML_POPREPORTING_GREENLIGHTS.RerunSB, BML_POPREPORTING_GREENLIGHTS.RerunCtr,BML_POPREPORTING_TUBEPRIORITY.Length, (CASE WHEN Tubes.RoundSeamerPStatus = -1 THEN 0 WHEN RoundSeamerPStatus = 0 then 1 ELSE Tubes.RoundSeamerPStatus END) + (Case WHEN Tubes.RoundSeamerSStatus = -1 THEN 0 When RoundSeamerSStatus = 0 Then 1 ELSE Tubes.RoundSeamerSStatus END) + (CASE WHEN Tubes.RoundSeamerCStatus = -1 THEN 0 WHEN Tubes.RoundSeamerCStatus = 0 THEN 1 ELSE Tubes.BafflesSectPM2Status END) as TubeStatusTotal FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo INNER JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo LEFT JOIN TUBES ON BML_POPREPORTING.ProdNo = Tubes.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.TubesStatus &lt; 1 or (BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.CentertubeStatus &lt; 1)) AND (((Tubes.RoundSeamerPStatus/OuterSections != 2) OR (Tubes.RoundSeamerSStatus/OuterSections != 2) OR (Tubes.RoundSeamerCStatus/NULLIF(CenterSections,0) != 2)) AND (Tubes.RoundSeamerPStatus =-1 OR Tubes.RoundSeamerSStatus = -1 OR Tubes.RoundSeamerCStatus =-1 )) ORDER BY TubeStatusTotal desc"></asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>

    </div>
    </form>
</body>
</html>
