Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports MySql.Data.MySqlClient

Partial Class OverviewNotStarted
	Inherits System.Web.UI.Page

	Public veadaShipData As New DataTable
	Public covidReturnDates As New DataTable

	Public Sub MesgBox(ByVal sMessage As String)
		Dim msg As String
		msg = "<script language='javascript'>"
		msg += "alert('" & sMessage & "');"
		msg += "<" & "/script>"
		Response.Write(msg)
	End Sub


	Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
		gvOverview.DataBind()
	End Sub

	Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
		Dim mysqldataadapter As New MySqlDataAdapter
		Dim conn As New MySqlConnection()
		Dim connstr As String = "server=veada-mysql-082019.cz8vw0a6whxb.us-east-1.rds.amazonaws.com;user id=BennDataPartner;password=DISH4087sky$$;persistsecurityinfo=True;database=vea_0819_dbshare"
		conn.ConnectionString = connstr

		conn.Open()
		mysqldataadapter.SelectCommand = New MySqlCommand("Select ProdNo, Shipped, TruckNum FROM BennShipping_Shipped ", conn)
		mysqldataadapter.Fill(veadaShipData)
		conn.Close()
		conn.Dispose()


		'Dim sqldataadapter As New SqlDataAdapter
		'Dim conn1 As New SqlConnection()
		'Dim connstr1 As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
		'conn1.ConnectionString = connstr1

		'Try
		'conn1.Open()
		'sqldataadapter.SelectCommand = New SqlCommand("SELECT RTrim(DlrNo) as CusNo, DateReturning From DlrReturnsFromCovid Where DateReturning > getDate()", conn1)
		'sqldataadapter.Fill(covidReturnDates)

		'conn1.Close()
		'conn1.Dispose()

		Return False
	End Function

	Private Shared Sub AddSuperHeader(gridView As GridView)
		Dim TodaysDate As Date = Date.Now
		Dim ThisDay As Date = TodaysDate.Date

		Dim cmd As New SqlCommand
		Dim cmd2 As New SqlCommand
		Dim cmd3 As New SqlCommand
		Dim cmd4 As New SqlCommand
		Dim cmd5 As New SqlCommand
		Dim cmd6 As New SqlCommand
		Dim cmd7 As New SqlCommand
		Dim cmd8 As New SqlCommand
		Dim cmd9 As New SqlCommand
		Dim cmd10 As New SqlCommand
		Dim cmd11 As New SqlCommand
		Dim cmd12 As New SqlCommand
		Dim cmd13 As New SqlCommand
		Dim cmd14 As New SqlCommand
		Dim cmd15 As New SqlCommand
		Dim cmd16 As New SqlCommand
		Dim cmd17 As New SqlCommand
		Dim cmd18 As New SqlCommand
		Dim cmd19 As New SqlCommand



		Dim conn As New SqlConnection()
		Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
		conn.ConnectionString = connstr

		Dim furnitureprepcount As Int16 = 0
		Dim fiberglassprepcount As Int16 = 0
		Dim coverscount As Int16 = 0
		Dim railsprepcount As Int16 = 0
		Dim tubesprepcount As Int16 = 0

		Dim framescount As Int16 = 0
		Dim floorscount As Int16 = 0
		Dim railscount As Int16 = 0
		Dim furniturecount As Int16 = 0
		Dim helmcount As Int16 = 0
		Dim cleaningcount As Int16 = 0
		Dim finalcount As Int16 = 0
		Dim shrinkwrapcount As Int16 = 0
		Dim wavetamercount As Int16 = 0
		Dim sharkhidecount As Int16 = 0
		Dim completecount As Int16 = 0
		Dim offlinecount As Int16 = 0
		Dim centertubecount As Int16 = 0
		Dim riggingcount As Int16 = 0

		cmd.CommandType = CommandType.Text
		cmd2.CommandType = CommandType.Text
		cmd3.CommandType = CommandType.Text
		cmd4.CommandType = CommandType.Text
		cmd5.CommandType = CommandType.Text
		cmd6.CommandType = CommandType.Text
		cmd7.CommandType = CommandType.Text
		cmd8.CommandType = CommandType.Text
		cmd9.CommandType = CommandType.Text
		cmd10.CommandType = CommandType.Text
		cmd11.CommandType = CommandType.Text
		cmd12.CommandType = CommandType.Text
		cmd13.CommandType = CommandType.Text
		cmd14.CommandType = CommandType.Text
		cmd15.CommandType = CommandType.Text
		cmd16.CommandType = CommandType.Text
		cmd17.CommandType = CommandType.Text
		cmd18.CommandType = CommandType.Text
		cmd19.CommandType = CommandType.Text



		cmd.Connection = conn
		cmd2.Connection = conn
		cmd3.Connection = conn
		cmd4.Connection = conn
		cmd5.Connection = conn
		cmd6.Connection = conn
		cmd7.Connection = conn
		cmd8.Connection = conn
		cmd9.Connection = conn
		cmd10.Connection = conn
		cmd11.Connection = conn
		cmd12.Connection = conn
		cmd13.Connection = conn
		cmd14.Connection = conn
		cmd15.Connection = conn
		cmd16.Connection = conn
		cmd17.Connection = conn
		cmd18.Connection = conn
		cmd19.Connection = conn





		cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus = 2 and Convert(date,FurniturePrepLastUpdated) ='" & ThisDay & "'"
		cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FiberglassStatus = 2 and Convert(date,FiberglassLastUpdated) ='" & ThisDay & "'"
		cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CoversStatus = 2 and Convert(date,CoversLastUpdated) ='" & ThisDay & "'"
		cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsStatus = 2 and Convert(date,RailsLastUpdated) ='" & ThisDay & "'"
		cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = 2 and Convert(date,TubesLastUpdated) ='" & ThisDay & "'"

		cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 2 and BuildLoc = M and Convert(date,FramesInstalled) ='" & ThisDay & "'"
		cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = 2 and BuildLoc = M and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
		cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = 2 and BuildLoc = M and Convert(date,RailsInstalled) ='" & ThisDay & "'"
		cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureInstalledStatus = 2 and BuildLoc = M and Convert(date,FurnitureInstalled) ='" & ThisDay & "'"
		cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmInstalledStatus = 2 and BuildLoc = M and Convert(date,HelmInstalled) ='" & ThisDay & "'"
		cmd11.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = 2 and BuildLoc = M and Convert(date,Cleaning) ='" & ThisDay & "'"
		cmd12.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and BuildLoc = M and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
		cmd13.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where WavetamerStatus = 2 and BuildLoc = M and Convert(date,WaveTamerInstalled) ='" & ThisDay & "'"
		cmd14.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FinalInspectionStatus = 2 and BuildLoc = M and Convert(date,FinalInspection) ='" & ThisDay & "'"
		cmd15.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where SharkhideStatus = 2 and BuildLoc = M and Convert(date,SharkhideInstalled) ='" & ThisDay & "'"
		cmd16.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CompleteStatus = 2 and BuildLoc = M and Convert(date,Complete) ='" & ThisDay & "'"
		cmd17.CommandText = "Select Count (*) FROM BML_POPREPORTING_OFFLINE where StatusSetTo = 'Offline' and BuildLoc = M and Convert(date,Date) ='" & ThisDay & "'"
		cmd18.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = '2' and BuildLoc = M and Convert(date,Centertube) ='" & ThisDay & "'"
		cmd19.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus = '2' and BuildLoc = M and Convert(date,Rigging) ='" & ThisDay & "'"



		'conn.Open()
		' furnitureprepcount = Convert.ToInt16(cmd.ExecuteScalar())
		'fiberglassprepcount = Convert.ToInt16(cmd2.ExecuteScalar())
		'coverscount = Convert.ToInt16(cmd3.ExecuteScalar())
		'railsprepcount = Convert.ToInt16(cmd4.ExecuteScalar())
		'tubesprepcount = Convert.ToInt16(cmd5.ExecuteScalar())
		'framescount = Convert.ToInt16(cmd6.ExecuteScalar())
		'floorscount = Convert.ToInt16(cmd7.ExecuteScalar())
		'railscount = Convert.ToInt16(cmd8.ExecuteScalar())
		'furniturecount = Convert.ToInt16(cmd9.ExecuteScalar())
		'helmcount = Convert.ToInt16(cmd10.ExecuteScalar())
		'cleaningcount = Convert.ToInt16(cmd11.ExecuteScalar())
		'shrinkwrapcount = Convert.ToInt16(cmd12.ExecuteScalar())
		'wavetamercount = Convert.ToInt16(cmd13.ExecuteScalar())
		'finalcount = Convert.ToInt16(cmd14.ExecuteScalar())
		'sharkhidecount = Convert.ToInt16(cmd15.ExecuteScalar())
		'completecount = Convert.ToInt16(cmd16.ExecuteScalar())
		'offlinecount = Convert.ToInt16(cmd17.ExecuteScalar())
		'centertubecount = Convert.ToInt16(cmd18.ExecuteScalar())

		'conn.Close()

		'all of this code adds a header above the gv header so that I can display the totals.
		Dim myTable = DirectCast(gridView.Controls(0), Table)
		Dim myNewRow = New GridViewRow(0, -1, DataControlRowType.Header, DataControlRowState.Normal)
		myNewRow.Cells.Add(MakeCell("Totals", 1))
		myNewRow.Cells.Add(MakeCell(furnitureprepcount, 1))
		myNewRow.Cells.Add(MakeCell(fiberglassprepcount, 1))
		myNewRow.Cells.Add(MakeCell(coverscount, 1))
		myNewRow.Cells.Add(MakeCell(railsprepcount, 1))
		myNewRow.Cells.Add(MakeCell(tubesprepcount, 1))
		myNewRow.Cells.Add(MakeCell(centertubecount, 1))
		myNewRow.Cells.Add(MakeCell())
		myNewRow.Cells.Add(MakeCell(framescount, 1))
		myNewRow.Cells.Add(MakeCell(floorscount, 1))
		myNewRow.Cells.Add(MakeCell(railscount, 1))
		myNewRow.Cells.Add(MakeCell(furniturecount, 1))
		myNewRow.Cells.Add(MakeCell(helmcount, 1))
		myNewRow.Cells.Add(MakeCell(cleaningcount, 1))
		myNewRow.Cells.Add(MakeCell(finalcount, 1))
		myNewRow.Cells.Add(MakeCell(shrinkwrapcount, 1))
		myNewRow.Cells.Add(MakeCell(riggingcount, 1))
		myNewRow.Cells.Add(MakeCell(wavetamercount, 1))
		myNewRow.Cells.Add(MakeCell(sharkhidecount, 1))
		myNewRow.Cells.Add(MakeCell(completecount, 1))
		myNewRow.Cells.Add(MakeCell(offlinecount, 1))
		myNewRow.Cells.Add(MakeCell("Notes", 1))
		myTable.Rows.AddAt(0, myNewRow)

	End Sub

	Private Shared Function MakeCell(Optional text As String = Nothing, Optional span As Integer = 1) As TableHeaderCell
		Return New TableHeaderCell() With {.ColumnSpan = span, .Text = If(text, String.Empty), .CssClass = "table-subheader"}
	End Function


	Protected Sub gvOverview_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOverview.RowDataBound
		' Dim gvOverview = DirectCast(sender, GridView)

		If e.Row.RowType = DataControlRowType.DataRow Then

			Dim prod As String = e.Row.Cells(0).Text
			Dim SONo As String = e.Row.Cells(1).Text

			Dim lblcusno As Label = e.Row.FindControl("lblCusNo")

			Dim s As SqlDataSource = CType(e.Row.FindControl("sdsMacola"), SqlDataSource)

			Dim lblEngPO As Label = DirectCast(e.Row.FindControl("lblEngPO"), Label)
			Dim lblPOLine As Label = DirectCast(e.Row.FindControl("lblPoLineNo"), Label)
			Dim lblETA As Label = DirectCast(e.Row.FindControl("lblETA"), Label)


			'Try
			'Dim cusno As String = Trim(lblcusno.Text)

			'Dim acceptingResults() As DataRow = covidReturnDates.Select("CusNo =  '" & cusno & "'")
			'Dim lblCovidNotTaking As Label = e.Row.FindControl("lblCovidNotTaking")

			'Try

			'If acceptingResults.Length > 0 Then

			'If covidReturnDates(0)(2).ToString <> "1" Then
			'e.Row.Cells(0).BackColor = Drawing.Color.Yellow
			'lblCovidNotTaking.Text = "Not Accepting Boats" 'covidReturnDates(0)(1)
			'End If

			'End If
			'	Catch ex As Exception

			'	End Try


			'Catch
			'End Try


			Dim veadaResults() As DataRow = veadaShipData.Select("ProdNo =  '" & prod & "'")
			Dim lblVeadaShip As Label = e.Row.FindControl("lblVeadaDate")
			Dim lblVeadaTruck As Label = e.Row.FindControl("lblVeadaTruck")


			Dim u As SqlDataSource = CType(e.Row.FindControl("sdsRailsData"), SqlDataSource)
			Dim v As SqlDataSource = CType(e.Row.FindControl("sdsBoatNotes"), SqlDataSource)

			Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.

				If e.Row.DataItem("RiggingNeeded") = 1 Then
					s.SelectParameters(0).DefaultValue = SONo

					'Get the PO # where the cmt = Prod # from Line 3.

					Dim conn As New SqlConnection()
					Dim cmd As New SqlCommand
					Dim cmd1 As New SqlCommand

					Dim connstr As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
					conn.ConnectionString = connstr
					conn.Open()
					cmd.Connection = conn
					cmd1.Connection = conn

					cmd.Parameters.AddWithValue("@Prod", prod)

					cmd.CommandText = "Select ord_no, line_no from POCOMFIL_SQL where RTrim(cmt) = @Prod and seq_no = '3'"

					Dim results As SqlDataReader = cmd.ExecuteReader

					If results.HasRows = True Then
						While results.Read
							Try
								lblEngPO.Text = Trim(results.Item("ord_no")).ToString
								lblPOLine.Text = Trim(results.Item("line_no")).ToString


							Catch
							End Try
						End While
						results.Close()
					End If

					Try
						cmd1.Parameters.AddWithValue("@PO", Trim(lblEngPO.Text))
						cmd1.Parameters.AddWithValue("@Line", Trim(lblPOLine.Text))

						cmd1.CommandText = "Select cmt from POCOMFIL_SQL where ord_no = @PO and line_no = @Line and seq_no = 6"
						Dim eta As String = cmd1.ExecuteScalar
						lblETA.Text = eta

					Catch ex As Exception

					End Try


					conn.Close()

					'End If

				End If

				u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
				v.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
			Catch
			End Try

			Try
				If (e.Row.DataItem("BuildLoc") = "S") Then
					e.Row.BackColor = Drawing.Color.LightGray
				End If
			Catch ex As Exception

			End Try

			Try
				If (e.Row.DataItem("BuildLoc") = "M") And
				   (e.Row.DataItem("FurnitureStatus") = "2" Or e.Row.DataItem("FurnitureStatus") = "3") And
				   e.Row.DataItem("FiberglassStatus") = "2" And
				   e.Row.DataItem("HelmBuildStatus") = "2" And
				   e.Row.DataItem("CoversStatus") >= 1 And
				   e.Row.DataItem("RailsStatus") = 2 And
				   e.Row.DataItem("TubesStatus") = 2 And
				   e.Row.DataItem("FramesInstalledStatus") = 2 And
				   e.Row.DataItem("GaugeStatus") = 2 And
				   e.Row.DataItem("HarnessStatus") = 2 And
				   ((e.Row.DataItem("CenterTubeNeeded") = 1 And e.Row.DataItem("CenterTubeStatus") = 2) Or e.Row.DataItem("CentertubeNeeded") = 0) Then
					e.Row.BackColor = Drawing.Color.LightGreen

				ElseIf (e.Row.DataItem("BuildLoc") = "S") And
				   (e.Row.DataItem("FurnitureStatus") = "2" Or e.Row.DataItem("FurnitureStatus") = "3") And
				   e.Row.DataItem("FiberglassStatus") = "2" And
				   e.Row.DataItem("HelmBuildStatus") = "2" And
				   e.Row.DataItem("CoversStatus") >= 1 And
				   e.Row.DataItem("RailsStatus") = 2 And
				   e.Row.DataItem("TubesStatus") = 2 And
				   e.Row.DataItem("FramesInstalledStatus") = 2 And
				   e.Row.DataItem("TrimStatus") = 2 And
				   e.Row.DataItem("GaugeStatus") = 2 And
				   e.Row.DataItem("HarnessStatus") = 2 And
				   ((e.Row.DataItem("CenterTubeNeeded") = 1 And e.Row.DataItem("CenterTubeStatus") = 2) Or e.Row.DataItem("CentertubeNeeded") = 0) And
					((e.Row.DataItem("QFrontNeeded") = 1 And e.Row.DataItem("QFrontStatus") = 2) Or e.Row.DataItem("QFrontNeeded") = 0) And
				   ((e.Row.DataItem("ArchTowerNeeded") = 1 And e.Row.DataItem("ArchTowerStatus") = 2) Or e.Row.DataItem("ArchTowerNeeded") = 0) Then
					e.Row.BackColor = Drawing.Color.LightGreen

				End If

			Catch ex As Exception

			End Try

			Try
				If e.Row.DataItem("Requested") = "1" And e.Row.DataItem("RailsStatus") = 0 Then
					e.Row.Cells(8).BackColor = Drawing.Color.Yellow
				End If

			Catch ex As Exception

			End Try

			Try
				If veadaResults.Length > 0 Then
					lblVeadaShip.Text = veadaResults(0)(1)
					lblVeadaTruck.Text = veadaResults(0)(2)
				Else
					lblVeadaShip.Text = ""
					lblVeadaTruck.Text = ""
				End If
			Catch ex As Exception

			End Try


		End If



	End Sub


	Protected Sub gvOverview_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvOverview.RowCommand
		If e.CommandName = "gotoorderdetails" Then 'handles when the ? button is clicked
			gvOverview.DataBind()
			Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetailsFull.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,toolbars=0');popUpObj.focus()}</script>")
        End If

		If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
			gvOverview.DataBind()
			Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command
			Dim workstation As String = "Overview"
			Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
			Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

		End If

		If e.CommandName = "gotooffline" Then
			gvOverview.DataBind()
			Dim Selected As String = e.CommandArgument 'get the row that is clicked
			Dim workstation As String = "Overview" 'to pass in the workstation that makes the note.
			Dim url As String = "./BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
			Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")

		End If

		If e.CommandName = "gotostatus" Then
			gvOverview.DataBind()
			Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command
			Dim workstation As String = "Overview" 'to pass in the workstation that makes the note.
			Dim url As String = "./BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
			Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
		End If

		If e.CommandName = "gotofullorderdetails" Then
			Dim SONo As String = e.CommandArgument 'get the row that is clicked
			Dim url As String = "./OrderDetailsFull.aspx?SONo=" & SONo
			Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,toolbars=1');popUpObj.focus()}</script>")
		End If
	End Sub


	Protected Sub btnClearProdNo_Click(sender As Object, e As EventArgs) Handles btnClearProdNo.Click
		tbSearchProdNo.Text = ""
	End Sub

	Protected Sub btnClearnCusName_Click(sender As Object, e As EventArgs) Handles btnClearnCusName.Click
		tbSearchCusName.Text = ""
	End Sub

	Protected Sub btnClearModel_Click(sender As Object, e As EventArgs) Handles btnClearModel.Click
		tbSearchModel.Text = ""
	End Sub

	Protected Sub btnClearSO_Click(sender As Object, e As EventArgs) Handles btnClearSO.Click
		tbSONo.Text = ""
	End Sub

	Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
		gvOverview.DataBind()
	End Sub

	Protected Sub ddlBldg_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlBldg.SelectedIndexChanged
		'If ddlBldg.SelectedValue = "M" Then
		'	gvOverview.Columns(20).Visible = False
		'	gvOverview.Columns(21).Visible = False
		'Else : gvOverview.Columns(19).Visible = True
		'	gvOverview.Columns(20).Visible = True
		'End If
	End Sub

	Private Sub OverviewNotStarted_Load(sender As Object, e As EventArgs) Handles Me.Load

		Response.Redirect("http://specs/v2/Overviews/BoatsNotStarted.aspx") 'Take them to the new page instead

		PopulateDataTables()


		Dim conn As New SqlConnection()
		Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

		Dim cmd As New SqlCommand
		Dim cmd1 As New SqlCommand
		Dim cmd2 As New SqlCommand

		Dim TodaysDate As Date = Date.Now
		Dim ThisDay As Date = TodaysDate.Date

		conn.ConnectionString = connstr

		cmd.Connection = conn
		cmd1.Connection = conn
		cmd2.Connection = conn


		cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and RailsInstalledStatus = 1 and IsDeckInside = 0 and FurnitureStatus >= 2  and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((ArchTowerNeeded = 0) OR (ArchTowerNeeded = 1 AND ArchTowerStatus = 2)) AND ((QFrontNeeded = 0) OR (QFrontNeeded = 1 AND QFrontStatus = 2)) And BML_POPREPORTING.ProdNo > '2099999'"
		cmd1.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and RailsInstalledStatus = 1 and IsDeckInside = 0 and BML_POPREPORTING.ProdNo > '1999999'"
		cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where IsDeckInside =1 and BuildLoc = 'S' and Convert(date,DeckLocModified) ='" & ThisDay & "'"   'South Bring Online Code added 1/9/2020

		conn.Open()

		lblReadyCount.Text = cmd.ExecuteScalar
		NumDecksOutside.Text = cmd1.ExecuteScalar
		NumDecksBroughtIn.Text = cmd2.ExecuteScalar
		conn.Close()
	End Sub
End Class
