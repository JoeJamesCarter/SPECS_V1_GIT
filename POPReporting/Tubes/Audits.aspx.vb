Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Tubes_Audits
    Inherits System.Web.UI.Page

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class

    Protected Sub Tubes_Audits_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbProd.Focus()
        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
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

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub
    
    Protected Sub Save(ByVal sender As Object, ByVal e As EventArgs)
        'Read the Base64 string from Hidden Field.
        Dim base64 As String = Request.Form(hfImageData.UniqueID).Split(",")(1)

        Dim prodno As String = lblProd.Text

        Dim TodaysDate As Date = Date.Now
        Dim filename As String = prodno + "_" + TodaysDate
        filename = filename.Substring(0, filename.Length - 2)
        filename = filename.Replace(" ", "_")
        filename = filename.Replace("/", "_")
        filename = filename.Replace(":", "")

        filename = filename + "_" + lblTube.Text


        'Convert Base64 string to Byte Array.)
        Dim bytes() As Byte = Convert.FromBase64String(base64)

        'Save the Byte Array as Image File.
        Dim filePath As String = String.Format("Audits/" + prodno + "/{0}.png", filename)
        Dim path As String = Server.MapPath("Audits/" + prodno + "/")

        'Dim filePath As String = String.Format(Server.MapPath("Uploads/" + prodno + "/")

        If (Not System.IO.Directory.Exists(path)) Then
            System.IO.Directory.CreateDirectory(path)
        End If

        File.WriteAllBytes(Server.MapPath(filePath), bytes)

        Dim TransomUnmarked As Integer = tbTransomUnmarked.Text
        Dim TransomMarked As Integer = tbTransomMarked.Text
        Dim TransomMissed As Integer = tbTransomMissed.Text

        Dim PreweldUnmarked As Integer = tbPreweldUnmarked.Text
        Dim PreweldMarked As Integer = tbPreweldMarked.Text
        Dim PreweldMissed As Integer = tbPreweldMissed.Text

        Dim BracketsUnmarked As Integer = tbBracketsUnmarked.Text
        Dim BracketsMarked As Integer = tbBracketsMarked.Text
        Dim BracketsMissed As Integer = tbBracketsMissed.Text

        Dim SeamerUnmarked As Integer = tbRSUnmarked.Text
        Dim SeamerMarked As Integer = tbRSMarked.Text
        Dim SeamerMissed As Integer = tbRSMissed.Text

        Dim KeelUnmarked As Integer = tbKeelUnmarked.Text
        Dim KeelMarked As Integer = tbKeelMarked.Text
        Dim KeelMissed As Integer = tbKeelMissed.Text

        Dim EndcapUnmarked As Integer = tbEndcapUnmarked.Text
        Dim EndcapMarked As Integer = tbEndcapMarked.Text
        Dim EndcapMissed As Integer = tbEndcapMissed.Text

        Dim NoseconeUnmarked As Integer = tbNoseconeUnmarked.Text
        Dim NoseconeMarked As Integer = tbNoseconeMarked.Text
        Dim NoseconeMissed As Integer = tbNoseconeMissed.Text

        Dim SplashUnmarked As Integer = tbSplashUnmarked.Text
        Dim SplashMarked As Integer = tbSplashMarked.Text
        Dim SplashMissed As Integer = tbSplashMissed.Text

        Dim TopseamUnmarked As Integer = tbTopseamUnmarked.Text
        Dim TopseamMarked As Integer = tbTopseamMarked.Text
        Dim TopseamMissed As Integer = tbTopseamMissed.Text

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd6 As New SqlCommand
        Dim cmd7 As New SqlCommand
        Dim cmd8 As New SqlCommand


        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd8.Connection = conn

        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@Marked", TransomMarked)
        cmd.Parameters.AddWithValue("@Unmarked", TransomUnmarked)
        cmd.Parameters.AddWithValue("@Missed", TransomMissed)
        cmd.Parameters.AddWithValue("@Type", "Transom")

        cmd1.Parameters.AddWithValue("@TodaysDate1", TodaysDate)
        cmd1.Parameters.AddWithValue("@Marked1", PreweldMarked)
        cmd1.Parameters.AddWithValue("@Unmarked1", PreweldUnmarked)
        cmd1.Parameters.AddWithValue("@Missed1", PreweldMissed)
        cmd1.Parameters.AddWithValue("@Type1", "Preweld")

        cmd2.Parameters.AddWithValue("@TodaysDate2", TodaysDate)
        cmd2.Parameters.AddWithValue("@Marked2", BracketsMarked)
        cmd2.Parameters.AddWithValue("@Unmarked2", BracketsUnmarked)
        cmd2.Parameters.AddWithValue("@Missed2", BracketsMissed)
        cmd2.Parameters.AddWithValue("@Type2", "Brackets")

        cmd3.Parameters.AddWithValue("@TodaysDate3", TodaysDate)
        cmd3.Parameters.AddWithValue("@Marked3", SplashMarked)
        cmd3.Parameters.AddWithValue("@Unmarked3", SplashUnmarked)
        cmd3.Parameters.AddWithValue("@Missed3", SplashMissed)
        cmd3.Parameters.AddWithValue("@Type3", "Splash")

        cmd4.Parameters.AddWithValue("@TodaysDate4", TodaysDate)
        cmd4.Parameters.AddWithValue("@Marked4", SeamerMarked)
        cmd4.Parameters.AddWithValue("@Unmarked4", SeamerUnmarked)
        cmd4.Parameters.AddWithValue("@Missed4", SeamerMissed)
        cmd4.Parameters.AddWithValue("@Type4", "Seamer")

        cmd5.Parameters.AddWithValue("@TodaysDate5", TodaysDate)
        cmd5.Parameters.AddWithValue("@Marked5", KeelMarked)
        cmd5.Parameters.AddWithValue("@Unmarked5", KeelUnmarked)
        cmd5.Parameters.AddWithValue("@Missed5", KeelMissed)
        cmd5.Parameters.AddWithValue("@Type5", "Keel")

        cmd6.Parameters.AddWithValue("@TodaysDate6", TodaysDate)
        cmd6.Parameters.AddWithValue("@Marked6", EndcapMarked)
        cmd6.Parameters.AddWithValue("@Unmarked6", EndcapUnmarked)
        cmd6.Parameters.AddWithValue("@Missed6", EndcapMissed)
        cmd6.Parameters.AddWithValue("@Type6", "End Cap")

        cmd7.Parameters.AddWithValue("@TodaysDate7", TodaysDate)
        cmd7.Parameters.AddWithValue("@Marked7", NoseconeMarked)
        cmd7.Parameters.AddWithValue("@Unmarked7", NoseconeUnmarked)
        cmd7.Parameters.AddWithValue("@Missed7", NoseconeMissed)
        cmd7.Parameters.AddWithValue("@Type7", "Nose Cone")

        cmd8.Parameters.AddWithValue("@TodaysDate8", TodaysDate)
        cmd8.Parameters.AddWithValue("@Marked8", TopseamMarked)
        cmd8.Parameters.AddWithValue("@Unmarked8", TopseamUnmarked)
        cmd8.Parameters.AddWithValue("@Missed8", TopseamMissed)
        cmd8.Parameters.AddWithValue("@Type8", "Top Seam")


        cmd.Parameters.AddWithValue("@AddedBy", GlobalVariables.stationID)
        cmd1.Parameters.AddWithValue("@AddedBy1", GlobalVariables.stationID)
        cmd2.Parameters.AddWithValue("@AddedBy2", GlobalVariables.stationID)
        cmd3.Parameters.AddWithValue("@AddedBy3", GlobalVariables.stationID)
        cmd4.Parameters.AddWithValue("@AddedBy4", GlobalVariables.stationID)
        cmd5.Parameters.AddWithValue("@AddedBy5", GlobalVariables.stationID)
        cmd6.Parameters.AddWithValue("@AddedBy6", GlobalVariables.stationID)
        cmd7.Parameters.AddWithValue("@AddedBy7", GlobalVariables.stationID)
        cmd8.Parameters.AddWithValue("@AddedBy8", GlobalVariables.stationID)

        cmd.Parameters.AddWithValue("@ProdNo", prodno)
        cmd1.Parameters.AddWithValue("@ProdNo1", prodno)
        cmd2.Parameters.AddWithValue("@ProdNo2", prodno)
        cmd3.Parameters.AddWithValue("@ProdNo3", prodno)
        cmd4.Parameters.AddWithValue("@ProdNo4", prodno)
        cmd5.Parameters.AddWithValue("@ProdNo5", prodno)
        cmd6.Parameters.AddWithValue("@ProdNo6", prodno)
        cmd7.Parameters.AddWithValue("@ProdNo7", prodno)
        cmd8.Parameters.AddWithValue("@ProdNo8", prodno)

        cmd.Parameters.AddWithValue("@Tube", lblTube.Text)
        cmd1.Parameters.AddWithValue("@Tube1", lblTube.Text)
        cmd2.Parameters.AddWithValue("@Tube2", lblTube.Text)
        cmd3.Parameters.AddWithValue("@Tube3", lblTube.Text)
        cmd4.Parameters.AddWithValue("@Tube4", lblTube.Text)
        cmd5.Parameters.AddWithValue("@Tube5", lblTube.Text)
        cmd6.Parameters.AddWithValue("@Tube6", lblTube.Text)
        cmd7.Parameters.AddWithValue("@Tube7", lblTube.Text)
        cmd8.Parameters.AddWithValue("@Tube8", lblTube.Text)

        cmd.CommandText = "Insert into Tubes_AuditInfo (ProdNo, Marked, Unmarked, Missed, Type, Added, AddedBy, Tube) VALUES (@ProdNo, @Marked, @Unmarked, @Missed, @Type, @TodaysDate, @AddedBy, @Tube)" 'Transom
        cmd1.CommandText = "Insert into Tubes_AuditInfo (ProdNo, Marked, Unmarked, Missed, Type, Added, AddedBy, Tube) VALUES (@ProdNo1, @Marked1, @Unmarked1, @Missed1, @Type1, @TodaysDate1, @AddedBy1, @Tube1)" 'Preweld
        cmd2.CommandText = "Insert into Tubes_AuditInfo (ProdNo, Marked, Unmarked, Missed, Type, Added, AddedBy, Tube) VALUES (@ProdNo2, @Marked2, @Unmarked2, @Missed2, @Type2, @TodaysDate2, @AddedBy2, @Tube2)" 'Brackets
        cmd3.CommandText = "Insert into Tubes_AuditInfo (ProdNo, Marked, Unmarked, Missed, Type, Added, AddedBy, Tube) VALUES (@ProdNo3, @Marked3, @Unmarked3, @Missed3, @Type3, @TodaysDate3, @AddedBy3, @Tube3)" 'Splash
        cmd4.CommandText = "Insert into Tubes_AuditInfo (ProdNo, Marked, Unmarked, Missed, Type, Added, AddedBy, Tube) VALUES (@ProdNo4, @Marked4, @Unmarked4, @Missed4, @Type4, @TodaysDate4, @AddedBy4, @Tube4)" 'Seamer
        cmd5.CommandText = "Insert into Tubes_AuditInfo (ProdNo, Marked, Unmarked, Missed, Type, Added, AddedBy, Tube) VALUES (@ProdNo5, @Marked5, @Unmarked5, @Missed5, @Type5, @TodaysDate5, @AddedBy5, @Tube5)" 'Keel
        cmd6.CommandText = "Insert into Tubes_AuditInfo (ProdNo, Marked, Unmarked, Missed, Type, Added, AddedBy, Tube) VALUES (@ProdNo6, @Marked6, @Unmarked6, @Missed6, @Type6, @TodaysDate6, @AddedBy6, @Tube6)" 'Endcap
        cmd7.CommandText = "Insert into Tubes_AuditInfo (ProdNo, Marked, Unmarked, Missed, Type, Added, AddedBy, Tube) VALUES (@ProdNo7, @Marked7, @Unmarked7, @Missed7, @Type7, @TodaysDate7, @AddedBy7, @Tube7)" 'Nosecone
        cmd8.CommandText = "Insert into Tubes_AuditInfo (ProdNo, Marked, Unmarked, Missed, Type, Added, AddedBy, Tube) VALUES (@ProdNo8, @Marked8, @Unmarked8, @Missed8, @Type8, @TodaysDate8, @AddedBy8, @Tube8)" 'TopSeam

        conn.open()

        cmd.ExecuteNonQuery()
        cmd1.ExecuteNonQuery()
        cmd2.ExecuteNonQuery()
        cmd3.ExecuteNonQuery()
        cmd4.ExecuteNonQuery()
        cmd5.ExecuteNonQuery()
        cmd6.ExecuteNonQuery()
        cmd7.ExecuteNonQuery()
        cmd8.ExecuteNonQuery()

        conn.close()

        MarkComplete()
        tbProd.Text = ""
        lblProd.Text = ""
        lblTube.Text = ""
        lblInspect.Text = ""
        lblBaffle.Text = ""
        lblBrackets.Text = ""
        lblSeamer.Text = ""
        lblAircheck1.Text = ""
        lblRepair1.Text = ""
        lblAircheck2.Text = ""
        lblRepair2.Text = ""

        'MarkComplete()

    End Sub

    Protected Function SetText() As String

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim results As SqlDataReader
        conn.ConnectionString = connstr
        cmd.Connection = conn

        Dim fullprodno As String = tbProd.Text
        Dim tubetype As String = ""

        Dim prod As String = fullprodno.Split("-")(0)
        Dim section As String = fullprodno.Split("-")(1)

        If fullprodno.Split("-").Count = 3 Then
            tubetype = fullprodno.Split("-")(2)
        End If

        lblProd.Text = prod

        If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then
            lblTube.Text = "PORT"
        ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
            lblTube.Text = "STRB"
        ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
            lblTube.Text = "CTR"
        End If

        cmd.Parameters.AddWithValue("@prodno", prod)

        If tubetype = "" Or tubetype = "RERUN" Then
            If lblTube.Text = "PORT" Then
                cmd.CommandText = "Select BafflesPFID as BafflesID, BracketsPID as BracketsID, RoundSeamerPID as SeamerID, AircheckPID as Aircheck1ID, Repair1PID as Repair1ID, Aircheck2PID as Aircheck2ID, Repair2PID as Repair2ID From Tubes where ProdNo =  @prodno"
            ElseIf lblTube.Text = "STRB" Then
                cmd.CommandText = "Select BafflesSFID as BafflesID, BracketsSID as BracketsID, RoundSeamerSID as SeamerID, AircheckSID as Aircheck1ID, Repair1SID as Repair1ID, Aircheck2SID as Aircheck2ID, Repair2SID as Repair2ID From Tubes where ProdNo =  @prodno"
            ElseIf lblTube.Text = "CTR" Then
                cmd.CommandText = "Select BafflesCFID as BafflesID, BracketsCID as BracketsID, RoundSeamerCID as SeamerID, Aircheck1CID as Aircheck1ID, Repair1CID as Repair1ID, Aircheck2CID as Aircheck2ID, Repair2CID as Repair2ID From Tubes where ProdNo =  @prodno"
            End If

        ElseIf tubetype = "WRTY" Then
            If lblTube.Text = "PORT" Then
                cmd.CommandText = "Select BafflesPFID as BafflesID, BracketsPID as BracketsID, RoundSeamerPID as SeamerID, AircheckPID as Aircheck1ID, Repair1PID as Repair1ID, Aircheck2PID as Aircheck2ID, Repair2PID as Repair2ID From CS_Tubes where TubeID =  @prodno"
            ElseIf lblTube.Text = "STRB" Then
                cmd.CommandText = "Select BafflesSFID as BafflesID, BracketsSID as BracketsID, RoundSeamerSID as SeamerID, AircheckSID as Aircheck1ID, Repair1SID as Repair1ID, Aircheck2SID as Aircheck2ID, Repair2SID as Repair2ID From CS_Tubes where TubeID =  @prodno"
            ElseIf lblTube.Text = "CTR" Then
                cmd.CommandText = "Select BafflesCFID as BafflesID, BracketsCID as BracketsID, RoundSeamerCID as SeamerID, AircheckCID as Aircheck1ID, Repair1CID as Repair1ID, Aircheck2CID as Aircheck2ID, Repair2CID as Repair2ID From CS_Tubes where TubeID =  @prodno"
            End If

        End If
        conn.Open()

        results = cmd.ExecuteReader(CommandBehavior.SingleRow)

        If results.Read() Then
            lblInspect.Text = GlobalVariables.stationID
            lblBaffle.Text = results.Item("BafflesID").ToString
            lblBrackets.Text = results.Item("BracketsID").ToString
            lblSeamer.Text = results.Item("SeamerID").ToString
            lblAircheck1.Text = results.Item("Aircheck1ID").ToString
            lblRepair1.Text = results.Item("Repair1ID").ToString
            lblAircheck2.Text = results.Item("Aircheck2ID").ToString
            lblRepair2.Text = results.Item("Repair2ID").ToString
        End If

        conn.Close()


    End Function

    Protected Sub tbProd_TextChanged(sender As Object, e As EventArgs) Handles tbProd.TextChanged
        SetText()
    End Sub

    Protected Function MarkComplete() As String
        'If it is an outer with foils or a center with chines turn on chines else if it is outer set final to ready.
        'Copied Aircheck to repeat logic that should really be at repair2 instead. Repair2 will turn on chines or not based on strakes.

        Dim fullprodno As String = tbProd.Text
        Dim TodaysDate As Date = Date.Now
        Dim stationID As String = GlobalVariables.stationID
        Dim tubetype As String = ""
        Dim strakes As String = ""

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand 'Check for Strakes or Foils
        Dim cmd2 As New SqlCommand 'Set Final or Chines to -1 based on strakes

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


        'get strakes
        If tubetype = "" Or tubetype = "RERUN" Then
            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Or section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
                cmd1.CommandText = "SELECT Strakes from OuterTubeDetails Where ProdNo = @prodno1"
            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                cmd1.CommandText = "SELECT Strakes from CentertubeDetails Where ProdNo = @prodno1"
            End If

        ElseIf tubetype = "WRTY" Then
            cmd1.CommandText = "SELECT Strakes from CS_Tubes Where TubeID = @prodno1"
        End If

        'update repair2
        If tubetype = "" Or tubetype = "RERUN" Then
            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then
                cmd.CommandText = "UPDATE Tubes SET AuditPStatus = 2, AuditP = @TodaysDate, AuditPID = @station where ProdNo =  @prodno"
            ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
                cmd.CommandText = "UPDATE Tubes SET AuditSStatus = 2, AuditS = @TodaysDate, AuditSID = @station where ProdNo =  @prodno"
            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                cmd.CommandText = "UPDATE Tubes SET AuditCStatus = 2, AuditC = @TodaysDate, AuditCID = @station where ProdNo =  @prodno"
            End If

        ElseIf tubetype = "WRTY" Then
            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET AuditPStatus = 2, AuditP = @TodaysDate, AuditPID = @station where TubeID =  @prodno"
            ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET AuditSStatus = 2, AuditS = @TodaysDate, AuditSID = @station where TubeID =  @prodno"
            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                cmd.CommandText = "UPDATE CS_Tubes SET AuditCStatus = 2, AuditC = @TodaysDate, AuditCID = @station where TubeID =  @prodno"
            End If
        End If

        conn.Open()
        cmd1.Parameters.AddWithValue("@prodno1", prod)
        cmd2.Parameters.AddWithValue("@prodno2", prod)
        strakes = cmd1.ExecuteScalar().ToString()

        cmd.Parameters.AddWithValue("@prodno", prod)
        cmd.Parameters.AddWithValue("@station", stationID)
        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)


        'If strakes Like "*FOILS*" Or strakes Like "*STRAKES*" Then
        'MesgBox("Yes")
        'Else
        'MesgBox("No")
        'End If

        cmd.ExecuteNonQuery()

        'update next station
        If tubetype = "" Or tubetype = "RERUN" Then
            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then

                If strakes Like "*FOIL*" Or strakes Like "*CHINE*" Then
                    cmd2.CommandText = "UPDATE Tubes SET ChinesPStatus = -1 where ProdNo =  @prodno2"
                Else
                    cmd2.CommandText = "UPDATE Tubes SET FinalPStatus = -1 where FinalPStatus < 2 and ProdNo =  @prodno2"
                End If

            ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then

                If strakes Like "*FOIL*" Or strakes.ToString() Like "*STRAKES*" Then
                    cmd2.CommandText = "UPDATE Tubes SET ChinesSStatus = -1 where ProdNo =  @prodno2"
                Else
                    cmd2.CommandText = "UPDATE Tubes SET FinalSStatus = -1 where FinalSStatus < 2 and ProdNo =  @prodno2"
                End If

            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                'If strakes Like "*FOIL*" Or strakes Like "*CHINE*" Then
                cmd2.CommandText = "UPDATE Tubes SET ChinesCStatus = -1 where ProdNo =  @prodno2"
                'Else
                'cmd2.CommandText = "UPDATE Tubes SET FinalCStatus = -1 where FinalCStatus < 2 and ProdNo =  @prodno2"
                'End If
            End If

        ElseIf tubetype = "WRTY" Then

            If section = "PF" Or section = "PM" Or section = "PM2" Or section = "PR" Then
                If strakes Like "*FOIL*" Or strakes Like "*CHINE*" Then
                    cmd2.CommandText = "UPDATE CS_Tubes SET ChinesPStatus = -1 where TubeID =  @prodno2"
                Else
                    cmd2.CommandText = "UPDATE CS_Tubes SET FinalPStatus = -1 where FinalPStatus < 2 and TubeID =  @prodno2"
                End If
            ElseIf section = "SF" Or section = "SM" Or section = "SM2" Or section = "SR" Then
                If strakes Like "*FOIL*" Or strakes Like "*CHINE*" Then
                    cmd2.CommandText = "UPDATE CS_Tubes SET ChinesSStatus = -1 where TubeID =  @prodno2"
                Else
                    cmd2.CommandText = "UPDATE CS_Tubes SET FinalSStatus = -1 where FinalSStatus < 2 and TubeID =  @prodno2"
                End If
            ElseIf section = "CF" Or section = "CM" Or section = "CM2" Or section = "CR" Then
                'If strakes Like "*FOIL*" Or strakes Like "*CHINE*" Then Note: All Centers get chines, they only designate Salt water on the schedule
                cmd2.CommandText = "UPDATE CS_Tubes SET ChinesCStatus = -1 where TubeID =  @prodno2"
                'Else
                'cmd2.CommandText = "UPDATE CS_Tubes SET FinalCStatus = -1 where FinalCStatus < 2 and TubeID =  @prodno2"
                'End If
            End If

        End If

        cmd2.ExecuteNonQuery()
        conn.Close()

        tbProd.Focus()

    End Function
End Class
