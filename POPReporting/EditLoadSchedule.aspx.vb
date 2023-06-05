Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls


Partial Class EditLoadSchedule
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim conn2 As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim connstr2 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        Dim ThisDay As Date = Calendar1.SelectedDate
        Dim loadcounttoday As Int16
        'Dim totalboatsinyard As Integer

        cmd.Connection = conn
        cmd1.Connection = conn2

        conn.ConnectionString = connstr
        conn2.ConnectionString = connstr2
        Try
            conn.Open()
            cmd.CommandText = "Select Max(LoadNo) FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & ThisDay & "'"
            loadcounttoday = cmd.ExecuteScalar
            conn.Close()
            lblLoadsScheduled.Text = loadcounttoday
        Catch ex As Exception
            lblLoadsScheduled.Text = 0
        End Try


        'cmd1.CommandText = "Select Count (mfg_ser_lot_no) From IMLSMST_SQL Where mfg_ser_lot_no like '1%'"
        'conn2.Open()
        'totalboatsinyard = cmd1.ExecuteScalar
        'lblTotalInYard.Text = totalboatsinyard
        'conn2.Close()



    End Sub

  

    Protected Sub Calendar1_SelectionChanged(sender As Object, e As EventArgs) Handles Calendar1.SelectionChanged

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        Dim selecteddate As Date = Calendar1.SelectedDate

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd.CommandType = CommandType.Text

        cmd.CommandText = "Select top 1 LoadNo FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & selecteddate & "' order By LoadNo desc"
        conn.Open()
        Try
            Dim numscheduled As Int16 = cmd.ExecuteScalar
            lblLoadsScheduled.Text = numscheduled
        Catch ex As Exception
            lblLoadsScheduled.Text = 0
        End Try

        conn.Close()

    End Sub

    Protected Sub gvBoatsScheduled_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBoatsScheduled.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsDlrBoats"), SqlDataSource)

            Try
                Dim load As String = (e.Row.Cells(1).Text)

                s.SelectParameters(0).DefaultValue = load


            Catch ex As Exception

            End Try

        End If
    End Sub


    Protected Sub btnSaveEdits_Click(sender As Object, e As EventArgs) Handles btnSaveEdits.Click
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn

        cmd.CommandType = CommandType.Text
        cmd1.CommandType = CommandType.Text

        Dim selecteddate As Date = Calendar1.SelectedDate

        'Don't let it run if the date is not selected.
        If Calendar1.SelectedDate = DateTime.MinValue Then
            MesgBox("Please select a date.")
        Else

            conn.Open()


            For Each row In gvBoatsScheduled.Rows
                Dim selected As CheckBox = TryCast(row.Cells(0).FindControl("cbSelectDlr"), CheckBox)
                Dim gvDealerBoats As GridView = TryCast(row.Cells(2).FindControl("gvDlrBoats"), GridView)



                If selected.Checked = True Then
                    For Each innerRow In gvDealerBoats.Rows
                        Dim cbSelectBoat As CheckBox = TryCast(innerRow.Cells(0).FindControl("cbSelectBoat"), CheckBox)
                        If cbSelectBoat.Checked = True Then
                            Dim prod = innerRow.Cells(4).Text
                            Dim splitstop As String = DirectCast(innerRow.Cells(1).FindControl("tbStopNo"), TextBox).Text
                            Dim shipper As String = DirectCast(innerRow.Cells(6).FindControl("ddlShippers"), DropDownList).SelectedValue
                            Dim issplit As Integer = 0

                            Dim issplitcb As CheckBox = DirectCast(innerRow.Cells(2).FindControl("cbSplitLoad"), CheckBox)
                            If issplitcb.Checked = True Then
                                issplit = 1
                            End If

                            cmd.CommandText = "Update LOAD_SCHEDULING Set StopNo = '" & splitstop & "', Shipper = '" & shipper & "', Split = '" & issplit & "' Where ProdNo = '" & prod & "'"
                            'MesgBox(prod)
                            'MesgBox(load)
                            'MesgBox(selecteddate)
                            'MesgBox(splitstop)
                            'MesgBox(shipper)
                            'MesgBox(issplit)
                            Try
                                cmd.ExecuteNonQuery()
                            Catch ex As Exception
                                MesgBox("failed")
                            End Try

                        End If

                    Next

                End If
            Next
            cmd1.CommandText = "Select Max(LoadNo) FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & selecteddate & "'"
            Try
                Dim numscheduled As Int16 = cmd1.ExecuteScalar
                lblLoadsScheduled.Text = numscheduled
            Catch ex As Exception
                lblLoadsScheduled.Text = 0
            End Try

            conn.Close()
            gvBoatsScheduled.DataBind()
        End If

    End Sub



    Protected Sub gvDlrBoats_RowCommand(sender As Object, e As GridViewCommandEventArgs)


    End Sub

   
    Protected Sub gvBoatsScheduled_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvBoatsScheduled.RowCommand
        If e.CommandName = "unscheduleaboat" Then
            'This code is for the update button

            Dim SelectedProdNo As Integer = Convert.ToInt32(e.CommandArgument) 'get the row that is clicked          
            Dim selecteddate As Date = Calendar1.SelectedDate

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Delete From Load_Scheduling where ProdNo = '" & SelectedProdNo & "'"
            cmd1.CommandText = "Select top 1 LoadNo FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & selecteddate & "' order By LoadNo desc"

            cmd.Connection = conn
            cmd1.Connection = conn

            ' MesgBox(SelectedProdNo)
            conn.Open()
            cmd.ExecuteNonQuery()

            Try
                Dim numscheduled As Int16 = cmd1.ExecuteScalar
                lblLoadsScheduled.Text = numscheduled
            Catch ex As Exception
                lblLoadsScheduled.Text = 0
            End Try

            conn.Close()
            gvBoatsScheduled.DataBind()

        End If
    End Sub
End Class