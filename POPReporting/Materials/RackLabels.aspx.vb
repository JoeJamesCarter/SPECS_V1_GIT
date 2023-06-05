Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Drawing.Printing

Partial Class Materials_RackLabels
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        tbBenPart.Focus()
        'tbNumLabels.Text = 2

        If Not IsPostBack Then
            ddlPrinters.SelectedIndex = -1
        End If
    End Sub


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbBenPart.Text = ""
        tbVendPart.Text = ""
        'tbQty.Text = ""
        btnPrint.Visible = False
        selectedDesc.Text = ""
        selectedVendorNo.Text = ""
        selectedUOM.Text = ""
        tbLoc1.Text = ""
        tbLoc2.Text = ""
        tbLoc3.Text = ""
        tbLoc4.Text = ""

        Dim u As SqlDataSource = CType(FindControl("sdsLocationsByPart"), SqlDataSource)
        Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
            u.SelectParameters(0).DefaultValue = tbBenPart.Text
        Catch ex As Exception

        End Try

    End Sub


    Protected Sub gvResults_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvResults.SelectedIndexChanged
        Dim key As Integer = gvResults.SelectedIndex

        tbBenPart.Text = gvResults.Rows(key).Cells(1).Text
        Dim ben As String = tbBenPart.Text
        Dim vendor As String = gvResults.Rows(key).Cells(3).Text
        Dim desc As String = gvResults.Rows(key).Cells(2).Text
        Dim uom As String = gvResults.Rows(key).Cells(4).Text

        Dim u As SqlDataSource = CType(FindControl("sdsLocationsByPart"), SqlDataSource)

        selectedDesc.Text = desc
        selectedVendorNo.Text = vendor
        selectedUOM.Text = uom

        tbVendPart.Text = ""
        lblResults.Visible = "false"

        'tbQty.Focus()

        Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
            u.SelectParameters(0).DefaultValue = ben
        Catch ex As Exception

        End Try



    End Sub


    Protected Sub gvResults_DataBound(sender As Object, e As EventArgs) Handles gvResults.DataBound
        Dim numrecs As Integer = gvResults.Rows.Count
        'If only one record is returned just select it
        If numrecs = 1 Then
            gvResults.SelectRow(0)
            gvResults.Columns(0).Visible = False
            btnPrint.Visible = "true"
        ElseIf numrecs > 1 Then
            gvResults.Columns(0).Visible = True

        End If
    End Sub

    Protected Sub tbBenPart_TextChanged(sender As Object, e As EventArgs) Handles tbBenPart.TextChanged
        'tbQty.Focus()
    End Sub

    Protected Sub gvLocations_DataBound(sender As Object, e As EventArgs) Handles gvLocations.DataBound
        Try
            If Len(tbBenPart.Text) > 0 Then
                gvLocations.Visible = True

                Dim loc1 As String = gvLocations.Rows(0).Cells(1).Text
                Dim loc2 As String = gvLocations.Rows(0).Cells(2).Text
                Dim loc3 As String = gvLocations.Rows(0).Cells(3).Text
                Dim loc4 As String = gvLocations.Rows(0).Cells(4).Text

                If loc1 = "&nbsp;" Then
                    loc1 = ""
                End If
                If loc2 = "&nbsp;" Then
                    loc2 = ""
                End If
                If loc3 = "&nbsp;" Then
                    loc3 = ""
                End If
                If loc4 = "&nbsp;" Then
                    loc4 = ""
                End If

                tbLoc1.Text = loc1
                tbLoc2.Text = loc2
                tbLoc3.Text = loc3
                tbLoc4.Text = loc4

            End If
        Catch ex As Exception

        End Try

    End Sub
    Protected Sub gvResults_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvResults.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim BenPart As String = e.Row.Cells(1).Text
            Dim Vendor As String = ""

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.Parameters.AddWithValue("@benpart", BenPart)

            cmd.CommandText = "Select top 1 payee_name from POORDLIN_SQL Left Join [APVENFIL_SQL] on POORDLIN_SQL.vend_no = APVENFIL_SQL.vend_no WHERE [item_no] = @benpart and qty_ordered > 0 order by request_dt desc"

            conn.Open()
            Vendor = cmd.ExecuteScalar()
            conn.Close()
            e.Row.Cells(5).Text = Vendor
            selectedVendor.Text = Vendor

        End If
    End Sub
    Protected Sub ddlPrinters_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlPrinters.SelectedIndexChanged
        gvResults.DataBind()
    End Sub

    Private Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        gvResults.DataBind()
    End Sub
End Class



