Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports MySql.Data.MySqlClient
Partial Class FurnitureHardwareSouth

    Inherits System.Web.UI.Page

    Public FurnHardwareLines As New DataTable
    Public ProdResults As New DataTable

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
        Dim connstr As String = ConfigurationManager.ConnectionStrings("SPECS_ExternalConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()
        mysqldataadapter.SelectCommand = New MySqlCommand("SELECT OrderLines.ProdNo, ItemNo,StockCode, PartStockCode,PartDesc,PartLineDesc,Color,BO_Flag,RGA_Flag,Qty,RcvdFlag,Job,HardwareReady,CASE When RCVDFlag = 0 Then '0' When RCVDFlag < Qty Then '1' When RCVDFlag = Qty Then '2' END as RCVDGraphic FROM OrderLines left join Live_Boats on OrderLines.ProdNo = Live_Boats.ProdNo WHERE OrderLines.ProdNo > '2103000' and (PartDesc Like '%RECL%' or PartDesc Like '%BASS SEAT%' or PartDesc Like '%BOW GATE BENCH%' or PartDesc Like '%OTTOMAN%' or PartDesc Like '%REFRESHMENT TABLE%' or PartDesc Like '%HELM SEAT%' or PartDesc Like 'LOOSE%' or PartDesc Like '%AFT GATE%')", conn)
        mysqldataadapter.Fill(FurnHardwareLines)

        conn.Close()
        conn.Dispose()

        'For Each row As DataRow In boatsRedFurnM.Rows

        '    Dim prod As String = row("ProdNo").ToString
        '    Dim color As String = row("BaseVinylColor").ToString
        '    Dim hasallrails As Integer = row("HasAllRails")
        '    Dim railsstatus As Integer = row("RailsStatus")

        '    Dim prodShort As String = Right(prod, 5)
        '    Dim view As DataView = veadaShipDataMain.DefaultView
        '    view.RowFilter = "ProdNo = " + prod
        '    If view.Count > 0 Then
        '        MShippedNotRcvd.Rows.Add(prodShort, color, prod)
        '    Else
        '        If hasallrails = 1 Or railsstatus >= 1 Then
        '            MNotShipped.Rows.Add(prodShort, color, prod)
        '        Else
        '            MMissingSomeRails.Rows.Add(prodShort, color, prod)
        '        End If

        '    End If

        'Next

        'For Each row As DataRow In boatsRedFurnS.Rows

        '    Dim prod As String = row("ProdNo").ToString
        '    Dim color As String = row("BaseVinylColor").ToString
        '    Dim hasallrails As Integer = row("HasAllRails")
        '    Dim railsstatus As Integer = row("RailsStatus")

        '    Dim prodShort As String = Right(prod, 5)
        '    Dim view As DataView = veadaShipDataSouth.DefaultView
        '    view.RowFilter = "ProdNo = " + prod
        '    If view.Count > 0 Then
        '        SShippedNotRcvd.Rows.Add(prodShort, color, prod)
        '    Else
        '        If hasallrails = 1 Or railsstatus >= 1 Then
        '            SNotShipped.Rows.Add(prodShort, color, prod)
        '        Else
        '            SMissingSomeRails.Rows.Add(prodShort, color, prod)
        '        End If
        '    End If

        'Next

        'MainPri3.DataSource = MShippedNotRcvd
        'MainPri3.DataBind()

        'SouthPri3.DataSource = SShippedNotRcvd
        'SouthPri3.DataBind()

        'MainPri4.DataSource = MNotShipped
        'MainPri4.DataBind()

        'SouthPri4.DataSource = SNotShipped
        'SouthPri4.DataBind()

        'MainPri5.DataSource = MMissingSomeRails
        'MainPri5.DataBind()

        'SouthPri5.DataSource = SMissingSomeRails
        'SouthPri5.DataBind()

        Return False
    End Function


    Protected Sub gvAllFieldsF_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsF.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFurnitureOptions"), SqlDataSource)
            'Dim u As SqlDataSource = CType(e.Row.FindControl("sdsVendorInfo"), SqlDataSource)

            Dim gvOrderLines As GridView = DirectCast(e.Row.FindControl("gvOrderLines"), GridView)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                'u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

                Dim view As DataView = FurnHardwareLines.DefaultView
                view.RowFilter = "ProdNo = " + e.Row.Cells(0).Text
                If view.Count > 0 Then
                    gvOrderLines.DataSource = view
                    gvOrderLines.DataBind()
                Else

                End If

            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If

            'ProdResults.Rows.Add(e.Row.Cells(0).Text)


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


            Dim rbList As RadioButtonList = DirectCast(gvAllFieldsF.Rows(Key).Cells(5).FindControl("rblFurnitureStatus"), RadioButtonList)
            'set the value of the radio button equal to what it is in the database on load.

            Dim conn As New SqlConnection()
            Dim conn2 As New MySqlConnection()

            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim connstr2 As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=veada;password=4xW)k?dYnUr:x\2(;persistsecurityinfo=True;database=SPECS_External"

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
            'Dim building As String

            conn.ConnectionString = connstr
            conn2.ConnectionString = connstr2

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FurnHwrStatus = '" & rbList.SelectedValue & "' , FurnHwr = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnHwrStatus = 2 and Convert(date,FurnHwr) ='" & ThisDay & "'"
            'to get the count of the prod #'s completed that day as it changes
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"
            'cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '1', DateAllGreen = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "' and FramesInstalled is NULL"
            'if not all green frames can't start, dateallgreen is wiped out only if Frames hasn't started yet.
            'cmd5.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FramesInstalledStatus = '0', DateAllGreen = NULL where ProdNo =  '" & SelectedProdNo & "' and FramesInstalled is NULL"
            'if all green lights are on (covers can be yellow) check if Centertubeneeded is 1 and if CentertubeStatus = 2.  If true, Frames can start.
            cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING where CentertubeNeeded = 1 and ProdNo =  '" & SelectedProdNo & "'"
            cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"
            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"

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

            cmd.ExecuteNonQuery()
            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount
            framesreadytostart = Convert.ToInt16(cmd8.ExecuteScalar)
            framesreadytostartio = Convert.ToInt16(cmd9.ExecuteScalar)
            lblReadytoStart.Text = framesreadytostart
            lblios.Text = framesreadytostartio
            gvAllFieldsF.DataBind()

            conn.Close()

        End If

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

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
        End If



        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnHwrStatus = 2 and Convert(date,FurnHwr) ='" & ThisDay & "'"
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

        ddlBldg.SelectedValue = "S"

        ProdResults.Columns.Add("ProdNo")
        PopulateDataTables()

    End Sub


    Protected Sub gvOrderLines_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "gotoReady" Then
            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim id As Integer = Convert.ToInt16(Line(0))
            Dim SelectedProd As Integer = Line(1)
            Dim SelectedPart As String = Line(2)
            Dim SelectedModel As String = Line(3)
            Dim SelectedColor As String = Line(4)
            Dim SelectedJob As String = Line(5)

            Dim TodaysDate As Date = Date.Now

            Dim ctrl As Control = e.CommandSource
            Dim CurrentRow As GridViewRow = ctrl.NamingContainer

            Dim img As Image = CType(CurrentRow.Cells(3).FindControl("btnReady"), Image)
            Dim hwrvalue = img.ImageUrl
            hwrvalue = Mid(hwrvalue, 17, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.

            Dim flag As Integer = 0

            If hwrvalue = 0 Then
                flag = 1
            ElseIf hwrvalue = 1 Then
                flag = 0
            End If


            Dim conn As New MySqlConnection()
            Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

            Dim cmd As New MySqlCommand
            Dim cmd1 As New MySqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text

            cmd.CommandText = "Update OrderLines Set HardwareReady = '" & flag & "' where ProdNo = '" & SelectedProd & "' and PartDesc = '" & SelectedPart & "' and Color = '" & SelectedColor & "' and Job = '" & SelectedJob & "'"


            cmd.Connection = conn

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            'MesgBox(flag)
            gvAllFieldsF.DataBind()


        End If
    End Sub

    Protected Sub gvOrderLines_RowDataBound(sender As Object, e As GridViewRowEventArgs)

    End Sub


    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsF.DataBind()
    End Sub

End Class

