Imports System.Data
Imports System.Data.SqlClient
Partial Class HelmsSouth
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


    Protected Sub gvHelm_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvHelm.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvHelm.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Helms" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvHelm.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Helms" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        'This code is for the update button
        If e.CommandName = "gotoupdate" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvHelm.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvHelm.Rows(Key).FindControl("btnUpdateHelm"), Image)
            Dim helmsvalue = img.ImageUrl
            helmsvalue = Mid(helmsvalue, 26, 1) 'get the value of HelmInstalledStatus from the imageurl.
            Dim NextWorkstationHasDate As Int16
            Dim southshrinkcount As Int16 = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand
            Dim cmd6 As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET HelmInstalledStatus = '2', CleaningStatus = '1', HelmInstalled = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmInstalledStatus = 2 and BuildLoc = 'M' and Convert(date,HelmInstalled) ='" & ThisDay & "'"
            'Check if the next workstation already has a finish date.
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where Cleaning is not NULL and ProdNo = '" & SelectedProdNo & "'"
            'reverse it only if the next workstation hasn't reported it complete.
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET HelmInstalledStatus = '1', CleaningStatus = '0', HelmInstalled = NULL where ProdNo =  '" & SelectedProdNo & "' and Cleaning is NULL"
            cmd5.CommandText = "Select CoversStatus from BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & SelectedProdNo & "'"
            cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd6.Connection = conn

            conn.Open()


            If helmsvalue <= 1 Then
                cmd.ExecuteNonQuery()
                Try
                    EmailKeri(SelectedProdNo)
                Catch ex As Exception

                End Try
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action becuase the next station has already completed this boat.")
                Else
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started/finished.
                End If
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())

            lblBoatsStarted.Text = recordcount
            coverstatus = Convert.ToInt16(cmd5.ExecuteScalar())

            southshrinkcount = Convert.ToInt16(cmd6.ExecuteScalar())
            lblSouthShrink.Text = southshrinkcount


            gvHelm.DataBind()

            conn.Close()

            If helmsvalue = 1 Then 'changing from start to done, not the other way.
                If coverstatus = 1 Then
                    Dim SmtpServer As New Net.Mail.SmtpClient
                    Dim mail As New Net.Mail.MailMessage
                    SmtpServer.Host = "elkhart.benningtonmarine.com"
                    SmtpServer.UseDefaultCredentials = False
                    SmtpServer.Credentials = New System.Net.NetworkCredential("smtpsvc@benningtonmarine.com", "B3nn1SMTP!")

                    mail.From = New Net.Mail.MailAddress("specs@benningtonmarine.com", "SPECS")
                    mail.To.Add("tumacschris@comcast.net")

                    'mail.To.Add("vknight@benningtonmarine.com")
                    mail.Subject = "Bennington Cover Ready to Be Patterned - Prod # " & SelectedProdNo & ""
                    mail.Body = "Bennington Production #" & SelectedProdNo & " is completed through Helm Install and ready to be patterned. "
                    'SmtpServer.Send(mail)
                End If
            End If
        End If

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String
        Dim southshrinkcount As Int16 = 0

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

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr

        cmd2.CommandType = CommandType.Text
        cmd3.CommandType = CommandType.Text

        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmInstalledStatus = 2 and BuildLoc = 'M' and Convert(date,HelmInstalled) ='" & ThisDay & "'"
        'to get the count of the prod #'s completed that day
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

        cmd2.Connection = conn
        cmd3.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount

        southshrinkcount = Convert.ToInt16(cmd3.ExecuteScalar())
        lblSouthShrink.Text = southshrinkcount

        'MesgBox(recordcount)
        conn.Close()

        ddlBldg.SelectedValue = "S"

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvHelm.DataBind()
    End Sub

    Protected Sub gvHelm_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvHelm.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsHelm"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
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

    Protected Function EmailKeri(prod As String) As String
        Try
            'Send email to Dan
            Dim newline As String = "<br/>"

            Dim stationID As String = GlobalVariables.stationID
            Dim TodaysDate As Date = Date.Now

            Dim SmtpServer As New Net.Mail.SmtpClient()
            Dim mail As New Net.Mail.MailMessage

            SmtpServer.Credentials = New System.Net.NetworkCredential("svccopier_smtp@polarisind.com", "dccGqWkzFWrFM4")
            SmtpServer.Host = "smtp.office365.com"
            SmtpServer.EnableSsl = True
            SmtpServer.Port = 587

            mail.IsBodyHtml = True
            mail.From = New Net.Mail.MailAddress("svccopier_smtp@polaris.com", "SPECS")

            mail.To.Add("krimbaugh@benningtonmarine.com")

            mail.Subject = "Helm Install Complete in South"
            mail.IsBodyHtml = True
            Dim mymessage As String = "A helm installation has been reported as complete on " & TodaysDate & newline & "Prod #: " & prod & newline & "By: " & stationID & newline & "."
            Dim message As String = mymessage

            mail.Body = message

            SmtpServer.Send(mail)
        Catch ex As Exception

        End Try
        Return True
    End Function

End Class
