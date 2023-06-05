<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OverviewByDate.aspx.vb" Inherits="OverviewByDate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Overview With Dates</title>
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
        
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
           
            <ContentTemplate>
               
        <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="5000" ontick="Timer1_Tick"></asp:Timer>
        <asp:GridView ID="gvOverview" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="PopNo" DataSourceID="sdsPopReporting" CellPadding="5" PageSize="15" AllowPaging="True">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="ProdNo" SortExpression="ProdNo" >
                </asp:BoundField>
                <asp:BoundField DataField="PopNo" HeaderText="PopNo" ReadOnly="True" SortExpression="PopNo" />
                <asp:BoundField DataField="CusNo" HeaderText="CusNo" SortExpression="CusNo" />
                <asp:BoundField DataField="CusName" HeaderText="CusName" SortExpression="CusName" />
                <asp:BoundField DataField="ItemNo" HeaderText="ItemNo" SortExpression="ItemNo" />
                <asp:ImageField DataImageUrlField="FurnitureStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="F">
                </asp:ImageField>
                <asp:BoundField DataField="FurniturePrepLastUpdated" HeaderText="FurniturePrepLastUpdated" SortExpression="FurniturePrepLastUpdated" />
                 <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="FG">
                </asp:ImageField>
                <asp:BoundField DataField="FiberglassLastUpdated" HeaderText="FiberglassLastUpdated" SortExpression="FiberglassLastUpdated" />
                 <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="C">
                </asp:ImageField>
                <asp:BoundField DataField="CoversLastUpdated" HeaderText="CoversLastUpdated" SortExpression="CoversLastUpdated" />
                 <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="R">
                </asp:ImageField>                
                <asp:BoundField DataField="RailsLastUpdated" HeaderText="RailsLastUpdated" SortExpression="RailsLastUpdated" />
                 <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="T">
                </asp:ImageField>
                <asp:BoundField DataField="TubesLastUpdated" HeaderText="TubesLastUpdated" SortExpression="TubesLastUpdated" />
                <asp:BoundField DataField="CentertubeNeeded" HeaderText="CT Needed" SortExpression="CentertubeNeeded" />
                 <asp:ImageField DataImageUrlField="CentertubeStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="CT">
                </asp:ImageField>
                <asp:BoundField DataField="Centertube" HeaderText="Centertube" SortExpression="Centertube" />
                <asp:BoundField DataField="DateAllGreen" HeaderText="DateAllGreen" SortExpression="DateAllGreen" />
                 <asp:ImageField DataImageUrlField="FramesInstalledStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Frames">
                </asp:ImageField>
                <asp:BoundField DataField="FramesInstalled" HeaderText="Frames Date" SortExpression="FramesInstalled" />
                 <asp:ImageField DataImageUrlField="HelmBuildStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="HB">
                </asp:ImageField>
                <asp:BoundField DataField="HelmBuild" HeaderText="Helm Build Date" SortExpression="HelmBuild" />
                 <asp:ImageField DataImageUrlField="HelmKittingStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="HK">
                </asp:ImageField>
                <asp:BoundField DataField="HelmKitting" HeaderText="Helm Kitting Date" SortExpression="HelmKitting" />
                 <asp:ImageField DataImageUrlField="FloorsInstalledStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="F">
                </asp:ImageField>
                <asp:BoundField DataField="FloorsInstalled" HeaderText="Floors Date" SortExpression="FloorsInstalled" />
                 <asp:ImageField DataImageUrlField="RailsInstalledStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="R">
                </asp:ImageField>
                <asp:BoundField DataField="RailsInstalled" HeaderText="Rails Date" SortExpression="RailsInstalled" />
                 <asp:ImageField DataImageUrlField="FurnitureInstalledStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="F">
                </asp:ImageField>
                <asp:BoundField DataField="FurnitureInstalled" HeaderText="Furniture Date" SortExpression="FurnitureInstalled" />
                 <asp:ImageField DataImageUrlField="HelmInstalledStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="H">
                </asp:ImageField>
                <asp:BoundField DataField="HelmInstalled" HeaderText="Helm Date" SortExpression="HelmInstalled" />
                 <asp:ImageField DataImageUrlField="CleaningStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="C">
                </asp:ImageField>
                <asp:BoundField DataField="Cleaning" HeaderText="Cleaning Date" SortExpression="Cleaning" />
                 <asp:ImageField DataImageUrlField="FinalInspectionStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="F">
                </asp:ImageField>
                <asp:BoundField DataField="FinalInspection" HeaderText="Final Date" SortExpression="FinalInspection" />
                 <asp:ImageField DataImageUrlField="ShrinkwrapStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="SW">
                </asp:ImageField>
                <asp:BoundField DataField="ShrinkWrap" HeaderText="Shrink Date" SortExpression="ShrinkWrap" />
                <asp:BoundField DataField="WavetamerNeeded" HeaderText="WT Needed" SortExpression="WavetamerNeeded" />
                 <asp:ImageField DataImageUrlField="WaveTamerStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="WT">
                </asp:ImageField>
                <asp:BoundField DataField="WaveTamerInstalled" HeaderText="WT Date" SortExpression="WaveTamerInstalled" />
                 <asp:ImageField DataImageUrlField="BuildOptionsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="BO">
                </asp:ImageField>
                <asp:BoundField DataField="BuildOptions" HeaderText="Build Options Date" SortExpression="BuildOptions" />
                <asp:BoundField DataField="SharkhideNeeded" HeaderText="SH Needed" SortExpression="SharkhideNeeded" />
                 <asp:ImageField DataImageUrlField="SharkhideStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="SH">
                </asp:ImageField>
                <asp:BoundField DataField="SharkhideInstalled" HeaderText="SH Date" SortExpression="SharkhideInstalled" />
                 <asp:ImageField DataImageUrlField="CompleteStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="C">
                </asp:ImageField>
                <asp:BoundField DataField="Complete" HeaderText="Complete Date" SortExpression="Complete" />
                <asp:BoundField DataField="BoatHasNotes" HeaderText="BoatHasNotes" SortExpression="BoatHasNotes" />
                <asp:BoundField DataField="IsBoatOffline" HeaderText="IsBoatOffline" SortExpression="IsBoatOffline" />
            </Columns>
            <PagerSettings PageButtonCount="15" />
            <RowStyle Height="50px" />
        </asp:GridView>
             
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.SharkhideNeeded, BML_POPREPORTING.WavetamerNeeded, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.FurniturePrepLastUpdated, BML_POPREPORTING_GREENLIGHTS.FiberglassLastUpdated, BML_POPREPORTING_GREENLIGHTS.CoversLastUpdated, BML_POPREPORTING_GREENLIGHTS.RailsLastUpdated, BML_POPREPORTING_GREENLIGHTS.TubesLastUpdated, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, BML_POPREPORTING_GREENLIGHTS.FloorsInstalled, BML_POPREPORTING_GREENLIGHTS.RailsInstalled, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalled, BML_POPREPORTING_GREENLIGHTS.HelmInstalled, BML_POPREPORTING_GREENLIGHTS.Cleaning, BML_POPREPORTING_GREENLIGHTS.FinalInspection, BML_POPREPORTING_GREENLIGHTS.ShrinkWrap, BML_POPREPORTING_GREENLIGHTS.WaveTamerInstalled, BML_POPREPORTING_GREENLIGHTS.SharkhideInstalled, BML_POPREPORTING_GREENLIGHTS.Complete, BML_POPREPORTING_GREENLIGHTS.DateAllGreen, BML_POPREPORTING_GREENLIGHTS.Centertube, BML_POPREPORTING_GREENLIGHTS.HelmKitting, BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus, BML_POPREPORTING_GREENLIGHTS.HelmBuild, BML_POPREPORTING_GREENLIGHTS.BuildOptionsStatus, BML_POPREPORTING_GREENLIGHTS.BuildOptions, BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus &lt;= @CompleteStatus) AND (BML_POPREPORTING.DueDate &lt;= @DueDate) ORDER BY BML_POPREPORTING.ProdNo">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlShowSelect" Name="CompleteStatus" PropertyName="SelectedValue" DefaultValue="0" Type="Int32" />  
                <asp:ControlParameter ControlID="ddlDaysInAdvance" Name="DueDate" PropertyName="SelectedValue" DbType="Date" />
            </SelectParameters>
        </asp:SqlDataSource>
    </ContentTemplate>
           
            </asp:UpdatePanel>
    </div>   

  
    </form>
          
</body>
</html>
