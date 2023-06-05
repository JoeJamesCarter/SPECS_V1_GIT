Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports RestSharp

Partial Class Workstations_PrePaidBackOrder
    Inherits System.Web.UI.Page


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim ProdNo As String = Request.QueryString("ProdNo")

        Dim s As SqlDataSource = CType(FindControl("sdsBOs"), SqlDataSource)
        Dim t As SqlDataSource = CType(FindControl("sdsRedTagReasons"), SqlDataSource)
        Dim u As SqlDataSource = CType(FindControl("sdsRGAs"), SqlDataSource)

        Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
            s.SelectParameters(0).DefaultValue = ProdNo
            t.SelectParameters(0).DefaultValue = ProdNo
            u.SelectParameters(0).DefaultValue = ProdNo
        Catch

        End Try



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


    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim ProdNo As String = Request.QueryString("ProdNo")
        Dim TodaysDate As Date = Date.Now
        Dim PPBONote As String = tbNote.Text

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        user = SplitBValSlash(user)

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        conn.ConnectionString = connstr

        cmd.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set HasPPBO = '1', PPBOCreatedBy = '" & user & "', PPBOCreatedDate = '" & TodaysDate & "', PPBONote = '" & PPBONote & "' Where ProdNo= '" & ProdNo & "'"
        cmd1.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set IsRedTagged ='0' where ProdNo =  '" & ProdNo & "'"
        cmd.Connection = conn
        cmd1.Connection = conn

        System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12
        Dim SmtpServer As New Net.Mail.SmtpClient()
        Dim mail As New Net.Mail.MailMessage
        SmtpServer.Credentials = New System.Net.NetworkCredential("svccopier_smtp@polarisind.com", "dccGqWkzFWrFM4")
        SmtpServer.Host = "smtp.office365.com"
        SmtpServer.EnableSsl = True
        SmtpServer.Port = 587

        mail.IsBodyHtml = True

        mail.From = New Net.Mail.MailAddress("svccopier_smtp@polaris.com", "SPECS - PPBO")
        mail.To.Add("cbateson@benningtonmarine.com")
        mail.To.Add("krimbaugh@benningtonmarine.com")
        mail.Subject = "Bennington PrePaid Backorder Info - Prod # " & ProdNo & ""
        mail.Body = "Bennington Production #" & ProdNo & " has been flagged for a Prepaid Backorder. The reason specified is: " & PPBONote & ""
        SmtpServer.Send(mail)

        conn.Open()

        cmd.ExecuteNonQuery()
        cmd1.ExecuteNonQuery()
        conn.Close()

        PostToTeams(ProdNo, PPBONote, user)

        ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")
    End Sub

    Private Sub PostToTeams(Prod As String, PPBONote As String, SubmittedBy As String)
        Dim client = New RestClient("https://polarisind.webhook.office.com/webhookb2/64b1a204-471f-4897-a55e-2603a3c26cf9@85f78c4c-ad11-4735-9624-0b2c11611dff/IncomingWebhook/c67ca8f366564e21a25fb8f8966ea182/e21f1092-8010-45f9-b419-50aa3efc4b1f")
        client.Timeout = -1
        Dim request = New RestRequest(Method.POST)
        request.AddHeader("Content-Type", "application/json")
        request.AddParameter("application/json", "{" & vbCrLf & "    ""@context"": ""https://schema.org/extensions""," & vbCrLf & "    ""@type"": ""MessageCard""," & vbCrLf & "    ""themeColor"": ""0072C6""," & vbCrLf & "    ""title"": ""Prod #: " & Prod & " ""," & vbCrLf & "    ""text"": ""Prod #:  " & Prod & "  Has a Prepaid Backorder for:  " & PPBONote & " .""" & vbCrLf & "    " & vbCrLf & "}", ParameterType.RequestBody)
        Dim response As IRestResponse = client.Execute(request)
        Console.WriteLine(response.Content)
    End Sub

End Class
