Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Workstations_BoatsOffline
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        lblToday.Text = ThisDay

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        cmd.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        'cmd.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where Cleared = 0 and StatusSetTo = 'Offline' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2"
        'cmd2.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where Cleared = 0 and StatusSetTo = 'Offline' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S'"
        'cmd3.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where Cleared = 0 and StatusSetTo = 'Offline' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M'"


        cmd.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2"
        'cmd.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where Cleared = 0 and BML_POPREPORTING_GREENLIGHTS.IsBoatOffline = 1 and StatusSetTo = 'Offline' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2"
        'cmd2.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where Cleared = 0 and BML_POPREPORTING_GREENLIGHTS.IsBoatOffline = 1 and StatusSetTo = 'Offline' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S'"
        cmd2.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S'"
        'cmd3.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where Cleared = 0 and StatusSetTo = 'Offline' and BML_POPREPORTING_GREENLIGHTS.IsBoatOffline = 1 and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M'"
        cmd3.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M'"
        cmd4.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V'"

        conn.Open()
        'cmd.ExecuteNonQuery()

        lblBoatsOffline.Text = cmd.ExecuteScalar
        lblS.Text = cmd2.ExecuteScalar
        lblM.Text = cmd3.ExecuteScalar
        lblV.Text = cmd4.ExecuteScalar

        conn.Close()

       

    End Sub

    Protected Sub gvProdsOffline_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvProdsOffline.RowCommand
        If e.CommandName = "gotooffline" Then
            gvProdsOffline.DataBind()
            Dim Selected As String = e.CommandArgument 'get the row that is clicked
            Dim workstation As String = "OfflineReport" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "clearsidelineitem" Then
            Dim Auto As String = e.CommandArgument 'get the row that is clicked
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "Update BML_POPREPORTING_OFFLINE Set Cleared ='1', DateCleared = '" & TodaysDate & "' where Auto =  '" & Auto & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvProdsOffline.DataBind()

        End If
    End Sub

    Protected Sub gvProdsOffline_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvProdsOffline.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsOfflineReasons"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
              
            Catch

            End Try
        End If

    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "clearmiscnote" Then
            Dim Auto As String = e.CommandArgument 'get the row that is clicked
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "Update MISC_NOTES Set Cleared ='1', DateCleared = '" & TodaysDate & "' where Auto =  '" & Auto & "'"

            conn.Open()
            cmd.ExecuteNonQuery()

            conn.Close()
            GridView1.DataBind()

        End If
    End Sub

    Protected Sub gvCompletewOpenIssues_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvCompletewOpenIssues.RowCommand
        If e.CommandName = "clearcompletesidelineitem" Then
            Dim Auto As String = e.CommandArgument 'get the row that is clicked
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "Update BML_POPREPORTING_OFFLINE Set Cleared ='1', DateCleared = '" & TodaysDate & "' where Auto =  '" & Auto & "'"

            conn.Open()
            cmd.ExecuteNonQuery()

            'MesgBox(Auto)
            conn.Close()
            gvCompletewOpenIssues.DataBind()

        End If
    End Sub

    Protected Sub gvCompletewOpenIssues_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCompletewOpenIssues.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsCompletewOfflineReasons"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try
        End If
    End Sub
End Class
