<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OpenOrders.aspx.vb" Inherits="OpenOrders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <style>     

        .grid {
            font-family: Calibri;
            font-size: 18px;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
     <asp:GridView ID="gvPartsOrders" CssClass="grid" runat="server" DataSourceID="sdsMacolaOrders" AutoGenerateColumns="False" Width="100%" Caption="Open Orders" CaptionAlign="Top" CellPadding="2" CellSpacing="2">
                <Columns>                  
                    <asp:BoundField DataField="item_no" HeaderText="Item #" />
                    <asp:BoundField DataField="payee_name" HeaderText="Vendor"  />
                    <asp:BoundField DataField="item_desc_1" HeaderText="Desc" />
                    <asp:BoundField DataField="item_desc_2" HeaderText="Vendor Part/Desc" />
                    <asp:BoundField DataField="qty_ordered" HeaderText="Qty Ordered" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="request_dt" DataFormatString="{0:d}" HeaderText="Request Date" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="qty_received" HeaderText="Qty Received" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="receipt_dt" DataFormatString="{0:d}" HeaderText="Receipt Date" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="qty_remaining" DataFormatString="{0:d}" HeaderText="Qty Remaining" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsMacolaOrders" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_no], [item_desc_1],request_dt,cast(qty_ordered as Int) as qty_ordered,cast(qty_received as int) as qty_received,receipt_dt, cast(qty_remaining as int) as qty_remaining, POORDLIN_SQL.vend_no, item_desc_2, payee_name FROM [POORDLIN_SQL] Left Join [APVENFIL_SQL] on POORDLIN_SQL.vend_no = APVENFIL_SQL.vend_no WHERE [item_no] = @item_no and qty_remaining > 0 Order By request_dt">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Label1" Name="item_no" Type="String" />                
                </SelectParameters>
            </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
