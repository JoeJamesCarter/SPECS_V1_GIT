Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_Cleaning
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gvCleaning_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvCleaning.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvCleaning.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Inspection" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvCleaning.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Inspection" 'to pass in the workstation that makes the note.
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
            Dim SelectedProdNo As Integer = gvCleaning.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvCleaning.Rows(Key).FindControl("btnUpdateCleaning"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 26, 1) 'get the value of CleaningStatus from the imageurl.
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



            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim southshrinkcount As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET CleaningStatus = '2', FinalInspectionStatus = '1', Cleaning = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 2 and BuildLoc = 'M' and Convert(date,Cleaning) ='" & ThisDay & "'"
            'Check if the next workstation already has a finish date.
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FinalInspection is not NULL and ProdNo = '" & SelectedProdNo & "'"
            'reverse it only if the next workstation hasn't reported it complete.
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET CleaningStatus = '1', FinalInspectionStatus = '0', Cleaning = NULL where ProdNo =  '" & SelectedProdNo & "' and FinalInspection is NULL"
            cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"


            cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 1 and BuildLoc = 'M' and CompleteStatus < 2 and ProdNo > 2110000"
            cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 1 and BuildLoc = 'S' and CompleteStatus < 2 and ProdNo > 2110000"
            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 1 and BuildLoc = 'V' and CompleteStatus < 2 and ProdNo > 2110000"

            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 2 and BuildLoc = 'S' and Convert(date,Cleaning) ='" & ThisDay & "'"
            cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 2 and BuildLoc = 'V' and Convert(date,Cleaning) ='" & ThisDay & "'"

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


            lblSouthReadyToStart.Text = Convert.ToInt16(cmd7.ExecuteScalar)
            lblValueReadyToStart.Text = Convert.ToInt16(cmd8.ExecuteScalar)

            lblReadyToStart.Text = ""

            lblBoatsStartedS.Text = cmd9.ExecuteScalar
            lblVBoatsStarted.Text = cmd10.ExecuteScalar

            'southshrinkcount = Convert.ToInt16(cmd5.ExecuteScalar())
            'lblSouthShrink.Text = southshrinkcount


            gvCleaning.DataBind()

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

        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 2 and BuildLoc = 'M' and Convert(date,Cleaning) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 1 and BuildLoc = 'M' and CompleteStatus < 2 and ProdNo > 2110000"
        cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 1 and BuildLoc = 'S' and CompleteStatus < 2 and ProdNo > 2110000"
        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 1 and BuildLoc = 'V' and CompleteStatus < 2 and ProdNo > 2110000"

        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 2 and BuildLoc = 'S' and Convert(date,Cleaning) ='" & ThisDay & "'"
        cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 2 and BuildLoc = 'V' and Convert(date,Cleaning) ='" & ThisDay & "'"

        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd8.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount

        lblMainReadyToStart.Text = Convert.ToInt16(cmd4.ExecuteScalar)
        lblSouthReadyToStart.Text = Convert.ToInt16(cmd5.ExecuteScalar)
        lblValueReadyToStart.Text = Convert.ToInt16(cmd6.ExecuteScalar)

        lblReadyToStart.Text = ""

        lblBoatsStartedS.Text = cmd7.ExecuteScalar
        lblVBoatsStarted.Text = cmd8.ExecuteScalar
        'MesgBox(recordcount)
        'southshrinkcount = Convert.ToInt16(cmd3.ExecuteScalar())
        'lblSouthShrink.Text = southshrinkcount

        conn.Close()
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvCleaning.DataBind()
    End Sub

    Protected Sub gvCleaning_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCleaning.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If

    End Sub


End Class