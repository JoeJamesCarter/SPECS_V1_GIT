
Partial Class SouthKitPartsList
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub dvSouthKitPartsInsert_ItemInserting(sender As Object, e As DetailsViewInsertEventArgs) Handles dvSouthKitPartsInsert.ItemInserting


        'Dim tbWorkstation As TextBox = DirectCast(DirectCast(sender, DetailsView).FindControl("tbWorkstation"), TextBox)

        Dim cbInsertDisabled As CheckBox = DirectCast(dvSouthKitPartsInsert.FindControl("cbInsertDisabled"), CheckBox)
        Dim cbInsertNotKitted As CheckBox = DirectCast(dvSouthKitPartsInsert.FindControl("cbInsertNotKitted"), CheckBox)
        Dim cbInsertWatch As CheckBox = DirectCast(dvSouthKitPartsInsert.FindControl("cbInsertWatch"), CheckBox)
        Dim cbInsertTally As CheckBox = DirectCast(dvSouthKitPartsInsert.FindControl("cbInsertTally"), CheckBox)

        If cbInsertDisabled.Checked = True Then
            sdsSouthParts.InsertParameters("Disabled").DefaultValue = 1
        Else
            sdsSouthParts.InsertParameters("Disabled").DefaultValue = 0
        End If

        If cbInsertNotKitted.Checked = True Then
            sdsSouthParts.InsertParameters("NotKitted").DefaultValue = 1
        Else
            sdsSouthParts.InsertParameters("NotKitted").DefaultValue = 0
        End If

        If cbInsertWatch.Checked = True Then
            sdsSouthParts.InsertParameters("Watch").DefaultValue = 1
        Else
            sdsSouthParts.InsertParameters("Watch").DefaultValue = 0
        End If

        If cbInsertTally.Checked = True Then
            sdsSouthParts.InsertParameters("Tally").DefaultValue = 1
        Else
            sdsSouthParts.InsertParameters("Tally").DefaultValue = 0
        End If


    End Sub

    Protected Sub gvSouthParts_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvSouthParts.RowUpdating

        Dim cbDisabled As CheckBox = DirectCast(gvSouthParts.Rows(e.RowIndex).FindControl("cbDisabled"), CheckBox)
        Dim cbNotKitted As CheckBox = DirectCast(gvSouthParts.Rows(e.RowIndex).FindControl("cbNotKitted"), CheckBox)
        Dim cbWatch As CheckBox = DirectCast(gvSouthParts.Rows(e.RowIndex).FindControl("cbWatch"), CheckBox)
        Dim cbTally As CheckBox = DirectCast(gvSouthParts.Rows(e.RowIndex).FindControl("cbTally"), CheckBox)
        Dim tbAbbr As TextBox = DirectCast(gvSouthParts.Rows(e.RowIndex).FindControl("tbAbbr"), TextBox)

        If cbDisabled.Checked = True Then
            sdsSouthParts.UpdateParameters("Disabled").DefaultValue = 1
        Else
            sdsSouthParts.UpdateParameters("Disabled").DefaultValue = 0
        End If

        If cbNotKitted.Checked = True Then
            sdsSouthParts.UpdateParameters("NotKitted").DefaultValue = 1
        Else
            sdsSouthParts.UpdateParameters("NotKitted").DefaultValue = 0
        End If

        If cbWatch.Checked = True Then
            sdsSouthParts.UpdateParameters("Watch").DefaultValue = 1
        Else
            sdsSouthParts.UpdateParameters("Watch").DefaultValue = 0
        End If

        If cbTally.Checked = True Then
            sdsSouthParts.UpdateParameters("Tally").DefaultValue = 1
        Else
            sdsSouthParts.UpdateParameters("Tally").DefaultValue = 0
        End If

        sdsSouthParts.UpdateParameters("Abbreviation").DefaultValue = tbAbbr.Text.ToString
    End Sub


End Class
