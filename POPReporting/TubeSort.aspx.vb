Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration

Partial Class TubeSort
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim DaystoShow As String
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        If ddlDaysInAdvance.Items.Count = 0 Then  'stop it from repopulating everytime the grid rebinds
            DaystoShow = ThisDay.AddDays(3).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("1 Day", DaystoShow))
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
        Response.Redirect("TubeSort.aspx")
    End Sub


    Protected Function GetLadderValue(LadderValue As Object) As String
        Dim ladderresult As String
        If LadderValue Is DBNull.Value Then
            ladderresult = ""
            Return ladderresult
        ElseIf LadderValue = "N" Then
            ladderresult = "NO LADDER"
            Return ladderresult
        ElseIf LadderValue = "Y" Then
            ladderresult = "LADDER"
            Return ladderresult
        End If
        Return ""

    End Function

    Protected Function GetRopeeyeValue(RopeeyeValue As Object) As String
        Dim ropeeyeresult As String
        If RopeeyeValue Is DBNull.Value Then
            ropeeyeresult = ""
            Return ropeeyeresult
        ElseIf RopeeyeValue = "N" Then
            ropeeyeresult = "NO ROPE EYE"
            Return ropeeyeresult
        ElseIf RopeeyeValue = "Y" Then
            ropeeyeresult = "ROPE EYE"
            Return ropeeyeresult
        End If
        Return ""

    End Function


    Protected Sub RerunPort(ByVal sender As Object, ByVal e As CommandEventArgs)
        Dim ProdNo As String = e.CommandArgument
        Dim url As String = "./Tubes/TubeRerun.aspx?ProdNo=" & ProdNo
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=750,toolbars=0');popUpObj.focus()}</script>")

    End Sub

    Protected Sub RerunStarboard(ByVal sender As Object, ByVal e As CommandEventArgs)
        Dim ProdNo As String = e.CommandArgument
        Dim url As String = "./Tubes/TubeRerun.aspx?ProdNo=" & ProdNo
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=750,toolbars=0');popUpObj.focus()}</script>")

    End Sub

    Protected Sub RerunCenter(ByVal sender As Object, ByVal e As CommandEventArgs)
        Dim ProdNo As String = e.CommandArgument
        Dim url As String = "./Tubes/TubeRerun.aspx?ProdNo=" & ProdNo
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=750,toolbars=0');popUpObj.focus()}</script>")

    End Sub

    Protected Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        Dim FirstProdNo As String = tbFirstProd.Text
        Dim LastProdNo As String = tbLastProd.Text
        Dim FirstProdNoOrder As Int32 = 0
        Dim LastProdNoOrder As Int32 = 0

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Select TubeSortOrder From BML_POPREPORTING_TUBEPRIORITY WHERE ProdNo = '" & FirstProdNo & "'"
        cmd2.CommandText = "Select TubeSortOrder From BML_POPREPORTING_TUBEPRIORITY WHERE ProdNo = '" & LastProdNo & "'"

        cmd.Connection = conn
        cmd2.Connection = conn
        conn.Open()
        cmd2.ExecuteNonQuery()
        cmd.ExecuteNonQuery()

        FirstProdNoOrder = Convert.ToInt32(cmd.ExecuteScalar())
        LastProdNoOrder = Convert.ToInt32(cmd2.ExecuteScalar())

        conn.Close()

        Dim url As String = "./TubeSchedulePrint.aspx?FirstProdNoOrder=" & FirstProdNoOrder & "&LastProdNoOrder=" & LastProdNoOrder
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=800,height=550,toolbars=0');popUpObj.focus()}</script>")

    End Sub

    Protected Sub btnPrintCenters_Click(sender As Object, e As EventArgs) Handles btnPrintCenters.Click
        Dim FirstProdNo As String = tbFirstProd.Text
        Dim LastProdNo As String = tbLastProd.Text
        Dim FirstProdNoOrder As Int32 = 0
        Dim LastProdNoOrder As Int32 = 0

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Select TubeSortOrder From BML_POPREPORTING_TUBEPRIORITY WHERE ProdNo = '" & FirstProdNo & "'"
        cmd2.CommandText = "Select TubeSortOrder From BML_POPREPORTING_TUBEPRIORITY WHERE ProdNo = '" & LastProdNo & "'"

        cmd.Connection = conn
        cmd2.Connection = conn
        conn.Open()
        cmd2.ExecuteNonQuery()
        cmd.ExecuteNonQuery()

        FirstProdNoOrder = Convert.ToInt32(cmd.ExecuteScalar())
        LastProdNoOrder = Convert.ToInt32(cmd2.ExecuteScalar())

        conn.Close()

        Dim url As String = "./CenterTubeSchedulePrint.aspx?FirstProdNoOrder=" & FirstProdNoOrder & "&LastProdNoOrder=" & LastProdNoOrder
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=800,height=550,toolbars=0');popUpObj.focus()}</script>")
    End Sub
End Class
