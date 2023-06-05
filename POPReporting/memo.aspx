<%@ Page Language="VB" AutoEventWireup="false" CodeFile="memo.aspx.vb" Inherits="memo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Control Memo</title>
    <style>
        #contents {
            width: 80%;
            margin: 0 auto;
        }

        .title {
            font-family: Calibri;
            font-size: 30px;
            font-weight: bold;
        }

        .subtitle {
            font-family: Calibri;
            font-size: 25px;
            font-weight: bold;
        }

        .field {
            font-family: Calibri;
            font-size: 18px;
            font-weight: bold;           
        }

        .inputs {
            font-family: Calibri;
            font-size: 18px;
            font-weight: bold;            
        }

        .grid {
            font-family: Calibri;
            font-size: 18px;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="contents">           
            <asp:Label runat="server" CssClass="title" Text="Inventory Control Memo"></asp:Label><br />
            <br />
            <hr />
            <asp:Label ID="Label8" runat="server" CssClass="subtitle" Text="Search By Any Text in The Ben Part #, Vendor Part # or Description."></asp:Label>
            <br />

            <br />
            <asp:Label ID="Label4" runat="server" CssClass="field" Text="Ben Part #:" Width="150px"></asp:Label>
            <asp:TextBox ID="tbBenPart" runat="server" CssClass="inputs" AutoPostBack="True"></asp:TextBox>&nbsp;&nbsp;&nbsp;<asp:Button ID="btnClearSearch" runat="server" Text="Clear Search" />
            <br />
            <br />
            <asp:Label ID="Label7" runat="server" CssClass="field" Text="Vendor Part #:" Width="150px"></asp:Label>

            <asp:TextBox ID="tbVendPart" runat="server" CssClass="inputs" AutoPostBack="True"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" CssClass="field" Text="Description:" Width="150px"></asp:Label>
            <asp:TextBox ID="tbDesc" runat="server" CssClass="inputs" Width="222px" AutoPostBack="True"></asp:TextBox>
            <br />
            <br />
            <asp:GridView ID="gvResults" runat="server" CssClass="grid" DataSourceID="sdsMacola" AutoGenerateColumns="False" Width="100%">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="item_no" HeaderText="Item #" />
                    <asp:BoundField DataField="item_desc_1" HeaderText="Description" />
                    <asp:BoundField DataField="item_desc_2" HeaderText="Vendor Part #/Description" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsMacola" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_no], [item_desc_1],[item_desc_2] FROM [IMITMIDX_SQL] WHERE [activity_cd] = 'A' and (([item_no] LIKE  '%' + @item_no + '%') or ([item_desc_2]  LIKE  '%' + @vend_part + '%') or ([item_desc_1]  LIKE  '%' + @desc + '%'))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="tbBenPart" Name="item_no" DefaultValue='ZXY' Type="String" />
                    <asp:ControlParameter ControlID="tbVendPart" Name="vend_part" DefaultValue='ZXY' Type="String" />
                    <asp:ControlParameter ControlID="tbDesc" Name="desc" DefaultValue='ZXY' Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br/>
             <asp:GridView ID="gvPartsOrders" runat="server" CssClass="grid" DataSourceID="sdsMacolaOrders" AutoGenerateColumns="False" Width="100%" Caption="Open Orders" CaptionAlign="Top" CellPadding="2" CellSpacing="2">
                <Columns>                  
                    <asp:BoundField DataField="item_no" HeaderText="Item #" />
                    <asp:BoundField DataField="payee_name" HeaderText="Vendor"  />
                    <asp:BoundField DataField="item_desc_1" HeaderText="Desc" />
                    <asp:BoundField DataField="item_desc_2" HeaderText="Vendor Part/Desc" />
                    <asp:BoundField DataField="qty_ordered" HeaderText="Qty Ordered" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="request_dt" HeaderText="Request Date" DataFormatString="{0:d}">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="qty_received" HeaderText="Qty Received" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="receipt_dt"  HeaderText="Receipt Date" DataFormatString="{0:d}" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="qty_remaining" DataFormatString="{0:d}" HeaderText="Qty Remaining" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsMacolaOrders" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_no], [item_desc_1], request_dt,cast(qty_ordered as Int) as qty_ordered,cast(qty_received as int) as qty_received,receipt_dt, cast(qty_remaining as int) as qty_remaining, POORDLIN_SQL.vend_no, item_desc_2, payee_name FROM [POORDLIN_SQL] Left Join [APVENFIL_SQL] on POORDLIN_SQL.vend_no = APVENFIL_SQL.vend_no WHERE [item_no] = @item_no and qty_remaining > 0 Order By request_dt">
                <SelectParameters>
                    <asp:ControlParameter ControlID="tbBenPartSelected" Name="item_no" DefaultValue='ZXY' Type="String" />                
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <hr />
            <asp:Label ID="Label9" runat="server" CssClass="subtitle" Text="Memo Body"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnCantFind" runat="server" Text="I can't find the Part # or there isn't one." />
            <br />
            <br />

            <asp:Label ID="Label1" CssClass="field" runat="server" Text="To:" Width="150px"></asp:Label>
           <asp:TextBox runat="server" CssClass="inputs" ID="tbTO"></asp:TextBox>            
            *<br />
            <br />
            <asp:Label ID="Label2" CssClass="field" runat="server" Text="From:" Width="150px"></asp:Label><asp:TextBox ID="tbFrom" CssClass="inputs" runat="server"></asp:TextBox>
            *<br />
            <br />
            <asp:Label ID="Label10" CssClass="field" runat="server" Text="Ben Part #:" Width="150px"></asp:Label><asp:TextBox ID="tbBenPartSelected" CssClass="inputs" runat="server" Enabled="False"></asp:TextBox>
            *<br />
            <br />
            <asp:Label ID="Label12" CssClass="field" runat="server" Text="Vendor Part #:" Width="150px"></asp:Label><asp:TextBox ID="tbVendPartSelected" CssClass="inputs" runat="server" Enabled="False" Width="377px"></asp:TextBox>
            *<br />
            <br />
            <asp:Label ID="Label11" CssClass="field" runat="server" Text="Description:" Width="150px"></asp:Label><asp:TextBox ID="tbDescriptionSelected" CssClass="inputs" runat="server" Enabled="False" Width="377px"></asp:TextBox>
            *<br />
            <br />
            <asp:Label ID="Label3" CssClass="field" runat="server" Text="Date Needed:" Width="150px"></asp:Label><asp:TextBox ID="tbDateNeeded" runat="server" TextMode="Date"></asp:TextBox>&nbsp;<br />
            <br />
            <asp:Label ID="Label13" CssClass="field" runat="server" Text="Qty On Hand:" Width="150px"></asp:Label><asp:TextBox ID="tbQOH" CssClass="inputs" runat="server" TextMode="Number" min="0"></asp:TextBox>
            *<br />
            <br />
            <asp:Label ID="Label14" CssClass="field" runat="server" Text="Notes:" Width="150px"></asp:Label><asp:TextBox ID="tbNotes" CssClass="inputs" runat="server" Width="377px" TextMode="MultiLine"></asp:TextBox>
            &nbsp;<br />
            <br />
            <asp:Label ID="Label15" runat="server" cssClass="inputs" Text="* = Required Field"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnSubmit" runat="server" Height="51px" style="text-align: center" Text="Submit" Width="186px" />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
