Imports System.Data
Imports System.Data.SqlClient

Partial Class Gates_GateRepair
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
        Dim ProdNo As String
        Dim workstation As String

        ProdNo = Request.QueryString("ProdNo")
        workstation = Request.QueryString("ws")
        lblProdNo.Text = ProdNo
        hdnWorkstation.Value = workstation


    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        Dim ProdNo As String = lblProdNo.Text
        Dim Type As String = "Repair"

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand

        Dim TodaysDate As Date = Date.Now

        Dim SetFlag As Boolean = False

        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@BoatNotesProdNo", ProdNo)
        cmd.Parameters.AddWithValue("@Workstation", hdnWorkstation.Value)

        conn.ConnectionString = connstr
        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd2.CommandText = "Update Gates_ByProd Set RepairFlag ='1' where ProdNo =  '" & ProdNo & "'"
        cmd.Connection = conn
        cmd2.Connection = conn

        conn.Open()
        If cbBowCtr.Checked = True Then
            Dim Note As String = tbBowCtrNotes.Text
            cmd.Parameters.AddWithValue("@Note", Note)
            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, BowCtr, Note, DateReq, StatusDate, Type) VALUES (@BoatNotesProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Repair')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If cbPort.Checked = True Then
            Dim Note As String = tbPortNotes.Text
            cmd.Parameters.AddWithValue("@Note1", Note)
            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, Port, Note, DateReq, StatusDate, Type) VALUES (@BoatNotesProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Repair')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If cbStrb.Checked = True Then
            Dim Note As String = tbStrbNotes.Text
            cmd.Parameters.AddWithValue("@Note2", Note)
            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, Strb, Note, DateReq, StatusDate, Type) VALUES (@BoatNotesProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Repair')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If cbAftPort.Checked = True Then
            Dim Note As String = tbAftPortNotes.Text
            cmd.Parameters.AddWithValue("@Note3", Note)
            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, AftPort, Note, DateReq, StatusDate, Type) VALUES (@BoatNotesProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Repair')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If cbAftCtr.Checked = True Then
            Dim Note As String = tbAftCtrNotes.Text
            cmd.Parameters.AddWithValue("@Note4", Note)
            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, AftCtr, Note, DateReq, StatusDate, Type) VALUES (@BoatNotesProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Repair')"
            cmd.ExecuteNonQuery()
            SetFlag = True
        End If

        If cbAftStrb.Checked = True Then
            Dim Note As String = tbAftStrbNotes.Text
            cmd.Parameters.AddWithValue("@Note5", Note)
            cmd.CommandText = "Insert into Gates_RepairsReorders (ProdNo, AftStrb, Note, DateReq, StatusDate, Type) VALUES (@BoatNotesProdNo,'1', @Note, @TodaysDate, @TodaysDate, 'Repair')"
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


            If Status = "2" Then
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

End Class
