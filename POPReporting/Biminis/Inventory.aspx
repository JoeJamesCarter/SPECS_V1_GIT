<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Inventory.aspx.vb" Inherits="Biminis_Inventory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Maintain Extra Bimini Inventory</title>
   <style>
       .FrameList {
           font-family:Calibri;
           font-size:20px;
           text-align: center;
       }
       .title {
           font-family:Calibri;
           font-size:30px;
           font-weight:bold;
       }
       #left {
           width:700px;
           float:left;
       }
       #right {
           margin-left:50px;
           margin-top:50px;
           width:474px;
           float:left;
       }
   </style>

    <script type = "text/javascript">
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
         </script>  
</head>
<body>
    <form id="form1" runat="server">
    <div id="left">
         <asp:Image runat="server" img src="../Images/logo-small.png"></asp:Image><br />

        <asp:Label ID="Label1" runat="server" CssClass="title" Text="Maintain An Inventory of Unassigned Biminis"></asp:Label><br />
        <br />
        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnAddARail" runat="server" Text="Add A Bimini" />
         <br />
        <br />
        <asp:GridView ID="gvBimInventory" runat="server" CssClass="FrameList" AutoGenerateColumns="False" DataKeyNames="AutoID" DataSourceID="sdsBimFrames" AllowSorting="True" CellPadding="2" CellSpacing="2" Width="1316px">
            <Columns>               
                <asp:BoundField DataField="AutoID" HeaderText="Bimini ID#" ReadOnly="true" SortExpression="AutoID" >              
                <ItemStyle Width="120px" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="FrameDesc" HeaderText="Frame" ReadOnly="true" SortExpression="FrameDesc" >
                <ItemStyle Width="200px" />
                </asp:BoundField>                             
                <asp:TemplateField HeaderText="Color">
                     <ItemTemplate>
                        <asp:DropDownList ID="ddlColor" runat="server" SelectedValue='<%# Trim(Eval("Color"))%>'>
                            <asp:ListItem Value="Silver">Silver</asp:ListItem>
                            <asp:ListItem Value="Black">Black</asp:ListItem>                            
                        </asp:DropDownList>
                    </ItemTemplate>
                     <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%# Trim(Eval("Status")) %>'>
                            <asp:ListItem Value="1">Good</asp:ListItem>
                            <asp:ListItem Value="2">Damaged</asp:ListItem>
                            <asp:ListItem Value="3">Missing Parts</asp:ListItem>
                            <asp:ListItem Value="4">Missing Parts/Damaged</asp:ListItem>
                        </asp:DropDownList>                        
                    </ItemTemplate>
                     <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="DateAdded" HeaderText="Date Added" ReadOnly="true" SortExpression="DateAdded" DataFormatString="{0:d}">              
                <ItemStyle Width="120px" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Updated" HeaderText="Updated" ReadOnly="true" SortExpression="Updated" DataFormatString="{0:d}">              
                <ItemStyle Width="120px" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" >              
                <ItemStyle Width="400px" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Update">
                    <ItemTemplate>
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="gotoupdate" CommandArgument='<%# Eval("AutoID")%>'/>
                    </ItemTemplate>
                    <ItemStyle Width="100px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mark Used">
                         <ItemTemplate>                                                                                                                                             
                             <asp:ImageButton ID="btnUpdateUsed" runat="server" ImageUrl='<%# Eval("Used", "../Images/extrarailused{0}.png")%>' CommandArgument='<%# Eval("AutoID") %>' CommandName="gotoupdateused" /> 
                         </ItemTemplate>
                         <ItemStyle VerticalAlign="Middle" />
                     </asp:TemplateField>
            </Columns>
        </asp:GridView>
        </div>
        <asp:SqlDataSource ID="sdsBimFrames" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Bimini_Inventory]">           
        </asp:SqlDataSource>
        <div id="right">
           
    </div>
    </form>
</body>
</html>
