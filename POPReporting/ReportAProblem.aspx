<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReportAProblem.aspx.vb" Inherits="ReportAProblem" Debug="True"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #TextArea1 {
            height: 182px;
            width: 321px;
        }
        .newStyle1 {
            font-family: Calibri;
            font-size: 18px;
        }
        #tbRequest {
            height: 182px;
            width: 327px;
        }
        #tbproblemrequest {
            height: 184px;
            width: 467px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <span class="newStyle1">Use this form to send a message to the SPECS Developer.<br />
        You can use it to report options that you want to see on your page,<br />
        Ideas for improving the system, etc.<br />
        <br />
        Your Name:&nbsp; </span><asp:TextBox ID="tbRequestor" runat="server" Height="16px" Width="229px"></asp:TextBox>
        <span class="newStyle1">&nbsp;<br />
        <asp:HiddenField ID="hdnSONo" runat="server" />
        <asp:HiddenField ID="hdnProdNo" runat="server" />
        <asp:HiddenField ID="hdnworkstationurl" runat="server" />
        Which Greenlight or Workstation Page(s) Does this Request Apply To? (example: Furniture Greenlight, Furiture Install, History, Overview etc.)<br />
        <asp:TextBox ID="tbPages" runat="server" Height="20px" Width="609px"></asp:TextBox>
        <br />
        Request/Problem:
        <br />
        </span>
        <asp:TextBox ID="tbproblem" runat="server" Height="16px" Width="811px"></asp:TextBox>
        <br />
        <br />
&nbsp;<asp:Button ID="btnSend" runat="server" Text="Send" />
    </div>
    </form>
</body>
</html>
