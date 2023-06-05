Imports System
Imports System.Web
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services

Partial Class Tubes_SaveTubeAudit
    Inherits System.Web.UI.Page

    <ScriptService>
    Partial Public Class Save_Picture
        Inherits System.Web.UI.Page

        <WebMethod()>
        Public Shared Sub UploadPic(ByVal imageData As String)
            Dim Pic_Path As String = HttpContext.Current.Server.MapPath("MyPicture.png")

            Using fs As FileStream = New FileStream(Pic_Path, FileMode.Create)

                Using bw As BinaryWriter = New BinaryWriter(fs)
                    Dim data As Byte() = Convert.FromBase64String(imageData)
                    bw.Write(data)
                    bw.Close()
                End Using
            End Using
        End Sub
    End Class


End Class
