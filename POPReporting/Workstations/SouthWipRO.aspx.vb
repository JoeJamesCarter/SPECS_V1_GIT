Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_SouthWipRO
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

        If e.CommandName = "gotooffline" Then
            gvRails.DataBind()
            Dim Selected As String = e.CommandArgument 'get the row that is clicked
            Dim workstation As String = "OfflineReport" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "clearsidelineitem" Then
            Dim Auto As String = e.CommandArgument 'get the row that is clicked
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "Update BML_POPREPORTING_OFFLINE Set Cleared ='1', DateCleared = '" & TodaysDate & "' where Auto =  '" & Auto & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvRails.DataBind()

        End If

        'If e.CommandName = "GotoRailsData" Then
        'Dim ID As String = e.CommandArgument 'get the row that is clicked
        'Dim gv1 As GridView = CType(gvRails.Rows(ID).Cells(15).FindControl("Gridview1"), GridView)
        'Dim gv2 As GridView = CType(gvRails.Rows(ID).Cells(15).FindControl("Gridview2"), GridView)
        'End If

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd6 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String
        Dim southshrinkcount As Int16
        Dim readycount As Int16
        Dim ioreadycount As Int16
        Dim qxreadycount As Int16

        If ddlDaysInAdvance.Items.Count = 0 Then  'stop it from repopulating everytime the grid rebinds            
            DaystoShow = ThisDay.AddDays(22).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("20 Days", DaystoShow))
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        'cmd2.CommandType = CommandType.Text
        cmd3.CommandType = CommandType.Text
        cmd4.CommandType = CommandType.Text

        'to get the count of the prod #'s completed that day

        'cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = 2 and Convert(date,RailsInstalled) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and (RailsInstalledStatus > 1 or (RailsInstalledStatus = 1 and IsDeckInside = 1)) and ShrinkwrapStatus < 2 and BML_POPREPORTING.ProdNo > '1999999'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and RailsInstalledStatus = 1 and IsDeckInside = 0 and FurnitureStatus >= 2  and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((ArchTowerNeeded = 0) OR (ArchTowerNeeded = 1 AND ArchTowerStatus = 2)) AND ((QFrontNeeded = 0) OR (QFrontNeeded = 1 AND QFrontStatus = 2)) And BML_POPREPORTING.ProdNo > '1999999'"
        cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.ItemNo Like '%QX%' and RailsInstalledStatus = 1 and IsDeckInside = 0 and FurnitureStatus >= 2  and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((ArchTowerNeeded = 0) OR (ArchTowerNeeded = 1 AND ArchTowerStatus = 2)) AND ((QFrontNeeded = 0) OR (QFrontNeeded = 1 AND QFrontStatus = 2)) And BML_POPREPORTING.ProdNo > '1999999'"
        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.ItemNo Like '%IO%' and RailsInstalledStatus = 1 and IsDeckInside = 0 and FurnitureStatus >= 2  and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((ArchTowerNeeded = 0) OR (ArchTowerNeeded = 1 AND ArchTowerStatus = 2)) AND ((QFrontNeeded = 0) OR (QFrontNeeded = 1 AND QFrontStatus = 2)) And BML_POPREPORTING.ProdNo > '1999999'"


        'cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        'recordcount = Convert.ToInt16(cmd4.ExecuteScalar())
        'lblBoatsStarted.Text = recordcount

        southshrinkcount = Convert.ToInt16(cmd3.ExecuteScalar())
        lblSouthDecks.Text = southshrinkcount

        readycount = Convert.ToInt16(cmd4.ExecuteScalar())
        lblReady.Text = readycount

        qxreadycount = Convert.ToInt16(cmd5.ExecuteScalar())
        ioreadycount = Convert.ToInt16(cmd6.ExecuteScalar())

        lblQX.text = qxreadycount
        lblIO.text = ioreadycount

        'lblBoatsStarted.Text = recordcount
        'MesgBox(recordcount)
        conn.Close()

        'ddlBldg.SelectedValue = "S"
        'ddlProdLine.SelectedValue = "1"




    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvRails.DataBind()
        'Chart1.DataBind()
        'Chart2.DataBind()
    End Sub

    Protected Sub gvRails_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRails.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsOfflineReasons"), SqlDataSource)
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
            e.Row.Cells(9).ToolTip = "Arch/Tower"
            e.Row.Cells(10).ToolTip = "Helm Built"
            e.Row.Cells(11).ToolTip = "Boat/Customer"
            e.Row.Cells(12).ToolTip = "Custom"
            e.Row.Cells(13).ToolTip = "Pilot"

            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If

            Dim gv1 As GridView = CType(e.Row.FindControl("Gridview1"), GridView)
            Dim gv2 As GridView = CType(e.Row.FindControl("Gridview2"), GridView)

            If cbRails.Checked = True Then
                Try
                    Dim v As SqlDataSource = CType(e.Row.FindControl("sdsRailRepairs"), SqlDataSource)
                    Dim w As SqlDataSource = CType(e.Row.FindControl("sdsRailsReorders"), SqlDataSource)
                    v.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                    w.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

                Catch ex As Exception

                End Try

            Else
                gv1.Visible = False
                gv2.Visible = False
                'Else
                'gv1.Visible = True
                'gv2.Visible = True
            End If


        End If
    End Sub

   


    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim PF As String = e.Row.Cells(2).Text
            Dim SF As String = e.Row.Cells(3).Text
            Dim PR As String = e.Row.Cells(4).Text
            Dim SR As String = e.Row.Cells(5).Text
            Dim T As String = e.Row.Cells(6).Text
            Dim PM As String = e.Row.Cells(7).Text
            Dim SM As String = e.Row.Cells(8).Text
            Dim Status As String = e.Row.Cells(10).Text
            Dim ReRcvd As String = e.Row.Cells(12).Text

            If PF = "1" Then
                e.Row.Cells(2).Text = "X"
                e.Row.Cells(2).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(2).Text = ""
            End If

            If SF = "1" Then
                e.Row.Cells(3).Text = "X"
                e.Row.Cells(3).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(3).Text = ""
            End If

            If PR = "1" Then
                e.Row.Cells(4).Text = "X"
                e.Row.Cells(4).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(4).Text = ""
            End If

            If SR = "1" Then
                e.Row.Cells(5).Text = "X"
                e.Row.Cells(5).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(5).Text = ""
            End If

            If T = "1" Then
                e.Row.Cells(6).Text = "X"
                e.Row.Cells(6).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(6).Text = ""
            End If

            If PM = "1" Then
                e.Row.Cells(7).Text = "X"
                e.Row.Cells(7).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(7).Text = ""
            End If

            If SM = "1" Then
                e.Row.Cells(8).Text = "X"
                e.Row.Cells(8).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(8).Text = ""
            End If

            If Status = "1" Then
                e.Row.Cells(10).Text = "Scrapped/Repordered"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            ElseIf Status = "2" Then
                e.Row.Cells(10).Text = "Sent"
                e.Row.Cells(10).BackColor = Drawing.Color.Green
            ElseIf Status = "3" Then
                e.Row.Cells(10).Text = "Cut"
                e.Row.Cells(10).BackColor = Drawing.Color.Yellow
            ElseIf Status = "-1" Then
                e.Row.Cells(10).Text = "Cancelled"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            ElseIf Status = "0" Then
                e.Row.Cells(10).Text = "Not Started"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            End If

            If ReRcvd = "2" Then
                e.Row.Cells(12).Text = "Yes"
                e.Row.Cells(12).BackColor = Drawing.Color.Green
            Else
                e.Row.Cells(12).Text = "No"
                e.Row.Cells(12).BackColor = Drawing.Color.Red
            End If

            'If e.Row.DataItem("NeedsTransom") = 0 Then
            'cbT.Visible = False
            'tbTNotes.Visible = False
            'lblT.Visible = False
            'End If

            'If e.Row.DataItem("NeedsPortMid") = 0 Then
            'cbPM.Visible = False
            'tbPMNotes.Visible = False
            'lblPM.Visible = False
            'End If

            'If e.Row.DataItem("NeedsStrbMid") = 0 Then
            'cbSM.Visible = False
            'tbSMNotes.Visible = False
            'lblSM.Visible = False
            'End If

        End If
    End Sub

    Protected Sub GridView2_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim PF As String = e.Row.Cells(2).Text
            Dim SF As String = e.Row.Cells(3).Text
            Dim PR As String = e.Row.Cells(4).Text
            Dim SR As String = e.Row.Cells(5).Text
            Dim T As String = e.Row.Cells(6).Text
            Dim PM As String = e.Row.Cells(7).Text
            Dim SM As String = e.Row.Cells(8).Text
            Dim Status As String = e.Row.Cells(10).Text
            Dim ReRcvd As String = e.Row.Cells(12).Text

            If PF = "1" Then
                e.Row.Cells(2).Text = "X"
                e.Row.Cells(2).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(2).Text = ""
            End If

            If SF = "1" Then
                e.Row.Cells(3).Text = "X"
                e.Row.Cells(3).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(3).Text = ""
            End If

            If PR = "1" Then
                e.Row.Cells(4).Text = "X"
                e.Row.Cells(4).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(4).Text = ""
            End If

            If SR = "1" Then
                e.Row.Cells(5).Text = "X"
                e.Row.Cells(5).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(5).Text = ""
            End If

            If T = "1" Then
                e.Row.Cells(6).Text = "X"
                e.Row.Cells(6).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(6).Text = ""
            End If

            If PM = "1" Then
                e.Row.Cells(7).Text = "X"
                e.Row.Cells(7).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(7).Text = ""
            End If

            If SM = "1" Then
                e.Row.Cells(8).Text = "X"
                e.Row.Cells(8).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(8).Text = ""
            End If

            If Status = "2" Then
                e.Row.Cells(10).Text = "Sent"
                e.Row.Cells(10).BackColor = Drawing.Color.Green
            ElseIf Status = "3" Then
                e.Row.Cells(10).Text = "Cut"
                e.Row.Cells(10).BackColor = Drawing.Color.Yellow
            ElseIf Status = "-1" Then
                e.Row.Cells(10).Text = "Cancelled"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            ElseIf Status = "0" Then
                e.Row.Cells(10).Text = "Not Started"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            End If

            If ReRcvd = "2" Then
                e.Row.Cells(12).Text = "Yes"
                e.Row.Cells(12).BackColor = Drawing.Color.Green
            Else
                e.Row.Cells(12).Text = "No"
                e.Row.Cells(12).BackColor = Drawing.Color.Red
            End If

            'If e.Row.DataItem("NeedsTransom") = 0 Then
            'cbT.Visible = False
            'tbTNotes.Visible = False
            'lblT.Visible = False
            'End If

            'If e.Row.DataItem("NeedsPortMid") = 0 Then
            'cbPM.Visible = False
            'tbPMNotes.Visible = False
            'lblPM.Visible = False
            'End If

            'If e.Row.DataItem("NeedsStrbMid") = 0 Then
            'cbSM.Visible = False
            'tbSMNotes.Visible = False
            'lblSM.Visible = False
            'End If

        End If
    End Sub

   
  
End Class
