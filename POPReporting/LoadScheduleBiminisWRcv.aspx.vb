Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class LoadScheduleBiminisWRcv
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
            'cmd.CommandText = "Select Max(LoadNo) FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & ThisDay & "'"
            cmd.CommandText = "Select Count(Distinct LoadNo) as Count FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & ThisDay & "'"
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

        'cmd.CommandText = "Select top 1 LoadNo FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & selecteddate & "' order By LoadNo desc"
        cmd.CommandText = "Select Count(Distinct LoadNo) as Count FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & selecteddate & "'"
        conn.Open()
        Try
            Dim numscheduled As Int16 = cmd.ExecuteScalar
            lblLoadsScheduled.Text = numscheduled
        Catch ex As Exception
            lblLoadsScheduled.Text = 0
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

    Protected Sub gvDlrBoats_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim building As String = e.Row.Cells(3).Text

            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsBiminis"), SqlDataSource)
            Dim v As SqlDataSource = CType(e.Row.FindControl("sdsStdTop"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.

                t.SelectParameters(0).DefaultValue = e.Row.Cells(1).Text
                v.SelectParameters(0).DefaultValue = e.Row.DataItem("ItemNo")
            Catch

            End Try

            If building = "S" Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If

    End Sub

    Protected Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        btnPrint.Visible = False
        btnRefresh.Visible = False
        Calendar1.Visible = False
        gvBoatsScheduled.Font.Size = "12"
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvBoatsScheduled.DataBind()
    End Sub

    Protected Sub gvDlrBoats_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "receive" Then
            'This code is for the load button

            Dim TodaysDate As Date = Date.Now

            Dim SelectedProdNo As Integer = Convert.ToInt32(e.CommandArgument) 'get the row that is clicked          
            Dim selecteddate As Date = Calendar1.SelectedDate
            Dim currentbimstatus As String

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text

            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BiminiRcvdStatus = 2, BiminiRcvd = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd3.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BiminiRcvdStatus = 0, BiminiRcvd = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd1.CommandText = "Select Count (ProdNo) as Count FROM LOAD_SCHEDULING where (Loaded = 0 or Loaded Is Null) and Convert(date,ActualLoadDate) ='" & selecteddate & "'"

            cmd2.CommandText = "Select BiminiRcvdStatus From BML_POPREPORTING_GREENLIGHTS Where ProdNo = '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn

            'MesgBox(SelectedProdNo)
            conn.Open()

            currentbimstatus = cmd2.ExecuteScalar()
            'MesgBox(currentbimstatus)

            Try
                Dim numscheduled As Int16 = cmd1.ExecuteScalar
                lblLoadsScheduled.Text = numscheduled
            Catch ex As Exception
                lblLoadsScheduled.Text = 0
            End Try

            If currentbimstatus = "0" Then
                cmd.ExecuteNonQuery()
            ElseIf currentbimstatus = "2" Then
                cmd3.ExecuteNonQuery()
            End If

            conn.Close()
            gvBoatsScheduled.DataBind()

        End If
    End Sub
End Class

