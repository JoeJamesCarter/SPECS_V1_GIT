Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class YardMaster_MoveBoats
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub



    Protected Sub gvBoatsToMove_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvBoatsToMove.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim s As SqlDataSource = CType(e.Row.FindControl("sdsCompleteBoatsData"), SqlDataSource)

            Try
                Dim prod As String = (e.Row.Cells(1).Text)
                s.SelectParameters(0).DefaultValue = prod

            Catch ex As Exception

            End Try

        End If
    End Sub


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        btnClear.Visible = False
        If Not IsPostBack Then
            Search.CssClass = "Clicked"
            'Frames.CssClass = "Clicked"
            'Decks.CssClass = "Initial"
            'Incomplete.CssClass = "Initial"
            'Complete.CssClass = "Initial"
            btnRack1.CssClass = "Clicked"
            MainView.ActiveViewIndex = 0
            LocationView.ActiveViewIndex = 0
        End If
    End Sub

    Protected Sub Search_Click(sender As Object, e As EventArgs)
        Search.CssClass = "Clicked"
        Frames.CssClass = "Initial"
        Decks.CssClass = "Initial"
        Incomplete.CssClass = "Initial"
        Complete.CssClass = "Initial"
        MainView.ActiveViewIndex = 0
    End Sub

    Protected Sub Frames_Click(sender As Object, e As EventArgs)
        Search.CssClass = "Initial"
        Frames.CssClass = "Clicked"
        Decks.CssClass = "Initial"
        Incomplete.CssClass = "Initial"
        Complete.CssClass = "Initial"
        MainView.ActiveViewIndex = 1
    End Sub

    Protected Sub Decks_Click(sender As Object, e As EventArgs)
        Search.CssClass = "Initial"
        Frames.CssClass = "Initial"
        Decks.CssClass = "Clicked"
        Incomplete.CssClass = "Initial"
        Complete.CssClass = "Initial"

        MainView.ActiveViewIndex = 2
    End Sub

    Protected Sub Incomplete_Click(sender As Object, e As EventArgs)
        Search.CssClass = "Initial"
        Frames.CssClass = "Initial"
        Decks.CssClass = "Initial"
        Incomplete.CssClass = "Clicked"
        Complete.CssClass = "Initial"

        MainView.ActiveViewIndex = 3
    End Sub

    Protected Sub Complete_Click(sender As Object, e As EventArgs)
        Search.CssClass = "Initial"
        Frames.CssClass = "Initial"
        Decks.CssClass = "Initial"
        Incomplete.CssClass = "Initial"
        Complete.CssClass = "Clicked"

        MainView.ActiveViewIndex = 4
    End Sub

    Protected Sub Rack1_Click()
        btnRack1.CssClass = "Clicked"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        LocationView.ActiveViewIndex = 0

    End Sub
    Protected Sub Rack2_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Clicked"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        LocationView.ActiveViewIndex = 1

    End Sub
    Protected Sub Rack3_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Clicked"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        LocationView.ActiveViewIndex = 2

    End Sub
    Protected Sub Rack4_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Clicked"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        LocationView.ActiveViewIndex = 3

    End Sub
    Protected Sub Rack5_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Clicked"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        LocationView.ActiveViewIndex = 4

    End Sub

    Protected Sub Rack6_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initail"
        btnRack6.CssClass = "Clicked"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        LocationView.ActiveViewIndex = 5

    End Sub

    Protected Sub Rack7_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Clicked"
        btnRack8.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        LocationView.ActiveViewIndex = 6

    End Sub

    Protected Sub Rack8_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Clicked"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        LocationView.ActiveViewIndex = 7

    End Sub

    Protected Sub Ground1_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnGround1.CssClass = "Clicked"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        LocationView.ActiveViewIndex = 8


    End Sub
    Protected Sub Ground2_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Clicked"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        LocationView.ActiveViewIndex = 9


    End Sub

    Protected Sub Ground3_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Clicked"
        btnGround4.CssClass = "Initial"
        LocationView.ActiveViewIndex = 10


    End Sub

    Protected Sub Ground4_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Clicked"
        LocationView.ActiveViewIndex = 11


    End Sub



    Protected Sub gvRack1SlotsinA_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRack1SlotsinA.RowDataBound, gvRack1SlotsinB.RowDataBound, gvRack2SlotsInA.RowDataBound, gvRack2SlotsInB.RowDataBound, gvRack2SlotsInC.RowDataBound, gvRack3SlotsInA.RowDataBound, gvRack3SlotsInB.RowDataBound, gvRack3SlotsInC.RowDataBound, gvRack4SlotsInB.RowDataBound, gvRack5SlotsInA.RowDataBound, gvRack5SlotsInB.RowDataBound, gvRack6SlotsInA.RowDataBound, gvRack6SlotsInB.RowDataBound, gvRack6SlotsInC.RowDataBound, gvRack7SlotsInA.RowDataBound, gvRack7SlotsInB.RowDataBound, gvRack7SlotsInC.RowDataBound, gvRack8SlotsInA.RowDataBound, gvRack8SlotsInB.RowDataBound, gvRack8SlotsInC.RowDataBound, gvGround1.RowDataBound, gvGround2.RowDataBound, gvGround3.RowDataBound, gvGround4.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then
            If (e.Row.DataItem("Filled") = "1") Then
                'e.Row.BackColor = Drawing.Color.Red
                e.Row.ForeColor = Drawing.Color.LightSlateGray
                e.Row.Font.Bold = False
            End If
        End If
    End Sub


    Protected Sub gvRack1SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack1SlotsinA.SelectedIndexChanged

        lblLocSet.Text = gvRack1SlotsinA.SelectedValue

        If (gvRack1SlotsinA.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If


        'gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack1SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack1SlotsinB.SelectedIndexChanged

        lblLocSet.Text = gvRack1SlotsinB.SelectedValue

        If (gvRack1SlotsinB.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack2SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack2SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack2SlotsInA.SelectedValue

        If (gvRack2SlotsInA.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack2SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack2SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack2SlotsInB.SelectedValue

        If (gvRack2SlotsInB.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack2SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack2SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack2SlotsInC.SelectedValue

        If (gvRack2SlotsInB.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack3SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack3SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack3SlotsInA.SelectedValue

        If (gvRack3SlotsInA.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack3SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack3SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack3SlotsInB.SelectedValue

        If (gvRack3SlotsInB.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack3SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack3SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack3SlotsInB.SelectedValue

        If (gvRack3SlotsInC.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack4SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack4SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack4SlotsInA.SelectedValue

        If (gvRack4SlotsInA.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If


        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack4SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack4SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack4SlotsInB.SelectedValue

        If (gvRack4SlotsInB.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub


    Protected Sub gvRack5SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack5SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack5SlotsInA.SelectedValue

        If (gvRack5SlotsInA.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack5SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack5SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack5SlotsInB.SelectedValue

        If (gvRack5SlotsInB.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If
        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack6SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack6SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack6SlotsInA.SelectedValue

        If (gvRack6SlotsInA.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack6SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack6SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack6SlotsInB.SelectedValue

        If (gvRack6SlotsInB.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack6SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack6SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack6SlotsInC.SelectedValue

        If (gvRack6SlotsInC.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack7SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack7SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack7SlotsInA.SelectedValue

        If (gvRack7SlotsInA.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack7SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack7SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack7SlotsInB.SelectedValue

        If (gvRack7SlotsInB.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack7SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack7SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack7SlotsInC.SelectedValue

        If (gvRack7SlotsInC.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub


    Protected Sub gvRack8SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack8SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack8SlotsInA.SelectedValue

        If (gvRack8SlotsInA.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack8SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack8SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack8SlotsInB.SelectedValue

        If (gvRack8SlotsInB.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack8SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack8SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack8SlotsInC.SelectedValue

        If (gvRack8SlotsInC.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvGround1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround1.SelectedIndexChanged

        lblLocSet.Text = gvGround1.SelectedValue

        If (gvGround1.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If
        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvGround2_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround2.SelectedIndexChanged

        lblLocSet.Text = gvGround2.SelectedValue

        If (gvGround2.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If
        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvGround3_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround3.SelectedIndexChanged

        lblLocSet.Text = gvGround3.SelectedValue

        If (gvGround3.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If
        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvGround4_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround4.SelectedIndexChanged

        lblLocSet.Text = gvGround4.SelectedValue

        If (gvGround4.SelectedRow.ForeColor.ToString = "Color [LightSlateGray]") Then
            btnClear.Visible = True
        Else : btnClear.Visible = False

        End If
        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvGround1.SelectedIndex = -1
        gvGround2.SelectedIndex = -1
        gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub


    Protected Sub gvResults_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvResults.SelectedIndexChanged

        lblProdSet.Text = gvResults.SelectedValue
        gvFrameStack.SelectedIndex = -1
        gvDecksOutside.SelectedIndex = -1
        gvIncomplete.SelectedIndex = -1
        gvBoatsToMove.SelectedIndex = -1

        Dim loc As String = gvResults.SelectedRow.Cells(5).Text

        If loc Like "&*" Then
        Else
            If loc Like "100*" Then
                Ground1_Click()
            ElseIf loc Like "200*" Then
                Ground2_Click()
            ElseIf loc Like "300*" Then
                Ground3_Click()
            ElseIf loc Like "400*" Then
                Ground4_Click()
            ElseIf loc Like "1*" Then
                Rack1_Click()
            ElseIf loc Like "2*" Then
                Rack2_Click()
            ElseIf loc Like "3*" Then
                Rack3_Click()
            ElseIf loc Like "4*" Then
                Rack4_Click()
            ElseIf loc Like "5*" Then
                Rack5_Click()
            ElseIf loc Like "6*" Then
                Rack6_Click()
            ElseIf loc Like "7*" Then
                Rack7_Click()
            ElseIf loc Like "8*" Then
                Rack8_Click()
            End If
        End If

    End Sub

    Protected Sub gvFrameStack_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvFrameStack.SelectedIndexChanged

        lblProdSet.Text = gvFrameStack.SelectedValue
        gvResults.SelectedIndex = -1
        'gvFrameStack.SelectedIndex = -1
        gvDecksOutside.SelectedIndex = -1
        gvIncomplete.SelectedIndex = -1
        gvBoatsToMove.SelectedIndex = -1

        Dim loc As String = gvFrameStack.SelectedRow.Cells(4).Text

        If loc Like "&*" Then

        Else
            If loc Like "100*" Then
                Ground1_Click()
            ElseIf loc Like "200*" Then
                Ground2_Click()
            ElseIf loc Like "300*" Then
                Ground3_Click()
            ElseIf loc Like "400*" Then
                Ground4_Click()
            ElseIf loc Like "1*" Then
                Rack1_Click()
            ElseIf loc Like "2*" Then
                Rack2_Click()
            ElseIf loc Like "3*" Then
                Rack3_Click()
            ElseIf loc Like "4*" Then
                Rack4_Click()
            ElseIf loc Like "5*" Then
                Rack5_Click()
            ElseIf loc Like "6*" Then
                Rack6_Click()
            ElseIf loc Like "7*" Then
                Rack7_Click()
            ElseIf loc Like "8*" Then
                Rack8_Click()
            End If
        End If

    End Sub

    Protected Sub gvDecksOutside_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvDecksOutside.SelectedIndexChanged

        lblProdSet.Text = gvDecksOutside.SelectedValue
        gvResults.SelectedIndex = -1
        gvFrameStack.SelectedIndex = -1
        'gvDecksOutside.SelectedIndex = -1
        gvIncomplete.SelectedIndex = -1
        gvBoatsToMove.SelectedIndex = -1

        Dim loc As String = gvDecksOutside.SelectedRow.Cells(3).Text

        If loc Like "&*" Then

        Else
            If loc Like "100*" Then
                Ground1_Click()
            ElseIf loc Like "200*" Then
                Ground2_Click()
            ElseIf loc Like "300*" Then
                Ground3_Click()
            ElseIf loc Like "400*" Then
                Ground4_Click()
            ElseIf loc Like "1*" Then
                Rack1_Click()
            ElseIf loc Like "2*" Then
                Rack2_Click()
            ElseIf loc Like "3*" Then
                Rack3_Click()
            ElseIf loc Like "4*" Then
                Rack4_Click()
            ElseIf loc Like "5*" Then
                Rack5_Click()
            ElseIf loc Like "6*" Then
                Rack6_Click()
            ElseIf loc Like "7*" Then
                Rack7_Click()
            ElseIf loc Like "8*" Then
                Rack8_Click()
            End If
        End If
    End Sub


    Protected Sub gvIncomplete_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvIncomplete.SelectedIndexChanged

        lblProdSet.Text = gvIncomplete.SelectedValue
        gvResults.SelectedIndex = -1
        gvFrameStack.SelectedIndex = -1
        gvDecksOutside.SelectedIndex = -1
        'gvIncomplete.SelectedIndex = -1
        gvBoatsToMove.SelectedIndex = -1

        Dim loc As String = gvIncomplete.SelectedRow.Cells(5).Text

        If loc Like "&*" Then

        Else
            If loc Like "100*" Then
                Ground1_Click()
            ElseIf loc Like "200*" Then
                Ground2_Click()
            ElseIf loc Like "300*" Then
                Ground3_Click()
            ElseIf loc Like "400*" Then
                Ground4_Click()
            ElseIf loc Like "1*" Then
                Rack1_Click()
            ElseIf loc Like "2*" Then
                Rack2_Click()
            ElseIf loc Like "3*" Then
                Rack3_Click()
            ElseIf loc Like "4*" Then
                Rack4_Click()
            ElseIf loc Like "5*" Then
                Rack5_Click()
            ElseIf loc Like "6*" Then
                Rack6_Click()
            ElseIf loc Like "7*" Then
                Rack7_Click()
            ElseIf loc Like "8*" Then
                Rack8_Click()
            End If
        End If
    End Sub


    Protected Sub gvBoatsToMove_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvBoatsToMove.SelectedIndexChanged

        lblProdSet.Text = gvBoatsToMove.SelectedValue
        gvResults.SelectedIndex = -1
        gvFrameStack.SelectedIndex = -1
        gvDecksOutside.SelectedIndex = -1
        gvIncomplete.SelectedIndex = -1
        'gvBoatsToMove.SelectedIndex = -1
    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        'Set the yard master location filled to 0 and the prod # and datein to null

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        conn.ConnectionString = connstr

        cmd.CommandType = CommandType.Text
        cmd.CommandText = "UPDATE Yard_Master_Locations SET Filled = 0, ProdNo = NULL, DateIn = NULL where SlotKey =  '" & lblLocSet.Text & "'"
        cmd.Connection = conn

        If Len(lblLocSet.Text) < 1 Then
            'Do Nothing
        Else
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            If lblLocSet.Text Like "*00*" Then
                gvGround1.DataBind()
                gvGround2.DataBind()
                gvGround3.DataBind()
                gvGround4.DataBind()
            ElseIf lblLocSet.Text Like "1*" Then
                gvRack1SlotsinA.DataBind()
                gvRack1SlotsinB.DataBind()
            ElseIf lblLocSet.Text Like "2*" Then
                gvRack2SlotsInA.DataBind()
                gvRack2SlotsInB.DataBind()
                gvRack2SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "3*" Then
                gvRack3SlotsInA.DataBind()
                gvRack3SlotsInB.DataBind()
                gvRack3SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "4*" Then
                gvRack4SlotsInA.DataBind()
                gvRack4SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "5*" Then
                gvRack5SlotsInA.DataBind()
                gvRack5SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "6*" Then
                gvRack6SlotsInA.DataBind()
                gvRack6SlotsInB.DataBind()
                gvRack6SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "7*" Then
                gvRack7SlotsInA.DataBind()
                gvRack7SlotsInB.DataBind()
                gvRack7SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "8*" Then
                gvRack8SlotsInA.DataBind()
                gvRack8SlotsInB.DataBind()
                gvRack8SlotsInC.DataBind()
            End If

        End If

        gvFrameStack.DataBind()
        gvDecksOutside.DataBind()
        gvIncomplete.DataBind()
        gvBoatsToMove.DataBind()
        gvResults.DataBind()


    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        'set the yard master location filled to 1 and prod to lblProdSet and Datein to Today

        Dim TodaysDate As Date = Date.Now
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim prod As String = lblProdSet.Text
        Dim slot As String = lblLocSet.Text

        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.CommandType = CommandType.Text
        cmd.CommandText = "UPDATE Yard_Master_Locations SET Filled = 1, ProdNo = '" & lblProdSet.Text & "', DateIn = '" & TodaysDate & "' where SlotKey =  '" & lblLocSet.Text & "'"

        If Len(prod) > 1 And Len(slot) > 1 Then
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            If lblLocSet.Text Like "*00*" Then
                gvGround1.DataBind()
                gvGround2.DataBind()
                gvGround3.DataBind()
                gvGround4.DataBind()
            ElseIf lblLocSet.Text Like "1*" Then
                gvRack1SlotsinA.DataBind()
                gvRack1SlotsinB.DataBind()
            ElseIf lblLocSet.Text Like "2*" Then
                gvRack2SlotsInA.DataBind()
                gvRack2SlotsInB.DataBind()
                gvRack2SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "3*" Then
                gvRack3SlotsInA.DataBind()
                gvRack3SlotsInB.DataBind()
                gvRack3SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "4*" Then
                gvRack4SlotsInA.DataBind()
                gvRack4SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "5*" Then
                gvRack5SlotsInA.DataBind()
                gvRack5SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "6*" Then
                gvRack6SlotsInA.DataBind()
                gvRack6SlotsInB.DataBind()
                gvRack6SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "7*" Then
                gvRack7SlotsInA.DataBind()
                gvRack7SlotsInB.DataBind()
                gvRack7SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "8*" Then
                gvRack8SlotsInA.DataBind()
                gvRack8SlotsInB.DataBind()
                gvRack8SlotsInC.DataBind()
            End If

            gvFrameStack.DataBind()
            gvDecksOutside.DataBind()
            gvIncomplete.DataBind()
            gvBoatsToMove.DataBind()
            gvResults.DataBind()

        End If



    End Sub

    Protected Sub btnClearSearch_Click(sender As Object, e As EventArgs) Handles btnClearSearch.Click
        tbSearchProdNo.Text = ""
        lblLocSet.Text = ""
        lblProdSet.Text = ""
        gvResults.SelectedIndex = -1

    End Sub
End Class

