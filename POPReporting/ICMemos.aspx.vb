Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class ICMemos
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvMemos_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvMemos.RowCommand
        If e.CommandName = "gototSaveMemo" Then
            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked

            Dim ID As Integer = gvMemos.Rows(Key).Cells(0).Text

            Dim Resolution As String = DirectCast(gvMemos.Rows(Key).Cells(7).FindControl("tbResolution"), TextBox).Text
            Dim NotesForRcv As String = DirectCast(gvMemos.Rows(Key).Cells(8).FindControl("tbNotesForRcv"), TextBox).Text
            'Dim Priority As Integer = DirectCast(gvMemos.Rows(Key).Cells(9).FindControl("cbPriority"), CheckBox).Checked
            Dim Status As Integer = DirectCast(gvMemos.Rows(Key).Cells(10).FindControl("rblStatus"), RadioButtonList).SelectedValue


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            Dim TodaysDate As Date = Date.Now

            cmd.Parameters.AddWithValue("@MemoID", ID)
            cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
            cmd.Parameters.AddWithValue("@Resolution", Resolution)
            cmd.Parameters.AddWithValue("@NotesForRcv", NotesForRcv)
            cmd.Parameters.AddWithValue("@Status", Status)
            'cmd.Parameters.AddWithValue("@Priority", Priority)

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE InventoryControlMemos SET Resolution = @Resolution, NotesForRcv = @NotesForRcv, Status = @Status, LastUpdated = @TodaysDate where AutoID = @MemoID"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvMemos.DataBind()
        End If
        If e.CommandName = "gotoopenorders" Then
            Dim BenPart As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OpenOrders.aspx?BenPart=" & BenPart
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1100,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "reqcyclecount" Then
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.CommandType = CommandType.Text

            Dim PartNo As String = e.CommandArgument
            Dim CountOn As String = tbCCCountDate.Text
            tbPartNoToCount.Text = ""


            If cbListCounter.SelectedIndex > -1 And tbCCCountDate.Text.Length > 0 Then
                conn.Open()

                For i = 0 To cbListCounter.Items.Count - 1
                    If cbListCounter.Items(i).Selected = True Then
                        cmd.Parameters.AddWithValue("@PartNo", PartNo)
                        cmd.Parameters.AddWithValue("@CountOn", CountOn)
                        cmd.Parameters.AddWithValue("@CounterID", cbListCounter.Items(i).Value)

                        cmd.CommandText = "Insert into CycleCounts(PartNo, DateToCount, CounterID) Values (@PartNo, @CountOn, @CounterID)"
                        cmd.ExecuteNonQuery()
                        cmd.Parameters.Clear()

                    End If
                Next

                conn.Close()
                MesgBox("Item has been added to Cycle Count Parts List.")
            Else
                MesgBox("Please make sure to select your counter and set the date.")
            End If


        End If

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvMemos.DataBind()
    End Sub

    Protected Sub gvMemos_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvMemos.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim lblBenPart As Label = DirectCast(e.Row.Cells(2).FindControl("lblBenPartNo"), Label)

            Dim BenPart As String = Trim(lblBenPart.Text)
            Dim Vendor As String = ""

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.Parameters.AddWithValue("@benpart", BenPart)

            cmd.CommandText = "Select top 1 payee_name from POORDLIN_SQL Left Join [APVENFIL_SQL] on POORDLIN_SQL.vend_no = APVENFIL_SQL.vend_no WHERE [item_no] = @benpart and qty_ordered > 0 order by request_dt desc"

            conn.Open()
            Vendor = cmd.ExecuteScalar()
            conn.Close()
            e.Row.Cells(3).Text = Vendor

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsCCs"), SqlDataSource)
            Try
                s.SelectParameters(0).DefaultValue = BenPart
            Catch

            End Try
        End If
    End Sub

    Private Sub btnSaveCCReq_Click(sender As Object, e As EventArgs) Handles btnSaveCCReq.Click
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd.CommandType = CommandType.Text

        Dim PartNo As String = tbPartNoToCount.Text
        Dim CountOn As String = tbCCCountDate.Text

        If cbListCounter.SelectedIndex > -1 And tbCCCountDate.Text.Length > 0 Then
            conn.Open()

            For i = 0 To cbListCounter.Items.Count - 1
                If cbListCounter.Items(i).Selected = True Then
                    cmd.Parameters.AddWithValue("@PartNo", PartNo)
                    cmd.Parameters.AddWithValue("@CountOn", CountOn)
                    cmd.Parameters.AddWithValue("@CounterID", cbListCounter.Items(i).Value)

                    cmd.CommandText = "Insert into CycleCounts(PartNo, DateToCount, CounterID) Values (@PartNo, @CountOn, @CounterID)"
                    cmd.ExecuteNonQuery()
                    cmd.Parameters.Clear()

                End If
            Next

            conn.Close()
            tbPartNoToCount.Text = ""
            MesgBox("Item has been added to Cycle Count Parts List.")
        Else
            MesgBox("Please make sure to select your counter and set the date.")
        End If

    End Sub
End Class
