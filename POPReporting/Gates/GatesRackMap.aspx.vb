Imports System.Data
Imports System.Data.SqlClient
Partial Class Gates_GatesRackMap
    Inherits System.Web.UI.Page
    Public ds As New DataTable
    Public slotsWColors As New DataTable
    Public gateWidths As New DataTable
    Public gatesStatus As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        Repeater1.DataBind()

    End Sub

    Protected Function PopulateDataTables() As String

        Dim sqldataadapter As New SqlDataAdapter
        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1

        ''Try
        conn1.Open()
        sqldataadapter.SelectCommand = New SqlCommand("SELECT Left(Drawing,4) as Drawing, Width From Gates Where Disabled = 0", conn1)
        sqldataadapter.Fill(gateWidths)

        conn1.Close()
        conn1.Dispose()

        Return False
    End Function



    Protected Sub gvGatesData_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            'Try
            '    If e.Row.DataItem("CustDrawNo") = "" Then
            '        e.Row.Cells(7).BackColor = System.Drawing.Color.White
            '    Else
            '        e.Row.Cells(7).BackColor = System.Drawing.Color.Yellow
            '    End If
            'Catch ex As Exception

            'End Try

        End If
    End Sub

    Private Sub Repeater1_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then

            If e.Item.DataItem("InUse") = 1 Then
                Dim ProdNo As String = e.Item.DataItem("ProdNo")
                Dim Model As String = e.Item.DataItem("ItemNo") + "SD"
                Dim letters As String
                Dim firsttwo As String = Left(ProdNo, 2)

                If firsttwo = "21" Then
                    letters = "SD"
                ElseIf firsttwo = "22" Then
                    Model = e.Item.DataItem("ItemNo") + "ST"
                    letters = "ST"
                ElseIf firsttwo = "23" Then
                    Model = e.Item.DataItem("ItemNo") + "SP"
                    letters = "SP"
                End If

                'Dim Model As String = e.Item.DataItem("ItemNo")
                Dim imgModel As Image = e.Item.FindControl("Image1")

                imgModel.ImageUrl = "../images/BWLayouts/20" & firsttwo & "/20" & firsttwo & "_BENNINGTON_PONTOON_BOAT_" & Model & ".png"
                'imgModel.ImageUrl = "../images/boatplaceholder.png"
                'imgModel.ImageUrl = "../images/ColorLayouts/20" & lasttwo & "/BENNINGTON_PONTOON_BOATS_20" & lasttwo & "_" & Model & ".png"


                If e.Item.DataItem("InUse").ToString = "1" Then

                    If e.Item.DataItem("Requested").ToString = "1" And
                       (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("HasAllRails").ToString = "1") And
                       e.Item.DataItem("BuildLoc").ToString = "S" Then 'And
                        '(e.Item.DataItem("FurnitureStatus") < 2 Or e.Item.DataItem("FiberglassStatus") < 2 Or e.Item.DataItem("CoversStatus") < 1 Or e.Item.DataItem("TubesStatus") < 2 Or ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0)) Then
                        Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                        sBlock.Attributes.Add("style", "width: 23rem; height: 12rem; background-color:yellow;")
                        'yellowByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "yellow")
                        slotsWColors.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "yellow")

                    ElseIf (e.Item.DataItem("Requested").ToString = "1" Or e.Item.DataItem("Requested").ToString = "0") And
                       e.Item.DataItem("HasAllRails").ToString = "1" And
                       e.Item.DataItem("BuildLoc").ToString = "S" And
                       (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                       e.Item.DataItem("FiberglassStatus") = "2" And
                       e.Item.DataItem("CoversStatus") >= 1 And
                       e.Item.DataItem("TubesStatus") = 2 And
                         e.Item.DataItem("GaugeStatus").ToString = "2" And
                       e.Item.DataItem("HarnessStatus").ToString = "2" And
                       ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                        Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                        sBlock.Attributes.Add("style", "width: 23rem; height: 12rem; background-color:Orange;")
                        'e.Item.BackColor = Drawing.Color.Orange
                        'orangeByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "orange")
                        slotsWColors.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "orange")

                    ElseIf e.Item.DataItem("Requested").ToString = "0" And
                        e.Item.DataItem("HasAllRails").ToString = "0" And
                        e.Item.DataItem("BuildLoc").ToString = "S" And
                        e.Item.DataItem("FurnitureStatus") = "2" And
                        e.Item.DataItem("FiberglassStatus") = "2" And
                        e.Item.DataItem("CoversStatus") >= 1 And
                        e.Item.DataItem("TubesStatus") = 2 And
                        ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                        Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                        sBlock.Attributes.Add("style", "width: 23rem; height: 12rem; background-color:Wheat;")
                        'e.Item.BackColor = Drawing.Color.Orange
                        'cyanByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light cyan")
                        slotsWColors.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "Wheat")

                    ElseIf e.Item.DataItem("HasAllRails") = "0" And
                        (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                        (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                        e.Item.DataItem("FiberglassStatus") = "2" And
                        e.Item.DataItem("CoversStatus") >= 1 And
                        e.Item.DataItem("TubesStatus") = 2 And
                          e.Item.DataItem("GaugeStatus").ToString = "2" And
                       e.Item.DataItem("HarnessStatus").ToString = "2" And
                        ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                        Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                        sBlock.Attributes.Add("style", "width: 23rem; height: 12rem; background-color:LightBlue;")
                        'e.Item.BackColor = Drawing.Color.LightBlue
                        'blueByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light blue")
                        slotsWColors.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light blue")

                    ElseIf e.Item.DataItem("HasAllRails") = "1" And
                        (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                        (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                        e.Item.DataItem("FiberglassStatus") = "2" And
                        e.Item.DataItem("CoversStatus") >= 1 And
                        e.Item.DataItem("TubesStatus") = 2 And
                          e.Item.DataItem("GaugeStatus").ToString = "2" And
                       e.Item.DataItem("HarnessStatus").ToString = "2" And
                        ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                        'e.Item.BackColor = Drawing.Color.LightGreen
                        Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                        sBlock.Attributes.Add("style", "width: 23rem; height: 12rem; background-color:LightGreen;")
                        'lightGreenByProdNo.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light green")
                        slotsWColors.Rows.Add(e.Item.DataItem("RailsSlot"), e.Item.DataItem("ProdNo"), "light green")
                    Else
                        Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                        'sBlock.Attributes.Add("style", "display: none;")
                        'Hide anything that doesn't have a color

                    End If

                End If


                Dim btnB As Button = DirectCast(e.Item.FindControl("btnB"), Button)
                Dim lblBWidth As Label = DirectCast(e.Item.FindControl("lblBWidth"), Label)
                Try
                    lblBWidth.Text = gateWidths.Select("Drawing ='" & btnB.Text & "'")(0)(1)
                Catch
                    If lblBWidth.Text.Length < 0 Then
                        'btnB.Visible = False
                    End If

                End Try

                Dim btnP As Button = DirectCast(e.Item.FindControl("btnP"), Button)
                Dim lblPWidth As Label = DirectCast(e.Item.FindControl("lblPWidth"), Label)
                Try
                    lblPWidth.Text = gateWidths.Select("Drawing ='" & btnP.Text & "'")(0)(1)
                Catch
                    If lblPWidth.Text.Length < 0 Then
                        'btnP.Visible = False
                    End If

                End Try

                Dim btnS As Button = DirectCast(e.Item.FindControl("btnS"), Button)
                Dim lblSWidth As Label = DirectCast(e.Item.FindControl("lblSWidth"), Label)
                Try
                    lblSWidth.Text = gateWidths.Select("Drawing ='" & btnS.Text & "'")(0)(1)
                Catch
                    'btnS.Visible = False
                End Try

                Dim btnAP As Button = DirectCast(e.Item.FindControl("btnAP"), Button)
                Dim lblAPWidth As Label = DirectCast(e.Item.FindControl("lblAPWidth"), Label)
                Try
                    lblAPWidth.Text = gateWidths.Select("Drawing ='" & btnAP.Text & "'")(0)(1)
                Catch
                    'btnAP.Visible = False
                End Try


                Dim btnAC As Button = DirectCast(e.Item.FindControl("btnAC"), Button)
                Dim lblACWidth As Label = DirectCast(e.Item.FindControl("lblACWidth"), Label)
                Try
                    lblACWidth.Text = gateWidths.Select("Drawing ='" & btnAC.Text & "'")(0)(1)
                Catch
                    'btnAC.Visible = False
                End Try

                Dim btnAS As Button = DirectCast(e.Item.FindControl("btnAS"), Button)
                Dim lblASWidth As Label = DirectCast(e.Item.FindControl("lblASWidth"), Label)
                Try
                    lblASWidth.Text = gateWidths.Select("Drawing ='" & btnAS.Text & "'")(0)(1)
                Catch
                    'btnAS.Visible = False
                End Try

                Dim btnStub As Button = DirectCast(e.Item.FindControl("btnStub"), Button)
                Dim lblStubWidth As Label = DirectCast(e.Item.FindControl("lblStubWidth"), Label)
                Try
                    lblStubWidth.Text = gateWidths.Select("Drawing ='" & btnStub.Text & "'")(0)(1)
                Catch
                    'btnAS.Visible = False
                End Try


            End If

        End If
    End Sub



    Private Sub Gates_RackMap1_Load(sender As Object, e As EventArgs) Handles Me.Load
        PopulateDataTables()
        slotsWColors.Columns.Add("slot")
        slotsWColors.Columns.Add("prod")
        slotsWColors.Columns.Add("color")
        slotsWColors.DefaultView.Sort = "prod"
    End Sub

    Private Sub Repeater1_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles Repeater1.ItemCommand
        If e.CommandName = "bowctr" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                UpdateStatus(ProdNo, e.CommandName, newstatus)
                'checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                UpdateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "port" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current.ToString = "0" Then
                newstatus = 2
                UpdateStatus(ProdNo, e.CommandName, newstatus)
                'checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current.ToString = "2" Then
                newstatus = 0
                UpdateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "strb" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                UpdateStatus(ProdNo, e.CommandName, newstatus)
                'checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                UpdateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "aftport" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                UpdateStatus(ProdNo, e.CommandName, newstatus)
                'checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                UpdateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "aftctr" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                UpdateStatus(ProdNo, e.CommandName, newstatus)
                'checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                UpdateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "aftstrb" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                UpdateStatus(ProdNo, e.CommandName, newstatus)
                'checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                UpdateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "stub" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                updateStatus(ProdNo, e.CommandName, newstatus)
                'checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                updateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

    End Sub

    Protected Function getCurrentStatus(ProdNo As String, GateLocation As String) As Integer 'toggle on and off

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr
        cmd.Connection = conn

        Dim currentStatus As Integer

        cmd.Parameters.AddWithValue("@ProdNo", ProdNo)

        If GateLocation = "bowctr" Then
            cmd.CommandText = "Select BowCtrRcvStatus from Gates_ByProd Where ProdNo = @ProdNo"
        ElseIf GateLocation = "port" Then
            cmd.CommandText = "Select PortRcvStatus from Gates_ByProd Where ProdNo = @ProdNo"
        ElseIf GateLocation = "strb" Then
            cmd.CommandText = "Select StrbRcvStatus from Gates_ByProd Where ProdNo = @ProdNo"
        ElseIf GateLocation = "aftport" Then
            cmd.CommandText = "Select AftPortRcvStatus from Gates_ByProd Where ProdNo = @ProdNo"
        ElseIf GateLocation = "aftctr" Then
            cmd.CommandText = "Select AftCtrRcvStatus from Gates_ByProd Where ProdNo = @ProdNo"
        ElseIf GateLocation = "aftstrb" Then
            cmd.CommandText = "Select AftStrbRcvStatus from Gates_ByProd Where ProdNo = @ProdNo"
        ElseIf GateLocation = "stub" Then
            cmd.CommandText = "Select StubRcvdStatus from Gates_ByProd Where ProdNo = @ProdNo"
        End If

        conn.Open()
        currentStatus = cmd.ExecuteScalar
        conn.Close()

        Return (currentStatus)
    End Function

    Protected Function updateStatus(ProdNo As String, GateLocation As String, newstatus As Integer) As String

        Dim TodaysDate As Date = Date.Now

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim hasallgates As Integer = 0
        Dim exists As Integer = 0
        Dim lowestEmptyLoc As Integer = 0

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn

        cmd.Parameters.AddWithValue("@ProdNo", ProdNo)
        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@NewStatus", newstatus)
        cmd1.Parameters.AddWithValue("@ProdNo1", ProdNo)
        cmd2.Parameters.AddWithValue("@ProdNo2", ProdNo)

        conn.ConnectionString = connstr
        conn.Open()

        If GateLocation = "bowctr" Then
            cmd.CommandText = "Update Gates_ByProd set BowCtrRcvStatus = @newstatus, BowCtrRcv = @TodaysDate where ProdNo = @ProdNo "
        ElseIf GateLocation = "port" Then
            cmd.CommandText = "Update Gates_ByProd set PortRcvStatus = @newstatus, PortRcv = @TodaysDate where ProdNo = @ProdNo "
        ElseIf GateLocation = "strb" Then
            cmd.CommandText = "Update Gates_ByProd set StrbRcvStatus = @newstatus, StrbRcv = @TodaysDate where ProdNo = @ProdNo "
        ElseIf GateLocation = "aftport" Then
            cmd.CommandText = "Update Gates_ByProd set AftPortRcvStatus = @newstatus, AftPortRcv = @TodaysDate where ProdNo = @ProdNo "
        ElseIf GateLocation = "aftctr" Then
            cmd.CommandText = "Update Gates_ByProd set AftCtrRcvStatus = @newstatus, AftCtrRcv = @TodaysDate where ProdNo = @ProdNo "
        ElseIf GateLocation = "aftstrb" Then
            cmd.CommandText = "Update Gates_ByProd set AftStrbRcvStatus = @newstatus, AftStrbRcv = @TodaysDate where ProdNo = @ProdNo "
        ElseIf GateLocation = "stub" Then
            cmd.CommandText = "Update Gates_ByProd set StubRcvdStatus = @newstatus, StbRcvd = @TodaysDate where ProdNo = @ProdNo "
        End If

        cmd.ExecuteNonQuery()

        'exists = checkIfExistsInRacks(ProdNo)
        ''MesgBox("exists" & exists)
        hasallgates = checkforAllGates(ProdNo)

        'If exists = 0 Then 'already in racks, tell them where it is
        '    lowestEmptyLoc = getLowestEmptyLoc(ProdNo)
        '    MesgBox("New Location = " & lowestEmptyLoc) 'actually gets the corresponding rail slot
        'Else 'not in racks put it in one and tell them where it is
        '    cmd2.Parameters.AddWithValue("@Slot", exists)
        '    cmd2.Parameters.AddWithValue("@Today", Date.Now)
        '    cmd2.CommandText = "Update Gates_KittingLocations set ProdNo = @ProdNo2, DateIn = @Today, InUse = 1 where GatesSlot = @Slot"
        '    cmd2.ExecuteNonQuery()
        '    If hasallgates < 3 Then
        '        MesgBox("Location =  " & exists) 'gate slot in use for this prod
        '    End If


        'End If


        'MesgBox(hasallgates)

        If hasallgates = 1 Then
            cmd1.CommandText = "Update Gates_ByProd Set HasAllGates = 1 where ProdNo = @ProdNo1"
        ElseIf hasallgates = 0 Then
            cmd1.CommandText = "Update Gates_ByProd Set HasAllGates = 0 where ProdNo = @ProdNo1"
        ElseIf hasallgates = 3 Then 'no gates received
            cmd1.CommandText = "Update Gates_ByProd Set HasAllGates = 0 where ProdNo = @ProdNo1"
            'resetInUse(ProdNo, exists)
        End If

        cmd1.ExecuteNonQuery()

        conn.Close()

        Repeater1.DataBind()
        Return False

    End Function

    Protected Function checkforAllGates(ProdNo As String) As Integer
        Dim gateResult As Integer
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr
        cmd.Connection = conn

        Dim SqlDataAdapter As New SqlDataAdapter

        conn.Open()
        SqlDataAdapter.SelectCommand = New SqlCommand("SELECT NumGates, BowCtrRcvStatus, PortRcvStatus, StrbRcvStatus, AftPortRcvStatus, AftCtrRcvStatus, AftStrbRcvStatus, StubRcvdStatus From Gates_ByProd Where ProdNo = '" & ProdNo & "'", conn)
        SqlDataAdapter.Fill(gatesStatus)


        Dim NumGates As Integer = gatesStatus(0)(0)
        Dim TotalGatesRcv As Integer = 0

        If gatesStatus(0)(1) = 2 Then
            TotalGatesRcv += 1
        End If

        If gatesStatus(0)(2) = 2 Then
            TotalGatesRcv += 1
        End If

        If gatesStatus(0)(3) = 2 Then
            TotalGatesRcv += 1
        End If

        If gatesStatus(0)(4) = 2 Then
            TotalGatesRcv += 1
        End If

        If gatesStatus(0)(5) = 2 Then
            TotalGatesRcv += 1
        End If

        If gatesStatus(0)(6) = 2 Then
            TotalGatesRcv += 1
        End If

        If gatesStatus(0)(7) = 2 Then
            TotalGatesRcv += 1
        End If

        If NumGates = TotalGatesRcv Then
            gateResult = 1
        Else
            gateResult = 0
        End If

        If TotalGatesRcv = 0 Then
            gateResult = 3
        End If

        conn.Dispose()
        conn.Close()

        Return gateResult
    End Function

End Class
