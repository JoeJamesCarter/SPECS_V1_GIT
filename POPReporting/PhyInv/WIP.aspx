<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WIP.aspx.vb" Inherits="PhyInv_WIP" MaintainScrollPositionOnPostback="true" Debug="true" EnableEventValidation="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PHY INV WIP</title>
    <style type="text/css">
        .newStyle1 {
            float: left;
            font-family: calibri;
            font-size: 14px;
            margin-left: 20px;
            text-align: center;
        }

        .newStyle2 {
            float: left;
            font-family: calibri;
            font-size: 20px;
        }

        .newStyle3 {
            float: left;
            font-family: calibri;
            color: green;
            font-size: 20px;
            margin-left: 4px;
            font-weight: bold;
            vertical-align: top;
        }

        .desc {
            font-family: calibri;
            font-size: 16px;
            font-weight: bold;
            color: blue;
        }

        .qty {
            font-family: calibri;
            font-size: 16px;
        }

        .partno {
            font-family: calibri;
            font-size: 16px;
        }

        .green {
            background-color: green;
            height: 70px;
            width: 70px;
        }

        .white {
            background-color: white;
            height: 70px;
            width: 70px;
        }


        #title {
            width: 100%;
            height: 30px;
            font-family: Calibri;
            font-size: 26px;
            font-weight: bold;
        }

        #right {
            width: 35%;
            height: 60px;
            float: right;
        }

        #left {
            width: 65%;
            height: 160px;
            float: left;
        }

        #col1 {
            width: 95%;
            float: left;
        }

        #col2 {
            margin-left: 870px;
            width: 5%;
            float: left;
            position: fixed;
        }

        #exploded {
            width: 100%;
        }

        .btnonboat {
            width: 70px;
            height: 70px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="gvSOLines" runat="server" CssClass="newStyle1" Caption="SO Lines">
            </asp:GridView>

            <asp:HiddenField ID="hdnSONo" runat="server" />
            <asp:HiddenField ID="hdnSONoSkip2LeadingZeros" runat="server" />
            <asp:HiddenField ID="hdnBoatYear" runat="server" />
            <asp:HiddenField ID="hdnProdNo" runat="server" />

            <div id="title">
                <asp:Label ID="Label3" runat="server" Text="Physical Inv WIP"></asp:Label>
            </div>
            <div id="left">
                <asp:Label ID="Label2" runat="server" CssClass="newStyle1" Text="Search By Prod #" Width="150"></asp:Label><asp:TextBox ID="tbProd" CssClass="newStyle1" runat="server"></asp:TextBox><br />
                <br />
                <asp:Label ID="Label1" runat="server" CssClass="newStyle1" Text="Search By SO" Width="150"></asp:Label><asp:TextBox ID="tbSO" CssClass="newStyle1" runat="server"></asp:TextBox>
                <asp:Button ID="btnLoad" CssClass="newStyle1" runat="server" Text="Load BOM" />
                <br />
                <br />

                <p />
                <br />
                <asp:Label ID="Label4" runat="server" CssClass="newStyle2" Text="Current SPECS Status (ie. Next Step Needed):"></asp:Label><asp:Label ID="lblCurrentSpecsStatus" CssClass="newStyle3" runat="server" Text=""></asp:Label>
            </div>
            <div id="right">
                <asp:TextBox ID="tbParentSearch" runat="server"></asp:TextBox>&nbsp;<asp:Button ID="btnParentSearch" runat="server" Text="Search By Parent" /><br />
                <br />
                <asp:TextBox ID="tbBomParentSearch" runat="server"></asp:TextBox>&nbsp;<asp:Button ID="btnBomParentSearch" runat="server" Text="Search By Bom Parent" />
                <asp:Button ID="btnClearSearch" runat="server" Text="Clear Search" /><br />
                <asp:Label ID="Label9" runat="server" Text="Location" CssClass="newStyle3"></asp:Label><br />
                &nbsp;<asp:RadioButtonList ID="RadioButtonList1" runat="server" CssClass="newStyle3" RepeatDirection="Horizontal">
                    <asp:ListItem>Outside</asp:ListItem>
                    <asp:ListItem>Main1</asp:ListItem>
                    <asp:ListItem>Main2</asp:ListItem>
                    <asp:ListItem>South</asp:ListItem>
                </asp:RadioButtonList>
                <br />
            </div>

            <asp:GridView ID="gvPartsThatZeroOut" runat="server" Visible="false" CssClass="newStyle1" Caption="Parts That Were Removed Because Another Part Negates Them" Width="500px"></asp:GridView>
            <div id="col1">
                <div id="exploded">
                    <asp:GridView ID="gvExplode" runat="server" AutoGenerateColumns="False" Caption="All Levels Grouped" CssClass="newStyle1">
                        <Columns>
                            <asp:TemplateField HeaderText="Parent Item" SortExpression="parent_item_desc">
                                <ItemTemplate>
                                    <asp:Label ID="parent_item_no" CssClass="partno" runat="server" Text='<%#Eval("parent_item_no") %>'></asp:Label><br />
                                    <asp:Label ID="parent_item_desc" CssClass="desc" runat="server" Text='<%#Eval("parent_item_desc") %>'></asp:Label><br />
                                    Qty:<asp:Label ID="parent_qty" CssClass="qty" runat="server" Text='<%#Eval("parent_qty") %>'></asp:Label><br />
                                    <asp:ImageButton ID="btnMissingLevel1" CssClass="btnonboat" runat="server" CommandName="parentMissing" ImageUrl="../Images/phyinv-missing.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                    <asp:ImageButton ID="btnIncompleteLevel1" CssClass="btnonboat" runat="server" CommandName="parentIncomplete" ImageUrl="../Images/phyinv-incomplete.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                    <asp:ImageButton ID="btnCompleteLevel1" CssClass="btnonboat" runat="server" CommandName="parentComplete" ImageUrl="../Images/phyinv-complete.png" CommandArgument="<%# Container.DataItemIndex %>" /><br />
                                    
                                    <asp:ImageButton ID="btnCollapse1" runat="server" CommandName="parentCollapse" ImageUrl="../Images/phyinv-collapse.png" CommandArgument="<%# Container.DataItemIndex %>" Visible="false" />
                                </ItemTemplate>
                                <ItemStyle VerticalAlign="Top" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="BOM Parents" Visible="true">
                                <ItemTemplate>
                                    <asp:GridView ID="gvBomParents" runat="server" AutoGenerateColumns="False" ShowHeader="False" OnRowDataBound="gvBomParents_RowDataBound" Visible="false" OnRowCommand="gvBomParents_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Item">
                                                <ItemTemplate>
                                                    <asp:Label ID="bomparent_item" CssClass="partno" runat="server" Text='<%#Eval("bomparent_item") %>'></asp:Label><br />
                                                    <asp:Label ID="bomparent_desc" CssClass="desc" runat="server" Text='<%#Eval("bomparent_desc") %>'></asp:Label><br>
                                                    Qty:<asp:Label ID="bomparent_qty" CssClass="qty" runat="server" Text='<%#Eval("bomparent_qty") %>'></asp:Label><br />
                                                    <asp:ImageButton ID="btnMissingLevel2" CssClass="btnonboat" runat="server" CommandName="bomParentMissing" ImageUrl="../Images/phyinv-missing.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                    <asp:ImageButton ID="btnIncompleteLevel2" CssClass="btnonboat" runat="server" CommandName="bomParentIncomplete" ImageUrl="../Images/phyinv-incomplete.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                    <asp:ImageButton ID="btnCompleteLevel2" CssClass="btnonboat" runat="server" CommandName="bomParentComplete" ImageUrl="../Images/phyinv-complete.png" CommandArgument="<%# Container.DataItemIndex %>" /><br />
                                                    <asp:ImageButton ID="btnCollapse2" runat="server" CommandName="bomParentCollapse" ImageUrl="../Images/phyinv-collapse.png" CommandArgument="<%# Container.DataItemIndex %>" Visible="false" />
                                                </ItemTemplate>
                                                <ItemStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Components" Visible="True">
                                                <ItemTemplate>
                                                    <asp:GridView ID="gvComponents" runat="server" AutoGenerateColumns="false" ShowHeader="false" GridLines="Both" Visible="false" OnRowCommand="gvComponents_RowCommand">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Component Item">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="component_item" CssClass="partno" runat="server" Text='<%#Eval("component_item") %>'></asp:Label><br />
                                                                    <asp:Label ID="component_desc" CssClass="desc" runat="server" Text='<%#Eval("component_desc") %>'></asp:Label><br />
                                                                    Qty:<asp:Label ID="component_qty" CssClass="qty" runat="server" Text='<%#Eval("component_qty") %>' Width="100"></asp:Label><br />
                                                                    <asp:ImageButton ID="btnMissingLevel3" CssClass="btnonboat" runat="server" CommandName="componentMissing" ImageUrl="../Images/phyinv-missing.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                    <asp:ImageButton ID="btnCompleteLevel3" CssClass="btnonboat" runat="server" CommandName="componentComplete" ImageUrl="../Images/phyinv-complete.png" CommandArgument="<%# Container.DataItemIndex %>" /><br />
                                                                </ItemTemplate>
                                                                <ItemStyle VerticalAlign="Top" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EditRowStyle VerticalAlign="Top" />
                                    </asp:GridView>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:GridView ID="gvAllLevels" runat="server" CssClass="newStyle1" Caption="All Levels"></asp:GridView>
                    <asp:GridView ID="gvComponents2" runat="server" CssClass="newStyle1" Caption="Level 2" Visible="false"></asp:GridView>
                    <asp:GridView ID="gvComponents3" runat="server" CssClass="newStyle1" Caption="Level 3" Visible="false"></asp:GridView>
                    <asp:GridView ID="gvComponents4" runat="server" CssClass="newStyle1" Caption="Level 4" Visible="false"></asp:GridView>
                    <asp:GridView ID="gvComponents5" runat="server" CssClass="newStyle1" Caption="Level 5" Visible="false"></asp:GridView>
                    <asp:GridView ID="gvComponents6" runat="server" CssClass="newStyle1" Caption="Level 6" Visible="false"></asp:GridView>
                    <asp:GridView ID="gvComponents7" runat="server" CssClass="newStyle1" Caption="Level 7" Visible="false"></asp:GridView>
                </div>
            </div>
            <div id="col2">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true"></asp:GridView>
                <asp:GridView ID="gvSelections" runat="server" CssClass="newStyle1" AutoGenerateColumns="False" DataKeyNames="AutoID" DataSourceID="sdsSavedLines" Width="600px" Visible="false">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="False" />
                        <asp:BoundField DataField="Auditor" HeaderText="Auditor" SortExpression="Auditor" />
                        <asp:BoundField DataField="PartDateTimeAudited" HeaderText="Audited" SortExpression="PartDateTimeAudited" />
                        <asp:BoundField DataField="ItemNo" HeaderText="Part #" SortExpression="ItemNo" />
                        <asp:BoundField DataField="ItemDesc" HeaderText="Desc" SortExpression="ItemDesc" />
                        <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" />

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="Label8" runat="server" Text='<%# Switch(Eval("PartStatus") = 1, "MISSING", Eval("PartStatus") = 2, "PARTIAL", Eval("PartStatus") = 3, "COMPLETE") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsSavedLines" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [WIP_Parts] WHERE [AutoID] = @AutoID" InsertCommand="INSERT INTO [WIP_Parts] ([ProdNo], [PartDateAudited], [Auditor], [PartDateTimeAudited], [ItemNo], [ItemDesc], [Qty], [PartStatus]) VALUES (@ProdNo, @PartDateAudited, @Auditor, @PartDateTimeAudited, @ItemNo, @ItemDesc, @Qty, @PartStatus)" SelectCommand="SELECT * FROM [WIP_Parts] WHERE [ProdNo] = @ProdNo and PartStatus <> 0 ORDER BY [AutoID]" UpdateCommand="UPDATE [WIP_Parts] SET [Qty] = @Qty, [PartStatus] = @PartStatus WHERE [AutoID] = @AutoID">
                    <DeleteParameters>
                        <asp:Parameter Name="AutoID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ProdNo" Type="String" />
                        <asp:Parameter DbType="Date" Name="PartDateAudited" />
                        <asp:Parameter Name="Auditor" Type="String" />
                        <asp:Parameter Name="PartDateTimeAudited" Type="DateTime" />
                        <asp:Parameter Name="ItemNo" Type="String" />
                        <asp:Parameter Name="ItemDesc" Type="String" />
                        <asp:Parameter Name="Qty" Type="Double" />
                        <asp:Parameter Name="PartStatus" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tbProd" Name="ProdNo" PropertyName="Text" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ProdNo" Type="String" />
                        <asp:Parameter DbType="Date" Name="PartDateAudited" />
                        <asp:Parameter Name="Auditor" Type="String" />
                        <asp:Parameter Name="PartDateTimeAudited" Type="DateTime" />
                        <asp:Parameter Name="ItemNo" Type="String" />
                        <asp:Parameter Name="ItemDesc" Type="String" />
                        <asp:Parameter Name="Qty" Type="Double" />
                        <asp:Parameter Name="PartStatus" Type="Int32" />
                        <asp:Parameter Name="AutoID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>

        </div>
    </form>
</body>
</html>
