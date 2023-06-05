<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BoatNotes.aspx.vb" Inherits="BoatNotes" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <link href="StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {}
        .auto-style2 {}
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
    
        <span class="newStyle4">Notes for Production #:
    
        </span>
    
        <asp:Label ID="lblProdNo" runat="server" Text="" CssClass="newStyle4"></asp:Label>
    
        &nbsp;&nbsp;&nbsp;
        <asp:HiddenField ID="hdnWorkstation" runat="server" />
    
        <asp:Button ID="btnClose" runat="server" Text="Close" />
    
        <br />
        <br />
        <span class="newStyle4">
        <asp:Label ID="lblAddNewNote" runat="server" Text="Add a New Note"></asp:Label>
        <br />
        <asp:TextBox ID="tbNote" runat="server" CssClass="auto-style2" Height="23px" MaxLength="300" Width="540px"></asp:TextBox>
        <br />
        Which workstations does this note affect?<asp:CheckBoxList ID="cblCreatedFor" runat="server" CssClass="newStyle1" Height="59px" RepeatColumns="4" RepeatDirection="Horizontal" Width="667px">
            <asp:ListItem Value="None">None</asp:ListItem>
            <asp:ListItem Value="BuildOptions">Build Options</asp:ListItem>
            <asp:ListItem Value="Centertube">Center Tubes</asp:ListItem>            
            <asp:ListItem>Covers</asp:ListItem>
            <asp:ListItem>Fiberglass</asp:ListItem>
            <asp:ListItem>Final</asp:ListItem>
            <asp:ListItem>Floors</asp:ListItem>
            <asp:ListItem>Frames</asp:ListItem>
            <asp:ListItem Value="Furniture">Furniture Install</asp:ListItem>
            <asp:ListItem Value="FurniturePrep">Furniture Prep</asp:ListItem>
            <asp:ListItem Value="Gauge">Gauges</asp:ListItem>
            <asp:ListItem Value="Harness">Harnesses</asp:ListItem>
            <asp:ListItem>Helms</asp:ListItem>
            <asp:ListItem Value="HelmBuild">Helm - Build</asp:ListItem>
            <asp:ListItem Value="HelmKitting">Helm - Kitting</asp:ListItem>
            <asp:ListItem>Inspection</asp:ListItem>
            <asp:ListItem>Kitting</asp:ListItem>
            <asp:ListItem Value="Rails">Rails Install</asp:ListItem>
            <asp:ListItem Value="RailsPrep">Rails Prep</asp:ListItem>
            <asp:ListItem>Sharkhide</asp:ListItem>
            <asp:ListItem>Shrinkwrap</asp:ListItem>
            <asp:ListItem>Tubes</asp:ListItem>
            <asp:ListItem>Wavetamer</asp:ListItem>
        </asp:CheckBoxList>
        <asp:Button ID="btnBoatNote" runat="server" Text="Submit" />
        <br />
        </span>
    
        <br />      
    
        
        <asp:GridView ID="gvCleared" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatNotesCleared" CssClass="newStyle1 auto-style1" Width="100%" Caption="Cleared">
            <Columns>
                <asp:BoundField DataField="Note" HeaderText="Note" SortExpression="Note" />
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                <asp:BoundField DataField="Workstation" HeaderText="Created By" SortExpression="Workstation" >
                <ItemStyle/>
                </asp:BoundField>
                <asp:BoundField DataField="CreatedFor" HeaderText="Created For" SortExpression="CreatedFor" />
                <asp:BoundField DataField="ResolvedBy" HeaderText="Cleared By" />
                <asp:BoundField DataField="ResolvedDate" HeaderText="Date Cleared"/>               
            </Columns>            
        </asp:GridView>
        <asp:SqlDataSource ID="sdsBoatNotesCleared" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [Note], [Workstation], [Date], [CreatedFor], [Auto], [Resolved], [ResolvedBy], [ResolvedDate] FROM [BML_POPREPORTING_NOTES] WHERE ([ProdNo] = @ProdNo) and Resolved = 1 ORDER BY [Auto]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    <br />

          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatNotes" CssClass="newStyle1 auto-style1" Width="100%"  Caption="Open">
            <Columns>
                <asp:BoundField DataField="Note" HeaderText="Note" SortExpression="Note" />
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                <asp:BoundField DataField="Workstation" HeaderText="Created By" SortExpression="Workstation" >
                <ItemStyle/>
                </asp:BoundField>
                <asp:BoundField DataField="CreatedFor" HeaderText="Created For" SortExpression="CreatedFor" />
                <asp:BoundField DataField="ResolvedBy" HeaderText="Cleared By" />
                <asp:BoundField DataField="ResolvedDate" HeaderText="Date Cleared"/>
                <asp:TemplateField HeaderText="Mark Resolved">
                    <ItemTemplate>
                        <asp:Button ID="btnMarkResolved" runat="server" Text="Mark Resolved" CommandArgument='<%# Eval("Auto")%>' CommandName = "gotoMarkResolved"/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>            
        </asp:GridView>
        <asp:SqlDataSource ID="sdsBoatNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [Note], [Workstation], [Date], [CreatedFor], [Auto], [Resolved], [ResolvedBy], [ResolvedDate] FROM [BML_POPREPORTING_NOTES] WHERE ([ProdNo] = @ProdNo) and Resolved is Null ORDER BY [Auto]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>