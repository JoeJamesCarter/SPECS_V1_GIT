
Partial Class Tubes_Baffles
    Inherits System.Web.UI.Page
    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        gvRoundSeamer.DataBind()
    End Sub
    Public Function CheckMidVisible(ByVal sections As Object) As String
        Try

            If sections = 3 Then
                Return "display:normal;"
            Else
                Return "display:none;"
            End If

        Catch
            Return "display:normal;"
        End Try
    End Function

    Public Function CheckMid2Visible(ByVal sections As Object) As String
        Try

            If sections = 4 Then
                Return "display:normal;"
            Else
                Return "display:none;"
            End If

        Catch
            Return "display:normal;"
        End Try
    End Function

    Public Function CheckCtrVisible(ByVal sections As Object) As String
        Try

            If sections = 0 Then
                Return "display:none;"
            Else
                Return "display:normal;"
            End If

        Catch
            Return "display:normal;"
        End Try
    End Function


End Class
