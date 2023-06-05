<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Baffles.aspx.vb" Inherits="Tubes_Displays_Baffles" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Baffles TV</title>
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
                <asp:Label ID="lblTitle" CssClass="boatinfoprod" runat="server" Text="BENNINGTON TUBE BAFFLES OVERVIEW"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblPort" runat="server" CssClass="boatinfoprod" Text="P:"></asp:Label><asp:Label ID="lblStrb" runat="server" CssClass="boatinfoprod" Text=" S:"></asp:Label><asp:Label ID="lblCtr" runat="server" CssClass="boatinfoprod" Text=" C:"></asp:Label><br />
        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" ontick="Timer1_Tick"></asp:Timer>                     
        <asp:DataList ID="dl1" CssClass ="area" runat="server" DataSourceID="sdsPopReporting" RepeatDirection="Horizontal"  RepeatColumns="8" BorderStyle="Outset" SeparatorStyle-Height="20px" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" >            
            <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="112px" Width="217px" VerticalAlign="Top" />
            <ItemTemplate> 
                <asp:Label ID="Label1" cssClass="boatinfoprod" runat="server" Text='<%# Mid(Eval("ProdNo"),3,5)%>'></asp:Label>
                <asp:Table runat="server" BorderWidth="1" BorderStyle="Solid" GridLines="Both" Width="300px" HorizontalAlign="Center">
                     <asp:TableRow>
                        <asp:TableCell>
                           
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="True">
                            Front
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="True" style='<%# CheckMidVisible(Eval("CenterSections")) %>'>
                            Mid
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="True" style='<%# CheckMid2Visible(Eval("CenterSections")) %>'>
                            Mid2
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="True">
                            Rear
                        </asp:TableCell>
                    </asp:TableRow>
                        
                        <asp:TableRow>
                        <asp:TableCell Font-Bold="True">
                            PORT
                        </asp:TableCell>
                        <asp:TableCell>
                           <asp:ImageButton ID="btnUpdateBafflesPF" runat="server"  ImageUrl='<%# Eval("BafflesSectPFStatus", "../../Images/tubesections_front{0}.png")%>'/>                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMidVisible(Eval("CenterSections")) %>'>
                            <asp:ImageButton ID="btnUpdateBafflesPM" runat="server" Visible='<%#Eval("OuterSections") >= 3%>' ImageUrl='<%# Eval("BafflesSectPMStatus", "../../Images/tubesections_mid{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMid2Visible(Eval("CenterSections")) %>'>
                          <asp:ImageButton ID="btnUpdateBafflesPM2" runat="server" Visible='<%#Eval("OuterSections") = 4%>' ImageUrl='<%# Eval("BafflesSectPM2Status", "../../Images/tubesections_mid2{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell>
                             <asp:ImageButton ID="btnUpdateBafflesPR" runat="server"  ImageUrl='<%# Eval("BafflesSectPRStatus", "../../Images/tubesections_rear{0}.png")%>' />                                         
                        </asp:TableCell>
                    </asp:TableRow>
                        <asp:TableRow>
                        <asp:TableCell Font-Bold="True">
                            STRB
                        </asp:TableCell>
                         <asp:TableCell>
                           <asp:ImageButton ID="btnUpdateBafflesSF" runat="server"  ImageUrl='<%# Eval("BafflesSectSFStatus", "../../Images/tubesections_front{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMidVisible(Eval("CenterSections")) %>'>
                            <asp:ImageButton ID="btnUpdateBafflesSM" runat="server" Visible='<%#Eval("OuterSections") >= 3%>' ImageUrl='<%# Eval("BafflesSectSMStatus", "../../Images/tubesections_mid{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell  style='<%# CheckMid2Visible(Eval("CenterSections")) %>'>
                          <asp:ImageButton ID="btnUpdateBafflesSM2" runat="server" Visible='<%#Eval("OuterSections") = 4%>' ImageUrl='<%# Eval("BafflesSectSM2Status", "../../Images/tubesections_mid2{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell>
                             <asp:ImageButton ID="btnUpdateBafflesSR" runat="server"  ImageUrl='<%# Eval("BafflesSectSRStatus", "../../Images/tubesections_rear{0}.png")%>'  />                                         
                        </asp:TableCell>
                    </asp:TableRow>    
                         <asp:TableRow style='<%# CheckCtrVisible(Eval("CenterSections")) %>'>
                        <asp:TableCell Font-Bold="True">
                            CTR
                        </asp:TableCell>
                         <asp:TableCell>
                           <asp:ImageButton ID="btnUpdateBafflesCF" runat="server"  ImageUrl='<%# Eval("BafflesSectCFStatus", "../../Images/tubesections_front{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMidVisible(Eval("CenterSections")) %>'>
                            <asp:ImageButton ID="btnUpdateBafflesCM" runat="server" Visible='<%#Eval("CenterSections") >= 3%>' ImageUrl='<%# Eval("BafflesSectCMStatus", "../../Images/tubesections_mid{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMid2Visible(Eval("CenterSections")) %>'>
                          <asp:ImageButton ID="btnUpdateBafflesCM2" runat="server" Visible='<%#Eval("CenterSections") = 4%>' ImageUrl='<%# Eval("BafflesSectCM2Status", "../../Images/tubesections_mid2{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell>
                             <asp:ImageButton ID="btnUpdateBafflesCR" runat="server"  ImageUrl='<%# Eval("BafflesSectCRStatus", "../../Images/tubesections_rear{0}.png")%>'  />                                         
                        </asp:TableCell>
                    </asp:TableRow>    
                    </asp:Table>
            </ItemTemplate>
            <SeparatorStyle Height="20px" />
            </asp:DataList>
                <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, Tubes.BafflesSectPFStatus, Tubes.BafflesSectPMStatus, Tubes.BafflesSectPM2Status, Tubes.BafflesSectPRStatus, Tubes.BafflesSectSFStatus, Tubes.BafflesSectSMStatus, Tubes.BafflesSectSM2Status, Tubes.BafflesSectSRStatus, Tubes.BafflesSectCFStatus, Tubes.BafflesSectCMStatus, Tubes.BafflesSectCM2Status, Tubes.BafflesSectCRStatus, Tubes.OuterSections, Tubes.CenterSections, Tubes.OuterScheduled, Tubes.CenterScheduled, Tubes.OuterScheduleOrder, Tubes.CenterScheduleOrder, Tubes.OuterRoller, Tubes.CenterRoller, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRoundSeamer, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.RerunP, BML_POPREPORTING_GREENLIGHTS.RerunSB, BML_POPREPORTING_GREENLIGHTS.RerunCtr,BML_POPREPORTING_TUBEPRIORITY.Length, (CASE WHEN Tubes.BafflesSectPFStatus = -1 THEN 0 WHEN Tubes.BafflesSectPFStatus = 0 THEN -1 ELSE Tubes.BafflesSectPFStatus END) + (Case WHEN Tubes.BafflesSectPMStatus = -1 THEN 0 WHEN Tubes.BafflesSectPMStatus = 0 THEN 1 ELSE Tubes.BafflesSectPMStatus END) + (CASE WHEN Tubes.BafflesSectPM2Status = -1 THEN 0 WHEN Tubes.BafflesSectPM2Status = 0 THEN 1 ELSE Tubes.BafflesSectPM2Status END) + (Case WHEN Tubes.BafflesSectPRStatus = -1 THEN 0 WHEN Tubes.BafflesSectPRStatus = 0 THEN 1 ELSE Tubes.BafflesSectPRStatus END) + (CASE WHEN Tubes.BafflesSectSFStatus = -1 THEN 0 WHEN Tubes.BafflesSectSFStatus = 0 THEN 1 ELSE Tubes.BafflesSectSFStatus END) + (CASE WHEN Tubes.BafflesSectSMStatus =-1 THEN 0 WHEN Tubes.BafflesSectSMStatus = 0 THEN 1 ELSE Tubes.BafflesSectSMStatus END) + (CASE WHEN Tubes.BafflesSectSM2Status = -1 THEN 0 WHEN Tubes.BafflesSectSM2Status = 0 THEN 1 ELSE Tubes.BafflesSectSM2Status END) + (CASE WHEN Tubes.BafflesSectSRStatus = -1 THEN 0 WHEN Tubes.BafflesSectSRStatus = 0 THEN 1 ELSE Tubes.BafflesSectSRStatus END) + (CASE WHEN Tubes.BafflesSectCFStatus = -1 THEN 0 WHEN Tubes.BafflesSectCFStatus = 0 THEN 1 ELSE Tubes.BafflesSectCFStatus END) + (CASE WHEN Tubes.BafflesSectCMStatus = -1 THEN 0 WHEN Tubes.BafflesSectCMStatus = 0 THEN 1 ELSE Tubes.BafflesSectCMStatus END) + (CASE WHEN Tubes.BafflesSectCM2Status = -1 THEN 0 WHEN Tubes.BafflesSectCM2Status = 0 THEN 1 ELSE Tubes.BafflesSectCM2Status END) + (CASE WHEN Tubes.BafflesSectCRStatus =-1 THEN 0 WHEN Tubes.BafflesSectCRStatus = 0 THEN 1 ELSE Tubes.BafflesSectCRStatus END) as TubeStatusTotal FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo INNER JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo LEFT JOIN TUBES ON BML_POPREPORTING.ProdNo = Tubes.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.TubesStatus &lt; 1 or (BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.CentertubeStatus &lt; 1)) AND ((((Tubes.BafflesSectPFStatus + Tubes.BafflesSectPMStatus + Tubes.BafflesSectPM2Status + Tubes.BafflesSectPRStatus)/OuterSections != 2) OR ((Tubes.BafflesSectSFStatus + Tubes.BafflesSectSMStatus + Tubes.BafflesSectSM2Status + Tubes.BafflesSectSRStatus)/OuterSections != 2) OR (Tubes.BafflesSectCFStatus + Tubes.BafflesSectCMStatus + Tubes.BafflesSectCM2Status + Tubes.BafflesSectCRStatus)/NULLIF(CenterSections,0) != 2) AND ((Tubes.BafflesSectPFStatus =-1 OR Tubes.BafflesSectPMStatus = -1 OR Tubes.BafflesSectPM2Status =-1 OR Tubes.BafflesSectPRStatus <> 0 or Tubes.BafflesSectSFStatus =-1 OR Tubes.BafflesSectSMStatus =-1 OR Tubes.BafflesSectSM2Status =-1 OR Tubes.BafflesSectSRStatus =-1 or Tubes.BafflesSectCFStatus =-1 OR Tubes.BafflesSectCMStatus=-1 OR Tubes.BafflesSectCM2Status =-1 OR Tubes.BafflesSectCRStatus =-1))) ORDER BY TubeStatusTotal desc"></asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>

    </div>
    </form>
</body>
</html>
