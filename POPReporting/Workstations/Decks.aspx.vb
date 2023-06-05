Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_Decks
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
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
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


        If e.CommandName = "UpdateBringOnline" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRails.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


            Dim rbList As RadioButtonList = DirectCast(gvRails.Rows(Key).Cells(19).FindControl("rblDeckLoc"), RadioButtonList)
            'set the value of the radio button equal to what it is in the database on load.

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand

            Dim TodaysDate As Date = Date.Now

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET IsDeckInside = '" & rbList.SelectedValue & "' , DeckLocModified = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"

            conn.Open()

            cmd.ExecuteNonQuery()
            gvRails.DataBind()
            conn.Close()

            If rbList.SelectedValue.ToString = "1" Then
                Try
                    If gvRails.Rows(Key).DataItem("IsPilot").ToString = "1" Then
                        Dim modelLbl As Label = CType(gvRails.Rows(Key).FindControl("lblItemNo"), Label)
                        Dim model As String = modelLbl.Text
                        SpecsGlobalFunctions.EmailPilotTeam(SelectedProdNo, model, "South Deck Brought Inside To Build ")
                    End If

                Catch ex As Exception

                End Try

            End If

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
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and RailsInstalledStatus = 1 and IsDeckInside = 0 and BML_POPREPORTING.ProdNo > '1999999'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and RailsInstalledStatus = 1 and BML_POPREPORTING.IsPilot = 1 and BML_POPREPORTING.ProdNo > '1999999'"

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

        'Chart3.DataBind()
        'Chart4.DataBind()
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvRails.DataBind()
        'Chart3.DataBind()
        'Chart4.DataBind()
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
            e.Row.Cells(13).ToolTip = "South Kits Received"
            e.Row.Cells(14).ToolTip = "Swingback"
            e.Row.Cells(15).ToolTip = "Boat/Customer"
            e.Row.Cells(16).ToolTip = "Custom"
            e.Row.Cells(17).ToolTip = "Pilot"
            e.Row.Cells(18).ToolTip = "Options"
            e.Row.Cells(19).ToolTip = "Notes"

            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If
    End Sub


    Protected Sub gvRailsOptions_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem("Option_Item") = "111111" Then ' standard w ss ladder and not removed
                e.Row.BackColor = Drawing.Color.Yellow
            ElseIf e.Row.DataItem("Option_Item") Like "906641*" Then 'replace alum with ss ladder
                e.Row.BackColor = Drawing.Color.Yellow
            End If

        End If
    End Sub
End Class

