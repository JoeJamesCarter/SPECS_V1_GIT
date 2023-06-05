<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Loading.aspx.vb" Inherits="Loading" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>LOADS</title>
    <link href="StyleSheet.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">LOADS</span><br />
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="showhide" runat="server" AutoPostBack="True">
                            <asp:ListItem Value="1">Show All</asp:ListItem>
                            <asp:ListItem Value="0">Show Hidden</asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>          
            </div>
            <asp:GridView ID="gvAllFieldsF" runat="server" AutoGenerateColumns="False" DataSourceID="sdsLoads" Height="177px" CellPadding="4" BorderColor="Black" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black">
                <Columns>
                    <asp:BoundField DataField="Planned" HeaderText="Load Date/#" >
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    
                    <asp:TemplateField Visible="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton2" runat="server" CommandArgument='<%# Eval("Planned")%>' CommandName="ship" ImageUrl="./Images/ship.png" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                    
                    <asp:TemplateField Visible="False">
                        <ItemTemplate>
                            Date:
                            <asp:TextBox ID="tbActualShipDate" runat="server" Height="16px" Width="66px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:BoundField DataField="LoadDateEst" HeaderText="LoadDateEst" SortExpression="LoadDateEst" Visible="False" />                   
                    <asp:TemplateField HeaderText="Green Lights">
                        <ItemTemplate>
                            <asp:GridView ID="gvLoadInfo" runat="server" AutoGenerateColumns="False" ShowHeader="False" DataSourceID="sdsLoadInfo" DataKeyNames="ProdNo" OnRowDataBound="gvLoadInfo_RowDataBound" BorderColor="Blue" BorderStyle="Solid" BorderWidth="3px" HorizontalAlign="Left" OnRowCommand="gvLoadInfo_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="ProdNo" HeaderText="ProdNo" ReadOnly="True" SortExpression="ProdNo" />
                                    <asp:TemplateField HeaderText="Boat/Customer">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text='<%# Eval("ItemNo") %>'></asp:Label>
                            <br />
                            <asp:Label ID="Label3" runat="server" CssClass="newStyle5" Text='<%# Eval("CusName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="200px" />
                    </asp:TemplateField>
                                    <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="F">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="FG">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="C">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="R">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="T">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:ImageField>
                                    <asp:TemplateField HeaderText="CT">                                       
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%#Eval("CentertubeStatus", "./Images/{0}.png")%>' Visible='<%#Eval("CentertubeNeeded")%>'/>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="15px" />
                                    </asp:TemplateField>
                                    <asp:ImageField DataImageUrlField="FramesInstalledStatus" DataImageUrlFormatString="./Images/Loads{0}.png">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="FloorsInstalledStatus" DataImageUrlFormatString="./Images/Loads{0}.png">
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="RailsInstalledStatus" DataImageUrlFormatString="./Images/Loads{0}.png">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px"/>
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="FurnitureInstalledStatus" DataImageUrlFormatString="./Images/Loads{0}.png">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="HelmInstalledStatus" DataImageUrlFormatString="./Images/Loads{0}.png">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px"/>
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="CleaningStatus" DataImageUrlFormatString="./Images/Loads{0}.png">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="FinalInspectionStatus" DataImageUrlFormatString="./Images/Loads{0}.png">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    </asp:ImageField>
                                    <asp:ImageField DataImageUrlField="ShrinkwrapStatus" DataImageUrlFormatString="./Images/Loads{0}.png">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px"/>
                                    </asp:ImageField>
                                    <asp:TemplateField>                                       
                                        <ItemTemplate>
                                            <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("WavetamerStatus", "./Images/Loads{0}.png") %>' Visible='<%#Eval("WavetamerNeeded")%>' />                                                                                       
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>                                        
                                        <ItemTemplate>
                                            <asp:Image ID="Image3" runat="server" ImageUrl='<%# Eval("SharkhideStatus", "./Images/Loads{0}.png") %>' Visible='<%#Eval("SharkhideNeeded")%>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>                                        
                                        <ItemTemplate>
                                            <asp:ImageButton ID="Image4" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "./Images/loadsoffline{0}.png") %>' Visible='<%#Eval("IsBoatOffline")= 1%>' CommandArgument='<%# Eval("ProdNo")%>'  CommandName="gotooffline" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    </asp:TemplateField>                                    
                                    <asp:ImageField DataImageUrlField="CompleteStatus" DataImageUrlFormatString="./Images/complete{0}.png">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    </asp:ImageField>
                                    <asp:TemplateField HeaderText="Red Tag">
                                 <ItemTemplate>         
                                     <asp:ImageButton ID="btnRedTag" runat="server" ImageUrl='<%# Eval("IsRedTagged", "Images/tag{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" Enabled="False" />
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:FormView ID="FormView1" runat="server" DataSourceID="sdsBoatLoadDate">
                                               <ItemTemplate>
                                                    Loaded:
                                                    <asp:Label ID="BoatLoaded" runat="server" Text='<%# Bind("BoatDateLoaded","{0:d}") %>' />
                                                    &nbsp;<br /> Trailer #:
                                                    <asp:Label ID="Trailer_NoLabel" runat="server" Text='<%# Bind("Trailer_No") %>' />
                                                    <br />
                                                </ItemTemplate>
                                            </asp:FormView>
                                            <asp:SqlDataSource ID="sdsBoatLoadDate" runat="server" ConnectionString="<%$ ConnectionStrings:BML_dataConnectionStringSQLCLUSTER %>" SelectCommand="SELECT [BoatDateLoaded], [Trailer_No] FROM [BML_SERIALSLOADED] WHERE ([Prod_no] = @Prod_no)">
                                                <SelectParameters>
                                                    <asp:Parameter Name="Prod_no" Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            &nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                   <asp:ImageField DataImageUrlField="IsInvoiced" DataImageUrlFormatString="./Images/invoiced{0}.png">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    </asp:ImageField>  
                                    
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:SqlDataSource ID="sdsBoatNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT distinct(BML_POPREPORTING_NOTES.Note),BML_POPREPORTING_NOTES.Date FROM [BML_POPREPORTING_NOTES] WHERE ([ProdNo] = @ProdNo)">
                                                <SelectParameters>
                                                    <asp:Parameter Name="ProdNo" Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:GridView ID="gvBoatNotes" runat="server" ShowHeader="False" DataSourceID="sdsBoatNotes" AutoGenerateColumns="False">
                                                <Columns>                                                    
                                                    <asp:BoundField DataField="Note" />
                                                    <asp:BoundField DataField="Date" DataFormatString="{0:d}" />
                                                </Columns>
                                            </asp:GridView>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsLoadInfo" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.IsRedTagged,BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_LOADINFO.ProdNo, BML_POPREPORTING_LOADINFO.Planned, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerNeeded, BML_POPREPORTING_GREENLIGHTS.SharkhideNeeded, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.CusName, BML_POPREPORTING_LOADINFO.Planned, BML_POPREPORTING_GREENLIGHTS.IsInvoiced FROM (BML_POPREPORTING_GREENLIGHTS INNER JOIN BML_POPREPORTING_LOADINFO ON BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_LOADINFO.ProdNo) WHERE (BML_POPREPORTING_LOADINFO.Planned = @Planned)">
                                <SelectParameters>
                                    <asp:Parameter Name="Planned" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle VerticalAlign="Top" BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsLoads" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT distinct (BML_POPREPORTING_LOADINFO.Planned),cast(BML_POPREPORTING_LOADINFO.LoadDateEst as datetime),BML_POPREPORTING_LOADINFO.LoadNo * 1 FROM  BML_POPREPORTING_GREENLIGHTS INNER JOIN BML_POPREPORTING_LOADINFO ON BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_LOADINFO.ProdNo Where BML_POPREPORTING_LoadInfo.Planned Not Like '//-' AND BML_POPREPORTING_LoadInfo.ProdNo IN(SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo FROM BML_POPREPORTING_GREENLIGHTS WHERE BML_POPREPORTING_GREENLIGHTS.IsInvoiced ='0' ) ORDER BY cast(BML_POPREPORTING_LOADINFO.LoadDateEst as datetime), BML_POPREPORTING_LOADINFO.LoadNo * 1">
            
            </asp:SqlDataSource>

    </form>
</body>
</html>