Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Inspections_TubeInspections
    Inherits System.Web.UI.Page

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class

    Protected Sub Tubes_Audits_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbProd.Focus()
        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
        btnSave.Enabled = False

        Dim BoatProdNo As String
        BoatProdNo = Request.QueryString("ProdNo")
        tbProd.Text = BoatProdNo

        'populate attachments placeholder

        Dim strFileSize As String = ""
        Dim di As New IO.DirectoryInfo(Server.MapPath("Tubes/" + BoatProdNo + "/"))
        If di.Exists Then


            Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
            Dim fi As IO.FileInfo
            Dim k As Integer = 0


            For Each fi In aryFi

                strFileSize = (Math.Round(fi.Length / 1024)).ToString()
                'lblUploadResult.Text = fi.Name

                Dim lnk As New HyperLink
                Dim img As New Image
                Dim imgBtn As New ImageButton

                lnk.ID = "lnk" & k.ToString()
                'PlaceHolder1.Controls.Add(GetLiteral("</br/>""))
                'PlaceHolder1.Controls.Add(GetLiteral("<br />"))
                lnk.ID = "lnk" & k.ToString()
                lnk.NavigateUrl = "http:\\specs\Live\PopReporting\Inspections\Tubes\" & BoatProdNo & "\" & fi.Name
                lnk.Target = "_blank"
                lnk.Text = fi.Name
                img.ImageUrl = lnk.NavigateUrl

                phPreviousInspections.Controls.Add(New LiteralControl("<br />"))
                phPreviousInspections.Controls.Add(lnk)

                phPreviousInspections.Controls.Add(img)
                k += 1

                'Console.WriteLine("File Name: {0}", fi.Name)
                'Console.WriteLine("File Full Name: {0}", fi.FullName)
                'Console.WriteLine("File Size (KB): {0}", strFileSize)
                'Console.WriteLine("File Extension: {0}", fi.Extension)
                'Console.WriteLine("Last Accessed: {0}", fi.LastAccessTime)
                'Console.WriteLine("Read Only: {0}", (fi.Attributes.ReadOnly = True).ToString)
            Next
        End If

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
        If ddlWorkstation.SelectedValue = "NotSet" Then
            MesgBox("Please set the location of the boat.")
            Return
        End If

        'Read the Base64 string from Hidden Field.
        Dim base64 As String = Request.Form(hfImageData.UniqueID).Split(",")(1)

        Dim prodno As String = tbProd.Text

        Dim TodaysDate As Date = Date.Now
        Dim filename As String = prodno + "_" + TodaysDate
        filename = filename.Substring(0, filename.Length - 2)
        filename = filename.Replace(" ", "_")
        filename = filename.Replace("/", "_")
        filename = filename.Replace(":", "")

        filename = filename.Substring(0, filename.Length - 3) 'strip am or pm
        filename = filename + "_" + rblTube.SelectedValue ' add which tube it is

        'Convert Base64 string to Byte Array.)
        Dim bytes() As Byte = Convert.FromBase64String(base64)

        'Save the Byte Array as Image File.
        Dim filePath As String = String.Format("Tubes/" + prodno + "/{0}.png", filename)
        Dim path As String = Server.MapPath("Tubes/" + prodno + "/")

        If (Not System.IO.Directory.Exists(path)) Then
            System.IO.Directory.CreateDirectory(path)
        End If

        File.WriteAllBytes(Server.MapPath(filePath), bytes)

        Dim DentsFront As Integer = tbDentsFront.Text
        Dim DentsMid As Integer = tbDentsMid.Text
        Dim DentsRear As Integer = tbDentsRear.Text
        Dim DentsEndCap As Integer = tbDentsEndCap.Text
        Dim DentsNoseCone As Integer = tbDentsNoseCone.Text

        Dim CartDentsFront As Integer = tbCartDentsFront.Text
        Dim CartDentsMid As Integer = tbCartDentsMid.Text
        Dim CartDentsRear As Integer = tbCartDentsRear.Text
        Dim CartDentsEndCap As Integer = tbCartDentsEndCap.Text
        Dim CartDentsNoseCone As Integer = tbCartDentsNoseCone.Text


        Dim ScratchesFront As Integer = tbScratchesFront.Text
        Dim ScratchesMid As Integer = tbScratchesMid.Text
        Dim ScratchesRear As Integer = tbScratchesRear.Text
        Dim ScratchesEndCap As Integer = tbScratchesEndCap.Text
        Dim ScratchesNoseCone As Integer = tbScratchesNoseCone.Text


        Dim SplatterFront As Integer = tbSplatterFront.Text
        Dim SplatterMid As Integer = tbSplatterMid.Text
        Dim SplatterRear As Integer = tbSplatterRear.Text
        Dim SplatterEndCap As Integer = tbSplatterEndCap.Text
        Dim SplatterNoseCone As Integer = tbSplatterNoseCone.Text


        Dim DustFront As Integer = tbDustFront.Text
        Dim DustMid As Integer = tbDustMid.Text
        Dim DustRear As Integer = tbDustRear.Text
        Dim DustEndCap As Integer = tbDustEndCap.Text
        Dim DustNoseCone As Integer = tbDustNoseCone.Text


        Dim BurnsFront As Integer = tbBurnsFront.Text
        Dim BurnsMid As Integer = tbBurnsMid.Text
        Dim BurnsRear As Integer = tbBurnsRear.Text
        Dim BurnsEndCap As Integer = tbBurnsEndCap.Text
        Dim BurnsNoseCone As Integer = tbBurnsNoseCone.Text


        Dim MarkerFront As Integer = tbMarkerFront.Text
        Dim MarkerMid As Integer = tbMarkerMid.Text
        Dim MarkerRear As Integer = tbMarkerRear.Text
        Dim MarkerEndCap As Integer = tbMarkerEndCap.Text
        Dim MarkerNoseCone As Integer = tbMarkerNoseCone.Text


        Dim IncompleteFront As Integer = tbIncompleteFront.Text
        Dim IncompleteMid As Integer = tbIncompleteMid.Text
        Dim IncompleteRear As Integer = tbIncompleteRear.Text
        Dim IncompleteEndCap As Integer = tbIncompleteEndCap.Text
        Dim IncompleteNoseCone As Integer = tbIncompleteNoseCone.Text


        Dim FitFinishFront As Integer = tbFitFinishFront.Text
        Dim FitFinishMid As Integer = tbFitFinishMid.Text
        Dim FitFinishRear As Integer = tbFitFinishRear.Text
        Dim FitFinishEndCap As Integer = tbFitFinishEndCap.Text
        Dim FitFinishNoseCone As Integer = tbFitFinishNoseCone.Text

        Dim Comments As String = tbComments.Text


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

        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@Dents", DentsFront)
        cmd.Parameters.AddWithValue("@CartDents", CartDentsFront)
        cmd.Parameters.AddWithValue("@Scratches", ScratchesFront)
        cmd.Parameters.AddWithValue("@Splatter", SplatterFront)
        cmd.Parameters.AddWithValue("@Dust", DustFront)
        cmd.Parameters.AddWithValue("@Burns", BurnsFront)
        cmd.Parameters.AddWithValue("@Marker", MarkerFront)
        cmd.Parameters.AddWithValue("@Incomplete", IncompleteFront)
        cmd.Parameters.AddWithValue("@FitFinish", FitFinishFront)
        cmd.Parameters.AddWithValue("@Tube", rblTube.SelectedValue)
        cmd.Parameters.AddWithValue("@Workstation", ddlWorkstation.SelectedValue)
        cmd.Parameters.AddWithValue("@Comments", Comments)

        cmd1.Parameters.AddWithValue("@TodaysDate1", TodaysDate)
        cmd1.Parameters.AddWithValue("@Dents1", DentsMid)
        cmd1.Parameters.AddWithValue("@CartDents1", CartDentsMid)
        cmd1.Parameters.AddWithValue("@Scratches1", ScratchesMid)
        cmd1.Parameters.AddWithValue("@Splatter1", SplatterMid)
        cmd1.Parameters.AddWithValue("@Dust1", DustMid)
        cmd1.Parameters.AddWithValue("@Burns1", BurnsMid)
        cmd1.Parameters.AddWithValue("@Marker1", MarkerMid)
        cmd1.Parameters.AddWithValue("@Incomplete1", IncompleteMid)
        cmd1.Parameters.AddWithValue("@FitFinish1", FitFinishMid)
        cmd1.Parameters.AddWithValue("@Tube1", rblTube.SelectedValue)
        cmd1.Parameters.AddWithValue("@Workstation1", ddlWorkstation.SelectedValue)
        cmd1.Parameters.AddWithValue("@Comments1", Comments)

        cmd2.Parameters.AddWithValue("@TodaysDate2", TodaysDate)
        cmd2.Parameters.AddWithValue("@Dents2", DentsRear)
        cmd2.Parameters.AddWithValue("@CartDents2", CartDentsRear)
        cmd2.Parameters.AddWithValue("@Scratches2", ScratchesRear)
        cmd2.Parameters.AddWithValue("@Splatter2", SplatterRear)
        cmd2.Parameters.AddWithValue("@Dust2", DustRear)
        cmd2.Parameters.AddWithValue("@Burns2", BurnsRear)
        cmd2.Parameters.AddWithValue("@Marker2", MarkerRear)
        cmd2.Parameters.AddWithValue("@Incomplete2", IncompleteRear)
        cmd2.Parameters.AddWithValue("@FitFinish2", FitFinishRear)
        cmd2.Parameters.AddWithValue("@Tube2", rblTube.SelectedValue)
        cmd2.Parameters.AddWithValue("@Workstation2", ddlWorkstation.SelectedValue)
        cmd2.Parameters.AddWithValue("@Comments2", Comments)

        cmd3.Parameters.AddWithValue("@TodaysDate3", TodaysDate)
        cmd3.Parameters.AddWithValue("@Dents3", DentsEndCap)
        cmd3.Parameters.AddWithValue("@CartDents3", CartDentsEndCap)
        cmd3.Parameters.AddWithValue("@Scratches3", ScratchesEndCap)
        cmd3.Parameters.AddWithValue("@Splatter3", SplatterEndCap)
        cmd3.Parameters.AddWithValue("@Dust3", DustEndCap)
        cmd3.Parameters.AddWithValue("@Burns3", BurnsEndCap)
        cmd3.Parameters.AddWithValue("@Marker3", MarkerEndCap)
        cmd3.Parameters.AddWithValue("@Incomplete3", IncompleteEndCap)
        cmd3.Parameters.AddWithValue("@FitFinish3", FitFinishEndCap)
        cmd3.Parameters.AddWithValue("@Tube3", rblTube.SelectedValue)
        cmd3.Parameters.AddWithValue("@Workstation3", ddlWorkstation.SelectedValue)
        cmd3.Parameters.AddWithValue("@Comments3", Comments)

        cmd4.Parameters.AddWithValue("@TodaysDate4", TodaysDate)
        cmd4.Parameters.AddWithValue("@Dents4", DentsNoseCone)
        cmd4.Parameters.AddWithValue("@CartDents4", CartDentsNoseCone)
        cmd4.Parameters.AddWithValue("@Scratches4", ScratchesNoseCone)
        cmd4.Parameters.AddWithValue("@Splatter4", SplatterNoseCone)
        cmd4.Parameters.AddWithValue("@Dust4", DustNoseCone)
        cmd4.Parameters.AddWithValue("@Burns4", BurnsNoseCone)
        cmd4.Parameters.AddWithValue("@Marker4", MarkerNoseCone)
        cmd4.Parameters.AddWithValue("@Incomplete4", IncompleteNoseCone)
        cmd4.Parameters.AddWithValue("@FitFinish4", FitFinishNoseCone)
        cmd4.Parameters.AddWithValue("@Tube4", rblTube.SelectedValue)
        cmd4.Parameters.AddWithValue("@Workstation4", ddlWorkstation.SelectedValue)
        cmd4.Parameters.AddWithValue("@Comments4", Comments)

        cmd.Parameters.AddWithValue("@InspectedBy", GlobalVariables.stationID)
        cmd1.Parameters.AddWithValue("@InspectedBy1", GlobalVariables.stationID)
        cmd2.Parameters.AddWithValue("@InspectedBy2", GlobalVariables.stationID)
        cmd3.Parameters.AddWithValue("@InspectedBy3", GlobalVariables.stationID)
        cmd4.Parameters.AddWithValue("@InspectedBy4", GlobalVariables.stationID)

        cmd.Parameters.AddWithValue("@ProdNo", prodno)
        cmd1.Parameters.AddWithValue("@ProdNo1", prodno)
        cmd2.Parameters.AddWithValue("@ProdNo2", prodno)
        cmd3.Parameters.AddWithValue("@ProdNo3", prodno)
        cmd4.Parameters.AddWithValue("@ProdNo4", prodno)

        cmd.CommandText = "Insert into Inspections_Tubes (ProdNo, DateInspected, Dents, CartDents, Scratches, Splatter, Dust, Burns, Marker, Incomplete, FitFinish, LocationOfProblem, Tube, Workstation, InspectedBy, Comments) VALUES (@ProdNo, @TodaysDate, @Dents, @CartDents, @Scratches, @Splatter, @Dust, @Burns, @Marker, @Incomplete, @FitFinish, 'Front', @Tube, @Workstation, @InspectedBy, @Comments)" ' Front
        cmd1.CommandText = "Insert into Inspections_Tubes (ProdNo, DateInspected, Dents, CartDents, Scratches, Splatter, Dust, Burns, Marker, Incomplete, FitFinish, LocationOfProblem, Tube, Workstation, InspectedBy, Comments) VALUES (@ProdNo1, @TodaysDate1, @Dents1, @CartDents1, @Scratches1, @Splatter1, @Dust1, @Burns1, @Marker1, @Incomplete1, @FitFinish1, 'Mid', @Tube1, @Workstation1, @InspectedBy1, @Comments1)" ' Mid
        cmd2.CommandText = "Insert into Inspections_Tubes (ProdNo, DateInspected, Dents, CartDents, Scratches, Splatter, Dust, Burns, Marker, Incomplete, FitFinish, LocationOfProblem, Tube, Workstation, InspectedBy, Comments) VALUES (@ProdNo2, @TodaysDate2, @Dents2, @CartDents2, @Scratches2, @Splatter2, @Dust2, @Burns2, @Marker2, @Incomplete2, @FitFinish2, 'Rear', @Tube2, @Workstation2, @InspectedBy2, @Comments2)" ' Rear
        cmd3.CommandText = "Insert into Inspections_Tubes (ProdNo, DateInspected, Dents, CartDents, Scratches, Splatter, Dust, Burns, Marker, Incomplete, FitFinish, LocationOfProblem, Tube, Workstation, InspectedBy, Comments) VALUES (@ProdNo3, @TodaysDate3, @Dents3, @CartDents3, @Scratches3, @Splatter3, @Dust3, @Burns3, @Marker3, @Incomplete3, @FitFinish3, 'End Cap', @Tube3, @Workstation3, @InspectedBy3, @Comments3)" ' End Cap
        cmd4.CommandText = "Insert into Inspections_Tubes (ProdNo, DateInspected, Dents, CartDents, Scratches, Splatter, Dust, Burns, Marker, Incomplete, FitFinish, LocationOfProblem, Tube, Workstation, InspectedBy, Comments) VALUES (@ProdNo4, @TodaysDate4, @Dents4, @CartDents4, @Scratches4, @Splatter4, @Dust4, @Burns4, @Marker4, @Incomplete4, @FitFinish4, 'Nose Cone', @Tube4, @Workstation4, @InspectedBy4, @Comments4)" ' Nose Cone

        conn.open()

        cmd.ExecuteNonQuery()
        cmd1.ExecuteNonQuery()
        cmd2.ExecuteNonQuery()
        cmd3.ExecuteNonQuery()
        cmd4.ExecuteNonQuery()

        conn.close()

        tbProd.Text = ""
        rblTube.SelectedIndex = -1
        ddlWorkstation.SelectedIndex = -1
        lblInspect.Text = ""
        lblBaffle.Text = ""
        lblBrackets.Text = ""
        lblSeamer.Text = ""
        lblAircheck1.Text = ""
        lblRepair1.Text = ""
        lblAircheck2.Text = ""
        lblRepair2.Text = ""
        tbComments.Text = ""

        ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
        'Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")

    End Sub

    Protected Function SetText() As String

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        Dim results As SqlDataReader
        Dim results1 As SqlDataReader

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn

        Dim prod As String = tbProd.Text
        Dim tubetype As String = rblTube.SelectedValue

        cmd.Parameters.AddWithValue("@prodno", prod)
        cmd1.Parameters.AddWithValue("@prodno", prod)


        If tubetype = "PORT" Then
            cmd.CommandText = "Select BafflesPFID as BafflesID, BracketsPID as BracketsID, RoundSeamerPID as SeamerID, AircheckPID as Aircheck1ID, Repair1PID as Repair1ID, Aircheck2PID as Aircheck2ID, Repair2PID as Repair2ID From Tubes where ProdNo =  @prodno"
            cmd1.CommandText = "Select * from OutertubeDetails where ProdNo = @prodno"
        ElseIf tubetype = "STRB" Then
            cmd.CommandText = "Select BafflesSFID as BafflesID, BracketsSID as BracketsID, RoundSeamerSID as SeamerID, AircheckSID as Aircheck1ID, Repair1SID as Repair1ID, Aircheck2SID as Aircheck2ID, Repair2SID as Repair2ID From Tubes where ProdNo =  @prodno"
            cmd1.CommandText = "Select * from OutertubeDetails where ProdNo = @prodno"
        ElseIf tubetype = "CTR" Then
            cmd.CommandText = "Select BafflesCFID as BafflesID, BracketsCID as BracketsID, RoundSeamerCID as SeamerID, AircheckCID as Aircheck1ID, Repair1CID as Repair1ID, Aircheck2CID as Aircheck2ID, Repair2CID as Repair2ID From Tubes where ProdNo =  @prodno"
            cmd1.CommandText = "Select * from CentertubeDetails where ProdNo = @prodno"
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
        results.Close()

        results1 = cmd1.ExecuteReader(CommandBehavior.SingleRow)

        If results1.Read() Then
            If tubetype = "PORT" Or tubetype = "STRB" Then
                lblSplashInst.Text = results1.Item("Splash").ToString
                lblLadderInst.Text = results1.Item("Ladder").ToString
                lblFuelInst.Text = results1.Item("Fuel").ToString
                lblChinesFoils.Text = results1.Item("Strakes").ToString
            ElseIf tubetype = "CTR" Then
                lblStorage.Text = results1.Item("Storage").ToString
                lblFuelInst.Text = results1.Item("Fuel").ToString
                lblChinesFoils.Text = results1.Item("Strakes").ToString
                lblUpsweep.Text = results1.Item("Upsweep_SldTrans").ToString
            End If

        End If
        results1.Close()

        conn.Close()




    End Function

    Protected Sub tbProd_TextChanged(sender As Object, e As EventArgs) Handles tbProd.TextChanged

    End Sub


    Protected Sub rblTube_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rblTube.SelectedIndexChanged
        SetText()
        If ddlWorkstation.SelectedValue = "NotSet" Then
            btnSave.Enabled = False
        Else
            btnSave.Enabled = True
        End If
    End Sub


    Protected Sub ddlWorkstation_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlWorkstation.SelectedIndexChanged
        If ddlWorkstation.SelectedValue = "NotSet" Then
            btnSave.Enabled = False
        Else
            btnSave.Enabled = True
        End If
    End Sub
End Class
