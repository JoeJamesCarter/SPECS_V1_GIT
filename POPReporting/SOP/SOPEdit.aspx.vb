Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class SOP_SOPEdit
    Inherits System.Web.UI.Page

    Public sopData As New DataTable
    Public allTools As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not ispostback Then
            addnewtools.Visible = "false"
            dvKit.Visible = "false"
        End If


        Dim SOPNo As String
        SOPNo = Request.QueryString("SOPNo")
        lblSOPNo.Text = SOPNo
        gvKit.DataBind()

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("SOPConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim sqldataadapter As New SqlDataAdapter
        sqldataadapter.SelectCommand = New SqlCommand("Select * from SOP_Log where SOP_ID =  '" & SOPNo & "'", conn)
        sqldataadapter.Fill(sopData)


        Dim sqldataadapter1 As New SqlDataAdapter
        sqldataadapter1.SelectCommand = New SqlCommand("Select * from SOP_ToolsList order by ToolDesc asc ", conn)
        sqldataadapter1.Fill(allTools)


        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd2.Connection = conn

        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Select Max(ItemID) from SOP_KitContents where SOP_ID =  '" & SOPNo & "'"
        cmd2.CommandText = "Select ToolsRequired from SOP_ToolsRequired where SOP_ID =  '" & SOPNo & "'"

        conn.Open()
        Try
            Dim tbItemID As TextBox = DirectCast(dvKit.FindControl("tbItemID"), TextBox)
            Dim nextItemId As Integer = cmd.ExecuteScalar + 1
            tbItemID.Text = nextItemId.ToString

        Catch ex As Exception

        End Try

        Dim toolsrequiredList As String = cmd2.ExecuteScalar
        Dim toolsrequired As String() = toolsrequiredList.Split(New Char() {","c})
        conn.Close()

        lblModelYear.Text = sopData(0)(1).ToString
        lblSeries.Text = sopData(0)(2).ToString
        lblModel.Text = sopData(0)(3).ToString
        lblSeriesModel.Text = sopData(0)(4).ToString
        lblDrawingNo.Text = sopData(0)(5).ToString
        lblDescription.Text = sopData(0)(6).ToString
        lblPartNo.Text = sopData(0)(7).ToString

        If Not IsPostBack Then
            cbTools.DataBind()
            cbSupplies.DataBind()
        End If

        For Each tool In toolsrequired
            Dim toolResult() As DataRow = allTools.Select("SOP_ToolID =  '" & tool & "'")
            Dim lbl As New Label
            lbl.Text = toolResult(0)(2).ToString
            Dim toolID As Int16 = toolResult(0)(0)

            If Trim(toolResult(0)(3).ToString) = "Tools" Then
                phReqTools.Controls.Add(lbl)
                phReqTools.Controls.Add(New LiteralControl("<br />"))
                If Not IsPostBack Then
                    cbTools.Items.FindByValue(toolID).Selected = True
                End If

            ElseIf Trim(toolResult(0)(3).ToString) = "Supplies" Then
                    phReqSupplies.Controls.Add(lbl)
                phReqSupplies.Controls.Add(New LiteralControl("<br />"))
                If Not IsPostBack Then
                    cbSupplies.Items.FindByValue(toolID).Selected = True
                End If

            End If


        Next


    End Sub
    Protected Sub dvKit_ItemInserting(sender As Object, e As DetailsViewInsertEventArgs) Handles dvKit.ItemInserting

        Dim SOP_Id As Int16 = lblSOPNo.Text
        Dim tbItemId As TextBox = dvKit.FindControl("tbItemID")
        Dim tbItemQty As TextBox = dvKit.FindControl("tbItemQty")
        Dim tbPartNoOrDesc As TextBox = dvKit.FindControl("tbPartNoOrDesc")
        Dim tbDesc As TextBox = dvKit.FindControl("tbDesc")

        sdsKit.InsertParameters("SOP_ID").DefaultValue = SOP_Id
        sdsKit.InsertParameters("ItemID").DefaultValue = tbItemId.Text
        sdsKit.InsertParameters("ItemQty").DefaultValue = tbItemQty.Text
        sdsKit.InsertParameters("PartNoOrDesc").DefaultValue = tbPartNoOrDesc.Text
        sdsKit.InsertParameters("Description").DefaultValue = tbDesc.Text

    End Sub
    Protected Sub dvKit_ItemInserted(sender As Object, e As DetailsViewInsertedEventArgs) Handles dvKit.ItemInserted
        gvKit.DataBind()
    End Sub
    Protected Sub dvAddToolsSupplies_ItemInserted(sender As Object, e As DetailsViewInsertedEventArgs) Handles dvAddToolsSupplies.ItemInserted
        dvAddToolsSupplies.DataBind()
    End Sub

    Protected Sub btnSaveTools_Click(sender As Object, e As EventArgs) Handles btnSaveTools.Click

        Dim cbTools As CheckBoxList = FindControl("cbTools")
            Dim cbSupplies As CheckBoxList = FindControl("cbSupplies")
            Dim newToolsList As String = ""
        'MesgBox(newToolsList)
        For Each item In cbTools.Items
                If item.Selected = True Then
                    newToolsList += item.value.ToString
                    newToolsList += ","
                Else
                    'MesgBox(item.value.ToString)
                End If
            Next

            For Each item In cbSupplies.Items
                If item.Selected = True Then
                    'MesgBox(item.value.ToString)
                    newToolsList += item.value.ToString
                    newToolsList += ","
                Else
                    'MesgBox(item.value.ToString)
                End If
            Next
            newToolsList = newToolsList.Substring(0, newToolsList.Length - 1)

        'MesgBox(newToolsList)

        'update the required tools list for this SOP and rebind it.

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("SOPConnectionString").ConnectionString
        conn.ConnectionString = connstr
        Dim cmd As New SqlCommand

        Dim SOPNo As String
        SOPNo = lblSOPNo.Text

        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@newtoolslist", newToolsList)
        cmd.Parameters.AddWithValue("@sopno", SOPNo)

        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Update SOP_ToolsRequired Set ToolsRequired =  @newtoolslist where SOP_ID =  @sopno"

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        phReqSupplies.Controls.Clear()
        phReqTools.Controls.Clear()
        Page_Load(sender, e)

    End Sub
    Protected Sub btnAddModifyTools_Click(sender As Object, e As EventArgs) Handles btnAddModifyTools.Click
        If addnewtools.Visible = "true" Then
            addnewtools.Visible = "false"
        ElseIf addnewtools.Visible = "false" Then
            addnewtools.Visible = "true"
        End If
    End Sub
    Protected Sub btnAddItemsToKit_Click(sender As Object, e As EventArgs) Handles btnAddItemsToKit.Click
        If dvKit.Visible = "true" Then
            dvKit.Visible = "false"
        ElseIf dvKit.Visible = "false" Then
            dvKit.Visible = "true"
        End If
    End Sub
    Protected Sub gvWorkInstEdit_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvWorkInstEdit.RowUpdating

        Dim tbInstNo As TextBox = gvWorkInstEdit.Rows(e.RowIndex).FindControl("tbWorkInstStepNo")
        Dim tbInstDesc As TextBox = gvWorkInstEdit.Rows(e.RowIndex).FindControl("tbWorkInstDesc")
        Dim lastupdate As Date = Date.Now

        sdsWorkInstuctions.UpdateParameters("WorkInstID").DefaultValue = tbInstNo.Text
        sdsWorkInstuctions.UpdateParameters("WorkInstDesc").DefaultValue = tbInstDesc.Text
        sdsWorkInstuctions.UpdateParameters("WorkInstLastModified").DefaultValue = lastupdate

    End Sub
    Protected Sub gvKit_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvKit.RowUpdating
        Dim SopNo As String = lblSOPNo.Text
        Dim tbItemID As TextBox = gvKit.Rows(e.RowIndex).FindControl("tbItemID")
        Dim tbItemQty As TextBox = gvKit.Rows(e.RowIndex).FindControl("tbItemQty")
        Dim tbPartNoOrDesc As TextBox = gvKit.Rows(e.RowIndex).FindControl("tbPartNoOrDesc")
        Dim tbDescription As TextBox = gvKit.Rows(e.RowIndex).FindControl("tbDescription")


        sdsKit.UpdateParameters("SOP_ID").DefaultValue = SopNo
        sdsKit.UpdateParameters("ItemID").DefaultValue = tbItemID.Text
        sdsKit.UpdateParameters("ItemQty").DefaultValue = tbItemQty.Text
        sdsKit.UpdateParameters("PartNoOrDesc").DefaultValue = tbPartNoOrDesc.Text
        sdsKit.UpdateParameters("Description").DefaultValue = tbDescription.Text


    End Sub
End Class
