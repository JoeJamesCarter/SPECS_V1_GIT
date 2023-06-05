Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.IO

Partial Class Barcode_EngineInvDataCollection
    Inherits System.Web.UI.Page

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
    End Sub

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Public Class GlobalVariables
        Public Shared stationID As String

    End Class

    Protected Function SplitBValSlash(val As Object) As String 'Split the base vinyl removing the - PT that describes the furniture as PillowTop etc
        Dim a As String
        Dim b As String

        a = val.ToString()
        b = a.Split("\")(1)
        If val IsNot Nothing Then
            Return (b)
        End If
        Return ""
    End Function

    Protected Sub Inventory_Click(sender As Object, e As EventArgs)
        Inventory.CssClass = "Clicked"
        Yard.CssClass = "Initial"
        MainView.ActiveViewIndex = 0
        hdnTabID.Value = "0"
        gvRecent.Visible = True
        lblRecentScans.Visible = True
        btnExport.Visible = True
    End Sub

    Protected Sub Yard_Click(sender As Object, e As EventArgs)
        Inventory.CssClass = "Initial"
        Yard.CssClass = "Clicked"
        MainView.ActiveViewIndex = 1
        hdnTabID.Value = "1"
        gvRecent.Visible = False
        lblRecentScans.Visible = False
        btnExport.Visible = False

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        GlobalVariables.stationID = SplitBValSlash(user)
    End Sub

    Protected Sub btnInvSave_Click(sender As Object, e As EventArgs) Handles btnInvSave.Click

        'save record
        Dim userID As String = GlobalVariables.stationID
        Dim TodaysDate As Date = Date.Now
        Dim engModel As String = tbModelNo.Text
        Dim engSerial As String = tbSerialNo.Text
        Dim engLoc As String = tbEngineLoc.Text

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString
        Dim cmd As New SqlCommand
       
        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@engModel", engModel)
        cmd.Parameters.AddWithValue("@engSerial", engSerial)
        cmd.Parameters.AddWithValue("@dateEntered", TodaysDate)
        cmd.Parameters.AddWithValue("@user", userID)
        cmd.Parameters.AddWithValue("@loc", engLoc)

        cmd.CommandText = "Insert into Engines (EngModel, EngSerial, DateEntered, EnteredBy, Loc) Values (@engModel, @engSerial, @dateEntered, @user, @loc)"

        conn.Open()
        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            MesgBox("Insert Failed, Serial # already saved.")
        End Try

        conn.Close()

        gvRecent.DataBind()
        tbModelNo.Text = ""
        tbSerialNo.Text = ""
        MainView.ActiveViewIndex = 0
        tbEngineLoc.Text = ""
    End Sub


    Protected Sub gvSerialBoats_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvSerialBoats.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim lblCompRackLoc As Label = CType(e.Row.FindControl("lblCompRackLoc"), Label)
            Dim lblCompEng1 As Label = CType(e.Row.FindControl("lblCompEng"), Label)
            Dim lblCompEng2 As Label = CType(e.Row.FindControl("lblCompEng2"), Label)
            Dim lblCompEngSerial As Label = CType(e.Row.FindControl("lblCompEngSerial"), Label)
            Dim lblCompEng2Serial As Label = CType(e.Row.FindControl("lblCompEng2Serial"), Label)

            Dim lblSONo As Label = CType(e.Row.FindControl("lblSONo"), Label)
            Dim lblEngLineSeqNo As Label = CType(e.Row.FindControl("lblEngLineSeqNo"), Label)
            Dim lblEng2LineSeqNo As Label = CType(e.Row.FindControl("lblEng2LineSeqNo"), Label)

            Dim btnEng1Serial As Button = CType(e.Row.FindControl("btnEng1Serial"), Button)
            Dim btnEng2Serial As Button = CType(e.Row.FindControl("btnEng2Serial"), Button)

            Dim btnLwr1Serial As Button = CType(e.Row.FindControl("btnLwr1Serial"), Button)
            Dim btnLwr2Serial As Button = CType(e.Row.FindControl("btnLwr2Serial"), Button)

            Dim Model As String = e.Row.Cells(2).Text
            Dim Twin As Integer = 0
            Dim storedEngCount As Integer = 0
            Dim storedEng2Count As Integer = 0
            Dim storedLwrCount As Integer = 0
            Dim storedLwr2Count As Integer = 0

            If Model.IndexOf("X2") > 1 Then
                Twin = 1
            End If

            Dim prod As String = e.Row.Cells(0).Text
            Dim results As SqlDataReader
            Dim twinresults As SqlDataReader
            Dim lwrResults As SqlDataReader

            Dim SONo As String

            Dim conn As New SqlConnection()
            Dim conn2 As New SqlConnection()
            Dim conn3 As New SqlConnection()
            Dim conn4 As New SqlConnection()

            Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString
            Dim connstr2 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
            Dim connstr3 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString
            Dim connstr4 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand
            Dim cmd2 As New SqlCommand
            Dim cmd3 As New SqlCommand
            Dim cmd4 As New SqlCommand
            Dim cmd5 As New SqlCommand 'check to see if it is already stored to change the color of the cell.
            Dim cmd6 As New SqlCommand
            Dim cmd7 As New SqlCommand
            Dim cmd8 As New SqlCommand
            Dim cmd9 As New SqlCommand
            Dim cmd10 As New SqlCommand

            conn.ConnectionString = connstr
            conn2.ConnectionString = connstr2
            conn3.ConnectionString = connstr3
            conn4.ConnectionString = connstr4

            cmd.Connection = conn2
            cmd1.Connection = conn
            cmd2.Connection = conn
            cmd3.Connection = conn2
            cmd4.Connection = conn3
            cmd5.Connection = conn
            cmd6.Connection = conn
            cmd7.Connection = conn4
            cmd8.Connection = conn4
            cmd9.Connection = conn
            cmd10.Connection = conn


            cmd1.Parameters.AddWithValue("@prod1", prod)
            cmd2.Parameters.AddWithValue("@prod2", prod)

            cmd.CommandText = "Select Count(*) FROM [OEORDLIN_SQL] where ord_no = @so and (item_no = '909153' or item_no = '909212')"
            cmd1.CommandText = "Select SlotKey from Yard_Master_Locations where ProdNo = @prod1"

            cmd2.CommandText = "Select SONo from BML_POPREPORTING_GREENLIGHTS where ProdNo = @prod2"
            cmd3.CommandText = "SELECT [item_no], [item_desc_1], [cmt], OEORDLIN_SQL.line_seq_no, [line_no] FROM [OEORDLIN_SQL] Left Join OELINCMT_SQL on OEORDLIN_SQL.ord_no = OELINCMT_SQL.ord_no WHERE ((OEORDLIN_SQL.ord_no = @ord_no) AND (OELINCMT_SQL.line_seq_no = OEORDLIN_SQL.line_no) AND item_desc_1 not like '%LWR%' AND ([prod_cat] like '%EN%') AND loc ='01')"
            'cmd4.CommandText = "SELECT [item_no], [item_desc_1], [cmt], OEORDLIN_SQL.line_seq_no, [line_no] FROM [OEORDLIN_SQL] Left Join OELINCMT_SQL on OEORDLIN_SQL.ord_no = OELINCMT_SQL.ord_no WHERE ((OEORDLIN_SQL.ord_no = @ord_no) AND ((OELINCMT_SQL.line_seq_no = OEORDLIN_SQL.line_no) AND item_desc_1 not like '%LWR%' AND (OEORDLIN_SQL.line_no > @firstengline)) AND ([prod_cat] like '%EN%')AND loc ='01')"
            cmd5.CommandText = "Select Count(*) From Engines Where EngSerial = @engserial"
            cmd6.CommandText = "Select Count(*) From Engines Where EngSerial = @engserial2"
            cmd7.CommandText = "SELECT [item_no], [item_desc_1], [cmt], OEORDLIN_SQL.line_seq_no, [line_no] FROM [OEORDLIN_SQL] Left Join OELINCMT_SQL on OEORDLIN_SQL.ord_no = OELINCMT_SQL.ord_no WHERE ((OEORDLIN_SQL.ord_no = @ord_no7) AND (OELINCMT_SQL.line_seq_no = OEORDLIN_SQL.line_no) AND item_desc_1 like '%LWR%' AND ([prod_cat] like '%ELU%') AND loc ='01')"
            ' cmd8.CommandText = "SELECT [item_no], [item_desc_1], [cmt], OEORDLIN_SQL.line_seq_no, [line_no] FROM [OEORDLIN_SQL] Left Join OELINCMT_SQL on OEORDLIN_SQL.ord_no = OELINCMT_SQL.ord_no WHERE ((OEORDLIN_SQL.ord_no = @ord_no) AND ((OELINCMT_SQL.line_seq_no = OEORDLIN_SQL.line_no) AND item_desc_1 not like '%LWR%' AND (OEORDLIN_SQL.line_no > @firstengline)) AND ([prod_cat] like '%EN%') AND loc ='01')"
            cmd9.CommandText = "Select Count(*) From Engines Where EngSerial = @engserial9"
            cmd10.CommandText = "Select Count(*) From FEngines Where EngSerial = @engserial10"

            conn.Open()
            conn2.Open()

            Try
                SONo = cmd2.ExecuteScalar
                SONo = Mid(SONo, 3)
                SONo = "  " + SONo
                lblSONo.Text = SONo

                cmd.Parameters.AddWithValue("@so", SONo)

                Dim rigflag As Integer = cmd.ExecuteScalar

                If rigflag = 1 Then

                    Try
                        lblCompRackLoc.Text = cmd1.ExecuteScalar.ToString
                    Catch
                    End Try


                    cmd4.Parameters.AddWithValue("@ord_no", SONo)

                    conn4.Open()

                    cmd3.Parameters.AddWithValue("@ord_no", SONo)
                    cmd7.Parameters.AddWithValue("@ord_no7", SONo)

                    results = cmd3.ExecuteReader()
                    lwrResults = cmd7.ExecuteReader()

                    Try
                        Dim count As Integer = 1
                        btnLwr1Serial.Visible = False
                        btnLwr2Serial.Visible = False

                        While lwrResults.Read()
                            If count = 1 Then
                                If Trim(lwrResults.Item("cmt")).ToString = "TO BE RIGGED" Or Trim(lwrResults.Item("cmt")).ToString = "TWIN RIGGING" Then

                                Else
                                    btnLwr1Serial.Visible = True
                                    btnLwr1Serial.Text = Trim(lwrResults.Item("item_no")).ToString & " - " & Trim(lwrResults.Item("cmt")).ToString
                                    count = count + 1
                                    Try
                                        cmd9.Parameters.AddWithValue("@engserial9", Trim(lwrResults.Item("cmt")).ToString)
                                        storedLwrCount = cmd9.ExecuteScalar

                                        If storedLwrCount.ToString = "1" Then
                                            btnLwr1Serial.BackColor = Drawing.Color.LightGreen
                                        End If
                                    Catch ex As Exception

                                    End Try
                                End If

                            ElseIf count = 2 Then
                                    If Trim(lwrResults.Item("cmt")).ToString = "TO BE RIGGED" Or Trim(lwrResults.Item("cmt")).ToString = "TWIN RIGGING" Then

                                    Else
                                        btnLwr2Serial.Visible = True
                                        btnLwr2Serial.Text = Trim(lwrResults.Item("item_no")).ToString & " - " & Trim(lwrResults.Item("cmt")).ToString
                                        count = count + 1
                                    Try
                                        cmd10.Parameters.AddWithValue("@engserial10", Trim(lwrResults.Item("cmt")).ToString)
                                        storedLwr2Count = cmd10.ExecuteScalar

                                        If storedLwr2Count.ToString = "1" Then
                                            btnLwr2Serial.BackColor = Drawing.Color.LightGreen
                                        End If
                                    Catch ex As Exception

                                    End Try
                                        
                                End If
                            End If

                        End While


                    Catch ex As Exception

                    End Try

                    Try
                        Dim engCount As Integer = 1
                        btnEng1Serial.Visible = False
                        btnEng2Serial.Visible = False
                        While results.Read()
                            If engCount = 1 Then

                                lblEngLineSeqNo.Text = results.Item("line_no").ToString
                                lblCompEngSerial.Text = results.Item("cmt").ToString

                                If Trim(results.Item("cmt")).ToString = "TO BE RIGGED" Or Trim(results.Item("cmt")).ToString = "TWIN RIGGING" Then
                                    btnEng1Serial.Visible = False
                                Else
                                    btnEng1Serial.Text = Trim(results.Item("item_no")).ToString & " - " & Trim(results.Item("cmt")).ToString
                                    btnEng1Serial.Visible = True
                                    engCount = engCount + 1

                                    cmd5.Parameters.AddWithValue("@engserial", Trim(results.Item("cmt")).ToString)
                                    storedEngCount = cmd5.ExecuteScalar

                                    If storedEngCount.ToString = "1" Then
                                        btnEng1Serial.BackColor = Drawing.Color.LightGreen
                                    End If

                                End If

                            ElseIf engCount = 2 Then
                                If Trim(results.Item("cmt")).ToString = "TO BE RIGGED" Or Trim(results.Item("cmt")).ToString = "TWIN RIGGING" Then
                                    btnEng2Serial.Visible = False
                                Else
                                    btnEng2Serial.Visible = True
                                    btnEng2Serial.Text = Trim(results.Item("item_no")).ToString & " - " & Trim(results.Item("cmt")).ToString
                                    engCount = engCount + 1

                                    cmd6.Parameters.AddWithValue("@engserial2", Trim(results.Item("cmt")).ToString)
                                    storedEng2Count = cmd6.ExecuteScalar

                                    If storedEng2Count.ToString = "1" Then
                                        btnEng2Serial.BackColor = Drawing.Color.LightGreen
                                    End If

                                End If
                            End If

                        End While

                    Catch

                    End Try

                    results.Close()

                    Try
                        
                    Catch ex As Exception

                    End Try

                Else
                    e.Row.Visible = False
                End If

            Catch ex As Exception

        End Try


            conn2.Close()
            conn3.Close()
            conn4.Close()
            conn.Close()
        End If



    End Sub

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnExport.Click

        ExportExcel("EngInvExport", gvRecent)
    End Sub

    Public Sub ExportExcel(ByVal filename As String, ByVal gv As GridView)

        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=" & filename & ".xls")
        Response.ContentType = "application/vnd.ms-excel"
        Dim sw As New StringWriter()
        Dim htw As New HtmlTextWriter(sw)
        gv.RenderControl(htw)
        Response.Write(sw.ToString())
        Response.[End]()

    End Sub

    Protected Sub gvSerialBoats_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvSerialBoats.RowCommand

    End Sub

    Protected Sub btnEng1Serial_Click(sender As Object, e As EventArgs)

        Dim eng1modelserial As String = sender.text

        Dim a As String
        Dim serial As String
        Dim engmodel As String

        a = eng1modelserial.ToString()
        engmodel = a.Split("-"c)(0)  'model
        serial = a.Split("-"c)(1)  'serial

        engmodel = Trim(engmodel)
        serial = Trim(serial)

        Dim gvr As GridViewRow = DirectCast(sender.NamingContainer, GridViewRow)
        Dim prod As String = gvr.Cells(0).Text

        'save record
        Dim userID As String = GlobalVariables.stationID
        Dim TodaysDate As Date = Date.Now

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@engModel", engmodel)
        cmd.Parameters.AddWithValue("@engSerial", serial)
        cmd.Parameters.AddWithValue("@prod", prod)
        cmd.Parameters.AddWithValue("@dateEntered", TodaysDate)
        cmd.Parameters.AddWithValue("@user", userID)

        cmd.CommandText = "Insert into Engines (EngModel, EngSerial, ProdNo, DateEntered, EnteredBy) Values (@engModel, @engSerial, @prod, @dateEntered, @user)"

        conn.Open()
        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            MesgBox("This Serial # has already been entered")
        End Try
        conn.Close()

        gvRecent.DataBind()

        gvSerialBoats.DataBind()
       

    End Sub

    Protected Sub btnEng2Serial_Click(sender As Object, e As EventArgs)
        Dim eng2modelserial As String = sender.text

        Dim a As String
        Dim serial As String
        Dim engmodel As String

        a = eng2modelserial.ToString()
        engmodel = a.Split("-"c)(0)  'model
        serial = a.Split("-"c)(1)  'serial

        engmodel = Trim(engmodel)
        serial = Trim(serial)

        Dim gvr As GridViewRow = DirectCast(sender.NamingContainer, GridViewRow)
        Dim prod As String = gvr.Cells(0).Text

        'save record
        Dim userID As String = GlobalVariables.stationID
        Dim TodaysDate As Date = Date.Now

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@engModel", engmodel)
        cmd.Parameters.AddWithValue("@engSerial", serial)
        cmd.Parameters.AddWithValue("@prod", prod)
        cmd.Parameters.AddWithValue("@dateEntered", TodaysDate)
        cmd.Parameters.AddWithValue("@user", userID)

        cmd.CommandText = "Insert into Engines (EngModel, EngSerial, ProdNo, DateEntered, EnteredBy) Values (@engModel, @engSerial, @prod, @dateEntered, @user)"

        conn.Open()
        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            MesgBox("This Serial # has already been entered")
        End Try

        conn.Close()

        gvRecent.DataBind()
        gvSerialBoats.DataBind()

    End Sub

    
    Protected Sub btnLwr1Serial_Click(sender As Object, e As EventArgs)
        Dim eng1modelserial As String = sender.text

        Dim a As String
        Dim serial As String
        Dim engmodel As String

        a = eng1modelserial.ToString()
        engmodel = a.Split("-"c)(0)  'model
        serial = a.Split("-"c)(1)  'serial

        engmodel = Trim(engmodel)
        serial = Trim(serial)

        Dim gvr As GridViewRow = DirectCast(sender.NamingContainer, GridViewRow)
        Dim prod As String = gvr.Cells(0).Text

        'save record
        Dim userID As String = GlobalVariables.stationID
        Dim TodaysDate As Date = Date.Now

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@engModel", engmodel)
        cmd.Parameters.AddWithValue("@engSerial", serial)
        cmd.Parameters.AddWithValue("@prod", prod)
        cmd.Parameters.AddWithValue("@dateEntered", TodaysDate)
        cmd.Parameters.AddWithValue("@user", userID)

        cmd.CommandText = "Insert into Engines (EngModel, EngSerial, ProdNo, DateEntered, EnteredBy) Values (@engModel, @engSerial, @prod, @dateEntered, @user)"

        conn.Open()
        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            MesgBox("This Serial # has already been entered")
        End Try
        conn.Close()

        gvRecent.DataBind()

        gvSerialBoats.DataBind()
    End Sub

    Protected Sub btnLwr2Serial_Click(sender As Object, e As EventArgs)
        Dim eng1modelserial As String = sender.text

        Dim a As String
        Dim serial As String
        Dim engmodel As String

        a = eng1modelserial.ToString()
        engmodel = a.Split("-"c)(0)  'model
        serial = a.Split("-"c)(1)  'serial

        engmodel = Trim(engmodel)
        serial = Trim(serial)

        Dim gvr As GridViewRow = DirectCast(sender.NamingContainer, GridViewRow)
        Dim prod As String = gvr.Cells(0).Text

        'save record
        Dim userID As String = GlobalVariables.stationID
        Dim TodaysDate As Date = Date.Now

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("InventoryConnectionString").ConnectionString
        Dim cmd As New SqlCommand

        conn.ConnectionString = connstr
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@engModel", engmodel)
        cmd.Parameters.AddWithValue("@engSerial", serial)
        cmd.Parameters.AddWithValue("@prod", prod)
        cmd.Parameters.AddWithValue("@dateEntered", TodaysDate)
        cmd.Parameters.AddWithValue("@user", userID)

        cmd.CommandText = "Insert into Engines (EngModel, EngSerial, ProdNo, DateEntered, EnteredBy) Values (@engModel, @engSerial, @prod, @dateEntered, @user)"

        conn.Open()
        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            MesgBox("This Serial # has already been entered")
        End Try
        conn.Close()

        gvRecent.DataBind()

        gvSerialBoats.DataBind()
    End Sub
End Class
