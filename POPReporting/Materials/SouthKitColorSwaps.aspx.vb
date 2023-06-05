
Imports System.Data.SqlClient

Partial Class Materials_SouthKitColorSwaps
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Private Sub btnAddSwap_Click(sender As Object, e As EventArgs) Handles btnAddSwap.Click
        Dim part As String = tbPartNo.Text
        Dim cbBlackout As CheckBox = CType(FindControl("cbBlackout"), CheckBox)
        Dim partfrom As String = tbFromPart.Text
        Dim partto As String = tbToPart.Text
        Dim allBlackout As Integer = 0

        If (part = "" And cbBlackout.Checked = False) Then
            MesgBox("Please enter an option or select that this rule applies to all Blackout Options.")
        ElseIf (tbFromPart.Text = "" Or tbToPart.Text = "") Then
            MesgBox("Please enter the from part and the to part.")
        Else
            Dim sqldataadapter As New SqlDataAdapter
            Dim conn As New SqlConnection()
            Dim cmd As New SqlCommand

            Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
            conn.ConnectionString = connstr
            cmd.Connection = conn

            If cbBlackout.Checked = True Then
                allBlackout = 1
            End If

            cmd.Parameters.AddWithValue("@AllBlackoutParts", allBlackout)
            cmd.Parameters.AddWithValue("@PartNo", tbPartNo.Text.ToString)
            cmd.Parameters.AddWithValue("@PartDesc", lblOptionDesc.Text)
            cmd.Parameters.AddWithValue("@FromPartNo", tbFromPart.Text.ToString)
            cmd.Parameters.AddWithValue("@FromPartDesc", lblFromPartDesc.Text)
            cmd.Parameters.AddWithValue("@ToPartNo", tbToPart.Text.ToString)
            cmd.Parameters.AddWithValue("@ToPartDesc", lblToPartDesc.Text)

            cmd.CommandText = "Insert Into SouthKitColorSwapParts(AllBlackoutParts, PartNo, PartDesc, FromPartNo, FromPartDesc, ToPartNo, ToPartDesc) Values(@AllBlackoutParts, @PartNo, @PartDesc, @FromPartNo, @FromPartDesc, @ToPartNo, @ToPartDesc)"
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

            tbPartNo.Text = ""
            lblOptionDesc.Text = ""
            tbFromPart.Text = ""
            lblFromPartDesc.Text = ""
            tbToPart.Text = ""
            lblToPartDesc.Text = ""
            cbBlackout.Checked = False

            gvSwaps.DataBind()

        End If
    End Sub

    Private Sub tbPartNo_TextChanged(sender As Object, e As EventArgs) Handles tbPartNo.TextChanged
        Dim sqldataadapter As New SqlDataAdapter
        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@item_no", tbPartNo.Text)

        cmd.CommandText = "Select item_desc_1 from Inventory_ItemMaster Where item_no = @item_no"
        conn.Open()
        lblOptionDesc.Text = cmd.ExecuteScalar
        conn.Close()
    End Sub

    Private Sub tbFromPart_TextChanged(sender As Object, e As EventArgs) Handles tbFromPart.TextChanged
        Dim sqldataadapter As New SqlDataAdapter
        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@item_no", tbFromPart.Text)

        cmd.CommandText = "Select item_desc_1 from Inventory_ItemMaster Where item_no = @item_no"
        conn.Open()
        lblFromPartDesc.Text = cmd.ExecuteScalar
        conn.Close()
    End Sub

    Private Sub tbToPart_TextChanged(sender As Object, e As EventArgs) Handles tbToPart.TextChanged
        Dim sqldataadapter As New SqlDataAdapter
        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand

        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        cmd.Connection = conn

        cmd.Parameters.AddWithValue("@item_no", tbToPart.Text)

        cmd.CommandText = "Select item_desc_1 from Inventory_ItemMaster Where item_no = @item_no"
        conn.Open()
        lblToPartDesc.Text = cmd.ExecuteScalar
        conn.Close()
    End Sub

End Class
