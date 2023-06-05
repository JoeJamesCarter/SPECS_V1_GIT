
Partial Class CentertubeSort
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim DaystoShow As String
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        If ddlDaysInAdvance.Items.Count = 0 Then  'stop it from repopulating everytime the grid rebinds
            DaystoShow = ThisDay.AddDays(5).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("3 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(7).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("5 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(12).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("10 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(17).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("15 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(22).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("20 Days", DaystoShow))
        End If
    End Sub

    Protected Sub ShowOrderDetails(ByVal sender As Object, ByVal e As CommandEventArgs)

        Dim SONo As String = e.CommandArgument 'get the row that is clicked
        Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")

    End Sub

    Protected Sub ShowOverride(ByVal sender As Object, ByVal e As CommandEventArgs)
        Dim ProdNo As String = e.CommandArgument
        Dim url As String = "./Tubes/TubeOverride.aspx?ProdNo=" & ProdNo
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=700,height=600,toolbars=0');popUpObj.focus()}</script>")

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        Response.Redirect("CenterTubeSort.aspx")
    End Sub
End Class
