<%@ Page Language="VB" AutoEventWireup="false" CodeFile="History.aspx.vb" Inherits="History" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SPECS - HISTORY</title>

 <style>
     #body {
         font-family:Calibri;
         font-size:14px;
     }
        #choose {
            float:left;
            width:300px;
        }
     #grid {
         float:left;
     }

     .newStyle1 {
         font-family: Calibri;
         font-size: 16px;
         text-align: left;
     }

     .auto-style1 {
         font-family: Calibri;
         font-size: x-large;
         text-align: left;
     }

    </style>
</head>
   
<body> 
    <form id="form1" runat="server">
       
        <span class="auto-style1"><strong>HISTORY OF PROD # COMPLETED BY STATION BY DAY
    </strong>
    </span>
           <span class="auto-style1"><strong>
        <asp:Image ID="Image1" runat="server" ImageUrl="./Images/logo-smaller.png" />
    </strong>
    </span>
        <br />
        <br />
        <div id="choose">
            <span class="newStyle1">Choose a Workstation:&nbsp;
        </span>
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem Value="FurnitureStatus">Furniture</asp:ListItem>
            <asp:ListItem Value="FiberglassStatus">Fiberglass</asp:ListItem> 
            <asp:ListItem Value="FGI">Fiberglass Inspection</asp:ListItem>             
            <asp:ListItem Value="CoverStatus">Covers</asp:ListItem>
            <asp:ListItem Value="RailsStatus">Rails</asp:ListItem>
            <asp:ListItem Value="TubesStatus">Tubes</asp:ListItem>
            <asp:ListItem Value="OuterTubesRollerStatus">Outer Tubes - Roller</asp:ListItem>         
            <asp:ListItem Value="CentertubeStatus">Center Tubes</asp:ListItem>
            <asp:ListItem Value="Kitting1Status">Kitting 1</asp:ListItem>
            <asp:ListItem Value="Kitting2Status">Kitting 2</asp:ListItem>
            <asp:ListItem Value="Kitting3Status">Kitting 3</asp:ListItem>
            <asp:ListItem Value="Kitting4Status">Kitting 4</asp:ListItem>
            <asp:ListItem Value="AllKitsRcvd">South Kits</asp:ListItem>
            <asp:ListItem Value="GatesStatus">Gates</asp:ListItem>
            <asp:ListItem Value="GaugeStatus">Gauges</asp:ListItem>
            <asp:ListItem Value="HarnessStatus">Harnesses</asp:ListItem>
            <asp:ListItem Value="HelmBuildStatus">Helm Build</asp:ListItem>
            <asp:ListItem Value="FramesInstallStatus">Frames Install</asp:ListItem>
            <asp:ListItem Value="FloorsInstalledStatus">Floors</asp:ListItem>
            <asp:ListItem Value="TrimStatus">Trim</asp:ListItem>
            <asp:ListItem Value="RailsInstalledStatus">Rails Install</asp:ListItem>
            <asp:ListItem Value="FurnitureInstalledStatus">Furniture Install</asp:ListItem>
            <asp:ListItem Value="HelmInstalledStatus">Helms</asp:ListItem>
            <asp:ListItem Value="CleaningStatus">Inspection</asp:ListItem>
            <asp:ListItem Value="FinalInspectionStatus">Final Inspection</asp:ListItem>
            <asp:ListItem Value="SharkhideStatus">Sharkhide</asp:ListItem>
            <asp:ListItem Value="PhotosStatus">Photos</asp:ListItem>
            <asp:ListItem Value="ShrinkwrapStatus">Shrinkwrap</asp:ListItem>
            <asp:ListItem Value="WaveTamerStatus">Wavetamer</asp:ListItem>
            <asp:ListItem Value="CompleteStatus">Completed Boats</asp:ListItem>
        </asp:DropDownList>
            <span class="newStyle1">&nbsp;
        <br />
        Choose a Date:<br />
            </span>
        <asp:Calendar ID="Calendar1" runat="server" CssClass="newStyle1"></asp:Calendar>
            
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Show History for any Prod # ( ie. 2000001)" CssClass="newStyle1"></asp:Label>
            &nbsp;<br />
            <br />
