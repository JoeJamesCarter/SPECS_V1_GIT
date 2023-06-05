<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TubeSort.aspx.vb" Inherits="TubeSort"  MaintainScrollPositionOnPostback="true"  %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tube Sort</title>

    <style type="text/css">
        LI { 
            list-style: none; 
           }
 .DragHandleClass
 {
 width: 15px;
 height: 15px;
 background-color: green;
 cursor:move;
 margin-right:10px;

 }
        .newStyle1 {
            font-family: Calibri;
            font-size: 16px;
        }
        .newStyle2 {
            font-family: Calibri;
            font-size: 18px; 
            text-align:center;           
                      
            
        }
        .newStyle3 {
            font-family: Calibri;
            font-size: 25px;
            font-weight: bold;
        }
        .newStyle4 {
            font-family: Calibri;
            font-size: 18px;
            color:red;
            
        }
        .auto-style1 {
            font-family:Calibri;
            text-align: center;
            font-weight:bold;
            margin-left:65px;
            table-layout:fixed;
            color:white;
            background-color:black;
            
        }
         .auto-style2 {
            
            text-align: center;
            table-layout:fixed;
        }
    </style>
    
</head>
<body>
    <form id="form1" runat="server">
       
        <asp:ScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ScriptManager>
        
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.SONo, BML_POPREPORTING.PopNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_TUBEPRIORITY.TubeSortOrder,BML_POPREPORTING_TUBEPRIORITY.Length, BML_POPREPORTING_TUBEPRIORITY.Keel, BML_POPREPORTING_TUBEPRIORITY.Ladder, BML_POPREPORTING_GREENLIGHTS.HASOVERRIDE, BML_POPREPORTING_GREENLIGHTS.ISCUSTOM, BML_POPREPORTING_GREENLIGHTS.TUBESSTATUS, BML_POPREPORTING_GREENLIGHTS.RERUNP, BML_POPREPORTING_GREENLIGHTS.RERUNSB, BML_POPREPORTING_GREENLIGHTS.RERUNCTR, BML_POPREPORTING_GREENLIGHTS.ROLLERSTATUSP, BML_POPREPORTING_GREENLIGHTS.ROLLERSTATUSS, BML_POPREPORTING.DueDate, BML_POPREPORTING_TUBEPRIORITY.IO, BML_POPREPORTING_TUBEPRIORITY.PerfPkg, BML_POPREPORTING_TUBEPRIORITY.Diameter, BML_POPREPORTING_TUBEPRIORITY.Ladder, BML_POPREPORTING_TUBEPRIORITY.Brackets, BML_POPREPORTING_TUBEPRIORITY.Ropeeye  FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where (BML_POPREPORTING_GREENLIGHTS.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.TubesStatus &lt;= @TubeStatus) AND (BML_POPREPORTING_GREENLIGHTS.RollerStatusP &lt;= @RollerStatusP) ORDER BY BML_POPREPORTING_TUBEPRIORITY.TubeSortOrder" UpdateCommand="UPDATE [BML_POPREPORTING_TUBEPRIORITY] SET [TubeSortOrder] = @TubeSortOrder WHERE [ProdNo] = @ProdNo">
          <SelectParameters>
              <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />              
              <asp:ControlParameter ControlID="ddlShowSelect" Name="TubeStatus" PropertyName="SelectedValue" Type="Int32" />
              <asp:ControlParameter ControlID="ddlShowRolled" Name="RollerStatusP" PropertyName="SelectedValue" Type="Int32" />

          </SelectParameters>
          <UpdateParameters>            
            <asp:Parameter Name="TubeSortOrder" Type="Int32" />
            <asp:Parameter Name="ProdNo" Type="String" />
        </UpdateParameters>
        </asp:SqlDataSource>
        <span class="newStyle3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TUBE SORT - Drag the green squares</span>
         <span class="newStyle1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Prod #&#39;s To Show <asp:DropDownList ID="ddlShowSelect" runat="server" AutoPostBack="True">
                <asp:ListItem Value="1">Hide Complete</asp:ListItem>                
                <asp:ListItem Value="2">Show All</asp:ListItem>                
            </asp:DropDownList>&nbsp;&nbsp; Days To Show:</span><asp:DropDownList ID="ddlDaysInAdvance" runat="server" AutoPostBack="True">
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;Show Rolled
        <asp:DropDownList ID="ddlShowRolled" runat="server" AutoPostBack="True">
            <asp:ListItem Value="1">No</asp:ListItem>
            <asp:ListItem Value="2">Yes</asp:ListItem>
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
        &nbsp;&nbsp;
        <asp:TextBox ID="tbFirstProd" runat="server" Width="64px"></asp:TextBox>
