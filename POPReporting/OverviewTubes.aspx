<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OverviewTubes.aspx.vb" Inherits="OverviewTubes" debug ="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tubes Overview - Searchable</title>
    <style type="text/css">
        .newStyle1 {
            font-family: calibri;
            font-size: 14px;                     
        }
        .newStyle2 {
            font-family: Calibri;
            font-weight: bold;
            font-size: large;
        }
        .table-subheader{
            font-family:Calibri;
            color: green;
            font-size: 18px; 
            font-weight:bold;              

        }
        .newStyle7 {
            font-family: calibri;
            font-size: 14px;
            font-weight: bold;
            width: 100%;
        }
        .auto-style1 {}
        .auto-style3 {}
        .auto-style4 {}
        </style>
        
</head>
<body>

    
    <form id="form1" runat="server">
    <div>
        
        <div class="newStyle7">
                <asp:Image ID="Image1" runat="server" ImageUrl="Images/logo-smaller.png" />          
              
                &nbsp;&nbsp;&nbsp;&nbsp; Search By Prod #:
                <asp:TextBox ID="tbSearchProdNo" runat="server" AutoPostBack="True" CssClass="auto-style1" Height="22px" Width="83px"></asp:TextBox>
              
                <asp:Button ID="btnClearProdNo" runat="server" Text="Clear" />
                &nbsp; Customer:
                <asp:TextBox ID="tbSearchCusName" runat="server" AutoPostBack="True" CssClass="auto-style3" Height="22px" Width="83px"></asp:TextBox>
              
                <asp:Button ID="btnClearnCusName" runat="server" Text="Clear" />
