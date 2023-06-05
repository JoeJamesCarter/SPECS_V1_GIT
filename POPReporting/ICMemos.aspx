<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ICMemos.aspx.vb" Inherits="ICMemos" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Control Memo Mgmt</title>
    <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="tblHeader" runat="server" CssClass="auto-style1" Width="1024px" GridLines="None">
                <asp:TableRow>
                    <asp:TableCell>
                        <span class="newStyle7">INVENTORY CONTROL MEMOS</span>                    
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" /><span class="newStyle3">&nbsp;&nbsp;&nbsp;Select Which Memo&#39;s to Show&nbsp;
                            <asp:DropDownList ID="ddlShowSelect" runat="server" AutoPostBack="True">
                                <asp:ListItem Value="1">Hide Complete</asp:ListItem>
                                <asp:ListItem Value="2">Show All</asp:ListItem>
                            </asp:DropDownList></span>
                    </asp:TableCell>
                   
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:Table ID="Table1" runat="server" GridLines="Horizontal" Width="935px">
                <asp:TableRow>
                     <asp:TableCell>
                        <asp:Label ID="Label11" runat="server" Text="Req Cycle Count:" CssClass="newStyle4"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="Label10" runat="server" Text="Part # (If Not Listed)" CssClass="newStyle1"></asp:Label><asp:TextBox ID="tbPartNoToCount" runat="server" CssClass="newStyle1" Width="100"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="Label8" runat="server" Text="Counter" CssClass="newStyle1"></asp:Label>
                        <asp:CheckBoxList ID="cbListCounter" runat="server" CssClass="newStyle1">
                            <asp:ListItem Value="1">Jeff</asp:ListItem>
                            <asp:ListItem Value="2">Sue</asp:ListItem>
                        </asp:CheckBoxList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="Label9" runat="server" Text="Count On:" CssClass="newStyle1"></asp:Label><asp:TextBox ID="tbCCCountDate" runat="server" TextMode="Date" CssClass="newStyle1"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnSaveCCReq" runat="server" Text="Submit" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
        </div>
        <div>
            <asp:GridView ID="gvMemos" runat="server" DataSourceID="sdsMemos" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="AutoID" Width="100%" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="AutoID" HeaderText="ID" />
                   <asp:TemplateField HeaderText="Entered/To/From">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("MemoDate")%>'></asp:Label><br />
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("MemoTo")%>'></asp:Label><br />
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("MemoFrom")%>'></asp:Label><br />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Ben Part #">
                        <ItemTemplate>
                        <asp:Label ID="lblBenPartNo" runat ="server" Text='<%#Eval("BenPartNo") %>'></asp:Label><br />
                            <asp:Button ID="btnReqCount" runat="server" Text="Req Count"  CommandArgument='<%# Eval("BenPartNo")%>' CommandName ="reqcyclecount" />
                           
                        </ItemTemplate>
                         <ItemStyle HorizontalAlign="center" />
                    </asp:TemplateField>                    
                    <asp:TemplateField HeaderText="Vendor"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Vendor Part">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("VendPartNo")%>'></asp:Label><br />
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("PartDesc")%>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("BenPartNo")%>' CommandName ="gotoopenorders"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:BoundField DataField="Notes" HeaderText="Notes" />
                    <asp:BoundField DataField="QtyOnHand" HeaderText="Qty on Hand" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Resolution">
                        <ItemTemplate>
                            <asp:TextBox ID="tbResolution" runat="server" Text='<%# Eval("Resolution") %>' TextMode="MultiLine" Height="100"></asp:TextBox><br />
                            <asp:Label ID="Label6" runat="server" Text="Locs at Last Physical: "></asp:Label><br /><asp:Label ID="Label7" runat="server" Text='<%#Eval("areaList") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Notes from Purchasing">
                        <ItemTemplate>
                            <asp:TextBox ID="tbNotesForRcv" runat="server" Text='<%# Eval("NotesForRcv") %>' TextMode="MultiLine" Height="100"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cycle Counts">
                        <ItemTemplate>
                            <asp:GridView ID="gvCCs" runat="server" AutoGenerateColumns="False" DataKeyNames="AutoID" DataSourceID="sdsCCs" Width="100%" >

                                <Columns>                                   
                                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                    <asp:BoundField DataField="Counted" HeaderText="Counted" SortExpression="Counted" />
                                    <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" >
                                    <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Area" HeaderText="Area" SortExpression="Area" />
                                    <asp:BoundField DataField="CountedBy" HeaderText="By" SortExpression="CountedBy" />                                                                        
                                </Columns>

                            </asp:GridView> 
                            <asp:SqlDataSource ID="sdsCCs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT  Top 6 * FROM [CycleCounts] WHERE ([PartNo] = @PartNo) ORDER BY [Counted] DESC" DeleteCommand="DELETE FROM [CycleCounts] WHERE [AutoID] = @AutoID" InsertCommand="INSERT INTO [CycleCounts] ([PartNo], [Counted], [Qty], [Area], [CountedBy], [CounterID], [DateToCount]) VALUES (@PartNo, @Counted, @Qty, @Area, @CountedBy, @CounterID, @DateToCount)" UpdateCommand="UPDATE [CycleCounts] SET [Counted] = @Counted, [Qty] = @Qty, [Area] = @Area, [CountedBy] = @CountedBy, [CounterID] = @CounterID, [DateToCount] = @DateToCount WHERE [AutoID] = @AutoID">
                                <DeleteParameters>
                                    <asp:Parameter Name="AutoID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="PartNo" Type="String" />
                                    <asp:Parameter Name="Counted" Type="DateTime" />
                                    <asp:Parameter Name="Qty" Type="Double" />
                                    <asp:Parameter Name="Area" Type="String" />
                                    <asp:Parameter Name="CountedBy" Type="String" />
                                    <asp:Parameter Name="CounterID" Type="Int32" />
                                    <asp:Parameter DbType="Date" Name="DateToCount" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:Parameter Name="PartNo" Type="String" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="PartNo" Type="String" />
                                    <asp:Parameter Name="Counted" Type="DateTime" />
                                    <asp:Parameter Name="Qty" Type="Double" />
                                    <asp:Parameter Name="Area" Type="String" />
                                    <asp:Parameter Name="CountedBy" Type="String" />
                                    <asp:Parameter Name="CounterID" Type="Int32" />
                                    <asp:Parameter DbType="Date" Name="DateToCount" />
                                    <asp:Parameter Name="AutoID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:RadioButtonList ID="rblStatus" runat="server" SelectedValue='<%# Eval("Status") %>'>
                                <asp:ListItem Value="0">Not Started</asp:ListItem>
                                <asp:ListItem Value="1">In Progress</asp:ListItem>
                                <asp:ListItem Value="2">Resolved</asp:ListItem>
                            </asp:RadioButtonList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="LastUpdated" DataFormatString="{0:d}" HeaderText="Last Updated" >
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Save">
                        <ItemTemplate>
                            <asp:Button ID="btnSave" runat="server" Text="Save" CommandName="gototSaveMemo" CommandArgument="<%# Container.DataItemIndex %>" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsMemos" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT AutoID, MemoDate, MemoTo, MemoFrom, BenPartNo, VendPartNo, PartDesc, QtyOnHand, DateNeeded, Notes, Resolution, NotesForRcv, HighPriority, Status,LastUpdated, STUFF((SELECT distinct ',' + Cast(areaID as VARCHAR) as areaID FROM [Inventory_Tags_Last] t3 WHERE BenPartNo = t3.itemNumber FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'') areaList FROM INVENTORYCONTROLMEMOS WHERE(Status &lt;= @Status) ORDER BY MemoDate">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="Status" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
             <span class="newStyle7">KITTING SHORTAGES - Keri's work in progress, please ignore for now.</span>                    
            <asp:GridView ID="gvKittingShortages" runat="server" AutoGenerateColumns="False" DataKeyNames="PartNo,ProdNo" DataSourceID="sdsKitShortages" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" Width="100%" >
                <Columns>
                    <asp:BoundField DataField="PartNo" HeaderText="Ben Part #" ReadOnly="True" SortExpression="PartNo" />
                    <asp:BoundField DataField="item_desc_1" HeaderText="Desc" ReadOnly="True" SortExpression="item_desc_1" />
                    <asp:BoundField DataField="item_desc_2" HeaderText="Desc 2" ReadOnly="True" SortExpression="item_desc_2" />
                    <asp:BoundField DataField="areaList" HeaderText="Last Inventory Locations" ReadOnly="True" SortExpression="areaID" />
                    <asp:BoundField DataField="QtyShort" HeaderText="Qty Short" SortExpression="QtyShort" >
                    <ItemStyle HorizontalAlign="Center" Width="100px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="DateReported" HeaderText="Date Reported" SortExpression="DateReported" >
                    <ItemStyle Width="250px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ReportedBy" HeaderText="Reported By" SortExpression="ReportedBy" />                    
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsKitShortages" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT t1.*, t2.item_desc_1, t2.item_desc_2, STUFF((SELECT distinct ',' + Cast(areaID as VARCHAR) as areaID FROM [Inventory_Tags_Last] t3 WHERE PartNo = t3.itemNumber FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'),1,1,'') areaList FROM [Kitting_Shortages] as t1 Left Join [Inventory_ItemMaster] as t2 on t1.PartNo = t2.item_no WHERE ([ClearedFlag] = @ClearedFlag) ORDER BY [PartNo], [ProdNo]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="ClearedFlag" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
                
        </div>
    </form>
</body>
</html>
