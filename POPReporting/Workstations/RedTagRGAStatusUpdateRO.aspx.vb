Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Workstations_RedTagStatusUpdateRO
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Dim lblProdNo As Label
        Dim RGAID As String
        Dim Results As SqlDataReader
        Dim Item As String
        Dim Status As String
        Dim Note As String
        Dim UpdatedBy As String
        Dim DateUpd As String


        RGAID = Request.QueryString("AutoID")
        lblAutoID.Text = RGAID

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        'Dim cmd1 As New SqlCommand

        cmd.CommandText = "Select RGA_Item_Desc,Status,StatusNote,StatusUpdatedBy,StatusLastUpdatedDate From Veada_RGAs Where AutoID=" & RGAID
        'cmd1.CommandText = "Select Status From Veada_RGAs Where AutoID=" & RGAID
        conn.ConnectionString = connstr
        cmd.Connection = conn
        'cmd1.Connection = conn

        conn.Open()

        Results = cmd.ExecuteReader(CommandBehavior.SingleRow)

        If Results.Read() Then

            Item = Results.Item("RGA_Item_Desc")
            Status = Results.Item("Status")
            Note = Results.Item("StatusNote").ToString
            UpdatedBy = Results.Item("StatusUpdatedBy").ToString
            DateUpd = Results.Item("StatusLastUpdatedDate").ToString


            lblRGAPart.Text = Item

            If Not IsPostBack Then
                rblStatus.SelectedValue = Status


                If Note.Length > 0 Then
                    tbNote.Text = Note
                End If
                If UpdatedBy.Length > 0 Then
                    tbUpdatedBy.Text = UpdatedBy

                End If
                If DateUpd.Length > 0 Then
                    tbLastUpdated.Text = DateUpd
                End If

            End If
        End If
        conn.Close()
    End Sub

    


End Class
