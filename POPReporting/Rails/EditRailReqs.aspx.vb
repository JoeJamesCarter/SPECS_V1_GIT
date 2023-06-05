
Partial Class Rails_EditRailReqs
    Inherits System.Web.UI.Page

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class

    Protected Sub Rails_EditRailReqs_Load(sender As Object, e As EventArgs) Handles Me.Load
         Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
    End Sub

    Protected Sub dvRailReqs_ItemUpdating(sender As Object, e As DetailsViewUpdateEventArgs) Handles dvRailReqs.ItemUpdating

        Dim cbNeedsTransom As CheckBox = DirectCast(DirectCast(sender, DetailsView).FindControl("cbNeedsTransom"), CheckBox)
        Dim cbNeedsPM As CheckBox = DirectCast(DirectCast(sender, DetailsView).FindControl("cbNeedsPM"), CheckBox)
        Dim cbNeedsSM As CheckBox = DirectCast(DirectCast(sender, DetailsView).FindControl("cbNeedsSM"), CheckBox)
        Dim cbProtech As CheckBox = DirectCast(DirectCast(sender, DetailsView).FindControl("cbProtech"), CheckBox)
        Dim tbRailsNeeded As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbRailsNeeded"), TextBox)

        Dim nt As Integer
        Dim npm As Integer
        Dim nsm As Integer
        Dim pt As Integer

        If cbNeedsTransom.Checked = True Then
            nt = 1
        Else
            nt = 0
        End If

        If cbNeedsPM.Checked = True Then
            npm = 1
        Else
            npm = 0
        End If

        If cbNeedsSM.Checked = True Then
            nsm = 1
        Else
            nsm = 0
        End If

        If cbProtech.Checked = True Then
            pt = 1
        Else
            pt = 0
        End If

        sdsRailData.UpdateParameters("NeedsTransom").DefaultValue = nt
        sdsRailData.UpdateParameters("NeedsPortMid").DefaultValue = npm
        sdsRailData.UpdateParameters("NeedsStrbMid").DefaultValue = nsm
        sdsRailData.UpdateParameters("Protech").DefaultValue = pt
        sdsRailData.UpdateParameters("RailsNeeded").DefaultValue = Convert.ToInt16(tbRailsNeeded.Text)

    End Sub

    
    Protected Sub dvRailReqs_ItemUpdated(sender As Object, e As DetailsViewUpdatedEventArgs) Handles dvRailReqs.ItemUpdated

        Dim ProdNo As String
        ProdNo = Request.QueryString("ProdNo")

        Dim nt As Integer
        Dim npm As Integer
        Dim nsm As Integer
        Dim pt As Integer

        Dim cbNeedsTransom As CheckBox = DirectCast(DirectCast(sender, DetailsView).FindControl("cbNeedsTransom"), CheckBox)
        Dim cbNeedsPM As CheckBox = DirectCast(DirectCast(sender, DetailsView).FindControl("cbNeedsPM"), CheckBox)
        Dim cbNeedsSM As CheckBox = DirectCast(DirectCast(sender, DetailsView).FindControl("cbNeedsSM"), CheckBox)
        Dim cbProtech As CheckBox = DirectCast(DirectCast(sender, DetailsView).FindControl("cbProtech"), CheckBox)
        Dim tbRailsNeeded As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbRailsNeeded"), TextBox)
        Dim TodaysDate As Date = Date.Now
        Dim stationID As String = GlobalVariables.stationID

        If cbNeedsTransom.Checked = True Then
            nt = 1
        Else
            nt = 0
        End If

        If cbNeedsPM.Checked = True Then
            npm = 1
        Else
            npm = 0
        End If

        If cbNeedsSM.Checked = True Then
            nsm = 1
        Else
            nsm = 0
        End If


        If cbProtech.Checked = True Then
            pt = 1
        Else
            pt = 0
        End If



        Dim SmtpServer As New Net.Mail.SmtpClient()
        Dim mail As New Net.Mail.MailMessage
        'SmtpServer.Host = "elkhart.benningtonmarine.com"
        SmtpServer.Credentials = New System.Net.NetworkCredential("svccopier_smtp@polarisind.com", "dccGqWkzFWrFM4")
        SmtpServer.Host = "smtp.office365.com"
        'SmtpServer.Host = "polaris-com.mail.protection.outlook.com"
        SmtpServer.EnableSsl = True
        SmtpServer.Port = 587

        'mail.From = New Net.Mail.MailAddress("krimbaugh@benningtonmarine.com")
        mail.IsBodyHtml = True
        mail.From = New Net.Mail.MailAddress("svccopier_smtp@polaris.com", "SPECS")
        mail.To.Add("krimbaugh@benningtonmarine.com")
        mail.Subject = "Rail Requirements Changed In Rails Receiving"
        mail.Body = "Rail Requirements have been changed on Prod # " & ProdNo & ". Needs Transom = " & nt & ". Needs Port Mid = " & npm & ". Needs Strb Mid = " & nsm & ". # of Rails Needed = " & tbRailsNeeded.Text & ". Protech Flag = " & pt & ". Change was made by pc logged in as: " & stationID & " at " & TodaysDate & ""
        SmtpServer.Send(mail)




        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")


    End Sub

    Protected Function SplitBValSlash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("\")(1)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function

End Class
