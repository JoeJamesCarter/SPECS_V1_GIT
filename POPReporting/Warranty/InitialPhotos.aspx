<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InitialPhotos.aspx.vb" Inherits="Warranty_InitialPhotos" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .newStyle1 {
            font-family: Calibri;
            font-size: 14px;
        }

         .newStyle2 {
            font-family: Calibri;
            font-size: 18px;
            font-weight:bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
          <asp:ScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ScriptManager>
       
          <span class="newStyle2">Initial Photo Uploads<br />
          </span>
       
    <div>       
        <span class="newStyle1">Exterior Photo Upload<br />           
            <asp:AjaxFileUpload ID="AjaxFileUpload1" runat="server" OnUploadComplete="UploadCompleteExt" ThrobberID="loader" AllowedFileTypes="jpg,gif,png,jpeg"/> 
            <asp:Image ID="loader" runat="server" ImageUrl ="~/loading.gif" Style="display:None"/>
        </span>
         <span class="newStyle1">Interior Photo Upload<br />           
            <asp:AjaxFileUpload ID="AjaxFileUpload2" runat="server" OnUploadComplete="UploadCompleteInt" ThrobberID="loader" AllowedFileTypes="jpg,gif,png,jpeg"/> 
            <asp:Image ID="Image1" runat="server" ImageUrl ="~/loading.gif" Style="display:None"/>
        </span>
         <span class="newStyle1">Personal Items Photo Upload<br />           
            <asp:AjaxFileUpload ID="AjaxFileUpload3" runat="server" OnUploadComplete="UploadCompletePer" ThrobberID="loader" AllowedFileTypes="jpg,gif,png,jpeg"/> 
            <asp:Image ID="Image2" runat="server" ImageUrl ="~/loading.gif" Style="display:None"/>
        </span>
    
    </div>
    </form>
</body>
</html>
