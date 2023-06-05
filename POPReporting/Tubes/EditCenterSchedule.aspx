<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditCenterSchedule.aspx.vb" Inherits="Tubes_EditCenterSchedule" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tubes - Center Schedule Edit/Print</title>
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
    
        <asp:Label ID="Label1" runat="server" CssClass="newStyle4" Text="Center Tube Schedule"></asp:Label>
&nbsp;<asp:DropDownList ID="ddlCenterDates" runat="server" AutoPostBack="True" DataSourceID="sdsCenterDates" DataTextField="CenterScheduled" DataValueField="CenterScheduled" DataTextFormatString="{0:d}" CssClass="newStyle6">
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnPrintable" runat="server" Text="Open Printable" />
        <br />
        <asp:SqlDataSource ID="sdsCenterDates" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [CenterScheduled] FROM [Tubes] WHERE ([CenterScheduled] IS NOT NULL) ORDER BY [CenterScheduled] Desc"></asp:SqlDataSource>
        <br />
    
        <asp:GridView ID="gvCenters" runat="server" DataSourceID="sdsCenterTubes" AutoGenerateColumns="False" DataKeyNames="ProdNo" CssClass="tubeschedule" AllowSorting="True">
            <Columns>
                <asp:TemplateField HeaderText="ORDER">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("CenterScheduleOrder")%>' Width="30px" ID="tbOrder"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>                
                <asp:BoundField DataField="PrintOrder" HeaderText="PRINT ORDER" ReadOnly="True" SortExpression="PrintOrder" >
                <ItemStyle Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="ProdNo" HeaderText="PROD #" ReadOnly="True" SortExpression="ShortProdNo" />
                <asp:TemplateField HeaderText="LEN">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Length")%>' Width="30px" ID="tbLength"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="NL ROPE">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Rope")%>' Width="30px" ID="tbRope"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Center">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Center")%>' Width="80px" ID="tbCenter"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="STORAGE">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Storage")%>' Width="50px" ID="tbStorage"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="10 WIDE">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("TenWide")%>' Width="100px" ID="tbTenWide"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DRAWING #">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("DrawingNo")%>' Width="50px" ID="tbDrawingNo"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- <asp:TemplateField HeaderText="BRKT">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Bracket")%>' Width="30px" ID="tbBrackets"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField> --%>            
                  <asp:TemplateField HeaderText="FUEL">                      
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Fuel")%>' Width="70px" ID="tbFuel"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>                
                  <asp:TemplateField HeaderText="STRAKES">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Strakes")%>' Width="100px" ID="tbStrakes"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="TUBE UPG">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("TubeUpg")%>' Width="100px" ID="tbTubeUpg"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="SPECIAL COMMENTS">
                    <ItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Eval("Upsweep_SldTrans")%>' Width="260px" ID="tbUpsweep"></asp:TextBox>
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
        <asp:SqlDataSource ID="sdsCenterTubes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Tubes.ProdNo, IsCustom, IsPilot, [CenterScheduledFlag], [CenterScheduled], [CenterRoller], [CenterSections], [CenterScheduleOrder], [CenterScheduleOrder] + 1 as PrintOrder, ShortProdNo, Length, Center, Storage, TenWide, DrawingNo, Bracket, Fuel, Strakes, TubeUpg, Upsweep_SldTrans, Rope FROM [Tubes] Left Join CenterTubeDetails on Tubes.ProdNo = CenterTubeDetailS.ProdNo left join BML_POPREPORTING on Tubes.ProdNo = BML_POPREPORTING.ProdNo WHERE ([CenterScheduled] = @CenterScheduled) ORDER BY [CenterScheduled], [CenterScheduleOrder]">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlCenterDates" DbType="Date" Name="CenterScheduled" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
