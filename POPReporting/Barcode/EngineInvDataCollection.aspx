<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EngineInvDataCollection.aspx.vb" Inherits="Barcode_EngineInvDataCollection" Debug ="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Collect Engine Inventory Data</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        #left {
            width: 35%;
            float: left;
            font-family: Calibri;
        }

        #right {
            width: 65%;
            float: left;
            font-family: Calibri;
        }

        .header {
            font-size: 30px;
        }

        #buttons {
            width: 100%;
            height: 90px;
        }

        .inputs {
            font-size: 20px;
            margin-bottom: 5px;
        }


        .Initial {
            display: block;
            padding: 4px 18px 4px 18px;
            float: left;
            background: url("../Images/InitialImageBarcode.png") no-repeat right top;
            color: Black;
            font-weight: bold;
            font-size: 30px;
        }

            .Initial:hover {
                color: White;
                background: url("../Images/SelectedButtonBarcode.png") no-repeat right top;
            }

        .Clicked {
            float: left;
            display: block;
            background: url("../Images/SelectedButtonBarcode.png") no-repeat right top;
            padding: 4px 18px 4px 18px;
            color: Black;
            font-weight: bold;
            color: White;
            font-size: 30px;
        }

        }

        .savebtn {
            text-align: center;
        }
    </style>
