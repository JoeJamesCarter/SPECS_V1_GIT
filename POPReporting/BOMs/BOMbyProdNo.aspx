<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BOMbyProdNo.aspx.vb" Inherits="BOMs_BOMbyProdNo" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .newStyle1 {
            float: left;
            font-family: calibri;
            font-size: 16px;
            margin-left: 20px;
        }

        .yellow {
            font-weight: bold;
            color: red;
            background-color: yellow;
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

            <asp:GridView ID="gvComponents2" runat="server" CssClass="newStyle1" Caption="Level 2"></asp:GridView>
            <asp:GridView ID="gvComponents3" runat="server" CssClass="newStyle1" Caption="Level 3"></asp:GridView>
            <asp:GridView ID="gvComponents4" runat="server" CssClass="newStyle1" Caption="Level 4"></asp:GridView>
            <asp:GridView ID="gvComponents5" runat="server" CssClass="newStyle1" Caption="Level 5"></asp:GridView>
            <asp:GridView ID="gvComponents6" runat="server" CssClass="newStyle1" Caption="Level 6"></asp:GridView>
            <asp:GridView ID="gvComponents7" runat="server" CssClass="newStyle1" Caption="Level 7"></asp:GridView>

            <asp:Label ID="Label1" runat="server"  CssClass="newStyle1" Text="Search By SO"></asp:Label><asp:TextBox ID="tbSO"  CssClass="newStyle1" runat="server"></asp:TextBox>
            <asp:Label ID="Label2" runat="server"   CssClass="newStyle1" Text="Search By Prod #"></asp:Label><asp:TextBox ID="tbProd"  CssClass="newStyle1" runat="server"></asp:TextBox>
            <asp:Button ID="btnLoad"  CssClass="newStyle1" runat="server" Text="Load BOM" />&nbsp;&nbsp;&nbsp;&nbsp;


          
                                   
            &nbsp;<asp:TextBox ID="tbParentSearch" runat="server"></asp:TextBox>&nbsp;<asp:Button ID="btnParentSearch" runat="server" Text="Search By Parent" /> 
            &nbsp;&nbsp;<asp:TextBox ID="tbBomParentSearch" runat="server"></asp:TextBox>&nbsp;<asp:Button ID="btnBomParentSearch" runat="server" Text="Search By Bom Parent" />
            &nbsp;&nbsp;&nbsp;<asp:Button ID="btnClearSearch" runat="server" Text="Clear Search" /><br /><br /><br /><br /><br />

            <asp:GridView ID="gvPartsThatZeroOut" runat="server" CssClass="newStyle1" Caption="Parts That Were Removed Because Another Part Negates Them" Width="500px"></asp:GridView><br /><br />
            
            <asp:GridView ID="gvExplode" runat="server" AutoGenerateColumns="False" Caption="All Levels Grouped" CssClass="newStyle1">
                <Columns>
                    <asp:TemplateField HeaderText="Parent Item">
                        <ItemTemplate>
                            <asp:Label ID="parent_item_no" runat="server" Text='<%#Eval("parent_item_no") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Desc">
                        <ItemTemplate>
                            <asp:Label ID="parent_item_desc" runat="server" Text='<%#Eval("parent_item_desc") %>' Width="350"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="BOM Parents">
                        <ItemTemplate>
                            <asp:GridView ID="gvBomParents" runat="server" AutoGenerateColumns="False" ShowHeader="False" OnRowDataBound="gvBomParents_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Item">
                                        <ItemTemplate>
                                            <asp:Label ID="bomparent_item" runat="server" Text='<%#Eval("bomparent_item") %>' CssClass='<%# IIf(Eval("bomparent_qty") Like "-*", "yellow", "white") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Item">
                                        <ItemTemplate>
                                            <asp:Label ID="bomparent_desc" runat="server" Text='<%#Eval("bomparent_desc") %>' CssClass='<%# IIf(Eval("bomparent_qty") Like "-*", "yellow", "white") %>' Width="350"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Qty">
                                        <ItemTemplate>
                                            <asp:Label ID="bomparent_qty" runat="server" Text='<%#Eval("bomparent_qty") %>' CssClass='<%# IIf(Eval("bomparent_qty") Like "-*", "yellow", "white") %>' Width="100"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="100px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="Button1" runat="server" Text="Button"></asp:Button>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Components">
                                        <ItemTemplate>
                                            <asp:GridView ID="gvComponents" runat="server" AutoGenerateColumns="false" ShowHeader="false" GridLines="Vertical">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Component Item">
                                                        <ItemTemplate>
                                                            <asp:Label ID="component_item" runat="server" Text='<%#Eval("component_item") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Component Desc">
                                                        <ItemTemplate>
                                                            <asp:Label ID="component_item" runat="server" Text='<%#Eval("component_desc") %>' Width="350"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Component Qty">
                                                        <ItemTemplate>
                                                            <asp:Label ID="component_item" runat="server" Text='<%#Eval("component_qty") %>' Width="100"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button ID="Button1" runat="server" Text="Button"></asp:Button>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ItemTemplate>
                    </asp:TemplateField>                   
                </Columns>
            </asp:GridView>
             <asp:GridView ID="gvAllLevels" runat="server" CssClass="newStyle1" Caption="All Levels"></asp:GridView>
        </div>
    </form>
</body>
</html>
