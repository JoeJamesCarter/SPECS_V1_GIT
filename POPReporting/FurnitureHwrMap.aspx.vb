Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports MySql.Data.MySqlClient
Partial Class FurnitureHwrMap
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub FurnitureHwrMap_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        Dim cmd As New SqlCommand
        Dim TodaysDate As Date = Date.Now
        Dim ThisDay As Date = TodaysDate.Date

        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Select Count (*) FROM BML_POPREPORTING_GREENLIGHTS where FurnHwrDelStatus = 2 and Convert(date,FurnHwrDel) ='" & ThisDay & "'"

        conn.Open()
        lblTodaysCount.Text = cmd.ExecuteScalar
        conn.Close()


    End Sub

    Protected Sub dlHelms_ItemDataBound(sender As Object, e As DataListItemEventArgs) Handles dlHelms.ItemDataBound, dlInspection.ItemDataBound, dlFinal.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then
            Dim prod As String = e.Item.DataItem("ProdNo")
            Dim s As SqlDataSource = CType(e.Item.FindControl("sdsVendorInfo"), SqlDataSource)

            Try 'use the selected prod # to get the green light values for the subgridview.  Used so that every greenlight section has headers.
                s.SelectParameters(0).DefaultValue = prod
            Catch

            End Try

        End If

    End Sub

    Protected Sub dlHelms_ItemCommand(source As Object, e As DataListCommandEventArgs) Handles dlHelms.ItemCommand, dlFinal.ItemCommand, dlInspection.ItemCommand

        If e.CommandName = "markdone" Then
            Dim prod As String = e.CommandArgument
            'MesgBox(prod.ToString)

            Dim conn As New SqlConnection()
            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            Dim cmd As New SqlCommand
            Dim TodaysDate As Date = Date.Now

            conn.ConnectionString = connstr
            cmd.Connection = conn

            cmd.CommandType = CommandType.Text
            cmd.CommandText = "UPDATE BML_POPREPORTING_GREENLIGHTS SET FurnHwrDelStatus =  2 , FurnHwrDel = '" & TodaysDate & "' where ProdNo =  '" & prod & "'"

            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            dlHelms.DataBind()
            dlInspection.DataBind()
            dlFinal.DataBind()

        End If

    End Sub


End Class
