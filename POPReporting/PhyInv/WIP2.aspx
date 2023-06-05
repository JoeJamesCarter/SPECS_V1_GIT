<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WIP2.aspx.vb" Inherits="PhyInv_WIP2" Debug="true" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Phy Inv WIP v2</title>
    <link rel="stylesheet" href="../scripts/css/bootstrap.min.css" />
    <script src="../scripts/jquery-3.5.0.min.js"></script>
    <script src="../scripts/bootstrap.min.js"></script>
    <style type="text/css">
        .newStyle1 {
            float: left;
            font-family: calibri;
            font-size: 18px;
            margin-left: 20px;
            text-align: center;
        }

        .btnonboat {
            width: 65px;
            height: 65px;
        }

        .green {
            background-color: green;
            height: 70px;
            width: 70px;
        }

        .white {
            background-color: white;
            height: 70px;
            width: 70px;
        }
    </style>

    <script>
        document.getElementById("showParts").addEventListener("click", function (event) {
            event.preventDefault()
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnSONo" runat="server" />
        <asp:HiddenField ID="hdnSONoSkip2LeadingZeros" runat="server" />
        <asp:HiddenField ID="hdnBoatYear" runat="server" />
        <asp:HiddenField ID="hdnProdNo" runat="server" />

        <div id="title">
            <h3><asp:Label ID="Label3" runat="server" CssClass="ml-1" Text="Physical Inv WIP"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label4" runat="server" CssClass="newStyle2" Text="Current SPECS Status: "></asp:Label><asp:Label ID="lblCurrentSpecsStatus" CssClass="newStyle3" runat="server" Text=""></asp:Label></h3>
        </div>

        <div id="toolbar">
            <asp:Label ID="Label2" runat="server" CssClass="newStyle1" Text="Search By Prod #" Width="150"></asp:Label><asp:TextBox ID="tbProd" CssClass="newStyle1" runat="server"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" CssClass="newStyle1" Text="Search By SO" Width="150"></asp:Label><asp:TextBox ID="tbSO" CssClass="newStyle1" runat="server"></asp:TextBox>
            <asp:Button ID="btnLoad" CssClass="newStyle1" runat="server" Text="Load BOM" />
            <asp:Button ID="btnExpandAll" CssClass="newStyle1" runat="server" Text="Show Expanded BOM" Visible="true" />
        </div>
        <br /> 
        <br />
        <asp:Button ID="btnCompleteAll" runat="server" cssClass="ml-1" Text="Mark All Complete" Visible="False" />
        <br />
        
        <div id="bom">
            <asp:GridView ID="gvOrderLines" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" BorderWidth="0">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="lblitemno" runat="server" Text='<%#Eval("parent_item_no") %>'></asp:Label><%--<a href="#" id="<%#Trim(Eval("parent_item_no")) %>" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#expandModal" data-parentitem="<%#Trim(Eval("parent_item_no")) %>" data-parentitemdesc ="<%#Trim(Eval("parent_item_desc")) %>" ></a>--%><br />
                            <asp:Label ID="lblitemdesc" runat="server" Text='<%#Eval("parent_item_desc") %>'></asp:Label><br />
                            <asp:Label ID="lblqty" runat="server" Text='<%#Eval("parent_qty") %>'></asp:Label><br />

                            <asp:ImageButton ID="btnMissingLevel" CssClass="btnonboat" runat="server" CommandName="Missing" ImageUrl="../Images/phyinv-missing.png" CommandArgument="<%# Container.DataItemIndex %>" />
                            <asp:ImageButton ID="btnIncompleteLevel" CssClass="btnonboat" runat="server" CommandName="Partial" ImageUrl="../Images/phyinv-incomplete.png" CommandArgument="<%# Container.DataItemIndex %>" />
                            <asp:ImageButton ID="btnCompleteLevel" CssClass="btnonboat" runat="server" CommandName="Complete" ImageUrl="../Images/phyinv-complete.png" CommandArgument="<%# Container.DataItemIndex %>" /><br />
                            <asp:ImageButton ID="btnCollapse" runat="server" CommandName="collapse" ImageUrl="../Images/phyinv-collapse.png" CommandArgument="<%# Container.DataItemIndex %>" Visible="false" /><br />
                            <asp:Button ID="btnMarkChildrenComplete" runat="server" Text="Complete Children =>" Visible="false" CommandName="CompleteChildren" CommandArgument="<%# Container.DataItemIndex %>"/>
                        </ItemTemplate>
                        <ItemStyle VerticalAlign="Top" />
                    </asp:TemplateField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:GridView ID="gvLevel1" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvLevel1_RowDataBound" ShowHeader="False" BorderWidth="0" OnRowCommand="gvLevel1_RowCommand" Visible="false">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemno1" runat="server" Text='<%#Eval("comp_item_no") %>'></asp:Label><br />
                                            <asp:Label ID="lblitemdesc1" runat="server" Text='<%#Eval("comp_item_desc") %>'></asp:Label><br />
                                            <asp:Label ID="lblqty1" runat="server" Text='<%#Eval("qty_per_par") %>'></asp:Label><br />
                                            <asp:ImageButton ID="btnMissingLevel1" CssClass="btnonboat" runat="server" CommandName="Missing1" ImageUrl="../Images/phyinv-missing.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                            <asp:ImageButton ID="btnIncompleteLevel1" CssClass="btnonboat" runat="server" CommandName="Partial1" ImageUrl="../Images/phyinv-incomplete.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                            <asp:ImageButton ID="btnCompleteLevel1" CssClass="btnonboat" runat="server" CommandName="Complete1" ImageUrl="../Images/phyinv-complete.png" CommandArgument="<%# Container.DataItemIndex %>" /><br />
                                            <asp:ImageButton ID="btnCollapse1" runat="server" CommandName="collapse1" ImageUrl="../Images/phyinv-collapse.png" CommandArgument="<%# Container.DataItemIndex %>" Visible="false" /><br />
                                            <asp:Button ID="btnMarkChildrenComplete1"  runat="server" Text="Complete Children =>" Visible="false" CommandName="CompleteChildren1" CommandArgument="<%# Container.DataItemIndex %>"/>
                                        </ItemTemplate>
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:GridView ID="gvLevel2" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvLevel2_RowDataBound" ShowHeader="false" BorderWidth="0" OnRowCommand="gvLevel2_RowCommand" Visible="false">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblitemno2" runat="server" Text='<%#Eval("comp_item_no") %>'></asp:Label><br />
                                                            <asp:Label ID="lblitemdesc2" runat="server" Text='<%#Eval("comp_item_desc") %>'></asp:Label><br />
                                                            <asp:Label ID="lblqty2" runat="server" Text='<%#Eval("qty_per_par") %>'></asp:Label><br />
                                                            <asp:ImageButton ID="btnMissingLevel2" CssClass="btnonboat" runat="server" CommandName="Missing2" ImageUrl="../Images/phyinv-missing.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                            <asp:ImageButton ID="btnIncompleteLevel2" CssClass="btnonboat" runat="server" CommandName="Partial2" ImageUrl="../Images/phyinv-incomplete.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                            <asp:ImageButton ID="btnCompleteLevel2" CssClass="btnonboat" runat="server" CommandName="Complete2" ImageUrl="../Images/phyinv-complete.png" CommandArgument="<%# Container.DataItemIndex %>" /><br />
                                                            <asp:ImageButton ID="btnCollapse2" runat="server" CommandName="collapse2" ImageUrl="../Images/phyinv-collapse.png" CommandArgument="<%# Container.DataItemIndex %>" Visible="false" /><br />
                                                            <asp:Button ID="btnMarkChildrenComplete2"  runat="server" Text="Complete Children =>" Visible="false" CommandName="CompleteChildren2" CommandArgument="<%# Container.DataItemIndex %>"/>
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Top" />

                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:GridView ID="gvLevel3" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvLevel3_RowDataBound" ShowHeader="False" Visible="false" BorderWidth="0" OnRowCommand="gvLevel3_RowCommand">
                                                                <Columns>

                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblitemno3" runat="server" Text='<%#Eval("comp_item_no") %>'></asp:Label><br />
                                                                            <asp:Label ID="lblitemdesc3" runat="server" Text='<%#Eval("comp_item_desc") %>'></asp:Label><br />
                                                                            <asp:Label ID="lblqty3" runat="server" Text='<%#Eval("qty_per_par") %>'></asp:Label><br />
                                                                            <asp:ImageButton ID="btnMissingLevel3" CssClass="btnonboat" runat="server" CommandName="Missing3" ImageUrl="../Images/phyinv-missing.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                            <asp:ImageButton ID="btnIncompleteLevel3" CssClass="btnonboat" runat="server" CommandName="Partial3" ImageUrl="../Images/phyinv-incomplete.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                            <asp:ImageButton ID="btnCompleteLevel3" CssClass="btnonboat" runat="server" CommandName="Complete3" ImageUrl="../Images/phyinv-complete.png" CommandArgument="<%# Container.DataItemIndex %>" /><br />
                                                                            <asp:ImageButton ID="btnCollapse3" runat="server" CommandName="collapse3" ImageUrl="../Images/phyinv-collapse.png" CommandArgument="<%# Container.DataItemIndex %>" Visible="false" /></br>
                                                                            <asp:Button ID="btnMarkChildrenComplete3"  runat="server" Text="Complete Children =>" Visible="false" CommandName="CompleteChildren3" CommandArgument="<%# Container.DataItemIndex %>"/>
                                                                        </ItemTemplate>
                                                                        <ItemStyle VerticalAlign="Top" />

                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>


                                                                            <asp:GridView ID="gvLevel4" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvLevel4_RowDataBound" ShowHeader="False" Visible="false" BorderWidth="0" OnRowCommand="gvLevel4_RowCommand">
                                                                                <Columns>
                                                                                    <asp:TemplateField>
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblitemno4" runat="server" Text='<%#Eval("comp_item_no") %>'></asp:Label><br />
                                                                                            <asp:Label ID="lblitemdesc4" runat="server" Text='<%#Eval("comp_item_desc") %>'></asp:Label><br />
                                                                                            <asp:Label ID="lblqty4" runat="server" Text='<%#Eval("qty_per_par") %>'></asp:Label><br />
                                                                                            <asp:ImageButton ID="btnMissingLevel4" CssClass="btnonboat" runat="server" CommandName="Missing4" ImageUrl="../Images/phyinv-missing.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                                            <asp:ImageButton ID="btnIncompleteLevel4" CssClass="btnonboat" runat="server" CommandName="Partial4" ImageUrl="../Images/phyinv-incomplete.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                                            <asp:ImageButton ID="btnCompleteLevel4" CssClass="btnonboat" runat="server" CommandName="Complete4" ImageUrl="../Images/phyinv-complete.png" CommandArgument="<%# Container.DataItemIndex %>" /><br />
                                                                                            <asp:ImageButton ID="btnCollapse4" runat="server" CommandName="collapse4" ImageUrl="../Images/phyinv-collapse.png" CommandArgument="<%# Container.DataItemIndex %>" Visible="false" /></br>
                                                                                            <asp:Button ID="btnMarkChildrenComplete4"  runat="server" Text="Complete Children =>" Visible="false" CommandName="CompleteChildren4" CommandArgument="<%# Container.DataItemIndex %>"/>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle VerticalAlign="Top" />

                                                                                    </asp:TemplateField>

                                                                                    <asp:TemplateField>
                                                                                        <ItemTemplate>



                                                                                            <asp:GridView ID="gvLevel5" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvLevel5_RowDataBound" ShowHeader="False" Visible="false" OnRowCommand="gvLevel5_RowCommand">
                                                                                                <Columns>
                                                                                                    <asp:TemplateField>
                                                                                                        <ItemTemplate>
                                                                                                            <asp:Label ID="lblitemno5" runat="server" Text='<%#Eval("comp_item_no") %>'></asp:Label><br />
                                                                                                            <asp:Label ID="lblitemdesc5" runat="server" Text='<%#Eval("comp_item_desc") %>'></asp:Label><br />
                                                                                                            <asp:Label ID="lblqty5" runat="server" Text='<%#Eval("qty_per_par") %>'></asp:Label><br />
                                                                                                            <asp:ImageButton ID="btnMissingLevel5" CssClass="btnonboat" runat="server" CommandName="Missing5" ImageUrl="../Images/phyinv-missing.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                                                            <asp:ImageButton ID="btnIncompleteLevel5" CssClass="btnonboat" runat="server" CommandName="Partial5" ImageUrl="../Images/phyinv-incomplete.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                                                            <asp:ImageButton ID="btnCompleteLevel5" CssClass="btnonboat" runat="server" CommandName="Complete5" ImageUrl="../Images/phyinv-complete.png" CommandArgument="<%# Container.DataItemIndex %>" /><br />
                                                                                                            <asp:ImageButton ID="btnCollapse5" runat="server" CommandName="collapse5" ImageUrl="../Images/phyinv-collapse.png" CommandArgument="<%# Container.DataItemIndex %>" Visible="false" /></br>
                                                                                                            <asp:Button ID="btnMarkChildrenComplete5"  runat="server" Text="Complete Children =>" Visible="false" CommandName="CompleteChildren5" CommandArgument="<%# Container.DataItemIndex %>"/>
                                                                                                        </ItemTemplate>
                                                                                                        <ItemStyle VerticalAlign="Top" />

                                                                                                    </asp:TemplateField>

                                                                                                    <asp:TemplateField>
                                                                                                        <ItemTemplate>


                                                                                                            <asp:GridView ID="gvLevel6" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvLevel6_RowDataBound" ShowHeader="False" Visible="true" OnRowCommand="gvLevel6_RowCommand">
                                                                                                                <Columns>
                                                                                                                    <asp:TemplateField>
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblitemno6" runat="server" Text='<%#Eval("comp_item_no") %>'></asp:Label><br />
                                                                                                                            <asp:Label ID="lblitemdesc6" runat="server" Text='<%#Eval("comp_item_desc") %>'></asp:Label><br />
                                                                                                                            <asp:Label ID="lblqty6" runat="server" Text='<%#Eval("qty_per_par") %>'></asp:Label><br />
                                                                                                                            <asp:ImageButton ID="btnMissingLevel6" CssClass="btnonboat" runat="server" CommandName="Missing6" ImageUrl="../Images/phyinv-missing.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                                                                            <asp:ImageButton ID="btnIncompleteLevel6" CssClass="btnonboat" runat="server" CommandName="Partial6" ImageUrl="../Images/phyinv-incomplete.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                                                                            <asp:ImageButton ID="btnCompleteLevel6" CssClass="btnonboat" runat="server" CommandName="Complete6" ImageUrl="../Images/phyinv-complete.png" CommandArgument="<%# Container.DataItemIndex %>" /><br />
                                                                                                                            <asp:ImageButton ID="btnCollapse6" runat="server" CommandName="collapse6" ImageUrl="../Images/phyinv-collapse.png" CommandArgument="<%# Container.DataItemIndex %>" Visible="false" /><br />
                                                                                                                            <asp:Button ID="btnMarkChildrenComplete6"  runat="server" Text="Complete Children =>" Visible="false" CommandName="CompleteChildren6" CommandArgument="<%# Container.DataItemIndex %>"/>
                                                                                                                        </ItemTemplate>
                                                                                                                        <ItemStyle VerticalAlign="Top" />

                                                                                                                    </asp:TemplateField>

                                                                                                                    <asp:TemplateField>
                                                                                                                        <ItemTemplate>


                                                                                                                            <asp:GridView ID="gvLevel7" runat="server" AutoGenerateColumns="False" ShowHeader="False" Visible="false" OnRowCommand="gvLevel7_RowCommand">
                                                                                                                                <Columns>
                                                                                                                                    <asp:TemplateField>
                                                                                                                                        <ItemTemplate>
                                                                                                                                            <asp:Label ID="lblitemno7" runat="server" Text='<%#Eval("comp_item_no") %>'></asp:Label><br />
                                                                                                                                            <asp:Label ID="lblitemdesc7" runat="server" Text='<%#Eval("comp_item_desc") %>'></asp:Label><br />
                                                                                                                                            <asp:Label ID="lblqty7" runat="server" Text='<%#Eval("qty_per_par") %>'></asp:Label><br />
                                                                                                                                            <asp:ImageButton ID="btnMissingLevel7" CssClass="btnonboat" runat="server" CommandName="Missing7" ImageUrl="../Images/phyinv-missing.png" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                                                                                            <asp:ImageButton ID="btnCompleteLevel7" CssClass="btnonboat" runat="server" CommandName="Complete7" ImageUrl="../Images/phyinv-complete.png" CommandArgument="<%# Container.DataItemIndex %>" /><br />
                                                                                                                                            <asp:ImageButton ID="btnCollapse7" runat="server" CommandName="collapse7" ImageUrl="../Images/phyinv-collapse.png" CommandArgument="<%# Container.DataItemIndex %>" Visible="false" />                                                                                                                                            
                                                                                                                                        </ItemTemplate>
                                                                                                                                        <ItemStyle VerticalAlign="Top" />

                                                                                                                                    </asp:TemplateField>

                                                                                                                                </Columns>
                                                                                                                            </asp:GridView>

                                                                                                                        </ItemTemplate>
                                                                                                                        <ItemStyle VerticalAlign="Top" />
                                                                                                                    </asp:TemplateField>
                                                                                                                </Columns>
                                                                                                            </asp:GridView>


                                                                                                        </ItemTemplate>
                                                                                                        <ItemStyle VerticalAlign="Top" />
                                                                                                    </asp:TemplateField>
                                                                                                </Columns>
                                                                                            </asp:GridView>


                                                                                        </ItemTemplate>
                                                                                        <ItemStyle VerticalAlign="Top" />
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>


                                                                        </ItemTemplate>
                                                                        <ItemStyle VerticalAlign="Top" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Top" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </ItemTemplate>
                                        <ItemStyle VerticalAlign="Top" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ItemTemplate>
                        <ItemStyle VerticalAlign="Top" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div id="selections">

            <asp:GridView ID="gvSelections" runat="server" CssClass="newStyle1" AutoGenerateColumns="False" DataKeyNames="AutoID" DataSourceID="sdsSavedLines" Width="600px">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="False" />
                    <asp:BoundField DataField="Auditor" HeaderText="Auditor" SortExpression="Auditor" />
                    <asp:BoundField DataField="PartDateTimeAudited" HeaderText="Audited" SortExpression="PartDateTimeAudited" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Part #" SortExpression="ItemNo" />
                    <asp:BoundField DataField="ItemDesc" HeaderText="Desc" SortExpression="ItemDesc" />
                    <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" />

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Switch(Eval("PartStatus") = 1, "MISSING", Eval("PartStatus") = 2, "PARTIAL", Eval("PartStatus") = 3, "COMPLETE") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsSavedLines" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" DeleteCommand="DELETE FROM [WIP_Parts] WHERE [AutoID] = @AutoID" InsertCommand="INSERT INTO [WIP_Parts] ([ProdNo], [PartDateAudited], [Auditor], [PartDateTimeAudited], [ItemNo], [ItemDesc], [Qty], [PartStatus]) VALUES (@ProdNo, @PartDateAudited, @Auditor, @PartDateTimeAudited, @ItemNo, @ItemDesc, @Qty, @PartStatus)" SelectCommand="SELECT * FROM [WIP_Parts] WHERE [ProdNo] = @ProdNo and PartStatus <> 0 and DATEADD(dd, 0, DATEDIFF(dd, 0, PartDateTimeAudited)) >= DATEADD(dd, -5, DATEDIFF(dd, 0, GETDATE())) ORDER BY [AutoID]" UpdateCommand="UPDATE [WIP_Parts] SET [Qty] = @Qty, [PartStatus] = @PartStatus WHERE [AutoID] = @AutoID">
                <DeleteParameters>
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ProdNo" Type="String" />
                    <asp:Parameter DbType="Date" Name="PartDateAudited" />
                    <asp:Parameter Name="Auditor" Type="String" />
                    <asp:Parameter Name="PartDateTimeAudited" Type="DateTime" />
                    <asp:Parameter Name="ItemNo" Type="String" />
                    <asp:Parameter Name="ItemDesc" Type="String" />
                    <asp:Parameter Name="Qty" Type="Double" />
                    <asp:Parameter Name="PartStatus" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="tbProd" Name="ProdNo" PropertyName="Text" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ProdNo" Type="String" />
                    <asp:Parameter DbType="Date" Name="PartDateAudited" />
                    <asp:Parameter Name="Auditor" Type="String" />
                    <asp:Parameter Name="PartDateTimeAudited" Type="DateTime" />
                    <asp:Parameter Name="ItemNo" Type="String" />
                    <asp:Parameter Name="ItemDesc" Type="String" />
                    <asp:Parameter Name="Qty" Type="Double" />
                    <asp:Parameter Name="PartStatus" Type="Int32" />
                    <asp:Parameter Name="AutoID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>


        <%-- <!--Requirements Modal -->

        <div class="modal fade" id="expandModal" tabindex="-1" role="dialog" aria-labelledby="expandModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="reqsModalTitle">Components In This Part</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                    </div>

                </div>
            </div>

        </div>
        <script>
            $('#expandModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget) // Button that triggered the modal
                var parent = button.data('parentitem') // Extract info from data-* attributes
                var parentdesc = button.data('parentitemdesc') // Extract info from data-* attributes                
                var modal = $(this)
                modal.find('.modal-title').text('Parts In  ' + parent + ' -' + parentdesc)                
            })
        </script>--%>
    </form>
</body>
</html>
