<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OverviewWarranty.aspx.vb" Inherits="Warranty_OverviewWarranty"  Debug="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Overview - Warranty Repairs</title>
    <style type="text/css">
        .newStyle1 {
            font-family: Calibri;
            font-size: 18px;
            text-align: left;
        }
         .newStyle2 {
            font-family: Calibri;
            font-size: 16px;
            text-align: left;
            font-weight:bold;
        }
    </style>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
    $("[src*=plus]").live("click", function () {
        $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
        $(this).attr("src", "../Images/minus.png");
    });
    $("[src*=minus]").live("click", function () {
        $(this).attr("src", "../Images/plus.png");
        $(this).closest("tr").next().remove();
    });
</script>   
</head>
<body>
    <form id="form1" runat="server">
    <div>  
        <asp:Image ID="Image1" runat="server" ImageUrl="../Images/logo-smaller.png" ImageAlign="AbsMiddle" />
        <span class="newStyle2">Search By Serial #: </span><asp:TextBox ID="tbSerial" runat="server"></asp:TextBox>
        <span class="newStyle2">Consumer: </span><asp:TextBox ID="tbConsumer" runat="server"></asp:TextBox>
        <span class="newStyle2">Dealer: </span><asp:TextBox ID="tbDealer" runat="server"></asp:TextBox>        
        <span class="newStyle2">Show:</span><asp:DropDownList ID="ddlShow" runat="server" AutoPostBack="True">
            <asp:ListItem Value="1">Open Jobs</asp:ListItem>
            <asp:ListItem Value="2">All Jobs</asp:ListItem>           
        </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" />
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnClear" runat="server" Text="Clear" />

        <br />
        <br />
        
            <asp:GridView ID="gvWarrantyBoats" runat="server" AutoGenerateColumns="False" DataKeyNames="RProdNo" DataSourceID="sdsWarrantyBoats" CssClass="newStyle1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Both">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <img alt = "" style="cursor: pointer" src="../Images/plus.png" />                           
                             <asp:Panel ID="Panel1" runat="server" Style="display: none">
                                 <asp:GridView ID="gvWarrantyWork" runat="server" AutoGenerateColumns="False" DataKeyNames="RProdNo" DataSourceID="sdsWarrantyWork" CssClass="newStyle1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                                     <Columns> 
                                          <asp:TemplateField HeaderText="Initial Inspection">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnUpdateInitInsp" runat="server"  Enabled =' <%# Eval("InitialInspection") >= 1%>' ImageUrl='<%# Eval("InitialInspection", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>"  CommandName="gotoupdateInitInsp"/>                                                                           
                                            </ItemTemplate>
                                             <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Initial Photos">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnUpdateInitialPhotos" runat="server"  Enabled =' <%# Eval("InitialPhotosTaken") >= 1%>' ImageUrl='<%# Eval("InitialPhotosTaken", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>"  CommandName="gotoupdateInitPhotos"/><br />                                                                        
                                                <asp:Button ID="btnShowInitPhotos" runat="server" Text="View" />
                                            </ItemTemplate>
                                             <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>                                       
                                         <asp:TemplateField HeaderText="Tubes" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                               <asp:Image ID="imgTubeStatus" runat="server" ImageUrl='<%# Eval("TubesStatus", "../Images/{0}.png")%>' /> 
                                               <asp:RadioButtonList ID="rblTubeStatus" SelectedValue ='<%# Bind("TubesStatus") %>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList>
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center"/>
                                         </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Frames" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgFramesStatus" runat="server" ImageUrl='<%# Eval("FramesStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblFramesStatus" SelectedValue ='<%# Bind("FramesStatus")%>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Floors" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgFloorsStatus" runat="server" ImageUrl='<%# Eval("FloorsStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblFloorsStatus" SelectedValue ='<%# Bind("FloorsStatus")%>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Rails" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgRailsStatus" runat="server" ImageUrl='<%# Eval("RailsStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblRailsStatus" SelectedValue ='<%# Bind("RailsStatus") %>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem> 
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Furniture" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgFurnitureStatus" runat="server" ImageUrl='<%# Eval("FurnitureStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblFurnitureStatus" SelectedValue ='<%# Bind("FurnitureStatus")%>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Helm" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgHelmStatus" runat="server" ImageUrl='<%# Eval("HelmStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblHelmStatus" SelectedValue ='<%# Bind("HelmStatus")%>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Cleaning" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgCleaningStatus" runat="server" ImageUrl='<%# Eval("CleaningStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblCleaningStatus" SelectedValue ='<%# Bind("CleaningStatus")%>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Inspection" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgInspectionStatus" runat="server" ImageUrl='<%# Eval("FinalInspectionStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblInspectionStatus" SelectedValue ='<%# Bind("FinalInspectionStatus")%>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Personal Items" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgPersonalItemsInBoatStatus" runat="server" ImageUrl='<%# Eval("PersonalItemsInBoatStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblPersonalItemsStatus" SelectedValue ='<%# Bind("PersonalItemsInBoatStatus")%>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Needed</asp:ListItem>
                                               <asp:ListItem Value="2">In Boat</asp:ListItem>
                                               </asp:RadioButtonList> 
                                                 <asp:Button ID="btnShowPersonalItems" runat="server" Text="View" CommandName="gotoViewPersonalItems" Visble='<%# Eval("PersonalItemsInBoatStatus") = 1%>' />
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Shrinkwrap" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgShrinkwrapStatus" runat="server" ImageUrl='<%# Eval("ShrinkStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblShrinkwrapStatus" SelectedValue ='<%# Bind("ShrinkStatus")%>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Rigging" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgRiggingStatus" runat="server" ImageUrl='<%# Eval("RiggingStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblRiggingStatus" SelectedValue ='<%# Bind("RiggingStatus")%>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Wavetamer" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgWavetamerStatus" runat="server" ImageUrl='<%# Eval("WavetamerStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblWaveTamerStatus" SelectedValue ='<%# Bind("WavetamerStatus")%>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>                                       
                                         <asp:TemplateField HeaderText="Sharkhide" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgSharkhideStatus" runat="server" ImageUrl='<%# Eval("SharkhideStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblSharkhideStatus" SelectedValue ='<%# Bind("SharkhideStatus") %>' runat="server">
                                               <asp:ListItem Value="0">N/A</asp:ListItem>
                                               <asp:ListItem Value="1">Not Started</asp:ListItem>
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>                                        
                                         <asp:TemplateField HeaderText="Final Photos" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                               <asp:ImageButton ID="btnFinalPhotos" runat="server"  Enabled =' <%# Eval("UploadFinalPhotos") >= 1%>' ImageUrl='<%# Eval("UploadFinalPhotos", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>"  CommandName="gotoupdateFinalPhotos"/><br />              
                                             <asp:Button ID="btnShowFinalPhotos" runat="server" Text="View" />
                                             </ItemTemplate>                                               
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Attach Forms" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                               <asp:ImageButton ID="btnAttachForms" runat="server"  Enabled =' <%# Eval("AttachedForms") >= 1%>' ImageUrl='<%# Eval("AttachedForms", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>"  CommandName="gotoupdateAttachForms"/><br />              
                                             <asp:Button ID="btnShowAttachForms" runat="server" Text="View" />
                                             </ItemTemplate>                                               
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Request Return" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                               <asp:ImageButton ID="btnUpdateReqReturn" runat="server"  Enabled =' <%# Eval("ReturnRequested") >= 1%>' ImageUrl='<%# Eval("ReturnRequested", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>"  CommandName="gotoupdateReqReturn"/>             
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Complete" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                <asp:Image ID="imgCompleteStatus" runat="server" ImageUrl='<%# Eval("CompleteStatus", "../Images/{0}.png")%>' /> 
                                                  <asp:RadioButtonList ID="rblCompleteStatus" SelectedValue ='<%# Bind("CompleteStatus") %>' runat="server">
                                               <asp:ListItem Value="0">Not Started</asp:ListItem>
                                               <asp:ListItem Value="1">In Progress</asp:ListItem>                                               
                                               <asp:ListItem Value="2">Complete</asp:ListItem>
                                               </asp:RadioButtonList> 
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>                                         
                                     </Columns>
                                      <FooterStyle BackColor="#CCCCCC" />
                                        <HeaderStyle HorizontalAlign="Center" BackColor="Black" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                        <SortedAscendingHeaderStyle BackColor="Gray" />
                                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                        <SortedDescendingHeaderStyle BackColor="#383838" />

                                 </asp:GridView>
                             </asp:Panel>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Boat">
                        <ItemTemplate>
                            <strong>Repair #: </strong><asp:Label ID="Label1" runat="server" Text='<%#Eval("RProdNo")%>'></asp:Label><br />
                            <strong>Orig. Prod #: </strong> <asp:Label ID="Label4" runat="server" Text='<%#Eval("OrigProdNo")%>'></asp:Label><br />
                            <asp:Label ID="Label2" runat="server" Text='<%#Eval("Serial")%>'></asp:Label><br />
                            <asp:Label ID="Label3" runat="server" Text='<%#Eval("Model")%>'></asp:Label>
                            <asp:SqlDataSource ID="sdsWarrantyWork" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [BML_POPREPORTING_WARRANTY] WHERE ([RProdNo] = @RProdNo)">
                                <SelectParameters>
                                    <asp:Parameter Name="RProdNo" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Request">
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%#Eval("DateRequested", "{0:d}")%>'></asp:Label><br />
                            <asp:Label ID="Label6" runat="server" Text='<%#Eval("RequestedBy")%>'></asp:Label><br />                                  
                            <asp:Button ID="btnShowRequest" runat="server" Text="View" CommandArgument="<%# Container.DataItemIndex %>" CommandName="showrequest" />                       
                        </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Dealer">
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%#Eval("DealerDBA")%>'></asp:Label><br />
                            Dlr #: <asp:Label ID="Label9" runat="server" Text='<%#Eval("DealerNo")%>'></asp:Label><br />                          
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Consumer/Contact" ItemStyle-Width="350px">
                        <ItemTemplate>
                            <strong>Consumer: </strong><asp:Label ID="Label10" runat="server" Text='<%#Eval("Consumer")%>'></asp:Label><br />
                            <strong>Contact: </strong> <asp:Label ID="Label11" runat="server" Text='<%#Eval("PrimaryContact")%>'></asp:Label><br />  
                            <strong>E: </strong> <asp:Label ID="Label12" runat="server" Text='<%#Eval("PrimaryEmail")%>'></asp:Label><br />  
                            <strong>Ph: </strong> <asp:Label ID="Label13" runat="server" Text='<%#Eval("PrimaryPhone")%>'></asp:Label><br />                          
                        </ItemTemplate>

