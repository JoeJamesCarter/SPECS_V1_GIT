﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ProductDesignIdeasHistory.aspx.vb" Inherits="PDI_ProductDesignIdeasHistory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Design Ideas - History</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .upper {
            text-transform: uppercase;
        }

        .filterlabels {
            margin-left: 10px;
            margin-right: 10px;
            font-family: Calibri;
            font-size: 22px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label2" runat="server" CssClass="newStyle7" Text="PRODUCT DEVELOPMENT IDEAS - HISTORY (No, Duplicate or Done)"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnRefresh" runat="server" Text="Refresh" />&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnAdd" runat="server" Text="Add An Idea" Visible="False" />
            &nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" Text="View History" Visible="False" />
            &nbsp;&nbsp;
            <asp:Button ID="btnRepIdeas" runat="server" Text="View Rep Ideas" Visible="False" />
&nbsp;&nbsp;
            <asp:Label ID="Label11" runat="server" CssClass="newStyle6" Text="# of Ideas:" Visible="False"></asp:Label>
&nbsp;
            <asp:Label ID="lblIdeaCount" runat="server" CssClass="newStyle6" Visible="False"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" CssClass="filterlabels" Text="Model Year"></asp:Label>
            &nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="ddlMY" runat="server" CssClass="newStyle6" AutoPostBack="True">
            <asp:ListItem Value="%">ALL</asp:ListItem>
            <asp:ListItem Value="18">2018</asp:ListItem>
            <asp:ListItem Value="19">2019</asp:ListItem>
            <asp:ListItem Value="20">2020</asp:ListItem>
            <asp:ListItem Value="21">2021</asp:ListItem>
            <asp:ListItem Value="22">2022</asp:ListItem>
            <asp:ListItem Value="23">2023</asp:ListItem>
            <asp:ListItem Value="24">2024</asp:ListItem>
        </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;<asp:Label ID="Label12" runat="server" CssClass="filterlabels" Text="Project ID:"></asp:Label>
            <asp:TextBox ID="tbProjectID" runat="server" Width="30px"></asp:TextBox>
            <asp:Button ID="btnClear" runat="server" Text="Clear" Width="46px" />
            &nbsp;
            <asp:Label ID="Label3" runat="server" CssClass="filterlabels" Text="Requested By"></asp:Label>
            <asp:DropDownList ID="ddlReqBy" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="newStyle6" DataSourceID="sdsDistinctRequestedBy" DataTextField="RequestedBy" DataValueField="RequestedBy">
                <asp:ListItem Text="All" Value="%" />
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label4" runat="server" CssClass="filterlabels" Text="Category"></asp:Label>
            <asp:DropDownList ID="ddlCategories" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="newStyle6" DataSourceID="sdsDistinctCategories" DataTextField="Category" DataValueField="Category">
                <asp:ListItem Text="All" Value="%" />
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label6" runat="server" CssClass="filterlabels" Text="Series"></asp:Label>
            <asp:DropDownList ID="ddlSeries" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="newStyle6" DataSourceID="sdsDistinctSeries" DataTextField="Series" DataValueField="Series">
                <asp:ListItem Text="Show All" Value="%" />
            </asp:DropDownList>
            <asp:Label ID="Label7" runat="server" CssClass="filterlabels" Text="Strategic Priority" Visible="False"></asp:Label>
            <asp:DropDownList ID="ddlStrategicPriority" runat="server" AutoPostBack="True" CssClass="newStyle6" Visible="False">
                <asp:ListItem Text="Show All" Value="%" />
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem Value="5"></asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="Label8" runat="server" CssClass="filterlabels" Text="Sales Priority" Visible="False"></asp:Label>
            <asp:DropDownList ID="ddlSalesPriority" runat="server" AutoPostBack="True" CssClass="newStyle6" Visible="False">
                <asp:ListItem Text="Show All" Value="%" />
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem Value="5"></asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="Label9" runat="server" CssClass="filterlabels" Text="Eng Active"></asp:Label>
            <asp:DropDownList ID="ddlEngActive" runat="server" AutoPostBack="True" CssClass="newStyle6">
                <asp:ListItem Text="Show All" Value="%" />
                <asp:ListItem Value="1">Y</asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="Label10" runat="server" CssClass="filterlabels" Text="Project Status"></asp:Label>
            <asp:DropDownList ID="ddlProjectStatuses" runat="server" AutoPostBack="True" CssClass="newStyle6">
                <asp:ListItem Text="Show All" Value="%" />
                <asp:ListItem Value="0">Not Started</asp:ListItem>
                <asp:ListItem Value="1">In Progress</asp:ListItem>
                <asp:ListItem Value="2">Done</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsDistinctProjectStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct[ProjectStatus] FROM [ProductDesignIdeas] ORDER BY [ProjectStatus]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsDistinctSeries" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Series] FROM [ProductDesignIdeas] ORDER BY [Series]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsDistinctCategories" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Category] FROM [ProductDesignIdeas] ORDER BY [Category]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsDistinctRequestedBy" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [RequestedBy] FROM [ProductDesignIdeas] ORDER BY [RequestedBy]"></asp:SqlDataSource>
            <br />
            <br />
            <asp:GridView ID="gvProjectIdeas" runat="server" DataSourceID="sdsProductDevIdeas" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="ModelYear,AutoID" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AllowSorting="True">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="ModelYear" HeaderText="MY" ReadOnly="True" SortExpression="ModelYear" />
                    <asp:BoundField DataField="AutoID" HeaderText="ID" ReadOnly="True" SortExpression="AutoID" />

                    <asp:TemplateField HeaderText="Edit">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CssClass="newStyle6" Text='<%# Eval("AutoID") %>' Width="50px" CommandName="EditStatus" CommandArgument="<%# Container.DataItemIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="RequestedBy" HeaderText="Req By" SortExpression="RequestedBy" />
                    <asp:BoundField DataField="RequestedDate" HeaderText="Request Date" SortExpression="RequestedDate" DataFormatString="{0:d}" />
                    <asp:TemplateField HeaderText="Approval Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlApprovalStatus" runat="server" SelectedValue='<%# Eval("ApprovalStatus") %>' DataSourceID="sdsApprovalStatuses" DataTextField="ApprovalStatusDesc" DataValueField="AutoID" Enabled="True" OnSelectedIndexChanged="ddlApprovalStatus_SelectedIndexChanged" AutoPostBack="True" ToolTip='<%#Eval("ApprovalStatusDate") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsApprovalStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [ProductDesignIdeas_ApprovalStatuses] ORDER BY [ApprovalStatusDesc]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" ItemStyle-CssClass="upper">
                        <ItemStyle CssClass="upper"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Series" HeaderText="Series" SortExpression="Series" ItemStyle-CssClass="upper">
                        <ItemStyle CssClass="upper"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="InitialDescription" HeaderText="Initial Desc" SortExpression="InitialDescription">
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NarrowedDescription" HeaderText="Revised Desc" SortExpression="NarrowedDescription" />
                    <asp:TemplateField HeaderText="Notes/Activity">
                        <ItemTemplate>
                            <asp:GridView ID="gvMeetingNotes" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="AutoID" DataSourceID="sdsMeetingNotes" Width="500px" ShowHeader="False">
                                <Columns>
                                    <asp:BoundField DataField="Note" HeaderText="Note" SortExpression="Note">
                                        <ItemStyle Width="400px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NoteCreated" HeaderText="Entered" SortExpression="NoteCreated" DataFormatString="{0:d}">
                                        <ItemStyle Width="100px" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsMeetingNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [ProductDesignIdeas_Notes] WHERE (([ModelYear] = @ModelYear) AND ([ProjectID] = @ProjectID)) ORDER BY [NoteCreated]">
                                <SelectParameters>
                                    <asp:Parameter Name="ModelYear" Type="Int32" />
                                    <asp:Parameter Name="ProjectID" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField  HeaderText="Rep Comments">
                        <ItemTemplate>
                            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                        </ItemTemplate>
                    </asp:TemplateField>                                    
                    <asp:TemplateField HeaderText="Strategic Priority">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlEditStrategicPriority" runat="server" SelectedValue ='<%#Eval("StrategicPriority")%>' OnSelectedIndexChanged="ddlStrategicPriority_SelectedIndexChanged" AutoPostBack="True" ToolTip='<%#Eval("StrategicPriorityDate")%>'>
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem Value="0"></asp:ListItem>
                                <asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                                <asp:ListItem>3</asp:ListItem>
                                <asp:ListItem>4</asp:ListItem>
                                <asp:ListItem Value="5"></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>            
                     <asp:TemplateField HeaderText="Sales Priority">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlEditSalesPriority" runat="server" SelectedValue ='<%#Eval("SalesPriority")%>' OnSelectedIndexChanged="ddlSalesPriority_SelectedIndexChanged" AutoPostBack="True" ToolTip='<%#Eval("SalesPriorityDate")%>'>
                                <asp:ListItem></asp:ListItem>
                                 <asp:ListItem Value="0"></asp:ListItem>
                                <asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                                <asp:ListItem>3</asp:ListItem>
                                <asp:ListItem>4</asp:ListItem>
                                <asp:ListItem Value="5"></asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>                     
                    <asp:TemplateField HeaderText="Eng Active" SortExpression="EngActiveFlag">
                        <ItemTemplate>
                             <asp:DropDownList ID="ddlEngActive" runat="server" AutoPostBack="True" SelectedValue ='<%#Eval("EngActiveFlag")%>' OnSelectedIndexChanged="ddlEngActiveStatus_SelectedIndexChanged" ToolTip='<%#Eval("EngActiveFlagDate")%>'>
                            <asp:ListItem Value="0">N</asp:ListItem>
                            <asp:ListItem Value="1">Y</asp:ListItem>
                            </asp:DropDownList>                            
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="ProjectLead" HeaderText="Project Lead" SortExpression="ProjectLead" ItemStyle-CssClass="upper">
                        <ItemStyle CssClass="upper"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="TargetDate" HeaderText="Target Date" SortExpression="TargetDate" DataFormatString="{0:d}" />
                    <asp:TemplateField HeaderText="Project Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlProjectStatus" runat="server" Enabled="True" SelectedValue='<%# Eval("ProjectStatus") %>' OnSelectedIndexChanged="ddlProjectStatus_SelectedIndexChanged" AutoPostBack="True" ToolTip='<%#Eval("ProjectStatusDate") %>'>
                                <asp:ListItem Value="0">NOT STARTED</asp:ListItem>
                                <asp:ListItem Value="1">IN PROGRESS</asp:ListItem>
                                <asp:ListItem Value="2">DONE</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Request Rep Feedback">
                        <ItemTemplate>
                            <asp:Button ID="btnRequestRepFeedback" runat="server" Text="Send Request" CommandName="RequestRepFeedback" CommandArgument="<%# Container.DataItemIndex %>"/>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
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
            </asp:GridView>
            <asp:SqlDataSource ID="sdsProductDevIdeas" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [ProductDesignIdeas] WHERE [ModelYear] = @ModelYear AND [AutoID] = @AutoID" InsertCommand="INSERT INTO [ProductDesignIdeas] ([ModelYear], [AutoID], [RequestedBy], [RequestedDate], [ApprovalStatus], [Category], [Series], [InitialDescription], [NarrowedDescription], [StrategicPriority], [SalesPriority], [EngActiveFlag], [ProjectLead], [TargetDate], [ProjectStatus], [Notes]) VALUES (@ModelYear, @AutoID, @RequestedBy, @RequestedDate, @ApprovalStatus, @Category, @Series, @InitialDescription, @NarrowedDescription, @StrategicPriority, @SalesPriority, @EngActiveFlag, @ProjectLead, @TargetDate, @ProjectStatus, @Notes)" SelectCommand="SELECT * FROM [ProductDesignIdeas] WHERE ([ModelYear] Like @ModelYear) and ([RequestedBy] like @RequestedBy OR [RequestedBy] is NULL) and ([Category] like @Category or [Category] is Null) and ([Series] like @Series or [Series] is Null) and [EngActiveFlag] Like @EngActiveFlag and ([ProjectStatus] = 2 or [ApprovalStatus] = 1 or [ApprovalStatus] = 4) ORDER BY [ModelYear], [AutoID]" UpdateCommand="UPDATE [ProductDesignIdeas] SET [RequestedBy] = @RequestedBy, [RequestedDate] = @RequestedDate, [ApprovalStatus] = @ApprovalStatus, [Category] = @Category, [Series] = @Series, [InitialDescription] = @InitialDescription, [NarrowedDescription] = @NarrowedDescription, [StrategicPriority] = @StrategicPriority, [SalesPriority] = @SalesPriority, [EngActiveFlag] = @EngActiveFlag, [ProjectLead] = @ProjectLead, [TargetDate] = @TargetDate, [ProjectStatus] = @ProjectStatus, [Notes] = @Notes WHERE [ModelYear] = @ModelYear AND [AutoID] = @AutoID">
                <DeleteParameters>
                    <asp:Parameter Name="ModelYear" Type="Int32" />
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ModelYear" Type="String" />
                    <asp:Parameter Name="AutoID" Type="Int32" />
                    <asp:Parameter Name="RequestedBy" Type="String" />
                    <asp:Parameter Name="RequestedDate" Type="DateTime" />
                    <asp:Parameter Name="ApprovalStatus" Type="Int32" />
                    <asp:Parameter Name="Category" Type="String" />
                    <asp:Parameter Name="Series" Type="String" />
                    <asp:Parameter Name="InitialDescription" Type="String" />
                    <asp:Parameter Name="NarrowedDescription" Type="String" />
                    <asp:Parameter Name="StrategicPriority" Type="Int32" />
                    <asp:Parameter Name="SalesPriority" Type="Int32" />
                    <asp:Parameter Name="EngActiveFlag" Type="Int32" />
                    <asp:Parameter Name="ProjectLead" Type="String" />
                    <asp:Parameter DbType="Date" Name="TargetDate" />
                    <asp:Parameter Name="ProjectStatus" Type="Int32" />
                    <asp:Parameter Name="Notes" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlMY" Name="ModelYear" PropertyName="SelectedValue" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlReqBy" Name="RequestedBy" PropertyName="SelectedValue" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlCategories" Name="Category" PropertyName="SelectedValue" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlSeries" Name="Series" PropertyName="SelectedValue" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlStrategicPriority" Name="StrategicPriority" PropertyName="SelectedValue" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlSalesPriority" Name="SalesPriority" PropertyName="SelectedValue" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlEngActive" Name="EngActiveFlag" PropertyName="SelectedValue" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="ddlProjectStatuses" Name="ProjectStatus" PropertyName="SelectedValue" DefaultValue='%' Type="String" />
                    <asp:ControlParameter ControlID="tbProjectID" Name="ProjectID" DefaultValue='%' Type ="String" />                    
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="RequestedBy" Type="String" />
                    <asp:Parameter Name="RequestedDate" Type="DateTime" />
                    <asp:Parameter Name="ApprovalStatus" Type="Int32" />
                    <asp:Parameter Name="Category" Type="String" />
                    <asp:Parameter Name="Series" Type="String" />
                    <asp:Parameter Name="InitialDescription" Type="String" />
                    <asp:Parameter Name="NarrowedDescription" Type="String" />
                    <asp:Parameter Name="StrategicPriority" Type="Int32" />
                    <asp:Parameter Name="SalesPriority" Type="Int32" />
                    <asp:Parameter Name="EngActiveFlag" Type="Int32" />
                    <asp:Parameter Name="ProjectLead" Type="String" />
                    <asp:Parameter DbType="Date" Name="TargetDate" />
                    <asp:Parameter Name="ProjectStatus" Type="Int32" />
                    <asp:Parameter Name="Notes" Type="String" />
                    <asp:Parameter Name="ModelYear" Type="Int32" />
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
        </div>
    </form>
</body>
</html>
