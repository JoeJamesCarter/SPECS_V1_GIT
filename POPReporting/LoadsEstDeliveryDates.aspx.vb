Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class LoadsEstDeliveryDates
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

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
        cmd.CommandText = "Select Count(ProdNo) as Count FROM LOAD_SCHEDULING where (Loaded = 0 or Loaded is Null) and Convert(date,ActualLoadDate) ='" & selecteddate & "'"
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
            End If

            If status = "Complete" Then
                e.Row.Cells(4).Text = ""
            Else
                e.Row.Cells(2).BackColor = Drawing.Color.Red
            End If
        End If


    End Sub

    Protected Sub gvDlrBoats_RowCommand(sender As Object, e As GridViewCommandEventArgs)
       

      
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvBoatsScheduled.DataBind()
    End Sub


    Protected Sub gvBoatsScheduled_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvBoatsScheduled.RowCommand
        If e.CommandName = "gotosavedeldate" Then
            Dim Key As Integer = Convert.ToInt32(e.CommandArgument) 'get the row that is clicked 
            Dim load As Integer = gvBoatsScheduled.Rows(Key).Cells(0).Text
            Dim tbEstDate As TextBox = TryCast(gvBoatsScheduled.Rows(Key).Cells(2).FindControl("tbDelDate"), TextBox)
            Dim estdate As String = tbEstDate.Text
            Dim plannedloaddate As Date = Calendar1.SelectedDate

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.CommandType = CommandType.Text

            cmd.CommandText = "Update LOAD_SCHEDULING set EstDeliveryDate = '" & estdate & "' where Convert(date,ActualLoadDate) ='" & plannedloaddate & "' and  LoadNo = '" & load & "'"

            conn.Open()

            cmd.ExecuteNonQuery()

            conn.Close()
            gvBoatsScheduled.DataBind()

        End If
    End Sub
End Class

