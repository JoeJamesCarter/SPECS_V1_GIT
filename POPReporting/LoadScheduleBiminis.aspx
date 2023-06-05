<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadScheduleBiminis.aspx.vb" Inherits="LoadScheduleBiminis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
         <link href="StyleSheet.css" rel="stylesheet" />
    <title>BIMINI LOAD SCHEDULE</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">BIMINI LOAD SCHEDULE</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:table id="Table1" runat="server" cssclass="auto-style1" width="966px" gridlines="None">
                            <asp:TableRow runat="server">
                                <asp:TableCell runat="server" HorizontalAlign="center">
                                    <asp:Label ID="lblLoadsScheduled" runat="server" CssClass="newStyle4" Text=""></asp:Label><span class="newStyle3"><span class="newStyle3">&nbsp;# Loads Scheduled For Selected Day</span>
                                </asp:TableCell>
                                <asp:TableCell runat="server"><span class="newStyle3"></span>
                                     <asp:Button ID="btnPrint" runat="server" Text="Printable Version" />
                                </asp:TableCell>
            <asp:TableCell>
               
              </asp:TableCell>
            <asp:TableCell rowspan="2">
             <asp:Image runat="server" img src="Images/logo-small.png" /></asp:Image>
              </asp:TableCell>                                       
        </asp:TableRow>
        <asp:TableRow>
            </asp:TableRow>
        
       
        </asp:table>

                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle3"><asp:Label ID="Label1" runat="server" Text="Load Date:"></asp:Label><asp:Label ID="lblDateSet" runat="server" Text=""></asp:Label></span><asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
                    </asp:TableCell>
                    <asp:TableCell>                       
                        
                        
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table> 
        <br />
        <asp:GridView ID="gvBoatsScheduled" CssClass="newStyle1"  runat="server" DataSourceID="sdsBoatsScheduledForLoads" AutoGenerateColumns="False" CellPadding="5" DataKeyNames="loadno">
            <Columns>
                 <asp:BoundField DataField="LoadNo" HeaderText="Load #" />
                <asp:BoundField DataField="LoadPriority" HeaderText="Load Priority" />
                <asp:TemplateField HeaderText="Planned Boats">
                    <ItemTemplate>
                        <asp:GridView ID="gvDlrBoats" runat="server" DataSourceID="sdsDlrBoats" AutoGenerateColumns="False" Width="1672px" OnRowDataBound="gvDlrBoats_RowDataBound" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Both" OnRowCommand="gvDlrBoats_RowCommand">                           
                            <Columns>                              
                                <asp:BoundField DataField="CusName" HeaderText="Dealer" >
                                <ItemStyle Width="300px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" >
                                <ItemStyle Width="50px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ItemNo" HeaderText="Boat" >                                
                                <ItemStyle Width="150px" />
                                </asp:BoundField>
                                     <asp:BoundField DataField="BuildLoc" HeaderText="Building" >                                
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                </asp:BoundField>
                                 <asp:TemplateField HeaderText="Built?">
                    <ItemTemplate>
                        <asp:Image ID="BimBuilt" ImageUrl='<%# Eval("BiminiStatus", "./Images/gates{0}.png")%>'  runat="server" ToolTip='<%# Eval("Bimini")%>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>    
                                <asp:TemplateField HeaderText="Rcvd?">
                    <ItemTemplate>
                        <asp:Image ID="BimRcvd" ImageUrl='<%# Eval("BiminiRcvdStatus", "./Images/{0}.png")%>'  runat="server" ToolTip='<%# Eval("BiminiRcvd")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="200px" />
                </asp:TemplateField>
                                 <asp:BoundField DataField="BiminiRcvd" HeaderText="Rcvd" >
                                <ItemStyle Width="175px" />
                                </asp:BoundField>                                                    
                                 <asp:TemplateField HeaderText="Std Top">
                    <ItemTemplate>                        
                        <asp:GridView ID="gvStdTop" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsStdTopM">
                            <Columns>
                                <asp:BoundField DataField="StdTop" HeaderText="Option_Desc" SortExpression="StdTop" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsStdTopM" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [StdTop] FROM [Standard_Tops] WHERE (Standard_Tops.ItemNo) = @ItemNo">
                            <SelectParameters>
                            <asp:Parameter Name="ItemNo" Type="String"/>                                          
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Options">
                        <ItemTemplate>
                             <asp:GridView ID="gvBiminiOptions" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsBiminisM">
                            <Columns>
                                <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsFabOptionsBiminisM" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter))">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                <asp:Parameter DefaultValue="Tops" Name="Workcenter" Type="String" />                                
                            </SelectParameters>
                        </asp:SqlDataSource>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="300px" />
                    </asp:TemplateField>
                                <asp:TemplateField HeaderText="Print Labels">
                                    <ItemTemplate>
                                    <asp:ImageButton ID="ImageButton2" ImageUrl='Images/printlabel.png'  runat="server" CommandArgument='<%# Eval("ProdNo") & ";" & Eval("ItemNo") & ";" & Eval("CusName") & ";" & Eval("SerialNo")  & ";" & Eval("Blackout")%>' CommandName ="gotobiminilabel"/>
                                        </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
                         <asp:SqlDataSource ID="sdsDlrBoats" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Load_Scheduling.LoadNo, Load_Scheduling.StopNo, Load_Scheduling.ProdNo,Load_Scheduling.ActualLoadDate,Load_Scheduling.Shipper,Load_Scheduling.Split, BML_POPREPORTING_GREENLIGHTS.CusName,BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.BiminiRcvdStatus, BML_POPREPORTING_GREENLIGHTS.BiminiStatus, BML_POPREPORTING_GREENLIGHTS.Bimini, BML_POPREPORTING_GREENLIGHTS.BiminiRcvd, BML_POPREPORTING_GREENLIGHTS.BuildLoc, Load_Scheduling.DateLoaded, SerialNo, Rails_Tracking.Blackout FROM Load_Scheduling Left Join BML_POPREPORTING_GREENLIGHTS on Load_Scheduling.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo LEFT JOIN ProdToSerialMatrix on BML_POPREPORTING_GREENLIGHTS.ProdNo = ProdToSerialMatrix.ProdNo LEFT JOIN RAILS_TRACKING on BML_POPREPORTING_GREENLIGHTS.PRODNO = RAILS_TRACKING.ProdNo Where Load_Scheduling.LoadNo = @loadno and ActualLoadDate = @selecteddate Order By Load_Scheduling.LoadNo, Load_Scheduling.StopNo">
                <SelectParameters>                                                                                       
                     <asp:Parameter Name="loadno" DefaultValue="" Type="String" />
                    <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />                   
                </SelectParameters>
        </asp:SqlDataSource>

                    </ItemTemplate>
                </asp:TemplateField>                      
               
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsBoatsScheduledForLoads" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct Load_Scheduling.LoadNo, Load_Scheduling.LoadPriority FROM Load_Scheduling Where Load_Scheduling.ActualLoadDate = @selecteddate Order By Load_Scheduling.LoadPriority,Load_Scheduling.LoadNo ">
                <SelectParameters> 
                     <asp:ControlParameter ControlID="Calendar1" Name="selecteddate" PropertyName="SelectedDate" DbType="String" />                                                                                                                 
                </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <span class="newStyle4"><asp:Label ID="Label3" runat="server" Text="South Decks Outside and South WIP w/Bimini's Not Received"></asp:Label></span>
         <br />
          <asp:GridView ID="gvRails" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                <ItemStyle Font-Bold="True" />
                </asp:BoundField>
                 <asp:ImageField DataImageUrlField="IsCustom" DataImageUrlFormatString="./Images/Custom{0}.png" HeaderText="Custom">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>                
                  <asp:ImageField DataImageUrlField="BiminiRcvdStatus" DataImageUrlFormatString="./Images/gates{0}.png" HeaderText="BIM Rcvd?" ItemStyle-HorizontalAlign="Center">                
                </asp:ImageField>                                        
                <asp:TemplateField HeaderText="Boat/Customer">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>' CssClass="newStyle5"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Std Top">
                    <ItemTemplate>                        
                        <asp:GridView ID="gvStdTop" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsStdTop">
                            <Columns>
                                <asp:BoundField DataField="StdTop" HeaderText="Option_Desc" SortExpression="StdTop" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsStdTop" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [StdTop] FROM [Standard_Tops] WHERE (Standard_Tops.ItemNo) = @ItemNo">
                            <SelectParameters>
                            <asp:Parameter Name="ItemNo" Type="String"/>                                          
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Options">
                        <ItemTemplate>
                             <asp:GridView ID="gvBiminiOptions" runat="server" gridlines= "None" showheader="False" AutoGenerateColumns="False" DataSourceID="sdsFabOptionsBiminis">
                            <Columns>
                                <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc" ShowHeader="False" >
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsFabOptionsBiminis" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter))">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gvRails" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                <asp:Parameter DefaultValue="Tops" Name="Workcenter" Type="String" />                                
                            </SelectParameters>
                        </asp:SqlDataSource>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
               <asp:TemplateField HeaderText="Comments" Visible="False">
                    <ItemTemplate>
                        <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" DataSourceID="sdsMacola" ShowHeader="false">
                            <Columns>
                                <asp:BoundField DataField="cmt" HeaderText="cmt" SortExpression="cmt" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsMacola" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [cmt] FROM [OELINCMT_SQL] WHERE ([ord_no] = @ord_no)">
                            <SelectParameters>
                                <asp:Parameter Name="ord_no" Type="String"/>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>            
                <asp:TemplateField HeaderText="Print Labels">
                                    <ItemTemplate>
                                    <asp:ImageButton ID="ImageButton2" ImageUrl='Images/printlabel.png'  runat="server" CommandArgument='<%# Eval("ProdNo") & ";" & Eval("ItemNo") & ";" & Eval("CusName") & ";" & Eval("SerialNo")  & ";" & Eval("Blackout")%>' CommandName ="gotobiminilabel"/>
                                        </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.SONo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.NotesRails, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CenterTubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded, BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus,cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus,(CASE WHEN cast(Rails_Tracking.PF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.PF_Received as varchar) END) + (CASE WHEN cast(Rails_Tracking.SF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.SF_Received as varchar) END) as QFrontRailsStatus, BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus, BML_POPREPORTING_GREENLIGHTS.BiminiRcvdStatus, BML_POPREPORTING_GREENLIGHTS.BiminiStatus, BML_POPREPORTING_GREENLIGHTS.Bimini, BML_POPREPORTING_GREENLIGHTS.BiminiRcvd, SerialNo, Rails_Tracking.Blackout FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo LEFT JOIN ProdToSerialMatrix on BML_POPREPORTING_GREENLIGHTS.ProdNo = ProdToSerialMatrix.ProdNo LEFT JOIN RAILS_TRACKING on BML_POPREPORTING.PRODNO = RAILS_TRACKING.ProdNo WHERE(BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus = 2) AND (BML_POPREPORTING_GREENLIGHTS.BiminiRcvdStatus < 2) AND (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo Not Like'%A%' or (BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus = 4 or BML_POPREPORTING_GREENLIGHTS.ItemNo Like '%APG%')) ORDER BY Convert(integer,BML_POPREPORTING.ProdNo)">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />               
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
