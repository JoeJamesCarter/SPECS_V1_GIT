<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Seamer.aspx.vb" Inherits="Tubes_Displays_Seamer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SEAMER TV</title>
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
                <asp:Label ID="lblTitle" CssClass="boatinfoprod" runat="server" Text="BENNINGTON TUBE SEAMER OVERVIEW"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblPort" runat="server" CssClass="boatinfoprod" Text="P:"></asp:Label><asp:Label ID="lblStrb" runat="server" CssClass="boatinfoprod" Text=" S:"></asp:Label><asp:Label ID="lblCtr" runat="server" CssClass="boatinfoprod" Text=" C:"></asp:Label><br />
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
                           <asp:ImageButton ID="btnUpdateSeamerPF" runat="server"  ImageUrl='<%# Eval("SeamerSectPFStatus", "../../Images/tubesections_front{0}.png")%>'/>                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMidVisible(Eval("CenterSections")) %>'>
                            <asp:ImageButton ID="btnUpdateSeamerPM" runat="server" Visible='<%#Eval("OuterSections") >= 3%>' ImageUrl='<%# Eval("SeamerSectPMStatus", "../../Images/tubesections_mid{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMid2Visible(Eval("CenterSections")) %>'>
                          <asp:ImageButton ID="btnUpdateSeamerPM2" runat="server" Visible='<%#Eval("OuterSections") = 4%>' ImageUrl='<%# Eval("SeamerSectPM2Status", "../../Images/tubesections_mid2{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell>
                             <asp:ImageButton ID="btnUpdateSeamerPR" runat="server"  ImageUrl='<%# Eval("SeamerSectPRStatus", "../../Images/tubesections_rear{0}.png")%>' />                                         
                        </asp:TableCell>
                    </asp:TableRow>
                        <asp:TableRow>
                        <asp:TableCell Font-Bold="True">
                            STRB
                        </asp:TableCell>
                         <asp:TableCell>
                           <asp:ImageButton ID="btnUpdateSeamerSF" runat="server"  ImageUrl='<%# Eval("SeamerSectSFStatus", "../../Images/tubesections_front{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMidVisible(Eval("CenterSections")) %>'>
                            <asp:ImageButton ID="btnUpdateSeamerSM" runat="server" Visible='<%#Eval("OuterSections") >= 3%>' ImageUrl='<%# Eval("SeamerSectSMStatus", "../../Images/tubesections_mid{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell  style='<%# CheckMid2Visible(Eval("CenterSections")) %>'>
                          <asp:ImageButton ID="btnUpdateSeamerSM2" runat="server" Visible='<%#Eval("OuterSections") = 4%>' ImageUrl='<%# Eval("SeamerSectSM2Status", "../../Images/tubesections_mid2{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell>
                             <asp:ImageButton ID="btnUpdateSeamerSR" runat="server"  ImageUrl='<%# Eval("SeamerSectSRStatus", "../../Images/tubesections_rear{0}.png")%>'  />                                         
                        </asp:TableCell>
                    </asp:TableRow>    
                         <asp:TableRow style='<%# CheckCtrVisible(Eval("CenterSections")) %>'>
                        <asp:TableCell Font-Bold="True">
                            CTR
                        </asp:TableCell>
                         <asp:TableCell>
                           <asp:ImageButton ID="btnUpdateSeamerCF" runat="server"  ImageUrl='<%# Eval("SeamerSectCFStatus", "../../Images/tubesections_front{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMidVisible(Eval("CenterSections")) %>'>
                            <asp:ImageButton ID="btnUpdateSeamerCM" runat="server" Visible='<%#Eval("CenterSections") >= 3%>' ImageUrl='<%# Eval("SeamerSectCMStatus", "../../Images/tubesections_mid{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMid2Visible(Eval("CenterSections")) %>'>
                          <asp:ImageButton ID="btnUpdateSeamerCM2" runat="server" Visible='<%#Eval("CenterSections") = 4%>' ImageUrl='<%# Eval("SeamerSectCM2Status", "../../Images/tubesections_mid2{0}.png")%>' />                                           
                        </asp:TableCell>
                        <asp:TableCell>
                             <asp:ImageButton ID="btnUpdateSeamerCR" runat="server"  ImageUrl='<%# Eval("SeamerSectCRStatus", "../../Images/tubesections_rear{0}.png")%>'  />                                         
                        </asp:TableCell>
                    </asp:TableRow>    
                    </asp:Table>
            </ItemTemplate>
            <SeparatorStyle Height="20px" />
            </asp:DataList>
                <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, Tubes.SeamerSectPFStatus, Tubes.SeamerSectPMStatus, Tubes.SeamerSectPM2Status, Tubes.SeamerSectPRStatus, Tubes.SeamerSectSFStatus, Tubes.SeamerSectSMStatus, Tubes.SeamerSectSM2Status, Tubes.SeamerSectSRStatus, Tubes.SeamerSectCFStatus, Tubes.SeamerSectCMStatus, Tubes.SeamerSectCM2Status, Tubes.SeamerSectCRStatus, Tubes.OuterSections, Tubes.CenterSections, Tubes.OuterScheduled, Tubes.CenterScheduled, Tubes.OuterScheduleOrder, Tubes.CenterScheduleOrder, Tubes.OuterRoller, Tubes.CenterRoller, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRoundSeamer, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.RerunP, BML_POPREPORTING_GREENLIGHTS.RerunSB, BML_POPREPORTING_GREENLIGHTS.RerunCtr,BML_POPREPORTING_TUBEPRIORITY.Length, (CASE WHEN Tubes.SeamerSectPFStatus = -1 THEN 0 WHEN Tubes.SeamerSectPFStatus = 0 THEN -1 ELSE Tubes.SeamerSectPFStatus END) + (Case WHEN Tubes.SeamerSectPMStatus = -1 THEN 0 WHEN Tubes.SeamerSectPMStatus = 0 THEN 1 ELSE Tubes.SeamerSectPMStatus END) + (CASE WHEN Tubes.SeamerSectPM2Status = -1 THEN 0 WHEN Tubes.SeamerSectPM2Status = 0 THEN 1 ELSE Tubes.SeamerSectPM2Status END) + (Case WHEN Tubes.SeamerSectPRStatus = -1 THEN 0 WHEN Tubes.SeamerSectPRStatus = 0 THEN 1 ELSE Tubes.SeamerSectPRStatus END) + (CASE WHEN Tubes.SeamerSectSFStatus = -1 THEN 0 WHEN Tubes.SeamerSectSFStatus = 0 THEN 1 ELSE Tubes.SeamerSectSFStatus END) + (CASE WHEN Tubes.SeamerSectSMStatus =-1 THEN 0 WHEN Tubes.SeamerSectSMStatus = 0 THEN 1 ELSE Tubes.SeamerSectSMStatus END) + (CASE WHEN Tubes.SeamerSectSM2Status = -1 THEN 0 WHEN Tubes.SeamerSectSM2Status = 0 THEN 1 ELSE Tubes.SeamerSectSM2Status END) + (CASE WHEN Tubes.SeamerSectSRStatus = -1 THEN 0 WHEN Tubes.SeamerSectSRStatus = 0 THEN 1 ELSE Tubes.SeamerSectSRStatus END) + (CASE WHEN Tubes.SeamerSectCFStatus = -1 THEN 0 WHEN Tubes.SeamerSectCFStatus = 0 THEN 1 ELSE Tubes.SeamerSectCFStatus END) + (CASE WHEN Tubes.SeamerSectCMStatus = -1 THEN 0 WHEN Tubes.SeamerSectCMStatus = 0 THEN 1 ELSE Tubes.SeamerSectCMStatus END) + (CASE WHEN Tubes.SeamerSectCM2Status = -1 THEN 0 WHEN Tubes.SeamerSectCM2Status = 0 THEN 1 ELSE Tubes.SeamerSectCM2Status END) + (CASE WHEN Tubes.SeamerSectCRStatus =-1 THEN 0 WHEN Tubes.SeamerSectCRStatus = 0 THEN 1 ELSE Tubes.SeamerSectCRStatus END) as TubeStatusTotal FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo INNER JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo LEFT JOIN TUBES ON BML_POPREPORTING.ProdNo = Tubes.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus &lt; 2) AND (BML_POPREPORTING_GREENLIGHTS.TubesStatus &lt; 1 or (BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.CentertubeStatus &lt; 1)) AND ((((Tubes.SeamerSectPFStatus + Tubes.SeamerSectPMStatus + Tubes.SeamerSectPM2Status + Tubes.SeamerSectPRStatus)/OuterSections != 2) OR ((Tubes.SeamerSectSFStatus + Tubes.SeamerSectSMStatus + Tubes.SeamerSectSM2Status + Tubes.SeamerSectSRStatus)/OuterSections != 2) OR (Tubes.SeamerSectCFStatus + Tubes.SeamerSectCMStatus + Tubes.SeamerSectCM2Status + Tubes.SeamerSectCRStatus)/NULLIF(CenterSections,0) != 2) AND ((Tubes.SeamerSectPFStatus =-1 OR Tubes.SeamerSectPMStatus = -1 OR Tubes.SeamerSectPM2Status =-1 OR Tubes.SeamerSectPRStatus <> 0 or Tubes.SeamerSectSFStatus =-1 OR Tubes.SeamerSectSMStatus =-1 OR Tubes.SeamerSectSM2Status =-1 OR Tubes.SeamerSectSRStatus =-1 or Tubes.SeamerSectCFStatus =-1 OR Tubes.SeamerSectCMStatus=-1 OR Tubes.SeamerSectCM2Status =-1 OR Tubes.SeamerSectCRStatus =-1))) ORDER BY TubeStatusTotal desc"></asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>

    </div>
    </form>
</body>
</html>
