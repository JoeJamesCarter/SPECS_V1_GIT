Imports System.IO

Partial Class ProdPics
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub btnRetreive_Click(sender As Object, e As EventArgs) Handles btnRetreive.Click
        Dim prodNo As String = tbProdNo.Text
        Dim i As Integer = 1


        While i < 31
            'Dim path As String = "http://www.benningtonmarine.com/private/databank/ProdPics/" & prodNo & "/" & prodNo & "_" & i & ".jpg" 'moved to a new server 2/20/19
            
Dim path As String = "https://prodpics.s3.amazonaws.com/" & prodNo & "/" & prodNo & "_" & i & ".jpg"

            If i = 1 Then
                Image1.ImageUrl = path
                Image1.Visible = True

            ElseIf i = 2 Then
                Image2.ImageUrl = path
                Image2.Visible = True

            ElseIf i = 3 Then
                Image3.ImageUrl = path
                Image3.Visible = True

            ElseIf i = 4 Then
                Image4.ImageUrl = path
                Image4.Visible = True

            ElseIf i = 5 Then
                Image5.ImageUrl = path
                Image5.Visible = True

            ElseIf i = 6 Then
                Image6.ImageUrl = path
                Image6.Visible = True

            ElseIf i = 7 Then
                Image7.ImageUrl = path
                Image7.Visible = True

            ElseIf i = 8 Then
                Image8.ImageUrl = path
                Image8.Visible = True

            ElseIf i = 9 Then
                Image9.ImageUrl = path
                Image9.Visible = True

            ElseIf i = 10 Then
                Image10.ImageUrl = path
                Image10.Visible = True

            ElseIf i = 11 Then
                Image11.ImageUrl = path
                Image11.Visible = True

            ElseIf i = 12 Then
                Image12.ImageUrl = path
                Image12.Visible = True

            ElseIf i = 13 Then
                Image13.ImageUrl = path
                Image13.Visible = True

            ElseIf i = 14 Then
                Image14.ImageUrl = path
                Image14.Visible = True

            ElseIf i = 15 Then
                Image15.ImageUrl = path
                Image15.Visible = True

            ElseIf i = 16 Then
                Image16.ImageUrl = path
                Image16.Visible = True

            ElseIf i = 17 Then
                Image17.ImageUrl = path
                Image17.Visible = True

            ElseIf i = 18 Then
                Image18.ImageUrl = path
                Image18.Visible = True

            ElseIf i = 19 Then
                Image19.ImageUrl = path
                Image19.Visible = True

            ElseIf i = 20 Then
                Image20.ImageUrl = path
                Image20.Visible = True

            ElseIf i = 21 Then
                Image21.ImageUrl = path
                Image21.Visible = True

            ElseIf i = 22 Then
                Image22.ImageUrl = path
                Image22.Visible = True

            ElseIf i = 23 Then
                Image23.ImageUrl = path
                Image23.Visible = True

            ElseIf i = 24 Then
                Image24.ImageUrl = path
                Image24.Visible = True

            ElseIf i = 25 Then
                Image25.ImageUrl = path
                Image25.Visible = True

            ElseIf i = 26 Then
                Image26.ImageUrl = path
                Image26.Visible = True

            ElseIf i = 27 Then

                Image27.ImageUrl = path
                Image27.Visible = True

            ElseIf i = 28 Then
                Image28.ImageUrl = path
                Image28.Visible = True

            ElseIf i = 29 Then
                Image29.ImageUrl = path
                Image29.Visible = True

            ElseIf i = 30 Then
                Image30.ImageUrl = path
                Image30.Visible = True

            End If

            i = i + 1
        End While


    End Sub

    Protected Sub form1_Load(sender As Object, e As EventArgs) Handles form1.Load
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



End Class
