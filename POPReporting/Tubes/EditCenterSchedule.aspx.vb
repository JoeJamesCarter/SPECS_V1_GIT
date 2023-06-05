Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Tubes_EditCenterSchedule
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvCenters_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvCenters.RowCommand
        'This code is for the update button
        If e.CommandName = "gotoSave" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvCenters.Rows(Key).Cells(2).Text 'find the prod # in that row to use in the update command

            Dim tbOrder As TextBox = CType(gvCenters.Rows(Key).FindControl("tbOrder"), TextBox)
            Dim tbLength As TextBox = CType(gvCenters.Rows(Key).FindControl("tbLength"), TextBox)
            Dim tbRope As TextBox = CType(gvCenters.Rows(Key).FindControl("tbRope"), TextBox)                        'Zach Added 4/24/2023
            Dim tbCenter As TextBox = CType(gvCenters.Rows(Key).FindControl("tbCenter"), TextBox)
            Dim tbStorage As TextBox = CType(gvCenters.Rows(Key).FindControl("tbStorage"), TextBox)
            Dim tbTenWide As TextBox = CType(gvCenters.Rows(Key).FindControl("tbTenWide"), TextBox)
            Dim tbDrawingNo As TextBox = CType(gvCenters.Rows(Key).FindControl("tbDrawingNo"), TextBox)
            'Dim tbBrackets As TextBox = CType(gvCenters.Rows(Key).Cells(0).FindControl("tbBrackets"), TextBox)
            Dim tbFuel As TextBox = CType(gvCenters.Rows(Key).Cells(0).FindControl("tbFuel"), TextBox)
            Dim tbStrakes As TextBox = CType(gvCenters.Rows(Key).Cells(0).FindControl("tbStrakes"), TextBox)
            Dim tbTubeUpg As TextBox = CType(gvCenters.Rows(Key).Cells(0).FindControl("tbTubeUpg"), TextBox)
            Dim tbUpsweep As TextBox = CType(gvCenters.Rows(Key).Cells(0).FindControl("tbUpsweep"), TextBox)

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn

            conn.Open()
            'one update statement for the sequence
            cmd.Parameters.AddWithValue("@centerorder", tbOrder.Text)
            cmd.Parameters.AddWithValue("@prodno", SelectedProdNo)

            cmd.CommandText = "Update Tubes Set CenterScheduleOrder = @centerorder Where ProdNo = @prodno"
            cmd.ExecuteNonQuery()

            'another for the center detail
            cmd1.Parameters.AddWithValue("@prodno1", SelectedProdNo)
            cmd1.Parameters.AddWithValue("@length", Trim(tbLength.Text))
            cmd1.Parameters.AddWithValue("@rope", Trim(tbRope.Text))                          'Zach Added 4/24/2023
            cmd1.Parameters.AddWithValue("@center", Trim(tbCenter.Text))
            cmd1.Parameters.AddWithValue("@storage", Trim(tbStorage.Text))
            cmd1.Parameters.AddWithValue("@tenwide", Trim(tbTenWide.Text))
            cmd1.Parameters.AddWithValue("@drawingno", Trim(tbDrawingNo.Text))
            'cmd1.Parameters.AddWithValue("@brackets", Trim(tbBrackets.Text))
            cmd1.Parameters.AddWithValue("@fuel", Trim(tbFuel.Text))
            cmd1.Parameters.AddWithValue("@strakes", Trim(tbStrakes.Text))
            cmd1.Parameters.AddWithValue("@tubeupg", Trim(tbTubeUpg.Text))
            cmd1.Parameters.AddWithValue("@upsweep", Trim(tbUpsweep.Text))


            For Each Parameter As SqlParameter In cmd1.Parameters
                If Parameter.Value Is Nothing Then
                    Parameter.Value = DBNull.Value
                End If
            Next

            cmd1.CommandText = "Update CentertubeDetails Set Length = @length, Center = @center, Storage = @storage, TenWide = @tenwide, DrawingNo = @drawingno, Fuel = @fuel, Strakes = @strakes, TubeUpg = @tubeupg, Upsweep_SldTrans = @upsweep, Edited = 1, Rope = @rope  Where ProdNo = @prodno1"

            cmd1.ExecuteNonQuery()

            conn.Close()

            gvCenters.Rows(Key).BackColor = Drawing.Color.LightGreen 'shows what rows were changed since last load


        End If

    End Sub

    Protected Sub btnPrintable_Click(sender As Object, e As EventArgs) Handles btnPrintable.Click
        Dim selectedDate As DateTime = ddlCenterDates.SelectedValue 'get the row that is clicked
        selectedDate = selectedDate.ToShortDateString()
        Dim url As String = "../Tubes/CenterSchedule.aspx?selectedDate=" & selectedDate & ""
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,toolbars=0');popUpObj.focus()}</script>")

    End Sub

    Private Sub gvCenters_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCenters.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                If e.Row.DataItem("IsCustom") = 1 Then
                    e.Row.Cells(0).BackColor = Drawing.Color.Red
                End If
                If e.Row.DataItem("IsPilot") = 1 Then
                    e.Row.Cells(0).BackColor = Drawing.Color.Blue
                End If
            Catch
            End Try

        End If
    End Sub
End Class
