<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OverviewSearch.aspx.vb" Inherits="OverviewSearch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Overview - Searchable</title>
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
                <asp:Image ID="Image1" runat="server" ImageUrl="Images/logo-smaller.png" />

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
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Prod Line:&nbsp;
                <%--<asp:DropDownList ID="ddlBldg" runat="server" AutoPostBack="true">
                    <asp:ListItem Text="All" Value="%"></asp:ListItem>
                    <asp:ListItem Text="Main" Value="M"></asp:ListItem>
                    <asp:ListItem Text="Value" Value="V"></asp:ListItem>
                    <asp:ListItem Text="South" Value="S"></asp:ListItem>
                    <asp:ListItem Text="Paint" Value="P"></asp:ListItem>
                </asp:DropDownList>--%>
                <asp:DropDownList runat="server" ID="ddlProdLine" AutoPostBack="True" DataSourceID="sdsProdLines" DataTextField="ProdLineDesc" DataValueField="ProdLineID"></asp:DropDownList>

                <asp:SqlDataSource runat="server" ID="sdsProdLines" ConnectionString='<%$ ConnectionStrings:bml_dataConnectionString %>' SelectCommand="SELECT * FROM [ProductionLines] WHERE ([Disabled] = 0) ORDER BY [ProdLineDesc]"></asp:SqlDataSource>

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
                    <asp:TemplateField HeaderText="F">
                        <ItemTemplate>
                            <asp:Image ID="imgFurnitureStatus" runat="server" ImageUrl='<%# Eval("FurnitureStatus", "./Images/{0}.png") %>' AlternateText='Furniture' ToolTip='<%# Eval("FurniturePrepLastUpdated")%>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
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
                            <asp:ImageButton ID="btnCentertube" Enabled="false" runat="server" Visible=' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "./Images/{0}.png")%>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:ImageField DataImageUrlField="ElectricalStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="G|H" ItemStyle-HorizontalAlign="Center">
                    </asp:ImageField>
                    <asp:TemplateField HeaderText="Q Front">
                        <ItemTemplate>
                            <asp:Image ID="QFront" Visible=' <%# Eval("QFrontNeeded") = 1%>' ImageUrl='<%# Eval("QFrontStatus", "./Images/{0}.png")%>' runat="server" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Q PF|SF">
                        <ItemTemplate>
                            <asp:Image ID="QFrontRails" Visible='<%# Eval("QFrontNeeded") = 1%>' ImageUrl='<%# Eval("QFrontRailsStatus", "./Images/{0}.png")%>' runat="server" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="A/T">
                        <ItemTemplate>
                            <asp:Image ID="ArchTower" Visible=' <%# Eval("ArchTowerNeeded") = 1%>' ImageUrl='<%# Eval("ArchTowerStatus", "./Images/{0}.png")%>' runat="server" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:ImageField DataImageUrlField="FramesInstalledStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Frames">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" CssClass="newStyle2" Text='<%# Eval("ItemNo") %>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotoorderdetails" />
                            <asp:ImageButton ID="ImageButton2" ImageUrl='./Images/getfullboatdetails.png' runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotofullorderdetails" />
                            <br />
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                    <asp:ImageField DataImageUrlField="FramesInstalledStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Frames" Visible="False">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                    <asp:ImageField DataImageUrlField="FloorsInstalledStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Floors">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                    <asp:ImageField DataImageUrlField="TrimStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Trim">
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
                    <asp:TemplateField HeaderText="Rigging - South">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnRigging" Enabled="false" runat="server" Visible=' <%# Eval("RiggingNeededFlag") = "S" %>' ImageUrl='<%# Eval("RiggingStatus", "./Images/complete_status{0}.png")%>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Wavetamer">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnWaveTamer" Enabled="false" runat="server" Visible=' <%# Eval("WavetamerNeeded") = 1%>' ImageUrl='<%# Eval("WavetamerStatus", "./Images/complete_status{0}.png")%>' AlternateText='Wavetamer' ToolTip='Wavetamer' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sharkhide">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnSharkhide" Enabled="false" runat="server" Visible=' <%# Eval("SharkhideNeeded") = 1%>' ImageUrl='<%# Eval("SharkhideStatus", "./Images/complete_status{0}.png")%>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rigging - Main">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnRiggingM" Enabled="false" runat="server" Visible=' <%# Eval("RiggingNeededFlag") = "M"%>' ImageUrl='<%# Eval("RiggingStatus", "./Images/complete_status{0}.png")%>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:ImageField DataImageUrlField="CompleteStatus" DataImageUrlFormatString="./Images/complete_status{0}.png" HeaderText="Complete">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ImageField>
                    <asp:TemplateField HeaderText="Offline">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnOffline" runat="server" ImageUrl='<%# Eval("IsBoatOffline", "./Images/boatstatus{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotooffline" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Notes">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnNotes" runat="server" ImageUrl='<%# Eval("BoatHasNotes", "./Images/notes{0}.png")%>' CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotonotes" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tube Damage">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnTubeDamage" runat="server" ImageUrl='<%# Eval("HasTubeDamage", "./Images/tubedamage{0}.png")%>' CommandArgument='<%# Eval("ProdNo") & ";" & Eval("ItemNo")%>' CommandName="gototubedamage" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Red Tag">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnRedTag" runat="server" ImageUrl='<%# Eval("IsRedTagged", "./Images/tag{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="gotoredtag" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerSettings PageButtonCount="15" />
                <RowStyle Height="50px" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, IsRedTagged, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.SharkhideNeeded, BML_POPREPORTING.WavetamerNeeded, BML_POPREPORTING.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FurniturePrepLastUpdated, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.TrimStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.RiggingStatus, BML_POPREPORTING_GREENLIGHTS.RiggingNeeded, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, HasTubeDamage, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.SONo, Convert(date,BML_POPREPORTING_GREENLIGHTS.DueDate) as DateDue, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes,cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, BML_POPREPORTING_GREENLIGHTS.QFrontNeeded, BML_POPREPORTING_GREENLIGHTS.QFrontStatus, BML_POPREPORTING_GREENLIGHTS.ArchTowerNeeded, BML_POPREPORTING_GREENLIGHTS.ArchTowerStatus,(CASE WHEN cast(Rails_Tracking.PF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.PF_Received as varchar) END) + (CASE WHEN cast(Rails_Tracking.SF_Received as varchar) = 1 THEN '2' ELSE cast(Rails_Tracking.SF_Received as varchar) END) as QFrontRailsStatus, Case When BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.RiggingNeeded = 1 then 'S' When BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.RiggingNeeded = 1 then 'M' When BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING_GREENLIGHTS.RiggingNeeded = 1 then 'M' else 'NO' end as RiggingNeededFlag, BML_POPREPORTING_GREENLIGHTS.ProdLineID, ProdLineDesc FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo LEFT JOIN RAILS_TRACKING on BML_POPREPORTING.PRODNO = RAILS_TRACKING.ProdNo Left Join ProductionLines on BML_POPREPORTING_GREENLIGHTS.ProdLineID = ProductionLines.ProdLineID WHERE (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.CusName LIKE '%' + @SearchCusName + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchModel + '%')AND (BML_POPREPORTING_GREENLIGHTS.SoNo LIKE '%' + @SearchSO + '%') AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus &lt;= @CompleteStatus) AND (HasTubeDamage &gt;= @HasTubeDamage) AND (BML_POPREPORTING_GREENLIGHTS.ProdLineID LIKE  '%' + @ProdLineID + '%') ORDER BY Convert(integer,BML_POPREPORTING.ProdNo)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="tbSearchProdNo" Name="Search" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbSearchCusName" Name="SearchCusName" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbSearchModel" Name="SearchModel" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbSoNo" Name="SearchSO" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="CompleteStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="3" />
                    <asp:ControlParameter ControlID="ddlTubeDamage" Name="HasTubeDamage" PropertyName="SelectedValue" Type="Int32" DefaultValue="0" />
                    <asp:ControlParameter ControlID="ddlProdLine" Name="ProdLineID" PropertyName="SelectedValue" DbType="String" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>


    </form>

</body>
</html>
