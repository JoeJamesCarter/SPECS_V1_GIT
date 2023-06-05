<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AddWarrantyRepair.aspx.vb" Inherits="Warranty_AddWarrantyRepair" %>


<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Boat for Warranty Repair</title>
    <link href="WarrantyStyleSheet.css" rel="stylesheet" />
   
    <style type="text/css">
        WarrantyTitles {
            font-family: Calibri;
            font-size: 20px;
            font-weight: bold;
        }
        .newStyle1 {
            font-family: calibri;
            font-size: 20px;
            font-weight: bold;
        }
    </style>
   
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <span class="newStyle1">WARRANTY BOAT REPAIRS</span><br />
        <asp:Button ID="btnShowAddABoat" runat="server" Text="Add A Boat" />
        <asp:Button ID="btnHideForm" runat="server" Text="Hide Form" />
     <asp:Panel ID="pnlAddABoat" runat="server">
        <asp:DetailsView ID="dvAddBoat" runat="server" AutoGenerateRows="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" CssClass="auto-style3" DataKeyNames="Auto" DataSourceID="sdsWarranty" ForeColor="Black" Height="50px">
            <EditRowStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
            <Fields>
                <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Status" SortExpression="Status">
                    <InsertItemTemplate>
                        <asp:DropDownList ID="ddlStatusAdd" runat="server" SelectedValue='<%# Bind("Status")%>'>
                            <asp:ListItem Value="0">Entered</asp:ListItem>
                            <asp:ListItem Value="1">Transport Arranged</asp:ListItem>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Priority" SortExpression="Priority" ConvertEmptyStringToNull="False">
                    <InsertItemTemplate>
                        <asp:DropDownList ID="ddlPriorityAdd" runat="server" SelectedValue='<%# Bind("Priority")%>'>
                            <asp:ListItem Value="0">Normal</asp:ListItem>
                            <asp:ListItem Value="1">High</asp:ListItem>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Dealer" HeaderText="Dealer" SortExpression="Dealer" ConvertEmptyStringToNull="False" />
                <asp:BoundField DataField="RetailCustomerName" HeaderText="Retail Customer" SortExpression="RetailCustomerName" ConvertEmptyStringToNull="False" />
                <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" ConvertEmptyStringToNull="False" />
                <asp:BoundField DataField="SerialNo" HeaderText="Serial #" SortExpression="SerialNo" ConvertEmptyStringToNull="False" />
                <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Date of Arrival" SortExpression="DateofArrival">
                    <InsertItemTemplate>
                        <asp:TextBox ID="tbDateofArrival" runat="server" Text='<%# Bind("DateofArrival")%>'></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:BoundField ConvertEmptyStringToNull="False" DataField="Approver" HeaderText="Approver" SortExpression="Approver" />
                <asp:TemplateField HeaderText="Color" SortExpression="Color" ConvertEmptyStringToNull="False">
                    <InsertItemTemplate>
                        <asp:DropDownList ID="Color" runat="server" SelectedValue='<%# Bind("Color")%>'>
                             <asp:ListItem Value="Bronze">Bronze</asp:ListItem>                             
                            <asp:ListItem Value="Charcoal">Charcoal</asp:ListItem>
                            <asp:ListItem Value="Champagne">Champagne</asp:ListItem>
                            <asp:ListItem Value="Crimson Red">Crimson Red</asp:ListItem>
                            <asp:ListItem Value="Hunter Green">Hunter Green</asp:ListItem>
                            <asp:ListItem Value="Matador Red">Matador Red</asp:ListItem>
                             <asp:ListItem Value="Midnight Black">Midnight Black</asp:ListItem>
                            <asp:ListItem Value="Regatta Blue">Regatta Blue</asp:ListItem>
                             <asp:ListItem Value="Smokey Granite">Smokey Granite</asp:ListItem>
                            <asp:ListItem Value="Steel Blue">Steel Blue</asp:ListItem>
                            <asp:ListItem Value="Wineberry">Wineberry</asp:ListItem>
                            <asp:ListItem Value="Yellow">Yellow</asp:ListItem>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                   </asp:TemplateField>
                <asp:BoundField DataField="ArrivedVia" HeaderText="Arrived Via" SortExpression="ArrivedVia" ConvertEmptyStringToNull="False" />
                <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Parts Ordered" SortExpression="PartsOrdered">
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="auto-style3" Height="75px" Text='<%# Bind("PartsOrdered") %>' TextMode="MultiLine" Width="229px"></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Work Needed" SortExpression="WorkNeeded" ConvertEmptyStringToNull="False">
                    
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Height="75px" Text='<%# Bind("WorkNeeded") %>' Width="229px"></asp:TextBox>
                    </InsertItemTemplate>
                    
                </asp:TemplateField>
                <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Requested Return" SortExpression="RequestedReturnDate">
                    <InsertItemTemplate>
                        <asp:TextBox ID="tbRequestedDateofReturn" runat="server" Text='<%# Bind("RequestedReturnDate")%>'></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ReturnVia" HeaderText="Return Via" SortExpression="ReturnVia" ConvertEmptyStringToNull="False" />
                <asp:CommandField ShowInsertButton="True" />
            </Fields>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
        </asp:DetailsView>
       
        </asp:Panel>
        <br />       
        <br />
         <span class="newStyle1">EXISTING BOATS</span><asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
         <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" DataKeyNames="Auto" DataSourceID="sdsWarranty" ForeColor="Black" CssClass="auto-style3">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:TemplateField HeaderText="Priority">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlPriorityEdit" runat="server" SelectedValue='<%# Bind("Priority")%>' >
                            <asp:ListItem Value="0">Normal</asp:ListItem>
                            <asp:ListItem Value="1">High</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlPriority" runat="server" enabled="false" SelectedValue='<%# Eval("Priority")%>'  >
                            <asp:ListItem Value="0">Normal</asp:ListItem>
                            <asp:ListItem Value="1">High</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlStatusEdit" runat="server" SelectedValue='<%# Bind("Status")%>' >
                            <asp:ListItem Value="0">Entered</asp:ListItem>
                            <asp:ListItem Value="1">Transport Arranged</asp:ListItem>
                            <asp:ListItem Value="2">Arrived</asp:ListItem>
                            <asp:ListItem Value="3">Parts Are Ready</asp:ListItem>
                            <asp:ListItem Value="4">Repairs Completed</asp:ListItem>
                            <asp:ListItem Value="5">Complete</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server" enabled="false" SelectedValue='<%# Eval("Status")%>'>
                           <asp:ListItem Value="0">Entered</asp:ListItem>
                            <asp:ListItem Value="1">Transport Arranged</asp:ListItem>
                            <asp:ListItem Value="2">Arrived</asp:ListItem>
                            <asp:ListItem Value="3">Parts Are Ready</asp:ListItem>
                            <asp:ListItem Value="4">Repairs Completed</asp:ListItem>
                            <asp:ListItem Value="5">Complete</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:BoundField DataField="Dealer" HeaderText="Dealer" SortExpression="Dealer" />
                <asp:BoundField DataField="RetailCustomerName" HeaderText="Retail Customer" SortExpression="RetailCustomerName" />
                <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
                <asp:BoundField DataField="SerialNo" HeaderText="Serial #" SortExpression="SerialNo" />
                <asp:BoundField DataField="Color" HeaderText="Color" SortExpression="Color" />
                <asp:BoundField DataField="Approver" HeaderText="Approver" SortExpression="Approver" />                
                <asp:BoundField DataField="DateofArrival" HeaderText="Date of Arrival" SortExpression="DateofArrival" DataFormatString="{0:d}" />
                <asp:BoundField DataField="RequestedReturnDate" HeaderText="Requested Return" SortExpression="RequestedReturnDate" DataFormatString="{0:d}" />
                <asp:BoundField DataField="ArrivedVia" HeaderText="Arrived Via" SortExpression="ArrivedVia" />
                <asp:BoundField DataField="WorkNeeded" HeaderText="Work Needed" SortExpression="WorkNeeded" >
                <ItemStyle Width="300px" />
                </asp:BoundField>
                <asp:BoundField DataField="PartsOrdered" HeaderText="Parts Ordered" SortExpression="PartsOrdered" >
                <ItemStyle Width="300px" />
                </asp:BoundField>
                <asp:BoundField DataField="ReturnVia" HeaderText="Return Via" SortExpression="ReturnVia" >
                <ItemStyle Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="ReturnShipDate" HeaderText="Return Date" SortExpression="ReturnShipDate" DataFormatString="{0:d}" />
                <asp:BoundField DataField="InventoryStatus" HeaderText="InventoryStatus" SortExpression="InventoryStatus" Visible="False" />
                <asp:BoundField DataField="CompleteStatus" HeaderText="CompleteStatus" SortExpression="CompleteStatus" Visible="False" />
                <asp:BoundField DataField="InspectedStatus" HeaderText="InspectedStatus" SortExpression="InspectedStatus" Visible="False" />
                <asp:BoundField DataField="EvalStatus" HeaderText="EvalStatus" SortExpression="EvalStatus" Visible="False" />
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
        <br />
    
        <asp:SqlDataSource ID="sdsWarranty" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [BML_POPREPORTING_WARRANTY] WHERE [Auto] = @Auto" InsertCommand="INSERT INTO [BML_POPREPORTING_WARRANTY] ([Priority], [Status], [Dealer], [RetailCustomerName], [Model], [SerialNo], [Color], [Approver], [RequestedReturnDate], [DateEntered], [DateofArrival], [ArrivedVia], [WorkNeeded], [PartsOrdered], [ReturnVia], [ReturnShipDate], [InventoriedItems], [WorkCompletedDesc]) VALUES (@Priority, @Status, @Dealer, @RetailCustomerName, @Model, @SerialNo, @Color, @Approver, @RequestedReturnDate, @DateEntered, @DateofArrival, @ArrivedVia, @WorkNeeded, @PartsOrdered, @ReturnVia, @ReturnShipDate, @InventoriedItems, @WorkCompletedDesc)" SelectCommand="SELECT * FROM [BML_POPREPORTING_WARRANTY] ORDER BY [Auto]" UpdateCommand="UPDATE [BML_POPREPORTING_WARRANTY] SET [Priority] = @Priority, [Status] = @Status, [Dealer] = @Dealer, [RetailCustomerName] = @RetailCustomerName, [Model] = @Model, [SerialNo] = @SerialNo, [Color] = @Color, [Approver] = @Approver, [RequestedReturnDate] = @RequestedReturnDate, [DateEntered] = @DateEntered, [DateofArrival] = @DateofArrival, [ArrivedVia] = @ArrivedVia, [WorkNeeded] = @WorkNeeded, [PartsOrdered] = @PartsOrdered, [ReturnVia] = @ReturnVia, [ReturnShipDate] = @ReturnShipDate, [InventoriedItems] = @InventoriedItems, [WorkCompletedDesc] = @WorkCompletedDesc WHERE [Auto] = @Auto">
            <DeleteParameters>
                <asp:Parameter Name="Auto" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Priority" Type="Int32" />
                <asp:Parameter Name="Status" Type="Int32" />
                <asp:Parameter Name="Dealer" Type="String" />
                <asp:Parameter Name="RetailCustomerName" Type="String" />
                <asp:Parameter Name="Model" Type="String" />
                <asp:Parameter Name="SerialNo" Type="String" />
                <asp:Parameter Name="Color" Type="String" />
                <asp:Parameter Name="Approver" Type="String" />
                <asp:Parameter DbType="Date" Name="RequestedReturnDate" />
                <asp:Parameter Name="DateEntered" Type="DateTime" />
                <asp:Parameter Name="DateofArrival" Type="DateTime" />
                <asp:Parameter Name="ArrivedVia" Type="String" />
                <asp:Parameter Name="WorkNeeded" Type="String" />
                <asp:Parameter Name="PartsOrdered" Type="String" />
                <asp:Parameter Name="ReturnVia" Type="String" />
                <asp:Parameter DbType="Date" Name="ReturnShipDate" />
                <asp:Parameter Name="InventoriedItems" DefaultValue="0" Type="String" />
                <asp:Parameter Name="WorkCompletedDesc" Type="String" />                
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Priority" Type="Int32" />
                <asp:Parameter Name="Status" Type="Int32" />
                <asp:Parameter Name="Dealer" Type="String" />
                <asp:Parameter Name="RetailCustomerName" Type="String" />
                <asp:Parameter Name="Model" Type="String" />
                <asp:Parameter Name="SerialNo" Type="String" />
                <asp:Parameter Name="Color" Type="String" />
                <asp:Parameter Name="Approver" Type="String" />
                <asp:Parameter DbType="Date" Name="RequestedReturnDate" />
                <asp:Parameter Name="DateEntered" Type="DateTime" />
                <asp:Parameter Name="DateofArrival" Type="DateTime" />
                <asp:Parameter Name="ArrivedVia" Type="String" />
                <asp:Parameter Name="WorkNeeded" Type="String" />
                <asp:Parameter Name="PartsOrdered" Type="String" />
                <asp:Parameter Name="ReturnVia" Type="String" />
                <asp:Parameter DbType="Date" Name="ReturnShipDate" />
                <asp:Parameter Name="InventoriedItems" Type="String" />
                <asp:Parameter Name="WorkCompletedDesc" Type="String" />               
                <asp:Parameter Name="Auto" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
