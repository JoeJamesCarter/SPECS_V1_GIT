Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration


Partial Class CoversRGAs
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub btnSelectAll_Click(sender As Object, e As EventArgs) Handles btnSelectAll.Click
        For Each row As GridViewRow In gvOpenRGAItems.Rows
            Dim cb As CheckBox = TryCast(row.Cells(0).FindControl("cbSelect"), CheckBox)
            cb.Checked = True
        Next
    End Sub

    Protected Sub bntCreatePrint_Click(sender As Object, e As EventArgs) Handles bntCreatePrint.Click

        Dim maxrgano As Integer = 0
        Dim nextrgano As Integer
        Dim TodaysDate As Date = Date.Now

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim cmd As New SqlCommand ' get max rga no
        Dim cmd1 As New SqlCommand ' update

        cmd.Connection = conn
        cmd1.Connection = conn

        conn.Open()

        cmd.CommandText = "Select Max(RGANo) from CanvasRGAs"
        maxrgano = cmd.ExecuteScalar
        nextrgano = maxrgano + 1

        cmd1.CommandText = "Update CanvasRGAs Set RGANo = @nextrgano, RGAGenDate = @TodaysDate where AutoID = @AutoID"

        For Each row As GridViewRow In gvOpenRGAItems.Rows
            Dim cb As CheckBox = TryCast(row.Cells(0).FindControl("cbSelect"), CheckBox)
            Dim id As String = row.Cells(5).Text

            If cb.Checked = True Then
                cmd1.Parameters.AddWithValue("@nextrgano", nextrgano)
                cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd1.Parameters.AddWithValue("@AutoID", id)
                cmd1.ExecuteNonQuery()
                cmd1.Parameters.Clear()
            End If
        Next

        conn.Close()
    End Sub
End Class