&nbsp;<asp:TextBox ID="tbProdNo" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;<br/>
            Or Hull #: &nbsp;<br/><asp:TextBox ID="tbHullNo" runat="server"></asp:TextBox>
            <asp:ImageButton ID="ImageButton3" runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName="gotofullorderdetails" ImageUrl="./Images/getfullboatdetails.png" />
            
            </div>
        <span class="newStyle1">&nbsp;

        </span><div id ="grid">
            <br />
            <asp:GridView ID="gvFurnitureStatus" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsFurnitureStatus" CssClass="newStyle1" Width="778px" Caption="Furniture Prep" AllowSorting="True" Visible="false" >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="FurniturePrepLastUpdated" HeaderText="Date/Time" SortExpression="FurniturePrepLastUpdated" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsFurnitureStatus" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo] , [ItemNo], [CusName],[FurnitureStatus], [FurniturePrepLastUpdated],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([FurnitureStatus] = @Status) AND (Convert(date,[FurniturePrepLastUpdated]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="gvFiberglassStatus" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsFiberglassStatus" CssClass="newStyle1" Width="785px" Caption="Fiberglass" AllowSorting="True" Visible="false" >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="FiberglassLastUpdated" HeaderText="Date/Time" SortExpression="FiberglassLastUpdated" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsFiberglassStatus" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo] , [ItemNo], [CusName], [FiberglassStatus], [FiberglassLastUpdated],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([FiberglassStatus] = @Status) AND (Convert(date,[FiberglassLastUpdated]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="gvCovers" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsCovers" CssClass="newStyle1" Width="789px" Caption="Covers" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="CoversLastUpdated" HeaderText="Date/Time" SortExpression="CoversLastUpdated" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsCovers" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo],  [ItemNo], [CusName],[CoversStatus], [CoversLastUpdated],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([CoversStatus] = @Status) AND (Convert(date,[CoversLastUpdated]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="gvRails" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsRails" CssClass="newStyle1" Width="793px" Caption="Rails" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="RailsLastUpdated" HeaderText="Date/Time" SortExpression="RailsLastUpdated" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsRails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo] , [ItemNo], [CusName], [RailsStatus], [RailsLastUpdated],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([RailsStatus] = @Status) AND (Convert(date,[RailsLastUpdated]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>

              <asp:GridView ID="gvTubes" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsTubes" CssClass="newStyle1" Width="797px" Caption="Tubes" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="TubesLastUpdated" HeaderText="Date/Time" SortExpression="TubesLastUpdated" />                  
                </Columns>
                  <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [TubesStatus], [TubesLastUpdated], [BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([TubesStatus] = @Status) AND (Convert(date,[TubesLastUpdated]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="gvOuterTubesRoller" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsOuterTubesRoller" CssClass="newStyle1" Width="797px" Caption="Tubes" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Roller" HeaderText="Date/Time" SortExpression="Roller" />
                </Columns>
                  <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsOuterTubesRoller" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [RollerStatusP], [RollerStatusS], [Roller],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([RollerStatusP] = @Status) AND ([RollerStatusS] = @Status) AND (Convert(date,[Roller]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>



             <asp:GridView ID="gvCentertubes" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsCenterTubes" CssClass="newStyle1" Width="800px" Caption="Center Tubes" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Centertube" HeaderText="Date/Time" SortExpression="Centertube" />
                </Columns>
                 <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsCenterTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [CentertubeStatus], [Centertube],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([CentertubeStatus] = @Status) AND (Convert(date,[Centertube]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
                        
            <asp:GridView ID="gvFrames" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsFrames" CssClass="newStyle1" Width="800px" Caption="Frames" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="PerfPkg" HeaderText="Perf Pkg" ReadOnly="True" SortExpression="PerfPkg" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="FramesInstalled" HeaderText="Date/Time" SortExpression="FramesInstalled" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsFrames" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, PerfPkg, [ItemNo], [CusName], [FramesInstalledStatus], [FramesInstalled],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo WHERE (([FramesInstalledStatus] = @Status) AND (Convert(date,[FramesInstalled]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>


             <asp:GridView ID="gvKitting1" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsKitting1" CssClass="newStyle1" Width="800px" Caption="Kitting 1" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Kitting1" HeaderText="Date/Time" SortExpression="Kitting1" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsKitting1" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [Kitting1],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([Kitting1Status] = @Status) AND (Convert(date,[Kitting1]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>


             <asp:GridView ID="gvKitting2" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsKitting2" CssClass="newStyle1" Width="800px" Caption="Kitting 2" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Kitting2" HeaderText="Date/Time" SortExpression="Kitting2" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsKitting2" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [Kitting2],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([Kitting2Status] = @Status) AND (Convert(date,[Kitting2]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>

             <asp:GridView ID="gvKitting3" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsKitting3" CssClass="newStyle1" Width="800px" Caption="Kitting 3" AllowSorting="True" Visible="false" >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Kitting3" HeaderText="Date/Time" SortExpression="Kitting3" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsKitting3" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [Kitting3],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([Kitting3Status] = @Status) AND (Convert(date,[Kitting3]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>

              <asp:GridView ID="gvKitting4" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsKitting4" CssClass="newStyle1" Width="800px" Caption="Kitting 4" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Kitting4" HeaderText="Date/Time" SortExpression="Kitting4" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsKitting4" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [Kitting4],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([Kitting4Status] = @Status) AND (Convert(date,[Kitting4]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="gvAllKitsRcvd" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsAllKitsRcvd" CssClass="newStyle1" Width="800px" Caption="South Kits" AllowSorting="True" Visible="false" >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="AllKitsRcvdDate" HeaderText="Date/Time" SortExpression="AllKitsRcvdDate" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsAllKitsRcvd" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [AllKitsRcvdDate],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([AllKitsRcvd] = @Status) AND (Convert(date,[AllKitsRcvdDate]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>


             <asp:GridView ID="gvGates" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsGates" CssClass="newStyle1" Width="800px" Caption="Gates" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Gates" HeaderText="Gate Cleared" SortExpression="Gates" />
                    <asp:BoundField DataField="FloorsInstalled" HeaderText="Floors Installed" SortExpression="FloorsInstalled" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsGates" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [Gates],[BuildLoc], FloorsInstalled FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([GatesStatus] = @Status) AND (Convert(date,[Gates]) = @Date)) Order By FloorsInstalled">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>


                                    
            <asp:GridView ID="gvFloors" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsFloors" CssClass="newStyle1" Width="800px" Caption="Floors" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="FloorsInstalled" HeaderText="Date/Time" SortExpression="FloorsInstalled" />
                    <asp:TemplateField HeaderText="Helm Built?">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnHelm" Enabled="false" runat="server" ImageUrl='<%# Eval("HelmBuildStatus", "./Images/{0}.png")%>' ToolTip='<%# "Helm - " + Eval("HelmBuild")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsFloors" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [FloorsInstalledStatus], [FloorsInstalled],[BuildLoc], [HelmBuildStatus], [HelmBuild] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([FloorsInstalledStatus] = @Status) AND (Convert(date,[FloorsInstalled]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
            
            <asp:GridView ID="gvTrim" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsTrim" CssClass="newStyle1" Width="800px" Caption="Trim" AllowSorting="True" Visible="false" >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Trim" HeaderText="Date/Time" SortExpression="Trim" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsTrim" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [TrimStatus], [Trim],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([TrimStatus] = @Status) AND (Convert(date,[Trim]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>             

            <asp:GridView ID="gvRailsInstall" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsRailsInstall" CssClass="newStyle1" Width="800px" Caption="Rails Install" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="RailsInstalled" HeaderText="Date/Time" SortExpression="RailsInstalled" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsRailsInstall" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [RailsInstalledStatus], [RailsInstalled],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([RailsInstalledStatus] = @Status) AND (Convert(date,[RailsInstalled]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>   

             <asp:GridView ID="gvPhotos" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsPhotos" CssClass="newStyle1" Width="800px" Caption="Photos Taken" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Photos" HeaderText="Date/Time" SortExpression="Photos" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsPhotos" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [PhotosStatus], [Photos],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([PhotosStatus] = @Status) AND (Convert(date,[Photos]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>              
            
            <asp:GridView ID="gvFurnitureInstall" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsFurnitureInstall" CssClass="newStyle1" Width="800px" Caption="Furniture Install" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="FurnitureInstalled" HeaderText="Date/Time" SortExpression="FurnitureInstalled" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsFurnitureInstall" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [FurnitureInstalledStatus], [FurnitureInstalled],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([FurnitureInstalledStatus] = @Status) AND (Convert(date,[FurnitureInstalled]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>   

            <asp:GridView ID="gvHelmInstall" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsHelmInstall" CssClass="newStyle1" Width="800px" Caption="Helm Install" AllowSorting="True" Visible="false" >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="HelmInstalled" HeaderText="Date/Time" SortExpression="HelmInstalled" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsHelmInstall" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [HelmInstalledStatus], [HelmInstalled],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([HelmInstalledStatus] = @Status) AND (Convert(date,[HelmInstalled]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>   

            <asp:GridView ID="gvInspection" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsInspection" CssClass="newStyle1" Width="800px" Caption="Inspection" AllowSorting="True" Visible="false" >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Cleaning" HeaderText="Date/Time" SortExpression="Cleaning" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsInspection" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [CleaningStatus], [Cleaning],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([CleaningStatus] = @Status) AND (Convert(date,[Cleaning]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>   
    
            <asp:GridView ID="gvHelmBuild" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsHelmBuild" CssClass="newStyle1" Width="800px" Caption="Helm Build" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="HelmBuild" HeaderText="Date/Time" SortExpression="HelmBuild" />
                    <asp:TemplateField HeaderText ="Helm Build Sheet">
                        <ItemTemplate>                              
                        <asp:ImageButton ID="ImageButton2" ImageUrl='Images/buildsheet.png'  runat="server" CommandArgument='<%# Eval("ProdNo") & ";" & Eval("ItemNo")%>' CommandName ="gotobuildsheet"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsHelmBuild" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [HelmBuildStatus], [HelmBuild],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([HelmBuildStatus] = @Status) AND (Convert(date,[HelmBuild]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>   

             <asp:GridView ID="gvFinalInspection" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsFinalInspection" CssClass="newStyle1" Width="800px" Caption="Final Inspection" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="FinalInspection" HeaderText="Date/Time" SortExpression="FinalInspection" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsFinalInspection" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [FinalInspectionStatus], [FinalInspection],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([FinalInspectionStatus] = @Status) AND (Convert(date,[FinalInspection]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>  
            
            <asp:GridView ID="gvShrinkwrap" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsShrinkwrap" CssClass="newStyle1" Width="1200px" Caption="Shrink Wrap" AllowSorting="True" Visible="false" >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="DueDate" HeaderText="Due Date" ReadOnly="True" SortExpression="DueDate" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Shrinkwrap" HeaderText="Date/Time" SortExpression="Shrinkwrap" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsShrinkwrap" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [ShrinkwrapStatus], [Shrinkwrap],[BuildLoc],[DueDate] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([ShrinkwrapStatus] = @Status) AND (Convert(date,[Shrinkwrap]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>  
            
             <asp:GridView ID="gvSharkhide" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsSharkhide" CssClass="newStyle1" Width="800px" Caption="Sharkhide" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="SharkhideInstalled" HeaderText="Date/Time" SortExpression="SharkhideInstalled" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsSharkhide" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [SharkhideStatus], [SharkhideInstalled],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([SharkhideStatus] = @Status) AND (Convert(date,[SharkhideInstalled]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>    

      <asp:GridView ID="gvWavetamer" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsWavetamer" CssClass="newStyle1" Width="800px" Caption="Wavetamer" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="WavetamerInstalled" HeaderText="Date/Time" SortExpression="WavetamerInstalled" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsWavetamer" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [WavetamerStatus], [WavetamerInstalled],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([WavetamerStatus] = @Status) AND (Convert(date,[WavetamerInstalled]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
            
             <asp:GridView ID="gvComplete" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsComplete" CssClass="newStyle1" Width="800px" Caption="Boats Completed" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Complete" HeaderText="Date/Time" SortExpression="Complete" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsComplete" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [CompleteStatus], [Complete],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([CompleteStatus] = @Status) AND (Convert(date,[Complete]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>        

              <asp:GridView ID="gvFGI" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsFGI" CssClass="newStyle1" Width="800px" Caption="Fiberglass Inspection" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Complete" HeaderText="Date/Time" SortExpression="Complete" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsFGI" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [CompleteStatus], [Complete],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([FiberglassInspStatus] = @Status) AND (Convert(date,[FiberglassInsp]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource> 
            
              <asp:GridView ID="gvGauges" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsGauges" CssClass="newStyle1" Width="800px" Caption="Gauges Received" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Complete" HeaderText="Date/Time" SortExpression="Complete" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsGauges" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [CompleteStatus], [Complete],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([GaugeStatus] = @Status) AND (Convert(date,[GaugeLastUpdated]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource> 


             <asp:GridView ID="gvHarnesses" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdNo" DataSourceID="sdsHarnesses" CssClass="newStyle1" Width="800px" Caption="Harnesses Received" AllowSorting="True" Visible="false"  >
                <Columns>
                    <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Item #" ReadOnly="True" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" ReadOnly="True" SortExpression="CusName" />
                    <asp:BoundField DataField="BuildLoc" HeaderText="Building" SortExpression="BuildLoc" />
                    <asp:BoundField DataField="Complete" HeaderText="Date/Time" SortExpression="Complete" />
                </Columns>
                <HeaderStyle Font-Bold="True" />
            </asp:GridView>

            <asp:SqlDataSource ID="sdsHarnesses" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [CusName], [CompleteStatus], [Complete],[BuildLoc] FROM [BML_POPREPORTING_GREENLIGHTS] WHERE (([HarnessStatus] = @Status) AND (Convert(date,[HarnessLastUpdated]) = @Date))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="Status" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource> 



             <br />
            <br />
    </div>
     
    </form>
</body>
</html>
