Imports System.Data
Imports System.Data.SqlClient
Imports MySql.Data.MySqlClient


Partial Class ReportCard
    Inherits System.Web.UI.Page

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

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim user As String = HttpContext.Current.Request.LogonUserIdentity.Name
        user = SplitBValSlash(user).ToUpper

        If user = "TLEITZ" Or user = "KRIMBA" Or user = "LMAYS" Then
            yardTbl.Visible = True
        Else
            yardTbl.Visible = True
        End If

        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim Yesterday As Date = Date.Now.AddDays(-1)

        Dim southcount As Int16
        Dim maincount As Int16
        Dim valuecount As Int16

        Dim cmd As New SqlCommand
        Dim cmd2 As New SqlCommand
        Dim cmd3 As New SqlCommand
        Dim cmd4 As New SqlCommand
        Dim cmd5 As New SqlCommand
        Dim cmd6 As New SqlCommand
        Dim cmd7 As New SqlCommand
        Dim cmd8 As New SqlCommand
        Dim cmd9 As New SqlCommand
        Dim cmd10 As New SqlCommand
        Dim cmd11 As New SqlCommand
        Dim cmd12 As New SqlCommand
        Dim cmd13 As New SqlCommand
        Dim cmd14 As New SqlCommand
        Dim cmd15 As New SqlCommand
        Dim cmd16 As New SqlCommand
        Dim cmd17 As New SqlCommand
        Dim cmd18 As New SqlCommand
        Dim cmd19 As New SqlCommand
        Dim cmd20 As New SqlCommand
        Dim cmd21 As New SqlCommand
        Dim cmd22 As New SqlCommand
        Dim cmd23 As New SqlCommand
        Dim cmd24 As New SqlCommand
        Dim cmd25 As New SqlCommand
        Dim cmd26 As New SqlCommand
        Dim cmd27 As New SqlCommand
        Dim cmd28 As New SqlCommand
        Dim cmd29 As New SqlCommand
        Dim cmd30 As New SqlCommand
        Dim cmd31 As New SqlCommand
        Dim cmd32 As New SqlCommand
        Dim cmd33 As New SqlCommand
        Dim cmd34 As New SqlCommand
        Dim cmd35 As New SqlCommand
        Dim cmd36 As New SqlCommand
        Dim cmd37 As New SqlCommand
        Dim cmd38 As New SqlCommand
        Dim cmd39 As New SqlCommand
        Dim cmd40 As New SqlCommand
        Dim cmd41 As New SqlCommand
        Dim cmd42 As New SqlCommand
        Dim cmd43 As New SqlCommand
        Dim cmd44 As New SqlCommand
        Dim cmd45 As New SqlCommand
        Dim cmd46 As New SqlCommand
        Dim cmd47 As New SqlCommand
        Dim cmd48 As New SqlCommand
        Dim cmd49 As New SqlCommand
        Dim cmd50 As New SqlCommand
        Dim cmd51 As New SqlCommand
        Dim cmd52 As New SqlCommand
        Dim cmd53 As New SqlCommand
        Dim cmd54 As New SqlCommand
        Dim cmd55 As New SqlCommand
        Dim cmd56 As New SqlCommand
        Dim cmd57 As New SqlCommand
        Dim cmd58 As New SqlCommand
        Dim cmd59 As New SqlCommand
        Dim cmd60 As New SqlCommand
        Dim cmd61 As New SqlCommand

        Dim cmd62 As New MySqlCommand
        Dim cmd63 As New MySqlCommand
        Dim cmd64 As New MySqlCommand
        Dim cmd65 As New MySqlCommand

        Dim cmd66 As New SqlCommand
        Dim cmd67 As New SqlCommand
        Dim cmd68 As New SqlCommand
        Dim cmd69 As New SqlCommand
        Dim cmd70 As New SqlCommand

        Dim cmd71 As New SqlCommand
        Dim cmd72 As New SqlCommand
        Dim cmd73 As New SqlCommand
        Dim cmd74 As New SqlCommand
        Dim cmd75 As New SqlCommand
        Dim cmd76 As New SqlCommand
        Dim cmd77 As New SqlCommand
        Dim cmd78 As New SqlCommand

        Dim cmd79 As New SqlCommand
        Dim cmd80 As New SqlCommand
        Dim cmd81 As New SqlCommand
        Dim cmd82 As New SqlCommand
        Dim cmd83 As New SqlCommand
        Dim cmd84 As New SqlCommand
        Dim cmd85 As New SqlCommand
        Dim cmd86 As New SqlCommand
        Dim cmd87 As New SqlCommand
        Dim cmd88 As New SqlCommand
        Dim cmd89 As New SqlCommand

        Dim cmd90 As New SqlCommand
        Dim cmd91 As New SqlCommand
        Dim cmd92 As New SqlCommand
        Dim cmd93 As New SqlCommand
        Dim cmd94 As New SqlCommand
        Dim cmd95 As New SqlCommand
        Dim cmd96 As New SqlCommand
        Dim cmd97 As New SqlCommand
        Dim cmd98 As New SqlCommand
        Dim cmd99 As New SqlCommand

        Dim cmd100 As New SqlCommand
        Dim cmd101 As New SqlCommand

        Dim cmd102 As New SqlCommand
        Dim cmd103 As New SqlCommand
        Dim cmd104 As New SqlCommand
        Dim cmd105 As New SqlCommand

        Dim cmd106 As New SqlCommand
        Dim cmd107 As New SqlCommand
        Dim cmd108 As New SqlCommand
        Dim cmd109 As New SqlCommand

        Dim cmd110 As New SqlCommand 'yellow rails
        Dim cmd111 As New SqlCommand 'orange rails
        Dim cmd112 As New SqlCommand 'blue rails
        Dim cmd113 As New SqlCommand 'green rails
        Dim cmd129 As New SqlCommand 'tan rails

        Dim cmd114 As New SqlCommand 'empty rail slots
        Dim cmd115 As New SqlCommand 'rails in rack with all rails rcvd
        Dim cmd116 As New SqlCommand 'rails in rack with all rails rcvd Main
        Dim cmd117 As New SqlCommand 'rails in rack with all rails rcvd South

        Dim cmd118 As New SqlCommand  'waiting for frames, can come straight over main
        Dim cmd119 As New SqlCommand  'waiting for frames, can come straight over south

        Dim cmd120 As New SqlCommand
        Dim cmd121 As New SqlCommand
        Dim cmd122 As New SqlCommand
        Dim cmd123 As New SqlCommand
        Dim cmd124 As New SqlCommand

        Dim cmd125 As New SqlCommand
        Dim cmd126 As New SqlCommand
        Dim cmd127 As New SqlCommand
        Dim cmd128 As New SqlCommand
        'cmd129 used above in tan rails
        Dim cmd130 As New SqlCommand
        Dim cmd131 As New SqlCommand
        Dim cmd132 As New SqlCommand
        Dim cmd133 As New SqlCommand
        Dim cmd134 As New SqlCommand
        Dim cmd135 As New SqlCommand
        Dim cmd136 As New SqlCommand
        Dim cmd137 As New SqlCommand
        Dim cmd138 As New SqlCommand

        'Value line Completed By:
        Dim cmd139 As New SqlCommand
        Dim cmd140 As New SqlCommand
        Dim cmd141 As New SqlCommand
        Dim cmd142 As New SqlCommand
        Dim cmd143 As New SqlCommand
        Dim cmd144 As New SqlCommand
        Dim cmd145 As New SqlCommand
        Dim cmd146 As New SqlCommand
        Dim cmd147 As New SqlCommand
        Dim cmd148 As New SqlCommand
        Dim cmd149 As New SqlCommand
        Dim cmd150 As New SqlCommand
        Dim cmd151 As New SqlCommand

        'Value Line Ready:

        Dim cmd152 As New SqlCommand
        Dim cmd153 As New SqlCommand
        Dim cmd154 As New SqlCommand
        Dim cmd155 As New SqlCommand
        Dim cmd156 As New SqlCommand
        Dim cmd157 As New SqlCommand
        Dim cmd158 As New SqlCommand
        Dim cmd159 As New SqlCommand
        Dim cmd160 As New SqlCommand
        Dim cmd161 As New SqlCommand
        Dim cmd162 As New SqlCommand
        Dim cmd163 As New SqlCommand

        Dim cmd164 As New SqlCommand
        Dim cmd165 As New SqlCommand
        Dim cmd166 As New SqlCommand
        Dim cmd167 As New SqlCommand
        Dim cmd168 As New SqlCommand
        Dim cmd169 As New SqlCommand
        Dim cmd170 As New SqlCommand
        Dim cmd171 As New SqlCommand
        Dim cmd172 As New SqlCommand

        Dim cmd173 As New SqlCommand
        Dim cmd174 As New SqlCommand
        Dim cmd175 As New SqlCommand
        Dim cmd176 As New SqlCommand
        Dim cmd177 As New SqlCommand
        Dim cmd178 As New SqlCommand
        Dim cmd179 As New SqlCommand
        Dim cmd180 As New SqlCommand

        Dim cmd181 As New MySqlCommand
        Dim cmd182 As New MySqlCommand
        Dim cmd183 As New SqlCommand
        Dim cmd184 As New SqlCommand
        Dim cmd185 As New SqlCommand
        Dim cmd186 As New SqlCommand
        Dim cmd187 As New SqlCommand
        Dim cmd188 As New SqlCommand
        Dim cmd189 As New SqlCommand
        Dim cmd190 As New SqlCommand
        Dim cmd191 As New SqlCommand
        Dim cmd192 As New SqlCommand
        Dim cmd193 As New SqlCommand
        Dim cmd194 As New SqlCommand
        Dim cmd195 As New SqlCommand
        Dim cmd196 As New SqlCommand

        Dim cmd197 As New SqlCommand
        Dim cmd198 As New SqlCommand
        Dim cmd199 As New SqlCommand
        Dim cmd200 As New SqlCommand

        Dim cmd201 As New SqlCommand
        Dim cmd202 As New SqlCommand
        Dim cmd203 As New SqlCommand
        Dim cmd204 As New SqlCommand
        Dim cmd205 As New SqlCommand
        Dim cmd206 As New SqlCommand
        Dim cmd207 As New SqlCommand
        Dim cmd208 As New SqlCommand
        Dim cmd209 As New SqlCommand
        Dim cmd210 As New SqlCommand


        Dim conn As New SqlConnection() 'Specs
        Dim conn2 As New MySqlConnection() 'External SPECS
        Dim conn1 As New SqlConnection() 'Macola

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim connstr2 As String = "server=ben.c0fnidwvz1hv.us-east-1.rds.amazonaws.com;user id=specs;password=CD$[v9ZW;persistsecurityinfo=True;database=SPECS_External"
        Dim connstr1 As String = ConfigurationManager.ConnectionStrings("dataConnectionString").ConnectionString

        conn.ConnectionString = connstr
        conn2.ConnectionString = connstr2
        conn1.ConnectionString = connstr1

        cmd.Connection = conn
        cmd2.Connection = conn
        cmd3.Connection = conn
        cmd4.Connection = conn
        cmd5.Connection = conn
        cmd6.Connection = conn
        cmd7.Connection = conn
        cmd8.Connection = conn
        cmd9.Connection = conn
        cmd10.Connection = conn
        cmd11.Connection = conn
        cmd12.Connection = conn
        cmd13.Connection = conn
        cmd14.Connection = conn
        cmd15.Connection = conn
        cmd16.Connection = conn
        cmd17.Connection = conn
        cmd18.Connection = conn
        cmd19.Connection = conn
        cmd20.Connection = conn
        cmd21.Connection = conn
        cmd22.Connection = conn
        cmd23.Connection = conn
        cmd24.Connection = conn
        cmd25.Connection = conn
        cmd26.Connection = conn
        cmd27.Connection = conn
        cmd28.Connection = conn
        cmd29.Connection = conn
        cmd30.Connection = conn
        cmd31.Connection = conn
        cmd32.Connection = conn
        cmd33.Connection = conn
        cmd34.Connection = conn
        cmd35.Connection = conn
        cmd36.Connection = conn
        cmd37.Connection = conn
        cmd38.Connection = conn
        cmd39.Connection = conn
        cmd40.Connection = conn
        cmd41.Connection = conn
        cmd42.Connection = conn
        cmd43.Connection = conn
        cmd44.Connection = conn
        cmd45.Connection = conn
        cmd46.Connection = conn
        cmd47.Connection = conn
        cmd48.Connection = conn
        cmd49.Connection = conn
        cmd50.Connection = conn
        cmd51.Connection = conn
        cmd52.Connection = conn
        cmd53.Connection = conn
        cmd54.Connection = conn
        cmd55.Connection = conn
        cmd56.Connection = conn
        cmd57.Connection = conn
        cmd58.Connection = conn
        cmd59.Connection = conn
        cmd60.Connection = conn
        cmd61.Connection = conn

        cmd62.Connection = conn2
        cmd63.Connection = conn2
        cmd64.Connection = conn2
        cmd65.Connection = conn2

        cmd66.Connection = conn
        cmd67.Connection = conn
        cmd68.Connection = conn
        cmd69.Connection = conn
        cmd70.Connection = conn
        cmd71.Connection = conn
        cmd72.Connection = conn
        cmd73.Connection = conn
        cmd74.Connection = conn
        cmd75.Connection = conn
        cmd76.Connection = conn
        cmd77.Connection = conn
        cmd78.Connection = conn
        cmd79.Connection = conn
        cmd80.Connection = conn
        cmd81.Connection = conn
        cmd82.Connection = conn
        cmd83.Connection = conn
        cmd84.Connection = conn
        cmd85.Connection = conn
        cmd86.Connection = conn
        cmd87.Connection = conn
        cmd88.Connection = conn
        cmd89.Connection = conn
        cmd90.Connection = conn
        cmd91.Connection = conn
        cmd92.Connection = conn
        cmd93.Connection = conn
        cmd94.Connection = conn
        cmd95.Connection = conn
        cmd96.Connection = conn
        cmd97.Connection = conn
        cmd98.Connection = conn
        cmd99.Connection = conn
        cmd100.Connection = conn
        cmd101.Connection = conn
        cmd102.Connection = conn
        cmd103.Connection = conn
        cmd104.Connection = conn
        cmd105.Connection = conn
        cmd106.Connection = conn
        cmd107.Connection = conn
        cmd108.Connection = conn
        cmd109.Connection = conn
        cmd110.Connection = conn
        cmd111.Connection = conn
        cmd112.Connection = conn
        cmd113.Connection = conn
        cmd114.Connection = conn
        cmd115.Connection = conn
        cmd116.Connection = conn
        cmd117.Connection = conn
        cmd118.Connection = conn
        cmd119.Connection = conn

        cmd120.Connection = conn
        cmd121.Connection = conn
        cmd122.Connection = conn
        cmd123.Connection = conn
        cmd124.Connection = conn

        cmd125.Connection = conn
        cmd126.Connection = conn
        cmd127.Connection = conn
        cmd128.Connection = conn
        cmd129.Connection = conn

        cmd130.Connection = conn1
        cmd131.Connection = conn

        cmd132.Connection = conn
        cmd133.Connection = conn
        cmd134.Connection = conn
        cmd135.Connection = conn
        cmd136.Connection = conn
        cmd137.Connection = conn
        cmd138.Connection = conn

        cmd139.Connection = conn
        cmd140.Connection = conn
        cmd141.Connection = conn
        cmd142.Connection = conn
        cmd143.Connection = conn
        cmd144.Connection = conn
        cmd145.Connection = conn
        cmd146.Connection = conn
        cmd147.Connection = conn
        cmd148.Connection = conn
        cmd149.Connection = conn
        cmd150.Connection = conn
        cmd151.Connection = conn

        cmd152.Connection = conn
        cmd153.Connection = conn
        cmd154.Connection = conn
        cmd155.Connection = conn
        cmd156.Connection = conn
        cmd157.Connection = conn
        cmd158.Connection = conn
        cmd159.Connection = conn
        cmd160.Connection = conn
        cmd161.Connection = conn
        cmd162.Connection = conn
        cmd163.Connection = conn
        cmd164.Connection = conn
        cmd165.Connection = conn
        cmd166.Connection = conn
        cmd167.Connection = conn
        cmd168.Connection = conn
        cmd169.Connection = conn
        cmd170.Connection = conn
        cmd171.Connection = conn
        cmd172.Connection = conn
        cmd173.Connection = conn
        cmd174.Connection = conn
        cmd175.Connection = conn
        cmd176.Connection = conn
        cmd177.Connection = conn
        cmd178.Connection = conn
        cmd179.Connection = conn
        cmd180.Connection = conn
        cmd181.Connection = conn2
        cmd182.Connection = conn2
        cmd183.Connection = conn
        cmd184.Connection = conn
        cmd185.Connection = conn
        cmd186.Connection = conn
        cmd187.Connection = conn
        cmd188.Connection = conn
        cmd189.Connection = conn
        cmd190.Connection = conn
        cmd190.Connection = conn
        cmd191.Connection = conn
        cmd192.Connection = conn
        cmd193.Connection = conn
        cmd194.Connection = conn
        cmd195.Connection = conn
        cmd196.Connection = conn
        cmd197.Connection = conn
        cmd198.Connection = conn
        cmd199.Connection = conn
        cmd200.Connection = conn

        cmd201.Connection = conn
        cmd202.Connection = conn
        cmd203.Connection = conn
        cmd204.Connection = conn
        cmd205.Connection = conn
        cmd206.Connection = conn
        cmd207.Connection = conn
        cmd208.Connection = conn
        cmd209.Connection = conn
        cmd210.Connection = conn

        cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus = '2' and ProdLineID = '3' and Convert(date,FurniturePrepLastUpdated) ='" & ThisDay & "'"
        cmd183.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus = '2' and ProdLineID = '2' and Convert(date,FurniturePrepLastUpdated) ='" & ThisDay & "'"
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FiberglassStatus = '2' and ProdLineID = '3' and Convert(date,FiberglassLastUpdated) ='" & ThisDay & "'"
        cmd184.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FiberglassStatus = '2' and ProdLineID = '2' and Convert(date,FiberglassLastUpdated) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CoversStatus = '2' and ProdLineID = '3' and Convert(date,CoversLastUpdated) ='" & ThisDay & "'"
        cmd185.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CoversStatus = '2' and ProdLineID = '2' and Convert(date,CoversLastUpdated) ='" & ThisDay & "'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsStatus = '2' and ProdLineID = '3' and Convert(date,RailsLastUpdated) ='" & ThisDay & "'"
        cmd186.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsStatus = '2' and ProdLineID = '2' and Convert(date,RailsLastUpdated) ='" & ThisDay & "'"
        cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = '2' and ProdLineID = '3' and Convert(date,TubesLastUpdated) ='" & ThisDay & "'"
        cmd187.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = '2' and ProdLineID = '2' and Convert(date,TubesLastUpdated) ='" & ThisDay & "'"
        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = '2' and ProdLineID = '3' and Convert(date,CenterTube) ='" & ThisDay & "'"
        cmd188.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = '2' and ProdLineID = '2' and Convert(date,CenterTube) ='" & ThisDay & "'"
        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where GaugeStatus = '2' and ProdLineID = '3' and Convert(date,GaugeLastUpdated) ='" & ThisDay & "'"
        cmd189.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where GaugeStatus = '2' and ProdLineID = '2' and Convert(date,GaugeLastUpdated) ='" & ThisDay & "'"
        cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HarnessStatus = '2' and ProdLineID = '3' and Convert(date,HarnessLastUpdated) ='" & ThisDay & "'"
        cmd190.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HarnessStatus = '2' and ProdLineID = '2' and Convert(date,HarnessLastUpdated) ='" & ThisDay & "'"
        cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ArchTowerStatus = '2' and Convert(date,ArchTower) ='" & ThisDay & "'"

        cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where TubesStatus = '2' and FramesInstalledStatus > 1 and FloorsInstalledStatus < 2 and CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc ='S'"
        cmd90.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where TubesStatus = '2' and FramesInstalledStatus > 1 and FloorsInstalledStatus < 2 and CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc ='M'"
        cmd167.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where TubesStatus = '2' and FramesInstalledStatus > 1 and FloorsInstalledStatus < 2 and CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc ='V'"


        cmd12.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus = '2' and ProdLineID = '1' and Convert(date,FurniturePrepLastUpdated) ='" & ThisDay & "'"
        cmd13.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FiberglassStatus = '2' and ProdLineID = '1' and Convert(date,FiberglassLastUpdated) ='" & ThisDay & "'"
        cmd14.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CoversStatus = '2' and ProdLineID = '1' and Convert(date,CoversLastUpdated) ='" & ThisDay & "'"
        cmd15.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsStatus = '2' and ProdLineID = '1' and Convert(date,RailsLastUpdated) ='" & ThisDay & "'"
        cmd16.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = '2' and ProdLineID = '1' and Convert(date,TubesLastUpdated) ='" & ThisDay & "'"
        cmd17.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = '2' and ProdLineID = '1' and Convert(date,CenterTube) ='" & ThisDay & "'"
        cmd18.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where GaugeStatus = '2' and ProdLineID = '1' and Convert(date,GaugeLastUpdated) ='" & ThisDay & "'"
        cmd19.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HarnessStatus = '2' and ProdLineID = '1' and Convert(date,HarnessLastUpdated) ='" & ThisDay & "'"
        cmd20.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where QFrontStatus = '2' and Convert(date,QFront) ='" & ThisDay & "'"

        cmd21.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = '2' and (CentertubeStatus = '2' or CentertubeNeeded = '0') and FramesInstalledStatus < 2 and ProdLineID = '3'"
        cmd152.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where TubesStatus = '2' and (CentertubeStatus = '2' or BML_POPREPORTING_GREENLIGHTS.CentertubeNeeded = '0') and FramesInstalledStatus < 2 and ProdLineID = '2'"
        cmd22.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = '2' and (CentertubeStatus = '2' or CentertubeNeeded = '0') and FramesInstalledStatus < 2 and ProdLineID = '1'"

        cmd23.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = '2' and ProdLineID = '3' and Convert(date,FramesInstalled) ='" & ThisDay & "'"
        cmd139.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = '2' and ProdLineID = '2' and Convert(date,FramesInstalled) ='" & ThisDay & "'"
        cmd24.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = '2' and ProdLineID = '1' and Convert(date,FramesInstalled) ='" & ThisDay & "'"

        cmd25.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = '1' and ProdLineID = '3' and ProdNo >= 2100000 and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2 and HelmBuildStatus > 0"
        cmd153.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = '1' and ProdLineID = '2' and ProdNo >= 2100000 and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2 and HelmBuildStatus > 0" ' and (SBNeeded = 0 or (SBNeeded = 1 and SwingbackStatus =2))
        cmd26.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = '1' and ProdLineID = '1' and ProdNo >= 2100000"

        cmd27.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = '2' and ProdLineID = '3' and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
        cmd140.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = '2' and ProdLineID = '2' and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
        cmd28.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = '2' and ProdLineID = '1' and Convert(date,FloorsInstalled) ='" & ThisDay & "'"

        cmd106.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = '2' and ProdLineID = '3' and Convert(date,Trim) ='" & ThisDay & "'"
        cmd141.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = '2' and ProdLineID = '2' and Convert(date,Trim) ='" & ThisDay & "'"
        cmd107.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = '2' and ProdLineID = '1' and Convert(date,Trim) ='" & ThisDay & "'"
        cmd108.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = '1' and ProdLineID = '3' and ProdNo >= 2100000 and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2"
        cmd154.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = '1' and ProdLineID = '2' and ProdNo >= 2100000 and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2"
        cmd109.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = '1' and ProdLineID = '1' and ProdNo >= 2100000"

        cmd29.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = '1' and ProdLineID = '3'"
        cmd155.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = '1' and ProdLineID = '2'"
        cmd30.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = '2' and ProdLineID = '3' and Convert(date,RailsInstalled) ='" & ThisDay & "'"
        cmd142.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = '2' and ProdLineID = '2' and Convert(date,RailsInstalled) ='" & ThisDay & "'"
        'cmd31.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = '2' and ProdLineID = '1' and Convert(date,RailsInstalled) ='" & ThisDay & "'"
        cmd31.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where IsDeckInside =1 and ProdLineID = '1' and Convert(date,DeckLocModified) ='" & ThisDay & "'"   'South Bring Online Code added 1/9/2020

        cmd32.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureInstalledStatus = '2' and ProdLineID = '3' and Convert(date,FurnitureInstalled) ='" & ThisDay & "'"
        cmd143.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureInstalledStatus = '2' and ProdLineID = '2' and Convert(date,FurnitureInstalled) ='" & ThisDay & "'"
        cmd99.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureInstalledStatus = '2' and ProdLineID = '1' and Convert(date,FurnitureInstalled) ='" & ThisDay & "'"

        cmd33.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmInstalledStatus = '2' and ProdLineID = '3' and Convert(date,HelmInstalled) ='" & ThisDay & "'"
        cmd144.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmInstalledStatus = '2' and ProdLineID = '2' and Convert(date,HelmInstalled) ='" & ThisDay & "'"
        cmd91.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmInstalledStatus = '2' and ProdLineID = '1' and Convert(date,HelmInstalled) ='" & ThisDay & "'"

        cmd34.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = '2' and ProdLineID = '3' and Convert(date,Cleaning) ='" & ThisDay & "'"
        cmd145.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = '2' and ProdLineID = '2' and Convert(date,Cleaning) ='" & ThisDay & "'"
        cmd92.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = '2' and ProdLineID = '1' and Convert(date,Cleaning) ='" & ThisDay & "'"

        cmd35.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FinalInspectionStatus = '2' and ProdLineID = '3' and Convert(date,FinalInspection) ='" & ThisDay & "'"
        cmd146.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FinalInspectionStatus = '2' and ProdLineID = '2' and Convert(date,FinalInspection) ='" & ThisDay & "'"
        cmd93.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FinalInspectionStatus = '2' and ProdLineID = '1' and Convert(date,FinalInspection) ='" & ThisDay & "'"

        cmd36.CommandText = "Select Count (*) FROM BML_POPREPORTING t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo where ShrinkwrapStatus = '1' and t2.BuildLoc = 'M' and t1.ProdNo >= 2100000 and CompleteStatus < 2"
        cmd160.CommandText = "Select Count (*) FROM BML_POPREPORTING t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo where ShrinkwrapStatus = '1' and t2.BuildLoc = 'V' and t1.ProdNo >= 2100000"
        cmd98.CommandText = "Select Count (*) FROM BML_POPREPORTING t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo where ShrinkwrapStatus = '1' and t2.BuildLoc = 'S' and t1.ProdNo >= 2100000"

        cmd37.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and ProdLineID = '3' and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
        cmd147.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and ProdLineID = '2' and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
        cmd38.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and ProdLineID = '1' and Convert(date,Shrinkwrap) ='" & ThisDay & "'"

        cmd39.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RiggingStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd161.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RiggingStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd40.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RiggingStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd41.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus = '2' and ProdLineID = '3' and Convert(date,Rigging) ='" & ThisDay & "'"
        cmd148.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus = '2' and ProdLineID = '2' and Convert(date,Rigging) ='" & ThisDay & "'"
        cmd42.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus = '2' and ProdLineID = '1' and Convert(date,Rigging) ='" & ThisDay & "'"

        cmd43.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where WaveTamerStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd162.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where WaveTamerStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd44.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where WavetamerStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd45.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where WavetamerStatus = '2' and ProdLineID = '3' and Convert(date,WavetamerInstalled) ='" & ThisDay & "'"
        cmd149.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where WavetamerStatus = '2' and ProdLineID = '2' and Convert(date,WavetamerInstalled) ='" & ThisDay & "'"
        cmd46.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where WavetamerStatus = '2' and ProdLineID = '1' and Convert(date,WavetamerInstalled) ='" & ThisDay & "'"

        cmd47.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where SharkhideStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd163.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where SharkhideStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd48.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where SharkhideStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd49.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where SharkhideStatus = '2' and ProdLineID = '3' and Convert(date,SharkhideInstalled) ='" & ThisDay & "'"
        cmd150.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where SharkhideStatus = '2' and ProdLineID = '2' and Convert(date,SharkhideInstalled) ='" & ThisDay & "'"
        cmd50.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where SharkhideStatus = '2' and ProdLineID = '1' and Convert(date,SharkhideInstalled) ='" & ThisDay & "'"

        cmd51.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CompleteStatus = '2' and ProdLineID = '3' and Convert(date,Complete) ='" & ThisDay & "'"
        cmd151.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CompleteStatus = '2' and ProdLineID = '2' and Convert(date,Complete) ='" & ThisDay & "'"
        cmd52.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CompleteStatus = '2' and ProdLineID = '1' and Convert(date,Complete) ='" & ThisDay & "'"

        cmd53.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FurnitureInstalledStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd156.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FurnitureInstalledStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd94.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FurnitureInstalledStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd54.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where HelmInstalledStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd157.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where HelmInstalledStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd95.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where HelmInstalledStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd55.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where CleaningStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd158.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where CleaningStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd96.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where CleaningStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd56.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FinalInspectionStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd159.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FinalInspectionStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd97.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FinalInspectionStatus = '1' and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd57.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and (RailsInstalledStatus > 1 or (RailsInstalledStatus = 1 and IsDeckInside = 1)) and ShrinkwrapStatus < 2 and BML_POPREPORTING.ProdNo > '1999999'"
        cmd58.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and RailsInstalledStatus = 1 and IsDeckInside = 0 and BML_POPREPORTING.ProdNo > '2100000'"
        cmd59.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and RailsInstalledStatus = 1 and IsDeckInside = 0 and FurnitureStatus >= 2  and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((ArchTowerNeeded = 0) OR (ArchTowerNeeded = 1 AND (ArchTowerStatus = 2 or ArchTowerStatus = 4))) AND ((QFrontNeeded = 0) OR (QFrontNeeded = 1 AND QFrontStatus = 2)) And BML_POPREPORTING.ProdNo > '2200000'"

        cmd60.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M'"
        cmd166.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V'"
        cmd61.CommandText = "Select Count (Distinct(BML_POPREPORTING_OFFLINE.ProdNo)) From BML_POPREPORTING_OFFLINE Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING_OFFLINE.ProdNo Where (BML_POPREPORTING_OFFLINE.Cleared = 0) AND (BML_POPREPORTING_OFFLINE.OfflineNote <> '') and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S'"

        cmd62.CommandText = "Select Count(*) FROM RGAs Left Join BuildLoc on RGAs.ProdNo = BuildLoc.ProdNo where BenRcvd is null and RgaNo is not null and BuildLoc = 'M'"
        cmd181.CommandText = "Select Count(*) FROM RGAs Left Join BuildLoc on RGAs.ProdNo = BuildLoc.ProdNo where BenRcvd is null and RgaNo is not null and BuildLoc = 'V'"
        cmd63.CommandText = "Select Count(*) FROM RGAs Left Join BuildLoc on RGAs.ProdNo = BuildLoc.ProdNo where BenRcvd is null and RgaNo is not null and BuildLoc = 'S'"
        cmd64.CommandText = "Select Count(*) FROM Backorders Left Join BuildLoc on Backorders.ProdNo = BuildLoc.ProdNo where Cleared = 0 and BuildLoc = 'M'"
        cmd182.CommandText = "Select Count(*) FROM Backorders Left Join BuildLoc on Backorders.ProdNo = BuildLoc.ProdNo where Cleared = 0 and BuildLoc = 'V'"
        cmd65.CommandText = "Select Count(*) FROM Backorders Left Join BuildLoc on Backorders.ProdNo = BuildLoc.ProdNo where Cleared = 0 and BuildLoc = 'S'"

        cmd66.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and DueDate >'" & TodaysDate & "'"

        cmd67.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & TodaysDate & "'"
        cmd191.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & TodaysDate & "'"
        cmd68.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & TodaysDate & "'"

        cmd69.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and ProdLineID = '3' and DueDate >'" & TodaysDate & "'"
        cmd192.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and ProdLineID = '2' and DueDate >'" & TodaysDate & "'"
        cmd70.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = 2 and ProdLineID = '1' and DueDate >'" & TodaysDate & "'"

        cmd71.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FurnitureStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd173.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FurnitureStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd72.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FurnitureStatus = 2 and RailsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd73.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FiberglassStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd174.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FiberglassStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd74.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FiberglassStatus = 2 and RailsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd75.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where CoversStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd175.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where CoversStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd76.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where CoversStatus = 2 and RailsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd77.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RailsStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd176.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RailsStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd78.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RailsStatus = 2 and RailsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd79.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where TubesStatus = 2 and FramesInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd177.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where TubesStatus = 2 and FramesInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd80.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where TubesStatus = 2 and FramesInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd81.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where CenterTubeStatus = 2 and FramesInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd178.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where CenterTubeStatus = 2 and FramesInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd82.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where CentertubeStatus = 2 and FramesInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd83.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where GaugeStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd179.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where GaugeStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd84.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where GaugeStatus = 2 and RailsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd85.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where HarnessStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd180.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where HarnessStatus = 2 and FloorsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd86.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where HarnessStatus = 2 and RailsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd87.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where ArchTowerStatus = 2 and RailsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd88.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where QFrontStatus = 2 and RailsInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd89.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FramesInstalledStatus = 2 and FloorsInstalledStatus = 2 and ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((ArchTowerNeeded = 0) OR (ArchTowerNeeded = 1 AND ArchTowerStatus = 2)) AND ((QFrontNeeded = 0) OR (QFrontNeeded = 1 AND QFrontStatus = 2)) and BML_POPREPORTING.ProdNo >= 2100000"
        cmd168.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where FramesInstalledStatus = 2 and FloorsInstalledStatus = 2 and ShrinkwrapStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and RailsStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((ArchTowerNeeded = 0) OR (ArchTowerNeeded = 1 AND ArchTowerStatus = 2)) AND ((QFrontNeeded = 0) OR (QFrontNeeded = 1 AND QFrontStatus = 2)) and BML_POPREPORTING.ProdNo >= 2100000"


        cmd100.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and FramesInstalledStatus = 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & TodaysDate & "'"
        cmd169.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and FramesInstalledStatus = 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & TodaysDate & "'"
        cmd101.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING_GREENLIGHTS.CompleteStatus < 2 and BML_POPREPORTING_GREENLIGHTS.ShrinkwrapStatus < 2 and RailsInstalledStatus = 2 and BML_POPREPORTING_GREENLIGHTS.DueDate <= '" & TodaysDate & "'"

        cmd102.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RailsStatus = 1 and FramesInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd170.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RailsStatus = 1 and FramesInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000"
        cmd103.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RailsStatus = 1 and FramesInstalledStatus < 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000"

        cmd104.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RailsStatus = 1 and FramesInstalledStatus = 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000 and ShrinkwrapStatus < 2"
        cmd171.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RailsStatus = 1 and FramesInstalledStatus = 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000 and ShrinkwrapStatus < 2"
        cmd105.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING_GREENLIGHTS.ProdNo = BML_POPREPORTING.ProdNo where RailsStatus = 1 and FramesInstalledStatus = 2 and BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000 and ShrinkwrapStatus < 2"

        cmd110.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and Requested = '1' and HasAllRails ='0' and BuildLoc ='S' and (FurnitureStatus < 2 or FiberglassStatus < 2 or CoversStatus < 1 or TubesStatus < 2 or RailsStatus < 1 or TrimStatus < 2 or ((CentertubeNeeded = 1 and CentertubeStatus < 2) or CentertubeNeeded = 0)) "
        'cmd111.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where (InUse = '1' and HasAllRails = '1' and BuildLoc ='S' and FurnitureStatus = 2 and FiberglassStatus = 2 and CoversStatus >= 1 and TubesStatus = 2 and GaugeStatus = 2 and RailsStatus = 0 and HarnessStatus = 2 and FloorsInstalledStatus = 2 and TrimStatus = 2 and ((CentertubeNeeded = 1 and CentertubeStatus >= 1) or CentertubeNeeded = 0) and ((ArchTowerNeeded = 1 and ArchTowerStatus >= 1) or ArchTowerNeeded = 0)) "

        cmd111.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '1' and Requested = '1' and BuildLoc ='S' and FurnitureStatus = 2 and FiberglassStatus = 2 and CoversStatus >= 1 and TubesStatus = 2 and GaugeStatus = 2 and RailsStatus = 0 and HarnessStatus = 2 and FloorsInstalledStatus = 2 and TrimStatus = 2 and ((CentertubeNeeded = 1 and CentertubeStatus = 2) or CentertubeNeeded = 0) and ((ArchTowerNeeded = 1 and (ArchTowerStatus = 2 or ArchTowerStatus = 4)) or ArchTowerNeeded = 0)"

        cmd129.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where (InUse = '1' and HasAllRails = '0' and BuildLoc ='S' and Requested = '0' and FurnitureStatus = 2 and FiberglassStatus = 2 and CoversStatus >= 1 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2) and ((CentertubeNeeded = 1 and CentertubeStatus >= 1) or CentertubeNeeded = 0) "

        cmd112.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '0' and ProdLineID = '3' and (FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((CentertubeNeeded = 1 and CentertubeStatus >= 1) or CentertubeNeeded = 0)) "
        cmd113.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '1' and ProdLineID = '3' and (FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((CentertubeNeeded = 1 and CentertubeStatus >= 1) or CentertubeNeeded = 0)) "

        cmd164.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '0' and ProdLineID = '2' and (FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((CentertubeNeeded = 1 and CentertubeStatus >= 1) or CentertubeNeeded = 0)) "
        cmd165.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '1' and ProdLineID = '2' and (FurnitureStatus >= 2 and FiberglassStatus = 2 and CoversStatus >= 1 and TubesStatus = 2 and GaugeStatus = 2 and HarnessStatus = 2 and ((CentertubeNeeded = 1 and CentertubeStatus >= 1) or CentertubeNeeded = 0)) "

        cmd114.CommandText = "Select Count (*) From Rails_KittingLocations where InUse ='0'"

        cmd115.CommandText = "Select Count (*) FROM Rails_KittingLocations left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '1'"
        cmd116.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '1' and ProdLineID = '3'"
        cmd194.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '1' and ProdLineID = '2'"
        cmd117.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '1' and ProdLineID = '1'"

        cmd118.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'M' and BML_POPREPORTING.ProdNo >= 2100000 and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2 AND FramesInstalledStatus < 2"
        cmd172.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'V' and BML_POPREPORTING.ProdNo >= 2100000 and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2 AND FramesInstalledStatus < 2"
        cmd119.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and BML_POPREPORTING.ProdNo >= 2100000 and FurnitureStatus >= 2 AND FiberglassStatus = 2 and CoversStatus >= 1 AND RailsStatus = 2 and GaugeStatus = 2 AND HarnessStatus = 2 AND FramesInstalledStatus < 2"

        'Furn Map Queries

        cmd120.CommandText = "Select Count (*) From Material_Locations Where Usable = 1 and InUse = 0"
        cmd121.CommandText = "Select Count (*) From Material_Locations Where Usable = 0"

        cmd122.CommandText = "Select Count(Distinct(Material_Locations.ProdNo)) From Material_Locations Left join BML_POPREPORTING_GREENLIGHTS on Material_Locations.ProdNo = Substring(BML_POPREPORTING_GREENLIGHTS.ProdNo,3,5) Where InUse = 1 and Usable = 1 and FurnitureStatus = 2 and CompleteStatus < 2 and ShrinkwrapStatus < 2"
        cmd201.CommandText = "Select Count(Distinct(Material_Locations.ProdNo)) From Material_Locations Left join BML_POPREPORTING_GREENLIGHTS on Material_Locations.ProdNo = Substring(BML_POPREPORTING_GREENLIGHTS.ProdNo,3,5) Where InUse = 1 and Usable = 1 and FurnitureStatus = 2 and CompleteStatus < 2 and ShrinkwrapStatus < 2 and ProdLineID = '3'"
        cmd202.CommandText = "Select Count(Distinct(Material_Locations.ProdNo)) From Material_Locations Left join BML_POPREPORTING_GREENLIGHTS on Material_Locations.ProdNo = Substring(BML_POPREPORTING_GREENLIGHTS.ProdNo,3,5) Where InUse = 1 and Usable = 1 and FurnitureStatus = 2 and CompleteStatus < 2 and ShrinkwrapStatus < 2 and ProdLineID = '2'"

        cmd123.CommandText = "Select Count(Distinct(Material_Locations.ProdNo)) From Material_Locations Left join BML_POPREPORTING_GREENLIGHTS on Material_Locations.ProdNo = Substring(BML_POPREPORTING_GREENLIGHTS.ProdNo,3,5) Where InUse = 1 and Usable = 1 and FurnitureStatus = 3 and CompleteStatus < 2 and ShrinkwrapStatus < 2"
        cmd203.CommandText = "Select Count(Distinct(Material_Locations.ProdNo)) From Material_Locations Left join BML_POPREPORTING_GREENLIGHTS on Material_Locations.ProdNo = Substring(BML_POPREPORTING_GREENLIGHTS.ProdNo,3,5) Where InUse = 1 and Usable = 1 and FurnitureStatus = 3 and CompleteStatus < 2 and ShrinkwrapStatus < 2 and ProdLineID = '3'"
        cmd204.CommandText = "Select Count(Distinct(Material_Locations.ProdNo)) From Material_Locations Left join BML_POPREPORTING_GREENLIGHTS on Material_Locations.ProdNo = Substring(BML_POPREPORTING_GREENLIGHTS.ProdNo,3,5) Where InUse = 1 and Usable = 1 and FurnitureStatus = 3 and CompleteStatus < 2 and ShrinkwrapStatus < 2 and ProdLineID = '2'"

        cmd124.CommandText = "Select Count(Distinct(Material_Locations.ProdNo)) From Material_Locations Left join BML_POPREPORTING_GREENLIGHTS on Material_Locations.ProdNo = Substring(BML_POPREPORTING_GREENLIGHTS.ProdNo,3,5) Where InUse = 1 and Usable = 1 and FurnitureStatus = 1 and CompleteStatus < 2 and ShrinkwrapStatus < 2"
        cmd205.CommandText = "Select Count(Distinct(Material_Locations.ProdNo)) From Material_Locations Left join BML_POPREPORTING_GREENLIGHTS on Material_Locations.ProdNo = Substring(BML_POPREPORTING_GREENLIGHTS.ProdNo,3,5) Where InUse = 1 and Usable = 1 and FurnitureStatus = 1 and CompleteStatus < 2 and ShrinkwrapStatus < 2 and ProdLineID = '3'"
        cmd206.CommandText = "Select Count(Distinct(Material_Locations.ProdNo)) From Material_Locations Left join BML_POPREPORTING_GREENLIGHTS on Material_Locations.ProdNo = Substring(BML_POPREPORTING_GREENLIGHTS.ProdNo,3,5) Where InUse = 1 and Usable = 1 and FurnitureStatus = 1 and CompleteStatus < 2 and ShrinkwrapStatus < 2 and ProdLineID = '2'"


        cmd200.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where (BuildLoc = 'M' or BuildLoc = 'V') and ShrinkwrapStatus < 2 and ProdNo >= 2100000 and (HelmInstalledStatus = 1 OR CleaningStatus = 1 or  FinalInspectionStatus = 1 or ShrinkwrapStatus = 1)"
        cmd207.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where (BuildLoc = 'M' or BuildLoc = 'V') and ShrinkwrapStatus < 2 and ProdNo >= 2100000 and (HelmInstalledStatus = 1 OR CleaningStatus = 1 or  FinalInspectionStatus = 1 or ShrinkwrapStatus = 1) and ProdLineID = '3'"
        cmd208.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where (BuildLoc = 'M' or BuildLoc = 'V') and ShrinkwrapStatus < 2 and ProdNo >= 2100000 and (HelmInstalledStatus = 1 OR CleaningStatus = 1 or  FinalInspectionStatus = 1 or ShrinkwrapStatus = 1) and ProdLineID = '2'"


        cmd125.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '0' and ProdLineID = '3' and (PF_Received = 1 or PR_Received = 1 or SF_Received = 1 or SR_Received = 1 or PM_Received = 1 or SM_Received = 1 or T_Received = 1)"
        cmd195.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '0' and ProdLineID = '2' and (PF_Received = 1 or PR_Received = 1 or SF_Received = 1 or SR_Received = 1 or PM_Received = 1 or SM_Received = 1 or T_Received = 1)"
        cmd126.CommandText = "Select Count (*) FROM Rails_KittingLocations left join BML_POPREPORTING_GREENLIGHTS on Rails_KittingLocations.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo left join Rails_Tracking on Rails_KittingLocations.ProdNo = Rails_Tracking.ProdNo Where InUse = '1' and HasAllRails = '0' and ProdLineID = '1' and (PF_Received = 1 or PR_Received = 1 or SF_Received = 1 or SR_Received = 1 or PM_Received = 1 or SM_Received = 1 or T_Received = 1)"

        cmd127.CommandText = "Select Count (*) FROM BML_POPREPORTING Left Join BML_POPREPORTING_GREENLIGHTS on BML_POPREPORTING.ProdNo = BML_POPREPORTING_GREENLIGHTS.ProdNo where BML_POPREPORTING_GREENLIGHTS.BuildLoc = 'S' and RailsInstalledStatus = 1 and IsDeckInside = 1 And BML_POPREPORTING.ProdNo > '1999999'"
        cmd128.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = 2 and ProdLineID = '1' and Convert(date,RailsInstalled) ='" & ThisDay & "'"

        cmd130.CommandText = "Select Count(*) From IMLSMST_SQL Where pkg_id = 'PP'"
        cmd131.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and WavetamerStatus = 1 and WavetamerNeeded = 1 and CompleteStatus < 2 and IsInvoiced = 0"
        cmd132.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and SharkhideStatus = 1 and SharkhideNeeded = 1 and CompleteStatus < 2 and IsInvoiced = 0"
        cmd133.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and IsRedTagged = 1 and IsInvoiced = 0 and ProdLineID = '3'"
        cmd196.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and IsRedTagged = 1 and IsInvoiced = 0 and ProdLineID = '2'"
        cmd134.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and IsRedTagged = 1 and IsInvoiced = 0 and ProdLineID = '1'"
        cmd135.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus = '1' and RiggingNeeded = 1 and IsInvoiced = 0"

        cmd136.CommandText = "Select Count(*) FROM Tubes_DamageReported where RepairReqdFlag = 1 and RepairedFlag = 0 and ReportedBy != 'specstube1'"
        cmd137.CommandText = "Select Count(*) FROM Tubes_DamageReported where ReplaceReqdFlag = 1 and ReplacedFlag = 0 and ReportedBy != 'specstube1'"

        cmd197.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmBuildStatus = '2' and ProdLineID = '3' and Convert(date,HelmBuild) ='" & ThisDay & "'"
        cmd198.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmBuildStatus = '2' and ProdLineID = '2' and Convert(date,HelmBuild) ='" & ThisDay & "'"
        cmd199.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmBuildStatus = '2' and ProdLineID = '1' and Convert(date,HelmBuild) ='" & ThisDay & "'"

        'cmd138.CommandText = "Select Count (*) FROM BML_POPREPORTING t1 Left Join BML_POPREPORTING_GREENLIGHTS t2 on t1.ProdNo = t2.ProdNo  where ShrinkwrapStatus = '2' and IsInvoiced = 0"

        conn.Open()

        lblFMain.Text = cmd.ExecuteScalar
        lblFValue.Text = cmd183.ExecuteScalar
        lblFSouth.Text = cmd12.ExecuteScalar
        lblFTotal.Text = Convert.ToInt32(lblFMain.Text) + Convert.ToInt32(lblFSouth.Text) + Convert.ToInt32(lblFValue.Text)

        lblFGMain.Text = cmd2.ExecuteScalar
        lblFGValue.Text = cmd184.ExecuteScalar
        lblFGSouth.Text = cmd13.ExecuteScalar
        lblFGTotal.Text = Convert.ToInt32(lblFGMain.Text) + Convert.ToInt32(lblFGSouth.Text) + Convert.ToInt32(lblFGValue.Text)

        lblCMain.Text = cmd3.ExecuteScalar
        lblCValue.Text = cmd185.ExecuteScalar
        lblCSouth.Text = cmd14.ExecuteScalar
        lblCTotal.Text = Convert.ToInt32(lblCMain.Text) + Convert.ToInt32(lblCSouth.Text) + Convert.ToInt32(lblCValue.Text)

        lblRMain.Text = cmd4.ExecuteScalar
        lblRValue.Text = cmd186.ExecuteScalar
        lblRSouth.Text = cmd15.ExecuteScalar
        lblRTotal.Text = Convert.ToInt32(lblRMain.Text) + Convert.ToInt32(lblRSouth.Text) + Convert.ToInt32(lblRValue.Text)

        lblTMain.Text = cmd5.ExecuteScalar
        lblTValue.Text = cmd187.ExecuteScalar
        lblTSouth.Text = cmd16.ExecuteScalar
        lblTTotal.Text = Convert.ToInt32(lblTMain.Text) + Convert.ToInt32(lblTSouth.Text) + Convert.ToInt32(lblTValue.Text)

        lblCTMain.Text = cmd6.ExecuteScalar
        lblCTValue.Text = cmd188.ExecuteScalar
        lblCTSouth.Text = cmd17.ExecuteScalar
        lblCTTotal.Text = Convert.ToInt32(lblCTMain.Text) + Convert.ToInt32(lblCTSouth.Text) + Convert.ToInt32(lblCTValue.Text)

        lblGMain.Text = cmd7.ExecuteScalar
        lblGValue.Text = cmd189.ExecuteScalar
        lblGSouth.Text = cmd18.ExecuteScalar
        lblGTotal.Text = Convert.ToInt32(lblGMain.Text) + Convert.ToInt32(lblGSouth.Text) + Convert.ToInt32(lblGValue.Text)

        lblHMain.Text = cmd8.ExecuteScalar
        lblHValue.Text = cmd190.ExecuteScalar
        lblHSouth.Text = cmd19.ExecuteScalar
        lblHTotal.Text = Convert.ToInt32(lblHMain.Text) + Convert.ToInt32(lblHSouth.Text) + Convert.ToInt32(lblHValue.Text)

        lblATTotal.Text = cmd9.ExecuteScalar

        lblQFTotal.Text = cmd20.ExecuteScalar

        lblMHelmsBuilt.Text = cmd197.ExecuteScalar
        lblVHelmsBuilt.Text = cmd198.ExecuteScalar
        lblSHelmsBuilt.Text = cmd199.ExecuteScalar
        lblHelmsBuiltTotal.Text = Convert.ToInt32(lblMHelmsBuilt.Text) + Convert.ToInt32(lblSHelmsBuilt.Text) + Convert.ToInt32(lblVHelmsBuilt.Text)

        lblFramesMReady.Text = cmd21.ExecuteScalar
        lblFramesVReady.Text = cmd152.ExecuteScalar
        lblFramesSReady.Text = cmd22.ExecuteScalar
        lblFramesMComplete.Text = cmd23.ExecuteScalar
        lblFramesSComplete.Text = cmd24.ExecuteScalar
        lblFramesVComplete.Text = cmd139.ExecuteScalar

        lblFramesTotalComplete.Text = Convert.ToInt32(lblFramesMComplete.Text) + Convert.ToInt32(lblFramesSComplete.Text) + Convert.ToInt32(lblFramesVComplete.Text)

        lblFloorsMReady.Text = cmd25.ExecuteScalar
        lblFloorsVReady.Text = cmd153.ExecuteScalar
        lblFloorsSReady.Text = cmd26.ExecuteScalar
        lblFloorsMComplete.Text = cmd27.ExecuteScalar
        lblFloorsVComplete.Text = cmd140.ExecuteScalar
        lblFloorsSComplete.Text = cmd28.ExecuteScalar
        lblFloorsTotalComplete.Text = Convert.ToInt32(lblFloorsMComplete.Text) + Convert.ToInt32(lblFloorsSComplete.Text) + Convert.ToInt32(lblFloorsVComplete.Text)

        lblTrimMComplete.Text = cmd106.ExecuteScalar
        lblTrimVComplete.Text = cmd141.ExecuteScalar
        lblTrimSComplete.Text = cmd107.ExecuteScalar
        lblTrimTotalComplete.Text = Convert.ToInt32(lblTrimMComplete.Text) + Convert.ToInt32(lblTrimSComplete.Text) + Convert.ToInt32(lblTrimVComplete.Text)

        lblTrimMReady.Text = cmd108.ExecuteScalar
        lblTrimVReady.Text = cmd154.ExecuteScalar
        lblTrimSReady.Text = cmd109.ExecuteScalar



        lblRailsMReady.Text = cmd29.ExecuteScalar
        lblRailsVReady.Text = cmd155.ExecuteScalar

        lblRailsVComplete.Text = cmd142.ExecuteScalar
        lblRailsMComplete.Text = cmd30.ExecuteScalar


        lblFurnitureMComplete.Text = cmd32.ExecuteScalar
        lblFurnitureVComplete.Text = cmd143.ExecuteScalar
        lblFurnitureSComplete.Text = cmd99.ExecuteScalar
        lblFurnitureTotalComplete.Text = Convert.ToInt32(lblFurnitureMComplete.Text) + Convert.ToInt32(lblFurnitureSComplete.Text) + Convert.ToInt32(lblFurnitureVComplete.Text)

        lblHelmMComplete.Text = cmd33.ExecuteScalar
        lblHelmVComplete.Text = cmd144.ExecuteScalar
        lblHelmSComplete.Text = cmd91.ExecuteScalar
        lblHelmTotalComplete.Text = Convert.ToInt32(lblHelmMComplete.Text) + Convert.ToInt32(lblHelmSComplete.Text) + Convert.ToInt32(lblHelmVComplete.Text)

        lblCleaningMComplete.Text = cmd34.ExecuteScalar
        lblCleaningVComplete.Text = cmd145.ExecuteScalar
        lblCleaningSComplete.Text = cmd92.ExecuteScalar
        lblCleaningTotalComplete.Text = Convert.ToInt32(lblCleaningMComplete.Text) + Convert.ToInt32(lblCleaningSComplete.Text) + Convert.ToInt32(lblCleaningVComplete.Text)

        lblInspectionMComplete.Text = cmd35.ExecuteScalar
        lblInspectionVComplete.Text = cmd146.ExecuteScalar
        lblInspectionSComplete.Text = cmd93.ExecuteScalar
        lblInspectionTotalComplete.Text = Convert.ToInt32(lblInspectionMComplete.Text) + Convert.ToInt32(lblInspectionSComplete.Text) + Convert.ToInt32(lblInspectionVComplete.Text)

        'Ready
        lblShrinkMReady.Text = cmd36.ExecuteScalar
        lblShrinkVReady.Text = cmd160.ExecuteScalar
        lblShrinkSReady.Text = cmd98.ExecuteScalar

        lblShrinkMComplete.Text = cmd37.ExecuteScalar
        lblShrinkVComplete.Text = cmd147.ExecuteScalar
        lblShrinkSComplete.Text = cmd38.ExecuteScalar
        lblShrinkTotalComplete.Text = Convert.ToInt32(lblShrinkMComplete.Text) + Convert.ToInt32(lblShrinkSComplete.Text) + Convert.ToInt32(lblShrinkVComplete.Text)

        lblRiggingMReady.Text = cmd39.ExecuteScalar
        lblRiggingVReady.Text = cmd161.ExecuteScalar
        lblRiggingSReady.Text = cmd40.ExecuteScalar
        lblRiggingMComplete.Text = cmd41.ExecuteScalar
        lblRiggingVComplete.Text = cmd148.ExecuteScalar
        lblRiggingSComplete.Text = cmd42.ExecuteScalar
        lblRiggingTotalComplete.Text = Convert.ToInt32(lblRiggingMComplete.Text) + Convert.ToInt32(lblRiggingSComplete.Text) + Convert.ToInt32(lblRiggingVComplete.Text)

        lblWTMReady.Text = cmd43.ExecuteScalar
        lblWTVReady.Text = cmd162.ExecuteScalar
        lblWTSReady.Text = cmd44.ExecuteScalar
        lblWTMComplete.Text = cmd45.ExecuteScalar
        lblWTVComplete.Text = cmd149.ExecuteScalar
        lblWTSComplete.Text = cmd46.ExecuteScalar
        lblWTTotalComplete.Text = Convert.ToInt32(lblWTMComplete.Text) + Convert.ToInt32(lblWTSComplete.Text) + Convert.ToInt32(lblWTVComplete.Text)

        lblSharkhideMReady.Text = cmd47.ExecuteScalar
        lblSharkhideVReady.Text = cmd163.ExecuteScalar
        lblSharkhideSReady.Text = cmd48.ExecuteScalar
        lblSharkhideMComplete.Text = cmd49.ExecuteScalar
        lblSharkhideVComplete.Text = cmd150.ExecuteScalar
        lblSharkhideSComplete.Text = cmd50.ExecuteScalar
        lblSharkhideTotalComplete.Text = Convert.ToInt32(lblSharkhideMComplete.Text) + Convert.ToInt32(lblSharkhideSComplete.Text) + Convert.ToInt32(lblSharkhideVComplete.Text)

        lblCompleteM.Text = cmd51.ExecuteScalar
        lblCompleteV.Text = cmd151.ExecuteScalar
        lblCompleteS.Text = cmd52.ExecuteScalar
        lblCompleteTotal.Text = Convert.ToInt32(lblCompleteM.Text) + Convert.ToInt32(lblCompleteS.Text) + Convert.ToInt32(lblCompleteV.Text)

        lblFurnitureMReady.Text = cmd53.ExecuteScalar
        lblFurnitureVReady.Text = cmd156.ExecuteScalar
        lblFurnitureSReady.Text = cmd94.ExecuteScalar

        lblHelmMReady.Text = cmd54.ExecuteScalar
        lblHelmVReady.Text = cmd157.ExecuteScalar
        lblHelmSReady.Text = cmd95.ExecuteScalar

        lblCleaningMReady.Text = cmd55.ExecuteScalar
        lblCleaningVReady.Text = cmd158.ExecuteScalar
        lblCleaningSReady.Text = cmd96.ExecuteScalar

        lblFinalInspectionMReady.Text = cmd56.ExecuteScalar
        lblFinalInspectionVReady.Text = cmd159.ExecuteScalar
        lblFinalInspectionSReady.Text = cmd97.ExecuteScalar

        'South Stats
        lblBroughtIn.Text = cmd31.ExecuteScalar
        lblRailsSComplete.Text = cmd128.ExecuteScalar
        lblRailsTotalComplete.Text = Convert.ToInt32(lblRailsMComplete.Text) + Convert.ToInt32(lblRailsSComplete.Text) + Convert.ToInt32(lblRailsVComplete.Text)

        lblWip.Text = cmd57.ExecuteScalar
        lblInProgressS.Text = lblWip.Text
        lblDecks.Text = cmd58.ExecuteScalar
        lblSouthReady.Text = cmd59.ExecuteScalar
        lblRailsSReady.Text = cmd127.ExecuteScalar



        lblOfflineM.Text = cmd60.ExecuteScalar
        lblOfflineV.Text = cmd166.ExecuteScalar
        lblOfflineS.Text = cmd61.ExecuteScalar
        lblOfflineTotal.Text = Convert.ToInt32(lblOfflineM.Text) + Convert.ToInt32(lblOfflineS.Text) + Convert.ToInt32(lblOfflineV.Text)

        lblFrameStacksS.Text = cmd10.ExecuteScalar
        lblFrameStacksV.Text = cmd167.ExecuteScalar
        lblFrameStacksM.Text = cmd90.ExecuteScalar
        lblFrameStacksTotal.Text = Convert.ToInt32(lblFrameStacksM.Text) + Convert.ToInt32(lblFrameStacksS.Text) + Convert.ToInt32(lblFrameStacksV.Text)

        conn2.Open()
        RGAsM.Text = cmd62.ExecuteScalar
        RGAsV.Text = cmd181.ExecuteScalar
        RGAsS.Text = cmd63.ExecuteScalar
        BOsM.Text = cmd64.ExecuteScalar
        BOsV.Text = cmd182.ExecuteScalar
        BOsS.Text = cmd65.ExecuteScalar

        RGAsTotal.Text = Convert.ToInt32(RGAsM.Text) + Convert.ToInt32(RGAsS.Text) + Convert.ToInt32(RGAsV.Text)
        BOsTotal.Text = Convert.ToInt32(BOsM.Text) + Convert.ToInt32(BOsS.Text) + Convert.ToInt32(BOsV.Text)
        conn2.Close()

        'Past Due
        maincount = Convert.ToInt16(cmd67.ExecuteScalar())
        southcount = Convert.ToInt16(cmd68.ExecuteScalar())
        valuecount = Convert.ToInt16(cmd191.ExecuteScalar())

        lblShrinkedAhead.Text = cmd66.ExecuteScalar
        lblMainAhead.Text = cmd69.ExecuteScalar
        lblValueAhead.Text = cmd192.ExecuteScalar
        lblSouthAhead.Text = cmd70.ExecuteScalar

        lblMain.Text = maincount
        lblValue.Text = valuecount
        lblSouth.Text = southcount

        lblMainDiff.Text = Convert.ToInt16(lblMainAhead.Text) - Convert.ToInt16(lblMain.Text)
        lblValueDiff.Text = Convert.ToInt16(lblValueAhead.Text) - Convert.ToInt16(lblValue.Text)
        lblSouthDiff.Text = Convert.ToInt16(lblSouthAhead.Text) - Convert.ToInt16(lblSouth.Text)
        lblTotalBehind.Text = maincount + southcount + valuecount
        lblScore.Text = Convert.ToInt16(lblShrinkedAhead.Text) - Convert.ToInt16(lblTotalBehind.Text)

        'Stock Level
        lblFurnStockM.Text = cmd71.ExecuteScalar
        lblFurnStockV.Text = cmd173.ExecuteScalar
        lblFurnStockS.Text = cmd72.ExecuteScalar
        lblFurnStockTotal.Text = Convert.ToInt32(lblFurnStockM.Text) + Convert.ToInt32(lblFurnStockS.Text) + Convert.ToInt32(lblFurnStockV.Text)

        lblFGStockM.Text = cmd73.ExecuteScalar
        lblFGStockV.Text = cmd174.ExecuteScalar
        lblFGStockS.Text = cmd74.ExecuteScalar
        lblFGStockTotal.Text = Convert.ToInt32(lblFGStockM.Text) + Convert.ToInt32(lblFGStockS.Text) + Convert.ToInt32(lblFGStockV.Text)

        lblCanvasStockM.Text = cmd75.ExecuteScalar
        lblCanvasStockV.Text = cmd175.ExecuteScalar
        lblCanvasStockS.Text = cmd76.ExecuteScalar
        lblCanvasStockTotal.Text = Convert.ToInt32(lblCanvasStockM.Text) + Convert.ToInt32(lblCanvasStockS.Text) + Convert.ToInt32(lblCanvasStockV.Text)

        lblRailsStockM.Text = cmd77.ExecuteScalar
        lblRailsStockV.Text = cmd176.ExecuteScalar
        lblRailsStockS.Text = cmd78.ExecuteScalar
        lblRailsStockTotal.Text = Convert.ToInt32(lblRailsStockM.Text) + Convert.ToInt32(lblRailsStockS.Text) + Convert.ToInt32(lblRailsStockV.Text)

        lblTubeStockM.Text = cmd79.ExecuteScalar
        lblTubeStockV.Text = cmd177.ExecuteScalar
        lblTubeStockS.Text = cmd80.ExecuteScalar
        lblTubeStockTotal.Text = Convert.ToInt32(lblTubeStockM.Text) + Convert.ToInt32(lblTubeStockS.Text) + Convert.ToInt32(lblTubeStockV.Text)

        lblCTStockM.Text = cmd81.ExecuteScalar
        lblCTStockV.Text = cmd178.ExecuteScalar
        lblCTStockS.Text = cmd82.ExecuteScalar
        lblCTStockTotal.Text = Convert.ToInt32(lblCTStockM.Text) + Convert.ToInt32(lblCTStockS.Text) + Convert.ToInt32(lblCTStockV.Text)

        lblGaugeStockM.Text = cmd83.ExecuteScalar
        lblGaugeStockV.Text = cmd179.ExecuteScalar
        lblGaugeStockS.Text = cmd84.ExecuteScalar
        lblGaugeStockTotal.Text = Convert.ToInt32(lblGaugeStockM.Text) + Convert.ToInt32(lblGaugeStockS.Text) + Convert.ToInt32(lblGaugeStockV.Text)

        lblHarnessStockM.Text = cmd85.ExecuteScalar
        lblHarnessStockV.Text = cmd180.ExecuteScalar
        lblHarnessStockS.Text = cmd86.ExecuteScalar
        lblHarnessStockTotal.Text = Convert.ToInt32(lblHarnessStockM.Text) + Convert.ToInt32(lblHarnessStockS.Text) + Convert.ToInt32(lblHarnessStockV.Text)

        lblATStockTotal.Text = cmd87.ExecuteScalar
        lblQFrontStockTotal.Text = cmd88.ExecuteScalar


        lblInProgressM.Text = cmd89.ExecuteScalar
        lblInProgressV.Text = cmd168.ExecuteScalar
        lblInProgressTotal.Text = Convert.ToInt32(lblInProgressM.Text) + Convert.ToInt32(lblInProgressS.Text) + Convert.ToInt32(lblInProgressV.Text)

        lblMainPastDueWIP.Text = cmd100.ExecuteScalar
        lblValuePastDueWIP.Text = cmd169.ExecuteScalar
        lblSouthPastDueWIP.Text = cmd101.ExecuteScalar
        lblTotalPastDueWIP.Text = Convert.ToInt32(lblMainPastDueWIP.Text) + Convert.ToInt32(lblSouthPastDueWIP.Text) + Convert.ToInt32(lblValuePastDueWIP.Text)

        lblRailsPulledMNotFramed.Text = cmd102.ExecuteScalar
        lblRailsPulledVNotFramed.Text = cmd170.ExecuteScalar
        lblRailsPulledSNotFramed.Text = cmd103.ExecuteScalar
        lblRailsPulledTotalNotFramed.Text = Convert.ToInt32(lblRailsPulledMNotFramed.Text) + Convert.ToInt32(lblRailsPulledSNotFramed.Text) + Convert.ToInt32(lblRailsPulledVNotFramed.Text)

        lblRailsPulledMFramed.Text = cmd104.ExecuteScalar
        lblRailsPulledVFramed.Text = cmd171.ExecuteScalar
        lblRailsPulledSFramed.Text = cmd105.ExecuteScalar
        lblRailsPulledTotalFramed.Text = Convert.ToInt32(lblRailsPulledMFramed.Text) + Convert.ToInt32(lblRailsPulledSFramed.Text) + Convert.ToInt32(lblRailsPulledVFramed.Text)

        lblRailsYellow.Text = cmd110.ExecuteScalar
        lblRailsOrange.Text = cmd111.ExecuteScalar
        lblRailsTan.Text = cmd129.ExecuteScalar
        lblRailsBlue.Text = cmd112.ExecuteScalar
        lblRailsGreen.Text = cmd113.ExecuteScalar

        lblRailsVGreen.Text = cmd165.ExecuteScalar
        lblRailsVBlue.Text = cmd164.ExecuteScalar

        lblEmtpySlots.Text = cmd114.ExecuteScalar

        lblHasAllRails.Text = cmd115.ExecuteScalar
        lblHasAllRailsM.Text = cmd116.ExecuteScalar
        lblHasAllRailsV.Text = cmd194.ExecuteScalar
        lblHasAllRailsS.Text = cmd117.ExecuteScalar

        lblReadyNeedsFramedM.Text = cmd118.ExecuteScalar
        lblReadyNeedsFramedV.Text = cmd172.ExecuteScalar
        lblReadyNeedsFramedS.Text = cmd119.ExecuteScalar
        lblReadyNeedsFramedTotal.Text = Convert.ToInt32(lblReadyNeedsFramedM.Text) + Convert.ToInt32(lblReadyNeedsFramedS.Text) + Convert.ToInt32(lblReadyNeedsFramedV.Text)

        lblHealthS.Text = lblSouthReady.Text
        lblHealthM.Text = Convert.ToInt32(lblFloorsMReady.Text) + Convert.ToInt32(lblRailsGreen.Text) + Convert.ToInt32(lblRailsPulledMFramed.Text) + Convert.ToInt32(lblRailsPulledMNotFramed.Text) + Convert.ToInt32(lblReadyNeedsFramedM.Text)
        lblHealthV.Text = Convert.ToInt32(lblFloorsVReady.Text) + Convert.ToInt32(lblRailsVGreen.Text) + Convert.ToInt32(lblRailsPulledVFramed.Text) + Convert.ToInt32(lblRailsPulledVNotFramed.Text) + Convert.ToInt32(lblReadyNeedsFramedV.Text)

        'furn map status

        lblFurnEmptySpaces.Text = cmd120.ExecuteScalar
        lblFurnDisabledSpaces.Text = cmd121.ExecuteScalar
        lblFurnGreen.Text = cmd122.ExecuteScalar
        lblFurnGreenB3.Text = cmd201.ExecuteScalar
        lblFurnGreenB2.Text = cmd202.ExecuteScalar

        lblFurnYellowRed.Text = cmd123.ExecuteScalar
        lblFurnYellowRedB3.Text = cmd203.ExecuteScalar
        lblFurnYellowRedB2.Text = cmd204.ExecuteScalar

        lblFurnYellow.Text = cmd124.ExecuteScalar
        lblFurnYellowB3.Text = cmd205.ExecuteScalar
        lblFurnYellowB2.Text = cmd206.ExecuteScalar

        lblWIPWFurn.Text = cmd200.ExecuteScalar
        lblWIPWFurnB3.Text = cmd207.ExecuteScalar
        lblWIPWFurnB2.Text = cmd208.ExecuteScalar

        lblFurnWIPandRacks.Text = Convert.ToInt32(lblWIPWFurn.Text) + Convert.ToInt32(lblFurnGreen.Text) + Convert.ToInt32(lblFurnYellow.Text) + Convert.ToInt32(lblFurnYellowRed.Text)
        lblFurnWIPandRacksB3.Text = Convert.ToInt32(lblWIPWFurnB3.Text) + Convert.ToInt32(lblFurnGreenB3.Text) + Convert.ToInt32(lblFurnYellowB3.Text) + Convert.ToInt32(lblFurnYellowRedB3.Text)
        lblFurnWIPandRacksB2.Text = Convert.ToInt32(lblWIPWFurnB2.Text) + Convert.ToInt32(lblFurnGreenB2.Text) + Convert.ToInt32(lblFurnYellowB2.Text) + Convert.ToInt32(lblFurnYellowRedB2.Text)

        lblMSomeRails.Text = cmd125.ExecuteScalar
        lblValueSomeRails.Text = cmd195.ExecuteScalar
        lblSouthSomeRails.Text = cmd126.ExecuteScalar
        lblTotalSomeRails.Text = Convert.ToInt32(lblMSomeRails.Text) + Convert.ToInt32(lblSouthSomeRails.Text) + Convert.ToInt32(lblValueSomeRails.Text)

        lblWTInYard.Text = cmd131.ExecuteScalar
        lblSHInYard.Text = cmd132.ExecuteScalar
        lblRedTagsMInYard.Text = cmd133.ExecuteScalar
        lblRedTagsVInYard.Text = cmd196.ExecuteScalar
        lblRedTagsSInYard.Text = cmd134.ExecuteScalar
        lblRigInYard.Text = cmd135.ExecuteScalar
        lblTubeRpl.Text = cmd137.ExecuteScalar
        lblTubeRpr.Text = cmd136.ExecuteScalar



        'conn2.Close()

        'conn1.Open()
        'lblFinGoods.Text = cmd130.ExecuteScalar()
        'lblInYard.Text = Convert.ToInt32(lblFinGoods.Text) + Convert.ToInt32(lblWTInYard.Text) + Convert.ToInt32(lblSHInYard.Text) + Convert.ToInt32(lblRigInYard.Text) + Convert.ToInt32(lblRedTagsMInYard.Text) + Convert.ToInt32(lblRedTagsSInYard.Text) + Convert.ToInt32(lblTubeRpl.Text) + Convert.ToInt32(lblTubeRpr.Text)

        conn.Close()
        'conn1.Close()

    End Sub
End Class
