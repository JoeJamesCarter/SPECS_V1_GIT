Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Rails_Scheduling
    Inherits System.Web.UI.Page

    
    Protected Sub gvRailsSchedule_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRailsSchedule.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim Blackout As String = e.Row.Cells(4).Text
            Dim Powertop As String = e.Row.Cells(5).Text
            'Dim Shatter As String = e.Row.Cells(6).Text
            Dim tbWeldDate As TextBox = TryCast(e.Row.Cells(6).FindControl("tbWeldDate"), TextBox)

            If Blackout = "1" Then
                e.Row.Cells(4).Text = "Blackout"
            Else
                e.Row.Cells(4).Text = ""
            End If

            If Powertop = "1" Then
                e.Row.Cells(5).Text = "Power Top"
            Else
                e.Row.Cells(5).Text = ""
            End If

            'If Shatter = "1" Then
            ' e.Row.Cells(6).Text = "Shatter"
            'Else
            'e.Row.Cells(6).Text = ""
            'End If
            If tbWeldDate.Text = "1/1/1900" Then
                tbWeldDate.Text = ""
            End If

            If (e.Row.DataItem("IsCustom") = "1") Then
                e.Row.Cells(1).BackColor = Drawing.Color.Yellow
            End If

            If (e.Row.DataItem("IsPilot") = "1") Then
                e.Row.Cells(2).BackColor = Drawing.Color.LightBlue
            End If

            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.Cells(0).BackColor = Drawing.Color.DarkGray
            End If

            If (e.Row.DataItem("Protech") = "1") Then
                e.Row.Cells(11).BackColor = Drawing.Color.Orange
            End If

        End If

    End Sub

    Protected Sub btnSelect_Click(sender As Object, e As EventArgs) Handles btnSelect.Click
        Dim first As String = tbFirst.Text
        Dim last As String = tbLast.Text
        last = last + 1
        Dim dateselected = Calendar1.SelectedDate

        For Each row In gvRailsSchedule.Rows

            Dim Prod As String = row.Cells(1).Text
            If Prod >= first And Prod <= last Then
                Dim selected As CheckBox = TryCast(row.Cells(0).FindControl("cbSelect"), CheckBox)
                selected.Checked = True
                Dim tbWeldDate As TextBox = TryCast(row.Cells(6).FindControl("tbWeldDate"), TextBox)
                tbWeldDate.Text = dateselected
            End If
        Next
    End Sub

    Protected Sub btnDeselectAll_Click(sender As Object, e As EventArgs) Handles btnDeselectAll.Click
        If ddlShowSelect.SelectedValue = 0 Then
            For Each row In gvRailsSchedule.Rows
                Dim selected As CheckBox = TryCast(row.Cells(0).FindControl("cbSelect"), CheckBox)
                selected.Checked = False
                Dim tbWeldDate As TextBox = TryCast(row.Cells(6).FindControl("tbWeldDate"), TextBox)
                tbWeldDate.Text = ""
            Next
        End If

    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand

        Dim selecteddate As Date = Calendar1.SelectedDate

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn

        cmd.CommandType = CommandType.Text
        cmd1.CommandType = CommandType.Text
        cmd2.CommandType = CommandType.Text

        conn.Open()
        For Each row In gvRailsSchedule.Rows
            Dim selected As CheckBox = TryCast(row.Cells(0).FindControl("cbSelect"), CheckBox)

            If selected.Checked = True Then
                Dim prod As String = row.Cells(1).Text
                Dim drawing As TextBox = TryCast(row.Cells(3).FindControl("tbCustomNo"), TextBox)
                Dim welddate As TextBox = TryCast(row.Cells(6).FindControl("tbWeldDate"), TextBox)
                Dim railsneeded As TextBox = TryCast(row.Cells(7).FindControl("tbNumRailsNeeded"), TextBox)

                Dim drawingText As String = drawing.Text

                Dim cbT As CheckBox = DirectCast(row.Cells(10).FindControl("cbT"), CheckBox)
                Dim cbPM As CheckBox = DirectCast(row.Cells(8).FindControl("cbPM"), CheckBox)
                Dim cbSM As CheckBox = DirectCast(row.Cells(9).FindControl("cbSM"), CheckBox)
                Dim cbprotech As CheckBox = DirectCast(row.Cells(11).FindControl("cbprotech"), CheckBox)

                Dim T As Integer = If(cbT.Checked, 1, 0)
                Dim PM As Integer = If(cbPM.Checked, 1, 0)
                Dim SM As Integer = If(cbSM.Checked, 1, 0)
                Dim Protech As Integer = If(cbprotech.Checked, 1, 0)

                'cmd.Parameters.AddWithValue("@T1", T)
                'cmd.Parameters.AddWithValue("@PM1", PM)
                'cmd.Parameters.AddWithValue("@SM1", SM)

                'cmd2.Parameters.AddWithValue("@T2", T)
                'cmd2.Parameters.AddWithValue("@PM2", PM)
                'cmd2.Parameters.AddWithValue("@SM2", SM)
                'If (Len(welddate.Text)) > 0 Then
                'Dim welddateText As Date = welddate.Text
                'End If

                Dim emptywelddate As Nullable(Of Date) = Nothing

                If Len(welddate.Text) > 0 Then
                    cmd.CommandText = "UPDATE Rails_Tracking SET Scheduled = '1', WeldDate = '" & welddate.Text & "', RailsNeeded = '" & railsneeded.Text & "', CustDrawNo = '" & drawingText & "', NeedsPortMid = '" & PM & "', NeedsStrbMid = '" & SM & "', NeedsTransom = '" & T & "', Protech = '" & Protech & "' where ProdNo =  '" & prod & "'"
                    cmd.ExecuteNonQuery()
                End If

                If Len(welddate.Text) <= 0 Then
                    cmd2.CommandText = "UPDATE Rails_Tracking SET Scheduled = '0', WeldDate = '" & emptywelddate & "', RailsNeeded = '" & railsneeded.Text & "', CustDrawNo = '" & drawingText & "', NeedsPortMid = '" & PM & "', NeedsStrbMid = '" & SM & "', NeedsTransom = '" & T & "', Protech = '" & Protech & "' where ProdNo =  '" & prod & "'"
                    cmd2.ExecuteNonQuery()
                End If

            End If

        Next

        cmd1.CommandText = "Select Count (*) FROM Rails_Tracking where WeldDate =  '" & selecteddate & "'"
        Dim numscheduled As Integer = cmd1.ExecuteScalar
        lblBoatsScheduled.Text = numscheduled
        conn.Close()
        gvRailsSchedule.DataBind()
    End Sub


    Protected Sub Calendar1_SelectionChanged(sender As Object, e As EventArgs) Handles Calendar1.SelectionChanged

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        Dim selecteddate As Date = Calendar1.SelectedDate

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd.CommandType = CommandType.Text

        cmd.CommandText = "Select Count (*) FROM Rails_Tracking where WeldDate =  '" & selecteddate & "'"
        conn.Open()
        Dim numscheduled As Integer = cmd.ExecuteScalar
        lblBoatsScheduled.Text = numscheduled
        conn.Close()

    End Sub


    Protected Sub btnApplyDate_Click(sender As Object, e As EventArgs) Handles btnApplyDate.Click
        If ddlShowSelect.SelectedValue = 0 Then
            Dim dateselected = Calendar1.SelectedDate

            For Each row In gvRailsSchedule.Rows
                Dim selected As CheckBox = TryCast(row.Cells(0).FindControl("cbSelect"), CheckBox)
                If selected.Checked = True Then
                    Dim tbWeldDate As TextBox = TryCast(row.Cells(6).FindControl("tbWeldDate"), TextBox)
                    tbWeldDate.Text = dateselected
                End If

            Next
        End If
    End Sub

    Protected Sub gvRailsSchedule_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvRailsSchedule.RowCommand
        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If
    End Sub


    Protected Sub btnNumSelected_Click(sender As Object, e As EventArgs) Handles btnNumSelected.Click
        Dim numselected As Integer

        For Each row In gvRailsSchedule.Rows
            Dim selected As CheckBox = TryCast(row.Cells(0).FindControl("cbSelect"), CheckBox)

            If selected.Checked = True Then
                numselected = numselected + 1
            End If
        Next
        lblNumSelected.Text = numselected

    End Sub
End Class
