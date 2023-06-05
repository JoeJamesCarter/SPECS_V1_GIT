
Imports System.Data
Imports System.Data.SqlClient

Partial Class EHS_TempTracker
    Inherits System.Web.UI.Page

    Public emps As New DataTable
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub EHS_TempTracker_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbEmpBadgeNo.Focus()
        Dim pageLastLoaded As Label = FindControl("pageLastLoaded")

        If emps.Rows.Count = 0 Then
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("BenningtonATTConnectionString").ConnectionString
            conn.ConnectionString = connstr
            conn.Open()

            Dim SqlDataAdapter As New SqlDataAdapter
            SqlDataAdapter.SelectCommand = New SqlCommand("SELECT BADGE, LASTNAME, FIRSTNAME FROM EMPLOYEES Where ActiveStatus = 0", conn)
            SqlDataAdapter.Fill(emps)
            'MesgBox(emps.Rows.Count)
            conn.Close()
            pageLastLoaded.Text = Date.Now()
        End If
    End Sub

    Private Sub tbEmpBadgeNo_TextChanged(sender As Object, e As EventArgs) Handles tbEmpBadgeNo.TextChanged

        lblBadge.Text = ""
        lblFirst.Text = ""
        lblLast.Text = ""

        Dim empView As DataView = emps.DefaultView
        Dim badge As String = tbEmpBadgeNo.Text

        empView.RowFilter = "BADGE = " & badge

        If empView.Count > 0 Then
            For Each rowView As DataRowView In empView
                Dim row As DataRow = rowView.Row
                lblBadge.Text = row("BADGE").ToString
                lblFirst.Text = row("FIRSTNAME").ToString
                lblLast.Text = row("LASTNAME").ToString

                Try
                    SubmitChecked()
                Catch ex As Exception
                    Dim text7 As String = "SOMETHING WENT WRONG. NOTE THIS Badge # " & tbEmpBadgeNo.Text & " As Checked."
                    ScriptManager.RegisterStartupScript(Me, GetType(Page), "Error", "<script>showpopError('" & text7 & "')</script>", False)
                End Try
            Next
        Else
            ErrorOnSubmit()
            Dim text7 As String = "EMPLOYEE NOT FOUND - Logged as Error."
            ScriptManager.RegisterStartupScript(Me, GetType(Page), "Error", "<script>showpopError('" & text7 & "')</script>", False)
        End If

    End Sub

    Private Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbEmpBadgeNo.Text = ""
        lblBadge.Text = ""
        lblFirst.Text = ""
        lblLast.Text = ""
    End Sub

    Private Sub gvRunningList_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRunningList.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim empView As DataView = emps.DefaultView
            Dim badge As String = e.Row.Cells(0).Text

            empView.RowFilter = "BADGE = " & badge

            For Each rowView As DataRowView In empView
                Dim row As DataRow = rowView.Row
                Dim lblName As Label = DirectCast(e.Row.FindControl("lblEmpFullName"), Label)
                lblName.Text = row("FIRSTNAME").ToString & " " & row("LASTNAME").ToString
            Next
        End If


    End Sub

    'Private Sub btnChecked_Click(sender As Object, e As EventArgs) Handles btnChecked.Click

    '    Dim conn As New SqlConnection()
    '    Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

    '    Dim cmd As New SqlCommand
    '    Dim TodaysDate As Date = Date.Now
    '    conn.ConnectionString = connstr

    '    cmd.Connection = conn

    '    cmd.Parameters.AddWithValue("@badge", tbEmpBadgeNo.Text)
    '    cmd.Parameters.AddWithValue("@today", TodaysDate)
    '    cmd.Parameters.AddWithValue("@result", "CHECKED")

    '    cmd.CommandText = "Insert into TempChecks (BadgeNo, DateChecked, Result) VALUES (@badge, @today, @result)"

    '    conn.Open()

    '    Try
    '        cmd.ExecuteNonQuery()
    '        Dim text6 As String = "SAVED SUCCESSFULLY - Badge # " & tbEmpBadgeNo.Text & " " & lblFirst.Text & " " & lblLast.Text & " Checked."
    '        ScriptManager.RegisterStartupScript(Me, GetType(Page), "Success", "<script>showpopSuccess('" & text6 & "')</script>", False)

    '    Catch

    '    End Try
    '    conn.Close()

    '    tbEmpBadgeNo.Text = ""
    '    lblBadge.Text = ""
    '    'lblFirst.Text = ""
    '    'lblLast.Text = ""
    '    tbEmpBadgeNo.Focus()
    'End Sub

    Function SubmitChecked() As String
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim TodaysDate As Date = Date.Now
        conn.ConnectionString = connstr

        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@badge", tbEmpBadgeNo.Text)
        cmd.Parameters.AddWithValue("@today", TodaysDate)
        cmd.Parameters.AddWithValue("@result", "CHECKED")

        cmd.CommandText = "Insert into TempChecks (BadgeNo, DateChecked, Result) VALUES (@badge, @today, @result)"

        conn.Open()

        Try
            cmd.ExecuteNonQuery()
            Dim text6 As String = "SAVED SUCCESSFULLY - Badge # " & tbEmpBadgeNo.Text & " " & lblFirst.Text & " " & lblLast.Text & " Checked."
            ScriptManager.RegisterStartupScript(Me, GetType(Page), "Success", "<script>showpopSuccess('" & text6 & "')</script>", False)

        Catch

        End Try
        conn.Close()

        tbEmpBadgeNo.Text = ""
        lblBadge.Text = ""
        'lblFirst.Text = ""
        'lblLast.Text = ""
        tbEmpBadgeNo.Focus()
        gvRunningList.DataBind()
        Return False
    End Function

    Function ErrorOnSubmit() As String
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim TodaysDate As Date = Date.Now
        conn.ConnectionString = connstr

        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@badge", tbEmpBadgeNo.Text)
        cmd.Parameters.AddWithValue("@today", TodaysDate)
        cmd.Parameters.AddWithValue("@result", "ERROR")

        cmd.CommandText = "Insert into TempChecksErrors (BadgeNo, DateChecked, Result) VALUES (@badge, @today, @result)"

        conn.Open()

        Try
            cmd.ExecuteNonQuery()
            'Dim text6 As String = "SAVED SUCCESSFULLY - Badge # " & tbEmpBadgeNo.Text & " " & lblFirst.Text & " " & lblLast.Text & " Checked."
            'ScriptManager.RegisterStartupScript(Me, GetType(Page), "Success", "<script>showpopSuccess('" & text6 & "')</script>", False)

        Catch

        End Try
        conn.Close()

        tbEmpBadgeNo.Text = ""
        lblBadge.Text = ""
        'lblFirst.Text = ""
        'lblLast.Text = ""
        tbEmpBadgeNo.Focus()
        gvRunningList.DataBind()
        Return False
    End Function


    'Private Sub btnPass_Click(sender As Object, e As EventArgs) Handles btnPass.Click

    '    Dim conn As New SqlConnection()
    '    Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

    '    Dim cmd As New SqlCommand
    '    Dim TodaysDate As Date = Date.Now
    '    conn.ConnectionString = connstr

    '    cmd.Connection = conn

    '    cmd.Parameters.AddWithValue("@badge", tbEmpBadgeNo.Text)
    '    cmd.Parameters.AddWithValue("@today", TodaysDate)
    '    cmd.Parameters.AddWithValue("@result", "PASS")

    '    cmd.CommandText = "Insert into TempChecks (BadgeNo, DateChecked, Result) VALUES (@badge, @today, @result)"

    '    conn.Open()

    '    Try
    '        cmd.ExecuteNonQuery()
    '        Dim text6 As String = "SAVED SUCCESSFULLY - Badge # " & tbEmpBadgeNo.Text & " Pass."
    '        ScriptManager.RegisterStartupScript(Me, GetType(Page), "Success", "<script>showpopSuccess('" & text6 & "')</script>", False)

    '    Catch

    '    End Try
    '    conn.Close()

    '    tbEmpBadgeNo.Text = ""
    '    lblBadge.Text = ""
    '    lblFirst.Text = ""
    '    lblLast.Text = ""
    '    tbEmpBadgeNo.Focus()

    'End Sub

    'Private Sub btnFail_Click(sender As Object, e As EventArgs) Handles btnFail.Click


    '    Dim conn As New SqlConnection()
    '    Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

    '    Dim cmd As New SqlCommand
    '    Dim TodaysDate As Date = Date.Now
    '    conn.ConnectionString = connstr

    '    cmd.Connection = conn

    '    cmd.Parameters.AddWithValue("@badge", tbEmpBadgeNo.Text)
    '    cmd.Parameters.AddWithValue("@today", TodaysDate)
    '    cmd.Parameters.AddWithValue("@result", "FAIL")

    '    cmd.CommandText = "Insert into TempChecks (BadgeNo, DateChecked, Result) VALUES (@badge, @today, @result)"

    '    conn.Open()

    '    Try
    '        cmd.ExecuteNonQuery()

    '        Dim text6 As String = "SAVED SUCCESSFULLY - Badge # " & tbEmpBadgeNo.Text & " Fail."
    '        ScriptManager.RegisterStartupScript(Me, GetType(Page), "Error", "<script>showpopError('" & text6 & "')</script>", False)

    '    Catch
    '    End Try

    '    conn.Close()


    '    tbEmpBadgeNo.Text = ""
    '    lblBadge.Text = ""
    '    lblFirst.Text = ""
    '    lblLast.Text = ""
    '    tbEmpBadgeNo.Focus()

    'End Sub

    'Private Sub btn94_Click(sender As Object, e As EventArgs) Handles btn94.Click, btn95.Click, btn96.Click, btn97.Click, btn98.Click, btn99.Click, btn100.Click
    '    Dim btn As Button = CType(sender, Button)
    '    Dim btnName As String = btn.ID
    '    Dim firstPart As String = Mid(btnName, 4)
    '    Dim secondPart As String = hdnSecond.Value
    '    hdnFirst.Value = firstPart
    '    tbTemp.Text = firstPart & "." & secondPart
    'End Sub

    'Private Sub btn0_Click(sender As Object, e As EventArgs) Handles btn0.Click, btn1.Click, btn2.Click, btn3.Click, btn4.Click, btn5.Click, btn6.Click, btn7.Click, btn8.Click, btn9.Click
    '    Dim btn As Button = CType(sender, Button)
    '    Dim btnName As String = btn.ID
    '    Dim firstPart As String = hdnFirst.Value
    '    Dim secondPart As String = Mid(btnName, 4)
    '    hdnSecond.Value = secondPart
    '    tbTemp.Text = firstPart & "." & secondPart
    'End Sub

End Class
