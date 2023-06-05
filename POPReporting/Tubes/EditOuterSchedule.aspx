<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditOuterSchedule.aspx.vb" Inherits="Tubes_EditOuterSchedule" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tubes - Outer Schedule Edit/Print</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .tubeschedule {
            font-family:Calibri;
            font-size:11px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="Label1" runat="server" CssClass="newStyle4" Text="Outer Tube Schedule"></asp:Label>
&nbsp;<asp:DropDownList ID="ddlOuterDates" runat="server" AutoPostBack="True" DataSourceID="sdsOuterDates" DataTextField="OuterScheduled" DataValueField="OuterScheduled" DataTextFormatString="{0:d}" CssClass="newStyle6">
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnPrintable" runat="server" Text="Open Printable" />
        <br />
        <asp:SqlDataSource ID="sdsOuterDates" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [OuterScheduled] FROM [Tubes] WHERE ([OuterScheduled] IS NOT NULL) ORDER BY [OuterScheduled] Desc"></asp:SqlDataSource>
        <br />
    
        <asp:GridView ID="gvOuters" runat="server" DataSourceID="sdsOuterTubes" AutoGenerateColumns="False" DataKeyNames="ProdNo" CssClass="tubeschedule" AllowSorting="True">
            <Columns>
                <asp:TemplateField HeaderText="ORDER">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("OuterScheduleOrder")%>' Width="30px" ID="tbOrder"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>                
                <asp:BoundField DataField="PrintOrder" HeaderText="PRINT ORDER" ReadOnly="True" SortExpression="PrintOrder" >
                <ItemStyle Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="ProdNo" HeaderText="PROD #" ReadOnly="True" SortExpression="ShortProdNo" />
                <asp:TemplateField HeaderText="STYLE">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Style")%>' Width="75px" ID="tbStyle"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DIA">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Diameter")%>' Width="30px" ID="tbDiameter"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="FNT">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Front")%>' Width="30px" ID="tbFront"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ROPE">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Rope")%>' Width="30px" ID="tbRope"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="MODEL">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("TubeModel")%>' Width="130px" ID="tbModel"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="LAD">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Ladder")%>' Width="50px" ID="tbLadder"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="BRKT">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Bracket")%>' Width="40px" ID="tbBrackets"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="KEEL">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Keel")%>' Width="20px" ID="tbKeel"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="FUEL">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Fuel")%>' Width="50px" ID="tbFuel"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="SPLASH">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Splash")%>' Width="100px" ID="tbSplash"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="STRAKES">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Strakes")%>' Width="90px" ID="tbStrakes"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="STRAKES CMTS">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("StrakesComments")%>' Width="80px" ID="tbStrakesCmts"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="STRB TRANS">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("StrbTrans")%>' Width="100px" ID="tbStrbTrans"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="CMTS">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Comments")%>' Width="300px" ID="tbComments"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="BLACK">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Black")%>' Width="50px" ID="tbBlack"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="MEGAPAN">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("MegaPan")%>' Width="50px" ID="tbMegaPan"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                  
                  <asp:TemplateField HeaderText="DRAWING #">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("DrawingNo")%>' Width="50px" ID="tbDrawingNo"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:BoundField DataField="ShortProdNo" HeaderText="PROD #" ReadOnly="True" SortExpression="ShortProdNo" />  
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnSave" runat="server" Text="Save" CommandName="gotoSave" CommandArgument="<%# Container.DataItemIndex %>" />
                    </ItemTemplate>
                </asp:TemplateField>                          
            </Columns>
            <HeaderStyle VerticalAlign="Bottom" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsOuterTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Tubes.ProdNo, IsCustom, IsPilot, [OuterScheduledFlag], [OuterScheduled], [OuterRoller], [OuterSections], [OuterScheduleOrder], [OuterScheduleOrder] + 1 as PrintOrder, ShortProdNo, Style, Diameter, Front, TubeModel, Ladder, Bracket, Keel, Fuel, Splash, Strakes, StrakesComments, StrbTrans, Comments, Black, DrawingNo, MegaPan, Rope FROM [Tubes] Left Join OuterTubeDetails on Tubes.ProdNo = OuterTubeDetailS.ProdNo Left Join BML_POPREPORTING on Tubes.ProdNo = BML_POPREPORTING.ProdNo WHERE ([OuterScheduled] = @OuterScheduled) ORDER BY [OuterScheduled], [OuterScheduleOrder]">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlOuterDates" DbType="Date" Name="OuterScheduled" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
