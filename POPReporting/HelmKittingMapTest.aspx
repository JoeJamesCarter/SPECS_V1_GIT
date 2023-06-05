<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HelmKittingMapTest.aspx.vb" Inherits="HelmKittingMapTest" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Helm Kits - Testing Colors</title>
    <link rel="stylesheet" href="scripts/css/bootstrap.min.css" />
    <link href="scripts/css/toastr.css" rel="stylesheet" />
    <script src="scripts/jquery-3.5.0.min.js"></script>
    <script src="scripts/bootstrap.min.js"></script>
    <script src="scripts/toastr.min.js"></script>

    <style>
        .green {
            background-color: lightgreen;
            margin: 2px;
            float: left;
        }

        .blue {
            background-color: lightblue;
            margin: 2px;
            float: left;
        }

        .purple {
            background-color: lavender;
            margin: 2px;
            float: left;
        }

        .yellow {
            background-color: lemonchiffon;
            margin: 2px;
            float: left;
        }

        .tan {
            background-color: wheat;
            margin: 2px;
            float: left;
        }

        .silver {
            background-color: silver;
            margin: 2px;
            float: left;
        }

        .peach {
            background-color: peachpuff;
            margin: 2px;
            float: left;
        }
         .white {
            background-color: white;
            margin: 2px;
            float: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid m-1">
              <div class="h4">
                                    <asp:Label ID="Label28" runat="server" Text="Green = Has Furniture and Rails." CssClass="green"></asp:Label>
                                    <asp:Label ID="Label29" runat="server" Text="Blue = Has Furniture, Has Rails Pulled to Panel." CssClass="blue"></asp:Label>
                                    <asp:Label ID="Label30" runat="server" Text="Silver = Has Furniture and Rails But Not Pulled to Panel.  " CssClass="silver"></asp:Label>
                                    <asp:Label ID="Label31" runat="server" Text="Purple = Furniture Yellow and Has All Rails." CssClass="purple"></asp:Label>
                                    <asp:Label ID="Label32" runat="server" Text="Peach = Furniture Green, Missing Rails and Tubes." CssClass="peach"></asp:Label>
                                    <asp:Label ID="Label33" runat="server" Text="Yellow = Furniture Red But Shipped, Might Have All Rails. " CssClass="yellow"></asp:Label>
                                    <asp:Label ID="Label34" runat="server" Text="Tan = Furniture Yellow and Missing Rails. " CssClass="tan"></asp:Label>
                                </div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" Visible="False">
                <ContentTemplate>
                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                    <div class="jumbotron-fluid">
                        <div class="container-fluid" visible="true">
                            <div class="row" >
                                <div class="display-4">
                                    <asp:Label ID="Label2" runat="server" Text=" Kits Completed Today  - " ></asp:Label>
                                    <asp:Label ID="Label3" runat="server" Text="Main: "></asp:Label>
                                    <asp:Label ID="lblMainCompleted" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Label ID="Label5" runat="server" Text="Value: "></asp:Label>
                                    <asp:Label ID="lblValueCompleted" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Label ID="Label4" runat="server" Text="South: "></asp:Label>
                                    <asp:Label ID="lblSouthCompleted" runat="server" Text=""></asp:Label>
                              
                                <div class="h4">
                                    <asp:Label ID="Label6" runat="server" Text="Green = Has Furniture and Rails." CssClass="green"></asp:Label>
                                    <asp:Label ID="Label7" runat="server" Text="Blue = Has Furniture, Has Rails Pulled to Panel." CssClass="blue"></asp:Label>
                                    <asp:Label ID="Label11" runat="server" Text="Silver = Has Furniture and Rails But Not Pulled to Panel.  " CssClass="silver"></asp:Label>
                                    <asp:Label ID="Label8" runat="server" Text="Purple = Furniture Yellow and Has All Rails." CssClass="purple"></asp:Label>
                                    <asp:Label ID="Label12" runat="server" Text="Peach = Furniture Green, Missing Rails and Tubes." CssClass="peach"></asp:Label>
                                    <asp:Label ID="Label9" runat="server" Text="Yellow = Furniture Red But Shipped, Might Have All Rails. " CssClass="yellow"></asp:Label>
                                    <asp:Label ID="Label10" runat="server" Text="Tan = Furniture Yellow and Missing Rails. " CssClass="tan"></asp:Label>
                                </div>
                                      </div>
                            </div>
                            <div class="row display-4">Main & Value</div>
                            <div class="row bg-light" visible="false">
                                <div>
                                    <asp:GridView ID="gvgreenM" runat="server" class="green" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>-                                               
                                                    <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                                    <asp:Label ID="Label14" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                     <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvblueM" runat="server" class="blue" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>-                                               
                                                    <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                                    <asp:Label ID="Label14" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                    <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvSilverM" runat="server" class="silver" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>-                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                      <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div>
                                    <asp:GridView ID="gvpurpleM" runat="server" class="purple" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                      <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvPeachM" runat="server" class="peach" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                      <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvyellowM" runat="server" class="yellow" AutoGenerateColumns="False" ShowHeader="False" AllowPaging="True" PageSize="6">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                     <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div>
                                    <asp:GridView ID="gvtanM" runat="server" class="tan" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                      <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvWhiteM" runat="server" class="white" AutoGenerateColumns="False" ShowHeader="False" AllowPaging="True" PageSize="6">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>-                                               
                                             <asp:Label ID="Label15" runat="server" Text='<%# Eval("BuildLoc")%>'></asp:Label>
                                                      <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                            </div>
                            <hr />
                            <div class="row display-4">South</div>
                            <div class="row" visible="false">
                                <div>
                                    <asp:GridView ID="gvgreenS" runat="server" class="green" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    - 
                                            <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                     <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                   
                                                   
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div>
                                    <asp:GridView ID="gvblueS" runat="server" class="blue" AutoGenerateColumns="false" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                     <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>


                                <div>
                                    <asp:GridView ID="gvSilverS" runat="server" class="silver" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                      <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvpurpleS" runat="server" class="purple" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                      <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvPeachS" runat="server" class="peach" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                      <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvyellowS" runat="server" class="yellow" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                     <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvtanS" runat="server" class="tan" AutoGenerateColumns="False" ShowHeader="False">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                      <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>
                                <div >
                                    <asp:GridView ID="gvWhiteS" runat="server" class="white" AutoGenerateColumns="False" ShowHeader="False" AllowPaging="True" PageSize="6">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label13" runat="server" Text='<%#Eval("Prod") %>'></asp:Label>
                                                    -                                               
                                             <asp:Label ID="lblBoat" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                                    <asp:Table runat="server">
                                                        <asp:TableHeaderRow>
                                                            <asp:TableHeaderCell><asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label19" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label20" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label21" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label></asp:TableHeaderCell>
                                                             <asp:TableHeaderCell><asp:Label ID="Label22" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All Rails"></asp:Label></asp:TableHeaderCell>
                                                            <asp:TableHeaderCell><asp:Label ID="Label23" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Framed"></asp:Label></asp:TableHeaderCell>
                                                        </asp:TableHeaderRow>
                                                        <asp:TableRow>
                                                            <asp:TableCell><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image4" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image5" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image6" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image7" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                            <asp:TableCell><asp:Image ID="Image8" ImageUrl='<%# Eval("FramesInstalledStatus", "Images/{0}.png") %>' runat="server" /></asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </div>

                            </div>


                        </div>
                    </div>

                    <div class="float-lef row w-75 ml-2t">
                        <div class="bg-dark text-light w-100 display-4 mb-1 text-center">
                        </div>
                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="sdsMain" Visible="false">
                            <ItemTemplate>
                                <div id="thiscard" runat="server" class="card text-center float-left border-dark mr-1 mb-1" style="width: 19rem; height: 6rem">
                                    <h5 class="card-header">
                                        <asp:Label ID="lblProd" CssClass="title display-5 w-15 float-left" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><asp:Label ID="lblBldg" CssClass="title display-5 w-15 float-left" runat="server" Text='<%# "-" & Eval("BuildLoc")%>'></asp:Label>
                                        <asp:Label ID="lblBoat" CssClass="boatinfoboat float-right display-5" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                        
                                    </h5>
                                    <%-- <asp:Label ID="Label4" runat="server" cssClass="display-5" Text='<%# SplitBVatDash(Eval("BaseVinylColor"))%>'></asp:Label><br />--%>
                                    <div>
                                        <asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label16" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label><asp:Image ID="Image2" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label27" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="C"></asp:Label><asp:Image ID="Image12" ImageUrl='<%# Eval("CoversStatus", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label1" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label><asp:Image ID="FGI" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label18" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label><asp:Image ID="Image3" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label24" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All R"></asp:Label><asp:Image ID="Image9" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label25" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="T"></asp:Label><asp:Image ID="Image10" ImageUrl='<%# Eval("TubesStatus", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label26" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="C/T" Visible='<%# Eval("CentertubeNeeded") = 1 %>'></asp:Label><asp:Image ID="Image11" ImageUrl='<%# Eval("CentertubeStatus", "Images/{0}.png") %>' Visible='<%# Eval("CentertubeNeeded") = 1 %>' runat="server" />
                                        
                                        <%--  <asp:Button ID="btnBuildSheet" CssClass="btn btn-light btn-sm text-align-center mr-4" runat="server" Text="Print Build Sheet" />--%>
                                        <%--<asp:Button ID="btnKitComplete" CssClass="btn btn-light btn-sm text-align-center ml-4" runat="server" Text="Mark As Kitted" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoupdate" />
                                        <asp:ImageButton ID="ImageButton1" Visible='<%# IIf(Eval("IsPilot").ToString() = "", 0, Eval("IsPilot")) = 1%>' runat="server" ImageUrl="Images/rackmapPilot1.png" />--%>
                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:Repeater>
                        <%-- </div>
                        <div class="float-left">--%>
                        <div class="bg-dark text-light w-100 display-4 mb-1 text-center">
                        </div>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="sdsPopReporting" Visible="false">
                            <ItemTemplate>
                                <div id="thiscard" runat="server" class="card text-center float-left border-dark mr-1 mb-1" style="width: 19rem; height: 6rem">
                                    <h5 class="card-header">
                                        <asp:Label ID="lblProd" CssClass="title display-5 w-15 float-left" runat="server" Text='<%# Eval("ProdNo")%>'></asp:Label><asp:Label ID="lblBldg" CssClass="title display-5 w-15 float-left" runat="server" Text='<%# "-" & Eval("BuildLoc")%>'></asp:Label>
                                        <asp:Label ID="lblBoat" CssClass="boatinfoboat float-right display-5" runat="server" Text='<%# Eval("ItemNo")%>'></asp:Label>
                                    </h5>
                                    <%-- <asp:Label ID="Label4" runat="server" cssClass="display-5" Text='<%# SplitBVatDash(Eval("BaseVinylColor"))%>'></asp:Label><br />--%>
                                    <div>
                                        <asp:Label ID="Label17" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="F"></asp:Label><asp:Image ID="Image1" ImageUrl='<%# Eval("FurnitureStatus", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label16" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FG"></asp:Label><asp:Image ID="Image2" ImageUrl='<%# Eval("FiberglassStatus", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label27" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="C"></asp:Label><asp:Image ID="Image12" ImageUrl='<%# Eval("CoversStatus", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label1" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="FGI"></asp:Label><asp:Image ID="FGI" ImageUrl='<%# Eval("FiberglassInspStatus", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label18" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="R"></asp:Label><asp:Image ID="Image3" ImageUrl='<%# Eval("RailsStatus", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label24" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="Has All R"></asp:Label><asp:Image ID="Image9" ImageUrl='<%# Eval("HasAllRails", "Images/{0}.png") %>' runat="server" />
                                        <asp:Label ID="Label25" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="T"></asp:Label><asp:Image ID="Image10" ImageUrl='<%# Eval("TubesStatus", "Images/{0}.png") %>' runat="server" />
                                      <asp:Label ID="Label26" CssClass="boatinfoboat display-5 mr-1" runat="server" Text="C/T" Visible='<%# Eval("CentertubeNeeded") = 1 %>'></asp:Label><asp:Image ID="Image11" ImageUrl='<%# Eval("CentertubeStatus", "Images/{0}.png") %>' Visible='<%# Eval("CentertubeNeeded") = 1 %>' runat="server" />
                                        <%--<asp:Button ID="btnBuildSheet" CssClass="btn btn-light btn-sm text-align-center mr-4" runat="server" Text="Print Build Sheet" />--%>
                                       <%-- <asp:Button ID="btnKitComplete" CssClass="btn btn-light btn-sm text-align-center ml-4" runat="server" Text="Mark As Kitted" CommandArgument='<%#Eval("ProdNo") %>' CommandName="gotoupdate" />
                                        <asp:ImageButton ID="ImageButton1" Visible='<%# IIf(Eval("IsPilot").ToString() = "", 0, Eval("IsPilot")) = 1%>' runat="server" ImageUrl="Images/rackmapPilot1.png" CssClass="float-right" />--%>
                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:Repeater>
                    </div>                 
                 

                    <asp:SqlDataSource ID="sdsPopReporting" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING_GREENLIGHTS.IsPilot, GaugeStatus, HarnessStatus, FiberglassInspStatus, BML_POPREPORTING.PopNo, 
                        BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus, BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, 
                        BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, 
                        BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, 
                        BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes, BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.NotesHelmKitting, 
                        BML_POPREPORTING_GREENLIGHTS.BuildLoc,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus,  BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded,
                        cast(FurnitureStatus as integer) + cast(FiberglassStatus as integer) + cast(CoversStatus as integer) + cast(RailsStatus as integer) + cast(TubesStatus as integer) + cast(CenterTubeStatus as integer) + cast(GaugeStatus as integer) + cast(HarnessStatus as integer) as GreenStatusTotal, 
                        cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, Case When FiberglassInspStatus = 2 Then 5 Else FiberglassInspStatus End As SortOrder, Case When HasAllRails = 1 then 2 else 0 end as HasAllRails, 
                        BML_POPREPORTING_GREENLIGHTS.BuildLoc,
                        
                        Case When FurnitureStatus = 2 and RailsStatus = 2 then 'green' 
                        when (FurnitureStatus = 2 or FurnitureStatus = 3) and RailsStatus = 1 then 'blue' 
                        when (FurnitureStatus = 2 or FurnitureStatus = 3) and RailsStatus = 0 and HasAllRails = 1 then 'silver' 
                        when FurnitureStatus = 1 and RailsStatus = 0 and HasAllRails = 1 then 'purple'
                        when FurnitureStatus = 2 and RailsStatus = 0 and HasAllRails = 0 and (TubesStatus = 0 or (BML_POPREPORTING_GREENLIGHTS.CenterTubeNeeded = 1 and CentertubeStatus = 0)) then 'peach'
                        end as color,

                        Case When FurnitureStatus = 2 and RailsStatus = 2 then '1' 
                        when (FurnitureStatus = 2 or FurnitureStatus = 3) and RailsStatus = 1 then '2' 
                        when (FurnitureStatus = 2 or FurnitureStatus = 3) and RailsStatus = 0 and HasAllRails = 1 then '3' 
                        else '100' end as displayorder, 
                        
                        Case When BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.CenterTubeStatus =2 then '2'
                        When BML_POPREPORTING_GREENLIGHTS.CenterTubeNeeded = 0 then '2'
                        When BML_POPREPORTING_GREENLIGHTS.CenterTubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.CentertubeStatus <> 2 then '0'
                        end as CenterResult
                        
                        FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo 
                        WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) And 
                        FiberglassStatus = 2 AND 
                        (BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus &lt; 2) AND 
                        (BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus &lt; 2) AND 
                        GaugeStatus = 2 AND 
                        (BML_POPREPORTING_GREENLIGHTS.FiberglassInspStatus &gt; 0) And 
                        BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' ORDER BY displayorder, ProdNo">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="sdsMain" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING_GREENLIGHTS.IsPilot, GaugeStatus, HarnessStatus,  FurnitureStatus, FiberglassStatus, 
                        BML_POPREPORTING_GREENLIGHTS.RailsStatus, FiberglassInspStatus, BML_POPREPORTING.PopNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.SONo, BML_POPREPORTING.BaseVinylColor, BML_POPREPORTING.IsCustom, BML_POPREPORTING.ItemNo, BML_POPREPORTING_GREENLIGHTS.FurnitureStatus,
                        BML_POPREPORTING_GREENLIGHTS.FiberglassStatus, BML_POPREPORTING_GREENLIGHTS.CoversStatus, BML_POPREPORTING_GREENLIGHTS.RailsStatus, BML_POPREPORTING_GREENLIGHTS.TubesStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FramesInstalled, 
                        BML_POPREPORTING_GREENLIGHTS.FloorsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus, BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus, BML_POPREPORTING_GREENLIGHTS.CleaningStatus, 
                        BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus, BML_POPREPORTING_GREENLIGHTS.CompleteStatus, BML_POPREPORTING_GREENLIGHTS.BoatHasNotes,
                        BML_POPREPORTING_GREENLIGHTS.IsBoatOffline, BML_POPREPORTING_GREENLIGHTS.NotesHelmKitting, BML_POPREPORTING_GREENLIGHTS.BuildLoc,  BML_POPREPORTING_GREENLIGHTS.CentertubeStatus, BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded,                      
                        cast(FurnitureStatus as integer) + cast(FiberglassStatus as integer) + cast(CoversStatus as integer) + cast(RailsStatus as integer) + cast(TubesStatus as integer) + cast(CenterTubeStatus as integer) + cast(GaugeStatus as integer) + cast(HarnessStatus as integer) as GreenStatusTotal, 
                        cast(BML_POPREPORTING_GREENLIGHTS.GaugeStatus as varchar) + cast(BML_POPREPORTING_GREENLIGHTS.HarnessStatus as varchar) as ElectricalStatus, Case When FiberglassInspStatus = 2 Then 5 Else FiberglassInspStatus End As SortOrder, Case When HasAllRails = 1 then 2 else 0 end as HasAllRails,  
                        BML_POPREPORTING_GREENLIGHTS.BuildLoc,

                        Case When FurnitureStatus = 2 and RailsStatus = 2 then 'green' 
                        when (FurnitureStatus = 2 or FurnitureStatus = 3) and RailsStatus = 1 then 'blue' 
                        when (FurnitureStatus = 2 or FurnitureStatus = 3) and RailsStatus = 0 and HasAllRails = 1 then 'silver'
                        when FurnitureStatus = 1 and RailsStatus = 0 and HasAllRails = 1 then 'purple'
                        when FurnitureStatus = 2 and RailsStatus = 0 and HasAllRails = 0 and (TubesStatus = 0 or (BML_POPREPORTING_GREENLIGHTS.CenterTubeNeeded = 1 and CentertubeStatus = 0)) then 'peach'
                        end as color,

                        Case When FurnitureStatus = 2 and RailsStatus = 2 then '1' 
                        when (FurnitureStatus = 2 or FurnitureStatus = 3) and RailsStatus = 1 then '2' 
                        when (FurnitureStatus = 2 or FurnitureStatus = 3) and RailsStatus = 0 and HasAllRails = 1 then '3' 
                        else'100' end as displayorder,
                        
                        Case When BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.CenterTubeStatus =2 then '2'
                        When BML_POPREPORTING_GREENLIGHTS.CenterTubeNeeded = 0 then '2'
                        When BML_POPREPORTING_GREENLIGHTS.CenterTubeNeeded = 1 and BML_POPREPORTING_GREENLIGHTS.CentertubeStatus <> 2 then '0'
                        end as CenterResult

                        FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on BML_POPREPORTING.ProdNo = Rails_Tracking.ProdNo 
                        WHERE (BML_POPREPORTING_GREENLIGHTS.CompleteStatus = @CompleteStatus) And 
                        FiberglassStatus = 2 AND (BML_POPREPORTING_GREENLIGHTS.HelmKittingStatus &lt; 2) AND 
                        (BML_POPREPORTING_GREENLIGHTS.HelmBuildStatus &lt; 2) AND GaugeStatus = 2 AND 
                        (BML_POPREPORTING_GREENLIGHTS.FiberglassInspStatus &gt; 0) And 
                        (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' or BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V') ORDER By displayorder, ProdNo">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="CompleteStatus" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
          <div>
              <asp:GridView runat="server" ID="gvSouth" DataSourceID="sdsPopReporting" AutoGenerateColumns="False" DataKeyNames="PopNo" Caption="South" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2">
                  <Columns>
                      <asp:BoundField DataField="ProdNo" HeaderText="ProdNo" SortExpression="ProdNo"></asp:BoundField>
                      <asp:BoundField DataField="IsPilot" HeaderText="IsPilot" SortExpression="IsPilot"></asp:BoundField>
                      <asp:BoundField DataField="FiberglassInspStatus" HeaderText="FiberglassInspStatus" SortExpression="FiberglassInspStatus"></asp:BoundField>
                      <asp:BoundField DataField="IsCustom" HeaderText="IsCustom" SortExpression="IsCustom"></asp:BoundField>
                      <asp:BoundField DataField="ItemNo" HeaderText="ItemNo" SortExpression="ItemNo"></asp:BoundField>
                      <asp:BoundField DataField="FurnitureStatus" HeaderText="FurnitureStatus" SortExpression="FurnitureStatus"></asp:BoundField>                     
                      <asp:BoundField DataField="RailsStatus" HeaderText="RailsStatus" SortExpression="RailsStatus"></asp:BoundField>
                      <asp:BoundField DataField="HasAllRails" HeaderText="HasAllRails" ReadOnly="True" SortExpression="HasAllRails"></asp:BoundField>
                      <asp:BoundField DataField="TubesStatus" HeaderText="TubesStatus" SortExpression="TubesStatus"></asp:BoundField>
                       <asp:BoundField DataField="CoversStatus" HeaderText="CoversStatus" SortExpression="CoversStatus"></asp:BoundField>
                      <asp:BoundField DataField="FramesInstalledStatus" HeaderText="FramesInstalledStatus" SortExpression="FramesInstalledStatus"></asp:BoundField>                     
                      <asp:BoundField DataField="FloorsInstalledStatus" HeaderText="FloorsInstalledStatus" SortExpression="FloorsInstalledStatus"></asp:BoundField>
                 <%--     <asp:BoundField DataField="CentertubeStatus" HeaderText="CentertubeStatus" SortExpression="CentertubeStatus"></asp:BoundField>
                      <asp:BoundField DataField="CentertubeNeeded" HeaderText="CentertubeNeeded" SortExpression="CentertubeNeeded"></asp:BoundField>--%>
                      <asp:BoundField DataField="CenterResult" HeaderText="CenterResult" SortExpression="CenterResult"></asp:BoundField>
                      <asp:BoundField DataField="GaugeStatus" HeaderText="GaugeStatus" ReadOnly="True" SortExpression="GaugeStatus"></asp:BoundField>
                      <asp:BoundField DataField="HarnessStatus" HeaderText="HarnessStatus" ReadOnly="True" SortExpression="HarnessStatus"></asp:BoundField>
                      <asp:BoundField DataField="color" HeaderText="color" ReadOnly="True" SortExpression="color"></asp:BoundField>


                  </Columns>
                  <FooterStyle BackColor="#CCCCCC"></FooterStyle>

                  <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>

                  <PagerStyle HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black"></PagerStyle>

                  <RowStyle BackColor="White"></RowStyle>

                  <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                  <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

                  <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>

                  <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

                  <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
              </asp:GridView>
              <asp:GridView runat="server" ID="gvMainValue" DataSourceID="sdsMain" AutoGenerateColumns="False" DataKeyNames="PopNo" Caption="Main/Value" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2">
                  <Columns>
                      <asp:BoundField DataField="ProdNo" HeaderText="ProdNo" SortExpression="ProdNo"></asp:BoundField>
                      <asp:BoundField DataField="IsPilot" HeaderText="IsPilot" SortExpression="IsPilot"></asp:BoundField>
                      <asp:BoundField DataField="FurnitureStatus" HeaderText="FurnitureStatus" SortExpression="FurnitureStatus"></asp:BoundField>
                      <asp:BoundField DataField="RailsStatus" HeaderText="RailsStatus" SortExpression="RailsStatus"></asp:BoundField>
                      <asp:BoundField DataField="FiberglassInspStatus" HeaderText="FiberglassInspStatus" SortExpression="FiberglassInspStatus"></asp:BoundField>
                      <asp:BoundField DataField="IsCustom" HeaderText="IsCustom" SortExpression="IsCustom"></asp:BoundField>
                      <asp:BoundField DataField="ItemNo" HeaderText="ItemNo" SortExpression="ItemNo"></asp:BoundField>
                      <asp:BoundField DataField="FurnitureStatus1" HeaderText="FurnitureStatus1" SortExpression="FurnitureStatus1"></asp:BoundField>                      
                      <asp:BoundField DataField="RailsStatus1" HeaderText="RailsStatus1" SortExpression="RailsStatus1"></asp:BoundField>
                      <asp:BoundField DataField="HasAllRails" HeaderText="HasAllRails" ReadOnly="True" SortExpression="HasAllRails"></asp:BoundField>
                      <asp:BoundField DataField="TubesStatus" HeaderText="TubesStatus" SortExpression="TubesStatus"></asp:BoundField>
                      <asp:BoundField DataField="CoversStatus" HeaderText="CoversStatus" SortExpression="CoversStatus"></asp:BoundField>
                      <asp:BoundField DataField="FramesInstalledStatus" HeaderText="FramesInstalledStatus" SortExpression="FramesInstalledStatus"></asp:BoundField>                      
                     <%-- <asp:BoundField DataField="CentertubeStatus" HeaderText="CentertubeStatus" SortExpression="CentertubeStatus"></asp:BoundField>
                      <asp:BoundField DataField="CentertubeNeeded" HeaderText="CentertubeNeeded" SortExpression="CentertubeNeeded"></asp:BoundField>--%>
                      <asp:BoundField DataField="CenterResult" HeaderText="CenterResult" SortExpression="CenterResult"></asp:BoundField>
                      <asp:BoundField DataField="GaugeStatus" HeaderText="GaugeStatus" ReadOnly="True" SortExpression="GaugeStatus"></asp:BoundField>
                      <asp:BoundField DataField="HarnessStatus" HeaderText="HarnessStatus" ReadOnly="True" SortExpression="HarnessStatus"></asp:BoundField>
                      <asp:BoundField DataField="BuildLoc1" HeaderText="BuildLoc1" SortExpression="BuildLoc1"></asp:BoundField>
                      <asp:BoundField DataField="color" HeaderText="color" ReadOnly="True" SortExpression="color"></asp:BoundField>
                  </Columns>
                  <FooterStyle BackColor="#CCCCCC"></FooterStyle>

                  <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>

                  <PagerStyle HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black"></PagerStyle>

                  <RowStyle BackColor="White"></RowStyle>

                  <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                  <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

                  <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>

                  <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

                  <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
              </asp:GridView>

                    </div>

    </form>
</body>
</html>
