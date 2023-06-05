Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls


Partial Class Tubes_EditOuterSchedule
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvOuters_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvOuters.RowCommand
        'This code is for the update button
        If e.CommandName = "gotoSave" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvOuters.Rows(Key).Cells(2).Text 'find the prod # in that row to use in the update command

            Dim tbOrder As TextBox = CType(gvOuters.Rows(Key).FindControl("tbOrder"), TextBox)
            Dim tbStyle As TextBox = CType(gvOuters.Rows(Key).FindControl("tbStyle"), TextBox)
            Dim tbDiameter As TextBox = CType(gvOuters.Rows(Key).FindControl("tbDiameter"), TextBox)
            Dim tbFront As TextBox = CType(gvOuters.Rows(Key).FindControl("tbFront"), TextBox)
            Dim tbRope As TextBox = CType(gvOuters.Rows(Key).FindControl("tbRope"), TextBox)                                  'Added by Zach 4/24/2023
            Dim tbModel As TextBox = CType(gvOuters.Rows(Key).FindControl("tbModel"), TextBox)
            Dim tbLadder As TextBox = CType(gvOuters.Rows(Key).FindControl("tbLadder"), TextBox)
            Dim tbBrackets As TextBox = CType(gvOuters.Rows(Key).Cells(0).FindControl("tbBrackets"), TextBox)
            Dim tbKeel As TextBox = CType(gvOuters.Rows(Key).Cells(0).FindControl("tbKeel"), TextBox)
            Dim tbFuel As TextBox = CType(gvOuters.Rows(Key).Cells(0).FindControl("tbFuel"), TextBox)
            Dim tbSplash As TextBox = CType(gvOuters.Rows(Key).Cells(0).FindControl("tbSplash"), TextBox)
            Dim tbStrakes As TextBox = CType(gvOuters.Rows(Key).Cells(0).FindControl("tbStrakes"), TextBox)
            Dim tbStrakesCmts As TextBox = CType(gvOuters.Rows(Key).Cells(0).FindControl("tbStrakesCmts"), TextBox)
            Dim tbStrbTrans As TextBox = CType(gvOuters.Rows(Key).Cells(0).FindControl("tbStrbTrans"), TextBox)
            Dim tbComments As TextBox = CType(gvOuters.Rows(Key).Cells(0).FindControl("tbComments"), TextBox)
            Dim tbBlack As TextBox = CType(gvOuters.Rows(Key).Cells(0).FindControl("tbBlack"), TextBox)
            Dim tbDrawingNo As TextBox = CType(gvOuters.Rows(Key).Cells(0).FindControl("tbDrawingNo"), TextBox)
            Dim tbMegaPan As TextBox = CType(gvOuters.Rows(Key).Cells(0).FindControl("tbMegaPan"), TextBox)

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd1.Connection = conn

            conn.Open()
            'one update statement for the sequence
            cmd.Parameters.AddWithValue("@outerorder", tbOrder.Text)
            cmd.Parameters.AddWithValue("@prodno", SelectedProdNo)

            cmd.CommandText = "Update Tubes Set OuterScheduleOrder = @outerorder Where ProdNo = @prodno"
            cmd.ExecuteNonQuery()

            'another for the outer detail
            cmd1.Parameters.AddWithValue("@prodno1", SelectedProdNo)
            cmd1.Parameters.AddWithValue("@style", Trim(tbStyle.Text))
            cmd1.Parameters.AddWithValue("@diameter", Trim(tbDiameter.Text))
            cmd1.Parameters.AddWithValue("@front", Trim(tbFront.Text))
            cmd1.Parameters.AddWithValue("@rope", Trim(tbRope.Text))                          'Added by Zach 4/24/2023
            cmd1.Parameters.AddWithValue("@model", Trim(tbModel.Text))
            cmd1.Parameters.AddWithValue("@ladder", Trim(tbLadder.Text))
            cmd1.Parameters.AddWithValue("@brackets", Trim(tbBrackets.Text))
            cmd1.Parameters.AddWithValue("@keel", Trim(tbKeel.Text))
            cmd1.Parameters.AddWithValue("@fuel", Trim(tbFuel.Text))
            cmd1.Parameters.AddWithValue("@splash", Trim(tbSplash.Text))
            cmd1.Parameters.AddWithValue("@strakes", Trim(tbStrakes.Text))
            cmd1.Parameters.AddWithValue("@strakescmts", Trim(tbStrakesCmts.Text))
            cmd1.Parameters.AddWithValue("@strbtrans", Trim(tbStrbTrans.Text))
            cmd1.Parameters.AddWithValue("@comments", Trim(tbComments.Text))
            cmd1.Parameters.AddWithValue("@black", Trim(tbBlack.Text))
            cmd1.Parameters.AddWithValue("@drawingno", Trim(tbDrawingNo.Text))
            cmd1.Parameters.AddWithValue("@megapan", Trim(tbMegaPan.Text))


            For Each Parameter As SqlParameter In cmd1.Parameters
                If Parameter.Value Is Nothing Then
                    Parameter.Value = DBNull.Value
                End If
            Next

            cmd1.CommandText = "Update OutertubeDetails Set Style = @style, Diameter = @diameter, Front = @front, Rope = @rope, TubeModel = @model, Ladder = @ladder, Bracket = @brackets, Keel = @keel, Fuel = @fuel, Splash = @splash, Strakes = @strakes, StrakesComments = @strakescmts, StrbTrans = @strbtrans, Comments = @comments, Black = @black, DrawingNo = @DrawingNo, MegaPan = @megapan, Edited = 1 Where ProdNo = @prodno1"

            cmd1.ExecuteNonQuery()

            conn.Close()
            ' gvOuters.DataBind()
            gvOuters.Rows(Key).BackColor = Drawing.Color.LightGreen 'shows what rows were changed since last load


        End If

    End Sub

    Protected Sub btnPrintable_Click(sender As Object, e As EventArgs) Handles btnPrintable.Click
        Dim selectedDate As DateTime = ddlOuterDates.SelectedValue 'get the row that is clicked
        selectedDate = selectedDate.ToShortDateString()
        Dim url As String = "../Tubes/OuterSchedule.aspx?selectedDate=" & selectedDate & ""
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,toolbars=0');popUpObj.focus()}</script>")

    End Sub

    Private Sub gvOuters_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOuters.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                If e.Row.DataItem("IsCustom") = 1 Then
                    e.Row.Cells(0).BackColor = Drawing.Color.Red
                End If
                If e.Row.DataItem("IsPilot") = 1 Then
                    e.Row.Cells(0).BackColor = Drawing.Color.Blue
                End If

                If e.Row.DataItem("Bracket") = "24 TD" Then
                    e.Row.Cells(8).BackColor = Drawing.Color.Red
                End If

                If Left(e.Row.DataItem("Comments"), 2) = "52" Then
                    e.Row.Cells(15).BackColor = Drawing.Color.Red
                End If

            Catch
            End Try

        End If
    End Sub
End Class
