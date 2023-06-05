<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AvailableImages.aspx.vb" Inherits="FurnitureCatalog_AvailableImages" Debug="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Available Furniture Images in the Web Directory Driven by DataBase Paths</title>
        <link href="../StyleSheet.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Took the filename from the end of Bob's path in the database. This displays those images names from the web directory to show what might be missing." CssClass="newStyle6"></asp:Label>
        <asp:Button ID="btnExport" runat="server" Text="Export" />
        
        
            
            <asp:GridView ID="gvFurnImages" runat="server" DataSourceID="sdsFurnitureImagePaths" CssClass="newStyle1">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                    <asp:Image ID="img1" runat="server"></asp:Image>
                    
                            </ItemTemplate>
                        </asp:TemplateField>
                     <asp:TemplateField>
                        <ItemTemplate>
                    
                    <asp:Image ID="img2" runat="server"></asp:Image>
                            </ItemTemplate>
                        </asp:TemplateField>
                    <asp:TemplateField HeaderText="Veada BOM">
                        <ItemTemplate>
                            <asp:Label ID="lblVeadaParentPart" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
                       <asp:SqlDataSource ID="sdsFurnitureImagePaths" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT *, RIGHT(BENCH_IMG_URL , CHARINDEX ('\' ,REVERSE(BENCH_IMG_URL))-1) as BENCH_IMG, RIGHT(RECLINER_IMG_URL , CHARINDEX ('\' ,REVERSE(RECLINER_IMG_URL))-1) as RECLINER_IMG FROM [Furniture_Combinations] ORDER BY [PATTERN]"></asp:SqlDataSource>
        
    </form>
</body>
</html>
