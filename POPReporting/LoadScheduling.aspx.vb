Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class LoadScheduling
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim conn2 As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim connstr2 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        Dim ThisDay As Date = Calendar1.SelectedDate
        Dim loadcounttoday As Int16
        'Dim totalboatsinyard As Integer

        cmd.Connection = conn
        cmd1.Connection = conn2

        conn.ConnectionString = connstr
        conn2.ConnectionString = connstr2
        Try
            conn.Open()
            cmd.CommandText = "Select Max(LoadNo) FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & ThisDay & "'"
            loadcounttoday = cmd.ExecuteScalar
            conn.Close()
            lblLoadsScheduled.Text = loadcounttoday
        Catch ex As Exception
            lblLoadsScheduled.Text = 0
        End Try


        'cmd1.CommandText = "Select Count (mfg_ser_lot_no) From IMLSMST_SQL Where mfg_ser_lot_no like '1%'"
        'conn2.Open()
        'totalboatsinyard = cmd1.ExecuteScalar
        'lblTotalInYard.Text = totalboatsinyard
        'conn2.Close()



    End Sub

    Protected Sub gvBoatsToSchedule_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBoatsToSchedule.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsDlrBoats"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsProductionBoats"), SqlDataSource)
            Try
                Dim dlr As String = (e.Row.Cells(2).Text)

                s.SelectParameters(0).DefaultValue = dlr
                t.SelectParameters(0).DefaultValue = dlr

            Catch ex As Exception

            End Try

        End If
    End Sub


    Protected Sub Calendar1_SelectionChanged(sender As Object, e As EventArgs) Handles Calendar1.SelectionChanged

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        Dim selecteddate As Date = Calendar1.SelectedDate

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd.CommandType = CommandType.Text

        cmd.CommandText = "Select top 1 LoadNo FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & selecteddate & "' order By LoadNo desc"
        conn.Open()
        Try
            Dim numscheduled As Int16 = cmd.ExecuteScalar
            lblLoadsScheduled.Text = numscheduled
        Catch ex As Exception
            lblLoadsScheduled.Text = 0
        End Try

        conn.Close()

    End Sub


    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn

        cmd.CommandType = CommandType.Text
        cmd1.CommandType = CommandType.Text

        Dim selecteddate As Date = Calendar1.SelectedDate

        'Don't let it run if the date is not selected.
        If Calendar1.SelectedDate = DateTime.MinValue Then
            MesgBox("Please select a date.")
        Else

            conn.Open()


            For Each row In gvBoatsToSchedule.Rows
                Dim selected As CheckBox = TryCast(row.Cells(0).FindControl("cbSelectDlr"), CheckBox)
                Dim gvDealerBoats As GridView = TryCast(row.Cells(3).FindControl("gvDlrBoats"), GridView)
                Dim gvProductionBoats As GridView = TryCast(row.Cells(3).FindControl("gvProductionBoats"), GridView)
                Dim shipper As String = DirectCast(row.Cells(4).FindControl("ddlShippers"), DropDownList).SelectedValue
                Dim loaded As Integer = 0

                If selected.Checked = True Then
                    For Each innerRow In gvDealerBoats.Rows
                        Dim cbSelectBoat As CheckBox = TryCast(innerRow.Cells(0).FindControl("cbSelectBoat"), CheckBox)
                        If cbSelectBoat.Checked = True Then
                            Dim prod = innerRow.Cells(1).Text
                            Dim load As String = DirectCast(innerRow.Cells(4).FindControl("tbLoadNo"), TextBox).Text
                            Dim splitstop As String = DirectCast(innerRow.Cells(6).FindControl("tbStopNo"), TextBox).Text


                            Dim issplit As Integer = 0

                            Dim issplitcb As CheckBox = DirectCast(innerRow.Cells(5).FindControl("cbSplitLoad"), CheckBox)
                            If issplitcb.Checked = True Then
                                issplit = 1
                            End If
                            cmd.CommandText = "Insert Into Load_Scheduling (ProdNo,LoadNo,StopNo,ActualLoadDate,Shipper,Split,Loaded) Values ('" & prod & "', '" & load & "', '" & splitstop & "', '" & selecteddate & "', '" & shipper & "', '" & issplit & "', '" & loaded & "')"
                            'MesgBox(prod)
                            'MesgBox(load)
                            'MesgBox(selecteddate)
                            'MesgBox(splitstop)
                            'MesgBox(shipper)
                            'MesgBox(issplit)
                            cmd.ExecuteNonQuery()
                        End If

                    Next

                    For Each innerRow In gvProductionBoats.Rows
                        Dim cbSelectProdBoat As CheckBox = TryCast(innerRow.Cells(0).FindControl("cbSelectProdBoat"), CheckBox)
                        If cbSelectProdBoat.Checked = True Then
                            Dim prod = innerRow.Cells(1).Text
                            Dim load As String = DirectCast(innerRow.Cells(4).FindControl("tbLoadNo"), TextBox).Text
                            Dim splitstop As String = DirectCast(innerRow.Cells(6).FindControl("tbStopNo"), TextBox).Text

                            Dim issplit As Integer = 0

                            Dim issplitcb As CheckBox = DirectCast(innerRow.Cells(5).FindControl("cbSplitLoad"), CheckBox)
                            If issplitcb.Checked = True Then
                                issplit = 1
                            End If
                            cmd.CommandText = "Insert Into Load_Scheduling (ProdNo,LoadNo,StopNo,ActualLoadDate,Shipper,Split,Loaded) Values ('" & prod & "', '" & load & "', '" & splitstop & "', '" & selecteddate & "', '" & shipper & "', '" & issplit & "', '" & loaded & "')"
                            'MesgBox(prod)
                            'MesgBox(load)
                            'MesgBox(selecteddate)
                            'MesgBox(splitstop)
                            'MesgBox(shipper)
                            'MesgBox(issplit)
                            cmd.ExecuteNonQuery()

                        End If
                    Next

                End If
            Next
            cmd1.CommandText = "Select Max(LoadNo) FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & selecteddate & "'"
            Try
                Dim numscheduled As Int16 = cmd1.ExecuteScalar
                lblLoadsScheduled.Text = numscheduled
            Catch ex As Exception
                lblLoadsScheduled.Text = 0
            End Try

            conn.Close()
            gvBoatsToSchedule.DataBind()
        End If

    End Sub

    Protected Sub gvDlrBoats_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim conn1 As New SqlConnection()
            Dim conn2 As New SqlConnection()

            Dim connstr2 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString

            Dim cmd1 As New SqlCommand
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
            Dim cmd12 As New SqlCommand
            Dim cmd13 As New SqlCommand

            Dim exists As Integer
            Dim redtagged As Integer
            Dim tubeissues As Integer
            Dim prod As String = (e.Row.Cells(1).Text)
            Dim model As String = (e.Row.Cells(2).Text)
            Dim so As String
            Dim cladded As String
            Dim notes As String
            Dim currentstatus As String
            Dim hotlistdropdeadship As String
            Dim hotflag As String
            Dim holdflag As String
            Dim redtagimage As ImageButton = DirectCast(e.Row.FindControl("btnRedTag"), ImageButton)
            Dim hold As Image = DirectCast(e.Row.FindControl("imgHold"), Image)
            Dim hot As Image = DirectCast(e.Row.FindControl("imgHot"), Image)
            Dim lblHotShipDate As Label = DirectCast(e.Row.FindControl("lblHotShipDate"), Label)
            'get the connection string and query the sales file for the ship instruction and if it isn't blank then assign it to this label
            Dim lblShipInstruction As Label = DirectCast(e.Row.FindControl("lblShipInstruction"), Label)
            Dim ShipInstruction As String
            'lblShipInstruction.Text = "hello"
            Dim custship As Integer = 0

            cmd1.Connection = conn2
            cmd2.Connection = conn2
            cmd3.Connection = conn2
            cmd4.Connection = conn1
            cmd5.Connection = conn2
            cmd6.Connection = conn2
            cmd7.Connection = conn2
            cmd8.Connection = conn2
            cmd9.Connection = conn2
            cmd10.Connection = conn2
            cmd11.Connection = conn1
            cmd12.Connection = conn1
            cmd13.Connection = conn1

            conn2.ConnectionString = connstr2
            conn1.ConnectionString = connstr1

            cmd1.CommandText = "Select count(ProdNo) From Load_Scheduling Where ProdNo = '" & prod & "'"
            cmd2.CommandText = "Select Scheduling.dbo.Order_Assignments.Notes From BML_POPREPORTING_GREENLIGHTS Left Join Scheduling.dbo.Order_Assignments on BML_POPREPORTING_GREENLIGHTS.SONo = Scheduling.dbo.Order_Assignments.SONo Where ProdNo = '" & prod & "'"
            cmd3.CommandText = "Select SONo from BML_POPREPORTING_GREENLIGHTS Where ProdNo = '" & prod & "'"
            cmd5.CommandText = "Select CASE When BML_POPREPORTING_GREENLIGHTS.CompleteStatus = '2' Then 'Complete' WHEN BML_POPREPORTING_GREENLIGHTS.SharkhideStatus = '1' Then 'Sharkhide' When BML_POPREPORTING_GREENLIGHTS.WavetamerStatus ='1' Then 'Wavetamer' When BML_POPREPORTING_GREENLIGHTS.RiggingStatus ='1' Then 'Rigging' When BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus ='1' Then 'Shrinkwrap' When BML_POPREPORTING_GREENLIGHTS.CleaningStatus ='1' Then 'Inspection' When BML_POPREPORTING_GREENLIGHTS.FinalInspectionStatus ='1' Then 'Final' When BML_POPREPORTING_GREENLIGHTS.HelmInstalledStatus ='1' Then 'Helm' When BML_POPREPORTING_GREENLIGHTS.FurnitureInstalledStatus ='1' Then 'Furniture' End as CurrentStatus From BML_POPREPORTING_GREENLIGHTS Where ProdNo = '" & prod & "'"
            cmd6.CommandText = "Select IsRedTagged From BML_POPREPORTING_GREENLIGHTS Where ProdNo = '" & prod & "'"
            cmd7.CommandText = "Select Count(ProdNo) From Tubes_DamageReported Where RepairedFlag = 0 and ReplacedFlag = 0 and ProdNo = '" & prod & "'"
            cmd8.CommandText = "Select Disabled From HotList Where ProdNo = '" & prod & "'"
            cmd9.CommandText = "Select HoldFlag From BML_POPREPORTING_GREENLIGHTS Where ProdNo = '" & prod & "'"
            cmd10.CommandText = "Select Disabled from HotList where ProdNo = '" & prod & "'"


            conn2.Open()
            exists = cmd1.ExecuteScalar


            If exists = 1 Then
                e.Row.Visible = False
            Else
                Try

                    redtagged = cmd6.ExecuteScalar
                    tubeissues = cmd7.ExecuteScalar
                    holdflag = cmd9.ExecuteScalar



                    If redtagged.ToString = "1" Then
                        redtagimage.Visible = True
                    End If

                    If holdflag.ToString = "1" Then
                        hold.Visible = True
                    End If

                    If tubeissues > 0 Then
                        e.Row.Cells(9).Text = "REPAIR or REPLACE"
                        ' Else
                        '    e.Row.Cells(9).Text = "NONE"
                    End If
                    e.Row.Cells(9).CssClass = "boatinfoboattuberepair"

                Catch ex As Exception

                End Try

                Try
                    currentstatus = cmd5.ExecuteScalar
                    hotflag = cmd10.ExecuteScalar
                    e.Row.Cells(12).Text = currentstatus
                    hotlistdropdeadship = cmd8.ExecuteScalar

                    If currentstatus <> "Complete" Then
                        e.Row.Cells(12).BackColor = Drawing.Color.Red
                    End If

                    If hotflag.ToString = "0" Then
                        hot.Visible = True
                    End If

                    If Len(hotlistdropdeadship).ToString > 2 Then
                        lblHotShipDate.Text = hotlistdropdeadship
                        hot.Visible = True
                    End If
                Catch ex As Exception

                End Try



                If cmd2.ExecuteScalar Is DBNull.Value Then

                Else
                    notes = cmd2.ExecuteScalar
                    e.Row.Cells(7).Text = notes
                End If 'added 5/13/20


                so = Mid(cmd3.ExecuteScalar(), 1)
                cmd4.CommandText = "Select count(item_desc_1) From OELINHST_SQL where (item_desc_1 Like '%Arch%Clad%' or item_no Like '901201%') and ord_no = '" & so & "'"
                cmd11.CommandText = "Select count(item_no) From OEORDLIN_SQL Where item_no = 'CUSTSHIP' and ord_no = '" & so & "'"
                cmd12.CommandText = "Select count(item_desc_1) From OEORDLIN_SQL where (item_desc_1 Like '%Arch%Clad%' or item_no Like '901201%') and ord_no = '" & so & "'"
                cmd13.CommandText = "Select ship_instruction_1 from oeordhdr_sql where ord_no = '" & so & "'"

                conn1.Open()
                cladded = cmd4.ExecuteScalar

                Dim stillopenordercladded As Int16 = 0
                stillopenordercladded = cmd12.ExecuteScalar

                If cmd13.ExecuteScalar Is DBNull.Value Then

                Else
                    ShipInstruction = cmd13.ExecuteScalar
                    lblShipInstruction.Text = ShipInstruction
                End If


                custship = cmd11.ExecuteScalar

                If cladded > 0 Or stillopenordercladded > 0 Or custship > 0 Then
                    e.Row.Cells(2).BackColor = Drawing.Color.Yellow
                End If

                conn1.Close()

                If (model.IndexOf("A") > 0 And model.IndexOf("X1") > 0) Or
                    (model.IndexOf("A") > 0 And model.IndexOf("X2") > 0) Or
                    cladded > 0 Or
                    (model.IndexOf("25RX") >= 0) Or
                    (model Like "##LXS*A*" And Not (model Like "##LXS*APG*")) Or
                    (model Like "##RX*A*" And Not (model Like "##RX*APG*")) Or
                    (model Like "##Q*A*" And Not (model Like "##Q*APG*")) Or
                    (model Like "##QX*A*" And Not (model Like "##QX*APG*")) Or
                    (model Like "##RT*A*" And Not (model Like "##RT*APG*")) Or
                    (model Like "##R*A*" And Not (model Like "##R*APG*")) Or
                    (model.IndexOf("QXSPORT") > 0) Then
                    e.Row.Cells(2).BackColor = Drawing.Color.Yellow
                End If

            End If

            conn2.Close()
        End If

    End Sub


    Protected Sub gvProductionBoats_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim conn As New SqlConnection()
            Dim conn2 As New SqlConnection()

            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim connstr2 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand
            Dim cmd6 As New SqlCommand
            Dim cmd7 As New SqlCommand

            Dim exists As Integer
            'Dim loaded As Integer
            Dim notes As String
            Dim prod As String = (e.Row.Cells(1).Text)
            Dim model As String = (e.Row.Cells(2).Text)
            Dim so As String
            Dim cladded As Integer = 0
            Dim custship As Integer = 0
            'this is where we would add it for the production boats as well...does it make sense to do it here??
            Dim lblProdShipInstruction As Label = DirectCast(e.Row.FindControl("lblProdShipInstruction"), Label)
            Dim ProdShipInstruction As String

            cmd1.Connection = conn2
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn2
            cmd6.Connection = conn2
            cmd7.Connection = conn2

            conn.ConnectionString = connstr
            conn2.ConnectionString = connstr2

            cmd1.CommandText = "Select count(mfg_ser_lot_no) From IMLSMST_SQL Where mfg_ser_lot_no = '" & prod & "'"
            cmd2.CommandText = "Select Scheduling.dbo.Order_Assignments.Notes From BML_POPREPORTING_GREENLIGHTS Left Join Scheduling.dbo.Order_Assignments on BML_POPREPORTING_GREENLIGHTS.SONo = Scheduling.dbo.Order_Assignments.SONo Where ProdNo = '" & prod & "'"
            cmd3.CommandText = "Select Count(Option_Desc) from BML_POPREPORTINGFABOPTIONS Where ((Option_Desc Like '%Arch%Clad%') or (Option_Item Like '901201%')) and ProdNo = '" & prod & "'"
            'cmd3.CommandText = "Select count(item_desc_1) From OEORDLIN_SQL where item_desc_1 Like '%Clad%' and RTrim(LTrim(ord_no)) =  '" & so & "'"
            cmd4.CommandText = "Select SONo from BML_POPREPORTING_GREENLIGHTS Where ProdNo = '" & prod & "'"
            cmd5.CommandText = "Select count(item_no) From OEORDLIN_SQL Where item_no Like 'CUSTSHIP*' and ord_no = '" & so & "'"
            cmd6.CommandText = "Select count(item_desc_1) From OEORDLIN_SQL where ((item_desc_1 Like '%Arch%Clad%') or (item_no Like '901201%')) and ord_no = '" & so & "'"
            cmd7.CommandText = "Select ship_instruction_1 from oeordhdr_sql where ord_no = '" & so & "'"

            conn.Open()
            conn2.Open()
            exists = cmd1.ExecuteScalar
            so = Mid(cmd4.ExecuteScalar(), 2)

            custship = cmd5.ExecuteScalar

            cladded = cmd3.ExecuteScalar

            Dim stillopencladded As Int16 = cmd6.ExecuteScalar

            If exists = 1 Then
                e.Row.Visible = False
            Else
                If cmd2.ExecuteScalar Is DBNull.Value Then

                Else
                    notes = cmd2.ExecuteScalar
                    e.Row.Cells(12).Text = notes

                    'Yellow model if it is cladded standards or optional

                    If cmd7.ExecuteScalar Is DBNull.Value Then

                    Else
                        ProdShipInstruction = cmd7.ExecuteScalar
                        lblProdShipInstruction.Text = ProdShipInstruction
                    End If

                End If
                conn.Close()
                conn2.Close()
            End If

            If (model.IndexOf("A") > 0 And model.IndexOf("X1") > 0) Or
                   (model.IndexOf("A") > 0 And model.IndexOf("X2") > 0) Or
                   cladded > 0 Or
                   stillopencladded > 0 Or
                   custship > 0 Or
                   (model.IndexOf("25RX") >= 0) Or
                    (model Like "##LXS*A*" And Not (model Like "##LXS*APG*")) Or
                    (model Like "##RX*A*" And Not (model Like "##RX*APG*")) Or
                    (model Like "##Q*A*" And Not (model Like "##Q*APG*")) Or
                    (model Like "##QX*A*" And Not (model Like "##QX*APG*")) Or
                    (model Like "##RT*A*" And Not (model Like "##RT*APG*")) Or
                    (model Like "##R*A*" And Not (model Like "##R*APG*")) Or
                   (model.IndexOf("QXSPORT") > 0) Then
                e.Row.Cells(2).BackColor = Drawing.Color.Yellow
            End If


        End If

    End Sub
    Protected Sub gvBoatsToSchedule_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvBoatsToSchedule.RowCommand

        If e.CommandName = "gotoredtag" Then 'handles when the notes button is clicked

            Dim Prod As String = e.CommandArgument 'get the row that is clicked
            Dim workstation As String = "LoadScheduling" 'to pass in the workstation that makes the note.

            Dim url As String = "RedTags.aspx?ws=" & workstation & "&ProdNo=" & Prod

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "newWindow", "window.open('" + url + "','_blank','status=1,toolbar=0,menubar=0,location=1,scrollbars=1,resizable=1,width=840,height=800');", True)

        End If
    End Sub
End Class
