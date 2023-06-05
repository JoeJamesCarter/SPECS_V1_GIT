Imports System.Data.SqlClient
Imports System.Data
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Workstations_BringOnline
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

        gvAllFieldsFG.DataBind()

    End Sub


    Protected Sub gvAllFieldsFG_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsFG.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            'Dim t As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFiberglassOptions"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                't.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If

    End Sub


    Protected Sub gvAllFieldsFG_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsFG.RowCommand

        If e.CommandName = "goto" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsFG.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Frames" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
            Dim url2 As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url2 + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)
            'This next line works, unless it is in an update panel. Then it doesn't. Response.Write doesn't work inside those. Use ScriptManager instead.
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url2 & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If
       

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)

        End If

        If e.CommandName = "UpdateBringOnline" Then
            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvAllFieldsFG.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


            Dim rbList As RadioButtonList = DirectCast(gvAllFieldsFG.Rows(Key).Cells(4).FindControl("rblBuildLoc"), RadioButtonList)
            'set the value of the radio button equal to what it is in the database on load.

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand
            Dim cmd6 As New SqlCommand
            Dim cmd7 As New SqlCommand
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand
            Dim cmd10 As New SqlCommand
            Dim cmd11 As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim framesstatus As Int16 = 0
            Dim tubeneeded As Int16 = 0
            Dim tubecomplete As Int16 = 0
            Dim framesreadytostart As Int16
            Dim framesreadytostartio As Int16
            Dim buildingto As String = rbList.SelectedValue
            Dim outertubecount As Int16 = 0
            Dim greenlightcount As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text


            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FloorsInstalledStatus = '1', FloorsInstalled = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FloorsInstalledStatus = '0', FloorsInstalled = Null where ProdNo =  '" & SelectedProdNo & "'"

            'is it framed
            cmd3.CommandText = "Select FloorsInstalledStatus FROM BML_POPREPORTING_GREENLIGHTS where ProdNo =  '" & SelectedProdNo & "'"

            'populate the labels to show boats ready to start and count that are not ios in the top toolbar
            'cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 2 and Convert(date,FramesInstalled) ='" & ThisDay & "'"
            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1"
            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
            cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and TubesStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"
            cmd11.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = 2 and ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd6.Connection = conn
            cmd7.Connection = conn
            cmd8.Connection = conn
            cmd9.Connection = conn
            cmd10.Connection = conn
            cmd11.Connection = conn

            conn.Open()

            framesstatus = Convert.ToInt16(cmd3.ExecuteScalar())
            'outertubecount = Convert.ToInt16(cmd11.ExecuteScalar)
            'greenlightcount = Convert.ToInt16(cmd10.ExecuteScalar())

            If framesstatus = 0 And rbList.SelectedValue = "1" Then
                cmd.ExecuteNonQuery() ' set it to 1
            ElseIf framesstatus = 1 And rbList.SelectedValue = "0" Then ' reverse it to 0
                cmd2.ExecuteNonQuery()

            End If


            'recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            'lblBoatsStarted.Text = recordcount

            framesreadytostart = Convert.ToInt16(cmd8.ExecuteScalar)
            framesreadytostartio = Convert.ToInt16(cmd9.ExecuteScalar)
            lblReadytoStart.Text = framesreadytostart
            lblios.Text = framesreadytostartio

            gvAllFieldsFG.DataBind()

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
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 2 and Convert(date,FramesInstalled) ='" & ThisDay & "'"
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

        'ddlShowSelect.SelectedValue = "0"

        'MesgBox(recordcount)
        conn.Close()

    End Sub

    Protected Sub ddlShowSelect_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlShowSelect.SelectedIndexChanged
        gvAllFieldsFG.DataBind() 'used to allow the user to hide/show jobs that they have completed.
        
    End Sub

    Protected Sub ddlDaysInAdvance_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDaysInAdvance.SelectedIndexChanged

        gvAllFieldsFG.DataBind()
        

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsFG.DataBind()
       
    End Sub

    Protected Function SplitBVatDash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("-"c)(0)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function

   
End Class
