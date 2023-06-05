Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Barcode_HarnessRcv
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
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        'Dim building As String

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
        Dim cmd12 As New SqlCommand

        Dim cmd13 As New SqlCommand
        Dim cmd14 As New SqlCommand
        Dim cmd15 As New SqlCommand


        cmd.CommandType = CommandType.Text
        'cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET GaugeStatus = '2' , GaugeLastUpdated = '" & TodaysDate & "' where ProdNo =  '" & fullprodno & "'"
        cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET HarnessStatus = '2' , HarnessLastUpdated = @TodaysDate where ProdNo =  @fullprodno"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and TubesStatus = 2 and GaugeStatus >= 2 and HarnessStatus >= 2 and ProdNo =  '" & fullprodno & "'"
        cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '1', DateAllGreen = @TodaysDate4 where ProdNo =  @fullprodno4 & " ' and FramesInstalled is NULL"
        'if not all green frames can't start, dateallgreen is wiped out only if Frames hasn't started yet.
        cmd5.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '0', DateAllGreen = NULL where ProdNo =  @fullprodno5 and FramesInstalled is NULL"
        'if all green lights are on (covers can be yellow) check if Centertubeneeded is 1 and if CentertubeStatus = 2.  If true, Frames can start.
        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING where CentertubeNeeded = 1 and ProdNo =  '" & fullprodno & "'"
        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = 2 and ProdNo =  '" & fullprodno & "'"
        cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus >= 1 and ProdNo =  '" & fullprodno & "'"
        cmd11.CommandText = "Select BuildLoc FROM BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & fullprodno & "'"

        cmd12.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HarnessStatus = 2 and Convert(date,HarnessLastUpdated) ='" & ThisDay & "'"

        cmd13.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ProdLineID = 1 and HarnessStatus = 2 and Convert(date,HarnessLastUpdated) ='" & ThisDay & "'"
        cmd14.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ProdLineID = 2 and HarnessStatus = 2 and Convert(date,HarnessLastUpdated) ='" & ThisDay & "'"
        cmd15.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ProdLineID = 3 and HarnessStatus = 2 and Convert(date,HarnessLastUpdated) ='" & ThisDay & "'"



        cmd.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn

        cmd10.Connection = conn
        cmd11.Connection = conn
        cmd12.Connection = conn
        cmd13.Connection = conn
        cmd14.Connection = conn
        cmd15.Connection = conn

        conn.Open()

        If fullprodno > 2100000 And fullprodno.Length = 7 And Left(fullprodno, 1) = 2 Then
            Try
                cmd.Parameters.AddWithValue("@fullprodno", fullprodno)
                cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)

                'cmd4.Parameters.AddWithValue("@fullprodno4", fullprodno)
                'cmd4.Parameters.AddWithValue("@TodaysDate4", TodaysDate)

                'cmd5.Parameters.AddWithValue("@fullprodno5", fullprodno)

                cmd.ExecuteNonQuery()

                recordcount = Convert.ToInt16(cmd12.ExecuteScalar())
                lblHarnessRcvToday.Text = recordcount
                lblB1Total.Text = cmd13.ExecuteScalar
                lblB2Total.Text = cmd14.ExecuteScalar
                lblB3Total.Text = cmd15.ExecuteScalar

            Catch ex As Exception
                MesgBox("Error on " & fullprodno)
            End Try

        Else
            MesgBox(fullprodno & " is not a valid production #. Please Try Again.")
            tbProd.Text = ""
            tbProd.Focus()
        End If


        tbProd.Text = ""
        tbProd.Focus()

        gvHarnessesToday.DataBind()
        conn.Close()
    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbProd.Text = ""
        tbProd.Focus()
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbProd.Focus()

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd13 As New SqlCommand
        Dim cmd14 As New SqlCommand
        Dim cmd15 As New SqlCommand

        cmd13.Connection = conn
        cmd14.Connection = conn
        cmd15.Connection = conn

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String
        Dim framesreadytostart As Int16
        Dim framesreadytostartio As Int16


        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HarnessStatus = 2 and Convert(date,HarnessLastUpdated) ='" & ThisDay & "'"
        cmd13.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ProdLineID = 1 and HarnessStatus = 2 and Convert(date,HarnessLastUpdated) ='" & ThisDay & "'"
        cmd14.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ProdLineID = 2 and HarnessStatus = 2 and Convert(date,HarnessLastUpdated) ='" & ThisDay & "'"
        cmd15.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ProdLineID = 3 and HarnessStatus = 2 and Convert(date,HarnessLastUpdated) ='" & ThisDay & "'"

        cmd.Connection = conn

        conn.Open()
        recordcount = Convert.ToInt16(cmd.ExecuteScalar())

        lblB1Total.Text = cmd13.ExecuteScalar
        lblB2Total.Text = cmd14.ExecuteScalar
        lblB3Total.Text = cmd15.ExecuteScalar

        lblHarnessRcvToday.Text = recordcount
        conn.close()

    End Sub
End Class
