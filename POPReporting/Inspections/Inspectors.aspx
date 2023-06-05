<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Inspectors.aspx.vb" Inherits="Inspections_Inspectors" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inspectors</title>
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

        .table-subheader {
            font-family: Calibri;
            color: green;
            font-size: 18px;
            font-weight: bold;
        }

        .newStyle7 {
            font-family: calibri;
            font-size: 14px;
            font-weight: bold;
            width: 100%;
        }

        .auto-style1 {
        }

        .auto-style2 {
            margin-left: 4px;
        }

        .auto-style3 {
        }

        .auto-style4 {
        }
    </style>

</head>
<body>


    <form id="form1" runat="server">
        <div>

            <div class="newStyle7">
                <asp:Image ID="Image1" runat="server" ImageUrl="../Images/logo-smaller.png" />

                &nbsp;&nbsp;&nbsp;&nbsp; Search By Prod #:
                <asp:TextBox ID="tbSearchProdNo" runat="server" AutoPostBack="True" CssClass="auto-style1" Height="22px" Width="83px"></asp:TextBox>

                <asp:Button ID="btnClearProdNo" runat="server" Text="Clear" />
                &nbsp; SO #<asp:TextBox ID="tbSONo" runat="server" AutoPostBack="True" CssClass="auto-style2" Width="83px"></asp:TextBox>
                <asp:Button ID="btnClearSO" runat="server" Text="Clear" />
                &nbsp; Customer:
                <asp:TextBox ID="tbSearchCusName" runat="server" AutoPostBack="True" CssClass="auto-style3" Height="22px" Width="83px"></asp:TextBox>

                <asp:Button ID="btnClearnCusName" runat="server" Text="Clear" />
                &nbsp; Boat Model:
                <asp:TextBox ID="tbSearchModel" runat="server" AutoPostBack="True" CssClass="auto-style4" Height="22px" Width="83px"></asp:TextBox>

                <asp:Button ID="btnClearModel" runat="server" Text="Clear" />&nbsp;&nbsp; Show:
                <asp:DropDownList ID="ddlShowSelect" runat="server" AutoPostBack="True">
                    <asp:ListItem Value="3">All</asp:ListItem>
                    <asp:ListItem Value="1">Incomplete</asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;Tube Damage:
            <asp:DropDownList ID="ddlTubeDamage" runat="server" AutoPostBack="True">
                <asp:ListItem Value="0">All</asp:ListItem>
                <asp:ListItem Value="1">Damaged</asp:ListItem>
            </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
                 <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
            </div>
            <br />
            <asp:GridView ID="gvOverview" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsPopReporting" CellPadding="5" PageSize="45" AllowPaging="True">
                <Columns>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo">
                        <ItemStyle Font-Bold="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="SONo" HeaderText="SO #">
                        <ItemStyle Font-Bold="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DateDue" HeaderText="Due Date" DataFormatString="{0:d}">
                        <ItemStyle Font-Bold="True" />
                    </asp:BoundField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" CssClass="newStyle2" Text='<%# Eval("ItemNo") %>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='../Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                            <br />
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="CurrentStatus" HeaderText="Current Status" >                
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Tubes">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnTubes" runat="server" ImageUrl='<%# Eval("TubeInspectionCount", "../Images/Inspector{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gototubeinsp" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Electrical">
                        <ItemTemplate>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Fuel">
                        <ItemTemplate>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Offline">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "../Images/boatstatus{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotooffline" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Notes">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "../Images/notes{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotonotes" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tube Damage">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnTubeDamage" runat="server" ImageUrl='<%# Eval("HasTubeDamage", "../Images/tubedamage{0}.png")%>' CommandArgument='<%# Eval("ProdNo") & ";" & Eval("ItemNo")%>' CommandName="gototubedamage" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerSettings PageButtonCount="15" />
                <RowStyle Height="50px" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.SharkhideNeeded, BML_POPREPORTING.WavetamerNeeded, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FurniturePrepLastUpdated, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.TrimStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.RiggingNeeded, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, HasTubeDamage, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.SONo, Convert(date,BML_POPREPORTING_GREENLIGHTS.DueDate) as DateDue, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes,cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded, BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus,(CASE WHEN cast(Rails_Tracking.PF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.PF_Received as varchar) END) + (CASE WHEN cast(Rails_Tracking.SF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.SF_Received as varchar) END) as QFrontRailsStatus, (Select Count(Distinct(ProdNo)) From Inspections_Tubes where Inspections_Tubes.ProdNo = BML_POPREPORTING.ProdNo) as TubeInspectionCount, CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' When BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus ='1' Then 'Rails' When BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus ='1' Then 'Floors' When BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus ='1' Then 'Frames' End as CurrentStatus FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo LEFT JOIN RAILS_TRACKING on BML_POPREPORTING.PRODNO = RAILS_TRACKING.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.CusName LIKE '%' + @SearchCusName + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchModel + '%') AND (BML_POPREPORTING_GREENLIGHTS.SoNo LIKE '%' + @SearchSO + '%') AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus &lt;= @CompleteStatus) AND (HasTubeDamage &gt;= @HasTubeDamage) ORDER BY Convert(integer,BML_POPREPORTING.ProdNo)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="tbSearchProdNo" Name="Search" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbSearchCusName" Name="SearchCusName" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbSearchModel" Name="SearchModel" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbSoNo" Name="SearchSO" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="CompleteStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="3" />
                    <asp:ControlParameter ControlID="ddlTubeDamage" Name="HasTubeDamage" PropertyName="SelectedValue" Type="Int32" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>


    </form>

</body>
</html>
