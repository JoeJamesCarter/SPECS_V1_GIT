Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Barcode_GaugesRcv
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim fullprodno As String = tbProd.Text

        'Dim fullprodno As String = year + prod
        'tbProd.Text = fullprodno

        Dim TodaysDate As Date = Date.Now
        Dim greenlightcount As Int16 = 0
        Dim tubeneeded As Int16 = 0
        Dim tubecomplete As Int16 = 0
        Dim building As String

        'MesgBox(fullprodno)


        Dim conn As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim cmd As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd6 As New SqlCommand
        Dim cmd7 As New SqlCommand
       
        Dim cmd10 As New SqlCommand
        Dim cmd11 As New SqlCommand


        cmd.CommandType = CommandType.Text
        'cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET GaugeStatus = '2' , GaugeLastUpdated = '" & TodaysDate & "' where ProdNo =  '" & fullprodno & "'"
        cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET GaugeStatus = '2' , GaugeLastUpdated = @TodaysDate where ProdNo =  @fullprodno"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where GaugeStatus = 2 and ProdNo =  '" & fullprodno & "'"
        cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '1', DateAllGreen = @TodaysDate4 where ProdNo =  @fullprodno4 & " ' and FramesInstalled is NULL"
        'if not all green frames can't start, dateallgreen is wiped out only if Frames hasn't started yet.
        cmd5.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '0', DateAllGreen = NULL where ProdNo =  @fullprodno5 and FramesInstalled is NULL"
        'if all green lights are on (covers can be yellow) check if Centertubeneeded is 1 and if CentertubeStatus = 2.  If true, Frames can start.
        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING where CentertubeNeeded = 1 and ProdNo =  '" & fullprodno & "'"
        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = 2 and ProdNo =  '" & fullprodno & "'"
        cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus >= 1 and ProdNo =  '" & fullprodno & "'"
        cmd11.CommandText = "Select BuildLoc FROM BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & fullprodno & "'"

        cmd.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        
        cmd10.Connection = conn
        cmd11.Connection = conn

        conn.Open()


        If fullprodno > 2100000 And (fullprodno.Length = 6 Or fullprodno.Length = 7) Then

            Try
                cmd.Parameters.AddWithValue("@fullprodno", fullprodno)
                cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)

                'cmd4.Parameters.AddWithValue("@fullprodno4", fullprodno)
                'cmd4.Parameters.AddWithValue("@TodaysDate4", TodaysDate)

                'cmd5.Parameters.AddWithValue("@fullprodno5", fullprodno)

                If cmd3.ExecuteScalar > 0 Then
                    MesgBox("Gauge Panel Already Green - Previously Received.")
                Else
                    cmd.ExecuteNonQuery()
                    gvGaugesToday.DataBind()
                End If

                'greenlightcount = Convert.ToInt16(cmd3.ExecuteScalar())
                'building = cmd11.ExecuteScalar

                'If building = "M" Then
                '    If greenlightcount = 1 Then '7 major greenlights are green

                '        tubeneeded = Convert.ToInt16(cmd6.ExecuteScalar()) 'is a centertube on the order
                '        tubecomplete = Convert.ToInt16(cmd7.ExecuteScalar()) 'if so, is it complete?
                '        If tubeneeded = 0 Then 'not on the order
                '            cmd4.ExecuteNonQuery() 'start frames to start.
                '        ElseIf tubeneeded = 1 And tubecomplete = 0 Then ' if on the order and not complete, reverse frames.
                '            cmd5.ExecuteNonQuery()
                '        ElseIf tubeneeded = 1 And tubecomplete = 1 Then 'if on the order and complete, set frames to start.
                '            cmd4.ExecuteNonQuery()
                '        End If
                '    Else
                '        cmd5.ExecuteNonQuery()
                '    End If
                'End If


            Catch ex As Exception
                MesgBox("Error")
            End Try

        Else : MesgBox("Error")
        End If


		tbProd.Text = ""
		tbProd.Focus()


		conn.Close()
    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
		tbProd.Text = ""
		tbProd.Focus()
	End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbProd.Focus()
    End Sub
End Class

