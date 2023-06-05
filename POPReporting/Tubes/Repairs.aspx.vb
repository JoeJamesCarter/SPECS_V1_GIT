Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Tubes_Repairs
    Inherits System.Web.UI.Page

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Tubes_Repairs_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String

        If ddlDaysInAdvance.Items.Count = 0 Then  'stop it from repopulating everytime the grid rebinds
            DaystoShow = ThisDay.AddDays(5).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("3 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(7).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("5 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(12).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("10 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(17).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("15 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(22).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("20 Days", DaystoShow))
        End If


        If ddlShowSelect.SelectedValue = 1 Then
            gvTubeRepairs.Columns(6).Visible = False
        Else : gvTubeRepairs.Columns(6).Visible = True
        End If

        Dim cmd As New SqlCommand
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        conn.ConnectionString = connstr
        cmd.CommandText = "Select Count (*) FROM Tubes_DamageReported where RepairedFlag = 1 and Convert(date,Repaired) ='" & ThisDay & "'"
        cmd.Connection = conn

        conn.Open()

        recordcount = Convert.ToInt16(cmd.ExecuteScalar())
        lblBoatsStarted.Text = recordcount

        conn.Close()

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
        If user = "IUSR" Then
            GlobalVariables.stationID = ""
        End If

    End Sub

    Protected Sub ddlShowSelect_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlShowSelect.SelectedIndexChanged
        gvTubeRepairs.DataBind() 'used to allow the user to hide/show jobs that they have completed.
        If ddlShowSelect.SelectedValue = 1 Then
            gvTubeRepairs.Columns(6).Visible = False
        Else : gvTubeRepairs.Columns(6).Visible = True
        End If
    End Sub

    Protected Sub ddlDaysInAdvance_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDaysInAdvance.SelectedIndexChanged

        gvTubeRepairs.DataBind()
        If ddlShowSelect.SelectedValue = 1 Then
            gvTubeRepairs.Columns(6).Visible = False
        Else : gvTubeRepairs.Columns(6).Visible = True
        End If

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvTubeRepairs.DataBind()
        If ddlShowSelect.SelectedValue = 1 Then
            gvTubeRepairs.Columns(6).Visible = False
        Else : gvTubeRepairs.Columns(6).Visible = True
        End If
    End Sub

    Protected Sub gvTubeRepairs_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvTubeRepairs.RowCommand
        If e.CommandName = "gotoupdate" Then

            Dim newline As String = "<br/>"
            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")

            Dim Key As Integer = Convert.ToInt16(Line(0))
            Dim TubeID As Integer = Convert.ToInt16(Line(1))
            Dim SelectedProd As Integer = Line(2)
            Dim SelectedModel As String = Line(3)
            Dim Tube As String = Line(4)
            Dim countremaining As Integer = 0

            Dim stationID As String = GlobalVariables.stationID

            Dim img As Image = CType(gvTubeRepairs.Rows(Key).FindControl("btnUpdateRepaired"), Image)
            Dim btnvalue = img.ImageUrl
            btnvalue = Mid(btnvalue, 19, 1) 'get the value of RepairedFlag from the imageurl. Get 1 character at 19.


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET HasTubeDamage = 0 where ProdNo =  '" & SelectedProd & "'"
            cmd1.CommandText = "UPDATE Tubes_DamageReported Set RepairedFlag = 1, Repaired = '" & TodaysDate & "' Where AutoID = '" & TubeID & "'"

            'count completed today
            cmd2.CommandText = "Select Count (*) FROM Tubes_DamageReported where RepairedFlag = 1 and Convert(date,Repaired) ='" & ThisDay & "'"
           
            'reverse done
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET HasTubeDamage = 1 where ProdNo =  '" & SelectedProd & "'"
            cmd3.CommandText = "UPDATE Tubes_DamageReported Set RepairedFlag = 0, Repaired = NULL Where AutoID = '" & TubeID & "'"

            'test if there is more than one tube to repair
            cmd5.CommandText = "Select Count (*) From Tubes_DamageReported Where (RepairedFlag = 0 and ReplacedFlag = 0) and AutoID = '" & TubeID & "'"

            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn

            conn.Open()

            If btnvalue.ToString = "0" Then
                cmd1.ExecuteNonQuery() 'update this tube

                'test if there is only one line for this boat first.
                countremaining = cmd5.ExecuteScalar()
                'MesgBox(countremaining)
                If countremaining = "0" Then
                    cmd.ExecuteNonQuery()
                End If

            ElseIf btnvalue.ToString = "1" Then
                cmd3.ExecuteNonQuery()
                cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())

            lblBoatsStarted.Text = recordcount

            gvTubeRepairs.DataBind()
            conn.Close()

            Try

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
                'mail.To.Add("dgorbics@benningtonmarine.com")
                mail.To.Add("skantz@benningtonmarine.com")
                mail.To.Add("msmith@benningtonmarine.com")

                mail.Subject = "Tube Repair Completed - " & SelectedProd
                mail.IsBodyHtml = True
                Dim mymessage As String = "Tube repair has been completed on " & TodaysDate & newline & "Prod #: " & SelectedProd & newline & "Model: " & SelectedModel & newline & "Tube: " & Tube & newline & "Completed By: " & stationID & newline & ""
                Dim message As String = mymessage

                mail.Body = message

                SmtpServer.Send(mail)
            Catch ex As Exception

            End Try

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "gotoreplace" Then
            'Dim Key As String = e.CommandArgument 'get the row that was clicked
            'Dim TubeID As Integer = gvTubeRepairs.Rows(Key).Cells(3).Text

            Dim newline As String = "<br/>"
            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")

            Dim Key As Integer = Convert.ToInt16(Line(0))
            Dim TubeID As Integer = Convert.ToInt16(Line(1))
            Dim SelectedProd As Integer = Line(2)
            Dim SelectedModel As String = Line(3)
            Dim Tube As String = Line(4)

            Dim stationID As String = GlobalVariables.stationID

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE Tubes_DamageReported SET RepairReqdFlag = 0, RepairedFlag = 0, Repaired = NULL, ReplaceReqdFlag = 1, ActionRequired = 'REPLACE', IsScrap = 1 where AutoID =  '" & TubeID & "'"
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            Try
                'Send email to Dan

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
                mail.To.Add("dgorbics@benningtonmarine.com")
                mail.To.Add("skantz@benningtonmarine.com")
                mail.To.Add("msmith@benningtonmarine.com")

                mail.Subject = "Tube Can't Be Repaired - Needs Replaced"
                mail.IsBodyHtml = True
                Dim mymessage As String = "A replacement of a tube has been requested on " & TodaysDate & newline & "Prod #: " & SelectedProd & newline & "Model: " & SelectedModel & newline & "Tube: " & Tube & newline & "Switch to Replaced By: " & stationID & newline & "A Repair Could Not Be Successfully Completed ."
                Dim message As String = mymessage

                mail.Body = message

                SmtpServer.Send(mail)
            Catch ex As Exception

            End Try


        End If

    End Sub

    Protected Sub gvTubeRepairs_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvTubeRepairs.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
            If (e.Row.DataItem("ScheduledToLoad") = "1") Then
                e.Row.Cells(0).BackColor = Drawing.Color.Orange
            End If
        End If
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
