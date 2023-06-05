Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Tubes_TubeRerun
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

        If Not IsPostBack Then
            Dim RerunProdNo As String

            RerunProdNo = Request.QueryString("ProdNo")
            lblProdNo.Text = RerunProdNo

            MultiView1.ActiveViewIndex = -1

            HideTubes()
            HideSections()

        End If
    End Sub


    Protected Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")


    End Sub

    Protected Sub ddlPort_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlPort.SelectedIndexChanged
        If ddlPort.SelectedValue = "Other" Then
            lblPortOther.Visible = True
            tbPortOther.Visible = True
            lblPortUsedFor.Visible = False
            tbPortUsedFor.Visible = False
            lblPortWrong.Visible = False
            tbPortWrong.Visible = False
        ElseIf ddlPort.SelectedValue = "Used for Another Boat" Then
            lblPortUsedFor.Visible = True
            tbPortUsedFor.Visible = True
            lblPortOther.Visible = False
            tbPortOther.Visible = False
            lblPortWrong.Visible = False
            tbPortWrong.Visible = False
        ElseIf ddlPort.SelectedValue = "Built Wrong/Could Be Reused" Or ddlPort.SelectedValue = "Built Wrong/Unusable" Or ddlPort.SelectedValue = "Damaged After Leaving North" Or ddlPort.SelectedValue = "Damaged/Scrap" Then
            lblPortWrong.Visible = True
            tbPortWrong.Visible = True
            lblPortUsedFor.Visible = False
            tbPortUsedFor.Visible = False
            lblPortOther.Visible = False
            tbPortOther.Visible = False
            cbUseForBoth.Visible = True
        Else
            lblPortUsedFor.Visible = False
            tbPortUsedFor.Visible = False
            lblPortOther.Visible = False
            tbPortOther.Visible = False
            lblPortWrong.Visible = False
            tbPortWrong.Visible = False
            cbUseForBoth.Visible = False
        End If
    End Sub

    Protected Sub ddlStrb_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlStrb.SelectedIndexChanged
        If ddlStrb.SelectedValue = "Other" Then
            lblStrbOther.Visible = True
            tbStrbOther.Visible = True
            lblStrbUsedFor.Visible = False
            tbStrbUsedFor.Visible = False
            tbStrbWrong.Visible = False
            lblStrbWrong.Visible = False
        ElseIf ddlStrb.SelectedValue = "Used for Another Boat" Then
            lblStrbUsedFor.Visible = True
            tbStrbUsedFor.Visible = True
            lblStrbOther.Visible = False
            tbStrbOther.Visible = False
            lblStrbWrong.Visible = False
            tbStrbWrong.Visible = False
        ElseIf ddlStrb.SelectedValue = "Built Wrong/Could Be Reused" Or ddlStrb.SelectedValue = "Built Wrong/Unusable" Or ddlStrb.SelectedValue = "Damaged After Leaving North" Or ddlStrb.SelectedValue = "Damaged/Scrap" Then
            lblStrbWrong.Visible = True
            tbStrbWrong.Visible = True
            lblStrbUsedFor.Visible = False
            tbStrbUsedFor.Visible = False
            lblStrbOther.Visible = False
            tbStrbOther.Visible = False
            cbUseForBoth.Visible = True
        Else
            lblStrbUsedFor.Visible = False
            tbStrbUsedFor.Visible = False
            lblStrbOther.Visible = False
            tbStrbOther.Visible = False
            lblStrbWrong.Visible = False
            tbStrbWrong.Visible = False
            cbUseForBoth.Visible = False
        End If
    End Sub

    Protected Sub ddlCtr_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCtr.SelectedIndexChanged
        If ddlCtr.SelectedValue = "Other" Then
            lblCtrOther.Visible = True
            tbCtrOther.Visible = True
            lblCtrUsedFor.Visible = False
            tbCtrUsedFor.Visible = False
            lblCtrWrong.Visible = False
            tbCtrWrong.Visible = False
        ElseIf ddlCtr.SelectedValue = "Used for Another Boat" Then
            lblCtrUsedFor.Visible = True
            tbCtrUsedFor.Visible = True
            lblCtrOther.Visible = False
            tbCtrOther.Visible = False
            lblCtrWrong.Visible = False
            tbCtrWrong.Visible = False
        ElseIf ddlCtr.SelectedValue = "Built Wrong/Could Be Reused" Or ddlCtr.SelectedValue = "Built Wrong/Unusable" Or ddlCtr.SelectedValue = "Damaged After Leaving North" Or ddlCtr.SelectedValue = "Damaged/Scrap" Then
            lblCtrWrong.Visible = True
            tbCtrWrong.Visible = True
            lblCtrUsedFor.Visible = False
            tbCtrUsedFor.Visible = False
            lblCtrOther.Visible = False
            tbCtrOther.Visible = False
            cbUseForBoth.Visible = True
        Else
            lblCtrUsedFor.Visible = False
            tbCtrUsedFor.Visible = False
            lblCtrOther.Visible = False
            tbCtrOther.Visible = False
            lblCtrWrong.Visible = False
            tbCtrWrong.Visible = False
            cbUseForBoth.Visible = False

        End If
    End Sub

    Protected Sub rblWhichTubes_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rblWhichTubes.SelectedIndexChanged
        lblTubeRerunReasons.Visible = True
        If rblWhichTubes.SelectedValue = "Port" Then
            ddlPort.Visible = True
            lblPort.Visible = True
            ddlStrb.Visible = False
            lblStrb.Visible = False
            ddlCtr.Visible = False
            lblCtr.Visible = False
            lblStrbOther.Visible = False
            tbStrbOther.Visible = False
            lblCtrOther.Visible = False
            tbCtrOther.Visible = False
        ElseIf rblWhichTubes.SelectedValue = "Starboard" Then
            ddlStrb.Visible = True
            lblStrb.Visible = True
            ddlPort.Visible = False
            lblPort.Visible = False
            ddlCtr.Visible = False
            lblCtr.Visible = False
            lblPortOther.Visible = False
            tbPortOther.Visible = False
            lblCtrOther.Visible = False
            tbCtrOther.Visible = False
        ElseIf rblWhichTubes.SelectedValue = "Both" Then
            ddlPort.Visible = True
            ddlStrb.Visible = True
            lblPort.Visible = True
            lblStrb.Visible = True
            ddlCtr.Visible = False
            lblCtr.Visible = False
        ElseIf rblWhichTubes.SelectedValue = "Center" Then
            ddlCtr.Visible = True
            lblCtr.Visible = True
            ddlPort.Visible = False
            lblPort.Visible = False
            ddlStrb.Visible = False
            lblStrb.Visible = False
            lblPortOther.Visible = False
            tbPortOther.Visible = False
            lblStrbOther.Visible = False
            tbStrbOther.Visible = False
        ElseIf rblWhichTubes.SelectedValue = "All" Then
            ddlPort.Visible = True
            ddlStrb.Visible = True
            ddlCtr.Visible = True
            lblPort.Visible = True
            lblStrb.Visible = True
            lblCtr.Visible = True
        End If
    End Sub

    Protected Sub rblType_SelectedIndexChanged(sender As Object, e As EventArgs) Handles rblType.SelectedIndexChanged
        If rblType.SelectedValue = "Tube" Then
            MultiView1.ActiveViewIndex = 0
            ShowTubes()
            HideSections()
        ElseIf rblType.SelectedValue = "Section" Then
            MultiView1.ActiveViewIndex = 1
            ShowSections()
            HideTubes()
        End If
    End Sub

    Protected Function HideTubes()
        rblWhichTubes.Visible = False
        lblTubes.Visible = False
        rblWhichTubes.SelectedIndex = -1
        lblPort.Visible = False
        lblStrb.Visible = False
        lblCtr.Visible = False
        ddlPort.Visible = False
        ddlStrb.Visible = False
        ddlCtr.Visible = False
        lblPortOther.Visible = False
        tbPortOther.Visible = False
        lblStrbOther.Visible = False
        tbStrbOther.Visible = False
        lblCtrOther.Visible = False
        tbCtrOther.Visible = False
        tbStrbOther.Visible = False
        tbCtrOther.Visible = False
        rblWhichTubes.Visible = False
        lblTubeRerunReasons.Visible = False
        lblTubes.Visible = False
        cbUseForBoth.Visible = False
        lblPortUsedFor.Visible = False
        lblStrbUsedFor.Visible = False
        lblCtrUsedFor.Visible = False
        tbPortUsedFor.Visible = False
        tbStrbUsedFor.Visible = False
        tbCtrUsedFor.Visible = False
        lblPortWrong.Visible = False
        tbPortWrong.Visible = False
        lblStrbWrong.Visible = False
        tbStrbWrong.Visible = False
        lblCtrWrong.Visible = False
        tbCtrWrong.Visible = False

    End Function


    Protected Function HideSections()
        cblSections.Visible = False
        lblSections.Visible = False
        lblSectionRerunReasons.Visible = False
        cblSections.SelectedIndex = -1
        lblPF.Visible = False
        ddlPF.Visible = False
        lblPM.Visible = False
        ddlPM.Visible = False
        lblPM2.Visible = False
        ddlPM2.Visible = False
        lblPR.Visible = False
        ddlPR.Visible = False

        lblSF.Visible = False
        ddlSF.Visible = False
        lblSM.Visible = False
        ddlSM.Visible = False
        lblSM2.Visible = False
        ddlSM2.Visible = False
        lblSR.Visible = False
        ddlSR.Visible = False

        lblCF.Visible = False
        ddlCF.Visible = False
        lblCM.Visible = False
        ddlCM.Visible = False
        lblCM2.Visible = False
        ddlCM2.Visible = False
        lblCR.Visible = False
        ddlCR.Visible = False

        lblSectionNotesIfOther.Visible = False

        lblPFSectionOther.Visible = False
        lblPMSectionOther.Visible = False
        lblPM2SectionOther.Visible = False
        lblPRSectionOther.Visible = False

        lblSFSectionOther.Visible = False
        lblSMSectionOther.Visible = False
        lblSM2SectionOther.Visible = False
        lblSRSectionOther.Visible = False

        lblCFSectionOther.Visible = False
        lblCMSectionOther.Visible = False
        lblCM2SectionOther.Visible = False
        lblCRSectionOther.Visible = False

        tbPFSectionOther.Visible = False
        tbPMSectionOther.Visible = False
        tbPM2SectionOther.Visible = False
        tbPRSectionOther.Visible = False

        tbSFSectionOther.Visible = False
        tbSMSectionOther.Visible = False
        tbSM2SectionOther.Visible = False
        tbSRSectionOther.Visible = False

        tbCFSectionOther.Visible = False
        tbCMSectionOther.Visible = False
        tbCM2SectionOther.Visible = False
        tbCRSectionOther.Visible = False



    End Function

    Protected Function ShowTubes()
        rblWhichTubes.Visible = True
        lblTubes.Visible = True
        'rblWhichTubes.SelectedIndex = -1
        'lblPort.Visible = True
        'lblStrb.Visible = True
        'lblCtr.Visible = True
        'ddlPort.Visible = True
        'ddlStrb.Visible = True
        'ddlCtr.Visible = True
        'lblPortOther.Visible = True
        'tbPortOther.Visible = True
        'lblStrbOther.Visible = True
        'tbStrbOther.Visible = True
        'lblCtrOther.Visible = True
        'tbCtrOther.Visible = True
        'tbStrbOther.Visible = True
        'tbCtrOther.Visible = True
        'rblWhichTubes.Visible = True
        'cblSections.Visible = True
        'lblTubeRerunReasons.Visible = True
        'lblSectionRerunReasons.Visible = True
        'lblTubes.Visible = True
        'lblSections.Visible = True
        'cbUseForBoth.Visible = True
    End Function


    Protected Function ShowSections()
        cblSections.Visible = True
        lblSections.Visible = True
        lblSectionRerunReasons.Visible = True
        'lblSectionRerunReasons.Visible = True

        'lblPF.Visible = True
        'ddlPF.Visible = True
        'lblPM.Visible = True
        'ddlPM.Visible = True
        'lblPM2.Visible = True
        'ddlPM2.Visible = True
        'lblPR.Visible = True
        'ddlPR.Visible = True

        'lblSF.Visible = True
        'ddlSF.Visible = True
        'lblSM.Visible = True
        'ddlSM.Visible = True
        'lblSM2.Visible = True
        'ddlSM2.Visible = True
        'lblSR.Visible = True
        'ddlSR.Visible = True

        'lblCF.Visible = True
        'ddlCF.Visible = True
        'lblCM.Visible = True
        'ddlCM.Visible = True
        'lblCM2.Visible = True
        'ddlCM2.Visible = True
        'lblCR.Visible = True
        'ddlCR.Visible = True

    End Function

    Protected Sub cblSections_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cblSections.SelectedIndexChanged


        lblPF.Visible = False
        ddlPF.Visible = False
        lblPM.Visible = False
        ddlPM.Visible = False
        lblPM2.Visible = False
        ddlPM2.Visible = False
        lblPR.Visible = False
        ddlPR.Visible = False

        lblSF.Visible = False
        ddlSF.Visible = False
        lblSM.Visible = False
        ddlSM.Visible = False
        lblSM2.Visible = False
        ddlSM2.Visible = False
        lblSR.Visible = False
        ddlSR.Visible = False

        lblCF.Visible = False
        ddlCF.Visible = False
        lblCM.Visible = False
        ddlCM.Visible = False
        lblCM2.Visible = False
        ddlCM2.Visible = False
        lblCR.Visible = False
        ddlCR.Visible = False

        For Each item As ListItem In cblSections.Items

            If item.Selected = True Then

                If item.Value = "PF" Then
                    lblPF.Visible = True
                    ddlPF.Visible = True

                ElseIf item.Value = "PM" Then
                    lblPM.Visible = True
                    ddlPM.Visible = True

                ElseIf item.Value = "PM2" Then
                    lblPM2.Visible = True
                    ddlPM2.Visible = True

                ElseIf item.Value = "PR" Then
                    lblPR.Visible = True
                    ddlPR.Visible = True

                ElseIf item.Value = "SF" Then
                    lblSF.Visible = True
                    ddlSF.Visible = True

                ElseIf item.Value = "SM" Then
                    lblSM.Visible = True
                    ddlSM.Visible = True

                ElseIf item.Value = "SM2" Then
                    lblSM2.Visible = True
                    ddlSM2.Visible = True

                ElseIf item.Value = "SR" Then
                    lblSR.Visible = True
                    ddlSR.Visible = True

                ElseIf item.Value = "CF" Then
                    lblCF.Visible = True
                    ddlCF.Visible = True

                ElseIf item.Value = "CM" Then
                    lblCM.Visible = True
                    ddlCM.Visible = True
                ElseIf item.Value = "CM2" Then
                    lblCM2.Visible = True
                    ddlCM2.Visible = True

                ElseIf item.Value = "CR" Then
                    lblCR.Visible = True
                    ddlCR.Visible = True
                End If
            End If

        Next
    End Sub
    Protected Sub btnTubeSubmit_Click(sender As Object, e As EventArgs) Handles btnTubeSubmit.Click

        Dim PortReason As String = tbPortOther.Text
        Dim StarboardReason As String = tbStrbOther.Text
        Dim CenterReason As String = tbCtrOther.Text

        Dim ProdNo As String = lblProdNo.Text
        Dim selectedcount As Integer = 0

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmdport As New SqlCommand
        Dim cmdsb As New SqlCommand
        Dim cmdboth As New SqlCommand
        Dim cmdcenter As New SqlCommand

        Dim cmdbothsamereason As New SqlCommand
        Dim cmdresetportstations As New SqlCommand
        Dim cmdresetsbstations As New SqlCommand
        Dim cmdresetallstations As New SqlCommand
        Dim cmdresetctrroller As New SqlCommand
        Dim cmdresetportandstarboard As New SqlCommand
        Dim cmdall As New SqlCommand
        Dim cmdallsamereason As New SqlCommand

        Dim TodaysDate As Date = Date.Now

        conn.ConnectionString = connstr

        cmdport.CommandType = CommandType.Text
        cmdsb.CommandType = CommandType.Text
        cmdboth.CommandType = CommandType.Text
        cmdall.CommandType = CommandType.Text
        cmdbothsamereason.CommandType = CommandType.Text
        cmdallsamereason.CommandType = CommandType.Text
        cmdcenter.CommandType = CommandType.Text

        cmdresetportstations.CommandType = CommandType.Text ' rollerstatusp etc
        cmdresetsbstations.CommandType = CommandType.Text   ' rollerstatuss etc
        cmdresetallstations.CommandType = CommandType.Text  'rollerstatusp, rollerstatuss etc
        cmdresetctrroller.CommandType = CommandType.Text    'rollerctr


        cmdport.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RerunP ='3', RerunPortReason = '" & PortReason & "', RerunPortReqDate = '" & TodaysDate & "' where ProdNo =  '" & ProdNo & "'"
        cmdsb.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RerunSB ='3', RerunSBReason = '" & StarboardReason & "' , RerunSBReqDate = '" & TodaysDate & "' where ProdNo =  '" & ProdNo & "'"
        cmdcenter.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RerunCtr ='3', RerunCtrReason = '" & CenterReason & "' , RerunCtrReqDate = '" & TodaysDate & "' where ProdNo =  '" & ProdNo & "'"

        cmdboth.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RerunSB ='3', RerunP ='3', RerunSBReason = '" & StarboardReason & "', RerunPortReason = '" & PortReason & "' , RerunPortReqDate = '" & TodaysDate & "', RerunSBReqDate = '" & TodaysDate & "' where ProdNo =  '" & ProdNo & "'"
        cmdall.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RerunSB ='3', RerunP ='3', RerunCtr ='3', RerunSBReason = '" & StarboardReason & "', RerunPortReason = '" & PortReason & "' , RerunPortReqDate = '" & TodaysDate & "', RerunSBReqDate = '" & TodaysDate & "', RerunCtrReason = '" & CenterReason & "', RerunCtrReqDate = '" & TodaysDate & "' where ProdNo =  '" & ProdNo & "'"

        cmdbothsamereason.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RerunSB ='3', RerunP ='3', RerunSBReason = '" & PortReason & "', RerunPortReason = '" & PortReason & "', RerunPortReqDate = '" & TodaysDate & "', RerunSBReqDate = '" & TodaysDate & "' where ProdNo =  '" & ProdNo & "'"
        cmdallsamereason.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RerunSB ='3', RerunP ='3', RerunCtr = '3', RerunSBReason = '" & PortReason & "', RerunPortReason = '" & PortReason & "', RerunCtrReason = '" & PortReason & "', RerunPortReqDate = '" & TodaysDate & "', RerunCtrReqDate = '" & TodaysDate & "', RerunSBReqDate = '" & TodaysDate & "' where ProdNo =  '" & ProdNo & "'"

        cmdresetportstations.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RollerStatusP = '1', RoundSeamerStatusP = '0' , BracketsStatusP = '0' , ChinesStatusP = '0' , RepairStatusP = '0' where ProdNo =  '" & ProdNo & "'"
        cmdresetsbstations.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RollerStatusS = '1', RoundSeamerStatusS = '0', BracketsStatusS = '0', ChinesStatusS = '0', RepairStatusS = '0' where ProdNo =  '" & ProdNo & "'"
        cmdresetallstations.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RollerStatusP = '1', RoundSeamerStatusP = '0', BracketsStatusP = '0', ChinesStatusP = '0', RepairStatusP = '0', RollerStatusS = '1', RoundSeamerStatusS = '0', BracketsStatusS = '0', ChinesStatusS = '0', RepairStatusS = '0', 'RollerCtr = '1', RoundSeamerStatusCtr = '0' , BracketsStatusCtr = '0' , ChinesStatusCtr = '0' , RepairStatusCtr = '0' where ProdNo =  '" & ProdNo & "'"
        cmdresetctrroller.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RollerCtr = '1', RoundSeamerStatusCtr = '0' , BracketsStatusCtr = '0' , ChinesStatusCtr = '0' , RepairStatusCtr = '0' where ProdNo =  '" & ProdNo & "'"
        cmdresetportandstarboard.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set RollerStatusP = '1', RoundSeamerStatusP = '0', BracketsStatusP = '0', ChinesStatusP = '0', RepairStatusP = '0', RollerStatusS = '1', RoundSeamerStatusS = '0', BracketsStatusS = '0', ChinesStatusS = '0', RepairStatusS = '0' where ProdNo =  '" & ProdNo & "'"

        cmdport.Connection = conn
        cmdsb.Connection = conn
        cmdboth.Connection = conn
        cmdbothsamereason.Connection = conn
        cmdallsamereason.Connection = conn
        cmdresetportstations.Connection = conn
        cmdresetsbstations.Connection = conn
        cmdresetallstations.Connection = conn
        cmdresetctrroller.Connection = conn
        cmdresetportandstarboard.Connection = conn
        cmdall.Connection = conn

        If rblWhichTubes.SelectedIndex < 0 Then
            MesgBox("Please select which tube(s) to Re-Run.")
        Else
            'conn.Open()
            If rblWhichTubes.SelectedValue = "Port" Then
                cmdport.ExecuteNonQuery()
                cmdresetportstations.ExecuteNonQuery()
                ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
                Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")

            ElseIf rblWhichTubes.SelectedValue = "Starboard" Then
                cmdsb.ExecuteNonQuery()
                cmdresetsbstations.ExecuteNonQuery()
                ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
                Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")

            ElseIf rblWhichTubes.SelectedValue = "Center" Then
                cmdcenter.ExecuteNonQuery()
                cmdresetctrroller.ExecuteNonQuery()
                ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
                Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")

            ElseIf rblWhichTubes.SelectedValue = "Both" Then
                If cbUseForBoth.Checked = False Then
                    cmdboth.ExecuteNonQuery()
                    cmdresetportandstarboard.ExecuteNonQuery()
                    ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
                    Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")
                Else
                    cmdbothsamereason.ExecuteNonQuery()
                    cmdresetportandstarboard.ExecuteNonQuery()
                    ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
                    Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")
                End If

            ElseIf rblWhichTubes.SelectedValue = "All" Then
                If cbUseForBoth.Checked = False Then
                    cmdall.ExecuteNonQuery()
                    cmdresetallstations.ExecuteNonQuery()
                    ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
                    Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")
                Else
                    cmdallsamereason.ExecuteNonQuery()
                    cmdresetallstations.ExecuteNonQuery()
                    ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
                    Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")
                End If
            End If

            conn.Close()
        End If

    End Sub



    Protected Sub ddlPF_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlPF.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub

    Protected Sub ddlPM_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlPM.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub

    Protected Sub ddlPM2_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlPM2.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub

    Protected Sub ddlPR_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlPR.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub

    Protected Sub ddlSF_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSF.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub

    Protected Sub ddlSM_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSM.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub

    Protected Sub ddlSM2_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSM2.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub

    Protected Sub ddlSR_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSR.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub

    Protected Sub ddlCF_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCF.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub

    Protected Sub ddlCM_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCM.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub

    Protected Sub ddlCM2_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCM2.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub

    Protected Sub ddlCR_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCR.SelectedIndexChanged
        ShowSectionReasonsIfOther()
    End Sub


    Protected Function ShowSectionReasonsIfOther()
        lblSectionNotesIfOther.Visible = False

        If ddlPF.SelectedValue = "Other" Then
            lblPFSectionOther.Visible = True
            tbPFSectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblPFSectionOther.Visible = False
            tbPFSectionOther.Visible = False

        End If

        If ddlPM.SelectedValue = "Other" Then
            lblPMSectionOther.Visible = True
            tbPMSectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblPMSectionOther.Visible = False
            tbPMSectionOther.Visible = False
        End If

        If ddlPM2.SelectedValue = "Other" Then
            lblPM2SectionOther.Visible = True
            tbPM2SectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblPM2SectionOther.Visible = False
            tbPM2SectionOther.Visible = False
        End If

        If ddlPR.SelectedValue = "Other" Then
            lblPRSectionOther.Visible = True
            tbPRSectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblPRSectionOther.Visible = False
            tbPRSectionOther.Visible = False
        End If

        If ddlSF.SelectedValue = "Other" Then
            lblSFSectionOther.Visible = True
            tbSFSectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblSFSectionOther.Visible = False
            tbSFSectionOther.Visible = False
        End If

        If ddlSM.SelectedValue = "Other" Then
            lblSMSectionOther.Visible = True
            tbSMSectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblSMSectionOther.Visible = False
            tbSMSectionOther.Visible = False
        End If

        If ddlSM2.SelectedValue = "Other" Then
            lblSM2SectionOther.Visible = True
            tbSM2SectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblSM2SectionOther.Visible = False
            tbSM2SectionOther.Visible = False
        End If

        If ddlSR.SelectedValue = "Other" Then
            lblSRSectionOther.Visible = True
            tbSRSectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblSRSectionOther.Visible = False
            tbSRSectionOther.Visible = False
        End If

        If ddlCF.SelectedValue = "Other" Then
            lblCFSectionOther.Visible = True
            tbCFSectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblCFSectionOther.Visible = False
            tbCFSectionOther.Visible = False
        End If

        If ddlCM.SelectedValue = "Other" Then
            lblCMSectionOther.Visible = True
            tbCMSectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblCMSectionOther.Visible = False
            tbCMSectionOther.Visible = False
        End If

        If ddlCM2.SelectedValue = "Other" Then
            lblCM2SectionOther.Visible = True
            tbCM2SectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblCM2SectionOther.Visible = False
            tbCM2SectionOther.Visible = False
        End If

        If ddlCR.SelectedValue = "Other" Then
            lblCRSectionOther.Visible = True
            tbCRSectionOther.Visible = True
            lblSectionNotesIfOther.Visible = True
        Else
            lblCRSectionOther.Visible = False
            tbCRSectionOther.Visible = False
        End If


    End Function


    Protected Sub btnSectionSubmit_Click(sender As Object, e As EventArgs) Handles btnSectionSubmit.Click

    End Sub


End Class





