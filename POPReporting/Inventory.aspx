<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Inventory.aspx.vb" Inherits="Inventory" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Physical Inventory White Board</title>
    <style>
        .area {
            float: left;                    
            font-family: Arial;
            font-size: 14px;
            font-weight: bold;            
            border-style: double;
            vertical-align: central;  
                      
        }

        .bluetext {
            text-align:left;            
            font-family: Arial;
            font-size:20px;
            font-weight: bold;
            
            
        }
        .bldg {

            text-align:right;            
            font-family: Arial;
            font-size: 40px;
            font-weight: bold;
                      
        }

        .percentComplete {

            text-align:right;            
            font-family: Arial;
            font-size: 20px;
            font-weight: bold;
                      
        }
            .clearing {

            text-align:right;            
            font-family: Arial;
            font-size: 15px;
            font-weight: bold;
                      
        }

        #left {
            width:70%;
        }

        #right {
            width:10%;
            padding-left: 2px;
            font-family: Calibri;
            font-size: 15px;
            float: left;
            
        }
        #legend {
            font-size:10px;
            vertical-align:bottom;
            font-weight:bold;
        }

        #ready {
            padding-left: 10px;
            font-family: Calibri;
            font-size: 20px;
            float: left;
            width:10%
            
        }

        #waiting {
            padding-left: 10px;
            font-family: Calibri;
            font-size: 150px;
            float: left;
            width: 10%;
        }

        .counting {
            background-color:white;
            font-weight:bold;
            
        }

         .clearreqd {
            background-color:orange;
            font-weight:bold;
            
        }

          .cleared {
            background-color:darkgrey;
            font-weight:bold;
            
        }
        .keyed {
            background-color: blue;
            color: white;
            font-weight:bold;
        }

        .errors {
            background-color: red;
            font-weight:bold;
            color:white;
        }

        .reportready {
            background-color: yellow;
            font-weight:bold;
        }

        .done {
            background-color: green;
            color: white;
            font-weight:bold;
        }

        .review1 {
            background-color: lightcyan;
            color: black;
            font-weight:bold;
        }

        .review2 {
            background-color: purple;
            color: white;
            font-weight:bold;
        }
        .callacct {
            background-color: darkred;
            color: white;
            font-weight:bold;
        }
          .blinkingText {
            animation: blinkingText 1.2s infinite;
        }

        @keyframes blinkingText {
            0% {
                color: #fff;
            }

            49% {
                color: #fff;
            }

            60% {
                color: transparent;
            }

            99% {
                color: transparent;
            }

            100% {
                color: #fff;
            }
        }
    </style>
