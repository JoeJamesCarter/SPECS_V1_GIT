Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO


Partial Class SRT_EditStatus
    Inherits System.Web.UI.Page
    Public triggers As Object

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim ItemID As String
        Dim ItemDesc As String
        Dim Dependency As String

        Dim modelYear As String = ddlModelYear.SelectedValue
        Dim firstMonday As Date

        ItemID = Request.QueryString("ItemID")
        ItemDesc = Request.QueryString("ItemDesc")
        Dependency = Request.QueryString("Dependency")

        hdnDependency.Value = Dependency
        lblItemDesc.Text = ItemDesc
        lblItemID.Text = ItemID


        If modelYear = "2020" Then
            firstMonday = "7/29/2019"
        ElseIf modelYear = "2021" Then
            firstMonday = "8/3/2020"
        ElseIf modelYear = "2022" Then
            firstMonday = "8/1/2021"
        End If

        Dim numWeeks As Integer = 104

        If ddlWeekOf.Items.Count = 0 Then  'stop it from repopulating everytime the grid rebinds
            Dim j As Integer = 7

            ddlWeekOf.Items.Add(New ListItem(firstMonday, firstMonday))

            For i = 1 To numWeeks
                ddlWeekOf.Items.Add(New ListItem(firstMonday.AddDays(j), firstMonday.AddDays(j)))
                j = j + 7
                i = i + 1
            Next

        End If
        'populate attachments placeholder


        Dim ItemNo As String = lblItemID.Text

        Dim strFileSize As String = ""
        Dim di As New IO.DirectoryInfo(Server.MapPath("Uploads/" + ItemNo + "/"))
        If di.Exists Then


            Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
            Dim fi As IO.FileInfo
            Dim k As Integer = 0


            For Each fi In aryFi

                strFileSize = (Math.Round(fi.Length / 1024)).ToString()
                'lblUploadResult.Text = fi.Name

                Dim lnk As New HyperLink
                lnk.ID = "lnk" & k.ToString()
                'PlaceHolder1.Controls.Add(GetLiteral("</br/>""))
                'PlaceHolder1.Controls.Add(GetLiteral("<br />"))
                lnk.ID = "lnk" & k.ToString()
                lnk.NavigateUrl = "http:\\specs1\Live\PopReporting\SRT\Uploads\" & ItemNo & "\" & fi.Name
                lnk.Target = "_blank"
                lnk.Text = fi.Name
                PlaceHolder1.Controls.Add(New LiteralControl("<br />"))
                PlaceHolder1.Controls.Add(lnk)
                k += 1

                'Console.WriteLine("File Name: {0}", fi.Name)
                'Console.WriteLine("File Full Name: {0}", fi.FullName)
                'Console.WriteLine("File Size (KB): {0}", strFileSize)
                'Console.WriteLine("File Extension: {0}", fi.Extension)
                'Console.WriteLine("Last Accessed: {0}", fi.LastAccessTime)
                'Console.WriteLine("Read Only: {0}", (fi.Attributes.ReadOnly = True).ToString)
            Next
        End If




    End Sub

    Protected Sub gvNotes_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvNotes.RowDataBound
        Dim colIndex As Integer = 2
        Dim Status As String = e.Row.Cells(2).Text

        If e.Row.RowType = DataControlRowType.DataRow Then

            If Status = "0" Then
                e.Row.Cells(1).Text = " "
            ElseIf Status = "1" Then
                e.Row.Cells(colIndex).Text = "Color Samples To Vendor (DSD)"
                e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                e.Row.Cells(colIndex).BackColor = Drawing.Color.Purple
            ElseIf Status = "2" Then
                e.Row.Cells(colIndex).Text = "Samples Available (DSD)"
                e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                e.Row.Cells(colIndex).BackColor = Drawing.Color.DarkGreen
            ElseIf Status = "3" Then
                e.Row.Cells(colIndex).Text = "Samples Under Review"
                e.Row.Cells(colIndex).ForeColor = Drawing.Color.Black
                e.Row.Cells(colIndex).BackColor = Drawing.Color.LightGreen
            ElseIf Status = "4" Then
                e.Row.Cells(colIndex).Text = "Colors Rejected (DESIGN)"
                e.Row.Cells(colIndex).ForeColor = Drawing.Color.Black
                e.Row.Cells(colIndex).BackColor = Drawing.Color.LightCyan
            ElseIf Status = "5" Then
                e.Row.Cells(colIndex).Text = "Color Approved (DSD/DESIGN)"
                e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                e.Row.Cells(colIndex).BackColor = Drawing.Color.SeaGreen
            ElseIf Status = "6" Then
                e.Row.Cells(colIndex).Text = "Validation Parts Ready(DSD/PURCHASING)"
                e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                e.Row.Cells(colIndex).BackColor = Drawing.Color.DodgerBlue
            ElseIf Status = "7" Then
                e.Row.Cells(colIndex).Text = "F/F/F Approved (ENGINEERING)"
                e.Row.Cells(colIndex).ForeColor = Drawing.Color.Black
                e.Row.Cells(colIndex).BackColor = Drawing.Color.GreenYellow
            ElseIf Status = "8" Then
                e.Row.Cells(colIndex).Text = "Prod Quote Approved (PURCHASING)"
                e.Row.Cells(colIndex).ForeColor = Drawing.Color.Black
                e.Row.Cells(colIndex).BackColor = Drawing.Color.Yellow
            ElseIf Status = "9" Then
                e.Row.Cells(colIndex).Text = "Drop Dead Date (VALIDATION)"
                e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                e.Row.Cells(colIndex).BackColor = Drawing.Color.DarkRed
            ElseIf Status = "10" Then
                e.Row.Cells(colIndex).Text = "Drop Dead Date (PRODUCTION)"
                e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                e.Row.Cells(colIndex).BackColor = Drawing.Color.PaleVioletRed
            ElseIf Status = "20" Then
                e.Row.Cells(colIndex).Text = "COMPLETED"
                e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                e.Row.Cells(colIndex).BackColor = Drawing.Color.Black
            End If
        End If


    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim weekOf As String = ddlWeekOf.SelectedValue
        Dim status As String = ddlStatuses.SelectedValue
        Dim note As String = tbNote.Text
        Dim itemID As Integer = lblItemID.Text.ToString

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@itemID", itemID)
        cmd.Parameters.AddWithValue("@weekOf", weekOf)
        cmd.Parameters.AddWithValue("@status", status)
        cmd.Parameters.AddWithValue("@note", note)


        cmd.CommandText = "Insert into SupplierReadiness_StatusNotes (ItemID, WeekOf, Status, Notes)VALUES(@itemID, @weekOf, @status, @note)"

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        tbNote.Text = ""

        gvNotes.DataBind()


    End Sub


    Protected Sub btnUpdateTriggers_Click(sender As Object, e As EventArgs) Handles btnUpdateTriggers.Click

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn

        Dim count As Integer = 0
        Dim result As String = ""
        Dim itemID As Integer = lblItemID.Text

        conn.Open()

        For i As Integer = 0 To gvParents.Rows.Count - 1
            Dim row As GridViewRow = gvParents.Rows(i)
            Dim id As String = row.Cells(1).Text
            Dim cbSelected As CheckBox = DirectCast(row.FindControl("cbSelected"), CheckBox)

            If cbSelected.Checked = "True" Then
                count = count + 1

                cmd2.Parameters.AddWithValue("@itemID2", itemID)
                cmd2.Parameters.AddWithValue("@dependentOnItemID2", id)
                cmd2.CommandText = "If Not Exists (Select * from SupplierTracking_ItemDependencies Where ItemID = @itemID2 and DependentOnItemID = @dependentOnItemID2) BEGIN Insert Into SupplierTracking_ItemDependencies (ItemID, DependentOnItemID) VALUES (@itemID2, @dependentOnItemID2) END"

                cmd2.ExecuteNonQuery()
                cmd2.Parameters.Clear()

                If count = 1 Then
                    result = id
                ElseIf count > 1 Then
                    result = result + "," + id
                End If

            Else ' make sure it isn't a delete
                cmd1.Parameters.AddWithValue("@itemID1", itemID)
                cmd1.Parameters.AddWithValue("@DependentOnItemID", id)
                cmd1.CommandText = "Delete from SupplierTracking_ItemDependencies where ItemID = @itemID1 and DependentOnItemID = @DependentOnItemID"

                Try
                    cmd1.ExecuteNonQuery()
                    cmd1.Parameters.Clear()
                Catch ex As Exception

                End Try

            End If
        Next

       
        cmd.Parameters.AddWithValue("@result", Trim(result))
        cmd.Parameters.AddWithValue("@itemID", itemID)

        cmd.CommandText = "Update SupplierTracking_Items Set DependentOnItemsList = @result where ItemID = @itemID "
        cmd.ExecuteNonQuery()
        conn.Close()

    End Sub

    Protected Sub gvParents_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvParents.RowDataBound

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        'Dim triggers As String = ""
        Dim itemID As String = lblItemID.Text

        conn.ConnectionString = connstr
        cmd.Connection = conn

        ' cmd.Parameters.AddWithValue("@result", Trim(result))
        cmd.Parameters.AddWithValue("@itemID", itemID)

        cmd.CommandText = "Select DependentOnItemsList From SupplierTracking_Items where ItemID = @itemID "

        If e.Row.RowType = DataControlRowType.DataRow Then

            If e.Row.RowIndex = 0 Then
                conn.Open()
                triggers = cmd.ExecuteScalar()

                If IsDBNull(triggers) Then
                    'MesgBox("No Triggers Set")
                    conn.Close()
                    Return
                End If

                Dim triggerID As String = e.Row.Cells(1).Text
                Dim cbTriggerID As CheckBox = e.Row.Cells(0).FindControl("cbSelected")

                If triggers.ToString.Length > 0 And triggers.Contains(triggerID) Then
                    cbTriggerID.Checked = True
                End If
            ElseIf e.Row.RowIndex > 0 And Not IsDBNull(triggers) Then
                Dim triggerID As String = e.Row.Cells(1).Text
                Dim cbTriggerID As CheckBox = e.Row.Cells(0).FindControl("cbSelected")
                If triggers.Contains(triggerID) Then
                    cbTriggerID.Checked = True
                End If
            End If
        End If

    End Sub

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnUpload.Click
        If IsPostBack Then
            Dim ItemNo As String = lblItemID.Text
            Dim path As String = Server.MapPath("Uploads/" + ItemNo + "/")
            Dim fileOK As Boolean = False

            If File1.HasFile Then
                Dim fileExtension As String
                fileExtension = System.IO.Path. _
                    GetExtension(File1.FileName).ToLower()
                Dim allowedExtensions As String() = _
                    {".jpg", ".jpeg", ".png", ".pdf", ".xls", ".xlsx", ".doc", ".docx"}
                For i As Integer = 0 To allowedExtensions.Length - 1
                    If fileExtension = allowedExtensions(i) Then
                        fileOK = True
                    End If
                Next
                If fileOK Then
                    If (Not System.IO.Directory.Exists(path)) Then
                        System.IO.Directory.CreateDirectory(path)
                    End If
                    Try
                        File1.PostedFile.SaveAs(path & _
                             File1.FileName)
                        lblUploadResult.Text = "File uploaded!"
                    Catch ex As Exception
                        lblUploadResult.Text = "File could not be uploaded."
                    End Try
                Else
                    Label1.Text = "Cannot accept files of this type."
                End If
            End If
        End If
    End Sub
End Class
