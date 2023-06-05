Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports MySql.Data.MySqlClient
Imports System.Net.Dns
Imports RestSharp

Partial Class FurniturePrepWLines
    Inherits System.Web.UI.Page

    Public vOrderLines As New DataTable
    Public missinglines As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
        Dim mysqldataadapter As New MySqlDataAdapter

        Dim conn As New MySqlConnection()
        Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

        conn.ConnectionString = connstr

        conn.Open()

        'mysqldataadapter.SelectCommand = New MySqlCommand("SELECT OrderLines.ProdNo, ItemNo,StockCode, PartStockCode,PartDesc,PartLineDesc,Color,BO_Flag,RGA_Flag,Qty,RcvdFlag,Job, CASE When RCVDFlag = 0 Then '0' When RCVDFlag < Qty Then '1' When RCVDFlag = Qty Then '2' END as RCVDGraphic FROM OrderLines right join Live_Boats on OrderLines.ProdNo = Live_Boats.ProdNo Where OrderLines.ProdNo = '" & prodnosearch & "' ", conn)
        mysqldataadapter.SelectCommand = New MySqlCommand("SELECT OrderLines.ProdNo, ItemNo,StockCode, PartStockCode,PartDesc,PartLineDesc,Color,BO_Flag,RGA_Flag,Qty,RcvdFlag,Job, CASE When RCVDFlag = 0 Then '0' When RCVDFlag < Qty Then '1' When RCVDFlag = Qty Then '2' END as RCVDGraphic FROM OrderLines right join Live_Boats on OrderLines.ProdNo = Live_Boats.ProdNo", conn)
        mysqldataadapter.Fill(vOrderLines)

        conn.Close()
        conn.Dispose()
        Return False

    End Function


    Protected Sub gvAllFieldsF_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsF.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFurnitureOptions"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsVendorInfo"), SqlDataSource)
            Dim prod As String = e.Row.Cells(0).Text

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
            ' Try

            'Dim ordLinesResult As DataView = vOrderLines.DefaultView
            'ordLinesResult.RowFilter = "ProdNo =  '" & prod & "'"
            'Dim gvOrderLines As GridView = CType(e.Row.FindControl("gvOrderLines"), GridView)

            'gvOrderLines.DataSource = ordLinesResult
            'gvOrderLines.DataBind()

            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If


        End If

    End Sub


    Protected Sub gvAllFieldsF_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsF.RowCommand

        If e.CommandName = "goto" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsF.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Furniture" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "UpdateFStatus" Then



            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvAllFieldsF.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


            Dim rbList As RadioButtonList = DirectCast(gvAllFieldsF.Rows(Key).Cells(4).FindControl("rblFurnitureStatus"), RadioButtonList)
            'set the value of the radio button equal to what it is in the database on load.

            Dim IsPilot As String = "0"
            Try
                IsPilot = CType(gvAllFieldsF.Rows(Key).FindControl("pilotflag"), HiddenField).Value.ToString
            Catch
            End Try

            Dim model As String = CType(gvAllFieldsF.Rows(Key).FindControl("Label2"), Label).Text

            Dim conn As New SqlConnection()
            Dim conn2 As New MySqlConnection()

            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim connstr2 As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand
            Dim cmd6 As New SqlCommand
            Dim cmd7 As New SqlCommand
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand
            Dim cmd10 As New MySqlCommand
            Dim cmd11 As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim greenlightcount As Int16 = 0
            Dim tubeneeded As Int16 = 0
            Dim tubecomplete As Int16 = 0
            Dim framesreadytostart As Int16
            Dim framesreadytostartio As Int16
            Dim building As String

            conn.ConnectionString = connstr
            conn2.ConnectionString = connstr2

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FurnitureStatus = '" & rbList.SelectedValue & "' , FurniturePrepLastUpdated = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus = 2 and Convert(date,FurniturePrepLastUpdated) ='" & ThisDay & "'"
            'to get the count of the prod #'s completed that day as it changes
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '1', DateAllGreen = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "' and FramesInstalled is NULL"
            'if not all green frames can't start, dateallgreen is wiped out only if Frames hasn't started yet.
            cmd5.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '0', DateAllGreen = NULL where ProdNo =  '" & SelectedProdNo & "' and FramesInstalled is NULL"
            'if all green lights are on (covers can be yellow) check if Centertubeneeded is 1 and if CentertubeStatus = 2.  If true, Frames can start.
            cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING where CentertubeNeeded = 1 and ProdNo =  '" & SelectedProdNo & "'"
            cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"
            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
            cmd10.CommandText = "Update Greenlights SET F_Status = '" & rbList.SelectedValue & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd11.CommandText = "Select BuildLoc FROM BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd6.Connection = conn
            cmd7.Connection = conn
            cmd8.Connection = conn
            cmd9.Connection = conn
            cmd10.Connection = conn2
            cmd11.Connection = conn

            conn.Open()
            'MesgBox(rbList.SelectedValue)
            'MesgBox(Key)
            'MesgBox(SelectedProdNo)
            cmd.ExecuteNonQuery()
            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount
            framesreadytostart = Convert.ToInt16(cmd8.ExecuteScalar)
            framesreadytostartio = Convert.ToInt16(cmd9.ExecuteScalar)
            lblReadytoStart.Text = framesreadytostart
            lblios.Text = framesreadytostartio

            If IsPilot = "1" And rbList.SelectedValue = 2 Then
                PostToTeams(SelectedProdNo, "Furniture Rcv", model)
            End If

            gvAllFieldsF.DataBind()


                conn.Close()
                conn2.Open()
                cmd10.ExecuteNonQuery()
                conn2.Close()
            End If

            If e.CommandName = "addInternalRGA" Then

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim SelectedProd As Integer = Line(1)
            Dim SelectedPart As String = Line(2)
            Dim SelectedModel As String = Line(3)
            Dim SelectedColor As String = Line(4)
            Dim SelectedLineQty As String = Line(5)
            'Dim SelectedJob As String = Line(6)

            Dim url As String = "./FurnitureInternalRGA.aspx?prod=" & SelectedProd & "&model=" & SelectedModel & "&color=" & SelectedColor & "&part=" & SelectedPart
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "addMissingLines" Then

            Dim ProdNo As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim mysqldataadapterSource As New MySqlDataAdapter

            Dim connSource As New MySqlConnection
            Dim connTarget As New MySqlConnection

            Dim connSourceConnStr = "server=veada-mysql-082019.cz8vw0a6whxb.us-east-1.rds.amazonaws.com;user id=BennDataPartner;password=DISH4087sky$$;persistsecurityinfo=True;database=vea_0819_dbshare"
            Dim connTargetConnStr = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

            connSource.ConnectionString = connSourceConnStr
            connTarget.ConnectionString = connTargetConnStr


            mysqldataadapterSource.SelectCommand = New MySqlCommand("Select * From BennPOLines Where ProdNo =  '" & ProdNo & "'", connSource)

            'Try
            mysqldataadapterSource.Fill(missinglines)

            Dim dtDistinctPartStockCode As DataTable = GetDistinctRecords(missinglines, {"ProdNo", "StockCode", "PartStockCode", "PartDesc", "PartLineDesc", "Color", "Quantity", "BuildDate", "ShipDate", "Job"})

            'gvTest.DataSource = dtDistinctPartStockCode
            'gvTest.DataBind()


            'MesgBox(dtDistinctPartStockCode.Rows.Count)

            connTarget.Open()
            For Each row As DataRow In dtDistinctPartStockCode.Rows

                Dim cmd As New MySqlCommand

                Dim StockCodeInsert As String = row("StockCode")
                Dim ColorInsert As String = row("Color")
                Dim PartLineDescInsert As String = row("PartLineDesc")

                If StockCodeInsert Is Nothing Then
                    StockCodeInsert = vbNull
                End If

                If ColorInsert Is Nothing Then
                    ColorInsert = vbNull
                End If

                If PartLineDescInsert Is Nothing Then
                    PartLineDescInsert = vbNull
                End If


                cmd.Parameters.AddWithValue("@ProdNo", Trim(row("ProdNo")))
                cmd.Parameters.AddWithValue("@StockCode", Trim(StockCodeInsert))
                cmd.Parameters.AddWithValue("@PartStockCode", Trim(row("PartStockCode")))
                cmd.Parameters.AddWithValue("@PartDesc", Trim(row("PartDesc")))
                cmd.Parameters.AddWithValue("@PartLineDesc", Trim(PartLineDescInsert))
                cmd.Parameters.AddWithValue("@Color", Trim(ColorInsert))
                cmd.Parameters.AddWithValue("@Quantity", Trim(row("Quantity")))
                cmd.Parameters.AddWithValue("@BuildDate", Trim(row("BuildDate")))
                cmd.Parameters.AddWithValue("@ShipDate", Trim(row("ShipDate")))
                cmd.Parameters.AddWithValue("@Job", Trim(row("Job")))


                'cmd.CommandText = "Insert INTO OrderLines (ProdNo, StockCode, PartStockCode, PartDesc, PartLineDesc, Color, Qty, RcvdFlag, RGA_Flag, BO_Flag, BuildDate, ShipDate, Job, HardwareReady) Values (@ProdNo, @StockCode, @PartStockCode, @PartDesc, @PartLineDesc, @Color, @Quantity, 0,0,0, @BuildDate, @ShipDate,0)"
                cmd.CommandText = "Insert INTO OrderLines (ProdNo, StockCode, PartStockCode, PartDesc, PartLineDesc, Color, Qty, BuildDate, ShipDate, Job) Values (@ProdNo, @StockCode, @PartStockCode, @PartDesc, @PartLineDesc, @Color, @Quantity, @BuildDate, @ShipDate, @Job)"
                cmd.Connection = connTarget

                Try
                    cmd.ExecuteNonQuery()

                Catch ex As Exception
                    'MesgBox(Err.ToString)
                End Try

            Next row
            'gvAllFieldsF.DataBind()
            connTarget.Close()

            'Catch
            'End Try


        End If

    End Sub

    Public Shared Function GetDistinctRecords(ByVal dt As DataTable, ByVal Columns As String()) As DataTable
        Dim dtUniqRecords As DataTable = New DataTable()
        dtUniqRecords = dt.DefaultView.ToTable(True, Columns)
        Return dtUniqRecords
    End Function

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        'PopulateDataTables()

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String
        Dim framesreadytostart As Int16
        Dim framesreadytostartio As Int16

        If ddlDaysInAdvance.Items.Count = 0 Then  'stop it from repopulating everytime the grid rebinds
            DaystoShow = ThisDay.AddDays(5).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("3 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(7).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("5 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(12).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("10 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(17).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("15 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(22).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("20 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(62).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("60 Days", DaystoShow))
        End If



        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus = 2 and Convert(date,FurniturePrepLastUpdated) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount
        framesreadytostart = Convert.ToInt16(cmd3.ExecuteScalar)
        framesreadytostartio = Convert.ToInt16(cmd4.ExecuteScalar)

        lblReadytoStart.Text = framesreadytostart
        lblios.Text = framesreadytostartio
        'MesgBox(recordcount)
        conn.Close()


    End Sub




    Protected Sub gvOrderLines_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        If e.CommandName = "addBO" Then
            'This code is for the update button

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim SelectedProd As Integer = Line(1)
            Dim SelectedPart As String = Line(2)
            Dim SelectedModel As String = Line(3)
            Dim SelectedColor As String = Line(4)
            Dim SelectedJob As String = Line(5)
            Dim TodaysDate As Date = DateTime.Now.ToString("yyyy-MM-dd")
            Dim i As Integer = 0

            Dim ctrl As Control = e.CommandSource
            Dim CurrentRow As GridViewRow = ctrl.NamingContainer

            'Dim qty As String = TryCast(CurrentRow.Cells(3).FindControl("tbQty"), TextBox).Text
            Dim qty = DirectCast(CurrentRow.Cells(3).FindControl("ddlqtys"), DropDownList).SelectedValue

            Dim conn As New MySqlConnection()
            Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

            Dim cmd As New MySqlCommand
            Dim cmd1 As New MySqlCommand

            Dim building As String = ddlBldg.SelectedValue
            Dim user As String

            If building = "S" Then
                user = "JROMERO"
            ElseIf building = "M" Then
                user = "BALLEN"
            Else
                user = "BENNI"
            End If

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update OrderLines Set BO_Flag = '1' where ProdNo = '" & SelectedProd & "' and PartDesc = '" & SelectedPart & "' and Color = '" & SelectedColor & "' and Job = '" & SelectedJob & "'"
            cmd1.CommandText = "Insert into Backorders (ProdNo,Model,Color,BO_Item_Desc,Date_Added,Added_By,Cleared) Values ('" & SelectedProd & "', '" & SelectedModel & "', '" & SelectedColor & "', '" & SelectedPart & "', '" & TodaysDate.ToString("yyyy-MM-dd") & "', '" & user & "', '0')"

            cmd.Connection = conn
            cmd1.Connection = conn
            conn.Open()


            If qty = 0 Then
                'don't do anything
            ElseIf qty = 1 Then
                cmd.ExecuteNonQuery()
                cmd1.ExecuteNonQuery()
            ElseIf qty > 1 Then
                cmd.ExecuteNonQuery()
                For i = 1 To qty
                    cmd1.ExecuteNonQuery()
                Next
            End If
            conn.Close()

            gvAllFieldsF.DataBind()

        End If

        If e.CommandName = "showaddRGA" Then
            Dim ctrl As Control = e.CommandSource
            Dim CurrentRow As GridViewRow = ctrl.NamingContainer
            CurrentRow.Cells(7).Visible = True
        End If



        If e.CommandName = "addRGA" Then
            'This code is for the update button

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim SelectedProd As Integer = Line(1)
            Dim SelectedPart As String = Line(2)
            Dim SelectedModel As String = Line(3)
            Dim SelectedColor As String = Line(4)
            Dim SelectedJob As String = Line(5)

            Dim TodaysDate As Date = Date.Now.ToString("yyyy-MM-dd")
            Dim j As Integer = 0

            Dim ctrl As Control = e.CommandSource
            Dim CurrentRow As GridViewRow = ctrl.NamingContainer

            'Dim qty As String = TryCast(CurrentRow.Cells(3).FindControl("tbQty"), TextBox).Text
            Dim qty = DirectCast(CurrentRow.Cells(3).FindControl("ddlqtys"), DropDownList).SelectedValue

            Dim who = DirectCast(CurrentRow.Cells(7).FindControl("ddlWhoDoneIt"), DropDownList).SelectedValue
            Dim priority = DirectCast(CurrentRow.Cells(7).FindControl("ddlStatus"), DropDownList).SelectedValue
            Dim reason As String = TryCast(CurrentRow.Cells(7).FindControl("tbReason"), TextBox).Text


            Dim building As String = ddlBldg.SelectedValue
            Dim user As String

            If building = "S" Then
                user = "JROMERO"
            ElseIf building = "M" Then
                user = "BGIRTEN"
            Else
                user = "BENNI"
            End If

            Dim conn As New MySqlConnection()
            Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

            Dim cmd As New MySqlCommand
            Dim cmd1 As New MySqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update OrderLines Set RGA_Flag = '1' where ProdNo = '" & SelectedProd & "' and PartDesc = '" & SelectedPart & "' and Job = '" & SelectedJob & "'"
            cmd1.CommandText = "Insert into RGAs (ProdNo, Model,Color,Accent,RGA_Item_Desc,Qty,Reason,DamagedBy,Priority,Added_By,Date_Added) Values ('" & SelectedProd & "' , '" & SelectedModel & "', '" & SelectedColor & "',' ', '" & SelectedPart & "','" & qty & "' ,'" & reason & "','" & who & "','" & priority & "','" & user & "','" & TodaysDate.ToString("yyyy-MM-dd") & "')"

            cmd.Connection = conn
            cmd1.Connection = conn


            conn.Open()

            If (reason.Length > 0 And priority.Length > 0 And who.Length > 0) Then
                cmd.ExecuteNonQuery()
                If qty = 0 Then

                ElseIf qty = 1 Then
                    cmd1.ExecuteNonQuery()
                ElseIf qty > 1 Then
                    For j = 1 To qty
                        cmd1.ExecuteNonQuery()
                    Next
                End If
                gvAllFieldsF.DataBind()
                CurrentRow.Cells(7).Visible = False

            Else
                MesgBox("Please make sure you have added a reason, damaged by and status.")
            End If

            conn.Close()

        End If

        If e.CommandName = "addRCVD" Then

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim SelectedProd As Integer = Line(1)
            Dim SelectedPart As String = Line(2)
            Dim SelectedModel As String = Line(3)
            Dim SelectedColor As String = Line(4)
            Dim SelectedLineQty As String = Line(5)
            Dim SelectedJob As String = Line(6)

            Dim TodaysDate As Date = Date.Now

            Dim ctrl As Control = e.CommandSource
            Dim CurrentRow As GridViewRow = ctrl.NamingContainer

            Dim img As Image = CType(CurrentRow.Cells(6).FindControl("btnRcvd"), Image)

            'Dim rcvdvalue = img.ImageUrl
            'rcvdvalue = Mid(rcvdvalue, 14, 1) 'get the value of RCVDFlag from the imageurl.

            Dim qty = DirectCast(CurrentRow.Cells(3).FindControl("ddlqtys"), DropDownList).SelectedValue

            Dim conn As New MySqlConnection()
            Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

            Dim cmd As New MySqlCommand
            Dim cmd1 As New MySqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update OrderLines Set RCVDFlag = '" & qty & "' where ProdNo = '" & SelectedProd & "' and PartDesc = '" & SelectedPart & "' and Color = '" & SelectedColor & "' and Job = '" & SelectedJob & "'"

            cmd.Connection = conn

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvAllFieldsF.DataBind()
        End If

    End Sub

    Protected Sub gvOrderLines_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim qty As Integer = e.Row.DataItem("Qty")
            Dim ddl = DirectCast(e.Row.FindControl("ddlqtys"), DropDownList)
            Dim i As Integer = 0

            For i = 0 To qty
                ddl.Items.Add(New ListItem(i, i))
            Next

            ddl.SelectedValue = qty
        End If
        e.Row.Cells(7).Visible = False

    End Sub


    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsF.DataBind()
    End Sub

    Private Sub tbSearch_TextChanged(sender As Object, e As EventArgs) Handles tbSearch.TextChanged

        'If Not IsPostBack Then
        'Dim prodNoSearch As String = tbSearch.Text
        'PopulateDataTables(prodNoSearch)
        'End If

    End Sub

    Private Sub PostToTeams(Prod As String, WS As String, Model As String)
        Dim client = New RestClient("https://polarisind.webhook.office.com/webhookb2/575d63df-68ca-4f80-b5fb-d8178ab3d75e@85f78c4c-ad11-4735-9624-0b2c11611dff/IncomingWebhook/00a5cf25dbae454186a1118808e8ba29/e21f1092-8010-45f9-b419-50aa3efc4b1f")
        client.Timeout = -1
        Dim request = New RestRequest(Method.POST)
        request.AddHeader("Content-Type", "application/json")
        request.AddParameter("application/json", "{" & vbCrLf & "    ""@context"": ""https://schema.org/extensions""," & vbCrLf & "    ""@type"": ""MessageCard""," & vbCrLf & "    ""themeColor"": ""0072C6""," & vbCrLf & "    ""title"": ""Prod #: " & Prod & "    Model:  " & Model & " ""," & vbCrLf & "    ""text"": ""Prod #:  " & Prod & "  Has Just Completed Through  " & WS & " .""" & vbCrLf & "    " & vbCrLf & "}", ParameterType.RequestBody)
        Dim response As IRestResponse = client.Execute(request)
        Console.WriteLine(response.Content)
    End Sub
End Class