</head>
<body>
    <div id="left">
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                <ContentTemplate>

                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="10000" OnTick="Timer1_Tick"></asp:Timer>
                    <asp:DataList ID="DataList1" CssClass="area" runat="server" DataSourceID="sdsInventoryAreas" RepeatDirection="Horizontal" RepeatColumns="11" BorderStyle="Outset" SeparatorStyle-Height="20px" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" Width="90%">
                        <ItemTemplate>
                            <asp:Table ID="Table1" runat="server" Width="90%">
                                <asp:TableRow>
                                    <asp:TableCell HorizontalAlign="Left">
                                        &nbsp;<asp:Label ID="lbl" class="bluetext" runat="server" Text='<%# Eval("Area")%>'></asp:Label>                                    
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center" VerticalAlign="Middle">
                                        <asp:Label ID="lblAuditor" cssClass="auditor" runat="server" Text='<%# Eval("Auditor") %>'></asp:Label>
                                    </asp:TableCell>                                   
                                </asp:TableRow>
                            </asp:Table>                          
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsInventoryAreas" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT Area, Status, Auditor, Building FROM Inventory where Area != '999999' order by Cast(Area as int) "></asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
    </div>
    <div id="right">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="percentComplete" CssClass="percentComplete" runat="server" Text=""></asp:Label><asp:Label ID="Label1" runat="server" cssClass="percentComplete" Text="% DONE"></asp:Label><br />
              <br />
                <asp:Table ID="Table2" runat="server" CssClass="legend" GridLines="Both">                     
                    <asp:TableRow><asp:TableCell><asp:Label runat="server" CssClass="counting" Text="COUNTING" Width="120px"></asp:Label></asp:TableCell><asp:TableCell><strong><asp:Label ID="lblNotStartedCount" runat="server" Text="0"></asp:Label></asp:TableCell></asp:TableRow>
                    <asp:TableRow><asp:TableCell><asp:Label runat="server" CssClass="clearreqd" Text="CLEAR REQ'D" Width="120px"></asp:Label></asp:TableCell><asp:TableCell><strong><asp:Label ID="lblClearReq" runat="server" Text="1"></asp:Label></strong></asp:TableCell></asp:TableRow>
                    <asp:TableRow><asp:TableCell><asp:Label runat="server" CssClass="cleared" Text="CLEARED" Width="120px"></asp:Label></asp:TableCell><asp:TableCell><strong><asp:Label ID="lblClearedCount" runat="server" Text="2"></asp:Label></strong></asp:TableCell></asp:TableRow>
                    <asp:TableRow><asp:TableCell><asp:Label runat="server" CssClass="callacct" Text="CALL CHERISSE IN TEAMS" Width="120px"></asp:Label></asp:TableCell><asp:TableCell><strong><asp:Label ID="lblCallAcct" runat="server" Text="3"></asp:Label></strong></asp:TableCell></asp:TableRow>
                    <asp:TableRow><asp:TableCell><asp:Label runat="server" cssclass="keyed" Text="KEYED" Width="120px"></asp:Label></asp:TableCell><asp:TableCell><strong><asp:Label ID="lblKeyedCount" runat="server" Text="4"></asp:Label></strong></asp:TableCell></asp:TableRow>
                    <asp:TableRow><asp:TableCell><asp:Label runat="server" cssclass="review1" Text="1ST ACCT REVIEW" Width="120px"></asp:Label></asp:TableCell><asp:TableCell><strong><asp:Label ID="lblReview1" runat="server" Text="5"></asp:Label></strong></asp:TableCell></asp:TableRow>
                    <asp:TableRow><asp:TableCell><asp:Label runat="server" cssclass="review2" Text="2ND ACCT REVIEW" Width="120px"></asp:Label></asp:TableCell><asp:TableCell><strong><asp:Label ID="lblReview2" runat="server" Text="6"></asp:Label></strong></asp:TableCell></asp:TableRow>                    
                    <asp:TableRow><asp:TableCell><asp:Label runat="server" CssClass="errors" Text="ERRORS" Width="120px"></asp:Label></asp:TableCell><asp:TableCell><strong><asp:Label ID="lblErrorsCount" runat="server" Text="7"></asp:Label></strong></asp:TableCell> </asp:TableRow>
                    <asp:TableRow><asp:TableCell><asp:Label runat="server" CssClass="reportready" Text="REPORT READY" Width="120px"></asp:Label></asp:TableCell><asp:TableCell><strong><asp:Label ID="lblReportsReadyCount" runat="server" Text="8"></asp:Label></strong></asp:TableCell></asp:TableRow>                    
                    <asp:TableRow><asp:TableCell><asp:Label runat="server" CssClass="done" Text="DONE" Width="120px"></asp:Label></asp:TableCell><asp:TableCell><strong><asp:Label ID="lblDoneCount" runat="server" Text="9"></asp:Label></strong></asp:TableCell></asp:TableRow>
                </asp:Table>                
                 <div id="waiting">                   
                            <asp:GridView ID="gvWaiting" runat="server" DataSourceID="sdsAreasToClear" CssClass="clearing" AutoGenerateColumns="False" Width="170px" Caption="Clearing Requests">
                                <Columns>
                                    <asp:BoundField DataField="ClearingAuditor" HeaderText="Auditor" SortExpression="ClearingAuditor">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Area" HeaderText="Area" SortExpression="Auditor">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsAreasToClear" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>" SelectCommand="SELECT [Area],[ClearRequested],[ClearingAuditor] FROM Inventory WHERE ([Status] = @Status) ORDER BY [ClearRequested]">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="1" Name="Status" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        
                </div>
                </div><br />
                </ContentTemplate>
        </asp:UpdatePanel>
        <%--<asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
               
                 </ContentTemplate>
            </asp:UpdatePanel>
                <div id="ready">
                    
                        
                </div>--%>



            
    </div>

    </form>

    
    
</body>
</html>
