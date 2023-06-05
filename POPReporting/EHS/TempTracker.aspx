<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TempTracker.aspx.vb" Inherits="EHS_TempTracker" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Temperature Tracking</title>
    <link rel="stylesheet" href="../scripts/css/bootstrap.min.css" />
    <link href="../scripts/css/toastr.css" rel="stylesheet" />
        <script src="../scripts/jquery-3.5.0.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
        <script src="../scripts/toastr.min.js"></script> 

<script type="text/javascript">
    function showpopSuccess(msg, title) {
        toastr.options = {
            "closeButton": false,
            "debug": false,
            "newestOnTop": false,
            "progressBar": false,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "2000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        }
        // toastr['success'](msg, title);
        var d = Date();
        toastr.success(msg, title);
        return false;
    }
</script>
<%--for chat process of consultant--%>
<script type="text/javascript">
    function showpopError(msg, title) {
        toastr.options = {
            "closeButton": false,
            "debug": false,
            "newestOnTop": false,
            "progressBar": false,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "2000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        }
        // toastr['success'](msg, title);
        var d = Date();
        toastr.error(msg, title);
        return false;
    }
</script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="mx-auto bg-light col-sm-12 h-100">
            <span class="h3">
                <label class="text-dark text-center w-100">Employee Temperature Tracking</label></span>
            <hr />
            <div class="form-inline mb-4 mt-4">
                <label for="name" class="mr-4">Scan Badge #</label>
                <asp:TextBox ID="tbEmpBadgeNo" class="form-control w-25 float-left" runat="server" AutoPostBack="True"></asp:TextBox><br />
                <asp:Button ID="btnClear" class="btn btn-dark text-light btn-large ml-4 float-left" runat="server" Text="X" />
            </div>
            <div class="form-inline mb-5 border-dark border ">
                <span class="h4 mx-auto">
                    <asp:Label ID="lblBadge" CssClass="p-2 font-weight-bold" runat="server" Text=""></asp:Label>
                    <asp:Label ID="lblFirst" CssClass="font-weight-bold" runat="server" Text=""></asp:Label>&nbsp;
                <asp:Label ID="lblLast" CssClass="font-weight-bold" runat="server" Text=""></asp:Label>
                </span>
            </div>

          <%--  <div class="form-group">
                <asp:Button ID="btnChecked" class="btn btn-primary btn-lg form-control mb-3" runat="server" Text="TEMP CHECKED" />                
            </div>--%>
            <div class="form-group">
            <asp:GridView ID="gvRunningList" runat="server" DataSourceID="sdsPeopleChecked" Width="100%" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="BadgeNo" HeaderText="Badge #" />
                    <asp:TemplateField HeaderText="Employee">
                        <ItemTemplate>
                            <asp:Label ID="lblEmpFullName" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DateChecked" DataFormatString="{0:d}" HeaderText="Date" />
                </Columns>
                

                </asp:GridView>
                <asp:SqlDataSource ID="sdsPeopleChecked" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [TempChecks] WHERE Convert(date,DateChecked) = convert(varchar(10), getdate(), 102) Order By AutoID desc">
                 
                </asp:SqlDataSource>
            </div>
            <asp:Label runat="server" ID="pageLastLoaded"></asp:Label>
        </div>





        <%--<div class="mx-auto bg-light col-sm-5 col-xl-5 h-100">--%>
        <%--<div class="form-group col-sm-5 col-xl-12">
                <span class="h4">
                    <label class="bg-dark text-light text-center w-100">Employee Temperature Tracking</label></span><br />
                <label for="name">Scan Badge #</label>
                <asp:TextBox ID="tbEmpBadgeNo" class="form-control w-25 p-10 float-left" runat="server"></asp:TextBox>
                <asp:Label ID="Label1" class="float-left" runat="server" Text="Label"></asp:Label>
                <asp:Label ID="Label2" class="float-left" runat="server" Text="Label"></asp:Label>
            </div>
                <div class="form-group h-25">
                <asp:GridView ID="gvEmployeeData" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="sdsEmployees" ShowHeader="false" Font-Bold="True">
                    <Columns>
                        <asp:BoundField DataField="BADGE" HeaderText="BADGE #" SortExpression="BADGE" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="FIRSTNAME" HeaderText="FIRST NAME" SortExpression="FIRSTNAME" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="LASTNAME" HeaderText="LAST NAME" SortExpression="LASTNAME" ItemStyle-HorizontalAlign="Center" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:BenningtonATTConnectionString %>" SelectCommand="SELECT [IDNUM], [BADGE], [LASTNAME], [FIRSTNAME] FROM [EMPLOYEES] WHERE ([BADGE] = @BADGE)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tbEmpBadgeNo" Name="BADGE" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                </div>
            <div class="container">
            <div class="form-group">
                <asp:Button ID="btnPass" class="btn btn-success btn-lg m-40 form-control" runat="server" Text="PASS" />                
            </div>
            <div class="form-group">
                <asp:Button ID="btnFail" class="btn btn-danger btn-lg form-control mt-6" runat="server" Text="FAIL" />
            </div>
                </div>--%>




        <%-- <label class="bg-primary text-light h-50 p-6 mb-4 w-100 text-center">Quick Tap Temp Builder</label>
            <div class="container">
            <div class="form-group">
                <asp:Button ID="btn94" runat="server" Text="94" CssClass="btn-sm" />
                <asp:Button ID="btn95" runat="server" Text="95" CssClass="btn-sm" />
                <asp:Button ID="btn96" runat="server" Text="96" CssClass="btn-sm" />
                <asp:Button ID="btn97" runat="server" Text="97" CssClass="btn-sm" />
                <asp:Button ID="btn98" runat="server" Text="98" CssClass="btn-sm" />
                <asp:Button ID="btn99" runat="server" Text="99" CssClass="btn-sm" />
                <asp:Button ID="btn100" runat="server" Text="100" CssClass="btn-sm" /><br />
                <br />
                <asp:Button ID="btn0" runat="server" Text="0" CssClass="btn-sm" />
                <asp:Button ID="btn1" runat="server" Text="1" CssClass="btn-sm" />
                <asp:Button ID="btn2" runat="server" Text="2" CssClass="btn-sm" />
                <asp:Button ID="btn3" runat="server" Text="3" CssClass="btn-sm" />
                <asp:Button ID="btn4" runat="server" Text="4" CssClass="btn-sm" />
                <asp:Button ID="btn5" runat="server" Text="5" CssClass="btn-sm" />
                <asp:Button ID="btn6" runat="server" Text="6" CssClass="btn-sm" />
                <asp:Button ID="btn7" runat="server" Text="7" CssClass="btn-sm" />
                <asp:Button ID="btn8" runat="server" Text="8" CssClass="btn-sm" />
                <asp:Button ID="btn9" runat="server" Text="9" CssClass="btn-sm" />
            </div>
                </div>
            <div class="form-group">
                <label>Employee Temp</label><br />
                <asp:TextBox ID="tbTemp" class="form-control w-25 float-left mb-5" runat="server" AutoPostBack="True" MaxLength="5"></asp:TextBox>
                <asp:Button ID="btnClear" class="btn btn-primary btn-large ml-4 mr-4 float-left" runat="server" Text="X" />
                <asp:Button ID="btnSave" class="btn btn-primary btn-lg float-left" runat="server" Text="SAVE" />
            </div>
            <asp:HiddenField ID="hdnFirst" runat="server" />
            <asp:HiddenField ID="hdnSecond" runat="server" />--%>
    </form>



</body>
</html>
