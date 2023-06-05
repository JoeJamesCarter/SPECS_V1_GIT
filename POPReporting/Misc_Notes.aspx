<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Misc_Notes.aspx.vb" Inherits="Misc_Notes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Misc Note</title>
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
        <asp:Button ID="btnClose" runat="server" Text="Close" />
    
        <br />
    
        <br />
          <span class="newStyle4">
        <asp:Label ID="lblAddNewMiscNote" runat="server" Text="ADD A NOTE TO THE OFFLINE PAGE THAT IS NOT PROD # SPECIFIC: (ie. Low on QX Logos)"></asp:Label>
        <br />
        <asp:TextBox ID="tbMiscNote" runat="server" CssClass="auto-style2" Height="23px" MaxLength="300" Width="540px"></asp:TextBox>
           <br />
           <br />
        <asp:Button ID="btnBoatMiscNote" runat="server" Text="Submit"/>
              <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatMiscNotes" CssClass="newStyle2" Width="827px" Caption="Misc Note History">
            <Columns>
                <asp:BoundField DataField="Note" HeaderText="Misc Note" SortExpression="Note" >
                <ItemStyle Font-Size="14pt" Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" >
                <ItemStyle Font-Size="14pt" Width="100px" />
                </asp:BoundField>
                 <asp:BoundField DataField="ETA" HeaderText="ETA"  >
                <ItemStyle Font-Size="14pt" Width="224px" HorizontalAlign="Center"/>
                </asp:BoundField>                 
                 <asp:BoundField DataField="ETADate" HeaderText="ETA Entered">
                <ItemStyle Font-Size="14pt" Width="250px" HorizontalAlign="Center"/>
                </asp:BoundField>                        
                <asp:TemplateField HeaderText="Clear">
                     <ItemTemplate>
                      <asp:ImageButton ID="btnClear" runat="server" ImageUrl='<%# Eval("Cleared", "./Images/cleared{0}.png")%>' CommandArgument='<%# Eval("Auto")%>' CommandName ="clearmiscnote" />
                    </ItemTemplate>
                                     <HeaderStyle HorizontalAlign="Center" />
                     <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    
        <br />
      
        <br />
        <br />
      
        <asp:SqlDataSource ID="sdsBoatMiscNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT MISC_NOTES.Auto, MISC_NOTES.Note, MISC_NOTES.Date, MISC_NOTES.Cleared,MISC_NOTES.DateCleared, MISC_NOTES.ETA,MISC_NOTES.ETADate FROM [MISC_NOTES] ORDER BY [Auto]">
           
        </asp:SqlDataSource>
    
     
        </span>
    
    </div>
    </form>
 
</body>
</html>
