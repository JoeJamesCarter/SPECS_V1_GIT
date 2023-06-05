<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ExpandedBOM.aspx.vb" Inherits="PhyInv_ExpandedBOM" MaintainScrollPositionOnPostback="true" EnableEventValidation="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PHY INV WIP</title>
    <style type="text/css">
        .newStyle1 {
            float: left;
            font-family: calibri;
            font-size: 14px;
            margin-left: 20px;
            text-align: center;
        }

        .newStyle2 {
            float: left;
            font-family: calibri;
            font-size: 20px;
        }

        .newStyle3 {
            float: left;
            font-family: calibri;
            color: green;
            font-size: 20px;
            margin-left: 4px;
            font-weight: bold;
            vertical-align: top;
        }

        .desc {
            font-family: calibri;
            font-size: 16px;
            font-weight: bold;
            color: blue;
        }

        .qty {
            font-family: calibri;
            font-size: 16px;
        }

        .partno {
            font-family: calibri;
            font-size: 16px;
        }

        .green {
            background-color: green;
            height: 70px;
            width: 70px;
        }

        .white {
            background-color: white;
            height: 70px;
            width: 70px;
        }


        #title {
            width: 100%;
            height: 30px;
            font-family: Calibri;
            font-size: 26px;
            font-weight: bold;
        }


        #col1 {
            width: 95%;
            float: left;
        }

        #exploded {
        }

        #gvAllLevels {
            width: 100%;
            font-family: Calibri;
            font-size: 16px;
            text-wrap: normal;
            text-align: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="gvSOLines" runat="server" CssClass="newStyle1" Caption="SO Lines">
            </asp:GridView>

            <asp:HiddenField ID="hdnSONo" runat="server" />
            <asp:HiddenField ID="hdnSONoSkip2LeadingZeros" runat="server" />
            <asp:HiddenField ID="hdnBoatYear" runat="server" />

            <div id="title">
                <asp:Label ID="Label3" runat="server" Text="Expanded BOM Prod #:"></asp:Label>
                <asp:Label ID="lblProdNo" runat="server" Text=""></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;Search For:
                <asp:TextBox ID="tbSearch" runat="server"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" />


                &nbsp;&nbsp;&nbsp;&nbsp;Or Filter To:
                <asp:TextBox ID="tbFilter" runat="server"></asp:TextBox>
                <asp:Button ID="btnFilter" runat="server" Text="Filter" />
                &nbsp;# Found:
               <asp:Label ID="lblCountOfFound" runat="server" Text="Label"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnClearSearch" runat="server" Text="Clear Search" />
            </div>

            <div id="col1">
                <div id="exploded">
                    <asp:GridView ID="gvAllLevels" runat="server" CssClass="newStyle1" Caption="All Levels"></asp:GridView>
                    <asp:GridView ID="gvComponents2" runat="server" CssClass="newStyle1" Caption="Level 2" Visible="false"></asp:GridView>
                    <asp:GridView ID="gvComponents3" runat="server" CssClass="newStyle1" Caption="Level 3" Visible="false"></asp:GridView>
                    <asp:GridView ID="gvComponents4" runat="server" CssClass="newStyle1" Caption="Level 4" Visible="false"></asp:GridView>
                    <asp:GridView ID="gvComponents5" runat="server" CssClass="newStyle1" Caption="Level 5" Visible="false"></asp:GridView>
                    <asp:GridView ID="gvComponents6" runat="server" CssClass="newStyle1" Caption="Level 6" Visible="false"></asp:GridView>
                    <asp:GridView ID="gvComponents7" runat="server" CssClass="newStyle1" Caption="Level 7" Visible="false"></asp:GridView>
                </div>
            </div>


        </div>
    </form>
</body>
</html>
