Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls

Partial Class Tubes_ReprintTubeLabels
    Inherits System.Web.UI.Page

    Public buildinst As New DataTable
    Public buildinstctr As New DataTable
    Public buildinstcs As New DataTable

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click

        Dim tubelist As RadioButtonList = rblTube
        Dim tube As String = tubelist.SelectedValue
        Dim tubetype As String = ddlTubeType.SelectedValue
        Dim sectionlist = New ArrayList()

        For Each li As ListItem In cblSections.Items

            If li.Selected = True And li.Value = "F" Then

                If tube = "Port" Then
                    sectionlist.Add("PF")
                ElseIf tube = "Strb" Then
                    sectionlist.Add("SF")
                ElseIf tube = "Ctr" Then
                    sectionlist.Add("CF")
                End If

            End If

            If li.Selected = True And li.Value = "M" Then

                If tube = "Port" Then
                    sectionlist.Add("PM")
                ElseIf tube = "Strb" Then
                    sectionlist.Add("SM")
                ElseIf tube = "Ctr" Then
                    sectionlist.Add("CM")
                End If

            End If

            If li.Selected = True And li.Value = "M2" Then

                If tube = "Port" Then
                    sectionlist.Add("PM2")
                ElseIf tube = "Strb" Then
                    sectionlist.Add("SM2")
                ElseIf tube = "Ctr" Then
                    sectionlist.Add("CM2")
                End If

            End If

            If li.Selected = True And li.Value = "R" Then

                If tube = "Port" Then
                    sectionlist.Add("PR")
                ElseIf tube = "Strb" Then
                    sectionlist.Add("SR")
                ElseIf tube = "Ctr" Then
                    sectionlist.Add("CR")
                End If

            End If

        Next

        If tubetype = "prod" Then
            If Len(tbProdNo.Text) = 7 Then
                PrintLabels(tbProdNo.Text, sectionlist.ToArray, tubetype)
            Else : MesgBox("Prod # needs to be 7 characters including the 2 digit year. Please try again.")
            End If
        Else
            PrintLabels(tbProdNo.Text, sectionlist.ToArray, tubetype)
        End If


    End Sub

    Protected Function PrintLabels(prod As String, sectionlist As Array, tubetype As String) As String 'normal production rerun and cs labels with barcode

        'Print Label

        Dim ipAddress As String = ddlPrinters.SelectedValue
        Dim port As Integer = 9100

        Dim prodfirst6 As String = Left(prod, Len(prod) - 1)
        Dim prodlast1 As String = Right(prod, 1)
        Dim ZPLString2x1 As String

        'Keri's 2x1 Printer format       

        For Each section As String In sectionlist
            If tubetype = "prod" Then
                ZPLString2x1 = _
                  "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                  "^XA" & _
                  "^MMT" & _
                  "^PW406" & _
                  "^LL0203" & _
                  "^LS0" & _
                  "^FO96,160^GFA,01536,01536,00024,:Z64:" & _
                  "eJztkTFKxEAUhl9IEYswsZziuXMD60HEXCVWtpMuhZBZtkiXXMCDWEZSpBG8wgsptlsDNhFlxzcrSDyBIPmLYfj4+OcnAVjztwmPfGwif3W05O6Hl9MvztYmATgDNy94sG0BFPsSqFj6ln1VAWggveRgkHnQlpBJFWkThaeK0E7OqpdmPgI9pjs3p92u4YcCm3f2ohcowU1530gzVLH0/tvO4l4IzftprDWNFd+5P9+2eIfxOZQ264XM8h7R+x/M3QM7I7lX9ueD+vTc+yUKCQO5fYxknr/5yP2p76eJQqHJHNDvD4YniyrmPZm57WNpsnv0e9wwMq+v2S/eu1oXVPg9gbMOMIlmBYRlFaNqi2g6ff8r5iEJoJtL7k+sDpc/Ys2af5svbfh7Og==:BB73" & _
                  "^BY3,3,114^FT41,169^BCN,,Y,Y" & _
                  "^FD>;" & prodfirst6 & ">6" & prodlast1 & "-" & section & "^FS" & _
                  "^PQ1,0,1,Y^XZ"

            ElseIf tubetype = "rerun" Then
                'tube rerun design
                ZPLString2x1 = _
                   "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                    "^XA" & _
                    "^MMT" & _
                    "^PW406" & _
                    "^LL0203" & _
                    "^LS0" & _
                    "^FO160,160^GFA,00768,00768,00012,:Z64:" & _
                    "eJztjjEKwzAMRV00aAnSmsGNzhHopbp3SPHgsVdKphyj9BYZgtyv9A4dSmU+PMzn8VP6nbPdmu1C9TQnc3VzoXKfkjVt1oTXZU6dSoQqOHNGPtyTRKi8pviLcL3OST0eOmD4/fCP4A3+Df0R/ZtEeD3DeZEIVQUP8A96cC/wizIx+qotKzdm7OGHd1ycKfY8W+ZlZ+z/33fuDU7XOqw=:5EE3" & _
                    "^BY2,3,121^FT13,164^BCN,,Y,Y" & _
                    "^FD>;" & _
                    prodfirst6 & _
                    ">" & _
                    "6" & _
                    prodlast1 & _
                    "-" & _
                    section & _
                    "-RERUN" & _
                    "^FS" & _
                    "^PQ1,0,1,Y^XZ"

            ElseIf tubetype = "custserv" Then
                ZPLString2x1 = _
                   "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                    "^XA" & _
                    "^MMT" & _
                    "^PW406" & _
                    "^LL0203" & _
                    "^LS0" & _
                    "^FO64,160^GFA,02048,02048,00032,:Z64:" & _
                    "eJztkTFu2zAYhX+CQLgU9JrBKK+QbCoSWPHUa2TLFlDoYiAGrEBDNusCOcxvOKiv8QteA1XeWFQw88im6B0SP0EQpI9P/3sk0UkfW06xdyoOjgbnRjeQoXiIc/5WL00Ej4/sV00cYh1m5bE8Uimxi3u+aqKJNanYgW9g6YbSjeCrAS8H/mFi8mvpOIhYLSHMplRYCkEUPv1p2xa/V/WcPYPXflxN6dzSrWfFlVRrZcB1jXxC4IvX+yL7Cf6F7NeUuCHwJZ0Zuny9m9LFV1oS/P52O6V/fmS3pi76PufL+WWAf4L82e/YGipe7tB/JDeAc7V5ppw/cS2J9305lkI6gNcPzTrz7Cef5v/8jvmeCPl3dNn8n/+bQ8r/q0f/BUkhaitX8E8yn3PF3mqudjv0vwZntRGn3vtLltUdEqP/jMIC/aVs2uYp7V+UKCs5wzlsd25E/7T/qKT/7j9FTissnvu1OxaT1P/AwekmtuhPLl9fcG+e3HhuyNyAX1v1fv4nnXTSZ9UbK9DoBQ==:2BC8" & _
                    "^BY2,3,122^FT49,163^BCN,,Y,Y" & _
                     "^FD>:" & _
                      prodfirst6 & _
                    ">" & _
                    "2" & _
                    prodlast1 & _
                    "-" & _
                    section & _
                    "-WRTY" & _
                    "^FS" & _
                    "^PQ1,0,1,Y^XZ"

            End If


            'Try

            Dim client As New System.Net.Sockets.TcpClient
            client.Connect(ipAddress, port)

            'Write ZPL String to Connection
            Dim writer As New System.IO.StreamWriter(client.GetStream())
            writer.Write(ZPLString2x1)
            writer.Flush()

            writer.Close()
            client.Close()
            'MesgBox(prodfirst6 & prodlast1 & "-" & section)
            'Catch ex As Exception


            'End Try
        Next
        'How to call
        'PrintLabels("1900001", 2, "Ctr")

    End Function

    Protected Function PrintBuildInstrLabels(prod As String, tube As String, tubetype As String) As String
        'data either comes from tube schedule if it is a prod or a rerun
        'This is for prod and rerun outers and centers only.
        'OutertubeDetails, CenterTubeDetails
        'Print Label

        Dim ipAddress As String = ddlPrinters.SelectedValue
        Dim port As Integer = 9100

        'Dim prodlast5 As String = Right(prod, 5)
        Dim ZPLString2x1 As String = ""

        'Build Schedule Labels
        If ((tubetype = "prod" Or tubetype = "rerun") And (tube = "PORT" Or tube = "STRB")) Then  '2x1 Printer format for Production Tubes and Reruns     

            Dim ShortProdNo As String = ""
            Dim Style As String = ""
            Dim Diameter As String = ""
            Dim Front As String = ""
            Dim TubeModel As String = ""
            Dim Ladder As String = ""
            Dim Bracket As String = ""
            Dim Keel As String = ""
            Dim Fuel As String = ""
            Dim Splash As String = ""
            Dim Strakes As String = ""
            Dim StrakesComments As String = ""
            Dim StrbTrans As String = ""
            Dim Comments As String = ""
            Dim OuterScheduled As String = ""
            Dim OuterScheduledOrder As String = ""
            Dim ItemNo As String = ""

            For Each row As DataRow In buildinst.Rows
                For Each column As DataColumn In buildinst.Columns
                    If column.ColumnName = "ShortProdNo" Then
                        ShortProdNo = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Style" Then
                        Style = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Diameter" Then
                        Diameter = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Front" Then
                        Front = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "TubeModel" Then
                        TubeModel = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Ladder" Then
                        Ladder = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Bracket" Then
                        Bracket = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Keel" Then
                        Keel = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Fuel" Then
                        Fuel = row(column.ColumnName).ToString()
                        If Fuel = "NO FUEL" Then
                            Fuel = "NO"
                        ElseIf Fuel = "CENTER" Then
                            Fuel = "Ctr"
                        End If
                    End If

                    If column.ColumnName = "Splash" Then
                        Splash = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Strakes" Then
                        Strakes = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "StrakesComments" Then
                        StrakesComments = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "StrbTrans" Then
                        StrbTrans = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Comments" Then
                        Comments = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "OuterScheduled" Then
                        OuterScheduled = row(column.ColumnName).ToString()
                        OuterScheduled = OuterScheduled.Substring(0, OuterScheduled.Length - 17)
                    End If

                    If column.ColumnName = "OuterScheduleOrder" Then
                        OuterScheduledOrder = row(column.ColumnName).ToString()
                        OuterScheduledOrder = OuterScheduledOrder + 1
                    End If

                    If column.ColumnName = "TubeModel" Then
                        TubeModel = row(column.ColumnName).ToString()
                    End If
                Next
            Next



            'Outer Tube 2x1 Label
            ZPLString2x1 = _
                "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                "^XA" & _
                "^MMT" & _
                "^PW406" & _
                "^LL0203" & _
                "^LS0" & _
                "^FO288,64^GFA,00768,00768,00012,:Z64:" & _
                "eJxjYBgFBAAf8/n//f9kwGwe9vb//P8hbD5+9v/9/+3AbDY5dgYeBqi4DR8DH5TNUwERLwCJ/2AHisuB2ewf2P/z/4OI8//gB7NBgH8OUPwPlL0PpB5iPh8fkvn8SOazI4kztwPdI/8PZCYb83GgO+X/gO1lfg90P4SNC9j/h4A/aOxhDwD/szcj:729E" & _
                "^FO0,64^GFA,00768,00768,00012,:Z64:" & _
                "eJztjrENwjAQRY0s+bq7NsUpt0JKF4isxAiewGyQWbIBKzBCSheRzTk2BQUVFRK/uaev7ycb88/3mZMktPcSKu+SHUBZK2cpkW4HD8iAoxnq3ivHs/GVJ8fgrnpaTzHpUZZdCm36rPkzpbZX5wZspu5JtLTeAzNi9wNfkLofWBy0/ZzVD6H79T+ntfvZRvs4+k8pr4R3/u08AaEGPGE=:389C" & _
                "^FO192,64^GFA,00512,00512,00008,:Z64:" & _
                "eJzdi7ENgDAMBL/CTURqJINXYANWYQQ62lSsxiawBeEdEAUTIL45nf8N/CySVSyTR13FnOhGT6hggp535wR6XDAGertiUu6bFb1Td+/lCBtG3+t87XW4/sniobt783/2sfxDxf0dyyUPP5ITcKojYA==:F0A4" & _
                "^FO96,64^GFA,00768,00768,00012,:Z64:" & _
                "eJxjYBgFBAD/Dz7mBzD2Hx72AzD2/z52mDgbOxt7AZTNx9zH9wHK5mE8w1YgAxM/x2chB1XPeEzGACEuY4FQLyMDN+ed/T8Ym/Gc/R+E+XBxHvaeAj6Eeyr4oeaz/2MrYJeBu/8B+xz8frT/DwKY7GEPAGZAJuA=:23AA" & _
                "^FT369,37^A0N,25,24^FH\^FD" & OuterScheduledOrder & "^FS" & _
                "^FT16,46^A0N,39,38^FH\^FD" & ShortProdNo & "^FS" & _
                "^FT257,107^A0N,28,28^FH\^FD" & Front & "^FS" & _
                "^FT310,75^A0N,28,28^FH\^FD" & Ladder & "^FS" & _
                "^FT92,108^A0N,28,28^FH\^FD" & Bracket & "^FS" & _
                "^FT16,142^A0N,28,28^FH\^FD" & Fuel & "^FS" & _
                "^FT385,107^A0N,28,28^FH\^FD" & Keel & "^FS" & _
                "^FT171,108^A0N,28,28^FH\^FD" & Diameter & "^FS" & _
                "^FT121,39^A0N,28,28^FH\^FD" & TubeModel & "^FS" & _
                "^FT15,77^A0N,28,28^FH\^FD" & Style & "^FS" & _
                "^FT135,141^A0N,28,28^FH\^FD" & StrbTrans & "^FS" & _
                "^FT181,172^A0N,28,28^FH\^FD" & StrakesComments & "^FS" & _
                "^FT22,196^A0N,20,21^FH\^FD" & Comments & "^FS" & _
                "^FT16,173^A0N,28,28^FH\^FD" & Strakes & "^FS" & _
                "^FT139,74^A0N,25,28^FH\^FD" & Splash & "^FS" & _
                "^FT321,36^A0N,17,16^FH\^FD" & OuterScheduled & "^FS" & _
                "^PQ1,0,1,Y^XZ"

        ElseIf (tubetype = "prod" Or tubetype = "rerun") And tube = "CTR" Then 'need to add section to the design
            'Center Tube xx1 Label
            Dim shortprodno As String = ""
            Dim Length As String = ""
            Dim Center As String = ""
            Dim Storage As String = ""
            Dim TenWide As String = ""
            Dim Bracket As String = ""
            Dim Fuel As String = ""
            Dim Strakes As String = ""
            Dim TubeUpg As String = ""
            Dim Upsweep_SldTrans As String = ""
            Dim CenterScheduled As String = ""
            Dim CenterScheduleOrder As String = ""
            Dim TubeModel As String = ""

            For Each row As DataRow In buildinstctr.Rows
                For Each column As DataColumn In buildinstctr.Columns
                    If column.ColumnName = "ShortProdNo" Then
                        shortprodno = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Length" Then
                        Length = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Center" Then
                        Center = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Storage" Then
                        Storage = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "TenWide" Then
                        TenWide = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Bracket" Then
                        Bracket = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "Fuel" Then
                        Fuel = row(column.ColumnName).ToString()
                        If Fuel = "NO FUEL" Then
                            Fuel = "NO"
                        End If
                    End If

                    If column.ColumnName = "Strakes" Then
                        Strakes = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "TubeUpg" Then
                        TubeUpg = row(column.ColumnName).ToString()
                        If TubeUpg = "" Then
                            TubeUpg = "NO"
                        End If
                    End If

                    If column.ColumnName = "Upsweep_SldTrans" Then
                        Upsweep_SldTrans = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "CenterScheduled" Then
                        CenterScheduled = row(column.ColumnName).ToString()
                        CenterScheduled = CenterScheduled.Substring(0, CenterScheduled.Length - 17)
                    End If

                    If column.ColumnName = "CenterScheduleOrder" Then
                        CenterScheduleOrder = row(column.ColumnName).ToString()
                    End If

                    If column.ColumnName = "TubeModel" Then
                        TubeModel = row(column.ColumnName).ToString()
                    End If
                Next
            Next

            ZPLString2x1 = _
                "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                "^XA" & _
                "^MMT" & _
                "^PW406" & _
                "^LL0203" & _
                "^LS0" & _
                "^FO0,64^GFA,00768,00768,00012,:Z64:" & _
                "eJztjzEKgDAMRSMdegkP4djBQzk6COZoOcoHD2DcFIQIWltxcNXBPz0e6YMS/Xt1hQnqfo0MtDZHVmj0JA3g+PDSDHIyVwM7RvQjedmZDGPyJpbuTRfOnQn+5HDpB2jqB7T5LTqX+qhzH6Vjffqjt33znT+wDXXfUXw=:7492" & _
                "^FO192,128^GFA,00640,00640,00020,:Z64:" & _
                "eJzNkDFqxDAQRWcQYZpF07oQ1jVcmN2TBJIbJH1ADinShJwg5Cyz7AX2AFvY7AXWnQrhiZCVQIpAihT5lfg8vv58gH+kq2NIJD7hBQKqFI/jbuHoF4igjzoWz6ewhOQVk9Gpeq4H6bYbxmiGaVjznEO5847wRLBf46ABHEbbGPNC+WUK6SVz5IjesyemkHwBGYkX82oB9VA4Spg9n4iZ5toPUs4jH8lanrR+3Ja8B1KiuWKdBbmxrmcluK1Y35Z+rddnuK+ca3Hoto215unrjryI7JJjZw4663ntF0E4bugNJe9yHtb9UOjo6IRy/dn5twr6TeNP3h/rA4cThNI=:C118" & _
                "^FO256,64^GFA,00768,00768,00012,:Z64:" & _
                "eJztjzEOwkAMBH26B+Q7VOErkfIBfpBFFJR8aa/iG3dKQUt5VcwpjlNQUCIK1s1otVrbIn99RRHzgiOMpSgnbn7RrHnlgJISn55vM3ieo8iw5TlDsufvYtzy+rjUvf8avacsN/eRGHHa+yMOtrdtDTQ/aKJotYP0TJlo3EdIj/zpx05X1Xf+Yb0AMC9PMQ==:BF51" & _
                "^FO96,64^GFA,00768,00768,00012,:Z64:" & _
                "eJztjbsNgDAMBY0YgFVcpssqGSEbOKMxykMs4DJd+MSKEJ8WUfDSnE7Whejf6/MZTjIqa2DR0HwxzwQXqbI7MFPgSKFL5kHo094ZnSi6ytj40t/utXXA9/0Y1775ktc3p917iJap/jskMf+0YsOJP7YFteJReA==:9AA5" & _
                "^FO256,32^GFA,00768,00768,00012,:Z64:" & _
                "eJxjYBgFFAPmBv5/cuwQNiMD/38YGyzODxVv4GGQh4vzMci3w9QDxdvZEOLn+6Dq+f/JHueDmyPzHG7+P5l0hDky/xHmy9QjidtD2UDzZeSh7P/9/2XkoeaD2Px8CHEoGxfg/w8GDejsIQ4AK4sqAA==:9285" & _
                "^FT369,37^A0N,25,24^FH\^FD" & CenterScheduleOrder & "^FS" & _
                "^FT16,40^A0N,33,38^FH\^FD" & shortprodno & "^FS" & _
                "^FT325,153^A0N,28,28^FH\^FD" & Storage & "^FS" & _
                "^FT72,113^A0N,28,28^FH\^FD" & Bracket & "^FS" & _
                "^FT172,114^A0N,28,28^FH\^FD" & Fuel & "^FS" & _
                "^FT116,40^A0N,28,28^FH\^FD" & TubeModel & "^FS" & _
                "^FT157,77^A0N,28,28^FH\^FD" & TenWide & "^FS" & _
                "^FT324,79^A0N,28,28^FH\^FD" & Length & "^FS" & _
                "^FT16,78^A0N,28,28^FH\^FD" & Center & "^FS" & _
                "^FT328,113^A0N,28,28^FH\^FD" & TubeUpg & "^FS" & _
                "^FT15,190^A0N,20,21^FH\^FD" & Upsweep_SldTrans & "^FS" & _
                "^FT13,156^A0N,28,28^FH\^FD" & Strakes & "^FS" & _
                "^FT321,36^A0N,17,16^FH\^FD" & CenterScheduled & "^FS" & _
                "^FT379,192^A0N,25,24^FH\^FDC^FS" & _
                "^PQ1,0,1,Y^XZ"
        End If


        Try

            Dim client As New System.Net.Sockets.TcpClient
            client.Connect(ipAddress, port)

            'Write ZPL String to Connection
            Dim writer As New System.IO.StreamWriter(client.GetStream())

            If tube = "PORT" Then 'print twice one for each rear tube
                writer.Write(ZPLString2x1)
                writer.Write(ZPLString2x1)
            Else 'CTR
                writer.Write(ZPLString2x1)
            End If

            writer.Flush()

            writer.Close()
            client.Close()

        Catch ex As Exception

        End Try

    End Function

    Protected Function PrintBuildInstrLabelsCustService(prod As String, tube As String, tubetype As String) As String
        Dim ipAddress As String = ddlPrinters.SelectedValue
        Dim port As Integer = 9100

        Dim ZPLString2x1 As String = ""

        'If tubetype = "custserv" Then

        Dim CSIDNo As String = ""
        Dim OENo As String = ""
        Dim Length As String = ""
        Dim Dealer As String = ""
        Dim Style As String = ""
        Dim Diameter As String = ""
        Dim Front As String = ""
        Dim Ladder As String = ""
        Dim Bracket As String = ""
        Dim Fuel As String = ""
        Dim Splash As String = ""
        Dim Strakes As String = ""
        Dim StrakesComments As String = ""
        Dim StrbTrans As String = ""
        Dim Comments As String = ""
        Dim OuterScheduled As String = ""

        Dim CenterScheduled As String = ""
        Dim Center As String = ""
        Dim TenWide As String = ""
        Dim TubeUpg As String = ""
        Dim Storage As String = ""
        Dim Upsweep As String = ""

        Dim isport As Integer = 0
        Dim isstrb As Integer = 0
        Dim isctr As Integer = 0

        'TubeID, OENo, Dealer, Customer, Model, ModelYear, Style, Diameter, Front, Port, Strb, Ctr, Ladder, Bracket, Keel, Fuel, Splash, Strakes, StrakesComments, StrbTrans, Comments, OuterScheduledFlag, CenterScheduledFlag, OuterScheduled, CenterScheduled

        For Each row As DataRow In buildinstcs.Rows
            For Each column As DataColumn In buildinstcs.Columns
                If column.ColumnName = "TubeID" Then
                    CSIDNo = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "OENo" Then
                    OENo = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Dealer" Then
                    Dealer = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Model" Then
                    Length = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Style" Then
                    Style = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Front" Then
                    Front = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Port" Then
                    If row(column.ColumnName).ToString() = "1" Then
                        isport = 1
                    End If
                End If

                If column.ColumnName = "Strb" Then
                    If row(column.ColumnName).ToString() = "1" Then
                        isstrb = 1
                    End If
                End If

                If column.ColumnName = "Ctr" Then
                    If row(column.ColumnName).ToString() = "1" Then
                        isctr = 1
                    End If
                End If

                If column.ColumnName = "Ladder" Then
                    Ladder = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Bracket" Then
                    Bracket = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Fuel" Then
                    Fuel = row(column.ColumnName).ToString()
                    If Fuel = "NO FUEL" Then
                        Fuel = "NO"
                    ElseIf Fuel = "Fuel" Then
                        Fuel = "FUEL"
                    ElseIf Fuel = "CENTER" Then
                        Fuel = "Ctr"
                    End If
                End If

                If column.ColumnName = "Splash" Then
                    Splash = row(column.ColumnName).ToString()
                    If Splash = "EXTRUDED" Then
                        Splash = "EXT"
                    ElseIf Splash = "REGULAR" Then
                        Splash = "REG"
                    End If
                End If

                If column.ColumnName = "Strakes" Then
                    Strakes = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "StrakesComments" Then
                    StrakesComments = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "StrbTrans" Then
                    StrbTrans = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Comments" Then
                    Comments = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "OuterScheduled" Then
                    OuterScheduled = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "TubeUpg" Then
                    TubeUpg = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Upsweep" Then
                    Upsweep = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "CenterScheduled" Then
                    CenterScheduled = row(column.ColumnName).ToString()
                    'CenterScheduled = CenterScheduled.Substring(0, CenterScheduled.Length - 17)
                End If

                If column.ColumnName = "Center" Then
                    Center = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "TenWide" Then
                    TenWide = row(column.ColumnName).ToString()
                End If

                If column.ColumnName = "Storage" Then
                    Storage = row(column.ColumnName).ToString()
                End If

            Next
        Next

        Dim tubetoprint As String = ""
        If isport = 1 Then
            tubetoprint = "PORT"
            OuterScheduled = OuterScheduled.Substring(0, OuterScheduled.Length - 17)
        ElseIf isstrb = 1 Then
            tubetoprint = "STRB"
            OuterScheduled = OuterScheduled.Substring(0, OuterScheduled.Length - 17)
        ElseIf isctr = 1 Then
            tubetoprint = "CTR"
            CenterScheduled = CenterScheduled.Substring(0, CenterScheduled.Length - 17)
        End If

        If tubetoprint = "PORT" Or tubetoprint = "STRB" Then

            ZPLString2x1 = _
            "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
            "^XA" & _
            "^MMT" & _
            "^PW406" & _
            "^LL0203" & _
            "^LS0" & _
            "^FO256,160^GFA,01280,01280,00020,:Z64:" & _
            "eJztkD0KwkAQRr9lwVjIeIGI15hC9FC2YjZssd2ewINYJgim8wyRXGDFJkV0TYhJ9gzi1wzzeDA/wG9n2xcKkPB9TbKJSd81c/hyYlHeMRYPF3hQHUMWepA6dYlwOKwaGuZJbeojaryXN5o8EzOSvFhH8eTZBWNXaTv7slnLiowRPQ2FnqkZqLyVHMxtWGR7f5LngWmtth1TNLL8UljaCPcoYuGGey/GEsPfr4Ry+Ev6Ms263c+PXvu/SpUEUjx6//zzM/kA0WdKow==:06BB" & _
            "^FO64,0^GFA,00768,00768,00012,:Z64:" & _
            "eJxjYBgFECDDUP/hgwWEzcFQ/wPGBotXQNg8DAkMP+DiBQx/4OoTgGwDuPi/mgKo+voP7ywK4OY8R5j/4TGSOc9/IMx//AMh/hDKlgCKP4Cy5f/U/3jwB2ImP4hdUYAQh7Jxgfr/IPAHgz1yAQB6tTwO:13D0" & _
            "^FO0,32^GFA,00768,00768,00012,:Z64:" & _
            "eJxjYBgFAwuYH/D/Y+BJALPZ//D/Z5BxALPl/wHFJR6A2TL8PAwMEgfAbAt+PiABETdg52Fg/P+xASzO3MfA8P8xmF3A3P+PQfAggm0IZgLZQDMNIfb+AKv/ABEHm/MBaj5QPBmiXkYeaG8yA8w9/xkeNzfA3enO2AB1/3+GR8wN+Pz4HwIeoLMHHgAAJfM6Og==:7EC7" & _
            "^FO256,0^GFA,00768,00768,00012,:Z64:" & _
            "eJxjYBgFUMD8j7nhB4z9n5nxA5z9uBEmzth4sPEOTLzhcfMeGJuhmHEOO0z8c3MfewNEfUNhOw9CvJ0PoZ6dHW7O7/7/DTB2cf9/hPkIccbHMsww9v/H85iPQ83/3ziH8Tjc/TsYn+P3I/9/EDiAwR6xAADuLjVN:7C7C" & _
            "^FO273,131^GB125,69,2^FS" & _
            "^FT16,46^A0N,39,38^FH\^FD" & CSIDNo & "^FS" & _
            "^FT275,83^A0N,28,28^FH\^FD" & Front & "^FS" & _
            "^FT330,82^A0N,28,28^FH\^FD" & Ladder & "^FS" & _
            "^FT13,120^A0N,28,28^FH\^FD" & Fuel & "^FS" & _
            "^FT134,41^A0N,28,28^FH\^FD" & Length & "^FS" & _
            "^FT161,79^A0N,23,24^FH\^FD" & Dealer & "^FS" & _
            "^FT75,82^A0N,23,24^FH\^FD" & OENo & "^FS" & _
            "^FT333,41^A0N,28,28^FH\^FD" & Diameter & "^FS" & _
            "^FT171,42^A0N,28,28^FH\^FD" & Style & "^FS" & _
            "^FT11,156^A0N,28,28^FH\^FD" & StrbTrans & "^FS" & _
            "^FT259,121^A0N,28,28^FH\^FD" & StrakesComments & "^FS" & _
            "^FT20,190^A0N,20,21^FH\^FD" & Comments & "^FS" & _
            "^FT127,120^A0N,28,28^FH\^FD" & Strakes & "^FS" & _
            "^FT317,161^A0N,23,24^FH\^FD" & tubetoprint & "^FS" & _
            "^FT178,156^A0N,25,28^FH\^FD" & Splash & "^FS" & _
            "^FT284,158^A0N,17,16^FH\^FD" & OuterScheduled & "^FS" & _
            "^PQ1,0,1,Y^XZ"


        ElseIf tubetoprint = "CTR" Then 'need to add section to the design
            ZPLString2x1 = _
                "^XA~TA000~JSN^LT0^MNW^MTT^PON^PMN^LH0,0^JMA^PR6,6~SD15^JUS^LRN^CI0^XZ" & _
                "^XA" & _
                "^MMT" & _
                "^PW406" & _
                "^LL0203" & _
                "^LS0" & _
                "^FO0,96^GFA,00384,00384,00012,:Z64:" & _
                "eJxjYKASYDxQ+N9B/gCE3VDw/4H9A6h4wf8P9R8gig4UPHjwoAKmHggNYOofGDYwGEDVPyg8wFAAU/+4AcIGmf/54B+4+Ycbf8DNd4eJH0h4wHjAAm4+4wEZiL1AWxkeQMQZ/gPZ9X8g5tcfeMBg/wDClmc8wCDvUIDPj+z/weAPOpsCAABp4Ux0:3807" & _
                "^FO160,0^GFA,00768,00768,00012,:Z64:" & _
                "eJxjYBgFYMD4Qf7//D8QNvM//v/z/0HY/P/l/9//D2Hz8TMU8PBD2DKsDAUy7BC2BAODgQQzH0ScASQOYVsA2fz/EGx5qPlAtoH8Dwi7BqS+Bi5eIGODZL4czN4GAwk+mHuA4vx8UHcyJPCw90HdD7L3PF4/1v8HgwZ09ggGABhEKzA=:8D9A" & _
                "^FO256,96^GFA,00512,00512,00016,:Z64:" & _
                "eJy9jjEKAjEQRbPkAF7Ag1iIZ4mVbdJt53izCR7AK/zgAUwZQRin2M2kECwEfxMenz8vzv09Xi5C2EvrnAUhnl+dizQ0WXmiwrFgorVXnu/sO7sjx5M+wfr2IE9Y9nq/ip6B+SFke/W5xL7/j8qNnrCeUmaM/nQF6uBPuYZoe1E/5tHPEdvRzzscev8tG1nSPvNPeQOuPWlh:18D1" & _
                "^FO256,160^GFA,01280,01280,00020,:Z64:" & _
                "eJztkD0KwkAQRr9lwVjIeIGI15hC9FC2YjZssd2ewINYJgim8wyRXGDFJkV0TYhJ9gzi1wzzeDA/wG9n2xcKkPB9TbKJSd81c/hyYlHeMRYPF3hQHUMWepA6dYlwOKwaGuZJbeojaryXN5o8EzOSvFhH8eTZBWNXaTv7slnLiowRPQ2FnqkZqLyVHMxtWGR7f5LngWmtth1TNLL8UljaCPcoYuGGey/GEsPfr4Ry+Ev6Ms263c+PXvu/SpUEUjx6//zzM/kA0WdKow==:06BB" & _
                "^FO64,0^GFA,00768,00768,00012,:Z64:" & _
                "eJxjYBgFECDDUP/hgwWEzcFQ/wPGBotXQNg8DAkMP+DiBQx/4OoTgGwDuPi/mgKo+voP7ywK4OY8R5j/4TGSOc9/IMx//AMh/hDKlgCKP4Cy5f/U/3jwB2ImP4hdUYAQh7Jxgfr/IPAHgz1yAQB6tTwO:13D0" & _
                "^FO0,160^GFA,00384,00384,00012,:Z64:" & _
                "eJytzz0OwjAMBeAXpSpb0zEDEhyhoyfO1BvAARBnChLiHD6CR6aaYJcMDCzwpk9W4h/gXzlAGXf3saiEmzEoK4eLu0hBOJvjSRjR6xFzwU6z14mRFnp5A6p/t7k5Gqun6tGc7L2udeuz9n8wevK51zq3n9o+MhC1Pbs5v/eXYU/fTkxqWT79Q56oRT/4:1F5D" & _
                "^FO273,131^GB125,69,2^FS" & _
                "^FT16,46^A0N,39,38^FH\^FD" & CSIDNo & "^FS" & _
                "^FT12,88^A0N,28,28^FH\^FD" & Fuel & "^FS" & _
                "^FT76,122^A0N,28,28^FH\^FD" & TubeUpg & "^FS" & _
                "^FT134,41^A0N,28,28^FH\^FD" & Length & "^FS" & _
                "^FT277,82^A0N,28,28^FH\^FD" & TenWide & "^FS" & _
                "^FT229,42^A0N,28,28^FH\^FD" & Center & "^FS" & _
                "^FT151,184^A0N,23,24^FH\^FD" & Dealer & "^FS" & _
                "^FT360,119^A0N,28,28^FH\^FD" & Bracket & "^FS" & _
                "^FT71,184^A0N,23,24^FH\^FD" & OENo & "^FS" & _
                "^FT12,152^A0N,20,21^FH\^FD" & Upsweep & "^FS" & _
                "^FT126,88^A0N,28,28^FH\^FD" & Strakes & "^FS" & _
                "^FT317,161^A0N,23,24^FH\^FD" & tubetoprint & "^FS" & _
                "^FT279,160^A0N,17,16^FH\^FD" & CenterScheduled & "^FS" & _
                "^PQ1,0,1,Y^XZ"
        End If
        'End If

        Try

            Dim client As New System.Net.Sockets.TcpClient
            client.Connect(ipAddress, port)

            'Write ZPL String to Connection
            Dim writer As New System.IO.StreamWriter(client.GetStream())

            writer.Write(ZPLString2x1)


            writer.Flush()

            writer.Close()
            client.Close()

        Catch ex As Exception

        End Try

    End Function

    Protected Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
        tbProdNo.Text = ""
        rblTube.ClearSelection()
        cblSections.ClearSelection()
    End Sub

    Protected Sub btnPrintBuildSchedule_Click(sender As Object, e As EventArgs) Handles btnPrintBuildSchedule.Click
        'Fill Data Tables
        If ddlTubeType.SelectedValue = "prod" Or ddlTubeType.SelectedValue = "rerun" Then
            PopulateDataTablesOuters(tbProdNo.Text, "prod")
            PrintBuildInstrLabels(tbProdNo.Text, "PORT", "prod") 'will print 2 labels
        ElseIf ddlTubeType.SelectedValue = "custserv" Then
            PopulateDataTablesCS(tbProdNo.Text) 'custserv
            PrintBuildInstrLabelsCustService(tbProdNo.Text, "PORT", "custserv")
        End If


    End Sub

    Protected Sub btnPrintBuildScheduleCenters_Click(sender As Object, e As EventArgs) Handles btnPrintBuildScheduleCenters.Click
        'Fill Data Tables
        If ddlTubeType.SelectedValue = "prod" Or ddlTubeType.SelectedValue = "rerun" Then
            PopulateDataTablesCenters(tbProdNo.Text, "prod")
            PrintBuildInstrLabels(tbProdNo.Text, "CTR", "prod")
        ElseIf ddlTubeType.SelectedValue = "custserv" Then
            PopulateDataTablesCS(tbProdNo.Text)
            PrintBuildInstrLabelsCustService(tbProdNo.Text, "CTR", "custserv")
        End If

    End Sub

    Protected Function PopulateDataTablesOuters(prod As String, tubetype As String) As String
        Dim sqldataadapter As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()

        If tubetype = "prod" Or tubetype = "rerun" Then
            sqldataadapter.SelectCommand = New SqlCommand("Select ShortProdNo, Style, Diameter, Front, TubeModel, OutertubeDetails.Ladder, Bracket, Keel, Fuel, Splash, Strakes, StrakesComments, StrbTrans, Comments, OuterScheduled, OuterScheduleOrder, ItemNo FROM OutertubeDetails Left Join Tubes on OutertubeDetails.ProdNo = Tubes.ProdNo Left join BML_POPREPORTING_GREENLIGHTS on OutertubeDetails.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where OutertubeDetails.ProdNo = '" & prod & "'", conn)
        End If

        sqldataadapter.Fill(buildinst) 'outer tube details

        conn.Close()
        conn.Dispose()
        Return False

    End Function

    Protected Function PopulateDataTablesCenters(prod As String, tubetype As String) As String
        Dim sqldataadapter As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()

        If tubetype = "prod" Or tubetype = "rerun" Then
            sqldataadapter.SelectCommand = New SqlCommand("Select CenterTubeDetails.ShortProdNo, Length,Center, Storage, TenWide, CenterTubeDetails.Bracket, CenterTubeDetails.Fuel, CenterTubeDetails.Strakes, TubeUpg, Upsweep_SldTrans, CenterScheduled, CenterScheduleOrder, TubeModel FROM CentertubeDetails Left Join Tubes on CenterTubeDetails.ProdNo = Tubes.ProdNo Left join OutertubeDetails on CenterTubeDetails.ProdNo = OutertubeDetails.ProdNo where CenterTubeDetails.ProdNo = '" & prod & "'", conn)
        End If


        sqldataadapter.Fill(buildinstctr) 'outer tube details

        conn.Close()
        conn.Dispose()
        Return False

    End Function

    Protected Function PopulateDataTablesCS(prod As String) As String 'tubetype is custserv
        Dim sqldataadapter As New SqlDataAdapter

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        conn.Open()
        'sqldataadapter.SelectCommand = New SqlCommand("Select TubeID, OENo, Dealer, Customer, Model, ModelYear, Style, Diameter, Front, Port, Strb, Ctr, Ladder, Bracket, Keel, Fuel, Splash, Strakes, StrakesComments, StrbTrans, Comments, OuterScheduledFlag, CenterScheduledFlag, OuterScheduled, CenterScheduled FROM CS_Tubes where TubeID = '" & prod & "'", conn)
        sqldataadapter.SelectCommand = New SqlCommand("Select * FROM CS_Tubes where TubeID = '" & prod & "'", conn)

        sqldataadapter.Fill(buildinstcs) 'outer tube details

        conn.Close()
        conn.Dispose()
        Return False
    End Function

End Class
