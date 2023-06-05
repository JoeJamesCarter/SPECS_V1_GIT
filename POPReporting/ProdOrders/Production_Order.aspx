<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Production_Order.aspx.vb" Inherits="ProdOrders_Production_Order" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    
    <style type="text/css">
        #content {
            width: 1100px;
            height: auto;
        }

        .descriptions {
            font-family: Calibri;
            font-size: 19px;
            font-weight: Bold;
            padding-right: 30px;
        }

        .data {
            font-family: Calibri;
            font-size: 19px;
        }

        .spacer {
            font-family: Calibri;
            width: 300px;
        }

        .options {
            font-family: Calibri;
            font-size: 19px;
            margin-right: 5px;
        }

        .comments {
            font-family: Calibri;
            font-size: 14pt;
            margin-right: 5px;
            width: 500px;
            clear: both;
            text-align: center;
        }

        .remaining {
            font-family: Calibri;
            font-size: 14pt;
            margin-right: 5px;
            width: 500px;
            clear: both;
        }

            .remaining caption {
                background-color: #000000;
                color: White;
                font-size: 16pt;
                font-weight: bold;
            }

        .comments caption {
            background-color: #000000;
            color: White;
            font-size: 16pt;
            font-weight: bold;
        }
        #header {
            float: left;
            width:1100px;
            margin-bottom: 5px;
            font-family: Calibri;
            font-size: 16pt;            
        }

        #headerleft {
            float: left;
            width: 1100px;
            margin-bottom: 5px;
            font-family: Calibri;
            font-size: 16pt;
        }

        #headerright {
            float: left;
            padding-left: 30px;
            width: 700px;
            background-color:red;
        }

        #workstationbody {
            clear: both;
        }

        .workstations {
            font-family: Calibri;
            margin-right: 5px;
            width: 295px;
            font-size: 14px;
        }

            .workstations caption {
                background-color: #5D7B9D;
                color: White;
                font-size: 16pt;
                font-weight: bold;
            }

        .columns {
            width: 300px;
            float: left;
            padding-bottom: 10px;
        }

        .newStyle1 {
            font-family: Calibri;
            font-size: 25px;
            font-weight: bold;
            text-align:right;
        }

        .newStyle2 {
            font-family: Calibri;
            font-size: 22px;
            text-align: left;
        }
    </style>

