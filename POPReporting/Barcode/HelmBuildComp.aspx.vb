Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Barcode_HelmBuildComp
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
        Dim recordcount As Int16 = 0

        Dim conn As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        cmd.CommandType = CommandType.Text

        cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET HelmBuildStatus = '2' , HelmBuild = @TodaysDate where ProdNo =  @fullprodno"

        cmd.Connection = conn
        cmd1.Connection = conn

        conn.Open()

        If Right(tbProd.Text, 10) = "HELMSBUILD" Then

            If fullprodno > 2100000 And fullprodno.Length = 7 Then
                'Try
                cmd.Parameters.AddWithValue("@fullprodno", fullprodno)
                cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)

                cmd.ExecuteNonQuery()

                'Try
                cmd1.Parameters.AddWithValue("@ThisDay", ThisDay)
                cmd1.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmBuildStatus = 2 and Convert(date,HelmBuild) ='" & ThisDay & "'"
                cmd1.ExecuteNonQuery()

                recordcount = Convert.ToInt16(cmd1.ExecuteScalar())
                lblHelmBuildCompToday.Text = recordcount
                'Catch
                'End Try


                'Catch ex As Exception
                'MesgBox("Error")
                'End Try

            Else : MesgBox("Error")
            End If

        End If


        tbProd.Text = ""
        tbProd.Focus()

        lblLastAction.Text = "Prod # " & fullprodno & " Marked Complete on " & TodaysDate

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


        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0


        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmBuildStatus = 2 and Convert(date,HelmBuild) ='" & ThisDay & "'"

        cmd.Connection = conn

        conn.Open()
        recordcount = Convert.ToInt16(cmd.ExecuteScalar())
        lblHelmBuildCompToday.Text = recordcount
        conn.Close()


    End Sub


End Class

