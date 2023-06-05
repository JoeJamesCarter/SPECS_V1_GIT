
Partial Class TubeSchedulePrint
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim FirstProdNoOrder As Integer = Int32.Parse(Request.QueryString("FirstProdNoOrder"))
        Dim LastProdNoOrder As Integer = Int32.Parse(Request.QueryString("LastProdNoOrder"))

        'FirstProdNoOrder = Request.QueryString("FirstProdNoOrder")

        'LastProdNoOrder = Request.QueryString("LastProdNoOrder")


        lblFirst.Text = FirstProdNoOrder
        lblLast.Text = LastProdNoOrder


    End Sub

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
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


End Class