&nbsp;to
        <asp:TextBox ID="tbLastProd" runat="server" Width="64px"></asp:TextBox>
        &nbsp;&nbsp;
        <asp:Button ID="btnPrint" runat="server" Text="Print Outers" />
        &nbsp;&nbsp;
        <asp:Button ID="btnPrintCenters" runat="server" Text="Print Centers" />
        <br />
        <asp:Table ID="Table1" runat="server" GridLines="Both" Height="15px" Width="1900px" CssClass="auto-style1">
         <asp:TableRow>
             <asp:TableCell Width="10px">Prod #</asp:TableCell>
             <asp:TableCell Width="15px">Override</asp:TableCell>
             <asp:TableCell Width="25px">Boat</asp:TableCell>
             <asp:TableCell Width="6px">Rolled</asp:TableCell>
             <asp:TableCell Width="3px">C</asp:TableCell>  
             <asp:TableCell Width="3px">IO</asp:TableCell>  
             <asp:TableCell Width="3px">CT</asp:TableCell>             
             <asp:TableCell Width="50px">Options</asp:TableCell>
             <asp:TableCell Width="30px">Overrides</asp:TableCell>
             <asp:TableCell Width="12px">Due Date</asp:TableCell>
             <asp:TableCell Width="5px">Diam</asp:TableCell>
             <asp:TableCell Width="5px">Len</asp:TableCell>                         
             <asp:TableCell Width="10px">Keel</asp:TableCell>
             <asp:TableCell Width="20px">Brackets</asp:TableCell>
             <asp:TableCell Width="15px">Ladder</asp:TableCell>
             <asp:TableCell Width="18px">Rope Eye</asp:TableCell>
             <asp:TableCell Width="12px">Complete</asp:TableCell>
             <asp:TableCell Width="40px">Re-Run</asp:TableCell>
         </asp:TableRow></asp:Table>

        <asp:ReorderList ID="rl1" runat="server" SortOrderField="TubeSortOrder" ClientIDMode="AutoID"  AllowReorder="True" DataKeyField="ProdNo" DataSourceID="SqlDataSource1" PostBackOnReorder="False" Width="1024px" Height="88px" >
            
