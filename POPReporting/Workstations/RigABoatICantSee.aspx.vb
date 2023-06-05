Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_RigABoatICantSee
    Inherits System.Web.UI.Page


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub btnRigged_Click(sender As Object, e As EventArgs) Handles btnRigged.Click
        Dim SelectedProdNo As Integer = tbProdNo.Text 'find the prod # in that row to use in the update command

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim checkforriggingnot2 As Int16 = 0

        Dim HasWaveTamercount As Int16
        Dim HasSharkhidecount As Int16
        Dim HasRiggingCount As Int16

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd1a As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd5a As New SqlCommand
        Dim cmd6 As New SqlCommand
        Dim cmd7 As New SqlCommand
        Dim cmd7a As New SqlCommand

        conn.ConnectionString = connstr

        cmd.CommandType = CommandType.Text

        'Set shrinkwrap to done and set the date.
        cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RiggingStatus = '2', Rigging = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
        'Check if WaveTamer is needed.
        cmd1.CommandText = "Select Count (*) FROM BML_POPREPORTING where WaveTamerNeeded = '1'and ProdNo = '" & SelectedProdNo & "'"
        cmd1a.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET WavetamerStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"

        'Check if Sharkhide is needed.
        cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING where SharkhideNeeded = '1'and ProdNo = '" & SelectedProdNo & "'"
        cmd5a.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET SharkhideStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"

        cmd6.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET CompleteStatus = '2', Complete = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"

        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING where RiggingNeeded = '1'and ProdNo = '" & SelectedProdNo & "'"
        cmd7a.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RiggingStatus = '1' where ProdNo =  '" & SelectedProdNo & "'"

        'Make sure it is not already rigged
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus < 2 and ProdNo = '" & SelectedProdNo & "'"


        cmd.Connection = conn
        cmd1.Connection = conn
        cmd1a.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd5a.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd7a.Connection = conn

        conn.Open()



        If (Len(SelectedProdNo)) > 0 Then
            checkforriggingnot2 = Convert.ToInt16(cmd2.ExecuteScalar())
            If checkforriggingnot2 = 1 Then
                cmd.ExecuteNonQuery()
                HasRiggingCount = Convert.ToInt16(cmd7.ExecuteScalar())
                HasWaveTamercount = Convert.ToInt16(cmd1.ExecuteScalar())

                If HasWaveTamercount = 1 Then
                    cmd1a.ExecuteNonQuery()
                Else
                    HasSharkhidecount = Convert.ToInt16(cmd5.ExecuteScalar())
                    If HasSharkhidecount = 1 Then
                        cmd5a.ExecuteNonQuery()
                    Else
                        cmd6.ExecuteNonQuery() 'No WT or SH, Boat is complete.
                    End If
                End If

                MesgBox("Rigging Complete.")
            Else

            End If

            conn.Close()
        Else
            MesgBox("Please enter a Full Production #.")
        End If


    End Sub
End Class
