<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Maintenance.aspx.vb" Inherits="Gates_Maintenance" MaintainScrollPositionOnPostback="true" %>


<%--<%--todo needs to have a way to add a New model--build it seperately And embed it here as it will be useful in more places%>--%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mfg'd Gates Weld Schedule</title>
     <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .left {
            float:left;
        }
        .right {
            float:left;
        }
     </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="left">
            <asp:Label ID="Label1" runat="server" Text="MFG'D GATES PER MODEL MAINTENANCE" CssClass="newStyle4"></asp:Label>&nbsp;&nbsp;<asp:DropDownList ID="ddlYears" runat="server" AutoPostBack="True" DataSourceID="sdsDistinctModelYears" DataTextField="Year" DataValueField="Year"></asp:DropDownList>
            <asp:SqlDataSource ID="sdsDistinctModelYears" runat="server" ConnectionString="<%$ ConnectionStrings:ProductInfoConnectionString %>" SelectCommand="SELECT Distinct(Year) FROM [BoatModels] ORDER BY [Year]"></asp:SqlDataSource>
            <asp:GridView ID="gvGateMaintenance" CssClass="newStyle1" runat="server" AutoGenerateColumns="False" DataKeyNames="ModelWYear" DataSourceID="sdsGates" AllowSorting="True" Width="1254px">
                <Columns>                    
                    <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" ReadOnly="true">
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" ReadOnly="true"/>
                    <asp:TemplateField HeaderText="Drawing">
                        <ItemTemplate>
                            <asp:Button ID="btnDrawing" runat="server" CommandName="gotodrawing" CommandArgument='<%#Eval("Drawing") %>' Text='<%#Eval("Drawing") %>' />                            
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center"/>
                    </asp:TemplateField>                    
                    
                    <asp:BoundField DataField="ModelWYear" HeaderText="Model W Year" ReadOnly="True" SortExpression="ModelWYear" Visible="false"/>
                    <asp:BoundField DataField="Series" HeaderText="Series" SortExpression="Series" ReadOnly="true"/>                    
                    <asp:BoundField DataField="NumberGates" HeaderText="# Gates" SortExpression="NumberGates" >                   
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BowCtr" HeaderText="Bow Ctr" SortExpression="BowCtr" >                                      
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Port" HeaderText="Port" SortExpression="Port" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Strb" HeaderText="Strb" SortExpression="Strb" >
                      <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                      <asp:BoundField DataField="AftPort" HeaderText="Aft Port" SortExpression="AftPort" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="AftCtr" HeaderText="Aft Ctr" SortExpression="AftCtr" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="AftStrb" HeaderText="Aft Strb" SortExpression="AftStrb" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:CommandField ShowEditButton="True" />
                </Columns>
            </asp:GridView>
            
            <asp:SqlDataSource ID="sdsGates" runat="server" ConnectionString="<%$ ConnectionStrings:ProductInfoConnectionString %>" DeleteCommand="DELETE FROM [Gates] WHERE [ModelWYear] = @ModelWYear" InsertCommand="INSERT INTO [Gates] ([Model], [ModelWYear], [Year], [NumberGates], [BowPort], [BowCtr], [BowStrb], [AftPort], [AftCtr], [AftStrb], [Port], [Strb]) VALUES (@Model, @ModelWYear, @Year, @NumberGates, @BowPort, @BowCtr, @BowStrb, @AftPort, @AftCtr, @AftStrb, @Port, @Strb)" SelectCommand="SELECT t2.Series, t2.ModelWYear, t2.Drawing, t2.Year, t2.Model, t1.NumberGates, t1.BowPort, t1.BowCtr, t1.BowStrb, t1.AftPort, t1.AftCtr, t1.AftStrb, t1.Port, t1.Strb FROM [BoatModels] t2 Join [Gates] t1 on t2.ModelWYear = t1.ModelWYear Where t2.Year = @Year ORDER BY t2.Year, t2.Model" UpdateCommand="UPDATE [Gates] SET [NumberGates] = @NumberGates, [BowCtr] = @BowCtr, [AftPort] = @AftPort, [AftCtr] = @AftCtr, [AftStrb] = @AftStrb, [Port] = @Port, [Strb] = @Strb WHERE [ModelWYear] = @ModelWYear">
                <DeleteParameters>
                    <asp:Parameter Name="ModelWYear" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Model" Type="String" />
                    <asp:Parameter Name="ModelWYear" Type="String" />
                    <asp:Parameter Name="Year" Type="Int32" />
                    <asp:Parameter Name="NumberGates" Type="Int32" />
                    <asp:Parameter Name="BowPort" Type="Int32" />
                    <asp:Parameter Name="BowCtr" Type="Int32" />
                    <asp:Parameter Name="BowStrb" Type="Int32" />
                    <asp:Parameter Name="AftPort" Type="Int32" />
                    <asp:Parameter Name="AftCtr" Type="Int32" />
                    <asp:Parameter Name="AftStrb" Type="Int32" />
                    <asp:Parameter Name="Port" Type="Int32" />
                    <asp:Parameter Name="Strb" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Model" Type="String" />
                    <asp:Parameter Name="Year" Type="Int32" />
                    <asp:Parameter Name="NumberGates" Type="Int32" />
                    <asp:Parameter Name="BowPort" Type="Int32" />
                    <asp:Parameter Name="BowCtr" Type="Int32" />
                    <asp:Parameter Name="BowStrb" Type="Int32" />
                    <asp:Parameter Name="AftPort" Type="Int32" />
                    <asp:Parameter Name="AftCtr" Type="Int32" />
                    <asp:Parameter Name="AftStrb" Type="Int32" />
                    <asp:Parameter Name="Port" Type="Int32" />
                    <asp:Parameter Name="Strb" Type="Int32" />
                    <asp:Parameter Name="ModelWYear" Type="String" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlYears" Name="Year" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div class="right">
            <asp:DetailsView ID="dvAddGates" runat="server" Height="50px" Width="305px" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" DataSourceID="sdsGates" DefaultMode="Insert" ForeColor="Black" Caption="Add A Model">
                <EditRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <Fields>
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle BackColor="White" />
            </asp:DetailsView>
        </div>
    </form>
</body>
</html>
