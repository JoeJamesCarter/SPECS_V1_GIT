<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SupplierReadinessTrackingRO.aspx.vb" Inherits="SRT_SupplierReadinessTrackingRO" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../StyleSheet.css" rel="stylesheet" />
    <script src="../scripts/jquery-2.1.0.min.js"></script>
    <style>
      
        #additem {
            background-color: lightgray;
            width: 500px;
        }

        #copyitems {
            background-color: lightgray;
            width: 800px;
        }

        #milestones {
        }

        #wrapper {
        }

        #ItemsToTrack {
            overflow-x: scroll;            
            text-align: left;
            width: 3450px; /* i.e. too small for all the columns */
        }

        .pinned {
            position: absolute; /* i.e. not scrolled - was fixed but that didn't work*/            
            background-color: White; /* prevent the scrolled columns showing through */
            z-index: 100; /* keep the pinned on top of the scrollables */
            color: black;
            border-style: solid;
            border-width: 1px; 
            white-space:nowrap;                                                  
        }

        .scrolled {
            position: relative;
            left: 3060px; /* i.e. sum of all scrolling col widths */
            overflow: hidden;
            white-space: nowrap;
            min-width: 10px; /* set your real column widths here */            
        }

        .col1 {
            left: 0px;
            width: 50px;
        }

        .col2 {
            left: 50px;
            width: 60px;
            text-align: left;
        }

        .col3 {
            left: 110px;
            width: 350px;
            text-align: left;
        }

        .col4 {
            left: 460px;
            width: 300px;
        }

        .col5 {
            left: 760px;
            width: 300px;
        }

        .col6 {
            left: 1060px;
            width: 200px;
        }
        .col7 {
            left: 1260px;
            width: 300px;
        }        

        .col8 {
            left: 1560px;
            width: 300px;
        }
         .col9 {
            left: 1860px;
            width: 300px;
        }
          .col10 {
            left: 2160px;
            width: 500px;          
        }
          .col11 {
            left: 2660px;
            width: 100px;
        }
          .col12 {
            left: 2760px;
            width: 300px;
            overflow:hidden;         
        }
              
        .parentWDependents {
             line-height:20px;                           
        }
        .dependents td {
           line-height:20px;           
        }
      
    </style>
  
    <title>Supplier Readiness Tracking</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label2" runat="server" Text="Product Development &amp; Supplier Readiness Tracking" CssClass="newStyle7"></asp:Label>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnShowAddItemForm" runat="server" Text="Show Add Item" Visible="False" />
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnHideAddItemForm" runat="server" Text="Hide Add Item" Visible="False" />
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnMaintainMileStones" runat="server" Text="Show/Hide Add Milestones " Visible="False" />
        &nbsp;&nbsp;&nbsp;       
        <asp:Button ID="btnCopyItems" runat="server" Text="Copy Items To Another Color" Visible="False" />
        &nbsp;&nbsp;
        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" Visible="True" />
        <br />
        <div id="additem" runat="server">
            <br />
            <asp:Label ID="Label1" runat="server" Text="Add Item to Track" CssClass="newStyle6"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnClose" runat="server" Text="Close" Width="87px" />
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" Text="Model Year: " CssClass="newStyle3" Width="200px"></asp:Label>
            <asp:DropDownList ID="ddlMY" runat="server" Width="71px">
                <asp:ListItem> </asp:ListItem>
                <asp:ListItem>2020</asp:ListItem>
                <asp:ListItem>2021</asp:ListItem>
                <asp:ListItem>2022</asp:ListItem>
                <asp:ListItem>2023</asp:ListItem>
                <asp:ListItem>2024</asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Category: " CssClass="newStyle3" Width="200px"></asp:Label>
            <asp:TextBox ID="tbCategory" runat="server" Width="262px"></asp:TextBox>
            <br />
            <asp:Label ID="Label5" runat="server" Text="Supplier: " CssClass="newStyle3" Width="200px"></asp:Label>
            <asp:TextBox ID="tbSupplier" runat="server" Width="262px"></asp:TextBox>
            &nbsp; 
        <br />
            <asp:Label ID="Label6" runat="server" CssClass="newStyle3" Text="Color/Type :" Width="200px"></asp:Label>
            <asp:TextBox ID="tbColorType" runat="server" Width="262px"></asp:TextBox>
            <br />
            <asp:Label ID="Label7" runat="server" CssClass="newStyle3" Text="Dependent Category: " Width="200px"></asp:Label>
            <asp:TextBox ID="tbDependency" runat="server" Width="262px"></asp:TextBox>
            <br />
            <asp:Label ID="Label8" runat="server" CssClass="newStyle3" Text="Lead Time (wks): " Width="200px"></asp:Label>
            <asp:TextBox ID="tbLeadTime" runat="server" Width="39px" TextMode="Number"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;<br />
           
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;
            &nbsp;<asp:Button ID="btnAddNew" runat="server" Text="Save" Width="88px" />
            <br />
            <br />
        </div>
        <br />
        <div id="copyitems" runat="server">
            <asp:Label ID="Label11" runat="server" Text="Copy Items To Another Color" CssClass="newStyle6" Visible="True"></asp:Label>
            &nbsp;
             <asp:Button ID="btnClose0" runat="server" Text="Close" Width="87px" />
            <br />
            <br />
            <asp:Label ID="Label12" runat="server" Text="Model Year: " CssClass="newStyle3" Width="119px"></asp:Label>
            <asp:DropDownList ID="ddlMY1" runat="server" Width="71px" AutoPostBack="True">
                <asp:ListItem> </asp:ListItem>
                <asp:ListItem>2020</asp:ListItem>
                <asp:ListItem>2021</asp:ListItem>
                <asp:ListItem>2022</asp:ListItem>
                <asp:ListItem>2023</asp:ListItem>
                <asp:ListItem>2024</asp:ListItem>
            </asp:DropDownList>

            &nbsp;<asp:Label ID="Label13" runat="server" Text="Color/Type: " CssClass="newStyle3" Width="119px"></asp:Label>
            <asp:DropDownList ID="ddlfromCurrentColor" runat="server" DataSourceID="sdsDistinctCurrentColors" DataTextField="CurrentColor" DataValueField="CurrentColor">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsDistinctCurrentColors" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Color_Type] FROM [SupplierTracking_Items] WHERE ([ModelYear] = @ModelYear) ORDER BY [Color_Type]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlMY1" Name="ModelYear" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="Label14" runat="server" Text="Copy All Records from Selected Year That Have Selected Current Color To:" CssClass="newStyle6"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label15" runat="server" Text="Current Color: " CssClass="newStyle3" Width="119px"></asp:Label>
            <asp:TextBox ID="tbNewCurrentColor" runat="server"></asp:TextBox>
            &nbsp;<asp:Label ID="Label16" runat="server" Text="New Color: " CssClass="newStyle3" Width="119px"></asp:Label>
            <asp:TextBox ID="tbNewNewColor" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="btnCopy" runat="server" Text="Copy" />
            <br />

        </div>
        <div id="milestones">
            <asp:Label ID="Label10" runat="server" CssClass="newStyle3" Text="Model Year: "></asp:Label>
            <asp:DropDownList ID="ddlMY0" runat="server" Width="71px" AutoPostBack="True">
                <asp:ListItem> </asp:ListItem>
                <asp:ListItem>2020</asp:ListItem>
                <asp:ListItem>2021</asp:ListItem>
                <asp:ListItem>2022</asp:ListItem>
                <asp:ListItem>2023</asp:ListItem>
                <asp:ListItem>2024</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label ID="Label9" runat="server" Text="Target Dates For Selected Year" CssClass="newStyle6"></asp:Label>


            <br />
            <br />
            <asp:GridView ID="gvMilestones" runat="server" AutoGenerateColumns="False" DataSourceID="sdsMilestones" CssClass="newStyle3" Width="487px" DataKeyNames="AutoID">
                <Columns>
                    <asp:BoundField DataField="ModelYear" HeaderText="Model Year" SortExpression="ModelYear">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MilestoneDesc" HeaderText="Description" SortExpression="MilestoneDesc">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MileStoneDate" HeaderText="Monday" SortExpression="MileStoneDate" DataFormatString="{0:d}">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:CommandField ShowDeleteButton="False" ShowEditButton="False" />                    
                </Columns>              
            </asp:GridView> 
            <br />
            <asp:DetailsView ID="dvMileStones" runat="server" Height="50px" Width="294px" CssClass="newStyle1" DataSourceID="sdsMilestones" AutoGenerateRows="False" Caption="Add Milestone">
                <Fields>
                    <asp:BoundField HeaderText="Model Year" DataField="ModelYear" />
                    <asp:BoundField HeaderText="Description" DataField="MilestoneDesc" />
                    <asp:BoundField HeaderText="Monday" DataField="MilestoneDate"  />
                    <asp:CommandField ShowInsertButton="True" />                    
                </Fields>
            </asp:DetailsView>          
            <asp:SqlDataSource ID="sdsMilestones" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [SupplierTracking_Milestones] WHERE [AutoID] = @AutoID" InsertCommand="INSERT INTO [SupplierTracking_Milestones] ([ModelYear], [MilestoneDesc], [MileStoneDate]) VALUES (@ModelYear, @MilestoneDesc, @MileStoneDate)" SelectCommand="SELECT * FROM [SupplierTracking_Milestones] WHERE ([ModelYear] = @ModelYear) ORDER BY [MileStoneDate]" UpdateCommand="UPDATE [SupplierTracking_Milestones] SET [ModelYear] = @ModelYear, [MilestoneDesc] = @MilestoneDesc, [MileStoneDate] = @MileStoneDate WHERE [AutoID] = @AutoID">
                <DeleteParameters>
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>                    
                    <asp:Parameter Name="ModelYear" Type="Int32" />
                    <asp:Parameter Name="MilestoneDesc" Type="String" />
                    <asp:Parameter DbType="Date" Name="MileStoneDate" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlMY0" Name="ModelYear" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ModelYear" Type="Int32" />
                    <asp:Parameter Name="MilestoneDesc" Type="String" />
                    <asp:Parameter DbType="Date" Name="MileStoneDate" />
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="Label17" runat="server" Text="Filter By Color/Type: " CssClass="newStyle6" Width="187px"></asp:Label>
            <asp:DropDownList ID="ddlfilterCurrentColor" runat="server" DataSourceID="sdsDistinctCurrentColors0" DataTextField="Color_Type" DataValueField="Color_Type" AppendDataBoundItems="true" AutoPostBack="True">
                <asp:ListItem Text="All" Value="%" />
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;
             <asp:Label ID="Label18" runat="server" Text="Filter By Category:" CssClass="newStyle6" Width="187px"></asp:Label>
            <asp:DropDownList ID="ddlDistinctItemDesc" runat="server" DataSourceID="sdsDistinctItems" DataTextField="Category" DataValueField="Category" AppendDataBoundItems="true" AutoPostBack="True">
                <asp:ListItem Text="All" Value="%" />
            </asp:DropDownList>
             &nbsp;&nbsp;<asp:Label ID="Label20" runat="server" Text="Filter By Replaces:" CssClass="newStyle6" Width="187px"></asp:Label>
            <asp:DropDownList ID="ddlDistinctReplaces" runat="server" DataSourceID="sdsDistinctReplaces" DataTextField="Replaces" DataValueField="Replaces" AppendDataBoundItems="true" AutoPostBack="True">
                <asp:ListItem Text="All" Value=""></asp:ListItem>
            </asp:DropDownList>
            &nbsp;&nbsp; <asp:Label ID="Label21" runat="server" Text="Filter By Model:" CssClass="newStyle6" Width="187px"></asp:Label>
            <asp:DropDownList ID="ddlDistinctModels" runat="server" DataSourceID="sdsDistinctModels" DataTextField="ModelInfo" DataValueField="ModelInfo" AppendDataBoundItems="True" AutoPostBack="True">
                <asp:ListItem Text="Show All" Value=""></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsDistinctModels" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [ModelInfo] FROM [SupplierTracking_Items] ORDER BY [ModelInfo]">
            </asp:SqlDataSource>
            &nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Label ID="Label19" runat="server" Text="Filter By Dependency:" CssClass="newStyle6" Width="187px"></asp:Label>
            <asp:DropDownList ID="ddlDistinctDependencies" runat="server" DataSourceID="sdsDistinctDependencies" DataTextField="DependentOn" DataValueField="DependentOn" AppendDataBoundItems="true" AutoPostBack="True">
                <asp:ListItem Text="All" Value="%" />
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsDistinctItems" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Category] FROM [SupplierTracking_Items] WHERE ([ModelYear] = @ModelYear) ORDER BY [Category]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlMY0" Name="ModelYear" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsDistinctCurrentColors0" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Color_Type] FROM [SupplierTracking_Items] WHERE ([ModelYear] = @ModelYear) ORDER BY [Color_Type]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlMY0" Name="ModelYear" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsDistinctDependencies" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [DependentOn] FROM [SupplierTracking_Items] WHERE ([ModelYear] = @ModelYear) ORDER BY [DependentOn]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlMY0" Name="ModelYear" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource> 
              <asp:SqlDataSource ID="sdsDistinctReplaces" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Replaces] FROM [SupplierTracking_Items] WHERE ([ModelYear] = @ModelYear) ORDER BY [Replaces]">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlMY0" Name="ModelYear" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>                  
            <br />
        </div>
        <div id="wrapper">
            <div id="ItemsToTrack">
                <br />
                <asp:GridView ID="gvItems" runat="server" CssClass="newStyle3" AutoGenerateColumns="False" DataKeyNames="ItemID" DataSourceID="sdsItems" Width="100%" BorderWidth="3px" CellPadding="4" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" ForeColor="Black" CellSpacing="2" >
                    <Columns>
                       <asp:BoundField DataField="ItemID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ItemID">
                            <HeaderStyle CssClass="pinned col1"></HeaderStyle>
                            <ItemStyle CssClass="pinned col1"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="ModelYear" HeaderText="MY" SortExpression="ModelYear">
                            <HeaderStyle CssClass="pinned col2"></HeaderStyle>
                            <ItemStyle CssClass="pinned col2" HorizontalAlign="Center"></ItemStyle>
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Category">
                            <HeaderStyle CssClass="pinned col3"></HeaderStyle>
                            <ItemStyle CssClass="pinned col3"></ItemStyle>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" Text='<%#Eval("Category").ToUpper()%>' CommandName="EditStatus" CommandArgument="<%# Container.DataItemIndex %>" />
                            </ItemTemplate>
                          </asp:TemplateField>
                        <asp:BoundField DataField="Supplier" HeaderText="Supplier" SortExpression="Supplier">
                            <HeaderStyle CssClass="pinned col4"></HeaderStyle>
                            <ItemStyle CssClass="pinned col4"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Color_Type" HeaderText="Color/Type" SortExpression="CurrentColor">
                            <HeaderStyle CssClass="pinned col5"></HeaderStyle>
                            <ItemStyle CssClass="pinned col5"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Replaces" HeaderText="Replaces" SortExpression="Replaces">
                            <HeaderStyle CssClass="pinned col6"></HeaderStyle>
                            <ItemStyle CssClass="pinned col6"></ItemStyle>
                        </asp:BoundField>
                         <asp:BoundField DataField="ModelInfo" HeaderText="Model" SortExpression="ModelInfo">
                            <HeaderStyle CssClass="pinned col7"></HeaderStyle>
                            <ItemStyle CssClass="pinned col7"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Color_Type" HeaderText="Color/Type" SortExpression="CurrentColor">
                            <HeaderStyle CssClass="pinned col8"></HeaderStyle>
                            <ItemStyle CssClass="pinned col8"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="DependentOn" HeaderText="Dependency" SortExpression="DependentOn">
                            <HeaderStyle CssClass="pinned col9"></HeaderStyle>
                            <ItemStyle CssClass="pinned col9"></ItemStyle>
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Dependency On Items" >
                            <HeaderStyle CssClass="pinned col10"></HeaderStyle>
                            <ItemStyle CssClass="pinned col10"></ItemStyle>
                            <ItemTemplate>
                                <asp:GridView ID="gvDependentItemStatuses" runat="server" AutoGenerateColumns="False" DataSourceID="sdsDependentItemStatuses" OnRowDataBound="gvDependentItemStatuses_RowDataBound" cssClass="dependents" ShowHeader="False" GridLines="Both" Width="100%">
                                    <Columns>                                       
                                        <asp:BoundField DataField="DependentOnItemID" HeaderText="ItemID" ItemStyle-Width="30" />
                                        <asp:BoundField DataField="Supplier"/>                                         
                                        <asp:BoundField DataField="Status"/>                                                                             
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsDependentItemStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [DependentOnItemID], Category, Supplier, Color_Type, LeadTime, Replaces, ModelInfo, (select Status From SupplierReadiness_StatusNotes Where EntryID = (Select max(EntryID) from SupplierReadiness_StatusNotes where [ItemID] = DependentOnItemID)) as Status FROM [SupplierTracking_ItemDependencies] Left Join SupplierTracking_Items on [SupplierTracking_ItemDependencies].DependentOnItemID = SupplierTracking_Items.ItemID  Left Join SupplierReadiness_StatusNotes on SupplierTracking_ItemDependencies.DependentOnItemID = SupplierReadiness_StatusNotes.ItemID WHERE ([SupplierTracking_ItemDependencies].ItemID = @ItemID) ORDER BY [DependentOnItemID] ">
                                    <SelectParameters>
                                        <asp:Parameter Name="ItemID" Type="Int32" />                                        
                                        <asp:Parameter Name="ItemID2" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                &nbsp;
                            </ItemTemplate>                           
                        </asp:TemplateField>
                        <asp:BoundField DataField="LeadTime" HeaderText="Lead Time" SortExpression="LeadTime">
                            <HeaderStyle CssClass="pinned col11"></HeaderStyle>
                            <ItemStyle CssClass="pinned col11"></ItemStyle>
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Current Status">
                            <HeaderStyle CssClass="pinned col12"></HeaderStyle>
                            <ItemStyle CssClass="pinned col12"></ItemStyle>
                            <ItemTemplate>
                                <asp:GridView runat="server" AutoGenerateColumns="False" DataSourceID="sdsMaxStatus" Width="400px" ShowHeader="False" ID="gvCurrentStatus" GridLines="None" OnRowDataBound="gvCurrentStatus_RowDataBound" >
                                    <Columns>
                                        <asp:BoundField DataField="WeekOf" DataFormatString="{0:d}" HeaderText="Week" SortExpression="WeekOf" >
                                        <ItemStyle Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" >                                       
                                        <ItemStyle Width="250px" />
                                        </asp:BoundField>                                                                             
                                    </Columns>
                                </asp:GridView>                                
                                <asp:SqlDataSource ID="sdsMaxStatus" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [WeekOf], [Status],[Notes] FROM [SupplierReadiness_StatusNotes] WHERE ([ItemID] = @ItemID) AND EntryID = (select max(EntryID) from SupplierReadiness_StatusNotes Where [ItemID] = @ItemID2)">
                                    <SelectParameters>
                                        <asp:Parameter Name="ItemID" Type="Int32" />
                                        <asp:Parameter Name="ItemID2" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                &nbsp;
                                </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
                         <asp:TemplateField>
                            <HeaderStyle CssClass="scrolled"></HeaderStyle>
                            <ItemStyle CssClass="scrolled"></ItemStyle>
                        </asp:TemplateField>
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
                <asp:SqlDataSource ID="sdsItems" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT ItemID, ModelYear, Category, Supplier, Color_Type, DependentOn, LeadTime, DependentOnItemsList, ModelInfo, Replaces FROM [SupplierTracking_Items] WHERE ([ModelYear] = @ModelYear) and (COALESCE(SupplierTracking_Items.[Color_Type],'') Like @CurrentColor) and ([Category] Like @Category) and (COALESCE(SupplierTracking_Items.[DependentOn],'') Like @DependentOn) and (COALESCE(SupplierTracking_Items.[Replaces], '') Like @Replaces) and (COALESCE(SupplierTracking_Items.[ModelInfo], '') Like @Models)  ORDER BY Category">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlMY0" Name="ModelYear" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="ddlfilterCurrentColor" Name="CurrentColor" DefaultValue="%" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="ddlDistinctItemDesc" Name="Category" DefaultValue="%" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="ddlDistinctDependencies" Name="DependentOn" DefaultValue="%" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="ddlDistinctReplaces" Name="Replaces" DefaultValue="%" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="ddlDistinctModels" Name="Models" DefaultValue="%" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </form>
</body>
</html>
