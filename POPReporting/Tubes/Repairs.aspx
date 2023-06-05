<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Repairs.aspx.vb" Inherits="Tubes_Repairs" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tube Repairs</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <meta content="width=device-width, initial-scale=1" name="viewport" />
</head>
<body>
    <form id="form1" runat="server">
    <div>   
          <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">TUBE REPAIRS</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                       <!-- #include file ="../Workstations/wstoolsbar.aspx" -->
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
    
            </div>
        <br/>
        <div id="viewport">
            <asp:GridView ID="gvTubeRepairs" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataSourceID="sdsTubeRepairs" DataKeyNames="AutoID" Width="1000px">
                <Columns>                    
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText ="Boat Details">
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label><asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/><br />                            
                            <asp:Label ID="Label10" runat="server" Text='<%#Eval("CusName")%>'></asp:Label><br />
                            <asp:Label ID="Label7" runat="server" Text="Boat Status: "></asp:Label><asp:Label ID="Label6" runat="server" Text='<%#Eval("CurrentStatus")%>'></asp:Label><br />
                            <asp:Label ID="Label9" runat="server" Text="Due: "></asp:Label><asp:Label ID="Label8" runat="server" Text='<%#Eval("DueDate","{0:M/d}") %>'></asp:Label>&nbsp;&nbsp;
                            <asp:Label ID="Label11" runat="server" Text="Loading: "></asp:Label><asp:Label ID="Label12" runat="server" Text='<%#Eval("ActualLoadDate","{0:M/d}") %>'></asp:Label><br />
                            <asp:Label ID="Label13" runat="server" Text="Rack Loc: "></asp:Label><asp:Label ID="Label14" runat="server" Text='<%#Eval("SlotKey")%>' Visible='<%#IIf(Eval("Filled").ToString = "1", True, False)%>'></asp:Label><br />                             
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Tube">
                        <ItemTemplate>
                            <asp:Label ID="Label15" runat="server" Text='<%#Eval("Tube")%>'></asp:Label><br />
                            <asp:LinkButton ID="lnkbtnCantFix" runat="server" OnClientClick="if(!confirm('Are you sure you want to mark this tube as needing replaced?')) return false;" CommandArgument='<%# Container.DataItemIndex & ";" & Eval("AutoID") & ";" & Eval("ProdNo") & ";" & Eval("ItemNo") & ";" & Eval("Tube")%>' CommandName="gotoreplace">Can't Be Fixed?</asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>                    
                    <asp:BoundField DataField="AutoID" HeaderText="Tube ID #" SortExpression="AutoID" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText ="Damage Description">
                        <ItemTemplate>
                            <strong><asp:Label ID="Label16" runat="server" Text='<%#Eval("PortDmgDesc")%>'></asp:Label>
                            <asp:Label ID="Label17" runat="server" Text='<%#Eval("StrbDmgDesc")%>'></asp:Label>
                            <asp:Label ID="Label18" runat="server" Text='<%#Eval("CtrDmgDesc")%>'></asp:Label></strong>                           
                           <br /></strong>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ReportedBy")%>'></asp:Label><br />
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("DateReported","{0:M/d hh:mm}")%>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField> 
                    <asp:TemplateField HeaderText ="Evaluated By">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("EvaluatedBy")%>'></asp:Label><br />
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("DateEvaluated","{0:M/d hh:mm}")%>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>                                                                
                    <asp:BoundField DataField="Repaired" HeaderText=" Date Repaired" SortExpression="Repaired" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="btnUpdateRepaired" runat="server"  Enabled =' <%# Eval("RepairedFlag") >= 0%>' ImageUrl='<%# Eval("RepairedFlag", "../Images/repaired{0}.png")%>' CommandArgument='<%# Container.DataItemIndex & ";" & Eval("AutoID") & ";" & Eval("ProdNo") & ";" & Eval("ItemNo") & ";" & Eval("Tube")%>' CommandName="gotoupdate"/>                                           
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>                    
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsTubeRepairs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Tubes_DamageReported.*, ItemNo, BuildLoc, SONo, BML_POPREPORTING_GREENLIGHTS.DueDate, Yard_Master_Locations.SlotKey, Filled, CusName, ActualLoadDate, Case When ActualLoadDate is NULL then '0' ELSE '1' End As ScheduledToLoad, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus FROM [Tubes_DamageReported] Left Join BML_POPREPORTING_GREENLIGHTS on Tubes_DamageReported.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Yard_Master_Locations On Tubes_DamageReported.ProdNo = Yard_Master_Locations.ProdNo Left Join Load_Scheduling on Tubes_DamageReported.ProdNo = Load_Scheduling.ProdNo WHERE ([RepairReqdFlag] = @RepairReqdFlag) And (RepairedFlag &lt; @RepairedFlag) AND (Tubes_DamageReported.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchBoat + '%') And ReportedBy <> 'tubes1' ORDER BY ScheduledToLoad desc, ActualLoadDate, CusName, DueDate, [DateEvaluated]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="RepairReqdFlag" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="RepairedFlag" PropertyName="SelectedValue" Type="Int32" DefaultValue="0" />
                    <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue = '%' Type="String" />
                    <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" /> 
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
