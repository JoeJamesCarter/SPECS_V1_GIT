Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_Bimini_Feet
    Inherits System.Web.UI.Page

    Public ProdsWithDblBims As New DataTable
    Public ProdsWithPowertops As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
        Dim sqldataadapter As New SqlDataAdapter
        Dim sqldataadapter2 As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        conn.ConnectionString = connstr

        conn.Open()

        sqldataadapter.SelectCommand = New SqlCommand("Select Distinct ProdNo FROM BML_POPREPORTINGFABOPTIONS Where Workcenter = 'RailsInstall' AND (Option_Desc Like '%DBL BIM%' or Option_Desc Like '%DOUBLE BIM%')", conn)
        sqldataadapter.Fill(ProdsWithDblBims)

        sqldataadapter2.SelectCommand = New SqlCommand("Select Distinct ProdNo FROM BML_POPREPORTINGFABOPTIONS Where Workcenter = 'RailsInstall' AND (Option_Desc Like '%POWER TOP%' or Option_Desc Like '%PWR TOP%' or Option_Desc Like '%EPT%')", conn)
        sqldataadapter2.Fill(ProdsWithPowertops)

        conn.Close()
        conn.Dispose()
        Return False

    End Function

    Protected Sub gvBiminiFt_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvBiminiFt.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvBiminiFt.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rails" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvBiminiFt.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rails" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        'This code is for the update button
        If e.CommandName = "gotoupdate" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvBiminiFt.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvBiminiFt.Rows(Key).FindControl("btnUpdateBiminis"), Image)
            Dim biminivalue = img.ImageUrl
            biminivalue = Mid(biminivalue, 26, 1) 'get the value of RailsInstalledStatus from the imageurl.
            'Dim NextWorkstationHasDate As Int16
            Dim southshrinkcount As Int16

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BiminiFeetStatus = '2', BiminiFeet = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where (BiminiFeetStatus = 2 and BiminiFeetStrbStatus = 2) and Convert(date,BiminiFeet) ='" & ThisDay & "'"

            'cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureInstalled is not NULL and ProdNo = '" & SelectedProdNo & "'"
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BiminiFeetStatus = '1', BiminiFeet = NULL where ProdNo =  '" & SelectedProdNo & "' and FurnitureInstalled is NULL"
            cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn

            conn.Open()

            If biminivalue = 1 Then
                cmd.ExecuteNonQuery()
            ElseIf biminivalue = 2 Then
                cmd4.ExecuteNonQuery() 'Allow reversal as needed
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())

            lblBoatsStarted.Text = recordcount
            southshrinkcount = Convert.ToInt16(cmd5.ExecuteScalar())
            lblSouthShrink.Text = southshrinkcount

            gvBiminiFt.DataBind()

            conn.Close()
        End If

        If e.CommandName = "gotoupdatestrb" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvBiminiFt.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvBiminiFt.Rows(Key).FindControl("btnUpdateBiminisStrb"), Image)
            Dim biminivalue = img.ImageUrl
            biminivalue = Mid(biminivalue, 26, 1) 'get the value of RailsInstalledStatus from the imageurl.
            'Dim NextWorkstationHasDate As Int16
            Dim southshrinkcount As Int16

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BiminiFeetStrbStatus = '2', BiminiFeetStrb = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BiminiFeetStrbStatus = 2 and BuildLoc = 'M' and Convert(date,BiminiFeetStrb) ='" & ThisDay & "'"

            'cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureInstalled is not NULL and ProdNo = '" & SelectedProdNo & "'"
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BiminiFeetStrbStatus = '1', BiminiFeetStrb = NULL where ProdNo =  '" & SelectedProdNo & "' and FurnitureInstalled is NULL"
            cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn

            conn.Open()

            If biminivalue = 1 Then
                cmd.ExecuteNonQuery()
            ElseIf biminivalue = 2 Then
                cmd4.ExecuteNonQuery() 'Allow reversal as needed
            End If

            'recordcount = Convert.ToInt16(cmd2.ExecuteScalar())

            'lblBoatsStarted.Text = recordcount
            southshrinkcount = Convert.ToInt16(cmd5.ExecuteScalar())
            lblSouthShrink.Text = southshrinkcount

            gvBiminiFt.DataBind()

            conn.Close()
        End If

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Response.Redirect("http://specs/v2/Greenlights/Rails/BiminiFeet.aspx") 'Take them to the new page instead
        PopulateDataTables()

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String
        Dim southshrinkcount As Int16

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
            DaystoShow = ThisDay.AddDays(32).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("40 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(42).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("50 Days", DaystoShow))
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd3.CommandType = CommandType.Text

        'to get the count of the prod #'s completed that day

        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where (BiminiFeetStatus = 2 and BiminiFeetStrbStatus = 2) and Convert(date,BiminiFeet) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

        cmd2.Connection = conn
        cmd3.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount

        southshrinkcount = Convert.ToInt16(cmd3.ExecuteScalar())
        lblSouthShrink.Text = southshrinkcount

        'MesgBox(recordcount)
        conn.Close()
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvBiminiFt.DataBind()
    End Sub

    Protected Sub gvBiminiFt_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBiminiFt.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsRails"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsSingleDimensions"), SqlDataSource)
            Dim v As SqlDataSource = CType(e.Row.FindControl("sdsDoubleDimensions"), SqlDataSource)
            Dim w As SqlDataSource = CType(e.Row.FindControl("sdsPowertopDimensions"), SqlDataSource)

            Dim prod As String = e.Row.Cells(0).Text
            Dim modelyear As String = Trim(Left(e.Row.DataItem("ProdNo"), 2))
            Dim dblBiminiResult() As DataRow = ProdsWithDblBims.Select("ProdNo =  '" & prod & "'")
            Dim powerTopResult() As DataRow = ProdsWithPowertops.Select("ProdNo =  '" & prod & "'")

            Try
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

                If dblBiminiResult.Length = 0 And powerTopResult.Length = 0 And e.Row.DataItem("IsCustom") = "0" Then
                    u.SelectParameters(0).DefaultValue = e.Row.DataItem("ItemNo")
                    u.SelectParameters(1).DefaultValue = modelyear
                ElseIf dblBiminiResult.Length > 0 And e.Row.DataItem("IsCustom") = "0" Then
                    v.SelectParameters(0).DefaultValue = e.Row.DataItem("ItemNo")
                    v.SelectParameters(1).DefaultValue = modelyear
                ElseIf powerTopResult.Length > 0 And e.Row.DataItem("IsCustom") = 0 Then
                    w.SelectParameters(0).DefaultValue = e.Row.DataItem("ItemNo")
                    w.SelectParameters(1).DefaultValue = modelyear

                End If

            Catch

            End Try

            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If


        End If
    End Sub

    Protected Sub btnEdiDims_Click(sender As Object, e As EventArgs) Handles btnEdiDims.Click
        Dim url As String = "./EditBiminiFeetDimensions.aspx"
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,toolbars=0');popUpObj.focus()}</script>")
    End Sub
End Class
