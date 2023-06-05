<%@ Page Language="VB" AutoEventWireup="false" Debug ="true" CodeFile="OverviewTest.aspx.vb" Inherits="OverviewTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Overview</title>
    <style type="text/css">
        .newStyle1 {
            font-family: calibri;
            font-size: 14px;
        }
        .newStyle2 {
            font-family: Calibri;
            font-weight: bold;
            font-size: large;
        }
        .table-subheader{
            font-family:Calibri;
            color: green;
            font-size: 18px; 
            font-weight:bold;              

        }
        .duedate {
            font-size: 12px;
            font-weight: bold;
            font-family: calibri;
        }
        </style>
        
</head>
<body>

    
    <form id="form1" runat="server">
    <div>
         
        
        <div class="newStyle7">
                <asp:HiddenField ID="hdnFurniturePrepTotal" runat="server" />
                <!-- #include file ="ovtoolbar.aspx" --> 
                </div>
        
       
        <asp:GridView ID="gvOverview" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsPopReporting" CellPadding="5" PageSize="15">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                <ItemStyle Font-Bold="True" />
                </asp:BoundField>
                <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="F">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="FG" AlternateText="Fiberglass">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="C">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="R">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="T">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
              
                <asp:TemplateField HeaderText="CT">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnCentertube" enabled= "false" runat="server" Visible = ' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "./Images/{0}.png")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" CssClass="newStyle2" Text='<%# Eval("ItemNo") %>'></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>                      
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("DueDate", "{0:d}")%>' CssClass="duedate"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>                
                <asp:ImageField DataImageUrlField="IsCustom" HeaderText="C" DataImageUrlFormatString="./Images/ovcustom{0}.png">
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="IsPilot" HeaderText="P" DataImageUrlFormatString="./Images/ovpilot{0}.png">
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FramesInstalledStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Frames">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FloorsInstalledStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Floors">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="RailsInstalledStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Rails">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FurnitureInstalledStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Furniture">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="HelmInstalledStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Helm">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="CleaningStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Inspection">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="FinalInspectionStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Final">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>                
                <asp:ImageField DataImageUrlField="ShrinkwrapStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Shrink-Wrap">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Rigging">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnRigging" Enabled="false" runat="server" Visible =' <%# Eval("RiggingNeeded") = 1%>' ImageUrl='<%# Eval("RiggingStatus", "./Images/complete_status{0}.png")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Wavetamer">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnWaveTamer" Enabled="false" runat="server" Visible =' <%# Eval("WavetamerNeeded") = 1%>' ImageUrl='<%# Eval("WavetamerStatus", "./Images/complete_status{0}.png")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sharkhide">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnSharkhide" enabled = "false" runat="server" Visible =' <%# Eval("SharkhideNeeded") = 1%>' ImageUrl='<%# Eval("SharkhideStatus", "./Images/complete_status{0}.png")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="CompleteStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Complete">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Offline">
                    <ItemTemplate>
                      <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "./Images/boatstatus{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName ="gotooffline" />
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName = "gotonotes" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="15" />
            <RowStyle Height="50px" />
        </asp:GridView>
             
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING.SharkhideNeeded, BML_POPREPORTING.SONo, BML_POPREPORTING.WavetamerNeeded, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING.IsCustom, BML_POPREPORTING.IsPilot, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.RiggingNeeded, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus &lt;= @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) AND (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING.ItemNo LIKE '%' + @SearchBoat + '%') ORDER BY BML_POPREPORTING.ProdNo">
            <SelectParameters>                              
                <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                 <asp:ControlParameter ControlID="ddlShowSelect" Name="CompleteStatus" PropertyName="SelectedValue" DefaultValue="0" Type="Int32" />
                 <asp:ControlParameter ControlID="tbSearch" Name="Search" DefaultValue='%' Type="String" />
                 <asp:ControlParameter ControlID="tbSearchBoat" Name="SearchBoat" DefaultValue='%' Type="String" />
             </SelectParameters>
        </asp:SqlDataSource>
  
    </div>   

  
    </form>
          
</body>
</html>
