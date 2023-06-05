<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TubeSchedulePrint.aspx.vb" Inherits="TubeSchedulePrint" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Printable Tube Schedule</title>
 
    <style type="text/css">
        LI { 
            list-style: none; 
           }
 
        .newStyle1 {
            font-family: Calibri;
            font-size: 12px;
        }
        .newStyle2 {
            font-family: Calibri;
            font-size: 14px; 
            text-align:center;           
                      
            
        }
        .newStyle3 {
            font-family: Calibri;
            font-size: 20px;
            font-weight: bold;
        }
        .newStyle4 {
            font-family: Calibri;
            font-size: 14px;
            color:red;
            
        }
         .auto-style1 {
            font-family:Calibri;
            text-align: center;
            font-weight:bold;            
            table-layout:fixed;
            color:white;
            margin-left:40px;
            background-color:black;
            
        }
         .auto-style2 {
            
            text-align: center;
            table-layout:fixed;
        }
         P.pagebreakhere {page-break-before: always}
    </style>
    
</head>
<body>
    <form id="form1" runat="server">
     
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.SONo, BML_POPREPORTING.PopNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_TUBEPRIORITY.TubeSortOrder, BML_POPREPORTING_TUBEPRIORITY.Length, BML_POPREPORTING_TUBEPRIORITY.Keel, BML_POPREPORTING_TUBEPRIORITY.Ladder, BML_POPREPORTING_GREENLIGHTS.HasOverride, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.RerunP, BML_POPREPORTING_GREENLIGHTS.RerunSB, BML_POPREPORTING.DueDate, BML_POPREPORTING_TUBEPRIORITY.IO, BML_POPREPORTING_TUBEPRIORITY.PerfPkg, BML_POPREPORTING_TUBEPRIORITY.Diameter, BML_POPREPORTING_TUBEPRIORITY.Ladder AS Expr1, BML_POPREPORTING_TUBEPRIORITY.Brackets, BML_POPREPORTING_TUBEPRIORITY.RopeEye FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_TUBEPRIORITY.TubeSortOrder &gt;= @FirstProdNoOrder) AND (BML_POPREPORTING_TUBEPRIORITY.TubeSortOrder &lt;= @LastProdNoOrder) AND (BML_POPREPORTING_GREENLIGHTS.TubesStatus &lt; 2) ORDER BY BML_POPREPORTING_TUBEPRIORITY.TubeSortOrder" >
          <SelectParameters>
              <asp:ControlParameter ControlID="lblFirst" Name="FirstProdNoOrder" PropertyName="Text" Type="Int32" />
              <asp:ControlParameter ControlID="lblLast" Name="LastProdNoOrder" PropertyName="Text" Type="Int32" />

          </SelectParameters>          
        </asp:SqlDataSource>
        <span class="newStyle3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TUBE SCHEDULE</span>
         <span class="newStyle1">&nbsp;&nbsp;&nbsp;<asp:Label ID="lblFirst" runat="server" Text="Label" Visible="False"></asp:Label>
&nbsp;&nbsp;<asp:Label ID="lblLast" runat="server" Text="Label" Visible="False"></asp:Label>
        &nbsp;</span>&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;
               
        
 
        
        &nbsp;<br />
        <asp:Table ID="Table1" runat="server" GridLines="Both" Height="15px" Width="1900px" CssClass="auto-style1">
         <asp:TableRow>
             <asp:TableCell Width="10px">Prod #</asp:TableCell>             
             <asp:TableCell Width="15px">Boat</asp:TableCell>             
             <asp:TableCell Width="2px">IO</asp:TableCell>  
             <asp:TableCell Width="2px">CT</asp:TableCell>             
             <asp:TableCell Width="30px">Options</asp:TableCell>
             <asp:TableCell Width="15px">Overrides</asp:TableCell>
             <asp:TableCell Width="12px">Due Date</asp:TableCell>
             <asp:TableCell Width="5px">Diam</asp:TableCell>
             <asp:TableCell Width="5px">Len</asp:TableCell>                          
             <asp:TableCell Width="10px">Keel</asp:TableCell>
             <asp:TableCell Width="20px">Brackets</asp:TableCell>
             <asp:TableCell Width="15px">Ladder</asp:TableCell>
             <asp:TableCell Width="18px">Rope Eye</asp:TableCell>
             
         </asp:TableRow></asp:Table>
 
        <asp:ReorderList ID="rl1" runat="server" SortOrderField="TubeSortOrder" ClientIDMode="AutoID"  AllowReorder="false" DataKeyField="ProdNo" DataSourceID="SqlDataSource1" PostBackOnReorder="False" Width="900px" Height="100%" >
