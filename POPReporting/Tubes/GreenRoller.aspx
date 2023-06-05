﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GreenRoller.aspx.vb"  MaintainScrollPositionOnPostback="true"  Inherits="Tubes_GreenRoller" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GREEN ROLLER</title>
 <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        #green {
            color:green;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
          <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7" id="green">ROLLER</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="../Tubes/tubestoolbar.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            <asp:HiddenField ID="hdnStatus" runat="server" />
          <asp:Label ID="Label9" runat="server" CssClass="newStyle4" Text="Reruns"></asp:Label>
            </div>
        <asp:GridView ID="gvReruns" runat="server" AutoGenerateColumns="False" CssClass="newStyle1 auto-style1" DataKeyNames="AutoID" DataSourceID="sdsReruns" Width="1750px" CaptionAlign="Left">
            <Columns>                
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                <ItemStyle HorizontalAlign="Center" Font-Bold="True" />
                </asp:BoundField>
                <asp:BoundField DataField="AutoID" HeaderText="R/R ID">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="OuterSections" HeaderText="Outer Sections" SortExpression="OuterSections" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="CenterSections" HeaderText="Center Sections" SortExpression="CenterSections" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/><br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label><br />                        
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                 <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="Custom">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                <asp:TemplateField HeaderText="Sheet Size">
                    <ItemTemplate>
                         <asp:GridView ID="gvFabOptionsRRRoller" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsPopReportingFabOptions" CssClass="newStyle3">
                                 <Columns>
                                     <asp:BoundField DataField="TubePartDesc" HeaderText="Fab Options" SortExpression="TubePartDesc" ShowHeader="False" >
                                     <ControlStyle BorderStyle="None" />
                                     <FooterStyle BorderStyle="None" />
                                     <HeaderStyle BorderStyle="None" Height="10px" />
                                     <ItemStyle BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Middle" />
                                     </asp:BoundField>
                                     <asp:BoundField DataField="Qty" DataFormatString=" - Qty: {0}" />
                                 </Columns>                                 
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsPopReportingFabOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [TubePartNo], [TubePartDesc], [Qty] FROM [BML_POPREPORTINGTUBEROLLER] WHERE ([ProdNo] = @ProdNo) ORDER BY [TubePartDesc]">
                                 <SelectParameters>
                                     <asp:Parameter Name="ProdNo" Type="String" />
                                     <asp:Parameter DefaultValue="Roller" Name="Workcenter" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                
                <asp:BoundField DataField="Length" HeaderText="Tube Length">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="Tube" HeaderText="Tube" SortExpression="Tube" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                 <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerP" runat="server"  Enabled =' <%# Eval("RollerPStatus") >= 1%>'  Visible=' <%# Eval("Tube") = "PORT" AndAlso Eval("OuterRoller").ToString() Like "Green*"%>' ImageUrl='<%# Eval("RollerPStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateP" ToolTip="PORT" />                                           
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Starboard">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerS" runat="server"  Enabled =' <%# Eval("RollerSStatus") >= 1%>' Visible=' <%# Eval("Tube") = "STRB" AndAlso Eval("OuterRoller").ToString() Like "Green*"%>' ImageUrl='<%# Eval("RollerSStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateS" ToolTip="STRB" />                                           
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>            
                <asp:TemplateField HeaderText="Center">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerCtr" runat="server"  Enabled =' <%# Eval("RollerCStatus") >= 1%>' Visible=' <%#Eval("Tube") = "CTR" AndAlso (Eval("CentertubeNeeded") = 1 And Eval("Express") = 0) AndAlso Eval("CenterRoller").ToString() Like "Green*"%>' ImageUrl='<%# Eval("RollerCStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCtr" ToolTip="CENTER" />                                           
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>      
                <asp:TemplateField HeaderText="Express">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerExpress" runat="server"  Enabled =' <%# Eval("RollerCStatus") >= 1%>' Visible='<%# Eval("Tube") = "CTR" AndAlso Eval("Express") = 1 AndAlso Eval("CenterRoller").ToString() Like "Green*"%>' ImageUrl='<%# Eval("RollerCStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCtr" ToolTip="EXPRESS" />                                           
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>                
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsReruns" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [AutoID], [Tube], Tubes.ProdNo, OuterSections, CenterSections, ItemNo, CusName, SONo, DueDate, OuterRoller, Express, CenterRoller, RollerPStatus, RollerSStatus, RollerCStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, IsCustom, BML_POPREPORTING_TUBEPRIORITY.Length FROM [Tubes_DamageReported] Left Join Tubes on Tubes_DamageReported.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on Tubes_DamageReported.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo  LEFT JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo WHERE (([ActionRequired] = @ActionRequired) AND ([ReRolledStatus] = @ReRolledStatus) And ((Tube = 'STRB' or Tube = 'PORT') And OuterRoller = 'Green') or (Tube = 'CTR' AND CenterRoller = 'Green')) And ReplaceReqdFlag = 1 AND Replaced is Null ORDER BY [AutoID]">
            <SelectParameters>
                <asp:Parameter DefaultValue="REPLACE" Name="ActionRequired" Type="String" />
                <asp:Parameter DefaultValue="0" Name="ReRolledStatus" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
       
        <br />
        <asp:Label ID="Label10" runat="server" CssClass="newStyle4" Text="Daily Production"></asp:Label>
         
        <asp:GridView ID="gvRoller" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20" Width="1750px">
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
                        <asp:Image ID="Centertube" Visible=' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "../Images/{0}.png") %>'  runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:BoundField DataField="OuterSections" HeaderText="Outer Sections"><ItemStyle Font-Bold="True" HorizontalAlign="Center" /></asp:BoundField>
                 <asp:BoundField DataField="CenterSections" HeaderText="Center Sections"><ItemStyle Font-Bold="True" HorizontalAlign="Center" /></asp:BoundField>
                
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/><br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label><br />
                        <br /><asp:Label ID="Label8" runat="server" Text='<%# Eval("CenterRoller")%>' CssClass="newStyle5"></asp:Label><asp:Label ID="Label4" Visible='<%# Eval("CentertubeNeeded") = 1%>' runat="server" Text='<%# "C:" & Eval("CenterScheduled")%>' CssClass="newStyle5"></asp:Label><asp:Label ID="Label5" Visible='<%# Eval("CentertubeNeeded") = 1%>' runat="server" Text="" CssClass="newStyle5"></asp:Label>                       
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
               <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="../Images/Custom{0}.png" HeaderText="Custom">
                         <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:ImageField>
                <asp:TemplateField HeaderText="Sheet Size">
                         <ItemTemplate>
                             <asp:GridView ID="gvOverrides" runat="server" Gridlines="None" DataSourceID="sdsOverrides" showheader= "False" ForeColor="Red" AutoGenerateColumns="False" DataKeyNames="ProdNo">
                                 <Columns>
                                     <asp:BoundField DataField="Override" HeaderText="Override" SortExpression="Override" >
                                     <ItemStyle HorizontalAlign="Center" />
                                     </asp:BoundField>
                                 </Columns>
                             </asp:GridView>
                              <asp:SqlDataSource ID="sdsOverrides" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [Override], [Chines] FROM [BML_POPREPORTING_TUBEOVERRIDES] WHERE (([Roller] = @Roller) AND ([ProdNo] = @ProdNo))">
                                 <SelectParameters>
                                     <asp:Parameter Name="ProdNo" Type="String" />
                                     <asp:Parameter DefaultValue="1" Name="Roller" Type="Int32" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                             <asp:GridView ID="gvFabOptionsRoller" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataSourceID="sdsPopReportingFabOptions" CssClass="newStyle3">
                                 <Columns>
                                     <asp:BoundField DataField="TubePartDesc" HeaderText="Fab Options" SortExpression="TubePartDesc" ShowHeader="False" >
                                     <ControlStyle BorderStyle="None" />
                                     <FooterStyle BorderStyle="None" />
                                     <HeaderStyle BorderStyle="None" Height="10px" />
                                     <ItemStyle BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Middle" />
                                     </asp:BoundField>
                                     <asp:BoundField DataField="Qty" DataFormatString=" - Qty: {0}" />
                                 </Columns>                                 
                             </asp:GridView>
                             <asp:SqlDataSource ID="sdsPopReportingFabOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [TubePartDesc], [Qty] FROM [BML_POPREPORTING_CENTERTUBEROLLER] WHERE ([ProdNo] = @ProdNo) ORDER BY [TubePartDesc]">
                                 <SelectParameters>
                                     <asp:Parameter Name="ProdNo" Type="String" />
                                     <asp:Parameter DefaultValue="Roller" Name="Workcenter" Type="String" />
                                 </SelectParameters>
                             </asp:SqlDataSource>
                         </ItemTemplate>
                         <ItemStyle Font-Size="12pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                     </asp:TemplateField>
                <asp:BoundField HeaderText="Tube Length" DataField="Length" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerP" runat="server"  Enabled =' <%# Eval("RollerPStatus") >= 1%>'  Visible=' <%# Eval("OuterDue") = 1 AndAlso Eval("OuterRoller").ToString() like "Green*"%>' ImageUrl='<%# Eval("RollerPStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateP" ToolTip="PORT" />                                           
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Starboard">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerS" runat="server"  Enabled =' <%# Eval("RollerSStatus") >= 1%>' Visible=' <%# Eval("OuterDue") = 1 AndAlso Eval("OuterRoller").ToString() Like "Green*"%>' ImageUrl='<%# Eval("RollerSStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateS" ToolTip="STRB" />                                           
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Center">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerCtr" runat="server"  Enabled =' <%# Eval("RollerCStatus") >= 1%>' Visible=' <%# (Eval("CentertubeNeeded") = 1 And Eval("Express") = 0) AndAlso Eval("CenterRoller").ToString() Like "Green*"%>' ImageUrl='<%# Eval("RollerCStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCtr" ToolTip="CENTER" />                                           
                    </ItemTemplate>
                </asp:TemplateField>      
                <asp:TemplateField HeaderText="Express">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateRollerExpress" runat="server"  Enabled =' <%# Eval("RollerCStatus") >= 1%>' Visible=' <%# Eval("Express") = 1 AndAlso Eval("CenterRoller").ToString() Like "Green*"%>' ImageUrl='<%# Eval("RollerCStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCtr" ToolTip="EXPRESS" />                                           
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
                        <asp:ImageButton ID="btnWSNotes" runat="server" Visible='<%#Eval("NotesRoller") = 1%>' ImageUrl='<%# Eval("NotesRoller", "../Images/wsnotes{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotonotes"/>                 
                         </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
         <br />
        <asp:Label ID="Label11" runat="server" CssClass="newStyle4" Text="Customer Service"></asp:Label>
        <br />
         <asp:GridView ID="gvCSTubes" runat="server" AutoGenerateColumns="False" DataKeyNames="TubeID" DataSourceID="sdsCSTubes" CssClass="newStyle1" CaptionAlign="Left" CellPadding="1" CellSpacing="1" Width="1750px">
            <Columns>
                <asp:BoundField DataField="TubeID" HeaderText="CS Tube #" InsertVisible="False" ReadOnly="True" SortExpression="TubeID" >                
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="DLR/OE #">
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%#Eval("Dealer")%>'></asp:Label><br />
                        <asp:Label ID="Label8" runat="server" Text='<%#Eval("OENo")%>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>                             
                <asp:BoundField DataField="Model" HeaderText="Length" SortExpression="Model" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Tube">
                    <ItemTemplate>
                        <asp:Label ID="lblTube" runat="server" Text=""></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Bottom" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="ModelYear" HeaderText="Model Year" SortExpression="ModelYear" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="CenterSections" HeaderText="# Sections">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Center" HeaderText="Center" SortExpression="Center" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Storage" HeaderText="Storage" SortExpression="Storage" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="TenWide" HeaderText="10 Wide?" SortExpression="TenWide" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="DrawingNo" HeaderText="Drawing #" SortExpression="DrawingNo" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>

                <asp:BoundField DataField="Bracket" HeaderText="Brackets" SortExpression="Bracket" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                
                            
                <asp:BoundField DataField="Fuel" HeaderText="Fuel" SortExpression="Fuel" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="Strakes" HeaderText="Strakes" SortExpression="Strakes" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="TubeUpg" HeaderText="TubeUpg" SortExpression="TubeUpg" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Upsweep" HeaderText="Upsweep/Comments" SortExpression="Upsweep" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                
                <asp:TemplateField HeaderText ="Center">                    
                         <ItemTemplate>
                        <asp:ImageButton ID="btnUpdateCSCRoller" runat="server"  Enabled =' <%# Eval("RollerCStatus") >= 1%>'  Visible=' <%# Eval("Ctr") = 1%>' ImageUrl='<%# Eval("RollerCStatus", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoupdateCSCtr" />                                           
                    </ItemTemplate>                    
                         <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>                       
            </Columns>           
        </asp:GridView>
         <br />  
        <asp:SqlDataSource ID="sdsCSTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [CS_Tubes] WHERE Convert(date,CenterScheduled) &lt;= GETDATE() AND (([CenterRoller] = @CenterRoller) AND ([CenterScheduledFlag] = @CenterScheduledFlag)) AND (([RollerCStatus] = @RollerCStatus and Ctr = @Ctr)) ORDER BY [CenterScheduleOrder]">
            <SelectParameters>
                <asp:Parameter DefaultValue="Green" Name="CenterRoller" Type="String" />
                <asp:Parameter DefaultValue="1" Name="Ctr" Type="Int32" />                
                <asp:Parameter DefaultValue="1" Name="CenterScheduledFlag" Type="Int32" />
                <asp:Parameter DefaultValue="1" Name="RollerCStatus" Type="Int32" />                                
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.IsCustom, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus,Tubes.RollerSStatus, Tubes.RollerPStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRoller, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.RerunP, BML_POPREPORTING_GREENLIGHTS.RerunSB,BML_POPREPORTING_TUBEPRIORITY.Length,BML_POPREPORTING_GREENLIGHTS.Express,Tubes.RollerCStatus, OuterScheduled,CenterScheduled, CenterScheduleOrder, OuterScheduleOrder, OuterSections,CenterSections, OuterRoller, CenterRoller, Case When OuterScheduled <= GetDate() Then 1 Else 0 End as OuterDue, Case When CenterScheduled <= GetDate() Then 1 Else 0 End as CenterDue FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo INNER JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo LEFT JOIN TUBES ON BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join Tubes_DamageReported on BML_POPREPORTING.ProdNo = Tubes_DamageReported.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) And (ReplaceReqdFlag is Null or ReplaceReqdFlag = 0) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') AND ((BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 AND BML_POPREPORTING_GREENLIGHTS.CentertubeStatus &lt; 1 AND CenterScheduled <= GetDate() AND Tubes.RollerCStatus &lt;= @RollerStatus AND Tubes.CenterRoller = 'Green') OR (OuterScheduled <= GetDate() And BML_POPREPORTING_GREENLIGHTS.TubesStatus &lt; 1 AND Tubes.OuterRoller = 'Green' AND (Tubes.RollerSStatus &lt;= @RollerStatus OR Tubes.RollerPStatus &lt;= @RollerStatus))) ORDER BY Tubes.CenterScheduled, Tubes.CenterScheduleOrder">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                 <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />                  
                 <asp:ControlParameter ControlID="ddlShowSelect" Name="RollerStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="2" />
                  <asp:ControlParameter ControlID="hdnStatus" Name="TubesStatus" Type="Int32" DefaultValue="2" />
                 <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />                  
            </SelectParameters>
        </asp:SqlDataSource>               
    </form>
</body>
</html>