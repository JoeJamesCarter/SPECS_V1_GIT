Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Tubes_TubeOverride
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
        Dim BoatNotesProdNo As String

        BoatNotesProdNo = Request.QueryString("ProdNo")
        lblProdNo.Text = BoatNotesProdNo
        

    End Sub

    Protected Sub btnBoatNote_Click(sender As Object, e As EventArgs) Handles btnBoatNote.Click
        Dim Override As String = tbOverride.Text
        Dim ProdNo As String = lblProdNo.Text

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim url As String = "TubeOverride.aspx?ProdNo=" & ProdNo & ""
        cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
        cmd.Parameters.AddWithValue("@Override", Trim(Override))
        cmd.Parameters.AddWithValue("@ProdNo", ProdNo)


        conn.ConnectionString = connstr

        cmd.CommandType = CommandType.Text
        cmd2.CommandText = "Update BML_POPREPORTING_GREENLIGHTS Set HasOverride ='1' where ProdNo =  '" & ProdNo & "'"
        cmd.Connection = conn
        cmd2.Connection = conn


        If ddlTubeStations.SelectedValue = "" Then
            MesgBox("Please select the workstation this override should appear for.")
        Else
            Dim Tubestation As String = ddlTubeStations.SelectedValue

            conn.Open()
            cmd2.ExecuteNonQuery()

            cmd.CommandText = "Insert into BML_POPREPORTING_TUBEOVERRIDES (Date, Override, ProdNo) VALUES (@TodaysDate, @Override, @ProdNo)"
            cmd.ExecuteNonQuery()
            cmd2.CommandText = "Update BML_POPREPORTING_TUBEOVERRIDES Set " & Tubestation & "= 1 where ProdNo = '" & ProdNo & "' and Override = '" & Override & "'"
            cmd2.ExecuteNonQuery()


            MesgBox("Saved")

            ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
            'Response.Write("<script language='javascript'> { window.opener='blah';window.close();}</script>")
            tbOverride.Text = ""
            ddlTubeStations.SelectedValue = ""
            Response.Redirect(url)
        End If

    End Sub

    Protected Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        ClientScript.RegisterClientScriptBlock(GetType(Page), "Refresh", "<script language='javascript'> { window.opener.document.getElementById('btnRefresh').click();}</script>")
        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")


    End Sub
End Class
