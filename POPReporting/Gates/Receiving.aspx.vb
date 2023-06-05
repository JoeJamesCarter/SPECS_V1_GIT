Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Gates_Receiving
    Inherits System.Web.UI.Page
    Public gatesStatus As New DataTable
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub gvAllFieldsR_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsR.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsGates"), SqlDataSource)

            Dim btnBowCtr As Button = DirectCast(e.Row.FindControl("btnBowCtr"), Button)
            Dim btnPort As Button = DirectCast(e.Row.FindControl("btnPort"), Button)
            Dim btnStrb As Button = DirectCast(e.Row.FindControl("btnStrb"), Button)
            Dim btnAftPort As Button = DirectCast(e.Row.FindControl("btnAftPort"), Button)
            Dim btnAftCtr As Button = DirectCast(e.Row.FindControl("btnAftCtr"), Button)
            Dim btnAftStrb As Button = DirectCast(e.Row.FindControl("btnAftStrb"), Button)
            Dim btnStub As Button = DirectCast(e.Row.FindControl("btnStub"), Button)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try

            If (e.Row.DataItem("WeldDate") < ddlDateSelected.SelectedValue) Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If

            If e.Row.DataItem("BowCtrRcvStatus") = 2 Then
                btnBowCtr.Attributes.Add("style", "background-color:green; color:white;")
            End If

            If e.Row.DataItem("PortRcvStatus") = 2 Then
                btnPort.Attributes.Add("style", "background-color:green; color:white;")
            End If

            If e.Row.DataItem("StrbRcvStatus") = 2 Then
                btnStrb.Attributes.Add("style", "background-color:green; color:white;")
            End If

            If e.Row.DataItem("AftPortRcvStatus") = 2 Then
                btnAftPort.Attributes.Add("style", "background-color:green; color:white;")
            End If

            If e.Row.DataItem("AftCtrRcvStatus") = 2 Then
                btnAftCtr.Attributes.Add("style", "background-color:green; color:white;")
            End If

            If e.Row.DataItem("AftStrbRcvStatus") = 2 Then
                btnAftStrb.Attributes.Add("style", "background-color:green; color:white;")
            End If

            If e.Row.DataItem("StubRcvdStatus") = 2 Then
                btnStub.Attributes.Add("style", "background-color:green; color:white;")
            End If



        End If
    End Sub

    Private Sub gvAllFieldsR_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsR.RowCommand
        If e.CommandName = "bowctr" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                updateStatus(ProdNo, e.CommandName, newstatus)
                checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                updateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "port" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current.ToString = "0" Then
                newstatus = 2
                updateStatus(ProdNo, e.CommandName, newstatus)
                checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current.ToString = "2" Then
                newstatus = 0
                updateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "strb" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                updateStatus(ProdNo, e.CommandName, newstatus)
                checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                updateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "aftport" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                updateStatus(ProdNo, e.CommandName, newstatus)
                checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                updateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "aftctr" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                updateStatus(ProdNo, e.CommandName, newstatus)
                checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                updateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "aftstrb" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                updateStatus(ProdNo, e.CommandName, newstatus)
                checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                updateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "stub" Then
            Dim ProdNo As String = e.CommandArgument
            Dim current As Integer = getCurrentStatus(ProdNo, e.CommandName)
            Dim newstatus As Integer

            If current = 0 Then
                newstatus = 2
                updateStatus(ProdNo, e.CommandName, newstatus)
                checkAndClearFlags(ProdNo, e.CommandName)

            ElseIf current = 2 Then
                newstatus = 0
                updateStatus(ProdNo, e.CommandName, newstatus)
            End If
        End If

        If e.CommandName = "gotorepair" Then 'handles when the repair button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsR.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Repair" 'to pass in the workstation that makes the note.
            Dim url As String = "GateRepair.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1050,height=1000,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoreorder" Then 'handles when the reorder button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsR.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Reorder" 'to pass in the workstation that makes the note.
            Dim ItemNoLbl As Label = gvAllFieldsR.Rows(ID).Cells(1).FindControl("lblItemNo")
            Dim ItemNo As String = ItemNoLbl.Text


            Dim url As String = "GateReorder.aspx?ws=" & workstation & "&ProdNo=" & Selected & "&Model=" & ItemNo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1050,height=1100,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "togglerequested" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsR.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn

            cmd.CommandText = "Select Requested From Gates_ByProdNo Where ProdNo = '" & Selected & "'"
            cmd1.CommandText = "UPDATE Gates_ByProdNo SET Requested = '1' where ProdNo =  '" & Selected & "'"
            cmd2.CommandText = "UPDATE Gates_ByProdNo SET Requested = '0' where ProdNo =  '" & Selected & "'"

            conn.Open()
            Dim currentrequestedvalue As String = cmd.ExecuteScalar

            If currentrequestedvalue = "0" Then
                cmd1.ExecuteNonQuery()
            ElseIf currentrequestedvalue = "1" Then
                cmd2.ExecuteNonQuery()
            End If

            conn.Close()
            gvAllFieldsR.DataBind()

        End If

    End Sub

    Private Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsR.DataBind()
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
            cmd.CommandText = "Update Gates_ByProd set StubRcvdStatus = @newstatus, StubRcvd = @TodaysDate where ProdNo = @ProdNo "
        End If

        cmd.ExecuteNonQuery()

        exists = checkIfExistsInRacks(ProdNo)
        'MesgBox("exists" & exists)
        hasallgates = checkforAllGates(ProdNo)

        If exists = 0 Then 'already in racks, tell them where it is
            lowestEmptyLoc = getLowestEmptyLoc(ProdNo)
            MesgBox("New Location = " & lowestEmptyLoc) 'actually gets the corresponding rail slot
        Else 'not in racks put it in one and tell them where it is
            cmd2.Parameters.AddWithValue("@Slot", exists)
            cmd2.Parameters.AddWithValue("@Today", Date.Now)
            cmd2.CommandText = "Update Gates_KittingLocations set ProdNo = @ProdNo2, DateIn = @Today, InUse = 1 where GatesSlot = @Slot"
            cmd2.ExecuteNonQuery()
            If hasallgates < 3 Then
                MesgBox("Location =  " & exists) 'gate slot in use for this prod
            End If


        End If


        'MesgBox(hasallgates)

        If hasallgates = 1 Then
            cmd1.CommandText = "Update Gates_ByProd Set HasAllGates = 1 where ProdNo = @ProdNo1"
        ElseIf hasallgates = 0 Then
            cmd1.CommandText = "Update Gates_ByProd Set HasAllGates = 0 where ProdNo = @ProdNo1"
        ElseIf hasallgates = 3 Then 'no gates received
            cmd1.CommandText = "Update Gates_ByProd Set HasAllGates = 0 where ProdNo = @ProdNo1"
            resetInUse(ProdNo, exists)
        End If

        cmd1.ExecuteNonQuery()

        conn.Close()

        gvAllFieldsR.DataBind()
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

    Protected Function checkIfExistsInRacks(ProdNo As String) As Integer
        Dim exists As Integer
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd.Parameters.AddWithValue("@ProdNo", ProdNo)

        cmd.CommandText = "Select RailsSlot From Rails_KittingLocations Where InUse = '1' and ProdNo = @ProdNo"

        conn.Open()
        exists = cmd.ExecuteScalar
        conn.Close()

        Return (exists)
    End Function

    Protected Function getLowestEmptyLoc(ProdNo As String) As Integer

        Dim lowestEmptyLoc As Integer
        Dim coorrespondingRailSlot As Integer
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn

        cmd.Parameters.AddWithValue("@ProdNo", ProdNo)
        'cmd.CommandText = "Select Top 1 GatesSlot From Gates_KittingLocations Where InUse = 0"
        cmd.CommandText = "Select RailsSlot From Rails_KittingLocations Where ProdNo = @ProdNo"
        conn.Open()
        'lowestEmptyLoc = cmd.ExecuteScalar
        coorrespondingRailSlot = cmd.ExecuteScalar


        cmd1.Parameters.AddWithValue("@ProdNo", ProdNo)
        cmd1.Parameters.AddWithValue("@Today", Date.Now)
        'cmd1.Parameters.AddWithValue("@LowestEmptySlot", lowestEmptyLoc)
        cmd1.Parameters.AddWithValue("@LowestEmptySlot", coorrespondingRailSlot)

        cmd1.CommandText = "Update Gates_KittingLocations set ProdNo = @ProdNo, DateIn = @Today, InUse = '1' Where GatesSlot = @LowestEmptySlot"
        cmd1.ExecuteNonQuery()
        conn.Close()

        Return (lowestEmptyLoc)
    End Function

    Protected Function resetInUse(ProdNo As String, GatesSlot As Integer) As String
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        cmd.Connection = conn
        conn.ConnectionString = connstr

        cmd.Parameters.AddWithValue("@ProdNo", ProdNo)
        cmd.Parameters.AddWithValue("@GatesSlot", GatesSlot)

        cmd.CommandText = "Update Gates_KittingLocations set InUse = 0, ProdNo = Null Where ProdNo = @ProdNo and GatesSlot = @GatesSlot"

        conn.ConnectionString = connstr
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        Return False
    End Function

    Protected Function checkAndClearFlags(ProdNo As String, GateLocation As String) As String

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd6 As New SqlCommand

        Dim openRepairCount As Integer = 0
        Dim openReorderCount As Integer = 0

        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn

        conn.ConnectionString = connstr

        cmd1.Parameters.AddWithValue("@ProdNo", ProdNo)
        cmd2.Parameters.AddWithValue("@ProdNo2", ProdNo)
        cmd3.Parameters.AddWithValue("@ProdNo3", ProdNo)
        cmd4.Parameters.AddWithValue("@ProdNo4", ProdNo)
        cmd5.Parameters.AddWithValue("@ProdNo5", ProdNo)
        cmd6.Parameters.AddWithValue("@ProdNo6", ProdNo)
        cmd6.Parameters.AddWithValue("@Today", Date.Now)

        cmd1.CommandText = "Select Count (*) From Gates_RepairsReorders where ReReceived = '0' and Type = 'Repair' and ProdNo =  @ProdNo"
        cmd2.CommandText = "Select Count (*) From Gates_RepairsReorders where ReReceived = '0' and Type = 'Reorder' and ProdNo = @ProdNo2"

        cmd3.CommandText = "UPDATE Gates_ByProd SET RepairFlag = '0' where ProdNo =  @ProdNo3"
        cmd4.CommandText = "UPDATE Gates_ByProd SET ReorderFlag = '0' where ProdNo =  @ProdNo4"
        cmd5.CommandText = "Select Count(*) From Gates_RepairsReorders where ReReceived = 0 and ProdNo = @ProdNo5"


        conn.Open()


        Dim unrcvdReOrderOrRepair As Integer = cmd5.ExecuteScalar

        If unrcvdReOrderOrRepair > 0 Then
            If GateLocation = "bowctr" Then
                cmd6.CommandText = "Update Gates_RepairsReorders set ReReceived = 2,ReReceivedDate = @Today where ProdNo = @ProdNo6 and BowCtr = 1"
            End If

            If GateLocation = "port" Then
                cmd6.CommandText = "Update Gates_RepairsReorders set ReReceived = 2,ReReceivedDate = @Today where ProdNo = @ProdNo6 and Port = 1"
            End If

            If GateLocation = "strb" Then
                cmd6.CommandText = "Update Gates_RepairsReorders set ReReceived = 2,ReReceivedDate = @Today where ProdNo = @ProdNo6 and Strb = 1"
            End If

            If GateLocation = "aftport" Then
                cmd6.CommandText = "Update Gates_RepairsReorders set ReReceived = 2, ReReceivedDate = @Today where ProdNo = @ProdNo6 and AftPort = 1"
            End If

            If GateLocation = "aftctr" Then
                cmd6.CommandText = "Update Gates_RepairsReorders set ReReceived = 2, ReReceivedDate = @Today where ProdNo = @ProdNo6 and AftCtr = 1"
            End If

            If GateLocation = "aftstrb" Then
                cmd6.CommandText = "Update Gates_RepairsReorders set ReReceived = 2,  ReReceivedDate = @Today where ProdNo = @ProdNo6 and AftStrb = 1"
            End If


            cmd6.ExecuteNonQuery()
        End If


        openRepairCount = cmd1.ExecuteScalar
        openReorderCount = cmd2.ExecuteScalar


        If openRepairCount = 0 Then
            cmd3.ExecuteNonQuery()
        End If

        If openReorderCount = 0 Then
            cmd4.ExecuteNonQuery()
        End If

        conn.Close()

        gvAllFieldsR.DataBind()

        Return False
    End Function
End Class
