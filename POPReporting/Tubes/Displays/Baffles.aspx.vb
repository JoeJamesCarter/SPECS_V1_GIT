Imports System.Data
Imports System.Data.SqlClient

Partial Class Tubes_Displays_Baffles
    Inherits System.Web.UI.Page
    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        dl1.DataBind()
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

    Protected Sub dl1_DataBinding(sender As Object, e As EventArgs) Handles dl1.DataBinding
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        cmd2.CommandText = "Select Count (*) FROM Tubes where (BafflesSectCFStatus = 2 and Convert(date,BafflesSectCF) ='" & ThisDay & "') or (BafflesSectCMStatus = 2 and Convert(date,BafflesSectCM) ='" & ThisDay & "') or (BafflesSectCM2Status = 2 and Convert(date,BafflesSectCM2) ='" & ThisDay & "') or (BafflesSectCRStatus = 2 and Convert(date,BafflesSectCR) ='" & ThisDay & "')"
        cmd3.CommandText = "Select Count (*) FROM Tubes where (BafflesSectPFStatus = 2 and Convert(date,BafflesSectPF) ='" & ThisDay & "') or (BafflesSectPMStatus = 2 and Convert(date,BafflesSectPM) ='" & ThisDay & "') or (BafflesSectPM2Status = 2 and Convert(date,BafflesSectPM2) ='" & ThisDay & "') or (BafflesSectPRStatus = 2 and Convert(date,BafflesSectPR) ='" & ThisDay & "')"
        cmd4.CommandText = "Select Count (*) FROM Tubes where (BafflesSectSFStatus = 2 and Convert(date,BafflesSectSF) ='" & ThisDay & "') or (BafflesSectSMStatus = 2 and Convert(date,BafflesSectSM) ='" & ThisDay & "') or (BafflesSectSM2Status = 2 and Convert(date,BafflesSectSM2) ='" & ThisDay & "') or (BafflesSectSRStatus = 2 and Convert(date,BafflesSectSR) ='" & ThisDay & "')"
        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        conn.ConnectionString = connstr
        conn.Open()

        lblCtr.Text = " C:" & Convert.ToInt16(cmd2.ExecuteScalar())
        lblPort.Text = " P: " & Convert.ToInt16(cmd3.ExecuteScalar())
        lblStrb.Text = " S: " & Convert.ToInt16(cmd4.ExecuteScalar())

        conn.Close()

    End Sub
End Class
