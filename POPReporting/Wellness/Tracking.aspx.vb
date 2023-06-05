Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO

Partial Class Wellness_Tracking
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

    Protected Sub Wellness_Tracking_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
        tbUser.Text = GlobalVariables.stationID

        If GlobalVariables.stationID = "krimbaugh" Or GlobalVariables.stationID = "mkrohn" Then
            tbUser.Enabled = False
            'btnBrandie.Visible = True
            'btnChristy.Visible = True
            'btnJim.Visible = True
            'btnMartin.Visible = True
            'btnKristin.Visible = True
            'btnKeri.Visible = True
            tbUser.Enabled = False
            btnBrandie.Visible = False
            btnChristy.Visible = False
            btnJim.Visible = False
            btnMartin.Visible = False
            btnKristin.Visible = False
            btnKeri.Visible = False
        Else
            tbUser.Text = GlobalVariables.stationID
            tbUser.Enabled = False
            btnBrandie.Visible = False
            btnChristy.Visible = False
            btnJim.Visible = False
            btnMartin.Visible = False
            btnKristin.Visible = False
            btnKeri.Visible = False
        End If


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

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim TodaysDate As Date = Date.Now
        Dim hourrange As String = ddlHourRange.SelectedItem.Text
        Dim datecompleted As Date = calDateCompleted.SelectedDate

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@username", tbUser.Text)
        cmd.Parameters.AddWithValue("@datecompleted", datecompleted)
        cmd.Parameters.AddWithValue("@hour", hourrange)
        cmd.Parameters.AddWithValue("@qty", tbQty.Text)
        cmd.Parameters.AddWithValue("@datelogged", TodaysDate)

        cmd.CommandText = "Insert Into Wellness (username, datecompleted, hour, exercise, qty, datelogged) VALUES (@username, @datecompleted,@hour,'PUSHUPS', @qty, @datelogged)"
        conn.Open()

        Try
            cmd.ExecuteScalar()
        Catch ex As Exception
            MesgBox("Select A Date In The Calendar.")
        End Try

        conn.Close()

        ddlHourRange.SelectedIndex = -1

        gvUserProgress.DataBind()
        gvMyProgressToday.DataBind()
        gvResults.DataBind()
    End Sub

    Protected Sub btnChristy_Click(sender As Object, e As EventArgs) Handles btnChristy.Click
        tbUser.Text = "cspringman"
        lblDailyTotal.Text = ""
        lblHistoryTotal.Text = ""
    End Sub

    Protected Sub btnBrandie_Click(sender As Object, e As EventArgs) Handles btnBrandie.Click
        tbUser.Text = "bmoran"
        lblDailyTotal.Text = ""
        lblHistoryTotal.Text = ""
    End Sub

    Protected Sub btnJim_Click(sender As Object, e As EventArgs) Handles btnJim.Click
        tbUser.Text = "jhary"
        lblDailyTotal.Text = ""
        lblHistoryTotal.Text = ""
    End Sub

    Protected Sub btnKristin_Click(sender As Object, e As EventArgs) Handles btnKristin.Click
        tbUser.Text = "kgildemieser"
        lblDailyTotal.Text = ""
        lblHistoryTotal.Text = ""
    End Sub

    Protected Sub btnMartin_Click(sender As Object, e As EventArgs) Handles btnMartin.Click
        tbUser.Text = "mkrohn"
        lblDailyTotal.Text = ""
        lblHistoryTotal.Text = ""
    End Sub

    Protected Sub btnKeri_Click(sender As Object, e As EventArgs) Handles btnKeri.Click
        tbUser.Text = "krimbaugh"
        lblDailyTotal.Text = ""
        lblHistoryTotal.Text = ""
    End Sub

    Dim dailyTotal As Integer = 0
    Dim historyTotal As Integer = 0

    Protected Sub gvMyProgressToday_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvMyProgressToday.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then
            dailyTotal = dailyTotal + e.Row.DataItem("qty")

        End If
        lblDailyTotal.Text = dailyTotal
        
    End Sub

    Protected Sub gvUserProgress_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvUserProgress.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            historyTotal = historyTotal + e.Row.DataItem("qty")

        End If
        lblHistoryTotal.Text = historyTotal

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvUserProgress.DataBind()
        gvMyProgressToday.DataBind()
        gvResults.DataBind()
    End Sub
End Class
