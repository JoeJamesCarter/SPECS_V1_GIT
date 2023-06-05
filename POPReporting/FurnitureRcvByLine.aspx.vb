Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports MySql.Data.MySqlClient
Imports System.Net.Dns

Partial Class FurnitureRcvByLine
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gvAllFieldsF_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvAllFieldsF.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingFurnitureOptions"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsVendorInfo"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                u.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If


        End If

    End Sub


    Protected Sub gvAllFieldsF_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsF.RowCommand

        If e.CommandName = "goto" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvAllFieldsF.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Furniture" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If


        If e.CommandName = "markRCVD" Then
            'This code is for the update button

            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim SelectedProd As Integer = Line(0)
            Dim SelectedPart As String = Line(1)
            Dim SelectedModel As String = Line(2)
            Dim SelectedColor As String = Line(3)
            Dim TodaysDate As Date = Date.Now


            MesgBox(SelectedColor)
            MesgBox(SelectedModel)

            Dim conn As New MySqlConnection()
            Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"

            Dim cmd As New MySqlCommand

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "Update OrderLines Set RCVDFlag = '1' where ProdNo = '" & SelectedProd & "' and PartDesc = '" & SelectedPart & "'"

            cmd.Connection = conn

            conn.Open()
            'cmd.ExecuteNonQuery()

            conn.Close()

            gvAllFieldsF.DataBind()

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



        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus = 2 and Convert(date,FurniturePrepLastUpdated) ='" & ThisDay & "'"
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
    End Sub




End Class
