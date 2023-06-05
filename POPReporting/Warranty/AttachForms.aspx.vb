
Partial Class Warranty_AttachForms
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click
        If IsPostBack Then
            Dim RepairProdNo As String = Request.QueryString("RProdNo")
            Dim path As String = Server.MapPath("Uploads/" + RepairProdNo + "/Forms/")
            Dim fileOK As Boolean = False
            If FileUpload1.HasFile Then
                Dim fileExtension As String
                fileExtension = System.IO.Path. _
                    GetExtension(FileUpload1.FileName).ToLower()
                Dim allowedExtensions As String() = _
                    {".jpg", ".jpeg", ".png", ".pdf"}
                For i As Integer = 0 To allowedExtensions.Length - 1
                    If fileExtension = allowedExtensions(i) Then
                        fileOK = True
                    End If
                Next
                If fileOK Then
                    If (Not System.IO.Directory.Exists(path)) Then
                        System.IO.Directory.CreateDirectory(path)
                    End If
                    Try
                        FileUpload1.PostedFile.SaveAs(path & _
                             FileUpload1.FileName)
                        Label1.Text = "File uploaded!"
                    Catch ex As Exception
                        Label1.Text = "File could not be uploaded."
                    End Try
                Else
                    Label1.Text = "Cannot accept files of this type."
                End If
            End If
        End If
    End Sub
End Class
