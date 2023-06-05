Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls


Partial Class YardMaster_BoatLocations
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Search.CssClass = "Clicked"
            btnRack1.CssClass = "Clicked"
            MainView.ActiveViewIndex = 0
            LocationView.ActiveViewIndex = 0
        End If
    End Sub

    Protected Sub Search_Click(sender As Object, e As EventArgs)
        Search.CssClass = "Clicked"
        Incomplete.CssClass = "Initial"
        Tubes.CssClass = "Initial"
        Transport.CssClass = "Initial"
        MainView.ActiveViewIndex = 0
    End Sub

    Protected Sub Incomplete_Click(sender As Object, e As EventArgs)
        Search.CssClass = "Initial"
        Incomplete.CssClass = "Clicked"
        Tubes.CssClass = "Initial"
        Transport.CssClass = "Initial"
        MainView.ActiveViewIndex = 1
    End Sub

    Protected Sub Tubes_Click(sender As Object, e As EventArgs)
        Search.CssClass = "Initial"
        Incomplete.CssClass = "Initial"
        Transport.CssClass = "Initial"
        Tubes.CssClass = "Clicked"
        MainView.ActiveViewIndex = 2
    End Sub

    Protected Sub Transport_Click(sender As Object, e As EventArgs)
        Search.CssClass = "Initial"
        Incomplete.CssClass = "Initial"
        Tubes.CssClass = "Initial"
        Transport.CssClass = "Clicked"
        MainView.ActiveViewIndex = 3
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
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
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
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 1

    End Sub

    Protected Sub Rack3_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Clicked"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
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
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
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
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 4

    End Sub

    Protected Sub Rack6_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Clicked"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
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
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
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
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 7

    End Sub


    Protected Sub Rack9_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Clicked"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 8

    End Sub

    Protected Sub Rack10_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Clicked"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 9

    End Sub

    Protected Sub Rack11_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Clicked"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 10

    End Sub

    Protected Sub Rack12_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Clicked"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 11

    End Sub

    Protected Sub Rack13_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Clicked"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 12

    End Sub

    Protected Sub Rack14_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Clicked"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 13

    End Sub

    Protected Sub Rack15_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Clicked"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 14

    End Sub

    Protected Sub Rack16_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Clicked"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 15

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
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Clicked"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 16


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
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Clicked"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 17


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
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Clicked"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 18


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
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Clicked"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 19


    End Sub

    Protected Sub Ground5_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Clicked"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 20


    End Sub

    Protected Sub Ground6_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Clicked"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 21


    End Sub


    Protected Sub Ground7_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Clicked"
        btnGround8.CssClass = "Initial"
        LocationView.ActiveViewIndex = 22


    End Sub


    Protected Sub Ground8_Click()
        btnRack1.CssClass = "Initial"
        btnRack2.CssClass = "Initial"
        btnRack3.CssClass = "Initial"
        btnRack4.CssClass = "Initial"
        btnRack5.CssClass = "Initial"
        btnRack6.CssClass = "Initial"
        btnRack7.CssClass = "Initial"
        btnRack8.CssClass = "Initial"
        btnRack9.CssClass = "Initial"
        btnRack10.CssClass = "Initial"
        btnRack11.CssClass = "Initial"
        btnRack12.CssClass = "Initial"
        btnRack13.CssClass = "Initial"
        btnRack14.CssClass = "Initial"
        btnRack15.CssClass = "Initial"
        btnRack16.CssClass = "Initial"
        btnGround1.CssClass = "Initial"
        btnGround2.CssClass = "Initial"
        btnGround3.CssClass = "Initial"
        btnGround4.CssClass = "Initial"
        btnGround5.CssClass = "Initial"
        btnGround6.CssClass = "Initial"
        btnGround7.CssClass = "Initial"
        btnGround8.CssClass = "Clicked"
        LocationView.ActiveViewIndex = 23


    End Sub




    Protected Sub gvRack1SlotsinA_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvRack1SlotsinA.RowDataBound, gvRack1SlotsinB.RowDataBound, gvRack1SlotsinC.RowDataBound, gvRack2SlotsInA.RowDataBound, gvRack2SlotsInC.RowDataBound, gvRack2SlotsInC.RowDataBound, gvRack3SlotsInA.RowDataBound, gvRack3SlotsInB.RowDataBound, gvRack3SlotsInC.RowDataBound, gvRack4SlotsInB.RowDataBound, gvRack4SlotsInC.RowDataBound, gvRack5SlotsInA.RowDataBound, gvRack5SlotsInB.RowDataBound, gvRack5SlotsInC.RowDataBound, gvRack6SlotsInA.RowDataBound, gvRack6SlotsInB.RowDataBound, gvRack6SlotsInC.RowDataBound, gvRack7SlotsInA.RowDataBound, gvRack7SlotsInB.RowDataBound, gvRack7SlotsInC.RowDataBound, gvRack8SlotsInA.RowDataBound, gvRack8SlotsInB.RowDataBound, gvRack8SlotsInC.RowDataBound, gvRack9SlotsInA.RowDataBound, gvRack9SlotsInB.RowDataBound, gvRack9SlotsInC.RowDataBound, gvRack10SlotsInA.RowDataBound, gvRack10SlotsInB.RowDataBound, gvRack10SlotsInC.RowDataBound, gvRack11SlotsInB.RowDataBound, gvRack11SlotsInC.RowDataBound, gvRack12SlotsInA.RowDataBound, gvRack12SlotsInB.RowDataBound, gvRack12SlotsInC.RowDataBound, gvRack13SlotsInA.RowDataBound, gvRack13SlotsInB.RowDataBound, gvRack13SlotsInC.RowDataBound, gvRack14SlotsInA.RowDataBound, gvRack14SlotsInB.RowDataBound, gvRack14SlotsInC.RowDataBound, gvRack15SlotsInA.RowDataBound, gvRack15SlotsInB.RowDataBound, gvRack15SlotsInC.RowDataBound, gvRack16SlotsInA.RowDataBound, gvRack16SlotsInB.RowDataBound, gvRack16SlotsInC.RowDataBound, gvGround1.RowDataBound, gvGround2.RowDataBound, gvGround3.RowDataBound, gvGround4.RowDataBound, gvGround5.RowDataBound, gvGround6.RowDataBound, gvGround7.RowDataBound, gvGround8.RowDataBound

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

        'gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        gvRack1SlotsinC.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack1SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack1SlotsinB.SelectedIndexChanged

        lblLocSet.Text = gvRack1SlotsinB.SelectedValue

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinC.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack1SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack1SlotsinC.SelectedIndexChanged

        lblLocSet.Text = gvRack1SlotsinC.SelectedValue

        gvRack1SlotsinA.SelectedIndex = -1
        gvRack1SlotsinB.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack2SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack2SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack2SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack2SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack2SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack2SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack2SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack2SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack2SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        gvRack2SlotsInA.SelectedIndex = -1
        gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack3SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack3SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack3SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack3SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack3SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack3SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack3SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack3SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack3SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        gvRack3SlotsInA.SelectedIndex = -1
        gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack4SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack4SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack4SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        gvRack4SlotsInC.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack4SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack4SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack4SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack4SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack4SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack4SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        gvRack4SlotsInA.SelectedIndex = -1
        gvRack4SlotsInB.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack5SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack5SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack5SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        gvRack5SlotsInC.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack5SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack5SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack5SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInC.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack5SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack5SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack5SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        gvRack5SlotsInA.SelectedIndex = -1
        gvRack5SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack6SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack6SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack6SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack6SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack6SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack6SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack6SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack6SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack6SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        gvRack6SlotsInA.SelectedIndex = -1
        gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack7SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack7SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack7SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack7SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack7SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack7SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack7SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack7SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack7SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        gvRack7SlotsInA.SelectedIndex = -1
        gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack8SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack8SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack8SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack8SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack8SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack8SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack8SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack8SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack8SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        gvRack8SlotsInA.SelectedIndex = -1
        gvRack8SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack9SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack9SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack9SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        gvRack9SlotsInB.SelectedIndex = -1
        gvRack9SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack9SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack9SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack9SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        gvRack9SlotsInA.SelectedIndex = -1
        gvRack9SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack9SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack9SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack9SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        gvRack9SlotsInA.SelectedIndex = -1
        gvRack9SlotsInB.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack10SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack10SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack10SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        gvRack10SlotsInB.SelectedIndex = -1
        gvRack10SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack10SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack10SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack10SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        gvRack10SlotsInA.SelectedIndex = -1
        gvRack10SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack10SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack10SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack10SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        gvRack10SlotsInA.SelectedIndex = -1
        gvRack10SlotsInB.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub


    Protected Sub gvRack11SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack11SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack11SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        gvRack11SlotsInB.SelectedIndex = -1
        gvRack11SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack11SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack11SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack11SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        gvRack11SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        gvRack11SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack11SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack11SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack11SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        gvRack11SlotsInA.SelectedIndex = -1
        gvRack11SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack12SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack12SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack12SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        gvRack12SlotsInB.SelectedIndex = -1
        gvRack12SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack12SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack12SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack12SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        gvRack12SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        gvRack12SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack12SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack12SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack12SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        gvRack12SlotsInA.SelectedIndex = -1
        gvRack12SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack13SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack13SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack13SlotsInA.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        'gvRack8SlotsInA.SelectedIndex = -1
        gvRack13SlotsInB.SelectedIndex = -1
        gvRack13SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack13SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack13SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack13SlotsInB.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        gvRack13SlotsInA.SelectedIndex = -1
        'gvRack8SlotsInB.SelectedIndex = -1
        gvRack13SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack13SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack13SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack13SlotsInC.SelectedValue

        'gvRack1SlotsinA.SelectedIndex = -1
        'gvRack1SlotsinB.SelectedIndex = -1
        'gvRack2SlotsInA.SelectedIndex = -1
        'gvRack2SlotsInB.SelectedIndex = -1
        'gvRack2SlotsInC.SelectedIndex = -1
        'gvRack3SlotsInA.SelectedIndex = -1
        'gvRack3SlotsInB.SelectedIndex = -1
        'gvRack3SlotsInC.SelectedIndex = -1
        'gvRack4SlotsInA.SelectedIndex = -1
        'gvRack4SlotsInB.SelectedIndex = -1
        'gvRack5SlotsInA.SelectedIndex = -1
        'gvRack5SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInA.SelectedIndex = -1
        'gvRack6SlotsInB.SelectedIndex = -1
        'gvRack6SlotsInC.SelectedIndex = -1
        'gvRack7SlotsInA.SelectedIndex = -1
        'gvRack7SlotsInB.SelectedIndex = -1
        'gvRack7SlotsInC.SelectedIndex = -1
        gvRack13SlotsInA.SelectedIndex = -1
        gvRack13SlotsInB.SelectedIndex = -1
        'gvRack8SlotsInC.SelectedIndex = -1
        'gvGround1.SelectedIndex = -1
        'gvGround2.SelectedIndex = -1
        'gvGround3.SelectedIndex = -1
        'gvGround4.SelectedIndex = -1
    End Sub

    Protected Sub gvRack14SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack14SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack14SlotsInA.SelectedValue
        gvRack14SlotsInB.SelectedIndex = -1
        gvRack14SlotsInC.SelectedIndex = -1
    End Sub

    Protected Sub gvRack14SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack14SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack14SlotsInB.SelectedValue
        gvRack14SlotsInA.SelectedIndex = -1
        gvRack14SlotsInC.SelectedIndex = -1

    End Sub

    Protected Sub gvRack14SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack14SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack14SlotsInC.SelectedValue

        gvRack14SlotsInA.SelectedIndex = -1
        gvRack14SlotsInB.SelectedIndex = -1

    End Sub


    Protected Sub gvRack15SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack15SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack15SlotsInA.SelectedValue
        gvRack15SlotsInB.SelectedIndex = -1
        gvRack15SlotsInC.SelectedIndex = -1
    End Sub

    Protected Sub gvRack15SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack15SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack15SlotsInB.SelectedValue
        gvRack15SlotsInA.SelectedIndex = -1
        gvRack15SlotsInC.SelectedIndex = -1

    End Sub

    Protected Sub gvRack15SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack15SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack15SlotsInC.SelectedValue

        gvRack15SlotsInA.SelectedIndex = -1
        gvRack15SlotsInB.SelectedIndex = -1

    End Sub

    Protected Sub gvRack16SlotsinA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack16SlotsInA.SelectedIndexChanged

        lblLocSet.Text = gvRack16SlotsInA.SelectedValue
        gvRack16SlotsInB.SelectedIndex = -1
        gvRack16SlotsInC.SelectedIndex = -1
    End Sub

    Protected Sub gvRack16SlotsinB_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack16SlotsInB.SelectedIndexChanged

        lblLocSet.Text = gvRack16SlotsInB.SelectedValue
        gvRack16SlotsInA.SelectedIndex = -1
        gvRack16SlotsInC.SelectedIndex = -1

    End Sub

    Protected Sub gvRack16SlotsinC_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvRack16SlotsInC.SelectedIndexChanged

        lblLocSet.Text = gvRack16SlotsInC.SelectedValue

        gvRack16SlotsInA.SelectedIndex = -1
        gvRack16SlotsInB.SelectedIndex = -1

    End Sub




    Protected Sub gvGround1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround1.SelectedIndexChanged

        lblLocSet.Text = gvGround1.SelectedValue

    End Sub

    Protected Sub gvGround2_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround2.SelectedIndexChanged

        lblLocSet.Text = gvGround2.SelectedValue

    End Sub

    Protected Sub gvGround3_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround3.SelectedIndexChanged

        lblLocSet.Text = gvGround3.SelectedValue


    End Sub

    Protected Sub gvGround4_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround4.SelectedIndexChanged

        lblLocSet.Text = gvGround4.SelectedValue


    End Sub

    Protected Sub gvGround5_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround5.SelectedIndexChanged

        lblLocSet.Text = gvGround5.SelectedValue


    End Sub

    Protected Sub gvGround6_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround6.SelectedIndexChanged

        lblLocSet.Text = gvGround6.SelectedValue

    End Sub

    Protected Sub gvGround7_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround7.SelectedIndexChanged

        lblLocSet.Text = gvGround7.SelectedValue

    End Sub
    Protected Sub gvGround8_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvGround8.SelectedIndexChanged

        lblLocSet.Text = gvGround8.SelectedValue


    End Sub

    Protected Sub gvResults_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvResults.RowCommand
        If e.CommandName = "clearloc" Then

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand

            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim SlotKey As String = gvResults.Rows(ID).Cells(5).Text 'find the slotkey in that row to use in the clear command

            'Dim Line() As String = Selected.Split(",")
            'Dim SlotKey As String = Line(1)
            'Dim RackRow As String = Line(2)

            Dim RacKRow As String = "1A"
            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE Yard_Master_Locations SET Filled = 0, ProdNo = NULL, DateIn = NULL where SlotKey =  '" & SlotKey & "'"
            cmd.Connection = conn

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            gvIncomplete.DataBind()
            gvResults.DataBind()

            If SlotKey Like "1A*" Then
                gvRack1SlotsinA.DataBind()
            ElseIf SlotKey Like "1B*" Then
                gvRack1SlotsinB.DataBind()
            ElseIf SlotKey Like "1C*" Then
                gvRack1SlotsinC.DataBind()
            ElseIf SlotKey Like "2A*" Then
                gvRack2SlotsInA.DataBind()
            ElseIf SlotKey Like "2B*" Then
                gvRack2SlotsInB.DataBind()
            ElseIf SlotKey Like "2C*" Then
                gvRack2SlotsInC.DataBind()
            ElseIf SlotKey Like "3A*" Then
                gvRack3SlotsInA.DataBind()
            ElseIf SlotKey Like "3B*" Then
                gvRack3SlotsInB.DataBind()
            ElseIf SlotKey Like "3C*" Then
                gvRack3SlotsInC.DataBind()
            ElseIf SlotKey Like "4A*" Then
                gvRack4SlotsInA.DataBind()
            ElseIf SlotKey Like "4B*" Then
                gvRack4SlotsInB.DataBind()
            ElseIf SlotKey Like "4C*" Then
                gvRack4SlotsInC.DataBind()
            ElseIf SlotKey Like "5A*" Then
                gvRack5SlotsInA.DataBind()
            ElseIf SlotKey Like "5B*" Then
                gvRack5SlotsInB.DataBind()
            ElseIf SlotKey Like "5C*" Then
                gvRack5SlotsInC.DataBind()
            ElseIf SlotKey Like "6A*" Then
                gvRack6SlotsInA.DataBind()
            ElseIf SlotKey Like "6B*" Then
                gvRack6SlotsInB.DataBind()
            ElseIf SlotKey Like "6C*" Then
                gvRack6SlotsInC.DataBind()
            ElseIf SlotKey Like "7A*" Then
                gvRack7SlotsInA.DataBind()
            ElseIf SlotKey Like "7B*" Then
                gvRack7SlotsInB.DataBind()
            ElseIf SlotKey Like "7C*" Then
                gvRack7SlotsInC.DataBind()
            ElseIf SlotKey Like "8A*" Then
                gvRack8SlotsInA.DataBind()
            ElseIf SlotKey Like "8B*" Then
                gvRack8SlotsInB.DataBind()
            ElseIf SlotKey Like "8C*" Then
                gvRack8SlotsInC.DataBind()
            ElseIf SlotKey Like "9A*" Then
                gvRack9SlotsInA.DataBind()
            ElseIf SlotKey Like "9B*" Then
                gvRack9SlotsInB.DataBind()
            ElseIf SlotKey Like "9C*" Then
                gvRack9SlotsInC.DataBind()
            ElseIf SlotKey Like "10A*" Then
                gvRack10SlotsInA.DataBind()
            ElseIf SlotKey Like "10B*" Then
                gvRack10SlotsInB.DataBind()
            ElseIf SlotKey Like "10C*" Then
                gvRack10SlotsInC.DataBind()
            ElseIf SlotKey Like "11A*" Then
                gvRack11SlotsInA.DataBind()
            ElseIf SlotKey Like "11B*" Then
                gvRack11SlotsInB.DataBind()
            ElseIf SlotKey Like "11C*" Then
                gvRack11SlotsInC.DataBind()
            ElseIf SlotKey Like "12A*" Then
                gvRack12SlotsInA.DataBind()
            ElseIf SlotKey Like "12B*" Then
                gvRack12SlotsInB.DataBind()
            ElseIf SlotKey Like "12C*" Then
                gvRack12SlotsInC.DataBind()
            ElseIf SlotKey Like "13A*" Then
                gvRack13SlotsInA.DataBind()
            ElseIf SlotKey Like "13B*" Then
                gvRack13SlotsInB.DataBind()
            ElseIf SlotKey Like "13C*" Then
                gvRack13SlotsInC.DataBind()


            ElseIf SlotKey Like "14A*" Then
                gvRack14SlotsInA.DataBind()
            ElseIf SlotKey Like "14B*" Then
                gvRack14SlotsInB.DataBind()
            ElseIf SlotKey Like "14C*" Then
                gvRack14SlotsInC.DataBind()


            ElseIf SlotKey Like "15A*" Then
                gvRack15SlotsInA.DataBind()
            ElseIf SlotKey Like "15B*" Then
                gvRack15SlotsInB.DataBind()
            ElseIf SlotKey Like "15C*" Then
                gvRack15SlotsInC.DataBind()

            ElseIf SlotKey Like "16A*" Then
                gvRack16SlotsInA.DataBind()
            ElseIf SlotKey Like "16B*" Then
                gvRack16SlotsInB.DataBind()
            ElseIf SlotKey Like "16C*" Then
                gvRack16SlotsInC.DataBind()


            ElseIf SlotKey Like "100G*" Then
                gvGround1.DataBind()
            ElseIf SlotKey Like "200G*" Then
                gvGround2.DataBind()
            ElseIf SlotKey Like "300G*" Then
                gvGround3.DataBind()
            ElseIf SlotKey Like "400G*" Then
                gvGround4.DataBind()
            ElseIf SlotKey Like "500G*" Then
                gvGround5.DataBind()
            ElseIf SlotKey Like "600G*" Then
                gvGround6.DataBind()
            ElseIf SlotKey Like "700G*" Then
                gvGround7.DataBind()
            ElseIf SlotKey Like "800G*" Then
                gvGround8.DataBind()
            End If

            btnSave.Visible = True
        End If


    End Sub

    Protected Sub gvResults_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvResults.SelectedIndexChanged

        lblProdSet.Text = gvResults.SelectedValue
        gvIncomplete.SelectedIndex = -1

        Dim loc As String = gvResults.SelectedRow.Cells(5).Text

        If loc Like "&*" Then
            btnSave.Visible = True
        Else
            btnSave.Visible = False

            If loc Like "100*" Then
                Ground1_Click()
            ElseIf loc Like "200*" Then
                Ground2_Click()
            ElseIf loc Like "300*" Then
                Ground3_Click()
            ElseIf loc Like "400*" Then
                Ground4_Click()
            ElseIf loc Like "500*" Then
                Ground5_Click()
            ElseIf loc Like "600*" Then
                Ground6_Click()
            ElseIf loc Like "700*" Then
                Ground7_Click()
            ElseIf loc Like "800*" Then
                Ground8_Click()
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
            ElseIf loc Like "9*" Then
                Rack9_Click()
            ElseIf loc Like "10*" Then
                Rack10_Click()
            ElseIf loc Like "11*" Then
                Rack11_Click()
            ElseIf loc Like "12*" Then
                Rack12_Click()
            ElseIf loc Like "13*" Then
                Rack13_Click()
            ElseIf loc Like "14*" Then
                Rack14_Click()
            ElseIf loc Like "15*" Then
                Rack15_Click()
            ElseIf loc Like "16*" Then
                Rack16_Click()


            End If
        End If

    End Sub

    Protected Sub gvIncomplete_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvIncomplete.SelectedIndexChanged

        lblProdSet.Text = gvIncomplete.SelectedValue
        gvResults.SelectedIndex = -1
        'gvIncomplete.SelectedIndex = -1

        Dim loc As String = gvIncomplete.SelectedRow.Cells(5).Text

        If loc Like "&*" Then
            btnSave.Visible = True
        Else
            btnSave.Visible = False

            If loc Like "100*" Then
                Ground1_Click()
            ElseIf loc Like "200*" Then
                Ground2_Click()
            ElseIf loc Like "300*" Then
                Ground3_Click()
            ElseIf loc Like "400*" Then
                Ground4_Click()
            ElseIf loc Like "500*" Then
                Ground5_Click()
            ElseIf loc Like "600*" Then
                Ground6_Click()
            ElseIf loc Like "700*" Then
                Ground7_Click()
            ElseIf loc Like "800*" Then
                Ground8_Click()
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
            ElseIf loc Like "9*" Then
                Rack9_Click()
            ElseIf loc Like "10*" Then
                Rack10_Click()
            ElseIf loc Like "11*" Then
                Rack11_Click()
            ElseIf loc Like "12*" Then
                Rack12_Click()
            ElseIf loc Like "13*" Then
                Rack13_Click()
            ElseIf loc Like "14*" Then
                Rack14_Click()
            ElseIf loc Like "15*" Then
                Rack15_Click()
            ElseIf loc Like "16*" Then
                Rack16_Click()
            End If
        End If
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

            If lblLocSet.Text Like "100G*" Then
                gvGround1.DataBind()
            ElseIf lblLocSet.Text Like "200G*" Then
                gvGround2.DataBind()
            ElseIf lblLoc.Text Like "300G*" Then
                gvGround3.DataBind()
            ElseIf lblLocSet.Text Like "400G*" Then
                gvGround4.DataBind()
            ElseIf lblLocSet.Text Like "500G*" Then
                gvGround5.DataBind()
            ElseIf lblLocSet.Text Like "600G*" Then
                gvGround6.DataBind()
            ElseIf lblLocSet.Text Like "700G*" Then
                gvGround7.DataBind()
            ElseIf lblLocSet.Text Like "800G*" Then
                gvGround8.DataBind()
            ElseIf lblLocSet.Text Like "1A*" Then
                gvRack1SlotsinA.DataBind()
            ElseIf lblLocSet.Text Like "1B*" Then
                gvRack1SlotsinB.DataBind()
            ElseIf lblLocSet.Text Like "1C*" Then
                gvRack1SlotsinC.DataBind()
            ElseIf lblLocSet.Text Like "2A*" Then
                gvRack2SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "2B*" Then
                gvRack2SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "2C*" Then
                gvRack2SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "3A*" Then
                gvRack3SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "3B*" Then
                gvRack3SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "3C*" Then
                gvRack3SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "4A*" Then
                gvRack4SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "4B*" Then
                gvRack4SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "4C*" Then
                gvRack4SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "5A*" Then
                gvRack5SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "5B*" Then
                gvRack5SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "5C*" Then
                gvRack5SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "6A*" Then
                gvRack6SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "6B*" Then
                gvRack6SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "6C*" Then
                gvRack6SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "7A*" Then
                gvRack7SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "7B*" Then
                gvRack7SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "7C*" Then
                gvRack7SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "8A*" Then
                gvRack8SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "8B*" Then
                gvRack8SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "8C*" Then
                gvRack8SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "9A*" Then
                gvRack9SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "9B*" Then
                gvRack9SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "9C*" Then
                gvRack9SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "10A*" Then
                gvRack10SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "10B*" Then
                gvRack10SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "10C*" Then
                gvRack10SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "11A*" Then
                gvRack11SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "11B*" Then
                gvRack11SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "11C*" Then
                gvRack11SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "12A*" Then
                gvRack12SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "12B*" Then
                gvRack12SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "12C*" Then
                gvRack12SlotsInC.DataBind()
            ElseIf lblLocSet.Text Like "13A*" Then
                gvRack13SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "13B*" Then
                gvRack13SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "13C*" Then
                gvRack13SlotsInC.DataBind()


            ElseIf lblLocSet.Text Like "14A*" Then
                gvRack14SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "14B*" Then
                gvRack14SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "14C*" Then
                gvRack14SlotsInC.DataBind()


            ElseIf lblLocSet.Text Like "15A*" Then
                gvRack15SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "15B*" Then
                gvRack15SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "15C*" Then
                gvRack15SlotsInC.DataBind()

            ElseIf lblLocSet.Text Like "16A*" Then
                gvRack16SlotsInA.DataBind()
            ElseIf lblLocSet.Text Like "16B*" Then
                gvRack16SlotsInB.DataBind()
            ElseIf lblLocSet.Text Like "16C*" Then
                gvRack16SlotsInC.DataBind()

            End If

            gvIncomplete.DataBind()
            gvResults.DataBind()

            gvIncomplete.SelectedIndex = -1
            gvResults.SelectedIndex = -1

            lblProdSet.Text = ""
            lblLocSet.Text = ""

        End If



    End Sub

    Protected Sub btnClearSearch_Click(sender As Object, e As EventArgs) Handles btnClearSearch.Click
        tbSearchProdNo.Text = ""
        lblLocSet.Text = ""
        lblProdSet.Text = ""
        gvResults.SelectedIndex = -1
    End Sub

    Protected Sub gvTubeDamage_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvTubeDamage.RowCommand
        If e.CommandName = "clearloc" Then

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand

            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim SlotKey As String = gvTubeDamage.Rows(ID).Cells(5).Text 'find the slotkey in that row to use in the clear command

            'Dim Line() As String = Selected.Split(",")
            'Dim SlotKey As String = Line(1)
            'Dim RackRow As String = Line(2)

            Dim RacKRow As String = "1A"
            conn.ConnectionString = connstr

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE Yard_Master_Locations SET Filled = 0, ProdNo = NULL, DateIn = NULL where SlotKey =  '" & SlotKey & "'"
            cmd.Connection = conn

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            gvIncomplete.DataBind()
            gvTubeDamage.DataBind()
            gvResults.DataBind()

            If SlotKey Like "1A*" Then
                gvRack1SlotsinA.DataBind()
            ElseIf SlotKey Like "1B*" Then
                gvRack1SlotsinB.DataBind()
            ElseIf SlotKey Like "1C*" Then
                gvRack1SlotsinC.DataBind()
            ElseIf SlotKey Like "2A*" Then
                gvRack2SlotsInA.DataBind()
            ElseIf SlotKey Like "2B*" Then
                gvRack2SlotsInB.DataBind()
            ElseIf SlotKey Like "2C*" Then
                gvRack2SlotsInC.DataBind()
            ElseIf SlotKey Like "3A*" Then
                gvRack3SlotsInA.DataBind()
            ElseIf SlotKey Like "3B*" Then
                gvRack3SlotsInB.DataBind()
            ElseIf SlotKey Like "3C*" Then
                gvRack3SlotsInC.DataBind()
            ElseIf SlotKey Like "4A*" Then
                gvRack4SlotsInA.DataBind()
            ElseIf SlotKey Like "4B*" Then
                gvRack4SlotsInB.DataBind()
            ElseIf SlotKey Like "4C*" Then
                gvRack4SlotsInC.DataBind()
            ElseIf SlotKey Like "5A*" Then
                gvRack5SlotsInA.DataBind()
            ElseIf SlotKey Like "5B*" Then
                gvRack5SlotsInB.DataBind()
            ElseIf SlotKey Like "5C*" Then
                gvRack5SlotsInC.DataBind()
            ElseIf SlotKey Like "6A*" Then
                gvRack6SlotsInA.DataBind()
            ElseIf SlotKey Like "6B*" Then
                gvRack6SlotsInB.DataBind()
            ElseIf SlotKey Like "6C*" Then
                gvRack6SlotsInC.DataBind()
            ElseIf SlotKey Like "7A*" Then
                gvRack7SlotsInA.DataBind()
            ElseIf SlotKey Like "7B*" Then
                gvRack7SlotsInB.DataBind()
            ElseIf SlotKey Like "7C*" Then
                gvRack7SlotsInC.DataBind()
            ElseIf SlotKey Like "8A*" Then
                gvRack8SlotsInA.DataBind()
            ElseIf SlotKey Like "8B*" Then
                gvRack8SlotsInB.DataBind()
            ElseIf SlotKey Like "8C*" Then
                gvRack8SlotsInC.DataBind()
            ElseIf SlotKey Like "9A*" Then
                gvRack9SlotsInA.DataBind()
            ElseIf SlotKey Like "9B*" Then
                gvRack9SlotsInB.DataBind()
            ElseIf SlotKey Like "9C*" Then
                gvRack9SlotsInC.DataBind()
            ElseIf SlotKey Like "10A*" Then
                gvRack10SlotsInA.DataBind()
            ElseIf SlotKey Like "10B*" Then
                gvRack10SlotsInB.DataBind()
            ElseIf SlotKey Like "10C*" Then
                gvRack10SlotsInC.DataBind()
            ElseIf SlotKey Like "11A*" Then
                gvRack11SlotsInA.DataBind()
            ElseIf SlotKey Like "11B*" Then
                gvRack11SlotsInB.DataBind()
            ElseIf SlotKey Like "11C*" Then
                gvRack11SlotsInC.DataBind()
            ElseIf SlotKey Like "12A*" Then
                gvRack12SlotsInA.DataBind()
            ElseIf SlotKey Like "12B*" Then
                gvRack12SlotsInB.DataBind()
            ElseIf SlotKey Like "12C*" Then
                gvRack12SlotsInC.DataBind()
            ElseIf SlotKey Like "13A*" Then
                gvRack13SlotsInA.DataBind()
            ElseIf SlotKey Like "13B*" Then
                gvRack13SlotsInB.DataBind()
            ElseIf SlotKey Like "13C*" Then
                gvRack13SlotsInC.DataBind()


            ElseIf SlotKey Like "14A*" Then
                gvRack14SlotsInA.DataBind()
            ElseIf SlotKey Like "14B*" Then
                gvRack14SlotsInB.DataBind()
            ElseIf SlotKey Like "14C*" Then
                gvRack14SlotsInC.DataBind()

            ElseIf SlotKey Like "15A*" Then
                gvRack15SlotsInA.DataBind()
            ElseIf SlotKey Like "15B*" Then
                gvRack15SlotsInB.DataBind()
            ElseIf SlotKey Like "15C*" Then
                gvRack15SlotsInC.DataBind()

            ElseIf SlotKey Like "16A*" Then
                gvRack16SlotsInA.DataBind()
            ElseIf SlotKey Like "16B*" Then
                gvRack16SlotsInB.DataBind()
            ElseIf SlotKey Like "16C*" Then
                gvRack16SlotsInC.DataBind()

            ElseIf SlotKey Like "100G*" Then
                gvGround1.DataBind()
            ElseIf SlotKey Like "200G*" Then
                gvGround2.DataBind()
            ElseIf SlotKey Like "300G*" Then
                gvGround3.DataBind()
            ElseIf SlotKey Like "400G*" Then
                gvGround4.DataBind()
            ElseIf SlotKey Like "500G*" Then
                gvGround5.DataBind()
            ElseIf SlotKey Like "600G*" Then
                gvGround6.DataBind()
            ElseIf SlotKey Like "700G*" Then
                gvGround7.DataBind()
            ElseIf SlotKey Like "800G*" Then
                gvGround8.DataBind()
            End If

            btnSave.Visible = True
        End If


    End Sub

    Private Sub gvTranspoM_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvTranspoM.RowCommand
        If e.CommandName = "clearlocandreq" Then

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            Dim cmd1 As New SqlCommand

            Dim ID As String = e.CommandArgument 'get the row that is clicked
            Dim SlotKey As String = gvTranspoM.Rows(ID).Cells(4).Text 'find the slotkey in that row to use in the clear command
            Dim AutoID As Int16 = gvTranspoM.Rows(ID).Cells(1).Text

            conn.ConnectionString = connstr

            cmd1.Parameters.AddWithValue("@Today", Date.Now)
            cmd1.Parameters.AddWithValue("@AutoID", AutoID)

            cmd.CommandText = "UPDATE Yard_Master_Locations SET Filled = 0, ProdNo = NULL, DateIn = NULL where SlotKey =  '" & SlotKey & "'"
            cmd1.CommandText = "UPDATE TransportReqs SET Status = 2, DateCleared = @Today where AutoID = @AutoID"

            cmd.Connection = conn
            cmd1.Connection = conn

            conn.Open()

            If SlotKey.Length > 0 Then
                Try
                    cmd.ExecuteNonQuery()
                Catch
                End Try
            End If

            cmd1.ExecuteNonQuery()

            conn.Close()

                gvTranspoM.DataBind()
            End If

    End Sub


    Protected Sub btnTaken_Click(sender As Object, e As EventArgs) Handles btnTaken.Click
        gvTranspoM.DataBind()
    End Sub

    Private Sub gvResults_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvResults.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem("ActionRequired").ToString = "" Then

            ElseIf e.Row.DataItem("ActionRequired").ToString = "REPAIR" Or e.Row.DataItem("ActionRequired").ToString = "REPLACE" Then
                e.Row.Cells(7).BackColor = System.Drawing.Color.Red
            End If
        End If
    End Sub
End Class


