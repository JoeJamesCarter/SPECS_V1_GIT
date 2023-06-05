<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditStatus.aspx.vb" Inherits="SRT_EditStatus" Debug="True" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Notes and Change Status</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        #editContainer {
            width: 1200px;
        }

        #left {
            float: left;
            width: 50%;
        }

        #right {
            float: left;
            width: 50%;
        }

        #bottom {
            width:100%;
            float: left;
        }
        #attachments {
            font-family:Calibri;
            font-size:20px;
            font-weight:bold;
        }
       
    </style>

     <script>
         window.onunload = function () {
             window.opener.document.getElementById('btnRefresh').click();

         }

     </script>
</head>
<body class="newStyle6">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Edit Status and Notes" CssClass="newStyle7"></asp:Label>
            &nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" Text="Item ID: " CssClass="newStyle6"></asp:Label>
            <asp:Label ID="lblItemID" runat="server" Text="" CssClass="newStyle6"></asp:Label>
            &nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label2" runat="server" Text="Item Category:  " CssClass="newStyle6"></asp:Label><asp:Label ID="lblItemDesc" runat="server" Text="" CssClass="newStyle6"></asp:Label>
            <br />
            <asp:HiddenField ID="hdnDependency" runat="server" />
            <br />
            <div id="editContainer">
                <div id="left">
                    <asp:Label ID="Label11" runat="server" CssClass="newStyle6" Text="Edit Item:" Width="290px"></asp:Label>
                    <br />
                    <asp:DetailsView ID="dvEditItem" runat="server" AutoGenerateRows="False" DataKeyNames="ItemID" DataSourceID="sdsThisItem" Height="50px" Width="500px" CssClass="newStyle1">
                        <Fields>
                            <asp:BoundField DataField="ItemID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ItemID" />
                            <asp:BoundField DataField="ModelYear" HeaderText="Model Year" SortExpression="ModelYear" />
                            <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                            <asp:BoundField DataField="Supplier" HeaderText="Supplier" SortExpression="Supplier" />
                            <asp:BoundField DataField="Color_Type" HeaderText="Color/Type" SortExpression="Color_Type" />
                            <asp:BoundField DataField="Replaces" HeaderText="Replaces" />
                            <asp:BoundField DataField="ModelInfo" HeaderText="Model" />
                            <asp:BoundField DataField="DependentOn" HeaderText="Dependent On" SortExpression="DependentOn" />
                            <asp:BoundField DataField="LeadTime" HeaderText="Lead Time (wks)" SortExpression="LeadTime" />
                            <asp:BoundField DataField="DependentOnItemsList" HeaderText="Triggered By Items" ReadOnly="True" SortExpression="DependentOnItemsList" />
                            <asp:CommandField ShowEditButton="True" />
                        </Fields>
                    </asp:DetailsView>
                    <asp:SqlDataSource ID="sdsThisItem" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [SupplierTracking_Items] WHERE [ItemID] = @ItemID" InsertCommand="INSERT INTO [SupplierTracking_Items] ([ModelYear], [Category], [Supplier], [Color_Type], [DependentOn], [LeadTime], [DependentOnItemsList], [Replaces], [ModelInfo]) VALUES (@ModelYear, @Category, @Supplier, @Color_Type, @DependentOn, @LeadTime, @DependentOnItemsList, @Replaces, @ModelInfo)" SelectCommand="SELECT * FROM [SupplierTracking_Items] WHERE ([ItemID] = @ItemID)" UpdateCommand="UPDATE [SupplierTracking_Items] SET [ModelYear] = @ModelYear, [Category] = @Category, [Supplier] = @Supplier, [Color_Type] = @Color_Type, [DependentOn] = @DependentOn, [LeadTime] = @LeadTime, [DependentOnItemsList] = @DependentOnItemsList, [Replaces] = @Replaces, [ModelInfo] = @ModelInfo WHERE [ItemID] = @ItemID">
                        <DeleteParameters>
                            <asp:Parameter Name="ItemID" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="ModelYear" Type="String" />
                            <asp:Parameter Name="Category" Type="String" />
                            <asp:Parameter Name="Supplier" Type="String" />
                            <asp:Parameter Name="Color_Type" Type="String" />
                            <asp:Parameter Name="Replaces" Type="String" />
                            <asp:Parameter Name="ModelInfo" Type="String" />
                            <asp:Parameter Name="DependentOn" Type="String" />
                            <asp:Parameter Name="LeadTime" Type="Int32" />
                            <asp:Parameter Name="DependentOnItemsList" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblItemID" Name="ItemID" PropertyName="Text" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="ModelYear" Type="String" />
                            <asp:Parameter Name="Category" Type="String" />
                            <asp:Parameter Name="Supplier" Type="String" />
                            <asp:Parameter Name="Color_Type" Type="String" />
                            <asp:Parameter Name="Replaces" Type="String" />
                            <asp:Parameter Name="ModelInfo" Type="String" />
                            <asp:Parameter Name="DependentOn" Type="String" />
                            <asp:Parameter Name="LeadTime" Type="Int32" />
                            <asp:Parameter Name="DependentOnItemsList" Type="String" />
                            <asp:Parameter Name="ItemID" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <br />
                </div>
                <div id="right">
                    <asp:Label ID="Label10" runat="server" CssClass="newStyle6" Text="Triggered By Approval Of:" Width="290px"></asp:Label>
                    <asp:GridView ID="gvParents" runat="server" AutoGenerateColumns="False" DataKeyNames="ItemID" DataSourceID="sdsItemsInDependentCategory" CssClass="newStyle1" Width="600px">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbSelected" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ItemID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ItemID" />
                            <asp:BoundField DataField="Color_Type" HeaderText="Color/Type" SortExpression="Color_Type" />
                            <asp:BoundField DataField="Supplier" HeaderText="Supplier" SortExpression="Supplier" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsItemsInDependentCategory" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ItemID], [Color_Type], [Supplier] FROM [SupplierTracking_Items] WHERE ([Category] = @Dependency) ORDER BY [ItemID]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdnDependency" Name="Dependency" PropertyName="Value" Type="String" />
                        </SelectParameters>

                    </asp:SqlDataSource>


                    <br />
                    <asp:Button ID="btnUpdateTriggers" runat="server" Text="Update Triggers" />
                    <br />
                </div>
            </div>
            <div id="bottom">
                <hr />
                <asp:Label ID="Label8" runat="server" Text="History:" CssClass="newStyle4"></asp:Label>
                <br />
                <asp:GridView ID="gvNotes" runat="server" AutoGenerateColumns="False" DataSourceID="sdsStatusNotes" CssClass="newStyle3" Width="1199px" DataKeyNames="EntryID">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="WeekOf" HeaderText="Week Of" SortExpression="Week Of" DataFormatString="{0:d}" >
                        <ItemStyle Width="150px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                        <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" >
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>               
                <asp:SqlDataSource ID="sdsStatusNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [SupplierReadiness_StatusNotes] WHERE [EntryID] = @EntryID" InsertCommand="INSERT INTO [SupplierReadiness_StatusNotes] ([ItemID], [WeekOf], [Status], [Notes]) VALUES (@ItemID, @WeekOf, @Status, @Notes)" SelectCommand="SELECT * FROM [SupplierReadiness_StatusNotes] WHERE ([ItemID] = @ItemID) ORDER BY [WeekOf], [EntryId]" UpdateCommand="UPDATE [SupplierReadiness_StatusNotes] SET [ItemID] = @ItemID, [WeekOf] = @WeekOf, [Status] = @Status, [Notes] = @Notes WHERE [EntryID] = @EntryID">
                    <DeleteParameters>
                        <asp:Parameter Name="EntryID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ItemID" Type="Int32" />
                        <asp:Parameter DbType="Date" Name="WeekOf" />
                        <asp:Parameter Name="Status" Type="String" />
                        <asp:Parameter Name="Notes" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblItemID" Name="ItemID" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ItemID" Type="Int32" />
                        <asp:Parameter DbType="Date" Name="WeekOf" />
                        <asp:Parameter Name="Status" Type="String" />
                        <asp:Parameter Name="Notes" Type="String" />
                        <asp:Parameter Name="EntryID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <br />
                <hr />
                <asp:Label ID="Label12" runat="server" Text="Upload Attachments:" CssClass="newStyle4"></asp:Label>
                &nbsp;
                <asp:FileUpload ID="File1" runat="server" Width="381px" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="btnUpload" runat="server" Text="Upload" />
                &nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblUploadResult" runat="server" CssClass="newStyle3"></asp:Label>
                <br />
                <div id="attachments">
                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                </div>
                <br />
                <hr />
                <br />
                <asp:Label ID="Label9" runat="server" Text="Add Status/Notes:" CssClass="newStyle4"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label4" runat="server" CssClass="newStyle6" Text="Model Year:  " Width="100px"></asp:Label>
                <asp:DropDownList ID="ddlModelYear" runat="server">
                    <asp:ListItem>2020</asp:ListItem>
                    <asp:ListItem>2021</asp:ListItem>
                    <asp:ListItem>2022</asp:ListItem>
                    <asp:ListItem>2023</asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:Label ID="Label5" runat="server" CssClass="newStyle6" Text="Week Of:  " Width="100px"></asp:Label>
                <asp:DropDownList ID="ddlWeekOf" runat="server">
                </asp:DropDownList>
                <br />
                <asp:Label ID="Label6" runat="server" CssClass="newStyle6" Text="Status:  " Width="100px"></asp:Label>
                <asp:DropDownList ID="ddlStatuses" runat="server" DataSourceID="sdsStatuses" DataTextField="StatusDesc" DataValueField="Status">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Status], [StatusDesc] FROM [SupplierReadines_Statuses] ORDER BY [Status]"></asp:SqlDataSource>
                <br />
                <br />
                <asp:Label ID="Label7" runat="server" CssClass="newStyle6" Text="Notes:  " Width="100px"></asp:Label><asp:TextBox ID="tbNote" runat="server" Height="66px" TextMode="MultiLine" Width="330px"></asp:TextBox>
                &nbsp;
        <asp:Button ID="btnSave" runat="server" Text="Save" Height="36px" Width="144px" />
            </div>
        </div>
    </form>
</body>
</html>
