<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReworkTracking.aspx.vb" Inherits="ReworkTracking" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ReWork Tracking</title>
    <link href="StyleSheet.css" rel="stylesheet" />
    <style>
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label12" runat="server" Text="Rework Logging By Prod #" CssClass="newStyle7"></asp:Label>
            <br />
            <asp:Table ID="Table1" runat="server" CellSpacing="2" CellPadding="2">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="Label1" runat="server" Text="Prod #: " CssClass="newStyle6"></asp:Label><asp:TextBox ID="tbProdNo" runat="server" CssClass="newStyle6" Height="38px" Width="130px"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:GridView ID="gvBoatDetails" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatDetails" CssClass="newStyle1" Width="738px">
                            <Columns>
                                <asp:BoundField DataField="ItemNo" HeaderText="MODEL" SortExpression="ItemNo">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DueDate" HeaderText="DUE DATE" SortExpression="DueDate" DataFormatString="{0:d}">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:ImageField DataImageUrlField="IsCustom" HeaderText="CUSTOM?" DataImageUrlFormatString="./Images/ovcustom{0}.png">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:ImageField>
                                <asp:ImageField DataImageUrlField="IsPilot" HeaderText="PILOT?" DataImageUrlFormatString="./Images/ovpilot{0}.png">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:ImageField>
                                <asp:BoundField DataField="BuildLoc" HeaderText="BUILDING" SortExpression="BuildLoc">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SerialNo" HeaderText="HIN #" SortExpression="SerialNo">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>

                        <asp:SqlDataSource ID="sdsBoatDetails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ItemNo], [DueDate], [IsCustom], [IsPilot], [BuildLoc], [SerialNo] FROM [BML_POPREPORTING_GREENLIGHTS] Left Join ProdtoSerialMatrix on BML_POPREPORTING_GREENLIGHTS.ProdNo = ProdtoSerialMatrix.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.ProdNo = @ProdNo)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="Label4" runat="server" Text="Date Defect Reported: " CssClass="newStyle6"></asp:Label>
                        <asp:TextBox ID="tbDate" runat="server" CssClass="newStyle1" TextMode="Date" Width="157px"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="Label11" runat="server" Text="Area:" CssClass="newStyle6"></asp:Label>
                        <asp:DropDownList ID="ddlArea" Enabled="false" runat="server">
                            <asp:ListItem>Boat Assembly</asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="Label2" runat="server" Text="Product Category:" CssClass="newStyle6"></asp:Label>
                        &nbsp;<asp:DropDownList ID="ddlProductCategories" runat="server" AppendDataBoundItems="true">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Audio</asp:ListItem>
                            <asp:ListItem>Bimini</asp:ListItem>
                            <asp:ListItem>Console</asp:ListItem>
                            <asp:ListItem>Deck</asp:ListItem>
                            <asp:ListItem>Electrical System</asp:ListItem>
                            <asp:ListItem>Flooring</asp:ListItem>
                            <asp:ListItem>Fuel System</asp:ListItem>
                            <asp:ListItem>Furniture</asp:ListItem>
                            <asp:ListItem>Owners Packet</asp:ListItem>
                            <asp:ListItem>Playpen Cover</asp:ListItem>
                            <asp:ListItem>Rail Structure</asp:ListItem>
                            <asp:ListItem>Tube</asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="Label5" runat="server" Text="Item (Individual Affected Component):" CssClass="newStyle6"></asp:Label>&nbsp;<asp:TextBox ID="tbItem" runat="server" CssClass="newStyle1" Width="436px"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <asp:Table ID="Table2" runat="server">
                <asp:TableRow>
                    <asp:TableCell VerticalAlign="Top">
                        <asp:Label ID="Label3" runat="server" Text="Location On Boat:" CssClass="newStyle6"></asp:Label>
                        <asp:CheckBoxList ID="cbLocation" runat="server" RepeatDirection="Vertical" RepeatColumns="0" Width="300px" CssClass="newStyle1">
                            <asp:ListItem Value="PF">Port Front</asp:ListItem>
                            <asp:ListItem Value="PM">Port Mid</asp:ListItem>
                            <asp:ListItem Value="PR">Port Rear</asp:ListItem>
                            <asp:ListItem Value="SF">Strb Front</asp:ListItem>
                            <asp:ListItem Value="SM">Strb Mid</asp:ListItem>
                            <asp:ListItem Value="SR">Strb Mid</asp:ListItem>
                            <asp:ListItem Value="CB">Ctr Bow</asp:ListItem>
                            <asp:ListItem Value="CS">Ctr Stern</asp:ListItem>
                        </asp:CheckBoxList>
                    </asp:TableCell>
                    <asp:TableCell VerticalAlign="Top">
                        <asp:Label ID="Label6" runat="server" Text="Discrepancy:" CssClass="newStyle6" Width="300px"></asp:Label>
                        <asp:CheckBoxList ID="cbDiscrepancy" runat="server" Width="550px" CssClass="newStyle1">
                            <asp:ListItem Value="Fit">Fit - Incorrect Positioning or Alignment</asp:ListItem>
                            <asp:ListItem Value="Form">Form - Incorrect Shape/Size/Dimention</asp:ListItem>
                            <asp:ListItem Value="Function">Function - Unable to Perform Stated Purpose</asp:ListItem>
                            <asp:ListItem Value="Damage">Damage - Physical Harm Impairing Aesthetics/Usefulness/Function</asp:ListItem>
                        </asp:CheckBoxList>
                    </asp:TableCell>
                    <asp:TableCell VerticalAlign="Top">
                        <asp:Label ID="Label7" runat="server" Text="Source:" CssClass="newStyle6"></asp:Label>
                        <asp:CheckBoxList ID="cbSource" runat="server" Width="500" CssClass="newStyle1">
                            <asp:ListItem Value="I">Internally Caused Defect</asp:ListItem>
                            <asp:ListItem Value="S">Outside Supplier Caused Defect</asp:ListItem>
                        </asp:CheckBoxList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <asp:Label ID="Label8" runat="server" Text="Details:" CssClass="newStyle6"></asp:Label><br />
            <asp:TextBox ID="tbDetails" runat="server" CssClass="newStyle1" TextMode="MultiLine" Height="100px" Width="608px"></asp:TextBox>            
            <br />
            <asp:Label ID="Label9" runat="server" Text="Repaired By (Initials): " CssClass="newStyle6" Width="167px"></asp:Label><asp:TextBox ID="tbRepairedBy" runat="server" CssClass="newStyle1" TextMode="SingleLine" Width="60px"></asp:TextBox>                        
            <asp:Label ID="Label10" runat="server" Text="Verified By (Initials): " CssClass="newStyle6" Width="167px"></asp:Label><asp:TextBox ID="tbVerifiedBy" runat="server" CssClass="newStyle1" TextMode="SingleLine" Width="60px"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" />

        </div>
    </form>
</body>
</html>
