<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ICMemosRO.aspx.vb" Inherits="ICMemosRO" Debug ="True"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Control Memo History</title>
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
                        <span class="newStyle3">Select Which Memo&#39;s to Show&nbsp;
                            <asp:DropDownList ID="ddlShowSelect" runat="server" AutoPostBack="True">
                                <asp:ListItem Value="1">Hide Complete</asp:ListItem>
                                <asp:ListItem Value="2">Show All</asp:ListItem>
                            </asp:DropDownList></span>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
                    </asp:TableCell>
                    <asp:TableCell>
                        To:
            <asp:DropDownList ID="ddlTo" runat="server" AutoPostBack="True">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="jbrown">Jim Brown</asp:ListItem>
                <asp:ListItem Value="cgirten">Chuck Girten</asp:ListItem>
                <asp:ListItem Value="jwerntz">Josh Wernzt</asp:ListItem>
            </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            
            <br />
            <br />
        </div>
        <div>
            <asp:GridView ID="gvMemos" runat="server" DataSourceID="sdsMemos" CellPadding="4" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" CssClass="newStyle1" ForeColor="Black" DataKeyNames="AutoID" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="AutoID" HeaderText="ID" />
                    <asp:BoundField DataField="MemoDate" HeaderText="Date Entered" />
                    <asp:BoundField DataField="MemoTo" HeaderText="To" />
                    <asp:BoundField DataField="MemoFrom" HeaderText="From" />
                    <asp:BoundField DataField="BenPartNo" HeaderText="Ben Part #" />
                    <asp:BoundField DataField="VendPartNo" HeaderText="Vendor Part #" />
                    <asp:TemplateField HeaderText="Vendor"></asp:TemplateField>
                    <asp:BoundField DataField="PartDesc" HeaderText="Description" />
                    <asp:BoundField DataField="Notes" HeaderText="Notes" />
                    <asp:BoundField DataField="QtyOnHand" HeaderText="Qty on Hand" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Resolution" HeaderText="Resolution" />
                    <asp:BoundField DataField="NotesForRcv" HeaderText="Notes For Receiving" />                   
                    <asp:TemplateField HeaderText="High Priority">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbPriority" runat="server" Checked='<%# Eval("HighPriority") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="150px">
                        <ItemTemplate>
                            <asp:RadioButtonList ID="rblStatus" runat="server" SelectedValue='<%# Eval("Status") %>'>
                                <asp:ListItem Value="0">Not Started</asp:ListItem>
                                <asp:ListItem Value="1">In Progress</asp:ListItem>
                                <asp:ListItem Value="2">Resolved</asp:ListItem>
                            </asp:RadioButtonList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="LastUpdated" DataFormatString="{0:d}" HeaderText="Last Updated" />                    
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsMemos" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT AutoID, MemoDate, MemoTo, MemoFrom, BenPartNo, VendPartNo, PartDesc, QtyOnHand, DateNeeded, Notes, Resolution, NotesForRcv, HighPriority, Status,LastUpdated FROM INVENTORYCONTROLMEMOS WHERE(Status &lt;= @Status) AND (MemoTo Like '%' + @MemoTo + '%') ORDER BY MemoDate">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlShowSelect" Name="Status" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlTo" Name="MemoTo" DefaultValue ="%" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
