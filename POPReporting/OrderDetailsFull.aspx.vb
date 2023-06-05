Imports System.Data
Imports System.Data.SqlClient
Partial Class OrderDetailsFull
    Inherits System.Web.UI.Page

    Public furncatalog As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Dim lblProdNo As Label
        Dim BoatSONo As String

        'Dim isPilot As String = GridView3.Rows(0).Cells(3).Text

        BoatSONo = Request.QueryString("SONo")
        hdnSONo.Value = BoatSONo
        hdnSONoSkip2LeadingZeros.Value = Right(BoatSONo, Len(BoatSONo) - 2)
        hdnBoatModel.Value = GridView3.Rows(0).Cells(1).Text
        hdnBoatYear.Value = Left(GridView3.Rows(0).Cells(0).Text, 2)
        hdnProdNo.Value = GridView3.Rows(0).Cells(0).Text


        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        cmd.CommandType = CommandType.Text
        cmd.Connection = conn
        cmd1.Connection = conn

        Dim CustomDrawingNo As String
        Dim HasSerialPart As String

        'cmd.CommandText = "Select user_def_fld_5 FROM OEORDHDR_SQL where ord_no =  '" & hdnSONo.Value & "'"
        cmd.CommandText = "Select extra_8 FROM OEORDHDR_SQL where ord_no =  '" & hdnSONo.Value & "'"
        cmd1.CommandText = "Select Count(item_no) FROM OEORDLIN_SQL where ord_no =  '" & hdnSONo.Value & "' and item_no like 'SERIAL%'"

        conn.Open()
        CustomDrawingNo = Convert.ToString(cmd.ExecuteScalar())
        HasSerialPart = Convert.ToString(cmd1.ExecuteScalar)

        hdnCustomDrawingNo.Value = CustomDrawingNo
        hdnSerialPart.Value = HasSerialPart

        If hdnSerialPart.Value = 1 Then
            hdnBoatYear.Value = hdnBoatYear.Value + 1
        End If

        Image1.Visible = False
        Image2.Visible = False
        Image3.Visible = False
        Image4.Visible = False
        Image5.Visible = False
        Image6.Visible = False
        Image7.Visible = False
        Image8.Visible = False
        Image9.Visible = False
        Image10.Visible = False
        Image11.Visible = False
        Image12.Visible = False
        Image13.Visible = False
        Image14.Visible = False
        Image15.Visible = False
        Image16.Visible = False
        Image17.Visible = False
        Image18.Visible = False
        Image19.Visible = False
        Image20.Visible = False
        Image21.Visible = False
        Image22.Visible = False
        Image23.Visible = False
        Image24.Visible = False
        Image25.Visible = False
        Image26.Visible = False
        Image27.Visible = False
        Image28.Visible = False
        Image29.Visible = False
        Image30.Visible = False

        Dim SqlDataAdapter As New SqlDataAdapter
        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1

        conn1.Open()
        SqlDataAdapter.SelectCommand = New SqlCommand("Select SERIES_PART, BASE_VINYL_PART,PRIMARY_ACCENT_PART, BENCH_IMG_URL, RECLINER_IMG_URL FROM Furniture_Combinations ", conn1)
        SqlDataAdapter.Fill(furncatalog)

        conn1.Close()
        conn1.Dispose()

        conn.Close()
        conn.Dispose()

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

    Protected Sub gvReasons_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReasons.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                If e.Row.DataItem("Cleared") <> 1 Then
                    e.Row.BackColor = Drawing.Color.LightYellow
                End If
            Catch ex As Exception

            End Try
        End If
    End Sub

    Private Sub gvGreenlights_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvGreenlights.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Cells(0).ToolTip = "F-" & e.Row.DataItem("FurniturePrepLastUpdated")
            e.Row.Cells(1).ToolTip = "FG-" & e.Row.DataItem("FiberglassLastUpdated")
            e.Row.Cells(2).ToolTip = "C-" & e.Row.DataItem("CoversLastUpdated")
            e.Row.Cells(3).ToolTip = "R- Weld Date - " & e.Row.DataItem("WeldDate") & "   Status Last Updated -" & e.Row.DataItem("RailsLastUpdated")
            e.Row.Cells(4).ToolTip = "T- Weld Date - " & e.Row.DataItem("OuterScheduled") & "   Status Last Updated - " & e.Row.DataItem("TubesLastUpdated")
            e.Row.Cells(5).ToolTip = "CT- Weld Date - " & e.Row.DataItem("CenterScheduled") & "   Status Last Updated - " & e.Row.DataItem("Centertube")
            e.Row.Cells(6).ToolTip = "G-" & e.Row.DataItem("GaugeLastUpdated") & "  H-" & e.Row.DataItem("HarnessLastUpdated")
            e.Row.Cells(7).ToolTip = "Arch/Tower-" & e.Row.DataItem("ArchTower")

        End If
    End Sub

    Protected Sub gvOverview_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOverview.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Try
                e.Row.Cells(0).ToolTip = e.Row.DataItem("FloorsInstalled")
            Catch
            End Try

            Try
                e.Row.Cells(1).ToolTip = e.Row.DataItem("Trim")
            Catch
            End Try
            Try
                e.Row.Cells(2).ToolTip = e.Row.DataItem("RailsInstalled")
            Catch
            End Try
            Try
                e.Row.Cells(3).ToolTip = e.Row.DataItem("FurnitureInstalled")
            Catch ex As Exception

            End Try
            Try
                e.Row.Cells(4).ToolTip = e.Row.DataItem("HelmInstalled")
            Catch ex As Exception

            End Try
            Try
                e.Row.Cells(5).ToolTip = e.Row.DataItem("Cleaning")
            Catch ex As Exception

            End Try
            Try
                e.Row.Cells(6).ToolTip = e.Row.DataItem("FinalInspection")
            Catch ex As Exception

            End Try
            Try
                e.Row.Cells(7).ToolTip = e.Row.DataItem("Shrinkwrap")
            Catch ex As Exception

            End Try
            Try
                e.Row.Cells(8).ToolTip = e.Row.DataItem("Rigging")
            Catch ex As Exception

            End Try
            Try
                e.Row.Cells(9).ToolTip = e.Row.DataItem("WavetamerInstalled")
            Catch ex As Exception

            End Try
            Try
                e.Row.Cells(10).ToolTip = e.Row.DataItem("SharkhideInstalled")
            Catch ex As Exception

            End Try
            Try
                e.Row.Cells(11).ToolTip = e.Row.DataItem("Complete")
            Catch ex As Exception

            End Try






        End If
    End Sub
    Protected Sub gvRailRepairs_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRailRepairs.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim PF As String = e.Row.Cells(2).Text
            Dim SF As String = e.Row.Cells(3).Text
            Dim PR As String = e.Row.Cells(4).Text
            Dim SR As String = e.Row.Cells(5).Text
            Dim T As String = e.Row.Cells(6).Text
            Dim PM As String = e.Row.Cells(7).Text
            Dim SM As String = e.Row.Cells(8).Text
            Dim Status As String = e.Row.Cells(10).Text
            Dim ReRcvd As String = e.Row.Cells(12).Text

            If PF = "1" Then
                e.Row.Cells(2).Text = "X"
                e.Row.Cells(2).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(2).Text = ""
            End If

            If SF = "1" Then
                e.Row.Cells(3).Text = "X"
                e.Row.Cells(3).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(3).Text = ""
            End If

            If PR = "1" Then
                e.Row.Cells(4).Text = "X"
                e.Row.Cells(4).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(4).Text = ""
            End If

            If SR = "1" Then
                e.Row.Cells(5).Text = "X"
                e.Row.Cells(5).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(5).Text = ""
            End If

            If T = "1" Then
                e.Row.Cells(6).Text = "X"
                e.Row.Cells(6).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(6).Text = ""
            End If

            If PM = "1" Then
                e.Row.Cells(7).Text = "X"
                e.Row.Cells(7).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(7).Text = ""
            End If

            If SM = "1" Then
                e.Row.Cells(8).Text = "X"
                e.Row.Cells(8).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(8).Text = ""
            End If

            If Status = "1" Then
                e.Row.Cells(10).Text = "Scrapped/Repordered"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            ElseIf Status = "2" Then
                e.Row.Cells(10).Text = "Sent"
                e.Row.Cells(10).BackColor = Drawing.Color.Green
            ElseIf Status = "3" Then
                e.Row.Cells(10).Text = "Cut"
                e.Row.Cells(10).BackColor = Drawing.Color.Yellow
            ElseIf Status = "-1" Then
                e.Row.Cells(10).Text = "Cancelled"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            ElseIf Status = "0" Then
                e.Row.Cells(10).Text = "Not Started"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            End If

            If ReRcvd = "2" Then
                e.Row.Cells(12).Text = "Yes"
                e.Row.Cells(12).BackColor = Drawing.Color.Green
            Else
                e.Row.Cells(12).Text = "No"
                e.Row.Cells(12).BackColor = Drawing.Color.Red
            End If

            'If e.Row.DataItem("NeedsTransom") = 0 Then
            'cbT.Visible = False
            'tbTNotes.Visible = False
            'lblT.Visible = False
            'End If

            'If e.Row.DataItem("NeedsPortMid") = 0 Then
            'cbPM.Visible = False
            'tbPMNotes.Visible = False
            'lblPM.Visible = False
            'End If

            'If e.Row.DataItem("NeedsStrbMid") = 0 Then
            'cbSM.Visible = False
            'tbSMNotes.Visible = False
            'lblSM.Visible = False
            'End If

        End If
    End Sub
    Protected Sub gvRailReorders_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRailReorders.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim PF As String = e.Row.Cells(2).Text
            Dim SF As String = e.Row.Cells(3).Text
            Dim PR As String = e.Row.Cells(4).Text
            Dim SR As String = e.Row.Cells(5).Text
            Dim T As String = e.Row.Cells(6).Text
            Dim PM As String = e.Row.Cells(7).Text
            Dim SM As String = e.Row.Cells(8).Text
            Dim Status As String = e.Row.Cells(10).Text
            Dim ReRcvd As String = e.Row.Cells(12).Text

            If PF = "1" Then
                e.Row.Cells(2).Text = "X"
                e.Row.Cells(2).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(2).Text = ""
            End If

            If SF = "1" Then
                e.Row.Cells(3).Text = "X"
                e.Row.Cells(3).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(3).Text = ""
            End If

            If PR = "1" Then
                e.Row.Cells(4).Text = "X"
                e.Row.Cells(4).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(4).Text = ""
            End If

            If SR = "1" Then
                e.Row.Cells(5).Text = "X"
                e.Row.Cells(5).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(5).Text = ""
            End If

            If T = "1" Then
                e.Row.Cells(6).Text = "X"
                e.Row.Cells(6).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(6).Text = ""
            End If

            If PM = "1" Then
                e.Row.Cells(7).Text = "X"
                e.Row.Cells(7).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(7).Text = ""
            End If

            If SM = "1" Then
                e.Row.Cells(8).Text = "X"
                e.Row.Cells(8).BackColor = Drawing.Color.LightGray
            Else
                e.Row.Cells(8).Text = ""
            End If

            If Status = "2" Then
                e.Row.Cells(10).Text = "Sent"
                e.Row.Cells(10).BackColor = Drawing.Color.Green
            ElseIf Status = "3" Then
                e.Row.Cells(10).Text = "Cut"
                e.Row.Cells(10).BackColor = Drawing.Color.Yellow
            ElseIf Status = "-1" Then
                e.Row.Cells(10).Text = "Cancelled"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            ElseIf Status = "0" Then
                e.Row.Cells(10).Text = "Not Started"
                e.Row.Cells(10).BackColor = Drawing.Color.Red
            End If

            If ReRcvd = "2" Then
                e.Row.Cells(12).Text = "Yes"
                e.Row.Cells(12).BackColor = Drawing.Color.Green
            Else
                e.Row.Cells(12).Text = "No"
                e.Row.Cells(12).BackColor = Drawing.Color.Red
            End If

            'If e.Row.DataItem("NeedsTransom") = 0 Then
            'cbT.Visible = False
            'tbTNotes.Visible = False
            'lblT.Visible = False
            'End If

            'If e.Row.DataItem("NeedsPortMid") = 0 Then
            'cbPM.Visible = False
            'tbPMNotes.Visible = False
            'lblPM.Visible = False
            'End If

            'If e.Row.DataItem("NeedsStrbMid") = 0 Then
            'cbSM.Visible = False
            'tbSMNotes.Visible = False
            'lblSM.Visible = False
            'End If

        End If
    End Sub



    Protected Sub btnRetreiveProdPocs_Click(sender As Object, e As EventArgs) Handles btnRetreiveProdPocs.Click
        Dim prodNo As String = Trim(hdnProdNo.Value)
        Dim i As Integer = 1


        While i < 31
            'Dim path As String = "http://www.benningtonmarine.com/private/databank/ProdPics/" & prodNo & "/" & prodNo & "_" & i & ".jpg" 'moved to a new server 2/20/19

            Dim path As String = "https://prodpics.s3.amazonaws.com/" & prodNo & "/" & prodNo & "_" & i & ".jpg"

            If i = 1 Then
                Image1.ImageUrl = path
                If CheckWebImage(path) Then
                    Image1.Visible = True
                End If


            ElseIf i = 2 Then
                Image2.ImageUrl = path
                If CheckWebImage(path) Then
                    Image2.Visible = True
                End If


            ElseIf i = 3 Then
                Image3.ImageUrl = path
                If CheckWebImage(path) Then
                    Image3.Visible = True
                End If


            ElseIf i = 4 Then
                Image4.ImageUrl = path
                If CheckWebImage(path) Then
                    Image4.Visible = True
                End If


            ElseIf i = 5 Then
                Image5.ImageUrl = path
                If CheckWebImage(path) Then
                    Image5.Visible = True
                End If


            ElseIf i = 6 Then
                Image6.ImageUrl = path
                If CheckWebImage(path) Then
                    Image6.Visible = True
                End If


            ElseIf i = 7 Then
                Image7.ImageUrl = path
                If CheckWebImage(path) Then
                    Image7.Visible = True
                End If


            ElseIf i = 8 Then
                Image8.ImageUrl = path
                If CheckWebImage(path) Then
                    Image8.Visible = True
                End If


            ElseIf i = 9 Then
                Image9.ImageUrl = path
                If CheckWebImage(path) Then
                    Image9.Visible = True
                End If


            ElseIf i = 10 Then
                Image10.ImageUrl = path
                If CheckWebImage(path) Then
                    Image10.Visible = True
                End If

            ElseIf i = 11 Then
                Image11.ImageUrl = path
                If CheckWebImage(path) Then
                    Image11.Visible = True
                End If


            ElseIf i = 12 Then
                Image12.ImageUrl = path
                If CheckWebImage(path) Then
                    Image12.Visible = True
                End If


            ElseIf i = 13 Then
                Image13.ImageUrl = path
                If CheckWebImage(path) Then
                    Image13.Visible = True
                End If


            ElseIf i = 14 Then
                Image14.ImageUrl = path
                If CheckWebImage(path) Then
                    Image14.Visible = True
                End If


            ElseIf i = 15 Then
                Image15.ImageUrl = path
                If CheckWebImage(path) Then
                    Image15.Visible = True
                End If


            ElseIf i = 16 Then
                Image16.ImageUrl = path
                If CheckWebImage(path) Then
                    Image16.Visible = True
                End If


            ElseIf i = 17 Then
                Image17.ImageUrl = path
                If CheckWebImage(path) Then
                    Image17.Visible = True
                End If


            ElseIf i = 18 Then
                Image18.ImageUrl = path
                If CheckWebImage(path) Then
                    Image18.Visible = True
                End If


            ElseIf i = 19 Then
                Image19.ImageUrl = path
                If CheckWebImage(path) Then
                    Image19.Visible = True
                End If


            ElseIf i = 20 Then
                Image20.ImageUrl = path
                If CheckWebImage(path) Then
                    Image20.Visible = True
                End If


            ElseIf i = 21 Then
                Image21.ImageUrl = path
                If CheckWebImage(path) Then
                    Image21.Visible = True
                End If

            ElseIf i = 22 Then
                Image22.ImageUrl = path
                If CheckWebImage(path) Then
                    Image22.Visible = True
                End If


            ElseIf i = 23 Then
                Image23.ImageUrl = path
                If CheckWebImage(path) Then
                    Image23.Visible = True
                End If


            ElseIf i = 24 Then
                Image24.ImageUrl = path
                If CheckWebImage(path) Then
                    Image24.Visible = True
                End If


            ElseIf i = 25 Then
                Image25.ImageUrl = path
                If CheckWebImage(path) Then
                    Image25.Visible = True
                End If


            ElseIf i = 26 Then
                Image26.ImageUrl = path
                If CheckWebImage(path) Then
                    Image26.Visible = True
                End If


            ElseIf i = 27 Then

                Image27.ImageUrl = path
                If CheckWebImage(path) Then
                    Image27.Visible = True
                End If


            ElseIf i = 28 Then
                Image28.ImageUrl = path
                If CheckWebImage(path) Then
                    Image28.Visible = True
                End If

            ElseIf i = 29 Then
                Image29.ImageUrl = path
                If CheckWebImage(path) Then
                    Image29.Visible = True
                End If


            ElseIf i = 30 Then
                    Image30.ImageUrl = path
                If CheckWebImage(path) Then
                    Image30.Visible = True
                End If


            End If

                i = i + 1
        End While
    End Sub

    Private Function CheckWebImage(path As String) As Boolean
        Dim url As New System.Uri(path)
        Dim request As System.Net.WebRequest = System.Net.WebRequest.Create(url)
        Dim response As System.Net.WebResponse

        Try
            response = request.GetResponse()
            response.Close()
            request = Nothing
            'MsgBox("Website Found!")
            Return True
        Catch ex As Exception
            request = Nothing
            'MsgBox("Website not found. Check the url and internet connection")
            Return False
        End Try
    End Function

    Private Sub btnDrawing_Click(sender As Object, e As EventArgs) Handles btnDrawing.Click
        Dim Prod As String = hdnProdNo.Value
        Dim isCustom As String = GridView3.Rows(0).Cells(4).Text
        Dim isPilot As String = GridView3.Rows(0).Cells(3).Text

        If isCustom = "1" And Len(hdnCustomDrawingNo.Value) > 0 Then
            Dim url As String = "../DrawingPDFs/" & hdnBoatYear.Value & "/Custom/" & RTrim(hdnCustomDrawingNo.Value) & ".pdf"
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1024,height=1000,toolbars=0');popUpObj.focus()}</script>")

        ElseIf isPilot = "1" Then
            Dim url As String = "../DrawingPDFs/" & hdnBoatYear.Value & "/Pilot/" & RTrim(Prod) & ".pdf"
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1024,height=1000,toolbars=0');popUpObj.focus()}</script>")

        Else
            If Convert.ToInt32(Prod) >= 188070 Then
                Dim url As String = "../DrawingPDFs/" & hdnBoatYear.Value & "/Standard/" & hdnBoatModel.Value & ".pdf"
                Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1024,height=1000,toolbars=0');popUpObj.focus()}</script>")
            Else
                Dim url As String = "../DrawingPDFs/" & hdnBoatYear.Value & "/Standard/Old/" & hdnBoatModel.Value & ".pdf"
                Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1024,height=1000,toolbars=0');popUpObj.focus()}</script>")
            End If

        End If
    End Sub

    Private Sub btnHelp_Click(sender As Object, e As EventArgs) Handles btnHelp.Click
        Dim url As String = "ReportAProblem.aspx?SONo=" & hdnSONo.Value & ""
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1024,height=1000,toolbars=0');popUpObj.focus()}</script>")
    End Sub
    Protected Sub gvRGAs_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRGAs.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                If e.Row.DataItem("BenRcvd").ToString = "1" Then

                Else
                    e.Row.BackColor = Drawing.Color.LightYellow
                End If
            Catch ex As Exception

            End Try
        End If
    End Sub
    Protected Sub gvBOs_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBOs.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                If e.Row.DataItem("Cleared").ToString = "1" Then

                Else
                    e.Row.BackColor = Drawing.Color.LightYellow
                End If
            Catch ex As Exception

            End Try
        End If
    End Sub

    Protected Sub gvOrderLinesMac_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOrderLinesMac.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                If e.Row.DataItem("prod_cat") = "H1V" Then
                    hdnBVPart.Value = Trim(e.Row.DataItem("item_no"))
                ElseIf e.Row.DataItem("prod_cat") = "H1I" Then
                    hdnAccentPart.Value = Trim(e.Row.DataItem("item_no"))
                ElseIf e.Row.DataItem("prod_cat") = "H1F" Then
                    hdnFurnPart.Value = Trim(e.Row.DataItem("item_no"))
                End If
            Catch

            End Try

        End If

    End Sub
    Protected Sub gvIntRGAs_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvIntRGAs.RowDataBound

    End Sub

    Protected Sub dlBasicBoatDetails_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles dlBasicBoatDetails.ItemDataBound

    End Sub

    Private Sub gvOrderLinesMac_DataBound(sender As Object, e As EventArgs) Handles gvOrderLinesMac.DataBound
        If hdnFurnPart.Value.Length > 0 And hdnBVPart.Value.Length > 0 And hdnAccentPart.Value.Length > 0 Then

            Dim dataView As DataView = furncatalog.DefaultView
            'dataView.RowFilter = Nothing

            Dim furnpart As String = Trim(hdnFurnPart.Value)
            Dim bvpart As String = Trim(hdnBVPart.Value)
            Dim accentpart As String = Trim(hdnAccentPart.Value)
            Dim modelyear As Int16 = Left(hdnProdNo.Value, 2)

            dataView.RowFilter = "SERIES_PART = '" & furnpart & "' AND BASE_VINYL_PART = '" & bvpart & "' AND PRIMARY_ACCENT_PART = '" & accentpart & "'"

            Dim img1 As New Image
            Dim img2 As New Image

            Try
                Dim benchurl As String = dataView(0)(3).ToString
                Dim reclinerurl As String = dataView(0)(4).ToString

                'get only the file name
                Dim pos = benchurl.LastIndexOf("\") + 1
                benchurl = benchurl.Substring(pos, benchurl.Length - pos)

                Dim pos1 = reclinerurl.LastIndexOf("\") + 1
                reclinerurl = reclinerurl.Substring(pos1, reclinerurl.Length - pos1)

                img1.ImageUrl = "FurnitureImages/" & modelyear & "/" & benchurl
                img2.ImageUrl = "FurnitureImages/" & modelyear & "/" & reclinerurl

                phBench.Controls.Add(img2)
                phRecliner.Controls.Add(img1)

            Catch
            End Try

        End If
    End Sub
    Protected Sub gvOverview_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvOverview.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            gvOverview.DataBind()
            Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command
            Dim workstation As String = "Overview"
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gototubedamage" Then
            gvOverview.DataBind()
            Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command

            Dim Line() As String = Selected.Split(";")
            Dim SelectedProd As Integer = Line(0)
            Dim SelectedModel As String = Line(1)

            Dim url As String = "http://specs1/Live/PopReporting/Tubes/ReportDamage.aspx?ProdNo=" & SelectedProd & "&Model=" & SelectedModel
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=1000,height=600,toolbars=1');popUpObj.focus()}</script>")
        End If
    End Sub

    Protected Sub gvRedTags_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvRedTags.RowCommand
        If e.CommandName = "gotoredtag" Then 'handles when the notes button is clicked
            Dim ProdNo As String = e.CommandArgument 'get the row that is clicked
            ' Dim Selected As Integer = gvRedTagReasons.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "History " 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "./RedTags.aspx?ws=" & workstation & "&ProdNo=" & ProdNo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If



    End Sub


End Class
