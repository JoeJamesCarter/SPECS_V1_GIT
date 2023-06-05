Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Ladders
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gvAllFieldsG_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsG.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingRailOptions"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If


        End If

    End Sub


    Protected Sub gvAllFieldsF_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsG.RowCommand

        If e.CommandName = "goto" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsG.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Gauges" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "UpdateLadderStatus" Then


            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvAllFieldsG.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


            Dim rbList As RadioButtonList = DirectCast(gvAllFieldsG.Rows(Key).Cells(4).FindControl("rblLadderStatus"), RadioButtonList)
            'set the value of the radio button equal to what it is in the database on load.

            Dim conn As New SqlConnection()


            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand
            Dim cmd10 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim framesreadytostart As Int16
            Dim framesreadytostartio As Int16
            Dim framesstarted As Int16

            conn.ConnectionString = connstr


            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET LadderStatus = '" & rbList.SelectedValue & "' , Ladder = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where LadderStatus = 2 and Convert(date,Ladder) ='" & ThisDay & "'"
            'to get the count of the prod #'s completed that day as it changes

            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
            cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus >= 1 and ProdNo =  '" & SelectedProdNo & "'"



            cmd.Connection = conn
            cmd2.Connection = conn

            cmd8.Connection = conn
            cmd9.Connection = conn
            cmd10.Connection = conn


            conn.Open()
            'MesgBox(rbList.SelectedValue)
            'MesgBox(Key)
            'MesgBox(SelectedProdNo)
            cmd.ExecuteNonQuery()
            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount
            framesreadytostart = Convert.ToInt16(cmd8.ExecuteScalar)
            framesreadytostartio = Convert.ToInt16(cmd9.ExecuteScalar)
            framesstarted = Convert.ToInt16(cmd10.ExecuteScalar) '1 waiting or finished, 0 not started

            lblReadytoStart.Text = framesreadytostart
            lblios.Text = framesreadytostartio


            gvAllFieldsG.DataBind()

            conn.Close()

        End If

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
        End If


        If ddlShowSelect.SelectedValue = 1 Then
            gvAllFieldsG.Columns(8).Visible = False
        Else : gvAllFieldsG.Columns(8).Visible = True
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where LadderStatus = 2 and Convert(date,Ladder) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
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

        GetDailyTotals()
    End Sub

    Protected Sub ddlShowSelect_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlShowSelect.SelectedIndexChanged
        gvAllFieldsG.DataBind() 'used to allow the user to hide/show jobs that they have completed.
        If ddlShowSelect.SelectedValue = 1 Then
            gvAllFieldsG.Columns(8).Visible = False
        Else : gvAllFieldsG.Columns(8).Visible = True
        End If
    End Sub

    Protected Sub ddlDaysInAdvance_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDaysInAdvance.SelectedIndexChanged

        gvAllFieldsG.DataBind()
        If ddlShowSelect.SelectedValue = 1 Then
            gvAllFieldsG.Columns(8).Visible = False
        Else : gvAllFieldsG.Columns(8).Visible = True
        End If

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsG.DataBind()
        If ddlShowSelect.SelectedValue = 1 Then
            gvAllFieldsG.Columns(8).Visible = False
        Else : gvAllFieldsG.Columns(8).Visible = True
        End If
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Dim TopSilverReorderQty As String = tbTopSilverReorderQty.Text
        Dim BottomSilverReorderQty As String = tbBottomSilverReorderQty.Text
        Dim TopBlackReorderQty As String = tbTOPBlackReorderQty.Text
        Dim BottomBlackReorderQty As String = tbBottomBlackReorderQty.Text

        Dim LeftSilverRepairQty As String = tbLeftSilverRepairQty.Text
        Dim RightSilverRepairQty As String = tbRightSilverRepairQty.Text
        Dim LeftBlackRepairQty As String = tbLeftBlackRepairQty.Text
        Dim RightBlackRepairQty As String = tbRightBlackRepairQty.Text

        Dim LeftSilverReorderQty As String = tbLeftSilverReorderQty.Text
        Dim CenterSilverReorderQty As String = tbCenterSilverReorderQty.Text
        Dim RightSilverReorderQty As String = tbRightSilverReorderQty.Text

        Dim LeftBlackReorderQty As String = tbLeftBlackReorderQty.Text
        Dim CenterBlackReorderQty As String = tbCenterBlackReorderQty.Text
        Dim RightBlackReorderQty As String = tbRightBlackReorderQty.Text

        
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
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

        conn.ConnectionString = connstr

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd8.Connection = conn
        cmd9.Connection = conn
        cmd10.Connection = conn
        cmd11.Connection = conn
        cmd12.Connection = conn
        cmd13.Connection = conn

        cmd.Parameters.AddWithValue("@TopSilverReorderQty", TopSilverReorderQty)
        cmd1.Parameters.AddWithValue("@BottomSilverReorderQty", BottomSilverReorderQty)
        cmd2.Parameters.AddWithValue("@TopBlackReorderQty", TopBlackReorderQty)
        cmd3.Parameters.AddWithValue("@BottomBlackReorderQty", BottomBlackReorderQty)

        cmd4.Parameters.AddWithValue("@LeftSilverRepairQty", LeftSilverRepairQty)
        cmd5.Parameters.AddWithValue("@RightSilverRepairQty", RightSilverRepairQty)
        cmd6.Parameters.AddWithValue("@LeftBlackRepairQty", LeftBlackRepairQty)
        cmd7.Parameters.AddWithValue("@RightBlackRepairQty", RightBlackRepairQty)

        cmd8.Parameters.AddWithValue("@LeftSilverReorderQty", LeftSilverReorderQty)
        cmd9.Parameters.AddWithValue("@RightSilverReorderQty", RightSilverReorderQty)
        cmd10.Parameters.AddWithValue("@CenterSilverReorderQty", CenterSilverReorderQty)
        cmd11.Parameters.AddWithValue("@LeftBlackReorderQty", LeftBlackReorderQty)
        cmd12.Parameters.AddWithValue("@RightBlackReorderQty", RightBlackReorderQty)
        cmd13.Parameters.AddWithValue("@CenterBlackReorderQty", CenterBlackReorderQty)



        cmd.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Top', 'Reorder', 'Silver', '" & TodaysDate & "', @TopSilverReorderQty)"
        cmd1.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Bottom', 'Reorder', 'Silver', '" & TodaysDate & "', @BottomSilverReorderQty)"
        cmd2.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Top', 'Reorder', 'Black', '" & TodaysDate & "', @TopBlackReorderQty)"
        cmd3.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Bottom', 'Reorder', 'Black', '" & TodaysDate & "', @BottomBlackReorderQty)"

        cmd4.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Left', 'Repair', 'Silver', '" & TodaysDate & "', @LeftSilverRepairQty)"
        cmd5.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Right', 'Repair', 'Silver', '" & TodaysDate & "', @RightSilverRepairQty)"
        cmd6.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Left', 'Repair', 'Black', '" & TodaysDate & "', @LeftBlackRepairQty)"
        cmd7.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Right', 'Repair', 'Black', '" & TodaysDate & "', @RightBlackRepairQty)"

        cmd8.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Left', 'Reorder', 'Silver', '" & TodaysDate & "', @LeftSilverReorderQty)"
        cmd9.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Right', 'Reorder', 'Silver', '" & TodaysDate & "', @RightSilverReorderQty)"
        cmd10.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Center', 'Reorder', 'Silver', '" & TodaysDate & "', @CenterSilverReorderQty)"
        cmd11.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Left', 'Reorder', 'Black', '" & TodaysDate & "', @LeftBlackReorderQty)"
        cmd12.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Right', 'Reorder', 'Black', '" & TodaysDate & "', @RightBlackReorderQty)"
        cmd13.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Center', 'Reorder', 'Black', '" & TodaysDate & "', @CenterBlackReorderQty)"


        conn.Open()


        If TopSilverReorderQty.Length > 0 Then
            cmd.ExecuteNonQuery()
        End If

        If BottomSilverReorderQty.Length > 0 Then
            cmd1.ExecuteNonQuery()
        End If

        If TopBlackReorderQty.Length > 0 Then
            cmd2.ExecuteNonQuery()
        End If

        If BottomBlackReorderQty.Length > 0 Then
            cmd3.ExecuteNonQuery()
        End If

        If LeftSilverRepairQty.Length > 0 Then
            cmd4.ExecuteNonQuery()
        End If

        If RightSilverRepairQty.Length > 0 Then
            cmd5.ExecuteNonQuery()
        End If

        If LeftBlackRepairQty.Length > 0 Then
            cmd6.ExecuteNonQuery()
        End If

        If RightBlackRepairQty.Length > 0 Then
            cmd7.ExecuteNonQuery()
        End If

        If LeftSilverReorderQty.Length > 0 Then
            cmd8.ExecuteNonQuery()
        End If

        If RightSilverReorderQty.Length > 0 Then
            cmd9.ExecuteNonQuery()
        End If

        If CenterSilverReorderQty.Length > 0 Then
            cmd10.ExecuteNonQuery()
        End If

        If LeftBlackReorderQty.Length > 0 Then
            cmd11.ExecuteNonQuery()
        End If

        If RightBlackReorderQty.Length > 0 Then
            cmd12.ExecuteNonQuery()
        End If

        If CenterBlackReorderQty.Length > 0 Then
            cmd13.ExecuteNonQuery()
        End If

        conn.Close()


        'MesgBox("Saved")

        tbTopSilverReorderQty.Text = ""
        tbBottomSilverReorderQty.Text = ""
        tbTOPBlackReorderQty.Text = ""
        tbBottomBlackReorderQty.Text = ""

        tbLeftSilverRepairQty.Text = ""
        tbRightSilverRepairQty.Text = ""
        tbLeftBlackRepairQty.Text = ""
        tbRightBlackRepairQty.Text = ""

        tbLeftSilverReorderQty.Text = ""
        tbCenterSilverReorderQty.Text = ""
        tbRightSilverReorderQty.Text = ""

        tbLeftBlackReorderQty.Text = ""
        tbCenterBlackReorderQty.Text = ""
        tbRightBlackReorderQty.Text = ""

        GetDailyTotals()

    End Sub

    Protected Sub GetDailyTotals()

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
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

        conn.ConnectionString = connstr

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd8.Connection = conn
        cmd9.Connection = conn
        cmd10.Connection = conn
        cmd11.Connection = conn
        cmd12.Connection = conn
        cmd13.Connection = conn

        cmd.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Top' and Color = 'Silver' and Convert(date,DateAdded) ='" & ThisDay & "'"
        cmd1.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Top' and Color = 'Black' and Convert(date,DateAdded) ='" & ThisDay & "'"

        cmd2.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Bottom' and Color = 'Silver' and Convert(date,DateAdded) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Bottom' and Color = 'Black' and Convert(date,DateAdded) ='" & ThisDay & "'"

        cmd4.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Repair' and Part = 'Left' and Color = 'Silver' and Convert(date,DateAdded) ='" & ThisDay & "'"
        cmd5.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Repair' and Part = 'Left' and Color = 'Black' and Convert(date,DateAdded) ='" & ThisDay & "'"

        cmd6.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Repair' and Part = 'Right' and Color = 'Silver' and Convert(date,DateAdded) ='" & ThisDay & "'"
        cmd7.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Repair' and Part = 'Right' and Color = 'Black' and Convert(date,DateAdded) ='" & ThisDay & "'"

        cmd8.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Left' and Color = 'Silver' and Convert(date,DateAdded) ='" & ThisDay & "'"
        cmd9.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Left' and Color = 'Black' and Convert(date,DateAdded) ='" & ThisDay & "'"

        cmd10.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Center' and Color = 'Silver' and Convert(date,DateAdded) ='" & ThisDay & "'"
        cmd11.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Center' and Color = 'Black' and Convert(date,DateAdded) ='" & ThisDay & "'"

        cmd12.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Right' and Color = 'Silver' and Convert(date,DateAdded) ='" & ThisDay & "'"
        cmd13.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Right' and Color = 'Black' and Convert(date,DateAdded) ='" & ThisDay & "'"



        conn.Open()

        Dim DailySilverTopsReorder As String
        Dim DailyBlackTopsReorder As String
        Dim DailySilverBottomReorder As String
        Dim DailyBlackBottomReorder As String
        Dim DailySilverLeftRepair As String
        Dim DailyBlackLeftRepair As String
        Dim DailySilverRightRepair As String
        Dim DailyBlackRightRepair As String
        Dim DailySilverLeftReorder As String
        Dim DailyBlackLeftReorder As String
        Dim DailySilverCenterReorder As String
        Dim DailyBlackCenterReorder As String
        Dim DailySilverRightReorder As String
        Dim DailyBlackRightReorder As String


        DailySilverTopsReorder = cmd.ExecuteScalar().ToString
        DailyBlackTopsReorder = cmd1.ExecuteScalar().ToString
        DailySilverBottomReorder = cmd2.ExecuteScalar().ToString
        DailyBlackBottomReorder = cmd3.ExecuteScalar().ToString
        DailySilverLeftRepair = cmd4.ExecuteScalar().ToString
        DailyBlackLeftRepair = cmd5.ExecuteScalar().ToString
        DailySilverRightRepair = cmd6.ExecuteScalar().ToString
        DailyBlackRightRepair = cmd7.ExecuteScalar().ToString
        DailySilverLeftReorder = cmd8.ExecuteScalar().ToString
        DailyBlackLeftReorder = cmd9.ExecuteScalar().ToString
        DailySilverCenterReorder = cmd10.ExecuteScalar().ToString
        DailyBlackCenterReorder = cmd11.ExecuteScalar().ToString
        DailySilverRightReorder = cmd12.ExecuteScalar().ToString
        DailyBlackRightReorder = cmd13.ExecuteScalar().ToString

        If DailySilverTopsReorder Is Nothing Then
            lblDailySilverTopsReorder.Text = "0"
        Else
            lblDailySilverTopsReorder.Text = DailySilverTopsReorder.ToString
        End If

        If DailyBlackTopsReorder Is Nothing Then
            lblDailyBlackTopsReorder.Text = "0"
        Else
            lblDailyBlackTopsReorder.Text = DailyBlackTopsReorder.ToString
        End If

        If DailySilverBottomReorder Is Nothing Then
            lblDailySilverBottomReorder.Text = "0"
        Else
            lblDailySilverBottomReorder.Text = DailySilverBottomReorder.ToString
        End If

        If DailyBlackBottomReorder Is Nothing Then
            lblDailyBlackBottomReorder.Text = "0"
        Else
            lblDailyBlackBottomReorder.Text = DailyBlackBottomReorder.ToString
        End If

        If DailySilverLeftRepair Is Nothing Then
            lblDailySilverRepairLeft.Text = "0"
        Else
            lblDailySilverRepairLeft.Text = DailySilverLeftRepair.ToString
        End If

        If DailyBlackLeftRepair Is Nothing Then
            lblDailyBlackRepairLeft.Text = "0"
        Else
            lblDailyBlackRepairLeft.Text = DailyBlackLeftRepair.ToString
        End If

        If DailySilverRightRepair Is Nothing Then
            lblDailySilverRepairRight.Text = "0"
        Else
            lblDailySilverRepairRight.Text = DailySilverRightRepair.ToString
        End If

        If DailyBlackRightRepair Is Nothing Then
            lblDailyBlackRepairRight.Text = "0"
        Else
            lblDailyBlackRepairRight.Text = DailyBlackRightRepair.ToString
        End If

        If DailySilverLeftReorder Is Nothing Then
            lblDailySilverReorderLeft.Text = "0"
        Else
            lblDailySilverReorderLeft.Text = DailySilverLeftReorder.ToString
        End If

        If DailyBlackLeftReorder Is Nothing Then
            lblDailyBlackReorderLeft.Text = "0"
        Else
            lblDailyBlackReorderLeft.Text = DailyBlackLeftReorder.ToString
        End If

        If DailySilverCenterReorder Is Nothing Then
            lblDailySilverReorderCenter.Text = "0"
        Else
            lblDailySilverReorderCenter.Text = DailySilverCenterReorder.ToString
        End If

        If DailyBlackCenterReorder Is Nothing Then
            lblDailyBlackReorderCenter.Text = "0"
        Else
            lblDailyBlackReorderCenter.Text = DailyBlackCenterReorder.ToString
        End If

        If DailySilverRightReorder Is Nothing Then
            lblDailySilverReorderRight.Text = "0"
        Else
            lblDailySilverReorderRight.Text = DailySilverRightReorder.ToString
        End If

        If DailyBlackRightReorder Is Nothing Then
            lblDailyBlackReorderRight.Text = "0"
        Else
            lblDailyBlackReorderRight.Text = DailyBlackRightReorder.ToString
        End If

        conn.Close()

    End Sub
End Class
