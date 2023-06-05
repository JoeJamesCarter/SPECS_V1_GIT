<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BoatsCompleted.aspx.vb" Inherits="Workstations_BoatsCompleted" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Boats Completed Today</title>
    <style type="text/css">
        .auto-style1 {
            font-family: Calibri;
        }
        .newStyle1 {
            font-family: Calibri;
        }
    </style>
</head>
  
<body>
    <form id="form1" runat="server">
    <div>
    
        <h1><span class="newStyle1">Boats That Complete Today:
        <asp:Label ID="lblToday" runat="server" Text="Label" CssClass="newStyle1"></asp:Label></h1></span>
            <br />
            <asp:GridView ID="GridView1" runat="server" DataKeyNames="ProdNo" CssClass="auto-style1" DataSourceID="sdsPOPREPORTING_GREENLIGHTS" AutoGenerateColumns="False" Width="1235px">
                <Columns>
                    <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Boat" SortExpression="ItemNo" />
                    <asp:BoundField DataField="CusName" HeaderText="Customer" SortExpression="CusName" />
                    <asp:BoundField DataField="FramesInstalled" HeaderText="Started" SortExpression="FramesInstalled" />
                    <asp:BoundField DataField="Complete" HeaderText="Complete" SortExpression="Complete" />
                    <asp:BoundField DataField="Minutes" HeaderText="Minutes Between" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsPOPREPORTING_GREENLIGHTS" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, BML_POPREPORTING_GREENLIGHTS.Complete, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, DateDiff(minute,FramesInstalled,Complete) as Minutes FROM BML_POPREPORTING_GREENLIGHTS INNER JOIN BML_POPREPORTING ON BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) AND (CONVERT (date, BML_POPREPORTING_GREENLIGHTS.Complete) = @Complete) ORDER BY BML_POPREPORTING_GREENLIGHTS.Complete">
                <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="CompleteStatus" Type="Int32" /> 
                    <asp:ControlParameter ControlID="lblToday" Name="Complete" PropertyName="Text" Type="DateTime" />                  
                </SelectParameters>
            </asp:SqlDataSource>
        </h1>
    
    </div>
    </form>
</body>
</html>
