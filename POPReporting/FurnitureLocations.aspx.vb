Imports System.Data
Imports System.Data.SqlClient

Partial Class FurnitureLocations
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

    Protected Sub Rack1_ItemCommand(source As Object, e As DataListCommandEventArgs) Handles Rack1.ItemCommand, Rack2.ItemCommand, Rack3.ItemCommand, Rack4.ItemCommand, Rack5.ItemCommand, Rack6.ItemCommand, Rack7.ItemCommand, Rack10.ItemCommand, Rack11.ItemCommand, Rack12.ItemCommand, Rack13.ItemCommand, Rack14.ItemCommand, Rack15.ItemCommand, Rack16.ItemCommand, Rack17.ItemCommand, Rack18.ItemCommand

        If e.CommandName = "ClearLoc" Then
            Dim ID As String = e.CommandArgument 'get the LocKey that is clicked
            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn
            cmd.CommandText = "Update Material_Locations Set InUse ='0', ProdNo = Null, DateIn = Null, Rear = 0 where LocKey = '" & ID & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            Rack1.DataBind()
            Rack2.DataBind()
            Rack3.DataBind()
            Rack4.DataBind()
            Rack5.DataBind()
            Rack6.DataBind()
            Rack7.DataBind()
            'Rack8.DataBind()
            'Rack9.DataBind()
            Rack10.DataBind()
            Rack11.DataBind()

        End If

        If e.CommandName = "AddLoc" Then
            Dim ProdNoToSet = DirectCast(e.Item.FindControl("TextBox1"), TextBox).Text
            Dim ID As String = e.CommandArgument 'get the LocKey that is clicked
            Dim RearCb As Boolean = DirectCast(e.Item.FindControl("cbRear"), CheckBox).Checked
            Dim TodaysDate As Date = Date.Now
            Dim rear As Integer = 0
            Dim rearLetter As String = ""

            If RearCb Then
                rear = 1
                rearLetter = "R"
            End If

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.Parameters.AddWithValue("@ProdNoToSet", ProdNoToSet)
            cmd.Parameters.AddWithValue("@TodaysDate", TodaysDate)
            cmd.Parameters.AddWithValue("@rear", rear)
            cmd.Parameters.AddWithValue("@ID", ID)

            'cmd.CommandText = "Update Material_Locations Set InUse ='1', ProdNo = '" & ProdNoToSet & "', DateIn = '" & TodaysDate & "', Rear = '" & rear & "' where LocKey = '" & ID & "'"
            cmd.CommandText = "Update Material_Locations Set InUse ='1', ProdNo = @ProdNoToSet, DateIn = @TodaysDate, Rear = @rear where LocKey = @ID"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            Rack1.DataBind()
            Rack2.DataBind()
            Rack3.DataBind()
            Rack4.DataBind()
            Rack5.DataBind()
            Rack6.DataBind()
            Rack7.DataBind()
            'Rack8.DataBind()
            'Rack9.DataBind()
            Rack10.DataBind()

            'Split the LocKey into number and letter

            Dim rack As String = ID.Substring(0, ID.Length - 1)
            Dim slot As String = ID(ID.Length - 1)


            'Print Label

            Dim ipAddress As String = "10.5.110.33"
            Dim port As Integer = 9100

            'Keri's 2x1 Printer format
            'Dim ZPLString2x1 As String =
            '     "CT~~CD,~CC^~CT~" &
            '     "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" &
            '     "^XA" &
            '     "^MMT" &
            '     "^PW406" &
            '     "^LL0203" &
            '     "^LS0" &
            '     "^FT59,87^A0N,45,45^FH\^FD" & ProdNoToSet & "^FS" &
            '     "^FT205,132^A0N,34,33^FH\^FD" & ID & "^FS" &
            '     "^PQ1,0,1,Y^XZ"


            'Dim ZPLString As String = _
            '    "CT~~CD,~CC^~CT~" & _
            '   "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
            '  "^XA" & _
            '  "^MMT" & _
            '  "^PW406" & _
            '  "^LL0203" & _
            '  "^LS0" & _
            '  "^FT59,87^A0N,45,45^FH\^FD" & ProdNoToSet & "^FS" & _
            '  "^FT205,132^A0N,34,33^FH\^FD" & ID & "^FS" & _
            '  "^PQ1,0,1,Y^XZ"

            Dim ZPLString As String =
                "^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD10^JUS^LRN^CI0^XZ" &
                "^XA" &
                "^MMT" &
                "^PW863" &
                "^LL1208" &
                "^LS0" &
                "^FT530,78^A0R,259,256^FH\^FD8000^FS" &
                "^FT550,868^A0R,231,228^FH\^FD28^FS" &
                "^FT308,308^A0R,197,194^FH\^FDR^FS" &
                "^FT298,921^A0R,230,228^FH\^FDA^FS" &
                "^FO72,727^GB791,0,8^FS" &
                "^PQ1,0,1,Y^XZ"



            'Try

            'Dim client As New System.Net.Sockets.TcpClient
            'client.Connect(ipAddress, port)

            'Write ZPL String to Connection
            'Dim writer As New System.IO.StreamWriter(client.GetStream())
            'writer.Write(ZPLString)
            'writer.Flush()

            'writer.Close()
            'client.Close()

            'Catch ex As Exception


            'End Try

        End If

    End Sub


    Protected Sub Rack1_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles Rack1.ItemDataBound, Rack2.ItemDataBound, Rack3.ItemDataBound, Rack4.ItemDataBound, Rack5.ItemDataBound, Rack6.ItemDataBound, Rack7.ItemDataBound, Rack10.ItemDataBound, Rack11.ItemDataBound, Rack12.ItemDataBound, Rack13.ItemDataBound, Rack14.ItemDataBound, Rack15.ItemDataBound, Rack16.ItemDataBound, Rack17.ItemDataBound, Rack18.ItemDataBound
        If e.Item.DataItem("Usable") = 0 Then
            e.Item.BackColor = Drawing.Color.Black
        ElseIf e.Item.DataItem("InUse") = 0 And e.Item.DataItem("Usable") = 1 Then
            e.Item.BackColor = Drawing.Color.LightGreen
        End If

    End Sub

    Protected Sub Button6_Click(sender As Object, e As EventArgs) Handles Button6.Click
        Rack1.DataBind()
        Rack2.DataBind()
        Rack3.DataBind()
        Rack4.DataBind()
        Rack5.DataBind()
        Rack6.DataBind()
        Rack7.DataBind()
        'Rack8.DataBind()
        'Rack9.DataBind()
        Rack10.DataBind()
        Rack11.DataBind()
        Rack12.DataBind()
        Rack13.DataBind()
        Rack14.DataBind()
        Rack15.DataBind()
        Rack16.DataBind()
        Rack17.DataBind()
        Rack18.DataBind()
    End Sub
End Class
