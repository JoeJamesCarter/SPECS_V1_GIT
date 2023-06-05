Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls


Partial Class LoadCompletionRptForAcct
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim LoadNo As String
        Dim PlannedLoadDate As String 'This and the load no return the proper records regardless of date marked complete.

        LoadNo = Request.QueryString("Load")
        PlannedLoadDate = Request.QueryString("SelectedDate")

        lblLoadNo.Text = LoadNo

        Dim s As SqlDataSource = CType(FindControl("sdsDlrBoats"), SqlDataSource)

        Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
            s.SelectParameters(0).DefaultValue = LoadNo
            s.SelectParameters(1).DefaultValue = PlannedLoadDate

        Catch

        End Try

        Dim DateMarkedComplete As String = gvDlrBoats.Rows(0).Cells(11).Text
        lblMarkedAsLoaded.Text = DateMarkedComplete
    End Sub

   
    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        'loop gridview and check for any boat that does not have a data on trailer.  If any boat has not be dated on a trailer, the submit should fail.

    End Sub
End Class
