Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Materials_SetupItemLocations
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Materials_SetupItemLocations_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbBenPartNo.Focus()
    End Sub

    Protected Sub DetailsView1_DataBound(sender As Object, e As EventArgs) Handles DetailsView1.DataBound
        If IsPostBack And tbBenPartNo.Text <> "" Then
            tbLoc.Focus()
        End If
    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbBenPartNo.Text = ""
        tbLoc.Text = ""
        tbBenPartNo.Focus()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Dim part As String = tbBenPartNo.Text
        Dim loc As String = tbLoc.Text
        Dim loc1 As String
        Dim loc2 As String
        Dim loc3 As String
        Dim loc4 As String

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        conn.Open()

        If loc Like "1*" Then
            loc1 = loc
            cmd1.Parameters.AddWithValue("@loc1", loc1)
            cmd1.CommandText = "Update LocationsByPart Set Loc1 = @loc1 where Item_No = '" & part & "'"
            cmd1.ExecuteNonQuery()
            'MesgBox("Setup Location 1")
        ElseIf loc Like "2*" Then
            loc2 = loc
            cmd2.Parameters.AddWithValue("@loc2", loc2)
            cmd2.CommandText = "Update LocationsByPart Set Loc2 = @loc2 where Item_No = '" & part & "'"
            cmd2.ExecuteNonQuery()
            'MesgBox("Setup Location 2")
        ElseIf loc Like "3*" Then
            loc3 = loc
            cmd3.Parameters.AddWithValue("@loc3", loc3)
            cmd3.CommandText = "Update LocationsByPart Set Loc3 = @loc3 where Item_No = '" & part & "'"
            cmd3.ExecuteNonQuery()
            'MesgBox("Setup Location 3")
        ElseIf loc Like "4*" Then
            loc4 = loc
            cmd4.Parameters.AddWithValue("@loc4", loc4)
            cmd4.CommandText = "Update LocationsByPart Set Loc4 = @loc4 where Item_No = '" & part & "'"
            cmd4.ExecuteNonQuery()
            'MesgBox("Setup Location 4")
        End If

        conn.Close()
        tbBenPartNo.Text = ""
        tbLoc.Text = ""
        tbBenPartNo.Focus()

    End Sub
End Class
