Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class KitReceiving
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gvRails_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvRails.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rails" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rails" 'to pass in the workstation that makes the note.
            Dim url As String = "BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "assembly" Then
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command

            Dim img As Image = CType(gvRails.Rows(ID).FindControl("btnAssembly"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 14, 1) 'get the value of FloorsInstalledStatus from the imageurl.
            Dim TodaysDate As Date = Date.Now


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            Dim KitTotal As Integer = 0

            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn

            conn.Open()

            If floorvalue = 0 Then
                'set k1rcvstatus = 2 and date time
                cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd1.Parameters.AddWithValue("@Selected", Selected)
                cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kit1RcvStatus = '2', Kit1Rcv = @TodaysDate where ProdNo =  @Selected"
                cmd1.ExecuteNonQuery()
                'gvRails.DataBind()
            ElseIf floorvalue = 2 Then
                'set k1rcvstatus = 0 and reset date time
                cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd1.Parameters.AddWithValue("@Selected", Selected)
                cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kit1RcvStatus = '0', Kit1Rcv = NULL where ProdNo =  @Selected"
                cmd1.ExecuteNonQuery()
                'gvRails.DataBind()
            End If

            'Test if they are all 2, if so set the flag for allkitsrcvd to 1 else 0 to account for the reversable of complete.
            cmd2.Parameters.AddWithValue("@Selected2", Selected)
            cmd2.CommandText = "Select cast(Kit1RcvStatus as integer) + cast(Kit3RcvStatus as integer) + cast(Kit4RcvStatus as integer) + cast(Kit5RcvStatus as integer) + cast(Kit2RcvStatus as integer) From BML_POPREPORTING_GREENLIGHTS where ProdNo = @Selected2"
            KitTotal = cmd2.ExecuteScalar
            'MesgBox(KitTotal)

            cmd3.Parameters.AddWithValue("@Selected3", Selected)
            cmd3.Parameters.AddWithValue("@TodaysDate3", TodaysDate)

            If KitTotal = 10 Then
                cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set AllKitsRcvd = '2', AllKitsRcvdDate = @TodaysDate3 Where ProdNo = @Selected3"
            Else
                cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set AllKitsRcvd = '0', AllKitsRcvdDate = NULL Where ProdNo = @Selected3"
            End If

            cmd3.ExecuteNonQuery()
            gvRails.DataBind()
            conn.Close()

        End If

        If e.CommandName = "furniture" Then
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command

            Dim img As Image = CType(gvRails.Rows(ID).FindControl("btnFurniture"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 14, 1) 'get the value of FloorsInstalledStatus from the imageurl.
            Dim TodaysDate As Date = Date.Now


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            Dim KitTotal As Integer = 0

            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn

            conn.Open()

            If floorvalue = 0 Then
                'set k1rcvstatus = 2 and date time
                cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd1.Parameters.AddWithValue("@Selected", Selected)
                cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kit3RcvStatus = '2', Kit3Rcv = @TodaysDate where ProdNo =  @Selected"
                cmd1.ExecuteNonQuery()
                'gvRails.DataBind()
            ElseIf floorvalue = 2 Then
                'set k1rcvstatus = 0 and reset date time
                cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd1.Parameters.AddWithValue("@Selected", Selected)
                cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kit3RcvStatus = '0', Kit3Rcv = NULL where ProdNo =  @Selected"
                cmd1.ExecuteNonQuery()
                'gvRails.DataBind()
            End If

            'Test if they are all 2, if so set the flag for allkitsrcvd to 1 else 0 to account for the reversable of complete.
            cmd2.Parameters.AddWithValue("@Selected2", Selected)
            cmd2.CommandText = "Select cast(Kit1RcvStatus as integer) + cast(Kit3RcvStatus as integer) + cast(Kit4RcvStatus as integer) + cast(Kit5RcvStatus as integer) + cast(Kit2RcvStatus as integer) From BML_POPREPORTING_GREENLIGHTS where ProdNo = @Selected2"
            KitTotal = cmd2.ExecuteScalar
            'MesgBox(KitTotal)

            cmd3.Parameters.AddWithValue("@Selected3", Selected)
            cmd3.Parameters.AddWithValue("@TodaysDate3", TodaysDate)

            If KitTotal = 10 Then
                cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set AllKitsRcvd = '2', AllKitsRcvdDate = @TodaysDate3 Where ProdNo = @Selected3"
            Else
                cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set AllKitsRcvd = '0', AllKitsRcvdDate = NULL Where ProdNo = @Selected3"
            End If

            cmd3.ExecuteNonQuery()
            gvRails.DataBind()
            conn.Close()
        End If

        If e.CommandName = "final" Then
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command

            Dim img As Image = CType(gvRails.Rows(ID).FindControl("btnFinal"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 14, 1) 'get the value of FloorsInstalledStatus from the imageurl.
            Dim TodaysDate As Date = Date.Now


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            Dim KitTotal As Integer = 0

            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn

            conn.Open()

            If floorvalue = 0 Then
                'set k1rcvstatus = 2 and date time
                cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd1.Parameters.AddWithValue("@Selected", Selected)
                cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kit4RcvStatus = '2', Kit4Rcv = @TodaysDate where ProdNo =  @Selected"
                cmd1.ExecuteNonQuery()
                'gvRails.DataBind()
            ElseIf floorvalue = 2 Then
                'set k1rcvstatus = 0 and reset date time
                cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd1.Parameters.AddWithValue("@Selected", Selected)
                cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kit4RcvStatus = '0', Kit4Rcv = NULL where ProdNo =  @Selected"
                cmd1.ExecuteNonQuery()
                'gvRails.DataBind()
            End If

            'Test if they are all 2, if so set the flag for allkitsrcvd to 1 else 0 to account for the reversable of complete.
            cmd2.Parameters.AddWithValue("@Selected2", Selected)
            cmd2.CommandText = "Select cast(Kit1RcvStatus as integer) + cast(Kit3RcvStatus as integer) + cast(Kit4RcvStatus as integer) + cast(Kit5RcvStatus as integer) + cast(Kit2RcvStatus as integer) From BML_POPREPORTING_GREENLIGHTS where ProdNo = @Selected2"
            KitTotal = cmd2.ExecuteScalar
            'MesgBox(KitTotal)

            cmd3.Parameters.AddWithValue("@Selected3", Selected)
            cmd3.Parameters.AddWithValue("@TodaysDate3", TodaysDate)

            If KitTotal = 10 Then
                cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set AllKitsRcvd = '2', AllKitsRcvdDate = @TodaysDate3 Where ProdNo = @Selected3"
            Else
                cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set AllKitsRcvd = '0', AllKitsRcvdDate = NULL Where ProdNo = @Selected3"
            End If

            cmd3.ExecuteNonQuery()
            gvRails.DataBind()
            conn.Close()

        End If

        If e.CommandName = "south" Then
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command

            Dim img As Image = CType(gvRails.Rows(ID).FindControl("btnSouth"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 14, 1) 'get the value of FloorsInstalledStatus from the imageurl.
            Dim TodaysDate As Date = Date.Now


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            Dim KitTotal As Integer = 0

            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn

            conn.Open()

            If floorvalue = 0 Then
                'set k1rcvstatus = 2 and date time
                cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd1.Parameters.AddWithValue("@Selected", Selected)
                cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kit5RcvStatus = '2', Kit5Rcv = @TodaysDate, KittingSouthStatus = '2', KittingSouth = @TodaysDate where ProdNo =  @Selected"
                cmd1.ExecuteNonQuery()
                'gvRails.DataBind()
            ElseIf floorvalue = 2 Then
                'set k1rcvstatus = 0 and reset date time
                cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd1.Parameters.AddWithValue("@Selected", Selected)
                cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kit5RcvStatus = '0', Kit5Rcv = NULL, KittingSouthStatus = '0', KittingSouth = NULL where ProdNo =  @Selected"
                cmd1.ExecuteNonQuery()
                'gvRails.DataBind()
            End If

            'Test if they are all 2, if so set the flag for allkitsrcvd to 1 else 0 to account for the reversable of complete.
            cmd2.Parameters.AddWithValue("@Selected2", Selected)
            cmd2.CommandText = "Select cast(Kit1RcvStatus as integer) + cast(Kit3RcvStatus as integer) + cast(Kit4RcvStatus as integer) + cast(Kit5RcvStatus as integer) + cast(Kit2RcvStatus as integer) From BML_POPREPORTING_GREENLIGHTS where ProdNo = @Selected2"
            KitTotal = cmd2.ExecuteScalar

            cmd3.Parameters.AddWithValue("@Selected3", Selected)
            cmd3.Parameters.AddWithValue("@TodaysDate3", TodaysDate)

            If KitTotal = 10 Then
                cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set AllKitsRcvd = '2', AllKitsRcvdDate = @TodaysDate3 Where ProdNo = @Selected3"
            Else
                cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set AllKitsRcvd = '0', AllKitsRcvdDate = NULL Where ProdNo = @Selected3"
            End If

            cmd3.ExecuteNonQuery()
            gvRails.DataBind()
            conn.Close()
        End If

        If e.CommandName = "trim" Then
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command

            Dim img As Image = CType(gvRails.Rows(ID).FindControl("btnTrim"), Image)
            Dim floorvalue = img.ImageUrl
            floorvalue = Mid(floorvalue, 14, 1) 'get the value of FloorsInstalledStatus from the imageurl.
            Dim TodaysDate As Date = Date.Now


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand

            Dim KitTotal As Integer = 0

            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn

            conn.Open()

            If floorvalue = 0 Then
                'set k1rcvstatus = 2 and date time
                cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd1.Parameters.AddWithValue("@Selected", Selected)
                cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kit2RcvStatus = '2', Kit2Rcv = @TodaysDate where ProdNo =  @Selected"
                cmd1.ExecuteNonQuery()
                'gvRails.DataBind()
            ElseIf floorvalue = 2 Then
                'set k1rcvstatus = 0 and reset date time
                cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                cmd1.Parameters.AddWithValue("@Selected", Selected)
                cmd1.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kit2RcvStatus = '0', Kit2Rcv = NULL where ProdNo =  @Selected"
                cmd1.ExecuteNonQuery()
                'gvRails.DataBind()
            End If

            'Test if they are all 2, if so set the flag for allkitsrcvd to 1 else 0 to account for the reversable of complete.
            cmd2.Parameters.AddWithValue("@Selected2", Selected)
            cmd2.CommandText = "Select cast(Kit1RcvStatus as integer) + cast(Kit3RcvStatus as integer) + cast(Kit4RcvStatus as integer) + cast(Kit5RcvStatus as integer) + cast(Kit2RcvStatus as integer) From BML_POPREPORTING_GREENLIGHTS where ProdNo = @Selected2"
            KitTotal = cmd2.ExecuteScalar

            cmd3.Parameters.AddWithValue("@Selected3", Selected)
            cmd3.Parameters.AddWithValue("@TodaysDate3", TodaysDate)

            If KitTotal = 10 Then
                cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set AllKitsRcvd = '2', AllKitsRcvdDate = @TodaysDate3 Where ProdNo = @Selected3"
            Else
                cmd3.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set AllKitsRcvd = '0', AllKitsRcvdDate = NULL Where ProdNo = @Selected3"
            End If

            cmd3.ExecuteNonQuery()
            gvRails.DataBind()
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
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd3.CommandType = CommandType.Text
        cmd4.CommandType = CommandType.Text

        'to get the count of the prod #'s completed that day

        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = 2 and Convert(date,RailsInstalled) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and RailsInstalledStatus = 1 and BML_POPREPORTING.ProdNo > '170000'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and RailsInstalledStatus = 1 and BML_POPREPORTING.IsPilot = 1 and BML_POPREPORTING.ProdNo > '170000'"

        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd4.ExecuteScalar())
        'lblBoatsStarted.Text = recordcount

        southshrinkcount = Convert.ToInt16(cmd3.ExecuteScalar())
        lblSouthDecks.Text = southshrinkcount
        lblBoatsStarted.Text = recordcount
        'MesgBox(recordcount)
        conn.Close()

        ddlBldg.SelectedValue = "S"


    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvRails.DataBind()

    End Sub

    Protected Sub gvRails_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRails.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsRails"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsBoatNotes"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try

            e.Row.Cells(0).ToolTip = "Prod #"
            e.Row.Cells(1).ToolTip = "Furniture"
            e.Row.Cells(2).ToolTip = "Fiberglass"
            e.Row.Cells(3).ToolTip = "Canvas"
            e.Row.Cells(4).ToolTip = "Rails"
            e.Row.Cells(5).ToolTip = "Tubes"
            e.Row.Cells(6).ToolTip = "Center Tube"
            e.Row.Cells(7).ToolTip = "Gauge/Harness"
            e.Row.Cells(8).ToolTip = "Q Front"
            e.Row.Cells(9).ToolTip = "Q Front Rails"
            e.Row.Cells(10).ToolTip = "Arch/Tower"
            e.Row.Cells(11).ToolTip = "Helm Built"
            e.Row.Cells(12).ToolTip = "Bimini Rcvd"

            e.Row.Cells(13).ToolTip = "K1"
            e.Row.Cells(14).ToolTip = "K2"
            e.Row.Cells(15).ToolTip = "K3"
            e.Row.Cells(16).ToolTip = "K4"
            e.Row.Cells(17).ToolTip = "KS"

            e.Row.Cells(18).ToolTip = "Boat/Customer"
            e.Row.Cells(19).ToolTip = "Custom"
            e.Row.Cells(20).ToolTip = "Pilot"
            e.Row.Cells(21).ToolTip = "Options"
            'e.Row.Cells(17).ToolTip = "Assembly Kit"
            'e.Row.Cells(18).ToolTip = "Furniture Kit"
            'e.Row.Cells(19).ToolTip = "Final Kit"
            'e.Row.Cells(20).ToolTip = "South Kit"
            e.Row.Cells(22).ToolTip = "Notes"

            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If
    End Sub


End Class


