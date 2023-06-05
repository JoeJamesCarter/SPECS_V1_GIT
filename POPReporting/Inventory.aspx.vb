Imports System.Data
Imports System.Data.SqlClient

Partial Class Inventory
    Inherits System.Web.UI.Page


    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

        DataList1.DataBind()

        Dim numAreas As Decimal
        Dim percent As Integer

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd6 As New SqlCommand
        Dim cmd7 As New SqlCommand
        Dim cmd8 As New SqlCommand
        Dim cmd9 As New SqlCommand

        Dim cmd0 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd8.Connection = conn
        cmd9.Connection = conn

        cmd0.Connection = conn

        cmd.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 0"
        cmd1.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 1"
        cmd2.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 2"
        cmd3.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 3"
        cmd4.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 4"
        cmd5.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 5"
        cmd6.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 6"
        cmd7.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 7"
        cmd8.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 8"
        cmd9.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 9"
        cmd0.CommandText = "Select Count(Area) as Count From Inventory" 'total # of areas


        conn.Open()

        lblNotStartedCount.Text = cmd.ExecuteScalar
        lblClearReq.Text = cmd1.ExecuteScalar
        lblClearedCount.Text = cmd2.ExecuteScalar
        lblCallAcct.Text = cmd3.ExecuteScalar
        lblKeyedCount.Text = cmd4.ExecuteScalar
        lblReview1.Text = cmd5.ExecuteScalar
        lblReview2.Text = cmd6.ExecuteScalar
        lblReportsReadyCount.Text = cmd8.ExecuteScalar
        lblErrorsCount.Text = cmd7.ExecuteScalar
        lblDoneCount.Text = cmd9.ExecuteScalar

        numAreas = cmd0.ExecuteScalar
        percent = (Convert.ToInt16(lblDoneCount.Text) / numAreas) * 100
        percentComplete.Text = percent
		gvWaiting.DataBind()
		conn.Close()
		'gvAuditorswRpts.DataBind()




	End Sub



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim numAreas As Decimal
        Dim percent As Integer

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd6 As New SqlCommand
        Dim cmd7 As New SqlCommand
        Dim cmd8 As New SqlCommand
        Dim cmd9 As New SqlCommand

        Dim cmd0 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd8.Connection = conn
        cmd9.Connection = conn

        cmd0.Connection = conn

        cmd.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 0"
        cmd1.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 1"
        cmd2.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 2"
        cmd3.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 3"
        cmd4.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 4"
        cmd5.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 5"
        cmd6.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 6"
        cmd7.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 7"
        cmd8.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 8"
        cmd9.CommandText = "Select Count(Area) as Count FROM Inventory where Status = 9"

        cmd0.CommandText = "Select Count(Area) as Count From Inventory" 'total # of areas
        conn.Open()

        lblNotStartedCount.Text = cmd.ExecuteScalar
        lblClearReq.Text = cmd1.ExecuteScalar
        lblClearedCount.Text = cmd2.ExecuteScalar

        lblCallAcct.Text = cmd3.ExecuteScalar()
        lblKeyedCount.Text = cmd4.ExecuteScalar

        lblReview1.Text = cmd5.ExecuteScalar()
        lblReview2.Text = cmd6.ExecuteScalar()


        lblReportsReadyCount.Text = cmd8.ExecuteScalar
        lblErrorsCount.Text = cmd7.ExecuteScalar
        lblDoneCount.Text = cmd9.ExecuteScalar

        numAreas = cmd0.ExecuteScalar
        percent = (Convert.ToInt32(lblDoneCount.Text) / numAreas) * 100
        percentComplete.Text = percent

        'gvAuditorswRpts.DataBind()
        'gvWaiting.DataBind()

        conn.Close()
    End Sub

    Protected Sub DataList1_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles DataList1.ItemDataBound
        If e.Item.DataItem("Status") = 0 Then 'counting
            e.Item.BackColor = Drawing.Color.White
            e.Item.ForeColor = Drawing.Color.Black
        ElseIf e.Item.DataItem("Status") = 1 Then 'clear reqd
            e.Item.BackColor = Drawing.Color.Orange
            e.Item.ForeColor = Drawing.Color.Black
        ElseIf e.Item.DataItem("Status") = 2 Then 'cleared
            e.Item.BackColor = Drawing.Color.Gray
            e.Item.ForeColor = Drawing.Color.Black
        ElseIf e.Item.DataItem("Status") = 3 Then 'call acct
            e.Item.BackColor = Drawing.Color.DarkRed
            e.Item.ForeColor = Drawing.Color.White
            e.Item.CssClass = "blinkingText"
        ElseIf e.Item.DataItem("Status") = 4 Then
            e.Item.BackColor = Drawing.Color.Blue 'keyed
            e.Item.ForeColor = Drawing.Color.White
        ElseIf e.Item.DataItem("Status") = 5 Then
            e.Item.BackColor = Drawing.Color.LightCyan 'reveiw1
            e.Item.ForeColor = Drawing.Color.Black
        ElseIf e.Item.DataItem("Status") = 6 Then
            e.Item.BackColor = Drawing.Color.Purple 'review2
            e.Item.ForeColor = Drawing.Color.White
        ElseIf e.Item.DataItem("Status") = 8 Then 'report ready
            e.Item.BackColor = Drawing.Color.Yellow
            e.Item.ForeColor = Drawing.Color.Black
        ElseIf e.Item.DataItem("Status") = 7 Then 'errors
            e.Item.BackColor = Drawing.Color.Red
            e.Item.ForeColor = Drawing.Color.White
        ElseIf e.Item.DataItem("Status") = 9 Then 'done
            e.Item.BackColor = Drawing.Color.Green
			e.Item.ForeColor = Drawing.Color.White
		End If

    End Sub
End Class
