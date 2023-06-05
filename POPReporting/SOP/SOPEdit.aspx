<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SOPEdit.aspx.vb" Inherits="SOP_SOPEdit" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SOP EDIT</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <script src="../scripts/jquery-ui-1.10.4.custom/js/jquery-1.10.2.js"></script>
    <script src="../scripts/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js"></script>
    <link href="../scripts/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.css" rel="stylesheet" />

    <style>
        #kit {
            width: 700px;
            border: double;
            padding: 20px;
            float: left;
            margin-right: 20px;
        }

        #reqResources {
            margin-top: 10px;
            width: 355px;
            float: left;
            height: 576px;
        }

        #workinstprint {
            float: left;
            width: 500px;
            height: 588px;
        }

        #addnewtools {
            width: 630px;
            height: 400px;
        }

        #addtools {
            float: left;
            width: 300px;
        }

        #addsupplies {
            float: left;
            width: 300px;
        }
    </style>



</head>
<body>
    <form id="form1" runat="server">
        <div id="header" class="newStyle7">
            <asp:Label ID="lblSOPNoTitle" runat="server" Text="SOP #:" CssClass="newStyle6"></asp:Label>
            <asp:Label ID="lblSOPNo" runat="server" Text=""></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lbl1" runat="server" Text="Model Year:" CssClass="newStyle6"></asp:Label>
            <asp:Label ID="lblModelYear" runat="server" Text=""></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lbl2" runat="server" Text="Series:" CssClass="newStyle6"></asp:Label>
            <asp:Label ID="lblSeries" runat="server" Text=""></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lbl3" runat="server" Text="Model #:" CssClass="newStyle6"></asp:Label>
            <asp:Label ID="lblModel" runat="server" Text=""></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label1" runat="server" Text="Series/Model:" CssClass="newStyle6"></asp:Label>
            <asp:Label ID="lblSeriesModel" runat="server" Text=""></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label2" runat="server" Text="Drawing #:" CssClass="newStyle6"></asp:Label>
            <asp:Label ID="lblDrawingNo" runat="server" Text=""></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Text="Description:" CssClass="newStyle6"></asp:Label>
            <asp:Label ID="lblDescription" runat="server" Text=""></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label4" runat="server" Text="Part #:" CssClass="newStyle6"></asp:Label>
            <asp:Label ID="lblPartNo" runat="server" Text=""></asp:Label>
            <br />
            <hr />

        </div>
        <div id="kit">
            <asp:Label ID="Label5" runat="server" CssClass="newStyle4" Text="KITS"></asp:Label>
            <br />
            <asp:GridView ID="gvKit" runat="server" AutoGenerateColumns="False" DataKeyNames="AutoID" DataSourceID="sdsKit" CssClass="newStyle1" Caption="Kit Contents" Width="690px">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="AutoID" HeaderText="AutoID" InsertVisible="False" ReadOnly="True" SortExpression="AutoID" Visible="false" />
                    <asp:BoundField DataField="SOP_ID" HeaderText="SOP_ID" SortExpression="SOP_ID" Visible="False" InsertVisible="False" ReadOnly="True" />

                    <asp:TemplateField HeaderText ="Item Order">
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%#Eval("ItemID") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tbItemID" runat="server" Text='<%#Eval("ItemID") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Item Qty">
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%#Eval("ItemQty") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tbItemQty" runat="server" Text='<%#Eval("ItemQty") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Part # or Desc">
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%#Eval("PartNoOrDesc") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tbPartNoOrDesc" runat="server" Text='<%#Eval("PartNoOrDesc") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Description">
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%#Eval("Description") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tbDescription" runat="server" Text='<%#Eval("Description") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsKit" runat="server" ConnectionString="<%$ ConnectionStrings:SOPConnectionString %>" DeleteCommand="DELETE FROM [SOP_KitContents] WHERE [AutoID] = @AutoID" InsertCommand="INSERT INTO [SOP_KitContents] ([SOP_ID], [ItemID], [ItemQty], [PartNoOrDesc], [Description]) VALUES (@SOP_ID, @ItemID, @ItemQty, @PartNoOrDesc, @Description)" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [SOP_KitContents] WHERE ([SOP_ID] = @SOP_ID) ORDER BY [ItemID]" UpdateCommand="UPDATE [SOP_KitContents] SET [SOP_ID] = @SOP_ID, [ItemID] = @ItemID, [ItemQty] = @ItemQty, [PartNoOrDesc] = @PartNoOrDesc, [Description] = @Description WHERE [AutoID] = @AutoID">
                <DeleteParameters>
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="SOP_ID" Type="Int32" />
                    <asp:Parameter Name="ItemID" Type="Int32" />
                    <asp:Parameter Name="ItemQty" Type="Int32" />
                    <asp:Parameter Name="PartNoOrDesc" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblSOPNo" Name="SOP_ID" PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SOP_ID" Type="Int32" />
                    <asp:Parameter Name="ItemID" Type="Int32" />
                    <asp:Parameter Name="ItemQty" Type="Int32" />
                    <asp:Parameter Name="PartNoOrDesc" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Button ID="btnAddItemsToKit" runat="server" CssClass="newStyle6" Text="Show/Hide Add Items To Kit" />
            <br />

            <asp:DetailsView ID="dvKit" runat="server" Height="50px" Width="690px" DataSourceID="sdsKit" DefaultMode="Insert" AutoGenerateRows="False" CssClass="newStyle1" Caption="Add New Items to Kit" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>

                    <asp:TemplateField HeaderText="Item Order">
                        <ItemTemplate>
                            <asp:TextBox ID="tbItemID" runat="server" Enabled="False"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Qty">
                        <ItemTemplate>
                            <asp:TextBox ID="tbItemQty" runat="server"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Part # or Short Desc">
                        <ItemTemplate>
                            <asp:TextBox ID="tbPartNoOrDesc" runat="server"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <asp:TextBox ID="tbDesc" runat="server"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowInsertButton="True" />

                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView>
            <br />
            <asp:Button ID="btnAddModifyTools" runat="server" Text="Show/Hide Add/Modify Tools/Supplies" CssClass="newStyle6" />
            <br />
        </div>

        <div id="reqResources" runat="server">
            <div id="reqTools" class="newStyle1">
                <asp:Label ID="Label8" runat="server" Text="Tools Required" CssClass="newStyle4"></asp:Label><br />
                <asp:PlaceHolder ID="phReqTools" runat="server"></asp:PlaceHolder>
            </div>
            <br />
            <div id="reqSupplies" class="newStyle1">
                <asp:Label ID="Label9" runat="server" Text="Supplies Required" CssClass="newStyle4"></asp:Label><br />
                <asp:PlaceHolder ID="phReqSupplies" runat="server"></asp:PlaceHolder>
                <br />
                <br />
            </div>

        </div>

        <div id="workinstedit">
            <asp:Label ID="Label13" runat="server" CssClass="newStyle4" Text="Edit Work Instructions"></asp:Label>
            <asp:GridView ID="gvWorkInstEdit" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="AutoID" DataSourceID="sdsWorkInstuctions" Width="624px">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# Eval("WorkInstID") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tbWorkInstStepNo" runat="server" Text='<%#Eval("WorkInstID") %>' TextMode="SingleLine" Width="30px"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# Eval("WorkInstDesc") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tbWorkInstDesc" runat="server" Text='<%#Eval("WorkInstDesc") %>' TextMode="MultiLine" Width="400px"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsWorkInstuctions" runat="server" ConnectionString="<%$ ConnectionStrings:SOPConnectionString %>" DeleteCommand="DELETE FROM [SOP_WorkInstructions] WHERE [AutoID] = @AutoID" InsertCommand="INSERT INTO [SOP_WorkInstructions] ([SOP_ID], [WorkInstID], [WorkInstDesc], [WorkInstLastModified]) VALUES (@SOP_ID, @WorkInstID, @WorkInstDesc, @WorkInstLastModified)" SelectCommand="SELECT * FROM [SOP_WorkInstructions] WHERE ([SOP_ID] = @SOP_ID) ORDER BY [WorkInstID]" UpdateCommand="UPDATE [SOP_WorkInstructions] SET [WorkInstID] = @WorkInstID, [WorkInstDesc] = @WorkInstDesc, [WorkInstLastModified] = @WorkInstLastModified WHERE [AutoID] = @AutoID">
                <DeleteParameters>
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="SOP_ID" Type="Int32" />
                    <asp:Parameter Name="WorkInstID" Type="Int32" />
                    <asp:Parameter Name="WorkInstDesc" Type="String" />
                    <asp:Parameter Name="WorkInstLastModified" Type="DateTime" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="lblSOPNo" Name="SOP_ID" PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SOP_ID" Type="Int32" />
                    <asp:Parameter Name="WorkInstID" Type="Int32" />
                    <asp:Parameter Name="WorkInstDesc" Type="String" />
                    <asp:Parameter Name="WorkInstLastModified" Type="DateTime" />
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>


        <div id="addnewtools" runat="server">
            <br />

            <asp:DetailsView ID="dvAddToolsSupplies" runat="server" Height="50px" Width="627px" AutoGenerateRows="False" Caption="Add a Tool or Supply not Listed Here" CellPadding="4" CssClass="newStyle1" DataKeyNames="SOP_ToolID" DataSourceID="sdsToolsandSupplies" DefaultMode="Insert" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="SOP_ToolID" HeaderText="SOP_ToolID" InsertVisible="False" ReadOnly="True" SortExpression="SOP_ToolID" />
                    <asp:BoundField DataField="ToolDesc" HeaderText="Tool/Supply Desc" SortExpression="ToolDesc" />
                    <asp:BoundField DataField="ToolNote" HeaderText="Tool/Supply Notes" SortExpression="ToolNote" />
                    <asp:BoundField DataField="ToolType" HeaderText="Type = Tools or Supplies" SortExpression="ToolType" />
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView>
            <br />
            <asp:SqlDataSource ID="sdsToolsandSupplies" runat="server" ConnectionString="<%$ ConnectionStrings:SOPConnectionString %>" DeleteCommand="DELETE FROM [SOP_ToolsList] WHERE [SOP_ToolID] = @SOP_ToolID" InsertCommand="INSERT INTO [SOP_ToolsList] ([ToolNote], [ToolDesc], [ToolType]) VALUES (@ToolNote, @ToolDesc, @ToolType)" SelectCommand="SELECT * FROM [SOP_ToolsList] ORDER BY [ToolDesc]" UpdateCommand="UPDATE [SOP_ToolsList] SET [ToolNote] = @ToolNote, [ToolDesc] = @ToolDesc, [ToolType] = @ToolType WHERE [SOP_ToolID] = @SOP_ToolID">
                <DeleteParameters>
                    <asp:Parameter Name="SOP_ToolID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ToolNote" Type="String" />
                    <asp:Parameter Name="ToolDesc" Type="String" />
                    <asp:Parameter Name="ToolType" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ToolNote" Type="String" />
                    <asp:Parameter Name="ToolDesc" Type="String" />
                    <asp:Parameter Name="ToolType" Type="String" />
                    <asp:Parameter Name="SOP_ToolID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <div id="addtools">
                <asp:Label ID="Label6" runat="server" Text="All Available Tools" CssClass="newStyle4"></asp:Label>
                <asp:CheckBoxList ID="cbTools" runat="server" DataSourceID="sdsTools" DataTextField="ToolDesc" DataValueField="SOP_ToolID" CssClass="newStyle1"></asp:CheckBoxList>
                <asp:SqlDataSource ID="sdsTools" runat="server" ConnectionString="<%$ ConnectionStrings:SOPConnectionString %>" SelectCommand="SELECT * FROM [SOP_ToolsList] Where ToolType = 'Tools' ORDER BY [ToolDesc]"></asp:SqlDataSource>
            </div>
            <div id="addsupplies">
                <asp:Label ID="Label7" runat="server" Text="All Available Supplies" CssClass="newStyle4"></asp:Label>
                <asp:CheckBoxList ID="cbSupplies" runat="server" DataSourceID="sdsSupplies" DataTextField="ToolDesc" DataValueField="SOP_ToolID" CssClass="newStyle1"></asp:CheckBoxList>
                <asp:SqlDataSource ID="sdsSupplies" runat="server" ConnectionString="<%$ ConnectionStrings:SOPConnectionString %>" SelectCommand="SELECT * FROM [SOP_ToolsList] Where ToolType = 'Supplies' ORDER BY [ToolDesc]"></asp:SqlDataSource>
                <br />

            </div>
            <asp:Button ID="btnSaveTools" runat="server" CssClass="newStyle6" Style="text-align: center" Text="Save Selections To This SOP" Width="293px" />
            <br />
            <br />
            <hr />
        </div>



    </form>
</body>
</html>
