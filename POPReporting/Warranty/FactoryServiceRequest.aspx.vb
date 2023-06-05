Imports System.Data
Imports System.Data.SqlClient

Partial Class Warranty_FactoryServiceRequest
    Inherits System.Web.UI.Page

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        Dim chargedto As String = cbWhoPays.SelectedValue
        Dim serial As String = tbSerialNo.Text
        Dim origprodno As String = tbOrigProdNo.Text
        Dim model As String = tbModel.Text
        Dim dealer As String = tbDealer.Text
        Dim consumer As String = tbConsumerName.Text
        Dim primarycontact As String = tbPrimary.Text
        Dim primaryphone As String = tbPrimaryPhone.Text
        Dim primaryemail As String = tbPrimaryEmail.Text
        Dim services As String = tbService.Text
        Dim special As String = tbSpecial.Text
        Dim target As Date = tbTarget.Text
        Dim returnvia As String = cbReturnedBy.SelectedValue
        Dim trailerowner As String = cbWhoseTrailer.SelectedValue
        Dim trailierid As String = tbTrailerID.Text
        Dim pickuplocation As String = tbPUAddress.Text
        Dim requestedby As String = tbRequestor.Text
        Dim requestorsemail As String = tbEmail.Text
        Dim requestorsphone As String = tbReqPhone.Text
        Dim daterequested As Date = Date.Now()
        Dim approvedby As String = tbApprovedBy.Text
        Dim dateapproved As Date = tbDateApproved.Text

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        Dim cmd As New SqlCommand

        cmd.Parameters.AddWithValue("@OrigProdNo", origprodno)
        cmd.Parameters.AddWithValue("@TodaysDate", ThisDay)
        cmd.Parameters.AddWithValue("@Charged", chargedto)
        cmd.Parameters.AddWithValue("@Serial", serial)
        cmd.Parameters.AddWithValue("@Model", model)
        cmd.Parameters.AddWithValue("@Dealer", dealer)
        cmd.Parameters.AddWithValue("@Consumer", consumer)
        cmd.Parameters.AddWithValue("@PrimaryContact", primarycontact)
        cmd.Parameters.AddWithValue("@PrimaryEmail", primaryemail)
        cmd.Parameters.AddWithValue("@PrimaryPhone", primaryphone)
        cmd.Parameters.AddWithValue("@ServicesRequired", services)
        cmd.Parameters.AddWithValue("@SpecialInstr", special)
        cmd.Parameters.AddWithValue("@Target", target)
        cmd.Parameters.AddWithValue("@ReturnVia", returnvia)
        cmd.Parameters.AddWithValue("@TrailerOwner", trailerowner)
        cmd.Parameters.AddWithValue("@TrailerID", trailierid)
        cmd.Parameters.AddWithValue("@PickupLocation", pickuplocation)
        cmd.Parameters.AddWithValue("@RequestedBy", requestedby)
        cmd.Parameters.AddWithValue("@RequestorsEmail", requestorsemail)
        cmd.Parameters.AddWithValue("@DateApproved", dateapproved)
        cmd.Parameters.AddWithValue("@Approver", approvedby)


        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim conn As New SqlConnection
        conn.ConnectionString = connstr

        cmd.Connection = conn

        cmd.CommandType = CommandType.Text
        'cmd.CommandText = "UPDATE BML_POPREPORTING_WARRANTY SET OrigProdNo = @OrigProdNo, DateEntered = @ThisDay, ChargedTo = @Charged, Serial = @Serial, Model = @Model, DealerDBA = @Dealer, Consumer = @Consumer, PrimaryContact = @PrimaryContact, PrimaryEmail = @PrimaryEmail, PrimaryPhone = @PrimaryPhone, ServicesRequired = @Services, SpecialInstr = @Special, TargetReturnDate = @Target, ReturnBenVia = @ReturnVia, TrailerOwner = @TrailerOwner, TrailerID = @ TrailerID, PickupLocation = @PickupLocation, RequestedBy =  @RequestedBy, RequestorsEmail = @RequestorsEmail, DateRequested = @TodaysDate, TubesStatus = '0', TubesDate = @TodaysDate, FramesStatus = '0', FramesDate = @TodaysDate, FloorsStatus = '0', FloorsDate = @TodaysDate, RailsStatus = '0', RailsDate = @TodaysDate, FurnitureStatus = '0', FurnitureDate = @TodaysDate, HelmStatus = '0', HelmDate = @TodaysDate, CleaningStatus = '0', CleaningDate = @TodaysDate, FinalInspectionStatus = '0', FinalInspectionDate = @TodaysDate, PersonalItemsInBoatStatus = '0', PersonalItemsInBoatDate = @TodaysDate, ShrinkStatus = '0', ShrinkDate = @TodaysDate, RiggingStatus = '0', RiggingDate = @TodaysDate, WavetamerStatus = '0', WavetamerDate = @TodaysDate, SharkhideStatus = '0', SharkhideDate = @TodaysDate, CompleteStatus = '0', CompleteDate = @TodaysDate where RProdNo =  @RProdNo'"

        cmd.CommandText = "Insert into BML_POPREPORTING_WARRANTY(DateEntered,ChargedTo,Serial,Model,DealerDBA,Consumer,PrimaryContact,PrimaryEmail,PrimaryPhone,ServicesRequired,SpecialInstr,TargetReturnDate,ReturnBenVia,TrailerOwner,TrailerID,PickupLocation,RequestedBy,RequestersEmail,DateRequested,ApprovedFlag,DateApproved,Approver,ReqInitPickup,Arrived,InitialInspection,Location,LocationDate,TubesStatus,TubesDate,FramesStatus,FramesDate,FloorsStatus,FloorsDate,RailsStatus,RailsDate,FurnitureStatus,FurnitureDate,HelmStatus,HelmDate,CleaningStatus,CleaningDate,FinalInspectionStatus,FinalInspectionDate,PersonalItemsInBoatStatus,PersonalItemsInBoatDate,ShrinkStatus,ShrinkDate,RiggingStatus,RiggingDate,WavetamerStatus,WavetamerDate,SharkhideStatus,SharkhideDate,CompleteStatus,CompleteDate,UploadFinalPhotos,AttachedForms,ReturnRequested,InitialPickupRequested,IntiialPhotosTaken,UploadInitialPhotos) VALUES (@TodaysDate, @Charged, @Serial, @Model, @Dealer, @Consumer,@PrimaryContact,@PrimaryEmail,@PrimaryPhone,@ServicesRequired,@SpecialInstr,@Target, @ReturnVia,@TrailerOwner,@TrailerID,@PickupLocation,@RequestedBy,@RequestorsEmail,@TodaysDate,'1',@TodaysDate,@Approver,'1','1','0','N/A',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0',@TodaysDate,'0','0','0','1','0','0')"
        conn.Open()
        cmd.ExecuteNonQuery()

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Request.QueryString.HasKeys() Then
            btnSubmit.Visible = False ' so it doesn't print

            Dim BoatRepairProdNo As String
            BoatRepairProdNo = Request.QueryString("RProdNo")

            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim conn As New SqlConnection
            conn.ConnectionString = connstr

            Dim adapter As New SqlDataAdapter
            Dim Record As New DataTable

            adapter.SelectCommand = New SqlCommand("Select * from BML_POPREPORTING_WARRANTY where RProdNo = '" & BoatRepairProdNo & "'", conn)
            conn.Open()
            adapter.Fill(Record)

            tbSerialNo.Text = (Record.Rows(0).Item("Serial").ToString())
            cbWhoPays.SelectedValue = (Record.Rows(0).Item("ChargedTo").ToString())
            tbModel.Text = (Record.Rows(0).Item("Model").ToString())
            tbDealer.Text = (Record.Rows(0).Item("DealerDBA").ToString())
            tbConsumerName.Text = (Record.Rows(0).Item("Consumer").ToString())
            tbPrimary.Text = (Record.Rows(0).Item("PrimaryContact").ToString())
            tbPrimaryEmail.Text = (Record.Rows(0).Item("PrimaryEmail").ToString())
            tbPrimaryPhone.Text = (Record.Rows(0).Item("PrimaryPhone").ToString())
            tbService.Text = (Record.Rows(0).Item("ServicesRequired").ToString())
            tbSpecial.Text = (Record.Rows(0).Item("SpecialInstr").ToString())
            cbReturnedBy.SelectedValue = (Record.Rows(0).Item("ReturnBenVia").ToString())
            cbWhoseTrailer.SelectedValue = (Record.Rows(0).Item("TrailerOwner").ToString())
            tbTrailerID.Text = (Record.Rows(0).Item("TrailerID").ToString())
            tbPUAddress.Text = (Record.Rows(0).Item("PickupLocation").ToString())
            tbPUContact.Text = (Record.Rows(0).Item("PickupContact").ToString())
            tbPhone.Text = (Record.Rows(0).Item("PickupPhone").ToString())
            tbOrigProdNo.Text = (Record.Rows(0).Item("OrigProdNo").ToString())
            tbRequestor.Text = (Record.Rows(0).Item("RequestedBy").ToString())
            tbReqPhone.Text = (Record.Rows(0).Item("RequestersPhone").ToString())
            tbEmail.Text = (Record.Rows(0).Item("RequestersEmail").ToString())
            tbApprovedBy.Text = (Record.Rows(0).Item("Approver").ToString())

            tbTarget.TextMode = TextBoxMode.SingleLine
            tbDateEntered.TextMode = TextBoxMode.SingleLine

            tbTarget.Text = (Left(Record.Rows(0).Item("TargetReturnDate").ToString(), 10))
            tbDateEntered.Text = (Left(Record.Rows(0).Item("DateEntered").ToString(), 10))
        Else
            tbDateEntered.TextMode = TextBoxMode.SingleLine

            Dim TodaysDate As Date = Date.Now()
            Dim ThisDay As Date = TodaysDate.Date
            tbDateEntered.Text = ThisDay
        End If
    End Sub
End Class
