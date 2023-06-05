Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class LoadCompletions
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Dim conn As New SqlConnection()
        'Dim conn2 As New SqlConnection()

        'Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        'Dim connstr2 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        'Dim cmd As New SqlCommand
        'Dim cmd1 As New SqlCommand

        'Dim ThisDay As Date = Calendar1.SelectedDate
        'Dim loadcounttoday As Int16
        'Dim totalboatsinyard As Integer

        'cmd.Connection = conn
        'cmd1.Connection = conn2

        'conn.ConnectionString = connstr
        'conn2.ConnectionString = connstr2
        'Try
        'conn.Open()
        'cmd.CommandText = "Select Max(LoadNo) FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & ThisDay & "'"
        'cmd.CommandText = "Select Count(Distinct LoadNo) as Count FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & ThisDay & "'"
        'cmd.CommandText = "Select Count (ProdNo) FROM LOAD_SCHEDULING where ((Loaded = 0 or Loaded is Null) and ActualLoadDate ='" & ThisDay & "')"
        'loadcounttoday = cmd.ExecuteScalar
        'conn.Close()
        'lblLoadsScheduled.Text = loadcounttoday
        'Catch ex As Exception
        'lblLoadsScheduled.Text = 0
        'End Try


        'cmd1.CommandText = "Select Count (mfg_ser_lot_no) From IMLSMST_SQL Where mfg_ser_lot_no like '1%'"
        'conn2.Open()
        'totalboatsinyard = cmd1.ExecuteScalar
        'lblTotalInYard.Text = totalboatsinyard
        'conn2.Close()

        'If Not IsPostBack Then
        'Calendar1.SelectedDate = Today()

        '        End If


    End Sub



    Protected Sub Calendar1_SelectionChanged(sender As Object, e As EventArgs) Handles Calendar1.SelectionChanged

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd3 As New SqlCommand

        Dim selecteddate As Date = Calendar1.SelectedDate

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd3.Connection = conn

        cmd.CommandType = CommandType.Text

        cmd1.CommandText = "Select Count(ProdNo) as Count FROM LOAD_SCHEDULING where OnTrailer = 1 and Convert(date,DateOnTrailer) ='" & selecteddate & "'"
        cmd3.CommandText = "Select Count(Distinct(LoadNo)) as Count FROM LOAD_SCHEDULING where LoadComplete = 1 and Convert(date,DateLoadComplete) ='" & selecteddate & "'"

        conn.Open()
        Try
            Dim numscheduled As Int16 = cmd1.ExecuteScalar
            lblBoatsPutOnTrailers.Text = numscheduled
            lblTrailersLoaded.Text = cmd3.ExecuteScalar
        Catch ex As Exception
            lblBoatsPutOnTrailers.Text = 0
            lblTrailersLoaded.Text = 0
        End Try

        lblDateSet.Text = selecteddate
        conn.Close()

    End Sub

    Protected Sub gvBoatsScheduled_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBoatsScheduled.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsDlrBoats"), SqlDataSource)
            Try
                Dim load As String = (e.Row.Cells(0).Text)
                s.SelectParameters(0).DefaultValue = load
            Catch ex As Exception

            End Try
        End If
    End Sub


    Protected Sub gvBoatsScheduled_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvBoatsScheduled.RowCommand
        If e.CommandName = "markcomplete" Then
            'Set every boat on that load as loadcomplete = 1 and DateLoadComplete = today
            'Create a report of the parent/child gridview as a pdf and save it to the server.

            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Load As Integer = gvBoatsScheduled.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim selecteddate As Date = Calendar1.SelectedDate

            Dim url As String = "./LoadCompletionRptForAcct.aspx?Load=" & Load & "&SelectedDate=" & selecteddate
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1000,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If
    End Sub

    Protected Sub gvBoatsScheduledPrev_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBoatsScheduledPrev.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsDlrBoatsPrev"), SqlDataSource)

            Try
                Dim plannedloaddate As String = e.Row.Cells(0).Text
                Dim load As String = (e.Row.Cells(1).Text)
                s.SelectParameters(0).DefaultValue = plannedloaddate
                s.SelectParameters(1).DefaultValue = load


            Catch ex As Exception

            End Try

        End If
    End Sub


    Protected Sub gvDlrBoats_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim shipper As String = e.Row.Cells(6).Text
            Dim trailer As String = e.Row.Cells(12).Text

            Dim parentCurrentRow As GridViewRow = TryCast(TryCast(sender, GridView).NamingContainer, GridViewRow)
            Dim TrailerTextBox As TextBox = DirectCast(parentCurrentRow.FindControl("tbTrailerNo"), TextBox)

            'Dim redtagged As Integer
            'Dim tubeissues As Integer

            'Dim redtagimage As ImageButton = DirectCast(e.Row.FindControl("btnRedTag"), ImageButton)
            'Dim hold As Image = DirectCast(e.Row.FindControl("imgHold"), Image)
            'Dim hot As Image = DirectCast(e.Row.FindControl("imgHot"), Image)

            If trailer.Length > 0 And trailer <> "&nbsp;" Then
                TrailerTextBox.Text = trailer
            End If


            Dim status As String = e.Row.Cells(5).Text

            Dim prod As String = e.Row.Cells(2).Text

            If shipper = "Big_Kid" Then
                e.Row.Cells(6).Text = "Big Kid"
            ElseIf shipper = "Maverick_Flatbed" Then
                e.Row.Cells(6).Text = "Maverick Flatbed"
            ElseIf shipper = "First_Choice" Then
                e.Row.Cells(6).Text = "First Choice"
            ElseIf shipper = "Indiana_Transport" Then
                e.Row.Cells(6).Text = "Indiana Transport"
            ElseIf shipper = "Peg_Leg" Then
                e.Row.Cells(6).Text = "Peg Leg"
            ElseIf shipper = "G_Diamond" Then
                e.Row.Cells(6).Text = "G Diamond"
            ElseIf shipper = "Jeff_Haul" Then
                e.Row.Cells(6).Text = "Jeff Haul"
            End If

            If status = "Complete" Then
                'e.Row.Cells(5).Text = ""
            Else
                e.Row.Cells(5).BackColor = Drawing.Color.Red
            End If

            Dim slotkey As String = e.Row.Cells(7).Text

            If slotkey Like "100*" Then
                Dim newKey As String = slotkey.Remove(0, 3)
                newKey = "1" + newKey
                e.Row.Cells(7).Text = newKey

            ElseIf slotkey Like "200*" Then
                Dim newKey As String = slotkey.Remove(0, 3)
                newKey = "2" + newKey
                e.Row.Cells(7).Text = newKey

            ElseIf slotkey Like "300*" Then
                Dim newKey As String = slotkey.Remove(0, 3)
                newKey = "3" + newKey
                e.Row.Cells(7).Text = newKey

            ElseIf slotkey Like "400*" Then
                Dim newKey As String = slotkey.Remove(0, 3)
                newKey = "4" + newKey
                e.Row.Cells(7).Text = newKey

            ElseIf slotkey Like "500*" Then
                Dim newKey As String = slotkey.Remove(0, 3)
                newKey = "5" + newKey
                e.Row.Cells(7).Text = newKey

            ElseIf slotkey Like "600*" Then
                Dim newKey As String = slotkey.Remove(0, 3)
                newKey = "6" + newKey
                e.Row.Cells(7).Text = newKey
            ElseIf slotkey Like "700*" Then
                Dim newKey As String = slotkey.Remove(0, 3)
                newKey = "7" + newKey
                e.Row.Cells(7).Text = newKey
            ElseIf slotkey Like "800*" Then
                Dim newKey As String = slotkey.Remove(0, 3)
                newKey = "8" + newKey
                e.Row.Cells(7).Text = newKey
            End If

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsEngineData"), SqlDataSource)

            Try
                Dim so As String = (e.Row.Cells(3).Text)

                s.SelectParameters(0).DefaultValue = so


            Catch ex As Exception

            End Try


        End If


    End Sub

    Protected Sub gvDlrBoatsPrev_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim shipper As String = e.Row.Cells(6).Text
            Dim status As String = e.Row.Cells(5).Text

            If shipper = "Big_Kid" Then
                e.Row.Cells(6).Text = "Big Kid"
            ElseIf shipper = "Maverick_Flatbed" Then
                e.Row.Cells(6).Text = "Maverick Flatbed"
            ElseIf shipper = "First_Choice" Then
                e.Row.Cells(6).Text = "First Choice"
            ElseIf shipper = "Indiana_Transport" Then
                e.Row.Cells(6).Text = "Indiana Transport"
            ElseIf shipper = "Peg_Leg" Then
                e.Row.Cells(6).Text = "Peg Leg"
            ElseIf shipper = "G_Diamond" Then
                e.Row.Cells(6).Text = "G Diamond"
            ElseIf shipper = "Jeff_Haul" Then
                e.Row.Cells(6).Text = "Jeff Haul"
            End If

            If status = "Complete" Then
                ' e.Row.Cells(5).Text = ""
            Else
                e.Row.Cells(5).BackColor = Drawing.Color.Red
            End If
        End If

        Dim s As SqlDataSource = CType(e.Row.FindControl("sdsEngineDataPrev"), SqlDataSource)

        Try
            Dim so As String = (e.Row.Cells(3).Text)

            s.SelectParameters(0).DefaultValue = so


        Catch ex As Exception

        End Try

    End Sub


    Protected Sub gvDlrBoats_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "loadaboat" Then
            'This code is for the load button

            Dim TodaysDate As Date = Date.Now

            Dim SelectedProdNo As Integer = Convert.ToInt32(e.CommandArgument) 'get the row that is clicked          
            Dim selecteddate As Date = Calendar1.SelectedDate

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update Load_Scheduling Set Loaded = '1', DateLoaded = '" & TodaysDate & "' where ProdNo = '" & SelectedProdNo & "'"
            cmd1.CommandText = "Select Count (ProdNo) as Count FROM LOAD_SCHEDULING where (OnTrailer = 1 and Convert(date,DateOnTrailer) ='" & selecteddate & "'"
            cmd2.CommandText = "UPDATE Yard_Master_Locations SET Filled = 0, ProdNo = NULL, DateIn = NULL where ProdNo =  '" & SelectedProdNo & "'"
            cmd3.CommandText = "Select Count Distinct(LoadNo) as Count FROM LOAD_SCHEDULING where (LoadComplete = 1 and Convert(date,DateLoadComplete) ='" & selecteddate & "'"

            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            ' MesgBox(SelectedProdNo)
            conn.Open()
            cmd.ExecuteNonQuery()
            cmd2.ExecuteNonQuery()

            Try
                Dim numscheduled As Int16 = cmd1.ExecuteScalar
                lblBoatsPutOnTrailers.Text = numscheduled
            Catch ex As Exception
                lblBoatsPutOnTrailers.Text = 0
            End Try

            conn.Close()

        End If

        If e.CommandName = "ontrailer" Then
            'This code is for the load button

            Dim TodaysDate As Date = Date.Now

            'Dim SelectedProdNo As Integer = Convert.ToInt32(e.CommandArgument) 'get the row that is clicked          
            Dim selecteddate As Date = Calendar1.SelectedDate

            Dim index As Integer = Integer.Parse(e.CommandArgument.ToString())
            Dim childCurrentrow As GridViewRow = TryCast(sender, GridView).Rows(index)
            Dim parentCurrentRow As GridViewRow = TryCast(TryCast(sender, GridView).NamingContainer, GridViewRow)
            Dim SelectedProdNo As String = childCurrentrow.Cells(2).Text
            Dim Trailer As String = DirectCast(parentCurrentRow.FindControl("tbTrailerNo"), TextBox).Text
            Dim Notes As String = DirectCast(parentCurrentRow.FindControl("tbAcctNotes"), TextBox).Text
            Dim AcctNotes As String = DirectCast(parentCurrentRow.FindControl("tbNotes"), TextBox).Text
            Dim EngineOnLoad As Integer = 0
            Dim EngineOnLoadCb As CheckBox = (childCurrentrow.FindControl("cbEngineOnLoad"))

            If EngineOnLoadCb.Checked = True Then
                EngineOnLoad = 1
            End If


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text

            If Trailer.Length > 0 Then
                cmd.CommandText = "Update Load_Scheduling Set OnTrailer = '1', TrailerNo = '" & Trailer & "',  DateOnTrailer = '" & TodaysDate & "', Notes = '" & Notes & "', AcctNotes = '" & AcctNotes & "', EngineOnLoad = '" & EngineOnLoad & "' where ProdNo = '" & SelectedProdNo & "'"
            Else
                cmd.CommandText = "Update Load_Scheduling Set OnTrailer = '1', DateOnTrailer = '" & TodaysDate & "', Notes = '" & Notes & "', AcctNotes = '" & AcctNotes & "', EngineOnLoad = '" & EngineOnLoad & "' where ProdNo = '" & SelectedProdNo & "'"
            End If

            cmd1.CommandText = "Select Count (ProdNo) as Count FROM LOAD_SCHEDULING where OnTrailer = 1 and Convert(date,DateOnTrailer) ='" & selecteddate & "'"
            cmd2.CommandText = "UPDATE Yard_Master_Locations SET Filled = 0, ProdNo = NULL, DateIn = NULL where ProdNo =  '" & SelectedProdNo & "'"
            cmd3.CommandText = "Select Count Distinct(LoadNo) as Count FROM LOAD_SCHEDULING where (LoadComplete = 1 and Convert(date,DateLoadComplete) ='" & selecteddate & "'"

            cmd.Connection = conn
            cmd1.Connection = conn

            ' MesgBox(SelectedProdNo)
            conn.Open()

            If Trailer.Length > 0 Then
                cmd.ExecuteNonQuery()
            Else
                MesgBox("Please Enter A Trailer # and Try Again. Thanks!")
            End If



            Try
                Dim numscheduled As Int16 = cmd1.ExecuteScalar
                lblBoatsPutOnTrailers.Text = numscheduled
            Catch ex As Exception
                lblBoatsPutOnTrailers.Text = 0
            End Try

            If e.CommandName = "markcomplete" Then
                'Note that for this the data you send to the report page has to be what is in cell(0) and not the calendar date.

            End If
            conn.Close()
        End If


        gvBoatsScheduled.DataBind()


    End Sub

    Protected Sub gvDlrBoatsPrev_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "loadaprevboat" Then
            'This code is for the load button

            Dim TodaysDate As Date = Date.Now

            Dim SelectedProdNo As Integer = Convert.ToInt32(e.CommandArgument) 'get the row that is clicked          
            Dim selecteddate As Date = Calendar1.SelectedDate

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update Load_Scheduling Set Loaded = '1', DateLoaded = '" & TodaysDate & "' where ProdNo = '" & SelectedProdNo & "'"
            cmd1.CommandText = "Select Count (ProdNo) as Count FROM LOAD_SCHEDULING where (Loaded = 0 or Loaded Is Null) and Convert(date,ActualLoadDate) ='" & selecteddate & "'"

            cmd2.CommandText = "UPDATE Yard_Master_Locations SET Filled = 0, ProdNo = NULL, DateIn = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn

            conn.Open()
            'cmd.ExecuteNonQuery()

            Try
                'cmd2.ExecuteNonQuery()
            Catch ex As Exception

            End Try

            conn.Close()
            gvBoatsScheduledPrev.DataBind()

        End If
    End Sub

    Protected Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        btnPrint.Visible = False
        btnRefresh.Visible = False
        Calendar1.Visible = False
        gvBoatsScheduled.Font.Size = "12"
    End Sub



End Class

