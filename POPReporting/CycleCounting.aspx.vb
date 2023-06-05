Imports System.Data
Imports System.Data.SqlClient

Partial Class CycleCounting
    Inherits System.Web.UI.Page

    Public Shared stationID As String

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

    Private Sub Test2_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
            stationID = SplitBValSlash(user)
            stationID = stationID.ToUpper

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            hdnToday.Value = ThisDay
            byloc.Visible = False
            bypart.Visible = False
            bypartPPL.Visible = False
            counttoday.Visible = False
            weeks.Visible = False
            gvPPLList.Visible = False

        End If

    End Sub

    Private Sub btnCountToday_Click(sender As Object, e As EventArgs) Handles btnCountToday.Click
        counttoday.Visible = True
        btnCountToday.Attributes.Add("class", "btn btn-primary m-1")
        btnByLoc.Attributes.Add("class", "btn btn-outline-primary m-1")
        btnByPart.Attributes.Add("class", "btn btn-outline-primary m-1")
        byloc.Visible = False
        bypart.Visible = False
        bypartPPL.Visible = False
        Dim btn As Button = CType(sender, Button)

        'MesgBox(btn.ID)
    End Sub

    Private Sub btnByLoc_Click(sender As Object, e As EventArgs) Handles btnByLoc.Click
        btnByLoc.Attributes.Add("class", "btn btn-primary m-1")
        btnCountToday.Attributes.Add("class", "btn btn-outline-primary m-1")
        btnByPart.Attributes.Add("class", "btn btn-outline-primary m-1")
        byloc.Visible = True
        bypart.Visible = False
        bypartPPL.Visible = False 'revisit this after hearing from Jeff
        counttoday.Visible = False
    End Sub

    Private Sub btnByPart_Click(sender As Object, e As EventArgs) Handles btnByPart.Click
        btnByPart.Attributes.Add("class", "btn btn-primary m-1")
        btnCountToday.Attributes.Add("class", "btn btn-outline-primary m-1")
        btnByLoc.Attributes.Add("class", "btn btn-outline-primary m-1")
        byloc.Visible = False

        If hdnCounterID.Value = 1 Then
            bypartPPL.Visible = True
        ElseIf hdnCounterID.Value = 2 Then
            bypart.Visible = True
        End If


        counttoday.Visible = False
    End Sub

    Private Sub btnCounter1_Click(sender As Object, e As EventArgs) Handles btnCounter1.Click
        hdnCounterID.Value = 1
        btnCounter2.Attributes.Add("class", "btn btn-outline-primary btn-sm float-left m-1")
        btnCounter1.Attributes.Add("class", "btn btn-primary btn-sm m-1 float-left")
        gvCounter.Visible = True
        gvCounterYellow.Visible = False
        weeks.Visible = True
        gvPPLList.Visible = True


    End Sub

    Private Sub btnCounter2_Click(sender As Object, e As EventArgs) Handles btnCounter2.Click
        hdnCounterID.Value = 2
        btnCounter2.Attributes.Add("class", "btn btn-primary btn-sm float-left m-1")
        btnCounter1.Attributes.Add("class", "btn btn-outline-primary btn-sm m-1 float-left")
        gvCounter.Visible = True
        gvCounterYellow.Visible = True
        weeks.Visible = False
        gvPPLList.Visible = False

    End Sub

    Protected Sub gvPartsInLoc_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvPartsInLoc.RowCommand
        If e.CommandName = "saveByLoc" Then

            Dim TodaysDate As Date = Date.Now
            Dim ID As String = e.CommandArgument 'get the row that is clicked

            Dim PartNo As String = DirectCast(gvPartsInLoc.Rows(ID).Cells(0).FindControl("lblPartNo"), Label).Text 'find the prod # in that row to use in the update command
            Dim areaID As String = ddlPhyInvLocs.SelectedValue
            Dim CountedBy As String = stationID

            Dim tbSetQty As TextBox = DirectCast(gvPartsInLoc.Rows(ID).Cells(1).FindControl("tbSetQty"), TextBox)
            'Dim qty As String = tbQty.Text
            Dim qty As String = tbSetQty.Text

            'tbSetQty.Text = qty

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.CommandType = CommandType.Text

            cmd.Parameters.AddWithValue("@PartNo", PartNo)
            cmd.Parameters.AddWithValue("@AreaID", areaID)
            cmd.Parameters.AddWithValue("@Today", TodaysDate)
            cmd.Parameters.AddWithValue("@Qty", qty)
            cmd.Parameters.AddWithValue("@CountedBy", CountedBy)

            cmd.CommandText = "Insert into CycleCounts(PartNo, Counted, Qty, Area, CountedBy) Values (@PartNo, @Today, @Qty, @AreaID, @CountedBy)"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            gvPartsInLoc.DataBind()
        End If

    End Sub
    Protected Sub btnClearSearch_Click(sender As Object, e As EventArgs) Handles btnClearSearch.Click
        tbPartSearch.Text = ""
    End Sub
    Protected Sub gvPartSearch_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvPartSearch.RowCommand

        If e.CommandName = "save" Then
            Dim TodaysDate As Date = Date.Now
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim PartNoLbl As Label = DirectCast(gvPartSearch.Rows(ID).Cells(0).FindControl("lblItemNo"), Label)
            Dim PartNo As String = PartNoLbl.Text

            Dim tbSetQty As TextBox = DirectCast(gvPartSearch.Rows(ID).Cells(0).FindControl("tbSetQtyPartSearch"), TextBox)
            Dim tbSetArea As TextBox = FindControl("tbSetArea")
            Dim qty As String = tbSetQty.Text
            Dim areaID As String = tbSetArea.Text
            Dim CountedBy As String = stationID

            'check for area blank
            If areaID.Length > 0 And qty.Length > 0 Then
                Dim conn As New SqlConnection()
                Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
                Dim cmd As New SqlCommand
                conn.ConnectionString = connstr
                cmd.Connection = conn
                cmd.CommandType = CommandType.Text

                cmd.Parameters.AddWithValue("@PartNo", PartNo)
                cmd.Parameters.AddWithValue("@AreaID", areaID)
                cmd.Parameters.AddWithValue("@Today", TodaysDate)
                cmd.Parameters.AddWithValue("@Qty", qty)
                cmd.Parameters.AddWithValue("@CountedBy", CountedBy)

                cmd.CommandText = "Insert into CycleCounts(PartNo, Counted, Qty, Area, CountedBy) Values (@PartNo, @Today, @Qty, @AreaID, @CountedBy)"
                conn.Open()
                cmd.ExecuteNonQuery()
                conn.Close()

            End If
            tbPartSearch.Text = ""
            tbSetQty.Text = ""
            tbPartSearch.Focus()

            gvPartSearch.DataBind()
        End If

    End Sub

    Private Sub gvCounter_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvCounter.RowCommand
        If e.CommandName = "countersave" Then

            Dim TodaysDate As Date = Date.Now
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim tbQtyByCounter As TextBox = DirectCast(gvCounter.Rows(ID).Cells(0).FindControl("tbQtyByCounter"), TextBox)
            Dim tbAreaByCounter As TextBox = DirectCast(gvCounter.Rows(ID).Cells(0).FindControl("tbAreaByCounter"), TextBox)
            Dim AutoIDField As HiddenField = DirectCast(gvCounter.Rows(ID).FindControl("hdnAutoID"), HiddenField)

            Dim AutoID As String = AutoIDField.Value
            Dim areaID As String = Trim(tbAreaByCounter.Text)
            Dim qty As String = tbQtyByCounter.Text
            Dim PartNoLbl As Label = DirectCast(gvCounter.Rows(ID).Cells(0).FindControl("lblPartNo"), Label)
            Dim PartNo As String = PartNoLbl.Text
            Dim CountedBy As String = stationID

            'check for area blank
            If qty.Length > 0 Then
                'If areaID.Length = 4 And qty.Length > 0 Then
                Dim conn As New SqlConnection()
                Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
                Dim cmd As New SqlCommand
                Dim cmd1 As New SqlCommand
                Dim cmd2 As New SqlCommand

                conn.ConnectionString = connstr
                cmd.Connection = conn
                cmd1.Connection = conn
                cmd2.Connection = conn

                cmd.Parameters.AddWithValue("@PartNo", PartNo)
                cmd.Parameters.AddWithValue("@Today", TodaysDate)

                cmd1.Parameters.AddWithValue("@PartNo1", PartNo)
                cmd1.Parameters.AddWithValue("@AreaID1", areaID)
                cmd1.Parameters.AddWithValue("@Today1", TodaysDate)
                cmd1.Parameters.AddWithValue("@Qty1", qty)
                cmd1.Parameters.AddWithValue("@CountedBy1", CountedBy)
                cmd1.Parameters.AddWithValue("@AutoID1", AutoID)

                cmd2.Parameters.AddWithValue("@PartNo2", PartNo)
                cmd2.Parameters.AddWithValue("@AreaID2", areaID)
                cmd2.Parameters.AddWithValue("@Today2", TodaysDate)
                cmd2.Parameters.AddWithValue("@Qty2", qty)
                cmd2.Parameters.AddWithValue("@CountedBy2", CountedBy)
                cmd2.Parameters.AddWithValue("@AutoID2", AutoID)
                cmd2.Parameters.AddWithValue("@CounterID2", hdnCounterID.Value)

                cmd.CommandText = "Select Count(PartNo) from CycleCounts where PartNo = @PartNo and DateToCount = @Today and Qty is Null"
                cmd1.CommandText = "Update CycleCounts Set Counted = @Today1, Qty = @Qty1, Area = @AreaID1, CountedBy = @CountedBy1 where AutoID = @AutoID1 and Qty Is Null"
                cmd2.CommandText = "Insert into CycleCounts(PartNo, Counted, Qty, Area, CountedBy, CounterID) Values (@PartNo2, @Today2, @Qty2, @AreaID2, @CountedBy2, @CounterID2)"

                conn.Open()
                Dim count As Integer = cmd.ExecuteScalar()

                If count = 1 Then
                    cmd1.ExecuteNonQuery()
                Else
                    cmd2.ExecuteNonQuery()
                End If

                conn.Close()


            End If
            gvCounter.DataBind()



        End If

    End Sub

    Protected Sub gvCounter2Yellow_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvCounterYellow.RowCommand 'Insert Instead of Update for South Watch List
        If e.CommandName = "counterYsave" Then
            Dim TodaysDate As Date = Date.Now
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim tbQtyByCounterY As TextBox = DirectCast(gvCounterYellow.Rows(ID).Cells(0).FindControl("tbQtyByCounterY"), TextBox)
            Dim tbAreaByCounterY As TextBox = DirectCast(gvCounterYellow.Rows(ID).Cells(0).FindControl("tbAreaByCounterY"), TextBox)

            Dim areaID As String = Trim(tbAreaByCounterY.Text)
            Dim qty As String = tbQtyByCounterY.Text
            Dim PartNoLbl As Label = DirectCast(gvCounterYellow.Rows(ID).Cells(0).FindControl("lblPartNo"), Label)
            Dim PartNo As String = PartNoLbl.Text
            Dim CountedBy As String = stationID

            'check for area blank
            If qty.Length > 0 Then
                ' If areaID.Length = 4 And qty.Length > 0 Then
                Dim conn As New SqlConnection()
                Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
                Dim cmd As New SqlCommand
                conn.ConnectionString = connstr
                cmd.Connection = conn
                cmd.CommandType = CommandType.Text

                cmd.Parameters.AddWithValue("@PartNo", PartNo)
                cmd.Parameters.AddWithValue("@AreaID", areaID)
                cmd.Parameters.AddWithValue("@Today", TodaysDate)
                cmd.Parameters.AddWithValue("@Qty", qty)
                cmd.Parameters.AddWithValue("@CountedBy", CountedBy)
                cmd.Parameters.AddWithValue("@CounterID", hdnCounterID.Value)


                cmd.CommandText = "Insert into CycleCounts(PartNo, Counted, Qty, Area, CountedBy, CounterID) Values (@PartNo, @Today, @Qty, @AreaID, @CountedBy, @CounterID)"
                conn.Open()
                cmd.ExecuteNonQuery()
                conn.Close()

            End If
            gvCounterYellow.DataBind()

        End If
    End Sub

    Private Sub gvPPLList_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvPPLList.RowCommand
        If e.CommandName = "calcandsave" Then
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim tbPPLQty As TextBox = DirectCast(gvPPLList.Rows(ID).Cells(0).FindControl("tbPPLQty"), TextBox)
            Dim tbText As String = tbPPLQty.Text
            Dim a As Integer = 0
            Dim b As Integer = 0
            Dim qty As Integer
            Dim TodaysDate As Date = Date.Now
            Dim PartNoLbl As Label = DirectCast(gvPPLList.Rows(ID).Cells(0).FindControl("lblPPLPartNo"), Label)
            Dim PartNo As String = PartNoLbl.Text
            Dim CountedBy As String = stationID
            Dim PartLocRbl As RadioButtonList = DirectCast(gvPPLList.Rows(ID).Cells(0).FindControl("rblLocations"), RadioButtonList)
            Dim partloc As String = PartLocRbl.SelectedValue
            Dim tbOtherLoc As TextBox = DirectCast(gvPPLList.Rows(ID).Cells(0).FindControl("tbOtherLoc"), TextBox)
            Dim loc As String = vbNull
            Dim gvPPLCountToday As GridView = DirectCast(gvPPLList.Rows(ID).Cells(0).FindControl("gvPPLCountToday"), GridView)

            ' calc multiply and add if needed  
            If tbPPLQty.Text.Length = 0 Then
                MesgBox("Please enter a qty.")

            ElseIf tbText Like "*x*" Then
                a = tbText.Split("x")(0)
                b = tbText.Split("x")(1)
                qty = a * b
                tbPPLQty.Text = qty

            ElseIf tbText Like "*+*" Then
                a = tbText.Split("+")(0)
                b = tbText.Split("+")(1)
                qty = a + b
                tbPPLQty.Text = qty
            Else
                qty = tbPPLQty.Text
            End If

            ''check for loc blank - sometimes he doesn't have a loc though
            'If (PartLocRbl.SelectedIndex = -1 Or tbOtherLoc.Text.Length < 0) Then
            '    MesgBox("Please select or enter a location.")
            'Else

            If PartLocRbl.SelectedIndex > -1 Then
                loc = PartLocRbl.SelectedItem.Text
            ElseIf tbOtherLoc.Text.Length > 0 Then
                loc = tbOtherLoc.Text
            End If

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn

            cmd.Parameters.AddWithValue("@PartNo", PartNo)
            cmd.Parameters.AddWithValue("@LocNote", loc)
            cmd.Parameters.AddWithValue("@Qty", qty)
            cmd.Parameters.AddWithValue("@Today", TodaysDate)

            cmd1.Parameters.AddWithValue("@PartNo1", PartNo)
            cmd1.Parameters.AddWithValue("@LocNote1", loc)

            cmd.CommandText = "Insert into PPL_PartCounts (ItemNo, LocNote, Qty, CountDate) Values (@PartNo, @LocNote, @Qty, @Today)"
            cmd1.CommandText = "Insert into PPL_PartLocNotes(ItemNo, Note) Values (@PartNo1, @LocNote1)"

            conn.Open()

            cmd.ExecuteNonQuery()

            If tbOtherLoc.Text.Length > 0 Then
                Try
                    cmd1.ExecuteNonQuery()
                    PartLocRbl.DataBind()
                Catch
                End Try

            End If

            conn.Close()
            gvPPLCountToday.DataBind()
            tbOtherLoc.Text = ""
            tbPPLQty.Text = ""


        End If
    End Sub

    Private Sub gvPPLList_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvPPLList.RowDataBound

    End Sub
End Class

