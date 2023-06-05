<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Canvas.aspx.vb" Inherits="Barcode_Canvas" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Canvas Receiving</title>
    <style>
        #barcodescanner {
        font-family:Calbri;
        font-size:70px;
        width:1000px;
        text-align:center;        
        }

    </style>
    <link href="../StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="barcodescanner">
        <asp:Label ID="Label1" runat="server" Text="Canvas Receiving" Font-Size="40px" CssClass="newStyle6"></asp:Label> <br />
               
        <asp:Label ID="Label2" runat="server" CssClass="newStyle7" Text="Scan once to return the canvas color from the order."></asp:Label>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Tap receive if it matches and RGA if it doesn't." CssClass="newStyle7"></asp:Label>
        <br />
        <br />
        &nbsp;&nbsp;<asp:TextBox ID="tbProd" runat="server" Font-Size="60px" Height="144px" Width="463px" style="text-align: center"></asp:TextBox>
        &nbsp;
        <asp:Button ID="btnClear" runat="server" Font-Size="30px" Height="90px" style="margin-top: 0px" Text="X" Width="92px" />
        <br />
        <span class="newStyle7">Last Scan:</span><asp:Label ID="lblProdNo" runat="server" Text="" CssClass="newStyle7"></asp:Label> <span class="newStyle7">&nbsp;Ordered:</span> <asp:Label ID="lblCanvasColor" runat="server" Text="" CssClass="newStyle7"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblRGAColor" runat="server" CssClass="newStyle7" Text="Came In Incorrectly As:"></asp:Label>
<asp:DropDownList ID="ddlDistinctCanvas" runat="server" DataSourceID="sdsDistinctCanvas" DataTextField="Option_Desc" DataValueField="Option_Desc" AppendDataBoundItems="True" CssClass="newStyle7" AutoPostBack="True">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem>Other Problem</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:Label ID="lblOtherProblem" runat="server" CssClass="newStyle7" Text="Other Problem: "></asp:Label><asp:TextBox ID="tbOtherProblem" runat="server" CssClass="newStyle6" Width="541px" Height="67px" AutoPostBack="True"></asp:TextBox>
        <asp:SqlDataSource ID="sdsDistinctCanvas" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Distinct [Option_Desc] FROM [BML_POPREPORTINGFABOPTIONS] WHERE (([Workcenter] = @Workcenter) AND ([Option_Desc] LIKE @Option_Desc + '%'))">
            <SelectParameters>
                <asp:Parameter DefaultValue="Tops" Name="Workcenter" Type="String" />
                <asp:Parameter DefaultValue="CANVAS" Name="Option_Desc" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        <asp:Button ID="btnRGA" runat="server" Text="RGA" Height="159px" Width="654px" Font-Size="30pt" />
        <br />
        <br />
        <asp:Button ID="btnRcv" runat="server" Text="RECEIVE" Height="159px" Width="654px" Font-Size="30pt" />
        <br />
        <asp:Button ID="btnSubmitRGA" runat="server" Text="Submit RGA" Height="159px" Width="654px" Font-Size="30pt" />
        <br />
        <asp:HiddenField ID="hdnColorShouldBe" runat="server" />
        <asp:Label ID="lbl2" runat="server" CssClass="newStyle7" Text="Last Action:"></asp:Label>
&nbsp;<asp:Label ID="lblLastActionProd" runat="server" CssClass="newStyle7"></asp:Label>
&nbsp;<asp:Label ID="lblLastActionResult" runat="server" CssClass="newStyle7"></asp:Label>
    </div>
    </form>
</body>
</html>
