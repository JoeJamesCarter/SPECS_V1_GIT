Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class LoadScheduleBiminis
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim conn2 As New SqlConnection()

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim connstr2 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim cmd1 As New SqlCommand

        Dim ThisDay As Date = Calendar1.SelectedDate
        Dim loadcounttoday As Int16
        'Dim totalboatsinyard As Integer

        cmd.Connection = conn
        cmd1.Connection = conn2

        conn.ConnectionString = connstr
        conn2.ConnectionString = connstr2
        Try
            conn.Open()
            'cmd.CommandText = "Select Max(LoadNo) FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & ThisDay & "'"
            cmd.CommandText = "Select Count(Distinct LoadNo) as Count FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & ThisDay & "'"
            loadcounttoday = cmd.ExecuteScalar
            conn.Close()
            lblLoadsScheduled.Text = loadcounttoday
        Catch ex As Exception
            lblLoadsScheduled.Text = 0
        End Try


        'cmd1.CommandText = "Select Count (mfg_ser_lot_no) From IMLSMST_SQL Where mfg_ser_lot_no like '1%'"
        'conn2.Open()
        'totalboatsinyard = cmd1.ExecuteScalar
        'lblTotalInYard.Text = totalboatsinyard
        'conn2.Close()



    End Sub



    Protected Sub Calendar1_SelectionChanged(sender As Object, e As EventArgs) Handles Calendar1.SelectionChanged

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        Dim selecteddate As Date = Calendar1.SelectedDate

        conn.ConnectionString = connstr
        cmd.Connection = conn
        cmd.CommandType = CommandType.Text

        'cmd.CommandText = "Select top 1 LoadNo FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & selecteddate & "' order By LoadNo desc"
        cmd.CommandText = "Select Count(Distinct LoadNo) as Count FROM LOAD_SCHEDULING where Convert(date,ActualLoadDate) ='" & selecteddate & "'"
        conn.Open()
        Try
            Dim numscheduled As Int16 = cmd.ExecuteScalar
            lblLoadsScheduled.Text = numscheduled
        Catch ex As Exception
            lblLoadsScheduled.Text = 0
        End Try
        lblDateSet.Text = selecteddate
        conn.Close()

    End Sub

    Protected Sub gvBoatsScheduled_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBoatsScheduled.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsDlrBoats"), SqlDataSource)

            Try
                Dim load As String = (e.Row.Cells(0).Text)

                s.SelectParameters(0).DefaultValue = load


            Catch ex As Exception

            End Try

        End If
    End Sub

    Protected Sub gvDlrBoats_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim building As String = e.Row.Cells(3).Text

            If building = "S" Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If

            Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsBiminisM"), SqlDataSource)
            Dim v As SqlDataSource = CType(e.Row.FindControl("sdsStdTopM"), SqlDataSource)


            Try
                'u.SelectParameters(0).DefaultValue = so
                t.SelectParameters(0).DefaultValue = e.Row.Cells(1).Text
                v.SelectParameters(0).DefaultValue = e.Row.DataItem("ItemNo")
            Catch ex As Exception

            End Try



        End If

    End Sub

    Protected Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        btnPrint.Visible = False
        btnRefresh.Visible = False
        Calendar1.Visible = False
        gvBoatsScheduled.Font.Size = "12"
    End Sub

    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs) Handles btnRefresh.Click
        gvBoatsScheduled.DataBind()
        gvRails.DataBind()
    End Sub

    Protected Sub gvRails_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRails.RowDataBound
        Dim so As String = DataBinder.Eval(e.Row.DataItem, "SONo")
        ' Dim u As SqlDataSource = CType(e.Row.FindControl("sdsMacola"), SqlDataSource)
        Dim t As SqlDataSource = CType(e.Row.FindControl("sdsFabOptionsBiminis"), SqlDataSource)
        Dim v As SqlDataSource = CType(e.Row.FindControl("sdsStdTop"), SqlDataSource)


        Try
            'u.SelectParameters(0).DefaultValue = so
            t.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            v.SelectParameters(0).DefaultValue = e.Row.DataItem("ItemNo")
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub gvDlrBoats_RowCommand(sender As Object, e As GridViewCommandEventArgs)
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

            Dim url As String = "Workstations/BiminiLabel.aspx?ProdNo=" & Trim(ProdNo) & "&Model=" & Trim(Model) & "&CusName=" & Trim(CusName) & "&Serial=" & Trim(Serial) & "&BO=" & Trim(BO) & ""

            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=850,height=1000,toolbars=0');popUpObj.focus()}</script>")
        End If
    End Sub

    Protected Sub gvRails_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvRails.RowCommand
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

            Dim url As String = "Workstations/BiminiLabel.aspx?ProdNo=" & Trim(ProdNo) & "&Model=" & Trim(Model) & "&CusName=" & Trim(CusName) & "&Serial=" & Trim(Serial) & "&BO=" & Trim(BO) & ""

            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=850,height=1000,toolbars=0');popUpObj.focus()}</script>")
        End If
    End Sub
End Class

