Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Rails_Production
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvAllFieldsR_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsR.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFabOptions"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try

            If (e.Row.DataItem("WeldDate") < ddlDateSelected.SelectedValue) Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If

        End If

    End Sub



    Protected Sub gvAllFieldsR_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsR.RowCommand

        If e.CommandName = "goto" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsR.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Rails" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotorepair" Then 'handles when the repair button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsR.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Repair" 'to pass in the workstation that makes the note.
            Dim url As String = "Repair.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1050,height=1000,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoreorder" Then 'handles when the reorder button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsR.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Reorder" 'to pass in the workstation that makes the note.
            Dim url As String = "Reorder.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1050,height=1000,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If
       

    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'If Not IsPostBack Then

        'Dim today As DateTime = DateTime.Today
        'Dim s_today As String = today.ToString("M/dd/yyyy")
        's_today = s_today & " 12:00:00 AM"
        'MesgBox(s_today)
        'Try
        'ddlDateSelected.SelectedValue = s_today
        'Catch ex As Exception

        'End Try

        'End If
    End Sub

    
    Protected Sub cbPF_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim SelectedProdNo As String = row.Cells(0).Text

        Dim cbPF As CheckBox = DirectCast(row.Cells(5).FindControl("cbPF"), CheckBox)
        Dim cbPR As CheckBox = DirectCast(row.Cells(5).FindControl("cbPR"), CheckBox)
        Dim cbSF As CheckBox = DirectCast(row.Cells(5).FindControl("cbSF"), CheckBox)
        Dim cbSR As CheckBox = DirectCast(row.Cells(5).FindControl("cbSR"), CheckBox)
        Dim cbT As CheckBox = DirectCast(row.Cells(5).FindControl("cbT"), CheckBox)
        Dim cbPM As CheckBox = DirectCast(row.Cells(5).FindControl("cbPM"), CheckBox)
        Dim cbSM As CheckBox = DirectCast(row.Cells(5).FindControl("cbSM"), CheckBox)

        Dim PF As Integer = If(cbPF.Checked, 1, 0)
        Dim PR As Integer = If(cbPR.Checked, 1, 0)
        Dim SF As Integer = If(cbSF.Checked, 1, 0)
        Dim SR As Integer = If(cbSR.Checked, 1, 0)
        Dim T As Integer = If(cbT.Checked, 1, 0)
        Dim PM As Integer = If(cbPM.Checked, 1, 0)
        Dim SM As Integer = If(cbSM.Checked, 1, 0)

        Dim RailsToSend As Integer = PF + PR + SF + SR + T + PM + SM

        cmd4.Parameters.AddWithValue("@PF", PF)
        cmd4.Parameters.AddWithValue("@PR", PR)
        cmd4.Parameters.AddWithValue("@SF", SF)
        cmd4.Parameters.AddWithValue("@SR", SR)
        cmd4.Parameters.AddWithValue("@T", T)
        cmd4.Parameters.AddWithValue("@PM", PM)
        cmd4.Parameters.AddWithValue("@SM", SM)

        cmd1.CommandText = "Select RailsNeeded From Rails_Tracking where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '1' where ProdNo =  '" & SelectedProdNo & "'"
        cmd3.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '0' where ProdNo =  '" & SelectedProdNo & "'"

        'Transactions
        cmd4.CommandText = "INSERT Into Rails_Transactions(ProdNo,TransactionDate,PF,SF,PR,SR,PM,SM,T,Produced,Received) VALUES ('" & SelectedProdNo & "', '" & TodaysDate & "', @PF, @SF, @PR, @SR, @PM, @SM, @T,1,0)"


        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        If chk.Checked Then
            cmd.CommandText = "UPDATE Rails_Tracking SET PF_Produced = '1' where ProdNo =  '" & SelectedProdNo & "'"
        Else
            cmd.CommandText = "UPDATE Rails_Tracking SET PF_Produced = '0' where ProdNo =  '" & SelectedProdNo & "'"
        End If

        conn.Open()
        cmd.ExecuteNonQuery()

        Dim temp As Object = cmd1.ExecuteScalar()
        Dim NumRailsNeeded As Nullable(Of Integer)

        NumRailsNeeded = If(Convert.IsDBNull(temp), New Integer?(), DirectCast(temp, Integer))

        If NumRailsNeeded.HasValue Then
            If RailsToSend = NumRailsNeeded Then
                cmd2.ExecuteNonQuery()
            Else
                cmd3.ExecuteNonQuery()
            End If
        End If


            cmd4.ExecuteNonQuery()
            conn.Close()
            gvAllFieldsR.DataBind()
    End Sub


    Protected Sub cbSF_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        Dim SelectedProdNo As String = row.Cells(0).Text

        Dim cbPF As CheckBox = DirectCast(row.Cells(5).FindControl("cbPF"), CheckBox)
        Dim cbPR As CheckBox = DirectCast(row.Cells(5).FindControl("cbPR"), CheckBox)
        Dim cbSF As CheckBox = DirectCast(row.Cells(5).FindControl("cbSF"), CheckBox)
        Dim cbSR As CheckBox = DirectCast(row.Cells(5).FindControl("cbSR"), CheckBox)
        Dim cbT As CheckBox = DirectCast(row.Cells(5).FindControl("cbT"), CheckBox)
        Dim cbPM As CheckBox = DirectCast(row.Cells(5).FindControl("cbPM"), CheckBox)
        Dim cbSM As CheckBox = DirectCast(row.Cells(5).FindControl("cbSM"), CheckBox)

        Dim PF As Integer = If(cbPF.Checked, 1, 0)
        Dim PR As Integer = If(cbPR.Checked, 1, 0)
        Dim SF As Integer = If(cbSF.Checked, 1, 0)
        Dim SR As Integer = If(cbSR.Checked, 1, 0)
        Dim T As Integer = If(cbT.Checked, 1, 0)
        Dim PM As Integer = If(cbPM.Checked, 1, 0)
        Dim SM As Integer = If(cbSM.Checked, 1, 0)

        Dim RailsToSend As Integer = PF + PR + SF + SR + T + PM + SM

        cmd4.Parameters.AddWithValue("@PF", PF)
        cmd4.Parameters.AddWithValue("@PR", PR)
        cmd4.Parameters.AddWithValue("@SF", SF)
        cmd4.Parameters.AddWithValue("@SR", SR)
        cmd4.Parameters.AddWithValue("@T", T)
        cmd4.Parameters.AddWithValue("@PM", PM)
        cmd4.Parameters.AddWithValue("@SM", SM)

        cmd1.CommandText = "Select RailsNeeded From Rails_Tracking where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '1', AllRailsProduced = '1' where ProdNo =  '" & SelectedProdNo & "'"
        cmd3.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '0' where ProdNo =  '" & SelectedProdNo & "'"

        'Transactions
        cmd4.CommandText = "INSERT Into Rails_Transactions(ProdNo,TransactionDate,PF,SF,PR,SR,PM,SM,T,Produced,Received) VALUES ('" & SelectedProdNo & "', '" & TodaysDate & "', @PF, @SF, @PR, @SR, @PM, @SM, @T,1,0)"


        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        If chk.Checked Then
            cmd.CommandText = "UPDATE Rails_Tracking SET SF_Produced = '1' where ProdNo =  '" & SelectedProdNo & "'"
        Else
            cmd.CommandText = "UPDATE Rails_Tracking SET SF_Produced = '0' where ProdNo =  '" & SelectedProdNo & "'"
        End If

        conn.Open()
        cmd.ExecuteNonQuery()

        Dim temp As Object = cmd1.ExecuteScalar()
        Dim NumRailsNeeded As Nullable(Of Integer)

        NumRailsNeeded = If(Convert.IsDBNull(temp), New Integer?(), DirectCast(temp, Integer))

        If NumRailsNeeded.HasValue Then
            If RailsToSend = NumRailsNeeded Then
                cmd2.ExecuteNonQuery()
            Else
                cmd3.ExecuteNonQuery()
            End If
        End If
        cmd4.ExecuteNonQuery()
        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub cbPR_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        Dim SelectedProdNo As String = row.Cells(0).Text

        Dim cbPF As CheckBox = DirectCast(row.Cells(5).FindControl("cbPF"), CheckBox)
        Dim cbPR As CheckBox = DirectCast(row.Cells(5).FindControl("cbPR"), CheckBox)
        Dim cbSF As CheckBox = DirectCast(row.Cells(5).FindControl("cbSF"), CheckBox)
        Dim cbSR As CheckBox = DirectCast(row.Cells(5).FindControl("cbSR"), CheckBox)
        Dim cbT As CheckBox = DirectCast(row.Cells(5).FindControl("cbT"), CheckBox)
        Dim cbPM As CheckBox = DirectCast(row.Cells(5).FindControl("cbPM"), CheckBox)
        Dim cbSM As CheckBox = DirectCast(row.Cells(5).FindControl("cbSM"), CheckBox)

        Dim PF As Integer = If(cbPF.Checked, 1, 0)
        Dim PR As Integer = If(cbPR.Checked, 1, 0)
        Dim SF As Integer = If(cbSF.Checked, 1, 0)
        Dim SR As Integer = If(cbSR.Checked, 1, 0)
        Dim T As Integer = If(cbT.Checked, 1, 0)
        Dim PM As Integer = If(cbPM.Checked, 1, 0)
        Dim SM As Integer = If(cbSM.Checked, 1, 0)

        Dim RailsToSend As Integer = PF + PR + SF + SR + T + PM + SM

        cmd4.Parameters.AddWithValue("@PF", PF)
        cmd4.Parameters.AddWithValue("@PR", PR)
        cmd4.Parameters.AddWithValue("@SF", SF)
        cmd4.Parameters.AddWithValue("@SR", SR)
        cmd4.Parameters.AddWithValue("@T", T)
        cmd4.Parameters.AddWithValue("@PM", PM)
        cmd4.Parameters.AddWithValue("@SM", SM)

        cmd1.CommandText = "Select RailsNeeded From Rails_Tracking where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '1' where ProdNo =  '" & SelectedProdNo & "'"
        cmd3.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '0' where ProdNo =  '" & SelectedProdNo & "'"

        'Transactions
        cmd4.CommandText = "INSERT Into Rails_Transactions(ProdNo,TransactionDate,PF,SF,PR,SR,PM,SM,T,Produced,Received) VALUES ('" & SelectedProdNo & "', '" & TodaysDate & "', @PF, @SF, @PR, @SR, @PM, @SM, @T,1,0)"


        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        If chk.Checked Then
            cmd.CommandText = "UPDATE Rails_Tracking SET PR_Produced = '1' where ProdNo =  '" & SelectedProdNo & "'"
        Else
            cmd.CommandText = "UPDATE Rails_Tracking SET PR_Produced = '0' where ProdNo =  '" & SelectedProdNo & "'"
        End If

        conn.Open()
        cmd.ExecuteNonQuery()

        Dim temp As Object = cmd1.ExecuteScalar()
        Dim NumRailsNeeded As Nullable(Of Integer)

        NumRailsNeeded = If(Convert.IsDBNull(temp), New Integer?(), DirectCast(temp, Integer))

        If NumRailsNeeded.HasValue Then
            If RailsToSend = NumRailsNeeded Then
                cmd2.ExecuteNonQuery()
            Else
                cmd3.ExecuteNonQuery()
            End If
        End If
        cmd4.ExecuteNonQuery()
        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub cbSR_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        Dim SelectedProdNo As String = row.Cells(0).Text

        Dim cbPF As CheckBox = DirectCast(row.Cells(5).FindControl("cbPF"), CheckBox)
        Dim cbPR As CheckBox = DirectCast(row.Cells(5).FindControl("cbPR"), CheckBox)
        Dim cbSF As CheckBox = DirectCast(row.Cells(5).FindControl("cbSF"), CheckBox)
        Dim cbSR As CheckBox = DirectCast(row.Cells(5).FindControl("cbSR"), CheckBox)
        Dim cbT As CheckBox = DirectCast(row.Cells(5).FindControl("cbT"), CheckBox)
        Dim cbPM As CheckBox = DirectCast(row.Cells(5).FindControl("cbPM"), CheckBox)
        Dim cbSM As CheckBox = DirectCast(row.Cells(5).FindControl("cbSM"), CheckBox)

        Dim PF As Integer = If(cbPF.Checked, 1, 0)
        Dim PR As Integer = If(cbPR.Checked, 1, 0)
        Dim SF As Integer = If(cbSF.Checked, 1, 0)
        Dim SR As Integer = If(cbSR.Checked, 1, 0)
        Dim T As Integer = If(cbT.Checked, 1, 0)
        Dim PM As Integer = If(cbPM.Checked, 1, 0)
        Dim SM As Integer = If(cbSM.Checked, 1, 0)

        Dim RailsToSend As Integer = PF + PR + SF + SR + T + PM + SM

        cmd4.Parameters.AddWithValue("@PF", PF)
        cmd4.Parameters.AddWithValue("@PR", PR)
        cmd4.Parameters.AddWithValue("@SF", SF)
        cmd4.Parameters.AddWithValue("@SR", SR)
        cmd4.Parameters.AddWithValue("@T", T)
        cmd4.Parameters.AddWithValue("@PM", PM)
        cmd4.Parameters.AddWithValue("@SM", SM)

        cmd1.CommandText = "Select RailsNeeded From Rails_Tracking where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '1' where ProdNo =  '" & SelectedProdNo & "'"
        cmd3.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '0' where ProdNo =  '" & SelectedProdNo & "'"

        'Transactions
        cmd4.CommandText = "INSERT Into Rails_Transactions(ProdNo,TransactionDate,PF,SF,PR,SR,PM,SM,T,Produced,Received) VALUES ('" & SelectedProdNo & "', '" & TodaysDate & "', @PF, @SF, @PR, @SR, @PM, @SM, @T,1,0)"


        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        If chk.Checked Then
            cmd.CommandText = "UPDATE Rails_Tracking SET SR_Produced = '1' where ProdNo =  '" & SelectedProdNo & "'"
        Else
            cmd.CommandText = "UPDATE Rails_Tracking SET SR_Produced = '0' where ProdNo =  '" & SelectedProdNo & "'"
        End If

        conn.Open()
        cmd.ExecuteNonQuery()

        Dim temp As Object = cmd1.ExecuteScalar()
        Dim NumRailsNeeded As Nullable(Of Integer)

        NumRailsNeeded = If(Convert.IsDBNull(temp), New Integer?(), DirectCast(temp, Integer))

        If NumRailsNeeded.HasValue Then
            If RailsToSend = NumRailsNeeded Then
                cmd2.ExecuteNonQuery()
            Else
                cmd3.ExecuteNonQuery()
            End If
        End If
        cmd4.ExecuteNonQuery()
        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub cbT_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        Dim SelectedProdNo As String = row.Cells(0).Text

        Dim cbPF As CheckBox = DirectCast(row.Cells(5).FindControl("cbPF"), CheckBox)
        Dim cbPR As CheckBox = DirectCast(row.Cells(5).FindControl("cbPR"), CheckBox)
        Dim cbSF As CheckBox = DirectCast(row.Cells(5).FindControl("cbSF"), CheckBox)
        Dim cbSR As CheckBox = DirectCast(row.Cells(5).FindControl("cbSR"), CheckBox)
        Dim cbT As CheckBox = DirectCast(row.Cells(5).FindControl("cbT"), CheckBox)
        Dim cbPM As CheckBox = DirectCast(row.Cells(5).FindControl("cbPM"), CheckBox)
        Dim cbSM As CheckBox = DirectCast(row.Cells(5).FindControl("cbSM"), CheckBox)

        Dim PF As Integer = If(cbPF.Checked, 1, 0)
        Dim PR As Integer = If(cbPR.Checked, 1, 0)
        Dim SF As Integer = If(cbSF.Checked, 1, 0)
        Dim SR As Integer = If(cbSR.Checked, 1, 0)
        Dim T As Integer = If(cbT.Checked, 1, 0)
        Dim PM As Integer = If(cbPM.Checked, 1, 0)
        Dim SM As Integer = If(cbSM.Checked, 1, 0)

        Dim RailsToSend As Integer = PF + PR + SF + SR + T + PM + SM

        cmd4.Parameters.AddWithValue("@PF", PF)
        cmd4.Parameters.AddWithValue("@PR", PR)
        cmd4.Parameters.AddWithValue("@SF", SF)
        cmd4.Parameters.AddWithValue("@SR", SR)
        cmd4.Parameters.AddWithValue("@T", T)
        cmd4.Parameters.AddWithValue("@PM", PM)
        cmd4.Parameters.AddWithValue("@SM", SM)

        cmd1.CommandText = "Select RailsNeeded From Rails_Tracking where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '1' where ProdNo =  '" & SelectedProdNo & "'"
        cmd3.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '0' where ProdNo =  '" & SelectedProdNo & "'"

        'Transactions
        cmd4.CommandText = "INSERT Into Rails_Transactions(ProdNo,TransactionDate,PF,SF,PR,SR,PM,SM,T,Produced,Received) VALUES ('" & SelectedProdNo & "', '" & TodaysDate & "', @PF, @SF, @PR, @SR, @PM, @SM, @T,1,0)"


        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        If chk.Checked Then
            cmd.CommandText = "UPDATE Rails_Tracking SET T_Produced = '1' where ProdNo =  '" & SelectedProdNo & "'"
        Else
            cmd.CommandText = "UPDATE Rails_Tracking SET T_Produced = '0' where ProdNo =  '" & SelectedProdNo & "'"
        End If

        conn.Open()
        cmd.ExecuteNonQuery()

        Dim temp As Object = cmd1.ExecuteScalar()
        Dim NumRailsNeeded As Nullable(Of Integer)

        NumRailsNeeded = If(Convert.IsDBNull(temp), New Integer?(), DirectCast(temp, Integer))

        If NumRailsNeeded.HasValue Then
            If RailsToSend = NumRailsNeeded Then
                cmd2.ExecuteNonQuery()
            Else
                cmd3.ExecuteNonQuery()
            End If
        End If


        cmd4.ExecuteNonQuery()
        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub
    Protected Sub cbPM_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        Dim SelectedProdNo As String = row.Cells(0).Text

        Dim cbPF As CheckBox = DirectCast(row.Cells(5).FindControl("cbPF"), CheckBox)
        Dim cbPR As CheckBox = DirectCast(row.Cells(5).FindControl("cbPR"), CheckBox)
        Dim cbSF As CheckBox = DirectCast(row.Cells(5).FindControl("cbSF"), CheckBox)
        Dim cbSR As CheckBox = DirectCast(row.Cells(5).FindControl("cbSR"), CheckBox)
        Dim cbT As CheckBox = DirectCast(row.Cells(5).FindControl("cbT"), CheckBox)
        Dim cbPM As CheckBox = DirectCast(row.Cells(5).FindControl("cbPM"), CheckBox)
        Dim cbSM As CheckBox = DirectCast(row.Cells(5).FindControl("cbSM"), CheckBox)

        Dim PF As Integer = If(cbPF.Checked, 1, 0)
        Dim PR As Integer = If(cbPR.Checked, 1, 0)
        Dim SF As Integer = If(cbSF.Checked, 1, 0)
        Dim SR As Integer = If(cbSR.Checked, 1, 0)
        Dim T As Integer = If(cbT.Checked, 1, 0)
        Dim PM As Integer = If(cbPM.Checked, 1, 0)
        Dim SM As Integer = If(cbSM.Checked, 1, 0)

        Dim RailsToSend As Integer = PF + PR + SF + SR + T + PM + SM

        cmd4.Parameters.AddWithValue("@PF", PF)
        cmd4.Parameters.AddWithValue("@PR", PR)
        cmd4.Parameters.AddWithValue("@SF", SF)
        cmd4.Parameters.AddWithValue("@SR", SR)
        cmd4.Parameters.AddWithValue("@T", T)
        cmd4.Parameters.AddWithValue("@PM", PM)
        cmd4.Parameters.AddWithValue("@SM", SM)

        cmd1.CommandText = "Select RailsNeeded From Rails_Tracking where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '1' where ProdNo =  '" & SelectedProdNo & "'"
        cmd3.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '0' where ProdNo =  '" & SelectedProdNo & "'"

        'Transactions
        cmd4.CommandText = "INSERT Into Rails_Transactions(ProdNo,TransactionDate,PF,SF,PR,SR,PM,SM,T,Produced,Received) VALUES ('" & SelectedProdNo & "', '" & TodaysDate & "', @PF, @SF, @PR, @SR, @PM, @SM, @T,1,0)"


        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        If chk.Checked Then
            cmd.CommandText = "UPDATE Rails_Tracking SET PM_Produced = '1' where ProdNo =  '" & SelectedProdNo & "'"
        Else
            cmd.CommandText = "UPDATE Rails_Tracking SET PM_Produced = '0' where ProdNo =  '" & SelectedProdNo & "'"
        End If

        conn.Open()
        cmd.ExecuteNonQuery()

        Dim temp As Object = cmd1.ExecuteScalar()
        Dim NumRailsNeeded As Nullable(Of Integer)

        NumRailsNeeded = If(Convert.IsDBNull(temp), New Integer?(), DirectCast(temp, Integer))

        If NumRailsNeeded.HasValue Then
            If RailsToSend = NumRailsNeeded Then
                cmd2.ExecuteNonQuery()
            Else
                cmd3.ExecuteNonQuery()
            End If
        End If


        cmd4.ExecuteNonQuery()
        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub cbSM_OnCheckedChanged(sender As Object, e As EventArgs)
        Dim chk As CheckBox = DirectCast(sender, CheckBox)
        Dim row As GridViewRow = DirectCast(chk.NamingContainer, GridViewRow)
        Dim TodaysDate As Date = Date.Now

        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        Dim SelectedProdNo As String = row.Cells(0).Text

        Dim cbPF As CheckBox = DirectCast(row.Cells(5).FindControl("cbPF"), CheckBox)
        Dim cbPR As CheckBox = DirectCast(row.Cells(5).FindControl("cbPR"), CheckBox)
        Dim cbSF As CheckBox = DirectCast(row.Cells(5).FindControl("cbSF"), CheckBox)
        Dim cbSR As CheckBox = DirectCast(row.Cells(5).FindControl("cbSR"), CheckBox)
        Dim cbT As CheckBox = DirectCast(row.Cells(5).FindControl("cbT"), CheckBox)
        Dim cbPM As CheckBox = DirectCast(row.Cells(5).FindControl("cbPM"), CheckBox)
        Dim cbSM As CheckBox = DirectCast(row.Cells(5).FindControl("cbSM"), CheckBox)

        Dim PF As Integer = If(cbPF.Checked, 1, 0)
        Dim PR As Integer = If(cbPR.Checked, 1, 0)
        Dim SF As Integer = If(cbSF.Checked, 1, 0)
        Dim SR As Integer = If(cbSR.Checked, 1, 0)
        Dim T As Integer = If(cbT.Checked, 1, 0)
        Dim PM As Integer = If(cbPM.Checked, 1, 0)
        Dim SM As Integer = If(cbSM.Checked, 1, 0)

        Dim RailsToSend As Integer = PF + PR + SF + SR + T + PM + SM

        cmd4.Parameters.AddWithValue("@PF", PF)
        cmd4.Parameters.AddWithValue("@PR", PR)
        cmd4.Parameters.AddWithValue("@SF", SF)
        cmd4.Parameters.AddWithValue("@SR", SR)
        cmd4.Parameters.AddWithValue("@T", T)
        cmd4.Parameters.AddWithValue("@PM", PM)
        cmd4.Parameters.AddWithValue("@SM", SM)

        cmd1.CommandText = "Select RailsNeeded From Rails_Tracking where ProdNo =  '" & SelectedProdNo & "'"
        cmd2.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '1' where ProdNo =  '" & SelectedProdNo & "'"
        cmd3.CommandText = "UPDATE Rails_Tracking SET AllRailsSent = '0' where ProdNo =  '" & SelectedProdNo & "'"

        'Transactions
        cmd4.CommandText = "INSERT Into Rails_Transactions(ProdNo,TransactionDate,PF,SF,PR,SR,PM,SM,T,Produced,Received) VALUES ('" & SelectedProdNo & "', '" & TodaysDate & "', @PF, @SF, @PR, @SR, @PM, @SM, @T,1,0)"


        cmd.Connection = conn
        cmd1.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        If chk.Checked Then
            cmd.CommandText = "UPDATE Rails_Tracking SET SM_Produced = '1' where ProdNo =  '" & SelectedProdNo & "'"
        Else
            cmd.CommandText = "UPDATE Rails_Tracking SET SM_Produced = '0' where ProdNo =  '" & SelectedProdNo & "'"
        End If

        conn.Open()
        cmd.ExecuteNonQuery()

        Dim temp As Object = cmd1.ExecuteScalar()
        Dim NumRailsNeeded As Nullable(Of Integer)

        NumRailsNeeded = If(Convert.IsDBNull(temp), New Integer?(), DirectCast(temp, Integer))

        If NumRailsNeeded.HasValue Then
            If RailsToSend = NumRailsNeeded Then
                cmd2.ExecuteNonQuery()
            Else
                cmd3.ExecuteNonQuery()
            End If
        End If


        cmd4.ExecuteNonQuery()
        conn.Close()
        gvAllFieldsR.DataBind()
    End Sub
End Class
