Imports System.Data
Imports System.Data.SqlClient
Partial Class Gates_AddAGate
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim model As String = tbModel.Text.ToUpper
        Dim gate As String = ddlGate.SelectedValue
        Dim customVal As Integer = 0
        Dim bo As Integer = 0
        Dim clear As Integer = 0
        Dim custdrawno As String = tbCusDrawNo.Text
        Dim gateID As Integer

        Dim readytosave As Boolean = True

        If cbCustom.Checked = True Then
            customVal = 1
        Else
            customVal = 0
        End If

        If rblColor.SelectedIndex = -1 Then
            MesgBox("Please select Clear or Blackout.")
            readytosave = False
        End If
        If rblColor.SelectedValue = "Blackout" Then
            bo = 1
        ElseIf rblColor.SelectedValue = "Clear" Then
            clear = 1
        End If

        If gate.Length < 1 Then
            MesgBox("Please select a Rail.")
            readytosave = False
        End If

        If model.Length = 0 Then
            MesgBox("Please make sure to type a Model.")
            readytosave = False
        End If

        If cbCustom.Checked = True And custdrawno.Length < 1 Then
            MesgBox("Please enter the Custom Drawing #.")
            readytosave = False
        End If

        If readytosave Then
            'Write the record to the rails inventory table.

            Dim DrawingNo As String = ""

            Dim MY As String = "2021"

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn


            If gate = "BowCtr" Then
                cmd2.CommandText = "Select BowCtr From ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & model & "'"

            ElseIf gate = "Port" Then
                cmd2.CommandText = "Select ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & model & "'"

            ElseIf gate = "Strb" Then

                cmd2.CommandText = "Select Strb From ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & model & "'"

            ElseIf gate = "AftPort" Then

                cmd2.CommandText = "Select AftPort From ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & model & "'"

            ElseIf gate = "AftCtr" Then

                cmd2.CommandText = "Select AftCtr From ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & model & "'"

            ElseIf gate = "AftStrb" Then

                cmd2.CommandText = "Select AftRear From ELK1ITSSQL002.ProductInfo.dbo.Gates Where Year = '" & MY & "' and Model = '" & model & "'"

            End If

            conn.Open()

            Try
                DrawingNo = cmd2.ExecuteScalar
            Catch ex As Exception
                DrawingNo = "" 'If you can't find it, send it blank.
            End Try


            cmd.Parameters.AddWithValue("@Model", model)
            cmd.Parameters.AddWithValue("@Gate", gate)
            cmd.Parameters.AddWithValue("@Clear", clear)
            cmd.Parameters.AddWithValue("@BO", bo)
            cmd.Parameters.AddWithValue("@CustomVal", customVal)
            cmd.Parameters.AddWithValue("@CustDrawNo", custdrawno)
            cmd.Parameters.AddWithValue("@Drawing", DrawingNo)

            cmd.CommandText = "INSERT Into Gates_ExtraInventory(Model,Gate,Clear,Blackout,Custom,CustomDrawNo,Used,UsedDate,ProdNoUsedFor,Drawing) VALUES (@Model, @Gate, @Clear, @BO, @CustomVal, @CustDrawNo,0,NULL,NULL,@Drawing)"
            cmd1.CommandText = "Select MAX(AutoID) from Gates_ExtraInventory"


            cmd.ExecuteNonQuery()

            gateID = cmd1.ExecuteScalar
            MesgBox(gateID)

            conn.Close()

            tbModel.Text = ""
            tbCusDrawNo.Text = ""
            ddlGate.SelectedIndex = -1
            cbCustom.Checked = False
            rblColor.SelectedIndex = -1
        End If
    End Sub
End Class
