Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Workstations_Biminis
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    Protected Sub gvBiminis_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvBiminis.RowCommand
        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvBiminis.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "HelmsBuild" 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If

        If e.CommandName = "gotostatus" Then 'handles when the offline button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvBiminis.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "HelmsBuild" 'to pass in the workstation that makes the note.
            Dim url As String = "../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
            'Response.Redirect("../BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected)

        End If

        If e.CommandName = "gotoorderdetails" Then 'handles when the notes button is clicked
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "../OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "gotobiminilabel" Then 'handles when the notes button is clicked
            Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
            Dim Line() As String = Selected.Split(";")
            Dim ProdNo As String = Line(0)
            Dim Model As String = Line(1)
            Dim CusName As String = Line(2)
            Dim Serial As String = Line(3)
            Dim BO As String = Line(4)

            CusName = CusName.Replace("'", "")
            CusName = CusName.Replace("&", "and")

            Dim url As String = "../Workstations/BiminiLabel.aspx?ProdNo=" & Trim(ProdNo) & "&Model=" & Trim(Model) & "&CusName=" & Trim(CusName) & "&Serial=" & Trim(Serial) & "&BO=" & Trim(BO) & ""

            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=850,height=1000,toolbars=0');popUpObj.focus()}</script>")
        End If

        'This code is for the update button
        If e.CommandName = "gotoupdate" Then
            Dim Key As String = e.CommandArgument 'get the row that is clicked
            Dim SelectedProdNo As Integer = gvBiminis.Rows(Key).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim img As Image = CType(gvBiminis.Rows(Key).FindControl("btnUpdateBiminis"), Image)
            Dim helmsvalue = img.ImageUrl
            helmsvalue = Mid(helmsvalue, 26, 1) 'get the value of HelmInstalledStatus from the imageurl.


            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand
            Dim cmd6 As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0
            Dim southshrinkcount As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BiminiStatus = '2', Bimini = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BiminiStatus = 2 and Convert(date,Bimini) ='" & ThisDay & "'"
            cmd4.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET BiminiStatus = '1', Bimini = NULL where ProdNo =  '" & SelectedProdNo & "'"

            cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BiminiRcvdStatus = 2 and BuildLoc = 'M' and Convert(date,BiminiRcvd) ='" & ThisDay & "'"
            cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where  BiminiRcvdStatus = 2 and BuildLoc = 'S' and Convert(date,BiminiRcvd) ='" & ThisDay & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd4.Connection = conn
            cmd5.Connection = conn
            cmd6.Connection = conn

            conn.Open()

            If helmsvalue <= 1 Then
                cmd.ExecuteNonQuery()
            Else
                cmd4.ExecuteNonQuery()
            End If

            recordcount = Convert.ToInt16(cmd2.ExecuteScalar())

            lblBoatsStarted.Text = recordcount


            lblRcvdM.Text = Convert.ToInt16(cmd5.ExecuteScalar())
            lblRcvdS.Text = Convert.ToInt16(cmd6.ExecuteScalar())

            gvBiminis.DataBind()

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
        Dim southshrinkcount As Int16 = 0

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
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BiminiStatus = 2 and Convert(date,Bimini) ='" & ThisDay & "'"

        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BiminiRcvdStatus = 2 and BuildLoc = 'M' and Convert(date,BiminiRcvd) ='" & ThisDay & "'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where  BiminiRcvdStatus = 2 and BuildLoc = 'S' and Convert(date,BiminiRcvd) ='" & ThisDay & "'"

        'to get the count of the prod #'s completed that day
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        conn.Open()

        recordcount = Convert.ToInt16(cmd2.ExecuteScalar())
        lblBoatsStarted.Text = recordcount

        lblRcvdM.Text = Convert.ToInt16(cmd3.ExecuteScalar())
        lblRcvdS.Text = Convert.ToInt16(cmd4.ExecuteScalar())


        conn.Close()
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvBiminis.DataBind()
    End Sub

    Protected Sub gvBiminis_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBiminis.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim s As SqlDataSource = CType(e.Row.FindControl("sdsPopReportingByProdNo"), SqlDataSource)
            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsBiminis"), SqlDataSource)
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsMacola"), SqlDataSource)
            Dim u As SqlDataSource = CType(e.Row.FindControl("sdsStdTop"), SqlDataSource)

            Dim so As String = DataBinder.Eval(e.Row.DataItem, "SONo")

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                '    s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
                's.SelectParameters(0).DefaultValue = so
                u.SelectParameters(0).DefaultValue = e.Row.DataItem("ItemNo")

            Catch

            End Try
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
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