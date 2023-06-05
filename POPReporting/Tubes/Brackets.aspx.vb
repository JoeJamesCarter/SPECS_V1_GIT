Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Tubes_Brackets
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

        gvBrackets.DataBind()

    End Sub

    Protected Sub gvBrackets_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvBrackets.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvBrackets.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Brackets" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
            Dim url2 As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url2 + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)
            'This next line works, unless it is in an update panel. Then it doesn't. Response.Write doesn't work inside those. Use ScriptManager instead.
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url2 & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvBrackets.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Brackets" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)

        End If

        'This code is for the update button
        If e.CommandName = "gotoupdateP" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvBrackets.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvBrackets.Rows(Key).FindControl("btnUpdateBracketsP"), Image)
            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 26, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.

            Dim NextWorkstationHasDate As Int16

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BracketsStatusP = '2', RepairStatusP = '1', Brackets = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BracketsStatusP = 2 and BracketsStatusS = 2 and Convert(date,Brackets) ='" & ThisDay & "'"
            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RepairStatusP = 2 and ProdNo = '" & SelectedProdNo & "'"
            'reverse done
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BracketsStatusP = '1', Brackets = NULL, RepairStatusP = '0' where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If framevalue <= 1 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                End If
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())

            lblBoatsStarted.Text = recordcount

            gvBrackets.DataBind()
            conn.Close()

        End If
        'This code is for the update button
        If e.CommandName = "gotoupdateS" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvBrackets.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvBrackets.Rows(Key).FindControl("btnUpdateBracketsS"), Image)
            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 26, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.

            Dim NextWorkstationHasDate As Int16

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BracketsStatusS = '2', RepairStatusS = '1', Brackets = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BracketsStatusS = 2 and BracketsStatusP = 2 and Convert(date,Brackets) ='" & ThisDay & "'"
            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RepairStatusS = 2 and ProdNo = '" & SelectedProdNo & "'"
            'reverse done
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BracketsStatusS = '1', Brackets = NULL, RepairStatusS = '0' where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If framevalue <= 1 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                End If
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())

            lblBoatsStarted.Text = recordcount

            gvBrackets.DataBind()
            conn.Close()

        End If
        If e.CommandName = "gotoupdateCtr" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvBrackets.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvBrackets.Rows(Key).FindControl("btnUpdateBracketsCtr"), Image)
            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 26, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.

            Dim NextWorkstationHasDate As Int16

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BracketsStatusCtr = '2', RepairStatusCtr = '1', BracketsCtr = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BracketsStatusCtr = 2 and BracketsStatusP = 2 and BracketsStatusS = 2 and Convert(date,Brackets) ='" & ThisDay & "'"
            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RepairStatusCtr = 2 and ProdNo = '" & SelectedProdNo & "'"
            'reverse done
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BracketsStatusCtr = '1', BracketsCtr = NULL, RepairStatusCtr = '0' where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If framevalue <= 1 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                End If
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())

            lblBoatsStarted.Text = recordcount

            gvBrackets.DataBind()
            conn.Close()

        End If
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

        hdnStatus.Value = 2

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BracketsStatusS = 2 and BracketsStatusP = 2 and Convert(date,Brackets) ='" & ThisDay & "'"
        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount
        'MesgBox(recordcount)
        conn.Close()
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvBrackets.DataBind()
    End Sub

    Protected Sub gvBrackets_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBrackets.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFabOptions"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsOverrides"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsBrackets"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
            If (e.Row.DataItem("RerunP") > 1) Or (e.Row.DataItem("RerunSB") > 1) Or (e.Row.DataItem("RerunCtr") > 1) Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If
    End Sub
End Class