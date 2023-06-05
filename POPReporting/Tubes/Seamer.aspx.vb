Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Tubes_Seamer
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        gvRoundSeamer.DataBind()
    End Sub

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class


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

        cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectCFStatus = 2 and Convert(date,SeamerSectCF) ='" & ThisDay & "') or (SeamerSectCMStatus = 2 and Convert(date,SeamerSectCM) ='" & ThisDay & "') or (SeamerSectCM2Status = 2 and Convert(date,SeamerSectCM2) ='" & ThisDay & "') or (SeamerSectCRStatus = 2 and Convert(date,SeamerSectCR) ='" & ThisDay & "')"
        cmd3.CommandText = "Select Count (*) FROM Tubes where (SeamerSectPFStatus = 2 and Convert(date,SeamerSectPF) ='" & ThisDay & "') or (SeamerSectPMStatus = 2 and Convert(date,SeamerSectPM) ='" & ThisDay & "') or (SeamerSectPM2Status = 2 and Convert(date,SeamerSectPM2) ='" & ThisDay & "') or (SeamerSectPRStatus = 2 and Convert(date,SeamerSectPR) ='" & ThisDay & "')"
        cmd4.CommandText = "Select Count (*) FROM Tubes where (SeamerSectSFStatus = 2 and Convert(date,SeamerSectSF) ='" & ThisDay & "') or (SeamerSectSMStatus = 2 and Convert(date,SeamerSectSM) ='" & ThisDay & "') or (SeamerSectSM2Status = 2 and Convert(date,SeamerSectSM2) ='" & ThisDay & "') or (SeamerSectSRStatus = 2 and Convert(date,SeamerSectSR) ='" & ThisDay & "')"
        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        conn.Open()



        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)

        lblCtr.Text = " C:" & Convert.ToInt16(cmd2.ExecuteScalar())
        lblPort.Text = " P: " & Convert.ToInt16(cmd3.ExecuteScalar())
        lblStrb.Text = " S: " & Convert.ToInt16(cmd4.ExecuteScalar())

        'conn.Close()
    End Sub

    Protected Sub gvRoundSeamer_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvRoundSeamer.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRoundSeamer.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "RoundSeamer" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
            Dim url2 As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url2 + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)
            'This next line works, unless it is in an update panel. Then it doesn't. Response.Write doesn't work inside those. Use ScriptManager instead.
            'Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url2 & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRoundSeamer.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "RoundSeamer" 'to pass in the workstation that makes the note.
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

        If e.CommandName = "gotoupdatePF" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerPF"), Image)
            Dim imgvalue = img.ImageUrl
            imgvalue = Mid(imgvalue, 29, 1) 'Get 1 character after 29.
            If imgvalue = "-" Then
                imgvalue = -1
            End If

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim PF As Integer = 0
            Dim BafflesPF As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                PF = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                PF = 2
                BafflesPF = -1

            End If

            cmd.Parameters.AddWithValue("@PF", PF)
            cmd.Parameters.AddWithValue("@BafflesPF", BafflesPF)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectPFStatus = @PF, BafflesSectPFStatus = @BafflesPF, SeamerSectPF = '" & TodaysDate & "', SeamerPFID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectPFStatus = 2 and Convert(date,SeamerSectPF) ='" & ThisDay & "') or (SeamerSectPMStatus = 2 and Convert(date,SeamerSectPM) ='" & ThisDay & "') or (SeamerSectPM2Status = 2 and Convert(date,SeamerSectPM2) ='" & ThisDay & "') or (SeamerSectPRStatus = 2 and Convert(date,SeamerSectPR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectPFStatus >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectPFStatus = @PF4, BafflesSectPFStatus = @BafflesPF4, SeamerSectPF = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in progress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        PF = -1
                        BafflesPF = 0
                        cmd4.Parameters.AddWithValue("@PF4", PF)
                        cmd4.Parameters.AddWithValue("@BafflesPF4", BafflesPF)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If
                End If
            End If

            lblPort.Text = " P:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If

        If e.CommandName = "gotoupdatePM" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerPM"), Image)
            Dim imgvalue = img.ImageUrl
            imgvalue = Mid(imgvalue, 27, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 29.
            If imgvalue = "-" Then
                imgvalue = -1
            End If

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim PM As Integer = 0
            Dim BafflesPM As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                PM = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                PM = 2
                BafflesPM = -1

            End If

            cmd.Parameters.AddWithValue("@PM", PM)
            cmd.Parameters.AddWithValue("@BafflesPM", BafflesPM)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectPMStatus = @PM, BafflesSectPMStatus = @BafflesPM, SeamerSectPM = '" & TodaysDate & "', SeamerPMID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectPFStatus = 2 and Convert(date,SeamerSectPF) ='" & ThisDay & "') or (SeamerSectPMStatus = 2 and Convert(date,SeamerSectPM) ='" & ThisDay & "') or (SeamerSectPM2Status = 2 and Convert(date,SeamerSectPM2) ='" & ThisDay & "') or (SeamerSectPRStatus = 2 and Convert(date,SeamerSectPR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectPMStatus >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectPMStatus = @PM4, BafflesSectPMStatus = @BafflesPM4, SeamerSectPM = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in progress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        PM = -1
                        BafflesPM = 0
                        cmd4.Parameters.AddWithValue("@PM4", PM)
                        cmd4.Parameters.AddWithValue("@BafflesPM4", BafflesPM)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If
                End If
            End If

            lblPort.Text = " P:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If


        If e.CommandName = "gotoupdatePM2" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerPM2"), Image)
            Dim imgvalue = img.ImageUrl

            imgvalue = Mid(imgvalue, 27, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 29.

            If imgvalue = "-" Then
                imgvalue = -1
            End If
            System.Console.WriteLine(imgvalue.ToString)

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim PM2 As Integer = 0
            Dim BafflesPM2 As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                PM2 = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                PM2 = 2
                BafflesPM2 = -1
            End If

            cmd.Parameters.AddWithValue("@PM2", PM2)
            cmd.Parameters.AddWithValue("@BafflesPM2", BafflesPM2)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectPM2Status = @PM2, BafflesSectPM2Status = @BafflesPM2, SeamerSectPM2 = '" & TodaysDate & "', SeamerPM2ID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectPFStatus = 2 and Convert(date,SeamerSectPF) ='" & ThisDay & "') or (SeamerSectPMStatus = 2 and Convert(date,SeamerSectPM) ='" & ThisDay & "') or (SeamerSectPM2Status = 2 and Convert(date,SeamerSectPM2) ='" & ThisDay & "') or (SeamerSectPRStatus = 2 and Convert(date,SeamerSectPR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectPM2Status >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectPM2Status = @PM24, BafflesSectPM2Status = @BafflesPM24, SeamerSectPM2 = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in progress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        PM2 = -1
                        BafflesPM2 = 0
                        cmd4.Parameters.AddWithValue("@PM24", PM2)
                        cmd4.Parameters.AddWithValue("@BafflesPM24", BafflesPM2)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If

                End If
            End If


            lblPort.Text = " P:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If


        If e.CommandName = "gotoupdatePR" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerPR"), Image)
            Dim imgvalue = img.ImageUrl

            imgvalue = Mid(imgvalue, 28, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 29.

            If imgvalue = "-" Then
                imgvalue = -1
            End If
            System.Console.WriteLine(imgvalue.ToString)

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim PR As Integer = 0
            Dim BafflesPR As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                PR = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                PR = 2
                BafflesPR = -1
            End If

            cmd.Parameters.AddWithValue("@PR", PR)
            cmd.Parameters.AddWithValue("@BafflesPR", BafflesPR)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectPRStatus = @PR, BafflesSectPRStatus = @BafflesPR, SeamerSectPR = '" & TodaysDate & "', SeamerPRID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectPFStatus = 2 and Convert(date,SeamerSectPF) ='" & ThisDay & "') or (SeamerSectPMStatus = 2 and Convert(date,SeamerSectPM) ='" & ThisDay & "') or (SeamerSectPM2Status = 2 and Convert(date,SeamerSectPM2) ='" & ThisDay & "') or (SeamerSectPRStatus = 2 and Convert(date,SeamerSectPR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectPRStatus >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectPRStatus = @PR4, BafflesSectPRStatus = @BafflesPR4, SeamerSectPR = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in progress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        PR = -1
                        BafflesPR = 0
                        cmd4.Parameters.AddWithValue("@PR4", PR)
                        cmd4.Parameters.AddWithValue("@BafflesPR4", BafflesPR)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If

                End If
            End If


            lblPort.Text = " P:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If

        If e.CommandName = "gotoupdateSF" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerSF"), Image)
            Dim imgvalue = img.ImageUrl
            imgvalue = Mid(imgvalue, 29, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 29.
            If imgvalue = "-" Then
                imgvalue = -1
            End If

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim SF As Integer = 0
            Dim BafflesSF As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                SF = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                SF = 2
                BafflesSF = -1

            End If

            cmd.Parameters.AddWithValue("@SF", SF)
            cmd.Parameters.AddWithValue("@BafflesSF", BafflesSF)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectSFStatus = @SF, BafflesSectSFStatus = @BafflesSF, SeamerSectSF = '" & TodaysDate & "', SeamerSFID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectSFStatus = 2 and Convert(date,SeamerSectSF) ='" & ThisDay & "') or (SeamerSectSMStatus = 2 and Convert(date,SeamerSectSM) ='" & ThisDay & "') or (SeamerSectSM2Status = 2 and Convert(date,SeamerSectSM2) ='" & ThisDay & "') or (SeamerSectSRStatus = 2 and Convert(date,SeamerSectSR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectSFStatus >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectSFStatus = @SF4, BafflesSectSFStatus = @BafflesSF4, SeamerSectSF = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in progress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        SF = -1
                        BafflesSF = 0
                        cmd4.Parameters.AddWithValue("@SF4", SF)
                        cmd4.Parameters.AddWithValue("@BafflesSF4", BafflesSF)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If
                End If
            End If

            lblStrb.Text = " S:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If


        If e.CommandName = "gotoupdateSM" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerSM"), Image)
            Dim imgvalue = img.ImageUrl
            imgvalue = Mid(imgvalue, 27, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 29.
            If imgvalue = "-" Then
                imgvalue = -1
            End If

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim SM As Integer = 0
            Dim BafflesSM As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                SM = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                SM = 2
                BafflesSM = -1

            End If

            cmd.Parameters.AddWithValue("@SM", SM)
            cmd.Parameters.AddWithValue("@BafflesSM", BafflesSM)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectSMStatus = @SM, BafflesSectSMStatus = @BafflesSM, SeamerSectSM = '" & TodaysDate & "', SeamerSMID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectSFStatus = 2 and Convert(date,SeamerSectSF) ='" & ThisDay & "') or (SeamerSectSMStatus = 2 and Convert(date,SeamerSectSM) ='" & ThisDay & "') or (SeamerSectSM2Status = 2 and Convert(date,SeamerSectSM2) ='" & ThisDay & "') or (SeamerSectSRStatus = 2 and Convert(date,SeamerSectSR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectSMStatus >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectSMStatus = @SM4, BafflesSectSMStatus = @BafflesSM4, SeamerSectSM = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in progress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        SM = -1
                        BafflesSM = 0
                        cmd4.Parameters.AddWithValue("@SM4", SM)
                        cmd4.Parameters.AddWithValue("@BafflesSM4", BafflesSM)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If
                End If
            End If

            lblStrb.Text = " S:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If


        If e.CommandName = "gotoupdateSM2" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerSM2"), Image)
            Dim imgvalue = img.ImageUrl

            imgvalue = Mid(imgvalue, 27, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 29.

            If imgvalue = "-" Then
                imgvalue = -1
            End If
            System.Console.WriteLine(imgvalue.ToString)

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim SM2 As Integer = 0
            Dim BafflesSM2 As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                SM2 = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                SM2 = 2
                BafflesSM2 = -1
            End If

            cmd.Parameters.AddWithValue("@SM2", SM2)
            cmd.Parameters.AddWithValue("@BafflesSM2", BafflesSM2)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectSM2Status = @SM2, BafflesSectSM2Status = @BafflesSM2, SeamerSectSM2 = '" & TodaysDate & "', SeamerSM2ID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectSFStatus = 2 and Convert(date,SeamerSectSF) ='" & ThisDay & "') or (SeamerSectSMStatus = 2 and Convert(date,SeamerSectSM) ='" & ThisDay & "') or (SeamerSectSM2Status = 2 and Convert(date,SeamerSectSM2) ='" & ThisDay & "') or (SeamerSectSRStatus = 2 and Convert(date,SeamerSectSR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectSM2Status >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectSM2Status = @SM24, BafflesSectSM2Status = @BafflesSM24, SeamerSectSM2 = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in progress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        SM2 = -1
                        BafflesSM2 = 0
                        cmd4.Parameters.AddWithValue("@SM24", SM2)
                        cmd4.Parameters.AddWithValue("@BafflesSM24", BafflesSM2)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If

                End If
            End If


            lblStrb.Text = " S:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If

        If e.CommandName = "gotoupdateSR" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerSR"), Image)
            Dim imgvalue = img.ImageUrl

            imgvalue = Mid(imgvalue, 28, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 29.

            If imgvalue = "-" Then
                imgvalue = -1
            End If
            System.Console.WriteLine(imgvalue.ToString)

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim SR As Integer = 0
            Dim BafflesSR As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                SR = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                SR = 2
                BafflesSR = -1
            End If

            cmd.Parameters.AddWithValue("@SR", SR)
            cmd.Parameters.AddWithValue("@BafflesSR", BafflesSR)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectSRStatus = @SR, BafflesSectSRStatus = @BafflesSR, SeamerSectSR = '" & TodaysDate & "', SeamerSRID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectSFStatus = 2 and Convert(date,SeamerSectSF) ='" & ThisDay & "') or (SeamerSectSMStatus = 2 and Convert(date,SeamerSectSM) ='" & ThisDay & "') or (SeamerSectSM2Status = 2 and Convert(date,SeamerSectSM2) ='" & ThisDay & "') or (SeamerSectSRStatus = 2 and Convert(date,SeamerSectSR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectSRStatus >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectSRStatus = @SR4, BafflesSectSRStatus = @BafflesSR4, SeamerSectSR = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in SRogress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        SR = -1
                        BafflesSR = 0
                        cmd4.Parameters.AddWithValue("@SR4", SR)
                        cmd4.Parameters.AddWithValue("@BafflesSR4", BafflesSR)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If

                End If
            End If


            lblStrb.Text = " S:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If


        'This code is for the update button for Center Front
        If e.CommandName = "gotoupdateCF" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerCF"), Image)
            Dim imgvalue = img.ImageUrl
            imgvalue = Mid(imgvalue, 29, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 29.
            If imgvalue = "-" Then
                imgvalue = -1
            End If

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim CF As Integer = 0
            Dim BafflesCF As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                CF = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                CF = 2
                BafflesCF = -1

            End If

            cmd.Parameters.AddWithValue("@CF", CF)
            cmd.Parameters.AddWithValue("@BafflesCF", BafflesCF)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectCFStatus = @CF, BafflesSectCFStatus = @BafflesCF, SeamerSectCF = '" & TodaysDate & "', SeamerCFID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectCFStatus = 2 and Convert(date,SeamerSectCF) ='" & ThisDay & "') or (SeamerSectCMStatus = 2 and Convert(date,SeamerSectCM) ='" & ThisDay & "') or (SeamerSectCM2Status = 2 and Convert(date,SeamerSectCM2) ='" & ThisDay & "') or (SeamerSectCRStatus = 2 and Convert(date,SeamerSectCR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectCFStatus >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectCFStatus = @CF4, BafflesSectCFStatus = @BafflesCF4, SeamerSectCF = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in progress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        CF = -1
                        BafflesCF = 0
                        cmd4.Parameters.AddWithValue("@CF4", CF)
                        cmd4.Parameters.AddWithValue("@BafflesCF4", BafflesCF)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If
                End If
            End If

            lblCtr.Text = " C:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If

        'This code is for the update button for Center Mid
        If e.CommandName = "gotoupdateCM" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerCM"), Image)
            Dim imgvalue = img.ImageUrl

            imgvalue = Mid(imgvalue, 27, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 29.

            If imgvalue = "-" Then
                imgvalue = -1
            End If
            System.Console.WriteLine(imgvalue.ToString)

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim CM As Integer = 0
            Dim BafflesCM As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                CM = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                CM = 2
                BafflesCM = -1
            End If

            cmd.Parameters.AddWithValue("@CM", CM)
            cmd.Parameters.AddWithValue("@BafflesCM", BafflesCM)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectCMStatus = @CM, BafflesSectCMStatus = @BafflesCM, SeamerSectCM = '" & TodaysDate & "', SeamerCMID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectCFStatus = 2 and Convert(date,SeamerSectCF) ='" & ThisDay & "') or (SeamerSectCMStatus = 2 and Convert(date,SeamerSectCM) ='" & ThisDay & "') or (SeamerSectCM2Status = 2 and Convert(date,SeamerSectCM2) ='" & ThisDay & "') or (SeamerSectCRStatus = 2 and Convert(date,SeamerSectCR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectCMStatus >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectCMStatus = @CM4, BafflesSectCMStatus = @BafflesCM4, SeamerSectCM = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in progress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        CM = -1
                        BafflesCM = 0
                        cmd4.Parameters.AddWithValue("@CM4", CM)
                        cmd4.Parameters.AddWithValue("@BafflesCM4", BafflesCM)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If

                End If
            End If


            lblCtr.Text = " C:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If

        'This code is for the update button for Center Mid 2
        If e.CommandName = "gotoupdateCM2" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerCM2"), Image)
            Dim imgvalue = img.ImageUrl

            imgvalue = Mid(imgvalue, 27, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 29.

            If imgvalue = "-" Then
                imgvalue = -1
            End If
            System.Console.WriteLine(imgvalue.ToString)

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim CM2 As Integer = 0
            Dim BafflesCM2 As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                CM2 = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                CM2 = 2
                BafflesCM2 = -1
            End If

            cmd.Parameters.AddWithValue("@CM2", CM2)
            cmd.Parameters.AddWithValue("@BafflesCM2", BafflesCM2)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectCM2Status = @CM2, BafflesSectCM2Status = @BafflesCM2, SeamerSectCM2 = '" & TodaysDate & "', SeamerCM2ID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectCFStatus = 2 and Convert(date,SeamerSectCF) ='" & ThisDay & "') or (SeamerSectCMStatus = 2 and Convert(date,SeamerSectCM) ='" & ThisDay & "') or (SeamerSectCM2Status = 2 and Convert(date,SeamerSectCM2) ='" & ThisDay & "') or (SeamerSectCRStatus = 2 and Convert(date,SeamerSectCR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectCM2Status >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectCM2Status = @CM24, BafflesSectCM2Status = @BafflesCM24, SeamerSectCM2 = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in progress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        CM2 = -1
                        BafflesCM2 = 0
                        cmd4.Parameters.AddWithValue("@CM24", CM2)
                        cmd4.Parameters.AddWithValue("@BafflesCM24", BafflesCM2)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If

                End If
            End If


            lblCtr.Text = " C:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If

        'This code is for the update button for Center Rear
        If e.CommandName = "gotoupdateCR" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvRoundSeamer.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvRoundSeamer.Rows(Key).FindControl("btnUpdateSeamerCR"), Image)
            Dim imgvalue = img.ImageUrl

            imgvalue = Mid(imgvalue, 28, 1) 'get the value of FramesInstalledStatus from the imageurl. Get 1 character after 29.

            If imgvalue = "-" Then
                imgvalue = -1
            End If
            System.Console.WriteLine(imgvalue.ToString)

            Dim NextWorkstationHasDate As Int16
            Dim stationID As String = GlobalVariables.stationID

            Dim CR As Integer = 0
            Dim BafflesCR As Integer = 0

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            If imgvalue = -1 Then 'white to yellow
                CR = 1
            ElseIf imgvalue = 1 Then ' yellow to green
                CR = 2
                BafflesCR = -1
            End If

            cmd.Parameters.AddWithValue("@CR", CR)
            cmd.Parameters.AddWithValue("@BafflesCR", BafflesCR)

            cmd.CommandText = "UPDATE Tubes SET SeamerSectCRStatus = @CR, BafflesSectCRStatus = @BafflesCR, SeamerSectCR = '" & TodaysDate & "', SeamerCRID = '" & stationID & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM Tubes where (SeamerSectCFStatus = 2 and Convert(date,SeamerSectCF) ='" & ThisDay & "') or (SeamerSectCMStatus = 2 and Convert(date,SeamerSectCM) ='" & ThisDay & "') or (SeamerSectCM2Status = 2 and Convert(date,SeamerSectCM2) ='" & ThisDay & "') or (SeamerSectCRStatus = 2 and Convert(date,SeamerSectCR) ='" & ThisDay & "')"

            'Determine if the next workstation already has a done date set.
            cmd3.CommandText = "Select Count (*) FROM Tubes where BafflesSectCRStatus >= 1 and ProdNo = '" & SelectedProdNo & "'"

            'reverse done
            cmd4.CommandText = "UPDATE Tubes SET SeamerSectCRStatus = @CR4, BafflesSectCRStatus = @BafflesCR4, SeamerSectCR = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()

            If imgvalue < 2 Then
                cmd.ExecuteNonQuery()
            Else

                NextWorkstationHasDate = Convert.ToInt16(cmd3.ExecuteScalar())
                If NextWorkstationHasDate = 1 Then
                    MesgBox("You cannot undo this action because the next station is in progress or has already completed their part of this boat. If you need help, please contact a supervisor")
                Else
                    If imgvalue = 2 Then ' green to white
                        CR = -1
                        BafflesCR = 0
                        cmd4.Parameters.AddWithValue("@CR4", CR)
                        cmd4.Parameters.AddWithValue("@BafflesCR4", BafflesCR)
                        cmd4.ExecuteNonQuery() 'Allow reversal if next workstation hasn't started.
                    End If

                End If
            End If


            lblCtr.Text = " C:" & Convert.ToInt16(cmd2.ExecuteScalar())

            gvRoundSeamer.DataBind()
            conn.Close()

        End If

    End Sub



    Public Function CheckMidVisible(ByVal sections As Object) As String
        Try

            If sections = 3 Then
                Return "display:normal;"
            Else
                Return "display:none;"
            End If

        Catch
            Return "display:normal;"
        End Try
    End Function

    Public Function CheckMid2Visible(ByVal sections As Object) As String
        Try

            If sections = 4 Then
                Return "display:normal;"
            Else
                Return "display:none;"
            End If

        Catch
            Return "display:normal;"
        End Try
    End Function

    Public Function CheckCtrVisible(ByVal sections As Object) As String
        Try

            If sections = 0 Then
                Return "display:none;"
            Else
                Return "display:normal;"
            End If

        Catch
            Return "display:normal;"
        End Try
    End Function


    Protected Function SplitBValSlash(val As Object) As String
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("\")(1)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function


    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvRoundSeamer.DataBind()
    End Sub

End Class

