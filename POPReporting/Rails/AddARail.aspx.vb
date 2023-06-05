Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Rails_AddARail
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
        Dim rail As String = ddlRail.SelectedValue
        Dim customVal As Integer = 0
        Dim bo As Integer = 0
        Dim pt As Integer = 0
        Dim clear As Integer = 0
        Dim custdrawno As String = tbCusDrawNo.Text
        Dim railID As Integer

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

        If cbPT.Checked = True Then
            pt = 1
        End If

        If rail.Length < 1 Then
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
            Dim Series As String

            Dim MY As String = "2021"

            If model Like "??R*" Or model Like "??Q*" Then
                Series = "RQ"
            Else
                Series = "SG"
            End If

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn
            cmd2.Connection = conn


            If rail = "PF" Then
                If Series = "SG" Then
                    cmd2.CommandText = "Select PortFront From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & model & "'"
                ElseIf Series = "RQ" Then
                    cmd2.CommandText = "Select PortFront From Rails.dbo.ModelsRQ Where Model = '" & model & "'"
                End If
            ElseIf rail = "SF" Then
                If Series = "SG" Then
                    cmd2.CommandText = "Select StrbFront From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & model & "'"
                ElseIf Series = "RQ" Then
                    cmd2.CommandText = "Select StrbFront From Rails.dbo.ModelsRQ Where Model = '" & model & "'"
                End If
            ElseIf rail = "PR" Then
                If Series = "SG" Then
                    cmd2.CommandText = "Select PortRear From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & model & "'"
                ElseIf Series = "RQ" Then
                    cmd2.CommandText = "Select PortRear From Rails.dbo.ModelsRQ Where Model = '" & model & "'"
                End If
            ElseIf rail = "SR" Then
                If Series = "SG" Then
                    cmd2.CommandText = "Select StrbRear From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & model & "'"
                ElseIf Series = "RQ" Then
                    cmd2.CommandText = "Select StrbRear From Rails.dbo.ModelsRQ Where Model = '" & model & "'"
                End If
            ElseIf rail = "PM" Then
                If Series = "SG" Then
                    cmd2.CommandText = "Select PortMid From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & model & "'"
                ElseIf Series = "RQ" Then
                    cmd2.CommandText = "Select PortMid From Rails.dbo.ModelsRQ Where Model = '" & model & "'"
                End If
            ElseIf rail = "SM" Then
                If Series = "SG" Then
                    cmd2.CommandText = "Select StrbMid From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & model & "'"
                ElseIf Series = "RQ" Then
                    cmd2.CommandText = "Select StrbMid From Rails.dbo.ModelsRQ Where Model = '" & model & "'"
                End If
            ElseIf rail = "T" Then
                If Series = "SG" Then
                    cmd2.CommandText = "Select Transom From Rails.dbo.Models Where ModelYear = '" & MY & "' and Model = '" & model & "'"
                ElseIf Series = "RQ" Then
                    cmd2.CommandText = "Select Transom From Rails.dbo.ModelsRQ Where Model = '" & model & "'"
                End If
            End If

            conn.Open()

            Try
                DrawingNo = cmd2.ExecuteScalar
            Catch
            End Try


            If DrawingNo Is Nothing Then
                DrawingNo = ""
            End If

            cmd.Parameters.AddWithValue("@Model", model)
            cmd.Parameters.AddWithValue("@Rail", rail)
            cmd.Parameters.AddWithValue("@Clear", clear)
            cmd.Parameters.AddWithValue("@BO", bo)
            cmd.Parameters.AddWithValue("@PT", pt)
            cmd.Parameters.AddWithValue("@CustomVal", customVal)
            cmd.Parameters.AddWithValue("@CustDrawNo", custdrawno)
            cmd.Parameters.AddWithValue("@Drawing", DrawingNo)

            cmd.CommandText = "INSERT Into Rails_ExtraInventory(Model,Rail,Clear,Blackout,Powertop,Custom,CustomDrawNo,Used,UsedDate,ProdNoUsedFor,Drawing) VALUES (@Model, @Rail, @Clear, @BO, @PT, @CustomVal, @CustDrawNo,0,NULL,NULL,@Drawing)"
            cmd1.CommandText = "Select MAX(AutoID) from Rails_ExtraInventory"


            cmd.ExecuteNonQuery()

            railID = cmd1.ExecuteScalar
            MesgBox(railID)

            conn.Close()

            tbModel.Text = ""
            tbCusDrawNo.Text = ""
            ddlRail.SelectedIndex = -1
            cbCustom.Checked = False
            cbPT.Checked = False
            rblColor.SelectedIndex = -1
        End If
    End Sub
End Class