<ItemStyle Width="350px"></ItemStyle>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Return Via" ItemStyle-Width="200px">
                        <ItemTemplate>
                            <strong>Via:</strong> <asp:Label ID="Label14" runat="server" Text='<%#Eval("ReturnBenVia")%>'></asp:Label><br />
                            <strong>Trailer Owner:</strong>  <asp:Label ID="Label15" runat="server" Text='<%#Eval("TrailerOwner")%>'></asp:Label><br />  
                            <strong>Trailer ID:</strong>  <asp:Label ID="Label16" runat="server" Text='<%#Eval("TrailerID")%>'></asp:Label><br />  
                            <strong>Arrived:</strong>  <asp:Label ID="Label17" runat="server" Text='<%#Eval("ArrivalDate")%>'></asp:Label><br />                          
                        </ItemTemplate>

<ItemStyle Width="200px"></ItemStyle>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Service Requested">
                        <ItemTemplate>
                            <asp:Label ID="Label19" runat="server" Text='<%#Eval("ServicesRequired")%>'></asp:Label><br />  
                            <strong>Est. Start Date: </strong><asp:Label ID="Label24" runat="server" Text='<%#Eval("EstStartDate", "{0:d}")%>'></asp:Label><br />       
                            <strong>Target Return:    </strong><asp:Label ID="Label23" runat="server" Text='<%#Eval("TargetReturnDate", "{0:d}")%>'></asp:Label><br />                       
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Special Instructions">
                        <ItemTemplate>
                            <asp:Label ID="Label18" runat="server" Text='<%#Eval("SpecialInstr")%>'></asp:Label><br />                       
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Request Pickup">
                        <ItemTemplate>
                           <asp:ImageButton ID="btnUpdateReqPU" runat="server"  Enabled =' <%# Eval("InitialPickupRequested") >= 1%>' ImageUrl='<%# Eval("InitialPickupRequested", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>"  CommandName="gotoupdatePU"/>                                   
                        </ItemTemplate>
                         <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Arrived">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnUpdateArrived" runat="server"  Enabled =' <%# Eval("Arrived") >= 1%>' ImageUrl='<%# Eval("Arrived", "../Images/complete_status{0}.png")%>' CommandArgument="<%# Container.DataItemIndex %>"  CommandName="gotoupdateArrived"/>                                                        
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                   
                    
                    <asp:TemplateField HeaderText="Location">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlLocation" SelectedValue ='<%# Bind("Location") %>' runat="server">
                                <asp:ListItem>N/A</asp:ListItem>
                                <asp:ListItem>Repair</asp:ListItem>
                                <asp:ListItem>Storage</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Storage Location">
                        <ItemTemplate>
                            <asp:TextBox ID="tbStorageLocation" Text ='<%# Bind("StorageLocation") %>' runat="server"></asp:TextBox>
                            <br />                       
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Notes" HeaderStyle-HorizontalAlign="Center">
                                             <ItemTemplate>                                              
                                                 <asp:TextBox ID="tbNotes" Text ='<%# Bind("Notes") %>' runat="server" TextMode="MultiLine"></asp:TextBox>
                                             </ItemTemplate>
                                             <ItemStyle HorizontalAlign ="Center" />
                                         </asp:TemplateField>
                     <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Image ID="imgCompleteStatus" runat="server" ImageUrl='<%# Eval("CompleteStatus", "../Images/{0}.png")%>' />                    
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Save">
                        <ItemTemplate>
                            <asp:Button ID="btnSave" runat="server" Text="Save" CommandName="Save" CommandArgument="<%# Container.DataItemIndex%>" />              
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle HorizontalAlign="Center" BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="Gray" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
            <asp:SqlDataSource ID="sdsWarrantyBoats" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [BML_POPREPORTING_WARRANTY] WHERE (BML_POPREPORTING_WARRANTY.Serial LIKE '%' + @Serial + '%') AND (BML_POPREPORTING_WARRANTY.Consumer LIKE '%' + @SearchConsumerName + '%') AND (BML_POPREPORTING_WARRANTY.DealerDBA LIKE '%' + @SearchDealer + '%') AND (BML_POPREPORTING_WARRANTY.CompleteStatus &lt;= @CompleteStatus) ORDER BY [RProdNo]">
                <SelectParameters>                              
                <asp:ControlParameter ControlID="tbSerial" Name="Serial" DefaultValue='1%' Type="String" />
                <asp:ControlParameter ControlID="tbConsumer" Name="SearchConsumerName" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="tbDealer" Name="SearchDealer" DefaultValue='%' Type="String" />
                <asp:ControlParameter ControlID="ddlShow" Name="CompleteStatus" PropertyName="SelectedValue" Type="Int32" DefaultValue="1" />                
             </SelectParameters>
            </asp:SqlDataSource>  
         

  
    
    </div>
    </form>
</body>
</html>
