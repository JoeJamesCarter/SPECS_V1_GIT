Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
'Any changes too this that involve Steering need to be made to Helm Kitting Labels too.
Partial Class Workstations_HelmBuildSheet
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Dim lblProdNo As Label
        Dim BoatNotesProdNo As String
        Dim Model As String
        BoatNotesProdNo = Request.QueryString("ProdNo")
        Model = Request.QueryString("Model")
        lblProdNo.Text = BoatNotesProdNo
        lblModel.Text = Model

        Dim bcString As String = "*" & lblProdNo.Text & "_HelmsBuild*"
        lblBarcode.Text = bcString


        Dim conn As New SqlConnection()
        Dim conn1 As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString

        conn.ConnectionString = connstr
        conn1.ConnectionString = connstr1

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn1


        cmd.CommandText = "Select BaseVinylColor From BML_POPREPORTING Where ProdNo = '" & BoatNotesProdNo & "'"
        cmd1.CommandText = "Select CusName From BML_POPREPORTING Where ProdNo = '" & BoatNotesProdNo & "'"
        cmd3.CommandText = "Select SONo from BML_POPREPORTING_GREENLIGHTS Where ProdNo = '" & BoatNotesProdNo & "'"

        conn.Open()

        Dim so As String = cmd3.ExecuteScalar
        cmd4.CommandText = "Select count(item_desc_1) From OEORDLIN_SQL where item_desc_1 Like 'Clad%' and item_desc_1 Not Like '%RECL%' and ord_no = '" & so & "'"


        'PreRig Grid Population
        Dim s As SqlDataSource = CType(FindControl("sdsOEORDLIN"), SqlDataSource)
        Dim t As SqlDataSource = CType(FindControl("sdsOEORDLINEngs"), SqlDataSource)

        Try
            s.SelectParameters(0).DefaultValue = so
            t.SelectParameters(0).DefaultValue = so
        Catch

        End Try




        conn1.Open()
        Dim cladded As Integer = cmd4.ExecuteScalar
        conn1.Close()

        If (Model.IndexOf("A") > 0 And Model.IndexOf("X1") > 0) Or (Model.IndexOf("A") > 0 And Model.IndexOf("X2") > 0) Or cladded > 0 Then
            cbPickup.Checked = True
        End If


        Dim bv As String
        Dim interioraccent As String = ""
        Dim dealer As String
        Dim baseseries As String
        Dim joystick As Boolean = False
        Dim windscreen As Boolean = False
        Dim tenwide As Boolean = False
        Dim spsnot115 As Boolean = False
        Dim powerassist As Boolean = False
        Dim sixyc As Boolean = False '6yc
        Dim twin As Boolean = False


        Dim adapter As New SqlDataAdapter
        Dim faboptionshelmbuild As New DataTable

        adapter.SelectCommand = New SqlCommand("Select Option_Item,Option_Desc,LinePop from BML_POPREPORTINGFABOPTIONS Where ProdNo ='" & BoatNotesProdNo & "'", conn)



        adapter.Fill(faboptionshelmbuild)

        'Get BV from Live Boats for Fiberglass Section
        bv = cmd.ExecuteScalar().ToString
        dealer = cmd1.ExecuteScalar() ' get the first alpha in the Model


        baseseries = RegularExpressions.Regex.Replace(Model, "\d", "").Substring(0, 1)

        'lblModel.Text = baseseries

        'if Sandstone check Platinum
        If bv Like "SANDSTONE*" Then
            'cbPlatinum.Checked = True
            'Not SS or Plat, check the right one
            'ElseIf bv Like "NAPA*" Then
            'cbNapa.Checked = True
            'ElseIf bv Like "DRIFTWOOD*" Then
            '   cbDriftwood.Checked = True
            'ElseIf bv Like "TUSCAN*" Then
            'cbTuscan.Checked = True
            'ElseIf bv Like "GLACIER*" Then
            '   cbGlacier.Checked = True
            'if Platinum check Taupe
        ElseIf bv Like "PLATINUM*" Then
            cbTaupe.Checked = True
            cbShroudEspresso.Checked = True
        ElseIf bv Like "SILVER*" Or bv Like "*SILVER*" Then
            cbSilver.Checked = True
            cbShroudCarbon.Checked = True
        ElseIf bv Like "GRAPHITE*" Then
            cbShroudCarbon.Checked = True
            cbGraphite.Checked = True
        ElseIf bv Like "IVORY*" Then
            cbShroudEspresso.Checked = True
            cbIvory.Checked = True
        End If

        'Look for Arctic Ice White rules further down.

        conn.Close()

        'Series Standards

        If Model Like "*X1*" Or Model Like "*X2*" Then ' if it is a 10 wide it skips all the series defaults
            tenwide = True
            cbPowerAssist.Checked = True
            cbStriker.Checked = True
            cbKickerLighted.Checked = True
            cbRockford.Checked = True
            cbElevatedHelm.Checked = True
            cbBilge.Checked = True
            If baseseries = "Q" Then
                cbSSCorvina.Checked = True
            End If
        ElseIf Model Like "*V*" Then 'SV'
            cbSXPCtrCap.Checked = False
            cbNonTilt.Checked = True
            cbStandard.Checked = True
            cbNoGraph.Checked = True
            cbUltimate.Checked = True
            cbKMC45.Checked = True
            If Model Like "20SFV*" Then ' SV Fishing
                cbLivewell.Checked = True
                cbLivewellCap.Checked = True
            End If
        ElseIf baseseries = "S" Then 'SXP
            If Model Like "*X*" And Model Like "*P*" Then
                cbNonTilt.Checked = True
                cbStandard.Checked = True
                cbSXPCtrCap.Checked = True
                cbNoGraph.Checked = True
                cbUltimate.Checked = True
                cbKMC45.Checked = True
            ElseIf Model Like "*X*" Then ' SX
                cbNonTilt.Checked = True
                cbStandard.Checked = True
                cbSXPCtrCap.Checked = True
                cbNoGraph.Checked = True
                cbUltimate.Checked = True
                cbKMC45.Checked = True
            Else ' S 
                cbNonTilt.Checked = True
                cbStandard.Checked = True
                cbSXPCtrCap.Checked = True
                cbNoGraph.Checked = True
                cbUltimate.Checked = True
                cbKMC45.Checked = True
            End If

        ElseIf baseseries = "L" Then
            If Model Like "*X*" Then 'LX I copied G to start
                cbTilt.Checked = True
                cbNoGraph.Checked = True
                cbKickerLighted.Checked = True
                cbKMC45.Checked = True

            ElseIf Model Like "*T*" Then
                If Model Like "*A" Then 'Arches can't get powertops.
                    cbPowerAssist.Checked = True
                    cbKickerLighted.Checked = True
                    cbKMC45.Checked = True
                Else
                    cbPowerAssist.Checked = True
                    cbPowerTop.Checked = True
                    'cbHandle.Checked = True
                    cbKickerLighted.Checked = True
                    cbKMC45.Checked = True
                End If

            Else
                cbTilt.Checked = True
                cbKickerLighted.Checked = True
                cbKMC45.Checked = True
            End If


        ElseIf baseseries = "G" Then
            cbTilt.Checked = True
            cbNoGraph.Checked = True
            cbKickerLighted.Checked = True
            cbKMC45.Checked = True

        ElseIf baseseries = "R" Then
            If Model Like "*RT*" Then 'RT
                cbPowerAssist.Checked = True
                cbStriker.Checked = True
                cbKickerLighted.Checked = True
                cbRockford.Checked = True
                cbMasterPwrSwitch.Checked = True
                cbRGBSwitches.Checked = True
                'cbHandle.Checked = True
                If Model Like "*A*" Then
                    cbPickup.Checked = True
                    cbPowerTop.Checked = False
                End If
            Else 'R
                cbTilt.Checked = True
                cbStriker.Checked = True
                cbKickerLighted.Checked = True
                cbRockford.Checked = True
                If Model Like "*A*" Then
                    cbPickup.Checked = True
                End If
            End If

        ElseIf baseseries Like "Q" Then 'Q and QX are the same for Joe
            cbTilt.Checked = True
            cbStriker.Checked = True
            cbSSCorvina.Checked = True
            cbKickerLighted.Checked = True
            cbRockford.Checked = True
            If Model Like "*A*" Then
                cbPickup.Checked = True
            End If

            If Model Like "QXSPORT" Then
                cbTilt.Checked = True
                cbStriker.Checked = True
                cbSSCorvina.Checked = True
                cbKickerLighted.Checked = True
                cbRockford.Checked = True
                cbBilge.Checked = True
                cbPickup.Checked = True
            End If

        End If


        'Other Options to Account For

        If Model Like "*TIO*" Or Model Like "*WWT*" Then ' tower models
            cbRoswell.Checked = True
        End If

        If Model Like "*WW*" Or Model Like "*SBW*" Or Model Like "*FBW*" Or Model Like "*RSRW*" Then ' windscreen models
            windscreen = True
        End If

        If Model Like "*TD*" Then ' top deck models
            cbPowerTop.Checked = False
        End If



        'Loop Options
        If faboptionshelmbuild.Rows.Count > 0 Then

            For Each row As DataRow In faboptionshelmbuild.Rows
                'Look for Joystick'
                If row("Option_Desc") Like "*JOYSTICK*" Then
                    joystick = True

                ElseIf row("Option_Desc") Like "SPS*" Then
                    If row("Option_Desc") Like "SPS115*" Then
                        spsnot115 = False
                        cbSeaStarHyd.Checked = True
                    Else
                        spsnot115 = True
                    End If
                    'lblModel.text = spsnot115

                    ' Speedo test had to be moved up to work
                ElseIf row("Option_Item") Like "*904357*" Or row("Option_Desc") Like "*SPEEDO*" Or row("Option_Desc") Like "SPEEDO*" Then
                    cbSpeedo.Checked = True

                ElseIf row("Option_Desc") Like "SWITCH MASTER POWER*" Or row("Option_Item") Like "*901173*" Then
                    cbMasterPwrSwitch.Checked = True
                    'Pre-Rig Tests

                ElseIf row("Option_Desc") Like "*VERADO*PPR*" Or row("Option_Item") Like "903489*" Then
                    '   cbVerado.Checked = True
                    cbVeradoSteering.Checked = True 'steering required with this prerig
                    cbTilt.Checked = False
                ElseIf row("Option_Desc") Like "*VERADO*" Then
                    '   cbVerado.Checked = True
                    cbVeradoSteering.Checked = True 'steering required with this prerig
                    cbTilt.Checked = False

                ElseIf row("Option_Desc") Like "BIG BLOCK UPGRADE*" Then
                    lblOtherPrerigValue.Text = "BIG BLOCK UPGRADE"

                ElseIf row("Option_Item") Like "902106*" Or row("Option_Item") Like "902210*" Or row("Option_Item") Like "902211*" Or row("Option_Item") Like "902212*" Then
                    'lblOtherPrerigValue.Text = "BRP DIGITAL ICON TOUCH, X2"
                    cbSeaStarHyd.Checked = True
                    cbPowerAssist.Checked = False
                    cbTilt.Checked = False
                    cbNonTilt.Checked = False

                ElseIf row("Option_Item") Like "*TORQ40NB*" Then
                    lblOtherPrerigValue.Text = "TORQ40NB"

                ElseIf row("Option_Desc") Like "*YAMAHA 6YC INFO STATION, X2*" Or row("Option_Item") Like "902100*" Then

                    sixyc = True

                ElseIf row("Option_Item") Like "902126*" Then

                    cbSeaStarHyd.Checked = True

                ElseIf row("Option_Item") Like "902204*" Or row("Option_Item") Like "902207*" Then

                    cbVeradoSteering.Checked = True

                ElseIf row("Option_Desc") Like "*MERC IO SMARTCRAFT MAN SD MT*" Then

                    cbVeradoSteering.Checked = True

                ElseIf row("Option_Desc") Like "*MERC R/Q I/O SMARTCRAFT MAN PR*" Then

                    cbVeradoSteering.Checked = True

                ElseIf row("Option_Desc") Like "*MERC VSL VIEW 7 200-350 SD MT*" Then

                    cbVeradoSteering.Checked = True 'steering required with this prerig
                    cbTilt.Checked = False
                    cbNonTilt.Checked = False
                    cbSeaStarHyd.Checked = False
                    cbPowerAssist.Checked = False

                ElseIf row("Option_Desc") Like "*MERCURY DGTL JSTK VSL VW, X2*" Then
                    cbVeradoSteering.Checked = True
                    cbTilt.Checked = False
                    cbNonTilt.Checked = False
                    cbSeaStarHyd.Checked = False
                    cbPowerAssist.Checked = False

                ElseIf row("Option_Desc") Like "*MERCURY DGTL VESSEL VIEW 7, X2*" Then
                    cbVeradoSteering.Checked = True 'steering required with this prerig
                    cbTilt.Checked = False
                    cbNonTilt.Checked = False
                    cbSeaStarHyd.Checked = False

                ElseIf row("Option_Item") Like "903316*" Then
                    cbVeradoSteering.Checked = True 'steering required with this prerig
                    cbTilt.Checked = False
                    cbNonTilt.Checked = False
                    cbSeaStarHyd.Checked = False

                ElseIf row("Option_Desc") Like "*MERCURY I/O PRE RIG*" Then
                    cbVeradoSteering.Checked = True

                ElseIf row("Option_Desc") Like "*MERCURY I/O SIDE MOUNT PRE RIG*" Then
                    cbVeradoSteering.Checked = True

                ElseIf row("Option_Desc") Like "*MERCURY R/Q I/O DTS PRE RIG*" Or row("Option_Item") Like "910423*" Then
                    'lblOtherPrerigValue.Text = "MERCURY R/Q I/O DTS"
                    cbVeradoSteering.Checked = True

                ElseIf row("Option_Desc") Like "*MERCURY R/Q I/O DTS SIDE MOUNT*" Then
                    'lblOtherPrerigValue.Text = "MERCURY R/Q I/O DTS SIDE MOUNT"
                    cbVeradoSteering.Checked = True

                ElseIf row("Option_Desc") Like "*MERCURY SW HYBRID PKG PRE-RIG*" Then
                    lblOtherPrerigValue.Text = "MERCURY SW HYBRID"

                ElseIf row("Option_Desc") Like "*MERCURY VESSEL VIEW 200-350*" Then
                    'lblOtherPrerigValue.Text = "MERCURY VESSEL VIEW 200-350"
                    cbVeradoSteering.Checked = True 'steering required with this prerig
                    cbTilt.Checked = False
                    cbNonTilt.Checked = False
                    cbSeaStarHyd.Checked = False

                ElseIf row("Option_Item") Like "*MINNKOTA*" Then
                    lblOtherPrerigValue.Text = "MINN KOTA 2HP 48V NO BATTERY"

                ElseIf Trim(row("Option_Item")) Like "902054*" Or row("Option_Desc") Like "VOLVO EVC I/O PRE*" Then
                    cbSeaStarHyd.Checked = True
                ElseIf Trim(row("Option_Item")) Like "902008*" Or Trim(row("Option_Item")) Like "902210*" Then
                    cbSeaStarHyd.Checked = True
                ElseIf row("Option_Item") Like "902071*" Then
                    cbSeaStarHyd.Checked = True
                ElseIf row("Option_Item") Like "902101*" Then
                    joystick = True

                    'Steering Tests
                ElseIf row("Option_Item") Like "902133*" Then
                    lblOtherSteeringValue.Text = "BRP DGTL IDOCK JSTK ICON, X2"

                ElseIf row("Option_Desc") Like "TILT STEERING EXC*" And cbSeaStarHyd.Checked = False Then
                    cbTilt.Checked = True
                    cbNonTilt.Checked = False

                ElseIf row("Option_Desc") Like "DEL NON-TILT HELM ADD SEA STAR*" Or row("Option_Desc") Like "DEL TILT HELM ADD SEA STAR*" Or row("Option_Item") Like "*999030*" Then
                    cbSeaStarHyd.Checked = True
                    cbNonTilt.Checked = False
                    cbTilt.Checked = False
                ElseIf row("Option_Desc") Like "POWER ASSIST STEERING*" Or row("Option_Item") Like "900438*" Then
                    powerassist = True
                    cbSeaStarHyd.Checked = False
                    cbPowerAssist.Checked = True
                    cbTilt.Checked = False
                    cbNonTilt.Checked = False

                ElseIf row("Option_Desc") Like "DEALER WAIVED POWER ASSIST*" Or row("Option_Desc") Like "*BRP*G2 ICON PRO*" Or row("Option_Desc") Like "*VOLVO I/O PRE RIG*" Or row("Option_Desc") Like "*SPS PLUS*" Then 'just to make sure
                    cbPowerAssist.Checked = False
                    cbSeaStarHyd.Checked = True
                    cbNonTilt.Checked = False
                    cbTilt.Checked = False

                ElseIf row("Option_Item") Like "*902131*" Or row("Option_Item") Like "*903361*" Then 'just to make sure
                    cbPowerAssist.Checked = False
                    cbSeaStarHyd.Checked = True
                    cbNonTilt.Checked = False
                    cbTilt.Checked = False

                ElseIf row("Option_Item") Like "*902076*" Or row("Option_Desc") Like "*YAMAHA DIGITAL EPS*" Then
                    lblOtherSteeringValue.Text = "YAMAHA DIG EPS PRE RIG X2"
                    cbPowerAssist.Checked = False
                    cbTilt.Checked = False

                    ''Any changes too this that involve Steering need to be made to Helm Kitting Labels too.
                    'Steering Wheel Tests
                ElseIf row("Option_Desc") Like "SS CORVINA*" Or row("Option_Desc") Like "*CORVINA*" Or row("Option_Desc") Like "*WHL CORV*" Then 'just to make sure
                    cbSSCorvina.Checked = True
                    cbStandard.Checked = False
                    cbGlossBlack.Checked = False

                ElseIf row("Option_Desc") Like "WHEEL UPGD GLOSS BLACK*" Then 'just to make sure
                    cbGlossBlack.Checked = True
                    cbStandard.Checked = False

                ElseIf row("Option_Desc") Like "*STEERING WH*L ZBRWD*BEIGE*" Or row("Option_Item") Like "903217*" Or row("Option_Item") Like "903220*" Then 'option set                    
                    cbZWoodBeige.Checked = True
                    cbStandard.Checked = False

                ElseIf row("Option_Desc") Like "*STEERING WHEEL BLACK*" Then 'option set                    
                    cbGlossBlack.Checked = True
                    cbStandard.Checked = False

                    'GPS/GRAPH TESTS
                ElseIf row("Option_Desc") Like "*STRIKER*" Then
                    cbStriker.Checked = True
                    cbNoGraph.Checked = False
                    cbSimrad.Checked = False
                    If row("Option_Desc") Like "*SWITCH*STRIKER*" Or row("Option_Item") Like "906334*" Or row("Option_Item") Like "905676*" Or row("Option_Item") Like "*901209*" Then
                        cbRGBSwitches.Checked = True
                    End If

                    If row("Option_Item") Like "*910428*" Then
                        cbStriker.Checked = False
                        cbNoGraph.Checked = True
                        TextBox1.Text = row("Option_Desc")
                    End If


                ElseIf row("Option_Desc") Like "*NO GRAPH w/SWIT*" Then
                    cbStriker.Checked = False
                    cbNoGraph.Checked = True
                    cbSimrad.Checked = False
                    cbRGBSwitches.Checked = True

                ElseIf row("Option_Desc") Like "*SIMRAD*" Then 'just to make sure
                    cbSimrad.Checked = True
                    cbNoGraph.Checked = False
                    cbStriker.Checked = False
                    If row("Option_Desc") Like "*SWITCH*SIMRAD*" Or row("Option_Desc") Like "*PANEL*SIMRAD*" Then
                        cbRGBSwitches.Checked = True
                        cbSimrad.Checked = True
                    End If

                ElseIf row("Option_Item") Like "*901163*" Then 'just to make sure
                    cbSimrad.Checked = True
                    cbNoGraph.Checked = False
                    cbStriker.Checked = False
                    lblOtherGraphValue.Text = "GPS, SIMRAD GO7, G SERIES"


                ElseIf row("Option_Item") Like "*903448*" Then 'just to make sure
                    cbSimrad.Checked = True
                    cbNoGraph.Checked = False
                    cbStriker.Checked = False
                    lblOtherGraphValue.Text = "GPS GARMIN 742 2ND DISPLAY CC"

                ElseIf row("Option_Item") Like "*903449*" Then 'just to make sure
                    cbSimrad.Checked = True
                    cbNoGraph.Checked = False
                    cbStriker.Checked = False
                    lblOtherGraphValue.Text = "GPS GARMIN 942 2ND DISPLAY CC"

                ElseIf row("Option_Desc") Like "*TRIM ACCENT ZEBRAWOOD SLATE*" Or row("Option_Item") Like "902440*" Or row("Option_Item") Like "901175*" Then 'just to make sure
                    cbZWDSlateTrim.Checked = True
                    If baseseries = "L" Or baseseries = "R" Then 'match the steering wheel to the trim
                        cbGlossBlack.Checked = True
                    End If
                    If row("Option_Item") Like "901175*" Then
                        cbRGBSwitches.Checked = True
                    End If

                ElseIf row("Option_Desc") Like "*TRIM ACCENT ZEBRAWOOD BEIGE*" Then 'just to make sure
                    cbZWDBeigeTrim.Checked = True
                    If baseseries = "L" Or baseseries = "R" Or row("Option_Desc") Like "*STEERING WHL ZBRWD BEIGE*" Then 'match the steering wheel to the trim
                        cbZWoodBeige.Checked = True
                    End If

                    'Speaker Tests
                ElseIf row("Option_Desc") Like "*ROSWELL*" Then 'just to make sure
                    cbRoswell.Checked = True
                    cbUltimate.Checked = False
                    cbKicker.Checked = False
                    cbKickerLighted.Checked = False
                    If row("Option_Item") Like "901113*" Then
                        cbRockford.Checked = True
                    End If

                ElseIf row("Option_Desc") Like "*KICKER SP* LIGHTED*" Or row("Option_Desc") Like "*SWINGBACK LIGHT SPKR*" Or row("Option_Desc") Like "*FASTBACK LIGHTED SPKR*" Or row("Option_Desc") Like "*BLUE LIGHTED SPK UPG*" Or row("Option_Item") Like "901215*" Or row("Option_Item") Like "901214*" Or row("Option_Item") Like "901106*" Then 'just to make sure
                    cbKickerLighted.Checked = True
                    cbKicker.Checked = False
                    cbUltimate.Checked = False
                ElseIf row("Option_Desc") Like "*KICKER SUB/AMP*" Or row("Option_Desc") Like "*KICKER AMP/SUB*" Or row("Option_Desc") Like "KICKER SPEAKER UPG*" Or row("Option_Desc") Like "*ARCH KICKER SPKR*" Or row("Option_Item") Like "901106*" Then 'just to make sure
                    cbKicker.Checked = True
                    cbKickerLighted.Checked = False
                    cbUltimate.Checked = False

                    'Radio Tests
                ElseIf row("Option_Desc") Like "KMC10*" Or row("Option_Item") Like "901139*" Or row("Option_Item") Like "901150*" Or row("Option_Item") Like "901151*" Or row("Option_Item") Like "901202*" Then
                    cbRockford.Checked = True
                    cbKMC45.Checked = False
                ElseIf row("Option_Desc") Like "KMC20*" Or row("Option_Item") Like "901187*" Then
                    cbRockford.Checked = True
                    cbKMC45.Checked = False
                ElseIf row("Option_Item") Like "901197*" Then
                    cbSatOrSirusUpg.Checked = True
                    cbRockford.Checked = True
                    cbKMC45.Checked = False
                ElseIf row("Option_Item") Like "903390*" Or row("Option_Item") Like "903391*" Or row("Option_Item") Like "901113*" Then
                    cbSatOrSirusUpg.Checked = False
                    cbKMC45.Checked = False
                    cbRockford.Checked = True
                    cbSatOrSirusUpg.Checked = False
                ElseIf row("Option_Item") Like "903392*" Or row("Option_Item") Like "903393*" Or row("Option_Item") Like "903394*" Then
                    cbSatOrSirusUpg.Checked = True
                    cbKMC45.Checked = False
                    cbRockford.Checked = True

                    'Misc Tests
                ElseIf row("Option_Desc") Like "*POWER TOP*" Or row("Option_Desc") Like "*PWR TOP*" Then
                    cbPowerTop.Checked = True
                    'ElseIf row("Option_Item") Like "903443*" Then 'Elv Helm w Door G ' turned off for MY 2022
                    '   cbElvHelmwDoor.Checked = True
                    '  cbElevatedHelm.Checked = False
                ElseIf row("Option_Desc") Like "*ELEVATED HELM*" Or row("Option_Desc") Like "*ELEVATED CHAISE*" Then
                    cbElevatedHelm.Checked = True
                ElseIf row("Option_Desc") Like "*SINK*" Or (Model Like "*SLX3*") Then
                    cbSink.Checked = True
                ElseIf row("Option_Desc") Like "*LIVEWELL*" Then
                    cbLivewell.Checked = True
                    cbLivewellCap.Checked = True
                ElseIf row("Option_Desc") Like "*WASHDOWN*" Or row("Option_Desc") Like "*WSHDWN*" Then
                    cbWashdown.Checked = True
                ElseIf row("Option_Desc") Like "*CUPHOLDER REFRI*" Then
                    cbRefrigCups.Checked = True

                ElseIf row("Option_Desc") Like "*SPEEDO*" Or row("Option_Item") Like "904357*" Then
                    cbSpeedo.Checked = True
                ElseIf row("Option_Desc") Like "*LIGHTING SWITCH P*" Or row("Option_Item") Like "901107*" Then 'Toe Kick Lighting
                    cbRGBSwitches.Checked = True
                ElseIf row("Option_Item") Like "901144*" Or row("Option_Item") Like "901159*" Or row("Option_Item") Like "901158*" Or row("Option_Item") Like "901160*" Or row("Option_Item") Like "901162*" Or row("Option_Item") Like "901174*" Or row("Option_Item") Like "901190*" Or row("Option_Item") Like "901191*" Or row("Option_Item") Like "901192*" Or row("Option_Item") Like "901193*" Or row("Option_Item") Like "901194*" Or row("Option_Item") Like "901195*" Or row("Option_Item") Like "901196*" Or row("Option_Item") Like "901209*" Or row("Option_Desc") Like "*EXTERIOR SIDE LIGHT*" Or row("Option_Desc") Like "*EXTERIOR SIDE LGHTS*" Or row("Option_Desc") Like "*Underwater Light*" Then 'G Panel analog w rgb
                    cbRGBSwitches.Checked = True
                ElseIf row("Option_Item") Like "901208*" Then 'Blue Int Lights
                    cbRGBSwitches.Checked = False
                ElseIf row("Option_Item") Like "901210*" Or row("Option_Item") Like "901211*" Or row("Option_Item") Like "901212*" Then 'RGB Gauge Panels
                    cbRGBSwitches.Checked = True
                ElseIf row("Option_Desc") Like "*28 GALLON FUEL TANK*" Then
                    cbFuelTank.Checked = True
                    'ElseIf row("Option_Item") Like "903425*" Then 'Bowrider Console Grab Handle
                    'cbHandle.Checked = True

                ElseIf row("LinePop") Like "*_IntAccent" Then
                    interioraccent = row("option_desc")

                    'Dash Panel Caps
                ElseIf row("Option_Desc") Like "*UNDERWATER*" Then
                    cbUnderWaterLights.Checked = True

                ElseIf row("Option_Desc") Like "*EXTERIOR SIDE*" Then
                    cbExtSideLights.Checked = True

                    'ElseIf row("Option_Item") Like "903431*" Or row("Option_Item") Like "903432*" Then
                    'cbMercActiveTrim.Checked = True

                    'ElseIf row("Option_Item") Like "903442*" Then
                    '    cbGChaiseConsole.Checked = True

                    'ElseIf row("Option_Item") Like "903436*" Then
                    '    cbMercZero.Checked = True

                ElseIf row("Option_Item") Like "901047*" Then
                    cbRockfordAmp.Checked = True

                ElseIf row("Option_Item") Like "901106*" Then
                    cbKickerAmp.Checked = True

                ElseIf row("Option_Item") Like "901106*" Then
                    cbKickerAmp.Checked = True

                ElseIf row("Option_Desc") Like "GLOVE BOX*" Then
                    cbGloveBox.Checked = True

                ElseIf row("Option_Desc") Like "CUPHOLDER W/ POCK*" Then
                    cbCupPocket.Checked = True

                ElseIf row("Option_Desc") Like "WINDSHIELD, GLASS*" Then
                    cbGlassWS.Checked = True
                End If

            Next row
        End If

        'SXP and G without RGB need a dash cap for Docking lights. Boats with RGB will have this cap on the rgb panel instead of the dash panel. Joe's team still needs to see RGB.
        If baseseries = "S" Then 'SXP
            If Model Like "*X*" And Model Like "*P*" Then
                If cbRGBSwitches.Checked = False Then
                    cbDocking.Checked = True
                End If
            End If
        End If

        If baseseries = "G" Then
            'If cbRGBSwitches.Checked = False Then
            cbDocking.Checked = True
            'End If
        End If
        'Livewlls standards in F but not FB, SS but not SSB, SCC.
        If Model Like "*F*" Then
            If Model Like "*FB*" Then

            Else
                cbLivewellCap.Checked = True
                cbLivewell.Checked = True
            End If
        End If


        If Model Like "*SS*" Then
            If Model Like "*SSB*" Then

            Else
                cbLivewellCap.Checked = True
                cbLivewell.Checked = True
            End If
        End If


        If Model Like "*SCC*" Then
            cbLivewellCap.Checked = True
            cbLivewell.Checked = True
        End If

        If Model Like "*IO*" Then
            cbBilge.Checked = True
        End If


        'Pickup for some local dealers
        If dealer Like "*HUBER*" Or dealer Like "*WYLAND*" Or dealer Like "*MAIN CHANNEL*" Or dealer Like "*KOOPER*" Or dealer Like "*TWIN LAKES MARINA*" Then
            cbPickup.Checked = True
        End If

        'Simrad standard on ten wides with windscreens and joysticks
        If tenwide = True And windscreen = True And joystick = True Then
            cbSimrad.Checked = True
            cbStriker.Checked = False
            cbNoGraph.Checked = False
        End If

        If cbSimrad.Checked = False And cbStriker.Checked = False Then
            cbNoGraph.Checked = True
        End If

        'SPS, SPS Plus get Sea Star Hyd, 115 does not.
        If spsnot115 = True Then
            cbSeaStarHyd.Checked = True
            cbTilt.Checked = False
            cbNonTilt.Checked = False
            cbTilt.Checked = False

        End If

        If powerassist = True Then
            cbSeaStarHyd.Checked = False
            cbPowerAssist.Checked = True
            cbTilt.Checked = False
            cbNonTilt.Checked = False

        End If


        If cbVeradoSteering.Checked = True Then
            cbTilt.Checked = False
            cbNonTilt.Checked = False
            cbSeaStarHyd.Checked = False
        End If

        If cbSeaStarHyd.Checked = True Then
            cbTilt.Checked = False
            cbNonTilt.Checked = False
            cbVeradoSteering.Checked = False
        End If

        If cbTilt.Checked = True Then
            cbSeaStarHyd.Checked = False
            cbNonTilt.Checked = False
            cbVeradoSteering.Checked = False
        End If

        If cbNonTilt.Checked = True Then
            cbSeaStarHyd.Checked = False
            cbTilt.Checked = False
            cbVeradoSteering.Checked = False
        End If

        If Model Like "*X2*" And sixyc = True And joystick = True Then
            lblOtherPrerigValue.Text = "YAMAHA 6YC INFO STATION, X2"
            lblOtherSteeringValue.Text = "YAMAHA OPTIMUS 360 JSTK, X2"
            cbPowerAssist.Checked = False
        End If

        If Len(lblOtherPrerigValue.Text) > 0 Then
            lblOtherPrerigValue.BackColor = Drawing.Color.Yellow
        End If

        If Len(lblOtherSteeringValue.Text) > 0 Then
            lblOtherSteeringValue.BackColor = Drawing.Color.Yellow
        End If

        If bv Like "*ICE*" Then
            cbIceWhite.Checked = True
            cbShroudCarbon.Checked = True
            If interioraccent Like "*Firecracker*" Or interioraccent Like "*ESPRESSO*" Then
                cbShroudEspresso.Checked = True
            Else
                cbShroudCarbon.Checked = True
            End If
        End If

    End Sub
End Class