</head>
<body>
    
    <form id="form1" runat="server">

        <div id="left">
            <div id="buttons">
                <asp:Button Text="Inventory" BorderStyle="None" CssClass="Initial" ID="Inventory" runat="server" OnClick="Inventory_Click" />
                <asp:Button Text="Yard" BorderStyle="None" CssClass="Initial" ID="Yard" runat="server" OnClick="Yard_Click" Visible="True" /><br />
            </div>

            <asp:MultiView ID="MainView" runat="server">
                <asp:View ID="vInv" runat="server">
                    <div "inv">
                        <asp:Label ID="Label1" runat="server" CssClass="inputs" Text="Eng Model:" Width="200px"></asp:Label><asp:TextBox ID="tbModelNo" runat="server" CssClass="inputs" Height="67px" Width="275px" BorderStyle="Solid"></asp:TextBox>
                    <br />                 
                    <asp:Label ID="Label2" runat="server" CssClass="inputs" Text="Eng Serial #:" Width="200px"></asp:Label><asp:TextBox ID="tbSerialNo" runat="server" CssClass="inputs" Height="69px" Width="275px" BorderStyle="Solid"></asp:TextBox>
                        <br />
                    <asp:Label ID="Label3" runat="server" CssClass="inputs" Text="Eng Location:" Width="200px"></asp:Label><asp:TextBox ID="tbEngineLoc" runat="server" CssClass="inputs" Height="69px" Width="275px" BorderStyle="Solid"></asp:TextBox>
                        <br />
                    <br />                    
                        <br />
                        <br />
                    <asp:Button ID="btnInvSave" runat="server" Text="Submit" CssClass="savebtn" Height="63px" Width="216px" />
                        </div>
                </asp:View>
                <asp:View ID="vYard" runat="server">                                         
                      <asp:GridView ID="gvSerialBoats" runat="server" AutoGenerateColumns="False" Caption="Completed Boats That Are Rigged" DataSourceID="sdsSerialBoats" CellPadding="10" CellSpacing="2" DataKeyNames="mfg_ser_lot_no" CssClass="newStyle1">
                          <Columns>
                              <asp:BoundField DataField="mfg_ser_lot_no" HeaderText="Prod #" />
                              <asp:TemplateField HeaderText="SO #" Visible="True">
                                  <ItemTemplate>
                                      <asp:Label ID="lblSONo" runat="server" Text=""></asp:Label>
                                  </ItemTemplate>
                              </asp:TemplateField>
                              <asp:TemplateField HeaderText="Model/Dealer">
                                  <ItemTemplate>
                                      <strong><asp:Label ID="Label4" runat="server" Text='<%#Eval("item_no")%>'></asp:Label></strong>
                                      <br>
                                      </br>                                      
                                      <asp:Label ID="Label5" cssClass="newStyle1" runat="server" Text='<%#Eval("cus_name")%>'></asp:Label>
                                  </ItemTemplate>
                              </asp:TemplateField>                              
                              <asp:BoundField DataField="ser_lot_no" HeaderText="Boat Serial" />
                              <asp:TemplateField HeaderText="Rack Loc">
                                  <ItemTemplate>
                                      <asp:Label ID="lblCompRackLoc" runat="server" Text=""></asp:Label>
                                  </ItemTemplate>
                                  <ItemStyle HorizontalAlign="Center" />
                              </asp:TemplateField>
                              <asp:TemplateField HeaderText="Engine 1 Line #" Visible="False">
                                  <ItemTemplate>
                                      <asp:Label ID="lblEngLineSeqNo" runat="server" Text=""></asp:Label>
                                  </ItemTemplate>
                              </asp:TemplateField>
                              <asp:TemplateField HeaderText="Eng 1" Visible="False">
                                  <ItemTemplate>
                                      <asp:Label ID="lblCompEng" runat="server" Text=""></asp:Label>
                                  </ItemTemplate>
                              </asp:TemplateField>
                              <asp:TemplateField HeaderText="Eng Serial(s)">
                                  <ItemTemplate>
                                      <asp:Label ID="lblCompEngSerial" runat="server" Text="" Visible="False"></asp:Label><asp:Button ID="btnEng1Serial" runat="server" OnClick="btnEng1Serial_Click" CommandArgument='<%#Eval("mfg_ser_lot_no")%>' /><br /><br />
                                      <asp:Label ID="lblCompEng2Serial" runat="server" Text="" Visible="False"></asp:Label><asp:Button ID="btnEng2Serial" runat="server" OnClick="btnEng2Serial_Click" CommandArgument='<%#Eval("mfg_ser_lot_no")%>' />
                                  </ItemTemplate>
                                  <ItemStyle HorizontalAlign="Center" />
                              </asp:TemplateField>                             
                              <asp:TemplateField HeaderText="Engine 2 Line #" Visible="False">
                                  <ItemTemplate>
                                      <asp:Label ID="lblEng2LineSeqNo" runat="server" Text="" Visible="False"></asp:Label>
                                  </ItemTemplate>
                              </asp:TemplateField>
                              <asp:TemplateField HeaderText="Eng 2" Visible="False">
                                  <ItemTemplate>
                                      <asp:Label ID="lblCompEng2" runat="server" Text=""></asp:Label>
                                  </ItemTemplate>
                              </asp:TemplateField>
                              <asp:TemplateField HeaderText="Eng LWR Unit(s)">
                                  <ItemTemplate>
                                      <asp:Label ID="lblCompLwr1Serial" runat="server" Text="" Visible="False"></asp:Label><asp:Button ID="btnLwr1Serial" runat="server" OnClick="btnLwr1Serial_Click" CommandArgument='<%#Eval("mfg_ser_lot_no")%>' /><br /><br />
                                      <asp:Label ID="lblCompLwr2Serial" runat="server" Text="" Visible="False"></asp:Label><asp:Button ID="btnLwr2Serial" runat="server" OnClick="btnLwr2Serial_Click" CommandArgument='<%#Eval("mfg_ser_lot_no")%>' />
                                  </ItemTemplate>
                                  <ItemStyle HorizontalAlign="Center" />
                              </asp:TemplateField>
                          </Columns>
                      </asp:GridView>
                    <asp:SqlDataSource ID="sdsSerialBoats" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT IMLSMST_SQL.item_no, IMLSMST_SQL.mfg_ser_lot_no, IMLSMST_SQL.ser_lot_no, cus_name FROM IMLSMST_SQL Inner join PPORDFIL_SQL on IMLSMST_SQL.mfg_ser_lot_no = PPORDFIL_SQL.user_def_fld_1 Where (IMLSMST_SQL.mfg_ser_lot_no like '1%' or IMLSMST_SQL.mfg_ser_lot_no like '2%') Order By IMLSMST_SQL.mfg_ser_lot_no"></asp:SqlDataSource>
                      <br />
                      <asp:GridView ID="gvProdBoats" runat="server" AutoGenerateColumns="False" DataSourceID="sdsNeedRigging" Caption="Production Boats That Need Rigged and Are Floored" Visible="False">
                          <Columns>
                              <asp:BoundField DataField="ProdNo" HeaderText="Prod" SortExpression="ProdNo" />                             
                              <asp:BoundField DataField="CusName" HeaderText="Dlr" SortExpression="CusName" />
                              <asp:BoundField DataField="ItemNo" HeaderText="Model" SortExpression="ItemNo" />
                              <asp:BoundField DataField="BuildLoc" HeaderText="Bldg" SortExpression="BuildLoc" />
                              <asp:BoundField DataField="CurrentStatus" HeaderText="Status" SortExpression="CurrentStatus" />
                              <asp:BoundField DataField="SlotKey" HeaderText="Rack Loc" SortExpression="SlotKey" />
                              <asp:BoundField DataField="DateIn" HeaderText="Date In" SortExpression="DateIn" />                              
                              <asp:TemplateField HeaderText="Boat Serial">                                  
                                  <ItemTemplate>
                                      <asp:Label ID="lblBoatSerial" runat="server" Text=""></asp:Label>
                                  </ItemTemplate>
                              </asp:TemplateField>                                      
                              <asp:TemplateField HeaderText="Eng">
                                  <ItemTemplate>
                                      <asp:Label ID="lblEng" runat="server" Text=""></asp:Label>
                                  </ItemTemplate>
                              </asp:TemplateField>
                              <asp:TemplateField HeaderText="Eng Serial">
                                  <ItemTemplate>
                                      <asp:Label ID="lblEngSerial" runat="server" Text=""></asp:Label>
                                  </ItemTemplate>
                              </asp:TemplateField>
                          </Columns>
                      </asp:GridView>
                      <asp:SqlDataSource ID="sdsNeedRigging" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.[ProdNo], BML_POPREPORTING.[CusName], BML_POPREPORTING.[ItemNo], BML_POPREPORTING_GREENLIGHTS.[BuildLoc], [SlotKey], DateIn, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus FROM [BML_POPREPORTING] Left join Yard_Master_Locations on BML_POPREPORTING.ProdNo = Yard_Master_Locations.ProdNo Left join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING.[RiggingNeeded] = @RiggingNeeded) and FloorsInstalledStatus = 2 ORDER BY [ProdNo]">
                          <SelectParameters>
                              <asp:Parameter DefaultValue="1" Name="RiggingNeeded" Type="Int32" />
                          </SelectParameters>
                      </asp:SqlDataSource>
                      <br />

                </asp:View>
            </asp:MultiView>
        </div>

        <div id="right" runat="server">
            <asp:Label ID="lblRecentScans" cssClass="header" runat="server" Text="Recents Scans"></asp:Label>
            &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnExport" runat="server" Text="Export" />
            <asp:GridView ID="gvRecent" runat="server" DataKeyNames="AutoID" DataSourceID="sdsEngineInv" AutoGenerateColumns="False" CssClass="newStyle1" Width="100%" PageSize="7">
                <Columns>                   
                    <asp:BoundField DataField="EngModel" HeaderText="Model" />
                    <asp:BoundField DataField="EngSerial" HeaderText="Serial #" />
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                    <asp:TemplateField HeaderText="Entered">
                        <ItemTemplate>
                            <asp:Label runat="server" Text='<%#Eval("DateEntered")%>'></asp:Label><br />
                            <asp:Label runat="server" Text='<%#Eval("EnteredBy")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:BoundField DataField="Loc" HeaderText="Eng Location" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsEngineInv" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT * FROM Engines order by DateEntered desc"></asp:SqlDataSource>
        </div>


        <asp:HiddenField ID="hdnTabID" runat="server" />


    </form>
</body>
</html>
