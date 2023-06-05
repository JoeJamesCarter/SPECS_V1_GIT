Imports System.Data.SqlClient

Partial Class Barcode_EngineLabels
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub Barcode_EngineLabels_Load(sender As Object, e As EventArgs) Handles Me.Load

    End Sub

    Protected Sub tbPONo_TextChanged(sender As Object, e As EventArgs) Handles tbPONo.TextChanged
        If Not IsPostBack Then
            gvResults.DataBind()
        End If

    End Sub
    Protected Sub gvResults_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvResults.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsComments"), SqlDataSource)
            Dim po As String = DataBinder.Eval(e.Row.DataItem, "ord_no")
            ' Dim line As String = DataBinder.Eval(e.Row.DataItem, "line_no")
            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = po
                s.SelectParameters(1).DefaultValue = e.Row.Cells(1).Text

            Catch

            End Try

        End If
    End Sub


    Protected Sub gvResults_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvResults.RowCommand
        If e.CommandName = "printEngLbl" Then

            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim engModel = DirectCast(gvResults.Rows(Key).FindControl("lblEngModel"), Label).Text
            Dim gvCmts As GridView = DirectCast(gvResults.Rows(Key).FindControl("gvCmts"), GridView)

            Dim cmt1 As String = ""  'boat model
            Dim cmt2 As String = "" 'dlr
            Dim cmt3 As String = "" 'prod
            Dim cmt4 As String = "" 'use
            Dim cmt5 As String = "" 'sn

            For Each row As GridViewRow In gvCmts.Rows

                Dim seqNo As String = row.Cells(0).Text

                If seqNo = 1 Then
                    cmt1 = row.Cells(1).Text

                ElseIf seqNo = 2 Then
                    cmt2 = row.Cells(1).Text

                ElseIf seqNo = 3 Then
                    cmt3 = row.Cells(1).Text

                ElseIf seqNo = 4 Then
                    cmt4 = row.Cells(1).Text

                ElseIf seqNo = 5 Then
                    cmt5 = row.Cells(1).Text
                End If
            Next


            If Left(cmt3, 1) = 2 And Len(Trim(cmt3)) = 7 Then
                Try

                    Dim prod As String = Trim(cmt3.ToString)
                    'MesgBox(prod)
                    Dim TodaysDate As Date = Date.Now

                    Dim conn As New SqlConnection()
                    Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
                    Dim cmd As New SqlCommand

                    conn.ConnectionString = connstr
                    cmd.Connection = conn

                    cmd.Parameters.AddWithValue("@fullprodno", prod)
                    cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
                    cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET EngineStatus = 2 , Engine = @TodaysDate where ProdNo =  @fullprodno"

                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()

                Catch ex As Exception

                End Try
            End If


            If ddlPrinters.SelectedIndex = -1 Then
                MesgBox("Please Select A Printer and Try Again.")
            Else
                Dim ip_addr As String
                ip_addr = ddlPrinters.SelectedValue
                Dim port As Integer = 9100


                Dim ZPLString4x6 As String = "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD24^JUS^LRN^CI0^XZ" &
                "^XA" &
                "^MMT" &
                "^PW863" &
                "^LL1218" &
                "^LS0" &
                "^FT711,178^A0B,23,24^FH\^FDPrinted :^FS" &
                "^FT755,518^A0B,68,67^FH\^FDS/N^FS" &
                "^FT150,1068^A0B,85,96^FB764,1,0,C^FH\^FD" & engModel & "^FS" &
                "^FT601,1182^A0B,118,136^FH\^FD" & cmt4 & "^FS" &
                "^FT787,1186^A0B,135,134^FH\^FD2005986^FS" &
                "^SL0" &
                "^FT773,218^A0B,45,45" &
                "^FC%,{,#" &
                "^FD%m/%d/%y^FS" &
                "^FT64,1197^BQN,2,5" &
                "^FH\^FDLA," & engModel & "^FS" &
                "^FT672,413^BQN,2,5" &
                "^FH\^FDLA," & cmt5 & "^FS" &
                "^FT672,738^BQN,2,5" &
                "^FH\^FDLA," & cmt3 & "^FS" &
                "^FT408,1190^A0B,169,168^FH\^FD" & cmt5 & " ^FS" &
                "^PQ1,0,1,Y^XZ"

                Try
                    Dim client As New System.Net.Sockets.TcpClient
                    client.Connect(ip_addr, port)

                    'Write ZPL String to Connection
                    Dim writer As New System.IO.StreamWriter(client.GetStream())
                    writer.Write(ZPLString4x6)
                    writer.Flush()

                    writer.Close()
                    client.Close()

                Catch ex As Exception


                End Try

            End If

        End If

    End Sub


End Class
