Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_Gates
    Inherits System.Web.UI.Page



    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gGates_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvGates.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvGates.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Gates" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvGates.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Gates" 'to pass in the workstation that makes the note.
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
            Dim SelectedProdNo As Integer = gvGates.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvGates.Rows(Key).FindControl("btnUpdateGates"), Image)
            Dim gatesvalue = img.ImageUrl
            gatesvalue = Mid(gatesvalue, 26, 1) 'get the value of RailsInstalledStatus from the imageurl.

            Dim southshrinkcount As Int16

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET GatesStatus = '2', Gates = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where GatesStatus = 2 and Convert(date,Gates) ='" & ThisDay & "'"
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET GatesStatus = '1', Gates = NULL where ProdNo =  '" & SelectedProdNo & "'"
            cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and ShrinkwrapStatus = 2 and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn

            conn.Open()


            If gatesvalue <= 1 Then
                cmd.ExecuteNonQuery()
            Else
                cmd4.ExecuteNonQuery() 'Allow reversal
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())

            lblBoatsStarted.Text = recordcount
            southshrinkcount = Convert.ToInt16(cmd5.ExecuteScalar())
            lblSouthShrink.Text = southshrinkcount

            gvGates.DataBind()

            conn.Close()
        End If

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
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
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd3.CommandType = CommandType.Text

        'to get the count of the prod #'s completed that day

        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where GatesStatus = 2 and Convert(date,Gates) ='" & ThisDay & "'"
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
        gvGates.DataBind()
    End Sub

    Protected Sub gvGates_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvGates.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsGateData"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFabOptions"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                If (e.Row.DataItem("IsCustom") = "0") Then
                    t.SelectParameters(0).DefaultValue = e.Row.DataItem("ItemNo")
                End If
            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If

        End If
    End Sub


End Class
