Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Tubes_AddCSTubes
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub cbTubes_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbTubes.SelectedIndexChanged
        For Each li As ListItem In cbTubes.Items
            If li.Value = "P" And li.Selected = True Then
                Label8.Visible = True
                ddlOuterSections.Visible = True
                outertubedetails.Visible = True
                btnSave.Visible = True
            End If

            If li.Value = "S" And li.Selected = True Then
                Label8.Visible = True
                ddlOuterSections.Visible = True
                outertubedetails.Visible = True
                btnSave.Visible = True
            End If

            If li.Value = "C" And li.Selected = True Then
                Label9.Visible = True
                ddlCenterSections.Visible = True
                centertubedetails.Visible = True
                btnSave.Visible = True
            End If
        Next
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Label8.Visible = False
        Label9.Visible = False
        ddlOuterSections.Visible = False
        ddlCenterSections.Visible = False

        outertubedetails.Visible = False
        centertubedetails.Visible = False
        btnSave.Visible = False

    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        Dim oe As String = tbOE.Text
        Dim dlr As String = tbDealer.Text
        Dim cust As String = tbCustomer.Text
        Dim model As String = tbModel.Text
        Dim modelyear As String = tbModelYear.Text

        Dim port As Integer = 0
        Dim strb As Integer = 0
        Dim ctr As Integer = 0

        Dim outersections As Integer = 0
        Dim centersections As Integer = 0

        outersections = ddlOuterSections.SelectedValue


        Dim outerroller As String = ddlOuterRoller.SelectedValue

        'Outer Fields
        Dim style As String = tbStyle.Text
        Dim diameter As Integer = ddlDiameter.SelectedValue
        Dim front As String = tbFront.Text
        Dim ladder As String = tbLadder.Text
        Dim bracket As String = tbBrackets.Text
        Dim keel As String = tbKeel.Text
        Dim fuel As String = tbFuel.Text
        Dim splash As String = tbSplash.Text
        Dim strakes As String = tbStrakes.Text
        Dim strakescomments As String = tbStrakesComments.Text
        Dim strbtrans As String = tbStrbTrans.Text
        Dim comments As String = tbComments.Text
        Dim black As String = tbBlack.Text
        Dim drawingno As String = tbDrawingNo.Text

        'Center Fields
        Dim centerroller As String = ddlCenterRoller.SelectedValue
        centersections = ddlCenterSections.SelectedValue
        Dim length As String = tbLength.Text
        Dim center As String = ddlCenter.SelectedValue
        Dim storage As String = ddlStorage.SelectedValue
        Dim tenwide As String = ddlTenWide.SelectedValue
        Dim ctrdrawingno As String = tbCtrDrawingNo.Text
        Dim ctrbracket As String = tbCtrBracket.Text
        Dim ctrfuel As String = ddlCenterFuel.SelectedValue
        Dim ctrstrakes As String = tbCenterStrakes.Text
        Dim tubeupg As String = tbTubeUpg.Text
        Dim upsweep As String = tbUpsweep.Text

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString

        Dim cmd As New SqlCommand
        
        Dim TodaysDate As Date = Date.Now

        conn.ConnectionString = connstr
        cmd.Connection = conn
        'outer detail
        cmd.Parameters.AddWithValue("@oe", oe)
        cmd.Parameters.AddWithValue("@dlr", dlr)
        cmd.Parameters.AddWithValue("@cust", cust)
        cmd.Parameters.AddWithValue("@model", model)
        cmd.Parameters.AddWithValue("@modelyear", modelyear)
       
        cmd.Parameters.AddWithValue("@outersections", outersections)
        cmd.Parameters.AddWithValue("@centersections", centersections)
        cmd.Parameters.AddWithValue("@outerroller", outerroller)
        cmd.Parameters.AddWithValue("@centerroller", centerroller)

        cmd.Parameters.AddWithValue("@style", style)
        cmd.Parameters.AddWithValue("@diameter", diameter)
        cmd.Parameters.AddWithValue("@front", front)
        cmd.Parameters.AddWithValue("@ladder", ladder)
        cmd.Parameters.AddWithValue("@bracket", bracket)
        cmd.Parameters.AddWithValue("@keel", keel)
        cmd.Parameters.AddWithValue("@fuel", fuel)
        cmd.Parameters.AddWithValue("@splash", splash)
        cmd.Parameters.AddWithValue("@strakes", strakes)
        cmd.Parameters.AddWithValue("@strakescomments", strakescomments)
        cmd.Parameters.AddWithValue("@strbtrans", strbtrans)
        cmd.Parameters.AddWithValue("@comments", comments)
        cmd.Parameters.AddWithValue("@black", black)
        cmd.Parameters.AddWithValue("@drawingno", drawingno)

        'center detail
        cmd.Parameters.AddWithValue("@length", length)
        cmd.Parameters.AddWithValue("@center", center)
        cmd.Parameters.AddWithValue("@storage", storage)
        cmd.Parameters.AddWithValue("@tenwide", tenwide)
        cmd.Parameters.AddWithValue("@ctrdrawingno", ctrdrawingno)
        cmd.Parameters.AddWithValue("@ctrbracket", ctrbracket)
        cmd.Parameters.AddWithValue("@ctrfuel", ctrfuel)
        cmd.Parameters.AddWithValue("@ctrstrakes", ctrstrakes)
        cmd.Parameters.AddWithValue("@tubeupg", tubeupg)
        cmd.Parameters.AddWithValue("@upsweep", upsweep)

        cmd.Parameters.AddWithValue("@port", port)
        cmd.Parameters.AddWithValue("@strb", strb)
        cmd.Parameters.AddWithValue("@ctr", ctr)


        For Each Parameter As SqlParameter In cmd.Parameters
            If Parameter.Value Is Nothing Then
                Parameter.Value = DBNull.Value
            End If
        Next

        cmd.CommandType = CommandType.Text

        conn.Open()

        For Each li As ListItem In cbTubes.Items
            If li.Value = "P" And li.Selected = True Then

                cmd.CommandText = "Insert Into CS_Tubes (OENo, Dealer, Customer, Model, ModelYear, Style, Diameter, Front, Port, Strb, Ctr, Ladder, Bracket, Keel, Fuel, Splash, Strakes, StrakesComments, StrbTrans, Comments, Black, DrawingNo, Length, Center, Storage, TenWide, CtrDrawingNo, CtrBracket, CtrFuel, CtrStrakes, TubeUpg, Upsweep, OuterScheduledFlag, CenterScheduledFlag, OuterRoller, CenterRoller, OuterSections, CenterSections) VALUES (@oe, @dlr, @cust, @model, @modelyear, @style, @diameter, @front, 1, 0, 0, @ladder, @bracket, @keel, @fuel, @splash, @strakes, @strakescomments, @strbtrans, @comments, @black, @drawingno, @length, @center, @storage, @tenwide, @ctrdrawingno, @ctrbracket, @ctrfuel, @ctrstrakes, @tubeupg, @upsweep, 0, 0, @outerroller, @centerroller, @outersections, @centersections)"

                If ddlOuterSections.SelectedValue > 0 Then
                    cmd.ExecuteNonQuery()
                Else
                    MesgBox("Please select # of Outer Sections and save again.")
                    outertubedetails.Visible = True
                    Return
                End If

            End If

            If li.Value = "S" And li.Selected = True Then

                cmd.CommandText = "Insert Into CS_Tubes (OENo, Dealer, Customer, Model, ModelYear, Style, Diameter, Front, Port, Strb, Ctr, Ladder, Bracket, Keel, Fuel, Splash, Strakes, StrakesComments, StrbTrans, Comments, Black, DrawingNo, Length, Center, Storage, TenWide, CtrDrawingNo, CtrBracket, CtrFuel, CtrStrakes, TubeUpg, Upsweep, OuterScheduledFlag, CenterScheduledFlag, OuterRoller, CenterRoller, OuterSections, CenterSections) VALUES (@oe, @dlr, @cust, @model, @modelyear, @style, @diameter, @front, 0, 1, 0, @ladder, @bracket, @keel, @fuel, @splash, @strakes, @strakescomments, @strbtrans, @comments, @black, @drawingno, @length, @center, @storage, @tenwide, @ctrdrawingno, @ctrbracket, @ctrfuel, @ctrstrakes, @tubeupg, @upsweep, 0, 0, @outerroller, @centerroller, @outersections, @centersections)"

                If ddlOuterSections.SelectedValue > 0 Then
                    cmd.ExecuteNonQuery()
                Else
                    MesgBox("Please select # of Outer Sections and save again.")
                    outertubedetails.Visible = True
                    Return
                End If
            End If

            If li.Value = "C" And li.Selected = True Then
                cmd.CommandText = "Insert Into CS_Tubes (OENo, Dealer, Customer, Model, ModelYear, Style, Diameter, Front, Port, Strb, Ctr, Ladder, Bracket, Keel, Fuel, Splash, Strakes, StrakesComments, StrbTrans, Comments, Black, DrawingNo, Length, Center, Storage, TenWide, CtrDrawingNo, CtrBracket, CtrFuel, CtrStrakes, TubeUpg, Upsweep, OuterScheduledFlag, CenterScheduledFlag, OuterRoller, CenterRoller, OuterSections, CenterSections) VALUES (@oe, @dlr, @cust, @model, @modelyear, @style, @diameter, @front, 0, 0, 1, @ladder, @bracket, @keel, @fuel, @splash, @strakes, @strakescomments, @strbtrans, @comments, @black, @drawingno, @length, @center, @storage, @tenwide, @ctrdrawingno, @ctrbracket, @ctrfuel, @ctrstrakes, @tubeupg, @upsweep, 0, 0, @outerroller, @centerroller, @outersections, @centersections)"

                If ddlCenterSections.SelectedValue > 0 Then
                    cmd.ExecuteNonQuery()
                Else
                    MesgBox("Please select # of Center Sections and save again.")
                    centertubedetails.Visible = True
                    Return
                End If

            End If
        Next

        conn.Close()

        gvCSOuters.DataBind()
        gvCSCenters.DataBind()

        MesgBox("Submitted")

        tbOE.Text = ""
        tbDealer.Text = ""
        tbCustomer.Text = ""
        tbModel.Text = ""
        tbModelYear.Text = ""

        
        ddlOuterSections.SelectedIndex = -1
        ddlCenterSections.SelectedIndex = -1

        ddlOuterRoller.SelectedIndex = -1
        ddlCenterRoller.SelectedIndex = -1

        tbStyle.Text = ""
        ddlDiameter.SelectedIndex = -1
        tbFront.Text = ""
        tbLadder.Text = ""
        tbBrackets.Text = ""
        tbCtrBracket.Text = ""
        tbKeel.Text = ""
        tbFuel.Text = ""
        tbSplash.Text = ""
        tbStrakes.Text = ""
        tbStrakesComments.Text = ""
        tbStrbTrans.Text = ""
        tbComments.Text = ""
        tbBlack.Text = ""
        tbDrawingNo.Text = ""

        tbLength.Text = ""
        ddlCenter.SelectedIndex = -1
        ddlStorage.SelectedIndex = -1
        ddlTenWide.SelectedIndex = -1
        tbCtrDrawingNo.Text = ""
        tbCtrBracket.Text = ""
        ddlCenterFuel.SelectedIndex = -1
        tbCenterStrakes.Text = ""
        tbTubeUpg.Text = ""
        tbUpsweep.Text = ""

        For Each li As ListItem In cbTubes.Items
            If li.Selected = True Then
                li.Selected = False
            End If
        Next



    End Sub

    Protected Sub gvCSOuters_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCSOuters.RowDataBound
        Dim dRowView As DataRowView = DirectCast(e.Row.DataItem, DataRowView)
        If e.Row.RowType = DataControlRowType.DataRow Then

            If (e.Row.RowState And DataControlRowState.Edit) > 0 Then

                Dim calOuterScheduled As Calendar = DirectCast(e.Row.FindControl("calOuterScheduled"), Calendar)

                If e.Row.DataItem("OuterScheduledFlag") = 1 Then 'only bind the date if it is set
                    calOuterScheduled.SelectedDate = e.Row.DataItem("OuterScheduled")
                    calOuterScheduled.SelectedDate = dRowView(21).ToString()
                End If

                'needed for using item templates in rowupdating command
                Dim ddlOuterRoller As DropDownList = DirectCast(e.Row.FindControl("ddlOuterRoller"), DropDownList)
                ddlOuterRoller.SelectedValue = dRowView(22).ToString()

            End If

        End If
    End Sub

    Protected Sub gvCSOuters_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvCSOuters.RowUpdating
        Dim ddlOuterRoller As DropDownList = DirectCast(gvCSOuters.Rows(e.RowIndex).FindControl("ddlOuterRoller"), DropDownList)
        Dim calOuterScheduled As Calendar = DirectCast(gvCSOuters.Rows(e.RowIndex).FindControl("calOuterScheduled"), Calendar)
        Dim outerscheduledFlag As Integer = 0

        sdsCSOuterTubes.UpdateParameters("OuterRoller").DefaultValue = ddlOuterRoller.SelectedValue

        If calOuterScheduled.SelectedDate.Date = DateTime.MinValue.Date Then
            sdsCSOuterTubes.UpdateParameters("OuterScheduledFlag").DefaultValue = outerscheduledFlag
        Else
            outerscheduledFlag = 1
            sdsCSOuterTubes.UpdateParameters("OuterScheduled").DefaultValue = calOuterScheduled.SelectedDate
            sdsCSOuterTubes.UpdateParameters("OuterScheduledFlag").DefaultValue = outerscheduledFlag
        End If



    End Sub

    Protected Sub gvCSCenters_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCSCenters.RowDataBound
        Dim dRowView As DataRowView = DirectCast(e.Row.DataItem, DataRowView)
        If e.Row.RowType = DataControlRowType.DataRow Then

            If (e.Row.RowState And DataControlRowState.Edit) > 0 Then

                Dim calCenterScheduled As Calendar = DirectCast(e.Row.FindControl("calCenterScheduled"), Calendar)

                If e.Row.DataItem("CenterScheduledFlag") = 1 Then 'only bind the date if it is set
                    calCenterScheduled.SelectedDate = e.Row.DataItem("CenterScheduled")
                    calCenterScheduled.SelectedDate = dRowView(16).ToString()
                End If

                'needed for using item templates in rowupdating command
                Dim ddlCenterRoller As DropDownList = DirectCast(e.Row.FindControl("ddlCenterRoller"), DropDownList)
                ddlCenterRoller.SelectedValue = dRowView(17).ToString()

            End If

        End If
    End Sub

    Protected Sub gvCSCenters_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvCSCenters.RowUpdating
        Dim ddlCenterRoller As DropDownList = DirectCast(gvCSCenters.Rows(e.RowIndex).FindControl("ddlCenterRoller"), DropDownList)
        Dim calCenterScheduled As Calendar = DirectCast(gvCSCenters.Rows(e.RowIndex).FindControl("calCenterScheduled"), Calendar)
        Dim CenterscheduledFlag As Integer = 0

        sdsCSCenterTubes.UpdateParameters("CenterRoller").DefaultValue = ddlCenterRoller.SelectedValue
        sdsCSCenterTubes.UpdateParameters("Storage").DefaultValue = ddlStorage.SelectedValue
        sdsCSCenterTubes.UpdateParameters("CtrFuel").DefaultValue = ddlCenterFuel.SelectedValue

        If calCenterScheduled.SelectedDate.Date = DateTime.MinValue.Date Then
            sdsCSCenterTubes.UpdateParameters("CenterScheduledFlag").DefaultValue = CenterscheduledFlag
        Else
            CenterscheduledFlag = 1
            sdsCSCenterTubes.UpdateParameters("CenterScheduled").DefaultValue = calCenterScheduled.SelectedDate
            sdsCSCenterTubes.UpdateParameters("CenterScheduledFlag").DefaultValue = CenterscheduledFlag
        End If
    End Sub


End Class