&nbsp; Boat Model:
                <asp:TextBox ID="tbSearchModel" runat="server" AutoPostBack="True" CssClass="auto-style4" Height="22px" Width="83px"></asp:TextBox>
                <asp:Button ID="btnClearModel" runat="server" Text="Clear" />
              
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sort By:
                <asp:DropDownList ID="ddlOrderBy" runat="server" AutoPostBack="True">
                    <asp:ListItem Value="1">Prod #</asp:ListItem>
                    <asp:ListItem Value="2">Tube Prioirty</asp:ListItem>
                </asp:DropDownList>
            Center Tube Needed:
            <asp:DropDownList ID="ddlCenterNeeded" runat="server" AutoPostBack="True">
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem Value="0">ALL</asp:ListItem>
                    <asp:ListItem Value="1">Needs Center</asp:ListItem>
                </asp:DropDownList>
                Building: &nbsp; <asp:DropDownList runat="server" ID ="ddlBldg" AutoPostBack="True">
                    <asp:ListItem Value="%">All</asp:ListItem>                
                    <asp:ListItem Value="M">Main</asp:ListItem> 
                    <asp:ListItem Value="S">South</asp:ListItem> 
                    </asp:DropDownList>
                &nbsp; Red = Not Done. Yellow/Red = Ready to Do. Yellow = In Progress. Green = Done.</div>
        <br />
        <asp:GridView ID="gvOverviewTubes" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsPopReporting" CellPadding="4" PageSize="45" AllowPaging="True" BorderStyle="Solid" BorderWidth="5px" CellSpacing="2" HeaderStyle-BorderStyle="Solid" HeaderStyle-BorderWidth="2">
            <Columns>
                <asp:BoundField DataField="ProdNo" HeaderText="Prod #" SortExpression="ProdNo" >
                <ItemStyle Font-Bold="True" />
                </asp:BoundField>
                <asp:BoundField DataField="SONo" HeaderText="SO #">
                <ItemStyle Font-Bold="True" />
                </asp:BoundField>
                <asp:BoundField DataField="DateDue" HeaderText="Due Date" DataFormatString="{0:d}">
                <ItemStyle Font-Bold="True" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="F">
                    <ItemTemplate>
                        <asp:Image ID="imgFurnitureStatus" runat="server" ImageUrl='<%# Eval("FurnitureStatus", "./Images/{0}.png") %>' AlternateText='Furniture' ToolTip= 'Furniture'  />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="FiberglassStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="FG" AlternateText="Fiberglass">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="CoversStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="C">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="RailsStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="R">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="TubesStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="T">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
              
                <asp:TemplateField HeaderText="CT">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnCentertube" enabled= "false" runat="server" Visible = ' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("CentertubeStatus", "./Images/{0}.png")%>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" CssClass="newStyle2" Text='<%# Eval("ItemNo") %>'></asp:Label>
                        <asp:ImageButton ID="ImageButton1" ImageUrl='./Images/getboatdetails.png'  runat="server" CommandArgument='<%# Eval("SONo")%>' CommandName ="gotoorderdetails"/>
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CusName") %>'></asp:Label><br />
                         <asp:Label ID="Label7" runat="server" Text='<%# Eval("OuterRoller")%>' CssClass="newStyle5"></asp:Label><asp:Label ID="Label3" runat="server" Text='<%# "O:" & Eval("OuterScheduled")%>' CssClass="newStyle5"></asp:Label>
                        <asp:Label ID="Label6" runat="server" Text='<%#"Seq:" & Eval("OuterScheduleOrder")%>' CssClass="newStyle5"></asp:Label><br />
                        <asp:Label ID="Label8" runat="server" Visible='<%# Eval("CentertubeNeeded") = 1%>' Text='<%# Eval("CenterRoller")%>' CssClass="newStyle5"></asp:Label>                        
                        <asp:Label ID="Label4" Visible='<%# Eval("CentertubeNeeded") = 1%>' runat="server" Text='<%# "C:" & Eval("CenterScheduled")%>' CssClass="newStyle5"></asp:Label>
                        <asp:Label ID="Label5" Visible='<%# Eval("CentertubeNeeded") = 1%>' runat="server" Text='<%# " Seq:" & Eval("CenterScheduleOrder")%>' CssClass="newStyle5"></asp:Label>       
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:ImageField DataImageUrlField="RollerPStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Port">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:ImageField DataImageUrlField="RollerSStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Strb">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:ImageField>
                <asp:TemplateField HeaderText="Center">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnRollerC" Enabled="false" runat="server" Visible =' <%# Eval("CentertubeNeeded") = 1%>' ImageUrl='<%# Eval("RollerCStatus", "./Images/{0}.png")%>' AlternateText='Roller - C' ToolTip= 'Roller - C' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Port">                    
                        <ItemTemplate>
                            <asp:Table runat="server" GridLines="Vertical">
                            <asp:TableHeaderRow>
                                <asp:TableHeaderCell>F</asp:TableHeaderCell>
                                <asp:TableHeaderCell>M</asp:TableHeaderCell>
                                <asp:TableHeaderCell>M2</asp:TableHeaderCell>
                                <asp:TableHeaderCell>R</asp:TableHeaderCell>
                            </asp:TableHeaderRow>    
                                <asp:TableRow>
                                    <asp:TableCell><asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("SeamerSectPFStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("SeamerPFID") & "-" & Eval("SeamerSectPF")%>' /></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image3" runat="server" ImageUrl='<%# Eval("SeamerSectPMStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("SeamerPMID") & "-" & Eval("SeamerSectPM")%>' Visible='<%# IIf(Eval("OuterSections") = 3, True, False)%>'/></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image4" runat="server" ImageUrl='<%# Eval("SeamerSectPM2Status", "./Images/{0}.png")%>' ToolTip='<%# Eval("SeamerPM2ID") & "-" & Eval("SeamerSectPM2")%>'  Visible='<%# IIf(Eval("OuterSections") = 4, True, False)%>' /></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image5" runat="server" ImageUrl='<%# Eval("SeamerSectPRStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("SeamerPRID")& "-" & Eval("SeamerSectPR")%>'  /></asp:TableCell>
                                </asp:TableRow>
                            
                            </asp:Table>
                        </ItemTemplate>
                    
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Strb">                    
                        <ItemTemplate>
                            <asp:Table runat="server" GridLines="Vertical">
                            <asp:TableHeaderRow>
                                <asp:TableHeaderCell>F</asp:TableHeaderCell>
                                <asp:TableHeaderCell>M</asp:TableHeaderCell>
                                <asp:TableHeaderCell>M2</asp:TableHeaderCell>
                                <asp:TableHeaderCell>R</asp:TableHeaderCell>
                            </asp:TableHeaderRow>    
                                <asp:TableRow>
                                    <asp:TableCell><asp:Image ID="Image6" runat="server" ImageUrl='<%# Eval("SeamerSectSFStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("SeamerSFID") & "-" & Eval("SeamerSectSF")%>' /></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image7" runat="server" ImageUrl='<%# Eval("SeamerSectSMStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("SeamerSMID") & "-" & Eval("SeamerSectSM")%>' Visible='<%# IIf(Eval("OuterSections") = 3, True, False)%>'/></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image8" runat="server" ImageUrl='<%# Eval("SeamerSectSM2Status", "./Images/{0}.png")%>' ToolTip='<%# Eval("SeamerSM2ID") & "-" & Eval("SeamerSectSM2")%>' Visible='<%# IIf(Eval("OuterSections") = 4, True, False)%>' /></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image9" runat="server" ImageUrl='<%# Eval("SeamerSectSRStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("SeamerSRID") & "-" & Eval("SeamerSectSR")%>' /></asp:TableCell>
                                </asp:TableRow>
                            
                            </asp:Table>
                        </ItemTemplate>
                    
                </asp:TemplateField>
                       <asp:TemplateField HeaderText="Ctr">                    
                        <ItemTemplate>
                            <asp:Table ID="tblSeamerCtr" runat="server" GridLines="Vertical">
                            <asp:TableHeaderRow>
                                <asp:TableHeaderCell Visible='<%# IIf(Eval("CenterSections") = 0, False, True)%>'>F</asp:TableHeaderCell>
                                <asp:TableHeaderCell Visible='<%# IIf(Eval("CenterSections") = 0, False, True)%>'>M</asp:TableHeaderCell>
                                <asp:TableHeaderCell Visible='<%# IIf(Eval("CenterSections") = 0, False, True)%>'>M2</asp:TableHeaderCell>
                                <asp:TableHeaderCell Visible='<%# IIf(Eval("CenterSections") = 0, False, True)%>'>R</asp:TableHeaderCell>
                            </asp:TableHeaderRow>    
                                <asp:TableRow>
                                    <asp:TableCell><asp:Image ID="Image10" runat="server" ImageUrl='<%# Eval("SeamerSectCFStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("SeamerCFID") & "-" & Eval("SeamerSectCF")%>' Visible='<%# IIf(Eval("CenterSections") <> 0, True, False)%>'/></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image11" runat="server" ImageUrl='<%# Eval("SeamerSectCMStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("SeamerCMID") & "-" & Eval("SeamerSectCM")%>' Visible='<%# IIf(Eval("CenterSections") = 3, True, False)%>'/></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image12" runat="server" ImageUrl='<%# Eval("SeamerSectCM2Status", "./Images/{0}.png")%>' ToolTip='<%# Eval("SeamerCM2ID") & "-" & Eval("SeamerSectCM2")%>' Visible='<%# IIf(Eval("CenterSections") = 4, True, False)%>' /></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image13" runat="server" ImageUrl='<%# Eval("SeamerSectCRStatus", "./Images/{0}.png")%>'  ToolTip='<%# Eval("SeamerCRID")& "-" & Eval("SeamerSectCR")%>' Visible='<%# IIf(Eval("CenterSections") <> 0, True, False)%>'/></asp:TableCell>
                                </asp:TableRow>                            
                            </asp:Table>
                        </ItemTemplate>
                    
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="Port">                    
                        <ItemTemplate>
                            <asp:Table runat="server"  GridLines="Vertical">
                            <asp:TableHeaderRow>
                                <asp:TableHeaderCell>F</asp:TableHeaderCell>
                                <asp:TableHeaderCell>M</asp:TableHeaderCell>
                                <asp:TableHeaderCell>M2</asp:TableHeaderCell>
                                <asp:TableHeaderCell>R</asp:TableHeaderCell>
                            </asp:TableHeaderRow>    
                                <asp:TableRow>
                                    <asp:TableCell><asp:Image ID="Image14" runat="server" ImageUrl='<%# Eval("BafflesSectPFStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesPFID") & "-" & Eval("BafflesSectPF")%>'/></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image15" runat="server" ImageUrl='<%# Eval("BafflesSectPMStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesPMID") & "-" & Eval("BafflesSectPM")%>' Visible='<%# IIf(Eval("OuterSections") = 3, True, False)%>'/></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image16" runat="server" ImageUrl='<%# Eval("BafflesSectPM2Status", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesPM2ID") & "-" & Eval("BafflesSectPM2")%>' Visible='<%# IIf(Eval("OuterSections") = 4, True, False)%>' /></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image17" runat="server" ImageUrl='<%# Eval("BafflesSectPRStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesPRID") & "-" & Eval("BafflesSectPR")%>'/></asp:TableCell>
                                </asp:TableRow>
                            
                            </asp:Table>
                        </ItemTemplate>
                    
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Strb">                    
                        <ItemTemplate>
                            <asp:Table runat="server" GridLines="Vertical">
                            <asp:TableHeaderRow>
                                <asp:TableHeaderCell>F</asp:TableHeaderCell>
                                <asp:TableHeaderCell>M</asp:TableHeaderCell>
                                <asp:TableHeaderCell>M2</asp:TableHeaderCell>
                                <asp:TableHeaderCell>R</asp:TableHeaderCell>
                            </asp:TableHeaderRow>    
                                <asp:TableRow>
                                    <asp:TableCell><asp:Image ID="Image18" runat="server" ImageUrl='<%# Eval("BafflesSectSFStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesSFID") & "-" & Eval("BafflesSectSF")%>'/></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image19" runat="server" ImageUrl='<%# Eval("BafflesSectSMStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesSMID") & "-" & Eval("BafflesSectSM")%>' Visible='<%# IIf(Eval("OuterSections") = 3, True, False)%>'/></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image20" runat="server" ImageUrl='<%# Eval("BafflesSectSM2Status", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesSM2ID") & "-" & Eval("BafflesSectSM2")%>' Visible='<%# IIf(Eval("OuterSections") = 4, True, False)%>' /></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image21" runat="server" ImageUrl='<%# Eval("BafflesSectSRStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesSRID")& "-" & Eval("BafflesSectSR")%>'/></asp:TableCell>
                                </asp:TableRow>
                            
                            </asp:Table>
                        </ItemTemplate>
                    
                </asp:TemplateField>
                       <asp:TemplateField HeaderText="Ctr">                    
                        <ItemTemplate>
                            <asp:Table ID="tblBafflesCtr" runat="server" GridLines="Vertical">
                            <asp:TableHeaderRow>
                                <asp:TableHeaderCell Visible='<%# IIf(Eval("CenterSections") = 0, False, True)%>'>F</asp:TableHeaderCell>
                                <asp:TableHeaderCell Visible='<%# IIf(Eval("CenterSections") = 0, False, True)%>'>M</asp:TableHeaderCell>
                                <asp:TableHeaderCell Visible='<%# IIf(Eval("CenterSections") = 0, False, True)%>'>M2</asp:TableHeaderCell>
                                <asp:TableHeaderCell Visible='<%# IIf(Eval("CenterSections") = 0, False, True)%>'>R</asp:TableHeaderCell>
                            </asp:TableHeaderRow>    
                                <asp:TableRow>
                                    <asp:TableCell><asp:Image ID="Image22" runat="server" ImageUrl='<%# Eval("BafflesSectCFStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesCFID") & "-" & Eval("BafflesSectCF")%>' Visible='<%# IIf(Eval("CenterSections") <> 0, True, False)%>'/></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image23" runat="server" ImageUrl='<%# Eval("BafflesSectCMStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesCMID") & "-" & Eval("BafflesSectCM")%>' Visible='<%# IIf(Eval("CenterSections") = 3, True, False)%>'/></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image24" runat="server" ImageUrl='<%# Eval("BafflesSectCM2Status", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesCM2ID") & "-" & Eval("BafflesSectCM2")%>' Visible='<%# IIf(Eval("CenterSections") = 4, True, False)%>' /></asp:TableCell>
                                    <asp:TableCell><asp:Image ID="Image25" runat="server" ImageUrl='<%# Eval("BafflesSectCRStatus", "./Images/{0}.png")%>' ToolTip='<%# Eval("BafflesCRID") & "-" & Eval("BafflesSectCR")%>' Visible='<%# IIf(Eval("CenterSections") <> 0, True, False)%>'/></asp:TableCell>
                                </asp:TableRow>
                            
                            </asp:Table>
                        </ItemTemplate>                    
                </asp:TemplateField>                
                <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                         <asp:ImageButton ID="btnRoundSeamerP" Enabled="false" runat="server" ToolTip='<%# Eval("RoundSeamerPID") & "-" & Eval("RoundSeamerP")%>' ImageUrl='<%# Eval("RoundSeamerPStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Strb">
                    <ItemTemplate>
                         <asp:ImageButton ID="btnRoundSeamerS" Enabled="false" runat="server" ToolTip='<%# Eval("RoundSeamerSID") & "-" & Eval("RoundSeamerS")%>' ImageUrl='<%# Eval("RoundSeamerSStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ctr">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnRoundSeamerC" Enabled="false" runat="server" Visible =' <%# Eval("CentertubeNeeded") = 1%>' ToolTip='<%# Eval("RoundSeamerCID") & "-" & Eval("RoundSeamerC")%>' ImageUrl='<%# Eval("RoundSeamerCStatus", "./Images/{0}.png")%>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>                 
                
                <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnBracketsP" Enabled="false" runat="server" ToolTip='<%# Eval("BracketsPID") & "-" & Eval("BracketsP")%>' ImageUrl='<%# Eval("BracketsPStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Strb">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnBracketsS" Enabled="false" runat="server" ToolTip='<%# Eval("BracketsSID") & "-" & Eval("BracketsS")%>' ImageUrl='<%# Eval("BracketsSStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                     <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>        
                <asp:TemplateField HeaderText="Ctr">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnBracketsC" Enabled="false" runat="server" Visible =' <%# Eval("CentertubeNeeded") = 1%>' ToolTip='<%# Eval("BracketsCID") & "-" & Eval("BracketsC")%>' ImageUrl='<%# Eval("BracketsCStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>    
                <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnAirCheckP" Enabled="false" runat="server" ToolTip='<%# Eval("AirCheckPID") & "-" & Eval("AirCheckP")%>' ImageUrl='<%# Eval("AirCheckPStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="Strb">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnAirCheckS" Enabled="false" runat="server" ToolTip='<%# Eval("AirCheckSID") & "-" & Eval("AirCheckS")%>' ImageUrl='<%# Eval("AirCheckSStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField> 
                <asp:TemplateField HeaderText="Ctr">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnAirCheckC" Enabled="false" runat="server" Visible =' <%# Eval("CentertubeNeeded") = 1%>' ToolTip='<%# Eval("AirCheckCID") & "-" & Eval("AirCheckC") %>' ImageUrl='<%# Eval("AirCheckCStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btRepair1P" Enabled="false" runat="server" ToolTip='<%# Eval("Repair1PID") & "-" & Eval("Repair1P")%>' ImageUrl='<%# Eval("Repair1PStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="Strb">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnRepair1S" Enabled="false" runat="server" ToolTip='<%# Eval("Repair1SID") & "-" & Eval("Repair1S")%>' ImageUrl='<%# Eval("Repair1SStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField> 
                <asp:TemplateField HeaderText="Ctr">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnRepair1C" Enabled="false" runat="server" Visible =' <%# Eval("CentertubeNeeded") = 1%>' ToolTip='<%# Eval("Repair1CID") & "-" & Eval("Repair1C")%>' ImageUrl='<%# Eval("Repair1CStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>          
                      <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnAirCheck2P" Enabled="false" runat="server" ToolTip='<%# Eval("AirCheck2PID") & "-" & Eval("AirCheck2P")%>' ImageUrl='<%# Eval("AirCheck2PStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="Strb">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnAirCheck2S" Enabled="false" runat="server" ToolTip='<%# Eval("AirCheck2SID") & "-" & Eval("AirCheck2S")%>' ImageUrl='<%# Eval("AirCheck2SStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField> 
                <asp:TemplateField HeaderText="Ctr">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnAirCheck2C" Enabled="false" runat="server" Visible =' <%# Eval("CentertubeNeeded") = 1%>' ToolTip='<%# Eval("AirCheck2CID") & "-" & Eval("AirCheck2C")%>' ImageUrl='<%# Eval("AirCheck2CStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnRepair2P" Enabled="false" runat="server" ToolTip='<%# Eval("Repair2PID") & "-" & Eval("Repair2P")%>' ImageUrl='<%# Eval("Repair2PStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="Strb">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnRepair2S" Enabled="false" runat="server" ToolTip='<%# Eval("Repair2SID") & "-" & Eval("Repair2S")%>' ImageUrl='<%# Eval("Repair2SStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField> 
                <asp:TemplateField HeaderText="Ctr">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnRepair2C" Enabled="false" runat="server" Visible =' <%# Eval("CentertubeNeeded") = 1%>' ToolTip='<%# Eval("Repair2CID") & "-" & Eval("Repair2C")%>' ImageUrl='<%# Eval("Repair2CStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>                 
                  <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnAuditP" Enabled="false" runat="server" ToolTip='<%# Eval("AuditPID") & "-" & Eval("AuditP")%>' ImageUrl='<%# Eval("AuditPStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="Strb">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnAuditS" Enabled="false" runat="server" ToolTip='<%# Eval("AuditSID") & "-" & Eval("AuditS")%>' ImageUrl='<%# Eval("AuditSStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>              
                   <asp:TemplateField HeaderText ="Ctr">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnAuditC" Enabled="false" runat="server" ToolTip='<%# Eval("AuditCID") & "-" & Eval("AuditC")%>' ImageUrl='<%# Eval("AuditCStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnFinalOuterP" Enabled="false" runat="server" ToolTip='<%# Eval("FinalPID") & "-" & Eval("FinalP")%>' ImageUrl='<%# Eval("FinalPStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="Strb">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnFinalOuterS" Enabled="false" runat="server" ToolTip='<%# Eval("FinalSID") & "-" & Eval("FinalS")%>' ImageUrl='<%# Eval("FinalSStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>                           
                <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnChinesP" Enabled="false" runat="server" ToolTip='<%# Eval("ChinesPID") & "-" & Eval("ChinesP")%>' ImageUrl='<%# Eval("ChinesPStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="Strb">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnChinesS" Enabled="false" runat="server" ToolTip='<%# Eval("ChinesSID") & "-" & Eval("ChinesS")%>' ImageUrl='<%# Eval("ChinesSStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>              
                   <asp:TemplateField HeaderText ="Ctr">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnChinesC" Enabled="false" runat="server" ToolTip='<%# Eval("ChinesCID") & "-" & Eval("ChinesC")%>' ImageUrl='<%# Eval("ChinesCStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>                                  
                 <asp:TemplateField HeaderText="Port">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnTransomP" Enabled="false" runat="server" ToolTip='<%# Eval("TransomPID") & "-" & Eval("TransomP")%>' ImageUrl='<%# Eval("TransomPStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="Strb">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnTransomS" Enabled="false" runat="server" ToolTip='<%# Eval("TransomSID") & "-" & Eval("TransomS")%>' ImageUrl='<%# Eval("TransomSStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>              
                   <asp:TemplateField HeaderText ="Ctr">
                    <ItemTemplate>
                        <asp:ImageButton ID="btnTransomC" Enabled="false" runat="server" ToolTip='<%# Eval("TransomCID") & "-" & Eval("TransomC")%>' ImageUrl='<%# Eval("TransomCStatus", "./Images/{0}.png")%>'/>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>                                
            </Columns>

<HeaderStyle BorderWidth="2px" BorderStyle="Solid"></HeaderStyle>

            <PagerSettings PageButtonCount="15" />
            <RowStyle Height="50px" />
        </asp:GridView>
             
        <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.PopNo , BML_POPREPORTING.SONo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo , BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded, BML_POPREPORTING_GREENLIGHTS.Roller, tubes.RoundSeamerPStatus, tubes.RoundSeamerSStatus, tubes.RoundSeamerCStatus, BML_POPREPORTING_GREENLIGHTS.BracketsStatusP, BML_POPREPORTING_GREENLIGHTS.BracketsStatusS, BML_POPREPORTING_GREENLIGHTS.BracketsStatusCtr, BML_POPREPORTING_GREENLIGHTS.Brackets, BML_POPREPORTING_GREENLIGHTS.ChinesStatusS, BML_POPREPORTING_GREENLIGHTS.ChinesStatusP, BML_POPREPORTING_GREENLIGHTS.ChinesStatusCtr ,BML_POPREPORTING_GREENLIGHTS.Chines, BML_POPREPORTING_GREENLIGHTS.RepairStatusP, BML_POPREPORTING_GREENLIGHTS.RepairStatusS, BML_POPREPORTING_GREENLIGHTS.RepairStatusCtr, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.Repair, BML_POPREPORTING_GREENLIGHTS.RerunP, BML_POPREPORTING_GREENLIGHTS.ReRunSB, BML_POPREPORTING_GREENLIGHTS.RerunPortReason, BML_POPREPORTING_GREENLIGHTS.ReRunPortReqDate, BML_POPREPORTING_GREENLIGHTS.ReRunSBReason, BML_POPREPORTING_GREENLIGHTS.ReRunSBReqDate, Convert(date,BML_POPREPORTING_GREENLIGHTS.DueDate) as DateDue, BML_POPREPORTING_TUBEPRIORITY.TubeSortOrder, (CASE WHEN Tubes.RollerPStatus = 1 THEN 0 ELSE Tubes.RollerPStatus END) as RollerPStatus, (CASE WHEN Tubes.RollerSStatus = 1 THEN 0 ELSE Tubes.RollerSStatus END) as RollerSStatus, (CASE WHEN Tubes.RollerCStatus = 1 THEN 0 ELSE Tubes.RollerCStatus END) as RollerCStatus, SeamerSectPFStatus , SeamerSectPMStatus , SeamerSectPM2Status, SeamerSectPRStatus , SeamerSectSFStatus , SeamerSectSMStatus , SeamerSectSM2Status , SeamerSectSRStatus , SeamerSectCFStatus , SeamerSectCMStatus , SeamerSectCM2Status, SeamerSectCRStatus, BafflesSectPFStatus , BafflesSectPMStatus , BafflesSectPM2Status, BafflesSectPRStatus , BafflesSectSFStatus , BafflesSectSMStatus , BafflesSectSM2Status , BafflesSectSRStatus , BafflesSectCFStatus , BafflesSectCMStatus , BafflesSectCM2Status, BafflesSectCRStatus, Tubes.OuterSections, Tubes.CenterSections,Tubes.OuterScheduled, Tubes.CenterScheduled, Tubes.OuterScheduleOrder, Tubes.CenterScheduleOrder, Tubes.OuterRoller, Tubes.CenterRoller, Tubes.BracketsPStatus, Tubes.BracketsSStatus, Tubes.BracketsCStatus,Tubes.SeamerPFID, Tubes.SeamerPMID, Tubes.SeamerPM2ID, Tubes.SeamerPRID,Tubes.SeamerSFID, Tubes.SeamerSMID, Tubes.SeamerSM2ID, Tubes.SeamerSRID, Tubes.SeamerCFID, Tubes.SeamerCMID, Tubes.SeamerCM2ID, Tubes.SeamerCRID, Tubes.BafflesPFID, Tubes.BafflesPMID, Tubes.BafflesPM2ID, Tubes.BafflesPRID,Tubes.BafflesSFID, Tubes.BafflesSMID, Tubes.BafflesSM2ID, Tubes.BafflesSRID, Tubes.BafflesCFID, Tubes.BafflesCMID, Tubes.BafflesCM2ID, Tubes.BafflesCRID, Tubes.RoundSeamerPID, Tubes.RoundSeamerSID, Tubes.RoundSeamerCID, Tubes.BracketsPID, Tubes.BracketsSID, Tubes.BracketsCID, AirCheckPStatus, AirCheckP, AirCheckSStatus, AirCheckS, AirCheckCStatus, AirCheckC, AirCheckPID, AirCheckSID, AirCheckCID, BracketsP, BracketsS, BracketsC, RoundSeamerP, RoundSeamerS, RoundSeamerC, BafflesSectPF, BafflesSectPR, BafflesSectPM, BafflesSectPM2, BafflesSectSF, BafflesSectSM, BafflesSectSM2, BafflesSectSR, BafflesSectCF, BafflesSectCM, BafflesSectCM2, BafflesSectCR, SeamerSectPF, SeamerSectPM, SeamerSectPM2, SeamerSectPR, SeamerSectSF, SeamerSectSM, SeamerSectSM2, SeamerSectSR, SeamerSectCF, SeamerSectCM, SeamerSectCM2, SeamerSectCR, Repair1PStatus, Repair1PID, Repair1P, Repair1SStatus, Repair1S, Repair1SID, Repair1CStatus, Repair1CID, Repair1C, AirCheck2PStatus, AirCheck2P, AirCheck2SStatus, AirCheck2S, AirCheck2CStatus, AirCheck2C, AirCheck2PID, AirCheck2SID, AirCheck2CID, SeamerSectCR, Repair2PStatus, Repair2PID, Repair2P, Repair2SStatus, Repair2S, Repair2SID, Repair2CStatus, Repair2CID, Repair2C, FinalPStatus, FinalP, FinalPID, FinalSStatus, FinalS, FinalSID, FinalCStatus, FinalC, FinalCID, AuditPStatus, AuditP, AuditPID, AuditSStatus, AuditS, AuditSID, AuditCStatus, AuditC, AuditCID, ChinesPStatus, ChinesP, ChinesPID, ChinesSStatus, ChinesS, ChinesSID, ChinesCStatus, ChinesC, ChinesCID, TransomPStatus, TransomP, TransomPID, TransomSStatus, TransomS, TransomSID, TransomCStatus, TransomC, TransomCID FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo INNER JOIN BML_POPREPORTING_TUBEPRIORITY ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo LEFT JOIN TUBES ON BML_POPREPORTING.ProdNo = Tubes.ProdNo WHERE (BML_POPREPORTING_GREENLIGHTS.ProdNo LIKE '%' + @Search + '%') AND (BML_POPREPORTING_GREENLIGHTS.CusName LIKE '%' + @SearchCusName + '%') AND (BML_POPREPORTING_GREENLIGHTS.ItemNo LIKE '%' + @SearchModel + '%') AND (BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded &gt;= @CentertubeNeeded) AND (BML_POPREPORTING_GREENLIGHTS.CompleteStatus != '2') AND (BML_POPREPORTING_GREENLIGHTS.BUILDLOC LIKE  '%' + @BuildLocation + '%') ORDER BY CASE @OrderBy WHEN 1 THEN BML_POPREPORTING.ProdNo WHEN 2 THEN TubeSortOrder END;">
            <SelectParameters>                              
                <asp:ControlParameter ControlID="tbSearchProdNo" Name="Search" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchCusName" Name="SearchCusName" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="tbSearchModel" Name="SearchModel" DefaultValue='%' Type="String" />  
                 <asp:ControlParameter ControlID="ddlOrderBy" Name="OrderBy" DefaultValue='1' Type="String" />
                <asp:ControlParameter ControlID="ddlCenterNeeded" Name="CentertubeNeeded" DefaultValue ='0' Type="String" />
                <asp:ControlParameter ControlID="ddlBldg" Name="BuildLocation" PropertyName="SelectedValue" DbType="String" />  
             </SelectParameters>            
        </asp:SqlDataSource>
  
    </div>   

  
    </form>
          
</body>
</html>
