Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Partial Class Gates_GatesInventory
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
        cmd.CommandText = "Select Count(AutoID) From Gates_ExtraInventory where Used =  0"
        conn.Open()
        lblNumGates.Text = cmd.ExecuteScalar
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

            cmd.CommandText = "Select Used from Gates_ExtraInventory Where AutoID = '" & AutoID & "'"
            cmd1.CommandText = "UPDATE Gates_ExtraInventory SET Used = '1', UsedDate = '" & TodaysDate & "' where AutoID =  '" & AutoID & "'"
            cmd2.CommandText = "UPDATE Gates_ExtraInventory SET Used = '0', UsedDate = NULL where AutoID =  '" & AutoID & "'"

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

    Protected Sub btnAddAGate_Click(sender As Object, e As EventArgs) Handles btnAddAGate.Click
        Dim url As String = "AddAGate.aspx"
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
    End Sub

    Protected Sub gvAllFieldsR_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsR.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim GateName As String = e.Row.DataItem("Gate")
            Dim MY As String = "2021"
            Dim ItemNo As String = ""
            Dim lblDrawing As Label = TryCast(e.Row.Cells(2).FindControl("lblDrawingNo"), Label)
            Dim Series As String = ""

            If e.Row.DataItem("Custom").ToString = "0" Then
                ItemNo = e.Row.DataItem("Model")
            End If

            Dim GateDrawNo As Object

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            If GateName.Length > 2 And e.Row.DataItem("Custom").ToString = "0" Then

                If Trim(GateName) = "BowCtr" Then
                    cmd.CommandText = "Select BowCtr From ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & ItemNo & "'"
                ElseIf Trim(GateName) = "Port" Then
                    cmd.CommandText = "Select Port From ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & ItemNo & "'"
                ElseIf Trim(GateName) = "Strb" Then
                    cmd.CommandText = "Select Strb From ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & ItemNo & "'"
                ElseIf Trim(GateName) = "AftPort" Then
                    cmd.CommandText = "Select AftPort From ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & ItemNo & "'"
                ElseIf Trim(GateName) = "AftCtr" Then
                    cmd.CommandText = "Select AftCtr From ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & ItemNo & "'"
                ElseIf Trim(GateName) = "AftRear" Then
                    cmd.CommandText = "Select AftStrb From ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & ItemNo & "'"
                End If

                conn.Open()
                GateDrawNo = Convert.ToString(cmd.ExecuteScalar)
                lblDrawing.Text = GateDrawNo

                Try
                    GateDrawNo = Convert.ToString(cmd.ExecuteScalar)
                    lblDrawing.Text = GateDrawNo

                Catch
                End Try
                conn.Close()
            End If

        End If
    End Sub
End Class
