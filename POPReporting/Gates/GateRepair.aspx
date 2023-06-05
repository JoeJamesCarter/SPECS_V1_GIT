<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GateRepair.aspx.vb" Inherits="Gates_GateRepair" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gates Repair</title>
   <link href="../StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {}
        </style>    
    
    <script>
        window.onunload = function () {
            window.opener.document.getElementById('btnRefresh').click();
        }

     </script>
     
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <span class="newStyle4">Gate Repairs for Production #:
    
        </span>
    
        <asp:Label ID="lblProdNo" runat="server" Text="" CssClass="newStyle4"></asp:Label>
    
        &nbsp;&nbsp;&nbsp;
        <asp:HiddenField ID="hdnWorkstation" runat="server" />
    
        <br />
        <br />
        <span class="newStyle4">
        <br />
        Which Gates Need Repairs?<br />
        <br />
        <asp:CheckBox ID="cbBowCtr" runat="server" Font-Size="20pt" Text="Bow Center" Width="200px" />&nbsp;Notes: <asp:TextBox ID="tbBowCtrNotes" runat="server" Width="600px"></asp:TextBox><br />            
        <asp:CheckBox ID="cbPort" runat="server" Font-Size="20pt" Text="Port" Width="200px" />&nbsp;Notes: <asp:TextBox ID="tbPortNotes" runat="server" Width="600px"></asp:TextBox><br />
        <asp:CheckBox ID="cbStrb" runat="server" Font-Size="20pt" Text="Strb" Width="200px" />&nbsp;Notes: <asp:TextBox ID="tbStrbNotes" runat="server" Width="600px"></asp:TextBox><br />
        <asp:CheckBox ID="cbAftPort" runat="server" Font-Size="20pt" Text="Aft Port" Width="200px" />&nbsp;Notes: <asp:TextBox ID="tbAftPortNotes" runat="server" Width="600px"></asp:TextBox><br />
        <asp:CheckBox ID="cbAftCtr" runat="server" Font-Size="20pt" Text="Aft Center" Width="200px"/>&nbsp;Notes: <asp:TextBox ID="tbAftCtrNotes" runat="server" Width="600px"></asp:TextBox><br />
        <asp:CheckBox ID="cbAftStrb" runat="server" Font-Size="20pt" Text="Aft Strb" Width="200px"/>&nbsp;Notes: <asp:TextBox ID="tbAftStrbNotes" runat="server" Width="600px" ></asp:TextBox><br />        
        <br />
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
        <br />
        </span>
    
        <br />
        
        <span class="newStyle4">Repairs</span>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="sdsGateRepairs" CssClass="newStyle1 auto-style1" Width="100%" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                <asp:BoundField DataField="DateReq" HeaderText="Date Requested">
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="BowCtr" HeaderText="Bow Ctr">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="Port" HeaderText="Port">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="Strb" HeaderText="Strb">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="AftPort" HeaderText="Aft Port">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="AftCtr" HeaderText="Aft Ctr">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="AftStrb" HeaderText="Aft Rear">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>                
                <asp:BoundField DataField="Note" HeaderText="Notes" />
                <asp:BoundField DataField="Status" HeaderText="Status">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="StatusDate" HeaderText="Status Date">
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="ReReceived" HeaderText="Re-Rcvd">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ReReceivedDate" HeaderText="Re-Rcvd Date" >
                <ItemStyle Width="200px" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <br />
         <span class="newStyle4">Reorders</span>
        <br />
        <asp:GridView ID="GridView2" runat="server" DataSourceID="sdsGateReorders" CssClass="newStyle1 auto-style1" Width="100%" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                <asp:BoundField DataField="DateReq" HeaderText="Date Requested">
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="BowCtr" HeaderText="PF">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="Port" HeaderText="SF">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="Strb" HeaderText="PR">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="AftPort" HeaderText="SR">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="AftCtr" HeaderText="T">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="AftStrb" HeaderText="PM">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:BoundField>                
                <asp:BoundField DataField="Note" HeaderText="Notes" />
                <asp:BoundField DataField="Status" HeaderText="Status">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="StatusDate" HeaderText="Status Date">
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="ReReceived" HeaderText="Re-Rcvd">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ReReceivedDate" HeaderText="Re-Rcvd Date" >
                <ItemStyle Width="200px" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <br />
        <br />
        <br />
        <br />
        <br />
    
        <asp:Button ID="btnClose" runat="server" Text="Close" />
    
        <asp:SqlDataSource ID="sdsGateRepairs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Gates_RepairsReorders] WHERE (ProdNo = @ProdNo) and Type = 'Repair' ORDER BY [Auto]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="sdsGateReorders" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Gates_RepairsReorders] WHERE (ProdNo = @ProdNo) and Type = 'Reorder' ORDER BY [Auto]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>    
        <br />
    
    </div>
    </form>
</body>
</html>