﻿Imports System.Data
Imports System.Data.SqlClient

Partial Class KittingSouth
    Inherits System.Web.UI.Page

    Public KitColors As New DataTable
    Public PartQtys As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub gvKitting_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvKitting.RowCommand
        If e.CommandName = "goto" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvKitting.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Kitting3" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvKitting.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Kitting3" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If


        If e.CommandName = "UpdateKittingStatus" Then


            'This code is for the update button
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvKitting.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command


            Dim rbList As RadioButtonList = DirectCast(gvKitting.Rows(Key).Cells(6).FindControl("rblKittingStatus"), RadioButtonList)
            'set the value of the radio button equal to what it is in the database on load.

            Dim conn As New SqlConnection()


            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            'Dim cmd3 As New SqlCommand
            'Dim cmd4 As New SqlCommand
            'Dim cmd5 As New SqlCommand
            'Dim cmd6 As New SqlCommand
            'Dim cmd7 As New SqlCommand
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand
            Dim cmd10 As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim greenlightcount As Int16 = 0
            Dim tubeneeded As Int16 = 0
            Dim tubecomplete As Int16 = 0
            Dim framesreadytostart As Int16
            Dim framesreadytostartio As Int16



            conn.ConnectionString = connstr


            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET KittingSouthStatus = '" & rbList.SelectedValue & "' , KittingSouth = '" & TodaysDate & "', Kit5RcvStatus = '" & rbList.SelectedValue & "' , Kit5Rcv = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where KittingSouthStatus = 2 and Convert(date,KittingSouth) ='" & ThisDay & "'"
            cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
            cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
            'cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus >= 1 and ProdNo =  '" & SelectedProdNo & "'"



            cmd.Connection = conn
            cmd2.Connection = conn
            cmd8.Connection = conn
            cmd9.Connection = conn
            cmd10.Connection = conn

            conn.Open()

            cmd.ExecuteNonQuery()
            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
            lblBoatsStarted.Text = recordcount
            framesreadytostart = Convert.ToInt16(cmd8.ExecuteScalar)
            framesreadytostartio = Convert.ToInt16(cmd9.ExecuteScalar)
            'framesstarted = Convert.ToInt16(cmd10.ExecuteScalar) '1 waiting or finished, 0 not started

            lblReadytoStart.Text = framesreadytostart
            lblios.Text = framesreadytostartio


            gvKitting.DataBind()

            conn.Close()

        End If




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


        If ddlShowSelect.SelectedValue = 1 Then
            gvKitting.Columns(7).Visible = False
        Else : gvKitting.Columns(7).Visible = True
        End If

        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where KittingSouthStatus = 2 and Convert(date,KittingSouth) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount
        framesreadytostart = Convert.ToInt16(cmd3.ExecuteScalar)
        framesreadytostartio = Convert.ToInt16(cmd4.ExecuteScalar)

        lblReadytoStart.Text = framesreadytostart
        lblios.Text = framesreadytostartio
        'MesgBox(recordcount)
        conn.Close()

        gvKitting.Columns(5).Visible = False
        gvKitting.Columns(6).Visible = True
        gvKitting.Columns(7).Visible = False
        gvKitting.Columns(8).Visible = True


        Dim sqldataadapter As New SqlDataAdapter
        Dim conn1 As New SqlConnection()
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        conn1.ConnectionString = connstr1

        'If Not IsPostBack Then
        Try
            conn1.Open()
            sqldataadapter.SelectCommand = New SqlCommand("Select Distinct(production_no), base_vinyl_desc, vinyl_accent_desc,trim_accent_desc FROM BML_PURPRDBOM Where production_no > = 2000000", conn1)
            sqldataadapter.Fill(KitColors)
            conn1.Close()
        Catch
        End Try

        'End If



    End Sub

    Protected Sub gvKitting_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvKitting.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsSouthKitting"), SqlDataSource)


            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text


            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If


            ' Try
            Dim lblBV As Label = e.Row.FindControl("lblBV")
            Dim lblAccent As Label = e.Row.FindControl("lblAccent")
            Dim lblTrim As Label = e.Row.FindControl("lblTrim")
            Dim prod As String = e.Row.Cells(0).Text
            Try

                Dim colorResult() As DataRow = KitColors.Select("production_no =  '" & prod & "'")
                Try
                    If colorResult(0)(1).ToString Like "BASE VINYL*" Then
                        lblBV.Text = colorResult(0)(1).ToString.Remove(0, 11)
                    End If
                Catch
                End Try

                Try
                    If colorResult(0)(2).ToString Like "INT ACCENT*" Then
                        lblAccent.Text = colorResult(0)(2).ToString.Remove(0, 10)
                    End If
                Catch
                End Try

                Try
                    If colorResult(0)(3).ToString Like "TRIM ACCENT*" Then
                        lblTrim.Text = colorResult(0)(3).ToString.Remove(0, 12)
                    End If
                Catch
                End Try
            Catch ex As Exception

            End Try

        End If

    End Sub

    Protected Sub ddlShowSelect_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlShowSelect.SelectedIndexChanged
        gvKitting.DataBind() 'used to allow the user to hide/show jobs that they have completed.

    End Sub

    Private Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        gvKitting.Columns(5).Visible = False
        gvKitting.Columns(6).Visible = False
        gvKitting.Columns(7).Visible = False
        gvKitting.Columns(8).Visible = False

        MesgBox("Click OK, Then Right Click Anywhere on the Page and Click Print. Then click the button that says REFRE5H to get the hidden columns back.")
    End Sub
    Protected Sub gvPartsNeeded_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvPartsNeeded.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsCCs"), SqlDataSource)
            Try
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch
            End Try

            If e.Row.DataItem("Watch") = 1 Then
                e.Row.BackColor = Drawing.Color.Yellow
            End If

        End If
    End Sub

    Private Sub btnMaintain_Click(sender As Object, e As EventArgs) Handles btnMaintain.Click
        Dim url As String = "SouthKitPartsList.aspx"
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,toolbars=0');popUpObj.focus()}</script>")
    End Sub

    Private Sub gvPartsNeededNotKittedSouthWip_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvPartsNeededNotKittedSouthWip.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsCCsNotKitted"), SqlDataSource)
            Try
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch
            End Try

            If e.Row.DataItem("Watch") = 1 Then
                e.Row.BackColor = Drawing.Color.Yellow
            End If

        End If
    End Sub
End Class