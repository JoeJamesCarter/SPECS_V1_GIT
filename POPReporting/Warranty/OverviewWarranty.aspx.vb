
Imports System.Data
Imports System.Data.SqlClient

Partial Class Warranty_OverviewWarranty
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvWarrantyBoats_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvWarrantyBoats.RowCommand
        If e.CommandName = "Save" Then

            Dim Key As String = e.CommandArgument
            'MesgBox(Key)
            'Get the Repair Prod # for the Selected Row
            Dim label = DirectCast(gvWarrantyBoats.Rows(Key).FindControl("Label1"), Label)
            Dim Selected As String = label.Text

            Dim TodaysDate As Date = Date.Now
            'Dim ThisDay As Date = TodaysDate.Date

            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim conn As New SqlConnection
            conn.ConnectionString = connstr

            Dim cmd As New SqlCommand
            cmd.Connection = conn

            Dim gvWork As GridView = TryCast(gvWarrantyBoats.Rows(Key).FindControl("gvWarrantyWork"), GridView)


            'MesgBox(Selected)

            Dim rbTubes As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(1).FindControl("rblTubeStatus"), RadioButtonList)
            Dim rbFrames As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(2).FindControl("rblFramesStatus"), RadioButtonList)
            Dim rbFloors As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(3).FindControl("rblFloorsStatus"), RadioButtonList)
            Dim rbRails As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(4).FindControl("rblRailsStatus"), RadioButtonList)
            Dim rbFurniture As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(5).FindControl("rblFurnitureStatus"), RadioButtonList)
            Dim rbHelm As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(6).FindControl("rblHelmStatus"), RadioButtonList)
            Dim rbCleaning As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(7).FindControl("rblCleaningStatus"), RadioButtonList)
            Dim rbInspection As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(8).FindControl("rblInspectionStatus"), RadioButtonList)
            Dim rbPersonalItems As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(9).FindControl("rblPersonalItemsStatus"), RadioButtonList)
            Dim rbShrinkwrap As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(10).FindControl("rblShrinkwrapStatus"), RadioButtonList)
            Dim rbRigging As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(10).FindControl("rblRiggingStatus"), RadioButtonList)
            Dim rbWavetamer As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(10).FindControl("rblWaveTamerStatus"), RadioButtonList)
            Dim rbSharkhide As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(12).FindControl("rblSharkhideStatus"), RadioButtonList)
            Dim rbComplete As RadioButtonList = DirectCast(gvWork.Rows(0).Cells(17).FindControl("rblCompleteStatus"), RadioButtonList)

            Dim cTubesStatus As Int16 = rbTubes.SelectedValue
            Dim cTubesDate As Date
            Dim cFramesStatus As Int16 = rbFrames.SelectedValue
            Dim cFramesDate As Date
            Dim cFloorsStatus As Int16 = rbFloors.SelectedValue
            Dim cFloorsDate As Date
            Dim cRailsStatus As Int16 = rbRails.SelectedValue
            Dim cRailsDate As Date
            Dim cFurnitureStatus As Int16 = rbFurniture.SelectedValue
            Dim cFurnitureDate As Date
            Dim cHelmStatus As Int16 = rbHelm.SelectedValue
            Dim cHelmDate As Date
            Dim cCleaningStatus As Int16 = rbCleaning.SelectedValue
            Dim cCleaningDate As Date
            Dim cFinalInspectionStatus As Int16 = rbInspection.SelectedValue
            Dim cFinalInspectionDate As Date
            Dim cPersonalItems As Int16 = rbPersonalItems.SelectedValue
            Dim cPersonalItemsDate As Date
            Dim cShrinkwrapStatus As Int16 = rbShrinkwrap.SelectedValue
            Dim cShrinkwrapDate As Date
            Dim cRiggingStatus As Int16 = rbShrinkwrap.SelectedValue
            Dim cRiggingDate As Date
            Dim cWavetamer As Int16 = rbWavetamer.SelectedValue
            Dim cWavetamerDate As Date
            Dim cSharkhide As Int16 = rbSharkhide.SelectedValue
            Dim cSharkhideDate As Date
            Dim cComplete As Int16 = rbComplete.SelectedValue
            Dim cCompleteDate As Date

            'MesgBox(rbTubes.SelectedValue)
            'pnl1.Attributes.Add("display", "block")

            'Get the record of the previous values.  Only save the various dates if the value has changed since the initial load of the record.
            'See how I used the adapter in Scheduling/Slot Maintenance

            Dim adapter As New SqlDataAdapter
            Dim beforeSaveRecord As New DataTable

            adapter.SelectCommand = New SqlCommand("Select * from BML_POPREPORTING_WARRANTY where RProdNo = '" & Selected & "'", conn)

            conn.Open()

            Dim imgRequestPickup As Image = CType(gvWarrantyBoats.Rows(Key).FindControl("btnUpdateReqPU"), Image)
            Dim imgArrived As Image = CType(gvWarrantyBoats.Rows(Key).FindControl("btnUpdateArrived"), Image)
            Dim imgInitialInspection As Image = CType(gvWarrantyBoats.Rows(Key).FindControl("btnUpdateInitInsp"), Image)
            Dim imgUpdateInitPhotos As Image = CType(gvWarrantyBoats.Rows(Key).FindControl("btnUpdateInitialPhotos"), Image)

            Dim imgFinalPhotos As Image = CType(gvWork.Rows(0).FindControl("btnFinalPhotos"), Image)
            Dim imgAttachForms As Image = CType(gvWork.Rows(0).FindControl("btnAttachForms"), Image)
            Dim imgRequestReturn As Image = CType(gvWork.Rows(0).FindControl("btnUpdateReqReturn"), Image)

            Dim RequestPU = Mid(imgRequestPickup.ImageUrl, 25, 1)
            Dim Arrived = Mid(imgArrived.ImageUrl, 25, 1)
            Dim InitialInspection = Mid(imgInitialInspection.ImageUrl, 25, 1)
            Dim UploadInitPhotos = Mid(imgUpdateInitPhotos.ImageUrl, 25, 1)
            Dim FinalPhotos = Mid(imgFinalPhotos.ImageUrl, 25, 1)
            Dim AttachForms = Mid(imgAttachForms.ImageUrl, 25, 1)
            Dim RequestReturn = Mid(imgRequestReturn.ImageUrl, 25, 1)

            Dim LocationDDL As DropDownList = gvWarrantyBoats.Rows(Key).FindControl("ddlLocation")
            Dim Location As String = LocationDDL.SelectedValue
            Dim LocNotestb As TextBox = gvWarrantyBoats.Rows(Key).FindControl("tbStorageLocation")
            Dim LocNotes As String = LocNotestb.Text
            Dim WorkNotestb As TextBox = gvWork.Rows(0).FindControl("tbNotes")
            Dim WorkNotes As String = WorkNotestb.Text


            cmd.Parameters.AddWithValue("@RProdNo", Selected)
            cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
            cmd.Parameters.AddWithValue("@Location", Location)
            cmd.Parameters.AddWithValue("@LocNotes", LocNotes)
            cmd.Parameters.AddWithValue("@WorkNotes", WorkNotes)

            adapter.Fill(beforeSaveRecord)

            'If beforeSaveRecord.Rows.Count > 0 Then
            Dim pTubesStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("TubesStatus")))
            Dim pFramesStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("FramesStatus")))
            Dim pFloorsStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("FloorsStatus")))
            Dim pRailsStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("RailsStatus")))
            Dim pFurnitureStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("FurnitureStatus")))
            Dim pHelmStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("HelmStatus")))
            Dim pCleaningStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("CleaningStatus")))
            Dim pInspectionStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("FinalInspectionStatus")))
            Dim pPersonalItemsStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("PersonalItemsInBoatStatus")))
            Dim pShrinkwrapStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("ShrinkStatus")))
            Dim pRiggingStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("RiggingStatus")))
            Dim pWavetamerStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("WavetamerStatus")))
            Dim pSharkhideStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("SharkhideStatus")))
            Dim pCompleteStatus = (Convert.ToInt16(beforeSaveRecord.Rows(0).Item("CompleteStatus")))
            Dim pLocation = beforeSaveRecord.Rows(0).Item("Location")
            Dim pLocationDate = beforeSaveRecord.Rows(0).Item("LocationDate")
            Dim pStorageLocation = beforeSaveRecord.Rows(0).Item("StorageLocation")
            Dim LocationDate = TodaysDate
            Dim StorageLocationDate = TodaysDate

            If Location = pLocation Then
                LocationDate = pLocationDate
            Else
                LocationDate = TodaysDate
            End If

            'If LocNotes = pStorageLocation Then ' compares string to null and fails
            'LocationDate = pLocationDate 'trying to set a date to null and fails.
            'End If

            'Update the values and dates that have changed - p is previous and c is current.
            If rbTubes.SelectedValue <> pTubesStatus Then
                cTubesDate = TodaysDate
            Else
                cTubesDate = beforeSaveRecord.Rows(0).Item("TubesDate")
            End If

            If rbFrames.SelectedValue <> pFramesStatus Then
                cFramesDate = TodaysDate
            Else
                cFramesDate = beforeSaveRecord.Rows(0).Item("FramesDate")
            End If

            If rbFloors.SelectedValue <> pFloorsStatus Then
                cFloorsDate = TodaysDate
            Else
                cFloorsDate = beforeSaveRecord.Rows(0).Item("FloorsDate")
            End If

            If rbRails.SelectedValue <> pRailsStatus Then
                cRailsDate = TodaysDate
            Else
                cRailsDate = beforeSaveRecord.Rows(0).Item("RailsDate")
            End If

            If rbFurniture.SelectedValue <> pFurnitureStatus Then
                cFurnitureDate = TodaysDate
            Else
                cFurnitureDate = beforeSaveRecord.Rows(0).Item("FurnitureDate")
            End If

            If rbHelm.SelectedValue <> pHelmStatus Then
                cHelmDate = TodaysDate
            Else
                cHelmDate = beforeSaveRecord.Rows(0).Item("HelmDate")
            End If

            If rbCleaning.SelectedValue <> pCleaningStatus Then
                cCleaningDate = TodaysDate
            Else
                cCleaningDate = beforeSaveRecord.Rows(0).Item("CleaningDate")
            End If

            If rbInspection.SelectedValue <> pInspectionStatus Then
                cFinalInspectionDate = TodaysDate
            Else
                cFinalInspectionDate = beforeSaveRecord.Rows(0).Item("FinalInspectionDate")
            End If

            If rbPersonalItems.SelectedValue <> pPersonalItemsStatus Then
                cPersonalItemsDate = TodaysDate
            Else
                cPersonalItemsDate = beforeSaveRecord.Rows(0).Item("PersonalItemsInBoatDate")
            End If

            If rbShrinkwrap.SelectedValue <> pShrinkwrapStatus Then
                cShrinkwrapDate = TodaysDate
            Else
                cShrinkwrapDate = beforeSaveRecord.Rows(0).Item("ShrinkDate")
            End If

            If rbRigging.SelectedValue <> pRiggingStatus Then
                cRiggingDate = TodaysDate
            Else
                cRiggingDate = beforeSaveRecord.Rows(0).Item("RiggingDate")
            End If

            If rbWavetamer.SelectedValue <> pWavetamerStatus Then
                cWavetamerDate = TodaysDate
            Else
                cWavetamerDate = beforeSaveRecord.Rows(0).Item("WavetamerDate")
            End If

            If rbSharkhide.SelectedValue <> pSharkhideStatus Then
                cSharkhideDate = TodaysDate
            Else
                cSharkhideDate = beforeSaveRecord.Rows(0).Item("SharkhideDate")
            End If

            If rbComplete.SelectedValue <> pCompleteStatus Then
                cCompleteDate = TodaysDate
            Else
                cCompleteDate = beforeSaveRecord.Rows(0).Item("CompleteDate")
            End If


            'Run Update Command - there is always going to be a record since all the data is tracked in this table.
            'Make sure new form enters all of these values at 0 at creating so it doesn't ever return null.
            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_WARRANTY SET Location = '" & Location & "', LocationDate = '" & LocationDate & "', StorageLocation = '" & LocNotes & "', TubesStatus = '" & cTubesStatus & "', TubesDate = '" & cTubesDate & "', FramesStatus = '" & cFramesStatus & "', FramesDate = '" & cFramesDate & "', FloorsStatus = '" & cFloorsStatus & "', FloorsDate = '" & cFloorsDate & "', RailsStatus = '" & cRailsStatus & "', RailsDate = '" & cRailsDate & "', FurnitureStatus = '" & cFurnitureStatus & "', FurnitureDate = '" & cFurnitureDate & "', HelmStatus = '" & cHelmStatus & "', HelmDate = '" & cHelmDate & "', CleaningStatus = '" & cCleaningStatus & "', CleaningDate = '" & cCleaningDate & "', FinalInspectionStatus = '" & cFinalInspectionStatus & "', FinalInspectionDate = '" & cFinalInspectionDate & "', PersonalItemsInBoatStatus = '" & cPersonalItems & "', PersonalItemsInBoatDate = '" & cPersonalItemsDate & "', ShrinkStatus = '" & cShrinkwrapStatus & "', ShrinkDate = '" & cShrinkwrapDate & "', RiggingStatus = '" & cRiggingStatus & "', RiggingDate = '" & cRiggingDate & "', WavetamerStatus = '" & cWavetamer & "', WavetamerDate = '" & cWavetamerDate & "', SharkhideStatus = '" & cSharkhide & "', SharkhideDate = '" & cSharkhideDate & "', CompleteStatus = '" & cComplete & "', CompleteDate = '" & cCompleteDate & "' where RProdNo =  '" & Selected & "'"

            cmd.ExecuteNonQuery()
            conn.Close()
            gvWarrantyBoats.DataBind()
        End If

        If e.CommandName = "gotoupdatePU" Then 'Request Pickup
            Dim Key As String = e.CommandArgument
            'Get the Repair Prod # for the Selected Row
            Dim label = DirectCast(gvWarrantyBoats.Rows(Key).FindControl("Label1"), Label)
            Dim Selected As String = label.Text

            Dim labelserial = DirectCast(gvWarrantyBoats.Rows(Key).FindControl("Label2"), Label)
            Dim serial As String = labelserial.Text

            Dim labelmodel = DirectCast(gvWarrantyBoats.Rows(Key).FindControl("Label3"), Label)
            Dim model As String = labelmodel.Text

            Dim labelorigprodno = DirectCast(gvWarrantyBoats.Rows(Key).FindControl("Label4"), Label)
            Dim origprodno As String = labelorigprodno.Text


            Dim TodaysDate As Date = Date.Now
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_WARRANTY SET InitialPickupRequested = '2' , InitialPickupRequestedDate = '" & TodaysDate & "', Arrived = '1' where RProdNo =  '" & Selected & "'"

            cmd.Connection = conn
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            Dim SmtpServer As New Net.Mail.SmtpClient
            Dim mail As New Net.Mail.MailMessage
            SmtpServer.Host = "192.168.1.5"
            SmtpServer.UseDefaultCredentials = False
            SmtpServer.Credentials = New System.Net.NetworkCredential("bensmtp@benningtonmarine.com", "BenSMTP")

            mail.From = New Net.Mail.MailAddress("bensmtp@benningtonmarine.com", "SPECS")
            'mail.To.Add("btrosper@benningtonmarine.com")
            mail.To.Add("krimbaugh@benningtonmarine.com")
            mail.Subject = "Bennington Warranty/Repair Boat Request for Pickup - " & Selected & ""
            mail.Body = "Bennington Repair Production #" & Selected & " is ready to be picked up for repairs. S/N: " & serial & "  Model: " & model & ""
            SmtpServer.Send(mail)

            gvWarrantyBoats.DataBind()
        End If

        If e.CommandName = "gotoupdateArrived" Then
            Dim Key As String = e.CommandArgument
            'Get the Repair Prod # for the Selected Row
            Dim label = DirectCast(gvWarrantyBoats.Rows(Key).FindControl("Label1"), Label)
            Dim Selected As String = label.Text
            Dim TodaysDate As Date = Date.Now
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_WARRANTY SET Arrived = '2' , ArrivalDate = '" & TodaysDate & "', InitialInspection = '1' where RProdNo =  '" & Selected & "'"

            cmd.Connection = conn
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvWarrantyBoats.DataBind()

        End If

        If e.CommandName = "gotoupdateInitInsp" Then
            Dim Key As String = e.CommandArgument
            'Get the Repair Prod # for the Selected Row
            Dim label = DirectCast(gvWarrantyBoats.Rows(Key).FindControl("Label1"), Label)
            Dim Selected As String = label.Text
            Dim TodaysDate As Date = Date.Now
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_WARRANTY SET InitialInspection = '2' , InitialInspectionDate = '" & TodaysDate & "', InitialPhotosTaken = '1', AttachedForms = '1', UploadFinalPhotos = '1' where RProdNo =  '" & Selected & "'"

            cmd.Connection = conn
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvWarrantyBoats.DataBind()
        End If

        If e.CommandName = "gotoupdateInitPhotos" Then
            Dim Key As String = e.CommandArgument
            'Get the Repair Prod # for the Selected Row
            Dim label = DirectCast(gvWarrantyBoats.Rows(Key).FindControl("Label1"), Label)
            Dim Selected As String = label.Text
            Dim url As String = "./InitialPhotos.aspx?RProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotoupdateFinalPhotos" Then


        End If

        If e.CommandName = "gotoupdateAttachForms" Then


        End If

        If e.CommandName = "gotoupdateReqReturn" Then


        End If

        If e.CommandName = "showrequest" Then
            Dim Key As String = e.CommandArgument
            'Get the Repair Prod # for the Selected Row
            Dim label = DirectCast(gvWarrantyBoats.Rows(Key).FindControl("Label1"), Label)
            Dim Selected As String = label.Text

            Dim url As String = "FactoryServiceRequest.aspx?RProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,width=1200,height=1400,resizable=1,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotoViewPersonalItems" Then
            Dim Key As String = e.CommandArgument
            'Get the Repair Prod # for the Selected Row
            Dim label = DirectCast(gvWarrantyBoats.Rows(0).FindControl("Label1"), Label)
            Dim Selected As String = label.Text

            Dim url As String = "PersonalItems.aspx?RProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,width=1200,height=1400,resizable=1,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotoupdateAttachForms" Then
            Dim Key As String = e.CommandArgument
            'Get the Repair Prod # for the Selected Row
            Dim label = DirectCast(gvWarrantyBoats.Rows(0).FindControl("Label1"), Label)
            Dim Selected As String = label.Text

            Dim url As String = "AttachForms.aspx?RProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,width=1200,height=1400,resizable=1,toolbars=0');popUpObj.focus()}</script>")

        End If



    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

    End Sub

    Protected Sub gvWarrantyBoats_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvWarrantyBoats.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsWarrantyWork"), SqlDataSource)

            'Dim rprodno = DataBinder.Eval(e.Row.DataItem, "Label1")
            '
            Dim rprodno = DirectCast(e.Row.FindControl("Label1"), Label)
            Dim Selected As String = rprodno.Text
            'MesgBox(Selected)


            Try 'use the selected prod # to get the green light values for the subgridview.
                '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = Selected

            Catch

            End Try
        End If

    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbSerial.Text = ""
        tbConsumer.Text = ""
        tbDealer.Text = ""
    End Sub
End Class
