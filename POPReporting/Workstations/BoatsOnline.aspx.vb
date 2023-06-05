Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_BoatsOnline
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim framescount As Int16
        Dim framesreadytostart As Int16
        Dim framesreadytostartio As Int16

        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand

        Dim conn As New SqlConnection
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        conn.ConnectionString = connstr
        lblToday.Text = ThisDay
        cmd.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn

        cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 2 and Convert(date,FramesInstalled) ='" & ThisDay & "'"
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
        conn.Open()
        framescount = Convert.ToInt16(cmd.ExecuteScalar())
        framesreadytostart = Convert.ToInt16(cmd2.ExecuteScalar)
        framesreadytostartio = Convert.ToInt16(cmd3.ExecuteScalar)

        lblCountOnlineToday.Text = framescount
        lblReadytoStart.Text = framesreadytostart
        lblios.Text = framesreadytostartio
        conn.Close()

    End Sub
End Class
