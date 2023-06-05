<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditRailReqs.aspx.vb" Inherits="Rails_EditRailReqs" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Rail Requirements</title>
    <link href="../StyleSheet.css" rel="stylesheet" />

     <script>
         window.onunload = function () {
             window.opener.document.getElementById('btnRefresh').click();

         }

     </script>
</head>
<body>
    <form id="form1" runat="server" class="newStyle6">
    <div>
        <asp:Label ID="Label1" runat="server" Text="If The Rails Requirements are Incorrect, You can Change them as Needed.  Keri will be emailed to address it on other prod #'s if needed." Width="500px"></asp:Label>
        <br />
        <br />
        <asp:DetailsView ID="dvRailReqs" runat="server" AutoGenerateRows="False" DataKeyNames="ProdNo" DataSourceID="sdsRailData" Height="50px" Width="435px">
            <Fields>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                <asp:BoundField DataField="ItemNo" HeaderText="Model" ReadOnly="True" SortExpression="ItemNo" />
                <asp:BoundField DataField="WeldDate"  HeaderText="Weld Date" ReadOnly="True" SortExpression="WeldDate" DataFormatString="{0:d}" />
                <asp:BoundField DataField="CustDrawNo" HeaderText="Custom Drawing #" ReadOnly="True" SortExpression="CustDrawNo" />
                <asp:TemplateField HeaderText="Needs Transom">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbNeedsTransom" runat="server" Enabled="false" Checked='<%#Eval("NeedsTransom") = 1%>'/>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="cbNeedsTransom" runat="server" Checked='<%#Eval("NeedsTransom") = 1%>'  />
                    </EditItemTemplate>                
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Needs Port Mid">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbNeedsPM" runat="server" Enabled="false" Checked='<%#Eval("NeedsPortMid") =1  %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="cbNeedsPM" runat="server" Checked='<%#Eval("NeedsPortMid") =1  %>' />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Needs Strb Mid">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbNeedsSM" runat="server" Enabled="false" Checked='<%#Eval("NeedsStrbMid") = 1%>'/>
                    </ItemTemplate>
                     <EditItemTemplate>
                        <asp:CheckBox ID="cbNeedsSM" runat="server" Checked='<%#Eval("NeedsStrbMid") = 1%>' />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total # of Rails Needed (4, 5 or 6)">
                    <ItemTemplate>
                        <asp:TextBox ID="tbRailsNeeded" runat="server" Enabled="false" Text='<%#Eval("RailsNeeded")%>' Width="30px" TextMode="Number"></asp:TextBox>                    
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="tbRailsNeeded" runat="server" Text='<%#Eval("RailsNeeded")%>' Width="30px" TextMode="Number"></asp:TextBox>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Must Be 4, 5 or 6." MaximumValue="6" MinimumValue="4" ControlToValidate="tbRailsNeeded"></asp:RangeValidator>
                    </EditItemTemplate>
                </asp:TemplateField>    
                  <asp:TemplateField HeaderText="Protech?">
                    <ItemTemplate>
                          <asp:CheckBox ID="cbProtech" runat="server" Enabled="false" Checked='<%#Eval("Protech") = 1%>'/>
                    </ItemTemplate>
                    <EditItemTemplate>
                       <asp:CheckBox ID="cbProtech" runat="server" Checked='<%#Eval("Protech") = 1%>' />
                    </EditItemTemplate>
                </asp:TemplateField>    
               
                <asp:CommandField ShowEditButton="True" />
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="sdsRailData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [WeldDate], [CustDrawNo], [NeedsTransom], [NeedsPortMid], [NeedsStrbMid], [RailsNeeded], [Protech] FROM [Rails_Tracking] WHERE ([ProdNo] = @ProdNo)" DeleteCommand="DELETE FROM [Rails_Tracking] WHERE [ProdNo] = @ProdNo" InsertCommand="INSERT INTO [Rails_Tracking] ([ProdNo], [ItemNo], [WeldDate], [CustDrawNo], [NeedsTransom], [NeedsPortMid], [NeedsStrbMid], [RailsNeeded], [Protech]) VALUES (@ProdNo, @ItemNo, @WeldDate, @CustDrawNo, @NeedsTransom, @NeedsPortMid, @NeedsStrbMid, @RailsNeeded, @Protech)" UpdateCommand="UPDATE [Rails_Tracking] SET [NeedsTransom] = @NeedsTransom, [NeedsPortMid] = @NeedsPortMid, [NeedsStrbMid] = @NeedsStrbMid, [RailsNeeded] = @RailsNeeded, [Protech] = @Protech WHERE [ProdNo] = @ProdNo">
            <DeleteParameters>
                <asp:Parameter Name="ProdNo" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ProdNo" Type="String" />
                <asp:Parameter Name="ItemNo" Type="String" />
                <asp:Parameter DbType="Date" Name="WeldDate" />
                <asp:Parameter Name="CustDrawNo" Type="String" />
                <asp:Parameter Name="NeedsTransom" Type="Int32" />
                <asp:Parameter Name="NeedsPortMid" Type="Int32" />
                <asp:Parameter Name="NeedsStrbMid" Type="Int32" />
                <asp:Parameter Name="RailsNeeded" Type="Int32" />
                <asp:Parameter Name="Protech" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="ProdNo" QueryStringField="ProdNo" Type="String" />
            </SelectParameters>
            <UpdateParameters>                
                <asp:Parameter Name="NeedsTransom" Type="Int32" />
                <asp:Parameter Name="NeedsPortMid" Type="Int32" />
                <asp:Parameter Name="NeedsStrbMid" Type="Int32" />
                <asp:Parameter Name="RailsNeeded" Type="Int32" />
                <asp:Parameter Name="Protech" Type="Int32" />
                <asp:Parameter Name="ProdNo" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
