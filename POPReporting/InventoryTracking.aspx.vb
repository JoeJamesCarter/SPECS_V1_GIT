Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class InventoryTracking
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gvAreas_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAreas.RowCommand
        If e.CommandName = "updatestatus" Then
            'This code is for the update button

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim rbList As RadioButtonList = DirectCast(gvAreas.Rows(Key).Cells(1).FindControl("rblStatus"), RadioButtonList)
            Dim area As String = gvAreas.Rows(Key).Cells(0).Text
            Dim status As Integer = rbList.SelectedValue

            Dim TodaysDate As Date = Date.Now

            'set the value of the radio button equal to what it is in the database on load.

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text

            If status = 1 Then 'clear req
                cmd.CommandText = "UPDATE Inventory.dbo.Inventory SET Status = '" & status & "', ClearRequested = '" & TodaysDate & "' where Area =  '" & area & "'"
            ElseIf status = 2 Then 'cleared
                cmd.CommandText = "UPDATE Inventory.dbo.Inventory SET Status = '" & status & "', TimeCleared = '" & TodaysDate & "' where Area =  '" & area & "'"
            ElseIf status = 3 Then 'call acct
                cmd.CommandText = "UPDATE Inventory.dbo.Inventory SET Status = '" & status & "', callAcctReq = '" & TodaysDate & "' where Area =  '" & area & "'"
            ElseIf status = 4 Then 'keyed
                cmd.CommandText = "UPDATE Inventory.dbo.Inventory SET Status = '" & status & "', keyEntryDone = '" & TodaysDate & "' where Area =  '" & area & "'"
            ElseIf status = 5 Then '1st review
                cmd.CommandText = "UPDATE Inventory.dbo.Inventory SET Status = '" & status & "', review1Done = '" & TodaysDate & "' where Area =  '" & area & "'"
            ElseIf status = 6 Then '2nd review
                cmd.CommandText = "UPDATE Inventory.dbo.Inventory SET Status = '" & status & "', review2Done = '" & TodaysDate & "' where Area =  '" & area & "'"

                'errors is 7

            ElseIf status = 8 Then 'report ready
                cmd.CommandText = "UPDATE Inventory.dbo.Inventory SET Status = '" & status & "', ReportRan = '" & TodaysDate & "' where Area =  '" & area & "'"
            ElseIf status = 9 Then 'area complete
                cmd.CommandText = "UPDATE Inventory.dbo.Inventory SET Status = '" & status & "', AreaComplete = '" & TodaysDate & "' where Area =  '" & area & "'"
            Else 'everything else
                cmd.CommandText = "UPDATE Inventory.dbo.Inventory SET Status = '" & status & "' where Area =  '" & area & "'"
            End If

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvAreas.DataBind()

        End If

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAreas.DataBind()
    End Sub
End Class
