Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration


Partial Class Barcode_Tubes_Baffles
    Inherits System.Web.UI.Page

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

    Protected Sub btnInProgress_Click(sender As Object, e As EventArgs) Handles btnInProgress.Click
        Dim fullprodno As String = tbProd.Text
        Dim TodaysDate As Date = Date.Now
        Dim stationID As String = GlobalVariables.stationID

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn

        Dim prod As String = fullprodno.Split("-")(0)
        Dim section As String = fullprodno.Split("-")(1)

        If section = "PF" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectPFStatus = 1, BafflesSectPF = @TodaysDate, BafflesPFID = @station where ProdNo =  @prodno"
        ElseIf section = "PM" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectPMStatus = 1, BafflesSectPM = @TodaysDate, BafflesPMID = @station  where ProdNo =  @prodno"
        ElseIf section = "PM2" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectPM2Status = 1, BafflesSectPM2 = @TodaysDate, BafflesPM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "PR" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectPRStatus = 1, BafflesSectPR = @TodaysDate, BafflesPRID = @station  where ProdNo =  @prodno"
        ElseIf section = "SF" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectSFStatus = 1, BafflesSectSF = @TodaysDate, BafflesSFID = @station  where ProdNo =  @prodno"
        ElseIf section = "SM" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectSMStatus = 1, BafflesSectSM = @TodaysDate, BafflesSMID = @station  where ProdNo =  @prodno"
        ElseIf section = "SM2" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectSM2Status = 1, BafflesSectSM2 = @TodaysDate, BafflesSM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "SR" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectSRStatus = 1, BafflesSectSR = @TodaysDate, BafflesSRID = @station  where ProdNo =  @prodno"
        ElseIf section = "CF" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectCFStatus = 1, BafflesSectCF = @TodaysDate, BafflesCFID = @station  where ProdNo =  @prodno"
        ElseIf section = "CM" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectCMStatus = 1, BafflesSectCM = @TodaysDate, BafflesCMID = @station  where ProdNo =  @prodno"
        ElseIf section = "CM2" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectCM2Status = 1, BafflesSectCM2 = @TodaysDate, BafflesCM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "CR" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectCRStatus = 1, BafflesSectCR = @TodaysDate, BafflesCRID = @station  where ProdNo =  @prodno"
        End If


        conn.Open()

        cmd.Parameters.AddWithValue("@prodno", prod)
        cmd.Parameters.AddWithValue("@station", stationID)
        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.ExecuteNonQuery()


        tbProd.Text = ""
        tbProd.Focus()

        conn.Close()

    End Sub
    Protected Sub btnComplete_Click(sender As Object, e As EventArgs) Handles btnComplete.Click

        Dim fullprodno As String = tbProd.Text
        Dim TodaysDate As Date = Date.Now
        Dim stationID As String = GlobalVariables.stationID

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn

        Dim prod As String = fullprodno.Split("-")(0)
        Dim section As String = fullprodno.Split("-")(1)

        If section = "PF" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectPFStatus = 2, BafflesSectPF = @TodaysDate, BafflesPFID = @station where ProdNo =  @prodno"
        ElseIf section = "PM" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectPMStatus = 2, BafflesSectPM = @TodaysDate, BafflesPMID = @station  where ProdNo =  @prodno"
        ElseIf section = "PM2" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectPM2Status = 2, BafflesSectPM2 = @TodaysDate, BafflesPM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "PR" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectPRStatus = 2, BafflesSectPR = @TodaysDate, BafflesPRID = @station  where ProdNo =  @prodno"
        ElseIf section = "SF" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectSFStatus = 2, BafflesSectSF = @TodaysDate, BafflesSFID = @station  where ProdNo =  @prodno"
        ElseIf section = "SM" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectSMStatus = 2, BafflesSectSM = @TodaysDate, BafflesSMID = @station  where ProdNo =  @prodno"
        ElseIf section = "SM2" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectSM2Status = 2, BafflesSectSM2 = @TodaysDate, BafflesSM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "SR" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectSRStatus = 2, BafflesSectSR = @TodaysDate, BafflesSRID = @station  where ProdNo =  @prodno"
        ElseIf section = "CF" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectCFStatus = 2, BafflesSectCF = @TodaysDate, BafflesCFID = @station  where ProdNo =  @prodno"
        ElseIf section = "CM" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectCMStatus = 2, BafflesSectCM = @TodaysDate, BafflesCMID = @station  where ProdNo =  @prodno"
        ElseIf section = "CM2" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectCM2Status = 2, BafflesSectCM2 = @TodaysDate, BafflesCM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "CR" Then
            cmd.CommandText = "UPDATE Tubes SET BafflesSectCRStatus = 2, BafflesSectCR = @TodaysDate, BafflesCRID = @station  where ProdNo =  @prodno"
        End If


        conn.Open()

        cmd.Parameters.AddWithValue("@prodno", prod)
        cmd.Parameters.AddWithValue("@station", stationID)
        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.ExecuteNonQuery()


        tbProd.Text = ""
        tbProd.Focus()

        conn.Close()

    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbProd.Text = ""
        tbProd.Focus()
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbProd.Focus()
        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
        Label1.Text = GlobalVariables.stationID.ToUpper
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
    Protected Function MarkComplete() As String

        Dim fullprodno As String = tbProd.Text
        Dim TodaysDate As Date = Date.Now
        Dim stationID As String = GlobalVariables.stationID
        Dim tubetype As String = ""
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand

        Dim results As SqlDataReader

        Dim portRoundSeamerReady As Integer = 0
        Dim strbRoundSeamerReady As Integer = 0
        Dim ctrRoundSeamerReady As Integer = 0

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn

        Dim prod As String = fullprodno.Split("-")(0)
        Dim section As String = fullprodno.Split("-")(1)


        If fullprodno.Split("-").Count = 3 Then
            tubetype = fullprodno.Split("-")(2)
        End If

        If tubetype = "" Or tubetype = "RERUN" Then
            If section = "PF" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectPFStatus = 2, BafflesSectPF = @TodaysDate, BafflesPFID = @station where ProdNo =  @prodno"
            ElseIf section = "PM" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectPMStatus = 2, BafflesSectPM = @TodaysDate, BafflesPMID = @station  where ProdNo =  @prodno"
            ElseIf section = "PM2" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectPM2Status = 2, BafflesSectPM2 = @TodaysDate, BafflesPM2ID = @station  where ProdNo =  @prodno"
            ElseIf section = "PR" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectPRStatus = 2, BafflesSectPR = @TodaysDate, BafflesPRID = @station  where ProdNo =  @prodno"
            ElseIf section = "SF" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectSFStatus = 2, BafflesSectSF = @TodaysDate, BafflesSFID = @station  where ProdNo =  @prodno"
            ElseIf section = "SM" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectSMStatus = 2, BafflesSectSM = @TodaysDate, BafflesSMID = @station  where ProdNo =  @prodno"
            ElseIf section = "SM2" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectSM2Status = 2, BafflesSectSM2 = @TodaysDate, BafflesSM2ID = @station  where ProdNo =  @prodno"
            ElseIf section = "SR" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectSRStatus = 2, BafflesSectSR = @TodaysDate, BafflesSRID = @station  where ProdNo =  @prodno"
            ElseIf section = "CF" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectCFStatus = 2, BafflesSectCF = @TodaysDate, BafflesCFID = @station  where ProdNo =  @prodno"
            ElseIf section = "CM" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectCMStatus = 2, BafflesSectCM = @TodaysDate, BafflesCMID = @station  where ProdNo =  @prodno"
            ElseIf section = "CM2" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectCM2Status = 2, BafflesSectCM2 = @TodaysDate, BafflesCM2ID = @station  where ProdNo =  @prodno"
            ElseIf section = "CR" Then
                cmd.CommandText = "UPDATE Tubes SET BafflesSectCRStatus = 2, BafflesSectCR = @TodaysDate, BafflesCRID = @station  where ProdNo =  @prodno"
            End If

        ElseIf tubetype = "WRTY" Then
            If section = "PF" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectPFStatus = 2, BafflesSectPF = @TodaysDate, BafflesPFID = @station where TubeID =  @prodno"
            ElseIf section = "PM" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectPMStatus = 2, BafflesSectPM = @TodaysDate, BafflesPMID = @station  where TubeID =  @prodno"
            ElseIf section = "PM2" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectPM2Status = 2, BafflesSectPM2 = @TodaysDate, BafflesPM2ID = @station  where TubeID =  @prodno"
            ElseIf section = "PR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectPRStatus = 2, BafflesSectPR = @TodaysDate, BafflesPRID = @station  where TubeID =  @prodno"
            ElseIf section = "SF" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectSFStatus = 2, BafflesSectSF = @TodaysDate, BafflesSFID = @station  where TubeID =  @prodno"
            ElseIf section = "SM" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectSMStatus = 2, BafflesSectSM = @TodaysDate, BafflesSMID = @station  where TubeID =  @prodno"
            ElseIf section = "SM2" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectSM2Status = 2, BafflesSectSM2 = @TodaysDate, BafflesSM2ID = @station  where TubeID =  @prodno"
            ElseIf section = "SR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectSRStatus = 2, BafflesSectSR = @TodaysDate, BafflesSRID = @station  where TubeID =  @prodno"
            ElseIf section = "CF" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectCFStatus = 2, BafflesSectCF = @TodaysDate, BafflesCFID = @station  where TubeID =  @prodno"
            ElseIf section = "CM" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectCMStatus = 2, BafflesSectCM = @TodaysDate, BafflesCMID = @station  where TubeID =  @prodno"
            ElseIf section = "CM2" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectCM2Status = 2, BafflesSectCM2 = @TodaysDate, BafflesCM2ID = @station  where TubeID =  @prodno"
            ElseIf section = "CR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET BafflesSectCRStatus = 2, BafflesSectCR = @TodaysDate, BafflesCRID = @station  where TubeID =  @prodno"
            End If

        End If

        conn.Open()

        cmd.Parameters.AddWithValue("@prodno", prod)
        cmd.Parameters.AddWithValue("@station", stationID)
        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)

        cmd.ExecuteNonQuery()

        cmd1.Parameters.AddWithValue("@prodno1", prod)
        cmd2.Parameters.AddWithValue("@prodno2", prod)
        cmd2.Parameters.AddWithValue("@TodaysDate3", TodaysDate)

        If tubetype = "" Or tubetype = "RERUN" Then
            cmd1.CommandText = "Select OuterSections, CenterSections, BafflesSectPFStatus, BafflesSectPMStatus, BafflesSectPM2Status, BafflesSectPRStatus, BafflesSectSFStatus, BafflesSectSMStatus, BafflesSectSM2Status, BafflesSectSRStatus, BafflesSectCFStatus, BafflesSectCMStatus, BafflesSectCM2Status, BafflesSectCRStatus from dbo.Tubes Where ProdNo = @prodno1"
        ElseIf tubetype = "WRTY" Then
            cmd1.CommandText = "Select OuterSections, CenterSections, BafflesSectPFStatus, BafflesSectPMStatus, BafflesSectPM2Status, BafflesSectPRStatus, BafflesSectSFStatus, BafflesSectSMStatus, BafflesSectSM2Status, BafflesSectSRStatus, BafflesSectCFStatus, BafflesSectCMStatus, BafflesSectCM2Status, BafflesSectCRStatus from dbo.CS_Tubes Where TubeID = @prodno1"
        End If


        results = cmd1.ExecuteReader(CommandBehavior.SingleRow)

        If results.Read() Then

            Dim OuterSections As Integer = results.Item("OuterSections")
            Dim CenterSections As Integer = results.Item("CenterSections")
            Dim PortTotal As Integer = Convert.ToInt32(results.Item("BafflesSectPFStatus")) + Convert.ToInt32(results.Item("BafflesSectPMStatus")) + Convert.ToInt32(results.Item("BafflesSectPM2Status")) + Convert.ToInt32(results.Item("BafflesSectPRStatus"))
            Dim StrbTotal As Integer = Convert.ToInt32(results.Item("BafflesSectSFStatus")) + Convert.ToInt32(results.Item("BafflesSectSMStatus")) + Convert.ToInt32(results.Item("BafflesSectSM2Status")) + Convert.ToInt32(results.Item("BafflesSectSRStatus"))
            Dim CtrTotal As Integer = Convert.ToInt32(results.Item("BafflesSectCFStatus")) + Convert.ToInt32(results.Item("BafflesSectCMStatus")) + Convert.ToInt32(results.Item("BafflesSectCM2Status")) + Convert.ToInt32(results.Item("BafflesSectCRStatus"))

            results.Close()


            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then
                portRoundSeamerReady = PortTotal / OuterSections

                If tubetype = "" Or tubetype = "RERUN" Then
                    cmd2.CommandText = "Update Tubes Set RoundSeamerPStatus = -1, RoundSeamerP = @TodaysDate3 where ProdNo = @prodno2"
                ElseIf tubetype = "WRTY" Then
                    cmd2.CommandText = "Update CS_Tubes Set RoundSeamerPStatus = -1, RoundSeamerP = @TodaysDate3 where TubeID = @prodno2"
                End If

                If portRoundSeamerReady = 2 Then
                    cmd2.ExecuteNonQuery()
                End If

            ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
                strbRoundSeamerReady = StrbTotal / OuterSections
                If tubetype = "" Or tubetype = "RERUN" Then
                    cmd2.CommandText = "Update Tubes Set RoundSeamerSStatus = -1, RoundSeamerS = @TodaysDate3 where ProdNo = @prodno2"
                ElseIf tubetype = "WRTY" Then
                    cmd2.CommandText = "Update CS_Tubes Set RoundSeamerSStatus = -1, RoundSeamerS = @TodaysDate3 where TubeID = @prodno2"
                End If


                If strbRoundSeamerReady = 2 Then
                    cmd2.ExecuteNonQuery()
                End If

            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                ctrRoundSeamerReady = CtrTotal / CenterSections
                If tubetype = "" Or tubetype = "RERUN" Then
                    cmd2.CommandText = "Update Tubes Set RoundSeamerCStatus = -1,  RoundSeamerC = @TodaysDate3 where ProdNo = @prodno2"
                ElseIf tubetype = "WRTY" Then
                    cmd2.CommandText = "Update CS_Tubes Set RoundSeamerCStatus = -1,  RoundSeamerC = @TodaysDate3 where TubeID = @prodno2"
                End If

                If ctrRoundSeamerReady = 2 Then
                    cmd2.ExecuteNonQuery()
                End If

            End If


        End If

        lblLast.Text = fullprodno
        tbProd.Text = ""
        tbProd.Focus()


        conn.Close()

    End Function

    Protected Sub tbProd_TextChanged(sender As Object, e As EventArgs) Handles tbProd.TextChanged
        MarkComplete()
    End Sub
End Class
