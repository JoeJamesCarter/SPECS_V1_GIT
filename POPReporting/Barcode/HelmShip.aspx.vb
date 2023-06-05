Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Partial Class Barcode_HelmShip
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
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
        cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmShipStatus = 2 and Convert(date,HelmShip) ='" & ThisDay & "'"

        cmd.Connection = conn

        conn.Open()
        recordcount = Convert.ToInt16(cmd.ExecuteScalar())
        lblHelmsShippedToday.Text = recordcount
        conn.Close()

    End Sub

    Private Sub tbProd_TextChanged(sender As Object, e As EventArgs) Handles tbProd.TextChanged
        Dim fullprodno As String = tbProd.Text
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0


        Dim conn As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim cmd As New SqlCommand
        Dim cmd12 As New SqlCommand


        cmd.CommandType = CommandType.Text

        cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET HelmShipStatus = '2', HelmShip = @TodaysDate where ProdNo = @fullprodno"
        cmd12.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmShipStatus = 2 and Convert(date,HelmShip) ='" & ThisDay & "'"

        cmd.Connection = conn
        cmd12.Connection = conn

        conn.Open()

        If fullprodno > 2100000 And Left(fullprodno, 1) = 2 Then
            Try
                cmd.Parameters.AddWithValue("@fullprodno", fullprodno)
                cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)

                cmd.ExecuteNonQuery()

                recordcount = Convert.ToInt16(cmd12.ExecuteScalar())
                lblHelmsShippedToday.Text = recordcount
            Catch ex As Exception
                MesgBox("Error on " & fullprodno)
            End Try

        Else
            MesgBox(fullprodno & " is not a valid production #. Please Try Again.")
            tbProd.Text = ""
            tbProd.Focus()
        End If

        conn.Close()

        gvShippedToday.DataBind()

        tbProd.Text = ""
        tbProd.Focus()
    End Sub
End Class
