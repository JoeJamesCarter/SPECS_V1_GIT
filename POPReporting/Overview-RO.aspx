<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Overview-RO.aspx.vb" Inherits="Overview_RO" MaintainScrollPositionOnPostback="true"  %>

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
        .auto-style1 {
            text-align: center;
        }
        .table-subheader{
            font-family:Calibri;
            color: green;
            font-size: 18px; 
            font-weight:bold;              

        }
        </style>

    <script type="text/javascript"> <!--I added this because the update panel made the scrolling jump all over -->

    var xPos1, yPos1;
    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_pageLoaded(pageLoaded);
    prm.add_pageLoading(pageLoadingHandler);
    function pageLoaded(sender, args) {
        //window.scrollTo(xPos1,yPos1);
        document.documentElement.scrollLeft = xPos1;
        document.documentElement.scrollTop = yPos1;
    }
    function pageLoadingHandler(sender, args) {
        xPos1 = document.documentElement.scrollLeft;
        yPos1 = document.documentElement.scrollTop;
    }
    </script>
 
</head>
<body>

    
    <form id="form1" runat="server">
    <div>
         <asp:ScriptManager ID="ScriptManager1" runat="server">
             </asp:ScriptManager>
        
        <div class="newStyle7">
                <asp:HiddenField ID="hdnFurniturePrepTotal" runat="server" />
                <!-- #include file ="ovtoolbar.aspx" --> 
                </div>
         <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" ontick="Timer1_Tick"></asp:Timer>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
           
            <ContentTemplate>
               
       
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
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
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
                      <asp:ImageButton ID="btnOffline" runat="server" Visible =' <%# Eval("IsBoatOffline") = 1%>' ImageUrl='<%# Eval("IsBoatOffline", "./Images/boatstatus{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName ="gotooffline" />
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="Notes">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnNotes" runat="server" Visible =' <%# Eval("BoatHasNotes") = 1%>'  ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName = "gotonotes" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerSettings PageButtonCount="15" />
            <RowStyle Height="50px" />
        </asp:GridView>
             
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.SharkhideNeeded, BML_POPREPORTING.WavetamerNeeded, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus &lt;= @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) ORDER BY BML_POPREPORTING.ProdNo">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
                <asp:ControlParameter ControlID="ddlShowSelect" Name="CompleteStatus" PropertyName="SelectedValue" DefaultValue="0" Type="Int32" />  
            </SelectParameters>
        </asp:SqlDataSource>
    </ContentTemplate>
           
            </asp:UpdatePanel>
    </div>   

  
    </form>
          
</body>
</html>
