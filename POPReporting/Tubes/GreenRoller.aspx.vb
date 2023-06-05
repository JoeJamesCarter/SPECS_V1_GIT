Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Tubes_GreenRoller
    Inherits System.Web.UI.Page

    Public buildinst As New DataTable
    Public buildinstctr As New DataTable
    Public buildinstcs As New DataTable

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Function SplitBValSlash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("\")(1)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

        gvRoller.DataBind()

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
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
            DaystoShow = ThisDay.AddDays(32).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("40 Days", DaystoShow))
        End If
        hdnStatus.Value = 2

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr

        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM Tubes where RollerPStatus = 2 and OuterRoller = 'Green' and Convert(date,RollerP) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM Tubes where RollerSStatus = 2 and OuterRoller = 'Green' and Convert(date,RollerS) ='" & ThisDay & "'"
        cmd4.CommandText = "Select Count (*) FROM Tubes where RollerCStatus = 2 and CenterRoller = 'Green' and Convert(date,RollerC) ='" & ThisDay & "'"

        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn


        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)


        lblPort.Text = "P:" & Convert.ToInt16(cmd2.ExecuteScalar())
        lblStrb.Text = " S:" & Convert.ToInt16(cmd3.ExecuteScalar())
        lblCtr.Text = " C:" & Convert.ToInt16(cmd4.ExecuteScalar())

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)

        conn.Close()
    End Sub

    Protected Function PrintLabelsByTubeType(prod As String, numsections As Integer, tube As String, tubetype As String) As String

        'Print Label - simple prod or cs no and barcode

        Dim ipAddress As String = "10.54.80.18" ' Green
        'Dim ipAddress As String = "10.5.110.59" 'Blue
        ' Dim ipAddress As String = "10.5.110.58" 'Keri

        Dim port As Integer = 9100

        Dim prodfirst6 As String = Left(prod, Len(prod) - 1)
        Dim prodlast1 As String = Right(prod, 1)
        Dim sectionlist = New ArrayList()

        If tube = "Port" And numsections <= 4 Then
            sectionlist.Add("PF")
            sectionlist.Add("PR")

        ElseIf tube = "Strb" And numsections <= 4 Then
            sectionlist.Add("SF")
            sectionlist.Add("SR")

        ElseIf tube = "Ctr" And numsections <= 4 Then
            sectionlist.Add("CF")
            sectionlist.Add("CR")
        End If

        If numsections = 3 Then
            If tube = "Port" Then
                sectionlist.Add("PM")
            ElseIf tube = "Strb" Then
                sectionlist.Add("SM")
            ElseIf tube = "Ctr" Then
                sectionlist.Add("CM")
            End If
        End If

        If numsections = 4 Then
            If tube = "Port" Then
                sectionlist.Add("PM")
                sectionlist.Add("PM2")
            ElseIf tube = "Strb" Then
                sectionlist.Add("SM")
                sectionlist.Add("SM2")
            ElseIf tube = "Ctr" Then
                sectionlist.Add("CM")
                sectionlist.Add("CM2")
            End If
        End If

        Dim ZPLString2x1 As String = ""

        'Keri's 2x1 Printer format       

        For Each section As String In sectionlist
            If tubetype = "prod" Then
                ZPLString2x1 = _
                  "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                  "^XA" & _
                  "^MMT" & _
                  "^PW406" & _
                  "^LL0203" & _
                  "^LS0" & _
                  "^FO96,160^GFA,01536,01536,00024,:Z64:" & _
                  "eJztkTFKxEAUhl9IEYswsZziuXMD60HEXCVWtpMuhZBZtkiXXMCDWEZSpBG8wgsptlsDNhFlxzcrSDyBIPmLYfj4+OcnAVjztwmPfGwif3W05O6Hl9MvztYmATgDNy94sG0BFPsSqFj6ln1VAWggveRgkHnQlpBJFWkThaeK0E7OqpdmPgI9pjs3p92u4YcCm3f2ohcowU1530gzVLH0/tvO4l4IzftprDWNFd+5P9+2eIfxOZQ264XM8h7R+x/M3QM7I7lX9ueD+vTc+yUKCQO5fYxknr/5yP2p76eJQqHJHNDvD4YniyrmPZm57WNpsnv0e9wwMq+v2S/eu1oXVPg9gbMOMIlmBYRlFaNqi2g6ff8r5iEJoJtL7k+sDpc/Ys2af5svbfh7Og==:BB73" & _
                  "^BY3,3,114^FT41,169^BCN,,Y,Y" & _
                  "^FD>;" & prodfirst6 & ">6" & prodlast1 & "-" & section & "^FS" & _
                  "^PQ1,0,1,Y^XZ"

            ElseIf tubetype = "rerun" Then
                'tube rerun design
                ZPLString2x1 = _
                   "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                    "^XA" & _
                    "^MMT" & _
                    "^PW406" & _
                    "^LL0203" & _
                    "^LS0" & _
                    "^FO160,160^GFA,00768,00768,00012,:Z64:" & _
                    "eJztjjEKwzAMRV00aAnSmsGNzhHopbp3SPHgsVdKphyj9BYZgtyv9A4dSmU+PMzn8VP6nbPdmu1C9TQnc3VzoXKfkjVt1oTXZU6dSoQqOHNGPtyTRKi8pviLcL3OST0eOmD4/fCP4A3+Df0R/ZtEeD3DeZEIVQUP8A96cC/wizIx+qotKzdm7OGHd1ycKfY8W+ZlZ+z/33fuDU7XOqw=:5EE3" & _
                    "^BY2,3,121^FT13,164^BCN,,Y,Y" & _
                    "^FD>;" & _
                    prodfirst6 & _
                    ">" & _
                    "6" & _
                    prodlast1 & _
                    "-" & _
                    section & _
                    "-RERUN" & _
                    "^FS" & _
                    "^PQ1,0,1,Y^XZ"

            ElseIf tubetype = "custserv" Then
                ZPLString2x1 = _
                   "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                    "^XA" & _
                    "^MMT" & _
                    "^PW406" & _
                    "^LL0203" & _
                    "^LS0" & _
                    "^FO64,160^GFA,02048,02048,00032,:Z64:" & _
                    "eJztkTFu2zAYhX+CQLgU9JrBKK+QbCoSWPHUa2TLFlDoYiAGrEBDNusCOcxvOKiv8QteA1XeWFQw88im6B0SP0EQpI9P/3sk0UkfW06xdyoOjgbnRjeQoXiIc/5WL00Ej4/sV00cYh1m5bE8Uimxi3u+aqKJNanYgW9g6YbSjeCrAS8H/mFi8mvpOIhYLSHMplRYCkEUPv1p2xa/V/WcPYPXflxN6dzSrWfFlVRrZcB1jXxC4IvX+yL7Cf6F7NeUuCHwJZ0Zuny9m9LFV1oS/P52O6V/fmS3pi76PufL+WWAf4L82e/YGipe7tB/JDeAc7V5ppw/cS2J9305lkI6gNcPzTrz7Cef5v/8jvmeCPl3dNn8n/+bQ8r/q0f/BUkhaitX8E8yn3PF3mqudjv0vwZntRGn3vtLltUdEqP/jMIC/aVs2uYp7V+UKCs5wzlsd25E/7T/qKT/7j9FTissnvu1OxaT1P/AwekmtuhPLl9fcG+e3HhuyNyAX1v1fv4nnXTSZ9UbK9DoBQ==:2BC8" & _
                    "^BY2,3,122^FT49,163^BCN,,Y,Y" & _
                     "^FD>:" & _
                      prodfirst6 & _
                    ">" & _
                    "2" & _
                    prodlast1 & _
                    "-" & _
                    section & _
                    "-WRTY" & _
                    "^FS" & _
                    "^PQ1,0,1,Y^XZ"

            End If


            Try

                Dim client As New System.Net.Sockets.TcpClient
                client.Connect(ipAddress, port)

                'Write ZPL String to Connection
                Dim writer As New System.IO.StreamWriter(client.GetStream())
                writer.Write(ZPLString2x1)
                writer.Flush()

                writer.Close()
                client.Close()
                'MesgBox(prodfirst6 & prodlast1 & "-" & section)
            Catch ex As Exception


            End Try
        Next
        'How to call
        'PrintLabels("1900001", 2, "Ctr")

    End Function

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvRoller.DataBind()
    End Sub

    Protected Sub gvRoller_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRoller.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFabOptions"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsOverrides"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch
            End Try

            If (e.Row.DataItem("RerunP") > 1) Or (e.Row.DataItem("RerunSB") > 1) Then
                e.Row.BackColor = Drawing.Color.LightYellow
            End If

        End If
    End Sub

    Protected Sub gvRoller_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvRoller.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRoller.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Roller" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
            Dim url2 As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url2 + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)
            'This next line works, unless it is in an update panel. Then it doesn't. Response.Write doesn't work inside those. Use ScriptManager instead.
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url2 & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRoller.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Roller" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)

        End If

        'This code is for the update button
        If e.CommandName = "gotoupdateP" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoller.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoller.Rows(Key).FindControl("btnUpdateRollerP"), Image)
            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 26, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.

            Dim NextWorkstationHasDate As Int16
            Dim RerunStatus As Int16

            Dim NumOuterSections As Integer = gvRoller.Rows(Key).Cells(7).Text
            Dim stationID As String = GlobalVariables.stationID

            'start with all 0s for the seamer sections
            Dim PF As Integer = -1
            Dim PM As Integer = 0
            Dim PM2 As Integer = 0
            Dim PR As Integer = -1

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
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If NumOuterSections = 3 Then
                PM = -1
            ElseIf NumOuterSections = 4 Then
                PM = -1
                PM2 = -1
            End If

            cmd7.Parameters.AddWithValue("@PF", PF)
            cmd7.Parameters.AddWithValue("@PM", PM)
            cmd7.Parameters.AddWithValue("@PM2", PM2)
            cmd7.Parameters.AddWithValue("@PR", PR)

            cmd8.Parameters.AddWithValue("@PF8", 0)
            cmd8.Parameters.AddWithValue("@PM8", 0)
            cmd8.Parameters.AddWithValue("@PM28", 0)
            cmd8.Parameters.AddWithValue("@PR8", 0)


            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RollerStatusP = '2', RoundSeamerStatusP = '1', Roller = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RollerStatusP = 2 and RollerStatusS = 2 and Convert(date,Roller) ='" & ThisDay & "'"
            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RoundSeamerStatusP = 2 and ProdNo = '" & SelectedProdNo & "'"
            'reverse done
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RollerStatusP = '1', RoundSeamerStatusP = '0', Roller = NULL where ProdNo =  '" & SelectedProdNo & "'"
            'look to see if it is a rerun
            cmd5.CommandText = "Select RerunP From BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & SelectedProdNo & "'"
            'if it is, set rerun to in progress which will show as yellow.
            cmd6.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RerunP = 2 where ProdNo = '" & SelectedProdNo & "'"
            cmd7.CommandText = "UPDATE Tubes SET RollerPStatus = '2', SeamerSectPFStatus = @PF,  SeamerSectPMStatus = @PM, SeamerSectPM2Status = @PM2, SeamerSectPRStatus = @PR, RollerP = '" & TodaysDate & "', OuterRollerID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            'reversal
            cmd8.CommandText = "UPDATE Tubes SET RollerPStatus = '1', SeamerSectPFStatus = @PF8,  SeamerSectPMStatus = @PM8, SeamerSectPM2Status = @PM28, SeamerSectPRStatus = @PR8, RollerP = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd9.CommandText = "Select Count (*) FROM Tubes where RollerPStatus = 2 and OuterRoller = 'Green' and Convert(date,RollerP) ='" & ThisDay & "'"
            cmd10.CommandText = "Select Count (*) FROM Tubes where RollerSStatus = 2 and OuterRoller = 'Green' and Convert(date,RollerS) ='" & ThisDay & "'"
            cmd11.CommandText = "Select Count (*) FROM Tubes where RollerCStatus = 2 and CenterRoller = 'Green' and Convert(date,RollerC) ='" & ThisDay & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd6.Connection = conn
            cmd7.Connection = conn
            cmd8.Connection = conn
            'to get the count of the prod #'s completed that day
            cmd9.Connection = conn
            cmd10.Connection = conn
            cmd11.Connection = conn

            conn.Open()

            If framevalue <= 1 Then
                'cmd.ExecuteNonQuery()
                cmd7.ExecuteNonQuery()

                PrintLabelsByTubeType(SelectedProdNo, NumOuterSections, "Port", "prod")
                Try
                    PrintBuildInstrLabels(SelectedProdNo, "PORT", "prod")
                Catch ex As Exception

                End Try
                RerunStatus = Convert.ToInt16(cmd5.ExecuteScalar())
                If RerunStatus = 3 Then
                    cmd6.ExecuteNonQuery()
                End If
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    'cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    cmd8.ExecuteNonQuery()
                End If
            End If

            lblPort.Text = "P:" & Convert.ToInt16(cmd9.ExecuteScalar())
            lblStrb.Text = " S:" & Convert.ToInt16(cmd10.ExecuteScalar())
            lblCtr.Text = " C:" & Convert.ToInt16(cmd11.ExecuteScalar())

            gvRoller.DataBind()
            conn.Close()

        End If

        'This code is for the update button
        If e.CommandName = "gotoupdateS" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoller.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoller.Rows(Key).FindControl("btnUpdateRollerS"), Image)
            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 26, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.

            Dim NextWorkstationHasDate As Int16
            Dim RerunStatus As Int16
            Dim stationID As String = GlobalVariables.stationID

            'start with all 0s for the seamer sections
            Dim NumOuterSections As Integer = gvRoller.Rows(Key).Cells(7).Text

            Dim SF As Integer = -1
            Dim SM As Integer = 0
            Dim SM2 As Integer = 0
            Dim SR As Integer = -1

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
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If NumOuterSections = 3 Then
                SM = -1
            ElseIf NumOuterSections = 4 Then
                SM = -1
                SM2 = -1
            End If

            cmd7.Parameters.AddWithValue("@SF", SF)
            cmd7.Parameters.AddWithValue("@SM", SM)
            cmd7.Parameters.AddWithValue("@SM2", SM2)
            cmd7.Parameters.AddWithValue("@SR", SR)

            cmd8.Parameters.AddWithValue("@SF8", 0)
            cmd8.Parameters.AddWithValue("@SM8", 0)
            cmd8.Parameters.AddWithValue("@SM28", 0)
            cmd8.Parameters.AddWithValue("@SR8", 0)

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RollerStatusS = '2', RoundSeamerStatusS = '1', Roller = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RollerStatusS = 2 and RollerStatusP = 2 and Convert(date,Roller) ='" & ThisDay & "'"
            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RoundSeamerStatusS = 2 and ProdNo = '" & SelectedProdNo & "'"
            'reverse done
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RollerStatusS = '1', RoundSeamerStatusS = '0', Roller = NULL where ProdNo =  '" & SelectedProdNo & "'"
            'look to see if it is a rerun
            cmd5.CommandText = "Select RerunSB from BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & SelectedProdNo & "'"
            'if it is, set rerun to in progress which will show as yellow.
            cmd6.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RerunSB = 2 where ProdNo = '" & SelectedProdNo & "'"
            cmd7.CommandText = "UPDATE Tubes SET RollerSStatus = '2', SeamerSectSFStatus = @SF,  SeamerSectSMStatus = @SM, SeamerSectSM2Status = @SM2, SeamerSectSRStatus = @SR, RollerS = '" & TodaysDate & "', OuterRollerID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            'reversal
            cmd8.CommandText = "UPDATE Tubes SET RollerSStatus = '1', SeamerSectSFStatus = @SF8,  SeamerSectSMStatus = @SM8, SeamerSectSM2Status = @SM28, SeamerSectSRStatus = @SR8, RollerS = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"

            cmd9.CommandText = "Select Count (*) FROM Tubes where RollerPStatus = 2 and OuterRoller = 'Green' and Convert(date,RollerP) ='" & ThisDay & "'"
            cmd10.CommandText = "Select Count (*) FROM Tubes where RollerSStatus = 2 and OuterRoller = 'Green' and Convert(date,RollerS) ='" & ThisDay & "'"
            cmd11.CommandText = "Select Count (*) FROM Tubes where RollerCStatus = 2 and CenterRoller = 'Green' and Convert(date,RollerC) ='" & ThisDay & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd6.Connection = conn
            cmd7.Connection = conn
            cmd8.Connection = conn
            'to get the count of the prod #'s completed that day
            cmd9.Connection = conn
            cmd10.Connection = conn
            cmd11.Connection = conn

            conn.Open()

            If framevalue <= 1 Then
                'cmd.ExecuteNonQuery()
                cmd7.ExecuteNonQuery()

                PrintLabelsByTubeType(SelectedProdNo, NumOuterSections, "Strb", "prod")
                Try
                    PrintBuildInstrLabels(SelectedProdNo, "STRB", "prod")
                Catch ex As Exception

                End Try
                RerunStatus = Convert.ToInt16(cmd5.ExecuteScalar())
                If RerunStatus = 3 Then
                    cmd6.ExecuteNonQuery()
                End If
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    'cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    cmd8.ExecuteNonQuery()
                End If
            End If

            lblPort.Text = "P:" & Convert.ToInt16(cmd9.ExecuteScalar())
            lblStrb.Text = " S:" & Convert.ToInt16(cmd10.ExecuteScalar())
            lblCtr.Text = " C:" & Convert.ToInt16(cmd11.ExecuteScalar())

            gvRoller.DataBind()
            conn.Close()

        End If

        'This code is for the update button
        If e.CommandName = "gotoupdateCtr" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoller.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoller.Rows(Key).FindControl("btnUpdateRollerCtr"), Image)
            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 26, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.

            Dim NextWorkstationHasDate As Int16
            Dim RerunStatus As Int16
            Dim stationID As String = GlobalVariables.stationID

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
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            Dim NumCenterSections As Integer = gvRoller.Rows(Key).Cells(8).Text

            Dim CF As Integer = -1
            Dim CM As Integer = 0
            Dim CM2 As Integer = 0
            Dim CR As Integer = -1

            If NumCenterSections = 3 Then
                CM = -1
            ElseIf NumCenterSections = 4 Then
                CM = -1
                CM2 = -1
            End If

            cmd7.Parameters.AddWithValue("@CF", CF)
            cmd7.Parameters.AddWithValue("@CM", CM)
            cmd7.Parameters.AddWithValue("@CM2", CM2)
            cmd7.Parameters.AddWithValue("@CR", CR)

            cmd8.Parameters.AddWithValue("@CF8", 0)
            cmd8.Parameters.AddWithValue("@CM8", 0)
            cmd8.Parameters.AddWithValue("@CM28", 0)
            cmd8.Parameters.AddWithValue("@CR8", 0)

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RollerStatusCtr = '2', RoundSeamerStatusCtr = '1', RollerCtr = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RollerStatusCtr = 2 and Convert(date,RollerCtr) ='" & ThisDay & "'"
            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RoundSeamerStatusCtr = 2 and ProdNo = '" & SelectedProdNo & "'"
            'reverse done
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET RollerStatusCtr = '1', RoundSeamerStatusCtr = '0', RollerCtr = NULL where ProdNo =  '" & SelectedProdNo & "'"
            'look to see if it is a rerun
            cmd5.CommandText = "Select RerunCtr From BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & SelectedProdNo & "'"
            'if it is, set rerun to in progress which will show as yellow.
            cmd6.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RerunCtr = 2 where ProdNo = '" & SelectedProdNo & "'"
            cmd7.CommandText = "UPDATE Tubes SET RollerCStatus = '2', SeamerSectCFStatus = @CF,  SeamerSectCMStatus = @CM, SeamerSectCM2Status = @CM2, SeamerSectCRStatus = @CR, RollerC = '" & TodaysDate & "', CenterRollerID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            'reversal
            cmd8.CommandText = "UPDATE Tubes SET RollerCStatus = '1', SeamerSectCFStatus = @CF8,  SeamerSectCMStatus = @CM8, SeamerSectCM2Status = @CM28, SeamerSectCRStatus = @CR8, RollerC = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd9.CommandText = "Select Count (*) FROM Tubes where RollerPStatus = 2 and OuterRoller = 'Green' and Convert(date,RollerP) ='" & ThisDay & "'"
            cmd10.CommandText = "Select Count (*) FROM Tubes where RollerSStatus = 2 and OuterRoller = 'Green' and Convert(date,RollerS) ='" & ThisDay & "'"
            cmd11.CommandText = "Select Count (*) FROM Tubes where RollerCStatus = 2 and CenterRoller = 'Green' and Convert(date,RollerC) ='" & ThisDay & "'"
            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd6.Connection = conn
            cmd7.Connection = conn
            cmd8.Connection = conn

            'to get the count of the prod #'s completed that day
            cmd9.Connection = conn
            cmd10.Connection = conn
            cmd11.Connection = conn

            conn.Open()

            If framevalue <= 1 Then
                'cmd.ExecuteNonQuery()
                cmd7.ExecuteNonQuery()

                PrintLabelsByTubeType(SelectedProdNo, NumCenterSections, "Ctr", "prod")
                Try
                    PrintBuildInstrLabels(SelectedProdNo, "CTR", "prod")
                Catch ex As Exception

                End Try
                RerunStatus = Convert.ToInt16(cmd5.ExecuteScalar())
                If RerunStatus = 3 Then
                    cmd6.ExecuteNonQuery()
                End If
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    'cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    cmd8.ExecuteNonQuery()
                End If
            End If

            lblPort.Text = "P:" & Convert.ToInt16(cmd9.ExecuteScalar())
            lblStrb.Text = " S:" & Convert.ToInt16(cmd10.ExecuteScalar())
            lblCtr.Text = " C:" & Convert.ToInt16(cmd11.ExecuteScalar())

            gvRoller.DataBind()
            conn.Close()

        End If
    End Sub

    Protected Function PrintBuildInstrLabels(prod As String, tube As String, tubetype As String) As String
        'data either comes from tube schedule if it is a prod or a rerun
        'This is for prod and rerun outers and centers only.
        'OutertubeDetails, CenterTubeDetails
        'Print Label

        'Dim ipAddress As String = "10.5.110.58" 'Keri
        Dim ipAddress As String = "10.54.80.18" 'Green
        Dim port As Integer = 9100

        Dim ZPLString2x1 As String = ""

        'Build Schedule Labels
        If ((tubetype = "prod" Or tubetype = "rerun") And (tube = "PORT" Or tube = "STRB")) Then  '2x1 Printer format for Production Tubes and Reruns     

            PopulateDataTablesOuters(prod, tubetype)

            Dim ShortProdNo As String = ""
            Dim Style As String = ""
            Dim Diameter As String = ""
            Dim Front As String = ""
            Dim TubeModel As String = ""
            Dim Ladder As String = ""
            Dim Bracket As String = ""
            Dim Keel As String = ""
            Dim Fuel As String = ""
            Dim Splash As String = ""
            Dim Strakes As String = ""
            Dim StrakesComments As String = ""
            Dim StrbTrans As String = ""
            Dim Comments As String = ""
            Dim OuterScheduled As String = ""
            Dim OuterScheduledOrder As String = ""
            Dim ItemNo As String = ""

            For Each row As DataRow In buildinst.Rows
                For Each column As DataColumn In buildinst.Columns
                    If column.ColumnName = "ShortProdNo" Then
                        ShortProdNo = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Style" Then
                        Style = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Diameter" Then
                        Diameter = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Front" Then
                        Front = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "TubeModel" Then
                        TubeModel = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Ladder" Then
                        Ladder = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Bracket" Then
                        Bracket = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Keel" Then
                        Keel = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Fuel" Then
                        Fuel = row(column.ColumnName).ToString()
                        If Fuel = "NO FUEL" Then
                            Fuel = "NO"
                        ElseIf Fuel = "CENTER" Then
                            Fuel = "Ctr"
                        End If
                    End If

                    If column.ColumnName = "Splash" Then
                        Splash = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Strakes" Then
                        Strakes = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "StrakesComments" Then
                        StrakesComments = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "StrbTrans" Then
                        StrbTrans = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Comments" Then
                        Comments = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "OuterScheduled" Then
                        OuterScheduled = row(column.ColumnName).ToString()
                        OuterScheduled = OuterScheduled.Substring(0, OuterScheduled.Length - 17)
                    End If

                    If column.ColumnName = "OuterScheduleOrder" Then
                        OuterScheduledOrder = row(column.ColumnName).ToString()
                        OuterScheduledOrder = OuterScheduledOrder + 1
                    End If

                    If column.ColumnName = "TubeModel" Then
                        TubeModel = row(column.ColumnName).ToString()
                    End If
                Next
            Next



            'Outer Tube 2x1 Label
            ZPLString2x1 = _
                "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                "^XA" & _
                "^MMT" & _
                "^PW406" & _
                "^LL0203" & _
                "^LS0" & _
                "^FO288,64^GFA,00768,00768,00012,:Z64:" & _
                "eJxjYBgFBAAf8/n//f9kwGwe9vb//P8hbD5+9v/9/+3AbDY5dgYeBqi4DR8DH5TNUwERLwCJ/2AHisuB2ewf2P/z/4OI8//gB7NBgH8OUPwPlL0PpB5iPh8fkvn8SOazI4kztwPdI/8PZCYb83GgO+X/gO1lfg90P4SNC9j/h4A/aOxhDwD/szcj:729E" & _
                "^FO0,64^GFA,00768,00768,00012,:Z64:" & _
                "eJztjrENwjAQRY0s+bq7NsUpt0JKF4isxAiewGyQWbIBKzBCSheRzTk2BQUVFRK/uaev7ycb88/3mZMktPcSKu+SHUBZK2cpkW4HD8iAoxnq3ivHs/GVJ8fgrnpaTzHpUZZdCm36rPkzpbZX5wZspu5JtLTeAzNi9wNfkLofWBy0/ZzVD6H79T+ntfvZRvs4+k8pr4R3/u08AaEGPGE=:389C" & _
                "^FO192,64^GFA,00512,00512,00008,:Z64:" & _
                "eJzdi7ENgDAMBL/CTURqJINXYANWYQQ62lSsxiawBeEdEAUTIL45nf8N/CySVSyTR13FnOhGT6hggp535wR6XDAGertiUu6bFb1Td+/lCBtG3+t87XW4/sniobt783/2sfxDxf0dyyUPP5ITcKojYA==:F0A4" & _
                "^FO96,64^GFA,00768,00768,00012,:Z64:" & _
                "eJxjYBgFBAD/Dz7mBzD2Hx72AzD2/z52mDgbOxt7AZTNx9zH9wHK5mE8w1YgAxM/x2chB1XPeEzGACEuY4FQLyMDN+ed/T8Ym/Gc/R+E+XBxHvaeAj6Eeyr4oeaz/2MrYJeBu/8B+xz8frT/DwKY7GEPAGZAJuA=:23AA" & _
                "^FT369,37^A0N,25,24^FH\^FD" & OuterScheduledOrder & "^FS" & _
                "^FT16,46^A0N,39,38^FH\^FD" & ShortProdNo & "^FS" & _
                "^FT257,107^A0N,28,28^FH\^FD" & Front & "^FS" & _
                "^FT310,75^A0N,28,28^FH\^FD" & Ladder & "^FS" & _
                "^FT92,108^A0N,28,28^FH\^FD" & Bracket & "^FS" & _
                "^FT16,142^A0N,28,28^FH\^FD" & Fuel & "^FS" & _
                "^FT385,107^A0N,28,28^FH\^FD" & Keel & "^FS" & _
                "^FT171,108^A0N,28,28^FH\^FD" & Diameter & "^FS" & _
                "^FT121,39^A0N,28,28^FH\^FD" & TubeModel & "^FS" & _
                "^FT15,77^A0N,28,28^FH\^FD" & Style & "^FS" & _
                "^FT135,141^A0N,28,28^FH\^FD" & StrbTrans & "^FS" & _
                "^FT181,172^A0N,28,28^FH\^FD" & StrakesComments & "^FS" & _
                "^FT22,196^A0N,20,21^FH\^FD" & Comments & "^FS" & _
                "^FT16,173^A0N,28,28^FH\^FD" & Strakes & "^FS" & _
                "^FT139,74^A0N,25,28^FH\^FD" & Splash & "^FS" & _
                "^FT321,36^A0N,17,16^FH\^FD" & OuterScheduled & "^FS" & _
                "^PQ1,0,1,Y^XZ"

        ElseIf (tubetype = "prod" Or tubetype = "rerun") And tube = "CTR" Then 'need to add section to the design
            PopulateDataTablesCenters(prod, tubetype)

            'Center Tube 2x1 Label
            Dim shortprodno As String = ""
            Dim Length As String = ""
            Dim Center As String = ""
            Dim Storage As String = ""
            Dim TenWide As String = ""
            Dim Bracket As String = ""
            Dim Fuel As String = ""
            Dim Strakes As String = ""
            Dim TubeUpg As String = ""
            Dim Upsweep_SldTrans As String = ""
            Dim CenterScheduled As String = ""
            Dim CenterScheduleOrder As String = ""
            Dim TubeModel As String = ""

            For Each row As DataRow In buildinstctr.Rows
                For Each column As DataColumn In buildinstctr.Columns
                    If column.ColumnName = "ShortProdNo" Then
                        shortprodno = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Length" Then
                        Length = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Center" Then
                        Center = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Storage" Then
                        Storage = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "TenWide" Then
                        TenWide = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Bracket" Then
                        Bracket = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Fuel" Then
                        Fuel = row(column.ColumnName).ToString()
                        If Fuel = "NO FUEL" Then
                            Fuel = "NO"
                        End If
                    End If

                    If column.ColumnName = "Strakes" Then
                        Strakes = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "TubeUpg" Then
                        TubeUpg = row(column.ColumnName).ToString()
                        If TubeUpg = "" Then
                            TubeUpg = "NO"
                        End If
                    End If

                    If column.ColumnName = "Upsweep_SldTrans" Then
                        Upsweep_SldTrans = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "CenterScheduled" Then
                        CenterScheduled = row(column.ColumnName).ToString()
                        CenterScheduled = CenterScheduled.Substring(0, CenterScheduled.Length - 17)
                    End If

                    If column.ColumnName = "CenterScheduleOrder" Then
                        CenterScheduleOrder = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "TubeModel" Then
                        TubeModel = row(column.ColumnName).ToString()
                    End If
                Next
            Next

            ZPLString2x1 = _
                "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                "^XA" & _
                "^MMT" & _
                "^PW406" & _
                "^LL0203" & _
                "^LS0" & _
                "^FO0,64^GFA,00768,00768,00012,:Z64:" & _
                "eJztjzEKgDAMRSMdegkP4djBQzk6COZoOcoHD2DcFIQIWltxcNXBPz0e6YMS/Xt1hQnqfo0MtDZHVmj0JA3g+PDSDHIyVwM7RvQjedmZDGPyJpbuTRfOnQn+5HDpB2jqB7T5LTqX+qhzH6Vjffqjt33znT+wDXXfUXw=:7492" & _
                "^FO192,128^GFA,00640,00640,00020,:Z64:" & _
                "eJzNkDFqxDAQRWcQYZpF07oQ1jVcmN2TBJIbJH1ADinShJwg5Cyz7AX2AFvY7AXWnQrhiZCVQIpAihT5lfg8vv58gH+kq2NIJD7hBQKqFI/jbuHoF4igjzoWz6ewhOQVk9Gpeq4H6bYbxmiGaVjznEO5847wRLBf46ABHEbbGPNC+WUK6SVz5IjesyemkHwBGYkX82oB9VA4Spg9n4iZ5toPUs4jH8lanrR+3Ja8B1KiuWKdBbmxrmcluK1Y35Z+rddnuK+ca3Hoto215unrjryI7JJjZw4663ntF0E4bugNJe9yHtb9UOjo6IRy/dn5twr6TeNP3h/rA4cThNI=:C118" & _
                "^FO256,64^GFA,00768,00768,00012,:Z64:" & _
                "eJztjzEOwkAMBH26B+Q7VOErkfIBfpBFFJR8aa/iG3dKQUt5VcwpjlNQUCIK1s1otVrbIn99RRHzgiOMpSgnbn7RrHnlgJISn55vM3ieo8iw5TlDsufvYtzy+rjUvf8avacsN/eRGHHa+yMOtrdtDTQ/aKJotYP0TJlo3EdIj/zpx05X1Xf+Yb0AMC9PMQ==:BF51" & _
                "^FO96,64^GFA,00768,00768,00012,:Z64:" & _
                "eJztjbsNgDAMBY0YgFVcpssqGSEbOKMxykMs4DJd+MSKEJ8WUfDSnE7Whejf6/MZTjIqa2DR0HwxzwQXqbI7MFPgSKFL5kHo094ZnSi6ytj40t/utXXA9/0Y1775ktc3p917iJap/jskMf+0YsOJP7YFteJReA==:9AA5" & _
                "^FO256,32^GFA,00768,00768,00012,:Z64:" & _
                "eJxjYBgFFAPmBv5/cuwQNiMD/38YGyzODxVv4GGQh4vzMci3w9QDxdvZEOLn+6Dq+f/JHueDmyPzHG7+P5l0hDky/xHmy9QjidtD2UDzZeSh7P/9/2XkoeaD2Px8CHEoGxfg/w8GDejsIQ4AK4sqAA==:9285" & _
                "^FT369,37^A0N,25,24^FH\^FD" & CenterScheduleOrder & "^FS" & _
                "^FT16,40^A0N,33,38^FH\^FD" & shortprodno & "^FS" & _
                "^FT325,153^A0N,28,28^FH\^FD" & Storage & "^FS" & _
                "^FT72,113^A0N,28,28^FH\^FD" & Bracket & "^FS" & _
                "^FT172,114^A0N,28,28^FH\^FD" & Fuel & "^FS" & _
                "^FT116,40^A0N,28,28^FH\^FD" & TubeModel & "^FS" & _
                "^FT157,77^A0N,28,28^FH\^FD" & TenWide & "^FS" & _
                "^FT324,79^A0N,28,28^FH\^FD" & Length & "^FS" & _
                "^FT16,78^A0N,28,28^FH\^FD" & Center & "^FS" & _
                "^FT328,113^A0N,28,28^FH\^FD" & TubeUpg & "^FS" & _
                "^FT15,190^A0N,20,21^FH\^FD" & Upsweep_SldTrans & "^FS" & _
                "^FT13,156^A0N,28,28^FH\^FD" & Strakes & "^FS" & _
                "^FT321,36^A0N,17,16^FH\^FD" & CenterScheduled & "^FS" & _
                "^FT379,192^A0N,25,24^FH\^FDC^FS" & _
                "^PQ1,0,1,Y^XZ"
        End If


        Try

            Dim client As New System.Net.Sockets.TcpClient
            client.Connect(ipAddress, port)

            'Write ZPL String to Connection
            Dim writer As New System.IO.StreamWriter(client.GetStream())

            If tube = "PORT" Then 'print twice one for each rear tube
                'writer.Write(ZPLString2x1)
                writer.Write(ZPLString2x1)
            ElseIf tube = "STRB" Then
                writer.Write(ZPLString2x1)
            Else 'CTR
                writer.Write(ZPLString2x1)
            End If

            writer.Flush()

            writer.Close()
            client.Close()

        Catch ex As Exception

        End Try

    End Function

    Protected Function PrintBuildInstrLabelsCustService(prod As String) As String
        Dim ipAddress As String = "10.54.80.18" 'Green
        Dim port As Integer = 9100

        PopulateDataTablesCS(prod)

        Dim ZPLString2x1 As String = ""

        'If tubetype = "custserv" Then

        Dim CSIDNo As String = ""
        Dim OENo As String = ""
        Dim Length As String = ""
        Dim Dealer As String = ""
        Dim Style As String = ""
        Dim Diameter As String = ""
        Dim Front As String = ""
        Dim Ladder As String = ""
        Dim Bracket As String = ""
        Dim Fuel As String = ""
        Dim Splash As String = ""
        Dim Strakes As String = ""
        Dim StrakesComments As String = ""
        Dim StrbTrans As String = ""
        Dim Comments As String = ""
        Dim OuterScheduled As String = ""

        Dim CenterScheduled As String = ""
        Dim Center As String = ""
        Dim TenWide As String = ""
        Dim TubeUpg As String = ""
        Dim Storage As String = ""
        Dim Upsweep As String = ""

        Dim isport As Integer = 0
        Dim isstrb As Integer = 0
        Dim isctr As Integer = 0

        'TubeID, OENo, Dealer, Customer, Model, ModelYear, Style, Diameter, Front, Port, Strb, Ctr, Ladder, Bracket, Keel, Fuel, Splash, Strakes, StrakesComments, StrbTrans, Comments, OuterScheduledFlag, CenterScheduledFlag, OuterScheduled, CenterScheduled

        For Each row As DataRow In buildinstcs.Rows
            For Each column As DataColumn In buildinstcs.Columns
                If column.ColumnName = "TubeID" Then
                    CSIDNo = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "OENo" Then
                    OENo = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Dealer" Then
                    Dealer = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Model" Then
                    Length = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Style" Then
                    Style = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Front" Then
                    Front = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Port" Then
                    If row(column.ColumnName).ToString() = "1" Then
                        isport = 1
                    End If
                End If

                If column.ColumnName = "Strb" Then
                    If row(column.ColumnName).ToString() = "1" Then
                        isstrb = 1
                    End If
                End If

                If column.ColumnName = "Ctr" Then
                    If row(column.ColumnName).ToString() = "1" Then
                        isctr = 1
                    End If
                End If

                If column.ColumnName = "Ladder" Then
                    Ladder = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Bracket" Then
                    Bracket = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Fuel" Then
                    Fuel = row(column.ColumnName).ToString()
                    If Fuel = "NO FUEL" Then
                        Fuel = "NO"
                    ElseIf Fuel = "Fuel" Then
                        Fuel = "FUEL"
                    ElseIf Fuel = "CENTER" Then
                        Fuel = "Ctr"
                    End If
                End If

                If column.ColumnName = "Splash" Then
                    Splash = row(column.ColumnName).ToString()
                    If Splash = "EXTRUDED" Then
                        Splash = "EXT"
                    ElseIf Splash = "REGULAR" Then
                        Splash = "REG"
                    End If
                End If

                If column.ColumnName = "Strakes" Then
                    Strakes = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "StrakesComments" Then
                    StrakesComments = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "StrbTrans" Then
                    StrbTrans = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Comments" Then
                    Comments = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "OuterScheduled" Then
                    OuterScheduled = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "TubeUpg" Then
                    TubeUpg = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Upsweep" Then
                    Upsweep = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "CenterScheduled" Then
                    CenterScheduled = row(column.ColumnName).ToString()
                    'CenterScheduled = CenterScheduled.Substring(0, CenterScheduled.Length - 17)
                End If

                If column.ColumnName = "Center" Then
                    Center = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "TenWide" Then
                    TenWide = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Storage" Then
                    Storage = row(column.ColumnName).ToString()
                End If

            Next
        Next

        Dim tubetoprint As String = ""
        If isport = 1 Then
            tubetoprint = "PORT"
            OuterScheduled = OuterScheduled.Substring(0, OuterScheduled.Length - 17)
        ElseIf isstrb = 1 Then
            tubetoprint = "STRB"
            OuterScheduled = OuterScheduled.Substring(0, OuterScheduled.Length - 17)
        ElseIf isctr = 1 Then
            tubetoprint = "CTR"
            CenterScheduled = CenterScheduled.Substring(0, CenterScheduled.Length - 17)
        End If

        If tubetoprint = "PORT" Or tubetoprint = "STRB" Then

            ZPLString2x1 = _
            "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
            "^XA" & _
            "^MMT" & _
            "^PW406" & _
            "^LL0203" & _
            "^LS0" & _
            "^FO256,160^GFA,01280,01280,00020,:Z64:" & _
            "eJztkD0KwkAQRr9lwVjIeIGI15hC9FC2YjZssd2ewINYJgim8wyRXGDFJkV0TYhJ9gzi1wzzeDA/wG9n2xcKkPB9TbKJSd81c/hyYlHeMRYPF3hQHUMWepA6dYlwOKwaGuZJbeojaryXN5o8EzOSvFhH8eTZBWNXaTv7slnLiowRPQ2FnqkZqLyVHMxtWGR7f5LngWmtth1TNLL8UljaCPcoYuGGey/GEsPfr4Ry+Ev6Ms263c+PXvu/SpUEUjx6//zzM/kA0WdKow==:06BB" & _
            "^FO64,0^GFA,00768,00768,00012,:Z64:" & _
            "eJxjYBgFECDDUP/hgwWEzcFQ/wPGBotXQNg8DAkMP+DiBQx/4OoTgGwDuPi/mgKo+voP7ywK4OY8R5j/4TGSOc9/IMx//AMh/hDKlgCKP4Cy5f/U/3jwB2ImP4hdUYAQh7Jxgfr/IPAHgz1yAQB6tTwO:13D0" & _
            "^FO0,32^GFA,00768,00768,00012,:Z64:" & _
            "eJxjYBgFAwuYH/D/Y+BJALPZ//D/Z5BxALPl/wHFJR6A2TL8PAwMEgfAbAt+PiABETdg52Fg/P+xASzO3MfA8P8xmF3A3P+PQfAggm0IZgLZQDMNIfb+AKv/ABEHm/MBaj5QPBmiXkYeaG8yA8w9/xkeNzfA3enO2AB1/3+GR8wN+Pz4HwIeoLMHHgAAJfM6Og==:7EC7" & _
            "^FO256,0^GFA,00768,00768,00012,:Z64:" & _
            "eJxjYBgFUMD8j7nhB4z9n5nxA5z9uBEmzth4sPEOTLzhcfMeGJuhmHEOO0z8c3MfewNEfUNhOw9CvJ0PoZ6dHW7O7/7/DTB2cf9/hPkIccbHMsww9v/H85iPQ83/3ziH8Tjc/TsYn+P3I/9/EDiAwR6xAADuLjVN:7C7C" & _
            "^FO273,131^GB125,69,2^FS" & _
            "^FT16,46^A0N,39,38^FH\^FD" & CSIDNo & "^FS" & _
            "^FT275,83^A0N,28,28^FH\^FD" & Front & "^FS" & _
            "^FT330,82^A0N,28,28^FH\^FD" & Ladder & "^FS" & _
            "^FT13,120^A0N,28,28^FH\^FD" & Fuel & "^FS" & _
            "^FT134,41^A0N,28,28^FH\^FD" & Length & "^FS" & _
            "^FT161,79^A0N,23,24^FH\^FD" & Dealer & "^FS" & _
            "^FT75,82^A0N,23,24^FH\^FD" & OENo & "^FS" & _
            "^FT333,41^A0N,28,28^FH\^FD" & Diameter & "^FS" & _
            "^FT171,42^A0N,28,28^FH\^FD" & Style & "^FS" & _
            "^FT11,156^A0N,28,28^FH\^FD" & StrbTrans & "^FS" & _
            "^FT259,121^A0N,28,28^FH\^FD" & StrakesComments & "^FS" & _
            "^FT20,190^A0N,20,21^FH\^FD" & Comments & "^FS" & _
            "^FT127,120^A0N,28,28^FH\^FD" & Strakes & "^FS" & _
            "^FT317,161^A0N,23,24^FH\^FD" & tubetoprint & "^FS" & _
            "^FT178,156^A0N,25,28^FH\^FD" & Splash & "^FS" & _
            "^FT284,158^A0N,17,16^FH\^FD" & OuterScheduled & "^FS" & _
            "^PQ1,0,1,Y^XZ"


        ElseIf tubetoprint = "CTR" Then 'need to add section to the design
            ZPLString2x1 = _
                "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                "^XA" & _
                "^MMT" & _
                "^PW406" & _
                "^LL0203" & _
                "^LS0" & _
                "^FO0,96^GFA,00384,00384,00012,:Z64:" & _
                "eJxjYKASYDxQ+N9B/gCE3VDw/4H9A6h4wf8P9R8gig4UPHjwoAKmHggNYOofGDYwGEDVPyg8wFAAU/+4AcIGmf/54B+4+Ycbf8DNd4eJH0h4wHjAAm4+4wEZiL1AWxkeQMQZ/gPZ9X8g5tcfeMBg/wDClmc8wCDvUIDPj+z/weAPOpsCAABp4Ux0:3807" & _
                "^FO160,0^GFA,00768,00768,00012,:Z64:" & _
                "eJxjYBgFYMD4Qf7//D8QNvM//v/z/0HY/P/l/9//D2Hz8TMU8PBD2DKsDAUy7BC2BAODgQQzH0ScASQOYVsA2fz/EGx5qPlAtoH8Dwi7BqS+Bi5eIGODZL4czN4GAwk+mHuA4vx8UHcyJPCw90HdD7L3PF4/1v8HgwZ09ggGABhEKzA=:8D9A" & _
                "^FO256,96^GFA,00512,00512,00016,:Z64:" & _
                "eJy9jjEKAjEQRbPkAF7Ag1iIZ4mVbdJt53izCR7AK/zgAUwZQRin2M2kECwEfxMenz8vzv09Xi5C2EvrnAUhnl+dizQ0WXmiwrFgorVXnu/sO7sjx5M+wfr2IE9Y9nq/ip6B+SFke/W5xL7/j8qNnrCeUmaM/nQF6uBPuYZoe1E/5tHPEdvRzzscev8tG1nSPvNPeQOuPWlh:18D1" & _
                "^FO256,160^GFA,01280,01280,00020,:Z64:" & _
                "eJztkD0KwkAQRr9lwVjIeIGI15hC9FC2YjZssd2ewINYJgim8wyRXGDFJkV0TYhJ9gzi1wzzeDA/wG9n2xcKkPB9TbKJSd81c/hyYlHeMRYPF3hQHUMWepA6dYlwOKwaGuZJbeojaryXN5o8EzOSvFhH8eTZBWNXaTv7slnLiowRPQ2FnqkZqLyVHMxtWGR7f5LngWmtth1TNLL8UljaCPcoYuGGey/GEsPfr4Ry+Ev6Ms263c+PXvu/SpUEUjx6//zzM/kA0WdKow==:06BB" & _
                "^FO64,0^GFA,00768,00768,00012,:Z64:" & _
                "eJxjYBgFECDDUP/hgwWEzcFQ/wPGBotXQNg8DAkMP+DiBQx/4OoTgGwDuPi/mgKo+voP7ywK4OY8R5j/4TGSOc9/IMx//AMh/hDKlgCKP4Cy5f/U/3jwB2ImP4hdUYAQh7Jxgfr/IPAHgz1yAQB6tTwO:13D0" & _
                "^FO0,160^GFA,00384,00384,00012,:Z64:" & _
                "eJytzz0OwjAMBeAXpSpb0zEDEhyhoyfO1BvAARBnChLiHD6CR6aaYJcMDCzwpk9W4h/gXzlAGXf3saiEmzEoK4eLu0hBOJvjSRjR6xFzwU6z14mRFnp5A6p/t7k5Gqun6tGc7L2udeuz9n8wevK51zq3n9o+MhC1Pbs5v/eXYU/fTkxqWT79Q56oRT/4:1F5D" & _
                "^FO273,131^GB125,69,2^FS" & _
                "^FT16,46^A0N,39,38^FH\^FD" & CSIDNo & "^FS" & _
                "^FT12,88^A0N,28,28^FH\^FD" & Fuel & "^FS" & _
                "^FT76,122^A0N,28,28^FH\^FD" & TubeUpg & "^FS" & _
                "^FT134,41^A0N,28,28^FH\^FD" & Length & "^FS" & _
                "^FT277,82^A0N,28,28^FH\^FD" & TenWide & "^FS" & _
                "^FT229,42^A0N,28,28^FH\^FD" & Center & "^FS" & _
                "^FT151,184^A0N,23,24^FH\^FD" & Dealer & "^FS" & _
                "^FT360,119^A0N,28,28^FH\^FD" & Bracket & "^FS" & _
                "^FT71,184^A0N,23,24^FH\^FD" & OENo & "^FS" & _
                "^FT12,152^A0N,20,21^FH\^FD" & Upsweep & "^FS" & _
                "^FT126,88^A0N,28,28^FH\^FD" & Strakes & "^FS" & _
                "^FT317,161^A0N,23,24^FH\^FD" & tubetoprint & "^FS" & _
                "^FT279,160^A0N,17,16^FH\^FD" & CenterScheduled & "^FS" & _
                "^PQ1,0,1,Y^XZ"
        End If
        'End If

        Try

            Dim client As New System.Net.Sockets.TcpClient
            client.Connect(ipAddress, port)

            'Write ZPL String to Connection
            Dim writer As New System.IO.StreamWriter(client.GetStream())

            writer.Write(ZPLString2x1)


            writer.Flush()

            writer.Close()
            client.Close()

        Catch ex As Exception

        End Try

    End Function

    Protected Sub gvCSTubes_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCSTubes.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblTube As Label = CType(e.Row.FindControl("lblTube"), Label)

            If e.Row.DataItem("Ctr") = 1 Then
                lblTube.Text = "CTR"
            End If

        End If
    End Sub

    Protected Sub gvReruns_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReruns.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFabOptions"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch
            End Try



        End If
    End Sub

    Protected Sub gvReruns_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvReruns.RowCommand
        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)
        End If

        If e.CommandName = "gotoupdateP" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvReruns.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim RerunID As Integer = gvReruns.Rows(Key).Cells(1).Text

            Dim img As Image = CType(gvReruns.Rows(Key).FindControl("btnUpdateRollerP"), Image)
            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 26, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.
            Dim stationID As String = GlobalVariables.stationID

            Dim NumOuterSections As Integer = gvReruns.Rows(Key).Cells(2).Text

            'start with all 0s for the seamer sections
            Dim PF As Integer = -1
            Dim PM As Integer = 0
            Dim PM2 As Integer = 0
            Dim PR As Integer = -1

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString


            Dim cmd7 As New SqlCommand
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If NumOuterSections = 3 Then
                PM = -1
            ElseIf NumOuterSections = 4 Then
                PM = -1
                PM2 = -1
            End If

            cmd7.Parameters.AddWithValue("@PF", PF)
            cmd7.Parameters.AddWithValue("@PM", PM)
            cmd7.Parameters.AddWithValue("@PM2", PM2)
            cmd7.Parameters.AddWithValue("@PR", PR)

            cmd8.Parameters.AddWithValue("@PF8", 0)
            cmd8.Parameters.AddWithValue("@PM8", 0)
            cmd8.Parameters.AddWithValue("@PM28", 0)
            cmd8.Parameters.AddWithValue("@PR8", 0)


            cmd7.CommandText = "UPDATE Tubes SET RollerPStatus = '2', SeamerSectPFStatus = @PF,  SeamerSectPMStatus = @PM, SeamerSectPM2Status = @PM2, SeamerSectPRStatus = @PR, RollerP = '" & TodaysDate & "', OuterRollerID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            'reversal
            cmd8.CommandText = "UPDATE Tubes SET RollerPStatus = '1', SeamerSectPFStatus = @PF8,  SeamerSectPMStatus = @PM8, SeamerSectPM2Status = @PM28, SeamerSectPRStatus = @PR8, RollerP = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            'clear damage flag
            cmd9.CommandText = "UPDATE Tubes_DamageReported Set ReRolledStatus = 1, ReRolled = '" & TodaysDate & "' where AutoID = '" & RerunID & "'" ' want to use autoid

            cmd7.Connection = conn
            cmd8.Connection = conn
            cmd9.Connection = conn

            conn.Open()

            If framevalue <= 1 Then
                cmd7.ExecuteNonQuery()
                PrintLabelsByTubeType(SelectedProdNo, NumOuterSections, "Port", "rerun")
                Try
                    PrintBuildInstrLabels(SelectedProdNo, "PORT", "rerun")
                Catch ex As Exception

                End Try
                cmd9.ExecuteNonQuery()
            Else
                cmd8.ExecuteNonQuery()
            End If

            gvRoller.DataBind()
            gvCSTubes.DataBind()
            gvReruns.DataBind()

            conn.Close()

        End If

        'This code is for the update button
        If e.CommandName = "gotoupdateS" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvReruns.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim RerunID As Integer = gvReruns.Rows(Key).Cells(1).Text

            Dim img As Image = CType(gvReruns.Rows(Key).FindControl("btnUpdateRollerS"), Image)
            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 26, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.
            Dim stationID As String = GlobalVariables.stationID

            'start with all 0s for the seamer sections
            Dim NumOuterSections As Integer = gvReruns.Rows(Key).Cells(2).Text

            Dim SF As Integer = -1
            Dim SM As Integer = 0
            Dim SM2 As Integer = 0
            Dim SR As Integer = -1

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString


            Dim cmd7 As New SqlCommand
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            conn.ConnectionString = connstr

            If NumOuterSections = 3 Then
                SM = -1
            ElseIf NumOuterSections = 4 Then
                SM = -1
                SM2 = -1
            End If

            cmd7.Parameters.AddWithValue("@SF", SF)
            cmd7.Parameters.AddWithValue("@SM", SM)
            cmd7.Parameters.AddWithValue("@SM2", SM2)
            cmd7.Parameters.AddWithValue("@SR", SR)

            cmd8.Parameters.AddWithValue("@SF8", 0)
            cmd8.Parameters.AddWithValue("@SM8", 0)
            cmd8.Parameters.AddWithValue("@SM28", 0)
            cmd8.Parameters.AddWithValue("@SR8", 0)


            cmd7.CommandText = "UPDATE Tubes SET RollerSStatus = '2', SeamerSectSFStatus = @SF,  SeamerSectSMStatus = @SM, SeamerSectSM2Status = @SM2, SeamerSectSRStatus = @SR, RollerS = '" & TodaysDate & "', OuterRollerID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            'reversal
            cmd8.CommandText = "UPDATE Tubes SET RollerSStatus = '1', SeamerSectSFStatus = @SF8,  SeamerSectSMStatus = @SM8, SeamerSectSM2Status = @SM28, SeamerSectSRStatus = @SR8, RollerS = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"

            'mark as rerun completed
            cmd9.CommandText = "UPDATE Tubes_DamageReported Set ReRolledStatus = 1, ReRolled = '" & TodaysDate & "' where AutoID = '" & RerunID & "'"

            cmd7.Connection = conn
            cmd8.Connection = conn
            cmd9.Connection = conn

            conn.Open()

            If framevalue <= 1 Then
                cmd7.ExecuteNonQuery()
                PrintLabelsByTubeType(SelectedProdNo, NumOuterSections, "Strb", "rerun")
                Try
                    PrintBuildInstrLabels(SelectedProdNo, "STRB", "rerun")
                Catch ex As Exception

                End Try
                cmd9.ExecuteNonQuery()
            Else
                cmd8.ExecuteNonQuery()
            End If

            gvRoller.DataBind()
            gvCSTubes.DataBind()
            gvReruns.DataBind()
            conn.Close()

        End If

        'This code is for the update button
        If e.CommandName = "gotoupdateCtr" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvReruns.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim RerunID As Integer = gvReruns.Rows(Key).Cells(1).Text

            Dim img As Image = CType(gvReruns.Rows(Key).FindControl("btnUpdateRollerCtr"), Image)
            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 26, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.

            Dim stationID As String = GlobalVariables.stationID

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd7 As New SqlCommand
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            Dim NumCenterSections As Integer = gvReruns.Rows(Key).Cells(3).Text

            Dim CF As Integer = -1
            Dim CM As Integer = 0
            Dim CM2 As Integer = 0
            Dim CR As Integer = -1

            If NumCenterSections = 3 Then
                CM = -1
            ElseIf NumCenterSections = 4 Then
                CM = -1
                CM2 = -1
            End If

            cmd7.Parameters.AddWithValue("@CF", CF)
            cmd7.Parameters.AddWithValue("@CM", CM)
            cmd7.Parameters.AddWithValue("@CM2", CM2)
            cmd7.Parameters.AddWithValue("@CR", CR)

            cmd8.Parameters.AddWithValue("@CF8", 0)
            cmd8.Parameters.AddWithValue("@CM8", 0)
            cmd8.Parameters.AddWithValue("@CM28", 0)
            cmd8.Parameters.AddWithValue("@CR8", 0)


            cmd7.CommandText = "UPDATE Tubes SET RollerCStatus = '2', SeamerSectCFStatus = @CF,  SeamerSectCMStatus = @CM, SeamerSectCM2Status = @CM2, SeamerSectCRStatus = @CR, RollerC = '" & TodaysDate & "', CenterRollerID = '" & stationID & "'  where ProdNo =  '" & SelectedProdNo & "'"
            'reversal
            cmd8.CommandText = "UPDATE Tubes SET RollerCStatus = '1', SeamerSectCFStatus = @CF8,  SeamerSectCMStatus = @CM8, SeamerSectCM2Status = @CM28, SeamerSectCRStatus = @CR8, RollerC = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd9.CommandText = "UPDATE Tubes_DamageReported Set ReRolledStatus = 1, ReRolled = '" & TodaysDate & "' where AutoID = '" & RerunID & "'" ' want to use autoid

            cmd7.Connection = conn
            cmd8.Connection = conn
            cmd9.Connection = conn

            conn.Open()

            If framevalue <= 1 Then
                cmd7.ExecuteNonQuery()
                PrintLabelsByTubeType(SelectedProdNo, NumCenterSections, "Ctr", "rerun")
                Try
                    PrintBuildInstrLabels(SelectedProdNo, "CTR", "rerun")
                Catch
                End Try

                cmd9.ExecuteNonQuery()
            Else
                cmd8.ExecuteNonQuery()
            End If

            gvRoller.DataBind()
            gvCSTubes.DataBind()
            gvReruns.DataBind()
            conn.Close()

        End If

    End Sub

    Protected Sub gvCSTubes_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvCSTubes.RowCommand
        
        If e.CommandName = "gotoupdateCSCtr" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedTubeID As Integer = gvCSTubes.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvCSTubes.Rows(Key).FindControl("btnUpdateCSCRoller"), Image)
            Dim framevalue = img.ImageUrl
            framevalue = Mid(framevalue, 26, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 32.
            Dim stationID As String = GlobalVariables.stationID


            Dim NumCenterSections As Integer = gvCSTubes.Rows(Key).Cells(5).Text

            'start with all 0s for the center sections
            Dim CF As Integer = -1
            Dim CM As Integer = 0
            Dim CM2 As Integer = 0
            Dim CR As Integer = -1

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

            conn.ConnectionString = connstr

            If NumCenterSections = 3 Then
                CM = -1
            ElseIf NumCenterSections = 4 Then
                CM = -1
                CM2 = -1
            End If

            cmd7.Parameters.AddWithValue("@CF", CF)
            cmd7.Parameters.AddWithValue("@CM", CM)
            cmd7.Parameters.AddWithValue("@CM2", CM2)
            cmd7.Parameters.AddWithValue("@CR", CR)

            cmd8.Parameters.AddWithValue("@CF8", 0)
            cmd8.Parameters.AddWithValue("@CM8", 0)
            cmd8.Parameters.AddWithValue("@CM28", 0)
            cmd8.Parameters.AddWithValue("@CR8", 0)


            cmd7.CommandText = "UPDATE CS_Tubes SET RollerCStatus = '2', SeamerSectCFStatus = @CF,  SeamerSectCMStatus = @CM, SeamerSectCM2Status = @CM2, SeamerSectCRStatus = @CR, FinalCStatus = 1, RollerC = '" & TodaysDate & "', CenterRollerID = '" & stationID & "' where TubeID =  '" & SelectedTubeID & "'"
            'reversal
            cmd8.CommandText = "UPDATE CS_Tubes SET RollerCStatus = '1', SeamerSectCFStatus = @CF8,  SeamerSectCMStatus = @CM8, SeamerSectCM2Status = @CM28, SeamerSectCRStatus = @CR8, RollerS = '" & TodaysDate & "' where TubeID =  '" & SelectedTubeID & "'"

            cmd7.Connection = conn
            cmd8.Connection = conn

            conn.Open()

            If framevalue <= 1 Then
                cmd7.ExecuteNonQuery()
                PrintLabelsByTubeType(SelectedTubeID, NumCenterSections, "Ctr", "custserv")
                Try
                    PrintBuildInstrLabelsCustService(SelectedTubeID)
                Catch ex As Exception

                End Try
            Else
                cmd8.ExecuteNonQuery()
            End If

            gvRoller.DataBind()
            gvCSTubes.DataBind()
            gvReruns.DataBind()

            conn.Close()
        End If
    End Sub

    Protected Function PopulateDataTablesOuters(prod As String, tubetype As String) As String
        Dim sqldataadapter As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()

        If tubetype = "prod" Or tubetype = "rerun" Then
            sqldataadapter.SelectCommand = New SqlCommand("Select ShortProdNo, Style, Diameter, Front, TubeModel, OutertubeDetails.Ladder, Bracket, Keel, Fuel, Splash, Strakes, StrakesComments, StrbTrans, Comments, OuterScheduled, OuterScheduleOrder, ItemNo FROM OutertubeDetails Left Join Tubes on OutertubeDetails.ProdNo = Tubes.ProdNo Left join BML_POPREPORTING_GREENLIGHTS on OutertubeDetails.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where OutertubeDetails.ProdNo = '" & prod & "'", conn)
        End If

        sqldataadapter.Fill(buildinst) 'outer tube details

        conn.Close()
        conn.Dispose()
        Return False

    End Function

    Protected Function PopulateDataTablesCenters(prod As String, tubetype As String) As String
        Dim sqldataadapter As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()

        If tubetype = "prod" Or tubetype = "rerun" Then
            sqldataadapter.SelectCommand = New SqlCommand("Select CenterTubeDetails.ShortProdNo, Length,Center, Storage, TenWide, CenterTubeDetails.Bracket, CenterTubeDetails.Fuel, CenterTubeDetails.Strakes, TubeUpg, Upsweep_SldTrans, CenterScheduled, CenterScheduleOrder, TubeModel FROM CentertubeDetails Left Join Tubes on CenterTubeDetails.ProdNo = Tubes.ProdNo Left join OutertubeDetails on CenterTubeDetails.ProdNo = OutertubeDetails.ProdNo where CenterTubeDetails.ProdNo = '" & prod & "'", conn)
        End If


        sqldataadapter.Fill(buildinstctr) 'outer tube details

        conn.Close()
        conn.Dispose()
        Return False

    End Function

    Protected Function PopulateDataTablesCS(prod As String) As String 'tubetype is custserv
        Dim sqldataadapter As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()
        'sqldataadapter.SelectCommand = New SqlCommand("Select TubeID, OENo, Dealer, Customer, Model, ModelYear, Style, Diameter, Front, Port, Strb, Ctr, Ladder, Bracket, Keel, Fuel, Splash, Strakes, StrakesComments, StrbTrans, Comments, OuterScheduledFlag, CenterScheduledFlag, OuterScheduled, CenterScheduled FROM CS_Tubes where TubeID = '" & prod & "'", conn)
        sqldataadapter.SelectCommand = New SqlCommand("Select * FROM CS_Tubes where TubeID = '" & prod & "'", conn)

        sqldataadapter.Fill(buildinstcs) 'outer tube details

        conn.Close()
        conn.Dispose()
        Return False
    End Function
End Class
