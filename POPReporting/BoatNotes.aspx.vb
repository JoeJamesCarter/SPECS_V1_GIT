Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class BoatNotes
    Inherits System.Web.UI.Page

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Function SplitBValSlash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("\")(1)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Dim lblProdNo As Label
        Dim BoatNotesProdNo As String
        Dim workstation As String

        BoatNotesProdNo = Request.QueryString("ProdNo")
        workstation = Request.QueryString("ws")
        lblProdNo.Text = BoatNotesProdNo
        hdnWorkstation.Value = workstation
        If workstation Is Nothing Then
            btnBoatNote.Visible = False
            tbNote.Visible = False
            lblAddNewNote.Visible = False
        End If

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)

    End Sub

    Protected Sub btnBoatNote_Click(sender As Object, e As EventArgs) Handles btnBoatNote.Click
        Dim Note As String = tbNote.Text
        Dim BoatNotesProdNo As String = lblProdNo.Text

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim i As Integer = 0
        Dim j As Integer = 0
        Dim selectedcount As Integer = 0

        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@Note", Note)
        cmd.Parameters.AddWithValue("@BoatNotesProdNo", BoatNotesProdNo)
        cmd.Parameters.AddWithValue("@Workstation", hdnWorkstation.Value)

        conn.ConnectionString = connstr
        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd2.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set BoatHasNotes ='1' where ProdNo =  '" & BoatNotesProdNo & "'"
        cmd.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn



        For i = 0 To cblCreatedFor.Items.Count - 1 '20
            If cblCreatedFor.Items(i).Selected = True Then
                selectedcount = selectedcount + 1
            End If
        Next

        If selectedcount = 0 Then
            MesgBox("Please select the workstation this note applies to, or select None.")
        Else
            'MesgBox(cblCreatedFor.Items.Count)
            conn.Open()
            cmd2.ExecuteNonQuery()
            For j = 0 To cblCreatedFor.Items.Count - 1
                If cblCreatedFor.Items(j).Selected = True Then
                    cmd.CommandText = "Insert into BML_POPREPORTING_NOTES (Date, Note, ProdNo, Workstation, CreatedFor) VALUES (@TodaysDate, @Note, @BoatNotesProdNo, @Workstation, '" & cblCreatedFor.Items(j).Value & "' )"
                    cmd.ExecuteNonQuery()
                    'prepend note to the value of the cb item to set a 1 if there is a note created for that workstation.
                    Dim NotetoSet As String = "Notes" & cblCreatedFor.Items(j).Value
                    cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set " & NotetoSet & "= '1' where ProdNo = '" & BoatNotesProdNo & "'"
                    'cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS SET NotesRailsPrep = '1' where ProdNo = '" & BoatNotesProdNo & "'"
                    cmd3.ExecuteNonQuery()
                End If
            Next
            MesgBox("Saved")

            ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
            Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")
        End If

    End Sub

    Protected Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")

    End Sub

    Private Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "gotoMarkResolved" Then 'handles when the ? button is clicked

            Dim Auto As String = e.CommandArgument 'get the row that is clicked
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim TodaysDate As Date = Date.Now
            Dim stationID As String = GlobalVariables.stationID


            cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
            cmd.Parameters.AddWithValue("@Auto", Auto)
            cmd.Parameters.AddWithValue("@ResolvedBy", stationID)

            conn.ConnectionString = connstr
            cmd.CommandType = CommandType.Text

            cmd.CommandText = "Update BML_POPREPORTING_NOTES Set Resolved = 1, ResolvedDate = @TodaysDate, ResolvedBy = @ResolvedBy where Auto = @Auto"
            cmd.Connection = conn
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            GridView1.DataBind()
            gvCleared.DataBind()

            ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
            Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")

        End If
    End Sub
End Class
