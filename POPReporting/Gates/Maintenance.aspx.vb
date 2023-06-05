
Partial Class Gates_Maintenance
    Inherits System.Web.UI.Page

    Private Sub gvGateMaintenance_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvGateMaintenance.RowCommand

        If e.CommandName = "gotodrawing" Then 'handles when the notes button is clicked
            'todo need to add virtual directory to eng drawings folder
            Dim drawing As String = e.CommandArgument

            If Convert.ToString(drawing).Length > 0 Then
                Dim url As String = "../EngDrawings/" & drawing & ".pdf"
                Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1024,height=1000,toolbars=0');popUpObj.focus()}</script>")
            Else
            End If
        End If


    End Sub
End Class
