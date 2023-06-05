Imports System.Data
Imports System.Data.SqlClient

Partial Class Barcode_Kitting3
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        'This code is for the update button
        Dim fullprodno As String = tbProd.Text
        Dim TodaysDate As Date = Date.Now

        Dim prod As String = ""
        Dim station As String = ""


        If fullprodno.Split("-").Count = 2 Then
            prod = fullprodno.Split("-")(0)
            station = fullprodno.Split("-")(1)

        ElseIf fullprodno.Split("-").Count = 1 Then
            prod = fullprodno
        End If


        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        conn.ConnectionString = connstr

        cmd.CommandType = CommandType.Text



        cmd.Connection = conn

        conn.Open()

        If prod > 1999999 And prod.Length = 7 Then
            Try
                cmd.Parameters.AddWithValue("@prod", prod)
                cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kitting3Status = 2 , Kitting3 = @TodaysDate where ProdNo =  @prod"
                cmd.ExecuteNonQuery()

            Catch ex As Exception
                'MesgBox("Error")
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
