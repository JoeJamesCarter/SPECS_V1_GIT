Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class RedTags
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
            btnBoatNote.Visible = False
            tbNote.Visible = False
            lblAddNewNote.Visible = False
        End If

    End Sub
    Protected Sub btnBoatNote_Click(sender As Object, e As EventArgs) Handles btnBoatNote.Click 'for entering red tags
        Dim Note As String = tbNote.Text
        Dim BoatNotesProdNo As String = lblProdNo.Text
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim TodaysDate As Date = Date.Now

        If tbNote.Text = "" Then
            MesgBox("Please type in a reason for this red tag and submit again.")
        Else

            cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
            cmd.Parameters.AddWithValue("@Note", Note)
            cmd.Parameters.AddWithValue("@BoatNotesProdNo", BoatNotesProdNo)
            'cmd.Parameters.AddWithValue("@Workstation", hdnWorkstation.Value)

            conn.ConnectionString = connstr
            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Insert into BML_POPREPORTING_REDTAGS (Date, RedTagNote, ProdNo) VALUES (@TodaysDate, @Note, @BoatNotesProdNo)"
            cmd2.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set IsRedTagged ='1' where ProdNo =  '" & BoatNotesProdNo & "'"
            cmd.Connection = conn
            cmd2.Connection = conn

            conn.Open()
            cmd2.ExecuteNonQuery()

            cmd.ExecuteNonQuery()
            MesgBox("Saved")
            Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")

            'email chelsea when a red tag is set
            'Dim SmtpServer As New Net.Mail.SmtpClient
            'Dim mail As New Net.Mail.MailMessage
            'SmtpServer.Host = "192.168.1.5"
            'SmtpServer.UseDefaultCredentials = False
            'SmtpServer.Credentials = New System.Net.NetworkCredential("krimbaugh@benningtonmarine.com", "keRi0213")

            'mail.From = New Net.Mail.MailAddress("specs@benningtonmarine.com", "SPECS")
            'mail.To.Add("krimbaugh@benningtonmarine.com")
            'mail.To.Add("aweiss@benningtonmarine.com")
            'mail.Subject = "Bennington Red Tag Info - Prod # " & BoatNotesProdNo & ""
            'mail.Body = "Bennington Production #" & BoatNotesProdNo & " has been red tagged. The reason specified is: " & Note & ""
            'SmtpServer.Send(mail)

        End If
    End Sub

    Protected Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")

    End Sub


    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "clearredtag" Then

            Dim auto As String = e.CommandArgument
            Dim BoatNotesProdNo As String = lblProdNo.Text
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn

            cmd.CommandText = "Update BML_POPREPORTING_REDTAGS Set DateCleared = '" & TodaysDate & "' where Auto =  '" & auto & "'"
            cmd1.CommandText = "Select Count(Auto) From BML_POPREPORTING_REDTAGS where ProdNo =  '" & BoatNotesProdNo & "' and DateCleared is Null"
            cmd2.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set IsRedTagged ='0' where ProdNo =  '" & BoatNotesProdNo & "'"


            conn.Open()
            cmd.ExecuteNonQuery() 'clear individual red tag
            Dim opentags As Int16 = cmd1.ExecuteScalar 'See if this prod has any more red tags.

            If opentags < 1 Then
                cmd2.ExecuteNonQuery() 'clear the red tag flag at the prod # level.
            End If

            'MesgBox("Red Tag Cleared")

            GridView1.DataBind()
            gvClosedTags.DataBind()

            'Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")


        End If
    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsRedTagComments"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
        End If

    End Sub
End Class
