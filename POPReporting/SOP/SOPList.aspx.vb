
Partial Class SOP_SOPList
    Inherits System.Web.UI.Page

    Protected Sub gvSOPs_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvSOPs.RowCommand
        If e.CommandName = "gotoeditsop" Then 'handles when the ? button is clicked

            Dim SOP_ID As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./SOPEdit.aspx?SOPNo=" & SOP_ID
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

    End Sub
End Class
