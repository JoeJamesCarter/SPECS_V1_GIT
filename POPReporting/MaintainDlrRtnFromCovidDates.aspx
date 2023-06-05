<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MaintainDlrRtnFromCovidDates.aspx.vb" MaintainScrollPositionOnPostback="True" Inherits="MaintainDlrRtnFromCovidDates" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Maintain Dates Dealers Return From Covid</title>
        <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Maintain Dates Dealers Return From Covid" CssClass="newStyle7"></asp:Label>
            <br />
            <asp:GridView ID="gvActiveDealers" runat="server" AllowSorting="True" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="DlrNo" DataSourceID="sdsCovidDealerDates">
                <Columns>
                    <asp:CommandField ShowEditButton="True" />
                     <asp:BoundField DataField="Rep" HeaderText="Rep" ReadOnly="True" SortExpression="Rep" >
                    <ItemStyle Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DlrNo" HeaderText="Dlr #" ReadOnly="True" SortExpression="DlrNo" >
                    <ItemStyle Width="150px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DlrName" HeaderText="Dlr DBA" ReadOnly="True" SortExpression="DlrName" />
                    <asp:BoundField DataField="DateReturning" DataFormatString="{0:d}" HeaderText="Date Returning" ReadOnly="False" SortExpression="DateReturning" />                                   
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsCovidDealerDates" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [DlrReturnsFromCovid] WHERE [DlrNo] = @DlrNo" InsertCommand="INSERT INTO [DlrReturnsFromCovid] ([DlrNo], [DateReturning]) VALUES (@DlrNo, @DateReturning)" SelectCommand="SELECT * FROM [DlrReturnsFromCovid] order By DlrName" UpdateCommand="UPDATE [DlrReturnsFromCovid] SET [DateReturning] = @DateReturning WHERE [DlrNo] = @DlrNo">
                <DeleteParameters>
                    <asp:Parameter Name="DlrNo" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="DlrNo" Type="String" />
                    <asp:Parameter DbType="Date" Name="DateReturning" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter DbType="Date" Name="DateReturning" />
                    <asp:Parameter Name="DlrNo" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
        </div>
    </form>
</body>
</html>
