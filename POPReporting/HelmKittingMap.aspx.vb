Imports System.Data
Imports System.Data.SqlClient
Imports MySql.Data.MySqlClient

Partial Class HelmKittingMap
    Inherits System.Web.UI.Page

    Public veadaShipped As New DataTable

    Public greenM As New DataTable
    Public blueM As New DataTable
    Public purpleM As New DataTable
    Public yellowM As New DataTable
    Public tanM As New DataTable
    Public silverM As New DataTable
    Public peachM As New DataTable

    Public greenS As New DataTable
    Public blueS As New DataTable
    Public purpleS As New DataTable
    Public yellowS As New DataTable
    Public tanS As New DataTable
    Public silverS As New DataTable
    Public peachS As New DataTable

    Public whiteM As New DataTable
    Public whiteS As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Public Function PopulateVeadaShipped() As String

        Dim mysqldataadapter As New MySqlDataAdapter
        Dim conn As New MySqlConnection()
        Dim connstr As String = "server=veada-mysql-082019.cz8vw0a6whxb.us-east-1.rds.amazonaws.com;user id=BennDataPartner;password=DISH4087sky$$;persistsecurityinfo=True;database=vea_0819_dbshare"
        conn.ConnectionString = connstr

        conn.Open()
        mysqldataadapter.SelectCommand = New MySqlCommand("Select Trim(Convert(ProdNo, CHAR)) as ProdNo, Shipped, TruckNum FROM BennShipping_Shipped order by ProdNo ", conn)
        mysqldataadapter.Fill(veadaShipped)

        conn.Close()

        conn.Dispose()
        Return False

    End Function

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

        PopulateVeadaShipped()

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        conn.ConnectionString = connstr

        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'M' and HelmKittingStatus = 2 and Convert(date,HelmKitting) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and HelmKittingStatus = 2 and Convert(date,HelmKitting) ='" & ThisDay & "'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'V' and HelmKittingStatus = 2 and Convert(date,HelmKitting) ='" & ThisDay & "'"

        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        conn.Open()


        lblMainCompleted.Text = cmd2.ExecuteScalar
        lblSouthCompleted.Text = cmd3.ExecuteScalar
        lblValueCompleted.Text = cmd4.ExecuteScalar

        Repeater1.DataBind()
        Repeater2.DataBind()

        conn.Close()

        gvgreenM.DataSource = greenM
        gvgreenM.DataBind()

        gvgreenS.DataSource = greenS
        gvgreenS.DataBind()

        gvblueM.DataSource = blueM
        gvblueM.DataBind()

        gvblueS.DataSource = blueS
        gvblueS.DataBind()

        gvpurpleM.DataSource = purpleM
        gvpurpleM.DataBind()

        gvpurpleS.DataSource = purpleS
        gvpurpleS.DataBind()

        gvyellowM.DataSource = yellowM
        gvyellowM.DataBind()

        gvyellowS.DataSource = yellowS
        gvyellowS.DataBind()

        gvtanM.DataSource = tanM
        gvtanM.DataBind()

        gvtanS.DataSource = tanS
        gvtanS.DataBind()

        gvSilverM.DataSource = silverM
        gvSilverM.DataBind()

        gvSilverS.DataSource = silverS
        gvSilverS.DataBind()

        gvPeachM.DataSource = peachM
        gvPeachM.DataBind()

        gvPeachS.DataSource = peachS
        gvPeachS.DataBind()

        gvWhiteM.DataSource = whiteM
        gvWhiteM.DataBind()

        gvWhiteS.DataSource = whiteS
        gvWhiteS.DataBind()


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

    Private Sub Repeater1_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles Repeater1.ItemDataBound, Repeater2.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then

            Dim Status As String = e.Item.DataItem("SortOrder").ToString
            Dim ProdNo As String = e.Item.DataItem("ProdNo").ToString

            Dim veadaShippedFlag() As DataRow = veadaShipped.Select("ProdNo =  '" & ProdNo & "'")

            Dim shippedflag = 0
            If veadaShippedFlag.Length > 0 Then
                shippedflag = 1
            End If


            If (e.Item.DataItem("HasAllRails").ToString = "1" Or e.Item.DataItem("RailsStatus") = 2) And
                   e.Item.DataItem("BuildLoc").ToString = "S" And
                   (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                   e.Item.DataItem("FiberglassStatus") = "2" And
                   e.Item.DataItem("CoversStatus") >= 1 And
                   e.Item.DataItem("TubesStatus") = 2 And
                   ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LightGreen;")
                greenS.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"))

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("RailsStatus") < 2) And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") = "2" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LightBlue;")
                blueS.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"))

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1" Or e.Item.DataItem("RailsStatus") = 1 Or e.Item.DataItem("RailsStatus") = -1) And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") = "1" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:Lavender;")
                purpleS.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"))


            ElseIf (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("RailsStatus") < 2) And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") = "2" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("TubesStatus") = 0 Then
                '((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:PeachPuff;")
                peachS.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"))

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("RailsStatus") = 0) And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") > "0" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:Wheat;")
                tanS.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"))

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1" Or e.Item.DataItem("RailsStatus") = -1 Or e.Item.DataItem("HasAllRails").ToString = "0") And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") > "0" And
                shippedflag = 1 And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LemonChiffon;")
                yellowS.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"))

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1") And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") = "2" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") < 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0) Then

                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:silver;")
                silverS.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"))


            ElseIf (e.Item.DataItem("RailsStatus") = 2 Or (e.Item.DataItem("HasAllRails") = 1 Or e.Item.DataItem("RailsStatus") = 0)) And
                (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LightGreen;")
                greenM.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("BuildLoc"))


            ElseIf (e.Item.DataItem("HasAllRails") = "1" Or e.Item.DataItem("RailsStatus") = 1) And
                (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                (e.Item.DataItem("FurnitureStatus") = "2" Or e.Item.DataItem("FurnitureStatus") = "3") And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LightBlue;")
                blueM.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("BuildLoc"))


            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1") And e.Item.DataItem("RailsStatus") = 0 And
                (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                 e.Item.DataItem("FurnitureStatus") = "2" And
                 e.Item.DataItem("FiberglassStatus") = "2" And
                 e.Item.DataItem("CoversStatus") >= 1 And
                 e.Item.DataItem("TubesStatus") < 2 And
                 ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0) Then

                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:silver;")
                silverM.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("BuildLoc"))

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1" Or e.Item.DataItem("RailsStatus") = 1 Or e.Item.DataItem("RailsStatus") = -1) And
                (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                e.Item.DataItem("FurnitureStatus") = "1" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:Lavender;")
                purpleM.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("BuildLoc"))


            ElseIf (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("RailsStatus") < 1) And
                (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                e.Item.DataItem("FurnitureStatus") = "2" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("TubesStatus") = 0 Then
                '((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0) 
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:PeachPuff;")
                peachM.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("BuildLoc"))


            ElseIf (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("RailsStatus") = 0) And
               (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                e.Item.DataItem("FurnitureStatus") = "1" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:Wheat;")
                tanM.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("BuildLoc"))

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1" Or e.Item.DataItem("HasAllRails").ToString = "0") And
                (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                e.Item.DataItem("FurnitureStatus") = "0" And
                shippedflag = 1 And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") = 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") >= 1) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:LemonChiffon;")
                yellowM.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("BuildLoc"))


                'catch the white ones
            ElseIf e.Item.DataItem("BuildLoc").ToString = "M" Or e.Item.DataItem("BuildLoc").ToString = "V" Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:white;")
                whiteM.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"), e.Item.DataItem("BuildLoc"))

            ElseIf e.Item.DataItem("BuildLoc").ToString = "S" Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:white;")
                whiteS.Rows.Add(e.Item.DataItem("ProdNo"), e.Item.DataItem("ItemNo"))
            End If
        End If

    End Sub

    Private Sub Repeater1_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles Repeater1.ItemCommand, Repeater2.ItemCommand
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
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET HelmKittingStatus = '2', HelmKitting = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
            cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'M' and HelmKittingStatus = 2 and Convert(date,HelmKitting) ='" & ThisDay & "'"
            cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and HelmKittingStatus = 2 and Convert(date,HelmKitting) ='" & ThisDay & "'"
            cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'V' and HelmKittingStatus = 2 and Convert(date,HelmKitting) ='" & ThisDay & "'"

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
            conn.Close()
        End If

    End Sub

    Private Sub HelmKittingTV_Load(sender As Object, e As EventArgs) Handles Me.Load

        PopulateVeadaShipped()

        greenS.Columns.Add("Prod")
        greenS.Columns.Add("ItemNo")

        greenM.Columns.Add("Prod")
        greenM.Columns.Add("ItemNo")
        greenM.Columns.Add("BuildLoc")

        blueM.Columns.Add("Prod")
        blueM.Columns.Add("ItemNo")
        blueM.Columns.Add("BuildLoc")

        blueS.Columns.Add("Prod")
        blueS.Columns.Add("ItemNo")

        purpleM.Columns.Add("Prod")
        purpleM.Columns.Add("ItemNo")
        purpleM.Columns.Add("BuildLoc")

        purpleS.Columns.Add("Prod")
        purpleS.Columns.Add("ItemNo")

        yellowM.Columns.Add("Prod")
        yellowM.Columns.Add("ItemNo")
        yellowM.Columns.Add("BuildLoc")

        yellowS.Columns.Add("Prod")
        yellowS.Columns.Add("ItemNo")

        tanM.Columns.Add("Prod")
        tanM.Columns.Add("ItemNo")
        tanM.Columns.Add("BuildLoc")

        tanS.Columns.Add("Prod")
        tanS.Columns.Add("ItemNo")

        silverM.Columns.Add("Prod")
        silverM.Columns.Add("ItemNo")
        silverM.Columns.Add("BuildLoc")

        silverS.Columns.Add("Prod")
        silverS.Columns.Add("ItemNo")

        peachM.Columns.Add("Prod")
        peachM.Columns.Add("ItemNo")
        peachM.Columns.Add("BuildLoc")

        peachS.Columns.Add("Prod")
        peachS.Columns.Add("ItemNo")

        whiteM.Columns.Add("Prod")
        whiteM.Columns.Add("ItemNo")
        whiteM.Columns.Add("BuildLoc")

        whiteS.Columns.Add("Prod")
        whiteS.Columns.Add("ItemNo")

        greenS.DefaultView.Sort = "Prod"
        blueS.DefaultView.Sort = "Prod"
        purpleS.DefaultView.Sort = "Prod"
        yellowS.DefaultView.Sort = "Prod"
        tanS.DefaultView.Sort = "Prod"
        silverS.DefaultView.Sort = "Prod"
        whiteS.DefaultView.Sort = "Prod"

        greenM.DefaultView.Sort = "Prod"
        blueM.DefaultView.Sort = "Prod"
        purpleM.DefaultView.Sort = "Prod"
        yellowM.DefaultView.Sort = "Prod"
        tanM.DefaultView.Sort = "Prod"
        silverM.DefaultView.Sort = "Prod"
        whiteM.DefaultView.Sort = "Prod"

    End Sub

    'Private Sub gvgreenM_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvgreenM.RowCommand, gvgreenS.RowCommand, gvblueM.RowCommand, gvblueS.RowCommand, gvpurpleM.RowCommand, gvpurpleS.RowCommand, gvyellowM.RowCommand, gvyellowS.RowCommand, gvtanM.RowCommand, gvtanS.RowCommand, gvSilverS.RowCommand, gvSilverM.RowCommand, gvPeachM.RowCommand, gvPeachS.RowCommand, gvWhiteM.RowCommand, gvWhiteS.RowCommand
    '    If e.CommandName = "gotoupdate" Then
    '        Dim SelectedProdNo As String = e.CommandArgument 'get the row that is clicked

    '        Dim conn As New SqlConnection()
    '        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

    '        Dim cmd As New SqlCommand
    '        Dim cmd2 As New SqlCommand
    '        Dim cmd3 As New SqlCommand


    '        Dim TodaysDate As Date = Date.Now
    '        Dim ThisDay As Date = TodaysDate.Date
    '        Dim recordcount As Int16 = 0
    '        Dim coverstatus As Int16 = 0

    '        conn.ConnectionString = connstr

    '        cmd.CommandType = CommandType.Text
    '        'Todo - if the value is 2 prompt to undo the values and then undo them.

    '        'to get the count of the prod #'s completed that day as it changes
    '        cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET HelmKittingStatus = '2', HelmKitting = '" & TodaysDate & "' where ProdNo =  '" & SelectedProdNo & "'"
    '        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'M' and HelmKittingStatus = 2 and Convert(date,HelmKitting) ='" & ThisDay & "'"
    '        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where BuildLoc = 'S' and HelmKittingStatus = 2 and Convert(date,HelmKitting) ='" & ThisDay & "'"

    '        cmd.Connection = conn
    '        cmd2.Connection = conn
    '        cmd3.Connection = conn

    '        conn.Open()
    '        cmd.ExecuteNonQuery()

    '        lblMainCompleted.Text = cmd2.ExecuteScalar
    '        lblSouthCompleted.Text = cmd3.ExecuteScalar

    '        Repeater1.DataBind()
    '        Repeater2.DataBind()
    '        conn.Close()
    '    End If

    'End Sub
End Class
