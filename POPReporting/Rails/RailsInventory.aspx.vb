Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Rails_RailsInventory
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim cmd As New SqlCommand
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd.CommandText = "Select Count(AutoID) From Rails_ExtraInventory where Used =  0"
        conn.Open()
        lblNumRails.Text = cmd.ExecuteScalar
        conn.Close()

    End Sub

    Protected Sub gvAllFieldsR_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsR.RowCommand
        If e.CommandName = "gotoupdateused" Then
            'This code is for the mark used button
            Dim AutoID As String = e.CommandArgument 'get the row that is clicked
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim TodaysDate As Date = Date.Now
            Dim isUsed As Integer

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand

            conn.ConnectionString = connstr

            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn

            cmd.CommandText = "Select Used from Rails_ExtraInventory Where AutoID = '" & AutoID & "'"
            cmd1.CommandText = "UPDATE Rails_ExtraInventory SET Used = '1', UsedDate = '" & TodaysDate & "' where AutoID =  '" & AutoID & "'"
            cmd2.CommandText = "UPDATE Rails_ExtraInventory SET Used = '0', UsedDate = NULL where AutoID =  '" & AutoID & "'"

            conn.Open()

            isUsed = cmd.ExecuteScalar

            If isUsed = 0 Then
                cmd1.ExecuteNonQuery()
            Else
                cmd2.ExecuteNonQuery()
            End If

            conn.Close()

            gvAllFieldsR.DataBind()

        End If

    End Sub

    Protected Sub btnAddARail_Click(sender As Object, e As EventArgs) Handles btnAddARail.Click
        Dim url As String = "AddARail.aspx"
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
    End Sub

    Protected Sub gvAllFieldsR_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsR.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim RailName As String = e.Row.DataItem("RailType")
            Dim MY As String = "2022"
            Dim ItemNo As String = ""
            Dim lblDrawing As Label = TryCast(e.Row.Cells(2).FindControl("lblDrawingNo"), Label)
            Dim Series As String = ""

            If e.Row.DataItem("Custom").ToString = "0" Then
                ItemNo = e.Row.DataItem("Model")
                If ItemNo Like "??R*" Or ItemNo Like "??Q*" Then
                    Series = "RQ"
                End If
            End If

            'If Series = "RQ" Then
            ' MesgBox(Series)
            'End If

            Dim RailDrawNo As Object

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            If RailName.Length > 2 And e.Row.DataItem("Custom").ToString = "0" And Series = "" Then

                If RailName = "PortFront" Then
                    cmd.CommandText = "Select PortFront From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & ItemNo & "'"
                ElseIf RailName = "PortRear" Then
                    cmd.CommandText = "Select PortRear From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & ItemNo & "'"
                ElseIf RailName = "StrbFront" Then
                    cmd.CommandText = "Select StrbFront From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & ItemNo & "'"
                ElseIf RailName = "StrbRear" Then
                    cmd.CommandText = "Select StrbRear From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & ItemNo & "'"
                ElseIf RailName = "PortMid" Then
                    cmd.CommandText = "Select PortMid From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & ItemNo & "'"
                ElseIf RailName = "StrbMid" Then
                    cmd.CommandText = "Select StrbMid From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & ItemNo & "'"
                ElseIf RailName = "Transom" Then
                    cmd.CommandText = "Select Transom From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & ItemNo & "'"
                End If

                conn.Open()
                RailDrawNo = Convert.ToString(cmd.ExecuteScalar)
                lblDrawing.Text = RailDrawNo
                conn.Close()

            ElseIf RailName.Length > 2 And e.Row.DataItem("Custom").ToString = "0" And Series = "RQ" Then
                If RailName = "PortFront" Then
                    cmd.CommandText = "Select PortFront From Rails.dbo.ModelsRQ Where Model = '" & ItemNo & "'"
                ElseIf RailName = "PortRear" Then
                    cmd.CommandText = "Select PortRear From Rails.dbo.ModelsRQ Where Model = '" & ItemNo & "'"
                ElseIf RailName = "StrbFront" Then
                    cmd.CommandText = "Select StrbFront From Rails.dbo.ModelsRQ Where Model = '" & ItemNo & "'"
                ElseIf RailName = "StrbRear" Then
                    cmd.CommandText = "Select StrbRear From Rails.dbo.ModelsRQ Where Model = '" & ItemNo & "'"
                ElseIf RailName = "PortMid" Then
                    cmd.CommandText = "Select PortMid From Rails.dbo.ModelsRQ Where Model = '" & ItemNo & "'"
                ElseIf RailName = "StrbMid" Then
                    cmd.CommandText = "Select StrbMid From Rails.dbo.ModelsRQ Where Model = '" & ItemNo & "'"
                ElseIf RailName = "Transom" Then
                    cmd.CommandText = "Select Transom From Rails.dbo.ModelsRQ Where Model = '" & ItemNo & "'"
                End If

                conn.Open()
                Try
                    RailDrawNo = Convert.ToString(cmd.ExecuteScalar)
                    lblDrawing.Text = RailDrawNo

                Catch
                End Try
                conn.Close()
            End If

        End If
    End Sub
End Class
