
Imports System.Data
Imports System.Data.SqlClient

Partial Class Barcode_HelmRcv
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim fullprodno As String = Left(tbProd.Text, 7)

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        Dim conn As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand

        cmd.CommandType = CommandType.Text

        cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET HelmRcvStatus = '2', HelmRcv = @TodaysDate where ProdNo = @fullprodno"

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn

        conn.Open()

        'If Right(tbProd.Text, 10) = "HELMSBUILD" Then

        If fullprodno > 2100000 And fullprodno.Length = 7 Then
            'Try
            cmd.Parameters.AddWithValue("@fullprodno", fullprodno)
            cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)

            cmd.ExecuteNonQuery()

            'Try
            cmd1.Parameters.AddWithValue("@ThisDay", ThisDay)
            cmd2.Parameters.AddWithValue("@ThisDay2", ThisDay)
            cmd3.Parameters.AddWithValue("@ThisDay3", ThisDay)

            cmd1.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'M' and HelmRcvStatus = 2 and Convert(date,HelmRcv) = @ThisDay"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'V' and HelmRcvStatus = 2 and Convert(date,HelmRcv) = @ThisDay2"
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and HelmRcvStatus = 2 and Convert(date,HelmRcv) = @ThisDay3"

            lblHelmBuildCompTodayM.Text = cmd1.ExecuteScalar
            lblHelmBuildCompTodayV.Text = cmd2.ExecuteScalar
            lblHelmBuildCompTodayS.Text = cmd3.ExecuteScalar

            lblLastAction.Text = "Prod # " & fullprodno & " Marked Complete on " & TodaysDate

        Else : MesgBox("Error - Prod # is not 7 Digits")
        End If

        'End If


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

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0


        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text

        cmd.Parameters.AddWithValue("@ThisDay", ThisDay)
        cmd1.Parameters.AddWithValue("@ThisDay1", ThisDay)
        cmd2.Parameters.AddWithValue("@ThisDay2", ThisDay)

        cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'M' and HelmRcvStatus = 2 and Convert(date,HelmRcv) = @ThisDay"
        cmd1.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'V' and HelmRcvStatus = 2 and Convert(date,HelmRcv) = @ThisDay1"
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and HelmRcvStatus = 2 and Convert(date,HelmRcv) = @ThisDay2"

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn

        conn.Open()

        lblHelmBuildCompTodayM.Text = cmd.ExecuteScalar
        lblHelmBuildCompTodayV.Text = cmd1.ExecuteScalar
        lblHelmBuildCompTodayS.Text = cmd2.ExecuteScalar
        conn.Close()


    End Sub


End Class

