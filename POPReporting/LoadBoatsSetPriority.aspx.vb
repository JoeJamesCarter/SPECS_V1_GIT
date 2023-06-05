Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class LoadBoatsSetPriority
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

    Protected Sub gvBoatsScheduled_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvBoatsScheduled.RowCommand
        If e.CommandName = "setpriority" Then

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.CommandType = CommandType.Text

            conn.Open()

            Dim selecteddate As Date = Calendar1.SelectedDate
            Dim selectedrow As String = e.CommandArgument.ToString
            'Dim load As String = gvBoatsScheduled.Rows(selectedrow).Cells(1).Text
            Dim loadpriority As String = TryCast(gvBoatsScheduled.Rows(selectedrow).FindControl("ddlLoadPriority"), DropDownList).SelectedValue

            Dim gvDealerBoats As GridView = TryCast(gvBoatsScheduled.Rows(selectedrow).FindControl("gvDlrBoats"), GridView)
            Dim i As Integer = 0

            For Each GridViewRows In gvDealerBoats.Rows
                Dim prod As String = gvDealerBoats.Rows(i).Cells(2).Text
                Dim boatpriority As Integer = TryCast(gvDealerBoats.Rows(i).FindControl("ddlBoatPriority"), DropDownList).SelectedValue
                cmd.CommandText = "Update Load_Scheduling Set loadpriority = '" & loadpriority & "', boatpriority = '" & boatpriority & "'  where ProdNo = '" & prod & "'"
                cmd.ExecuteNonQuery()
                i = i + 1
            Next
            conn.Close()
            gvBoatsScheduled.DataBind()
        End If
    End Sub

    Protected Sub gvBoatsScheduled_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBoatsScheduled.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsDlrBoats"), SqlDataSource)
            'Dim ddl As DropDownList = CType(e.Row.FindControl("ddlLoadPriority"), DropDownList)
            'Dim i As Integer = 0
            'Dim loadcount As Integer = Convert.ToInt32(lblLoadsScheduled.Text)

            Try
                Dim load As String = (e.Row.Cells(1).Text)
                s.SelectParameters(0).DefaultValue = load
            Catch ex As Exception
            End Try

            'For i = 1 To loadcount
            'ddl.Items.Add(i)
            'Next i

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

            Dim ddlboatpriority As DropDownList = CType(e.Row.FindControl("ddlBoatPriority"), DropDownList)

        End If


    End Sub

    


 
End Class

