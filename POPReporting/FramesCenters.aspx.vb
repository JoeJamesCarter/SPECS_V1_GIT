Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient

Partial Class FramesCenters
    Inherits System.Web.UI.Page
   Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

   

    Protected Sub gvFrames_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvFrames.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvFrames.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Frames" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
            Dim url2 As String = "BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url2 + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)
            'This next line works, unless it is in an update panel. Then it doesn't. Response.Write doesn't work inside those. Use ScriptManager instead.
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url2 & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvFrames.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Frames" 'to pass in the workstation that makes the note.
            Dim url As String = "BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "OrderDetails.aspx?SONo=" & SONo
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)

        End If

        'This code is for the update button
        If e.CommandName = "UpdateFrameStatus" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvFrames.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim rbList As RadioButtonList = DirectCast(gvFrames.Rows(Key).Cells(13).FindControl("rblFrameStatus"), RadioButtonList)

            Dim tStatus As Integer = gvFrames.Rows(Key).DataItem("TubesStatus")
            Dim ctStatus As Integer = gvFrames.Rows(Key).DataItem("CentertubeStatus")
            Dim cNeeded As Integer = gvFrames.Rows(Key).DataItem("CentertubeNeeded")

            Dim NextWorkstationHasDate As Int16

            Dim conn As New SqlConnection()
            Dim conn2 As New MySqlConnection()

            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim connstr2 As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand
            Dim cmd6 As New MySqlCommand
            Dim cmd7 As New SqlCommand
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand

            Dim cmd10 As New SqlCommand
            Dim cmd11 As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim recordcountS As Int16 = 0
            Dim coverstatus As Int16 = 0
            Dim framesreadytostart As Int16
            Dim southshrinkcount As Int16 = 0
            Dim mainreadycount As Int16
            Dim southreadycount As Int16

            conn.ConnectionString = connstr
            conn2.ConnectionString = connstr2

            cmd.CommandType = CommandType.Text

            cmd.Parameters.AddWithValue("@Status", rbList.SelectedValue)
            cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
            cmd4.Parameters.AddWithValue("@Status4", rbList.SelectedValue)

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = @Status, FramesInstalled = @TodaysDate where FramesInstalledStatus < 2 and ProdNo =  '" & SelectedProdNo & "'"

            'if complete set Floors to startable
            cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FloorsInstalledStatus = '1', BuildOptionsStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 2 and BuildLoc ='M' and Convert(date,FramesInstalled) ='" & ThisDay & "'"
            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalled is not NULL and ProdNo = '" & SelectedProdNo & "'"
            'reverse done
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = @Status4, FloorsInstalledStatus = '0', BuildOptionsStatus = '0' where ProdNo =  '" & SelectedProdNo & "' and FloorsInstalled is NULL"
            cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
            'for the email to Tumacs
            'for External SPECS - Veada
            cmd6.CommandText = "Update Greenlights SET StartedInFrames = '1' where ProdNo =  '" & SelectedProdNo & "'"
            cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 2 and BuildLoc = 'S' and Convert(date,FramesInstalled) ='" & ThisDay & "'"
            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = S and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

            cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and BuildLoc = 'M'"
            cmd11.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and BuildLoc = 'S'"

            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd6.Connection = conn2
            cmd7.Connection = conn
            cmd8.Connection = conn
            cmd9.Connection = conn
            cmd10.Connection = conn
            cmd11.Connection = conn

            conn.Open()

            If tStatus = 2 And (cNeeded = 1 And ctStatus = 2 Or (cNeeded = 0)) Then
                cmd.ExecuteNonQuery()
            Else
                MesgBox("Please have the Center or Outer Tubes greened first, then mark this as framed. Thanks.")
            End If



            NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())

            If rbList.SelectedValue = 2 Then
                cmd1.ExecuteNonQuery()
                conn2.Open()
                cmd6.ExecuteNonQuery()
                conn2.Close()
            ElseIf rbList.SelectedValue < 2 And NextWorkstationHasDate = 1 Then
                MesgBox("You cannot undo floors ability to start because they have already completed their part of this boat. If you need help, please contact a supervisor")
            Else
                cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            recordcountS = Convert.ToInt16(cmd7.ExecuteScalar())

            lblBoatsStarted.Text = recordcount
            lblBoatsStartedS.Text = recordcountS

            framesreadytostart = Convert.ToInt16(cmd8.ExecuteScalar)
            lblReadyToStart.Text = framesreadytostart

            southshrinkcount = Convert.ToInt16(cmd5.ExecuteScalar())
            lblSouthShrink.Text = southshrinkcount

            mainreadycount = Convert.ToInt16(cmd10.ExecuteScalar)
            southreadycount = Convert.ToInt16(cmd11.ExecuteScalar)
            lblMainReadyToStart.Text = mainreadycount
            lblSouthReadyToStart.Text = southreadycount
            gvFrames.DataBind()

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

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim recordcountSouth As Int16 = 0
        Dim DaystoShow As String
        Dim framesreadytostart As Int16
        Dim southshrinkcount As Int16 = 0
        Dim mainreadycount As Int16
        Dim southreadycount As Int16

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
        End If


        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd3.CommandType = CommandType.Text

        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 2 and BuildLoc = 'M' and Convert(date,FramesInstalled) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 2 and BuildLoc = 'S' and Convert(date,FramesInstalled) ='" & ThisDay & "'"
        'to get the count of the prod #'s completed that day
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
        cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and BuildLoc = 'M'"
        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and BuildLoc = 'S'"

        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        recordcountSouth = Convert.ToInt16(cmd3.ExecuteScalar())
        lblBoatsStarted.Text = recordcount
        lblBoatsStartedS.Text = recordcountSouth

        framesreadytostart = Convert.ToInt16(cmd4.ExecuteScalar)
        lblReadyToStart.Text = framesreadytostart
        'MesgBox(recordcount)

        southshrinkcount = Convert.ToInt16(cmd5.ExecuteScalar())
        lblSouthShrink.Text = southshrinkcount

        mainreadycount = Convert.ToInt16(cmd6.ExecuteScalar)
        southreadycount = Convert.ToInt16(cmd7.ExecuteScalar)
        lblMainReadyToStart.Text = mainreadycount
        lblSouthReadyToStart.Text = southreadycount
        conn.Close()
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvFrames.DataBind()
    End Sub

    Protected Sub gvFrames_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvFrames.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFabOptions"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsRailsData"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try

            Try
                If (e.Row.DataItem("BuildLoc") = "S") Then
                    e.Row.BackColor = Drawing.Color.LightGray
                End If
            Catch ex As Exception

            End Try
        End If
    End Sub
End Class
