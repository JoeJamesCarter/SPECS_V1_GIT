Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

'ToDo - Handle the enter button when problem is other after keying problem.

Partial Class Barcode_Canvas
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub btnRcv_Click(sender As Object, e As EventArgs) Handles btnRcv.Click

        'Dim fullprodno As String = tbProd.Text
        Dim fullprodno As String = lblProdNo.Text

        Dim TodaysDate As Date = Date.Now

        Dim conn As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim cmd As New SqlCommand

        cmd.CommandType = CommandType.Text
        cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET CoversStatus = '2' , CoversLastUpdated = @TodaysDate where ProdNo =  @fullprodno"

        cmd.Connection = conn

        conn.Open()

        If fullprodno.Length = 7 Then
            Try
                cmd.Parameters.AddWithValue("@fullprodno", fullprodno)
                cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)

                'cmd.ExecuteNonQuery()
                lblLastActionProd.Text = fullprodno
                lblLastActionResult.Text = "Received"
            Catch ex As Exception
                'MesgBox("Error")
            End Try

        Else : MesgBox("Error")
        End If

        tbProd.Text = ""
        tbProd.Focus()

        conn.Close()
    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbProd.Text = ""
        tbOtherProblem.Text = ""
        ddlDistinctCanvas.SelectedIndex = -1
        lblLastActionProd.Text = ""
        lblLastActionResult.Text = ""


        tbProd.Focus()
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbProd.Focus()
        btnRcv.Visible = False
        btnRGA.Visible = False
        btnSubmitRGA.Visible = False
        lblRGAColor.Visible = False
        ddlDistinctCanvas.Visible = False
        lblOtherProblem.Visible = False
        tbOtherProblem.Visible = False
    End Sub

    Protected Sub tbProd_TextChanged(sender As Object, e As EventArgs) Handles tbProd.TextChanged
        'return the canvas color from the order and set the labels with prod no and color.

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim fullprodno As String = tbProd.Text
        Dim color As String = ""

        conn.ConnectionString = connstr

        Dim cmd As New SqlCommand

        cmd.Parameters.AddWithValue("@fullprodno", fullprodno)

        cmd.Connection = conn
        cmd.CommandText = "Select Option_Desc from BML_POPREPORTINGFABOPTIONS Where ProdNo = @fullprodno and Workcenter = 'Tops' and Option_Desc like '%CANVAS%'"

        If fullprodno.Length = 7 Then
            conn.Open()
            color = cmd.ExecuteScalar
            conn.Close()

            lblProdNo.Text = fullprodno
            lblCanvasColor.Text = color
            hdnColorShouldBe.Value = color
            btnRcv.Visible = True
            btnRGA.Visible = True
        Else
            MesgBox("Prod # needs to be 7 digits.")
        End If

    End Sub

    Protected Sub btnRGA_Click(sender As Object, e As EventArgs) Handles btnRGA.Click
        'Show the rga fields and buttons

        lblRGAColor.Visible = True
        ddlDistinctCanvas.Visible = True
        btnRGA.Visible = False
        btnSubmitRGA.Visible = True
       

    End Sub

    Protected Sub btnSubmitRGA_Click(sender As Object, e As EventArgs) Handles btnSubmitRGA.Click
        'Enter RGA into Database if color is selected.
        'set canvas status to 3.
        'rga data changes if other problem is selected.

        Dim fullprodno As String = lblProdNo.Text
        lblLastActionProd.Text = fullprodno

        Dim wrongColor As String
        Dim colorShouldBe As String = hdnColorShouldBe.Value
        Dim Desc As String = "Ordered " + colorShouldBe
        Dim Reason As String = ""
        Dim TodaysDate As Date = Date.Now

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        cmd.Connection = conn
        cmd1.Connection = conn

        cmd.CommandType = CommandType.Text

        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@fullprodno", fullprodno)
        conn.Open()

        If ddlDistinctCanvas.SelectedIndex > 1 Then ' not blank and not other, but a color
            wrongColor = ddlDistinctCanvas.SelectedItem.Text
            Reason = Trim(wrongColor) + " - Delivered."
            Desc = "Ordered " + colorShouldBe
            cmd1.Parameters.AddWithValue("@ProdNo", fullprodno)
            cmd1.Parameters.AddWithValue("@Desc", Desc)
            cmd1.Parameters.AddWithValue("@Reason", Reason)
            cmd1.Parameters.AddWithValue("@TodaysDate", TodaysDate)

            cmd1.CommandText = "Insert Into CanvasRGAs (ProdNo, Description, Reason, DateAdded) VALUES (@ProdNo, @Desc, @Reason, @TodaysDate)"



            If fullprodno.Length = 7 Then
                Try
                    cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET CoversStatus = '3' , CoversLastUpdated = @TodaysDate where ProdNo =  @fullprodno"
                    'cmd.ExecuteNonQuery()
                    cmd1.ExecuteNonQuery()
                    lblLastActionResult.Text = "RGA Entered. Color is " + wrongColor + ". Should Be: " + colorShouldBe
                Catch ex As Exception
                    lblLastActionResult.Text = "Error"
                End Try

            Else : lblLastActionResult.Text = "Error"
            End If

            tbProd.Text = ""
            lblCanvasColor.Text = ""

            tbProd.Focus()

        ElseIf ddlDistinctCanvas.SelectedIndex = 1 Then ' other reason

            Reason = Trim(tbOtherProblem.Text)

            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET CoversStatus = '3' , CoversLastUpdated = @TodaysDate where ProdNo =  @fullprodno"

            cmd1.Parameters.AddWithValue("@ProdNo1", fullprodno)
            cmd1.Parameters.AddWithValue("@Desc1", Desc)
            cmd1.Parameters.AddWithValue("@Reason1", Reason)
            cmd1.Parameters.AddWithValue("@TodaysDate1", TodaysDate)
            'cmd.ExecuteNonQuery()
            cmd1.CommandText = "Insert Into CanvasRGAs (ProdNo, Description, Reason, DateAdded) VALUES (@ProdNo1, @Desc1, @Reason1, @TodaysDate1)"

            If Len(tbOtherProblem.Text) <= 0 Then
                lblLastActionResult.Text = "Please try again and enter a reason."
            Else
                cmd1.ExecuteNonQuery()
                lblLastActionResult.Text = "Other Problem: " + tbOtherProblem.Text
            End If

        Else
            lblLastActionResult.Text = "Please try again & select a color or choose other problem."
            wrongColor = ""
            Reason = ""
            Return
        End If

            conn.Close()
    End Sub


    Protected Sub ddlDistinctCanvas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDistinctCanvas.SelectedIndexChanged
        If ddlDistinctCanvas.SelectedIndex = 1 Then
            lblOtherProblem.Visible = True
            tbOtherProblem.Visible = True
            btnSubmitRGA.Visible = True
        End If
    End Sub

    Protected Sub tbOtherProblem_TextChanged(sender As Object, e As EventArgs) Handles tbOtherProblem.TextChanged
        lblLastActionProd.Text = lblProdNo.Text
        lblLastActionResult.Text = "Other Issue: " + tbOtherProblem.Text
        btnSubmitRGA_Click(sender, e)

    End Sub
End Class

