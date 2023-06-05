Imports System.Data
Imports System.Data.SqlClient
Partial Class Rails_ReorderV2
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim BoatNotesProdNo As String
        Dim workstation As String

        BoatNotesProdNo = Request.QueryString("ProdNo")
        workstation = Request.QueryString("ws")
        lblProdNo.Text = BoatNotesProdNo
        hdnWorkstation.Value = workstation
        Dim firsttwo As String = Left(BoatNotesProdNo, 2)

        Dim modelyear As String = "20" & firsttwo
        Dim Results As SqlDataReader
        Dim Blackout As String

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand


        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn

        cmd.CommandText = "Select ItemNo From BML_POPREPORTING_GREENLIGHTS Where ProdNo = '" & BoatNotesProdNo & "'"
        cmd2.CommandText = "SELECT Rails_Tracking.Blackout From Rails_Tracking Where ProdNo = '" & BoatNotesProdNo & "'"

        conn.Open()
        Dim model As String = cmd.ExecuteScalar

        Dim Series As String

        If model Like "??R*" Or model Like "??Q*" Then
            Series = "RQ"
        Else
            Series = "SG"
        End If

        If Series = "SG" Then
            cmd1.CommandText = "Select PortFront,StrbFront,PortRear,StrbRear,PortMid,StrbMid,Transom From Rails.dbo.Models where Model = '" & model & "' and ModelYear = '" & modelyear & "'"
        ElseIf Series = "RQ" Then
            cmd1.CommandText = "Select PortFront,StrbFront,PortRear,StrbRear,PortMid,StrbMid,Transom From Rails.dbo.ModelsRQ where Model = '" & model & "'"
        End If

        Blackout = cmd2.ExecuteScalar

        Results = cmd1.ExecuteReader(CommandBehavior.SingleRow)

        If Results.Read() Then
            Dim PF As String = Results.Item("PortFront").ToString
            Dim SF As String = Results.Item("StrbFront").ToString
            Dim PR As String = Results.Item("PortRear").ToString
            Dim SR As String = Results.Item("StrbRear").ToString
            Dim PM As String = Results.Item("PortMid").ToString
            Dim SM As String = Results.Item("StrbMid").ToString
            Dim T As String = Results.Item("Transom").ToString

            If PM = "" Then
                PM = "0"
            End If
            If SM = "" Then
                SM = "0"
            End If
            If T = "" Then
                T = "0"
            End If

            Dim s As SqlDataSource = CType(FindControl("sdsPossibleExtraRails"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = SR
                s.SelectParameters(1).DefaultValue = PF
                s.SelectParameters(2).DefaultValue = SF
                s.SelectParameters(3).DefaultValue = PR
                s.SelectParameters(4).DefaultValue = PM
                s.SelectParameters(5).DefaultValue = SM
                s.SelectParameters(6).DefaultValue = T
                s.SelectParameters(7).DefaultValue = Blackout

            Catch

            End Try
            GvExtraRails.DataBind()

            'MesgBox(Results.Item("PortFront").ToString)
            'MesgBox(Results.Item("StrbFront").ToString)
        End If
        conn.Close()




        If Not IsPostBack Then
            rblDamaged.Visible = False
            lblDamaged.Visible = False
            cblBuiltIncorrectly.Visible = False
            lblBuiltInc.Visible = False
        ElseIf rblPrimaryReason.SelectedValue = "Damaged" Then
            rblDamaged.Visible = True
            lblDamaged.Visible = True
            cblBuiltIncorrectly.Visible = False
            lblBuiltInc.Visible = False
        ElseIf rblPrimaryReason.SelectedValue = "Built Incorrectly" Then
            cblBuiltIncorrectly.Visible = True
            lblBuiltInc.Visible = True
            rblDamaged.Visible = False
            lblDamaged.Visible = False
        End If

    End Sub

    Private Sub rblPrimaryReason_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rblPrimaryReason.SelectedIndexChanged

        For Each li As ListItem In rblPrimaryReason.Items
            If li.Value = "Damaged" Then
                If li.Selected Then
                    rblDamaged.Visible = True
                    lblDamaged.Visible = True
                    'lblNote.Text = "Damaged - "
                    cblBuiltIncorrectly.SelectedIndex = -1
                End If
            ElseIf li.Value = "Built Incorrectly" Then
                If li.Selected Then
                    cblBuiltIncorrectly.Visible = True
                    lblBuiltInc.Visible = True
                    'lblNote.Text = "Built Wrong - "
                    rblDamaged.SelectedIndex = -1
                End If
            ElseIf li.Value = "Not Received" Then
                If li.Selected Then
                    lblNote.Text = "Not Received"
                    rblDamaged.SelectedIndex = -1
                End If
            ElseIf li.Value = "Reassigned" Then
                If li.Selected Then
                    lblNote.Text = "Reassigned"
                    rblDamaged.SelectedIndex = -1
                End If

            End If
        Next
    End Sub

    Private Sub rblDamaged_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rblDamaged.SelectedIndexChanged

        For Each li As ListItem In rblDamaged.Items
            If li.Selected Then
                lblNote.Text = "Damaged " & li.Value
            End If
        Next
    End Sub

    Private Sub cblBuiltIncorrectly_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cblBuiltIncorrectly.SelectedIndexChanged
        'Dim lblText As String = "Built Wrong -"
        lblNote.Text = ""
        For Each li As ListItem In cblBuiltIncorrectly.Items
            If li.Selected Then
                lblNote.Text += li.Value + " - "
            End If
        Next

    End Sub
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        Dim BoatNotesProdNo As String = lblProdNo.Text
        Dim Type As String = "Reorder"

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand

        Dim TodaysDate As Date = Date.Now

        Dim SetFlag As Boolean = False
        Dim scrap As Integer = 0

        Dim rail As String = ddlRail.SelectedValue
        Dim Note As String = lblNote.Text
        Dim AddtDetail As String = tbDetail.Text

        If Note = "Not Received" Or Note = "Reassigned" Then
            scrap = 0
        Else
            scrap = 1
        End If

        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@BoatNotesProdNo", BoatNotesProdNo)
        cmd.Parameters.AddWithValue("@Workstation", hdnWorkstation.Value)
        cmd.Parameters.AddWithValue("@Detail", AddtDetail)
        cmd.Parameters.AddWithValue("@Scrap", scrap)
        cmd.Parameters.AddWithValue("@Note", Note)

        conn.ConnectionString = connstr
        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd2.CommandText = "Update Rails_Tracking Set ReorderFlag ='1' where ProdNo =  '" & BoatNotesProdNo & "'"
        cmd.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        conn.Open()


        If ddlRail.SelectedIndex = -1 Then
            MesgBox("Please select a rail.")
        ElseIf Note.Length = 0 Then
            MesgBox("Please select reason for reorder.")

        ElseIf rail = "PF" Then

            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate, Type, ReReceived,Scrap, AddtDetail) VALUES (@BoatNotesProdNo,'1', '0','0','0','0','0','0', @Note, @TodaysDate, '0', @TodaysDate, 'Reorder', '0', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True


        ElseIf rail = "SF" Then

            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate, Type, ReReceived,Scrap, AddtDetail) VALUES (@BoatNotesProdNo,'0', '1','0','0','0','0','0', @Note, @TodaysDate, '0',@TodaysDate, 'Reorder', '0', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True


        ElseIf rail = "PR" Then

            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status,StatusDate, Type, ReReceived,Scrap, AddtDetail) VALUES (@BoatNotesProdNo,'0','0','1','0','0','0','0', @Note, @TodaysDate, '0', @TodaysDate,'Reorder', '0', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True


        ElseIf rail = "SR" Then

            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status,StatusDate, Type, ReReceived,Scrap, AddtDetail) VALUES (@BoatNotesProdNo,'0', '0','0','1','0','0','0', @Note, @TodaysDate, '0', @TodaysDate,'Reorder', '0', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True


        ElseIf rail = "T" Then

            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate,Type, ReReceived,Scrap, AddtDetail) VALUES (@BoatNotesProdNo,'0','0','0','0','0','0','1', @Note, @TodaysDate, '0', @TodaysDate,'Reorder', '0', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True


        ElseIf rail = "PM" Then

            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate,Type, ReReceived,Scrap, AddtDetail) VALUES (@BoatNotesProdNo,'0','0','0','0','1','0','0', @Note, @TodaysDate, '0', @TodaysDate,'Reorder', '0', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True

        ElseIf rail = "SM" Then

            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status,StatusDate, Type, ReReceived,Scrap, AddtDetail) VALUES (@BoatNotesProdNo,'0','0','0','0','0','1','0', @Note, @TodaysDate, '0', @TodaysDate,'Reorder', '0', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If SetFlag = True Then
            cmd2.ExecuteNonQuery()
        End If
        GridView2.DataBind()
        conn.Close()

    End Sub
    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim PF As String = e.Row.Cells(2).Text
            Dim SF As String = e.Row.Cells(3).Text
            Dim PR As String = e.Row.Cells(4).Text
            Dim SR As String = e.Row.Cells(5).Text
            Dim T As String = e.Row.Cells(6).Text
            Dim PM As String = e.Row.Cells(7).Text
            Dim SM As String = e.Row.Cells(8).Text
            Dim Status As String = e.Row.Cells(11).Text
            Dim ReRcvd As String = e.Row.Cells(13).Text

            If PF = "1" Then
                e.Row.Cells(2).Text = "X"
                e.Row.Cells(2).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(2).Text = ""
            End If

            If SF = "1" Then
                e.Row.Cells(3).Text = "X"
                e.Row.Cells(3).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(3).Text = ""
            End If

            If PR = "1" Then
                e.Row.Cells(4).Text = "X"
                e.Row.Cells(4).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(4).Text = ""
            End If

            If SR = "1" Then
                e.Row.Cells(5).Text = "X"
                e.Row.Cells(5).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(5).Text = ""
            End If

            If T = "1" Then
                e.Row.Cells(6).Text = "X"
                e.Row.Cells(6).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(6).Text = ""
            End If

            If PM = "1" Then
                e.Row.Cells(7).Text = "X"
                e.Row.Cells(7).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(7).Text = ""
            End If

            If SM = "1" Then
                e.Row.Cells(8).Text = "X"
                e.Row.Cells(8).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(8).Text = ""
            End If

            If Status = "1" Then
                e.Row.Cells(11).Text = "Scrapped/Repordered"
                e.Row.Cells(11).BackColor = Drawing.Color.Red
            ElseIf Status = "2" Then
                e.Row.Cells(11).Text = "Sent"
                e.Row.Cells(11).BackColor = Drawing.Color.Green
            ElseIf Status = "3" Then
                e.Row.Cells(11).Text = "Cut"
                e.Row.Cells(11).BackColor = Drawing.Color.Yellow
            ElseIf Status = "-1" Then
                e.Row.Cells(11).Text = "Cancelled"
                e.Row.Cells(11).BackColor = Drawing.Color.Red
            ElseIf Status = "0" Then
                e.Row.Cells(11).Text = "Not Started"
                e.Row.Cells(11).BackColor = Drawing.Color.Red
            End If

            If ReRcvd = "2" Then
                e.Row.Cells(13).Text = "Yes"
                e.Row.Cells(13).BackColor = Drawing.Color.Green
            Else
                e.Row.Cells(13).Text = "No"
                e.Row.Cells(13).BackColor = Drawing.Color.Red
            End If

            'If e.Row.DataItem("NeedsTransom") = 0 Then
            'cbT.Visible = False
            'tbTNotes.Visible = False
            'lblT.Visible = False
            'End If

            'If e.Row.DataItem("NeedsPortMid") = 0 Then
            'cbPM.Visible = False
            'tbPMNotes.Visible = False
            'lblPM.Visible = False
            'End If

            'If e.Row.DataItem("NeedsStrbMid") = 0 Then
            'cbSM.Visible = False
            'tbSMNotes.Visible = False
            'lblSM.Visible = False
            'End If

        End If
    End Sub

    Protected Sub GridView2_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim PF As String = e.Row.Cells(2).Text
            Dim SF As String = e.Row.Cells(3).Text
            Dim PR As String = e.Row.Cells(4).Text
            Dim SR As String = e.Row.Cells(5).Text
            Dim T As String = e.Row.Cells(6).Text
            Dim PM As String = e.Row.Cells(7).Text
            Dim SM As String = e.Row.Cells(8).Text
            Dim Status As String = e.Row.Cells(11).Text
            Dim ReRcvd As String = e.Row.Cells(13).Text

            If PF = "1" Then
                e.Row.Cells(2).Text = "X"
                e.Row.Cells(2).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(2).Text = ""
            End If

            If SF = "1" Then
                e.Row.Cells(3).Text = "X"
                e.Row.Cells(3).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(3).Text = ""
            End If

            If PR = "1" Then
                e.Row.Cells(4).Text = "X"
                e.Row.Cells(4).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(4).Text = ""
            End If

            If SR = "1" Then
                e.Row.Cells(5).Text = "X"
                e.Row.Cells(5).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(5).Text = ""
            End If

            If T = "1" Then
                e.Row.Cells(6).Text = "X"
                e.Row.Cells(6).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(6).Text = ""
            End If

            If PM = "1" Then
                e.Row.Cells(7).Text = "X"
                e.Row.Cells(7).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(7).Text = ""
            End If

            If SM = "1" Then
                e.Row.Cells(8).Text = "X"
                e.Row.Cells(8).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(8).Text = ""
            End If

            If Status = "2" Then
                e.Row.Cells(11).Text = "Sent"
                e.Row.Cells(11).BackColor = Drawing.Color.Green
            ElseIf Status = "3" Then
                e.Row.Cells(11).Text = "Cut"
                e.Row.Cells(11).BackColor = Drawing.Color.Yellow
            ElseIf Status = "-1" Then
                e.Row.Cells(11).Text = "Cancelled"
                e.Row.Cells(11).BackColor = Drawing.Color.Red
            ElseIf Status = "0" Then
                e.Row.Cells(11).Text = "Not Started"
                e.Row.Cells(11).BackColor = Drawing.Color.Red
            End If

            If ReRcvd = "2" Then
                e.Row.Cells(13).Text = "Yes"
                e.Row.Cells(13).BackColor = Drawing.Color.Green
            Else
                e.Row.Cells(13).Text = "No"
                e.Row.Cells(13).BackColor = Drawing.Color.Red
            End If

            'If e.Row.DataItem("NeedsTransom") = 0 Then
            'cbT.Visible = False
            'tbTNotes.Visible = False
            'lblT.Visible = False
            'End If

            'If e.Row.DataItem("NeedsPortMid") = 0 Then
            'cbPM.Visible = False
            'tbPMNotes.Visible = False
            'lblPM.Visible = False
            'End If

            'If e.Row.DataItem("NeedsStrbMid") = 0 Then
            'cbSM.Visible = False
            'tbSMNotes.Visible = False
            'lblSM.Visible = False
            'End If

        End If
    End Sub

End Class
