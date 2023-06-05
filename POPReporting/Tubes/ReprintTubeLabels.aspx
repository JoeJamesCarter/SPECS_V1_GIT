<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReprintTubeLabels.aspx.vb" Inherits="Tubes_ReprintTubeLabels" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>REPRINT TUBE LABELS</title>
      <link href="../StyleSheet.css" rel="stylesheet" />    
    <style type="text/css">
        #top {
            width:617px;
            text-align:center;
            padding-bottom:6px;
        }
        #left {
            width:574px;
            float:left;
            border-style:solid;
            padding:20px;            
        }
       
        #right {
            width:425px;
            border-style:solid;             
            float:left;
             padding:20px;
             margin-left:20px;
        }
        .auto-style2 {
            height: 530px;
        }      
        .auto-style3 {}
        </style>
</head>
<body class="auto-style2">
    <form id="form1" runat="server">
        <div id="top">
        <asp:Label ID="Label7" runat="server" Text="REPRINT TUBE LABELS" CssClass="newStyle7"></asp:Label>
            </div>
    <div id="left">
        <span class="newStyle7"><asp:Label ID="Label1" runat="server" Text="Production/Reruns/Customer Service"></asp:Label>
        <br />
        </span>

        <span class="newStyle1">
        <br />
        <strong>     
      
        <asp:Label ID="Label2" runat="server" Text="Prod # (7 digits) or CS #"></asp:Label>
        </strong>:&nbsp;
        <asp:TextBox ID="tbProdNo" runat="server" MaxLength="7"></asp:TextBox> &nbsp;&nbsp; <asp:Button ID="btnClear" runat="server" Font-Bold="True" Text="Clear Fields" Height="30px" />
        &nbsp;
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ex. 1900062&nbsp; or 45<br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Tube:" style="font-weight: 700"></asp:Label>        
        <asp:RadioButtonList ID="rblTube" runat="server" RepeatDirection="Horizontal" Height="23px" Width="274px">
            <asp:ListItem>Port</asp:ListItem>
            <asp:ListItem>Strb</asp:ListItem>
            <asp:ListItem>Ctr</asp:ListItem>
        </asp:RadioButtonList>
        <br />
        <asp:Label ID="Label4" runat="server" Text="# Sections:" style="font-weight: 700"></asp:Label>
        <br />
        <asp:CheckBoxList ID="cblSections" runat="server" RepeatDirection="Horizontal" Width="341px">
            <asp:ListItem Value="F">Front</asp:ListItem>
            <asp:ListItem Value="M">Mid</asp:ListItem>
            <asp:ListItem Value="M2">Mid 2</asp:ListItem>
            <asp:ListItem Value="R">Rear</asp:ListItem>
        </asp:CheckBoxList>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Printer:" style="font-weight: 700"></asp:Label>
        <br />
        <asp:DropDownList ID="ddlPrinters" runat="server">
            <asp:ListItem>   </asp:ListItem>
           <asp:ListItem Value="10.54.80.17">Blue Roller</asp:ListItem>         
           <asp:ListItem Value="10.54.80.18">Green Roller</asp:ListItem>
           <asp:ListItem Value="10.54.80.20">Tube&#39;s Printer</asp:ListItem>
           <asp:ListItem Value="10.54.80.86">Keri&#39;s Printer</asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <asp:Label ID="Label8" runat="server" Text="Type of Tube:" style="font-weight: 700"></asp:Label>
        &nbsp;&nbsp;
        <asp:DropDownList ID="ddlTubeType" runat="server">
            <asp:ListItem Value="prod">Production</asp:ListItem>
            <asp:ListItem Value="rerun">Rerun</asp:ListItem>
            <asp:ListItem Value="custserv">Customer Service</asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <asp:Button ID="btnPrint" runat="server" Font-Bold="True" Height="33px" Text="Print" Width="115px" />
        <br />
        <br />
        <hr />
        <br />
        <span class="newStyle7"><asp:Label ID="Label9" runat="server" Text="Build Instructions"></asp:Label>&nbsp;</span><br />
        Click once and wait please.<br />
        <br />
        <asp:Button ID="btnPrintBuildSchedule" runat="server" Font-Bold="True" Height="33px" Text="Print Build Instructions - Outers" Width="229px" CssClass="auto-style3" />
        &nbsp;<br />
        <br />
            <asp:Button ID="btnPrintBuildScheduleCenters" runat="server" Font-Bold="True" Height="33px" Text="Print Build Instructions - Centers" Width="229px" CssClass="auto-style3" />
        
            </span>
    </div>
  
            </form>
</body>
</html>
