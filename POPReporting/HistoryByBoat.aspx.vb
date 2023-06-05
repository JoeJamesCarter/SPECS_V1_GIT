Imports System.IO

Partial Class HistoryByBoat
    Inherits System.Web.UI.Page

    Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView1.SelectedIndexChanged

    End Sub

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub tbProdNo_TextChanged(sender As Object, e As EventArgs) Handles tbProdNo.TextChanged
        Dim prodNo As String = tbProdNo.Text
        Dim path As String = "http://prodpics.benningtonmarine.com/ProdPics/" & prodNo & "/" & prodNo & "_1.jpg"

        If IsValidURl(path) Then
            btnShowPhotos.Visible = True
            btnHidePhotos.Visible = True
        End If


    End Sub

    Protected Sub HistoryByBoat_Load(sender As Object, e As EventArgs) Handles Me.Load
        btnShowPhotos.Visible = False
        btnHidePhotos.Visible = False

        photos.Visible = False
        Image1.Visible = False
        Image2.Visible = False
        Image3.Visible = False
        Image4.Visible = False
        Image5.Visible = False
        Image6.Visible = False
        Image7.Visible = False
        Image8.Visible = False
        Image9.Visible = False
        Image10.Visible = False
        Image11.Visible = False
        Image12.Visible = False
        Image13.Visible = False
        Image14.Visible = False
        Image15.Visible = False
        Image16.Visible = False
        Image17.Visible = False
        Image18.Visible = False
        Image19.Visible = False
        Image20.Visible = False
        Image21.Visible = False
        Image22.Visible = False
        Image23.Visible = False
        Image24.Visible = False
        Image25.Visible = False
        Image26.Visible = False
        Image27.Visible = False
        Image28.Visible = False
        Image29.Visible = False
        Image30.Visible = False

    End Sub

    Public Function IsValidURl(url As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim req As System.Net.WebRequest
        req = System.Net.WebRequest.Create(url)
        Dim resp As System.Net.WebResponse
        Dim isvalid As Boolean
        Try
            resp = req.GetResponse()
            resp.Close()
            req = Nothing
            isvalid = True
        Catch ex As Exception
            req = Nothing
            isvalid = False
        End Try
        Return isvalid
    End Function


    Protected Sub btnShowPhotos_Click(sender As Object, e As EventArgs) Handles btnShowPhotos.Click
        Dim prodNo As String = tbProdNo.Text
        btnHidePhotos.Visible = True

        Dim i As Integer = 1

        While i < 31
            'Dim path As String = "http://www.benningtonmarine.com/private/databank/ProdPics/" & prodNo & "/" & prodNo & "_" & i & ".jpg"
            Dim path As String = "http://prodpics.benningtonmarine.com/ProdPics/" & prodNo & "/" & prodNo & "_" & i & ".jpg"

            If i = 1 Then
                Image1.ImageUrl = path
                If IsValidURl(path) Then
                    Image1.Visible = True
                    photos.Visible = True
                End If


            ElseIf i = 2 Then
                Image2.ImageUrl = path
                'If IsValidURl(path) Then 'If there is one image there are at least 12, cut processing time
                Image2.Visible = True
                'End If


            ElseIf i = 3 Then
                Image3.ImageUrl = path
                '    If IsValidURl(path) Then
                Image3.Visible = True
                'End If


            ElseIf i = 4 Then
                Image4.ImageUrl = path
                'If IsValidURl(path) Then
                Image4.Visible = True
                'End If


            ElseIf i = 5 Then
                Image5.ImageUrl = path
                'If IsValidURl(path) Then
                Image5.Visible = True
                'End If


            ElseIf i = 6 Then
                Image6.ImageUrl = path
                'If IsValidURl(path) Then
                Image6.Visible = True
                'End If


            ElseIf i = 7 Then
                Image7.ImageUrl = path
                'If IsValidURl(path) Then
                Image7.Visible = True
                'End If


            ElseIf i = 8 Then
                Image8.ImageUrl = path
                '    If IsValidURl(path) Then
                Image8.Visible = True
                'End If


            ElseIf i = 9 Then
                Image9.ImageUrl = path
                '    If IsValidURl(path) Then
                Image9.Visible = True
                'End If


            ElseIf i = 10 Then
                Image10.ImageUrl = path
                '    If IsValidURl(path) Then
                Image10.Visible = True
                'End If


            ElseIf i = 11 Then
                Image11.ImageUrl = path
                'If IsValidURl(path) Then
                Image11.Visible = True
                'End If


            ElseIf i = 12 Then
                Image12.ImageUrl = path
                '   If IsValidURl(path) Then
                Image12.Visible = True
                'End If


            ElseIf i = 13 Then
                Image13.ImageUrl = path
                If IsValidURl(path) Then
                    Image13.Visible = True
                End If


            ElseIf i = 14 Then
                Image14.ImageUrl = path
                If IsValidURl(path) Then
                    Image14.Visible = True
                End If


            ElseIf i = 15 Then
                Image15.ImageUrl = path
                If IsValidURl(path) Then
                    Image15.Visible = True
                End If


            ElseIf i = 16 Then
                Image16.ImageUrl = path
                If IsValidURl(path) Then
                    Image16.Visible = True
                End If


            ElseIf i = 17 Then
                Image17.ImageUrl = path
                If IsValidURl(path) Then
                    Image17.Visible = True
                End If


            ElseIf i = 18 Then
                Image18.ImageUrl = path
                If IsValidURl(path) Then
                    Image18.Visible = True
                End If


            ElseIf i = 19 Then
                Image19.ImageUrl = path
                If IsValidURl(path) Then
                    Image19.Visible = True
                End If


            ElseIf i = 20 Then
                Image20.ImageUrl = path
                If IsValidURl(path) Then
                    Image20.Visible = True
                End If


            ElseIf i = 21 Then
                Image21.ImageUrl = path
                If IsValidURl(path) Then
                    Image21.Visible = True
                End If

            ElseIf i = 22 Then
                Image22.ImageUrl = path
                If IsValidURl(path) Then
                    Image22.Visible = True
                End If


            ElseIf i = 23 Then
                Image23.ImageUrl = path
                If IsValidURl(path) Then
                    Image23.Visible = True
                End If


            ElseIf i = 24 Then
                Image24.ImageUrl = path
                If IsValidURl(path) Then
                    Image24.Visible = True
                End If


            ElseIf i = 25 Then
                Image25.ImageUrl = path
                If IsValidURl(path) Then
                    Image25.Visible = True
                End If


            ElseIf i = 26 Then
                Image26.ImageUrl = path
                If IsValidURl(path) Then
                    Image26.Visible = True
                End If



            ElseIf i = 27 Then

                Image27.ImageUrl = path
                If IsValidURl(path) Then
                    Image27.Visible = True
                End If


            ElseIf i = 28 Then
                Image28.ImageUrl = path
                If IsValidURl(path) Then
                    Image28.Visible = True
                End If


            ElseIf i = 29 Then
                Image29.ImageUrl = path
                If IsValidURl(path) Then
                    Image29.Visible = True
                End If

            ElseIf i = 30 Then

                Image30.ImageUrl = path

                If IsValidURl(path) Then
                    Image30.Visible = True
                End If
            End If

            i = i + 1
        End While
    End Sub

    Protected Sub btnHidePhotos_Click(sender As Object, e As EventArgs) Handles btnHidePhotos.Click
        photos.Visible = False
        btnShowPhotos.Visible = True
    End Sub
End Class
