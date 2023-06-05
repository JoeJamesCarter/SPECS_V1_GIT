Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.IO

Partial Class HotList
    Inherits System.Web.UI.Page

    Public Class GlobalVariables
        Public Shared stationID As String
    End Class
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
        user = GlobalVariables.stationID.ToUpper


        If user = "TLEITZ" Or user = "KRIMBA" Or user = "CBATES" Then
            btnMaintain.Visible = True
            gvRails.Columns(18).Visible = True
            ' LinkButton1.Visible = True
        Else
            btnMaintain.Visible = False
            gvRails.Columns(18).Visible = False
            'LinkButton1.Visible = False

        End If
    End Sub
 
    Protected Function SplitBValSlash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("\")(1)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvRails_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvRails.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rails" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvRails.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rails" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "gotofullorderdetails" Then 'handles when the ? button is clicked
            gvRails.DataBind()
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetailsFull.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,toolbars=1, height=1200');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "removefromhotlist" Then
            Dim ProdNo As String = e.CommandArgument
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.Parameters.AddWithValue("@ProdNo", ProdNo)
            conn.Open()
            cmd.CommandText = "Update HotList Set Disabled = 2 where ProdNo = @ProdNo"
            cmd.ExecuteNonQuery()
            conn.Close()
            gvRails.DataBind()
        End If
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvRails.DataBind()
    End Sub

    Protected Sub gvRails_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRails.RowDataBound
        Dim TodaysDate As Date = Date.Now

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim gvRailsData As GridView = e.Row.FindControl("gvRailsData")

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsOfflineReasons"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsBoatNotes"), SqlDataSource)
            Dim v As SqlDataSource = CType(e.Row.FindControl("sdsRailsData"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                v.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try

            e.Row.Cells(0).ToolTip = "Prod #"
            e.Row.Cells(1).ToolTip = "Furniture"
            e.Row.Cells(2).ToolTip = "Fiberglass"
            e.Row.Cells(3).ToolTip = "Canvas"
            e.Row.Cells(4).ToolTip = "Rails"
            e.Row.Cells(5).ToolTip = "Tubes"
            e.Row.Cells(6).ToolTip = "Center Tube"
            e.Row.Cells(7).ToolTip = "Gauge/Harness"
            e.Row.Cells(8).ToolTip = "Q Front"
            e.Row.Cells(9).ToolTip = "Arch/Tower"
            e.Row.Cells(10).ToolTip = "Helm Built"
            e.Row.Cells(11).ToolTip = "Boat/Customer"
            e.Row.Cells(12).ToolTip = "Custom"
            e.Row.Cells(13).ToolTip = "Pilot"

            If (e.Row.DataItem("ProdLineID") = "1") Then
                e.Row.BackColor = Drawing.Color.LightGray
            ElseIf (e.Row.DataItem("ProdLineID") = "2") Then
                e.Row.BackColor = Drawing.Color.LightBlue
            End If

            Try
                Dim DropDead As Date = e.Row.DataItem("DropDeadShipDate")
                Dim RedFlag As Date = DateAdd("d", 7, TodaysDate) '7 days before the ship date, highlight it orange.
                '    MesgBox(DropDead)
                '    MesgBox(RedFlag)

                If DropDead <= RedFlag Then
                    e.Row.Cells(0).BackColor = Drawing.Color.Orange
                End If
            Catch ex As Exception

            End Try


            Try
                If e.Row.DataItem("ItemNo") Like "*QX*" Or e.Row.DataItem("ItemNo") Like "*5RXS*" Then
                    gvRailsData.Visible = False
                End If

            Catch ex As Exception

            End Try
        End If
    End Sub

    Protected Sub gvRailsData_RowDataBound(sender As Object, e As GridViewRowEventArgs)



        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                If e.Row.DataItem("CustDrawNo") = "" Then
                    e.Row.Cells(7).BackColor = System.Drawing.Color.White
                Else
                    e.Row.Cells(7).BackColor = System.Drawing.Color.Yellow
                End If
            Catch ex As Exception

            End Try

        End If
    End Sub

    Protected Sub btnMaintain_Click(sender As Object, e As EventArgs) Handles btnMaintain.Click
        Dim url As String = "./MaintainHotList.aspx"
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,toolbars=1');popUpObj.focus()}</script>")
    End Sub

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnExport.Click
        ExportExcel("HotList", gvRails)
    End Sub

    Public Sub ExportExcel(ByVal filename As String, ByVal gv As GridView)
        HideDetailButtons()
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=" & filename & ".xls")
        Response.ContentType = "application/vnd.ms-excel"
        Dim sw As New StringWriter()

        Dim htw As New HtmlTextWriter(sw)

        gv.RenderControl(htw)
        Response.Write(sw.ToString())
        Response.Flush()
        Response.[End]()
        ShowDetailButtons()
    End Sub

    Protected Function HideDetailButtons() As String
        For Each row As GridViewRow In gvRails.Rows
            Dim IMG1 As ImageButton = TryCast(row.Cells(0).FindControl("ImageButton1"), ImageButton)
            Dim IMG2 As ImageButton = TryCast(row.Cells(0).FindControl("ImageButton2"), ImageButton)
            IMG1.Visible = False
            IMG2.Visible = False
        Next
        Return ""
    End Function

    Protected Function ShowDetailButtons() As String
        For Each row As GridViewRow In gvRails.Rows
            Dim IMG1 As ImageButton = TryCast(row.Cells(0).FindControl("ImageButton1"), ImageButton)
            Dim IMG2 As ImageButton = TryCast(row.Cells(0).FindControl("ImageButton2"), ImageButton)
            IMG1.Visible = True
            IMG2.Visible = True
        Next
        Return ""
    End Function
End Class
