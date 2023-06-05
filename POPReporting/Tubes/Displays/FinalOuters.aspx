<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FinalOuters.aspx.vb" Inherits="Tubes_Displays_FinalOuters" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FINAL OUTERS - TV</title>
 <link href="http://localhost:43824/StyleSheet.css" rel="stylesheet" />
      <style>      
      
         .area {
            float:left;
            text-align:center;
            border-style:double;
            vertical-align:central;
            font-size:200px;
            font-family:Calibri;
            font-weight:bold;                    

        }

           .bldg {
            
            font-size:150px;
            font-family:Calibri;
            font-weight:bold;                    

        }
      
        .boatinfodlr {
            font-family:Calibri;
            font-size:10px;
        }
         .boatinfoprod {
            font-family:Calibri;
            font-size:100px;
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
          #floatleft {
              float:left;
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
                <asp:Label ID="Label2" runat="server" CssClass="boatinfoprod" Text="Red = Goes Online After Tubes & Frames, Orange = Goes Online When Framed."></asp:Label><br />
                <asp:Label ID ="label4" runat ="server" CssClass="boatinfoprod" Text="Green = Ready To Frame But Can't Go Online.  Yellow = Rerun."></asp:Label><br />                
        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="3000" ontick="Timer1_Tick"></asp:Timer>                     
        <asp:DataList ID="dl1" CssClass ="area" runat="server" DataSourceID="sdsPopReporting" BorderStyle="Outset" SeparatorStyle-Height="20px" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" RepeatColumns="4" RepeatDirection="Horizontal" Width="3800px">                        
            <ItemStyle BorderStyle="Solid" BorderWidth="2px" VerticalAlign="Top" Width="500px" />
            <ItemTemplate>               
                <asp:Label ID="Label1" runat="server" Text='<%# Mid(Eval("ProdNo"),3,5) & " - " & Eval("BuildLoc")%>'></asp:Label>
                <asp:Table runat="server" BorderWidth="0" BorderStyle="Solid" GridLines="Both" HorizontalAlign="Center">
                                                       
                    </asp:Table>                    
            </ItemTemplate>
            <SeparatorStyle Height="20px" />
            </asp:DataList>
                <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, Tubes.RoundSeamerPStatus, RoundSeamerP, RoundSeamerPID, RoundSeamerSStatus, RoundSeamerS, RoundSeamerSID, RoundSeamerCStatus, RoundSeamerC, RoundSeamerCID, Tubes.OuterSections, Tubes.CenterSections, Tubes.OuterScheduled, Tubes.CenterScheduled, Tubes.OuterScheduleOrder, Tubes.CenterScheduleOrder, Tubes.OuterRoller, Tubes.CenterRoller, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRoundSeamer, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.RerunP, BML_POPREPORTING_GREENLIGHTS.RerunSB, BML_POPREPORTING_GREENLIGHTS.RerunCtr,BML_POPREPORTING_TUBEPRIORITY.Length, FinalPStatus, FinalSStatus, FinalCStatus, CentertubeStatus, ReplaceReqdFlag, ReplacedFlag, (CASE WHEN Tubes.FinalPStatus = -1 THEN 0 WHEN FinalPStatus = 0 then 1 ELSE Tubes.FinalPStatus END) + (Case WHEN Tubes.FinalSStatus = -1 THEN 0 When FinalSStatus = 0 Then 1 ELSE Tubes.FinalSStatus END) + (CASE WHEN Tubes.FinalCStatus = -1 THEN 0 WHEN Tubes.FinalCStatus = 0 THEN 1 ELSE Tubes.FinalCStatus END) as TubeStatusTotal, HasAllRails, GaugeStatus, HarnessStatus, BML_POPREPORTING_GREENLIGHTS.BuildLoc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo INNER JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo LEFT JOIN TUBES ON BML_POPREPORTING.ProdNo = Tubes.ProdNo left join Rails_Tracking on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo Left join Tubes_DamageReported on BML_POPREPORTING.ProdNo = Tubes_DamageReported.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus &lt; 2) AND FramesInstalledStatus = 0 and FloorsInstalledStatus <> 2 and (RollerPStatus = 2 OR TubesStatus = 2) ORDER BY TubesLastUpdated desc, ProdNo"></asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>

    </div>
    </form>
</body>
</html>
