Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class BoatStatus
    Inherits System.Web.UI.Page


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Dim lblProdNo As Label

        Dim BoatNotesProdNo As String
        Dim workstation As String

        BoatNotesProdNo = Request.QueryString("ProdNo")
        workstation = Request.QueryString("ws")
        lblProdNo.Text = BoatNotesProdNo
        hdnWorkstation.Value = workstation
        If workstation Is Nothing Then
            btnBoatOfflineNote.Visible = False
            tbOfflineNote.Visible = False
            lblAddNewOfflineNote.Visible = False
        End If
    End Sub

    Protected Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")
    End Sub

    Protected Sub btnBoatOfflineNote_Click(sender As Object, e As EventArgs) Handles btnBoatOfflineNote.Click
        Dim Note As String = tbOfflineNote.Text
        Dim BoatOfflineProdNo As String = lblProdNo.Text

        Dim Status As String = rblBoatStatus.SelectedItem.Text
        Dim StatusCode As Integer = rblBoatStatus.SelectedValue


        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim TodaysDate As Date = Date.Now

        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@Note", Note)
        cmd.Parameters.AddWithValue("@BoatNotesProdNo", BoatOfflineProdNo)
        cmd.Parameters.AddWithValue("@Workstation", hdnWorkstation.Value)
        cmd.Parameters.AddWithValue("@StatusSetTo", Status)
        cmd.Parameters.AddWithValue("@StatusCode", StatusCode)

        conn.ConnectionString = connstr
        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Insert into BML_POPREPORTING_OFFLINE (Date, OfflineNote, ProdNo, Workcenter, StatusSetTo, Cleared) VALUES (@TodaysDate, @Note, @BoatNotesProdNo, @Workstation, @StatusSetTo, '0')"
        cmd2.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set IsBoatOffline ='" & StatusCode & " ' where ProdNo =  '" & BoatOfflineProdNo & "'"
        cmd.Connection = conn
        cmd2.Connection = conn

        conn.Open()
        cmd.ExecuteNonQuery()
        cmd2.ExecuteNonQuery()

        MesgBox("Saved")

        'If Status = "Offline" Then

        'Dim SmtpServer As New Net.Mail.SmtpClient
        'Dim mail As New Net.Mail.MailMessage
        'SmtpServer.Host = "192.168.1.5"
        'SmtpServer.UseDefaultCredentials = False
        'SmtpServer.Credentials = New System.Net.NetworkCredential("krimbaugh@benningtonmarine.com", "keRi0213")

        'mail.From = New Net.Mail.MailAddress("krimbaugh@benningtonmarine.com")
        'mail.To.Add("krimbaugh@benningtonmarine.com")
        'mail.To.Add("jnafziger@benningtonmarine.com")
        'mail.To.Add("aweiss@benningtonmarine.com")
        'mail.Subject = "Prod # " & BoatOfflineProdNo & " Has Gone Offline"
        'mail.Body = "Bennington Production #" & BoatOfflineProdNo & " Has gone offline at " & hdnWorkstation.Value & " for the following reason: " & Note & ""
        'SmtpServer.Send(mail)
        'End If
        ' Response.Write("<script language='javascript'> { return CloseWindow();}</script>")

        'Response.Write("<script language='javascript'> { window.opener='mywindow';window.opener.location.reload();}</script>")

        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")

    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "clearsidelineitem" Then
            Dim Auto As String = e.CommandArgument 'get the row that is clicked
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "Update BML_POPREPORTING_OFFLINE Set Cleared ='1', DateCleared = '" & TodaysDate & "' where Auto =  '" & Auto & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            GridView1.DataBind()

        End If
    End Sub
End Class
