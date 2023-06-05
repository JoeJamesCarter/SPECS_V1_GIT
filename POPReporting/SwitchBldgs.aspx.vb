Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Workstations_SwitchBldgs
    Inherits System.Web.UI.Page

    Public SOLineCounts As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Public Function PopulateDataTables() As String
        Dim sqldataadapter As New SqlDataAdapter
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()
        sqldataadapter.SelectCommand = New SqlCommand("Select Count(item_no) as total, ord_no as SONo FROM [oeordlin_sql] Group By ord_no", conn)
        sqldataadapter.Fill(SOLineCounts)
        conn.Close()

        Return True

    End Function


    Protected Sub gvAllFieldsFG_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsFG.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFiberglassOptions"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            ElseIf (e.Row.DataItem("BuildLoc") = "V") Then
                e.Row.BackColor = Drawing.Color.LightBlue
            End If

            Dim lblSOLineCount As Label = CType(e.Row.FindControl("lblSOLineCount"), Label)
            Dim hdnSONo As String = CType(e.Row.FindControl("hdnSONo"), HiddenField).Value

            Try
                Dim SOCount() As DataRow = SOLineCounts.Select("SONo =  '" & hdnSONo & "'")
                lblSOLineCount.Text = SOCount(0)(0)
            Catch
            End Try



        End If

    End Sub


    Protected Sub gvAllFieldsFG_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsFG.RowCommand

        If e.CommandName = "goto" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsFG.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Switch" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "UpdateProdLine" Then
            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvAllFieldsFG.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


            Dim rbList As RadioButtonList = DirectCast(gvAllFieldsFG.Rows(Key).Cells(4).FindControl("rblProdLine"), RadioButtonList)

            Dim ProdLineID As Integer = rbList.SelectedValue
            Dim BuildLoc As String = ""

            If rbList.SelectedValue = 1 Then
                BuildLoc = "S"
            ElseIf rbList.SelectedValue = 2 Then
                BuildLoc = "V"
            ElseIf rbList.SelectedValue = 3 Then
                BuildLoc = "M"
            End If
            'set the value of the radio button equal to what it is in the database on load.

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

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim framesstatus As Int16 = 0
            Dim tubeneeded As Int16 = 0
            Dim tubecomplete As Int16 = 0
            Dim framesreadytostart As Int16
            Dim framesreadytostartio As Int16
            Dim buildingto As String = rbList.SelectedValue
            Dim outertubecount As Int16 = 0
            Dim greenlightcount As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.Parameters.AddWithValue("@ProdNo", SelectedProdNo)
            cmd.Parameters.AddWithValue("@BuildLoc", BuildLoc)
            cmd.Parameters.AddWithValue("@ProdLineID", ProdLineID)

            'just set building
            'cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET ProdLineID = '" & rbList.SelectedValue & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET ProdLineID = @ProdLineID, BuildLoc = @BuildLoc where ProdNo =  @ProdNo"

            'populate the lables to show boats ready to start and count that are not ios in the top toolbar
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 2 and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > '2200000'"
            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and Right(ItemNo,2) = 'IO' and ProdNo > '2200000'"

            cmd.Connection = conn
            cmd2.Connection = conn

            cmd8.Connection = conn
            cmd9.Connection = conn


            conn.Open()
            cmd.ExecuteNonQuery() 'just change buildings

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount

            framesreadytostart = Convert.ToInt16(cmd8.ExecuteScalar)
            framesreadytostartio = Convert.ToInt16(cmd9.ExecuteScalar)
            lblReadytoStart.Text = framesreadytostart
            lblios.Text = framesreadytostartio

            gvAllFieldsFG.DataBind()

            conn.Close()
        End If
        'If e.CommandName = "UpdateBuildLoc" Then
        '    'This code is for the update button
        '    Dim Key As String = e.CommandArgument 'get the row that is clicked
        '    Dim SelectedProdNo As Integer = gvAllFieldsFG.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


        '    Dim rbList As RadioButtonList = DirectCast(gvAllFieldsFG.Rows(Key).Cells(4).FindControl("rblBuildLoc"), RadioButtonList)
        '    'set the value of the radio button equal to what it is in the database on load.

        '    Dim conn As New SqlConnection()
        '    Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        '    Dim cmd As New SqlCommand
        '    Dim cmd2 As New SqlCommand
        '    Dim cmd3 As New SqlCommand
        '    Dim cmd4 As New SqlCommand
        '    Dim cmd5 As New SqlCommand
        '    Dim cmd6 As New SqlCommand
        '    Dim cmd7 As New SqlCommand
        '    Dim cmd8 As New SqlCommand
        '    Dim cmd9 As New SqlCommand
        '    Dim cmd10 As New SqlCommand
        '    Dim cmd11 As New SqlCommand

        '    Dim TodaysDate As Date = Date.Now
        '    Dim ThisDay As Date = TodaysDate.Date
        '    Dim recordcount As Int16 = 0
        '    Dim framesstatus As Int16 = 0
        '    Dim tubeneeded As Int16 = 0
        '    Dim tubecomplete As Int16 = 0
        '    Dim framesreadytostart As Int16
        '    Dim framesreadytostartio As Int16
        '    Dim buildingto As String = rbList.SelectedValue
        '    Dim outertubecount As Int16 = 0
        '    Dim greenlightcount As Int16 = 0

        '    conn.ConnectionString = connstr

        '    cmd.CommandType = CommandType.Text

        '    'just set building
        '    cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BuildLoc = '" & rbList.SelectedValue & "' where ProdNo =  '" & SelectedProdNo & "'"


        '    'is it framed
        '    'cmd3.CommandText = "Select FramesInstalledStatus FROM BML_POPREPORTING_GREENLIGHTS where ProdNo =  '" & SelectedProdNo & "'"

        '    'set frames and building
        '    ' cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '1', BuildLoc = '" & rbList.SelectedValue & "' where ProdNo =  '" & SelectedProdNo & "'"
        '    'cmd5.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '0' where ProdNo =  '" & SelectedProdNo & "'"
        '    'Check if Centertubeneeded is 1 and if CentertubeStatus = 2.  If true, Frames can start.
        '    'cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING where CentertubeNeeded = 1 and ProdNo =  '" & SelectedProdNo & "'"
        '    'cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"


        '    'populate the lables to show boats ready to start and count that are not ios in the top toolbar
        '    cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 2 and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
        '    cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > '2200000'"
        '    cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and Right(ItemNo,2) = 'IO' and ProdNo > '2200000'"
        '    'cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus =2 and ProdNo =  '" & SelectedProdNo & "'"
        '    'cmd11.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"

        '    cmd.Connection = conn
        '    cmd2.Connection = conn
        '    'cmd3.Connection = conn
        '    'cmd4.Connection = conn
        '    'cmd5.Connection = conn
        '    'cmd6.Connection = conn
        '    'cmd7.Connection = conn
        '    cmd8.Connection = conn
        '    cmd9.Connection = conn
        '    'cmd10.Connection = conn
        '    'cmd11.Connection = conn

        '    conn.Open()
        '    cmd.ExecuteNonQuery() 'just change buildings

        '    'framesstatus = Convert.ToInt16(cmd3.ExecuteScalar())
        '    'outertubecount = Convert.ToInt16(cmd11.ExecuteScalar)
        '    'greenlightcount = Convert.ToInt16(cmd10.ExecuteScalar())

        '    'If buildingto = "M" Then
        '    'If greenlightcount = 0 And framesstatus = 1 Then
        '    'cmd5.ExecuteNonQuery() ' reverse frames
        '    'cmd.ExecuteNonQuery() ' change buildings
        '    'Else
        '    'cmd.ExecuteNonQuery()
        '    'End If


        '    'ElseIf buildingto = "S" Then
        '    'If outertubecount = 1 Then 'outer tubes are green

        '    'tubeneeded = Convert.ToInt16(cmd6.ExecuteScalar()) 'is a centertube on the order
        '    'tubecomplete = Convert.ToInt16(cmd7.ExecuteScalar()) 'if so, is it complete?

        '    'If tubeneeded = 0 And (framesstatus = 0 Or framesstatus = 1) Then 'center not on the order and frames isn't already started or done
        '    'cmd4.ExecuteNonQuery() 'start frames to start and set the building.
        '    'ElseIf tubeneeded = 1 And tubecomplete = 0 Then
        '    'cmd.ExecuteNonQuery()

        '    'ElseIf tubeneeded = 1 And tubecomplete = 1 And (framesstatus = 0 Or framesstatus = 1) Then ' if on the order and complete and frames isn't already started or done, set frames to start.
        '    'cmd4.ExecuteNonQuery()

        '    'End If
        '    'Else
        '    'cmd.ExecuteNonQuery() 'just change buildings
        '    'End If

        '    'End If

        '    recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        '    lblBoatsStarted.Text = recordcount

        '    framesreadytostart = Convert.ToInt16(cmd8.ExecuteScalar)
        '    framesreadytostartio = Convert.ToInt16(cmd9.ExecuteScalar)
        '    lblReadytoStart.Text = framesreadytostart
        '    lblios.Text = framesreadytostartio

        '    gvAllFieldsFG.DataBind()

        '    conn.Close()
        'End If

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String
        Dim framesreadytostart As Int16
        Dim framesreadytostartio As Int16


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
            ddlDaysInAdvance.Items.Add(New ListItem("30 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(42).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("40 Days", DaystoShow))
        End If

        If ddlShowSelect.SelectedValue = 1 Then
            gvAllFieldsFG.Columns(7).Visible = False
        Else : gvAllFieldsFG.Columns(7).Visible = True
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 2 and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and ProdNo > '2200000'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and Right(ItemNo,2) = 'IO' and ProdNo > '2200000'"

        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount
        framesreadytostart = Convert.ToInt16(cmd3.ExecuteScalar)
        framesreadytostartio = Convert.ToInt16(cmd4.ExecuteScalar)

        lblReadytoStart.Text = framesreadytostart
        lblios.Text = framesreadytostartio


        'MesgBox(recordcount)
        conn.Close()

        PopulateDataTables()



    End Sub

    Protected Sub ddlShowSelect_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlShowSelect.SelectedIndexChanged
        gvAllFieldsFG.DataBind() 'used to allow the user to hide/show jobs that they have completed.
        If ddlShowSelect.SelectedValue = 1 Then
            gvAllFieldsFG.Columns(7).Visible = False
        Else : gvAllFieldsFG.Columns(7).Visible = True
        End If
    End Sub

    Protected Sub ddlDaysInAdvance_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDaysInAdvance.SelectedIndexChanged

        gvAllFieldsFG.DataBind()
        If ddlShowSelect.SelectedValue = 1 Then
            gvAllFieldsFG.Columns(7).Visible = False
        Else : gvAllFieldsFG.Columns(7).Visible = True
        End If

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsFG.DataBind()
        If ddlShowSelect.SelectedValue = 1 Then
            gvAllFieldsFG.Columns(7).Visible = False
        Else : gvAllFieldsFG.Columns(7).Visible = True
        End If
    End Sub

    Protected Function SplitBVatDash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("-"c)(0)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function


End Class
