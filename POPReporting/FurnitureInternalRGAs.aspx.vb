Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class FurnitureInternalRGAs
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim DaystoShow As String


        If ddlDaysInAdvance.Items.Count = 0 Then  'stop it from repopulating everytime the grid rebinds
            DaystoShow = ThisDay.AddDays(5).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("3 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(7).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("5 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(12).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("10 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(17).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("15 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(22).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("20 Days", DaystoShow))
        End If
    End Sub


    Protected Sub gvInternalRGAs_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvInternalRGAs.RowCommand
        If e.CommandName = "gotoUpdate" Then

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim SelectedAutoID As Integer = Line(1)


            Dim rbList As RadioButtonList = DirectCast(gvInternalRGAs.Rows(id).Cells(8).FindControl("rblStatus"), RadioButtonList)
            Dim Status As Integer = rbList.SelectedValue
            Dim TodaysDate As Date = Date.Now
            'MesgBox(id)
            'MesgBox(SelectedAutoID)

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.Parameters.AddWithValue("@Status", rbList.SelectedValue)
            cmd.Parameters.AddWithValue("@AutoID", SelectedAutoID)
            cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update InternalRGAs Set Resolved = @Status, DateResolved = @TodaysDate where AutoID = @AutoID"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            Me.DataBind()

        End If
    End Sub

    Protected Sub gvInternalRGAs_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvInternalRGAs.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If

    End Sub
End Class
