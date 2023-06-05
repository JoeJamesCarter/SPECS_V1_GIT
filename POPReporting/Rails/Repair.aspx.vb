Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Rails_Repair
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Dim lblProdNo As Label
        Dim BoatNotesProdNo As String
        Dim workstation As String

        BoatNotesProdNo = Request.QueryString("ProdNo")
        workstation = Request.QueryString("ws")
        lblProdNo.Text = BoatNotesProdNo
        hdnWorkstation.Value = workstation


    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        'Dim SF_Note As String = tbSFNotes.Text
        'Dim PR_Note As String = tbPRNotes.Text
        'Dim SR_Note As String = tbSRNotes.Text
        'Dim T_Note As String = tbTNotes.Text
        'Dim PM_Note As String = tbPMNotes.Text
        'Dim SM_Note As String = tbSMNotes.Text

        Dim BoatNotesProdNo As String = lblProdNo.Text
        Dim Type As String = "Repair"

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand

        Dim TodaysDate As Date = Date.Now

        Dim SetFlag As Boolean = False

        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@BoatNotesProdNo", BoatNotesProdNo)
        cmd.Parameters.AddWithValue("@Workstation", hdnWorkstation.Value)

        conn.ConnectionString = connstr
        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd2.CommandText = "Update Rails_Tracking Set RepairFlag ='1' where ProdNo =  '" & BoatNotesProdNo & "'"
        cmd.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        conn.Open()
        If cbPF.Checked = True Then
            Dim Note As String = tbPFNotes.Text
            cmd.Parameters.AddWithValue("@Note", Note)
            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate, Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'1', '0','0','0','0','0','0', @Note, @TodaysDate, '0', @TodaysDate, 'Repair', '0', '0')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If cbSF.Checked = True Then
            Dim Note As String = tbSFNotes.Text
            cmd.Parameters.AddWithValue("@Note1", Note)
            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate, Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0', '1','0','0','0','0','0', @Note1, @TodaysDate, '0',@TodaysDate, 'Repair', '0', '0')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If cbPR.Checked = True Then
            Dim Note As String = tbPRNotes.Text
            cmd.Parameters.AddWithValue("@Note2", Note)
            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status,StatusDate, Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0','0','1','0','0','0','0', @Note2, @TodaysDate, '0', @TodaysDate,'Repair', '0', '0')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If cbSR.Checked = True Then
            Dim Note As String = tbSRNotes.Text
            cmd.Parameters.AddWithValue("@Note3", Note)
            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status,StatusDate, Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0', '0','0','1','0','0','0', @Note3, @TodaysDate, '0', @TodaysDate,'Repair', '0', '0')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If cbT.Checked = True Then
            Dim Note As String = tbTNotes.Text
            cmd.Parameters.AddWithValue("@Note4", Note)
            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate,Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0','0','0','0','0','0','1', @Note4, @TodaysDate, '0', @TodaysDate,'Repair', '0', '0')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If cbPM.Checked = True Then
            Dim Note As String = tbPMNotes.Text
            cmd.Parameters.AddWithValue("@Note5", Note)
            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status, StatusDate,Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0','0','0','0','1','0','0', @Note5, @TodaysDate, '0', @TodaysDate,'Repair', '0', '0')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If cbSM.Checked = True Then
            Dim Note As String = tbSMNotes.Text
            cmd.Parameters.AddWithValue("@Note6", Note)
            cmd.CommandText = "Insert into Rails_RepairsReorders (ProdNo, PF, SF, PR, SR, PM, SM, T, Note, DateReq, Status,StatusDate, Type, ReReceived, Scrap) VALUES (@BoatNotesProdNo,'0','0','0','0','0','1','0', @Note6, @TodaysDate, '0', @TodaysDate,'Repair', '0', '0')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If SetFlag = True Then
            cmd2.ExecuteNonQuery()
        End If
        GridView1.DataBind()
        conn.Close()
       
    End Sub

    Protected Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")

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
            Dim Status As String = e.Row.Cells(10).Text
            Dim ReRcvd As String = e.Row.Cells(12).Text

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
                e.Row.Cells(10).Text = "Scrapped/Reordered"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            ElseIf Status = "2" Then
                e.Row.Cells(10).Text = "Sent"
                e.Row.Cells(10).BackColor = Drawing.Color.Green
            ElseIf Status = "3" Then
                e.Row.Cells(10).Text = "Cut"
                e.Row.Cells(10).BackColor = Drawing.Color.Yellow
            ElseIf Status = "-1" Then
                e.Row.Cells(10).Text = "Cancelled"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            ElseIf Status = "0" Then
                e.Row.Cells(10).Text = "Not Started"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            End If

            If ReRcvd = "2" Then
                e.Row.Cells(12).Text = "Yes"
                e.Row.Cells(12).BackColor = Drawing.Color.Green
            Else
                e.Row.Cells(12).Text = "No"
                e.Row.Cells(12).BackColor = Drawing.Color.Red
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
            Dim Status As String = e.Row.Cells(10).Text
            Dim ReRcvd As String = e.Row.Cells(12).Text

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
                e.Row.Cells(10).Text = "Sent"
                e.Row.Cells(10).BackColor = Drawing.Color.Green
            ElseIf Status = "3" Then
                e.Row.Cells(10).Text = "Cut"
                e.Row.Cells(10).BackColor = Drawing.Color.Yellow
            ElseIf Status = "-1" Then
                e.Row.Cells(10).Text = "Cancelled"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            ElseIf Status = "0" Then
                e.Row.Cells(10).Text = "Not Started"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            End If

            If ReRcvd = "2" Then
                e.Row.Cells(12).Text = "Yes"
                e.Row.Cells(12).BackColor = Drawing.Color.Green
            Else
                e.Row.Cells(12).Text = "No"
                e.Row.Cells(12).BackColor = Drawing.Color.Red
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
