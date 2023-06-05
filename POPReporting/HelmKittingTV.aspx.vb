Imports System.Data
Imports System.Data.SqlClient
Imports MySql.Data.MySqlClient

Partial Class HelmKittingTV
    Inherits System.Web.UI.Page

    Public veadaShipped As New DataTable

    Public greenM As New DataTable
    Public blueM As New DataTable
    Public purpleM As New DataTable
    Public yellowM As New DataTable
    Public tanM As New DataTable
    Public silverM As New DataTable
    Public peachM As New DataTable

    Public greenV As New DataTable
    Public blueV As New DataTable
    Public purpleV As New DataTable
    Public yellowV As New DataTable
    Public tanV As New DataTable
    Public silverV As New DataTable
    Public peachV As New DataTable

    Public greenS As New DataTable
    Public blueS As New DataTable
    Public purpleS As New DataTable
    Public yellowS As New DataTable
    Public tanS As New DataTable
    Public silverS As New DataTable
    Public peachS As New DataTable

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
        'Dim connstr As String = "server=veada-mysql-082019.cz8vw0a6whxb.us-east-1.rds.amazonaws.com;user id=BennDataPartner;password=DISH4087sky$$;persistsecurityinfo=True;database=vea_0819_dbshare"
        Dim connstr As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"
        conn.ConnectionString = connstr

        conn.Open()
        ' mysqldataadapter.SelectCommand = New MySqlCommand("Select Trim(Convert(ProdNo, CHAR)) as ProdNo, Shipped, TruckNum FROM BennShipping_Shipped order by ProdNo ", conn)
        mysqldataadapter.SelectCommand = New MySqlCommand("Select CAST(ProdNo AS CHAR) as ProdNo,MAX(CAST(Actual_Ship_Date AS DATE)) as Shipped, '1' as ShippedFlag, 'N/A' as Line, 'N/A' as TruckNum, TrailerNum FROM SPECS_External.OrderLines Where ProdNo > 2100000 and Actual_Ship_Date is not null group by ProdNo Order By ProdNo asc", conn)
        mysqldataadapter.Fill(veadaShipped)

        conn.Close()

        conn.Dispose()
        Return False

    End Function

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        'Repeater1.DataBind()
        'Repeater2.DataBind()

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
        Repeater3.DataBind()

        conn.Close()

        greenS.DefaultView.Sort = "Prod"
        blueS.DefaultView.Sort = "Prod"
        purpleS.DefaultView.Sort = "Prod"
        yellowS.DefaultView.Sort = "Prod"
        tanS.DefaultView.Sort = "Prod"
        silverS.DefaultView.Sort = "Prod"

        greenM.DefaultView.Sort = "Prod"
        blueM.DefaultView.Sort = "Prod"
        purpleM.DefaultView.Sort = "Prod"
        yellowM.DefaultView.Sort = "Prod"
        tanM.DefaultView.Sort = "Prod"
        silverM.DefaultView.Sort = "Prod"

        greenV.DefaultView.Sort = "Prod"
        blueV.DefaultView.Sort = "Prod"
        purpleV.DefaultView.Sort = "Prod"
        yellowV.DefaultView.Sort = "Prod"
        tanV.DefaultView.Sort = "Prod"
        silverV.DefaultView.Sort = "Prod"


        gvgreenM.DataSource = greenM
        gvgreenM.DataBind()

        gvGreenV.DataSource = greenV
        gvGreenV.DataBind()

        gvgreenS.DataSource = greenS
        gvgreenS.DataBind()

        gvblueM.DataSource = blueM
        gvblueM.DataBind()

        gvblueV.DataSource = blueV
        gvblueV.DataBind()

        gvblueS.DataSource = blueS
        gvblueS.DataBind()

        gvpurpleM.DataSource = purpleM
        gvpurpleM.DataBind()

        gvpurpleV.DataSource = purpleV
        gvpurpleV.DataBind()

        gvpurpleS.DataSource = purpleS
        gvpurpleS.DataBind()

        gvyellowM.DataSource = yellowM
        gvyellowM.DataBind()

        gvyellowV.DataSource = yellowV
        gvyellowV.DataBind()

        gvyellowS.DataSource = yellowS
        gvyellowS.DataBind()

        gvtanM.DataSource = tanM
        gvtanM.DataBind()

        gvtanV.DataSource = tanV
        gvtanV.DataBind()

        gvtanS.DataSource = tanS
        gvtanS.DataBind()

        gvSilverM.DataSource = silverM
        gvSilverM.DataBind()

        gvsilverV.DataSource = silverV
        gvsilverV.DataBind()

        gvSilverS.DataSource = silverS
        gvSilverS.DataBind()

        gvPeachM.DataSource = peachM
        gvPeachM.DataBind()

        gvPeachV.DataSource = peachV
        gvPeachV.DataBind()

        gvPeachS.DataSource = peachS
        gvPeachS.DataBind()


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
            Dim ProdNo As String = e.Item.DataItem("ProdNo").ToString

            Dim veadaShippedFlag() As DataRow = veadaShipped.Select("ProdNo =  '" & ProdNo & "'")

            Dim shippedflag = 0
            If veadaShippedFlag.Length > 0 Then
                shippedflag = 1
            End If


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


            ElseIf (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("RailsStatus") < 2) And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") = "2" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("TubesStatus") = 0 Then
                '((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0) Then
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:PeachPuff;")
                peachS.Rows.Add(e.Item.DataItem("ProdNo"))

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
                yellowS.Rows.Add(e.Item.DataItem("ProdNo"))

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1") And
                e.Item.DataItem("BuildLoc").ToString = "S" And
                e.Item.DataItem("FurnitureStatus") = "2" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("CoversStatus") >= 1 And
                e.Item.DataItem("TubesStatus") < 2 And
                ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0) Then

                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:silver;")
                silverS.Rows.Add(e.Item.DataItem("ProdNo"))

            ElseIf (e.Item.DataItem("RailsStatus") = 2) And
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

            ElseIf (e.Item.DataItem("HasAllRails") = "1" Or e.Item.DataItem("RailsStatus") = 1) And
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

            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1") And e.Item.DataItem("RailsStatus") = 0 And
            (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
             e.Item.DataItem("FurnitureStatus") = "2" And
             e.Item.DataItem("FiberglassStatus") = "2" And
             e.Item.DataItem("CoversStatus") >= 1 And
             e.Item.DataItem("TubesStatus") < 2 And
             ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0) Then


                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:silver;")

                If e.Item.DataItem("BuildLoc") = "M" Then
                    silverM.Rows.Add(e.Item.DataItem("ProdNo"))
                ElseIf e.Item.DataItem("BuildLoc") = "V" Then
                    silverV.Rows.Add(e.Item.DataItem("ProdNo"))
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


            ElseIf (e.Item.DataItem("HasAllRails").ToString = "0" Or e.Item.DataItem("RailsStatus") < 2) And
                   (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
                e.Item.DataItem("FurnitureStatus") = "2" And
                e.Item.DataItem("FiberglassStatus") = "2" And
                e.Item.DataItem("TubesStatus") = 0 Then
                '((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0) 
                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:PeachPuff;")

                If e.Item.DataItem("BuildLoc") = "M" Then
                    peachM.Rows.Add(e.Item.DataItem("ProdNo"))
                ElseIf e.Item.DataItem("BuildLoc") = "V" Then
                    peachV.Rows.Add(e.Item.DataItem("ProdNo"))
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

                If e.Item.DataItem("BuildLoc") = "M" Then
                    yellowM.Rows.Add(e.Item.DataItem("ProdNo"))
                ElseIf e.Item.DataItem("BuildLoc") = "V" Then
                    yellowV.Rows.Add(e.Item.DataItem("ProdNo"))
                End If


            ElseIf (e.Item.DataItem("HasAllRails").ToString = "1") And e.Item.DataItem("RailsStatus") = 0 And
            (e.Item.DataItem("BuildLoc") = "M" Or e.Item.DataItem("BuildLoc") = "V") And
             e.Item.DataItem("FurnitureStatus") = "2" And
             e.Item.DataItem("FiberglassStatus") = "2" And
             e.Item.DataItem("CoversStatus") >= 1 And
             e.Item.DataItem("TubesStatus") < 2 And
             ((e.Item.DataItem("CenterTubeNeeded") = 1 And e.Item.DataItem("CenterTubeStatus") < 2) Or e.Item.DataItem("CentertubeNeeded") = 0) Then


                Dim sBlock As HtmlGenericControl = DirectCast(e.Item.FindControl("thiscard"), HtmlGenericControl)
                sBlock.Attributes.Add("style", "width: 19rem; height: 6rem; background-color:silver;")

                If e.Item.DataItem("BuildLoc") = "M" Then
                    silverM.Rows.Add(e.Item.DataItem("ProdNo"))
                ElseIf e.Item.DataItem("BuildLoc") = "V" Then
                    silverV.Rows.Add(e.Item.DataItem("ProdNo"))
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

        PopulateVeadaShipped() 'Joe wants to used whether or not Veada has shipped as a flag for the color yellow 4/30/21

        greenS.Columns.Add("Prod")
        greenM.Columns.Add("Prod")
        greenV.Columns.Add("Prod")
        blueM.Columns.Add("Prod")
        blueV.Columns.Add("Prod")
        blueS.Columns.Add("Prod")
        purpleM.Columns.Add("Prod")
        purpleV.Columns.Add("Prod")
        purpleS.Columns.Add("Prod")
        yellowM.Columns.Add("Prod")
        yellowV.Columns.Add("Prod")
        yellowS.Columns.Add("Prod")
        tanM.Columns.Add("Prod")
        tanV.Columns.Add("Prod")
        tanS.Columns.Add("Prod")
        silverM.Columns.Add("Prod")
        silverV.Columns.Add("Prod")
        silverS.Columns.Add("Prod")
        peachM.Columns.Add("Prod")
        peachV.Columns.Add("Prod")
        peachS.Columns.Add("Prod")

    End Sub

    Private Sub gvgreenM_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvgreenM.RowCommand, gvGreenV.RowCommand, gvgreenS.RowCommand, gvblueM.RowCommand, gvblueV.RowCommand, gvblueS.RowCommand, gvpurpleM.RowCommand, gvpurpleV.RowCommand, gvpurpleS.RowCommand, gvyellowM.RowCommand, gvyellowV.RowCommand, gvyellowS.RowCommand, gvtanM.RowCommand, gvtanV.RowCommand, gvtanS.RowCommand, gvSilverS.RowCommand, gvSilverM.RowCommand, gvSilverV.RowCommand, gvPeachM.RowCommand, gvPeachV.RowCommand, gvPeachS.RowCommand
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
            Repeater3.DataBind()
            conn.Close()
        End If

    End Sub
End Class
