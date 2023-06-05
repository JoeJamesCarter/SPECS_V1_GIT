<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Tracking.aspx.vb" Inherits="Wellness_Tracking" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bennington Push Up Challenge</title>
    
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {}
        .auto-style2 {}

        #left {
        width:883px;
        float:left;
        }
        #right {
            width:500px;
            float:left;
        }
        .auto-style3 {
            width: 1527px;
        }
    </style>
    </head>
<body class="auto-style3">
    <form id="form1" runat="server">
    <div id="left" class="newStyle6">
        <asp:Label ID="Label5" runat="server" CssClass="newStyle7" Text="BENNINGTON HOURLY PUSHUP CHALLENGE"></asp:Label>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnRefresh" runat="server" CssClass="newStyle4" Text="REFRESH" />
        <br />
        <asp:Label ID="Label6" runat="server" CssClass="newStyle6" Text="Begins 8/1/19 - Goal : Build up your endurance for a friendly competition at the end of the month."></asp:Label><br />
        <asp:Label ID="Label7" runat="server" CssClass="newStyle6" Text="Date/Location: TBD. 2 rounds so that everyone can play - 1. Knees vs Knees. 2. Feet vs Feet. ;-)"></asp:Label><br />
        <asp:Label ID="Label8" runat="server" CssClass="newStyle6" Text="Anyone can play. Share this link with other Benni's if you wish."></asp:Label>
        <br />
        <asp:Button ID="btnBrandie" runat="server" Text="Brandie" />
&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnChristy" runat="server" Text="Christy" />
&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnJim" runat="server" Text="Jim" />
&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnKeri" runat="server" Text="Keri" />
&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnKristin" runat="server" Text="Kristin" />
&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnMartin" runat="server" Text="Martin" />
        &nbsp;&nbsp;&nbsp;
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" CssClass="newStyle6" Text="Person: " Width="100px"></asp:Label><asp:TextBox ID="tbUser" runat="server" CssClass="newStyle7" Width="314px"></asp:TextBox>
        <br />
        <br />
        Date Completed:<asp:Calendar ID="calDateCompleted" runat="server"></asp:Calendar>
        <br />
        <br /><asp:Label ID="Label4" runat="server" CssClass="newStyle6" Text="Exercise: " Width="100px"></asp:Label>
        <asp:DropDownList ID="ddlExercise" runat="server">
            <asp:ListItem>PUSH UPS</asp:ListItem>
        </asp:DropDownList>
        <br />     
        <br />
        <asp:Label ID="Label2" runat="server" CssClass="newStyle6" Text="Between: " Width="100px"></asp:Label>
        <asp:DropDownList ID="ddlHourRange" runat="server" CssClass="newStyle6" Height="29px">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem Value="5a6a">5am - 6am</asp:ListItem>
            <asp:ListItem Value="6a7a">6am - 7am</asp:ListItem>
            <asp:ListItem Value="7a8a">7am - 8am</asp:ListItem>
            <asp:ListItem Value="8a9a">8am - 9am</asp:ListItem>
            <asp:ListItem Value="9a10a">9am - 10am</asp:ListItem>
            <asp:ListItem Value="10a11a">10am - 11am</asp:ListItem>
            <asp:ListItem Value="11a12p">11am - 12pm</asp:ListItem>
            <asp:ListItem Value="12p1p">12pm - 1pm</asp:ListItem>
            <asp:ListItem Value="1p2p">1pm - 2pm</asp:ListItem>
            <asp:ListItem Value="2p3p">2pm - 3pm</asp:ListItem>
            <asp:ListItem Value="3p4p">3pm - 4pm</asp:ListItem>
            <asp:ListItem Value="4p5p">4pm - 5pm</asp:ListItem>
            <asp:ListItem Value="5p6p">5pm - 6pm</asp:ListItem>
            <asp:ListItem Value="6p7p">6pm - 7pm</asp:ListItem>
            <asp:ListItem Value="7p8p">7pm - 8pm</asp:ListItem>
            <asp:ListItem Value="8p9p">8pm - 9pm</asp:ListItem>
            <asp:ListItem Value="9p10p">9pm - 10pm</asp:ListItem>
            <asp:ListItem Value="10p11p">10pm - 11pm</asp:ListItem>
            <asp:ListItem Value="11p12a">Why Are You Doing Pushups at Midnight?</asp:ListItem>            
        </asp:DropDownList>
       
        <br />
        <br />
       
        <asp:Label ID="Label1" runat="server" CssClass="newStyle6" Text="Qty: " Width="100px"></asp:Label>
        <asp:TextBox ID="tbQty" runat="server" CssClass="newStyle6" Height="29px" TextMode="Number" Width="63px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnSave" runat="server" CssClass="newStyle6" Text="Save" />
        <br />
        <br />
        My Progress Today:&nbsp;&nbsp;
        <asp:Label ID="lblDailyTotal" runat="server" CssClass="newStyle4"></asp:Label>
        <br />
        <asp:GridView ID="gvMyProgressToday" runat="server" AutoGenerateColumns="False" CssClass="auto-style2" DataKeyNames="autoID" DataSourceID="sdsByUserToday" Width="609px" ShowFooter="False">
            <Columns>
                <asp:BoundField DataField="username" HeaderText="Person" SortExpression="username" />
                <asp:BoundField DataField="datecompleted" HeaderText="Date Completed" SortExpression="datecompleted" DataFormatString="{0:d}" />
                <asp:BoundField DataField="hour" HeaderText="Hour" SortExpression="hour" />
                <asp:BoundField DataField="qty" HeaderText="Qty" SortExpression="qty">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsByUserToday" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Wellness] WHERE [username] = @username AND datecompleted = CONVERT(char(10), GetDate(),126) order by datelogged">
            <SelectParameters>
                <asp:ControlParameter ControlID="tbUser" Name="username" PropertyName="Text" Type="String" />                
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        My Progress History:&nbsp; <asp:Label ID="lblHistoryTotal" runat="server" CssClass="newStyle4"></asp:Label>
        <br />
        <asp:GridView ID="gvUserProgress" runat="server" AutoGenerateColumns="False" CssClass="auto-style1" DataKeyNames="autoID" DataSourceID="sdsWellnessByUser" Width="614px">
            <Columns>
                <asp:BoundField DataField="username" HeaderText="Person" SortExpression="username" />
                <asp:BoundField DataField="datecompleted" DataFormatString="{0:d}" HeaderText="Date Completed" SortExpression="datecompleted" />
                <asp:BoundField DataField="hour" HeaderText="Hour Completed" SortExpression="hour" />
                <asp:BoundField DataField="qty" HeaderText="Qty" SortExpression="qty" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsWellnessByUser" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Wellness] WHERE ([username] = @username) ORDER BY [datecompleted] desc">
            <SelectParameters>
                <asp:ControlParameter ControlID="tbUser" Name="username" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
    </div>
        <div id="right" class="newStyle6">
            <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTotals" Caption="Totals Since 8/1/19">
                <Columns>
                    <asp:BoundField DataField="username" HeaderText="Person" SortExpression="username" >
                    <ItemStyle Width="100px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="qty" HeaderText="Total" SortExpression="qty" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsTotals" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT Sum(qty) as qty, username FROM [Wellness] Where datecompleted > '2019-07-31' Group By [username] Order By Qty desc">
                
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
