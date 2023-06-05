Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_RedTag
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
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

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        'cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where IsRedTagged = 1" 'and Convert(date,ShrinkWrap) ='" & ThisDay & "'"
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING INNER JOIN BML_POPREPORTING_GREENLIGHTS ON BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where IsRedTagged = 1" 'and Convert(date,ShrinkWrap) ='" & ThisDay & "'"
        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn

        conn.Open()
        

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount

        conn.Close()
    End Sub


    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvRedTags.DataBind()
    End Sub
    Protected Sub gvRedTags_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRedTags.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsBOs"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsRedTagReasons"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsRGAs"), SqlDataSource)
            Dim v As SqlDataSource = CType(e.Row.FindControl("sdsBoatNotes"), SqlDataSource)


            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
				s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
				t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                v.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

			End Try

			If (e.Row.DataItem("BuildLoc") = "S") Then
				e.Row.BackColor = Drawing.Color.LightGray
			End If
			If (e.Row.DataItem("ScheduledToLoad") = "1") Then
				e.Row.Cells(6).BackColor = Drawing.Color.Orange
			End If

		End If
    End Sub


    Protected Sub gvRedTags_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvRedTags.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRedTags.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Shrinkwrap " 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        'If e.CommandName = "gotoclear" Then 'handles when the offline button is clicked
        '    Dim ID As String = e.CommandArgument 'get the row that is clicked
        '    Dim BoatNotesProdNo As Integer = gvRedTags.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
        '    MesgBox(BoatNotesProdNo)

        '    Dim conn As New SqlConnection()
        '    Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        '    conn.ConnectionString = connstr

        '    Dim cmd As New SqlCommand

        '    conn.ConnectionString = connstr
        '    cmd.CommandType = CommandType.Text
        '    cmd.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set IsRedTagged ='0' where ProdNo =  '" & BoatNotesProdNo & "'"
        '    cmd.Connection = conn
        '    conn.Open()
        '    cmd.ExecuteNonQuery()
        '    MesgBox("Red Tag Cleared")

        'End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "gotoredtag" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRedTags.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Shrinkwrap " 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../RedTags.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If
        'This code is for the update button

        If e.CommandName = "gotostatusupdate" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            'Dim Selected As Integer = gvRGAs.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command            
            Dim url As String = "../Workstations/RedTagRGAStatusUpdate.aspx?AutoID=" & ID
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=450,height=700,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If
        If e.CommandName = "gotoppbo" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRedTags.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command     
            Dim url As String = "../Workstations/PrePaidBackOrder.aspx?ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=560,height=750,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If
    End Sub



    Protected Sub gvRedTagReasons_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "gotoclear" Then 'handles when the offline button is clicked

            Dim TodaysDate As Date = Date.Now

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim Auto As Integer = Convert.ToInt16(Line(0))
            Dim SelectedProd As Integer = Line(1)

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set IsRedTagged ='0' where ProdNo =  '" & SelectedProd & "'"
            cmd1.CommandText = "Select Count(Auto) From BML_POPREPORTING_REDTAGS Where DateCleared IS NULL and ProdNo  =  '" & SelectedProd & "'"


            cmd2.Parameters.AddWithValue("@Prod", SelectedProd)
            cmd2.Parameters.AddWithValue("@Auto", Auto)
            cmd2.Parameters.AddWithValue("@TodaysDate", TodaysDate)

            cmd2.CommandText = "Update BML_POPREPORTING_REDTAGS Set DateCleared = @TodaysDate where Auto = @Auto and ProdNo = @Prod"

            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn

            conn.Open()

            cmd2.ExecuteNonQuery() 'clear item

            Dim openRedTags = cmd1.ExecuteScalar 'test for more open items

            If openRedTags = 0 Then
                cmd.ExecuteNonQuery() 'clear boat if none left
                MesgBox("All Red Tag Cleared For This Boat")
            End If

            MesgBox("Red Tag Cleared")

            gvRedTags.DataBind()

        End If
    End Sub

    Protected Sub gvRedTagReasons_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsRedTagComments"), SqlDataSource)

            'Try
            s.SelectParameters(0).DefaultValue = e.Row.Cells(1).Text
            'Catch
            'End Try
        End If

    End Sub
End Class
