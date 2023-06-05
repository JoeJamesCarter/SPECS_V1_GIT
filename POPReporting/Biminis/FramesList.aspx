<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FramesList.aspx.vb" Inherits="Biminis_FramesList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Maintain List of Bimini Frames for Inventory</title>
   <style>
       .FrameList {
           font-family:Calibri;
           font-size:20px;
       }
       .title {
           font-family:Calibri;
           font-size:30px;
           font-weight:bold;
       }
       #left {
           width:700px;
           float:left;
       }
       #right {
           margin-left:50px;
           margin-top:50px;
           width:474px;
           float:left;
       }
   </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="left">
         <asp:Image runat="server" img src="../Images/logo-small.png" /></asp:Image><br />

        <asp:Label ID="Label1" runat="server" CssClass="title" Text="Maintain the List of Frames You Can Select When Adding Inventory"></asp:Label><br />
        <br />
        <asp:GridView ID="gvBimFrames" runat="server" CssClass="FrameList" AutoGenerateColumns="False" DataKeyNames="FrameDesc" DataSourceID="sdsBimFrames" AllowSorting="True" CellPadding="2" CellSpacing="2">
            <Columns>
                <asp:CommandField ShowDeleteButton="False" ShowEditButton="True" />
                <asp:BoundField DataField="FrameDesc" HeaderText="Frame" ReadOnly="true" SortExpression="FrameDesc" >
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="FrameLongDesc" HeaderText="Frame Long Desc" SortExpression="FrameLongDesc" >
                <ItemStyle Width="300px" />
                </asp:BoundField>               
                <asp:BoundField DataField="Disable" HeaderText="Disabled = 1 Enabled = 0" SortExpression="Disable" >              
                <ItemStyle Width="120px" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        </div>
        <asp:SqlDataSource ID="sdsBimFrames" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" InsertCommand="INSERT INTO [Biminis_FramesList] ([FrameDesc], [FrameLongDesc], [Disable]) VALUES (@FrameDesc, @FrameLongDesc, @Disable)" SelectCommand="SELECT [FrameDesc], [FrameLongDesc], [Disable] FROM [Biminis_FramesList]" UpdateCommand="UPDATE [Biminis_FramesList] SET [FrameLongDesc] = @FrameLongDesc, [Disable] = @Disable WHERE [FrameDesc] = @FrameDesc"></asp:SqlDataSource>
        <div id="right">
            <asp:Label ID="Label2" runat="server" CssClass="title" Text="Add A New Frame"></asp:Label><br />
        <asp:DetailsView ID="DetailsView1" CssClass="FrameList"  runat="server" DataSourceID="sdsBimFrames" Height="68px" Width="368px">
            <Fields>
                <asp:CommandField ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
    </div6
    </form>
</body>
</html>
