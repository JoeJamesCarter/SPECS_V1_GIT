Imports System.Data
Imports System.Data.SqlClient

Partial Class FurnitureLocationEdit
    Inherits System.Web.UI.Page


    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    'Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

    'Rack1.DataBind()
    'Rack2.DataBind()
    'Rack3.DataBind()
    'Rack4.DataBind()
    'Rack5.DataBind()
    'Rack6.DataBind()

    ' End Sub



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
      

    End Sub

    Protected Sub Rack1_ItemCommand(source As Object, e As DataListCommandEventArgs) Handles Rack1.ItemCommand
        If e.CommandName = "ClearLoc" Then
            Dim ID As String = e.CommandArgument 'get the LocKey that is clicked
            Dim TBID = DirectCast(e.Item.FindControl("TextBox1"), TextBox)
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.CommandText = "Update Material_Locations Set InUse ='0', ProdNo = Null, DateIn = Null where LocKey = '" & ID & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            Rack1.DataBind()
            'Rack2.DataBind()
            'Rack3.DataBind()
            'Rack4.DataBind()
            'Rack5.DataBind()
            'Rack6.DataBind()
            TBID.Focus()
        End If

        If e.CommandName = "AddLoc" Then
            Dim ProdNoToSet = DirectCast(e.Item.FindControl("TextBox1"), TextBox).Text
            Dim TBID = DirectCast(e.Item.FindControl("TextBox1"), TextBox)
            Dim ID As String = e.CommandArgument 'get the LocKey that is clicked
            Dim TodaysDate As Date = Date.Now

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.CommandText = "Update Material_Locations Set InUse ='1', ProdNo = '" & ProdNoToSet & "', DateIn = '" & TodaysDate & "' where LocKey = '" & ID & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            'tbCurrentTbID.Text = Mid(TBID.ClientID, 16)
            'tbCurrentTbID.Text = convert.toInt32(tbCurrentTbID.Text) + 1

            'Dim nextboxname As String = "Rack1_Textbox1_" + tbCurrentTbID.Text
            'tbCurrentTbID.Text = nextboxname
            'Dim nextbox As TextBox = DirectCast(e.Item.FindControl(nextboxname), TextBox)
            TBID.Focus()

            'Rack1.DataBind()
            'Rack2.DataBind()
            'Rack3.DataBind()
            'Rack4.DataBind()
            'Rack5.DataBind()
            'Rack6.DataBind()

        End If

    End Sub

   


    Protected Sub Rack1_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles Rack1.ItemDataBound
        If e.Item.DataItem("Usable") = 0 Then
            e.Item.BackColor = Drawing.Color.Black
        End If
    End Sub

    

End Class
