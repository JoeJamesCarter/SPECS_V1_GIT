Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class menu
    Inherits System.Web.UI.Page
    Public siteLinks As New DataTable
    Public siteCategories As New DataTable


    Private Sub menu_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim sqldataadapter1 As New SqlDataAdapter
        Dim sqldataadapter2 As New SqlDataAdapter
        Dim conn1 As New SqlConnection
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim phGreenlights As PlaceHolder = DirectCast(sender.FindControl("phGreenlights"), PlaceHolder)

        conn1.ConnectionString = connstr1
        conn1.Open()
        sqldataadapter1.SelectCommand = New SqlCommand("Select * FROM Links order by Category, Name", conn1)
        sqldataadapter1.Fill(siteLinks)

        sqldataadapter1.SelectCommand = New SqlCommand("Select DISTINCT(CATEGORY) FROM Links order by Category", conn1)
        sqldataadapter1.Fill(siteCategories)


        conn1.Close()
        conn1.Dispose()

        For Each cat In siteCategories.Rows

            'Button method
            Dim lblCategory As New Label
            lblCategory.Text = cat("Category")
            lblCategory.CssClass = "categoryClass"
            phGreenlights.Controls.Add(lblCategory)
            phGreenlights.Controls.Add(New LiteralControl("<br />"))

            'DropDown List Method
            'Dim ddlCategory As New DropDownList
            'ddlCategory.ID = cat("Category")
            'ddlCategory.AutoPostBack = True
            'ddlCategory.Items.Insert(0, New ListItem("")) 'add one blank

            'Dim goButton As New Button
            'goButton.Text = "Go"
            'goButton.ID = "Go" + cat("Category")
            'goButton.OnClientClick = "this.options[this.selectedIndex].value && (window.location = this.options[this.selectedIndex].value);"

            For Each link In siteLinks.Rows

                If link("Category") = cat("Category") Then
                    Dim linkCategory As String = link("Category")
                    Dim linkBtn As New Button
                    linkBtn.Text = link("Name")
                    linkBtn.ID = link("Name")
                    linkBtn.CssClass = link("AccessLevel")
                    linkBtn.PostBackUrl = link("URL")
                    linkBtn.ToolTip = link("Description")



                    'drop down list
                    'ddlCategory.Items.Add(New ListItem(link("Name"), link("URL")))

                    phGreenlights.Controls.Add(linkBtn)
                End If

                'phGreenlights.Controls.Add(ddlCategory)
                'phGreenlights.Controls.Add(New LiteralControl("   "))
                'goButton.PostBackUrl = ddlCategory.SelectedValue


                'phGreenlights.Controls.Add(goButton)



                'phGreenlights.Controls.Add(linkBtn)

            Next
            phGreenlights.Controls.Add(New LiteralControl("<br />"))
        Next




    End Sub
End Class
