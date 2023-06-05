Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Tubes_InspectACenter
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Dim lblProdNo As Label
        Dim ProdNo As String

        ProdNo = Request.QueryString("ProdNo")
        lblProdNo.Text = ProdNo
       

    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs)
        Dim Prod As String = lblProdNo.Text
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        Dim rblLength As RadioButtonList = DirectCast(gvRoller.Rows(0).Cells(2).FindControl("rblLengthStatus"), RadioButtonList)
        Dim lengthStatus As Integer = rblLength.SelectedValue

        Dim rblStyle As RadioButtonList = DirectCast(gvRoller.Rows(0).Cells(3).FindControl("rblStyleStatus"), RadioButtonList)
        Dim styleStatus As Integer = rblStyle.SelectedValue

        Dim rblStorage As RadioButtonList = DirectCast(gvRoller.Rows(0).Cells(4).FindControl("rblStorageStatus"), RadioButtonList)
        Dim storageStatus As Integer = rblStorage.SelectedValue

        Dim rblBrackets As RadioButtonList = DirectCast(gvRoller.Rows(0).Cells(5).FindControl("rblBracketStatus"), RadioButtonList)
        Dim bracketStatus As Integer = rblBrackets.SelectedValue

        Dim rblFuel As RadioButtonList = DirectCast(gvRoller.Rows(0).Cells(6).FindControl("rblFuelStatus"), RadioButtonList)
        Dim fuelStatus As Integer = rblFuel.SelectedValue

        Dim rblSplash As RadioButtonList = DirectCast(gvRoller.Rows(0).Cells(7).FindControl("rblSplashStatus"), RadioButtonList)
        Dim splashStatus As Integer = rblSplash.SelectedValue

        Dim rblChines As RadioButtonList = DirectCast(gvRoller.Rows(0).Cells(8).FindControl("rblChinesStatus"), RadioButtonList)
        Dim chinesStatus As Integer = rblChines.SelectedValue

        Dim rblKeel As RadioButtonList = DirectCast(gvRoller.Rows(0).Cells(9).FindControl("rblKeelStatus"), RadioButtonList)
        Dim keelStatus As Integer = rblKeel.SelectedValue

        Dim rblInspection As RadioButtonList = DirectCast(gvRoller.Rows(0).Cells(10).FindControl("rblInspectionStatus"), RadioButtonList)
        Dim inspectionStatus As Integer = rblInspection.SelectedValue

        Dim tbNote As TextBox = DirectCast(gvRoller.Rows(0).Cells(10).FindControl("tbInsNotes"), TextBox)
        Dim Note As String = tbNote.Text

        Dim InspectionNote As String = tbNote.text

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn

        cmd.CommandType = CommandType.Text
        cmd1.CommandType = CommandType.Text

        cmd.CommandText = "UPDATE CenterInspection SET LengthStatus = '" & lengthStatus & "', StyleStatus = '" & styleStatus & "', StorageStatus = '" & storageStatus & "', BracketStatus = '" & bracketStatus & "', FuelStatus = '" & fuelStatus & "', SplashStatus = '" & splashStatus & "', ChinesStatus = '" & chinesStatus & "', KeelStatus = '" & keelStatus & "', InspectionStatus = '" & inspectionStatus & "', InspectionDate = '" & TodaysDate & "', InspectionNotes = '" & Note & "' where ProdNo =  '" & Prod & "'"
        cmd1.CommandText = "INSERT Into CenterInspection_FailureLog (ProdNo, LengthStatus,StyleStatus,StorageStatus,BracketStatus,FuelStatus,SplashStatus,ChinesStatus,KeelStatus,InspectionStatus,InspectionDate,InspectionNotes) VALUES( '" & Prod & "', '" & lengthStatus & "', '" & styleStatus & "', '" & storageStatus & "', '" & bracketStatus & "', '" & fuelStatus & "', '" & splashStatus & "', '" & chinesStatus & "', '" & keelStatus & "', '" & inspectionStatus & "', '" & TodaysDate & "', '" & InspectionNote & "')"
        conn.Open()
        cmd.ExecuteNonQuery()

        'Log all failures to transactions
        If lengthStatus = 1 Or styleStatus = 1 Or storageStatus = 1 Or bracketStatus = 1 Or fuelStatus = 1 Or splashStatus = 1 Or chinesStatus = 1 Or keelStatus = 1 Or inspectionStatus = 1 Then
            Try
                cmd1.ExecuteNonQuery()
            Catch ex As Exception

            End Try
        End If
        conn.Close()

        ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
        Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")

    End Sub
End Class
