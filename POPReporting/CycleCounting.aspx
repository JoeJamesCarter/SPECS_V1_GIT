<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CycleCounting.aspx.vb" Inherits="CycleCounting" Debug="true" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cycle Counting</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="StyleSheet.css" rel="stylesheet" />
    <link rel="stylesheet" href="./scripts/css/bootstrap.min.css" />

</head>
<body>

    <form id="form1" runat="server">
        <div runat="server" class="row p-1 float-left m-1">
            <asp:Button ID="btnCountToday" class="btn btn-outline-primary m-1" runat="server" Text="Count Today" />
            <asp:Button ID="btnByPart" class="btn btn-outline-primary m-1" runat="server" Text="By Part" />
            <asp:Button ID="btnByLoc" class="btn btn-outline-primary m-1" runat="server" Text="By Loc" />
        </div>
        <div id="counters" runat="server" class="float-left p-1 ml-2 mt-2">
            <asp:Button ID="btnCounter1" class="btn btn-outline-primary btn-sm m-1 float-left" runat="server" Text="Jeff" />
            <asp:Button ID="btnCounter2" class="btn btn-outline-primary btn-sm float-left m-1" runat="server" Text="Sue" />
        </div>
        <div id="weeks" runat="server">
            <div class="container form-row">
                <div class="col w-40">
                    <label for="rblWeek" class="ml-1 mr-1">Week:</label>
                    <asp:RadioButtonList ID="rblWeek" runat="server" RepeatDirection="Horizontal" CellSpacing="2" CellPadding="4" AutoPostBack="True">
                        <asp:ListItem>A</asp:ListItem>
                        <asp:ListItem>B1</asp:ListItem>
                        <asp:ListItem>B2</asp:ListItem>
                        <asp:ListItem>B3</asp:ListItem>
                        <%-- <asp:ListItem>RS</asp:ListItem>--%>
                    </asp:RadioButtonList>
                </div>

                <div class="col w-60">
                    <label for="rblDay" class="ml-1 mr-1">Day:</label>
                    <asp:RadioButtonList ID="rblDay" runat="server" RepeatDirection="Horizontal" CellSpacing="2" CellPadding="4" AutoPostBack="True">
                        <asp:ListItem>M </asp:ListItem>
                        <asp:ListItem>TU</asp:ListItem>
                        <asp:ListItem>W</asp:ListItem>
                        <asp:ListItem>TH</asp:ListItem>
                        <asp:ListItem>F</asp:ListItem>
                        <%-- <asp:ListItem>RS</asp:ListItem>--%>
                    </asp:RadioButtonList>
                </div>
            </div>
        </div>

        <div class="row m-1 col-12">
            <div id="counttoday" runat="server">
                <asp:HiddenField ID="hdnCounterID" runat="server" />
                <asp:HiddenField ID="hdnToday" runat="server" />
                <asp:GridView ID="gvCounter" runat="server" DataSourceID="sdsTodaysCounts" AutoGenerateColumns="False" DataKeyNames="AutoID" CssClass="gvs" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="100%">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText="Count Today">
                            <ItemTemplate>
                                <asp:Label ID="lblPartNo" runat="server" CssClass="mr-2" Text='<%#Eval("PartNo") %>'></asp:Label>
                                <asp:HiddenField ID="hdnAutoID" runat="server" Value='<%#Eval("AutoID") %>' />
                                <asp:Label ID="Label10" runat="server" Text='<%#Eval("item_desc_1") %>'></asp:Label><br />
                                <div class="form-inline">
                                    <label for="tbQtyByCounter" class="mr-2">Qty:</label><asp:TextBox ID="tbQtyByCounter" CssClass="form-control w-25" runat="server" BorderStyle="Solid"></asp:TextBox>
                                    <label for="tbAreaByCounter" class="ml-2 mr-2">Area:</label><asp:TextBox ID="tbAreaByCounter" CssClass="form-control w-25" runat="server" BorderStyle="Solid"></asp:TextBox>
                                    <asp:Button ID="btnByCounterIDSave" runat="server" Text="Save" CssClass="float-left btn btn-primary ml-3" CommandArgument='<%# Container.DataItemIndex%>' CommandName="countersave" />
                                    <br />
                                </div>
                                <asp:GridView ID="gvPrevDailyCounts" runat="server" AutoGenerateColumns="False" CssClass="mt-1" DataSourceID="sdsTodaysCountsPerPart" Width="100%" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="AutoID">
                                    <Columns>
                                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                        <asp:BoundField DataField="Counted" HeaderText="Counted" SortExpression="Counted" />
                                        <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Area" HeaderText="Area" SortExpression="Area">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                    </Columns>
                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                    <RowStyle BackColor="White" ForeColor="#003399" />
                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <SortedAscendingCellStyle BackColor="#EDF6F6" />
                                    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                                    <SortedDescendingCellStyle BackColor="#D6DFDF" />
                                    <SortedDescendingHeaderStyle BackColor="#002876" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsTodaysCountsPerPart" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Counted], [Qty], [Area], [AutoID] FROM [CycleCounts] WHERE ([PartNo] = @PartNo) And (convert(varchar(10), Counted, 102) = convert(varchar(10), getdate(), 102)) ORDER BY [Counted] DESC" DeleteCommand="DELETE FROM [CycleCounts] WHERE [AutoID] = @AutoID" InsertCommand="INSERT INTO [CycleCounts] ([Counted], [Qty], [Area]) VALUES (@Counted, @Qty, @Area)" UpdateCommand="UPDATE [CycleCounts] SET [Counted] = @Counted, [Qty] = @Qty, [Area] = @Area WHERE [AutoID] = @AutoID">
                                    <DeleteParameters>
                                        <asp:Parameter Name="AutoID" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="Counted" Type="DateTime" />
                                        <asp:Parameter Name="Qty" Type="Double" />
                                        <asp:Parameter Name="Area" Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="lblPartNo" Name="PartNo" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="Counted" Type="DateTime" />
                                        <asp:Parameter Name="Qty" Type="Double" />
                                        <asp:Parameter Name="Area" Type="String" />
                                        <asp:Parameter Name="AutoID" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>
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

                <asp:GridView ID="gvPPLList" runat="server" DataSourceID="sdsPPLSelected" AutoGenerateColumns="False" CssClass="gvs" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="100%">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText="PPL Count Today">
                            <ItemTemplate>
                                <asp:Label ID="lblPPLPartNo" runat="server" CssClass="mr-2" Text='<%#Eval("ItemNo") %>'></asp:Label>
                                <asp:Label ID="Label10" runat="server" Text='<%#Eval("item_desc_1") %>'></asp:Label>
                                -
                                <asp:Label ID="Label4" runat="server" Text='<%#Eval("item_desc_2") %>'></asp:Label><br />
                                <asp:Label ID="Label6" runat="server" Text='<%#Eval("vendor") %>'></asp:Label><br />
                                <hr />
                                <div class="container form-row mt-1" runat="server">
                                    <div class="col">
                                        <label for="tbPPLQty" class="mr-1 float-left">Qty:</label>                                                                                
                                        <asp:TextBox ID="tbPPLQty" runat="server" CssClass="form-control w-100 float-left"></asp:TextBox>                                                                                
                                        <asp:Label ID="Label7" runat="server" CssClass="float-left" Text='<%#Eval("pur_uom") %>'></asp:Label>
                                    </div>
                                  
                                    <div class="col">
                                        <asp:Label ID="Label9" runat="server" Text="Locations:"></asp:Label>
                                        <asp:RadioButtonList ID="rblLocations" runat="server" DataSourceID="sdsPartLocs" DataTextField="Note" DataValueField="Note" CellPadding="-1" CellSpacing="-1"></asp:RadioButtonList>
                                        <asp:SqlDataSource ID="sdsPartLocs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Note] FROM [PPL_PartLocNotes] WHERE ([ItemNo] = @ItemNo) ORDER BY [Note]">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblPPLPartNo" Name="ItemNo" PropertyName="Text" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                    <div class="col">
                                        <asp:Label ID="Label8" runat="server" Text="Other Location:"></asp:Label><asp:TextBox ID="tbOtherLoc" runat="server"></asp:TextBox>  <asp:Label ID="Label12" runat="server" Text="(optional):"></asp:Label>
                                    </div>
                                    <div class="float-left">
                                        <asp:Button ID="btnPPLCalcAndSave" runat="server" Text="Save" Enabled="true" CssClass="btn btn-primary ml-1" CommandArgument='<%# Container.DataItemIndex%>' CommandName="calcandsave" />
                                    </div>
                                    <br />
                                </div>
                                <asp:GridView ID="gvPPLCountToday" runat="server" AutoGenerateColumns="False" CssClass="mt-1" DataSourceID="sdsPPLCountsTodayPerPart" Width="100%" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="ItemNo,LocNote,Qty,CountDate">
                                    <Columns>
                                        <asp:BoundField DataField="ItemNo" HeaderText="Part #" SortExpression="ItemNo" ReadOnly="True" />
                                        <asp:BoundField DataField="LocNote" HeaderText="Location" SortExpression="LocNote" ReadOnly="True">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" ReadOnly="True">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CountDate" HeaderText="Counted" ReadOnly="True" SortExpression="CountDate" />
                                    </Columns>
                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                    <RowStyle BackColor="White" ForeColor="#003399" />
                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <SortedAscendingCellStyle BackColor="#EDF6F6" />
                                    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                                    <SortedDescendingCellStyle BackColor="#D6DFDF" />
                                    <SortedDescendingHeaderStyle BackColor="#002876" />
                                </asp:GridView>
                               
                                <asp:SqlDataSource ID="sdsPPLCountsTodayPerPart" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [PPL_PartCounts] WHERE [ItemNo] = @ItemNo AND [LocNote] = @LocNote AND [Qty] = @Qty AND [CountDate] = @CountDate" InsertCommand="INSERT INTO [PPL_PartCounts] ([ItemNo], [LocNote], [Qty], [CountDate]) VALUES (@ItemNo, @LocNote, @Qty, @CountDate)" SelectCommand="SELECT * FROM [PPL_PartCounts] WHERE [ItemNo] = @ItemNo And (convert(varchar(10), CountDate, 102) = convert(varchar(10), getdate(), 102)) ORDER BY [CountDate] DESC">
                                    <DeleteParameters>
                                        <asp:Parameter Name="ItemNo" Type="String" />
                                        <asp:Parameter Name="LocNote" Type="String" />
                                        <asp:Parameter Name="Qty" Type="Int32" />
                                        <asp:Parameter Name="CountDate" Type="DateTime" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="ItemNo" Type="String" />
                                        <asp:Parameter Name="LocNote" Type="String" />
                                        <asp:Parameter Name="Qty" Type="Int32" />
                                        <asp:Parameter Name="CountDate" Type="DateTime" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="lblPPLPartNo" Name="ItemNo" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                               
                            </ItemTemplate>
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
                <asp:SqlDataSource ID="sdsPPLSelected" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.*, t2.item_desc_1, t2.item_desc_2, t2.pur_uom FROM [PPL_PartsToCount] t1 Left join Inventory_ItemMaster t2 on t1.ItemNo = t2.item_no WHERE (([Week] = @Week) AND ([Day] = @Day)) ORDER BY [ItemNo]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="rblWeek" Name="Week" PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="rblDay" Name="Day" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:GridView ID="gvCounterYellow" runat="server" DataSourceID="sdsTodaysCountsWYellow" AutoGenerateColumns="False" CssClass="mt-2" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="100%">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText="South Parts To Watch">
                            <ItemTemplate>
                                <asp:Label ID="lblPartNo" runat="server" CssClass="mr-2" Text='<%#Eval("PartNo") %>'></asp:Label>
                                <asp:Label ID="Label10" runat="server" Text='<%#Eval("item_desc_1") %>'></asp:Label><br />
                                <div class="form-inline">
                                    <label for="tbQtyByCounterY" class="mr-2">Qty:</label><asp:TextBox ID="tbQtyByCounterY" CssClass="form-control w-25" runat="server" BorderStyle="Solid"></asp:TextBox>
                                    <label for="tbAreaByCounterY" class="ml-2 mr-2">Area:</label><asp:TextBox ID="tbAreaByCounterY" CssClass="form-control w-25" runat="server" BorderStyle="Solid"></asp:TextBox>
                                    <asp:Button ID="btnByCounterIDYSave" runat="server" Text="Save" CssClass="float-left btn btn-primary ml-3" CommandArgument='<%# Container.DataItemIndex%>' CommandName="counterYsave" />
                                    <br />
                                </div>
                                <asp:GridView ID="gvPrevDailyCounts" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTodaysCountsPerPart" CssClass="mt-1" Width="100%" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="AutoID">
                                    <Columns>
                                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                        <asp:BoundField DataField="Counted" HeaderText="Counted" SortExpression="Counted" />
                                        <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Area" HeaderText="Area" SortExpression="Area">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                    </Columns>
                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                    <RowStyle BackColor="White" ForeColor="#003399" />
                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <SortedAscendingCellStyle BackColor="#EDF6F6" />
                                    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                                    <SortedDescendingCellStyle BackColor="#D6DFDF" />
                                    <SortedDescendingHeaderStyle BackColor="#002876" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsTodaysCountsPerPart" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Counted], [Qty], [Area], [AutoID] FROM [CycleCounts] WHERE ([PartNo] = @PartNo) And (convert(varchar(10), Counted, 102) = convert(varchar(10), getdate(), 102)) ORDER BY [Counted] DESC" DeleteCommand="DELETE FROM [CycleCounts] WHERE [AutoID] = @AutoID" InsertCommand="INSERT INTO [CycleCounts] ([Counted], [Qty], [Area]) VALUES (@Counted, @Qty, @Area)" UpdateCommand="UPDATE [CycleCounts] SET [Counted] = @Counted, [Qty] = @Qty, [Area] = @Area WHERE [AutoID] = @AutoID">
                                    <DeleteParameters>
                                        <asp:Parameter Name="AutoID" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="Counted" Type="DateTime" />
                                        <asp:Parameter Name="Qty" Type="Double" />
                                        <asp:Parameter Name="Area" Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="lblPartNo" Name="PartNo" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="Counted" Type="DateTime" />
                                        <asp:Parameter Name="Qty" Type="Double" />
                                        <asp:Parameter Name="Area" Type="String" />
                                        <asp:Parameter Name="AutoID" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>
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
                <asp:SqlDataSource ID="sdsTodaysCountsWYellow" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.*, t3.item_desc_1, t3.uom FROM [KittingSouthParts] t1 Left join Inventory_ItemMaster t3 on PartNo = t3.item_no WHERE Watch = 1 ORDER BY [PartNo]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnCounterID" Name="CounterID" PropertyName="Value" Type="Int32" />
                        <asp:ControlParameter ControlID="hdnToday" DbType="Date" Name="DateToCount" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsTodaysCounts" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [CycleCounts] Left join Inventory_ItemMaster on PartNo = item_no WHERE [CounterID] = @CounterID AND [DateToCount] = @DateToCount and Qty is null ORDER BY [PartNo]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnCounterID" Name="CounterID" PropertyName="Value" Type="Int32" />
                        <asp:ControlParameter ControlID="hdnToday" DbType="Date" Name="DateToCount" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </div>

            <div id="bypart" runat="server">
                <div class="form-inline">
                    <label for="tbSetArea" class="mr-2">Area:</label>
                    <asp:TextBox ID="tbSetArea" runat="server" CssClass="form-control w-25"></asp:TextBox>
                    <label for="tbPartSearch" class="ml-2 mr-2">Part:</label>
                    <asp:TextBox ID="tbPartSearch" runat="server" AutoPostBack="true" CssClass="form-control w-25"></asp:TextBox>
                    <asp:Button ID="btnClearSearch" runat="server" CssClass="ml-4" Text="X" />
                </div>
                <br />
                <asp:GridView ID="gvPartSearch" runat="server" DataSourceID="sdsPartSearch" AutoGenerateColumns="False" Width="100%" CssClass="gvs" GridLines="None" HorizontalAlign="Left">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="form-inline">
                                    <asp:Label ID="lblItemNo" runat="server" Text='<%#Eval("item_no") %>'></asp:Label>
                                    <asp:Label ID="Label5" runat="server" CssClass="ml-3" Text='<%#Eval("item_desc_1") %>'></asp:Label>
                                </div>
                                <div class="form-inline">
                                    <label for="tbSetQtyPartSearch" class="mr-2">Qty:</label><asp:TextBox ID="tbSetQtyPartSearch" runat="server" CssClass="form-control w-25"></asp:TextBox>
                                    <asp:Label ID="Label3" runat="server" CssClass=" ml-2 float-left" Text='<%#Eval("uom") %>'></asp:Label><br />
                                    <asp:Button ID="btnGetKeyPad" runat="server" Text="SAVE" CssClass="btn btn-primary ml-5" CommandName="save" CommandArgument="<%# Container.DataItemIndex %>" Font-Bold="True" />
                                </div>
                                <hr />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsPartSearch" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT [item_desc_1], [item_desc_2], [item_no], [uom] FROM [Inventory_ItemMaster] WHERE [item_no] Like '%' +  @item_no + '%' ORDER BY [item_desc_1]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tbPartSearch" Name="item_no" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>

            <div id="bypartPPL" runat="server">
                <div class="form-inline">
                    <label for="tbSetArea" class="mr-2">Area:</label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control w-25"></asp:TextBox>
                    <label for="tbPartSearch" class="ml-2 mr-2">Part:</label>
                    <asp:TextBox ID="TextBox2" runat="server" AutoPostBack="true" CssClass="form-control w-25"></asp:TextBox>
                    <asp:Button ID="Button1" runat="server" CssClass="ml-4" Text="X" />
                </div>
                <br />
                <asp:GridView ID="GridView1" runat="server" DataSourceID="sdsPartSearch" AutoGenerateColumns="False" Width="100%" CssClass="gvs" GridLines="None" HorizontalAlign="Left">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="form-inline">
                                    <asp:Label ID="lblItemNo" runat="server" Text='<%#Eval("item_no") %>'></asp:Label>
                                    <asp:Label ID="Label5" runat="server" CssClass="ml-3" Text='<%#Eval("item_desc_1") %>'></asp:Label>
                                </div>
                                <div class="form-inline">
                                    <label for="tbSetQtyPartSearch" class="mr-2">Qty:</label><asp:TextBox ID="tbSetQtyPartSearch" runat="server" CssClass="form-control w-25"></asp:TextBox>
                                    <asp:Label ID="Label3" runat="server" CssClass=" ml-2 float-left" Text='<%#Eval("uom") %>'></asp:Label><br />
                                    <asp:Button ID="btnGetKeyPad" runat="server" Text="SAVE" CssClass="btn btn-primary ml-5" CommandName="save" CommandArgument="<%# Container.DataItemIndex %>" Font-Bold="True" />
                                </div>
                                <hr />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT [item_desc_1], [item_desc_2], [item_no], [uom] FROM [Inventory_ItemMaster] WHERE [item_no] Like '%' +  @item_no + '%' ORDER BY [item_desc_1]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tbPartSearch" Name="item_no" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>


            <div id="byloc" runat="server">
                <asp:Label ID="Label1" runat="server" Text="Location:"></asp:Label>
                <asp:DropDownList ID="ddlPhyInvLocs" runat="server" CssClass="mb-2" DataSourceID="sdsInvLocs" DataTextField="areaID" DataValueField="areaID" AppendDataBoundItems="true" AutoPostBack="true">
                    <asp:ListItem></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsInvLocs" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT Distinct(areaID) FROM [Inventory_Tags_Last] ORDER BY [areaID]"></asp:SqlDataSource>
                <asp:GridView ID="gvPartsInLoc" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPartsInLoc" Width="100%" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText="Part/Daily Counts">
                            <ItemTemplate>

                                <asp:Label ID="lblPartNo" runat="server" Text='<%#Eval("itemNumber") %>' CssClass="mr-2"></asp:Label><br />
                                <asp:Label ID="Label11" runat="server" Text='<%#Eval("item_desc_1") %>'></asp:Label>

                                <asp:GridView ID="gvTodaysCounts" runat="server" AutoGenerateColumns="False" DataSourceID="sdsCurrentCountsByArea" Width="100%" ShowHeader="False">
                                    <Columns>
                                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
                                        <asp:BoundField DataField="Counted" DataFormatString="{0:t}" HeaderText="Counted" SortExpression="Counted"></asp:BoundField>
                                        <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CountedBy" HeaderText="By" SortExpression="CountedBy"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsCurrentCountsByArea" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [CycleCounts] WHERE (([Area] = @Area) AND ([PartNo] = @PartNo) AND (convert(varchar(10), Counted, 102) = convert(varchar(10), getdate(), 102))) ORDER BY [Counted]" DeleteCommand="DELETE FROM [CycleCounts] WHERE [AutoID] = @AutoID" InsertCommand="INSERT INTO [CycleCounts] ([PartNo], [Counted], [Qty], [Area], [CountedBy]) VALUES (@PartNo, @Counted, @Qty, @Area, @CountedBy)" UpdateCommand="UPDATE [CycleCounts] SET [PartNo] = @PartNo, [Counted] = @Counted, [Qty] = @Qty, [Area] = @Area, [CountedBy] = @CountedBy WHERE [AutoID] = @AutoID">
                                    <DeleteParameters>
                                        <asp:Parameter Name="AutoID" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="PartNo" Type="String" />
                                        <asp:Parameter Name="Counted" Type="DateTime" />
                                        <asp:Parameter Name="Qty" Type="Double" />
                                        <asp:Parameter Name="Area" Type="String" />
                                        <asp:Parameter Name="CountedBy" Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlPhyInvLocs" Name="Area" PropertyName="SelectedValue" Type="String" />
                                        <asp:ControlParameter ControlID="lblPartNo" Name="PartNo" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="PartNo" Type="String" />
                                        <asp:Parameter Name="Counted" Type="DateTime" />
                                        <asp:Parameter Name="Qty" Type="Double" />
                                        <asp:Parameter Name="Area" Type="String" />
                                        <asp:Parameter Name="CountedBy" Type="String" />
                                        <asp:Parameter Name="AutoID" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>
                            <ItemStyle Width="65%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Count">
                            <ItemTemplate>
                                <div class="form-inline">
                                    <asp:TextBox ID="tbSetQty" runat="server" CssClass="form-control ml-1 w-25"></asp:TextBox>
                                    <asp:Label ID="Label2" runat="server" CssClass="ml-1" Text='<%#Eval("unitMeasure") %>'></asp:Label>
                                    <asp:Button ID="btnGetKeyPad" runat="server" Text="SAVE" CssClass="btn btn-primary ml-1" CommandName="saveByLoc" CommandArgument="<%# Container.DataItemIndex %>" />
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="35%" />
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
                <asp:SqlDataSource ID="sdsPartsInLoc" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT [itemNumber], [unitMeasure], item_desc_1 FROM [Inventory_Tags_Last] Left Join Inventory_ItemMaster on Inventory_Tags_Last.itemNumber = Inventory_ItemMaster.item_no WHERE ([areaID] = @areaID) and (itemNumber <> 'VOID' ) and (itemNumber <> 'UNUSED') ORDER BY [itemNumber]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlPhyInvLocs" Name="areaID" PropertyName="SelectedValue" Type="Double" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </form>
    <script src="./scripts/jquery-3.5.0.min.js"></script>
    <script src="./scripts/bootstrap.min.js"></script>
</body>
</html>