</head>
<body>
    <div id="content">
        <form id="form1" runat="server">
           
            <div id="header">
                 <asp:SqlDataSource ID="sdsPPORDFILProdNos" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [ord_no], [last_trx_dt], [user_def_fld_1], [org_ord_no] FROM [PPORDFIL_SQL] WHERE (([ord_status] = @ord_status) AND ([user_def_fld_1] IS NOT NULL) AND ([user_def_fld_1] Like '%1%') AND ([last_trx_dt] = NULL)) ORDER BY [user_def_fld_1]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="R" Name="ord_status" Type="String" />
                    <asp:Parameter DefaultValue="0" Name="last_trx_dt" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
                 Prod #:
            <asp:DropDownList ID="ddlProdNo" runat="server" DataSourceID="sdsPPORDFILProdNos" DataTextField="user_def_fld_1" DataValueField="user_def_fld_1" AutoPostBack="True" CssClass="newStyle2">
                <asp:ListItem>Select Prod #</asp:ListItem>
            </asp:DropDownList>            
            <asp:TextBox ID="tbBuildDate" visible="False" runat="server"></asp:TextBox>
            <asp:HiddenField ID="hdnPopNo" runat="server" />
            <asp:Button ID="btnBuildDate" visible="False" runat="server" Text="Button" />
            <asp:HiddenField ID="hdnPanelColor" runat="server" />
            <asp:HiddenField ID="hdnSoNo" runat="server" />
            
            <asp:SqlDataSource ID="sdsGetPPORDFILInfo" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [ord_no], [item_desc_2], [item_desc_1], [item_no], [due_dt], [cus_no], [cus_name], [src_ord_no], [user_def_fld_1] FROM [PPORDFIL_SQL] WHERE ([user_def_fld_1] = @user_def_fld_1)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlProdNo" Name="user_def_fld_1" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
                 <span class="newStyle1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    BENNINGTON MARINE PRODUCTION ORDER
                </span>
                </div>
            <div id="headerleft">
                <asp:FormView ID="BuildInfo" runat="server" DataSourceID="sdsGetPPORDFILInfo" Width="1200px">
                    <ItemTemplate>
                        <asp:Table ID="Table1" runat="server">
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                            Model:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("item_no")%>'></asp:Label>&nbsp;-&nbsp;
                <asp:Label ID="Label2" runat="server" Text='<%# EVAL("item_desc_1") %>'></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell CssClass="spacer"></asp:TableCell>
                                <asp:TableCell CssClass="descriptions">Prod #:</asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:Label ID="Label3" runat="server" Text='<%# EVAL("user_def_fld_1") %>'></asp:Label></asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                    Panel Color:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:GridView ID="gvPanelColor" ShowHeader="false" GridLines="None" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGetPanelColor">
                                        <Columns>
                                            <asp:BoundField DataField="item_desc_1" HeaderText="Panel Color" SortExpression="item_desc_1" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                                <asp:TableCell CssClass="spacer"></asp:TableCell>
                                 <asp:TableCell CssClass="descriptions">
                            Dealer:
                                </asp:TableCell>
                                
                                <asp:TableCell CssClass="data">
                                    <asp:Label ID="Dealer" runat="server" Text='<%# EVAL("cus_name") %>'></asp:Label>
                                </asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                    Accent Panel:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:GridView ID="gvAccentPanel" ShowHeader="false" GridLines="None" runat="server" AutoGenerateColumns="False" DataSourceID="sdsGetAccentPanel">
                                        <Columns>
                                            <asp:BoundField DataField="item_desc_1" HeaderText="Accent Panel" SortExpression="item_desc_1" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                                <asp:TableCell CssClass="spacer"></asp:TableCell>
                                 <asp:TableCell CssClass="descriptions">
                            Build Date:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("due_dt","{0:d}")%>'></asp:Label>
                                </asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                   Trim Accent:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:GridView ID="gvTrimAccent" ShowHeader="false" GridLines="None" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTrimAccent">
                                        <Columns>
                                            <asp:BoundField DataField="item_desc_1" HeaderText="Trim Accent" SortExpression="item_desc_1" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                                
                            </asp:TableHeaderRow>
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                    Base Vinyl:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:GridView ID="gvBaseVinyl" runat="server" ShowHeader="false" GridLines="none" AutoGenerateColumns="False" DataSourceID="sdsBaseVinyl">
                                        <Columns>
                                            <asp:BoundField DataField="item_desc_1" HeaderText="Interior Accent" SortExpression="item_desc_1" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                                <asp:TableCell CssClass="spacer"></asp:TableCell>
                                <asp:TableCell CssClass="descriptions">POP#:</asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:Label ID="Label5" runat="server" Text='<%# EVAL("ord_no") %>'></asp:Label>
                                </asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                    Interior Accent:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:GridView ID="gvInteriorAccent" runat="server" ShowHeader="false" GridLines="none" AutoGenerateColumns="False" DataSourceID="sdsInteriorAccent">
                                        <Columns>
                                            <asp:BoundField DataField="item_desc_1" HeaderText="Interior Accent" SortExpression="item_desc_1" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                                <asp:TableCell CssClass="spacer"></asp:TableCell>
                                <asp:TableCell CssClass="descriptions">
                            SO#:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:Label ID="Label6" runat="server" Text='<%# EVAL("src_ord_no") %>'></asp:Label>
                                </asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                    Furniture:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:GridView ID="gvFurniture" runat="server" ShowHeader="false" GridLines="None" AutoGenerateColumns="False" DataSourceID="sdsFurniture">
                                        <Columns>
                                            <asp:BoundField DataField="item_desc_1" HeaderText="Canvas" SortExpression="item_desc_1" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                                <asp:TableCell CssClass="spacer"></asp:TableCell>
                                <asp:TableCell CssClass="descriptions">S/N:</asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:Label ID="Label4" runat="server" Text="ETW __ __ __ __ __ __ __ __ __"></asp:Label></asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                    Canvas:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:GridView ID="gvCanvas" runat="server" ShowHeader="false" GridLines="none" AutoGenerateColumns="False" DataSourceID="sdsCanvas">
                                        <Columns>
                                            <asp:BoundField DataField="item_desc_1" HeaderText="Canvas" SortExpression="item_desc_1" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>                               
                            </asp:TableHeaderRow>
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                    Flooring:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:GridView ID="gvFlooring" runat="server" ShowHeader="false" GridLines="None" AutoGenerateColumns="False" DataSourceID="sdsFlooring">
                                        <Columns>
                                            <asp:BoundField DataField="item_desc_1" HeaderText="Pre-Rig" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>                                  
                                <asp:TableCell ColumnSpan="3" HorizontalAlign="Center">
                                    <asp:GridView ID="gvRigging" runat="server" ShowHeader="false" GridLines="none" AutoGenerateColumns="False" DataSourceID="sdsFlags">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                 <asp:ImageButton ID="btnIsCustom" runat="server" Visible='<%# Eval("IsCustom") = 1%>' ImageUrl="../Images/custom.png" /><asp:ImageButton ID="bntPilot" runat="server" Visible='<%# Eval("IsPilot") = 1%>' ImageUrl="../Images/pilot.png" /> <asp:ImageButton ID="btnRigging" runat="server" Visible='<%# Eval("RiggingNeeded") = 1%>' ImageUrl="../Images/rigging.png" /> <asp:ImageButton ID="btnWT" runat="server" Visible='<%# Eval("WavetamerNeeded") = 1%>' ImageUrl="../Images/wavetamer.png" /> <asp:ImageButton ID="btnShark" runat="server" Visible='<%# Eval("SharkhideNeeded") = 1%>' ImageUrl="../Images/sharkhide.png" />    
                                                    </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>                                   
                                    </asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                    Graphics:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:GridView ID="gvGraphics" runat="server" ShowHeader="false" GridLines="None" AutoGenerateColumns="False" DataSourceID="sdsGraphics">
                                        <Columns>
                                            <asp:BoundField DataField="item_desc_1" HeaderText="Graphics" SortExpression="item_desc_1" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                    Pre-Rig:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:GridView ID="gvPreRig" runat="server" ShowHeader="false" GridLines="None" AutoGenerateColumns="False" DataSourceID="sdsPreRig">
                                        <Columns>
                                            <asp:BoundField DataField="item_desc_1" HeaderText="Pre-Rig" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableHeaderRow>
                                <asp:TableCell CssClass="descriptions">
                    Engine:
                                </asp:TableCell>
                                <asp:TableCell CssClass="data">
                                    <asp:GridView ID="gvEngine" runat="server" ShowHeader="false" GridLines="None" AutoGenerateColumns="False" DataSourceID="sdsEngine">
                                        <Columns>
                                            <asp:BoundField DataField="item_desc_1" HeaderText="Engine" SortExpression="item_desc_1" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                            </asp:TableHeaderRow>


                            
                        </asp:Table>
                    </ItemTemplate>
                </asp:FormView>
            </div>

            <asp:SqlDataSource ID="sdsGetPanelColor" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                <SelectParameters>
                     <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                     <asp:Parameter DefaultValue="H1" Name="prod_cat" Type="String" />
                </SelectParameters>

            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsGetAccentPanel" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                    <asp:Parameter DefaultValue="H3A" Name="prod_cat" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsTrimAccent" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                    <asp:Parameter DefaultValue="H1P" Name="prod_cat" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsBaseVinyl" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                    <asp:Parameter DefaultValue="H1V" Name="prod_cat" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsCanvas" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                    <asp:Parameter DefaultValue="H5" Name="prod_cat" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsGraphics" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat OR [prod_cat] = @prod_cat1))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                    <asp:Parameter DefaultValue="H3G" Name="prod_cat" Type="String" />
                    <asp:Parameter DefaultValue="H3U" Name="prod_cat1" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsPreRig" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT IMITMIDX_SQL.mat_cost_type, OEORDLIN_SQL.ord_no, OEORDLIN_SQL.item_desc_1 FROM OEORDLIN_SQL LEFT OUTER JOIN IMITMIDX_SQL ON OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE (IMITMIDX_SQL.mat_cost_type = 'PRE') AND (OEORDLIN_SQL.ord_no = @ord_no)  Order By OEORDLIN_SQL.item_desc_1">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsPerfPkg" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT IMITMIDX_SQL.mat_cost_type, OEORDLIN_SQL.ord_no, OEORDLIN_SQL.item_desc_1 FROM OEORDLIN_SQL LEFT OUTER JOIN IMITMIDX_SQL ON OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE (IMITMIDX_SQL.mat_cost_type = 'A2P' OR IMITMIDX_SQL.mat_cost_type = 'A2T') AND (OEORDLIN_SQL.ord_no = @ord_no)  Order By OEORDLIN_SQL.item_desc_1">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsFurniture" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT IMITMIDX_SQL.mat_cost_type, OEORDLIN_SQL.ord_no, OEORDLIN_SQL.item_desc_1 FROM OEORDLIN_SQL LEFT OUTER JOIN IMITMIDX_SQL ON OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE (IMITMIDX_SQL.mat_cost_type = 'A0V') AND (OEORDLIN_SQL.ord_no = @ord_no) Order By OEORDLIN_SQL.item_desc_1">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsInteriorAccent" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] = @prod_cat))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                    <asp:Parameter DefaultValue="H1I" Name="prod_cat" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsEngine" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [item_desc_1] FROM [OEORDLIN_SQL] WHERE (([ord_no] = @ord_no) AND ([prod_cat] Like @prod_cat))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                    <asp:Parameter DefaultValue="EN%" Name="prod_cat" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsFlooring" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT IMITMIDX_SQL.mat_cost_type, OEORDLIN_SQL.ord_no, OEORDLIN_SQL.item_desc_1 FROM OEORDLIN_SQL LEFT OUTER JOIN IMITMIDX_SQL ON OEORDLIN_SQL.item_no = IMITMIDX_SQL.item_no WHERE (IMITMIDX_SQL.mat_cost_type = 'A1') AND (OEORDLIN_SQL.ord_no = @ord_no)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsFlags" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT IsCustom, IsPilot, WavetamerNeeded, SharkhideNeeded, RiggingNeeded FROM BML_POPREPORTING_GREENLIGHTS WHERE (BML_POPREPORTING_GREENLIGHTS.SONo = @ord_no)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <div id="workstationbody">
                <div class="columns">
                    <asp:GridView ID="gvFrames" runat="server" AutoGenerateColumns="False" ShowHeader="False" DataSourceID="sdsFabOptions_Frames" Caption="FRAMES - TUBES" CssClass="workstations">
                        <Columns>
                            <asp:BoundField DataField="Option_Desc" SortExpression="Option_Desc" />
                            <asp:TemplateField HeaderText="Sign Off">
                                <ItemStyle Width="40px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsFabOptions_Frames" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Item],[Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter))  Order By Option_Desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlProdNo" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter DefaultValue="Tubes" Name="Workcenter" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:GridView ID="gvFloors" runat="server" AutoGenerateColumns="False" DataSourceID="sdsFabOptions_Floors" ShowHeader="false" Caption="FLOORS" CssClass="workstations">
                        <Columns>
                            <asp:BoundField DataField="Option_Desc" SortExpression="Option_Desc" />
                            <asp:TemplateField HeaderText="Sign Off">
                                <ItemStyle Width="40px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsFabOptions_Floors" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Item],[Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter)) Order By Option_Desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlProdNo" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter DefaultValue="Flooring" Name="Workcenter" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:GridView ID="gvRailsInstall" runat="server" AutoGenerateColumns="False" DataSourceID="sdsFabOptions_RailsInstall" ShowHeader="false" Caption="RAILS" CssClass="workstations">
                        <Columns>
                            <asp:BoundField DataField="Option_Desc" SortExpression="Option_Desc" />
                            <asp:TemplateField HeaderText="Sign Off">
                                <ItemStyle Width="40px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsFabOptions_RailsInstall" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Option_Item],[Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter or [Workcenter] = @Workcenter2)) Order By Option_Desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlProdNo" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter DefaultValue="RailsInstall" Name="Workcenter" Type="String" />
                            <asp:Parameter DefaultValue="RailsPrep" Name="Workcenter2" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />                    
                    <asp:GridView ID="gvFurnitureInstall" runat="server" AutoGenerateColumns="False" DataSourceID="sdsFabOptions_Furniture" ShowHeader="false" Caption="FURNITURE" CssClass="workstations">
                        <Columns>
                            <asp:BoundField DataField="Option_Desc" SortExpression="Option_Desc" />
                            <asp:TemplateField HeaderText="Sign Off">
                                <ItemStyle Width="40px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsFabOptions_Furniture" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Option_Item],[Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter or [Workcenter] = @Workcenter2)) Order By Option_Desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlProdNo" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter DefaultValue="Furniture" Name="Workcenter" Type="String" />
                            <asp:Parameter DefaultValue="FurniturePrep" Name="Workcenter2" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="columns">
                    <asp:GridView ID="gvHelms" runat="server" AutoGenerateColumns="False" DataSourceID="sdsFabOptions_Helms" ShowHeader="false" Caption="HELMS" CssClass="workstations">
                        <Columns>
                            <asp:BoundField DataField="Option_Desc" SortExpression="Option_Desc" />
                            <asp:TemplateField HeaderText="Sign Off">
                                <ItemStyle Width="40px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsFabOptions_Helms" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Item],[Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter)) Order By Option_Desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlProdNo" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter DefaultValue="Helms" Name="Workcenter" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:GridView ID="gvCovers" runat="server" AutoGenerateColumns="False" DataSourceID="sdsFabOptions_Covers" ShowHeader="false" Caption="COVERS" CssClass="workstations">
                        <Columns>
                            <asp:BoundField DataField="Option_Desc" SortExpression="Option_Desc" />
                            <asp:TemplateField HeaderText="Sign Off">
                                <ItemStyle Width="40px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsFabOptions_Covers" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Item],[Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter)) Order By Option_Desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlProdNo" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter DefaultValue="Covers" Name="Workcenter" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:GridView ID="gvBuildOptions" runat="server" AutoGenerateColumns="False" DataSourceID="sdsFabOptions_BuildOptions" ShowHeader="false" Caption="BUILD OPTIONS" CssClass="workstations">
                        <Columns>
                            <asp:BoundField DataField="Option_Desc" SortExpression="Option_Desc" />
                            <asp:TemplateField HeaderText="Sign Off">
                                <ItemStyle Width="40px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsFabOptions_BuildOptions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Option_Item],[Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter or [Workcenter] = @Workcenter2)) Order By Option_Desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlProdNo" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter DefaultValue="BuildOptions" Name="Workcenter" Type="String" />
                            <asp:Parameter DefaultValue="Fiberglass" Name="Workcenter2" Type="String" />

                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:GridView ID="gvWaveTamer" runat="server" AutoGenerateColumns="False" DataSourceID="sdsFabOptions_WaveTamer" ShowHeader="false" Caption="WAVETAMER" CssClass="workstations">
                        <Columns>
                            <asp:BoundField DataField="Option_Desc" SortExpression="Option_Desc" />
                            <asp:TemplateField HeaderText="Sign Off">
                                <ItemStyle Width="40px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsFabOptions_WaveTamer" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Item],[Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter)) Order By Option_Desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlProdNo" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter DefaultValue="WaveTamer" Name="Workcenter" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:GridView ID="gvCentertube" runat="server" AutoGenerateColumns="False" DataSourceID="sdsFabOptions_Centertube" ShowHeader="false" Caption="CENTER TUBE" CssClass="workstations">
                        <Columns>
                            <asp:BoundField DataField="Option_Desc" SortExpression="Option_Desc" />
                            <asp:TemplateField HeaderText="Sign Off">
                                <ItemStyle Width="40px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsFabOptions_Centertube" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Item],[Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter)) Order By Option_Desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlProdNo" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter DefaultValue="WaveTamer" Name="Workcenter" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:GridView ID="gvSharkhide" runat="server" AutoGenerateColumns="False" DataSourceID="sdsFabOptions_Sharkhide" ShowHeader="false" Caption="SHARKHIDE" CssClass="workstations">
                        <Columns>
                            <asp:BoundField DataField="Option_Desc" SortExpression="Option_Desc" />
                            <asp:TemplateField HeaderText="Sign Off">
                                <ItemStyle Width="40px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <br />                    
                    <asp:SqlDataSource ID="sdsFabOptions_Sharkhide" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [Option_Item],[Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([ProdNo] = @ProdNo) AND ([Workcenter] = @Workcenter)) Order By Option_Desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlProdNo" Name="ProdNo" PropertyName="SelectedValue" Type="String" />
                            <asp:Parameter DefaultValue="WaveTamer" Name="Workcenter" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="columns">
                    <asp:GridView ID="dbGridView3" Caption="REMAINING LINE ITEMS" ShowHeader="False" CssClass="remaining" runat="server" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="item_no" />
                            <asp:BoundField DataField="item_desc_1" />
                            <asp:TemplateField HeaderText="Sign Off">
                                <ItemStyle Width="40px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <br />

                    <asp:GridView ID="gvComments" runat="server" Caption="COMMENTS" AutoGenerateColumns="False" DataSourceID="sdsOELINCMTS" CssClass="comments">
                        <Columns>
                            <asp:BoundField DataField="cmt" HeaderText="" SortExpression="cmt" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsOELINCMTS" runat="server" ConnectionString="<%$ ConnectionStrings:dataConnectionString %>" SelectCommand="SELECT [ord_no], [cmt] FROM [OELINCMT_SQL] WHERE ([ord_no] = @ord_no)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdnSoNo" Name="ord_no" PropertyName="Value" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="dbGridview1" runat="server">
                    </asp:GridView>
                </div>
            </div>
        </form>
    </div>



</body>
</html>
