Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration


Partial Class Warranty_InitialPhotos
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub UploadCompleteExt(sender As Object, e As AjaxControlToolkit.AjaxFileUploadEventArgs) Handles AjaxFileUpload1.UploadComplete
        Dim RepairProdNo As String = Request.QueryString("RProdNo")

        Dim file As String = Server.MapPath("Uploads/" + RepairProdNo + "/Before/Exterior/")

        If (Not System.IO.Directory.Exists(file)) Then
            System.IO.Directory.CreateDirectory(file)
        End If

        Dim path As String = file + e.FileName
        Try
            AjaxFileUpload1.SaveAs(path)
        Catch ex As Exception

        End Try

    End Sub


    Protected Sub UploadCompleteInt(sender As Object, e As AjaxControlToolkit.AjaxFileUploadEventArgs) Handles AjaxFileUpload2.UploadComplete
        Dim RepairProdNo As String = Request.QueryString("RProdNo")
        Dim file As String = Server.MapPath("Uploads/" + RepairProdNo + "/Before/Interior/")

        If (Not System.IO.Directory.Exists(file)) Then
            System.IO.Directory.CreateDirectory(file)
        End If

        Dim path As String = file + e.FileName

        AjaxFileUpload2.SaveAs(path)
    End Sub

    Protected Sub UploadCompletePer(sender As Object, e As AjaxControlToolkit.AjaxFileUploadEventArgs) Handles AjaxFileUpload3.UploadComplete
        Dim RepairProdNo As String = Request.QueryString("RProdNo")
        Dim file As String = Server.MapPath("Uploads/" + RepairProdNo + "/Before/PersonalItems/")

        If (Not System.IO.Directory.Exists(file)) Then
            System.IO.Directory.CreateDirectory(file)
        End If

        Dim path As String = file + e.FileName

        AjaxFileUpload3.SaveAs(path)
    End Sub
End Class
