Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Tubes_TubeScheduling
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

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim selectedDate As Date = calDateSelected.SelectedDate.Date

        If selectedDate = DateTime.MinValue.Date Then
            MesgBox("Please select the date you want to schedule.")
        Else

            Dim Prod As String = tbProdNo.Text
            Dim order As Integer = tbOrder.Text.ToString
            Dim toBox As String = tbTo.Text
            Dim fromBox As String = tbFrom.Text


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

            conn.Open()

            If ((fromBox = "main" Or fromBox = "south" Or fromBox = "value") And toBox = "dayouters") Or (fromBox = "dayouters" And toBox = "dayouters") Then
                'MesgBox("Saving an outer")


                cmd.Parameters.AddWithValue("@seldate", selectedDate)
                cmd.Parameters.AddWithValue("@prod", Prod)
                cmd.Parameters.AddWithValue("@order", order)

                cmd.CommandText = "Update Tubes Set OuterScheduledFlag = '1', OuterScheduled = @seldate, OuterScheduleOrder = @order Where ProdNo = @prod"
                cmd.ExecuteNonQuery()


                Dim i As Integer = 1

                For Each item As ListViewItem In lvplannedouters.Items
                    Dim prodno As Integer = lvplannedouters.DataKeys(item.DataItemIndex).Value

                    cmd1.CommandText = "Update Tubes Set OuterScheduledFlag ='1', OuterScheduled = '" & selectedDate & "', OuterScheduleOrder = '" & i & "' Where ProdNo = '" & prodno & "' and OuterScheduleOrder >= '" & order & "'"

                    If (prodno <> Prod) Then
                        cmd1.ExecuteNonQuery()
                        i = i + 1
                    End If
                Next

            ElseIf ((fromBox = "maincenters" Or fromBox = "southcenters" Or fromBox = "valuecenters") And toBox = "daycenters") Or (fromBox = "daycenters" And toBox = "daycenters") Then
                'MesgBox("Saving a center")

                cmd2.Parameters.AddWithValue("@seldate2", selectedDate)
                cmd2.Parameters.AddWithValue("@prod2", Prod)
                cmd2.Parameters.AddWithValue("@order2", order)

                cmd2.CommandText = "Update Tubes Set CenterScheduledFlag = '1', CenterScheduled = @seldate2, CenterScheduleOrder = @order2 Where ProdNo = @prod2"
                cmd2.ExecuteNonQuery()


                Dim i As Integer = 1

                For Each item As ListViewItem In lvplannedcenters.Items
                    Dim prodno As Integer = lvplannedcenters.DataKeys(item.DataItemIndex).Value

                    cmd3.CommandText = "Update Tubes Set CenterScheduledFlag ='1', CenterScheduled = '" & selectedDate & "', CenterScheduleOrder = '" & i & "' Where ProdNo = '" & prodno & "' and CenterScheduleOrder >= '" & order & "'"

                    If (prodno <> Prod) Then
                        cmd3.ExecuteNonQuery()
                        i = i + 1
                    End If
                Next

                'To Unplan
            ElseIf (fromBox = "daycenters" And (toBox = "maincenters" Or toBox = "southcenters" Or toBox = "valuecenters")) Then

                cmd4.Parameters.AddWithValue("@prod4", Prod)
                cmd4.CommandText = "Update Tubes Set CenterScheduledFlag = '0', CenterScheduled = NULL, CenterScheduleOrder = NULL Where ProdNo = @prod4"
                cmd4.ExecuteNonQuery()

            ElseIf (fromBox = "dayouters" And (toBox = "main" Or toBox = "south" Or toBox = "value")) Then

                cmd5.Parameters.AddWithValue("@prod5", Prod)
                cmd5.CommandText = "Update Tubes Set OuterScheduledFlag = '0', OuterScheduled = NULL, OuterScheduleOrder = NULL Where ProdNo = @prod5"
                cmd5.ExecuteNonQuery()

            End If

            cmd6.Connection = conn
            cmd7.Connection = conn


            cmd6.Parameters.AddWithValue("@selDay6", selectedDate)
            cmd7.Parameters.AddWithValue("@selDay7", selectedDate)
            cmd8.Parameters.AddWithValue("@selDay8", selectedDate)
            cmd9.Parameters.AddWithValue("@selDay9", selectedDate)
            cmd10.Parameters.AddWithValue("@selDay10", selectedDate)
            cmd11.Parameters.AddWithValue("@selDay11", selectedDate)
            cmd12.Parameters.AddWithValue("@selDay12", selectedDate)


            cmd6.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where Tubes.OuterScheduledFlag = 1 and Tubes.OuterScheduled = @selDay6 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M'"
            cmd7.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where Tubes.OuterScheduledFlag = 1 and Tubes.OuterScheduled = @selDay7 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S'"
            cmd8.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Where Tubes.CenterScheduledFlag = 1 and Tubes.CenterScheduled = @selDay8"
            cmd9.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TubePriority.ProdNo Where Tubes.CenterScheduledFlag = 1 and Tubes.CenterScheduled = @selDay9 and PerfPkg = 'ESP'"
            cmd10.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TubePriority.ProdNo Where Tubes.CenterScheduledFlag = 1 and Tubes.CenterScheduled = @selDay10 and PerfPkg = 'SPS'"
            cmd11.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TubePriority.ProdNo Where Tubes.CenterScheduledFlag = 1 and Tubes.CenterScheduled = @selDay11 and PerfPkg = 'EXP'"
            cmd12.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where Tubes.OuterScheduledFlag = 1 and Tubes.OuterScheduled = @selDay12 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V'"


            mCount.Text = cmd6.ExecuteScalar
            sCount.Text = cmd7.ExecuteScalar
            vCount.Text = cmd12.ExecuteScalar
            OutersCount.Text = Convert.ToInt32(mCount.Text) + Convert.ToInt32(vCount.Text) + Convert.ToInt32(sCount.Text)

            centerCount.Text = cmd8.ExecuteScalar
            espCount.Text = cmd9.ExecuteScalar
            spsCount.Text = cmd10.ExecuteScalar
            expCount.Text = cmd11.ExecuteScalar

            conn.Close()
        End If

        lvplannedouters.DataBind()
        lvplannedcenters.DataBind()
        lvmain.DataBind()
        lvsouth.DataBind()
        lvsouthcenters.DataBind()
        lvmaincenters.DataBind()
        lvvalue.DataBind()
        lvvaluecenters.DataBind()



    End Sub

    Protected Sub calDateSelected_SelectionChanged(sender As Object, e As EventArgs) Handles calDateSelected.SelectionChanged

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd6 As New SqlCommand

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn

        Dim selDay As Date = calDateSelected.SelectedDate.Date

        cmd.Parameters.AddWithValue("@selDay", selDay)
        cmd1.Parameters.AddWithValue("@selDay1", selDay)
        cmd2.Parameters.AddWithValue("@selDay2", selDay)
        cmd3.Parameters.AddWithValue("@selDay3", selDay)
        cmd4.Parameters.AddWithValue("@selDay4", selDay)
        cmd5.Parameters.AddWithValue("@selDay5", selDay)
        cmd6.Parameters.AddWithValue("@selDay6", selDay)



        cmd.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where Tubes.OuterScheduledFlag = 1 and Tubes.OuterScheduled = @selDay and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M'"
        cmd1.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where Tubes.OuterScheduledFlag = 1 and Tubes.OuterScheduled = @selDay1 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S'"

        cmd2.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Where Tubes.CenterScheduledFlag = 1 and Tubes.CenterScheduled = @selDay2"
        cmd3.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TubePriority.ProdNo Where Tubes.CenterScheduledFlag = 1 and Tubes.CenterScheduled = @selDay3 and PerfPkg = 'ESP'"
        cmd4.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TubePriority.ProdNo Where Tubes.CenterScheduledFlag = 1 and Tubes.CenterScheduled = @selDay4 and PerfPkg = 'SPS'"
        cmd5.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_TUBEPRIORITY on BML_POPREPORTING.ProdNo = BML_POPREPORTING_TubePriority.ProdNo Where Tubes.CenterScheduledFlag = 1 and Tubes.CenterScheduled = @selDay5 and PerfPkg = 'EXP'"
        cmd6.CommandText = "Select Count(Tubes.ProdNo) From BML_POPREPORTING Left Join Tubes on BML_POPREPORTING.ProdNo = Tubes.ProdNo Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo Where Tubes.OuterScheduledFlag = 1 and Tubes.OuterScheduled = @selDay6 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V'"


        conn.Open()
        mCount.Text = cmd.ExecuteScalar
        sCount.Text = cmd1.ExecuteScalar
        vCount.Text = cmd6.ExecuteScalar
        OutersCount.Text = Convert.ToInt32(mCount.Text) + Convert.ToInt32(vCount.Text) + Convert.ToInt32(sCount.Text)

        centerCount.Text = cmd2.ExecuteScalar
        espCount.Text = cmd3.ExecuteScalar
        spsCount.Text = cmd4.ExecuteScalar
        expCount.Text = cmd5.ExecuteScalar


        conn.Close()

    End Sub



    Protected Sub lvmain_ItemDataBound(sender As Object, e As ListViewItemEventArgs) Handles lvmain.ItemDataBound, lvvalue.ItemDataBound, lvsouth.ItemDataBound, lvmaincenters.ItemDataBound, lvvaluecenters.ItemDataBound, lvsouthcenters.ItemDataBound, lvplannedcenters.ItemDataBound, lvplannedouters.ItemDataBound
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
End Class
