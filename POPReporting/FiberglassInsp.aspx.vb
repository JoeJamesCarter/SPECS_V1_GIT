Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient

Partial Class FiberglassInsp
	Inherits System.Web.UI.Page

	Public veadaShipData As New DataTable

	Public Sub MesgBox(ByVal sMessage As String)
		Dim msg As String
		msg = "<script language='javascript'>"
		msg += "alert('" & sMessage & "');"
		msg += "<" & "/script>"
		Response.Write(msg)
	End Sub

	Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
		Dim conn As New SqlConnection()
		Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

		Dim cmd2 As New SqlCommand
		Dim cmd3 As New SqlCommand
		Dim cmd4 As New SqlCommand
		Dim TodaysDate As Date = Date.Now
		Dim ThisDay As Date = TodaysDate.Date
		Dim recordcount As Int16 = 0
		Dim DaystoShow As String
		Dim framesreadytostart As Int16
		Dim framesreadytostartio As Int16


		If ddlDaysInAdvance.Items.Count = 0 Then  'stop it from repopulating everytime the grid rebinds
			DaystoShow = ThisDay.AddDays(5).ToString("yyyy-MM-dd")
			ddlDaysInAdvance.Items.Add(New ListItem("3 Days", DaystoShow))
			DaystoShow = ThisDay.AddDays(7).ToString("yyyy-MM-dd")
			ddlDaysInAdvance.Items.Add(New ListItem("5 Days", DaystoShow))
			DaystoShow = ThisDay.AddDays(12).ToString("yyyy-MM-dd")
			ddlDaysInAdvance.Items.Add(New ListItem("10 Days", DaystoShow))
			DaystoShow = ThisDay.AddDays(17).ToString("yyyy-MM-dd")
			ddlDaysInAdvance.Items.Add(New ListItem("15 Days", DaystoShow))
			DaystoShow = ThisDay.AddDays(22).ToString("yyyy-MM-dd")
			ddlDaysInAdvance.Items.Add(New ListItem("20 Days", DaystoShow))
		End If

		'MesgBox(DaystoShow)
		conn.ConnectionString = connstr
		cmd2.CommandType = CommandType.Text
		cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FiberglassInspStatus = 2 and Convert(date,FiberglassInsp) ='" & ThisDay & "'"
		'cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
		cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where (FloorsInstalledStatus = '1' and BuildLoc = 'S' and ProdNo >= 2000000) or (FloorsInstalledStatus = '1' and BuildLoc = 'M' and ProdNo >= 2000000 and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2)"
		cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"

		'to get the count of the prod #'s completed that day
		cmd2.Connection = conn
		cmd3.Connection = conn
		cmd4.Connection = conn

		conn.Open()

		recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
		lblBoatsStarted.Text = recordcount
		framesreadytostart = Convert.ToInt16(cmd3.ExecuteScalar)
		framesreadytostartio = Convert.ToInt16(cmd4.ExecuteScalar)

		lblReadytoStart.Text = framesreadytostart
		lblios.Text = framesreadytostartio

		'MesgBox(recordcount)
		conn.Close()
		PopulateDataTables()
	End Sub

	Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
		Dim mysqldataadapter As New MySqlDataAdapter
		Dim conn As New MySqlConnection()
		'Dim connstr As String = "server=veada-mysql-082019.cz8vw0a6whxb.us-east-1.rds.amazonaws.com;user id=BennDataPartner;password=DISH4087sky$$;persistsecurityinfo=True;database=vea_0819_dbshare"
		Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"
		conn.ConnectionString = connstr

		conn.Open()
		'mysqldataadapter.SelectCommand = New MySqlCommand("Select ProdNo, Shipped, TruckNum FROM BennShipping_Shipped ", conn)
		mysqldataadapter.SelectCommand = New MySqlCommand("Select ProdNo,MAX(CAST(Shipped AS DATE)) as Shipped, '1' as ShippedFlag, Line, TruckNum, TrailerNum FROM SPECS_External.LocalBennShipping_Shipped Where ProdNo > 2100000  group by ProdNo Order By ProdNo asc", conn)
		mysqldataadapter.Fill(veadaShipData)
		conn.Close()
		conn.Dispose()
		Return False
	End Function

	Protected Sub gvHelmBuild_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvHelmBuild.RowCommand
		If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
			Dim ID As String = e.CommandArgument 'get the row that is clicked
			Dim Selected As Integer = gvHelmBuild.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
			Dim workstation As String = "HelmsBuild" 'to pass in the workstation that makes the note.
			'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
			Dim url As String = "BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
			Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

			' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
		End If

		If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
			Dim ID As String = e.CommandArgument 'get the row that is clicked
			Dim Selected As Integer = gvHelmBuild.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
			Dim workstation As String = "HelmsBuild" 'to pass in the workstation that makes the note.
			Dim url As String = "BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
			Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
			'Response.Redirect("../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected)

		End If

		If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
			Dim SONo As String = e.CommandArgument 'get the row that is clicked
			Dim url As String = "OrderDetails.aspx?SONo=" & SONo
			Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
		End If

		If e.CommandName = "gotobuildsheet" Then 'handles when the notes button is clicked
			Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
			Dim Line() As String = Selected.Split(";")
			Dim ProdNo As String = Line(0)
			Dim Model As String = Line(1)

			Dim url As String = "../Workstations/HelmBuildSheet.aspx?ProdNo=" & Trim(ProdNo) & "&Model=" & Trim(Model) & ""

			Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1024,height=1200,toolbars=0');popUpObj.focus()}</script>")
		End If

		'This code is for the update button
		If e.CommandName = "UpdateFGStatus" Then
			'This code is for the update button
			Dim Key As String = e.CommandArgument 'get the row that is clicked
			Dim SelectedProdNo As Integer = gvHelmBuild.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


			Dim rbList As RadioButtonList = DirectCast(gvHelmBuild.Rows(Key).Cells(4).FindControl("rblFiberglassStatus"), RadioButtonList)
			'set the value of the radio button equal to what it is in the database on load.

			Dim conn As New SqlConnection()
			Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

			Dim cmd As New SqlCommand
			Dim cmd2 As New SqlCommand
			Dim cmd3 As New SqlCommand
			'Dim cmd4 As New SqlCommand
			'Dim cmd5 As New SqlCommand
			'Dim cmd6 As New SqlCommand
			'Dim cmd7 As New SqlCommand
			Dim cmd8 As New SqlCommand
			Dim cmd9 As New SqlCommand
			'Dim cmd10 As New SqlCommand

			Dim TodaysDate As Date = Date.Now
			Dim ThisDay As Date = TodaysDate.Date
			Dim recordcount As Int16 = 0
			'Dim greenlightcount As Int16 = 0
			'Dim tubeneeded As Int16 = 0
			'Dim tubecomplete As Int16 = 0
			Dim framesreadytostart As Int16
			Dim framesreadytostartio As Int16
			'Dim building As String

			conn.ConnectionString = connstr

			cmd.CommandType = CommandType.Text
			cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FiberglassInspStatus = '" & rbList.SelectedValue & "' , FiberglassInsp = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
			cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FiberglassInspStatus = 2 and Convert(date,FiberglassInsp) ='" & ThisDay & "'"
			cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where (FloorsInstalledStatus = '1' and BuildLoc = 'S' and ProdNo >= 2000000) or (FloorsInstalledStatus = '1' and BuildLoc = 'M' and ProdNo >= 2000000 and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2)"
			cmd8.CommandText = "Insert into BML_POPREPORTING_NOTES (Date, Note, ProdNo, Workstation, CreatedFor) VALUES ('" & TodaysDate & "', 'CONSOLE NEEDS REPAIRED', '" & SelectedProdNo & "', 'FG Inspection', 'HelmsBuild' )"
			cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
			'cmd10.CommandText = "Select BuildLoc FROM BML_POPREPORTING_GREENLIGHTS where ProdNo = '" & SelectedProdNo & "'"

			cmd.Connection = conn
			cmd2.Connection = conn
			cmd3.Connection = conn
			'cmd4.Connection = conn
			'cmd5.Connection = conn
			'cmd6.Connection = conn
			'cmd7.Connection = conn
			cmd8.Connection = conn
			cmd9.Connection = conn
			'cmd10.Connection = conn

			conn.Open()

			If rbList.SelectedValue = 1 Then ' auto add a note that it needs repaired.
				cmd8.ExecuteNonQuery()
			End If

			cmd.ExecuteNonQuery()
			recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
			lblBoatsStarted.Text = recordcount

			framesreadytostart = Convert.ToInt16(cmd3.ExecuteScalar)
			framesreadytostartio = Convert.ToInt16(cmd9.ExecuteScalar)
			lblReadytoStart.Text = framesreadytostart
			lblios.Text = framesreadytostartio


			gvHelmBuild.DataBind()

			conn.Close()
		End If

	End Sub


	Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
		gvHelmBuild.DataBind()
	End Sub

	Protected Sub gvHelmBuild_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvHelmBuild.RowDataBound
		If e.Row.RowType = DataControlRowType.DataRow Then

			Dim prod As String = e.Row.Cells(0).Text
			Dim veadaResults() As DataRow = veadaShipData.Select("ProdNo =  '" & prod & "'")
			Dim lblVeadaShip As Label = e.Row.FindControl("lblVeadaDate")
			Dim lblVeadaTruck As Label = e.Row.FindControl("lblVeadaTruck")
			Dim fStatus As Int16 = e.Row.DataItem("FurnitureStatus")

			If (e.Row.DataItem("BuildLoc") = "S") Then
				e.Row.BackColor = Drawing.Color.LightGray
			End If
			If (e.Row.DataItem("FiberglassInspStatus") = "1") Then
				e.Row.Cells(15).BackColor = Drawing.Color.Yellow
			End If

			If veadaResults.Length > 0 And fStatus < 2 Then
				lblVeadaShip.Text = veadaResults(0)(1)
				lblVeadaTruck.Text = veadaResults(0)(2)
			Else
				lblVeadaShip.Text = ""
				lblVeadaTruck.Text = ""
			End If

		End If
	End Sub

	Protected Function SplitBVatDash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
		Dim a As String
		Dim b As String

		a = val.ToString()
		b = a.Split("-"c)(0)
		If val IsNot Nothing Then
			Return (b)
		End If
		Return ""
	End Function

End Class
