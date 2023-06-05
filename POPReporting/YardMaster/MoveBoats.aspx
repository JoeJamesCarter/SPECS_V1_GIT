<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MoveBoats.aspx.vb" Inherits="YardMaster_MoveBoats" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Move Boats</title>
     <link href="../StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
.Initial
{
  display: block;
  padding: 4px 18px 4px 18px;
  float: left;
  background: url("../Images/InitialImage.png") no-repeat right top;
  color: Black;
  font-weight: bold;
}
.Initial:hover
{
  color: White;
  background: url("../Images/SelectedButton.png") no-repeat right top;
}
.Clicked
{
  float: left;
  display: block;
  background: url("../Images/SelectedButton.png") no-repeat right top;
  padding: 4px 18px 4px 18px;
  color: Black;
  font-weight: bold;
  color: White;
}
        #left {
            float:left;
            width:45%;           
        }
        #right {
             text-align:center;
             width:45%;
            float:left;            
        }
        #actions {
            float:left;
            width:10%;
            height:600px;
            font-family:Calibri;
            font-size:30px;
        }
        .gvLocs {           
            margin-left:5px;
            float:left;
            font-weight:normal;
            font-family:Calibri;
        }
        .auto-style1 {
            width: 1376px;
        }
        .selectionResults {
            font-family:Calibri;
            font-size:25px;
            font-weight:bold;
        }
         .selectionResultValue {
            font-family:Calibri;
            font-size:25px;
            font-weight:bold;
            color:blue;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="left">      
           <table>
      <tr>
        <td>
          <asp:Button Text="Search" BorderStyle="None" CssClass="Initial" ID="Search" runat="server" OnClick="Search_Click" />
          <asp:Button Text="Frames Stack" BorderStyle="None" CssClass="Initial" ID="Frames" runat="server" OnClick="Frames_Click" />
          <asp:Button Text="South Decks" BorderStyle="None" CssClass="Initial" ID="Decks"  runat="server" OnClick="Decks_Click" />
          <asp:Button Text="Incomplete" BorderStyle="None" CssClass="Initial" ID="Incomplete" runat="server" OnClick="Incomplete_Click" />
          <asp:Button Text="Complete" BorderStyle="None" CssClass="Initial" ID="Complete" runat="server" OnClick="Complete_Click" />
          <asp:MultiView ID="MainView" runat="server">
              <asp:View ID="View5" runat="server">
              <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td class="auto-style1">
                    <h3>
                        <asp:Label ID="lblSearch" runat="server" Text="Search By"></asp:Label>&nbsp; Prod #:&nbsp;<asp:TextBox ID="tbSearchProdNo" runat="server" Width="76px"></asp:TextBox>
                        &nbsp;
                        <asp:Button ID="btnClearSearch" runat="server" Text="Clear" />
                   
                    </h3>
                      <h3>
                          <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsSearchResults" ForeColor="Black" GridLines="Vertical" Width="350px">
                              <AlternatingRowStyle BackColor="#CCCCCC" />
                              <Columns>
                                  <asp:CommandField ShowSelectButton="True" />
                                  <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                                  <asp:BoundField DataField="ItemNo" HeaderText="Model" />
                                  <asp:BoundField DataField="BuildLoc" HeaderText="Bldg">
                                  <ItemStyle HorizontalAlign="Center" />
                                  </asp:BoundField>
                                  <asp:BoundField DataField="CurrentStatus" HeaderText="Next" />
                                  <asp:BoundField DataField="SlotKey" HeaderText="Location" />
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
                          <asp:SqlDataSource ID="sdsSearchResults" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.CusName, SlotKey, BuildLoc, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus From BML_POPREPORTING_GREENLIGHTS Left Join Yard_Master_Locations on BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo Where (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') and (BML_POPREPORTING_GREENLIGHTS.IsInvoiced = 0) Order By BML_POPREPORTING_GREENLIGHTS.ProdNo">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="tbSearchProdNo" DefaultValue="A%" Name="Search" Type="String" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                      </h3>
                  </td>
                </tr>
              </table>
            </asp:View>
            <asp:View ID="View1" runat="server">
              <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td class="auto-style1">
                    <h3>
                        <asp:Label ID="lblFrameStack" runat="server" Text="Tubes are Green, Frames Are Not"></asp:Label>
                      <asp:GridView ID="gvFrameStack" CssClass="newStyle1" runat="server" DataSourceID="sdsFramesStack" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="350px" DataKeyNames="ProdNo">
                           <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />                
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />                
                <asp:BoundField DataField="ItemNo" HeaderText="Model" />
                <asp:BoundField DataField="BuildLoc" HeaderText="Bldg" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="SlotKey" HeaderText="Location" />                   
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
                        <asp:SqlDataSource ID="sdsFramesStack" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, SlotKey, BML_POPREPORTING_GREENLIGHTS.BuildLoc From BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo Left Join Yard_Master_Locations on BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo Where BML_POPREPORTING_GREENLIGHTS.TubesStatus = 2 and BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus  < 2 and BML_POPREPORTING_GREENLIGHTS.CompleteStatus  < 2 Order By BML_POPREPORTING_GREENLIGHTS.ProdNo"></asp:SqlDataSource>
                   
                    </h3>
                  </td>
                </tr>
              </table>
            </asp:View>
            <asp:View ID="View2" runat="server">
              <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <asp:Label ID="lblDecksOutside" runat="server" Text="South Boats Complete Through Floors"></asp:Label>
                       <asp:GridView ID="gvDecksOutside" CssClass="newStyle1" runat="server" DataSourceID="sdsDecksOutside" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="350px" DataKeyNames="ProdNo">
                           <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />                
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                <asp:BoundField DataField="ItemNo" HeaderText="Model" />
                <asp:BoundField DataField="SlotKey" HeaderText="Location" />                 
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
                        <asp:SqlDataSource ID="sdsDecksOutside" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, SlotKey From BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo Left Join Yard_Master_Locations on BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo Where BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus = 2 and BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus  = '1' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus  < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc  = 'S' Order By BML_POPREPORTING_GREENLIGHTS.ProdNo"></asp:SqlDataSource>
                    </h3>
                  </td>
                </tr>
              </table>
            </asp:View>
            <asp:View ID="View3" runat="server">
              <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <asp:Label ID="lblIncomplete" runat="server" Text="Through Shrink"></asp:Label>
                      <asp:GridView ID="gvIncomplete" CssClass="newStyle1" runat="server" DataSourceID="sdsIncomplete" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="350px" DataKeyNames="ProdNo">
                           <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                <asp:BoundField DataField="ItemNo" HeaderText="Model" />
                <asp:BoundField DataField="CurrentStatus" HeaderText="Next" />
                <asp:BoundField DataField="ActualLoadDate" DataFormatString="{0:d}" HeaderText="To Be Loaded" />                
                <asp:BoundField DataField="SlotKey" HeaderText="Location" />               
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
                        <asp:SqlDataSource ID="sdsIncomplete" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.ItemNo, BML_POPREPORTING.CusName, SlotKey, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' End as CurrentStatus, ActualLoadDate From BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo Left Join Yard_Master_Locations on BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo Left Join Load_Scheduling on BML_POPREPORTING_GREENLIGHTS.ProdNo = Load_Scheduling.ProdNo Where BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus = 2 and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 Order By ActualLoadDate desc, BML_POPREPORTING_GREENLIGHTS.ProdNo"></asp:SqlDataSource>
                   
                    </h3>
                  </td>
                </tr>
              </table>
            </asp:View>
               <asp:View ID="View4" runat="server">
              <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <asp:Label ID="lblCompleteBoats" runat="server" Text="Complete Boats Waiting to Ship"></asp:Label>
                     <asp:GridView ID="gvBoatsToMove" CssClass="newStyle1" runat="server" DataSourceID="sdsBoatsToMove" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="350px" DataKeyNames="mfg_ser_lot_no">
                         <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />              
                <asp:BoundField DataField="user_def_fld_1" HeaderText="Prod #" />                              
              
                <asp:TemplateField HeaderText="Model/Location">
                    <ItemTemplate>
                        <asp:GridView ID="gvCompleteBoatsData" runat="server" AutoGenerateColumns="False" DataSourceID="sdsCompleteBoatsData" GridLines="None" ShowHeader="False" BorderStyle="None">
                            <Columns>
                                <asp:BoundField DataField="ItemNo">
                                <ItemStyle Width="150px" />
                                </asp:BoundField>                                
                                <asp:BoundField DataField="SlotKey" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsCompleteBoatsData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ItemNo, BML_POPREPORTING_GREENLIGHTS.ProdNo,BML_POPREPORTING_GREENLIGHTS.CusName, SlotKey From BML_POPREPORTING_GREENLIGHTS Left Join Yard_Master_Locations on BML_POPREPORTING_GREENLIGHTS.ProdNo = Yard_Master_Locations.ProdNo Where BML_POPREPORTING_GREENLIGHTS.ProdNo = @prod">
                        <SelectParameters>                                                                                       
                        <asp:Parameter Name="prod" DefaultValue="" Type="String" />                   
                        </SelectParameters>                       
                </asp:SqlDataSource>
                    </ItemTemplate>
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
        </asp:GridView>  <asp:SqlDataSource ID="sdsBoatsToMove" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT PPORDFIL_SQL.user_def_fld_1, IMLSMST_SQL.mfg_ser_lot_no FROM PPORDFIL_SQL left join IMLSMST_SQL on PPORDFIL_SQL.user_def_fld_1 = IMLSMST_SQL.mfg_ser_lot_no Where (IMLSMST_SQL.mfg_ser_lot_no like '1%' and PPORDFIL_SQL.report_qty like '1.0000') AND (Cast(Left(IMLSMST_SQL.mfg_ser_lot_no,2) as Int) > 17) Order By PPORDFIL_SQL.user_def_fld_1 ">
        </asp:SqlDataSource>
                    </h3>
                  </td>
                </tr>
              </table>
            </asp:View>
          </asp:MultiView>
        </td>
      </tr>
    </table>

       </div>
        <div id="right"> 
            <table>
      <tr>
        <td>
          <asp:Button Text="Rack 1" BorderStyle="None" CssClass="Initial" ID="btnRack1" runat="server" OnClick="Rack1_Click" />
          <asp:Button Text="Rack 2" BorderStyle="None" CssClass="Initial" ID="btnRack2"  runat="server" OnClick="Rack2_Click" />
          <asp:Button Text="Rack 3" BorderStyle="None" CssClass="Initial" ID="btnRack3" runat="server" OnClick="Rack3_Click" />
          <asp:Button Text="Rack 4" BorderStyle="None" CssClass="Initial" ID="btnRack4" runat="server" OnClick="Rack4_Click" />
          <asp:Button Text="Rack 5" BorderStyle="None" CssClass="Initial" ID="btnRack5" runat="server" OnClick="Rack5_Click" />
          <asp:Button Text="Rack 6" BorderStyle="None" CssClass="Initial" ID="btnRack6" runat="server" OnClick="Rack6_Click" />
          <asp:Button Text="Rack 7" BorderStyle="None" CssClass="Initial" ID="btnRack7" runat="server" OnClick="Rack7_Click" />
          <asp:Button Text="Rack 8" BorderStyle="None" CssClass="Initial" ID="btnRack8" runat="server" OnClick="Rack8_Click" />
          <asp:Button Text="Ground 1" BorderStyle="None" CssClass="Initial" ID="btnGround1" runat="server" OnClick="Ground1_Click" />
          <asp:Button Text="Ground 2" BorderStyle="None" CssClass="Initial" ID="btnGround2" runat="server" OnClick="Ground2_Click" />
          <asp:Button Text="Ground 3" BorderStyle="None" CssClass="Initial" ID="btnGround3" runat="server" OnClick="Ground3_Click" />
          <asp:Button Text="Ground 4" BorderStyle="None" CssClass="Initial" ID="btnGround4" runat="server" OnClick="Ground4_Click" />
        <asp:MultiView ID="LocationView" runat="server">
           
            <asp:View ID="Rack1" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                         <br />
                        <asp:GridView ID="gvRack1SlotsinA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack1SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />                                                             
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                       
                        <asp:GridView ID="gvRack1SlotsinB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack1SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />                                                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                        </h3>
                           <asp:SqlDataSource ID="sdsRack1SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '1' and Row = 'A' Order By Row, Slot"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsRack1SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '1' and Row = 'B' Order By Row, Slot"></asp:SqlDataSource>
                    
                  </td>
                </tr>
              </table>
            </asp:View>   
             <asp:View ID="Rack2" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <br />
                      <asp:GridView ID="gvRack2SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack2SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row A"  />                                
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                       
                        <asp:GridView ID="gvRack2SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack2SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B"  />                                
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                         <asp:GridView ID="gvRack2SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack2SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row C"  />                                
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                        </h3>
                           <asp:SqlDataSource ID="sdsRack2SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '2' and Row = 'A' Order By Row, Slot"></asp:SqlDataSource>
                           <asp:SqlDataSource ID="sdsRack2SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '2' and Row = 'B' Order By Row, Slot"></asp:SqlDataSource>
                           <asp:SqlDataSource ID="sdsRack2SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '2' and Row = 'C' Order By Row, Slot"></asp:SqlDataSource>
                    
                  </td>
                </tr>
              </table>
            </asp:View>
             <asp:View ID="Rack3" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <br />
                            <asp:GridView ID="gvRack3SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack3SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row A"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                       
                        <asp:GridView ID="gvRack3SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack3SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                         <asp:GridView ID="gvRack3SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack3SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                        </h3>
                           <asp:SqlDataSource ID="sdsRack3SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '3' and Row = 'A' Order By Row, Slot"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsRack3SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '3' and Row = 'B' Order By Row, Slot"></asp:SqlDataSource>
                      <asp:SqlDataSource ID="sdsRack3SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '3' and Row = 'C' Order By Row, Slot"></asp:SqlDataSource>
                    
              
                  </td>
                </tr>
              </table>
            </asp:View>               
             <asp:View ID="Rack4" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <br />
                        <asp:GridView ID="gvRack4SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack4SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row A" />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                       
                        <asp:GridView ID="gvRack4SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack4SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />                                
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>                        
                        </h3>
                           <asp:SqlDataSource ID="sdsRack4SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '4' and Row = 'A' Order By Row, Slot"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsRack4SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '4' and Row = 'B' Order By Row, Slot"></asp:SqlDataSource>
                                         
              
                  </td>
                </tr>
              </table>
            </asp:View>   
             <asp:View ID="Rack5" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <br />
                       <asp:GridView ID="gvRack5SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack5SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row A"  />
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                       
                        <asp:GridView ID="gvRack5SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack5SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B" />
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                        </h3>
                           <asp:SqlDataSource ID="sdsRack5SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '5' and Row = 'A' Order By Row, Slot"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsRack5SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '5' and Row = 'B' Order By Row, Slot"></asp:SqlDataSource>
                    
            
                  </td>
                </tr>
              </table>
            </asp:View>
             <asp:View ID="Rack6" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <br />
                            <asp:GridView ID="gvRack6SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack6SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row A"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                       
                        <asp:GridView ID="gvRack6SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack6SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                         <asp:GridView ID="gvRack6SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack6SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                        </h3>
                           <asp:SqlDataSource ID="sdsRack6SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '6' and Row = 'A' Order By Row, Slot"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsRack6SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '6' and Row = 'B' Order By Row, Slot"></asp:SqlDataSource>
                      <asp:SqlDataSource ID="sdsRack6SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '6' and Row = 'C' Order By Row, Slot"></asp:SqlDataSource>                 
                   </td>
                </tr>
              </table>
            </asp:View>
              <asp:View ID="Rack7" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <br />
                            <asp:GridView ID="gvRack7SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack7SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row A"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                       
                        <asp:GridView ID="gvRack7SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack7SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                         <asp:GridView ID="gvRack7SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack7SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                        </h3>
                           <asp:SqlDataSource ID="sdsRack7SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '7' and Row = 'A' Order By Row, Slot"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsRack7SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '7' and Row = 'B' Order By Row, Slot"></asp:SqlDataSource>
                      <asp:SqlDataSource ID="sdsRack7SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '7' and Row = 'C' Order By Row, Slot"></asp:SqlDataSource>                 
                   </td>
                </tr>
              </table>
            </asp:View>
                   <asp:View ID="Rack8" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <br />
                            <asp:GridView ID="gvRack8SlotsInA" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack8SlotsA" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" HorizontalAlign="Justify" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row A"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                       
                        <asp:GridView ID="gvRack8SlotsInB" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack8SlotsB" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                         <asp:GridView ID="gvRack8SlotsInC" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRack8SlotsC" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Row B"  />                               
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                        </h3>
                           <asp:SqlDataSource ID="sdsRack8SlotsA" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '8' and Row = 'A' Order By Row, Slot"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsRack8SlotsB" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '8' and Row = 'B' Order By Row, Slot"></asp:SqlDataSource>
                      <asp:SqlDataSource ID="sdsRack8SlotsC" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '8' and Row = 'C' Order By Row, Slot"></asp:SqlDataSource>                 
                   </td>
                </tr>
              </table>
            </asp:View>                  
             <asp:View ID="Ground1" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <br />
                         <asp:GridView ID="gvGround1" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround1" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Ground 1" />
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                        </h3>
                           <asp:SqlDataSource ID="sdsGround1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '100' and Row = 'G' Order By Row, Slot"></asp:SqlDataSource>
                  
                  </td>
                </tr>
              </table>
            </asp:View>
             <asp:View ID="Ground2" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <br />
                      <asp:GridView ID="gvGround2" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround2" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Ground 2" />
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                        </h3>
                           <asp:SqlDataSource ID="sdsGround2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '200' and Row = 'G' Order By Row, Slot"></asp:SqlDataSource>
                  
                  </td>
                </tr>
              </table>
            </asp:View>      
             <asp:View ID="Ground3" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <br />
                      <asp:GridView ID="gvGround3" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround3" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Ground 3" />
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                        </h3>
                           <asp:SqlDataSource ID="sdsGround3" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '300' and Row = 'G' Order By Row, Slot"></asp:SqlDataSource>
                  
                  </td>
                </tr>
              </table>
            </asp:View>      
            <asp:View ID="Groudn4" runat="server">
                 <table style="width: 100%; border-width: 0px; border-color: #0026ff; border-style: solid">
                <tr>
                  <td>
                    <h3>
                        <br />
                      <asp:GridView ID="gvGround4" class="gvLocs" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGround4" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" DataKeyNames="SlotKey">

                            <Columns>
                                <asp:CommandField ShowSelectButton="True" HeaderText="Ground 4S" />
                                <asp:BoundField DataField="Slot" HeaderText="Slot" />
                                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                            </Columns>

                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />

                        </asp:GridView>
                        </h3>
                           <asp:SqlDataSource ID="sdsGround4" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Rack, Row, Slot, SlotKey, Filled, ProdNo From Yard_Master_Locations Where Rack = '400' and Row = 'G' Order By Row, Slot"></asp:SqlDataSource>
                  
                  </td>
                </tr>
              </table>
            </asp:View>      
        </asp:MultiView>
            </td>
      </tr>
    </table>
    </div>      
    <div id="actions">
        
        
        <br />
        <br />
        <br />
        <br />
        <asp:Label ID="lblSelected" cssClass="selectionResults" runat="server" Text="Selected:" Font-Bold="True"></asp:Label> <br />  
        <asp:Label ID="lblProd" cssClass="selectionResults" runat="server" Text="Prod #:    " Font-Bold="True"></asp:Label>   
        <asp:Label ID="lblProdSet" cssClass="selectionResultValue" runat="server" Text="" Font-Bold="True"></asp:Label>
        <br />
        <asp:Label ID="lblLoc" cssClass="selectionResults" runat="server" Text="Location:    " Font-Bold="True"></asp:Label>   
        <asp:Label ID="lblLocSet" cssClass="selectionResultValue" runat="server" Text="" Font-Bold="True"></asp:Label>

        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="btnSave" runat="server" Text="Save" Width="100px" />
         <br />
        <br />
         <br />
        <br />
         <br />
        <br />
        <asp:Button ID="btnClear" runat="server" Text="Clear Slot" Width="100px" />

    </div> 
    </form>
</body>
</html>
