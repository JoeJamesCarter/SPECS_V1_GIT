<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SouthKitPartsList.aspx.vb" Inherits="SouthKitPartsList" Debug="true" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Maintain South Kit Parts List</title>
     <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DetailsView ID="dvSouthKitPartsInsert" runat="server" AutoGenerateRows="False" DataKeyNames="PartNo" Caption="Add New Part To South Kit Labels/Tally" CssClass="newStyle1" DataSourceID="sdsSouthParts" Height="50px" Width="758px" DefaultMode="Insert" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                <EditRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <Fields>
                    <asp:BoundField DataField="PartNo" HeaderText="Macola Part #" SortExpression="PartNo" />                    
                    <asp:TemplateField HeaderText="Disabled? - If checked, don't print on labels or show counts for this part.">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbInsertDisabled" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Not Kitted? - If checked, don't print on labels.">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbInsertNotKitted" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Part to Watch? - If checked, part will show Yellow in Tally List.">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbInsertWatch" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                      <asp:TemplateField HeaderText="Tally? - If checked, part will show in Tally List.">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbInsertTally" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                  
                    <asp:BoundField DataField="Abbreviation" HeaderText="Abbreviation" SortExpression="Abbreviation" />
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle BackColor="White" />
            </asp:DetailsView>
            <br />
            <hr />
            <br />
            <asp:GridView ID="gvSouthParts" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" Caption="Edit Existing Parts In South Kit Labels/Tally"  DataKeyNames="PartNo" DataSourceID="sdsSouthParts" Width="1066px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:CommandField ShowEditButton="True" />
                    <asp:BoundField DataField="PartNo" HeaderText="PartNo" ReadOnly="True" SortExpression="PartNo" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                     <asp:BoundField DataField="item_desc_1" HeaderText="Desc" SortExpression="item_desc_1" ReadOnly="true" />
                  
                    <asp:TemplateField HeaderText="Disabled">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbDisabled" runat="server" Checked='<%#IIf(Eval("Disabled") = 1, True, False) %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                  
                    <asp:TemplateField HeaderText="Not Kitted">
                            <ItemTemplate>
                            <asp:CheckBox ID="cbNotKitted" runat="server" Checked='<%#IIf(Eval("NotKitted") = 1, True, False) %>' />
                        </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                  
                    <asp:TemplateField HeaderText="Yellow?">
                            <ItemTemplate>
                            <asp:CheckBox ID="cbWatch" runat="server" Checked='<%#IIf(Eval("Watch") = 1, True, False) %>' />
                        </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                  
                    <asp:TemplateField HeaderText="Tally?">
                            <ItemTemplate>
                            <asp:CheckBox ID="cbTally" runat="server" Checked='<%#IIf(Eval("Tally") = 1, True, False) %>' />
                        </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                   
                    <asp:TemplateField HeaderText="Abbreviation">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Abbreviation")%>'></asp:Label>
                    </ItemTemplate>                            
                    
                        <EditItemTemplate>
                            <asp:TextBox ID="tbAbbr" runat="server" Text='<%# Eval("Abbreviation") %>' Width="200px"></asp:TextBox>                             
                        </EditItemTemplate>
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
            <asp:SqlDataSource ID="sdsSouthParts" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [KittingSouthParts] Left Join  WHERE [PartNo] = @PartNo" InsertCommand="INSERT INTO [KittingSouthParts] ([PartNo], [Disabled], [NotKitted], [Watch], [Tally], [Abbreviation]) VALUES (@PartNo, @Disabled, @NotKitted, @Watch, @Tally, @Abbreviation)" SelectCommand="SELECT t1.*, t2.item_desc_1 FROM [KittingSouthParts] t1 Left Join Inventory_ItemMaster t2 on t1.PartNo = t2.item_no ORDER BY [PartNo]" UpdateCommand="UPDATE [KittingSouthParts] SET [Disabled] = @Disabled, [NotKitted] = @NotKitted, [Watch] = @Watch, [Tally] = @Tally, [Abbreviation] = @Abbreviation WHERE [PartNo] = @PartNo">
                <DeleteParameters>
                    <asp:Parameter Name="PartNo" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PartNo" Type="String" />
                    <asp:Parameter Name="Disabled" Type="Int32" />
                    <asp:Parameter Name="NotKitted" Type="Int32" />
                    <asp:Parameter Name="Watch" Type="Int32" />
                    <asp:Parameter Name="Tally" Type="Int32" />
                    <asp:Parameter Name="Abbreviation" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Disabled" Type="Int32" />
                    <asp:Parameter Name="NotKitted" Type="Int32" />
                    <asp:Parameter Name="Watch" Type="Int32" />
                    <asp:Parameter Name="Tally" Type="Int32" />
                    <asp:Parameter Name="Abbreviation" Type="String" />
                    <asp:Parameter Name="PartNo" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
