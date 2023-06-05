<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InspectACenter.aspx.vb" Inherits="Tubes_InspectACenter" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inspect Center Tube</title>
     <link href="../StyleSheet.css" rel="stylesheet" />

     <script>
         window.onunload = function () {
             window.opener.document.getElementById('btnRefresh').click();

         }

     </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="lblProdNo" runat="server" Text="" Visible ="false"></asp:Label>

        <asp:GridView ID="gvRoller" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsPopReporting" CellPadding="8" PageSize="20">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                <ItemStyle Font-Bold="True" />
                </asp:BoundField>                
                <asp:TemplateField HeaderText="Boat">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemNo") %>' CssClass="newStyle6"></asp:Label>                                             
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="True" />
                </asp:TemplateField>                      
                <asp:TemplateField HeaderText="Length">
                    <ItemTemplate>
                        <asp:Label ID="lblLength" runat="server" Text='<%# Eval("Length")%>' style="text-align: center" Font-Underline="True"></asp:Label>
                        <br></br>
                         <asp:Image ID="imgLengthStatus" runat="server" ImageUrl='<%# Eval("LengthStatus", "../Images/inspectionstatus{0}.png")%>' /> 
                        <asp:RadioButtonList ID="rblLengthStatus" runat="server" SelectedValue='<%# Bind("LengthStatus")%>'>
                            <asp:ListItem Value="0">N/I</asp:ListItem>
                            <asp:ListItem Value="1">Failed</asp:ListItem>
                            <asp:ListItem Value="2">Passed</asp:ListItem>
                        </asp:RadioButtonList>
                    </ItemTemplate>
                    <ItemStyle Font-Bold="True" HorizontalAlign="Center" Width="100px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Style">
                     <ItemTemplate>
                    <asp:Label ID="lblStyle" runat="server" Text='<%# Eval("Style")%>' style="text-align: center" Font-Underline="True"></asp:Label>
                         <br></br>
                         <asp:Image ID="imgStyleStatus" runat="server" ImageUrl='<%# Eval("StyleStatus", "../Images/inspectionstatus{0}.png")%>' />
                        <asp:RadioButtonList ID="rblStyleStatus" runat="server" SelectedValue='<%# Bind("StyleStatus")%>'>
                            <asp:ListItem Value="0">N/I</asp:ListItem>
                            <asp:ListItem Value="1">Failed</asp:ListItem>
                            <asp:ListItem Value="2">Passed</asp:ListItem>
                        </asp:RadioButtonList>
                    </ItemTemplate>
                     <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Storage">
                     <ItemTemplate>
                    <asp:Label ID="lblStorage" runat="server" Text='<%# Eval("Storage")%>' style="text-align: center" Font-Underline="True"></asp:Label>
                         <br></br>
                         <asp:Image ID="imgStorageStatus" runat="server" ImageUrl='<%# Eval("StorageStatus", "../Images/inspectionstatus{0}.png")%>' />
                        <asp:RadioButtonList ID="rblStorageStatus" runat="server" SelectedValue='<%# Bind("StorageStatus")%>'>
                            <asp:ListItem Value="0">N/I</asp:ListItem>
                            <asp:ListItem Value="1">Failed</asp:ListItem>
                            <asp:ListItem Value="2">Passed</asp:ListItem>
                        </asp:RadioButtonList>
                    </ItemTemplate>
                     <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Brackets">
                     <ItemTemplate>
                    <asp:Label ID="lblBrackets" runat="server" Text='<%# Eval("Brackets")%>' style="text-align: center" Font-Underline="True"></asp:Label>
                         <br></br>
                         <asp:Image ID="imgBracketsStatus" runat="server" ImageUrl='<%# Eval("BracketStatus", "../Images/inspectionstatus{0}.png")%>' />
                        <asp:RadioButtonList ID="rblBracketStatus" runat="server" SelectedValue='<%# Bind("BracketStatus")%>' >
                            <asp:ListItem Value="0">N/I</asp:ListItem>
                            <asp:ListItem Value="1">Failed</asp:ListItem>
                            <asp:ListItem Value="2">Passed</asp:ListItem>
                        </asp:RadioButtonList>
                    </ItemTemplate>
                     <ItemStyle Font-Bold="True" HorizontalAlign="Center" Width="100px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Fuel">
                     <ItemTemplate>
                    <asp:Label ID="lblFuel" runat="server" Text='<%# Eval("Fuel")%>' style="text-align: center" Font-Underline="True"></asp:Label>
                         <br></br>
                         <asp:Image ID="imgFuelStatus" runat="server" ImageUrl='<%# Eval("FuelStatus", "../Images/inspectionstatus{0}.png")%>' />
                        <asp:RadioButtonList ID="rblFuelStatus" runat="server" SelectedValue='<%# Bind("FuelStatus")%>' >
                            <asp:ListItem Value="0">N/I</asp:ListItem>
                            <asp:ListItem Value="1">Failed</asp:ListItem>
                            <asp:ListItem Value="2">Passed</asp:ListItem>
                        </asp:RadioButtonList>
                    </ItemTemplate>
                     <ItemStyle Font-Bold="True" HorizontalAlign="Center" Width="100px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Splash">
                     <ItemTemplate>
                    <asp:Label ID="lblSplash" runat="server" Text='<%# Eval("Splash")%>' style="text-align: center" Font-Underline="True"></asp:Label>
                         <br></br>
                         <asp:Image ID="imgSplashStatus" runat="server" ImageUrl='<%# Eval("SplashStatus", "../Images/inspectionstatus{0}.png")%>' />
                        <asp:RadioButtonList ID="rblSplashStatus" runat="server" SelectedValue='<%# Bind("SplashStatus")%>' >
                            <asp:ListItem Value="0">N/I</asp:ListItem>
                            <asp:ListItem Value="1">Failed</asp:ListItem>
                            <asp:ListItem Value="2">Passed</asp:ListItem>
                        </asp:RadioButtonList>
                    </ItemTemplate>
                     <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Chines">
                     <ItemTemplate>
                    <asp:Label ID="lblChines" runat="server" Text='<%# Eval("Chines")%>' style="text-align: center" Font-Underline="True"></asp:Label>
                         <br></br>
                         <asp:Image ID="imgLChinesStatus" runat="server" ImageUrl='<%# Eval("ChinesStatus", "../Images/inspectionstatus{0}.png")%>' />
                        <asp:RadioButtonList ID="rblChinesStatus" runat="server" SelectedValue='<%# Bind("ChinesStatus")%>' >
                            <asp:ListItem Value="0">N/I</asp:ListItem>
                            <asp:ListItem Value="1">Failed</asp:ListItem>
                            <asp:ListItem Value="2">Passed</asp:ListItem>
                        </asp:RadioButtonList>
                    </ItemTemplate>
                     <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Keel">
                     <ItemTemplate>
                    <asp:Label ID="lblKeel" runat="server" Text='<%# Eval("Keel")%>' style="text-align: center" Font-Underline="True"></asp:Label>
                         <br></br>
                         <asp:Image ID="imgKeelStatus" runat="server" ImageUrl='<%# Eval("KeelStatus", "../Images/inspectionstatus{0}.png")%>' />
                        <asp:RadioButtonList ID="rblKeelStatus" runat="server" SelectedValue='<%# Bind("KeelStatus")%>' >
                            <asp:ListItem Value="0">N/I</asp:ListItem>
                            <asp:ListItem Value="1">Failed</asp:ListItem>
                            <asp:ListItem Value="2">Passed</asp:ListItem>
                        </asp:RadioButtonList>
                    </ItemTemplate>
                     <ItemStyle Font-Bold="True" HorizontalAlign="Center" Width="100px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Inspection Notes">
                     <ItemTemplate>
                         <asp:TextBox ID="tbInsNotes" runat="server" Height="228px" MaxLength="250" Rows="5" Width="149px" Text='<%# Eval("InspectionNotes")%>'></asp:TextBox>
                          <asp:RadioButtonList ID="rblInspectionStatus" runat="server" SelectedValue='<%# Bind("InspectionStatus")%>' >
                            <asp:ListItem Value="0">N/I</asp:ListItem>
                            <asp:ListItem Value="1">Failed</asp:ListItem>
                            <asp:ListItem Value="2">Passed</asp:ListItem>
                        </asp:RadioButtonList>                         
                         </br>
                         <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" />
                         </br>                         
                    </ItemTemplate>
                     <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                </asp:TemplateField>               
            </Columns>
            <PagerSettings PageButtonCount="20" />
            <RowStyle Height="50px" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT CenterInspection.ProdNo, CenterInspection.ItemNo, CenterInspection.Length, CenterInspection.Style, CenterInspection.Storage, CenterInspection.Brackets, CenterInspection.Fuel, CenterInspection.Splash, CenterInspection.Chines, CenterInspection.Keel, CenterInspection.LengthStatus, CenterInspection.StyleStatus, CenterInspection.StorageStatus, CenterInspection.BracketStatus,  CenterInspection.FuelStatus, CenterInspection.SplashStatus,CenterInspection.ChinesStatus,CenterInspection.KeelStatus, CenterInspection.InspectionStatus, CenterInspection.InspectionNotes FROM CenterInspection WHERE CenterInspection.ProdNo = @ProdNo ORDER BY CenterInspection.ProdNo">
            <SelectParameters>
               <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />             
            </SelectParameters>
        </asp:SqlDataSource>             
    </div>
    </form>
</body>
</html>
