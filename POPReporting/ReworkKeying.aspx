<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReworkKeying.aspx.vb" Inherits="ReworkKeying" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">



    <title>Rework of Defects Tracking</title>
    <link href="StyleSheet.css" rel="stylesheet" />
    <style>
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label12" runat="server" Text="Defects Rework Logging By Prod #" CssClass="newStyle7"></asp:Label>
            <br />
            <br />
               <asp:Label ID="Label1" runat="server" Text="Prod #: " CssClass="newStyle6"></asp:Label><asp:TextBox ID="tbProdNo" runat="server" CssClass="newStyle6" Height="38px" Width="130px" AutoPostBack="true" Enabled="false"></asp:TextBox> 
          
             <asp:Label ID="Label2" runat="server" Text="Workstation: " CssClass="newStyle6"></asp:Label><asp:TextBox ID="tbWorkstation" runat="server" Enabled="False" CssClass="newStyle6">></asp:TextBox>
            <br />           
            <br />
                        <asp:GridView ID="gvBoatDetails" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatDetails" CssClass="newStyle1" Width="738px">
                            <Columns>
                                <asp:BoundField DataField="ItemNo" HeaderText="MODEL" SortExpression="ItemNo">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DueDate" HeaderText="DUE DATE" SortExpression="DueDate" DataFormatString="{0:d}">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:ImageField DataImageUrlField="IsCustom" HeaderText="CUSTOM?" DataImageUrlFormatString="./Images/ovcustom{0}.png">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="IsPilot" HeaderText="PILOT?" DataImageUrlFormatString="./Images/ovpilot{0}.png">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:ImageField>
                                <asp:BoundField DataField="BuildLoc" HeaderText="BUILDING" SortExpression="BuildLoc">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SerialNo" HeaderText="HIN #" SortExpression="SerialNo">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsBoatDetails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ItemNo], [DueDate], [IsCustom], [IsPilot], [BuildLoc], [SerialNo] FROM [BML_POPREPORTING_GREENLIGHTS] Left Join ProdtoSerialMatrix on BML_POPREPORTING_GREENLIGHTS.ProdNo = ProdtoSerialMatrix.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.ProdNo = @ProdNo)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                  
            <br />           
            <br />
            <asp:DetailsView ID="dvAddDefect" runat="server" AutoGenerateRows="False" CssClass="newStyle1" DataKeyNames="AutoID" DataSourceID="sdsRework" DefaultMode="Insert" Height="50px" Width="888px">
                <Fields>                    
                    <asp:TemplateField HeaderText="Area">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlArea" runat="server" Enabled="false">
                                <asp:ListItem Value="Boat-Assembly">Boat Assembly</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>                        
                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="Category">
                       <ItemTemplate>
                           <asp:DropDownList ID="ddlCategories" runat="server" AppendDataBoundItems="true">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Audio</asp:ListItem>
                            <asp:ListItem>Bimini</asp:ListItem>
                            <asp:ListItem>Console</asp:ListItem>
                            <asp:ListItem>Deck</asp:ListItem>
                            <asp:ListItem>Electrical System</asp:ListItem>
                            <asp:ListItem>Flooring</asp:ListItem>
                            <asp:ListItem>Fuel System</asp:ListItem>
                            <asp:ListItem>Furniture</asp:ListItem>
                            <asp:ListItem>Owners Packet</asp:ListItem>
                            <asp:ListItem>Playpen Cover</asp:ListItem>
                            <asp:ListItem>Rail Structure</asp:ListItem>
                            <asp:ListItem>Tube</asp:ListItem>
                        </asp:DropDownList>
                       </ItemTemplate>
                   </asp:TemplateField>                    
                   <asp:TemplateField HeaderText ="Item (Individual Affected Component)">
                       <ItemTemplate>
                           <asp:TextBox ID="tbItem" runat="server"></asp:TextBox>
                       </ItemTemplate>
                   </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Location on Boat">
                        <ItemTemplate>
                            <asp:RadioButtonList ID="rbLocation" runat="server" RepeatDirection="Horizontal" RepeatColumns="3">
                             <asp:ListItem Value="PF">Port Front</asp:ListItem>
                            <asp:ListItem Value="PM">Port Mid</asp:ListItem>
                            <asp:ListItem Value="PR">Port Rear</asp:ListItem>
                            <asp:ListItem Value="SF">Strb Front</asp:ListItem>
                            <asp:ListItem Value="SM">Strb Mid</asp:ListItem>
                            <asp:ListItem Value="SR">Strb Rear</asp:ListItem>
                            <asp:ListItem Value="CB">Ctr Bow</asp:ListItem>
                            <asp:ListItem Value="CS">Ctr Stern</asp:ListItem>
                            </asp:RadioButtonList>                              
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="Discrepancy">
                       <ItemTemplate>
                           <asp:RadioButtonList ID="rbDiscrepancy" runat="server">
                            <asp:ListItem Value="Fit">Fit - Incorrect Positioning or Alignment</asp:ListItem>
                            <asp:ListItem Value="Form">Form - Incorrect Shape/Size/Dimention</asp:ListItem>
                            <asp:ListItem Value="Function">Function - Unable to Perform Stated Purpose</asp:ListItem>
                            <asp:ListItem Value="Damage">Damage - Physical Harm Impairing Aesthetics/Usefulness/Function</asp:ListItem>
                            <asp:ListItem Value="Shortage">ShortVend - Missing From Supplier</asp:ListItem>
                            <asp:ListItem Value="Shortage">Shortage - Not Installed In Previous Standard Work</asp:ListItem>
                           </asp:RadioButtonList>
                       </ItemTemplate>
                   </asp:TemplateField>
                   <asp:TemplateField HeaderText="Source">
                       <ItemTemplate>
                           <asp:RadioButtonList ID="rbSource" runat="server">
                               <asp:ListItem Value="I">Internally Caused Defect</asp:ListItem>
                            <asp:ListItem Value="S">Outside Supplier Caused Defect</asp:ListItem>
                           </asp:RadioButtonList>                            
                       </ItemTemplate>
                   </asp:TemplateField>
                   
                    <asp:TemplateField HeaderText ="Details">
                       <ItemTemplate>
                           <asp:TextBox ID="tbDetail" runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox>
                       </ItemTemplate>
                   </asp:TemplateField>                    
                    <asp:BoundField DataField="RepairedBy" HeaderText="Repaired By (Initials)" SortExpression="RepairedBy" />
                    <asp:BoundField DataField="VerifiedBy" HeaderText="Verified By (Initials)" SortExpression="VerifiedBy" />
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
                <HeaderStyle Width="400px" />
            </asp:DetailsView>
            <br />
            <br />
            <asp:GridView ID="gvReworkHistory" runat="server" DataSourceID="sdsRework" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="AutoID" Width="1348px" Caption="Rework History">
                <Columns>
                    <asp:CommandField ShowDeleteButton="False" ShowEditButton="True" />
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" ReadOnly="True" />
                    <asp:BoundField DataField="Area" HeaderText="Area" SortExpression="Area" />
                    <asp:BoundField DataField="Workstation" HeaderText="Workstation" SortExpression="Workstation" />
                    <asp:BoundField DataField="DateofDefect" HeaderText="Date Entered" SortExpression="DateofDefect" />
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                    <asp:BoundField DataField="Item" HeaderText="Item" SortExpression="Item" />
                    <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
                    <asp:BoundField DataField="Discrepancy" HeaderText="Discrepancy" SortExpression="Discrepancy" />
                    <asp:BoundField DataField="Source" HeaderText="Source" SortExpression="Source" >
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Detail" HeaderText="Detail" SortExpression="Detail" />
                    <asp:BoundField DataField="RepairedBy" HeaderText="Repaired By" SortExpression="RepairedBy" >
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="VerifiedBy" HeaderText="Verified By" SortExpression="VerifiedBy" >
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>                    
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsRework" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [ReworkByProd] WHERE [AutoID] = @AutoID" InsertCommand="INSERT INTO [ReworkByProd] ([ProdNo], [Area], [DateofDefect], [Category], [Item], [Location], [Discrepancy], [Source], [Detail], [RepairedBy], [VerifiedBy], [Workstation]) VALUES (@ProdNo, @Area, @DateofDefect, @Category, @Item, @Location, @Discrepancy, @Source, @Detail, @RepairedBy, @VerifiedBy, @Workstation)" SelectCommand="SELECT * FROM [ReworkByProd] WHERE ([ProdNo] = @ProdNo) ORDER BY [AutoID]" UpdateCommand="UPDATE [ReworkByProd] SET [Area] = @Area, [DateofDefect] = @DateofDefect, [Category] = @Category, [Item] = @Item, [Location] = @Location, [Discrepancy] = @Discrepancy, [Source] = @Source, [Detail] = @Detail, [RepairedBy] = @RepairedBy, [VerifiedBy] = @VerifiedBy WHERE [AutoID] = @AutoID">
                <DeleteParameters>
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="AutoID" Type="Int32" />
                    <asp:Parameter Name="ProdNo" Type="String" />
                    <asp:Parameter Name="Area" Type="String" />
                    <asp:Parameter DbType="Date" Name="DateofDefect" />
                    <asp:Parameter Name="Category" Type="String" />
                    <asp:Parameter Name="Item" Type="String" />
                    <asp:Parameter Name="Location" Type="String" />
                    <asp:Parameter Name="Discrepancy" Type="String" />
                    <asp:Parameter Name="Source" Type="String" />
                    <asp:Parameter Name="Detail" Type="String" />
                    <asp:Parameter Name="RepairedBy" Type="String" />
                    <asp:Parameter Name="VerifiedBy" Type="String" />
                    <asp:Parameter Name="Workstation" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ProdNo" Type="String" />
                    <asp:Parameter Name="Area" Type="String" />
                    <asp:Parameter DbType="Date" Name="DateofDefect" />
                    <asp:Parameter Name="Category" Type="String" />
                    <asp:Parameter Name="Item" Type="String" />
                    <asp:Parameter Name="Location" Type="String" />
                    <asp:Parameter Name="Discrepancy" Type="String" />
                    <asp:Parameter Name="Source" Type="String" />
                    <asp:Parameter Name="Detail" Type="String" />
                    <asp:Parameter Name="RepairedBy" Type="String" />
                    <asp:Parameter Name="VerifiedBy" Type="String" />
                    <asp:Parameter Name="Workstation" Type="String" />
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />

        </div>
    </form>
</body>
</html>
