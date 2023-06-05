Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Warranty_AddWarrantyRepair
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        pnlAddABoat.Visible = False
        btnHideForm.Visible = False
        dvAddBoat.ChangeMode(FormViewMode.Insert)

    End Sub

    Protected Sub btnShowAddABoat_Click(sender As Object, e As EventArgs) Handles btnShowAddABoat.Click
        pnlAddABoat.Visible = True
        btnHideForm.Visible = True
    End Sub

    Protected Sub btnHideForm_Click(sender As Object, e As EventArgs) Handles btnHideForm.Click
        pnlAddABoat.Visible = False
    End Sub

    Protected Sub calReturnDate_SelectionChanged(sender As Object, e As EventArgs)

        pnlAddABoat.Visible = True

    End Sub


    Protected Sub calDateofArrival_SelectionChanged(sender As Object, e As EventArgs)
        pnlAddABoat.Visible = True

    End Sub

    Protected Sub calDateofArrival_VisibleMonthChanged(sender As Object, e As MonthChangedEventArgs)
        pnlAddABoat.Visible = True
    End Sub

    Protected Sub calReturnDate_VisibleMonthChanged(sender As Object, e As MonthChangedEventArgs)
        pnlAddABoat.Visible = True
    End Sub

    Function FixDBNull(ByVal inVal As Object) As DateTime
        If inVal Is DBNull.Value Then
            Return DateTime.Now
        Else
            Return inVal
        End If
    End Function

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        GridView1.DataBind()
    End Sub
End Class
