<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RedTags.aspx.vb" Inherits="RedTags" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <link href="StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {}
        .auto-style2 {}
    </style>    
    
      <script>
          window.onunload = function () {
              window.opener.location.href = window.opener.location;
          }
      </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <span class="newStyle4">Red Tag:
    
        </span>
    
        <asp:Label ID="lblProdNo" runat="server" Text="" CssClass="newStyle4"></asp:Label>
    
        &nbsp;&nbsp;&nbsp;
        <asp:HiddenField ID="hdnWorkstation" runat="server" />
    
        <asp:Button ID="btnClose" runat="server" Text="Close" />
    
        <br />
        <br />
        <span class="newStyle4">
        <asp:Label ID="lblAddNewNote" runat="server" Text="Add a New Note"></asp:Label>
        <br />
        <asp:TextBox ID="tbNote" runat="server" CssClass="auto-style2" Height="23px" MaxLength="300" Width="540px"></asp:TextBox>
        <br />
        <asp:Button ID="btnBoatNote" runat="server" Text="Submit" />
        <br />
        </span>
    
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBoatNotes" DataKeyNames="Auto" CssClass="newStyle1 auto-style1" Caption="Open Red Tags" Width="1000px" OnRowDataBound="GridView1_RowDataBound" CellPadding="2" CellSpacing="2">
            <Columns>
                <asp:BoundField DataField="Auto" HeaderText="ID"/>
                <asp:BoundField DataField="RedTagNote" HeaderText="Note" SortExpression="Note" />
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:GridView runat="server" ID="gvRedTagComments" AutoGenerateColumns="False" DataKeyNames="CommentID" DataSourceID="sdsRedTagComments" Width="100%">
                            <Columns>                                
                                <asp:BoundField DataField="RedTagComments" HeaderText="Comments" ItemStyle-Width="300px" SortExpression="RedTagComments"></asp:BoundField>
                                <asp:BoundField DataField="CmtDate" DataFormatString="{0:d}" HeaderText="Comment Date" SortExpression="CmtDate"></asp:BoundField>
                                <asp:BoundField DataField="EnteredBy" HeaderText="EnteredBy" SortExpression="Entered By"></asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource runat="server" ID="sdsRedTagComments" ConnectionString='<%$ ConnectionStrings:bml_dataConnectionString %>' SelectCommand="SELECT * FROM [RedTagComments] WHERE ([RedTagAutoID] = @Auto)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Gridview1" Name="Auto" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnClearRedTag" runat="server" Text="Clear Red Tag" CommandArgument='<%#Eval("Auto") %>' CommandName="clearredtag" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsBoatNotes" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [RedTagNote], [Date], Auto FROM [BML_POPREPORTING_REDTAGS] WHERE ([ProdNo] = @ProdNo) and DateCleared is NULL ORDER BY [Auto]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <br />
        <asp:GridView runat="server" ID="gvClosedTags" DataSourceID="sdsRedTagsClosed" AutoGenerateColumns="False" DataKeyNames="Auto" CssClass="newStyle1 auto-style1"  Caption="Closed Red Tags">

            <Columns>                
                <asp:BoundField DataField="RedTagNote" HeaderText="RedTag" SortExpression="RedTagNote"></asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Date Entered" SortExpression="Date"></asp:BoundField>
                <asp:BoundField DataField="DateCleared" HeaderText="Date Cleared" SortExpression="DateCleared"></asp:BoundField>                
            </Columns>
        </asp:GridView>
         <asp:SqlDataSource ID="sdsRedTagsClosed" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [RedTagNote], [Date], DateCleared, Auto FROM [BML_POPREPORTING_REDTAGS] WHERE ([ProdNo] = @ProdNo) and DateCleared is not null ORDER BY [Auto]">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        
    
        <br />
    
    </div>
    </form>
</body>
</html>