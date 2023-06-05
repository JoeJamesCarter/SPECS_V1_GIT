
Partial Class Tubes_CenterSchedule
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Tubes_CenterSchedule_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim selectedDate As String
        selectedDate = Request.QueryString("selectedDate")
        ddlCenterDates.SelectedValue = selectedDate + " 12:00:00 AM"
    End Sub

    Protected Sub gvCenters_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCenters.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            If Trim((e.Row.DataItem("Rope").ToString()) Like "*Top*") Then
                e.Row.Cells(3).ForeColor = Drawing.Color.Red
                e.Row.Cells(3).Font.Bold = True
            End If

        End If
    End Sub

End Class
