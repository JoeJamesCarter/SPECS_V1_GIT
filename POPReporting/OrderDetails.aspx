<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OrderDetails.aspx.vb" Inherits="OrderDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .newStyle1 {
            font-family: calibri;
            font-size: 16px;
        }
        .auto-style2 {
            width: 100%;
        }
    </style>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="auto-style2">
            <tr>
                <td><span class="newStyle1">
        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPopReporting" CssClass="newStyle1" Width="359px">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ItemNo" HeaderText="Boat" SortExpression="ItemNo" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="PanelColor" HeaderText="Panel Color">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="IsPilot" HeaderText="Pilot?">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="IsCustom" HeaderText="Custom?">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
                    </span>
                    <br />
                    <span class="newStyle1">
    
                        
                    <br />
    
                        
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataSourceID="sdsOEOLINCMT">
            <Columns>
                <asp:BoundField DataField="cmt" HeaderText="Comments" SortExpression="cmt" />
            </Columns>
        </asp:GridView>
                    <br />
                    <asp:Button ID="btnDrawing" runat="server" Text="Drawing" />
                    </span></td>
                <td rowspan="2"><span class="newStyle1"></span><asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataSourceID="sdsOEORDLIN" Width="100%" Caption="Order Lines From Macola">
            <Columns>
                <asp:BoundField DataField="item_no" HeaderText="Item #" SortExpression="item_no" >
                <ItemStyle Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="item_desc_1" HeaderText="Desc" SortExpression="item_desc_1" >
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="qty_ordered" HeaderText="Qty" SortExpression="qty_ordered" DataFormatString="{0:#,#.###}">
                <ItemStyle Width="30px" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
                    <br />
                  
                    <asp:GridView ID="gvKittedParts" runat="server" Caption="Kitted Parts" CssClass="newStyle1" DataSourceID="sdsKitting" AutoGenerateColumns="False" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="comp_item_no" HeaderText="Item #" >
                            <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="item_desc_1" HeaderText="Desc" >
                            <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="qty_per_par" HeaderText="Qty" DataFormatString="{0:#,#.###}">
                            <ItemStyle Width="30px" HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                  
                </td>
            </tr>
            <tr>
                <td><span class="newStyle1">
    
                    <br />
                    <asp:Button ID="Button1" runat="server" Text="Have a SPECS Request/Problem?" />
                    </span></td>
            </tr>
            
        </table>
        <asp:PlaceHolder ID="phRecliner" runat="server"></asp:PlaceHolder>
                <asp:PlaceHolder ID="phBench" runat="server"></asp:PlaceHolder>
        <asp:PlaceHolder ID="phCatPageLink" runat="server"></asp:PlaceHolder>
        <asp:HiddenField ID="hdnSONo" runat="server" />
        <asp:HiddenField ID="hdnSONoSkip2LeadingZeros" runat="server" />
        <asp:HiddenField ID="hdnBoatYear" runat="server" />
        
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [ItemNo], [PanelColor], [IsPilot], [IsCustom] FROM [BML_POPREPORTING] WHERE ([SONo] = @SONo)">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnSONo" Name="SONo" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsOEORDLIN" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT OEORDLIN_SQL.item_no, [ord_no], IMITMIDX_SQL.item_desc_1, [qty_ordered], OEORDLIN_SQL.user_def_fld_3, OEORDLIN_SQL.prod_cat FROM [OEORDLIN_SQL] Left Join IMITMIDX_SQL on OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = @ord_no) Order By IMITMIDX_SQL.item_desc_1">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnSONo" Name="ord_no" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <asp:SqlDataSource ID="sdsOEOLINCMT" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [cmt] FROM [OELINCMT_SQL] WHERE ([ord_no] = @ord_no) Order By  line_seq_no desc, OELINCMT_SQL.cmt_seq_no">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnSONo" Name="ord_no" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsKitting" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT IMKITFIL_SQL.comp_item_no, IMKITFIL_SQL.qty_per_par, IMITMIDX_SQL.item_desc_1 From [IMKITFIL_SQL] Left join OEORDLIN_SQL on OEORDLIN_SQL.item_no = IMKITFIL_SQl.item_no left join IMITMIDX_SQL on IMKITFIL_SQL.comp_item_no = IMITMIDX_SQL.item_no WHERE ([ord_no] = @ord_no) and right(IMITMIDX_SQL.item_desc_1,3) <>'DIS'">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnSONo" Name="ord_no" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hdnBoatModel" runat="server" />
    
        <asp:HiddenField ID="hdnCustomDrawingNo" runat="server" />    
        <asp:HiddenField ID="hdnSerialPart" runat="server" />   
        <asp:HiddenField ID="hdnBVPart" runat="server" />
        <asp:HiddenField ID="hdnFurnPart" runat="server" />
        <asp:HiddenField ID="hdnAccentPart" runat="server" />
        <asp:HiddenField ID="hdnProdNo" runat="server" />
    
    </div>
    </form>
</body>
</html>
