﻿Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_Trim
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gvTrim_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvTrim.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvTrim.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Floors" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvTrim.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Floors" 'to pass in the workstation that makes the note.
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
            Dim SelectedProdNo As Integer = gvTrim.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvTrim.Rows(Key).FindControl("btnUpdateTrim"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 26, 1) 'get the value of FloorsInstalledStatus from the imageurl.
            Dim NextWorkstationHasDate As Int16



            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand
            Dim cmd6 As New SqlCommand
            Dim cmd7 As New SqlCommand
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand
            Dim cmd10 As New SqlCommand
            Dim cmd11 As New SqlCommand
            Dim cmd12 As New SqlCommand
            Dim cmd13 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim recordcountS As Int16 = 0
            Dim isSBoat As Int16 = 0
            Dim trimreadytostart As Int16 = 0
            Dim southshrinkcount As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET TrimStatus = '2', RailsInstalledStatus = '1', Trim = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = 2 and BuildLoc = 'M' and Convert(date,Trim) ='" & ThisDay & "'"
            cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = 2 and BuildLoc = 'V' and Convert(date,Trim) ='" & ThisDay & "'"

            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalled is not NULL and ProdNo = '" & SelectedProdNo & "'"
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET TrimStatus = '1', RailsInstalledStatus = '0', FloorsInstalled = NULL where ProdNo =  '" & SelectedProdNo & "' and RailsInstalled is NULL"
            cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = 2 and BuildLoc = 'S' and ProdNo ='" & SelectedProdNo & "'"
            cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = 1 and ProdNo > 160188"
            cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

            cmd8.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set BoatHasNotes ='1', NotesRails ='1' where ProdNo =  '" & SelectedProdNo & "'"
            cmd9.CommandText = "Insert into BML_POPREPORTING_NOTES (Date, Note, ProdNo, Workstation, CreatedFor) VALUES ('" & ThisDay & "', 'South Frame Ready', '" & SelectedProdNo & "', 'Trim', 'Rails' )"

            cmd11.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'V' and TrimStatus = 1 and ProdNo > 2100000"
            cmd12.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'M' and TrimStatus = 1 and ProdNo > 2100000"
            cmd13.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and TrimStatus = 1 and ProdNo > 2100000"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd6.Connection = conn
            cmd7.Connection = conn
            cmd8.Connection = conn
            cmd9.Connection = conn
            cmd10.Connection = conn

            conn.Open()


            If floorvalue <= 1 Then
                cmd.ExecuteNonQuery()

                isSBoat = Convert.ToInt16(cmd5.ExecuteScalar())

                If isSBoat = 1 Then 'email Jim to come get it

                    cmd8.ExecuteNonQuery() 'Set it to have notes for Rails
                    cmd9.ExecuteNonQuery() 'Add Note for Rails

                    'Dim SmtpServer As New Net.Mail.SmtpClient
                    'Dim mail As New Net.Mail.MailMessage
                    'SmtpServer.Host = "192.168.1.5"
                    'SmtpServer.UseDefaultCredentials = False
                    'SmtpServer.Credentials = New System.Net.NetworkCredential("krimbaugh@benningtonmarine.com", "keRi0213")

                    'mail.From = New Net.Mail.MailAddress("specs@benningtonmarine.com", "SPECS")
                    'mail.To.Add("jsmith@benningtonmarine.com")
                    'mail.To.Add("krimbaugh@benningtonmarine.com")
                    'mail.Subject = "Bennington South Bldg Frame Ready for Pickup - " & SelectedProdNo & ""
                    'mail.Body = "Bennington Production #" & SelectedProdNo & " is completed through floors and ready to go to the south building. "
                    'SmtpServer.Send(mail)
                End If

            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed this boat.")
                Else
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started/finished.
                End If
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            recordcount = Convert.ToInt16(cmd5.ExecuteScalar())

            lblBoatsStarted.Text = recordcount
            lblBoatsStartedS.Text = recordcountS
            lblVBoatsStarted.Text = cmd10.ExecuteScalar
            trimreadytostart = Convert.ToInt16(cmd6.ExecuteScalar)
            lblReadyToStart.Text = trimreadytostart

            lblValueReadyToStart.Text = cmd7.ExecuteScalar
            lblMainReadyToStart.Text = cmd8.ExecuteScalar
            lblSouthReadyToStart.Text = cmd9.ExecuteScalar


            'southshrinkcount = Convert.ToInt16(cmd7.ExecuteScalar())
            'lblSouthShrink.Text = southshrinkcount

            gvTrim.DataBind()

            conn.Close()



        End If

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd6 As New SqlCommand
        Dim cmd7 As New SqlCommand
        Dim cmd8 As New SqlCommand
        Dim cmd9 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim recordcountS As Int16 = 0
        Dim trimreadytostart As Int16 = 0
        Dim southshrinkcount As Int16 = 0

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
            DaystoShow = ThisDay.AddDays(32).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("40 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(42).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("50 Days", DaystoShow))
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = 2 and BuildLoc ='M' and Convert(date,Trim) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = 2 and BuildLoc ='S' and Convert(date,Trim) ='" & ThisDay & "'"
        'to get the count of the prod #'s completed that day
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = 1 and ProdNo > 2100000"
        cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = 2 and BuildLoc ='V' and Convert(date,Trim) ='" & ThisDay & "'"
        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'V' and TrimStatus = 1 and ProdNo > 2100000"
        cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'M' and TrimStatus = 1 and ProdNo > 2100000"
        cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and TrimStatus = 1 and ProdNo > 2100000"

        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd8.Connection = conn
        cmd9.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount

        recordcountS = Convert.ToInt16(cmd3.ExecuteScalar())
        lblBoatsStartedS.Text = recordcountS

        lblVBoatsStarted.Text = cmd6.ExecuteScalar

        trimreadytostart = Convert.ToInt16(cmd4.ExecuteScalar)
        lblReadyToStart.Text = trimreadytostart
        lblValueReadyToStart.Text = cmd7.ExecuteScalar
        lblMainReadyToStart.Text = cmd8.ExecuteScalar
        lblSouthReadyToStart.Text = cmd9.ExecuteScalar

        'southshrinkcount = Convert.ToInt16(cmd5.ExecuteScalar())
        'lblSouthShrink.Text = southshrinkcount
        'MesgBox(recordcount)
        conn.Close()
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvTrim.DataBind()
    End Sub

    Protected Sub gvTrim_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvTrim.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsTrim"), SqlDataSource)

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


End Class
