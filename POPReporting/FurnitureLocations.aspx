<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FurnitureLocations.aspx.vb" Inherits="FurnitureLocations" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Furniture Locations</title>
    <style>      
      
         .area {
            float:left;
            height:120px;
            width:1820px;
            font-family:Arial;
            font-size:15px;
            font-weight:bold;
            text-align:center;
            border-style:double;
            vertical-align:central;
        }
          .area2 {
            float:left;
            height:120px;
            width:1820px;
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
        &nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button6" runat="server" Text="Refresh" />
        <p>
                <asp:DataList ID="Rack1" CssClass ="area" runat="server" DataSourceID="sdsRack1" RepeatDirection="Vertical"  RepeatColumns="16" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Furniture Row 1" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="btnClear" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="X" CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+" CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc" /><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>' runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 64 Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) < 10 order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource> 
            </p>
               <p>
                <asp:DataList ID="Rack2" CssClass ="area" runat="server" DataSourceID="sdsRack2" RepeatDirection="Vertical"  RepeatColumns="14" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Furniture Row 2" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label> 
                <br />
                <asp:Button ID="btnClear" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+" CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>' runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 56 Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 9 and Cast(Rack as Int) < 24 order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource>  
                
                </p>
                <p>
  
                <asp:DataList ID="Rack3" CssClass ="area" runat="server" DataSourceID="sdsRack3" RepeatDirection="Vertical"  RepeatColumns="13" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Furniture Row 3" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button2" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack3" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 56 Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 23 and Cast(Rack as Int) < 37 order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource>   
                
           </p>

  <p>
                <asp:DataList ID="Rack4" CssClass ="area" runat="server" DataSourceID="sdsRack4" RepeatDirection="Vertical"  RepeatColumns="13" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Furniture Row 4" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button3" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+" CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack4" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 52 Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 36 and Cast(Rack as Int) < 50 order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource>   
               </p>
                <p>
  
                <asp:DataList ID="Rack5" CssClass ="area" runat="server" DataSourceID="sdsRack5" RepeatDirection="Vertical"  RepeatColumns="12" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Furniture Row 5" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button4" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+" CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack5" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 48 Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 49 and Cast(Rack as Int) < 62 order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource>          
                
               </p>
                <p>  
                <asp:DataList ID="Rack6" CssClass ="area" runat="server" DataSourceID="sdsRack6" RepeatDirection="Vertical"  RepeatColumns="12" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Furniture Row 6" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button5" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack6" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 48 Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 61 and Cast(Rack as Int) < 73 order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource>                  
                    </p>

          <p>  
                <asp:DataList ID="Rack7" CssClass ="area" runat="server" DataSourceID="sdsRack7" RepeatDirection="Vertical"  RepeatColumns="10" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Furniture Row 7 - Row 9" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button7" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack7" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 40 Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 72 and Cast(Rack as Int) < 83 order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource>                  
       <%--             
                <asp:DataList ID="Rack8" CssClass ="area" runat="server" DataSourceID="sdsRack8" RepeatDirection="Vertical"  RepeatColumns="4" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Furniture Row 8" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button8" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack8" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 16 Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 74 and Cast(Rack as Int) < 79 order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource>                  
                   
                <asp:DataList ID="Rack9" CssClass ="area" runat="server" DataSourceID="sdsRack9" RepeatDirection="Vertical"  RepeatColumns="4" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Furniture Row 9" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button9" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack9" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 16 Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 78 and Cast(Rack as Int) < 83 order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource>                  --%>
                   
                <asp:DataList ID="Rack10" CssClass ="area" runat="server" DataSourceID="sdsRack10" RepeatDirection="Vertical"  RepeatColumns="6" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Furniture Row 10" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button10" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack10" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 24 Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 82 and Cast(Rack as Int) < 89 order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource>                  
                    </p>

           <asp:DataList ID="Rack11" CssClass ="area" runat="server" DataSourceID="sdsRack11" RepeatDirection="Vertical"  RepeatColumns="7" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Furniture Row 11" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button11" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList>       
        <asp:SqlDataSource ID="sdsRack11" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Top 40 Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 88 and Cast(Rack as Int) < 96 order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource>                  
                    </p>
         <asp:DataList ID="Rack12" CssClass ="area" runat="server" DataSourceID="sdsRack12" RepeatDirection="Vertical"  RepeatColumns="7" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Horse Shoe" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button12" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList> 
         <asp:SqlDataSource ID="sdsRack12" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT  Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 95 and Cast(Rack as Int) < 103  order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource>  
        </p>
         <asp:DataList ID="Rack13" CssClass ="area" runat="server" DataSourceID="sdsRack13" RepeatDirection="Vertical"  RepeatColumns="10" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Row 13" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button13" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList> 
         <asp:SqlDataSource ID="sdsRack13" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT  Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 102 and Cast(Rack as Int) < 113  order by Cast(Rack as int),Slot">                  
          </asp:SqlDataSource> 
        </p>
         <asp:DataList ID="Rack14" CssClass ="area" runat="server" DataSourceID="sdsRack14" RepeatDirection="Vertical"  RepeatColumns="14" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Row 14" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button14" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList> 
         <asp:SqlDataSource ID="sdsRack14" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 112 and Cast(Rack as Int) < 127  order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource> 
        </p>
         <asp:DataList ID="Rack15" CssClass ="area" runat="server" DataSourceID="sdsRack15" RepeatDirection="Vertical"  RepeatColumns="14" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Row 15" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button15" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList> 
         <asp:SqlDataSource ID="sdsRack15" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 126 and Cast(Rack as Int) < 141  order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource> 
        </p>
         <asp:DataList ID="Rack16" CssClass ="area" runat="server" DataSourceID="sdsRack16" RepeatDirection="Vertical"  RepeatColumns="14" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Row 16" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button16" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList> 
         <asp:SqlDataSource ID="sdsRack16" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 140 and Cast(Rack as Int) < 155  order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource> 
        </p>
         <asp:DataList ID="Rack17" CssClass ="area" runat="server" DataSourceID="sdsRack17" RepeatDirection="Vertical"  RepeatColumns="14" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Row 17" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button17" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList> 
         <asp:SqlDataSource ID="sdsRack17" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 154 and Cast(Rack as Int) < 169  order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource> 
        </p>
         <asp:DataList ID="Rack18" CssClass ="area" runat="server" DataSourceID="sdsRack18" RepeatDirection="Vertical"  RepeatColumns="13" BorderStyle="Outset" SeparatorStyle-Height="20px" Caption="Row 18" CaptionAlign="Top" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2">
            <ItemTemplate>
                <asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Rack") & "-" & Eval("Slot")%>'></asp:Label>
                <br />
                <asp:Button ID="Button18" runat="server" Text="X" Visible = ' <%# Eval("Usable") = 1%>' CommandArgument= '<%# Eval("LocKey")%>' CommandName="ClearLoc"/>&nbsp;<asp:TextBox ID="TextBox1" Text='<%# Eval("ProdNo")%>' runat="server" Width="60px" Font-Bold="True" Font-Size="16" Visible = ' <%# Eval("Usable") = 1%>'></asp:TextBox>&nbsp;<asp:Button ID="Button1" runat="server" Visible = ' <%# Eval("Usable") = 1%>'  Text="+"  CommandArgument= '<%# Eval("LocKey")%>' CommandName="AddLoc"/><br /><asp:CheckBox ID="CbRear" Visible = ' <%# Eval("Usable") = 1%>'  runat="server" Text="R" Checked='<%# IIf(Eval("Rear").ToString() = "", 0, Eval("Rear")) = 1%>'/>
            </ItemTemplate>
        </asp:DataList> 
         <asp:SqlDataSource ID="sdsRack18" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Slot, Usable, ProdNo, LocKey, Rear, InUse FROM [Material_Locations] Where Building = 'M' and Cast(Rack as Int) > 168 and Cast(Rack as Int) < 182  order by Cast(Rack as int),Slot">           
        </asp:SqlDataSource> 
        </p>
   
    
    
    </form>

 
    
</body>
</html>
