<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MaintainPartsByLocation.aspx.vb" Inherits="Materials_MaintainPartsByLocation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Maintain Parts By Location</title>
    <style>
        #left {
           
            float:left;
        }
        #right {
            font-family:Calibri;
            font-size:14px;
           margin-left:20px;
            float:left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="left">
        
        <asp:GridView ID="gvPartsByLocation" runat="server" AutoGenerateColumns="False" DataKeyNames="Item_No" DataSourceID="sdsPartsByLocation" AllowSorting="True" Font-Size="14px" Font-Names="Calibri" CellPadding="2" CellSpacing="2" style="text-align: center">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="Item_No" HeaderText="Item #" ReadOnly="True" SortExpression="Item_No" />
                <asp:BoundField DataField="Desc1" HeaderText="Desc 1" SortExpression="Desc1" />
                <asp:BoundField DataField="Desc2" HeaderText="Desc 2" SortExpression="Desc2" />
                <asp:BoundField DataField="Loc1" HeaderText="Loc #1 - (Main Back)" SortExpression="Loc1" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Loc2" HeaderText="Loc #2 (Main Middle)" SortExpression="Loc2" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Loc3" HeaderText="Loc #3 - (Unassigned)" SortExpression="Loc3" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Loc4" HeaderText="Loc #4 - (South)" SortExpression="Loc4" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="$">
                    <ItemTemplate>
                        <asp:Label ID="lblCost" cssClass= "newStyle10" runat="server" Text="Label"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="100px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Count On the Line">
                    <ItemTemplate>
                        <asp:CheckBox ID="cbCountOnline" runat="server" Checked='<%# Bind("CountedOnline") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPartsByLocation" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [LocationsByPart] WHERE [Item_No] = @Item_No" InsertCommand="INSERT INTO [LocationsByPart] ([Item_No], [Loc1], [Loc2], [Loc3], [Loc4]) VALUES (@Item_No, @Loc1, @Loc2, @Loc3, @Loc4)" SelectCommand="SELECT * FROM [LocationsByPart]" UpdateCommand="UPDATE [LocationsByPart] SET [Desc1] = @Desc1, [Desc2] = @Desc2, [Loc1] = @Loc1, [Loc2] = @Loc2, [Loc3] = @Loc3, [Loc4] = @Loc4, [CountedOnline] = @CountedOnline WHERE [Item_No] = @Item_No">
            <DeleteParameters>
                <asp:Parameter Name="Item_No" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Item_No" Type="String" />
                <asp:Parameter Name="Loc1" Type="String" />
                <asp:Parameter Name="Loc2" Type="String" />
                <asp:Parameter Name="Loc3" Type="String" />
                <asp:Parameter Name="Loc4" Type="String" />                       
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Item_No" Type="String" />
                <asp:Parameter Name="Desc1" Type="String" />
                <asp:Parameter Name="Desc2" Type="String" />
                <asp:Parameter Name="Loc1" Type="String" />
                <asp:Parameter Name="Loc2" Type="String" />
                <asp:Parameter Name="Loc3" Type="String" />
                <asp:Parameter Name="Loc4" Type="String" />  
               <asp:Parameter  Name="CountedOnline" DbType="Boolean" />                
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
        <div id="right">
<asp:DetailsView ID="DetailsView1" runat="server" DataSourceID="sdsPartsByLocation" Height="50px" Width="397px" CellPadding="2" CellSpacing="2">
            <Fields>
                <asp:CommandField ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
        </div>
    </form>
</body>
</html>