<DragHandleTemplate>
<div class="DragHandleClass">
</div>
</DragHandleTemplate>
<ItemTemplate> 
    <asp:SqlDataSource ID="sdsBracketOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Brackets], [ProdNo] FROM [BML_POPREPORTING_TUBEPRIORITY] WHERE ([ProdNo] = @ProdNo)">
 
        <SelectParameters>
            <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
        </SelectParameters>
 
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsRoller" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [TubePartDesc], [Qty] FROM [BML_POPREPORTINGTUBEROLLER] WHERE ([ProdNo] = @ProdNo) ORDER BY [TubePartDesc]">
        <SelectParameters>
            <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsOverrides" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Override], [ProdNo] FROM [BML_POPREPORTING_TUBEOVERRIDES] WHERE ([ProdNo] = @ProdNo) AND ([Roller] = 1 OR [RoundSeamer] = 1 OR [Brackets] = 1 OR [Repair] = 1 OR [Chines] = 1)  ORDER BY [Override]">
            <SelectParameters>
                <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTINGFABOPTIONS.Option_Desc, BML_POPREPORTINGFABOPTIONS.ProdNo FROM BML_POPREPORTINGFABOPTIONS WHERE (BML_POPREPORTINGFABOPTIONS.ProdNo = @ProdNo) AND (BML_POPREPORTINGFABOPTIONS.Workcenter = @Workcenter OR BML_POPREPORTINGFABOPTIONS.Workcenter = @Workcenter2 OR BML_POPREPORTINGFABOPTIONS.Workcenter = @Workcenter3) ORDER BY BML_POPREPORTINGFABOPTIONS.Option_Desc">
     <SelectParameters>
         <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
         <asp:Parameter DefaultValue="Chines" Name="Workcenter" Type="String" />
         <asp:Parameter DefaultValue="Brackets" Name="Workcenter2" />
         <asp:Parameter DefaultValue="Repair" Name="Workcenter3" />
     </SelectParameters>      
                </asp:SqlDataSource>
    <asp:TextBox ID="tbProdNo" Text='<%#Eval("ProdNo")%>' runat="server" Visible="false"></asp:TextBox>
                <asp:Table ID="Table2" runat="server" GridLines="Both" Height="15px" Width="1900px" CssClass="auto-style2">         
          <asp:TableRow>              
              <asp:TableCell Width="10px"><asp:Label ID="Label1" runat="server" Text='<%#Eval("ProdNo")%>' CssClass="newStyle1" /></asp:TableCell><asp:TableCell Width="15px"><asp:Label ID="Label2" runat="server"  Text='<%# Eval("ItemNo") %>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="2px"><asp:Label ID="Label5" runat="server" Text='<%# Eval("IO")%>' Visible='<%# Eval("IO") = 1%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="2px"><asp:Label ID="Label11" runat="server" Text='<%# Eval("CentertubeNeeded")%>' Visible='<%# Eval("CentertubeNeeded") = 1%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="30px" HorizontalAlign="Center">     
                  <asp:GridView ID="gvOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsOptions" CssClass="newStyle1">
                                <Columns>
                                    <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:BoundField>                                                                                
                                 </Columns>
                   </asp:GridView>
                      </asp:TableCell><asp:TableCell Width="15px">
                  <asp:GridView ID="gvOverrides" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsOverrides" CssClass="newStyle4" HorizontalAlign="Center">
                                <Columns>
                                    <asp:BoundField DataField="Override" HeaderText="Override" SortExpression="Override">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />  
                                    </asp:BoundField>                                                                                
                                 </Columns>
                   </asp:GridView>
                      </asp:TableCell><asp:TableCell Width="12px"><asp:Label ID="Label3" runat="server" Text='<%# Eval("DueDate" , "{0:d}")%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="5px"><asp:Label ID="Label4" runat="server" Text='<%# Eval("Diameter")%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="5px"><asp:Label ID="Label6" runat="server" Text='<%# Eval("Length")%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="10px"><asp:Label ID="Label9" runat="server" Text='<%# Eval("Keel")%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="20px"><asp:Label ID="Label7" runat="server" Text='<%# Eval("Brackets")%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="15px"><asp:Label ID="Label8" runat="server" Text='<%# GetLadderValue(Eval("Ladder"))%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="18px"><asp:Label ID="Label10" runat="server" Text='<%# GetRopeeyeValue(Eval("Ropeeye"))%>' CssClass="newStyle1"></asp:Label></asp:TableCell></asp:TableRow></asp:Table></ItemTemplate></asp:ReorderList>


 </form>


</body></html>