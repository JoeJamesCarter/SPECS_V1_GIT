Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class FurnitureInternalRGA
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim Prod As String = Request.QueryString("prod")
        Dim Model As String = Request.QueryString("model")
        Dim Part As String = Request.QueryString("part")
        Dim Color As String = Request.QueryString("color")
        If Not IsPostBack Then
            tbProdNo.Text = Prod
            tbModel.Text = Model
            tbPart.Text = Part
            tbColor.Text = Color
        End If

    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim continueflag As Boolean = True

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn

        Dim TodaysDate As Date = Date.Now

        Dim Prod = tbProdNo.Text
        Dim Model = tbModel.Text
        Dim Part = tbPart.Text
        Dim Color = tbColor.Text
        Dim Qty = tbQty.Text
        Dim Reason = tbReason.Text
        Dim Who = ddlWho.SelectedValue
        Dim Status = ddlStatus.SelectedValue

        If (Reason.Length < 1 Or Qty.Length < 1 Or Who.Length < 1 Or Status.Length < 1) Then
            continueflag = False
            MesgBox("Qty, Reason, Damaged By and Status are required.")
        End If

        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("ProdNo", Prod)
        cmd.Parameters.AddWithValue("@Model", Model)
        cmd.Parameters.AddWithValue("@Part", Part)
        cmd.Parameters.AddWithValue("@Color", Color)
        cmd.Parameters.AddWithValue("@Qty", Qty)
        cmd.Parameters.AddWithValue("@Reason", Reason)
        cmd.Parameters.AddWithValue("@Who", Who)
        cmd.Parameters.AddWithValue("@Status", Status)

        cmd.CommandText = "Insert into InternalRGAs (ProdNo, Model, Part, Color, Qty, Reason, DamagedBy, Status, DateEntered) VALUES (@ProdNo, @Model, @Part, @Color, @Qty, @Reason, @Who, @Status, @TodaysDate)"

        If continueflag Then
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            MesgBox("Internal RGA Successfully Added.")
            tbProdNo.Text = ""
            tbModel.Text = ""
            tbPart.Text = ""
            tbColor.Text = ""
            tbQty.Text = ""
            tbReason.Text = ""
        End If



    End Sub
End Class
