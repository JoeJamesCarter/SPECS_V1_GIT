<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EvaluateDamage.aspx.vb" Inherits="Tubes_EvaluateDamage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Evaluate Reported Tube Damage</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <meta content="width=device-width, initial-scale=1" name="viewport" />
   
</head>
<body class="newStyle1">
    <form id="form1" runat="server">
           <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                <ContentTemplate>

                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="60000" OnTick="Timer1_Tick"></asp:Timer>
    <div id="viewport">
        <asp:GridView ID="gvTubeDamageEvals" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTubeDamageEvals" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" Caption="Tube Damage Reported" CellPadding="3" CssClass="auto-style3" ForeColor="Black" GridLines="Vertical" DataKeyNames="AutoID">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>                   
                    <asp:TemplateField HeaderText ="Prod # - Bldg">
                        <ItemTemplate>
                        <strong><asp:Label runat="server" Text='<%#Eval("ProdNo")%>' ID="lblProdNo"></asp:Label>-<asp:Label runat="server" Text='<%#Eval("BuildLoc")%>'></asp:Label></strong><br />                             
                            <strong><asp:Label ID="Label3" runat="server" Text="Due: "></asp:Label></strong><asp:Label runat="server" Text='<%#Eval("DueDate", "{0:M/d}")%>'></asp:Label><br />
                            <strong><asp:Label ID="Label4" runat="server" Text="To Load: "></asp:Label></strong><asp:Label runat="server" Text='<%#Eval("ActualLoadDate", "{0:M/d}")%>'></asp:Label><br />
                            <strong><asp:Label ID="Label6" runat="server" Text="Boat Status: "></asp:Label></strong><asp:Label runat="server" Text='<%#Eval("CurrentStatus")%>'></asp:Label><br />
                            <strong><asp:Label ID="Label5" runat="server" Text="Loc: "></asp:Label></strong><asp:Label runat="server" Text='<%#Eval("SlotKey")%>'></asp:Label>
                            </ItemTemplate>
                    </asp:TemplateField> 
                    <asp:TemplateField HeaderText ="Predicted Action">
                        <ItemTemplate>
                            <strong><asp:Label runat="server" Text='<%#Eval("ItemNo")%>'></asp:Label></strong><br />
                            <asp:Label ID="Label7" runat="server" Text='<%#Eval("Tube")%>'></asp:Label><br />
                            <asp:Label ID="Label13" runat="server" Text='<%#Eval("PortPredictedAction")%>'></asp:Label>
                            <asp:Label ID="Label14" runat="server" Text='<%#Eval("StrbPredictedAction")%>'></asp:Label>
                            <asp:Label ID="Label15" runat="server" Text='<%#Eval("CtrPredictedAction")%>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="90px" HorizontalAlign="Center" />
                    </asp:TemplateField>                                    
                    <asp:TemplateField HeaderText ="Reported">
                        <ItemTemplate>
                             <asp:Label ID="Label16" runat="server" Text='<%#Eval("PortDmgDesc")%>'></asp:Label>
                            <asp:Label ID="Label17" runat="server" Text='<%#Eval("StrbDmgDesc")%>'></asp:Label>
                            <asp:Label ID="Label18" runat="server" Text='<%#Eval("CtrDmgDesc")%>'></asp:Label>
                            <br />
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ReportedBy")%>'></asp:Label><br />
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("DateReported","{0:M/d hh:mm}")%>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="150px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Action Required">
                        <ItemTemplate>
                             <asp:ImageButton ID="btnUpdateShipAsIs" runat="server" ImageUrl='<%# Eval("ShipAsIsFlag", "../Images/noactionreqd{0}.png")%>' CommandArgument='<%# Container.DataItemIndex & ";" & Eval("AutoID") & ";" & Eval("ProdNo") & ";" & Eval("ItemNo") & ";" & Eval("Tube")%>' CommandName="gotoshipasis"/>
                             <asp:ImageButton ID="btnUpdateRepair" runat="server" ImageUrl='<%# Eval("RepairReqdFlag", "../Images/repair{0}.png")%>' CommandArgument='<%# Container.DataItemIndex & ";" & Eval("AutoID") & ";" & Eval("ProdNo") & ";" & Eval("ItemNo") & ";" & Eval("Tube")%>' CommandName="gotorepair"/>
                             <asp:ImageButton ID="btnUpdateReorder" runat="server" ImageUrl='<%# Eval("ReplaceReqdFlag", "../Images/reorder{0}.png")%>' CommandArgument='<%# Container.DataItemIndex & ";" & Eval("AutoID") & ";" & Eval("ProdNo") & ";" & Eval("ItemNo")  & ";" & Eval("Tube")%>' CommandName="gotoreorder"/>                             
                        </ItemTemplate>
                        <ItemStyle Width="350px" HorizontalAlign="Center" />
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
        <asp:SqlDataSource ID="sdsTubeDamageEvals" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Tubes_DamageReported.*,BuildLoc, ItemNo, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus, Yard_Master_Locations.SlotKey, Filled, CusName, DueDate, ActualLoadDate FROM [Tubes_DamageReported] left join BML_POPREPORTING_GREENLIGHTS on Tubes_DamageReported.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Yard_Master_Locations On Tubes_DamageReported.ProdNo = Yard_Master_Locations.ProdNo Left Join Load_Scheduling on Tubes_DamageReported.ProdNo = Load_Scheduling.ProdNo WHERE BML_POPREPORTING_GREENLIGHTS.ProdNo > 2100000 and ([DateEvaluated] IS NULL or (RepairReqdFlag = 0 and ReplaceReqdFlag = 0 and ShipAsIsFlag = 0)) ORDER BY [DateReported]"></asp:SqlDataSource>
        <br />
        <asp:GridView ID="gvTubeDamageHistory" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTubeDamageHistory" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" Caption="Tube Damage History Prod # > 2300000" CellPadding="3" CssClass="auto-style3" ForeColor="Black" GridLines="Vertical" AllowPaging="True">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>                                      
                   <asp:TemplateField>
                       <ItemTemplate>
                           <strong><asp:Label runat="server" Text='<%#Eval("ProdNo")%>'></asp:Label><br />
                               <asp:Label runat="server" Text='<%#Eval("Tube")%>'></asp:Label></strong><br />                             
                       </ItemTemplate>
                   </asp:TemplateField>                       
                     <asp:TemplateField HeaderText ="Reported">
                        <ItemTemplate>
                             <asp:Label ID="Label16" runat="server" Text='<%#Eval("PortDmgDesc")%>'></asp:Label>
                            <asp:Label ID="Label17" runat="server" Text='<%#Eval("StrbDmgDesc")%>'></asp:Label>
                            <asp:Label ID="Label18" runat="server" Text='<%#Eval("CtrDmgDesc")%>'></asp:Label>
                            <br />
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ReportedBy")%>'></asp:Label><br />
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("DateReported","{0:M/d hh:mm}")%>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="150px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Evaluated By">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%#Eval("EvaluatedBy")%>'></asp:Label><br />
                            <asp:Label runat="server" Text='<%#Eval("DateEvaluated")%>'></asp:Label><br />                            
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="150px" />
                    </asp:TemplateField>                  
                    <asp:BoundField DataField="ActionRequired" HeaderText="Action Required" SortExpression="ActionRequired" >                   
                    <ItemStyle HorizontalAlign="Center" Width="100px" />
                    </asp:BoundField>
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
        <asp:SqlDataSource ID="sdsTubeDamageHistory" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Tubes_DamageReported] WHERE ([DateEvaluated] IS NOT NULL) and ProdNo > 2300000 ORDER BY [DateReported]"></asp:SqlDataSource>
    </div>
                           
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
