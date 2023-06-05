Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration

Partial Class Overview
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub


    'Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)

    'gvOverview.DataBind()

    'End Sub

    Private Shared Sub AddSuperHeader(gridView As GridView)
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

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

        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr

        Dim furnitureprepcount As Int16 = 0
        Dim fiberglassprepcount As Int16 = 0
        Dim coverscount As Int16 = 0
        Dim railsprepcount As Int16 = 0
        Dim tubesprepcount As Int16 = 0

        Dim framescountM As Int16 = 0
        Dim floorscountM As Int16 = 0
        Dim trimcountM As Int16 = 0
        Dim railscountM As Int16 = 0
        Dim furniturecountM As Int16 = 0
        Dim helmcountM As Int16 = 0
        Dim cleaningcountM As Int16 = 0
        Dim finalcountM As Int16 = 0
        Dim shrinkwrapcountM As Int16 = 0
        Dim wavetamercountM As Int16 = 0
        Dim sharkhidecountM As Int16 = 0
        Dim completecountM As Int16 = 0
        ' Dim offlinecount As Int16 = 0
        Dim centertubecountM As Int16 = 0
        Dim riggingcountM As Int16 = 0

        Dim framescountV As Int16 = 0
        Dim floorscountV As Int16 = 0
        Dim trimcountV As Int16 = 0
        Dim railscountV As Int16 = 0
        Dim furniturecountV As Int16 = 0
        Dim helmcountV As Int16 = 0
        Dim cleaningcountV As Int16 = 0
        Dim finalcountV As Int16 = 0
        Dim shrinkwrapcountV As Int16 = 0
        Dim wavetamercountV As Int16 = 0
        Dim sharkhidecountV As Int16 = 0
        Dim completecountV As Int16 = 0
        ' Dim offlinecountV As Int16 = 0
        Dim centertubecountV As Int16 = 0
        Dim riggingcountV As Int16 = 0


        Dim framescountS As Int16 = 0
        Dim floorscountS As Int16 = 0
        Dim trimcountS As Int16 = 0
        Dim railscountS As Int16 = 0
        Dim furniturecountS As Int16 = 0
        Dim helmcountS As Int16 = 0
        Dim cleaningcountS As Int16 = 0
        Dim finalcountS As Int16 = 0
        Dim shrinkwrapcountS As Int16 = 0
        Dim wavetamercountS As Int16 = 0
        Dim sharkhidecountS As Int16 = 0
        Dim completecountS As Int16 = 0
        Dim offlinecountS As Int16 = 0
        Dim centertubecountS As Int16 = 0
        Dim riggingcountS As Int16 = 0


        cmd.CommandType = CommandType.Text
        cmd2.CommandType = CommandType.Text
        cmd3.CommandType = CommandType.Text
        cmd4.CommandType = CommandType.Text
        cmd5.CommandType = CommandType.Text
        cmd6.CommandType = CommandType.Text
        cmd7.CommandType = CommandType.Text
        cmd8.CommandType = CommandType.Text
        cmd9.CommandType = CommandType.Text
        cmd10.CommandType = CommandType.Text
        cmd11.CommandType = CommandType.Text
        cmd12.CommandType = CommandType.Text
        cmd13.CommandType = CommandType.Text
        cmd14.CommandType = CommandType.Text
        cmd15.CommandType = CommandType.Text
        cmd16.CommandType = CommandType.Text
        cmd17.CommandType = CommandType.Text
        cmd18.CommandType = CommandType.Text
        cmd19.CommandType = CommandType.Text


        cmd20.CommandType = CommandType.Text
        cmd21.CommandType = CommandType.Text
        cmd22.CommandType = CommandType.Text
        cmd23.CommandType = CommandType.Text
        cmd24.CommandType = CommandType.Text
        cmd25.CommandType = CommandType.Text
        cmd26.CommandType = CommandType.Text
        cmd27.CommandType = CommandType.Text
        cmd29.CommandType = CommandType.Text
        cmd30.CommandType = CommandType.Text
        cmd31.CommandType = CommandType.Text
        cmd32.CommandType = CommandType.Text
        cmd33.CommandType = CommandType.Text
        cmd34.CommandType = CommandType.Text
        cmd35.CommandType = CommandType.Text


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


        cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureStatus = '2' and Convert(date,FurniturePrepLastUpdated) ='" & ThisDay & "'"
        cmd2.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FiberglassStatus = '2' and Convert(date,FiberglassLastUpdated) ='" & ThisDay & "'"
        cmd3.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CoversStatus = '2' and Convert(date,CoversLastUpdated) ='" & ThisDay & "'"
        cmd4.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsStatus = '2' and Convert(date,RailsLastUpdated) ='" & ThisDay & "'"
        cmd5.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TubesStatus = '2' and Convert(date,TubesLastUpdated) ='" & ThisDay & "'"

        cmd6.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = '2' and BuildLoc = 'M' and Convert(date,FramesInstalled) ='" & ThisDay & "'"
        cmd7.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = '2' and BuildLoc = 'M' and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
        cmd34.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = '2' and BuildLoc = 'M' and Convert(date,Trim) ='" & ThisDay & "'"


        cmd8.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = '2' and BuildLoc = 'M' and Convert(date,RailsInstalled) ='" & ThisDay & "'"
        cmd9.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureInstalledStatus = '2' and BuildLoc = 'M' and Convert(date,FurnitureInstalled) ='" & ThisDay & "'"
        cmd10.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmInstalledStatus = '2' and BuildLoc = 'M' and Convert(date,HelmInstalled) ='" & ThisDay & "'"
        cmd11.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = '2' and BuildLoc = 'M' and Convert(date,Cleaning) ='" & ThisDay & "'"
        cmd12.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and BuildLoc = 'M' and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
        cmd13.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where WavetamerStatus = '2' and BuildLoc = 'M' and Convert(date,WaveTamerInstalled) ='" & ThisDay & "'"
        cmd14.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FinalInspectionStatus = '2' and BuildLoc = 'M' and Convert(date,FinalInspection) ='" & ThisDay & "'"
        cmd15.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where SharkhideStatus = '2' and BuildLoc = 'M' and Convert(date,SharkhideInstalled) ='" & ThisDay & "'"
        cmd16.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CompleteStatus = '2' and BuildLoc = 'M' and Convert(date,Complete) ='" & ThisDay & "'"
        cmd17.CommandText = "Select Count (*) FROM BML_POPREPORTING_OFFLINE where StatusSetTo = 'Offline' and Convert(date,Date) ='" & ThisDay & "'"
        cmd18.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = '2' and BuildLoc = 'M' and Convert(date,Centertube) ='" & ThisDay & "'"
        cmd19.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus = '2' and BuildLoc = 'M' and Convert(date,Rigging) ='" & ThisDay & "'"


        cmd20.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = '2' and BuildLoc = 'S' and Convert(date,FramesInstalled) ='" & ThisDay & "'"
        cmd21.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = '2' and BuildLoc = 'S' and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
        cmd35.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = '2' and BuildLoc = 'S' and Convert(date,Trim) ='" & ThisDay & "'"

        cmd22.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = '2' and BuildLoc = 'S' and Convert(date,RailsInstalled) ='" & ThisDay & "'"
        cmd23.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureInstalledStatus = '2' and BuildLoc = 'S' and Convert(date,FurnitureInstalled) ='" & ThisDay & "'"
        cmd24.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmInstalledStatus = '2' and BuildLoc = 'S' and Convert(date,HelmInstalled) ='" & ThisDay & "'"
        cmd25.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = '2' and BuildLoc = 'S' and Convert(date,Cleaning) ='" & ThisDay & "'"
        cmd26.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and BuildLoc = 'S' and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
        cmd27.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where WavetamerStatus = '2' and BuildLoc = 'S' and Convert(date,WaveTamerInstalled) ='" & ThisDay & "'"
        cmd28.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FinalInspectionStatus = '2'  and BuildLoc = 'S' and Convert(date,FinalInspection) ='" & ThisDay & "'"
        cmd29.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where SharkhideStatus = '2' and BuildLoc = 'S' and Convert(date,SharkhideInstalled) ='" & ThisDay & "'"
        cmd30.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CompleteStatus = '2' and BuildLoc = 'S' and Convert(date,Complete) ='" & ThisDay & "'"
        'cmd31.CommandText = "Select Count (*) FROM BML_POPREPORTING_OFFLINE where StatusSetTo = 'Offline' and BuildLoc = 'S' and Convert(date,Date) ='" & ThisDay & "'"
        cmd32.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = '2' and BuildLoc = 'S' and Convert(date,Centertube) ='" & ThisDay & "'"
        cmd33.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus = '2' and BuildLoc = 'S' and Convert(date,Rigging) ='" & ThisDay & "'"

        cmd36.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FramesInstalledStatus = '2' and BuildLoc = 'V' and Convert(date,FramesInstalled) ='" & ThisDay & "'"
        cmd37.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FloorsInstalledStatus = '2' and BuildLoc = 'V' and Convert(date,FloorsInstalled) ='" & ThisDay & "'"
        cmd38.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where TrimStatus = '2' and BuildLoc = 'V' and Convert(date,Trim) ='" & ThisDay & "'"
        cmd39.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RailsInstalledStatus = '2' and BuildLoc = 'V' and Convert(date,RailsInstalled) ='" & ThisDay & "'"
        cmd40.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnitureInstalledStatus = '2' and BuildLoc = 'V' and Convert(date,FurnitureInstalled) ='" & ThisDay & "'"
        cmd41.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where HelmInstalledStatus = '2' and BuildLoc = 'V' and Convert(date,HelmInstalled) ='" & ThisDay & "'"
        cmd42.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CleaningStatus = '2' and BuildLoc = 'V' and Convert(date,Cleaning) ='" & ThisDay & "'"
        cmd43.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where ShrinkwrapStatus = '2' and BuildLoc = 'V' and Convert(date,Shrinkwrap) ='" & ThisDay & "'"
        cmd44.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where WavetamerStatus = '2' and BuildLoc = 'V' and Convert(date,WaveTamerInstalled) ='" & ThisDay & "'"
        cmd45.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FinalInspectionStatus = '2' and BuildLoc = 'V' and Convert(date,FinalInspection) ='" & ThisDay & "'"
        cmd46.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where SharkhideStatus = '2' and BuildLoc = 'V' and Convert(date,SharkhideInstalled) ='" & ThisDay & "'"
        cmd47.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CompleteStatus = '2' and BuildLoc = 'V' and Convert(date,Complete) ='" & ThisDay & "'"
        cmd48.CommandText = "Select Count (*) FROM BML_POPREPORTING_OFFLINE where StatusSetTo = 'Offline' and Convert(date,Date) ='" & ThisDay & "'"
        cmd49.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where CentertubeStatus = '2'  and  BuildLoc = 'V' and Convert(date,Centertube) ='" & ThisDay & "'"
        cmd50.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where RiggingStatus = '2' and BuildLoc = 'V' and Convert(date,Rigging) ='" & ThisDay & "'"

        conn.Open()
        furnitureprepcount = Convert.ToInt16(cmd.ExecuteScalar())
        fiberglassprepcount = Convert.ToInt16(cmd2.ExecuteScalar())
        coverscount = Convert.ToInt16(cmd3.ExecuteScalar())
        railsprepcount = Convert.ToInt16(cmd4.ExecuteScalar())
        tubesprepcount = Convert.ToInt16(cmd5.ExecuteScalar())

        framescountM = Convert.ToInt16(cmd6.ExecuteScalar())
        floorscountM = Convert.ToInt16(cmd7.ExecuteScalar())
        trimcountM = Convert.ToInt16(cmd34.ExecuteScalar)
        railscountM = Convert.ToInt16(cmd8.ExecuteScalar())
        furniturecountM = Convert.ToInt16(cmd9.ExecuteScalar())
        helmcountM = Convert.ToInt16(cmd10.ExecuteScalar())
        cleaningcountM = Convert.ToInt16(cmd11.ExecuteScalar())
        shrinkwrapcountM = Convert.ToInt16(cmd12.ExecuteScalar())
        wavetamercountM = Convert.ToInt16(cmd13.ExecuteScalar())
        finalcountM = Convert.ToInt16(cmd14.ExecuteScalar())
        sharkhidecountM = Convert.ToInt16(cmd15.ExecuteScalar())
        completecountM = Convert.ToInt16(cmd16.ExecuteScalar())
        'offlinecount = Convert.ToInt16(cmd17.ExecuteScalar())
        centertubecountM = Convert.ToInt16(cmd18.ExecuteScalar())
        riggingcountM = Convert.ToInt16(cmd19.ExecuteScalar())

        framescountV = Convert.ToInt16(cmd36.ExecuteScalar())
        floorscountV = Convert.ToInt16(cmd37.ExecuteScalar())
        trimcountV = Convert.ToInt16(cmd38.ExecuteScalar)
        railscountV = Convert.ToInt16(cmd39.ExecuteScalar())
        furniturecountV = Convert.ToInt16(cmd40.ExecuteScalar())
        helmcountV = Convert.ToInt16(cmd41.ExecuteScalar())
        cleaningcountV = Convert.ToInt16(cmd42.ExecuteScalar())
        shrinkwrapcountV = Convert.ToInt16(cmd43.ExecuteScalar())
        wavetamercountV = Convert.ToInt16(cmd44.ExecuteScalar())
        finalcountV = Convert.ToInt16(cmd45.ExecuteScalar())
        sharkhidecountV = Convert.ToInt16(cmd46.ExecuteScalar())
        completecountV = Convert.ToInt16(cmd47.ExecuteScalar())
        'offlinecount = Convert.ToInt16(cmd48.ExecuteScalar())
        centertubecountV = Convert.ToInt16(cmd49.ExecuteScalar())
        riggingcountV = Convert.ToInt16(cmd50.ExecuteScalar())


        framescountS = Convert.ToInt16(cmd20.ExecuteScalar())
        floorscountS = Convert.ToInt16(cmd21.ExecuteScalar())
        trimcountS = Convert.ToInt16(cmd35.ExecuteScalar())
        railscountS = Convert.ToInt16(cmd22.ExecuteScalar())
        furniturecountS = Convert.ToInt16(cmd23.ExecuteScalar())
        helmcountS = Convert.ToInt16(cmd24.ExecuteScalar())
        cleaningcountS = Convert.ToInt16(cmd25.ExecuteScalar())
        shrinkwrapcountS = Convert.ToInt16(cmd26.ExecuteScalar())
        wavetamercountS = Convert.ToInt16(cmd27.ExecuteScalar())
        finalcountS = Convert.ToInt16(cmd28.ExecuteScalar())
        sharkhidecountS = Convert.ToInt16(cmd29.ExecuteScalar())
        completecountS = Convert.ToInt16(cmd30.ExecuteScalar())
        'offlinecountS = Convert.ToInt16(cmd31.ExecuteScalar())
        centertubecountS = Convert.ToInt16(cmd32.ExecuteScalar())
        riggingcountS = Convert.ToInt16(cmd33.ExecuteScalar())



        conn.Close()

        'all of this code adds a header above the gv header so that I can display the totals.
        Dim myTable = DirectCast(gridView.Controls(0), Table)
        Dim myNewRow = New GridViewRow(0, -1, DataControlRowType.Header, DataControlRowState.Normal)
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())

        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell("Main"))
        myNewRow.Cells.Add(MakeCell(framescountM, 1))
        myNewRow.Cells.Add(MakeCell(floorscountM, 1))
        myNewRow.Cells.Add(MakeCell(trimcountM, 1))
        myNewRow.Cells.Add(MakeCell(railscountM, 1))
        myNewRow.Cells.Add(MakeCell(furniturecountM, 1))
        myNewRow.Cells.Add(MakeCell(helmcountM, 1))
        myNewRow.Cells.Add(MakeCell(cleaningcountM, 1))
        myNewRow.Cells.Add(MakeCell(finalcountM, 1))
        myNewRow.Cells.Add(MakeCell(shrinkwrapcountM, 1))
        myNewRow.Cells.Add(MakeCell(riggingcountM, 1))
        myNewRow.Cells.Add(MakeCell(wavetamercountM, 1))
        myNewRow.Cells.Add(MakeCell(sharkhidecountM, 1))
        myNewRow.Cells.Add(MakeCell(completecountM, 1))
        myNewRow.Cells.Add(MakeCell())
        myNewRow.Cells.Add(MakeCell())
        myTable.Rows.AddAt(0, myNewRow)

        'Row 1

        Dim myNewRow1 = New GridViewRow(0, -1, DataControlRowType.Header, DataControlRowState.Normal)
        myNewRow1.Cells.Add(MakeCell())
        myNewRow1.Cells.Add(MakeCell())
        myNewRow1.Cells.Add(MakeCell())
        myNewRow1.Cells.Add(MakeCell())
        myNewRow1.Cells.Add(MakeCell())
        myNewRow1.Cells.Add(MakeCell())
        myNewRow1.Cells.Add(MakeCell())
        myNewRow1.Cells.Add(MakeCell())
        myNewRow1.Cells.Add(MakeCell())

        myNewRow1.Cells.Add(MakeCell())
        myNewRow1.Cells.Add(MakeCell("Value"))
        myNewRow1.Cells.Add(MakeCell(framescountV, 1))
        myNewRow1.Cells.Add(MakeCell(floorscountV, 1))
        myNewRow1.Cells.Add(MakeCell(trimcountV, 1))
        myNewRow1.Cells.Add(MakeCell(railscountV, 1))
        myNewRow1.Cells.Add(MakeCell(furniturecountV, 1))
        myNewRow1.Cells.Add(MakeCell(helmcountV, 1))
        myNewRow1.Cells.Add(MakeCell(cleaningcountV, 1))
        myNewRow1.Cells.Add(MakeCell(finalcountV, 1))
        myNewRow1.Cells.Add(MakeCell(shrinkwrapcountV, 1))
        myNewRow1.Cells.Add(MakeCell(riggingcountV, 1))
        myNewRow1.Cells.Add(MakeCell(wavetamercountV, 1))
        myNewRow1.Cells.Add(MakeCell(sharkhidecountV, 1))
        myNewRow1.Cells.Add(MakeCell(completecountV, 1))
        myNewRow1.Cells.Add(MakeCell())
        myNewRow1.Cells.Add(MakeCell())
        myTable.Rows.AddAt(1, myNewRow1)

        'Row 2

        Dim myNewRow2 = New GridViewRow(-1, -1, DataControlRowType.Header, DataControlRowState.Normal)
        myNewRow2.Cells.Add(MakeCell("Totals", 1))
        myNewRow2.Cells.Add(MakeCell(furnitureprepcount, 1))
        myNewRow2.Cells.Add(MakeCell(fiberglassprepcount, 1))
        myNewRow2.Cells.Add(MakeCell(coverscount, 1))
        myNewRow2.Cells.Add(MakeCell(railsprepcount, 1))
        myNewRow2.Cells.Add(MakeCell(tubesprepcount, 1))
        myNewRow2.Cells.Add(MakeCell(centertubecountM, 1))
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell("South"))
        myNewRow2.Cells.Add(MakeCell(framescountS, 1))
        myNewRow2.Cells.Add(MakeCell(floorscountS, 1))
        myNewRow2.Cells.Add(MakeCell(trimcountS, 1))
        myNewRow2.Cells.Add(MakeCell(railscountS, 1))
        myNewRow2.Cells.Add(MakeCell(furniturecountS, 1))
        myNewRow2.Cells.Add(MakeCell(helmcountS, 1))
        myNewRow2.Cells.Add(MakeCell(cleaningcountS, 1))
        myNewRow2.Cells.Add(MakeCell(finalcountS, 1))
        myNewRow2.Cells.Add(MakeCell(shrinkwrapcountS, 1))
        myNewRow2.Cells.Add(MakeCell(riggingcountS, 1))
        myNewRow2.Cells.Add(MakeCell(wavetamercountS, 1))
        myNewRow2.Cells.Add(MakeCell(sharkhidecountS, 1))
        myNewRow2.Cells.Add(MakeCell(completecountS, 1))
        myNewRow2.Cells.Add(MakeCell())
        myNewRow2.Cells.Add(MakeCell())
        myTable.Rows.AddAt(2, myNewRow2)


    End Sub

    Private Shared Function MakeCell(Optional text As String = Nothing, Optional span As Integer = 1) As TableHeaderCell
        Return New TableHeaderCell() With {.ColumnSpan = span, .Text = If(text, String.Empty), .CssClass = "table-subheader"}
    End Function


    Protected Sub gvOverview_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvOverview.RowDataBound
        Dim gvOverview = DirectCast(sender, GridView)
        If e.Row.RowType = DataControlRowType.Header Then
            AddSuperHeader(gvOverview)
        End If

        If e.Row.RowType = DataControlRowType.DataRow Then
            'AddSuperHeader(gvOverview)
            e.Row.Cells(0).ToolTip = "Prod #"
            e.Row.Cells(1).ToolTip = "Furniture"
            e.Row.Cells(2).ToolTip = "Fiberglass"
            e.Row.Cells(3).ToolTip = "Covers"
            e.Row.Cells(4).ToolTip = "Rails"
            e.Row.Cells(5).ToolTip = "Tubes"
            e.Row.Cells(6).ToolTip = "Centertubes"
            e.Row.Cells(7).ToolTip = "Gauge/Harness"
            e.Row.Cells(8).ToolTip = "Boat/Customer/Due Date"
            e.Row.Cells(9).ToolTip = "Custom"
            e.Row.Cells(10).ToolTip = "Pilot"
            e.Row.Cells(11).ToolTip = "Frames"
            e.Row.Cells(12).ToolTip = "Floors"
            e.Row.Cells(13).ToolTip = "Trim"
            e.Row.Cells(14).ToolTip = "Rails"
            e.Row.Cells(15).ToolTip = "Furniture"
            e.Row.Cells(16).ToolTip = "Helm"
            e.Row.Cells(17).ToolTip = "Inspection"
            e.Row.Cells(18).ToolTip = "Final Inspection"
            e.Row.Cells(19).ToolTip = "Shrinkwrap"
            e.Row.Cells(20).ToolTip = "Rigging"
            e.Row.Cells(21).ToolTip = "Wavetamer"
            e.Row.Cells(22).ToolTip = "Sharkhide"
            e.Row.Cells(23).ToolTip = "Complete"
            e.Row.Cells(24).ToolTip = "Offline"
            e.Row.Cells(25).ToolTip = "Notes"
        End If

        If e.Row.RowType = DataControlRowType.DataRow Then
            If (e.Row.DataItem("BuildLoc") = "S") Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
        End If

    End Sub


    Protected Sub gvOverview_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvOverview.RowCommand
        If e.CommandName = "gotoorderdetails" Then 'handles when the ? button is clicked
            gvOverview.DataBind()
            Dim SONo As String = e.CommandArgument 'get the row that is clicked
            Dim url As String = "./OrderDetails.aspx?SONo=" & SONo
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=900,height=900,toolbars=0');popUpObj.focus()}</script>")
        End If

        If e.CommandName = "gotonotes" Then 'handles when the notes button is clicked
            gvOverview.DataBind()
            Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command
            Dim workstation As String = "Overview"
            Dim url As String = "./BoatNotes.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=840,height=800,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotooffline" Then
            gvOverview.DataBind()
            Dim Selected As String = e.CommandArgument 'get the row that is clicked
            Dim workstation As String = "Overview" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")

        End If

        If e.CommandName = "gotostatus" Then
            gvOverview.DataBind()
            Dim Selected As String = e.CommandArgument 'find the prod # in that row to use in the update command
            Dim workstation As String = "Overview" 'to pass in the workstation that makes the note.
            Dim url As String = "./BoatStatus.aspx?ws=" & workstation & "&ProdNo=" & Selected
            Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=1,width=840,height=600,toolbars=0');popUpObj.focus()}</script>")
        End If



    End Sub



    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim cmd2 As New SqlCommand
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date
        Dim recordcount As Int16 = 0
        Dim DaystoShow As String

        If ddlDaysInAdvance.Items.Count = 0 Then  'stop it from repopulating everytime the grid rebinds
            DaystoShow = ThisDay.AddDays(1).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("1 Day", DaystoShow))
            DaystoShow = ThisDay.AddDays(3).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("3 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(5).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("5 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(10).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("10 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(15).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("15 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(20).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("20 Days", DaystoShow))
            DaystoShow = ThisDay.AddDays(40).ToString("yyyy-MM-dd")
            ddlDaysInAdvance.Items.Add(New ListItem("40 Days", DaystoShow))
        End If


    End Sub



End Class