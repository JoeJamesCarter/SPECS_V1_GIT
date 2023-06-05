Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports MySql.Data.MySqlClient


Partial Class FurnitureOnlineIssues
    Inherits System.Web.UI.Page

    Public rgaProdNoList As New DataTable
    Public boProdNoList As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
        Dim mysqldataadapter As New MySqlDataAdapter
        Dim mysqldataadapter2 As New MySqlDataAdapter

        Dim conn As New MySqlConnection()
        Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

        conn.ConnectionString = connstr

        conn.Open()

        mysqldataadapter.SelectCommand = New MySqlCommand("Select distinct ProdNo FROM RGAs where BenRcvd is Null or DeliveredToLine is Null", conn)
        mysqldataadapter.Fill(rgaProdNoList)

        mysqldataadapter2.SelectCommand = New MySqlCommand("Select distinct ProdNo FROM Backorders where Cleared = 0 or DeliveredToLine is Null", conn)
        mysqldataadapter2.Fill(boProdNoList)

        conn.Close()
        conn.Dispose()
        Return False

    End Function

    Protected Sub gvAllFieldsF_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsF.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim rgaResult() As DataRow = rgaProdNoList.Select("ProdNo =  '" & e.Row.Cells(0).Text & "'")
            Dim boResult() As DataRow = boProdNoList.Select("ProdNo =  '" & e.Row.Cells(0).Text & "'")

            If (rgaResult.Length < 1 And boResult.Length < 1) Or e.Row.DataItem("CurrentStatus") = "Shrinkwrap" Or e.Row.DataItem("CurrentStatus") = "Rigging" Or e.Row.DataItem("CurrentStatus") = "Wavetamer" Or e.Row.DataItem("CurrentStatus") = "Sharkhide" Or e.Row.DataItem("CurrentStatus") = "Complete" Then
                e.Row.Visible = False

            Else
                'Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
                Dim t As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFurnitureOptions"), SqlDataSource)
                Dim u As SqlDataSource = CType(e.Row.FindControl("sdsRGAs"), SqlDataSource)
                Dim v As SqlDataSource = CType(e.Row.FindControl("sdsBOs"), SqlDataSource)


                Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                    's.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                    t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                    u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                    v.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

                Catch

                End Try
                If (e.Row.DataItem("BuildLoc") = "S") Then
                    e.Row.BackColor = Drawing.Color.LightGray
                End If

            End If

            Dim w As SqlDataSource = CType(e.Row.FindControl("sdsIntRGAs"), SqlDataSource)
            w.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

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


    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        PopulateDataTables()

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String


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
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus = 2 and Convert(date,FurniturePrepLastUpdated) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        'conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        'recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        'lblBoatsStarted.Text = recordcount
        'framesreadytostart = Convert.ToInt16(cmd3.ExecuteScalar)
        'framesreadytostartio = Convert.ToInt16(cmd4.ExecuteScalar)

        'lblReadytoStart.Text = framesreadytostart
        'lblios.Text = framesreadytostartio
        'MesgBox(recordcount)
        'conn.Close()

        ddlBldg.SelectedValue = "M"
    End Sub




    Protected Sub gvOrderLines_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        If e.CommandName = "setdelivered" Then
            Dim AutoID As Integer = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            'MesgBox(AutoID)
            Dim TodaysDate As Date = Date.Now

            Dim conn As New MySqlConnection()
            Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"
            Dim cmd As New MySqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update RGAs Set DeliveredToLine = '1', DateDeliveredToLine = '" & TodaysDate & "' where AutoID = '" & AutoID & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            Me.DataBind()

        End If


    End Sub


    Protected Sub gvIntRGAs_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        If e.CommandName = "setintdelivered" Then
            Dim AutoID As Integer = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            'MesgBox(AutoID)
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update InternalRGAs Set DeliveredToLine = '1', DateDeliveredToLine = '" & TodaysDate & "' where AutoID = '" & AutoID & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            Me.DataBind()

        End If


    End Sub

    Protected Sub gvBOs_RowCommand(sender As Object, e As GridViewCommandEventArgs)


        If e.CommandName = "setbodelivered" Then
            Dim AutoID As Integer = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            'MesgBox(AutoID)
            Dim TodaysDate As Date = Date.Now

            Dim conn As New MySqlConnection()
            Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"
            Dim cmd As New MySqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update Backorders Set DeliveredToLine = '1', DateDeliveredToLine = '" & TodaysDate & "' where AutoID = '" & AutoID & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            Me.DataBind()

        End If



    End Sub

    Protected Sub gvOrderLines_RowDataBound(sender As Object, e As GridViewRowEventArgs)

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim BenRcvd As Integer = 0
            Dim Delivered As Integer = 0


            If e.Row.DataItem("BenRcvd") Is DBNull.Value Then
                BenRcvd = 0
            Else
                BenRcvd = Convert.ToInt16(e.Row.DataItem("BenRcvd"))
            End If

            If e.Row.DataItem("DeliveredToLine") Is DBNull.Value Then
                Delivered = 0
            Else
                Delivered = Convert.ToInt16(e.Row.DataItem("Delivered"))
            End If

            If BenRcvd = 0 Then
                e.Row.BackColor = Drawing.Color.Yellow
            ElseIf BenRcvd = 1 And Delivered = 0 Then
                e.Row.BackColor = Drawing.Color.Orange

            End If

        End If

    End Sub

    Protected Sub gvIntRGAs_RowDataBound(sender As Object, e As GridViewRowEventArgs)

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim Resolved As Integer = 0
            Dim Delivered As Integer = 0


            If e.Row.DataItem("Resolved") Is DBNull.Value Then
                Resolved = 0
            Else
                Resolved = Convert.ToInt16(e.Row.DataItem("Resolved"))
            End If

            If e.Row.DataItem("DeliveredToLine") Is DBNull.Value Then
                Delivered = 0
            Else
                Delivered = Convert.ToInt16(e.Row.DataItem("Delivered"))
            End If

            If Resolved = 0 Or Resolved = 1 Then
                e.Row.BackColor = Drawing.Color.Yellow
            ElseIf Resolved = 2 And Delivered = 0 Then
                e.Row.BackColor = Drawing.Color.Orange

            End If

        End If

    End Sub

    Protected Sub gvBOs_RowDataBound(sender As Object, e As GridViewRowEventArgs)

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim Cleared As Integer = 0
            Dim Delivered As Integer = 0


            If e.Row.DataItem("Cleared") Is DBNull.Value Then
                Cleared = 0
            Else
                Cleared = Convert.ToInt16(e.Row.DataItem("Cleared"))
            End If

            If e.Row.DataItem("DeliveredToLine") Is DBNull.Value Then
                Delivered = 0
            Else
                Delivered = Convert.ToInt16(e.Row.DataItem("Delivered"))
            End If

            If Cleared = 0 Then
                e.Row.BackColor = Drawing.Color.Yellow
            ElseIf Cleared = 1 And Delivered = 0 Then
                e.Row.BackColor = Drawing.Color.Orange

            End If

        End If

    End Sub


    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsF.DataBind()
    End Sub


End Class
