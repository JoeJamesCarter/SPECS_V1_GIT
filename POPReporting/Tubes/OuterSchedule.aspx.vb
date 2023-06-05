
Partial Class Tubes_OuterSchedule
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Tubes_OuterSchedule_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim selectedDate As String
		selectedDate = Request.QueryString("selectedDate")
		ddlOuterDates.SelectedValue = selectedDate + " 12:00:00 AM"
	End Sub

    Protected Sub gvOuters_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOuters.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            If Trim((e.Row.DataItem("Splash").ToString()) Like "*REG SPLASH*") Then
                e.Row.Cells(10).ForeColor = Drawing.Color.Red
                e.Row.Cells(10).Font.Bold = True
            End If

            If Trim((e.Row.DataItem("Comments").ToString()) Like "*140*") Then
                e.Row.Cells(11).Text = e.Row.DataItem("Strakes") & " - " & e.Row.DataItem("Comments")
                e.Row.Cells(11).ForeColor = Drawing.Color.Red
                e.Row.Cells(11).Font.Bold = True
            End If


            If Trim((e.Row.DataItem("Comments").ToString()) Like "52*") Then
                e.Row.Cells(14).ForeColor = Drawing.Color.Red
                e.Row.Cells(14).Font.Bold = True
            End If


            If Trim((e.Row.DataItem("Bracket").ToString()) Like "24 TD*") Then
                e.Row.Cells(7).ForeColor = Drawing.Color.Red
                e.Row.Cells(7).Font.Bold = True
            End If

            If Trim((e.Row.DataItem("Diameter").ToString()) Like "*32*") Then
                e.Row.Cells(3).ForeColor = Drawing.Color.Red
                e.Row.Cells(3).Font.Bold = True
            End If

            If Trim((e.Row.DataItem("Rope").ToString()) Like "*Top*") Then
                e.Row.Cells(5).ForeColor = Drawing.Color.Red
                e.Row.Cells(5).Font.Bold = True
            End If
        End If
    End Sub
   
    
    Protected Sub gvCSOuterTubes_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCSOuterTubes.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblTube As Label = CType(e.Row.FindControl("lblTube"), Label)

            If e.Row.DataItem("Port") = 1 Then
                lblTube.Text = "PORT"
            ElseIf e.Row.DataItem("Strb") = 1 Then
                lblTube.Text = "STRB"
            End If


        End If
    End Sub
End Class
