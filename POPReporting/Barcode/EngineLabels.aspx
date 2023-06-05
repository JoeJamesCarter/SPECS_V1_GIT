<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EngineLabels.aspx.vb" Inherits="Barcode_EngineLabels" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Engine Labels</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .largeText {
            font-family:Calibri;
            font-size:62px;
        }
        .mediumText {
            font-family:Calibri;
            font-size:42px;

        }
        .smallText {
            font-family:Calibri;
            font-size:32px;

        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label6" runat="server" CssClass="newStyle7" Text="Printer:"></asp:Label>
            <asp:DropDownList ID="ddlPrinters" runat="server" Font-Size="30pt" AutoPostBack="True" DataSourceID="sdsPrinters" DataTextField="PrinterName" DataValueField="IP" AppendDataBoundItems="true">
                <asp:ListItem></asp:ListItem>           
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsPrinters" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Printers] ORDER BY [DisplayOrder]"></asp:SqlDataSource>
            <br />
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="PO #:" CssClass="mediumText"></asp:Label><asp:TextBox ID="tbPONo" runat="server" CssClass="mediumText" Height="75px" Width="416px"></asp:TextBox>
            <br />
            <br />
            <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="False" DataKeyNames="ord_no" DataSourceID="sdsEngPOs" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Style="text-align: center" CssClass="smallText" Width="974px">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:TemplateField HeaderText="PO # & Date">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#Eval("ord_no") %>' CssClass="mediumText"></asp:Label><br />
                            <asp:Label ID="Label3" runat="server" Text='<%#Eval("ord_dt", "{0:MM/dd/yy}") %>' CssClass="mediumText"></asp:Label>
                        </ItemTemplate>

                        <ItemStyle CssClass="newStyle6" Width="100px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="line_no" HeaderText="Line #" SortExpression="line_no">


                        <ItemStyle Width="50px" />
                    </asp:BoundField>


                    <asp:TemplateField HeaderText="ENG MODEL/COMMENTS" ShowHeader="False">
                        <ItemTemplate>
                            <asp:Label ID="lblEngModel" runat="server" Text='<%#Eval("item_no") %>' CssClass="mediumText"></asp:Label><br />
                            <asp:Label ID="lblEngDesc1" runat="server" Text='<%#Eval("item_desc_1") %>' CssClass="smallText"></asp:Label><br />
                            <asp:Label ID="lblEngDesc2" runat="server" Text='<%#Eval("item_desc_2") %>' CssClass="smallText"></asp:Label><br />

                            <asp:GridView ID="gvCmts" runat="server" DataSourceID="sdsComments" Width="350px" AutoGenerateColumns="False" CssClass="smallText" ShowHeader="False">
                                <Columns>
                                    <asp:BoundField DataField="seq_no" HeaderText="Comment" />
                                    <asp:BoundField DataField="cmt" HeaderText="Comment" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsComments" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [seq_no], [cmt] FROM [POCOMFIL_SQL] WHERE ([ord_no] = @ord_no) and (line_no = @line_no) order by seq_no">
                                <SelectParameters>
                                    <asp:Parameter Name="ord_no" Type="String" />
                                    <asp:Parameter Name="line_no" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Width="300px" />
                    </asp:TemplateField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnPrint" runat="server" Text="PRINT" CssClass="newStyle7" CommandName="printEngLbl" CommandArgument="<%# Container.DataItemIndex %>" Height="124px" Width="188px" />
                        </ItemTemplate>
                        <ItemStyle Width="50px" />
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
            <asp:SqlDataSource ID="sdsEngPOs" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT poordhdr_sql.ord_no, poordhdr_sql.vend_no, poordhdr_sql.ord_dt, poordhdr_sql.receive_comp_fg, poordhdr_sql.user_name, poordlin_sql.line_no, poordlin_sql.item_no, poordlin_sql.item_desc_1, poordlin_sql.item_desc_2 FROM [poordhdr_sql] left join [poordlin_sql] on poordhdr_sql.ord_no = poordlin_sql.ord_no WHERE ((poordhdr_sql.ord_no = @ord_no) AND ([ship_to_cd] = @ship_to_cd))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="tbPONo" Name="ord_no" PropertyName="Text" Type="String" />
                    <asp:Parameter DefaultValue="ENGINE" Name="ship_to_cd" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
