<%@ Page Language="VB" AutoEventWireup="false" CodeFile="menu.aspx.vb" Inherits="menu" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SPECS Link Menu</title>
    <style>
        .categoryClass {
            font-family: Calibri;
            font-size: 28px;
            width: 100%;
            text-align: left;
        }

        .Limited {
            box-shadow: inset 0px 1px 3px 0px #91b8b3;
            background: linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
            background-color: #768d87;
            border-radius: 5px;
            border: 1px solid #566963;
            display: inline-block;
            cursor: pointer;
            color: #ffffff;
            font-family: Arial;
            font-size: 15px;
            font-weight: bold;
            padding: 11px 23px;
            text-decoration: none;
            text-shadow: 0px -1px 0px #2b665e;
            margin: 5px;
        }

            .Limited:hover {
                background: linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
                background-color: #6c7c7c;
            }

            .Limited:active {
                position: relative;
                top: 1px;
            }

        .Open {
            -moz-box-shadow: inset 0px 1px 3px 0px #3dc21b;
            -webkit-box-shadow: inset 0px 1px 3px 0px #3dc21b;
            box-shadow: inset 0px 1px 3px 0px #3dc21b;
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #2f7a43), color-stop(1, #5cbf2a));
            background: -moz-linear-gradient(top, #2f7a43 5%, #5cbf2a 100%);
            background: -webkit-linear-gradient(top, #2f7a43 5%, #5cbf2a 100%);
            background: -o-linear-gradient(top, #2f7a43 5%, #5cbf2a 100%);
            background: -ms-linear-gradient(top, #2f7a43 5%, #5cbf2a 100%);
            background: linear-gradient(to bottom, #2f7a43 5%, #5cbf2a 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#2f7a43', endColorstr='#5cbf2a',GradientType=0);
            background-color: #2f7a43;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            border: 1px solid #18ab29;
            display: inline-block;
            cursor: pointer;
            color: #ffffff;
            font-family: Arial;
            font-size: 15px;
            font-weight: bold;
            padding: 11px 23px;
            text-decoration: none;
            text-shadow: 0px -1px 0px #2f6627;
            margin: 5px;
            &:hover

        {
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5cbf2a), color-stop(1, #2f7a43));
            background: -moz-linear-gradient(top, #5cbf2a 5%, #2f7a43 100%);
            background: -webkit-linear-gradient(top, #5cbf2a 5%, #2f7a43 100%);
            background: -o-linear-gradient(top, #5cbf2a 5%, #2f7a43 100%);
            background: -ms-linear-gradient(top, #5cbf2a 5%, #2f7a43 100%);
            background: linear-gradient(to bottom, #5cbf2a 5%, #2f7a43 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#5cbf2a', endColorstr='#2f7a43',GradientType=0);
            background-color: #5cbf2a;
        }

        &:active {
            position: relative;
            top: 1px;
        }
    </style>
      
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="SPECSLINKS" runat="server" Text="Label" CssClass="categoryClass">SPECS LINKS - </asp:Label>
        
        <asp:Label ID="lbl2" runat="server" Text="Label" CssClass="categoryClass">Grey is Limited Access, Green is Read Only and Open.</asp:Label>
        <br />
        <br />
        <div>
            <asp:PlaceHolder ID="phGreenlights" runat="server"></asp:PlaceHolder>
                        
            </div>
    </form>
</body>
</html>
