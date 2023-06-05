<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HistoryByBoat.aspx.vb" Inherits="HistoryByBoat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>History</title>
    <link href="StyleSheet.css" rel="stylesheet" />
    <style>
        #tubedata {
            float: left;
        }

        #tubestations {
            float: left;
            padding-left: 20px;
        }
         .Thumbs {
            height:200px;
            width:400px;
            padding:10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Prod #:   " CssClass="newStyle7"></asp:Label><asp:TextBox ID="tbProdNo" runat="server" CssClass="newStyle7"></asp:TextBox>
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="newStyle1" DataSourceID="sdsGreeblights" Width="1223px">
                <Columns>
                    <asp:BoundField DataField="CusName" HeaderText="Dealer" />
                    <asp:BoundField DataField="ProdNo" HeaderText="Model" />
                    <asp:BoundField DataField="ItemNo" HeaderText="Model" />
                    <asp:BoundField DataField="DueDate" DataFormatString="{0:d}" HeaderText="Due Date" />
                    <asp:BoundField DataField="Complete" HeaderText="Completed" />
                    <asp:BoundField DataField="Photos" HeaderText="Photos Taken" />
                </Columns>
            </asp:GridView>
            <br />
            &nbsp;<asp:Button ID="btnShowPhotos" runat="server" CssClass="newStyle4" Text="Show Photos" />
&nbsp;
            <asp:Button ID="btnHidePhotos" runat="server" CssClass="newStyle4" Text="Hide Photos" />
&nbsp;<div>
            <div id="photos" runat="server"> 
                 <asp:Image ID="Image1" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image2" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image3" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image4" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image5" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image6" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image7" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image8" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image9" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image10" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image11" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image12" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image13" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image14" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image15" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image16" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image17" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image18" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image19" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image20" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image21" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image22" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image23" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image24" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image25" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image26" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image27" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image28" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image29" CssClass="Thumbs" runat="server" />
        <asp:Image ID="Image30" CssClass="Thumbs" runat="server" />

            </div>
            <div id="tubedata">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsTubeData" Height="16px" Width="703px" Caption="Tube Details">
                    <Fields>
                        <asp:BoundField DataField="OuterScheduled" HeaderText="Outer Scheduled" SortExpression="OuterScheduled" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="CenterScheduled" HeaderText="Center Scheduled" SortExpression="CenterScheduled" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="OuterRoller" HeaderText="OuterRoller" SortExpression="OuterRoller" />
                        <asp:BoundField DataField="CenterRoller" HeaderText="CenterRoller" SortExpression="CenterRoller" />
                        <asp:BoundField DataField="OuterSections" HeaderText="Outer Sections" SortExpression="OuterSections" />
                        <asp:BoundField DataField="CenterSections" HeaderText="Center Sections" SortExpression="CenterSections" />

                        <asp:ImageField DataImageUrlField="RollerPStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Roller Port">
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </asp:ImageField>

                        <asp:BoundField DataField="RollerP" HeaderText="RollerP" SortExpression="RollerP" />

                        <asp:ImageField DataImageUrlField="RollerSStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Roller Strb">
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </asp:ImageField>

                        <asp:BoundField DataField="RollerS" HeaderText="RollerS" SortExpression="RollerS" />

                        <asp:ImageField DataImageUrlField="RollerCStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Roller Ctr">
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:BoundField DataField="RollerC" HeaderText="RollerC" SortExpression="RollerC" />

                        <asp:ImageField DataImageUrlField="RoundSeamerPStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Round Seamer Port">
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:BoundField DataField="RoundSeamerP" HeaderText="RoundSeamerP" SortExpression="RoundSeamerP" />

                        <asp:ImageField DataImageUrlField="RollerPStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Round Seamer Strb">
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:BoundField DataField="RoundSeamerS" HeaderText="RoundSeamerS" SortExpression="RoundSeamerS" />
                        <asp:ImageField DataImageUrlField="RoundSeamerCStatus" DataImageUrlFormatString="./Images/{0}.png" HeaderText="Round Seamer Ctr">
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </asp:ImageField>
                        <asp:BoundField DataField="RoundSeamerC" HeaderText="RoundSeamerC" SortExpression="RoundSeamerC" />

                        <asp:BoundField DataField="SeamerSectPFStatus" HeaderText="SeamerSectPFStatus" SortExpression="SeamerSectPFStatus" />

                        <asp:BoundField DataField="SeamerSectPF" HeaderText="SeamerSectPF" SortExpression="SeamerSectPF" />

                        <asp:BoundField DataField="SeamerSectPMStatus" HeaderText="SeamerSectPMStatus" SortExpression="SeamerSectPMStatus" />

                        <asp:BoundField DataField="SeamerSectPM" HeaderText="SeamerSectPM" SortExpression="SeamerSectPM" />

                        <asp:BoundField DataField="SeamerSectPM2Status" HeaderText="SeamerSectPM2Status" SortExpression="SeamerSectPM2Status" />

                        <asp:BoundField DataField="SeamerSectPM2" HeaderText="SeamerSectPM2" SortExpression="SeamerSectPM2" />

                        <asp:BoundField DataField="SeamerSectPRStatus" HeaderText="SeamerSectPRStatus" SortExpression="SeamerSectPRStatus" />

                        <asp:BoundField DataField="SeamerSectPR" HeaderText="SeamerSectPR" SortExpression="SeamerSectPR" />

                        <asp:BoundField DataField="SeamerSectCFStatus" HeaderText="SeamerSectCFStatus" SortExpression="SeamerSectCFStatus" />

                        <asp:BoundField DataField="SeamerSectCF" HeaderText="SeamerSectCF" SortExpression="SeamerSectCF" />

                        <asp:BoundField DataField="SeamerSectCMStatus" HeaderText="SeamerSectCMStatus" SortExpression="SeamerSectCMStatus" />

                        <asp:BoundField DataField="SeamerSectCM" HeaderText="SeamerSectCM" SortExpression="SeamerSectCM" />

                        <asp:BoundField DataField="SeamerSectCM2Status" HeaderText="SeamerSectCM2Status" SortExpression="SeamerSectCM2Status" />

                        <asp:BoundField DataField="SeamerSectCM2" HeaderText="SeamerSectCM2" SortExpression="SeamerSectCM2" />

                        <asp:BoundField DataField="SeamerSectCRStatus" HeaderText="SeamerSectCRStatus" SortExpression="SeamerSectCRStatus" />

                        <asp:BoundField DataField="SeamerSectCR" HeaderText="SeamerSectCR" SortExpression="SeamerSectCR" />

                        <asp:BoundField DataField="SeamerSectSFStatus" HeaderText="SeamerSectSFStatus" SortExpression="SeamerSectSFStatus" />

                        <asp:BoundField DataField="SeamerSectSF" HeaderText="SeamerSectSF" SortExpression="SeamerSectSF" />

                        <asp:BoundField DataField="SeamerSectSMStatus" HeaderText="SeamerSectSMStatus" SortExpression="SeamerSectSMStatus" />
                        <asp:BoundField DataField="SeamerSectSM" HeaderText="SeamerSectSM" SortExpression="SeamerSectSM" />
                        <asp:BoundField DataField="SeamerSectSM2Status" HeaderText="SeamerSectSM2Status" SortExpression="SeamerSectSM2Status" />
                        <asp:BoundField DataField="SeamerSectSM2" HeaderText="SeamerSectSM2" SortExpression="SeamerSectSM2" />
                        <asp:BoundField DataField="SeamerSectSRStatus" HeaderText="SeamerSectSRStatus" SortExpression="SeamerSectSRStatus" />
                        <asp:BoundField DataField="SeamerSectSR" HeaderText="SeamerSectSR" SortExpression="SeamerSectSR" />
                        <asp:BoundField DataField="BafflesSectPFStatus" HeaderText="BafflesSectPFStatus" SortExpression="BafflesSectPFStatus" />
                        <asp:BoundField DataField="BafflesSectPF" HeaderText="BafflesSectPF" SortExpression="BafflesSectPF" />
                        <asp:BoundField DataField="BafflesSectPMStatus" HeaderText="BafflesSectPMStatus" SortExpression="BafflesSectPMStatus" />
                        <asp:BoundField DataField="BafflesSectPM" HeaderText="BafflesSectPM" SortExpression="BafflesSectPM" />
                        <asp:BoundField DataField="BafflesSectPM2Status" HeaderText="BafflesSectPM2Status" SortExpression="BafflesSectPM2Status" />
                        <asp:BoundField DataField="BafflesSectPM2" HeaderText="BafflesSectPM2" SortExpression="BafflesSectPM2" />
                        <asp:BoundField DataField="BafflesSectPRStatus" HeaderText="BafflesSectPRStatus" SortExpression="BafflesSectPRStatus" />
                        <asp:BoundField DataField="BafflesSectPR" HeaderText="BafflesSectPR" SortExpression="BafflesSectPR" />
                        <asp:BoundField DataField="BafflesSectSFStatus" HeaderText="BafflesSectSFStatus" SortExpression="BafflesSectSFStatus" />
                        <asp:BoundField DataField="BafflesSectSF" HeaderText="BafflesSectSF" SortExpression="BafflesSectSF" />
                        <asp:BoundField DataField="BafflesSectSMStatus" HeaderText="BafflesSectSMStatus" SortExpression="BafflesSectSMStatus" />
                        <asp:BoundField DataField="BafflesSectSM" HeaderText="BafflesSectSM" SortExpression="BafflesSectSM" />
                        <asp:BoundField DataField="BafflesSectSM2Status" HeaderText="BafflesSectSM2Status" SortExpression="BafflesSectSM2Status" />
                        <asp:BoundField DataField="BafflesSectSM2" HeaderText="BafflesSectSM2" SortExpression="BafflesSectSM2" />
                        <asp:BoundField DataField="BafflesSectSRStatus" HeaderText="BafflesSectSRStatus" SortExpression="BafflesSectSRStatus" />
                        <asp:BoundField DataField="BafflesSectSR" HeaderText="BafflesSectSR" SortExpression="BafflesSectSR" />
                        <asp:BoundField DataField="BafflesSectCFStatus" HeaderText="BafflesSectCFStatus" SortExpression="BafflesSectCFStatus" />
                        <asp:BoundField DataField="BafflesSectCF" HeaderText="BafflesSectCF" SortExpression="BafflesSectCF" />
                        <asp:BoundField DataField="BafflesSectCMStatus" HeaderText="BafflesSectCMStatus" SortExpression="BafflesSectCMStatus" />
                        <asp:BoundField DataField="BafflesSectCM" HeaderText="BafflesSectCM" SortExpression="BafflesSectCM" />
                        <asp:BoundField DataField="BafflesSectCM2Status" HeaderText="BafflesSectCM2Status" SortExpression="BafflesSectCM2Status" />
                        <asp:BoundField DataField="BafflesSectCM2" HeaderText="BafflesSectCM2" SortExpression="BafflesSectCM2" />
                        <asp:BoundField DataField="BafflesSectCRStatus" HeaderText="BafflesSectCRStatus" SortExpression="BafflesSectCRStatus" />
                        <asp:BoundField DataField="BafflesSectCR" HeaderText="BafflesSectCR" SortExpression="BafflesSectCR" />
                        <asp:BoundField DataField="BracketsPStatus" HeaderText="BracketsPStatus" SortExpression="BracketsPStatus" />
                        <asp:BoundField DataField="BracketsP" HeaderText="BracketsP" SortExpression="BracketsP" />
                        <asp:BoundField DataField="BracketsSStatus" HeaderText="BracketsSStatus" SortExpression="BracketsSStatus" />
                        <asp:BoundField DataField="BracketsS" HeaderText="BracketsS" SortExpression="BracketsS" />
                        <asp:BoundField DataField="BracketsCStatus" HeaderText="BracketsCStatus" SortExpression="BracketsCStatus" />
                        <asp:BoundField DataField="BracketsC" HeaderText="BracketsC" SortExpression="BracketsC" />
                        <asp:BoundField DataField="AirCheckPStatus" HeaderText="AirCheckPStatus" SortExpression="AirCheckPStatus" />
                        <asp:BoundField DataField="AirCheckP" HeaderText="AirCheckP" SortExpression="AirCheckP" />
                        <asp:BoundField DataField="AirCheckSStatus" HeaderText="AirCheckSStatus" SortExpression="AirCheckSStatus" />
                        <asp:BoundField DataField="AirCheckS" HeaderText="AirCheckS" SortExpression="AirCheckS" />
                        <asp:BoundField DataField="AirCheckCStatus" HeaderText="AirCheckCStatus" SortExpression="AirCheckCStatus" />
                        <asp:BoundField DataField="AirCheckC" HeaderText="AirCheckC" SortExpression="AirCheckC" />
                        <asp:BoundField DataField="FinalPStatus" HeaderText="FinalPStatus" SortExpression="FinalPStatus" />
                        <asp:BoundField DataField="FinalP" HeaderText="FinalP" SortExpression="FinalP" />
                        <asp:BoundField DataField="FinalSStatus" HeaderText="FinalSStatus" SortExpression="FinalSStatus" />
                        <asp:BoundField DataField="FinalS" HeaderText="FinalS" SortExpression="FinalS" />
                    </Fields>
                </asp:DetailsView>
            </div>
            <div id="tubestations">
                <asp:DetailsView ID="DetailsView2" runat="server" AutoGenerateRows="False" CssClass="newStyle1" DataKeyNames="ProdNo" DataSourceID="sdsTubeStationIDs" Height="16px" Width="703px" Caption="Tube Stations">
                    <Fields>
                        <asp:BoundField DataField="OuterRollerID" HeaderText="OuterRollerID" SortExpression="OuterRollerID" />
                        <asp:BoundField DataField="CenterRollerID" HeaderText="CenterRollerID" SortExpression="CenterRollerID" />
                        <asp:BoundField DataField="BafflesPFID" HeaderText="BafflesPFID" SortExpression="BafflesPFID" />
                        <asp:BoundField DataField="BafflesPMID" HeaderText="BafflesPMID" SortExpression="BafflesPMID" />
                        <asp:BoundField DataField="BafflesPM2ID" HeaderText="BafflesPM2ID" SortExpression="BafflesPM2ID" />
                        <asp:BoundField DataField="BafflesPRID" HeaderText="BafflesPRID" SortExpression="BafflesPRID" />
                        <asp:BoundField DataField="BafflesSFID" HeaderText="BafflesSFID" SortExpression="BafflesSFID" />
                        <asp:BoundField DataField="BafflesSMID" HeaderText="BafflesSMID" SortExpression="BafflesSMID" />
                        <asp:BoundField DataField="BafflesSM2ID" HeaderText="BafflesSM2ID" SortExpression="BafflesSM2ID" />
                        <asp:BoundField DataField="BafflesSRID" HeaderText="BafflesSRID" SortExpression="BafflesSRID" />
                        <asp:BoundField DataField="BafflesCFID" HeaderText="BafflesCFID" SortExpression="BafflesCFID" />
                        <asp:BoundField DataField="BafflesCMID" HeaderText="BafflesCMID" SortExpression="BafflesCMID" />
                        <asp:BoundField DataField="BafflesCM2ID" HeaderText="BafflesCM2ID" SortExpression="BafflesCM2ID" />
                        <asp:BoundField DataField="BafflesCRID" HeaderText="BafflesCRID" SortExpression="BafflesCRID" />
                        <asp:BoundField DataField="SeamerPFID" HeaderText="SeamerPFID" SortExpression="SeamerPFID" />
                        <asp:BoundField DataField="SeamerPMID" HeaderText="SeamerPMID" SortExpression="SeamerPMID" />
                        <asp:BoundField DataField="SeamerPM2ID" HeaderText="SeamerPM2ID" SortExpression="SeamerPM2ID" />
                        <asp:BoundField DataField="SeamerPRID" HeaderText="SeamerPRID" SortExpression="SeamerPRID" />
                        <asp:BoundField DataField="SeamerSFID" HeaderText="SeamerSFID" SortExpression="SeamerSFID" />
                        <asp:BoundField DataField="SeamerSMID" HeaderText="SeamerSMID" SortExpression="SeamerSMID" />
                        <asp:BoundField DataField="SeamerSM2ID" HeaderText="SeamerSM2ID" SortExpression="SeamerSM2ID" />
                        <asp:BoundField DataField="SeamerSRID" HeaderText="SeamerSRID" SortExpression="SeamerSRID" />
                        <asp:BoundField DataField="SeamerCFID" HeaderText="SeamerCFID" SortExpression="SeamerCFID" />
                        <asp:BoundField DataField="SeamerCMID" HeaderText="SeamerCMID" SortExpression="SeamerCMID" />
                        <asp:BoundField DataField="SeamerCM2ID" HeaderText="SeamerCM2ID" SortExpression="SeamerCM2ID" />
                        <asp:BoundField DataField="SeamerCRID" HeaderText="SeamerCRID" SortExpression="SeamerCRID" />
                        <asp:BoundField DataField="RoundSeamerPID" HeaderText="RoundSeamerPID" SortExpression="RoundSeamerPID" />
                        <asp:BoundField DataField="RoundSeamerSID" HeaderText="RoundSeamerSID" SortExpression="RoundSeamerSID" />
                        <asp:BoundField DataField="RoundSeamerCID" HeaderText="RoundSeamerCID" SortExpression="RoundSeamerCID" />
                        <asp:BoundField DataField="BracketsCID" HeaderText="BracketsCID" SortExpression="BracketsCID" />
                        <asp:BoundField DataField="BracketsSID" HeaderText="BracketsSID" SortExpression="BracketsSID" />
                        <asp:BoundField DataField="BracketsPID" HeaderText="BracketsPID" SortExpression="BracketsPID" />
                        <asp:BoundField DataField="AirCheckPID" HeaderText="AirCheckPID" SortExpression="AirCheckPID" />
                        <asp:BoundField DataField="AirCheckSID" HeaderText="AirCheckSID" SortExpression="AirCheckSID" />
                        <asp:BoundField DataField="AirCheckCID" HeaderText="AirCheckCID" SortExpression="AirCheckCID" />
                        <asp:BoundField DataField="FinalPID" HeaderText="FinalPID" SortExpression="FinalPID" />
                        <asp:BoundField DataField="FinalSID" HeaderText="FinalSID" SortExpression="FinalSID" />
                    </Fields>
                </asp:DetailsView>
            </div>
            <div>
            </div>
        </div>
            <br />

            <br />
            <br />

            <br />
            <asp:SqlDataSource ID="sdsGreeblights" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [BML_POPREPORTING_GREENLIGHTS] WHERE ([ProdNo] = @ProdNo)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsTubeStationIDs" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT [ProdNo], [FinalSID], [FinalPID], [AirCheckCID], [AirCheckSID], [AirCheckPID], [BracketsCID], [BracketsSID], [BracketsPID], [RoundSeamerCID], [RoundSeamerSID], [RoundSeamerPID], [BafflesCRID], [BafflesCM2ID], [BafflesCMID], [BafflesCFID], [BafflesSRID], [BafflesSMID], [BafflesSM2ID], [BafflesSFID], [BafflesPRID], [BafflesPM2ID], [BafflesPMID], [BafflesPFID], [SeamerCRID], [SeamerCM2ID], [SeamerCMID], [SeamerCFID], [SeamerSRID], [SeamerSM2ID], [SeamerSMID], [SeamerSFID], [SeamerPRID], [SeamerPM2ID], [SeamerPMID], [SeamerPFID], [CenterRollerID], [OuterRollerID] FROM [Tubes] WHERE ([ProdNo] = @ProdNo)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsTubeData" runat="server" ConnectionString="<%$ ConnectionStrings:bml_dataConnectionString %>" SelectCommand="SELECT * FROM [Tubes] WHERE ([ProdNo] = @ProdNo)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="tbProdNo" Name="ProdNo" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
