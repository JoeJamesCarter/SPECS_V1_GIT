Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class BiminiRcv
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gvBiminis_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBiminis.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            'Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsBiminis"), SqlDataSource)
            'Dim u As SqlDataSource = CType(e.Row.FindControl("sdsMacola"), SqlDataSource)
            Dim v As SqlDataSource = CType(e.Row.FindControl("sdsStdTop"), SqlDataSource)


            Dim so As String = DataBinder.Eval(e.Row.DataItem, "SONo")

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                's.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                'u.SelectParameters(0).DefaultValue = so
                v.SelectParameters(0).DefaultValue = e.Row.DataItem("ItemNo")
            Catch

            End Try
            If (e.Row.DataItem("ProdLineID") = "1") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If


        End If

    End Sub


    Protected Sub gvBiminis_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvBiminis.RowCommand

        If e.CommandName = "goto" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvBiminis.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Gauges" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "UpdateBiminiRcvdStatus" Then


            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvBiminis.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


            Dim rbList As RadioButtonList = DirectCast(gvBiminis.Rows(Key).Cells(8).FindControl("rblBiminiRcvdStatus"), RadioButtonList)
            'set the value of the radio button equal to what it is in the database on load.

            Dim conn As New SqlConnection()


            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim rcvdM As Int16
            Dim rcvdS As Int16

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text

            If rbList.SelectedValue = 2 Then
                cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BiminiRcvdStatus = '" & rbList.SelectedValue & "' , BiminiRcvd = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            ElseIf rbList.SelectedValue = 0 Then
                cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BiminiRcvdStatus = '" & rbList.SelectedValue & "' , BiminiRcvd =  NULL where ProdNo =  '" & SelectedProdNo & "'"
            End If

            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BiminiRcvdStatus = 2 and Convert(date,BiminiRcvd) ='" & ThisDay & "'"
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BiminiRcvdStatus = 2 and ProdLineID = '3' and Convert(date,BiminiRcvd) ='" & ThisDay & "'"
            cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where  BiminiRcvdStatus = 2 and ProdLineID = '1' and Convert(date,BiminiRcvd) ='" & ThisDay & "'"


            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            conn.Open()

            cmd.ExecuteNonQuery()
            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount

            lblRcvdM.Text = Convert.ToInt16(cmd3.ExecuteScalar())
            lblRcvdS.Text = Convert.ToInt16(cmd4.ExecuteScalar())


            gvBiminis.DataBind()

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
        Dim rcvdM As Int16
        Dim rcvdS As Int16

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
            DaystoShow = ThisDay.AddDays(42).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("40 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(52).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("50 Days", DaystoShow))
        End If


        If ddlShowSelect.SelectedValue = 1 Then
            gvBiminis.Columns(9).Visible = False
        Else : gvBiminis.Columns(9).Visible = True
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BiminiRcvdStatus = 2 and Convert(date,BiminiRcvd) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BiminiRcvdStatus = 2 and ProdLineID = '3' and Convert(date,BiminiRcvd) ='" & ThisDay & "'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where  BiminiRcvdStatus = 2 and ProdLineID = '1'and Convert(date,BiminiRcvd) ='" & ThisDay & "'"
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
        rcvdM = Convert.ToInt16(cmd3.ExecuteScalar)
        rcvdS = Convert.ToInt16(cmd4.ExecuteScalar)

        lblRcvdM.Text = rcvdM
        lblRcvdS.Text = rcvdS

        conn.Close()
    End Sub

    Protected Sub ddlShowSelect_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlShowSelect.SelectedIndexChanged
        gvBiminis.DataBind() 'used to allow the user to hide/show jobs that they have completed.
        If ddlShowSelect.SelectedValue = 1 Then
            gvBiminis.Columns(9).Visible = False
        Else : gvBiminis.Columns(9).Visible = True
        End If
    End Sub

    Protected Sub ddlDaysInAdvance_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDaysInAdvance.SelectedIndexChanged

        gvBiminis.DataBind()
        If ddlShowSelect.SelectedValue = 1 Then
            gvBiminis.Columns(9).Visible = False
        Else : gvBiminis.Columns(9).Visible = True
        End If

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvBiminis.DataBind()
        If ddlShowSelect.SelectedValue = 1 Then
            gvBiminis.Columns(9).Visible = False
        Else : gvBiminis.Columns(9).Visible = True
        End If
    End Sub


End Class
