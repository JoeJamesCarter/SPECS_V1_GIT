Imports System.Data
Imports System.Data.SqlClient
Imports MySql.Data.MySqlClient
Imports System.IO


Partial Class PDI_RepIdeas
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub PDI_RepIdeas_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbModelYear.Text = "21"
    End Sub

    Protected Sub gvRepIdeas_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvRepIdeas.RowCommand

        If e.CommandName = "markasduplicate" Then

            Dim conn As New MySqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("PDI_ExternalConnectionString").ConnectionString
            Dim cmd As New MySqlCommand
            Dim ID As String = e.CommandArgument 'get the ideas autoid that is clicked

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.Parameters.AddWithValue("@ID", ID)

            cmd.CommandText = "Update RepIdeas Set DuplicateFlag = 1 Where AutoID = @ID"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvRepIdeas.DataBind()

        End If

        If e.CommandName = "addtoprojects" Then 'handles when the notes button is clicked

            Dim conn As New SqlConnection()
            Dim conn2 As New MySqlConnection

            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim connstr2 As String = ConfigurationManager.ConnectionStrings("PDI_ExternalConnectionString").ConnectionString

            Dim TodaysDate As Date = Date.Now

            conn.ConnectionString = connstr
            conn2.ConnectionString = connstr2

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New MySqlCommand

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn2

            Dim ID As String = e.CommandArgument 'get the row that is clicked

            Dim RequestedBy As String = gvRepIdeas.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim Series As String = gvRepIdeas.Rows(ID).Cells(1).Text
            Dim Category As String = gvRepIdeas.Rows(ID).Cells(2).Text

            Category = StrConv(Category, vbProperCase)

            Dim Idea As String = gvRepIdeas.Rows(ID).Cells(3).Text
            Dim DateSubmitted As String = gvRepIdeas.Rows(ID).Cells(4).Text
            Dim Image1 As Image = gvRepIdeas.Rows(ID).FindControl("image1")
            Dim Image2 As Image = gvRepIdeas.Rows(ID).FindControl("image2")
            Dim Image3 As Image = gvRepIdeas.Rows(ID).FindControl("image3")
            Dim IdeaID As String = gvRepIdeas.Rows(ID).Cells(10).Text

            Dim URL1 As String = Image1.ImageUrl
            Dim URL2 As String = Image2.ImageUrl
            Dim URL3 As String = Image3.ImageUrl

            'Write it, get the id of it, then upload its images, the set ProjectedCreateFlag = 1, then refresh the grid.

            Dim ModelYear As String = tbModelYear.Text


            cmd.Parameters.AddWithValue("@ModelYear", ModelYear)
            cmd.Parameters.AddWithValue("@ReqBy", RequestedBy)
            cmd.Parameters.AddWithValue("@ReqDate", DateSubmitted)
            cmd.Parameters.AddWithValue("@Category", Category)
            cmd.Parameters.AddWithValue("@Series", Series)
            cmd.Parameters.AddWithValue("@InitDesc", Idea)
            cmd.Parameters.AddWithValue("@Image1", URL1)
            cmd.Parameters.AddWithValue("@Image2", URL2)
            cmd.Parameters.AddWithValue("@Image3", URL3)

            cmd2.Parameters.AddWithValue("@ModelYear2", ModelYear)
            cmd2.Parameters.AddWithValue("@ReqBy2", RequestedBy)
            cmd2.Parameters.AddWithValue("@ReqDate2", DateSubmitted)
            cmd2.Parameters.AddWithValue("@Category2", Category)
            cmd2.Parameters.AddWithValue("@Series2", Series)
            cmd2.Parameters.AddWithValue("@InitDesc2", Idea)

            cmd3.Parameters.AddWithValue("@AutoID", IdeaID)

            cmd.CommandText = "Insert Into ProductDesignIdeas (ModelYear,RequestedBy,RequestedDate,Category,Series,InitialDescription, Image1URL, Image2URL, Image3URL)VALUES (@ModelYear, @ReqBy, @ReqDate, @Category, @Series, @InitDesc, @Image1, @Image2, @Image3)"
            cmd2.CommandText = "Select AutoID From ProductDesignIdeas Where ModelYear = @ModelYear2 and RequestedBy = @ReqBy2 and RequestedDate = @ReqDate2 and Category = @Category2 and Series = @Series2 and InitialDescription = @InitDesc2"
            cmd3.CommandText = "Update RepIdeas Set ProjectCreatedFlag = 1 Where AutoID = @AutoID"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            conn2.Open()
            cmd3.ExecuteNonQuery()
            conn2.Close()

            gvRepIdeas.DataBind()

        End If
    End Sub
End Class
