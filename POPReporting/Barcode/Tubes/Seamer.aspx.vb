Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Barcode_Tubes_Seamer
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
            cmd.CommandText = "UPDATE Tubes SET SeamerSectPFStatus = 1, SeamerSectPF = @TodaysDate, SeamerPFID = @station where ProdNo =  @prodno"
        ElseIf section = "PM" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectPMStatus = 1, SeamerSectPM = @TodaysDate, SeamerPMID = @station  where ProdNo =  @prodno"
        ElseIf section = "PM2" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectPM2Status = 1, SeamerSectPM2 = @TodaysDate, SeamerPM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "PR" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectPRStatus = 1, SeamerSectPR = @TodaysDate, SeamerPRID = @station  where ProdNo =  @prodno"
        ElseIf section = "SF" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectSFStatus = 1, SeamerSectSF = @TodaysDate, SeamerSFID = @station  where ProdNo =  @prodno"
        ElseIf section = "SM" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectSMStatus = 1, SeamerSectSM = @TodaysDate, SeamerSMID = @station  where ProdNo =  @prodno"
        ElseIf section = "SM2" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectSM2Status = 1, SeamerSectSM2 = @TodaysDate, SeamerSM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "SR" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectSRStatus = 1, SeamerSectSR = @TodaysDate, SeamerSRID = @station  where ProdNo =  @prodno"
        ElseIf section = "CF" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectCFStatus = 1, SeamerSectCF = @TodaysDate, SeamerCFID = @station  where ProdNo =  @prodno"
        ElseIf section = "CM" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectCMStatus = 1, SeamerSectCM = @TodaysDate, SeamerCMID = @station  where ProdNo =  @prodno"
        ElseIf section = "CM2" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectCM2Status = 1, SeamerSectCM2 = @TodaysDate, SeamerCM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "CR" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectCRStatus = 1, SeamerSectCR = @TodaysDate, SeamerCRID = @station  where ProdNo =  @prodno"
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
            cmd.CommandText = "UPDATE Tubes SET SeamerSectPFStatus = 2, SeamerSectPF = @TodaysDate, SeamerPFID = @station where ProdNo =  @prodno"
        ElseIf section = "PM" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectPMStatus = 2, SeamerSectPM = @TodaysDate, SeamerPMID = @station  where ProdNo =  @prodno"
        ElseIf section = "PM2" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectPM2Status = 2, SeamerSectPM2 = @TodaysDate, SeamerPM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "PR" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectPRStatus = 2, SeamerSectPR = @TodaysDate, SeamerPRID = @station  where ProdNo =  @prodno"
        ElseIf section = "SF" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectSFStatus = 2, SeamerSectSF = @TodaysDate, SeamerSFID = @station  where ProdNo =  @prodno"
        ElseIf section = "SM" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectSMStatus = 2, SeamerSectSM = @TodaysDate, SeamerSMID = @station  where ProdNo =  @prodno"
        ElseIf section = "SM2" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectSM2Status = 2, SeamerSectSM2 = @TodaysDate, SeamerSM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "SR" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectSRStatus = 2, SeamerSectSR = @TodaysDate, SeamerSRID = @station  where ProdNo =  @prodno"
        ElseIf section = "CF" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectCFStatus = 2, SeamerSectCF = @TodaysDate, SeamerCFID = @station  where ProdNo =  @prodno"
        ElseIf section = "CM" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectCMStatus = 2, SeamerSectCM = @TodaysDate, SeamerCMID = @station  where ProdNo =  @prodno"
        ElseIf section = "CM2" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectCM2Status = 2, SeamerSectCM2 = @TodaysDate, SeamerCM2ID = @station  where ProdNo =  @prodno"
        ElseIf section = "CR" Then
            cmd.CommandText = "UPDATE Tubes SET SeamerSectCRStatus = 2, SeamerSectCR = @TodaysDate, SeamerCRID = @station  where ProdNo =  @prodno"
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

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn

        Dim prod As String = fullprodno.Split("-")(0)
        Dim section As String = fullprodno.Split("-")(1)

        'MesgBox(fullprodno.Split("-").Count)

        If fullprodno.Split("-").Count = 3 Then
            tubetype = fullprodno.Split("-")(2)
        End If

        If tubetype = "" Or tubetype = "RERUN" Then
            If section = "PF" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectPFStatus = 2, SeamerSectPF = @TodaysDate, SeamerPFID = @station, BafflesSectPFStatus = -1 where ProdNo =  @prodno"
            ElseIf section = "PM" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectPMStatus = 2, SeamerSectPM = @TodaysDate, SeamerPMID = @station, BafflesSectPMStatus = -1  where ProdNo =  @prodno"
            ElseIf section = "PM2" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectPM2Status = 2, SeamerSectPM2 = @TodaysDate, SeamerPM2ID = @station, BafflesSectPM2Status = -1  where ProdNo =  @prodno"
            ElseIf section = "PR" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectPRStatus = 2, SeamerSectPR = @TodaysDate, SeamerPRID = @station, BafflesSectPRStatus = -1  where ProdNo =  @prodno"
            ElseIf section = "SF" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectSFStatus = 2, SeamerSectSF = @TodaysDate, SeamerSFID = @station, BafflesSectSFStatus = -1  where ProdNo =  @prodno"
            ElseIf section = "SM" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectSMStatus = 2, SeamerSectSM = @TodaysDate, SeamerSMID = @station, BafflesSectSMStatus = -1  where ProdNo =  @prodno"
            ElseIf section = "SM2" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectSM2Status = 2, SeamerSectSM2 = @TodaysDate, SeamerSM2ID = @station, BafflesSectSM2Status = -1  where ProdNo =  @prodno"
            ElseIf section = "SR" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectSRStatus = 2, SeamerSectSR = @TodaysDate, SeamerSRID = @station, BafflesSectSRStatus = -1  where ProdNo =  @prodno"
            ElseIf section = "CF" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectCFStatus = 2, SeamerSectCF = @TodaysDate, SeamerCFID = @station, BafflesSectCFStatus = -1  where ProdNo =  @prodno"
            ElseIf section = "CM" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectCMStatus = 2, SeamerSectCM = @TodaysDate, SeamerCMID = @station, BafflesSectCMStatus = -1  where ProdNo =  @prodno"
            ElseIf section = "CM2" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectCM2Status = 2, SeamerSectCM2 = @TodaysDate, SeamerCM2ID = @station, BafflesSectCM2Status = -1  where ProdNo =  @prodno"
            ElseIf section = "CR" Then
                cmd.CommandText = "UPDATE Tubes SET SeamerSectCRStatus = 2, SeamerSectCR = @TodaysDate, SeamerCRID = @station, BafflesSectCRStatus = -1  where ProdNo =  @prodno"
            End If

        ElseIf tubetype = "WRTY" Then
            If section = "PF" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectPFStatus = 2, SeamerSectPF = @TodaysDate, SeamerPFID = @station, BafflesSectPFStatus = -1 where TubeID =  @prodno"
            ElseIf section = "PM" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectPMStatus = 2, SeamerSectPM = @TodaysDate, SeamerPMID = @station, BafflesSectPMStatus = -1  where TubeID =  @prodno"
            ElseIf section = "PM2" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectPM2Status = 2, SeamerSectPM2 = @TodaysDate, SeamerPM2ID = @station, BafflesSectPM2Status = -1  where TubeID =  @prodno"
            ElseIf section = "PR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectPRStatus = 2, SeamerSectPR = @TodaysDate, SeamerPRID = @station, BafflesSectPRStatus = -1  where TubeID =  @prodno"
            ElseIf section = "SF" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectSFStatus = 2, SeamerSectSF = @TodaysDate, SeamerSFID = @station, BafflesSectSFStatus = -1  where TubeID =  @prodno"
            ElseIf section = "SM" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectSMStatus = 2, SeamerSectSM = @TodaysDate, SeamerSMID = @station, BafflesSectSMStatus = -1  where TubeID =  @prodno"
            ElseIf section = "SM2" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectSM2Status = 2, SeamerSectSM2 = @TodaysDate, SeamerSM2ID = @station, BafflesSectSM2Status = -1  where TubeID =  @prodno"
            ElseIf section = "SR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectSRStatus = 2, SeamerSectSR = @TodaysDate, SeamerSRID = @station, BafflesSectSRStatus = -1  where TubeID =  @prodno"
            ElseIf section = "CF" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectCFStatus = 2, SeamerSectCF = @TodaysDate, SeamerCFID = @station, BafflesSectCFStatus = -1  where TubeID =  @prodno"
            ElseIf section = "CM" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectCMStatus = 2, SeamerSectCM = @TodaysDate, SeamerCMID = @station, BafflesSectCMStatus = -1  where TubeID =  @prodno"
            ElseIf section = "CM2" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectCM2Status = 2, SeamerSectCM2 = @TodaysDate, SeamerCM2ID = @station, BafflesSectCM2Status = -1  where TubeID =  @prodno"
            ElseIf section = "CR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET SeamerSectCRStatus = 2, SeamerSectCR = @TodaysDate, SeamerCRID = @station, BafflesSectCRStatus = -1  where TubeID =  @prodno"
            End If

        End If

        'Mesgbox(cmd.CommandText)

        conn.Open()

        cmd.Parameters.AddWithValue("@prodno", prod)
        cmd.Parameters.AddWithValue("@station", stationID)
        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.ExecuteNonQuery()

        lblLast.Text = fullprodno
        tbProd.Text = ""
        tbProd.Focus()


        conn.Close()

    End Function

    Protected Sub tbProd_TextChanged(sender As Object, e As EventArgs) Handles tbProd.TextChanged
        MarkComplete()
    End Sub
End Class
