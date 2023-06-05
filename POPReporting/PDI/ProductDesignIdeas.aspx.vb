Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient


Partial Class PDI_ProductDesignIdeas
    Inherits System.Web.UI.Page
    'Public extRepFeedback As New DataTable
    'Public repVotes As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    '    Protected Sub PDI_ProductDesignIdeas_Load(sender As Object, e As EventArgs) Handles Me.Load
    '        PopulateDataTables()

    '        Dim conn As New MySqlConnection()
    '        Dim connstr As String = ConfigurationManager.ConnectionStrings("PDI_ExternalConnectionString").ConnectionString
    '        Dim cmd As New MySqlCommand

    '        conn.ConnectionString = connstr
    '        cmd.Connection = conn

    '        cmd.CommandText = "Select Count(AutoID) From RepIdeas Where ProjectCreatedFlag = 0 and (DuplicateFlag = 0)"

    '        conn.Open()

    '        lblIdeaCount.Text = cmd.ExecuteScalar
    '        conn.Close()

    '    End Sub

    '    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
    '        Dim mysqldataadapter As New MySqlDataAdapter
    '        Dim mysqldataadapter2 As New MySqlDataAdapter

    '        Dim conn As New MySqlConnection()
    '        Dim connstr As String = ConfigurationManager.ConnectionStrings("PDI_ExternalConnectionString").ConnectionString

    '        conn.ConnectionString = connstr

    '        conn.Open()

    '        mysqldataadapter.SelectCommand = New MySqlCommand("Select ModelYear, ProjectID, RepName as Rep,RepComment as Comment,Date_FORMAT(RepCommentDate, '%m/%d/%y') as Date FROM RepFeedback", conn)
    '        mysqldataadapter.Fill(extRepFeedback)

    '        mysqldataadapter2.SelectCommand = New MySqlCommand("Select ModelYear,ProjectID,BSPENCER_VOTE,DHAHN_VOTE, DMARTIN_VOTE, JCALL_VOTE, JFIZER_VOTE, TPAYNE_VOTE, TCOOPER_VOTE, AMEEKS_VOTE, SGIRTEN_VOTE, SBUFF_VOTE FROM RepVotes", conn)
    '        mysqldataadapter2.Fill(repVotes)

    '        conn.Close()
    '        conn.Dispose()
    '        Return False

    '    End Function
    '    Protected Sub gvProjectIdeas_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvProjectIdeas.RowDataBound
    '        If e.Row.RowType = DataControlRowType.DataRow Then
    '            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsMeetingNotes"), SqlDataSource)

    '            Dim modelyear As String = e.Row.Cells(0).Text
    '            Dim projectId As String = e.Row.Cells(1).Text
    '            Dim placeholder1 As PlaceHolder = CType(e.Row.FindControl("PlaceHolder1"), PlaceHolder)

    '            Dim feedbackResult() As DataRow = extRepFeedback.Select("ModelYear =  '" & modelyear & "' AND ProjectID = '" & projectId & "'")

    '            Try
    '                t.SelectParameters(0).DefaultValue = modelyear
    '                t.SelectParameters(1).DefaultValue = projectId

    '                'u.SelectParameters(0).DefaultValue = modelyear
    '                'u.SelectParameters(1).DefaultValue = projectId

    '                'MesgBox(modelyear)
    '                'MesgBox(projectId)


    '                If feedbackResult.Length > 0 Then

    '                    Dim html As New StringBuilder()

    '                    'Table start.
    '                    html.Append("<table class='newStyle1' cellspacing='0' border='1' style='width:500px;border-collapse:collapse;'><tbody>")

    '                    'Building the Header row.
    '                    'html.Append("<tr>")
    '                    'For Each column As DataColumn In extRepFeedback.Columns
    '                    'If column.ColumnName = "Rep" Or column.ColumnName = "Comment" Or column.ColumnName = "Date" Then
    '                    'html.Append("<th>")
    '                    'html.Append(column.ColumnName)
    '                    'html.Append("</th>")
    '                    'End If

    '                    'Next
    '                    'html.Append("</tr>")

    '                    'Building the Data rows.
    '                    For Each row As DataRow In extRepFeedback.Rows
    '                        If row("ModelYear") = modelyear And row("ProjectID") = projectId Then

    '                            html.Append("<tr>")
    '                            For Each column As DataColumn In extRepFeedback.Columns
    '                                If column.ColumnName = "Rep" Or column.ColumnName = "Comment" Or column.ColumnName = "Date" Then
    '                                    html.Append("<td>")
    '                                    html.Append(row(column.ColumnName))
    '                                    html.Append("</td>")
    '                                End If
    '                            Next
    '                            html.Append("</tr>")

    '                        End If
    '                    Next
    '                    'Table end.
    '                    html.Append("</table>")
    '                    'Append the HTML string to Placeholder.
    '                    placeholder1.Controls.Add(New Literal() With { _
    '                       .Text = html.ToString() _
    '                     })
    '                End If

    '            Catch
    '            End Try



    '            Dim totalAgree As Integer = 0
    '            Dim totalNeutral As Integer = 0
    '            Dim totalDisagree As Integer = 0
    '            Try
    '                Dim votes() As DataRow = repVotes.Select("ModelYear =  '" & modelyear & "' AND ProjectID = '" & projectId & "'")
    '                If votes.Length > 0 Then


    '                    Dim lblAgree As Label = CType(e.Row.FindControl("lblAgree"), Label)
    '                    Dim lblDisagree As Label = CType(e.Row.FindControl("lblDisagree"), Label)
    '                    Dim lblNeutral As Label = CType(e.Row.FindControl("lblNeutral"), Label)

    '                    Dim repsThatAgree As String = ""
    '                    Dim repsNeutral As String = ""
    '                    Dim repsThatDisagree As String = ""

    '                    'MesgBox(votes(1).Item("TCOOPER_VOTE"))
    '                    If votes(0).Item("DMARTIN_VOTE").ToString = "" Then

    '                    ElseIf votes(0).Item("DMARTIN_VOTE") = "0" Then
    '                        totalNeutral = totalNeutral + 1
    '                        repsNeutral = repsNeutral & " DMARTIN"
    '                        lblNeutral.ToolTip = repsNeutral
    '                        lblNeutral.Text = totalNeutral.ToString
    '                    ElseIf votes(0).Item("DMARTIN_VOTE") = "1" Then
    '                        totalDisagree = totalDisagree + 1
    '                        repsThatDisagree = repsThatDisagree & " DMARTIN"
    '                        lblDisagree.ToolTip = repsThatDisagree
    '                        lblDisagree.Text = totalDisagree.ToString
    '                    ElseIf votes(0).Item("DMARTIN_VOTE").ToString = "2" Then
    '                        totalAgree = totalAgree + 1
    '                        repsThatAgree = repsThatAgree & " DMARTIN"
    '                        lblAgree.ToolTip = repsThatAgree
    '                        lblAgree.Text = totalAgree.ToString

    '                    End If

    '                    If votes(0).Item("BSPENCER_VOTE").ToString = "" Then

    '                    ElseIf votes(0).Item("BSPENCER_VOTE") = "0" Then
    '                        totalNeutral = totalNeutral + 1
    '                        repsNeutral = repsNeutral & " BSPENCER"
    '                        lblNeutral.ToolTip = repsNeutral
    '                        lblNeutral.Text = totalNeutral.ToString
    '                    ElseIf votes(0).Item("BSPENCER_VOTE") = "1" Then
    '                        totalDisagree = totalDisagree + 1
    '                        repsThatDisagree = repsThatDisagree & " BPSPENCER"
    '                        lblDisagree.ToolTip = repsThatDisagree
    '                        lblDisagree.Text = totalDisagree.ToString
    '                    ElseIf votes(0).Item("BSPENCER_VOTE").ToString = "2" Then
    '                        totalAgree = totalAgree + 1
    '                        repsThatAgree = repsThatAgree & " BSPENCER"
    '                        lblAgree.ToolTip = repsThatAgree
    '                        lblAgree.Text = totalAgree.ToString

    '                    End If

    '                    If votes(0).Item("DHAHN_VOTE").ToString = "" Then
    '                    ElseIf votes(0).Item("DHAHN_VOTE") = 0 Then
    '                        totalNeutral = totalNeutral + 1
    '                        repsNeutral = repsNeutral & " DHAHN"
    '                        lblNeutral.ToolTip = repsNeutral
    '                        lblNeutral.Text = totalNeutral.ToString
    '                    ElseIf votes(0).Item("DHAHN_VOTE") = 1 Then
    '                        totalDisagree = totalDisagree + 1
    '                        repsThatDisagree = repsThatDisagree & " DHAHN"
    '                        lblDisagree.ToolTip = repsThatDisagree
    '                        lblDisagree.Text = totalDisagree.ToString
    '                    ElseIf votes(0).Item("DHAHN_VOTE").ToString = 2 Then
    '                        repsThatAgree = repsThatAgree & " DHAHN"
    '                        lblAgree.ToolTip = repsThatAgree
    '                        totalAgree = totalAgree + 1
    '                        lblAgree.Text = totalAgree.ToString
    '                    End If

    '                    If votes(0).Item("JCALL_VOTE").ToString = "" Then
    '                    ElseIf votes(0).Item("JCALL_VOTE") = 0 Then
    '                        totalNeutral = totalNeutral + 1
    '                        repsNeutral = repsNeutral & " JCALL"
    '                        lblNeutral.ToolTip = repsNeutral
    '                        lblNeutral.Text = totalNeutral.ToString
    '                    ElseIf votes(0).Item("JCALL_VOTE") = 1 Then
    '                        totalDisagree = totalDisagree + 1
    '                        repsThatDisagree = repsThatDisagree & " JCALL"
    '                        lblDisagree.ToolTip = repsThatDisagree
    '                        lblDisagree.Text = totalDisagree.ToString
    '                    ElseIf votes(0).Item("JCALL_VOTE").ToString = 2 Then
    '                        totalAgree = totalAgree + 1
    '                        repsThatAgree = repsThatAgree & " JCALL"
    '                        lblAgree.ToolTip = repsThatAgree
    '                        lblAgree.Text = totalAgree.ToString
    '                    End If

    '                    If votes(0).Item("JFIZER_VOTE").ToString = "" Then
    '                    ElseIf votes(0).Item("JFIZER_VOTE") = 0 Then
    '                        totalNeutral = totalNeutral + 1
    '                        repsNeutral = repsNeutral & " JFIZER"
    '                        lblNeutral.ToolTip = repsNeutral
    '                        lblNeutral.Text = totalNeutral.ToString
    '                    ElseIf votes(0).Item("JFIZER_VOTE") = 1 Then
    '                        totalDisagree = totalDisagree + 1
    '                        repsThatDisagree = repsThatDisagree & " JFIZER"
    '                        lblDisagree.ToolTip = repsThatDisagree
    '                        lblDisagree.Text = totalDisagree.ToString
    '                    ElseIf votes(0).Item("JFIZER_VOTE").ToString = 2 Then
    '                        repsThatAgree = repsThatAgree & " JFIZER"
    '                        lblAgree.ToolTip = repsThatAgree
    '                        totalAgree = totalAgree + 1
    '                        lblAgree.Text = totalAgree.ToString
    '                    End If

    '                    If votes(0).Item("TPAYNE_VOTE").ToString = "" Then
    '                    ElseIf votes(0).Item("TPAYNE_VOTE") = 0 Then
    '                        totalNeutral = totalNeutral + 1
    '                        repsNeutral = repsNeutral & " TPAYNE"
    '                        lblNeutral.ToolTip = repsNeutral
    '                        lblNeutral.Text = totalNeutral.ToString
    '                    ElseIf votes(0).Item("TPAYNE_VOTE") = 1 Then
    '                        totalDisagree = totalDisagree + 1
    '                        repsThatDisagree = repsThatDisagree & " TPAYNE"
    '                        lblDisagree.ToolTip = repsThatDisagree
    '                        lblDisagree.Text = totalDisagree.ToString
    '                    ElseIf votes(0).Item("TPAYNE_VOTE").ToString = 2 Then
    '                        totalAgree = totalAgree + 1
    '                        repsThatAgree = repsThatAgree & " TPAYNE"
    '                        lblAgree.ToolTip = repsThatAgree
    '                        lblAgree.Text = totalAgree.ToString
    '                    End If

    '                    If votes(0).Item("TCOOPER_VOTE").ToString = "" Then
    '                    ElseIf votes(0).Item("TCOOPER_VOTE") = 0 Then
    '                        totalNeutral = totalNeutral + 1
    '                        repsNeutral = repsNeutral & " TCOOPER"
    '                        lblNeutral.ToolTip = repsNeutral
    '                        lblNeutral.Text = totalNeutral.ToString
    '                    ElseIf votes(0).Item("TCOOPER_VOTE") = 1 Then
    '                        totalDisagree = totalDisagree + 1
    '                        repsThatDisagree = repsThatDisagree & " TCOOPER"
    '                        lblDisagree.ToolTip = repsThatDisagree
    '                        lblDisagree.Text = totalDisagree.ToString
    '                    ElseIf votes(0).Item("TCOOPER_VOTE").ToString = 2 Then
    '                        totalAgree = totalAgree + 1
    '                        repsThatAgree = repsThatAgree & " TCOOPER"
    '                        lblAgree.ToolTip = repsThatAgree
    '                        lblAgree.Text = totalAgree.ToString
    '                    End If

    '                    If votes(0).Item("AMEEKS_VOTE").ToString = "" Then
    '                    ElseIf votes(0).Item("AMEEKS_VOTE") = 0 Then
    '                        totalNeutral = totalNeutral + 1
    '                        repsNeutral = repsNeutral & " AMEEKS"
    '                        lblNeutral.ToolTip = repsNeutral
    '                        lblNeutral.Text = totalNeutral.ToString
    '                    ElseIf votes(0).Item("AMEEKS_VOTE") = 1 Then
    '                        totalDisagree = totalDisagree + 1
    '                        repsThatDisagree = repsThatDisagree & " AMEEKS"
    '                        lblDisagree.ToolTip = repsThatDisagree
    '                        lblDisagree.Text = totalDisagree.ToString
    '                    ElseIf votes(0).Item("AMEEKS_VOTE").ToString = 2 Then
    '                        totalAgree = totalAgree + 1
    '                        repsThatAgree = repsThatAgree & " AMEEKS"
    '                        lblAgree.ToolTip = repsThatAgree
    '                        lblAgree.Text = totalAgree.ToString
    '                    End If

    '                    If votes(0).Item("SGIRTEN_VOTE").ToString = "" Then
    '                    ElseIf votes(0).Item("SGIRTEN_VOTE") = 0 Then
    '                        totalNeutral = totalNeutral + 1
    '                        repsNeutral = repsNeutral & " SGIRTEN"
    '                        lblNeutral.ToolTip = repsNeutral
    '                        lblNeutral.Text = totalNeutral.ToString
    '                    ElseIf votes(0).Item("SGIRTEN_VOTE") = 1 Then
    '                        totalDisagree = totalDisagree + 1
    '                        repsThatDisagree = repsThatDisagree & " SGIRTEN"
    '                        lblDisagree.ToolTip = repsThatDisagree
    '                        lblDisagree.Text = totalDisagree.ToString
    '                    ElseIf votes(0).Item("SGIRTEN_VOTE").ToString = 2 Then
    '                        totalAgree = totalAgree + 1
    '                        repsThatAgree = repsThatAgree & " SGIRTEN"
    '                        lblAgree.ToolTip = repsThatAgree
    '                        lblAgree.Text = totalAgree.ToString
    '                    End If

    '                    If votes(0).Item("SBUFF_VOTE").ToString = "" Then
    '                    ElseIf votes(0).Item("SBUFF_VOTE") = 0 Then
    '                        totalNeutral = totalNeutral + 1
    '                        repsNeutral = repsNeutral & " SBUFF"
    '                        lblNeutral.ToolTip = repsNeutral
    '                        lblNeutral.Text = totalNeutral.ToString
    '                    ElseIf votes(0).Item("SBUFF_VOTE") = 1 Then
    '                        totalDisagree = totalDisagree + 1
    '                        repsThatDisagree = repsThatDisagree & " SBUFF"
    '                        lblDisagree.ToolTip = repsThatDisagree
    '                        lblDisagree.Text = totalDisagree.ToString
    '                    ElseIf votes(0).Item("SBUFF_VOTE").ToString = 2 Then
    '                        totalAgree = totalAgree + 1
    '                        repsThatAgree = repsThatAgree & " SBUFF"
    '                        lblAgree.ToolTip = repsThatAgree
    '                        lblAgree.Text = totalAgree.ToString
    '                    End If

    '                End If

    '            Catch ex As Exception

    '            End Try
    '        End If

    '        'Tally Votes'



    '    End Sub

    '    Protected Sub gvProjectIdeas_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvProjectIdeas.RowCommand
    '        If e.CommandName = "EditStatus" Then
    '            'This code is for the update button

    '            Dim Key As String = e.CommandArgument 'get the itemID to edit
    '            Dim ModelYear As Integer = gvProjectIdeas.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
    '            Dim ItemID As String = gvProjectIdeas.Rows(Key).Cells(1).Text
    '            Dim url As String = "./EditProjectStatus.aspx?MY=" & ModelYear & "&ItemID=" & ItemID

    '            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,toolbars=0');popUpObj.focus()}</script>")
    '            gvProjectIdeas.DataBind()
    '        End If

    '        If e.CommandName = "RequestRepFeedback" Then

    '            Dim Key As String = e.CommandArgument 'get the itemID to edit
    '            Dim ModelYear As Integer = gvProjectIdeas.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
    '            Dim ItemID As String = gvProjectIdeas.Rows(Key).Cells(1).Text
    '            Dim url As String = "./RepFeedbackRequest.aspx?MY=" & ModelYear & "&ItemID=" & ItemID

    '            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=1400,height=1000,toolbars=0');popUpObj.focus()}</script>")
    '            'gvProjectIdeas.DataBind()

    '        End If


    '    End Sub


    '    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
    '        gvProjectIdeas.DataBind()
    '    End Sub


    '    Protected Sub ddlApprovalStatus_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

    '        Dim ddlApprovalStatus As DropDownList = TryCast(sender, DropDownList)

    '        If ddlApprovalStatus Is Nothing Then
    '            Return
    '        End If

    '        Dim gvr As GridViewRow = TryCast(ddlApprovalStatus.NamingContainer, GridViewRow)

    '        If gvr Is Nothing Then
    '            'MsgBox("nothing")
    '            Return
    '        End If


    '        Dim modelyear As String = gvProjectIdeas.DataKeys(gvr.RowIndex)("ModelYear").ToString()
    '        Dim projectid As String = gvProjectIdeas.DataKeys(gvr.RowIndex)("AutoID").ToString()
    '        Dim approval As String = ddlApprovalStatus.SelectedValue

    '        'MesgBox(modelyear)
    '        'MesgBox(projectid)
    '        'MesgBox(approval)

    '        Dim conn As New SqlConnection()
    '        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
    '        Dim TodaysDate As Date = Date.Now

    '        conn.ConnectionString = connstr
    '        Dim cmd As New SqlCommand
    '        cmd.Connection = conn

    '        cmd.Parameters.AddWithValue("approval", approval)
    '        cmd.Parameters.AddWithValue("modelyear", modelyear)
    '        cmd.Parameters.AddWithValue("projectid", projectid)
    '        cmd.Parameters.AddWithValue("today", TodaysDate)

    '        cmd.CommandText = "Update ProductDesignIdeas Set ApprovalStatus = @approval, ApprovalStatusDate = @today where ModelYear = @modelyear and AutoID = @projectid"
    '        conn.Open()
    '        cmd.ExecuteNonQuery()
    '        conn.Close()


    '    End Sub

    '    Protected Sub ddlProjectStatus_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

    '        Dim ddlProjectStatus As DropDownList = TryCast(sender, DropDownList)

    '        If ddlProjectStatus Is Nothing Then
    '            Return
    '        End If

    '        Dim gvr As GridViewRow = TryCast(ddlProjectStatus.NamingContainer, GridViewRow)

    '        If gvr Is Nothing Then
    '            'MsgBox("nothing")
    '            Return
    '        End If


    '        Dim modelyear As String = gvProjectIdeas.DataKeys(gvr.RowIndex)("ModelYear").ToString()
    '        Dim projectid As String = gvProjectIdeas.DataKeys(gvr.RowIndex)("AutoID").ToString()
    '        Dim projectstatus As String = ddlProjectStatus.SelectedValue

    '        'MesgBox(modelyear)
    '        'MesgBox(projectid)
    '        'MesgBox(approval)

    '        Dim conn As New SqlConnection()
    '        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
    '        Dim TodaysDate As Date = Date.Now

    '        conn.ConnectionString = connstr
    '        Dim cmd As New SqlCommand
    '        cmd.Connection = conn

    '        cmd.Parameters.AddWithValue("projectstatus", projectstatus)
    '        cmd.Parameters.AddWithValue("modelyear", modelyear)
    '        cmd.Parameters.AddWithValue("projectid", projectid)
    '        cmd.Parameters.AddWithValue("today", TodaysDate)

    '        cmd.CommandText = "Update ProductDesignIdeas Set ProjectStatus = @projectstatus, ProjectStatusDate = @today where ModelYear = @modelyear and AutoID = @projectid"
    '        conn.Open()
    '        cmd.ExecuteNonQuery()
    '        conn.Close()


    '    End Sub

    '    Protected Sub ddlStrategicPriority_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

    '        Dim ddlStrategicPriority As DropDownList = TryCast(sender, DropDownList)

    '        If ddlStrategicPriority Is Nothing Then
    '            Return
    '        End If

    '        Dim gvr As GridViewRow = TryCast(ddlStrategicPriority.NamingContainer, GridViewRow)

    '        If gvr Is Nothing Then
    '            'MsgBox("nothing")
    '            Return
    '        End If

    '        Dim modelyear As String = gvProjectIdeas.DataKeys(gvr.RowIndex)("ModelYear").ToString()
    '        Dim projectid As String = gvProjectIdeas.DataKeys(gvr.RowIndex)("AutoID").ToString()
    '        Dim strategicpriority As String = ddlStrategicPriority.SelectedValue

    '        'MesgBox(modelyear)
    '        'MesgBox(projectid)
    '        'MesgBox(approval)

    '        Dim conn As New SqlConnection()
    '        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
    '        Dim TodaysDate As Date = Date.Now

    '        conn.ConnectionString = connstr
    '        Dim cmd As New SqlCommand
    '        cmd.Connection = conn

    '        cmd.Parameters.AddWithValue("strategicpriority", strategicpriority)
    '        cmd.Parameters.AddWithValue("modelyear", modelyear)
    '        cmd.Parameters.AddWithValue("projectid", projectid)
    '        cmd.Parameters.AddWithValue("today", TodaysDate)

    '        cmd.CommandText = "Update ProductDesignIdeas Set StrategicPriority = @strategicpriority, StrategicPriorityDate = @today where ModelYear = @modelyear and AutoID = @projectid"
    '        conn.Open()
    '        cmd.ExecuteNonQuery()
    '        conn.Close()


    '    End Sub

    '    Protected Sub ddlSalesPriority_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

    '        Dim ddlSalesPriority As DropDownList = TryCast(sender, DropDownList)

    '        If ddlSalesPriority Is Nothing Then
    '            Return
    '        End If

    '        Dim gvr As GridViewRow = TryCast(ddlSalesPriority.NamingContainer, GridViewRow)

    '        If gvr Is Nothing Then
    '            'MsgBox("nothing")
    '            Return
    '        End If

    '        Dim modelyear As String = gvProjectIdeas.DataKeys(gvr.RowIndex)("ModelYear").ToString()
    '        Dim projectid As String = gvProjectIdeas.DataKeys(gvr.RowIndex)("AutoID").ToString()
    '        Dim salespriority As String = ddlSalesPriority.SelectedValue

    '        'MesgBox(modelyear)
    '        'MesgBox(projectid)
    '        'MesgBox(approval)

    '        Dim conn As New SqlConnection()
    '        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
    '        Dim TodaysDate As Date = Date.Now

    '        conn.ConnectionString = connstr
    '        Dim cmd As New SqlCommand
    '        cmd.Connection = conn

    '        cmd.Parameters.AddWithValue("salespriority", salespriority)
    '        cmd.Parameters.AddWithValue("modelyear", modelyear)
    '        cmd.Parameters.AddWithValue("projectid", projectid)
    '        cmd.Parameters.AddWithValue("today", TodaysDate)

    '        cmd.CommandText = "Update ProductDesignIdeas Set SalesPriority = @salespriority, SalesPriorityDate = @today where ModelYear = @modelyear and AutoID = @projectid"
    '        conn.Open()
    '        cmd.ExecuteNonQuery()
    '        conn.Close()


    '    End Sub

    '    Protected Sub ddlEngActiveStatus_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

    '        Dim ddlEngActiveStatus As DropDownList = TryCast(sender, DropDownList)

    '        If ddlEngActiveStatus Is Nothing Then
    '            Return
    '        End If

    '        Dim gvr As GridViewRow = TryCast(ddlEngActiveStatus.NamingContainer, GridViewRow)

    '        If gvr Is Nothing Then
    '            'MsgBox("nothing")
    '            Return
    '        End If

    '        Dim modelyear As String = gvProjectIdeas.DataKeys(gvr.RowIndex)("ModelYear").ToString()
    '        Dim projectid As String = gvProjectIdeas.DataKeys(gvr.RowIndex)("AutoID").ToString()
    '        Dim engactivestatus As String = ddlEngActiveStatus.SelectedValue

    '        'MesgBox(modelyear)
    '        'MesgBox(projectid)
    '        'MesgBox(approval)

    '        Dim conn As New SqlConnection()
    '        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
    '        Dim TodaysDate As Date = Date.Now

    '        conn.ConnectionString = connstr
    '        Dim cmd As New SqlCommand
    '        cmd.Connection = conn

    '        cmd.Parameters.AddWithValue("engactivestatus", engactivestatus)
    '        cmd.Parameters.AddWithValue("modelyear", modelyear)
    '        cmd.Parameters.AddWithValue("projectid", projectid)
    '        cmd.Parameters.AddWithValue("today", TodaysDate)

    '        cmd.CommandText = "Update ProductDesignIdeas Set EngActiveFlag = @engactivestatus, EngActiveFlagDate = @today where ModelYear = @modelyear and AutoID = @projectid"
    '        conn.Open()
    '        cmd.ExecuteNonQuery()
    '        conn.Close()


    '    End Sub


    '    Protected Sub btnAdd_Click(sender As Object, e As EventArgs) Handles btnAdd.Click
    '        Dim url As String = "./AddProductIdea.aspx"
    '        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=1400,height=1000,toolbars=0');popUpObj.focus()}</script>")
    '        gvProjectIdeas.DataBind()
    '    End Sub


    '    Protected Sub btnRepIdeas_Click(sender As Object, e As EventArgs) Handles btnRepIdeas.Click
    '        Dim url As String = "./RepIdeas.aspx"
    '        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=1400,height=1000,toolbars=0');popUpObj.focus()}</script>")
    '    End Sub

    '    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
    '        tbProjectID.Text = ""
    '    End Sub

    '    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
    '        Dim url As String = "./ProductDesignIdeasHistory.aspx"
    '        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,toolbars=0');popUpObj.focus()}</script>")
    '    End Sub
End Class
