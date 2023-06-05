<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BoatStatus.aspx.vb" Inherits="BoatStatus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .newStyle1 {
            font-family: calibri;
            font-size: 20px;
            font-weight: bold;
        }
        .newStyle2 {
            font-family: calibri;
            font-size: 16px;
            
        }
    </style>
    
      <script> 
          window.onunload = function () {
              window.opener.location.href = window.opener.location;
          }
      </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        Prod #:
    
        <asp:Label ID="lblProdNo" runat="server" Text="" CssClass="newStyle1"></asp:Label>
     &nbsp;&nbsp;&nbsp;
        <asp:HiddenField ID="hdnWorkstation" runat="server" />
    
        <asp:Button ID="btnClose" runat="server" Text="Close" />
    
        <br />
    
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatOfflineNotes" CssClass="newStyle2" Width="827px">
            <Columns>
                <asp:BoundField DataField="OfflineNote" HeaderText="Offline Note" SortExpression="Note" >
                <ItemStyle Font-Size="14pt" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" >
                <ItemStyle Font-Size="14pt" Width="150px" />
                </asp:BoundField>
                <asp:BoundField DataField="Workcenter" HeaderText="Workcenter" SortExpression="Workcenter" >
                <ItemStyle Font-Size="14pt" Width="100px"/>
                </asp:BoundField>
                <asp:TemplateField HeaderText="Clear">
                     <ItemTemplate>
                      <asp:ImageButton ID="btnClear" runat="server" ImageUrl='<%# Eval("Cleared", "./Images/cleared{0}.png")%>' CommandArgument='<%# Eval("Auto")%>' CommandName ="clearsidelineitem" />
                    </ItemTemplate>
                                     <HeaderStyle HorizontalAlign="Center" />
                     <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    
        <br />
        <span class="newStyle4">
        <asp:Label ID="lblAddNewOfflineNote" runat="server" Text="Add a Offline Note"></asp:Label>
        <br />
        <asp:TextBox ID="tbOfflineNote" runat="server" CssClass="auto-style2" Height="23px" MaxLength="300" Width="540px"></asp:TextBox>
        <br />
        <br />
        Boat is Now<br />
        <asp:RadioButtonList ID="rblBoatStatus" runat="server" SelectedValue='<%# Bind("BML_POPREPORTING_GREENLIGHTS.IsBoatOffline")%>'>
            <asp:ListItem Value="1">Offline</asp:ListItem>
            <asp:ListItem Value="0">Online</asp:ListItem>
        </asp:RadioButtonList>
        <asp:SqlDataSource ID="sdsBoatOfflineNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.Cleared, BML_POPREPORTING_OFFLINE.OfflineNote,BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date,BML_POPREPORTING_GREENLIGHTS.IsBoatOffline FROM [BML_POPREPORTING_OFFLINE] INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING_OFFLINE.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo  WHERE (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) ORDER BY [Auto]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <br />
        <asp:Button ID="btnBoatOfflineNote" runat="server" Text="Submit"/>
        </span>
    
    </div>
    </form>
 
</body>
</html>
