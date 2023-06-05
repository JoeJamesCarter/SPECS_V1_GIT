<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReportDamage.aspx.vb" Inherits="Tubes_ReportDamage" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report Tube Damage</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
        }
        .auto-style2 {}
        .auto-style3 {}
    </style>
     <script>
         window.onunload = function () {
             window.opener.document.getElementById('btnRefresh').click();

         }

     </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="newStyle1">

            <asp:Label ID="Label1" runat="server" Text="Report Tube Damage" CssClass="newStyle7"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="This request will be evaluated by a supervisor to determine if the tube needs repaired or replaced."></asp:Label>
            <br />
            <br />
            <asp:Table ID="Table1" runat="server" CssClass="auto-style1" Width="920px">
                <asp:TableRow>
                    <asp:TableCell Width="100px">
                        <asp:Label ID="Label3" runat="server" Text="Prod #:"></asp:Label><asp:Label ID="lblProdNo" runat="server" Text="Label" CssClass="newStyle6"></asp:Label>
                    </asp:TableCell>                    
                    <asp:TableCell><asp:Label ID="Label12" runat="server" Text="Model: "></asp:Label><asp:Label ID="lblModel" runat="server" Text="" CssClass="newStyle6"></asp:Label>                        
                    </asp:TableCell>
                    <asp:TableCell>

                    </asp:TableCell>                    
                </asp:TableRow>
                <asp:TableRow Height="20px">
                    <asp:TableCell>                    
                    
                        </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>                   
                    <asp:TableCell>
                        <asp:Label ID="Label4" runat="server" Text="Which Tubes?"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:CheckBoxList ID="cbTubes" runat="server" CssClass="newStyle6" RepeatDirection="Horizontal" Width="200px" AutoPostBack="True">
                            <asp:ListItem>Port</asp:ListItem>
                            <asp:ListItem>Strb</asp:ListItem>
                            <asp:ListItem>Ctr</asp:ListItem>
                        </asp:CheckBoxList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="400px">
                        <asp:Label ID="Label5" runat="server" Text="Port Damage Description"></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="tbPortDamage" runat="server" TextMode="MultiLine" Width="300px"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell Width="250px"><asp:Label ID="Label9" runat="server" Text="I think it: "></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="ddlPortPrediction" runat="server">
                            <asp:ListItem></asp:ListItem>                            
                            <asp:ListItem Text="Can Be Repaired" Value="REPAIR"></asp:ListItem>
                            <asp:ListItem Text="Needs Replaced" Value="REPLACE"></asp:ListItem>
                            <asp:ListItem Text="I Don't Know" Value="Unknown"></asp:ListItem>
                        </asp:DropDownList></asp:TableCell>
                      <asp:TableCell Width="300px">                        
                        <asp:Label ID="lblPScrap" Width="100px" runat="server" Text="Is It Scrap?"></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="ddlPScrap" runat="server">
                            <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                            <asp:ListItem Text="YES" Value="1"></asp:ListItem>
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="400px">
                        <asp:Label ID="Label6" runat="server" Text="Strb Damage Description"></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="tbStrbDamage" runat="server" TextMode="MultiLine" Width="300px"></asp:TextBox></asp:TableCell>
                     <asp:TableCell Width="100px"><asp:Label ID="Label10" runat="server" Text="I think it: "></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="ddlStrbPrediction" runat="server">
                            <asp:ListItem></asp:ListItem>                            
                            <asp:ListItem Text="Can Be Repaired" Value="REPAIR"></asp:ListItem>
                            <asp:ListItem Text="Needs Replaced" Value="REPLACE"></asp:ListItem>
                            <asp:ListItem Text="I Don't Know" Value="Unknown"></asp:ListItem>
                        </asp:DropDownList></asp:TableCell>
                     <asp:TableCell Width="300px">                        
                        <asp:Label ID="lblSScrap" Width="100px" runat="server" Text="Is It Scrap?"></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="ddlSScrap" runat="server">
                            <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                            <asp:ListItem Text="YES" Value="1"></asp:ListItem>
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="1000px">
                        <asp:Label ID="Label7" runat="server" Text="Center Damage Description"></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="tbCenterDamage" runat="server" TextMode="MultiLine" Width="300px"></asp:TextBox></asp:TableCell>
                     <asp:TableCell Width="100px"><asp:Label ID="Label11" runat="server" Text="I think it: "></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="ddlCenterPrediction" runat="server">
                            <asp:ListItem></asp:ListItem>                            
                            <asp:ListItem Text="Can Be Repaired" Value="REPAIR"></asp:ListItem>
                            <asp:ListItem Text="Needs Replaced" Value="REPLACE"></asp:ListItem>
                            <asp:ListItem Text="I Don't Know" Value="Unknown"></asp:ListItem>
                        </asp:DropDownList></asp:TableCell>
                     <asp:TableCell Width="300px">                        
                        <asp:Label ID="lblCScrap" Width="100px" runat="server" Text="Is It Scrap?"></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="ddlCScrap" runat="server">
                            <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                            <asp:ListItem Text="YES" Value="1"></asp:ListItem>
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>

                <asp:TableRow>                    
                    <asp:TableCell>                        
                        <asp:Label ID="Label8" runat="server" Text="Reported By:*"></asp:Label></asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="tbReportedBy" runat="server" ReadOnly="False"></asp:TextBox>*
                    </asp:TableCell>
                </asp:TableRow>
               
            </asp:Table>
            <br />
            <asp:Button ID="btnSubmit" runat="server" CssClass="newStyle6" Text="Submit for Tube Evaluation" Width="283px" /><br /><br /><br />
            <asp:GridView ID="gvBoatData" runat="server" DataSourceID="sdsBoatData" AutoGenerateColumns="False" CssClass="auto-style2" Width="780px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" Caption="Boat Detail" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:TemplateField HeaderText="Building">                       
                        <ItemTemplate>
                            <asp:Label ID="lblBuildLoc" runat="server" Text='<%# Bind("BuildLoc") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="CurrentStatus" HeaderText="Current Status" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Rack Location" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CusName" HeaderText="Dealer" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DueDate" DataFormatString="{0:d}" HeaderText="Due" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ActualLoadDate" DataFormatString="{0:d}" HeaderText="Planned to Load" >
                    <ItemStyle HorizontalAlign="Center" />
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
                <asp:SqlDataSource ID="sdsBoatData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BuildLoc, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus, Yard_Master_Locations.SlotKey, Filled, CusName, DueDate, ActualLoadDate FROM BML_POPREPORTING_GREENLIGHTS left join Yard_Master_Locations On BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Where BML_POPREPORTING_GREENLIGHTS.ProdNo = @ProdNo">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" Type="String" /> 
                            </SelectParameters>
                        </asp:SqlDataSource>
            <br />
            <asp:GridView ID="gvTubeDamageHistory" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTubeDamageHistory" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" Caption="Tube Damage Reported" CellPadding="3" CssClass="auto-style3" ForeColor="Black" GridLines="Vertical" Width="100%">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>                  
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" />
                    <asp:BoundField DataField="Tube" HeaderText="Tube" SortExpression="Tube" />
                   
                    <asp:TemplateField HeaderText ="Predicted Action">
                        <ItemTemplate>
                            <asp:Label ID="Label13" runat="server" Text='<%#Eval("PortPredictedAction")%>'></asp:Label>
                            <asp:Label ID="Label14" runat="server" Text='<%#Eval("StrbPredictedAction")%>'></asp:Label>
                            <asp:Label ID="Label15" runat="server" Text='<%#Eval("CtrPredictedAction")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Damage Desc">
                        <ItemTemplate>
                            <asp:Label ID="Label13" runat="server" Text='<%#Eval("PortDmgDesc")%>'></asp:Label>
                            <asp:Label ID="Label14" runat="server" Text='<%#Eval("StrbDmgDesc")%>'></asp:Label>
                            <asp:Label ID="Label15" runat="server" Text='<%#Eval("CtrDmgDesc")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>                  
                    <asp:BoundField DataField="ReportedBy" HeaderText="Reported By" SortExpression="ReportedBy" />
                    <asp:BoundField DataField="DateReported" HeaderText="Date Reported" SortExpression="DateReported" />
                    <asp:BoundField DataField="EvaluatedBy" HeaderText="Evaluated By" SortExpression="EvaluatedBy" />
                    <asp:BoundField DataField="DateEvaluated" HeaderText="Date Evaluated" SortExpression="DateEvaluated" />
                    <asp:BoundField DataField="ActionRequired" HeaderText="Action Required" SortExpression="ActionRequired" />                   
                    <asp:BoundField DataField="Repaired" HeaderText="Repaired" SortExpression="Repaired" />                    
                    <asp:BoundField DataField="Replaced" HeaderText="Replaced" SortExpression="Replaced" />
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
            <asp:SqlDataSource ID="sdsTubeDamageHistory" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Tubes_DamageReported] WHERE ([ProdNo] = @ProdNo) ORDER BY [DateReported]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:HiddenField ID="hdnBuildLoc" runat="server" />
            <asp:HiddenField ID="hdnRackLocation" runat="server" />
            <asp:HiddenField ID="hdnCurrentStatus" runat="server" />
            <asp:HiddenField ID="hdnDueDate" runat="server" />
            <asp:HiddenField ID="hdnLoadDate" runat="server" />
            <asp:HiddenField ID="hdnFilled" runat="server" />
        </div>
    </form>
</body>
</html>
