Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Net.Mime.MediaTypeNames

Partial Class ReportAProblem
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim BoatSONo As String


        BoatSONo = Request.QueryString("SONo")
        hdnSONo.Value = BoatSONo
        Dim workstationurl As String

        workstationurl = Request.UrlReferrer.ToString()
        hdnworkstationurl.Value = workstationurl

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        Dim cmd As New SqlCommand

        cmd.CommandType = CommandType.Text
        cmd.Connection = conn
        Dim ProdNo As String
        cmd.CommandText = "Select ProdNo FROM BML_POPREPORTING_GREENLIGHTS where SONo =  '" & hdnSONo.Value & "'"
        conn.Open()
        ProdNo = Convert.ToString(cmd.ExecuteScalar())
        hdnProdNo.Value = ProdNo
    End Sub


    Protected Sub btnSend_Click(sender As Object, e As EventArgs) Handles btnSend.Click
        Dim problemrequest As String = tbproblem.Text
        Dim pages As String = tbPages.Text

        System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12
        Dim SmtpServer As New Net.Mail.SmtpClient()
        Dim mail As New Net.Mail.MailMessage
        SmtpServer.Credentials = New System.Net.NetworkCredential("svccopier_smtp@polarisind.com", "dccGqWkzFWrFM4")
        SmtpServer.Host = "smtp.office365.com"
        SmtpServer.EnableSsl = True
        SmtpServer.Port = 587

        mail.IsBodyHtml = True
		mail.From = New Net.Mail.MailAddress("svccopier_smtp@polaris.com", "SPECS")
		mail.To.Add("krimbaugh@benningtonmarine.com")

        mail.Subject = "Prod # " & Trim(hdnProdNo.Value) & " - SPECS Report Request/Problem"
		mail.Body = "Request sent from Production # " & Trim(hdnProdNo.Value) & " For Page(s) " & tbPages.Text & " by: " & tbRequestor.Text & ". Request: " & tbproblem.Text & ""
		SmtpServer.Send(mail)

		Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")
    End Sub
End Class
