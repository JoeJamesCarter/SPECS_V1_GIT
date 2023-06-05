Imports System.Data
Imports System.Data.SqlClient
Partial Class Gates_GateReorder
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub Gates_Reorder_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim BoatNotesProdNo As String
        Dim workstation As String
        Dim Model As String

        BoatNotesProdNo = Request.QueryString("ProdNo")
        workstation = Request.QueryString("ws")
        Model = Request.QueryString("Model")

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

        '  cmd.CommandText = "Select ItemNo From BML_POPREPORTING_GREENLIGHTS Where ProdNo = '" & BoatNotesProdNo & "'"
        cmd2.CommandText = "SELECT Rails_Tracking.Blackout From Rails_Tracking Where ProdNo = '" & BoatNotesProdNo & "'"

        conn.Open()

        cmd1.CommandText = "Select BowCtr,Port,Strb,AftPort,AftCtr,AftStrb From ELK1ITSSQL002.ProductInfo.dbo.Gates where Model = '" & Model & "' and Year = '" & modelyear & "'"

        Blackout = cmd2.ExecuteScalar

        Results = cmd1.ExecuteReader(CommandBehavior.SingleRow)

        If Results.Read() Then
            Dim BowCtr As String = Trim(Results.Item("BowCtr").ToString)
            Dim Port As String = Trim(Results.Item("Port").ToString)
            Dim Strb As String = Trim(Results.Item("Strb").ToString)
            Dim AftPort As String = Trim(Results.Item("AftPort").ToString)
            Dim AftCtr As String = Trim(Results.Item("AftCtr").ToString)
            Dim AftStrb As String = Trim(Results.Item("AftStrb").ToString)

            If BowCtr = "" Then
                BowCtr = "0"
            End If

            If Port = "" Then
                Port = "0"
            End If

            If Strb = "" Then
                Strb = "0"
            End If

            If AftPort = "" Then
                AftPort = "0"
            End If

            If AftCtr = "" Then
                AftCtr = "0"
            End If

            If AftStrb = "" Then
                AftStrb = "0"
            End If


            'MesgBox(BowCtr)
            'MesgBox(Port)
            'MesgBox(Strb)
            'MesgBox(AftPort)
            'MesgBox(AftCtr)
            'MesgBox(AftStrb)
            'MesgBox(Blackout)

            Dim s As SqlDataSource = CType(sender.FindControl("sdsPossibleExtraGates"), SqlDataSource)


            Try
                s.SelectParameters(0).DefaultValue = BowCtr
                s.SelectParameters(1).DefaultValue = Port
                s.SelectParameters(2).DefaultValue = Strb
                s.SelectParameters(3).DefaultValue = AftPort
                s.SelectParameters(4).DefaultValue = AftCtr
                s.SelectParameters(5).DefaultValue = AftStrb
                s.SelectParameters(6).DefaultValue = Trim(Blackout)

            Catch

            End Try

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
        Dim ProdNo As String = lblProdNo.Text
        Dim Type As String = "Reorder"

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand

        Dim TodaysDate As Date = Date.Now

        Dim SetFlag As Boolean = False
        Dim scrap As Integer = 0

        Dim gate As String = ddlGate.SelectedItem.ToString
        Dim Note As String = lblNote.Text
        Dim AddtDetail As String = tbDetail.Text

        If Note = "Not Received" Or Note = "Reassigned" Then
            scrap = 0
        Else
            scrap = 1
        End If

        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@ProdNo", ProdNo)
        cmd.Parameters.AddWithValue("@Workstation", hdnWorkstation.Value)
        cmd.Parameters.AddWithValue("@Detail", AddtDetail)
        cmd.Parameters.AddWithValue("@Scrap", scrap)
        cmd.Parameters.AddWithValue("@Note", Note)

        conn.ConnectionString = connstr
        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd2.CommandText = "Update Gates_ByProd Set ReorderFlag ='1' where ProdNo =  '" & ProdNo & "'"
        cmd.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        conn.Open()


        If ddlGate.SelectedIndex = -1 Then
            MesgBox("Please select a gate.")
        ElseIf Note.Length = 0 Then
            MesgBox("Please select reason for reorder.")

        ElseIf gate = "Bow Ctr" Then

            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, BowCtr,Note, DateReq, StatusDate, Type, Scrap, AddtDetail) VALUES (@ProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Reorder', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True


        ElseIf gate = "Port" Then

            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, Port,Note, DateReq, StatusDate, Type, Scrap, AddtDetail) VALUES (@ProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Reorder', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True


        ElseIf gate = "Strb" Then

            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, Strb,Note, DateReq, StatusDate, Type, Scrap, AddtDetail) VALUES (@ProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Reorder', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True


        ElseIf gate = "Aft Port" Then

            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, AftPort, Note, DateReq, StatusDate, Type, Scrap, AddtDetail) VALUES (@ProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Reorder', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True


        ElseIf gate = "Aft Ctr" Then

            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, AftCtr,Note, DateReq, StatusDate, Type, Scrap, AddtDetail) VALUES (@ProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Reorder', @Scrap, @Detail)"
            cmd.ExecuteNonQuery()
            SetFlag = True


        ElseIf gate = "Aft Strb" Then

            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, AftStrb,Note, DateReq, StatusDate, Type, Scrap, AddtDetail) VALUES (@ProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Reorder', @Scrap, @Detail)"
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
            Dim BowCtr As String = e.Row.Cells(2).Text
            Dim Port As String = e.Row.Cells(3).Text
            Dim Strb As String = e.Row.Cells(4).Text
            Dim AftPort As String = e.Row.Cells(5).Text
            Dim AftCtr As String = e.Row.Cells(6).Text
            Dim AftStrb As String = e.Row.Cells(7).Text
            Dim Status As String = e.Row.Cells(9).Text
            Dim ReRcvd As String = e.Row.Cells(11).Text

            If BowCtr = "1" Then
                e.Row.Cells(2).Text = "X"
                e.Row.Cells(2).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(2).Text = ""
            End If

            If Port = "1" Then
                e.Row.Cells(3).Text = "X"
                e.Row.Cells(3).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(3).Text = ""
            End If

            If Strb = "1" Then
                e.Row.Cells(4).Text = "X"
                e.Row.Cells(4).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(4).Text = ""
            End If

            If AftPort = "1" Then
                e.Row.Cells(5).Text = "X"
                e.Row.Cells(5).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(5).Text = ""
            End If

            If AftCtr = "1" Then
                e.Row.Cells(6).Text = "X"
                e.Row.Cells(6).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(6).Text = ""
            End If

            If AftStrb = "1" Then
                e.Row.Cells(7).Text = "X"
                e.Row.Cells(7).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(7).Text = ""
            End If



            If Status = "1" Then
                e.Row.Cells(9).Text = "Scrapped/Reordered"
                e.Row.Cells(9).BackColor = Drawing.Color.Red
            ElseIf Status = "2" Then
                e.Row.Cells(9).Text = "Sent"
                e.Row.Cells(9).BackColor = Drawing.Color.Green
            ElseIf Status = "3" Then
                e.Row.Cells(9).Text = "Cut"
                e.Row.Cells(9).BackColor = Drawing.Color.Yellow
            ElseIf Status = "-1" Then
                e.Row.Cells(9).Text = "Cancelled"
                e.Row.Cells(9).BackColor = Drawing.Color.Red
            ElseIf Status = "0" Then
                e.Row.Cells(9).Text = "Not Started"
                e.Row.Cells(9).BackColor = Drawing.Color.Red
            End If

            If ReRcvd = "2" Then
                e.Row.Cells(11).Text = "Yes"
                e.Row.Cells(11).BackColor = Drawing.Color.Green
            Else
                e.Row.Cells(11).Text = "No"
                e.Row.Cells(11).BackColor = Drawing.Color.Red
            End If
        End If

    End Sub

    Protected Sub GridView2_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim BowCtr As String = e.Row.Cells(2).Text
            Dim Port As String = e.Row.Cells(3).Text
            Dim Strb As String = e.Row.Cells(4).Text
            Dim AftPort As String = e.Row.Cells(5).Text
            Dim AftCtr As String = e.Row.Cells(6).Text
            Dim AftStrb As String = e.Row.Cells(7).Text

            Dim Status As String = e.Row.Cells(10).Text
            Dim ReRcvd As String = e.Row.Cells(12).Text

            If BowCtr = "1" Then
                e.Row.Cells(2).Text = "X"
                e.Row.Cells(2).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(2).Text = ""
            End If

            If Port = "1" Then
                e.Row.Cells(3).Text = "X"
                e.Row.Cells(3).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(3).Text = ""
            End If

            If Strb = "1" Then
                e.Row.Cells(4).Text = "X"
                e.Row.Cells(4).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(4).Text = ""
            End If

            If AftPort = "1" Then
                e.Row.Cells(5).Text = "X"
                e.Row.Cells(5).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(5).Text = ""
            End If

            If AftCtr = "1" Then
                e.Row.Cells(6).Text = "X"
                e.Row.Cells(6).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(6).Text = ""
            End If

            If AftStrb = "1" Then
                e.Row.Cells(7).Text = "X"
                e.Row.Cells(7).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(7).Text = ""
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
