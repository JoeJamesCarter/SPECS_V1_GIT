<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HelmRcv.aspx.vb" Inherits="Barcode_HelmRcv" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Helm Receiving</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../scripts/css/bootstrap.min.css" />

</head>
<body>
    <form id="form1" runat="server" class="container w-100">

        <div class="form-group mt-2">
            <h4>
                <asp:Label ID="Label1" runat="server" Text="Helm Receiving" CssClass="mb-2"></asp:Label></h4>
        </div>

        <div class="form-row">
            <h5>
                <asp:Label ID="Label2" runat="server" Text="# M Received Today: "></asp:Label><asp:Label ID="lblHelmBuildCompTodayM" runat="server" Text=""></asp:Label></h5>
        </div>

        <div class="form-row">
            <h5>
                <asp:Label ID="Label3" runat="server" Text="# V Received Today: "></asp:Label><asp:Label ID="lblHelmBuildCompTodayV" runat="server" Text=""></asp:Label></h5>
            <p />
        </div>
        <div class="form-row">
            <h5>
                <asp:Label ID="Label5" runat="server" Text="# S Received Today: "></asp:Label><asp:Label ID="lblHelmBuildCompTodayS" runat="server" Text=""></asp:Label></h5>
            <p />
        </div>


        <div class="form-inline text-center">


            <asp:TextBox ID="tbProd" runat="server" class="mt-5"></asp:TextBox>

            <asp:Button ID="btnClear" class="btn btn-danger mt-5 ml-2" runat="server" Text="X" />

        </div>
        <div class="form=group mt-5 mb-5">
            <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="COMPLETE" />
        </div>
        <div class="form-group mt-5 text-center">

            <asp:Label ID="lblLastAction" runat="server" Text=""></asp:Label>

        </div>
    </form>

    <script src="../scripts/jquery-3.5.0.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>

</body>
</html>
