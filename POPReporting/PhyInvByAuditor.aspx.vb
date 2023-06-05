Imports System.Data
Imports System.Data.SqlClient

Partial Class PhyInvByAuditor
    Inherits System.Web.UI.Page

    Public tagsWIssues As New DataTable

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything

        Dim sqldataadapter As New SqlDataAdapter
        Dim conn As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()

        sqldataadapter.SelectCommand = New SqlCommand("SELECT * from TagsWithIssues", conn)
        sqldataadapter.Fill(tagsWIssues)

        conn.Close()
        conn.Dispose()
        Return False
    End Function


    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        DataList1.DataBind()
    End Sub
    Protected Sub DataList1_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles DataList1.ItemDataBound

        Dim lblStatus As Label = CType(e.Item.FindControl("StatusLabel"), Label)
        Dim lblCurrentStatus As Label = CType(e.Item.FindControl("lblCurrentStatus"), Label)

        If e.Item.DataItem("Status") = 0 Then 'counting
            e.Item.BorderWidth = 4
            e.Item.BorderColor = Drawing.Color.White
            e.Item.ForeColor = Drawing.Color.Black
            lblStatus.Text = "Counting In Progress"

        ElseIf e.Item.DataItem("Status") = 1 Then 'clear reqd
            e.Item.BorderWidth = 4
            e.Item.BorderColor = Drawing.Color.Orange
            lblStatus.Text = "Clearing Requested"
            'lblStatus.Attributes.Add("class", "text-light")
            lblStatus.BackColor = Drawing.Color.Orange
            'lblCurrentStatus.Attributes.Add("class", "text-light")
            lblCurrentStatus.BackColor = Drawing.Color.Orange

        ElseIf e.Item.DataItem("Status") = 2 Then 'cleared
            e.Item.BorderWidth = 4
            e.Item.BorderColor = Drawing.Color.Gray
            e.Item.ForeColor = Drawing.Color.Black
            lblStatus.Text = "Cleared"
            lblStatus.BackColor = Drawing.Color.Gray
            lblCurrentStatus.BackColor = Drawing.Color.Gray

        ElseIf e.Item.DataItem("Status") = 3 Then 'call acct
            lblStatus.Text = "Call Accounting - Keying Not Yet Completed."
            e.Item.BorderWidth = 4
            e.Item.BorderColor = Drawing.Color.DarkRed
            e.Item.ForeColor = Drawing.Color.White
            ' e.Item.CssClass = "blinkingText"
            lblStatus.Attributes.Add("class", "text-light")
            lblStatus.BackColor = Drawing.Color.DarkRed
            lblCurrentStatus.Attributes.Add("class", "text-light")
            lblCurrentStatus.BackColor = Drawing.Color.DarkRed
            'populate error data here

            Dim gvIssues As GridView = CType(e.Item.FindControl("gvIssues"), GridView)
            Dim area As String = e.Item.DataItem("Area")

            Dim areaTagsWithIssues As DataView = tagsWIssues.DefaultView
            areaTagsWithIssues.RowFilter = "AreaID = " & area
            gvIssues.DataSource = areaTagsWithIssues
            gvIssues.DataBind()

        ElseIf e.Item.DataItem("Status") = 4 Then
            lblStatus.Text = "Keyed"
            'e.Item.BackColor = Drawing.Color.Blue 'keyed
            e.Item.BorderWidth = 4
            e.Item.BorderColor = Drawing.Color.Blue
            'e.Item.ForeColor = Drawing.Color.White
            lblStatus.Attributes.Add("class", "text-light")
            lblStatus.BackColor = Drawing.Color.Blue
            lblCurrentStatus.Attributes.Add("class", "text-light")
            lblCurrentStatus.BackColor = Drawing.Color.Blue

        ElseIf e.Item.DataItem("Status") = 5 Then
            e.Item.BorderWidth = 4
            lblStatus.Text = "1st Accounting Review"
            e.Item.BorderColor = Drawing.Color.LightCyan 'reveiw1
            e.Item.ForeColor = Drawing.Color.Black
            lblStatus.BackColor = Drawing.Color.LightCyan
            lblCurrentStatus.BackColor = Drawing.Color.LightCyan

        ElseIf e.Item.DataItem("Status") = 6 Then
            lblStatus.Text = "2nd Accounting Review"
            e.Item.BorderWidth = 4
            e.Item.BorderColor = Drawing.Color.LightBlue 'review2
            e.Item.ForeColor = Drawing.Color.Black
            lblStatus.BackColor = Drawing.Color.LightBlue
            lblCurrentStatus.BackColor = Drawing.Color.LightBlue


        ElseIf e.Item.DataItem("Status") = 8 Then 'report ready
            lblStatus.Text = "Report Ready In Andrew's Office"
            e.Item.BorderWidth = 4
            e.Item.BorderColor = Drawing.Color.Yellow
            e.Item.ForeColor = Drawing.Color.Black
            lblStatus.BackColor = Drawing.Color.Yellow
            lblCurrentStatus.BackColor = Drawing.Color.Yellow

        ElseIf e.Item.DataItem("Status") = 7 Then 'errors
            lblStatus.Text = "Ryan Has Questions, See him In Andrew's Office."
            e.Item.BorderWidth = 4
            e.Item.BorderColor = Drawing.Color.Red
            'e.Item.ForeColor = Drawing.Color.White
            lblStatus.Attributes.Add("class", "text-light")
            lblStatus.BackColor = Drawing.Color.Red
            lblCurrentStatus.Attributes.Add("class", "text-light")
            lblCurrentStatus.BackColor = Drawing.Color.Red


        ElseIf e.Item.DataItem("Status") = 9 Then 'done
            lblStatus.Text = "Area Complete"
            e.Item.BorderWidth = 4
            e.Item.BorderColor = Drawing.Color.Green
            lblStatus.Attributes.Add("class", "text-light")
            lblStatus.BackColor = Drawing.Color.Green
            lblCurrentStatus.Attributes.Add("class", "text-light")
            lblCurrentStatus.BackColor = Drawing.Color.Green
        End If

    End Sub

    Private Sub PhyInvByAuditor_Load(sender As Object, e As EventArgs) Handles Me.Load
        PopulateDataTables()
    End Sub
End Class
