<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Repair.aspx.vb" Inherits="Rails_Repair" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Repair</title>
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
    
        <span class="newStyle4">Repairs for Production #:
    
        </span>
    
        <asp:Label ID="lblProdNo" runat="server" Text="" CssClass="newStyle4"></asp:Label>
    
        &nbsp;&nbsp;&nbsp;
        <asp:HiddenField ID="hdnWorkstation" runat="server" />
    
        <br />
        <br />
        <span class="newStyle4">
        <br />
        Which Rails Need Repairs?<br />
        <br />
        <asp:CheckBox ID="cbPF" runat="server" Font-Size="20pt" Text="PF" Width="100px" />&nbsp;Notes: <asp:TextBox ID="tbPFNotes" runat="server" Width="600px"></asp:TextBox><br />            
        <asp:CheckBox ID="cbSF" runat="server" Font-Size="20pt" Text="SF" Width="100px" />&nbsp;Notes: <asp:TextBox ID="tbSFNotes" runat="server" Width="600px"></asp:TextBox><br />
        <asp:CheckBox ID="cbPR" runat="server" Font-Size="20pt" Text="PR" Width="100px" />&nbsp;Notes: <asp:TextBox ID="tbPRNotes" runat="server" Width="600px"></asp:TextBox><br />
        <asp:CheckBox ID="cbSR" runat="server" Font-Size="20pt" Text="SR" Width="100px" />&nbsp;Notes: <asp:TextBox ID="tbSRNotes" runat="server" Width="600px"></asp:TextBox><br />
        <asp:CheckBox ID="cbT" runat="server" Font-Size="20pt" Text="T" Width="100px" />&nbsp;Notes: <asp:TextBox ID="tbTNotes" runat="server" Width="600px"></asp:TextBox><br />
        <asp:CheckBox ID="cbPM" runat="server" Font-Size="20pt" Text="PM" Width="100px"/>&nbsp;Notes: <asp:TextBox ID="tbPMNotes" runat="server" Width="600px" ></asp:TextBox><br />
        <asp:CheckBox ID="cbSM" runat="server" Font-Size="20pt" Text="SM" Width="100px"/>&nbsp;Notes: <asp:TextBox ID="tbSMNotes" runat="server" Width="600px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
        <br />
        </span>
    
        <br />
        
        <span class="newStyle4">Repairs</span>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="sdsRailRepairs" CssClass="newStyle1 auto-style1" Width="1000px" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                <asp:BoundField DataField="DateReq" HeaderText="Date Requested">
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="PF" HeaderText="PF">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="SF" HeaderText="SF">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="PR" HeaderText="PR">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="SR" HeaderText="SR">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="T" HeaderText="T">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="PM" HeaderText="PM">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="SM" HeaderText="SM">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
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
        <asp:GridView ID="GridView2" runat="server" DataSourceID="sdsRailsReorders" CssClass="newStyle1 auto-style1" Width="1000px" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" />
                <asp:BoundField DataField="DateReq" HeaderText="Date Requested">
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="PF" HeaderText="PF">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="SF" HeaderText="SF">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="PR" HeaderText="PR">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="SR" HeaderText="SR">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="T" HeaderText="T">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="PM" HeaderText="PM">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:BoundField>
                <asp:BoundField DataField="SM" HeaderText="SM">
                <ItemStyle HorizontalAlign="Center" Width="20px" />
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
    
        <asp:SqlDataSource ID="sdsRailRepairs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [PF], [SF], [PR], [SR], [T], [PM], [SM], [Note], [DateReq], [Status], [StatusDate], [ReReceived], [ReReceivedDate] FROM [Rails_RepairsReorders] WHERE (ProdNo = @ProdNo) and Type = 'Repair' ORDER BY [Auto]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="sdsRailsReorders" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [PF], [SF], [PR], [SR], [T], [PM], [SM], [Note], [DateReq], [Status], [StatusDate], [ReReceived], [ReReceivedDate] FROM [Rails_RepairsReorders] WHERE (ProdNo = @ProdNo) and Type = 'Reorder' ORDER BY [Auto]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
         <asp:SqlDataSource ID="sdsRailsNeeded" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [NeedsTransom], [NeedsPortMid], [NeedsStrbMid] FROM [Rails_Tracking] WHERE (Rails_Tracking.ProdNo = @ProdNo) ORDER BY [Auto]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
    
    </div>
    </form>
</body>
</html>