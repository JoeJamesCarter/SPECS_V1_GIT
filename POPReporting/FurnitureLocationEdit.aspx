<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureLocationEdit.aspx.vb" Inherits="FurnitureLocationEdit" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture Locations</title>
    <style>      
      
         .area {
            float:left;
            height:120px;
            width:300px;
            font-family:Arial;
            font-size:15px;
            font-weight:bold;
            text-align:center;
            border-style:double;
            vertical-align:central;
        }
        .bluetext {
            color:blue;            
             font-family:Arial;
            font-size:16px;
            font-weight:bold;
            text-align:center;
        }

        
    </style>
</head>
<body>
    
    <form id="form1" runat="server"> 
          <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" Text="Results" NavigateUrl="~/Live/PopReporting/FurnitureLocationsByBoat.aspx">Print Results</asp:HyperLink>
        <p>
                <asp:DataList ID="Rack1" CssClass ="area" runat="server" DataSourceID="sdsRack1" RepeatDirection="Vertical"  RepeatColumns="1" BorderStyle="None" SeparatorStyle-Height="20px" Caption="Furniture Rows" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" RepeatLayout="Flow">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="btnClear" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="X" CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+" CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc" CausesValidation="False" UseSubmitBehavior="False" />
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Slot, Usable, ProdNo, LocKey FROM [Material_Locations] Where Building = 'M' order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource> 
            </p>
              
    
    
          <asp:TextBox ID="tbCurrentTbID" runat="server"></asp:TextBox>
              
    
    
    </form>

 
    
</body>
</html>
