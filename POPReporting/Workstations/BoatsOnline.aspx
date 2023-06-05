<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BoatsOnline.aspx.vb" Inherits="Workstations_BoatsOnline" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Boats Online Today</title>
    <style type="text/css">
        .auto-style1 {
            font-family: Calibri;
        }
        .newStyle1 {
            font-family: Calibri;
        }
        .auto-style2 {
            font-weight: 700;
        }
        .auto-style3 {
            font-weight: 700;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h1><span class="newStyle1">Boats That Came Online Today:
        </span>
        <asp:Label ID="lblToday" runat="server" Text="Label" CssClass="newStyle1"></asp:Label>
        &nbsp;-
            <asp:Label ID="lblCountOnlineToday" runat="server" CssClass="auto-style1" Text="Label"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Image ID="Image1" runat="server" ImageUrl="../Images/logo-smaller.png" />
        </h1>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="auto-style1" DataKeyNames="ProdNo" DataSourceID="sdsPopReportingGreenLights" Width="972px">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" ReadOnly="True" SortExpression="ProdNo" />
                <asp:BoundField DataField="CusName" HeaderText="Customer" SortExpression="CusName" />
                <asp:BoundField DataField="ItemNo" HeaderText="Boat" SortExpression="ItemNo" />
                <asp:BoundField DataField="FramesInstalled" HeaderText="Online Date/Time" SortExpression="FramesInstalled" />
                <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="../Images/{0}.png" HeaderText="Canvas Status">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPopReportingGreenLights" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_GREENLIGHTS.ProdNo, BML_POPREPORTING_GREENLIGHTS.FramesInstalled , BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo FROM BML_POPREPORTING_GREENLIGHTS INNER JOIN BML_POPREPORTING ON BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus = @FramesInstalledStatus) AND (CONVERT (date, BML_POPREPORTING_GREENLIGHTS.FramesInstalled) = @FramesInstalled) ORDER BY BML_POPREPORTING_GREENLIGHTS.FramesInstalled">
            <SelectParameters>
                <asp:Parameter DefaultValue="2" Name="FramesInstalledStatus" Type="Int32" />
                <asp:ControlParameter ControlID="lblToday" Name="FramesInstalled" PropertyName="Text" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <br />
        <strong># Of Boats That Are Ready to Start in Frames:</strong>
        <asp:Label ID="lblReadytoStart" runat="server" CssClass="auto-style2" Text="Label"></asp:Label>
    
    &nbsp;-
        <asp:Label ID="lblios" runat="server" CssClass="auto-style3" Text="Label"></asp:Label>
&nbsp;<strong>of them are IO&#39;s.</strong></div>
    </form>
</body>
</html>
