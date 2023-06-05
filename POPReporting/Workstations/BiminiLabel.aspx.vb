
Partial Class Workstations_BiminiLabel
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Dim lblProdNo As Label
        Dim BoatNotesProdNo As String
        Dim Model As String
        Dim CusName As String
        Dim Serial As String
        Dim BO As String


        BoatNotesProdNo = Request.QueryString("ProdNo")
        Model = Request.QueryString("Model")
        CusName = Request.QueryString("CusName")
        Serial = Request.QueryString("Serial")
        BO = Request.QueryString("BO")

        lblProdNo.Text = BoatNotesProdNo
        lblModel.Text = Model
        lblCusName.Text = CusName
        lblSerial.Text = Serial

        If BO = "1" Then
            lblBO.Text = " Black"
        End If


    End Sub

End Class
