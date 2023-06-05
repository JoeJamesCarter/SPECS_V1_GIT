Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient

Partial Class PDI_RepFeedbackRequest
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

    Protected Sub PDI_RepFeedbackRequest_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)

        Dim ItemID As String
        Dim ModelYear As String
        
        ItemID = Request.QueryString("ItemID")
        ModelYear = Request.QueryString("MY")

        lblModelYear.Text = ModelYear
        lblItemID.Text = ItemID

    End Sub

    
    Protected Sub btnNone_Click(sender As Object, e As EventArgs) Handles btnNone.Click
        Dim checked As Boolean = False   ' Set to True or False, as required.
        For i As Integer = 0 To cbReps.Items.Count - 1
            cbReps.SelectedIndex = -1
        Next
    End Sub

    Protected Sub btnAll_Click(sender As Object, e As EventArgs) Handles btnAll.Click
        Dim checked As Boolean = True   ' Set to True or False, as required.
        For i As Integer = 0 To cbReps.Items.Count - 1
            cbReps.Items(i).Selected = True
        Next
    End Sub

    Protected Sub btnReps_Click(sender As Object, e As EventArgs) Handles btnReps.Click
        Dim checked As Boolean = True   ' Set to True or False, as required.
        For i As Integer = 0 To 6
            cbReps.Items(i).Selected = True
        Next
    End Sub

    Protected Sub btnAssociates_Click(sender As Object, e As EventArgs) Handles btnAssociates.Click
        Dim checked As Boolean = True   ' Set to True or False, as required.
        For i As Integer = 7 To 10
            cbReps.Items(i).Selected = True
        Next
    End Sub

    Protected Sub btnSend_Click(sender As Object, e As EventArgs) Handles btnSend.Click
        Dim stationID As String = GlobalVariables.stationID
        Dim modelYear As String = lblModelYear.Text
        Dim itemID As String = lblItemID.Text

        Dim ideaReqdBy As String = DetailsView1.Rows(0).Cells(1).Text
        Dim category As String = DetailsView1.Rows(1).Cells(1).Text
        Dim series As String = DetailsView1.Rows(2).Cells(1).Text
        Dim desc As String = DetailsView1.Rows(3).Cells(1).Text
        Dim detailedDesc As String = DetailsView1.Rows(4).Cells(1).Text
        Dim additionalInfo As String = tbAdditionalnfo.Text

        Dim SmtpServer As New Net.Mail.SmtpClient
        Dim mail As New Net.Mail.MailMessage
        SmtpServer.Host = "elkhart.benningtonmarine.com"
        SmtpServer.UseDefaultCredentials = False


        If additionalInfo.length = 0 Then
            additionalInfo = ""
        End If

        Dim repString As String = ""

        Dim all As Integer = 0
        Dim repsOnly As Integer = 0
        Dim assocOnly As Integer = 0
        Dim onlySomeReps As Integer = 0
        'Rep Sent to Flags

        Dim BSPENCER As Integer = 0
        Dim DHAHN As Integer = 0
        Dim SBUFF As Integer = 0
        Dim JCALL As Integer = 0
        Dim JFIZER As Integer = 0
        Dim TPAYNE As Integer = 0
        Dim TCOOPER As Integer = 0
        Dim ACOOK As Integer = 0
        Dim AMEEKS As Integer = 0
        Dim DMARTIN As Integer = 0
        Dim SGIRTEN As Integer = 0

        For i As Integer = 0 To cbReps.Items.Count - 1

            If cbReps.Items(i).Selected = True Then
                If cbReps.Items(i).Text = "Bob Spencer" Then
                    BSPENCER = 1
                    repString += "BSPENCER"
                    mail.To.Add("mspencer@nexicom.net")
                ElseIf cbReps.Items(i).Text = "Daniel Hahn" Then
                    DHAHN = 1
                    repString += " DHAHN"
                    mail.To.Add("mdidanielh@gmail.com")
                ElseIf cbReps.Items(i).Text = "Susan Buff" Then
                    SBUFF = 1
                    repString += " SBUFF"
                    mail.To.Add("nauticalbuff2@ gmail.com")
                ElseIf cbReps.Items(i).Text = "Jason Call" Then
                    JCALL = 1
                    repString += " JCALL"
                    mail.To.Add("jcall@benningtonmarine.com")
                ElseIf cbReps.Items(i).Text = "Jon Fizer" Then
                    JFIZER = 1
                    repString += " JFIZER"
                    mail.To.Add("jonathanfizer@yahoo.com")
                ElseIf cbReps.Items(i).Text = "Tim Payne" Then
                    TPAYNE = 1
                    repString += " TPAYNE"
                    mail.To.Add("tpayne4m@gmail.com")
                ElseIf cbReps.Items(i).Text = "Tom Cooper" Then
                    TCOOPER = 1
                    repString += " TCOOPER"
                    mail.To.Add("tcooper@benningtonmarine.com")
                ElseIf cbReps.Items(i).Text = "Alex Cook" Then
                    ACOOK = 1
                    repString += " ACOOK"
                    mail.To.Add("cookalex1990@gmail.com")
                ElseIf cbReps.Items(i).Text = "Austin Meeks" Then
                    AMEEKS = 1
                    repString += " AMEEKS"
                    mail.To.Add("ameeks023@gmail.com")
                ElseIf cbReps.Items(i).Text = "Daniel Martin" Then
                    DMARTIN = 1
                    repString += " DMARTIN"
                    mail.To.Add("dmartin041@gmail.com")
                ElseIf cbReps.Items(i).Text = "Sam Girten" Then
                    SGIRTEN = 1
                    repString += " SGIRTEN"
                    mail.To.Add("sgirten@benningtonmarine.com")
                End If
            End If
        Next

        If BSPENCER = 1 And DHAHN = 1 And SBUFF = 1 And JCALL = 1 And JFIZER = 1 And TPAYNE = 1 And TCOOPER = 1 And ACOOK = 1 And AMEEKS = 1 And SGIRTEN = 1 And DMARTIN = 1 Then
            all = 1
        ElseIf BSPENCER = 1 And DHAHN = 1 And SBUFF = 1 And JCALL = 1 And JFIZER = 1 And TPAYNE = 1 And TCOOPER = 1 And ACOOK = 0 And AMEEKS = 0 And SGIRTEN = 0 And DMARTIN = 0 Then
            repsOnly = 1
        ElseIf BSPENCER = 0 And DHAHN = 0 And SBUFF = 0 And JCALL = 0 And JFIZER = 0 And TPAYNE = 0 And TCOOPER = 0 And ACOOK = 1 And AMEEKS = 1 And SGIRTEN = 1 And DMARTIN = 1 Then
            assocOnly = 1
        Else
            onlySomeReps = 1
        End If



        Dim conn As New MySqlConnection()
        Dim conn2 As New SqlConnection

        Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=PDI;password=SuSM-_we8C;persistsecurityinfo=True;database=PDI"
        Dim connstr2 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim TodaysDate As Date = Date.Now

        'Insert into mySQL for boat builder page to access

        conn.ConnectionString = connstr
        conn2.ConnectionString = connstr2

        Dim cmd As New MySqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New MySqlCommand

        cmd.Connection = conn
        cmd2.Connection = conn2
        cmd3.Connection = conn

        cmd.Parameters.AddWithValue("@Today", TodaysDate)
        cmd.Parameters.AddWithValue("@RequestedBy", stationID)
        cmd.Parameters.AddWithValue("@ModelYear", modelYear)
        cmd.Parameters.AddWithValue("@ProjectID", ItemID)
        cmd.Parameters.AddWithValue("@IdeaReqdBy", ideaReqdBy)
        cmd.Parameters.AddWithValue("@Category", category)
        cmd.Parameters.AddWithValue("@Series", series)
        cmd.Parameters.AddWithValue("@Desc", desc)
        cmd.Parameters.AddWithValue("@DetailedDesc", detailedDesc)
        cmd.Parameters.AddWithValue("@AdditionalInfo", additionalInfo)
        cmd.Parameters.AddWithValue("@BSPENCER", BSPENCER)
        cmd.Parameters.AddWithValue("@DHAHN", DHAHN)
        cmd.Parameters.AddWithValue("@SBUFF", SBUFF)
        cmd.Parameters.AddWithValue("@JCALL", JCALL)
        cmd.Parameters.AddWithValue("@JFIZER", JFIZER)
        cmd.Parameters.AddWithValue("@TPAYNE", TPAYNE)
        cmd.Parameters.AddWithValue("@TCOOPER", TCOOPER)
        cmd.Parameters.AddWithValue("@ACOOK", ACOOK)
        cmd.Parameters.AddWithValue("@AMEEKS", AMEEKS)
        cmd.Parameters.AddWithValue("@DMARTIN", DMARTIN)
        cmd.Parameters.AddWithValue("@SGIRTEN", SGIRTEN)

        cmd3.Parameters.AddWithValue("@ModelYear3", modelYear)
        cmd3.Parameters.AddWithValue("@ProjectID3", ItemID)


        cmd.CommandText = "Insert Into FeedbackRequests (ReqDate,ReqdBy,ModelYear,ProjectID,IdeaReqBy,Category,Series,InitialDescription,DetailedDescription,AdditionalInfo,BSPENCER,DHAHN,SBUFF,JCALL,JFIZER,TPAYNE,TCOOPER,ACOOK,AMEEKS,DMARTIN,SGIRTEN) VALUES (@Today, @RequestedBy, @ModelYear, @ProjectID, @IdeaReqdBy, @Category, @Series, @Desc, @DetailedDesc, @AdditionalInfo, @BSPENCER, @DHAHN, @SBUFF, @JCALL, @JFIZER, @TPAYNE, @TCOOPER, @ACOOK, @AMEEKS, @DMARTIN, @SGIRTEN)"
        cmd3.CommandText = "Insert Into RepVotes (ModelYear,ProjectID) VALUES (@ModelYear3, @ProjectID3)"

        Dim sentTo As String = ""

        If all = 1 Then
            sentTo = "ALL"
        ElseIf repsOnly = 1 Then
            sentTo = "REPS ONLY"
        ElseIf assocOnly = 1 Then
            sentTo = "ASSOC ONLY"
        Else
            sentTo = repString
        End If
        cmd2.Parameters.AddWithValue("@Today2", TodaysDate)
        cmd2.Parameters.AddWithValue("@ModelYear2", modelYear)
        cmd2.Parameters.AddWithValue("@ProjectID2", ItemID)

        Dim NoteToAdd As String = "Rep Feedback requested on " & TodaysDate.Date & ". Sent To " & sentTo & ". " & additionalInfo

        cmd2.Parameters.AddWithValue("@NoteToAdd", NoteToAdd)

        cmd2.CommandText = "Insert into ProductDesignIdeas_Notes (ModelYear, ProjectID, Note, NoteCreated) VALUES (@ModelYear2, @ProjectID2, @NoteToAdd, @Today2)"


        Try
            conn.Open()
            cmd.ExecuteNonQuery()
            Try
                cmd3.ExecuteNonQuery()
            Catch
            End Try

            conn.Close()

            conn2.Open()
            cmd2.ExecuteNonQuery()
            conn2.Close()

            'MesgBox("Request Sent Succesfully")

        Catch ex As Exception
            MesgBox("Error Sending - Tell Keri")
        End Try

            mail.From = New Net.Mail.MailAddress("tmeier@benningtonmarine.com")
            mail.To.Add("krimbaugh@benningtonmarine.com")
            mail.Subject = "Rep Feedback Requested"
            mail.Body = "Bennington has requested your feedback on a Development Idea. Please login to the boat builder (otherwise you will get an unauthorized message) and then visit https://boat-builder.benningtonmarine.com/product/client/order/standalone/5c6da343d4ecb379cf8f4763 to respond. Thank you.        Additional Info: " & additionalInfo & ""
            SmtpServer.Send(mail)
            MesgBox("Request Sent Succesfully")

    End Sub
End Class
