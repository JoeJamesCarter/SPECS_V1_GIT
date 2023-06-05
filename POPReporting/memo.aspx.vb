Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class memo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbBenPart.Focus()
    End Sub


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub btnClearSearch_Click(sender As Object, e As EventArgs) Handles btnClearSearch.Click
        tbBenPart.Text = ""
        tbVendPart.Text = ""
        tbDesc.Text = ""
        tbBenPartSelected.Text = ""
        tbVendPartSelected.Text = ""
        tbDescriptionSelected.Text = ""

        tbBenPart.Enabled = True
        tbVendPart.Enabled = True
        tbDesc.Enabled = True

    End Sub

    Protected Sub tbBenPart_TextChanged(sender As Object, e As EventArgs) Handles tbBenPart.TextChanged
        tbVendPart.Enabled = False
        tbDesc.Enabled = False
    End Sub

    Protected Sub tbVendPart_TextChanged(sender As Object, e As EventArgs) Handles tbVendPart.TextChanged
        tbBenPart.Enabled = False
        tbDesc.Enabled = False
    End Sub

    Protected Sub tbDesc_TextChanged(sender As Object, e As EventArgs) Handles tbDesc.TextChanged
        tbBenPart.Enabled = False
        tbVendPart.Enabled = False
    End Sub

    Protected Sub gvResults_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvResults.SelectedIndexChanged
        Dim key As Integer = gvResults.SelectedIndex

        Dim ben As String = gvResults.Rows(key).Cells(1).Text
        Dim vendor As String = gvResults.Rows(key).Cells(3).Text
        Dim desc As String = gvResults.Rows(key).Cells(2).Text

        ben = ben.Replace("&quot;", """")
        vendor = vendor.Replace("&quot;", """")
        desc = desc.Replace("&quot;", """")

        tbBenPartSelected.Text = ben
        tbDescriptionSelected.Text = desc
        tbVendPartSelected.Text = vendor

        'Dim u As SqlDataSource = CType(FindControl("sdsLocationsByPart"), SqlDataSource)

        'selectedDesc.Text = desc
        'selectedVendorNo.Text = vendor

        tbVendPart.Text = ""
        'lblResults.Visible = "false"

        'tbQty.Focus()

        'Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
        'u.SelectParameters(0).DefaultValue = ben
        'Catch ex As Exception

        'End Try  

        tbDesc.Text = ""
        tbBenPart.Text = ben

        'gvResults.DataBind()
        ' gvPartsOrders.DataBind()
    End Sub

    Protected Sub gvResults_DataBound(sender As Object, e As EventArgs) Handles gvResults.DataBound
        Dim numrecs As Integer = gvResults.Rows.Count
        'If only one record is returned just select it
        If numrecs = 1 Then
            gvResults.SelectRow(0)
            gvResults.Columns(0).Visible = False
            gvPartsOrders.DataBind()

        ElseIf numrecs > 1 Then
            gvResults.Columns(0).Visible = True

        End If
    End Sub

    Protected Sub btnCantFind_Click(sender As Object, e As EventArgs) Handles btnCantFind.Click
        'tbBenPartSelected.Enabled = True
        tbDescriptionSelected.Enabled = True
        'tbVendPartSelected.Enabled = True
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        Dim continueflag As Boolean = True

        If tbTO.Text = "" Or tbFrom.Text = "" Or tbDescriptionSelected.Text = "" Or tbQOH.Text = "" Then
            MesgBox("To, From, Description, Qty on Hand, Date Needed and Notes are required.")
            continueflag = False
        End If

        If continueflag Then

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            Dim TodaysDate As Date = Date.Now

            cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
            cmd.Parameters.AddWithValue("@To", tbTO.Text)
            cmd.Parameters.AddWithValue("@From", tbFrom.Text)
            cmd.Parameters.AddWithValue("@BenPartNo", tbBenPartSelected.Text)
            cmd.Parameters.AddWithValue("@VendPartNo", tbVendPartSelected.Text)
            cmd.Parameters.AddWithValue("@Desc", tbDescriptionSelected.Text)
            cmd.Parameters.AddWithValue("@QOH", tbQOH.Text)
            cmd.Parameters.AddWithValue("@DateNeeded", tbDateNeeded.Text)
            cmd.Parameters.AddWithValue("@Notes", tbNotes.Text)

            cmd.CommandText = "Insert into InventoryControlMemos(MemoDate,MemoTo,MemoFrom,BenPartNo,VendPartNo,PartDesc,QtyOnHand,DateNeeded,Notes) Values (@TodaysDate, @To, @From, @BenPartNo, @VendPartNo, @Desc, @QOH, @DateNeeded, @Notes)"
            cmd.Connection = conn

            conn.Open()

            cmd.ExecuteNonQuery()
            conn.Close()

            tbTO.Text = ""
            tbFrom.Text = ""
            tbBenPart.Text = ""
            tbVendPart.Text = ""
            tbDesc.Text = ""
            tbDateNeeded.Text = ""
            tbBenPartSelected.Text = ""
            tbVendPartSelected.Text = ""
            tbDescriptionSelected.Text = ""
            tbNotes.Text = ""
            tbQOH.Text = ""

            tbBenPart.Enabled = True
            tbVendPart.Enabled = True
            tbDesc.Enabled = True


        End If

    End Sub

    Protected Sub gvPartsOrders_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvPartsOrders.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then


            Dim requested As String = e.Row.Cells(5).Text
            Dim received As String = e.Row.Cells(6).Text

            Dim requestedY As String = Mid(requested, 3, 2)
            Dim requestedD As String = Right(requested, 2)
            Dim requestedM As String = Mid(requested, 5, 2)
            Dim requestedFullDate As String = requestedM & "/" & requestedD & "/" & requestedY

            'e.Row.Cells(5).Text = requestedFullDate

            If received <> "0" Then

                Dim receivedY As String = Mid(requested, 3, 2)
                Dim receivedD As String = Right(requested, 2)
                Dim receivedM As String = Mid(requested, 5, 2)
                Dim receivedFullDate As String = receivedM & "/" & receivedD & "/" & receivedY
                'e.Row.Cells(7).Text = receivedFullDate
            End If


        End If


    End Sub
End Class
