Imports System.Data
Imports System.Data.SqlClient

Partial Class Tubes_Displays_FinalOuters
	Inherits System.Web.UI.Page
	Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
		dl1.DataBind()
	End Sub

	Public Function CheckMidVisible(ByVal sections As Object) As String
		Try

			If sections = 3 Then
				Return "display:normal;"
			Else
				Return "display:none;"
			End If

		Catch
			Return "display:normal;"
		End Try
	End Function

	Public Function CheckMid2Visible(ByVal sections As Object) As String
		Try

			If sections = 4 Then
				Return "display:normal;"
			Else
				Return "display:none;"
			End If

		Catch
			Return "display:normal;"
		End Try
	End Function

	Public Function CheckCtrVisible(ByVal sections As Object) As String
		Try

			If sections = 0 Then
				Return "display:none;"
			Else
				Return "display:normal;"
			End If

		Catch
			Return "display:normal;"
		End Try
	End Function

	Protected Sub dl1_DataBinding(sender As Object, e As EventArgs) Handles dl1.DataBinding
		Dim conn As New SqlConnection()
		Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

		Dim cmd2 As New SqlCommand
		Dim cmd3 As New SqlCommand
		Dim cmd4 As New SqlCommand

		Dim TodaysDate As Date = Date.Now
		Dim ThisDay As Date = TodaysDate.Date

		cmd2.CommandText = "Select Count (*) FROM Tubes where (FinalCStatus = 2 and Convert(date,FinalC) ='" & ThisDay & "')"
		cmd3.CommandText = "Select Count (*) FROM Tubes where (FinalPStatus = 2 and Convert(date,FinalP) ='" & ThisDay & "')"
		cmd4.CommandText = "Select Count (*) FROM Tubes where (FinalSStatus = 2 and Convert(date,FinalS) ='" & ThisDay & "')"
		'to get the count of the prod #'s completed that day
		cmd2.Connection = conn
		cmd3.Connection = conn
		cmd4.Connection = conn
		conn.ConnectionString = connstr
		conn.Open()

		'lblPort.Text = " P: " & Convert.ToInt16(cmd3.ExecuteScalar())
		'lblStrb.Text = " S: " & Convert.ToInt16(cmd4.ExecuteScalar())

		conn.Close()

	End Sub

	Protected Sub dl1_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles dl1.ItemDataBound
		If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then

			Dim Status As String = e.Item.DataItem("RailsStatus").ToString

			If e.Item.DataItem("HasAllRails") = "1" And
				 e.Item.DataItem("FurnitureStatus") >= "2" And
				 e.Item.DataItem("FiberglassStatus") = "2" And
				 e.Item.DataItem("CoversStatus") >= 1 And
				 e.Item.DataItem("TubesStatus") = 2 And
				 e.Item.DataItem("GaugeStatus") = 2 And
				 e.Item.DataItem("HarnessStatus") = 2 And
				 ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
				e.Item.BackColor = Drawing.Color.Orange
			ElseIf e.Item.DataItem("HasAllRails") = "1" And
				 e.Item.DataItem("FurnitureStatus") >= "2" And
				 e.Item.DataItem("FiberglassStatus") = "2" And
				e.Item.DataItem("CoversStatus") >= 1 And
				e.Item.DataItem("RailsStatus") >= 1 And
				(e.Item.DataItem("TubesStatus") < 2 Or ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2))) And
				e.Item.DataItem("GaugeStatus") = 2 And
				e.Item.DataItem("HarnessStatus") = 2 Then
				e.Item.BackColor = Drawing.Color.Red
			ElseIf e.Item.DataItem("ReplaceReqdFlag").ToString = "1" And e.Item.DataItem("ReplacedFlag").ToString = "0" Then
				e.Item.BackColor = Drawing.Color.Yellow
			ElseIf e.Item.DataItem("TubesStatus") = 2 And
			   ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
				e.Item.BackColor = Drawing.Color.LightGreen
			End If
		End If

	End Sub
End Class
