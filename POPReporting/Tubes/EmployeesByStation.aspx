<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EmployeesByStation.aspx.vb" Inherits="Tubes_EmployeesByStation" Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employees By Station</title>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        .emptables {
            font-family: Calibri;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <span class="newStyle7">
                <asp:Label ID="Label1" runat="server" Text="Set North Employee Schedule By Station"></asp:Label>
                <br />
                <asp:DropDownList ID="ddlSupervisors" runat="server" AutoPostBack="True">
                    <asp:ListItem>Select Supervisor</asp:ListItem>
                    <asp:ListItem Value="RSB">Rollers/Seamers/Baffles</asp:ListItem>
                    <asp:ListItem Value="RSBKTS">Round Seamer/Brackets</asp:ListItem>
                    <asp:ListItem Value="ACR">Aircheck/Repair/Audit</asp:ListItem>
                    <asp:ListItem Value="CT">Chines/Transoms</asp:ListItem>
                </asp:DropDownList>
                <br />
            </span>
            <div id ="emps">
            <asp:Table ID="tblRollerSeamer" CssClass="emptables" runat="server" Width="600px" GridLines="Both">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="5"><span class="newStyle7">ROLLERS</span></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Roller 1</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRoller1" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="tbtRoller1Time" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="tbdRoller1Date" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnSaveRoller1" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Roller 2</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRoller2" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="tbtRoller2Time" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="tbdRoller2Date" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnSaveRoller2" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3"><span class="newStyle7">SEAMERS</span></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Seamer 1</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlSeamer1" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox3" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox4" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnSaveSeamer1" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Seamer 2</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlSeamer2" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox5" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox6" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnSaveSeamer2" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Seamer 3</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlSeamer3" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox9" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox10" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnSaveSeamer3" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3"><span class="newStyle7">BAFFLES</span></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Baffles 1</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="dlBaffles1" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox11" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox12" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnSaveBaffles1" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Baffles 2</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="dlBaffles2" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox13" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox14" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnSaveBaffles2" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Baffles 3</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBaffles3" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox15" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox16" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button8" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Baffles 4</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBaffels4" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Baffles 5</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBaffles5" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox17" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox18" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button9" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Baffles 6</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBaffles6" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox19" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox20" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button10" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Baffles 7</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBaffles7" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox21" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox22" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button11" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <asp:Table ID="tblRSBrackets" CssClass="emptables" runat="server" Width="600px" GridLines="Both">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="5"><span class="newStyle7">ROUND SEAMERS</span></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Round Seamer 1</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRoundSeamer1" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox23" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox24" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button12" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Round Seamer 2</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRoundSeamer2" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox25" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox26" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button13" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Round Seamer 3</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRoundSeamer3" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox27" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox28" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button14" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Round Seamer 4</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRoundSeamer4" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox29" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox30" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button15" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Round Seamer 5</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRoundSeamer5" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox31" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox32" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button16" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Round Seamer 6</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRoundSeamer6" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox33" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox34" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button17" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Round Seamer 7</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRoundSeamer7" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox7" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox8" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button4" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Round Seamer 8</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRoundSeamer8" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox35" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox36" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button18" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Round Seamer 9</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRoundSeamer9" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox37" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox38" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button19" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3"><span class="newStyle7">BRACKETS</span></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Brackets 1</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBrackets1" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox39" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox40" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button20" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Brackets 2</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBrackets2" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox41" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox42" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button21" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Brackets 3</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBrackets3" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox43" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox44" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button22" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Brackets 4</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBrackets4" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox45" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox46" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button23" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Brackets 5</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBrackets5" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox47" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox48" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button24" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Brackets 6</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBrackets6" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox49" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox50" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button25" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Brackets 7</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBrackets7" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox51" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox52" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button26" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell>Brackets 8</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlBrackets8" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox53" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox54" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button27" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />

            <asp:Table ID="tbACRepair" CssClass="emptables" runat="server" Width="600px" GridLines="Both">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="5"><span class="newStyle7">AIR CHECK</span></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Air Check 1A</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlAirCheck1" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox55" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox56" runat="server" TextMode="Date" Text=""></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button28" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                 <asp:TableCell>Air Check 1B</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList11" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox83" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox84" runat="server" TextMode="Date" Text=""></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button42" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>                
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Air Check 2A</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlAirCheck2" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox57" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox58" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button29" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                 <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Air Check 2B</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList13" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox87" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox88" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button44" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3"><span class="newStyle7">REPAIR</span></asp:TableCell>
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Repair 1A</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRepair1" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox59" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox60" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button30" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Repair 1B</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="ddlRepair2" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox61" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox62" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button31" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow> 
                    <asp:TableCell Width="20"></asp:TableCell>                   
                 <asp:TableCell>Repair 2A</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList12" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox85" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox86" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button43" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow> 
                    <asp:TableCell Width="20"></asp:TableCell>                   
                 <asp:TableCell>Repair 2B</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList14" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox89" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox90" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button45" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow> 
                    <asp:TableCell Width="20"></asp:TableCell>                   
                 <asp:TableCell>Repair 2C</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList15" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox91" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox92" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button46" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="5"><span class="newStyle7">AUDIT</span></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Audit 1</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList10" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox81" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox82" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button41" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>


            </asp:Table>

            <asp:Table ID="tblCT" CssClass="emptables" runat="server" Width="600px" GridLines="Both">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="5"><span class="newStyle7">CHINES/FOILS</span></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Chines 1</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox63" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox64" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button32" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Chines 2</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox65" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox66" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button33" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Chines 3</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox71" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox72" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button36" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Chines 4</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox73" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox74" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button37" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Chines 5</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox75" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox76" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button38" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3"><span class="newStyle7">TRANSOMS</span></asp:TableCell>
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Transom 1</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox67" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox68" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button34" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Transom 2</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox69" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox70" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button35" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Transom 3</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList8" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox77" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox78" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button39" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="20"></asp:TableCell>
                    <asp:TableCell>Transom 4</asp:TableCell>
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:DropDownList ID="DropDownList9" runat="server" DataSourceID="sdsActiveTubeEmployees" DataTextField="FullName" DataValueField="FullName"></asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBox79" runat="server" TextMode="Time"></asp:TextBox>
                        <asp:TextBox ID="TextBox80" runat="server" TextMode="Date"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="Button40" runat="server" Text="Save" />
                    </asp:TableCell>
                </asp:TableRow>

            </asp:Table>
            <asp:SqlDataSource ID="sdsActiveTubeEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [First], [Last], [FullName], [Dept] FROM [Tubes_Employees] ORDER BY [Last]"></asp:SqlDataSource>
        </div>
            </div>
    </form>
</body>
</html>
