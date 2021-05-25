<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RepairDetailPage.aspx.cs" Inherits="RepairMS.ManageSystem.RepairDetailPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>维修记录详情页</title>
    <style>
        .container {
            display: grid;
            padding: 30px;
            grid-template-columns: 450px auto;
            grid-row-gap: 20px;
            align-items: center;
        }

        .span-col-2 {
            grid-column: span 2;
        }

        #div_editBtns .RadButton {
            margin-right: 30px;
        }

        #viewProject {
            margin-left: 10px;
        }

        a.aspNetDisabled {
            cursor: no-drop;
        }

        #dropZone {
            width: 300px;
            height: 100px;
            border: dashed 1px black;
            margin-right: 30px;
            display: -webkit-box;
            -webkit-box-align: center;
            -webkit-box-pack: center;
        }

        .mt-20 {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
        <h2 runat="server" id="lblWarning" visible="false">未能加载正确的项目信息，请检查页面参数后重试。</h2>
        <div class="container">
            <div id="div_btnArea" class="span-col-2">
                <telerik:RadButton ID="btnEdit" runat="server" Text="编辑" Width="150px" OnClick="btnEdit_Click" Visible="false"></telerik:RadButton>
            </div>
            <div class="span-col-2">
                <telerik:RadLabel ID="lblDetailID" runat="server" Text="维修单号：" Width="100px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbDetailID" runat="server" Width="300px"></telerik:RadTextBox>
            </div>
            <div class="span-col-2">
                <telerik:RadLabel ID="lblProjectID" runat="server" Text="报修单号：" Width="100px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbProjectID" runat="server" Width="300px"></telerik:RadTextBox>
                <asp:HyperLink ID="viewProject" runat="server" Font-Underline="true" Target="_blank">View Detail</asp:HyperLink>
            </div>
            <div>
                <telerik:RadLabel ID="lblRepairmanID" runat="server" Text="维修人员：" Width="100px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbRepairmanID" runat="server" Width="300px"></telerik:RadTextBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblCreateDate" runat="server" Text="分配日期：" Width="100px"></telerik:RadLabel>
                <telerik:RadDatePicker ID="dateCreate" runat="server" Width="300px"></telerik:RadDatePicker>
            </div>
            <div class="span-col-2">
                <telerik:RadLabel ID="lblFaultStatus" runat="server" Text="故障状态：" Width="100px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbFaultStatus" runat="server" Width="300px"></telerik:RadComboBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblFaultType" runat="server" Text="故障类型：" Width="100px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbFaultType" runat="server" Width="300px"></telerik:RadComboBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblSeverity" runat="server" Text="损坏程度：" Width="100px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbSeverity" runat="server" Width="300px"></telerik:RadComboBox>
            </div>
            <div class="span-col-2">
                <telerik:RadLabel ID="lblFaultDetail" runat="server" Text="故障细节：" Width="100px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbFaultDetail" runat="server" TextMode="MultiLine" Width="600px" Height="100px"></telerik:RadTextBox>
            </div>
            <div class="span-col-2">
                <telerik:RadLabel ID="lblAddRequirement" runat="server" Text="附加需求：" Width="100px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbAddRequirement" runat="server" TextMode="MultiLine" Width="600px" Height="100px"></telerik:RadTextBox>
            </div>
            <div class="span-col-2" style="display: flex;">
                <telerik:RadLabel ID="lblUpload" runat="server" Text="上传图片：" Width="100px"></telerik:RadLabel>
                <div style="width: 600px;">
                    <telerik:RadGrid ID="GridPhoto" runat="server" Width="600px" AutoGenerateColumns="False" OnNeedDataSource="GridPhoto_NeedDataSource" OnItemCommand="GridPhoto_ItemCommand" OnItemDataBound="GridPhoto_ItemDataBound">
                        <MasterTableView>
                            <Columns>
                                <telerik:GridBoundColumn DataField="picID" Display="False" UniqueName="picID" FilterControlAltText=""></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="detailID" Display="False" UniqueName="detailID" FilterControlAltText="" DataType="System.Int32"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="picName" UniqueName="picName" FilterControlAltText="" HeaderText="File Name"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="roleID" Display="false" UniqueName="roleID" FilterControlAltText="" DataType="System.Int32"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="userID" HeaderText="Uploader" UniqueName="userID" FilterControlAltText="" DataType="System.Int32"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="deleteStatus" Display="False" UniqueName="deleteStatus" FilterControlAltText="" DataType="System.Int32"></telerik:GridBoundColumn>
                                <telerik:GridButtonColumn CommandName="ViewPhoto" Text="Preview" FilterControlAltText="Filter column2 column" UniqueName="View" ButtonType="PushButton"></telerik:GridButtonColumn>
                                <telerik:GridButtonColumn CommandName="DownloadPhoto" Text="Download" FilterControlAltText="Filter column2 column" UniqueName="Download" ButtonType="PushButton"></telerik:GridButtonColumn>
                                <telerik:GridButtonColumn CommandName="DeletePhoto" Text="Delete" FilterControlAltText="Filter column2 column" UniqueName="Delete" ButtonType="PushButton"></telerik:GridButtonColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <telerik:RadAsyncUpload ID="RadAsyncUpload1" runat="server" RenderMode="Lightweight" Width="600px" PostbackTriggers="btnSubmit" HideFileInput="True" MultipleFileSelection="Automatic" UploadedFilesRendering="BelowFileInput" DropZones="#dropZone" CssClass="mt-20" OnFileUploaded="RadAsyncUpload1_FileUploaded">
                        <Localization Select="Click or Drop Here to Upload." />
                        <FileFilters>
                            <telerik:FileFilter Description="Images(jpeg;jpg;png)" Extensions="jpeg,jpg,png" />
                        </FileFilters>
                    </telerik:RadAsyncUpload>
                    <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" CssClass="mt-20" ResizeMode="Fit" Height="200px" BorderStyle="None" AutoAdjustImageControlSize="False" />
                </div>
            </div>
            <div id="div_editBtns" class="span-col-2" runat="server">
                <telerik:RadButton ID="btnSubmit" runat="server" Text="完成" Primary="true" Width="100px" OnClick="btnSubmit_Click"></telerik:RadButton>
                <telerik:RadButton ID="btnCancel" runat="server" Text="取消" Width="100px" OnClick="btnCancel_Click"></telerik:RadButton>
            </div>
        </div>
    </form>
</body>
</html>
