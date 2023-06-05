Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class LoadSchedule
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
            Dim shipper As String = e.Row.Cells(5).Text
            Dim status As String = e.Row.Cells(4).Text

            If shipper = "Big_Kid" Then
                e.Row.Cells(5).Text = "Big Kid"
            ElseIf shipper = "Maverick_Flatbed" Then
                e.Row.Cells(5).Text = "Maverick Flatbed"
            ElseIf shipper = "First_Choice" Then
                e.Row.Cells(5).Text = "First Choice"
            ElseIf shipper = "Indiana_Transport" Then
                e.Row.Cells(5).Text = "Indiana Transport"
            ElseIf shipper = "Peg_Leg" Then
                e.Row.Cells(5).Text = "Peg Leg"
            ElseIf shipper = "G_Diamond" Then
                e.Row.Cells(5).Text = "G. Diamond"
            ElseIf shipper = "Maverick_Stinger" Then
                e.Row.Cells(5).Text = "Maverick Stinger"
            End If



        If status = "Complete" Then
            e.Row.Cells(4).Text = ""
        Else
            e.Row.Cells(2).BackColor = Drawing.Color.Red
        End If

        Dim building As String = e.Row.Cells(7).Text

        If building = "S" Then
            e.Row.BackColor = Drawing.Color.LightGray
        End If

        Dim slotkey As String = e.Row.Cells(6).Text

        If slotkey Like "100*" Then
            Dim newKey As String = slotkey.Remove(0, 3)
            newKey = "1" + newKey
            e.Row.Cells(6).Text = newKey

        ElseIf slotkey Like "200*" Then
            Dim newKey As String = slotkey.Remove(0, 3)
            newKey = "2" + newKey
            e.Row.Cells(6).Text = newKey

        ElseIf slotkey Like "300*" Then
            Dim newKey As String = slotkey.Remove(0, 3)
            newKey = "3" + newKey
            e.Row.Cells(6).Text = newKey

        ElseIf slotkey Like "400*" Then
            Dim newKey As String = slotkey.Remove(0, 3)
            newKey = "4" + newKey
            e.Row.Cells(6).Text = newKey

        ElseIf slotkey Like "500*" Then
            Dim newKey As String = slotkey.Remove(0, 3)
            newKey = "5" + newKey
            e.Row.Cells(6).Text = newKey
        End If


        End If


    End Sub

    Protected Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        btnPrint.Visible = False
        btnRefresh.Visible = False
        Calendar1.Visible = False
        gvBoatsScheduled.Font.Size = "12"
    End Sub
End Class

