<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadScheduleBiminisWRcv.aspx.vb" Inherits="LoadScheduleBiminisWRcv" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
         <link href="StyleSheet.css" rel="stylesheet" />
    <title>BIMINI RECEIVING TO LOAD SCHEDULE </title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1050px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell Wrap="false">
                        <span class="newStyle7">BIMINI RECEIVING TO LOAD SCHEDULE</span><br />
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
                        <asp:GridView ID="gvDlrBoats" runat="server" DataSourceID="sdsDlrBoats" AutoGenerateColumns="False" Width="1014px" OnRowDataBound="gvDlrBoats_RowDataBound" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Both" style="text-align: center" OnRowCommand="gvDlrBoats_RowCommand" DataKeyNames="ProdNo">                           
                            <Columns>                              
                                <asp:BoundField DataField="CusName" HeaderText="Dealer" >
                                <ItemStyle Width="200px" />
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
                                <asp:ControlParameter ControlID="gvDlrBoats" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                                <asp:Parameter DefaultValue="Tops" Name="Workcenter" Type="String" />                                
                            </SelectParameters>
                        </asp:SqlDataSource>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
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
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>                                   
                                <asp:TemplateField HeaderText="Receiving">
                                    <ItemTemplate>
                                        <asp:Button ID="btnRcv" runat="server" Text="Receive" CommandArgument='<%# Eval("ProdNo")%>' CommandName ="receive"/>
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" />
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
                         <asp:SqlDataSource ID="sdsDlrBoats" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Load_Scheduling.LoadNo, Load_Scheduling.StopNo, Load_Scheduling.ProdNo,Load_Scheduling.ActualLoadDate,Load_Scheduling.Shipper,Load_Scheduling.Split, BML_POPREPORTING_GREENLIGHTS.CusName,BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.BiminiRcvdStatus, BML_POPREPORTING_GREENLIGHTS.BiminiStatus, BML_POPREPORTING_GREENLIGHTS.Bimini, BML_POPREPORTING_GREENLIGHTS.BiminiRcvd, BML_POPREPORTING_GREENLIGHTS.BuildLoc, Load_Scheduling.DateLoaded FROM Load_Scheduling Left Join BML_POPREPORTING_GREENLIGHTS on Load_Scheduling.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where Load_Scheduling.LoadNo = @loadno and ActualLoadDate = @selecteddate Order By Load_Scheduling.LoadNo, Load_Scheduling.StopNo">
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
        
    
    </div>
    </form>
</body>
</html>
