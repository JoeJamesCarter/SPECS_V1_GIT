<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WarrantyWork.aspx.vb" Inherits="Warranty_WarrantyWork" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Warranty Work</title>
    <style type="text/css">
        .newStyle1 {
            font-family: calibri;
            font-size: 17px;
            text-align: center;
        }
        .newStyle2 {
            font-family: Calibri;
            font-size: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <span class="newStyle2">WARRANTY WORK&nbsp;&nbsp;
        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
        </span><br />
    
        <asp:GridView ID="gvWarrantyWork" runat="server" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" CssClass="newStyle1" DataKeyNames="Auto" DataSourceID="sdsWarranty" ForeColor="Black">
            <Columns>
                <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Boat Info">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Dealer") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("RetailCustomerName") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("Model") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("Color") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("SerialNo") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="200px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server" enabled="false" SelectedValue='<%# Bind("Status") %>'>
                                <asp:ListItem Value="0">Entered</asp:ListItem>
                            <asp:ListItem Value="1">Transport Arranged</asp:ListItem>
                            <asp:ListItem Value="2">Arrived</asp:ListItem>
                            <asp:ListItem Value="3">Parts Are Ready</asp:ListItem>
                            <asp:ListItem Value="4">Repairs Completed</asp:ListItem>
                            <asp:ListItem Value="5">Complete</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="RequestedReturnDate" DataFormatString="{0:d}" HeaderText="Requested Return" SortExpression="RequestedReturnDate" />
                <asp:TemplateField HeaderText="Arrival">
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("ArrivedVia") %>'></asp:Label>
                        <br />
                        on<br />
                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("DateofArrival", "{0:d}") %>'></asp:Label>
                        <br />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="WorkNeeded" HeaderText="Dealer Reported Work Required" SortExpression="WorkNeeded">
                <ItemStyle Width="200px" HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="EvalNotes" HeaderText="Actual Work Plan">
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="PartsOrdered" HeaderText="Parts Ordered" SortExpression="PartsOrdered" >
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Attach Files/Photos"></asp:TemplateField>
                <asp:TemplateField HeaderText="Inspected">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnInspected" runat="server" ImageUrl='<%# Eval("InspectedStatus", "../Images/complete_status{0}.png")%>' OnClick="btnInspected_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Inspection Notes">
                    <ItemTemplate>
                        <asp:TextBox ID="tbInspectionNotes" runat="server" Text='<%# Eval("InventoriedItems")%>' TextMode="MultiLine" Height="82px"></asp:TextBox>
                        <br />
                        <asp:Button ID="btnCloseInspectionNotes" runat="server" Text="Close" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnSaveInspectionNotes" runat="server" Text="Save" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Inventoried">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnInventory" runat="server" ImageUrl='<%# Eval("InventoryStatus", "../Images/complete_status{0}.png")%>' OnClick="btnInventory_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Inventoried Items">
                    <ItemTemplate>
                        <asp:TextBox ID="tbInventoriedItems" runat="server" Text='<%# Eval("InventoriedItems")%>' TextMode="MultiLine" Height="82px"></asp:TextBox>
                        <br />
                        <asp:Button ID="btnCloseInventoryItems" runat="server" Text="Close" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnSaveInventoriedItems" runat="server" Text="Save" />
                        <br />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Eval Work Required">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnEvaluated" runat="server" ImageUrl='<%# Eval("EvalStatus", "../Images/complete_status{0}.png")%>' OnClick="btnEval_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actual Work Required">
                    <ItemTemplate>
                        <asp:TextBox ID="tbWorkRequired" runat="server" Text='<%# Eval("InventoriedItems")%>' TextMode="MultiLine" Height="82px"></asp:TextBox>
                        <br />
                        <asp:Button ID="btnCloseWorkRequired" runat="server" Text="Close" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnSaveWorkRequired" runat="server" Text="Save" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Work Complete">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnWorkCompleted" runat="server" ImageUrl='<%# Eval("CompleteStatus", "../Images/complete_status{0}.png")%>' OnClick="btnWorkComplete_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="Gray" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsWarranty" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [BML_POPREPORTING_WARRANTY] WHERE [Auto] = @Auto" InsertCommand="INSERT INTO [BML_POPREPORTING_WARRANTY] ([Priority], [Status], [Dealer], [RetailCustomerName], [Model], [SerialNo], [Color], [Approver], [RequestedReturnDate], [DateEntered], [DateofArrival], [ArrivedVia], [WorkNeeded], [PartsOrdered], [ReturnVia], [ReturnShipDate], [InventoriedItems], [WorkCompletedDesc], [InventoryStatus], [CompleteStatus]) VALUES (@Priority, @Status, @Dealer, @RetailCustomerName, @Model, @SerialNo, @Color, @Approver, @RequestedReturnDate, @DateEntered, @DateofArrival, @ArrivedVia, @WorkNeeded, @PartsOrdered, @ReturnVia, @ReturnShipDate, @InventoriedItems, @WorkCompletedDesc, @InventoryStatus, @CompleteStatus)" SelectCommand="SELECT * FROM [BML_POPREPORTING_WARRANTY] WHERE ([CompleteStatus] = @CompleteStatus) AND ([Status] = @ArrivedStatus) OR ([Status] = @PartsReadyStatus) ORDER BY [Priority] desc, [Auto]" UpdateCommand="UPDATE [BML_POPREPORTING_WARRANTY] SET [Priority] = @Priority, [Status] = @Status, [Dealer] = @Dealer, [RetailCustomerName] = @RetailCustomerName, [Model] = @Model, [SerialNo] = @SerialNo, [Color] = @Color, [Approver] = @Approver, [RequestedReturnDate] = @RequestedReturnDate, [DateEntered] = @DateEntered, [DateofArrival] = @DateofArrival, [ArrivedVia] = @ArrivedVia, [WorkNeeded] = @WorkNeeded, [PartsOrdered] = @PartsOrdered, [ReturnVia] = @ReturnVia, [ReturnShipDate] = @ReturnShipDate, [InventoriedItems] = @InventoriedItems, [WorkCompletedDesc] = @WorkCompletedDesc, [InventoryStatus] = @InventoryStatus, [CompleteStatus] = @CompleteStatus WHERE [Auto] = @Auto">
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
                <asp:Parameter Name="InventoriedItems" Type="String" />
                <asp:Parameter Name="WorkCompletedDesc" Type="String" />
                <asp:Parameter Name="InventoryStatus" Type="Int32" />
                <asp:Parameter Name="CompleteStatus" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />  
                <asp:Parameter DefaultValue="2" Name="ArrivedStatus" Type="Int32" />                
                <asp:Parameter DefaultValue="3" Name="PartsReadyStatus" Type="Int32" />  
            </SelectParameters>
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
                <asp:Parameter Name="InventoryStatus" Type="Int32" />
                <asp:Parameter Name="CompleteStatus" Type="Int32" />
                <asp:Parameter Name="Auto" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