<DragHandleTemplate>
<div class="DragHandleClass">
</div>
</DragHandleTemplate>
<ItemTemplate> 
 <asp:SqlDataSource ID="sdsOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTINGFABOPTIONS.Option_Desc, BML_POPREPORTINGFABOPTIONS.ProdNo FROM BML_POPREPORTINGFABOPTIONS WHERE (BML_POPREPORTINGFABOPTIONS.ProdNo = @ProdNo) AND (BML_POPREPORTINGFABOPTIONS.Workcenter = @Workcenter OR BML_POPREPORTINGFABOPTIONS.Workcenter = @Workcenter2 OR BML_POPREPORTINGFABOPTIONS.Workcenter = @Workcenter3) ORDER BY BML_POPREPORTINGFABOPTIONS.Option_Desc">
     <SelectParameters>
         <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
         <asp:Parameter DefaultValue="Chines" Name="Workcenter" Type="String" />
         <asp:Parameter DefaultValue="Brackets" Name="Workcenter2" />
         <asp:Parameter DefaultValue="Repair" Name="Workcenter3" />
                    </SelectParameters>
                </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsOverrides" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Override], [ProdNo] FROM [BML_POPREPORTING_TUBEOVERRIDES] WHERE ([ProdNo] = @ProdNo) AND ([Roller] = 1 OR [RoundSeamer] = 1 OR [Brackets] = 1 OR [Repair] = 1 OR [Chines] = 1)  ORDER BY [Override]">
            <SelectParameters>
                <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsRoller" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [TubePartDesc], [Qty] FROM [BML_POPREPORTINGTUBEROLLER] WHERE ([ProdNo] = @ProdNo) ORDER BY [TubePartDesc]">
        <SelectParameters>
            <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsBracketOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Brackets], [ProdNo] FROM [BML_POPREPORTING_TUBEPRIORITY] WHERE ([ProdNo] = @ProdNo)">

        <SelectParameters>
            <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
        </SelectParameters>

    </asp:SqlDataSource>
    <asp:TextBox ID="tbProdNo" Text='<%#Eval("ProdNo")%>' runat="server" Visible="False"></asp:TextBox>
                <asp:Table ID="Table2" runat="server" GridLines="Both" Height="15px" Width="1900px" CssClass="auto-style2">         
          <asp:TableRow>              
              <asp:TableCell Width="10px"><asp:Label ID="Label1" runat="server" Text='<%#Eval("ProdNo")%>' CssClass="newStyle1" /></asp:TableCell><asp:TableCell Width="15px" VerticalAlign="Middle">                        
              <asp:ImageButton ID="btnUpdateOverride" runat="server" ImageUrl='<%# Eval("HasOverride","./Images/override{0}.png")%>' CommandArgument='<%#Eval("ProdNo")%>' OnCommand="ShowOverride" />                            
              </asp:TableCell><asp:TableCell Width="25px"><asp:Label ID="Label2" runat="server"  Text='<%# Eval("ItemNo") %>' CssClass="newStyle1"></asp:Label>
                  <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' OnCommand="ShowOrderDetails" /></asp:TableCell>
              <asp:TableCell Width="6px"><asp:Label ID="Label12" runat="server" Text='Y' Visible='<%# Eval("ROLLERSTATUSP") = 2%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="3px"><asp:Label ID="Label13" runat="server" Text='<%# Eval("IsCustom")%>' Visible='<%# Eval("IsCustom") = 1%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="3px"><asp:Label ID="Label5" runat="server" Text='<%# Eval("IO")%>' Visible='<%# Eval("IO") = 1%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="3px"><asp:Label ID="Label11" runat="server" Text='<%# Eval("CentertubeNeeded")%>' Visible='<%# Eval("CentertubeNeeded") = 1%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="50px" HorizontalAlign="Center">     
                  <asp:GridView ID="gvOptions" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsOptions" CssClass="newStyle1">
                                <Columns>
                                    <asp:BoundField DataField="Option_Desc" HeaderText="Option_Desc" SortExpression="Option_Desc">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:BoundField>                                                                                
                                 </Columns>
                   </asp:GridView>
                      </asp:TableCell><asp:TableCell Width="30px">
                  <asp:GridView ID="gvOverrides" runat="server" GridLines="None" ShowHeader="False" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsOverrides" CssClass="newStyle4" HorizontalAlign="Center">
                                <Columns>
                                    <asp:BoundField DataField="Override" HeaderText="Override" SortExpression="Override">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />  
                                    </asp:BoundField>                                                                                
                                 </Columns>
                   </asp:GridView>
                      </asp:TableCell><asp:TableCell Width="12px"><asp:Label ID="Label3" runat="server" Text='<%# Eval("DueDate" , "{0:d}")%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="5px"><asp:Label ID="Label4" runat="server" Text='<%# Eval("Diameter")%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="5px"><asp:Label ID="Label6" runat="server" Text='<%# Eval("Length")%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="10px"><asp:Label ID="Label9" runat="server" Text='<%# Eval("Keel")%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="20px"><asp:Label ID="Label7" runat="server" Text='<%# Eval("Brackets")%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="15px"><asp:Label ID="Label8" runat="server" Text='<%# GetLadderValue(Eval("Ladder"))%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="18px"><asp:Label ID="Label10" runat="server" Text='<%# GetRopeeyeValue(Eval("Ropeeye"))%>' CssClass="newStyle1"></asp:Label></asp:TableCell><asp:TableCell Width="12px"><asp:ImageButton ID="ImageButton2" runat="server" ImageUrl='<%# Eval("TubesStatus", "./Images/{0}checkmark.png")%>'/></asp:TableCell>
              <asp:TableCell width="40px"><asp:ImageButton ID="btnrerunport" runat="server" ImageUrl='<%# Eval("RerunP", "./Images/rerunp{0}.png")%>'  CommandArgument='<%#Eval("ProdNo")%>' OnCommand="RerunPort"/>
              &nbsp;<asp:ImageButton ID="btnrerunsb" runat="server" ImageUrl='<%# Eval("RerunSB", "./Images/rerunsb{0}.png")%>' CommandArgument='<%#Eval("ProdNo")%>' OnCommand="RerunStarboard" /> &nbsp;<asp:ImageButton ID="btnrerunctr" runat="server" ImageUrl='<%# Eval("RerunCtr", "./Images/rerunc{0}.png")%>' CommandArgument='<%#Eval("ProdNo")%>' OnCommand="RerunCenter" /></asp:TableCell>    
          </asp:TableRow></asp:Table></ItemTemplate></asp:ReorderList></form></body></html>