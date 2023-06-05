Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class LadderRepairsReorders
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Dim TopSilverReorderQty As String = tbTopSilverReorderQty.Text
        Dim BottomSilverReorderQty As String = tbBottomSilverReorderQty.Text
        Dim TopBlackReorderQty As String = tbTOPBlackReorderQty.Text
        Dim BottomBlackReorderQty As String = tbBottomBlackReorderQty.Text

        'Dim LeftSilverRepairQty As String = tbLeftSilverRepairQty.Text
        'Dim RightSilverRepairQty As String = tbRightSilverRepairQty.Text
        'Dim LeftBlackRepairQty As String = tbLeftBlackRepairQty.Text
        'Dim RightBlackRepairQty As String = tbRightBlackRepairQty.Text

        Dim LeftSilverReorderQty As String = tbLeftSilverReorderQty.Text
        Dim CenterSilverReorderQty As String = tbCenterSilverReorderQty.Text
        Dim RightSilverReorderQty As String = tbRightSilverReorderQty.Text

        Dim LeftBlackReorderQty As String = tbLeftBlackReorderQty.Text
        Dim CenterBlackReorderQty As String = tbCenterBlackReorderQty.Text
        Dim RightBlackReorderQty As String = tbRightBlackReorderQty.Text


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
        Dim cmd13 As New SqlCommand

        Dim TodaysDate As Date = Date.Now

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
        cmd13.Connection = conn

        cmd.Parameters.AddWithValue("@TopSilverReorderQty", TopSilverReorderQty)
        cmd1.Parameters.AddWithValue("@BottomSilverReorderQty", BottomSilverReorderQty)
        cmd2.Parameters.AddWithValue("@TopBlackReorderQty", TopBlackReorderQty)
        cmd3.Parameters.AddWithValue("@BottomBlackReorderQty", BottomBlackReorderQty)

        'cmd4.Parameters.AddWithValue("@LeftSilverRepairQty", LeftSilverRepairQty)
        'cmd5.Parameters.AddWithValue("@RightSilverRepairQty", RightSilverRepairQty)
        'cmd6.Parameters.AddWithValue("@LeftBlackRepairQty", LeftBlackRepairQty)
        'cmd7.Parameters.AddWithValue("@RightBlackRepairQty", RightBlackRepairQty)

        cmd8.Parameters.AddWithValue("@LeftSilverReorderQty", LeftSilverReorderQty)
        cmd9.Parameters.AddWithValue("@RightSilverReorderQty", RightSilverReorderQty)
        cmd10.Parameters.AddWithValue("@CenterSilverReorderQty", CenterSilverReorderQty)
        cmd11.Parameters.AddWithValue("@LeftBlackReorderQty", LeftBlackReorderQty)
        cmd12.Parameters.AddWithValue("@RightBlackReorderQty", RightBlackReorderQty)
        cmd13.Parameters.AddWithValue("@CenterBlackReorderQty", CenterBlackReorderQty)



        cmd.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Top', 'Reorder', 'Silver', '" & TodaysDate & "', @TopSilverReorderQty)"
        cmd1.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Bottom', 'Reorder', 'Silver', '" & TodaysDate & "', @BottomSilverReorderQty)"
        cmd2.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Top', 'Reorder', 'Black', '" & TodaysDate & "', @TopBlackReorderQty)"
        cmd3.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Bottom', 'Reorder', 'Black', '" & TodaysDate & "', @BottomBlackReorderQty)"

        'cmd4.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Left', 'Repair', 'Silver', '" & TodaysDate & "', @LeftSilverRepairQty)"
        'cmd5.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Right', 'Repair', 'Silver', '" & TodaysDate & "', @RightSilverRepairQty)"
        'cmd6.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Left', 'Repair', 'Black', '" & TodaysDate & "', @LeftBlackRepairQty)"
        'cmd7.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Right', 'Repair', 'Black', '" & TodaysDate & "', @RightBlackRepairQty)"

        cmd8.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Left', 'Reorder', 'Silver', '" & TodaysDate & "', @LeftSilverReorderQty)"
        cmd9.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Right', 'Reorder', 'Silver', '" & TodaysDate & "', @RightSilverReorderQty)"
        cmd10.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Center', 'Reorder', 'Silver', '" & TodaysDate & "', @CenterSilverReorderQty)"
        cmd11.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Left', 'Reorder', 'Black', '" & TodaysDate & "', @LeftBlackReorderQty)"
        cmd12.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Right', 'Reorder', 'Black', '" & TodaysDate & "', @RightBlackReorderQty)"
        cmd13.CommandText = "Insert into LadderTransactions (Part, Type, Color, DateAdded, Qty) VALUES ('Center', 'Reorder', 'Black', '" & TodaysDate & "', @CenterBlackReorderQty)"


        conn.Open()


        If TopSilverReorderQty.Length > 0 Then
            cmd.ExecuteNonQuery()
        End If

        If BottomSilverReorderQty.Length > 0 Then
            cmd1.ExecuteNonQuery()
        End If

        If TopBlackReorderQty.Length > 0 Then
            cmd2.ExecuteNonQuery()
        End If

        If BottomBlackReorderQty.Length > 0 Then
            cmd3.ExecuteNonQuery()
        End If

        'If LeftSilverRepairQty.Length > 0 Then
        ' cmd4.ExecuteNonQuery()
        ' End If

        'If RightSilverRepairQty.Length > 0 Then
        ' cmd5.ExecuteNonQuery()
        ' End If

        '        If LeftBlackRepairQty.Length > 0 Then
        'cmd6.ExecuteNonQuery()
        'End If

        'If RightBlackRepairQty.Length > 0 Then
        'cmd7.ExecuteNonQuery()
        'End If

        If LeftSilverReorderQty.Length > 0 Then
            cmd8.ExecuteNonQuery()
        End If

        If RightSilverReorderQty.Length > 0 Then
            cmd9.ExecuteNonQuery()
        End If

        If CenterSilverReorderQty.Length > 0 Then
            cmd10.ExecuteNonQuery()
        End If

        If LeftBlackReorderQty.Length > 0 Then
            cmd11.ExecuteNonQuery()
        End If

        If RightBlackReorderQty.Length > 0 Then
            cmd12.ExecuteNonQuery()
        End If

        If CenterBlackReorderQty.Length > 0 Then
            cmd13.ExecuteNonQuery()
        End If

        conn.Close()


        'MesgBox("Saved")

        tbTopSilverReorderQty.Text = ""
        tbBottomSilverReorderQty.Text = ""
        tbTOPBlackReorderQty.Text = ""
        tbBottomBlackReorderQty.Text = ""

        tbLeftSilverReorderQty.Text = ""
        tbCenterSilverReorderQty.Text = ""
        tbRightSilverReorderQty.Text = ""

        tbLeftBlackReorderQty.Text = ""
        tbCenterBlackReorderQty.Text = ""
        tbRightBlackReorderQty.Text = ""

        GetDailyTotals()

    End Sub
    Protected Sub GetDailyTotals()

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
        Dim cmd13 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

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
        cmd13.Connection = conn

        cmd.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Top' and Color = 'Silver' and Resolved = '0'"
        cmd1.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Top' and Color = 'Black' and Resolved = '0'"

        cmd2.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Bottom' and Color = 'Silver' and Resolved = '0'"
        cmd3.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Bottom' and Color = 'Black' and Resolved = '0'"

        cmd4.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Repair' and Part = 'Left' and Color = 'Silver' and Resolved = '0'"
        cmd5.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Repair' and Part = 'Left' and Color = 'Black' and Resolved = '0'"

        cmd6.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Repair' and Part = 'Right' and Color = 'Silver' and Resolved = '0'"
        cmd7.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Repair' and Part = 'Right' and Color = 'Black' and Resolved = '0'"

        cmd8.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Left' and Color = 'Silver' and Resolved = '0'"
        cmd9.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Left' and Color = 'Black' and Resolved = '0'"

        cmd10.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Center' and Color = 'Silver' and Resolved = '0'"
        cmd11.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Center' and Color = 'Black' and Resolved = '0'"

        cmd12.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Right' and Color = 'Silver' and Resolved = '0'"
        cmd13.CommandText = "Select Sum(Qty) From LadderTransactions Where Type = 'Reorder' and Part = 'Right' and Color = 'Black' and Resolved = '0'"



        conn.Open()

        Dim DailySilverTopsReorder As String
        Dim DailyBlackTopsReorder As String
        Dim DailySilverBottomReorder As String
        Dim DailyBlackBottomReorder As String
        Dim DailySilverLeftRepair As String
        Dim DailyBlackLeftRepair As String
        Dim DailySilverRightRepair As String
        Dim DailyBlackRightRepair As String
        Dim DailySilverLeftReorder As String
        Dim DailyBlackLeftReorder As String
        Dim DailySilverCenterReorder As String
        Dim DailyBlackCenterReorder As String
        Dim DailySilverRightReorder As String
        Dim DailyBlackRightReorder As String


        DailySilverTopsReorder = cmd.ExecuteScalar().ToString
        DailyBlackTopsReorder = cmd1.ExecuteScalar().ToString
        DailySilverBottomReorder = cmd2.ExecuteScalar().ToString
        DailyBlackBottomReorder = cmd3.ExecuteScalar().ToString
        DailySilverLeftRepair = cmd4.ExecuteScalar().ToString
        DailyBlackLeftRepair = cmd5.ExecuteScalar().ToString
        DailySilverRightRepair = cmd6.ExecuteScalar().ToString
        DailyBlackRightRepair = cmd7.ExecuteScalar().ToString
        DailySilverLeftReorder = cmd8.ExecuteScalar().ToString
        DailyBlackLeftReorder = cmd9.ExecuteScalar().ToString
        DailySilverCenterReorder = cmd10.ExecuteScalar().ToString
        DailyBlackCenterReorder = cmd11.ExecuteScalar().ToString
        DailySilverRightReorder = cmd12.ExecuteScalar().ToString
        DailyBlackRightReorder = cmd13.ExecuteScalar().ToString

        If DailySilverTopsReorder Is Nothing Then
            lblDailySilverTopsReorder.Text = "0"
        Else
            lblDailySilverTopsReorder.Text = DailySilverTopsReorder.ToString
        End If

        If DailyBlackTopsReorder Is Nothing Then
            lblDailyBlackTopsReorder.Text = "0"
        Else
            lblDailyBlackTopsReorder.Text = DailyBlackTopsReorder.ToString
        End If

        If DailySilverBottomReorder Is Nothing Then
            lblDailySilverBottomReorder.Text = "0"
        Else
            lblDailySilverBottomReorder.Text = DailySilverBottomReorder.ToString
        End If

        If DailyBlackBottomReorder Is Nothing Then
            lblDailyBlackBottomReorder.Text = "0"
        Else
            lblDailyBlackBottomReorder.Text = DailyBlackBottomReorder.ToString
        End If

        If DailySilverLeftRepair Is Nothing Then
            lblDailySilverRepairLeft.Text = "0"
        Else
            lblDailySilverRepairLeft.Text = DailySilverLeftRepair.ToString
        End If

        If DailyBlackLeftRepair Is Nothing Then
            lblDailyBlackRepairLeft.Text = "0"
        Else
            lblDailyBlackRepairLeft.Text = DailyBlackLeftRepair.ToString
        End If

        If DailySilverRightRepair Is Nothing Then
            lblDailySilverRepairRight.Text = "0"
        Else
            lblDailySilverRepairRight.Text = DailySilverRightRepair.ToString
        End If

        If DailyBlackRightRepair Is Nothing Then
            lblDailyBlackRepairRight.Text = "0"
        Else
            lblDailyBlackRepairRight.Text = DailyBlackRightRepair.ToString
        End If

        If DailySilverLeftReorder Is Nothing Then
            lblDailySilverReorderLeft.Text = "0"
        Else
            lblDailySilverReorderLeft.Text = DailySilverLeftReorder.ToString
        End If

        If DailyBlackLeftReorder Is Nothing Then
            lblDailyBlackReorderLeft.Text = "0"
        Else
            lblDailyBlackReorderLeft.Text = DailyBlackLeftReorder.ToString
        End If

        If DailySilverCenterReorder Is Nothing Then
            lblDailySilverReorderCenter.Text = "0"
        Else
            lblDailySilverReorderCenter.Text = DailySilverCenterReorder.ToString
        End If

        If DailyBlackCenterReorder Is Nothing Then
            lblDailyBlackReorderCenter.Text = "0"
        Else
            lblDailyBlackReorderCenter.Text = DailyBlackCenterReorder.ToString
        End If

        If DailySilverRightReorder Is Nothing Then
            lblDailySilverReorderRight.Text = "0"
        Else
            lblDailySilverReorderRight.Text = DailySilverRightReorder.ToString
        End If

        If DailyBlackRightReorder Is Nothing Then
            lblDailyBlackReorderRight.Text = "0"
        Else
            lblDailyBlackReorderRight.Text = DailyBlackRightReorder.ToString
        End If

        conn.Close()

        gvReorders.DataBind()

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetDailyTotals()
        End If

    End Sub

    Protected Sub gvReorders_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvReorders.RowCommand
        If e.CommandName = "gotoMarkResolved" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            Dim cmd As New SqlCommand
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE LadderTransactions SET Resolved = '1' , DateResolved = '" & TodaysDate & "' where AutoID =  '" & Key & "'"
            'MesgBox(Key)
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
            gvReorders.DataBind()
            GetDailyTotals()

        End If
    End Sub
End Class
