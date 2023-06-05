Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class OrderDetails
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

        Dim SqlDataAdapter As New SqlDataAdapter
        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1

        conn1.Open()
        SqlDataAdapter.SelectCommand = New SqlCommand("Select SERIES_PART, BASE_VINYL_PART,PRIMARY_ACCENT_PART, BENCH_IMG_URL, RECLINER_IMG_URL, CATALOG_PAGE FROM Furniture_Combinations ", conn1)
        SqlDataAdapter.Fill(furncatalog)

        conn1.Close()
        conn1.Dispose()

    End Sub


    Protected Sub btnDrawing_Click(sender As Object, e As EventArgs) Handles btnDrawing.Click

        Dim Prod As String = GridView3.Rows(0).Cells(0).Text
        Dim isPilot As String = GridView3.Rows(0).Cells(3).Text
        Dim isCustom As String = GridView3.Rows(0).Cells(4).Text


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

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim url As String = "./ReportAProblem.aspx?SONo=" & hdnSONo.Value & ""
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1024,height=1000,toolbars=0');popUpObj.focus()}</script>")
    End Sub
    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView1.RowDataBound
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
    End Sub
    Protected Sub GridView1_DataBound(sender As Object, e As EventArgs) Handles GridView1.DataBound
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
            Dim catpgLink As New HyperLink

            Try
                Dim benchurl As String = dataView(0)(3).ToString
                Dim reclinerurl As String = dataView(0)(4).ToString
                Dim catpage As String = dataView(0)(5).ToString

                'get only the file name
                Dim pos = benchurl.LastIndexOf("\") + 1
                benchurl = benchurl.Substring(pos, benchurl.Length - pos)

                Dim pos1 = reclinerurl.LastIndexOf("\") + 1
                reclinerurl = reclinerurl.Substring(pos1, reclinerurl.Length - pos1)

                img1.ImageUrl = "FurnitureImages/" & modelyear & "/" & benchurl
                img2.ImageUrl = "FurnitureImages/" & modelyear & "/" & reclinerurl

                phBench.Controls.Add(img2)
                phRecliner.Controls.Add(img1)


                catpgLink.ID = "lnk" & catpage
                catpgLink.Target = "_blank"
                catpgLink.ImageUrl = catpgLink.NavigateUrl
                catpgLink.Text = "Furniture Description"
                catpgLink.NavigateUrl = "FurnitureImages/" & modelyear & "/PagePDFS/" & catpage
                'phCatPageLink.Controls.Add(catpgLink)


            Catch
            End Try

        End If
    End Sub
    Protected Sub GridView3_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView3.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            hdnProdNo.Value = e.Row.DataItem("ProdNo")
        End If
    End Sub
End Class
