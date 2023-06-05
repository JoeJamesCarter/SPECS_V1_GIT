Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Misc_Notes
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")
    End Sub

    Protected Sub btnBoatMiscNote_Click(sender As Object, e As EventArgs) Handles btnBoatMiscNote.Click
        Dim Note As String = tbMiscNote.Text

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim TodaysDate As Date = Date.Now

        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@Note", Note)


        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Insert into MISC_NOTES (Date, Note, Cleared) VALUES (@TodaysDate, @Note, '0')"

        cmd.Connection = conn

        conn.Open()
        cmd.ExecuteNonQuery()


        MesgBox("Saved")


        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")

    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "clearmiscnote" Then
            Dim Auto As String = e.CommandArgument 'get the row that is clicked
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "Update MISC_NOTES Set Cleared ='1', DateCleared = '" & TodaysDate & "' where Auto =  '" & Auto & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            GridView1.DataBind()

        End If
    End Sub
End Class
