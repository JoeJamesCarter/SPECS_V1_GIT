<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Baffles.aspx.vb" Inherits="Tubes_Baffles" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BAFFLES</title>
     <link href="../StyleSheet.css" rel="stylesheet" />    
</head>
<body>
    <form id= "form1" runat= "server" Class= "newStyle7" >   
    <div>
          <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
          <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">BAFFLES</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="../Tubes/tubestoolbar.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
          <asp:UpdatePanel ID="UpdatePanel1" runat="server">
           
            <ContentTemplate>
        <asp:Timer ID="Timer2" runat="server" ClientIDMode="AutoID" Interval="30000" ontick="Timer1_Tick"></asp:Timer>   
        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" ontick="Timer1_Tick"></asp:Timer>
        <asp:GridView ID="gvRoundSeamer" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                <ItemStyle Font-Bold="True" />
                </asp:BoundField>
                <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="F">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="FG">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="C">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="R">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="T">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="CT">
                    <ItemTemplate>
                        <asp:Image ID="Centertube" Visible='<%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "../Images/{0}.png") %>'  runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/><br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label><br />
                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("OuterRoller")%>' CssClass="newStyle5"></asp:Label><asp:Label ID="Label3" runat="server" Text='<%# "O:" & Eval("OuterScheduled")%>' CssClass="newStyle5"></asp:Label>
                        <asp:Label ID="Label6" runat="server" Text='<%#"Seq:" & Eval("OuterScheduleOrder")%>' CssClass="newStyle5"></asp:Label><br />
                        <asp:Label ID="Label8" runat="server" Visible='<%# Eval("CentertubeNeeded") = 1%>' Text='<%# Eval("CenterRoller")%>' CssClass="newStyle5"></asp:Label>                        
                        <asp:Label ID="Label4" Visible='<%# Eval("CentertubeNeeded") = 1%>' runat="server" Text='<%# "C:" & Eval("CenterScheduled")%>' CssClass="newStyle5"></asp:Label>
                        <asp:Label ID="Label5" Visible='<%# Eval("CentertubeNeeded") = 1%>' runat="server" Text='<%# " Seq:" & Eval("CenterScheduleOrder")%>' CssClass="newStyle5"></asp:Label>                   
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
               <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="Custom">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                <asp:TemplateField HeaderText="Options">
                         <ItemTemplate>
                             <asp:GridView ID="gvOverrides" runat="server" Gridlines="None" DataSourceID="sdsOverrides" showheader= "False" ForeColor="Red" AutoGenerateColumns="False" DataKeyNames="ProdNo">
                                 <Columns>
                                     <asp:BoundField DataField="Override" HeaderText="Override" SortExpression="Override" >
                                     <ItemStyle HorizontalAlign="Center" />
                                     </asp:BoundField>
                                 </Columns>
                             </asp:GridView>
                              <asp:SqlDataSource ID="sdsOverrides" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [Override], [Chines] FROM [BML_POPREPORTING_TUBEOVERRIDES] WHERE (([RoundSeamer] = @RoundSeamer) AND ([ProdNo] = @ProdNo))">
                                 <SelectParameters>
                                     <asp:Parameter Name="ProdNo" Type="String" />
                                     <asp:Parameter DefaultValue="1" Name="RoundSeamer" Type="Int32" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                             <asp:GridView ID="gvFabOptionsRoundSeamer" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsPopReportingFabOptions" CssClass="newStyle3">
                                 <Columns>
                                     <asp:BoundField DataField="Keel" HeaderText="Fab Options" SortExpression="Keel" ShowHeader="False" >
                                     <ControlStyle BorderStyle="None" />
                                     <FooterStyle BorderStyle="None" />
                                     <HeaderStyle BorderStyle="None" Height="10px" />
                                     <ItemStyle BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Middle" />
                                     </asp:BoundField> 
                                                                         
                                 </Columns>                                 
                             </asp:GridView>
                             <asp:GridView ID="gvFabOptionsRoundSeamer2" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsPopReportingFabOptions" CssClass="newStyle3">
                                 <Columns>
                                     <asp:BoundField DataField="Brackets" HeaderText="Fab Options" SortExpression="Brackets" ShowHeader="False" >
                                     <ControlStyle BorderStyle="None" />
                                     <FooterStyle BorderStyle="None" />
                                     <HeaderStyle BorderStyle="None" Height="10px" />
                                     <ItemStyle BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Middle" />
                                     </asp:BoundField> 
                                                                         
                                 </Columns>                                 
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsPopReportingFabOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [Keel], [Brackets] FROM [BML_POPREPORTING_TUBEPRIORITY] WHERE ([ProdNo] = @ProdNo)">
                                 <SelectParameters>
                                     <asp:Parameter Name="ProdNo" Type="String" />                                     
                                 </SelectParameters>
                             </asp:SqlDataSource>
                         </ItemTemplate>
                         <ItemStyle Font-Size="12pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                <asp:BoundField HeaderText="Tube Length" DataField="Length" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Sections">
                    <ItemTemplate>
                    <asp:Table runat="server" BorderWidth="1" BorderStyle="Solid" GridLines="Both" Width="300px">
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
                           <asp:ImageButton ID="btnUpdateBafflesPF" runat="server"  ImageUrl='<%# Eval("BafflesSectPFStatus", "../Images/tubesections_front{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdatePF"/>                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMidVisible(Eval("CenterSections")) %>'>
                            <asp:ImageButton ID="btnUpdateBafflesPM" runat="server" Visible='<%#Eval("OuterSections") >= 3%>' ImageUrl='<%# Eval("BafflesSectPMStatus", "../Images/tubesections_mid{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdatePM"/>                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMid2Visible(Eval("CenterSections")) %>'>
                          <asp:ImageButton ID="btnUpdateBafflesPM2" runat="server" Visible='<%#Eval("OuterSections") = 4%>' ImageUrl='<%# Eval("BafflesSectPM2Status", "../Images/tubesections_mid2{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdatePM2"/>                                           
                        </asp:TableCell>
                        <asp:TableCell>
                             <asp:ImageButton ID="btnUpdateBafflesPR" runat="server"  ImageUrl='<%# Eval("BafflesSectPRStatus", "../Images/tubesections_rear{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdatePR" />                                         
                        </asp:TableCell>
                    </asp:TableRow>
                        <asp:TableRow>
                        <asp:TableCell Font-Bold="True">
                            STRB
                        </asp:TableCell>
                         <asp:TableCell>
                           <asp:ImageButton ID="btnUpdateBafflesSF" runat="server"  ImageUrl='<%# Eval("BafflesSectSFStatus", "../Images/tubesections_front{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateSF"/>                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMidVisible(Eval("CenterSections")) %>'>
                            <asp:ImageButton ID="btnUpdateBafflesSM" runat="server" Visible='<%#Eval("OuterSections") >= 3%>' ImageUrl='<%# Eval("BafflesSectSMStatus", "../Images/tubesections_mid{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateSM"/>                                           
                        </asp:TableCell>
                        <asp:TableCell  style='<%# CheckMid2Visible(Eval("CenterSections")) %>'>
                          <asp:ImageButton ID="btnUpdateBafflesSM2" runat="server" Visible='<%#Eval("OuterSections") = 4%>' ImageUrl='<%# Eval("BafflesSectSM2Status", "../Images/tubesections_mid2{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateSM2"/>                                           
                        </asp:TableCell>
                        <asp:TableCell>
                             <asp:ImageButton ID="btnUpdateBafflesSR" runat="server"  ImageUrl='<%# Eval("BafflesSectSRStatus", "../Images/tubesections_rear{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateSR" />                                         
                        </asp:TableCell>
                    </asp:TableRow>    
                         <asp:TableRow style='<%# CheckCtrVisible(Eval("CenterSections")) %>'>
                        <asp:TableCell Font-Bold="True">
                            CTR
                        </asp:TableCell>
                         <asp:TableCell>
                           <asp:ImageButton ID="btnUpdateBafflesCF" runat="server"  ImageUrl='<%# Eval("BafflesSectCFStatus", "../Images/tubesections_front{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCF"/>                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMidVisible(Eval("CenterSections")) %>'>
                            <asp:ImageButton ID="btnUpdateBafflesCM" runat="server" Visible='<%#Eval("CenterSections") >= 3%>' ImageUrl='<%# Eval("BafflesSectCMStatus", "../Images/tubesections_mid{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCM"/>                                           
                        </asp:TableCell>
                        <asp:TableCell style='<%# CheckMid2Visible(Eval("CenterSections")) %>'>
                          <asp:ImageButton ID="btnUpdateBafflesCM2" runat="server" Visible='<%#Eval("CenterSections") = 4%>' ImageUrl='<%# Eval("BafflesSectCM2Status", "../Images/tubesections_mid2{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCM2"/>                                           
                        </asp:TableCell>
                        <asp:TableCell>
                             <asp:ImageButton ID="btnUpdateBafflesCR" runat="server"  ImageUrl='<%# Eval("BafflesSectCRStatus", "../Images/tubesections_rear{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCR" />                                         
                        </asp:TableCell>
                    </asp:TableRow>    
                    </asp:Table>
                    </ItemTemplate>
                </asp:TemplateField>
                
                 
                    <asp:TemplateField HeaderText="Offline">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotostatus" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "../Images/notes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes" />
                        <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesRoundSeamer") = 1%>' ImageUrl='<%# Eval("NotesRoundSeamer", "../Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes"/>                 
                         </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, Tubes.SeamerSectPFStatus, Tubes.SeamerSectPMStatus, Tubes.SeamerSectPM2Status, Tubes.SeamerSectPRStatus, Tubes.SeamerSectSFStatus, Tubes.SeamerSectSMStatus, Tubes.SeamerSectSM2Status, Tubes.SeamerSectSRStatus, Tubes.SeamerSectCFStatus, Tubes.SeamerSectCMStatus, Tubes.SeamerSectCM2Status, Tubes.SeamerSectCRStatus, Tubes.OuterSections, Tubes.CenterSections, Tubes.OuterScheduled, Tubes.CenterScheduled, Tubes.OuterScheduleOrder, Tubes.CenterScheduleOrder, Tubes.OuterRoller, Tubes.CenterRoller, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRoundSeamer, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.RerunP, BML_POPREPORTING_GREENLIGHTS.RerunSB, BML_POPREPORTING_GREENLIGHTS.RerunCtr,BML_POPREPORTING_TUBEPRIORITY.Length, (CASE WHEN Tubes.SeamerSectPFStatus = -1 THEN 0 WHEN Tubes.SeamerSectPFStatus = 0 THEN -1 ELSE Tubes.SeamerSectPFStatus END) + (Case WHEN Tubes.SeamerSectPMStatus = -1 THEN 0 WHEN Tubes.SeamerSectPMStatus = 0 THEN 1 ELSE Tubes.SeamerSectPMStatus END) + (CASE WHEN Tubes.SeamerSectPM2Status = -1 THEN 0 WHEN Tubes.SeamerSectPM2Status = 0 THEN 1 ELSE Tubes.SeamerSectPM2Status END) + (Case WHEN Tubes.SeamerSectPRStatus = -1 THEN 0 WHEN Tubes.SeamerSectPRStatus = 0 THEN 1 ELSE Tubes.SeamerSectPRStatus END) + (CASE WHEN Tubes.SeamerSectSFStatus = -1 THEN 0 WHEN Tubes.SeamerSectSFStatus = 0 THEN 1 ELSE Tubes.SeamerSectSFStatus END) + (CASE WHEN Tubes.SeamerSectSMStatus =-1 THEN 0 WHEN Tubes.SeamerSectSMStatus = 0 THEN 1 ELSE Tubes.SeamerSectSMStatus END) + (CASE WHEN Tubes.SeamerSectSM2Status = -1 THEN 0 WHEN Tubes.SeamerSectSM2Status = 0 THEN 1 ELSE Tubes.SeamerSectSM2Status END) + (CASE WHEN Tubes.SeamerSectSRStatus = -1 THEN 0 WHEN Tubes.SeamerSectSRStatus = 0 THEN 1 ELSE Tubes.SeamerSectSRStatus END) + (CASE WHEN Tubes.SeamerSectCFStatus = -1 THEN 0 WHEN Tubes.SeamerSectCFStatus = 0 THEN 1 ELSE Tubes.SeamerSectCFStatus END) + (CASE WHEN Tubes.SeamerSectCMStatus = -1 THEN 0 WHEN Tubes.SeamerSectCMStatus = 0 THEN 1 ELSE Tubes.SeamerSectCMStatus END) + (CASE WHEN Tubes.SeamerSectCM2Status = -1 THEN 0 WHEN Tubes.SeamerSectCM2Status = 0 THEN 1 ELSE Tubes.SeamerSectCM2Status END) + (CASE WHEN Tubes.SeamerSectCRStatus =-1 THEN 0 WHEN Tubes.SeamerSectCRStatus = 0 THEN 1 ELSE Tubes.SeamerSectCRStatus END) as TubeStatusTotal FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo INNER JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo LEFT JOIN TUBES ON BML_POPREPORTING.ProdNo = Tubes.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.TubesStatus &lt; 1 or (BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.CentertubeStatus &lt; 1)) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND ((((Tubes.SeamerSectPFStatus + Tubes.SeamerSectPMStatus + Tubes.SeamerSectPM2Status + Tubes.SeamerSectPRStatus)/OuterSections != 2) OR ((Tubes.SeamerSectSFStatus + Tubes.SeamerSectSMStatus + Tubes.SeamerSectSM2Status + Tubes.SeamerSectSRStatus)/OuterSections != 2) OR (Tubes.SeamerSectCFStatus + Tubes.SeamerSectCMStatus + Tubes.SeamerSectCM2Status + Tubes.SeamerSectCRStatus)/NULLIF(CenterSections,0) != 2) AND ((Tubes.SeamerSectPFStatus =-1 OR Tubes.SeamerSectPMStatus = -1 OR Tubes.SeamerSectPM2Status =-1 OR Tubes.SeamerSectPRStatus <> 0 or Tubes.SeamerSectSFStatus =-1 OR Tubes.SeamerSectSMStatus =-1 OR Tubes.SeamerSectSM2Status =-1 OR Tubes.SeamerSectSRStatus =-1 or Tubes.SeamerSectCFStatus =-1 OR Tubes.SeamerSectCMStatus=-1 OR Tubes.SeamerSectCM2Status =-1 OR Tubes.SeamerSectCRStatus =-1))) ORDER BY TubeStatusTotal desc">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                 <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                 <asp:ControlParameter ControlID="ddlShowSelect" Name="SeamerStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />                 
                 <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '1%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />  
            </SelectParameters>
        </asp:SqlDataSource> 
                 </ContentTemplate>
           
            </asp:UpdatePanel>              
    </form>
</body>
</html>