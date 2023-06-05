
Imports System.Data
Imports System.Data.SqlClient

Partial Class HoldList
    Inherits System.Web.UI.Page

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class

    Public greenlights As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Public Function PopulateDataTables() As String

        Dim sqldataadapter As New SqlDataAdapter
        Dim conn As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()
        sqldataadapter.SelectCommand = New SqlCommand("SELECT t2.ProdNo, t2.ItemNo, t2.DueDate, t2.CusName, t2.CusNo From BML_POPREPORTING_GREENLIGHTS t2 Where ProdNo > 2000000  Order By t2.ProdNo", conn)
        sqldataadapter.Fill(greenlights)

        conn.Close()

        conn.Dispose()
        Return False

    End Function

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

    Private Sub HoldList_Load(sender As Object, e As EventArgs) Handles Me.Load
        PopulateDataTables()

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
        user = GlobalVariables.stationID.ToUpper

        If user = "TLEITZ" Or user = "KRIMBA" Or user = "BTROSP" Or user = "CBATES" Then
            addboat.Visible = True
            boatinfo.Visible = True
        Else
            addboat.Visible = False
            boatinfo.Visible = False
        End If

    End Sub
    Private Sub tbProdNo_TextChanged(sender As Object, e As EventArgs) Handles tbProdNo.TextChanged

        Dim ProdNo As String = tbProdNo.Text
        If ProdNo.Length < 7 Then
            MesgBox("Prod # needs to be a length of 7.")
        Else
            Dim dv As DataView = greenlights.DefaultView
            dv.RowFilter = "ProdNo = " & ProdNo

            For Each rowView As DataRowView In dv
                Dim row As DataRow = rowView.Row
                lblDlr.Text = " - " & row("CusName").ToString
                lblDlrNo.Text = "Dealer: " & row("CusNo").ToString
                lblModel.Text = row("ItemNo").ToString
            Next
        End If
    End Sub

    Private Sub btnSetHoldFlag_Click(sender As Object, e As EventArgs) Handles btnSetHoldFlag.Click

        'submit 

        Dim TodaysDate As Date = Date.Now
        Dim ProdNo As String = tbProdNo.Text 'get the row that is clicked
        Dim HoldNote As String = tbNotes.Text
        Dim HoldPer As String = ddlHoldPer.SelectedValue

        If ProdNo.Length < 7 Then
            MesgBox("Prod # needs to be a length of 7.")
        Else
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.CommandType = CommandType.Text

            cmd.Parameters.AddWithValue("@Today", TodaysDate)
            cmd.Parameters.AddWithValue("@ProdNo", ProdNo)
            cmd.Parameters.AddWithValue("@HoldFlag", 1)
            cmd.Parameters.AddWithValue("@HoldNote", HoldNote)
            cmd.Parameters.AddWithValue("@HoldPer", HoldPer)

            cmd.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set HoldFlag = @HoldFlag, Hold = @Today, HoldPer = @HoldPer, HoldNote = @HoldNote Where ProdNo = @ProdNo"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            MesgBox("Boat Set to Hold")
        End If

        gvHoldList.DataBind()

        'and reset
        tbProdNo.Text = ""
        lblDlrNo.Text = "Enter Prod # & Click Search. Verify Boat. Set On Hold Per and Reason. Click Hold."
        lblDlr.Text = ""
        lblModel.Text = ""
        ddlHoldPer.SelectedIndex = -1
        tbNotes.Text = ""
    End Sub

    Private Sub gvHoldList_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvHoldList.RowCommand

        If e.CommandName = "gotorelease" Then 'handles when the release button

            Dim ID As String = e.CommandArgument
            Dim ProdNo As Integer = gvHoldList.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.CommandType = CommandType.Text

            cmd.Parameters.AddWithValue("@ProdNo", ProdNo)
            cmd.Parameters.AddWithValue("@HoldFlag", 0)

            cmd.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set HoldFlag = @HoldFlag Where ProdNo = @ProdNo"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            gvHoldList.DataBind()

        End If
    End Sub

    Private Sub gvHoldList_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvHoldList.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim User As String = GlobalVariables.stationID.ToUpper
            Dim btnRelease As Button = CType(e.Row.FindControl("btnRelease"), Button)

            If User = "TLEITZ" Or User = "KRIMBA" Or User = "BTROSP" Or User = "CBATES" Then
                btnRelease.Visible = True
            Else
                btnRelease.Visible = False
            End If
        End If

    End Sub
End Class
