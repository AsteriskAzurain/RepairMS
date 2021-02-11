<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectDetailPage.aspx.cs" Inherits="RepairMS.ManageSystem.ProjectDetailPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>报修项目详情页</title>
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
        <h2 runat="server" id="lblWarning" visible="false">未能加载正确的项目信息，请检查页面参数后重试。</h2>
        <div class="container">
            <div id="div_btnArea" class="span-col-2">
                <telerik:RadButton ID="btnEdit" runat="server" Text="编辑" OnClick="btnEdit_Click" Width="150px"></telerik:RadButton>
            </div>

            <div class="span-col-2">
                <telerik:RadLabel ID="lblProjectID" runat="server" Text="报修单号：" Width="100px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbProjectID" runat="server" Enabled="false" Width="300px"></telerik:RadTextBox>
            </div>
            <div class="span-col-2">
                <telerik:RadLabel ID="lblProjectStatus" runat="server" Text="项目状态：" Width="100px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbProjectStatus" runat="server" Width="300px"></telerik:RadComboBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblProjectType" runat="server" Text="报修类别：" Width="100px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbProjectType" runat="server" Width="300px"></telerik:RadComboBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblPriority" runat="server" Text="优先级：" Width="100px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbPriority" runat="server" Width="300px"></telerik:RadComboBox>
            </div>
            <div class="span-col-2">
                <telerik:RadLabel ID="lblCreateDate" runat="server" Text="报修日期：" Width="100px"></telerik:RadLabel>
                <telerik:RadDatePicker ID="dateCreate" runat="server" Width="300px"></telerik:RadDatePicker>
            </div>
            <div>
                <telerik:RadLabel ID="lblContactName" runat="server" Text="报修人：" Width="100px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbContactName" runat="server" Width="300px"></telerik:RadTextBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblContactPhone" runat="server" Text="联系方式：" Width="100px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbContactPhone" runat="server" Width="300px"></telerik:RadTextBox>
            </div>
            <div class="span-col-2">
                <telerik:RadLabel ID="lblProjectDetail" runat="server" Text="详细描述：" Width="100px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbProjectDetail" runat="server" TextMode="MultiLine" Width="600px" Height="100px"></telerik:RadTextBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblProjectSite" runat="server" Text="报修地点：" Width="100px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbProjectSite" runat="server" Width="300px"></telerik:RadComboBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblSiteDetail" runat="server" Text="具体位置：" Width="100px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbSiteDetail" runat="server" Width="300px"></telerik:RadTextBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblUpdateDate" runat="server" Text="维修日期：" Width="100px"></telerik:RadLabel>
                <telerik:RadDatePicker ID="dateUpdate" runat="server" Width="300px"></telerik:RadDatePicker>
            </div>
            <div>
                <telerik:RadLabel ID="lblRepairman" runat="server" Text="维修人员：" Width="100px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbRepairman" runat="server" Width="300px"></telerik:RadTextBox>
            </div>
            <div id="div_editBtns" class="span-col-2" runat="server">
                <telerik:RadButton ID="btnSubmit" runat="server" Text="完成" Primary="true" OnClick="btnSubmit_Click" Width="100px"></telerik:RadButton>
                <telerik:RadButton ID="btnCancel" runat="server" Text="取消" OnClick="btnCancel_Click" Width="100px"></telerik:RadButton>
            </div>
            <div id="div_Griddetail" class="span-col-2" runat="server">
                <h3 style="margin-bottom: 5px; margin-left: 5px;">维修记录</h3>
                <telerik:RadGrid ID="GridDetail" runat="server" AutoGenerateColumns="False" Width="700px" OnItemDataBound="GridDetail_ItemDataBound">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <ClientSettings>
                        <Scrolling UseStaticHeaders="True" />
                    </ClientSettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridBoundColumn DataField="detailID" HeaderText="维修单号" UniqueName="detailID" FilterControlAltText="Filter column column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="50px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="50px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="projectID" Display="False" UniqueName="projectID" FilterControlAltText="Filter column1 column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="repairmanID" HeaderText="维修人员" UniqueName="repairmanID" FilterControlAltText="Filter column2 column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="120px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="120px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="severity" Display="False" UniqueName="severity" FilterControlAltText="Filter column3 column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="faultType" Display="False" UniqueName="faultType" FilterControlAltText="Filter column4 column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="faultStatus" Display="False" UniqueName="faultStatus" FilterControlAltText="Filter faultStatus column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="faultDetail" Display="False" UniqueName="faultDetail" FilterControlAltText="Filter faultDetail column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="add_requirement" HeaderText="附加需求" UniqueName="add_requirement" FilterControlAltText="Filter add_requirement column">
                                <HeaderStyle HorizontalAlign="Center" Width="250px"></HeaderStyle>
                                <ItemStyle Width="250px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="createDate" Display="False" UniqueName="createDate" FilterControlAltText="Filter createDate column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="更新日期" DataField="updateDate" UniqueName="updateDate" FilterControlAltText="Filter updateDate column" DataFormatString="{0:yyyy/MM/dd}" DataType="System.DateTime">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="100px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="deleteStatus" Display="False" UniqueName="deleteStatus" FilterControlAltText="Filter column column"></telerik:GridBoundColumn>
                            <telerik:GridHyperLinkColumn Text="View" AllowSorting="False" UniqueName="viewDetail" Target="_blank" FilterControlAltText="Filter column1 column" DataNavigateUrlFields="detailID" DataNavigateUrlFormatString="./RepairDetailPage.aspx?detailID={0}"></telerik:GridHyperLinkColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>
    </form>
</body>
</html>
