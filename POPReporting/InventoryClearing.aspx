<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InventoryClearing.aspx.vb" Inherits="InventoryClearing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Areas To Clear</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./scripts/css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">

        <label for="btnRefresh" class="fixed-top bg-dark text-light text-center">INVENTORY AREAS READY FOR FINAL CLEARING</label>

        <asp:Button ID="btnRefresh" runat="server" Text="Refresh" CssClass="btn btn-dark m-1 mt-4 float-left" />
        <h6><asp:Label ID="Label2" CssClass="float-left col-9 mt-3" runat="server" Text="Accept The Area You Are About To Work On. Mark It Complete When You Are Finished."></asp:Label></h6>
        
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>

                <asp:GridView ID="gvAreasToClear" runat="server" SqlDataSource="sdsInventoryAreas" AutoGenerateColumns="False" DataSourceID="sdsInventoryAreas" ShowEditButton="True" Width="100%" CssClass="mt-2">
                    <Columns>
                        
                        <asp:BoundField DataField="Area" HeaderText="Area">
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                            
                        <asp:BoundField DataField="Building" HeaderText="Bldg">
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        
                       
                        <asp:TemplateField HeaderText="Aud/Wrt/Desc">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%#Eval("Auditor")%>'></asp:Label><br />
                                <asp:Label ID="Label4" runat="server" Text='<%#Eval("Writer")%>'></asp:Label><br />                                
                                <asp:Label ID="Label5" runat="server" Text='<%#Eval("AreaDesc")%>'></asp:Label>
                            </ItemTemplate>                          
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Accept">
                            <ItemTemplate>
                                <asp:Button ID="btnAccept" runat="server" CssClass="btn btn-outline-success m-2" Visible='<%#Eval("ClearingInProgress") = 0%>' Text="Accept" CommandArgument="<%# Container.DataItemIndex %>" CommandName="updateaccept" />                               
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center"  />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Accepted By:">
                            <ItemTemplate>
                                 <asp:TextBox ID="tbAcceptedBy" CssClass="w-75 m-2" runat="server" Text='<%# Eval("ClearingAuditor")%>' Enabled="False"></asp:TextBox>
                                 <asp:Button ID="btnComplete" cssClass="btn btn-outline-success m-2" runat="server" Visible='<%#Eval("ClearingInProgress") = 1%>' Text="Complete" CommandArgument="<%# Container.DataItemIndex %>" CommandName="updatecleared" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>                       

                    </Columns>
                    <RowStyle Font-Names="Calibri"/>
                </asp:GridView>

               
                <asp:SqlDataSource ID="sdsInventoryAreas" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT Area, Status, ClearingAuditor, ClearingInProgress,ClearRequested, Building, Writer, Auditor, AreaDesc FROM Inventory.dbo.Inventory Where Status = '1' order by ClearRequested "></asp:SqlDataSource>
                </div>
            
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
