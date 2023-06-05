Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Rails_ReordersTracking
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

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFabOptions"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsDrawingDims"), SqlDataSource)

            Dim prodno As String = e.Row.DataItem("ProdNo")
            Dim model As String = e.Row.DataItem("ItemNo")
            Dim reqdate As Date = e.Row.DataItem("DateReq")
            Dim reqdateset As Date = reqdate.Date

            If Len(e.Row.DataItem("WeldDate").ToString) = 0 Then

            Else
                Dim welddate As Date = e.Row.DataItem("WeldDate")
                Dim welddateset As Date = welddate.Date
                If welddateset = reqdateset Then
                    e.Row.BackColor = Drawing.Color.LightGreen
                End If
            End If


            Dim modelyear As String = "2018"

            If Left(prodno, 2) = "18" Then
                modelyear = "2018"

            ElseIf Left(prodno, 2) = "19" Then
                modelyear = "2019"

            ElseIf Left(prodno, 2) = "20" Then
                modelyear = "2020"

            ElseIf Left(prodno, 2) = "21" Then
                modelyear = "2021"

            ElseIf Left(prodno, 2) = "22" Then
                modelyear = "2022"

            ElseIf Left(prodno, 2) = "23" Then
                modelyear = "2023"

            ElseIf Left(prodno, 2) = "24" Then
                modelyear = "2024"

            End If

            Dim rail As String
            Dim drawingno As String

            Dim cmd As New SqlCommand

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try

            If e.Row.DataItem("PF") = "1" Then
                e.Row.Cells(2).Text = "Port Front"
                rail = "PortFront"
                cmd.CommandText = "Select PortFront from Models Where ModelYear = @Year and Model = @Model"

            ElseIf e.Row.DataItem("SF") = "1" Then
                e.Row.Cells(2).Text = "Strb Front"
                rail = "StrbFront"
                cmd.CommandText = "Select StrbFront from Models Where ModelYear = @Year and Model = @Model"

            ElseIf e.Row.DataItem("PR") = "1" Then
                e.Row.Cells(2).Text = "Port Rear"
                rail = "PortRear"
                cmd.CommandText = "Select PortRear from Models Where ModelYear = @Year and Model = @Model"

            ElseIf e.Row.DataItem("SR") = "1" Then
                e.Row.Cells(2).Text = "Strb Rear"
                rail = "StrbRear"
                cmd.CommandText = "Select StrbRear from Models Where ModelYear = @Year and Model = @Model"

            ElseIf e.Row.DataItem("T") = "1" Then
                e.Row.Cells(2).Text = "Transom"
                rail = "Transom"
                cmd.CommandText = "Select Transom from Models Where ModelYear = @Year and Model = @Model"

            ElseIf e.Row.DataItem("PM") = "1" Then
                e.Row.Cells(2).Text = "Port Mid"
                rail = "PortMid"
                cmd.CommandText = "Select PortMid from Models Where ModelYear = @Year and Model = @Model"

            ElseIf e.Row.DataItem("SM") = "1" Then
                e.Row.Cells(2).Text = "Strb Mid"
                rail = "StrbMid"
                cmd.CommandText = "Select StrbMid from Models Where ModelYear = @Year and Model = @Model"
            End If



            'select drawing # where model, modelyear and drawing match - then use that drawing # as the source for a sds connection for the gridview of cut data.
            'Select rail from Rails.Drawings Where Model = model and ModelYear = year

            Dim conn As New SqlConnection
            Dim connstr As String = "Data Source=ELK1ITSSQL002;Initial Catalog=Rails;Persist Security Info=True;User ID=BM2;Password=Pb0@ts2"


            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.Parameters.AddWithValue("@Year", modelyear)
            cmd.Parameters.AddWithValue("@Model", model)



            'Hide cut list for customs to make them look closer
            Try
                conn.Open()
                drawingno = cmd.ExecuteScalar.ToString
                conn.Close()
                'If drawingno.Length > 0 Then
                If (e.Row.DataItem("CustDrawNo").ToString.Length < 1) Then
                    Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                        'MesgBox(drawingno.Length)

                        t.SelectParameters(0).DefaultValue = drawingno

                    Catch

                    End Try
                End If
            Catch
            End Try

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

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "UpdateRRStatus" Then
            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            'Dim SelectedProdNo As Integer = gvAllFieldsR.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command

            Dim rbList As RadioButtonList = DirectCast(gvAllFieldsR.Rows(Key).Cells(6).FindControl("rblReorderStatus"), RadioButtonList)
            Dim status As Integer = rbList.SelectedValue
            'Dim autoid As String = gvAllFieldsR.Rows(Key).DataItem("Auto")
            Dim autoid As String = DirectCast(gvAllFieldsR.Rows(Key).Cells(1).FindControl("lblAutoID"), Label).Text

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand

            cmd.Parameters.AddWithValue("@Status", status)

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE Rails_RepairsReorders SET Status = @Status, StatusDate = '" & TodaysDate & "' where Auto =  '" & autoid & "'"

            conn.Open()

            cmd.ExecuteNonQuery()

            conn.Close()
            gvAllFieldsR.DataBind()

            End If


    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvAllFieldsR.DataBind()
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

        gvAllFieldsR.DataBind()

    End Sub
End Class

