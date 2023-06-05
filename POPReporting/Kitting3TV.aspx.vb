
Imports System.Data
Imports System.Data.SqlClient

Partial Class Kitting3TV
    Inherits System.Web.UI.Page
    Public greenM As New DataTable
    Public blueM As New DataTable
    Public purpleM As New DataTable
    Public yellowM As New DataTable
    Public tanM As New DataTable

    Public greenV As New DataTable
    Public blueV As New DataTable
    Public purpleV As New DataTable
    Public yellowV As New DataTable
    Public tanV As New DataTable

    Public greenS As New DataTable
    Public blueS As New DataTable
    Public purpleS As New DataTable
    Public yellowS As New DataTable
    Public tanS As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        'Repeater1.DataBind()
        'Repeater2.DataBind()

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        conn.ConnectionString = connstr

        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'M' and Kitting3Status = 2 and Convert(date,Kitting3) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and Kitting3Status = 2 and Convert(date,Kitting3) ='" & ThisDay & "'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'V' and Kitting3Status = 2 and Convert(date,Kitting3) ='" & ThisDay & "'"

        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn

        conn.Open()


        lblMainCompleted.Text = cmd2.ExecuteScalar
        lblSouthCompleted.Text = cmd3.ExecuteScalar
        lblValueCompleted.Text = cmd4.ExecuteScalar

        Repeater1.DataBind()
        Repeater2.DataBind()
        Repeater3.DataBind()

        conn.Close()

        greenS.DefaultView.Sort = "Prod"
        blueS.DefaultView.Sort = "Prod"
        purpleS.DefaultView.Sort = "Prod"
        yellowS.DefaultView.Sort = "Prod"
        tanS.DefaultView.Sort = "Prod"

        greenM.DefaultView.Sort = "Prod"
        blueM.DefaultView.Sort = "Prod"
        purpleM.DefaultView.Sort = "Prod"
        yellowM.DefaultView.Sort = "Prod"
        tanM.DefaultView.Sort = "Prod"

        greenV.DefaultView.Sort = "Prod"
        blueV.DefaultView.Sort = "Prod"
        purpleV.DefaultView.Sort = "Prod"
        yellowV.DefaultView.Sort = "Prod"
        tanV.DefaultView.Sort = "Prod"



        gvgreenM.DataSource = greenM
        gvgreenM.DataBind()

        gvgreenS.DataSource = greenS
        gvgreenS.DataBind()

        gvgreenV.DataSource = greenV
        gvgreenV.DataBind()

        gvblueM.DataSource = blueM
        gvblueM.DataBind()

        gvblueS.DataSource = blueS
        gvblueS.DataBind()

        gvblueV.DataSource = blueV
        gvblueV.DataBind()

        gvpurpleM.DataSource = purpleM
        gvpurpleM.DataBind()

        gvpurpleS.DataSource = purpleS
        gvpurpleS.DataBind()

        gvpurpleV.DataSource = purpleV
        gvpurpleV.DataBind()

        gvyellowM.DataSource = yellowM
        gvyellowM.DataBind()

        gvyellowS.DataSource = yellowS
        gvyellowS.DataBind()

        gvyellowV.DataSource = yellowV
        gvyellowV.DataBind()

        gvtanM.DataSource = tanM
        gvtanM.DataBind()

        gvtanV.DataSource = tanV
        gvtanV.DataBind()

        gvtanS.DataSource = tanS
        gvtanS.DataBind()



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

    Private Sub Repeater1_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles Repeater1.ItemDataBound, Repeater2.ItemDataBound, Repeater3.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then

            Dim Status As String = e.Item.DataItem("SortOrder").ToString

            If (e.Item.DataItem("HasAllRails").ToString = "1" Or e.Item.DataItem("RailsStatus") > 0) And
                   e.Item.DataItem("BuildLoc").ToString = "S" And
                   (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                   e.Item.DataItem("FiberglassStatus") = "2" And
                   e.Item.DataItem("CoversStatus") >= 1 And
                   e.Item.DataItem("TubesStatus") = 2 And
                   ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LightGreen;")
                greenS.Rows.Add(e.Item.DataItem("ProdNo"))

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("RailsStatus") < 1) And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") = "2" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LightBlue;")
                blueS.Rows.Add(e.Item.DataItem("ProdNo"))

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1" Or e.Item.DataItem("RailsStatus") = 1 Or e.Item.DataItem("RailsStatus") = -1) And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") = "1" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:Lavender;")
                purpleS.Rows.Add(e.Item.DataItem("ProdNo"))


            ElseIf (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("RailsStatus") = 0) And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") > "0" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:Wheat;")
                tanS.Rows.Add(e.Item.DataItem("ProdNo"))

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1" Or e.Item.DataItem("RailsStatus") = -1) And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") > "0" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LemonChiffon;")
                yellowS.Rows.Add(e.Item.DataItem("ProdNo"))

            ElseIf (e.Item.DataItem("HasAllRails") = "0" Or e.Item.DataItem("RailsStatus") < 1) And
                (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LightBlue;")

                If e.Item.DataItem("BuildLoc") = "M" Then
                    blueM.Rows.Add(e.Item.DataItem("ProdNo"))
                ElseIf e.Item.DataItem("BuildLoc") = "V" Then
                    blueV.Rows.Add(e.Item.DataItem("ProdNo"))
                End If


            ElseIf (e.Item.DataItem("HasAllRails") = "1" Or e.Item.DataItem("RailsStatus") > 0) And
                (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LightGreen;")
                If e.Item.DataItem("BuildLoc") = "M" Then
                    greenM.Rows.Add(e.Item.DataItem("ProdNo"))
                ElseIf e.Item.DataItem("BuildLoc") = "V" Then
                    greenV.Rows.Add(e.Item.DataItem("ProdNo"))
                End If


            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1" Or e.Item.DataItem("RailsStatus") = 1 Or e.Item.DataItem("RailsStatus") = -1) And
               (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                e.Item.DataItem("FurnitureStatus") = "1" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:Lavender;")
                If e.Item.DataItem("BuildLoc") = "M" Then
                    purpleM.Rows.Add(e.Item.DataItem("ProdNo"))
                ElseIf e.Item.DataItem("BuildLoc") = "V" Then
                    purpleV.Rows.Add(e.Item.DataItem("ProdNo"))
                End If


            ElseIf (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("RailsStatus") = 0) And
                (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                e.Item.DataItem("FurnitureStatus") > "0" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:Wheat;")
                If e.Item.DataItem("BuildLoc") = "M" Then
                    tanM.Rows.Add(e.Item.DataItem("ProdNo"))
                ElseIf e.Item.DataItem("BuildLoc") = "V" Then
                    tanV.Rows.Add(e.Item.DataItem("ProdNo"))
                End If

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1") And
                (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                e.Item.DataItem("FurnitureStatus") = "0" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LemonChiffon;")
                If e.Item.DataItem("BuildLoc") = "M" Then
                    yellowM.Rows.Add(e.Item.DataItem("ProdNo"))
                ElseIf e.Item.DataItem("BuildLoc") = "V" Then
                    yellowV.Rows.Add(e.Item.DataItem("ProdNo"))
                End If
            End If

        End If
    End Sub

    Private Sub Repeater1_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles Repeater1.ItemCommand, Repeater2.ItemCommand, Repeater3.ItemCommand
        If e.CommandName = "gotoupdate" Then
            Dim SelectedProdNo As String = e.CommandArgument 'get the row that is clicked

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand


            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kitting3Status = '2', Kitting3 = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'M' and Kitting3Status = 2 and Convert(date,Kitting3) ='" & ThisDay & "'"
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and Kitting3Status = 2 and Convert(date,Kitting3) ='" & ThisDay & "'"
            cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'V' and Kitting3Status = 2 and Convert(date,Kitting3) ='" & ThisDay & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()
            cmd.ExecuteNonQuery()

            lblMainCompleted.Text = cmd2.ExecuteScalar
            lblSouthCompleted.Text = cmd3.ExecuteScalar
            lblValueCompleted.Text = cmd4.ExecuteScalar

            Repeater1.DataBind()
            Repeater2.DataBind()
            Repeater3.DataBind()

            conn.Close()
        End If

    End Sub

    Private Sub HelmKittingTV_Load(sender As Object, e As EventArgs) Handles Me.Load
        greenS.Columns.Add("Prod")
        greenM.Columns.Add("Prod")
        greenV.Columns.Add("Prod")
        blueM.Columns.Add("Prod")
        blueS.Columns.Add("Prod")
        blueV.Columns.Add("Prod")
        purpleM.Columns.Add("Prod")
        purpleS.Columns.Add("Prod")
        purpleV.Columns.Add("Prod")
        yellowM.Columns.Add("Prod")
        yellowV.Columns.Add("Prod")
        yellowS.Columns.Add("Prod")
        tanM.Columns.Add("Prod")
        tanV.Columns.Add("Prod")
        tanS.Columns.Add("Prod")

    End Sub

    Private Sub gvgreenM_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvgreenM.RowCommand, gvgreenV.RowCommand, gvgreenS.RowCommand, gvblueM.RowCommand, gvblueV.RowCommand, gvblueS.RowCommand, gvpurpleM.RowCommand, gvpurpleV.RowCommand, gvpurpleS.RowCommand, gvyellowM.RowCommand, gvyellowV.RowCommand, gvyellowS.RowCommand, gvtanM.RowCommand, gvtanV.RowCommand, gvtanS.RowCommand
        If e.CommandName = "gotoupdate" Then
            Dim SelectedProdNo As String = e.CommandArgument 'get the row that is clicked

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand

            Dim TodaysDate As Date = Date.Now
            Dim ThisDay As Date = TodaysDate.Date
            Dim recordcount As Int16 = 0
            Dim coverstatus As Int16 = 0

            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            'Todo - if the value is 2 prompt to undo the values and then undo them.

            'to get the count of the prod #'s completed that day as it changes
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET Kitting3Status = '2', Kitting3 = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'M' and Kitting3Status = 2 and Convert(date,Kitting3) ='" & ThisDay & "'"
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and Kitting3Status = 2 and Convert(date,Kitting3) ='" & ThisDay & "'"
            cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'V' and Kitting3Status = 2 and Convert(date,Kitting3) ='" & ThisDay & "'"

            cmd.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn
            cmd4.Connection = conn

            conn.Open()
            cmd.ExecuteNonQuery()

            lblMainCompleted.Text = cmd2.ExecuteScalar
            lblSouthCompleted.Text = cmd3.ExecuteScalar
            lblValueCompleted.Text = cmd4.ExecuteScalar

            Repeater1.DataBind()
            Repeater2.DataBind()
            Repeater3.DataBind()

            conn.Close()
        End If

    End Sub
End Class
