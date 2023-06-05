Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.IO

Partial Class Gates_Scheduling
    Inherits System.Web.UI.Page

    Public GateLabels As New DataTable
    Public GateDrawings As New DataTable

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
    End Sub
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvGatesSchedule_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvGatesSchedule.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim Blackout As String = e.Row.Cells(2).Text

            If Blackout = "1" Then
                e.Row.Cells(2).Text = "Blackout"
            Else
                e.Row.Cells(2).Text = ""
            End If

            If (e.Row.DataItem("IsCustom") = "1") Then
                e.Row.Cells(1).BackColor = Drawing.Color.Yellow
            End If

        End If

    End Sub

    Protected Sub gvGatesSchedule_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvGatesSchedule.RowCommand
        If e.CommandName = "savegatechanges" Then
            'This code is for the load button

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand

            cmd.Connection = conn


            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = sender.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim lblNumGates As Label = sender.Row.FindControl("lblNumGates").text
            'Dim numgatesTB As TextBox = DirectCast(gvGatesSchedule.Rows(Key).FindControl("tbNumGates"), TextBox)
            'Dim numgates As String = numgatesTB.Text
            Dim numgates As String = lblNumGates.Text
            MesgBox(numgates)

            Dim gate_1_dl As DropDownList = DirectCast(gvGatesSchedule.Rows(Key).Cells(3).FindControl("ddlGate1"), DropDownList)
            Dim gate_1 As String

            Dim gate_2_dl As DropDownList = DirectCast(gvGatesSchedule.Rows(Key).Cells(4).FindControl("ddlGate2"), DropDownList)
            Dim gate_2 As String

            Dim gate_3_dl As DropDownList = DirectCast(gvGatesSchedule.Rows(Key).Cells(5).FindControl("ddlGate3"), DropDownList)
            Dim gate_3 As String

            Dim gate_4_dl As DropDownList = DirectCast(gvGatesSchedule.Rows(Key).Cells(6).FindControl("ddlGate4"), DropDownList)
            Dim gate_4 As String 

            Dim gate_5_dl As DropDownList = DirectCast(gvGatesSchedule.Rows(Key).Cells(7).FindControl("ddlGate5"), DropDownList)
            Dim gate_5 As String

            Dim gate_6_dl As DropDownList = DirectCast(gvGatesSchedule.Rows(Key).Cells(8).FindControl("ddlGate6"), DropDownList)
            Dim gate_6 As String

            cmd.Parameters.AddWithValue("@numgates", numgates)

            If gate_1_dl.SelectedIndex = 0 Then
                cmd.Parameters.AddWithValue("@gate1", DBNull.Value)
            Else
                gate_1 = gate_1_dl.SelectedValue
                cmd.Parameters.AddWithValue("@gate1", gate_1)
            End If

            If gate_2_dl.SelectedIndex = 0 Then
                cmd.Parameters.AddWithValue("@gate2", DBNull.Value)
            Else
                gate_2 = gate_2_dl.SelectedValue
                cmd.Parameters.AddWithValue("@gate2", gate_2)
            End If

            If gate_3_dl.SelectedIndex = 0 Then
                cmd.Parameters.AddWithValue("@gate3", DBNull.Value)
            Else
                gate_3 = gate_3_dl.SelectedValue
                cmd.Parameters.AddWithValue("@gate3", gate_3)
            End If

            If gate_4_dl.SelectedIndex = 0 Then
                cmd.Parameters.AddWithValue("@gate4", DBNull.Value)
            Else
                gate_4 = gate_4_dl.SelectedValue
                cmd.Parameters.AddWithValue("@gate4", gate_4)
            End If

            If gate_5_dl.SelectedIndex = 0 Then
                cmd.Parameters.AddWithValue("@gate5", DBNull.Value)
            Else
                gate_5 = gate_5_dl.SelectedValue
                cmd.Parameters.AddWithValue("@gate5", gate_5)
            End If

            If gate_6_dl.SelectedIndex = 0 Then
                cmd.Parameters.AddWithValue("@gate6", DBNull.Value)
            Else
                gate_6 = gate_6_dl.SelectedValue
                cmd.Parameters.AddWithValue("@gate6", gate_6)
            End If

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update Gates_ByProd Set NumGates = @numgates, BowCtr = @gate1, Port = @gate2, Strb = @gate3, AftPort = @gate4, AftCtr = @gate5, AftStrb = @gate6 where ProdNo = '" & SelectedProdNo & "'"

            conn.Open()
            cmd.ExecuteNonQuery()



            conn.Close()
            gvGatesSchedule.DataBind()

        End If
    End Sub

    Private Sub btnExportGateLabels_Click(sender As Object, e As EventArgs) Handles btnExportGateLabels.Click
        GateLabels.Columns.Add("Prod")
        GateLabels.Columns.Add("Model")
        GateLabels.Columns.Add("Black")
        GateLabels.Columns.Add("Location")
        GateLabels.Columns.Add("Drawing")
        GateLabels.Columns.Add("ColorRef")
        GateLabels.Columns.Add("Barcode")

        For Each row As GridViewRow In gvGatesSchedule.Rows

            Dim Prod As String = row.Cells(0).Text
            Dim ModelLbl As Label = DirectCast(row.Cells(1).FindControl("lblModel"), Label)
            Dim Model As String = ModelLbl.Text
            Dim Blackout As String = row.Cells(2).Text
            Dim ColorRefRec As DataRow()
            Dim ColorRef As String = ""
            Dim Barcode As String = ""
            Dim ddlGate1 As DropDownList = DirectCast(row.FindControl("ddlGate1"), DropDownList) 'bowctr
            Dim ddlGate2 As DropDownList = DirectCast(row.FindControl("ddlGate2"), DropDownList) 'port
            Dim ddlGate3 As DropDownList = DirectCast(row.FindControl("ddlGate3"), DropDownList) 'strb
            Dim ddlGate4 As DropDownList = DirectCast(row.FindControl("ddlGate4"), DropDownList) 'aft port
            Dim ddlGate5 As DropDownList = DirectCast(row.FindControl("ddlGate5"), DropDownList) 'aft ctr
            Dim ddlGate6 As DropDownList = DirectCast(row.FindControl("ddlGate6"), DropDownList) 'aft strb
            Dim Location As String = ""
            Dim LocationBC As String = ""
            Dim Drawing As String = ""

            If ddlGate1.SelectedIndex > -1 Then
                Location = "Bow Ctr"
                LocationBC = "BC"
                Drawing = ddlGate1.SelectedValue
                ColorRefRec = GateDrawings.Select("DrawingNo =  '" & Drawing & "'")
                Barcode = Trim(Prod) & "_" & LocationBC & "_" & Drawing
                Try
                    ColorRef = ColorRefRec(0)(1).ToString.ToUpper
                Catch
                End Try

                GateLabels.Rows.Add(Prod, Model, Blackout, Location, Drawing, ColorRef, Barcode)
            End If

            If ddlGate2.SelectedIndex <> 0 Then
                Location = "Port"
                LocationBC = "P"
                Drawing = ddlGate2.SelectedValue
                ColorRefRec = GateDrawings.Select("DrawingNo =  '" & Drawing & "'")
                Barcode = Trim(Prod) & "_" & LocationBC & "_" & Drawing
                Try
                    ColorRef = ColorRefRec(0)(1).ToString.ToUpper
                Catch
                End Try

                GateLabels.Rows.Add(Prod, Model, Blackout, Location, Drawing, ColorRef, Barcode)
            End If

            If ddlGate3.SelectedIndex <> 0 Then
                Location = "Strb"
                LocationBC = "S"
                Drawing = ddlGate3.SelectedValue
                ColorRefRec = GateDrawings.Select("DrawingNo =  '" & Drawing & "'")
                Barcode = Trim(Prod) & "_" & LocationBC & "_" & Drawing
                Try
                    ColorRef = ColorRefRec(0)(1).ToString.ToUpper
                Catch
                End Try

                GateLabels.Rows.Add(Prod, Model, Blackout, Location, Drawing, ColorRef, Barcode)
            End If

            If ddlGate4.SelectedIndex <> 0 Then
                Location = "Aft Port"
                LocationBC = "AP"
                Drawing = ddlGate4.SelectedValue
                ColorRefRec = GateDrawings.Select("DrawingNo =  '" & Drawing & "'")
                Barcode = Trim(Prod) & "_" & LocationBC & "_" & Drawing
                Try
                    ColorRef = ColorRefRec(0)(1).ToString.ToUpper
                Catch
                End Try

                GateLabels.Rows.Add(Prod, Model, Blackout, Location, Drawing, ColorRef, Barcode)
            End If

            If ddlGate5.SelectedIndex <> 0 Then
                Location = "Aft Ctr"
                LocationBC = "AC"
                Drawing = ddlGate5.SelectedValue
                ColorRefRec = GateDrawings.Select("DrawingNo =  '" & Drawing & "'")
                Barcode = Trim(Prod) & "_" & LocationBC & "_" & Drawing
                Try
                    ColorRef = ColorRefRec(0)(1).ToString.ToUpper
                Catch
                End Try

                GateLabels.Rows.Add(Prod, Model, Blackout, Location, Drawing, ColorRef, Barcode)
            End If

            If ddlGate6.SelectedIndex <> 0 Then
                Location = "Aft Strb"
                LocationBC = "AS"
                Drawing = ddlGate6.SelectedValue
                ColorRefRec = GateDrawings.Select("DrawingNo =  '" & Drawing & "'")
                Barcode = Trim(Prod) & "_" & LocationBC & "_" & Drawing
                Try
                    ColorRef = ColorRefRec(0)(1).ToString.ToUpper
                Catch
                End Try

                GateLabels.Rows.Add(Prod, Model, Blackout, Location, Drawing, ColorRef, Barcode)
            End If
        Next
        gvExportedLabels.Visible = True
        Dim dv As DataView = GateLabels.DefaultView
        dv.Sort = "ColorRef, Drawing"
        gvExportedLabels.DataSource = dv
        gvExportedLabels.DataBind()
        ExportExcel("GateLabels", gvExportedLabels)
        'gvExportedLabels.Visible = False

    End Sub

    Public Sub ExportExcel(ByVal filename As String, ByVal gv As GridView)

        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=" & filename & ".xls")
        Response.ContentType = "application/vnd.ms-excel"
        Dim sw As New StringWriter()
        Dim htw As New HtmlTextWriter(sw)
        gv.RenderControl(htw)
        Response.Write(sw.ToString())
        Response.[End]()

    End Sub

    Private Sub Gates_Scheduling_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim conn As New SqlConnection()
        Dim SqlDataAdapter As New SqlDataAdapter
        Dim connstr As String = ConfigurationManager.ConnectionStrings("ProductInfoConnectionString").ConnectionString

        Dim cmd As New SqlCommand

        cmd.Connection = conn
        conn.ConnectionString = connstr

        conn.Open()
        SqlDataAdapter.SelectCommand = New SqlCommand("Select RTrim(DrawingNo) as DrawingNo, RTrim(ColorRef) as ColorRef from Drawings where RTrim(Category) = 'GATE' Order By DrawingNo", conn)
        SqlDataAdapter.Fill(GateDrawings)
        'MesgBox(GateDrawings.Rows.Count)
        conn.Close()

    End Sub

    Protected Sub myDDList_DataBinding1(sender As Object, e As EventArgs)
        Dim ddList As DropDownList = CType(sender, DropDownList)
        RemoveHandler ddList.DataBinding, AddressOf myDDList_DataBinding1
        Try
            ddList.DataBind()
        Catch ex As ArgumentOutOfRangeException
            ddList.SelectedValue = ""  ' or whatever value you have for the page dropdownlist
            ddList.BackColor = Drawing.Color.Red
            EmailKeri()
        End Try
    End Sub

    Protected Sub EmailKeri()

        Dim SmtpServer As New Net.Mail.SmtpClient()
        Dim mail As New Net.Mail.MailMessage
        'SmtpServer.Host = "elkhart.benningtonmarine.com"
        SmtpServer.Credentials = New System.Net.NetworkCredential("svccopier_smtp@polarisind.com", "dccGqWkzFWrFM4")
        SmtpServer.Host = "smtp.office365.com"
        'SmtpServer.Host = "polaris-com.mail.protection.outlook.com"
        SmtpServer.EnableSsl = True
        SmtpServer.Port = 587

        'mail.From = New Net.Mail.MailAddress("krimbaugh@benningtonmarine.com")
        mail.IsBodyHtml = True
        mail.From = New Net.Mail.MailAddress("svccopier_smtp@polaris.com", "SPECS")
        mail.To.Add("krimbaugh@benningtonmarine.com")
        mail.Subject = "Gate Missing in Drawings List"
        mail.Body = "Request sent from Gates Scheduling on Load. Schedule for " & Calendar1.SelectedDate & " has a gate that is missing from the drawings list."
        SmtpServer.Send(mail)

        Response.Write("<script language='javascript'> { window.opener='mywindow';window.close();}</script>")
    End Sub

End Class
