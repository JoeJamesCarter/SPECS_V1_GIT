Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Drawing.Printing

Partial Class Materials_RackLabelsByArea
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'tbBenPart.Focus()
        'tbNumLabels.Text = 2

        If Not IsPostBack Then
            ddlPrinters.SelectedIndex = -1
        End If
    End Sub


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub



    Protected Sub ddlAreas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlAreas.SelectedIndexChanged

    End Sub
    Protected Sub btnSelectAll_Click(sender As Object, e As EventArgs) Handles btnSelectAll.Click
        For Each row In gvItemsInArea.Rows

            Dim ItemNo As String = row.Cells(1).Text
            Dim selected As CheckBox = TryCast(row.Cells(0).FindControl("cbSelect"), CheckBox)
            selected.Checked = True

        Next
    End Sub
    Protected Sub btnDeselectAll_Click(sender As Object, e As EventArgs) Handles btnDeselectAll.Click
        For Each row In gvItemsInArea.Rows

            Dim ItemNo As String = row.Cells(1).Text
            Dim selected As CheckBox = TryCast(row.Cells(0).FindControl("cbSelect"), CheckBox)
            selected.Checked = False

        Next
    End Sub
    Protected Sub gvItemsInArea_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvItemsInArea.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim BenPart As String = e.Row.Cells(1).Text
            Dim Vendor As String = ""

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.Parameters.AddWithValue("@benpart", BenPart)

            cmd.CommandText = "Select top 1 payee_name from POORDLIN_SQL Left Join [APVENFIL_SQL] on POORDLIN_SQL.vend_no = APVENFIL_SQL.vend_no WHERE [item_no] = @benpart and qty_ordered > 0 order by request_dt desc"

            conn.Open()
            Vendor = cmd.ExecuteScalar()
            conn.Close()
            e.Row.Cells(5).Text = Vendor
        End If


    End Sub
    Protected Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        If ddlPrinters.SelectedIndex = -1 Then
            MesgBox("Please Select A Printer and Try Again.")
        Else
            Dim ip_addr = ""
            ip_addr = ddlPrinters.SelectedValue
            Dim port As Integer = 9100

            For Each row In gvItemsInArea.Rows

                Dim selected As CheckBox = TryCast(row.Cells(0).FindControl("cbSelect"), CheckBox)

                If selected.Checked = True Then
                    Dim benpart As String = row.Cells(1).Text
                    Dim Desc As String = row.Cells(3).Text
                    Dim vendorno As String = row.Cells(4).Text
                    Dim vendor As String = row.cells(5).Text
                    Dim uom As String = row.Cells(6).Text

                    Desc = Desc.Replace("&quot;", "")
                    Desc = Desc.Replace("&#39;", "'")
                    vendorno = vendorno.Replace("&quot;", "")
                    vendorno = vendorno.Replace("&#39;", "'")

                    'Dim zpl = "^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR2,2~SD8^JUS^LRN^CI0^XZ^XA^MMT^PW772^LL0406^LS0^BY2,3,135^FT295,236^B3I,N,,Y,N^FD" + benpart + "^FS^FT766,45^A0I,39,38^FH\^FD" + vendor + "^FS^FT772,107^A0I,39,38^FH\^FD" + vendorno + "^FS^FT769,163^A0I,39,38^FH\^FD" + Desc + "^FS^FT770,252^A0I,135,134^FH\^FD" + benpart + "^FS^FT127,75^A0I,28,28^FH\^FD^FS^FT68,75^A0I,28,35^FH\^FD" + Uom + " ^FS^PQ1,0,1,Y^XZ"
                    Dim zpl = "^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR2,2~SD8^JUS^LRN^CI0^XZ" &
                    "^XA" &
                    "^MMT" &
                    "^PW772" &
                    "^LL0406" &
                    "^LS0" &
                    "^BY2,3,135^FT295,236^B3I,N,,Y,N" &
                    "^FD" + benpart + "^FS" &
                    "^FT766,45^A0I,39,38^FH\^FD" + vendor + "^FS" &
                    "^FT766,107^A0I,39,38^FH\^FD" + vendorno + " ^FS" &
                    "^FT766,163^A0I,39,38^FH\^FD" + Desc + "^FS" &
                    "^FT770,252^A0I,135,134^FH\^FD" + benpart + "^FS" &
                    "^FT158,75^A0I,28,28^FH\^FDUOM:^FS" &
                    "^FT81,75^A0I,28,28^FH\^FD" + uom + "^FS" &
                    "^PQ1,0,1,Y^XZ"
                    Try

                        Dim client As New System.Net.Sockets.TcpClient
                        client.Connect(ip_addr, port)

                        'Write ZPL String to Connection
                        Dim writer As New System.IO.StreamWriter(client.GetStream())
                        writer.Write(zpl)
                        writer.Flush()

                        writer.Close()
                        client.Close()

                    Catch ex As Exception


                    End Try


                End If

            Next
        End If

    End Sub

    Protected Sub gvItemsInArea_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvItemsInArea.RowCommand
        If e.CommandName = "printone" Then 'handles when the notes button is clicked

            If ddlPrinters.SelectedIndex = -1 Then
                MesgBox("Please Select A Printer and Try Again.")
            Else
                Dim ip_addr = ""
                ip_addr = ddlPrinters.SelectedValue
                Dim port As Integer = 9100


                Dim ID As String = e.CommandArgument 'get the row that is clicked

                Dim benpart As String = gvItemsInArea.Rows(ID).Cells(1).Text
                Dim Desc As String = gvItemsInArea.Rows(ID).Cells(3).Text
                Dim vendorno As String = gvItemsInArea.Rows(ID).Cells(4).Text
                Dim vendor As String = gvItemsInArea.Rows(ID).Cells(5).Text
                Dim uom As String = gvItemsInArea.Rows(ID).Cells(6).Text

                Desc = Desc.Replace("&quot;", "")
                Desc = Desc.Replace("&#39;", "'")
                vendorno = vendorno.Replace("&quot;", "")
                vendorno = vendorno.Replace("&#39;", "'")

                'Dim zpl = "^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR2,2~SD8^JUS^LRN^CI0^XZ^XA^MMT^PW772^LL0406^LS0^BY2,3,135^FT295,236^B3I,N,,Y,N^FD" + benpart + "^FS^FT766,45^A0I,39,38^FH\^FD" + vendor + "^FS^FT772,107^A0I,39,38^FH\^FD" + vendorno + "^FS^FT769,163^A0I,39,38^FH\^FD" + Desc + "^FS^FT770,252^A0I,135,134^FH\^FD" + benpart + "^FS^FT127,75^A0I,28,28^FH\^FD^FS^FT68,75^A0I,28,35^FH\^FD" + Uom + " ^FS^PQ1,0,1,Y^XZ"
                Dim zpl = "^XA~TA000~JSN^LT0^MNN^MTD^PON^PMN^LH0,0^JMA^PR2,2~SD8^JUS^LRN^CI0^XZ" &
                        "^XA" &
                        "^MMT" &
                        "^PW772" &
                        "^LL0406" &
                        "^LS0" &
                        "^BY2,3,135^FT295,236^B3I,N,,Y,N" &
                        "^FD" + benpart + "^FS" &
                        "^FT766,45^A0I,39,38^FH\^FD" + vendor + "^FS" &
                        "^FT766,107^A0I,39,38^FH\^FD" + vendorno + " ^FS" &
                        "^FT766,163^A0I,39,38^FH\^FD" + Desc + "^FS" &
                        "^FT770,252^A0I,135,134^FH\^FD" + benpart + "^FS" &
                        "^FT158,75^A0I,28,28^FH\^FDUOM:^FS" &
                        "^FT81,75^A0I,28,28^FH\^FD" + uom + "^FS" &
                        "^PQ1,0,1,Y^XZ"
                Try

                    Dim client As New System.Net.Sockets.TcpClient
                    client.Connect(ip_addr, port)

                    'Write ZPL String to Connection
                    Dim writer As New System.IO.StreamWriter(client.GetStream())
                    writer.Write(zpl)
                    writer.Flush()

                    writer.Close()
                    client.Close()

                Catch ex As Exception


                End Try


            End If
        End If

    End Sub
End Class



