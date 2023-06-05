Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO

Partial Class SRT_SupplierReadinessTracking
    Inherits System.Web.UI.Page

    Public StatusandNotesList As New DataTable
    Public CurrentRecordsToCopy As New DataTable
    Public firstMilestone As Date
    Public currentWeekMonday As Date

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        additem.Style.Add("display", "none")


        If Not IsPostBack Then
            ddlMY0.SelectedValue = "2023"
            copyitems.Style.Add("display", "none")
            dvMileStones.Visible = False
        End If

        PopulateDataTables()

        'Trying to scroll to todays week on page load
        Dim today As Date = Date.Today
        Dim dayIndex As Integer = Today.DayOfWeek
        If dayIndex < DayOfWeek.Monday Then
            dayIndex += 7 'Monday is first day of week, no day of week should have a smaller index
        End If
        Dim dayDiff As Integer = dayIndex - DayOfWeek.Monday
        Dim monday As Date = today.AddDays(-dayDiff)

        currentWeekMonday = monday

        'Dim todaysColIndex As Integer = GetColumnIndexByName(gvItems, monday)

    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
    End Sub


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub btnShowAddItemForm_Click(sender As Object, e As EventArgs) Handles btnShowAddItemForm.Click
        additem.Style.Add("display", "block")
    End Sub

    Protected Sub btnAddNew_Click(sender As Object, e As EventArgs) Handles btnAddNew.Click
        Dim modelYear As Integer = ddlMY.SelectedValue
        Dim category As String = tbCategory.Text
        Dim supplier As String = tbSupplier.Text
        Dim colorType As String = tbColorType.Text
        Dim leadTime As Integer = tbLeadTime.Text
        Dim dependentOn As String = tbDependency.Text

        If Len(modelYear) > 0 And Len(category) > 0 Then

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.Parameters.AddWithValue("@modelYear", modelYear)
            cmd.Parameters.AddWithValue("@category", category)
            cmd.Parameters.AddWithValue("@supplier", supplier)
            cmd.Parameters.AddWithValue("@colorType", colorType)
            cmd.Parameters.AddWithValue("@leadTime", leadTime)
            cmd.Parameters.AddWithValue("@dependentOn", dependentOn)


            cmd.CommandText = "Insert into SupplierTracking_Items (ModelYear, Category, Supplier, Color_Type, DependentOn, LeadTime) Values (@modelYear, @category, @supplier, @colorType, @dependentOn, @leadTime)"

            Try
                conn.Open()
                cmd.ExecuteNonQuery()
                conn.Close()

                'reset form
                ddlMY.SelectedIndex = -1
                tbCategory.Text = ""
                tbSupplier.Text = ""
                tbColorType.Text = ""
                tbDependency.Text = ""
                tbLeadTime.Text = ""

                gvItems.DataBind()
            Catch ex As Exception

            End Try

        End If
    End Sub

    Protected Sub gvItems_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvItems.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then


            Dim currentStatus As String = e.Row.Cells(10).Text

            'Dim firstCell As Integer = 8
            Dim leadtime As Integer = e.Row.Cells(10).Text
            Dim leadtimeindays As Integer = (leadtime * 7) * -1
            Dim lateFlag As Integer = 0
            Dim completeFlag As Integer = 0

            gvMilestones.DataBind()

            Dim dropDead As Date = firstMilestone.AddDays(leadtimeindays)
            Dim TwoWeeksTilDropDead As Date = dropDead.AddDays(-14)
            Dim ThreeWeeksTilDropDead As Date = dropDead.AddDays(-21)

            Dim columnIndex As Integer = GetColumnIndexByName(gvItems, dropDead)

            If columnIndex > 0 Then
                e.Row.Cells(columnIndex).BackColor = Drawing.Color.Red
                e.Row.Cells(columnIndex).ForeColor = Drawing.Color.White
                e.Row.Cells(columnIndex).Text = "Lead Time Critical"
            End If

            'e.Row.Cells(0).ToolTip = "ID"

            Dim itemID As String
            Dim statusResult() As DataRow

            itemID = e.Row.DataItem("ItemID")
            e.Row.Cells(7).ToolTip = itemID
            e.Row.Cells(8).ToolTip = itemID

            'Populate Current status Gridview
            'Populate Dependency Gridview
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsMaxStatus"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsDependentItemStatuses"), SqlDataSource)


            Try
                s.SelectParameters(0).DefaultValue = itemID
                s.SelectParameters(1).DefaultValue = itemID
                t.SelectParameters(0).DefaultValue = itemID
                t.SelectParameters(1).DefaultValue = itemID
            Catch ex As Exception

            End Try

            statusResult = StatusandNotesList.Select("ItemID =  '" & itemID & "'", "EntryID ASC")

            Dim i As Integer = 0

            For j = 0 To statusResult.Length ' repeat until you have processed all the status lines per item.

                If statusResult.Length > 0 Then
                    Dim Monday = statusResult(i)(2)
                    Dim Status = statusResult(i)(3)
                    'MesgBox(Status)

                    Dim Note = statusResult(i)(4)
                    If Len(Note.ToString) > 0 Then
                        Note = "(" + Note + ")"
                    End If
                    Dim colIndex As Integer = GetColumnIndexByName(gvItems, Monday)

                    'If e.row.Cells(0).Text = "134" Then
                    'MesgBox(Monday)
                    'MesgBox(colIndex)
                    'End If


                    If colIndex > 0 Then
                        e.Row.Cells(colIndex).Text = Status
                        'e.Row.Cells(2).ToolTip = colIndex
                        'e.Row.Cells(2).ToolTip = Status
                        'e.Row.Cells(2).ToolTip = Monday
                        'Set the display the statuses by words representing numbers.

                        If Status = "0" Then
                            e.Row.Cells(colIndex).Text = " " + Note
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.Black
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.White
                            lateFlag = 1
                        ElseIf Status = "1" Then
                            e.Row.Cells(colIndex).Text = "Color Samples To Vendor (DSD)" + " " + Note
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.Purple
                            lateFlag = 1
                        ElseIf Status = "2" Then
                            e.Row.Cells(colIndex).Text = "Samples Available (DSD)" + " " + Note
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.DarkGreen
                            lateFlag = 1
                        ElseIf Status = "3" Then
                            e.Row.Cells(colIndex).Text = "Samples Under Review" + " " + Note
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.Black
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.LightGreen
                            lateFlag = 1
                        ElseIf Status = "4" Then
                            e.Row.Cells(colIndex).Text = "Colors Rejected (DESIGN)" + " " + Note
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.Black
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.LightCyan
                            lateFlag = 1
                        ElseIf Status = "5" Then
                            e.Row.Cells(colIndex).Text = "Color Approved (DSD/DESIGN)" + " " + Note
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.SeaGreen
                        ElseIf Status = "6" Then
                            e.Row.Cells(colIndex).Text = "Validation Parts Ready(DSD/PUR)" + " " + Note
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.DodgerBlue
                        ElseIf Status = "7" Then
                            e.Row.Cells(colIndex).Text = "F/F/F Approved (ENG)" + " " + Note
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.Black
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.GreenYellow
                        ElseIf Status = "8" Then
                            e.Row.Cells(colIndex).Text = "Prod Quote Approved (PUR)" + " " + Note
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.Black
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.Yellow
                        ElseIf Status = "9" Then
                            e.Row.Cells(colIndex).Text = "Drop Dead Date (VALIDATION)" + " " + Note
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.DarkRed
                        ElseIf Status = "10" Then
                            e.Row.Cells(colIndex).Text = "Drop Dead Date (PROD)" + " " + Note
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.PaleVioletRed
                        ElseIf Status = "20" Then
                            e.Row.Cells(colIndex).Text = "COMPLETED" + " " + Note
                            e.Row.Cells(2).BackColor = Drawing.Color.Black
                            e.Row.Cells(colIndex).ForeColor = Drawing.Color.White
                            e.Row.Cells(colIndex).BackColor = Drawing.Color.Black
                            completeFlag = 1
                        End If
                        i = i + 1
                    End If

                End If
                j = j + 1

            Next


            If lateFlag = 1 And ThreeWeeksTilDropDead < Today() And completeFlag = 0 Then
                e.Row.Cells(2).BackColor = Drawing.Color.Yellow
            End If

            If lateFlag = 1 And TwoWeeksTilDropDead < Today() And completeFlag = 0 Then
                e.Row.Cells(2).BackColor = Drawing.Color.Orange
            End If

            If lateFlag = 1 And dropDead < Today() And completeFlag = 0 Then
                e.Row.Cells(2).BackColor = Drawing.Color.Red
            End If



            Dim dependents As String = e.Row.DataItem("DependentOnItemsList").ToString
            If Trim(dependents).Length >= 3 Then
                e.Row.CssClass = "parentWDependents"
                ' Else
                'e.Row.Cells(6).Text.Replace("&nbsp;", "")
            End If

            If completeFlag = 1 Then
                e.Row.Cells(2).BackColor = Drawing.Color.Black
                e.Row.Cells(2).ForeColor = Drawing.Color.White
            End If


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.Parameters.AddWithValue("@ItemID", itemID)
            cmd.CommandText = "SELECT [Status] as MaxStatus FROM [SupplierReadiness_StatusNotes] WHERE ([ItemID] = @ItemID) AND EntryID = (select max(EntryID) from SupplierReadiness_StatusNotes Where [ItemID] = @ItemID)"
            conn.Open()
            Dim maxStatus As Integer = cmd.ExecuteScalar()
            Dim hdnMaxStatus As HiddenField = e.Row.FindControl("hdnMaxStatus")
            hdnMaxStatus.Value = maxStatus
            conn.Close()

            If maxStatus = 20 Then
                e.Row.Cells(2).ForeColor = Drawing.Color.White
                e.Row.Cells(2).BackColor = Drawing.Color.Black
            End If

        End If

    End Sub

    Private Function GetColumnIndexByName(ByVal grid As GridView, ByVal name As String) As Integer
        For Each col As DataControlField In grid.Columns

            If col.HeaderText.ToLower().Trim() = name.ToLower().Trim() Then
                Return grid.Columns.IndexOf(col)
            End If
        Next

        Return -1
    End Function


    Protected Sub gvItems_DataBound(sender As Object, e As EventArgs) Handles gvItems.DataBound
        'Create the Monday Headers
        Dim modelYear As String = ddlMY0.SelectedValue
        Dim firstMonday As Date = "11/12/2018"
        'Dim firstMonday As Date = "7/30/2018"
        Dim numWeeks As Integer

        If modelYear = "2020" Then
            'firstMonday = "8/01/2018"
            numWeeks = 40
        ElseIf modelYear = "2021" Then
            firstMonday = "8/12/2019"
            numWeeks = 52
        ElseIf modelYear = "2022" Then
            firstMonday = "8/11/2020"
            numWeeks = 52
        End If


        Dim key As Integer = 12

        For i = 1 To numWeeks
            gvItems.Columns(key).HeaderText = firstMonday

            If firstMonday = currentWeekMonday Then
                'MesgBox(firstMonday)
                gvItems.Columns(key).FooterText = firstMonday
                gvItems.Columns(key).ItemStyle.BorderColor = Drawing.Color.Black
                gvItems.Columns(key).ItemStyle.BorderStyle = BorderStyle.Solid
                gvItems.Columns(key).ItemStyle.BorderWidth = 3
            End If


            'gvItems.Columns(key).FooterText = firstMonday
            key = key + 1
            firstMonday = firstMonday.AddDays(7)
        Next
    End Sub

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
        Dim sqldataadapter As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr
        cmd.Connection = conn

        conn.Open()

        sqldataadapter.SelectCommand = New SqlCommand("Select * FROM SupplierReadiness_StatusNotes Order By ItemID, EntryID", conn)
        sqldataadapter.Fill(StatusandNotesList)

        conn.Close()
        conn.Dispose()
        Return False

    End Function


    Protected Sub gvMilestones_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvMilestones.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow And e.Row.RowIndex = "0" Then
            Try
                firstMilestone = e.Row.Cells(2).Text
            Catch ex As Exception

            End Try

        End If

    End Sub

    Protected Sub gvItems_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvItems.RowCommand
        If e.CommandName = "EditStatus" Then
            'This code is for the update button

            Dim Key As String = e.CommandArgument 'get the itemID to edit

            Dim ItemID As Integer = gvItems.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim ItemButton As Button = CType(gvItems.Rows(Key).FindControl("Button1"), Button)
            Dim Dependency As String = gvItems.Rows(Key).Cells(8).Text
            Dim ItemDesc As String = ItemButton.Text
            Dim url As String = "./EditStatus.aspx?ItemID=" & ItemID & "&ItemDesc=" & ItemDesc & "&Dependency=" & Dependency
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1400,height=1000,toolbars=0');popUpObj.focus()}</script>")
            gvItems.DataBind()
        End If
    End Sub

    Protected Sub btnCopyItems_Click(sender As Object, e As EventArgs) Handles btnCopyItems.Click
        copyitems.Style.Add("display", "block")
    End Sub

    Protected Sub btnCopy_Click(sender As Object, e As EventArgs) Handles btnCopy.Click

        Dim newCurrentColor As String = tbNewCurrentColor.Text
        Dim newNewColor As String = tbNewNewColor.Text

        Dim fromModelYear As String = ddlMY1.SelectedValue
        Dim fromCurrenctColor As String = ddlfromCurrentColor.SelectedValue

        Dim sqldataadapter1 As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn

        conn.Open()


        sqldataadapter1.SelectCommand = New SqlCommand("Select * FROM [SupplierTracking_Items] WHERE ([ModelYear] = '" & fromModelYear & "') and ([CurrentColor] = '" & fromCurrenctColor & "') Order By ItemID", conn)
        sqldataadapter1.Fill(CurrentRecordsToCopy)

        Dim k As Integer = 0

        Dim modelYear As String
        Dim itemDesc As String
        Dim supplier As String
        Dim leadTime As Integer
        Dim currentStatus As Integer

        For Each DataRow In CurrentRecordsToCopy.Rows
            modelYear = CurrentRecordsToCopy(k)(1)
            itemDesc = CurrentRecordsToCopy(k)(2)
            supplier = CurrentRecordsToCopy(k)(3)
            leadTime = CurrentRecordsToCopy(k)(6)
            currentStatus = 0

            cmd.Parameters.AddWithValue("@modelYear1", modelYear)
            cmd.Parameters.AddWithValue("@itemDesc1", itemDesc)
            cmd.Parameters.AddWithValue("@supplier1", supplier)
            cmd.Parameters.AddWithValue("@leadTime1", leadTime)
            cmd.Parameters.AddWithValue("@newCurrentColor1", newCurrentColor)
            cmd.Parameters.AddWithValue("@newNewColor1", newNewColor)
            cmd.Parameters.AddWithValue("@currentStatus1", currentStatus)

            cmd.CommandText = "Insert into SupplierTracking_Items (ModelYear, ItemDesc, Supplier, CurrentColor, NewColor, LeadTime, CurrentStatus) VALUES ( @modelYear1, @itemDesc1, @supplier1, @newCurrentColor1, @newNewColor1, @leadTime1, @currentStatus1)"

            'MesgBox(modelYear & " " & itemDesc & " " & supplier & " " & newCurrentColor & " " & newNewColor & " " & leadTime & " " & currentStatus)
            cmd.ExecuteNonQuery()

            cmd.Parameters.Clear()

            k = k + 1
        Next



        conn.Close()
        conn.Dispose()


    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvItems.DataBind()
        gvMilestones.DataBind()
    End Sub


    Protected Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        additem.Style.Add("display", "none")
    End Sub

    Protected Sub btnClose0_Click(sender As Object, e As EventArgs) Handles btnClose0.Click
        copyitems.Style.Add("display", "none")
    End Sub


    Protected Sub gvCurrentStatus_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim curStatus As Integer = e.Row.Cells(1).Text
            Dim Note As String = e.Row.DataItem("Notes")



            If Len(Note.ToString) > 0 Then
                Note = "(" + Note + ")"
            End If

            'MesgBox(curStatus)
            If curStatus = "0" Then
                e.Row.Cells(1).Text = " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.Black
                e.Row.Cells(1).BackColor = Drawing.Color.White
            ElseIf curStatus = "1" Then
                e.Row.Cells(1).Text = "Color Samples To Vendor (DSD)" + " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.White
                e.Row.Cells(1).BackColor = Drawing.Color.Purple
            ElseIf curStatus = "2" Then
                e.Row.Cells(1).Text = "Samples Available (DSD)" + " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.White
                e.Row.Cells(1).BackColor = Drawing.Color.DarkGreen
            ElseIf curStatus = "3" Then
                e.Row.Cells(1).Text = "Samples Under Review" + " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.Black
                e.Row.Cells(1).BackColor = Drawing.Color.LightGreen
            ElseIf curStatus = "4" Then
                e.Row.Cells(1).Text = "Colors Rejected (DESIGN)" + " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.Black
                e.Row.Cells(1).BackColor = Drawing.Color.LightCyan
            ElseIf curStatus = "5" Then
                e.Row.Cells(1).Text = "Color Approved (DSD/DESIGN)" + " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.White
                e.Row.Cells(1).BackColor = Drawing.Color.SeaGreen
            ElseIf curStatus = "6" Then
                e.Row.Cells(1).Text = "Validation Parts Ready(DSD/PUR)" + " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.White
                e.Row.Cells(1).BackColor = Drawing.Color.DodgerBlue
            ElseIf curStatus = "7" Then
                e.Row.Cells(1).Text = "F/F/F Approved (ENG)" + " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.Black
                e.Row.Cells(1).BackColor = Drawing.Color.GreenYellow
            ElseIf curStatus = "8" Then
                e.Row.Cells(1).Text = "Prod Quote Approved (PUR)" + " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.Black
                e.Row.Cells(1).BackColor = Drawing.Color.Yellow
            ElseIf curStatus = "9" Then
                e.Row.Cells(1).Text = "Drop Dead Date (VALIDATION)" + " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.White
                e.Row.Cells(1).BackColor = Drawing.Color.DarkRed
            ElseIf curStatus = "10" Then
                e.Row.Cells(1).Text = "Drop Dead Date (PROD)" + " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.White
                e.Row.Cells(1).BackColor = Drawing.Color.PaleVioletRed
            ElseIf curStatus = "20" Then
                e.Row.Cells(1).Text = "COMPLETED" + " " + Note
                e.Row.Cells(1).ForeColor = Drawing.Color.White
                e.Row.Cells(1).BackColor = Drawing.Color.Black

            End If
            'end of change current status color

            e.Row.Cells(1).ToolTip = Note
        End If


    End Sub

    Protected Sub gvDependentItemStatuses_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim curStatus As String = "0"
        Dim depLateFlag As Integer = 0
        Dim depCompleteFlag As Integer = 0

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim depLeadTime As Integer = e.Row.DataItem("LeadTime")

            If e.Row.Cells(2).Text <> "" Then
                curStatus = e.Row.Cells(2).Text
            End If

            'MesgBox(curStatus)
            If curStatus = "0" Then
                e.Row.Cells(2).Text = " "
                e.Row.Cells(2).ForeColor = Drawing.Color.Black
                e.Row.Cells(2).BackColor = Drawing.Color.White
                depLateFlag = 1
            ElseIf curStatus = "1" Then
                e.Row.Cells(2).Text = "Color Samples To Vendor (DSD)"
                e.Row.Cells(2).ForeColor = Drawing.Color.White
                e.Row.Cells(2).BackColor = Drawing.Color.Purple
                depLateFlag = 1
            ElseIf curStatus = "2" Then
                e.Row.Cells(2).Text = "Samples Available (DSD)"
                e.Row.Cells(2).ForeColor = Drawing.Color.White
                e.Row.Cells(2).BackColor = Drawing.Color.DarkGreen
                depLateFlag = 1
            ElseIf curStatus = "3" Then
                e.Row.Cells(2).Text = "Samples Under Review"
                e.Row.Cells(2).ForeColor = Drawing.Color.Black
                e.Row.Cells(2).BackColor = Drawing.Color.LightGreen
                depLateFlag = 1
            ElseIf curStatus = "4" Then
                e.Row.Cells(2).Text = "Colors Rejected (DESIGN)"
                e.Row.Cells(2).ForeColor = Drawing.Color.Black
                e.Row.Cells(2).BackColor = Drawing.Color.LightCyan
                depLateFlag = 1
            ElseIf curStatus = "5" Then
                e.Row.Cells(2).Text = "Color Approved (DSD/DESIGN)"
                e.Row.Cells(2).ForeColor = Drawing.Color.White
                e.Row.Cells(2).BackColor = Drawing.Color.SeaGreen
            ElseIf curStatus = "6" Then
                e.Row.Cells(2).Text = "Validation Parts Ready(DSD/PURCHASING)"
                e.Row.Cells(2).ForeColor = Drawing.Color.White
                e.Row.Cells(2).BackColor = Drawing.Color.DodgerBlue
            ElseIf curStatus = "7" Then
                e.Row.Cells(2).Text = "F/F/F Approved (ENGINEERING)"
                e.Row.Cells(2).ForeColor = Drawing.Color.Black
                e.Row.Cells(2).BackColor = Drawing.Color.GreenYellow
            ElseIf curStatus = "8" Then
                e.Row.Cells(2).Text = "Prod Quote Approved (PURCHASING)"
                e.Row.Cells(2).ForeColor = Drawing.Color.Black
                e.Row.Cells(2).BackColor = Drawing.Color.Yellow
            ElseIf curStatus = "9" Then
                e.Row.Cells(2).Text = "Drop Dead Date (VALIDATION)"
                e.Row.Cells(2).ForeColor = Drawing.Color.White
                e.Row.Cells(2).BackColor = Drawing.Color.DarkRed
            ElseIf curStatus = "10" Then
                e.Row.Cells(2).Text = "Drop Dead Date (PRODUCTION)"
                e.Row.Cells(2).ForeColor = Drawing.Color.White
                e.Row.Cells(2).BackColor = Drawing.Color.PaleVioletRed
            ElseIf curStatus = "20" Then
                e.Row.Cells(2).Text = "COMPLETED"
                e.Row.Cells(2).ForeColor = Drawing.Color.White
                e.Row.Cells(2).BackColor = Drawing.Color.Black
                depCompleteFlag = 1
            End If
            'end of change current status color
            'Make first cell red if dependent is lead time critical

            Dim leadtime As Integer = e.Row.DataItem("LeadTime")
            Dim leadtimeindays As Integer = (leadtime * 7) * -1

            gvMilestones.DataBind()
            Dim depDropDead As Date = firstMilestone.AddDays(leadtimeindays)
            Dim depTwoWeeksTilDropDead As Date = depDropDead.AddDays(-14)
            Dim depThreeWeeksTilDropDead As Date = depDropDead.AddDays(-21)

            If depLateFlag = 1 And depThreeWeeksTilDropDead < Today() Then
                e.Row.Cells(0).BackColor = Drawing.Color.Yellow
            End If

            If depLateFlag = 1 And depTwoWeeksTilDropDead < Today() Then
                e.Row.Cells(0).BackColor = Drawing.Color.Orange
            End If

            If depLateFlag = 1 And depDropDead < Today() Then
                e.Row.Cells(0).BackColor = Drawing.Color.Red
            End If

            If depCompleteFlag = 1 Then
                e.Row.Cells(0).BackColor = Drawing.Color.Black
                e.Row.Cells(0).ForeColor = Drawing.Color.White

            End If

        End If

    End Sub



    Protected Sub btnMaintainMileStones_Click(sender As Object, e As EventArgs) Handles btnMaintainMileStones.Click
        If dvMileStones.Visible = True Then
            dvMileStones.Visible = False
        Else
            dvMileStones.Visible = True
        End If
    End Sub

    Protected Sub btnHideAddItemForm_Click(sender As Object, e As EventArgs) Handles btnHideAddItemForm.Click
        additem.Style.Add("display", "none")
    End Sub

   
    Protected Sub ddlStatuses_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlStatuses.SelectedIndexChanged
        ' Dim statusFilter As String = ddlStatuses.SelectedValue

        'For Each row As GridViewRow In gvItems.Rows
        'Dim maxStatus As String = TryCast(row.Cells(2).FindControl("hdnMaxStatus"), HiddenField).Value

        'If statusFilter = "%" Then
        ' row.Visible = True
        ' ElseIf maxStatus = statusFilter Then
        'row.Visible = True
        'Else
        'row.Visible = False
        'End If
        'Next

    End Sub

    Protected Sub cbCurrentStatusFilter_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbCurrentStatusFilter.SelectedIndexChanged

        Dim i As Integer = 0


        For Each row As GridViewRow In gvItems.Rows

            Dim maxStatus As String = TryCast(row.Cells(2).FindControl("hdnMaxStatus"), HiddenField).Value

            If cbCurrentStatusFilter.Items.FindByValue("%").Selected Then 'reset the other checkboxes on All selection
                row.Visible = True
                For Each li As ListItem In cbCurrentStatusFilter.Items
                    If li.Selected = True And li.Value <> "%" Then
                        li.Selected = False
                    End If
                Next
            ElseIf cbCurrentStatusFilter.Items.FindByValue(maxStatus).Selected Then
                cbCurrentStatusFilter.Items.FindByValue("%").Selected = False
                row.Visible = True
            Else
                row.Visible = False
            End If
        Next
    End Sub

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnExport.Click
        ExportExcel("SRTExport", gvItems)
    End Sub

    Public Sub ExportExcel(ByVal filename As String, ByVal gv As GridView)

        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=" & filename & ".xls")
        Response.ContentType = "application/vnd.ms-excel"
        Dim sw As New StringWriter()
        Dim htw As New HtmlTextWriter(sw)
        gv.RenderControl(htw)
        Response.Write(sw.ToString())
        Response.[End]()
    End Sub

End Class
