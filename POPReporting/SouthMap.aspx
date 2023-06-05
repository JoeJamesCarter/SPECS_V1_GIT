<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SouthMap.aspx.vb" Inherits="SouthMap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>South Map</title>
    <style>
        .area {
            text-align: center;
            vertical-align: central;
            font-size: 20px;
            font-family: Calibri;
            font-weight: bold;
        }

            .area caption {
                display: table-caption;
                text-align: left;
                color: blue;
            }

        .title {
            font-family: Calibri;
            font-weight: bold;
            font-size: 30px;
        }

        .subtitle {
            font-family: Calibri;
            font-weight: bold;
            font-size: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:Button ID="Button1" runat="server" Text="Button" Visible="False" />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                <ContentTemplate>
                    <asp:Timer ID="Timer1" runat="server" ClientIDMode="AutoID" Interval="30000" OnTick="Timer1_Tick"></asp:Timer>
                    <asp:Label runat="server" CssClass="title" Text="South Boats Online"></asp:Label>&nbsp;&nbsp;&nbsp;<asp:Label ID="Label1" CssClass="subtitle" runat="server" Text=""></asp:Label>
                       <asp:DataList ID="dlRails" CssClass="area" runat="server" DataSourceID="sdsRails" RepeatColumns="6" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="READY FOR RAILS" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                             <asp:GridView ID="gvReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsOfflineReasons" Width="300px" AutoGenerateColumns="False" style="text-align: left" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="Auto" Visible="False" />
                                <asp:BoundField DataField="OfflineNote" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:M/d}" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:TemplateField>
                                    <ItemTemplate>
                                    <asp:Label runat="server" Text="ETA:"></asp:Label>
                                    <asp:Label runat="server" Text='<%#Eval("ETA") %>'></asp:Label>
                                        </ItemTemplate>
                                </asp:TemplateField>                                 
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsOfflineReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date, BML_POPREPORTING_OFFLINE.Cleared, BML_POPREPORTING_OFFLINE.ETA, BML_POPREPORTING_OFFLINE.ETADate FROM BML_POPREPORTING_OFFLINE WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) Order By BML_POPREPORTING_OFFLINE.Date">
                            <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                        </asp:SqlDataSource>                                       
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsRails" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.RailsInstalledStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE IsDeckInside = 1 and RailsInstalledStatus < 2 ORDER BY BML_POPREPORTING_GREENLIGHTS.ProdNo"></asp:SqlDataSource>
        
                    
                     <asp:DataList ID="dlFurniture" CssClass="area" runat="server" DataSourceID="sdsFurniture" RepeatColumns="6" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="FURNITURE" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:GridView ID="gvReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsOfflineReasons" Width="300px" AutoGenerateColumns="False" style="text-align: left" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="Auto" Visible="False" />
                                <asp:BoundField DataField="OfflineNote" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:M/d}" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:TemplateField>
                                    <ItemTemplate>
                                    <asp:Label runat="server" Text="ETA:"></asp:Label>
                                    <asp:Label runat="server" Text='<%#Eval("ETA") %>'></asp:Label>
                                        </ItemTemplate>
                                </asp:TemplateField>                                 
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsOfflineReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date, BML_POPREPORTING_OFFLINE.Cleared, BML_POPREPORTING_OFFLINE.ETA, BML_POPREPORTING_OFFLINE.ETADate FROM BML_POPREPORTING_OFFLINE WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) Order By BML_POPREPORTING_OFFLINE.Date">
                            <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                        </asp:SqlDataSource>                                       
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsFurniture" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([FurnitureInstalledStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlHelms" CssClass="area" runat="server" DataSourceID="sdsHelms" RepeatColumns="6" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="HELMS" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                           <asp:GridView ID="gvReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsOfflineReasons" Width="300px" AutoGenerateColumns="False" style="text-align: left" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="Auto" Visible="False" />
                                <asp:BoundField DataField="OfflineNote" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:M/d}" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:TemplateField>
                                    <ItemTemplate>
                                    <asp:Label runat="server" Text="ETA:"></asp:Label>
                                    <asp:Label runat="server" Text='<%#Eval("ETA") %>'></asp:Label>
                                        </ItemTemplate>
                                </asp:TemplateField>                                 
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsOfflineReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date, BML_POPREPORTING_OFFLINE.Cleared, BML_POPREPORTING_OFFLINE.ETA, BML_POPREPORTING_OFFLINE.ETADate FROM BML_POPREPORTING_OFFLINE WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) Order By BML_POPREPORTING_OFFLINE.Date">
                            <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                        </asp:SqlDataSource>                                       
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsHelms" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([HelmInstalledStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S') Order By ProdNo"></asp:SqlDataSource>


                    <asp:DataList ID="dlInspection" CssClass="area" runat="server" DataSourceID="sdsInspection" RepeatColumns="6" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="INSPECTION" CellPadding="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                             <asp:GridView ID="gvReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsOfflineReasons" Width="300px" AutoGenerateColumns="False" style="text-align: left" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="Auto" Visible="False" />
                                <asp:BoundField DataField="OfflineNote" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:M/d}" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:TemplateField>
                                    <ItemTemplate>
                                    <asp:Label runat="server" Text="ETA:"></asp:Label>
                                    <asp:Label runat="server" Text='<%#Eval("ETA") %>'></asp:Label>
                                        </ItemTemplate>
                                </asp:TemplateField>                                 
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsOfflineReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date, BML_POPREPORTING_OFFLINE.Cleared, BML_POPREPORTING_OFFLINE.ETA, BML_POPREPORTING_OFFLINE.ETADate FROM BML_POPREPORTING_OFFLINE WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) Order By BML_POPREPORTING_OFFLINE.Date">
                            <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                        </asp:SqlDataSource>                           
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsInspection" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.CleaningStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([CleaningStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlFinal" CssClass="area" runat="server" DataSourceID="sdsFinal" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="FINAL INSPECTION" CellPadding="6" RepeatColumns="6">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label><br />
                             <asp:GridView ID="gvReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsOfflineReasons" Width="300px" AutoGenerateColumns="False" style="text-align: left" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="Auto" Visible="False" />
                                <asp:BoundField DataField="OfflineNote" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:M/d}" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:TemplateField>
                                    <ItemTemplate>
                                    <asp:Label runat="server" Text="ETA:"></asp:Label>
                                    <asp:Label runat="server" Text='<%#Eval("ETA") %>'></asp:Label>
                                        </ItemTemplate>
                                </asp:TemplateField>                                 
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsOfflineReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date, BML_POPREPORTING_OFFLINE.Cleared, BML_POPREPORTING_OFFLINE.ETA, BML_POPREPORTING_OFFLINE.ETADate FROM BML_POPREPORTING_OFFLINE WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) Order By BML_POPREPORTING_OFFLINE.Date">
                            <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                        </asp:SqlDataSource>                                       
                        </ItemTemplate>
                        <SeparatorStyle Height="20px" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsFinal" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([FinalInspectionStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlShrink" CssClass="area" runat="server" DataSourceID="sdsShrink" RepeatColumns="6" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="SHRINKWRAP" Visible="True">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                             <asp:GridView ID="gvReasons" runat="server" DataKeyNames="ProdNo" DataSourceID="sdsOfflineReasons" Width="300px" AutoGenerateColumns="False" style="text-align: left" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="Auto" Visible="False" />
                                <asp:BoundField DataField="OfflineNote" >
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:M/d}" >                                
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Font-Size="14pt" HorizontalAlign="Center" />
                                </asp:BoundField>
                                 <asp:TemplateField>
                                    <ItemTemplate>
                                    <asp:Label runat="server" Text="ETA:"></asp:Label>
                                    <asp:Label runat="server" Text='<%#Eval("ETA") %>'></asp:Label>
                                        </ItemTemplate>
                                </asp:TemplateField>                                 
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsOfflineReasons" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING_OFFLINE.ProdNo, BML_POPREPORTING_OFFLINE.Auto, BML_POPREPORTING_OFFLINE.OfflineNote, BML_POPREPORTING_OFFLINE.Workcenter, BML_POPREPORTING_OFFLINE.Date, BML_POPREPORTING_OFFLINE.Cleared, BML_POPREPORTING_OFFLINE.ETA, BML_POPREPORTING_OFFLINE.ETADate FROM BML_POPREPORTING_OFFLINE WHERE (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') AND (BML_POPREPORTING_OFFLINE.ProdNo = @ProdNo) Order By BML_POPREPORTING_OFFLINE.Date">
                            <SelectParameters>
                                    <asp:Parameter Name="ProdNo" Type="Int32" />
                                </SelectParameters>
                        </asp:SqlDataSource>           
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsShrink" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([ShrinkwrapStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlRigging" CssClass="area" runat="server" DataSourceID="sdsRigging" RepeatColumns="6" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="RIGGING" Visible="False">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotodetails" />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsRigging" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.RiggingStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([RiggingStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlWavetamer" CssClass="area" runat="server" DataSourceID="sdsWavetamer" RepeatColumns="6" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="WAVETAMER" Visible="False">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotodetails" />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsWavetamer" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.WavetamerStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([WavetamerStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S') Order By ProdNo"></asp:SqlDataSource>

                    <asp:DataList ID="dlSharkhide" CssClass="area" runat="server" DataSourceID="sdsSharkhide" RepeatColumns="6" RepeatDirection="Horizontal" SeparatorStyle-Height="20px" CaptionAlign="Left" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="2" ItemStyle-Width="150px" ItemStyle-Height="100px" Caption="SHARKHIDE" Visible="False">
                        <ItemStyle BorderStyle="Solid" BorderWidth="2px" Height="100px" Width="150px" />
                        <ItemTemplate>
                            <asp:Label ID="lbl" runat="server" Text='<%# Eval("ProdNo") & "</br>" & Eval("ItemNo")%>'></asp:Label>
                            <asp:ImageButton ID="ImageButton1" ImageUrl='Images/getboatdetails.png' runat="server" CommandArgument='<%# Eval("ProdNo")%>' CommandName="gotodetails" />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsSharkhide" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT BML_POPREPORTING.ProdNo, BML_POPREPORTING.CusNo, BML_POPREPORTING.CusName, BML_POPREPORTING.ItemNo, BML_POPREPORTING.DueDate, BML_POPREPORTING_GREENLIGHTS.BuildLoc, BML_POPREPORTING_GREENLIGHTS.SharkhideStatus FROM [BML_POPREPORTING] Left JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo WHERE ([SharkhideStatus] = '1') and (BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S') Order By ProdNo"></asp:SqlDataSource>
                    
                    
                    
                    
                    </div>
                    
                </ContentTemplate>
            </asp:UpdatePanel>
    </form>
</body>
</html>
