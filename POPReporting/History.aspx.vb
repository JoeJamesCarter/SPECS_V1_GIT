Imports System.Data.SqlClient
Partial Class History
    Inherits System.Web.UI.Page

    Public Sub MesgBox(ByVal sMessage As String)
        Dim msg As String
        msg = "<script language='javascript'>"
        msg += "alert('" & sMessage & "');"
        msg += "<" & "/script>"
        Response.Write(msg)
    End Sub

    Protected Sub History_Load(sender As Object, e As EventArgs) Handles Me.Load


    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        If DropDownList1.SelectedValue = "" Then

            VisibleFalse()
            'gvFurnitureStatus.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvRailsInstall.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If
        If DropDownList1.SelectedValue = "FurnitureStatus" Then
            VisibleFalse()
            gvFurnitureStatus.DataBind()
            gvFurnitureStatus.Visible = True

            'gvFiberglassStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvRailsInstall.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False

        End If

        If DropDownList1.SelectedValue = "FiberglassStatus" Then
            VisibleFalse()
            gvFiberglassStatus.DataBind()
            gvFiberglassStatus.Visible = True

            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvRailsInstall.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False
        End If

        If DropDownList1.SelectedValue = "CoverStatus" Then
            VisibleFalse()
            gvCovers.DataBind()
            gvCovers.Visible = True

            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvRails.Visible = False
            'gvCentertubes.Visible = False
            'gvTubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvRailsInstall.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False

        End If

        If DropDownList1.SelectedValue = "RailsStatus" Then
            VisibleFalse()
            gvRails.DataBind()
            gvRails.Visible = True

            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvRailsInstall.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False

        End If

        If DropDownList1.SelectedValue = "TubesStatus" Then
            VisibleFalse()
            gvTubes.DataBind()
            gvTubes.Visible = True

            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvRailsInstall.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False

        End If

        If DropDownList1.SelectedValue = "CentertubeStatus" Then
            VisibleFalse()
            gvCentertubes.DataBind()
            gvCentertubes.Visible = True

            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvRailsInstall.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If

        If DropDownList1.SelectedValue = "FramesInstallStatus" Then
            VisibleFalse()
            gvFrames.DataBind()
            gvFrames.Visible = True

            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvRailsInstall.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If

        If DropDownList1.SelectedValue = "FloorsInstalledStatus" Then
            VisibleFalse()
            gvFloors.DataBind()
            gvFloors.Visible = True

            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvTrim.Visible = False
            'gvRailsInstall.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False

        End If

        If DropDownList1.SelectedValue = "TrimStatus" Then
            VisibleFalse()
            gvTrim.DataBind()
            gvTrim.Visible = True

            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvFloors.Visible = False
            'gvRailsInstall.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False

        End If

        If DropDownList1.SelectedValue = "RailsInstalledStatus" Then
            VisibleFalse()
            gvRailsInstall.DataBind()
            gvRailsInstall.Visible = True

            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False

        End If

        If DropDownList1.SelectedValue = "FurnitureInstalledStatus" Then
            VisibleFalse()
            gvFurnitureInstall.DataBind()
            gvFurnitureInstall.Visible = True

            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If


        If DropDownList1.SelectedValue = "HelmInstalledStatus" Then
            VisibleFalse()
            gvHelmInstall.DataBind()
            gvHelmInstall.Visible = True

            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False

        End If


        If DropDownList1.SelectedValue = "CleaningStatus" Then
            VisibleFalse()
            gvInspection.DataBind()
            gvInspection.Visible = True

            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvHelmBuild.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False

        End If

        If DropDownList1.SelectedValue = "HelmBuildStatus" Then
            VisibleFalse()
            gvHelmBuild.DataBind()
            gvHelmBuild.Visible = True

            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvFinalInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False

        End If

        If DropDownList1.SelectedValue = "FinalInspectionStatus" Then
            VisibleFalse()
            gvFinalInspection.DataBind()
            gvFinalInspection.Visible = True

            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvPhotos.Visible = False
            'gvShrinkwrap.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False

        End If


        If DropDownList1.SelectedValue = "ShrinkwrapStatus" Then
            VisibleFalse()
            gvShrinkwrap.DataBind()
            gvShrinkwrap.Visible = True

            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvPhotos.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If

        If DropDownList1.SelectedValue = "SharkhideStatus" Then
            VisibleFalse()
            gvSharkhide.DataBind()
            gvSharkhide.Visible = True

            'gvShrinkwrap.Visible = False
            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvPhotos.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If


        If DropDownList1.SelectedValue = "WaveTamerStatus" Then
            VisibleFalse()
            gvWavetamer.DataBind()
            gvWavetamer.Visible = True

            'gvSharkhide.Visible = False
            'gvShrinkwrap.Visible = False
            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvPhotos.Visible = False
            'gvComplete.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If


        If DropDownList1.SelectedValue = "CompleteStatus" Then
            VisibleFalse()
            gvComplete.DataBind()
            gvComplete.Visible = True

            'gvSharkhide.Visible = False
            'gvShrinkwrap.Visible = False
            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvPhotos.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvOuterTubesRoller.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If

        If DropDownList1.SelectedValue = "OuterTubesRollerStatus" Then
            VisibleFalse()
            gvOuterTubesRoller.DataBind()
            gvOuterTubesRoller.Visible = True

            'gvSharkhide.Visible = False
            'gvShrinkwrap.Visible = False
            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvPhotos.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If


        If DropDownList1.SelectedValue = "Kitting1Status" Then
            VisibleFalse()
            gvKitting1.DataBind()
            gvKitting1.Visible = True

            'gvSharkhide.Visible = False
            'gvShrinkwrap.Visible = False
            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = True
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvPhotos.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If

        If DropDownList1.SelectedValue = "Kitting2Status" Then
            VisibleFalse()
            gvKitting2.DataBind()
            gvKitting2.Visible = True

            'gvSharkhide.Visible = False
            'gvShrinkwrap.Visible = False
            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = True
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvSharkhide.Visible = False
            'gvPhotos.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If


        If DropDownList1.SelectedValue = "Kitting3Status" Then
            VisibleFalse()
            gvKitting3.DataBind()
            gvKitting3.Visible = True

            'gvSharkhide.Visible = False
            'gvShrinkwrap.Visible = False
            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = True
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvPhotos.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If

        If DropDownList1.SelectedValue = "Kitting4Status" Then
            VisibleFalse()
            gvKitting4.DataBind()
            gvKitting4.Visible = True

            'gvSharkhide.Visible = False
            'gvShrinkwrap.Visible = False
            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = True
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvTrim.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvSharkhide.Visible = False
            'gvPhotos.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If

        If DropDownList1.SelectedValue = "GatesStatus" Then
            VisibleFalse()
            gvGates.DataBind()
            gvGates.Visible = True

            'gvSharkhide.Visible = False
            'gvShrinkwrap.Visible = False
            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = True
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvPhotos.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If

        If DropDownList1.SelectedValue = "PhotosStatus" Then
            VisibleFalse()
            gvPhotos.DataBind()
            gvPhotos.Visible = True

            'gvSharkhide.Visible = False
            'gvShrinkwrap.Visible = False
            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvPhotos.Visible = True
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvAllKitsRcvd.Visible = False


        End If

        If DropDownList1.SelectedValue = "AllKitsRcvd" Then
            VisibleFalse()
            gvAllKitsRcvd.DataBind()
            gvAllKitsRcvd.Visible = True

            'gvSharkhide.Visible = False
            'gvShrinkwrap.Visible = False
            'gvFinalInspection.Visible = False
            'gvHelmBuild.Visible = False
            'gvFurnitureInstall.Visible = False
            'gvFiberglassStatus.Visible = False
            'gvFurnitureStatus.Visible = False
            'gvCovers.Visible = False
            'gvRails.Visible = False
            'gvTubes.Visible = False
            'gvCentertubes.Visible = False
            'gvKitting1.Visible = False
            'gvKitting2.Visible = False
            'gvKitting3.Visible = False
            'gvKitting4.Visible = False
            'gvGates.Visible = False
            'gvFrames.Visible = False
            'gvRailsInstall.Visible = False
            'gvFloors.Visible = False
            'gvTrim.Visible = False
            'gvHelmInstall.Visible = False
            'gvInspection.Visible = False
            'gvPhotos.Visible = False
            'gvSharkhide.Visible = False
            'gvWavetamer.Visible = False
            'gvComplete.Visible = False
            'gvAllKitsRcvd.Visible = True


        End If

        If DropDownList1.SelectedValue = "FGI" Then
            VisibleFalse()
            gvFGI.DataBind()
            gvFGI.Visible = True
        End If


        If DropDownList1.SelectedValue = "GaugeStatus" Then
            VisibleFalse()
            gvGauges.DataBind()
            gvGauges.Visible = True
        End If


        If DropDownList1.SelectedValue = "HarnessStatus" Then
            VisibleFalse()
            gvHarnesses.DataBind()
            gvHarnesses.Visible = True
        End If



    End Sub

	Private Sub gvHelmBuild_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvHelmBuild.RowCommand
		If e.CommandName = "gotobuildsheet" Then 'handles when the notes button is clicked
			Dim Selected As String = Convert.ToString(e.CommandArgument) 'get the row that is clicked 
			Dim Line() As String = Selected.Split(";")
			Dim ProdNo As String = Line(0)
			Dim Model As String = Line(1)

			Dim url As String = "./Workstations/HelmBuildSheet.aspx?ProdNo=" & Trim(ProdNo) & "&Model=" & Trim(Model) & ""

			Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,width=1024,height=1200,toolbars=0');popUpObj.focus()}</script>")
		End If
	End Sub

    Protected Sub ImageButton3_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton3.Click

        Dim cmd1 As New SqlCommand
        Dim conn As New SqlConnection()
        Dim connstr As String = ConfigurationManager.ConnectionStrings("bml_dataConnectionString").ConnectionString
        conn.ConnectionString = connstr
        cmd1.Connection = conn

        Dim prod As String = Trim(tbProdNo.Text)
        Dim hull As String = Trim(tbHullNo.Text)

        conn.Open()
        If prod.Length > 0 Then
            cmd1.CommandText = "Select SONo FROM BML_POPREPORTING_GREENLIGHTS where ProdNo = @prod1"
        ElseIf hull.Length > 0 Then
            cmd1.CommandText = "Select SONo FROM BML_POPREPORTING_GREENLIGHTS where Notes = @hull1"
        End If


        cmd1.Parameters.AddWithValue("@prod1", prod)
        cmd1.Parameters.AddWithValue("@hull1", hull)

        Dim SONo As String = cmd1.ExecuteScalar
        Dim url As String = "./OrderDetailsFull.aspx?SONo=" & SONo
        Response.Write("<script language='javascript'> {popUpObj=window.open ('" & url & "' ,'mywindow','menubar=0,resizable=0,toolbars=1');popUpObj.focus()}</script>")
        conn.Close()
    End Sub

    Public Function VisibleFalse() As String

        gvFurnitureStatus.Visible = False
        gvFiberglassStatus.Visible = False
        gvCovers.Visible = False
        gvRails.Visible = False
        gvTubes.Visible = False
        gvCentertubes.Visible = False
        gvKitting1.Visible = False
        gvKitting2.Visible = False
        gvKitting3.Visible = False
        gvKitting4.Visible = False
        gvGates.Visible = False
        gvFrames.Visible = False
        gvFloors.Visible = False
        gvTrim.Visible = False
        gvRailsInstall.Visible = False
        gvFurnitureInstall.Visible = False
        gvHelmInstall.Visible = False
        gvInspection.Visible = False
        gvHelmBuild.Visible = False
        gvFinalInspection.Visible = False
        gvPhotos.Visible = False
        gvShrinkwrap.Visible = False
        gvSharkhide.Visible = False
        gvWavetamer.Visible = False
        gvComplete.Visible = False
        gvOuterTubesRoller.Visible = False
        gvAllKitsRcvd.Visible = False
        gvGauges.Visible = False
        gvHarnesses.Visible = False




        Return False

    End Function
End Class
