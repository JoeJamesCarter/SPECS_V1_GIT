Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Tubes_RollerLoadBalancing
    Inherits System.Web.UI.Page

    Public faboptions As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        PopulateDataTables()
    End Sub

    Protected Sub lvblue_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lvblue.ItemDataBound, lvgreen.ItemDataBound
        If e.Item.ItemType = ListViewItemType.DataItem Then

            Dim prod As String = e.Item.DataItem("ProdNo")
            Dim fabOptionsResult() As DataRow = faboptions.Select("ProdNo =  '" & prod & "'")
            Dim fab As String = ""
            Dim i As Integer = 0
            Dim fab1 As Label = e.Item.FindControl("fab1")

            If fabOptionsResult.Length > 0 Then

                For Each Row As DataRow In fabOptionsResult
                    fab = fab + Row(i)
                    i = i = 1
                Next

                fab1.Text = fab

            End If
        End If

    End Sub

    Protected Function PopulateDataTables() As String  'store distinct prods with rgas and bos so you don't have to scan everything
        Dim sqlAdapter As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        conn.ConnectionString = connstr

        conn.Open()

        sqlAdapter.SelectCommand = New SqlCommand("Select Option_Desc,ProdNo From BML_POPREPORTINGFABOPTIONS Where Workcenter = 'TubeScheduling'", conn)
        sqlAdapter.Fill(faboptions)

        conn.Close()
        conn.Dispose()
        Return False

    End Function


    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim selectedDate As Date = tubeCalendar.SelectedDate.Date

        Dim Prod As String = tbProd.Text
        Dim toBox As String = tbTo.Text
        Dim fromBox As String = tbFrom.Text
        Dim tubetype As String = tbTubeType.Text
        Dim to_var As String


        If toBox = "green" Then
            to_var = "Green"
        ElseIf toBox = "blue" Then
            to_var = "Blue"
        End If



        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand


        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn


        conn.Open()

        If (fromBox = "blue" And toBox = "green") Then
            'MesgBox("Saving an outer")

            cmd.Parameters.AddWithValue("@prod", Prod)

            If (tubetype = "Outer") Then
                cmd.CommandText = "Update Tubes Set OuterRoller = 'Green' Where ProdNo = @prod"
                cmd.ExecuteNonQuery()
            ElseIf (tubetype = "Center") Then
                cmd.CommandText = "Update Tubes Set CenterRoller = 'Green' Where ProdNo = @prod"
                cmd.ExecuteNonQuery()
            End If

            'cmd.ExecuteNonQuery()


        ElseIf (fromBox = "green" And toBox = "blue") Then
            'MesgBox("Saving a center")

            cmd2.Parameters.AddWithValue("@prod2", Prod)

            If (tubetype = "Outer") Then
                cmd2.CommandText = "Update Tubes Set OuterRoller = 'Blue' Where ProdNo = @prod2"
                cmd2.ExecuteNonQuery()
            ElseIf (tubetype = "Center") Then
                cmd2.CommandText = "Update Tubes Set CenterRoller = 'Blue' Where ProdNo = @prod2"
                cmd2.ExecuteNonQuery()
            End If

        End If



        conn.Close()


        lvblue.DataBind()
        lvgreen.DataBind()
        getCounts()

    End Sub


    Protected Sub tubeCalendar_SelectionChanged(sender As Object, e As EventArgs) Handles tubeCalendar.SelectionChanged
        getCounts()
       
    End Sub


    Protected Function getCounts() As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim selecteddate As Date = tubeCalendar.SelectedDate
        Dim blueouters As Integer = 0
        Dim bluecenters As Integer = 0

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
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

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn
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

        cmd.CommandText = "Select Count (*) FROM Tubes where OuterScheduled =  '" & selecteddate & "' and OuterRoller = 'Blue'"
        cmd1.CommandText = "Select Count (*) FROM Tubes where OuterScheduled =  '" & selecteddate & "' and OuterRoller = 'Green'"
        cmd3.CommandText = "Select Count (*) FROM Tubes Left Join BML_POPREPORTING_TUBEPRIORITY on Tubes.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where CenterScheduled =  '" & selecteddate & "' and CenterRoller = 'Blue' and PerfPkg <>'EXP'"
        cmd4.CommandText = "Select Count (*) FROM Tubes Left Join BML_POPREPORTING_TUBEPRIORITY on Tubes.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where CenterScheduled =  '" & selecteddate & "' and CenterRoller = 'Green' and PerfPkg <> 'EXP'"
        cmd5.CommandText = "Select Count (*) FROM Tubes Left Join BML_POPREPORTING_TUBEPRIORITY on Tubes.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where CenterScheduled =  '" & selecteddate & "' and CenterRoller = 'Green' and PerfPkg = 'EXP'"
        cmd6.CommandText = "Select Count (*) FROM Tubes Left Join BML_POPREPORTING_TUBEPRIORITY on Tubes.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where CenterScheduled =  '" & selecteddate & "' and CenterRoller = 'Blue' and PerfPkg = 'EXP'"

        cmd7.CommandText = "Select Sum(OuterSections) as blueoutersum FROM Tubes where OuterScheduled =  '" & selecteddate & "' and OuterRoller = 'Blue'"
        cmd8.CommandText = "Select Sum(OuterSections) as greenoutersum FROM Tubes where OuterScheduled =  '" & selecteddate & "' and OuterRoller = 'Green'"

        cmd9.CommandText = "Select Sum(CenterSections) as bluecentersections FROM Tubes Left Join BML_POPREPORTING_TUBEPRIORITY on Tubes.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where CenterScheduled =  '" & selecteddate & "' and CenterRoller = 'Blue' and PerfPkg <>'EXP'"
        cmd10.CommandText = "Select Sum(CenterSections) as greencentersections FROM Tubes Left Join BML_POPREPORTING_TUBEPRIORITY on Tubes.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where CenterScheduled =  '" & selecteddate & "' and CenterRoller = 'Green' and PerfPkg <>'EXP'"

        cmd11.CommandText = "Select Sum(CenterSections) as blueexpsectionsFROM Tubes Left Join BML_POPREPORTING_TUBEPRIORITY on Tubes.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where CenterScheduled =  '" & selecteddate & "' and CenterRoller = 'Blue' and PerfPkg = 'EXP'"
        cmd12.CommandText = "Select Sum(CenterSections) as greenexpsections FROM Tubes Left Join BML_POPREPORTING_TUBEPRIORITY on Tubes.ProdNo = BML_POPREPORTING_TUBEPRIORITY.ProdNo where CenterScheduled =  '" & selecteddate & "' and CenterRoller = 'Green' and PerfPkg = 'EXP'"

        conn.Open()
        Dim numblueouters As Integer = cmd.ExecuteScalar
        Dim numgreenouters As Integer = cmd1.ExecuteScalar
        Dim numblueoutersections As Integer = 0
        Dim numgreenoutersections As Integer = 0

        If numblueouters > 0 Then
            numblueoutersections = cmd7.ExecuteScalar
        End If

        If numgreenouters > 0 Then
            numgreenoutersections = cmd8.ExecuteScalar
        End If


        lblBlueOuters.Text = numblueouters * 2
        lblGreenOuters.Text = numgreenouters * 2
        lblBlueCenters.Text = cmd3.ExecuteScalar
        lblGreenCenters.Text = cmd4.ExecuteScalar
        lblGreenExpress.Text = cmd5.ExecuteScalar
        lblBlueExpress.Text = cmd6.ExecuteScalar
        lblBlueOuterSections.Text = numblueoutersections * 2
        lblGreenOuterSections.Text = numgreenoutersections * 2

        If Convert.ToInt16(lblBlueCenters.Text) > 0 Then
            lblBlueCenterSections.Text = cmd9.ExecuteScalar
        Else
            lblBlueCenterSections.Text = 0
        End If

        If Convert.ToInt16(lblBlueExpress.Text) > 0 Then
            lblBlueExpressSections.Text = cmd11.ExecuteScalar
        Else
            lblBlueExpressSections.Text = 0
        End If

        If Convert.ToInt16(lblGreenCenters.Text) > 0 Then
            lblGreenCenterSections.Text = cmd10.ExecuteScalar
        Else
            lblGreenCenterSections.Text = 0
        End If



        If Convert.ToInt16(lblGreenExpress.Text) > 0 Then
            lblGreenExpressSections.Text = cmd12.ExecuteScalar
        Else
            lblGreenExpressSections.Text = 0
        End If

        lblBlueTotal.Text = Convert.ToInt32(lblBlueOuters.Text) + Convert.ToInt32(lblBlueCenters.Text) + Convert.ToInt32(lblBlueExpress.Text)
        lblGreenTotal.Text = Convert.ToInt32(lblGreenOuters.Text) + Convert.ToInt32(lblGreenCenters.Text) + Convert.ToInt32(lblGreenExpress.Text)

        lblBlueTotalSections.Text = Convert.ToInt32(lblBlueOuterSections.Text) + Convert.ToInt32(lblBlueCenterSections.Text) + Convert.ToInt32(lblBlueExpressSections.Text)
        lblGreenTotalSections.Text = Convert.ToInt32(lblGreenOuterSections.Text) + Convert.ToInt32(lblGreenCenterSections.Text) + Convert.ToInt32(lblGreenExpressSections.Text)







        conn.Close()

    End Function

End Class
