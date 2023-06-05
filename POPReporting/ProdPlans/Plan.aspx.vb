Imports System.Data
Imports System.Data.SqlClient

Partial Class ProdPlans_Plan
    Inherits System.Web.UI.Page

    Public greenlights As New DataTable
    Public firstMondayInSelectedYear As Integer
    Public dtDates As DataTable


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub ProdPlans_Plan_Load(sender As Object, e As EventArgs) Handles Me.Load
        PopulateDataTables()
        FindMondays(1, Right(ddlCalYear.SelectedValue, 2))
        PopulateDates(firstMondayInSelectedYear)

    End Sub

    Private Sub ddlCalYear_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCalYear.SelectedIndexChanged
        PopulateDataTables()
    End Sub

    Public Function PopulateDataTables() As String
        Dim selectedYear As String = ddlCalYear.SelectedValue
        selectedYear = Right(selectedYear, 2)

        Dim sqldataadapter As New SqlDataAdapter
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        'Try
        conn.Open()
        sqldataadapter.SelectCommand = New SqlCommand("SELECT ProdNo, Shrinkwrap, DueDate, BuildLoc From BML_POPREPORTING_GREENLIGHTS Where Left(ProdNo, 2) = " & selectedYear, conn)
        sqldataadapter.Fill(greenlights)
        conn.Close()
        'MesgBox(greenlights.Rows.Count)

        'conn.Close()
        conn.Dispose()

        Return False

    End Function

    Sub FindMondays(ByVal p_Month As Long, ByVal p_Year As Long)
        Dim Monday As Integer
        ' Find first Monday of month
        Monday = 8 - Weekday(DateSerial(p_Year, p_Month, 1), vbTuesday)
        ' Do
        'MesgBox("Monday in " & MonthName(p_Month) & " " & p_Year & ": " & Monday)
        'MesgBox(Monday & "-" & MonthName(p_Month))
        firstMondayInSelectedYear = Monday.ToString

        'Monday = Monday + 7  ' Add a week to previously determined Monday
        ''Loop until dateserial overflows into next month
        'Loop While Month(DateSerial(p_Year, p_Month, Monday)) = p_Month
    End Sub

    Public Function PopulateDates(ByVal firstDay As Integer) As String
        dtDates.Rows.Add(firstMondayInSelectedYear)
        January.DataSource = dtDates
        January.DataBind()
    End Function

    Private Sub January_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles January.ItemDataBound
        'Dim lblMonday As Label = DirectCast(e.Item.FindControl("lblMonday"), Label)
        'lblMonday.Text = dtJanuary(0)(0).ToString
    End Sub
End Class
