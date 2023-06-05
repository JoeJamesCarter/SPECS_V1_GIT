
Partial Class Tubes_EmployeesByStation
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Tubes_EmployeesByStation_Load(sender As Object, e As EventArgs) Handles Me.Load
        'tbACRepair.Visible = False
        'tblRollerSeamer.Visible = False
        'tblRSBrackets.Visible = False
        'tblCT.Visible = False

        'TextBox56.Text = DateTime.Today.ToString("yyyy-MM-dd")

        'For Each control As Object In tblRollerSeamer.Controls
        '    MesgBox(control.ID)
        '    If TypeOf control Is TextBox Then
        '        MesgBox(control.ID)
        '        If (control.ID) Like "tbd*" Then
        '            MesgBox(control.ID)
        '            control.Text = DirectCast(control, TextBox).Text = DateTime.Today.ToString("yyyy-MM-dd")
        '        End If
        '    End If


        'Next
        Dim TodaysDate As Date = DateTime.Today.ToString("yyyy-MM-dd")
        Dim ctrl As Control
        For Each ctrl In tblRollerSeamer.Controls
            'MesgBox(ctrl.ID)
            If (ctrl.GetType() Is GetType(TextBox)) Then
                Dim txt As TextBox = CType(ctrl, TextBox)
                txt.Text = DirectCast(txt, TextBox).Text = TodaysDate
            End If
        Next


    End Sub

    Protected Sub ddlSupervisors_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSupervisors.SelectedIndexChanged
        If ddlSupervisors.SelectedValue = "RSB" Then
            tblRollerSeamer.Visible = True
        ElseIf ddlSupervisors.SelectedValue = "RSBKTS" Then
            tblRSBrackets.Visible = True
        ElseIf ddlSupervisors.SelectedValue = "ACR" Then
            tbACRepair.Visible = True
        ElseIf ddlSupervisors.SelectedValue = "CT" Then
            tblCT.Visible = True
        End If
    End Sub

    'after the save you need to trigger the supervisor selection again
   
End Class
