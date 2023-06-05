Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Loading
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
            Dim planned As String = e.Row.Cells(0).Text

            'testing
            'System.Console.WriteLine(planned)
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.CommandType = CommandType.Text
            cmd.CommandText = "SELECT Count(ProdNo) FROM BML_POPREPORTING_LOADINFO WHERE Planned Like '" & planned & "'"
            conn.Open()

            'If planned NOT LIKE '//-'Then
            Dim totalonload As Int16 = Convert.ToInt16(cmd.ExecuteScalar())


            'End If
            'Dim connstr2 As String = ConfigurationManager.ConnectionStrings("BML_dataConnectionStringSQLCLUSTER").ConnectionString
            Dim cmd2 As New SqlCommand
            'Dim conn2 As New SqlConnection
            ' conn2.ConnectionString = connstr2
            cmd2.Connection = conn
            cmd2.CommandText = "SELECT Count(ProdNo) FROM BML_POPREPORTING_GREENLIGHTS WHERE IsInvoiced = '0' AND IN(SELECT ProdNo FROM BML_POPREPORTING_LOADINFO WHERE Planned Like '" & planned & "')"
            Dim totalonloadnotinvoiced As Int16 = Convert.ToInt16(cmd.ExecuteScalar())
            'end of testing


            'If (totalonload <> totalonloadinvoiced) Then
            If (totalonloadnotinvoiced > 0) Then
                'MesgBox("total on load " & totalonload & " " & totalonloadnotinvoiced & "invoiced on load " & planned)
                'MesgBox(totalonload & " " & totalonloadnotinvoiced & " not invoiced on load " & planned)

            End If

            conn.Close()

            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsLoadInfo"), SqlDataSource)

            Try
                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
            Catch

            End Try
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


        'MesgBox(DaystoShow)
        conn.ConnectionString = connstr
        cmd2.CommandType = CommandType.Text
        'cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus = 2 and Convert(date,FurniturePrepLastUpdated) ='" & ThisDay & "'"
        'cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1"
        'cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = 1 and Right(ItemNo,2) = 'IO'"
        'to get the count of the prod #'s completed that day
        'cmd2.Connection = conn
        'cmd3.Connection = conn
        'cmd4.Connection = conn

        'conn.Open()
        'MesgBox(rbList.SelectedValue)
        'MesgBox(Key)
        'MesgBox(SelectedProdNo)

       
        'MesgBox(recordcount)
        'conn.Close()
    End Sub


    Protected Sub gvLoadInfo_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim gvLoadInfo = DirectCast(sender, GridView)


        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim t As SqlDataSource = DirectCast(CType(e.Row.FindControl("sdsBoatLoadDate"), SqlDataSource), SqlDataSource)
            Dim Prod As String = e.Row.Cells(0).Text

            Dim u As SqlDataSource = DirectCast(CType(e.Row.FindControl("sdsBoatNotes"), SqlDataSource), SqlDataSource)

            'use the selected prod # to get the load date from Jim's Load program.
            t.SelectParameters(0).DefaultValue = Prod
            u.SelectParameters(0).DefaultValue = Prod

            e.Row.Cells(0).ToolTip = "Prod #"
            e.Row.Cells(1).ToolTip = "Boat/Customer"
            e.Row.Cells(2).ToolTip = "Furniture"
            e.Row.Cells(3).ToolTip = "Fiberglass"
            e.Row.Cells(4).ToolTip = "Covers"
            e.Row.Cells(5).ToolTip = "Rails"
            e.Row.Cells(6).ToolTip = "Tubes"
            e.Row.Cells(7).ToolTip = "Centertubes"
            e.Row.Cells(8).ToolTip = "Frames"
            e.Row.Cells(9).ToolTip = "Floors"
            e.Row.Cells(10).ToolTip = "Rails"
            e.Row.Cells(11).ToolTip = "Furniture"
            e.Row.Cells(12).ToolTip = "Helm"
            e.Row.Cells(13).ToolTip = "Inspection"
            e.Row.Cells(14).ToolTip = "Final Inspection"
            e.Row.Cells(15).ToolTip = "Shrinkwrap"
            e.Row.Cells(16).ToolTip = "Wavetamer"
            e.Row.Cells(17).ToolTip = "Sharkhide"
            e.Row.Cells(18).ToolTip = "Offline"
            e.Row.Cells(19).ToolTip = "Complete"
            e.Row.Cells(22).ToolTip = "Invoiced"

        End If
        

    End Sub

   
    Protected Sub gvLoadInfo_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Dim gvLoadInfo = DirectCast(sender, GridView)
        If e.CommandName = "gotooffline" Then
            Dim Selected As String = e.CommandArgument 'get the row that is clicked
            Dim workstation As String = "Loads" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotoredtag" Then 'handles when the notes button is clicked
            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim Selected As Integer = gvLoadInfo.Rows(ID).Cells(0).Text 'find the prod # in that row to use in the update command
            Dim workstation As String = "Shrinkwrap " 'to pass in the workstation that makes the note.
            'Response.Redirect("../BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected) 'This is commented out because Workstations can't set notes.
            Dim url As String = "../RedTags.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

            ' Response.Redirect("../BoatNotes.aspx?&ProdNo=" & Selected)
        End If
    End Sub

    Protected Sub gvAllFieldsF_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvAllFieldsF.RowCommand
        Dim gvAllFieldsF = DirectCast(sender, GridView)


        If e.CommandName = "ship" Then

            Dim Selected As String = e.CommandArgument 'get the planned date/number for the row that is clicked
           

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand

            conn.ConnectionString = connstr
            cmd.CommandType = CommandType.Text
            'cmd.CommandText = "Update BML_POPREPORTING_LOADINFO set HideLoad = 1, Actual = '" & tbActualShipDate.Text & "' where Planned = '" & Selected & "'"

            'cmd.Connection = conn

            'conn.Open()
            ' cmd.ExecuteNonQuery()
            ' conn.Close()
            ' gvAllFieldsF.DataBind()


        End If
    End Sub

  

    
End Class