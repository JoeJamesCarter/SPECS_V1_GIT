Imports System.Data
Imports System.Data.SqlClient

Partial Class PopReporting
    Inherits System.Web.UI.Page
    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

    End Sub


    Protected Sub DropDownList2_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlWorkstations.SelectedIndexChanged
        If ddlWorkstations.SelectedValue = "Furniture" Then
            lblFurnitureStatus.Visible = True
            rblFurnitureStatus.Visible = True
            btnUpdateFurnitureStatus.Visible = True

            lblFiberglassStatus.Visible = False
            rblFiberglassStatus.Visible = False
            btnUpdateFiberglassStatus.Visible = False

            btnCoversReady.Visible = False
            btnRailsReady.Visible = False
            btnTubesReady.Visible = False

        End If

        If ddlWorkstations.SelectedValue = "Fiberglass" Then
            lblFiberglassStatus.Visible = True
            rblFiberglassStatus.Visible = True
            btnUpdateFiberglassStatus.Visible = True

            lblFurnitureStatus.Visible = False
            rblFurnitureStatus.Visible = False
            btnUpdateFurnitureStatus.Visible = False

            btnCoversReady.Visible = False
            btnRailsReady.Visible = False
            btnTubesReady.Visible = False

        End If

        If ddlWorkstations.SelectedValue = "Covers" Then
            btnCoversReady.Visible = True

            btnTubesReady.Visible = False
            btnRailsReady.Visible = False

            lblFiberglassStatus.Visible = False
            rblFiberglassStatus.Visible = False
            btnUpdateFiberglassStatus.Visible = False

            lblFurnitureStatus.Visible = False
            rblFurnitureStatus.Visible = False
            btnUpdateFurnitureStatus.Visible = False

        End If

        If ddlWorkstations.SelectedValue = "Rails" Then
            btnRailsReady.Visible = True

            btnTubesReady.Visible = False
            btnCoversReady.Visible = False

            lblFiberglassStatus.Visible = False
            rblFiberglassStatus.Visible = False
            btnUpdateFiberglassStatus.Visible = False

            lblFurnitureStatus.Visible = False
            rblFurnitureStatus.Visible = False
            btnUpdateFurnitureStatus.Visible = False

        End If

        If ddlWorkstations.SelectedValue = "Tubes" Then
            btnTubesReady.Visible = True

            btnRailsReady.Visible = False
            btnCoversReady.Visible = False

            lblFiberglassStatus.Visible = False
            rblFiberglassStatus.Visible = False
            btnUpdateFiberglassStatus.Visible = False

            lblFurnitureStatus.Visible = False
            rblFurnitureStatus.Visible = False
            btnUpdateFurnitureStatus.Visible = False

            GridView1.Columns(9).Visible = False 'Hide Rails

        End If
    End Sub



    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        MesgBox(e.CommandName)
        If e.CommandName = "UpdateTubes" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)

            ' Get the last name of the selected author from the appropriate
            ' cell in the GridView control.
            Dim selectedRow As GridViewRow = GridView1.Rows(index)
            Dim ProdNo As TableCell = selectedRow.Cells(0)
            Dim Item As String = selectedRow.Cells(1).Text

            ' Display the selected author.
            'MesgBox(Item)
            TextBox1.Text = Item

        End If

        'msdn.microsoft.com/en-us/library/system.web.ui.webcontrols.buttonfield.commandname(v=vs.110).aspx?cs-save-lang=1&cs-lang=vb#code-snippet-2
    End Sub
End Class
