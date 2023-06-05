<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditBiminiFeetDimensions.aspx.vb" Inherits="Workstations_EditBiminiFeetDimensions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Bimini Feet Dimensions Or Add New Models</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        #left {
            float: left;
        }

        #right {
            float: left;
            margin-left: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">


        <div id="left">
            <asp:Label ID="Label2" runat="server" CssClass="newStyle7" Text="Edit Bimini Feet Dimensions or Add Models: "></asp:Label><br />
            <asp:Label ID="Label1" runat="server" CssClass="newStyle1" Text="Model Year: "></asp:Label>
            &nbsp;
       
             <asp:DropDownList ID="ddlModelYear" runat="server">
                 <asp:ListItem Value="19">2019</asp:ListItem>
                 <asp:ListItem Value="20">2020</asp:ListItem>
                 <asp:ListItem Value="21">2021</asp:ListItem>
                 <asp:ListItem Value="22">2022</asp:ListItem>
                 <asp:ListItem Value="23">2023</asp:ListItem>
             </asp:DropDownList>
            <br />
            <br />
            <asp:GridView ID="gvBiminiDimensions" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="MODEL,MODEL_YEAR" DataSourceID="sdsBiminiDimensions" Width="1200px">
                <Columns>
                    <asp:CommandField ShowEditButton="True" />
                    <asp:BoundField DataField="MODEL" HeaderText="MODEL" ReadOnly="True" SortExpression="MODEL" />
                    <asp:BoundField DataField="PORT_REAR" HeaderText="PORT REAR" SortExpression="PORT_REAR">
                        <ItemStyle HorizontalAlign="Center" Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PORT_MID" HeaderText="PORT MID" SortExpression="PORT_MID">
                        <ItemStyle HorizontalAlign="Center" Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="STRB_REAR" HeaderText="STRB REAR" SortExpression="STRB_REAR">
                        <ItemStyle HorizontalAlign="Center" Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="STRB_MID" HeaderText="STRB MID" SortExpression="STRB_MID">
                        <ItemStyle HorizontalAlign="Center" Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PORT_DBL_BIM" HeaderText="PORT DBL BIM" SortExpression="PORT_DBL_BIM">
                        <ItemStyle HorizontalAlign="Center" Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="STRB_DBL_BIM" HeaderText="STRB DBL BIM" SortExpression="STRB_DBL_BIM">
                        <ItemStyle HorizontalAlign="Center" Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PORT_POWER_TOP" HeaderText="PORT PWR TOP"> 
                    <ItemStyle HorizontalAlign="Center" Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="STRB_POWER_TOP" HeaderText="STRB PWR TOP">
                        <ItemStyle HorizontalAlign="Center" Width="200px" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsBiminiDimensions" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [Bimini_Feet_Dimensions] WHERE [MODEL] = @MODEL AND [MODEL_YEAR] = @MODEL_YEAR" InsertCommand="INSERT INTO [Bimini_Feet_Dimensions] ([MODEL], [MODEL_YEAR], [PORT_REAR], [PORT_MID], [STRB_REAR], [STRB_MID], [PORT_DBL_BIM], [STRB_DBL_BIM],[PORT_POWER_TOP],[STRB_POWER_TOP]) VALUES (@MODEL, @MODEL_YEAR, @PORT_REAR, @PORT_MID, @STRB_REAR, @STRB_MID, @PORT_DBL_BIM, @STRB_DBL_BIM, @PORT_POWER_TOP, @STRB_POWER_TOP)" SelectCommand="SELECT * FROM [Bimini_Feet_Dimensions] WHERE ([MODEL_YEAR] = @MODEL_YEAR) ORDER BY [MODEL]" UpdateCommand="UPDATE [Bimini_Feet_Dimensions] SET [PORT_REAR] = @PORT_REAR, [PORT_MID] = @PORT_MID, [STRB_REAR] = @STRB_REAR, [STRB_MID] = @STRB_MID, [PORT_DBL_BIM] = @PORT_DBL_BIM, [STRB_DBL_BIM] = @STRB_DBL_BIM, [PORT_POWER_TOP] = @PORT_POWER_TOP, [STRB_POWER_TOP] = @STRB_POWER_TOP WHERE [MODEL] = @MODEL AND [MODEL_YEAR] = @MODEL_YEAR">
                <DeleteParameters>
                    <asp:Parameter Name="MODEL" Type="String" />
                    <asp:Parameter Name="MODEL_YEAR" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="MODEL" Type="String" />
                    <asp:Parameter Name="MODEL_YEAR" Type="Int32" />
                    <asp:Parameter Name="PORT_REAR" Type="String" />
                    <asp:Parameter Name="PORT_MID" Type="String" />
                    <asp:Parameter Name="STRB_REAR" Type="String" />
                    <asp:Parameter Name="STRB_MID" Type="String" />
                    <asp:Parameter Name="PORT_DBL_BIM" Type="String" />
                    <asp:Parameter Name="STRB_DBL_BIM" Type="String" />
                    <asp:Parameter Name="PORT_POWER_TOP" Type="String" />
                    <asp:Parameter Name="STRB_POWER_TOP" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlModelYear" Name="MODEL_YEAR" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="PORT_REAR" Type="String" />
                    <asp:Parameter Name="PORT_MID" Type="String" />
                    <asp:Parameter Name="STRB_REAR" Type="String" />
                    <asp:Parameter Name="STRB_MID" Type="String" />
                    <asp:Parameter Name="PORT_DBL_BIM" Type="String" />
                    <asp:Parameter Name="STRB_DBL_BIM" Type="String" />
                    <asp:Parameter Name="MODEL" Type="String" />
                    <asp:Parameter Name="MODEL_YEAR" Type="Int32" />
                    <asp:Parameter Name="PORT_POWER_TOP" Type="String" />
                    <asp:Parameter Name="STRB_POWER_TOP" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        <div id="right">
            <br />
            <br />
            <br />
            <asp:DetailsView ID="dvAddModel" runat="server" Height="50px" Width="400px" AutoGenerateRows="False" CssClass="newStyle1" DataKeyNames="MODEL,MODEL_YEAR" DataSourceID="sdsBiminiDimensions" Caption="Add Missing Model">
                <Fields>
                    <asp:BoundField DataField="MODEL" HeaderText="MODEL" ReadOnly="True" SortExpression="MODEL" />
                    <asp:BoundField DataField="MODEL_YEAR" HeaderText="TWO DIGIIT MODEL YEAR" ReadOnly="True" SortExpression="MODEL_YEAR" />
                    <asp:BoundField DataField="PORT_REAR" HeaderText="PORT REAR" SortExpression="PORT_REAR" />
                    <asp:BoundField DataField="PORT_MID" HeaderText="PORT MID" SortExpression="PORT_MID" />
                    <asp:BoundField DataField="STRB_REAR" HeaderText="STRB REAR" SortExpression="STRB_REAR" />
                    <asp:BoundField DataField="STRB_MID" HeaderText="STRB MID" SortExpression="STRB_MID" />
                    <asp:BoundField DataField="PORT_DBL_BIM" HeaderText="PORT DBL BIM" SortExpression="PORT_DBL_BIM" />
                    <asp:BoundField DataField="STRB_DBL_BIM" HeaderText="STRB DBL BIM" SortExpression="STRB_DBL_BIM" />                    
                    <asp:BoundField DataField="PORT_POWER_TOP" HeaderText="PORT PWR TOP" SortExpression="PORT_POWER_TOP" />
                    <asp:BoundField DataField="STRB_POWER_TOP" HeaderText="STRB PWR TOP" SortExpression="STRB_POWER_TOP" />
                    <asp:CommandField ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
        </div>
    </form>
</body>
</html>
