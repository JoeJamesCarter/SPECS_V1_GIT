
Partial Class Workstations_BoatsCompleted
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        lblToday.Text = ThisDay


    End Sub

End Class
