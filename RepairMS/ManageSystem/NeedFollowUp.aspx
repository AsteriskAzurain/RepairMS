<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NeedFollowUp.aspx.cs" Inherits="RepairMS.ManageSystem.NeedFollowUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>待跟进项目查询 - SBS报修后台管理系统</title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="GridProject">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="GridProject" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="GridDetail">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="GridDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="GridProject">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="GridProject"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="GridDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="GridDetail">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="GridDetail"></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <div style="width: 1200px; margin: auto;">
            <h1 style="text-align: center; margin-bottom: 30px;">待跟进项目</h1>
            <div id="div_gridProject">
                <telerik:RadGrid ID="GridProject" runat="server" Height="310px" AutoGenerateColumns="False" CellSpacing="-1" GridLines="Both" OnNeedDataSource="GridProject_NeedDataSource" OnSelectedIndexChanged="GridProject_SelectedIndexChanged" OnItemDataBound="GridProject_ItemDataBound" BorderStyle="None">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <ClientSettings EnablePostBackOnRowClick="True" EnableRowHoverStyle="True">
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="projectID" AllowAutomaticUpdates="True">
                        <CommandItemSettings ShowRefreshButton="False"></CommandItemSettings>
                        <Columns>
                            <telerik:GridBoundColumn DataField="projectID" HeaderText="项目号" UniqueName="projectID" FilterControlAltText="Filter projectID column">
                                <HeaderStyle HorizontalAlign="Center" Width="80px" Wrap="false"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="80px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="projectStatus" HeaderText="状态" UniqueName="projectStatus" FilterControlAltText="Filter projectStatus column" Display="False">
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="priority" HeaderText="优先级" UniqueName="priority" FilterControlAltText="Filter column column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="120px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="120px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="projectType" HeaderText="报修类型" UniqueName="projectType" FilterControlAltText="Filter column1 column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="150px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="150px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="projectSite" HeaderText="报修地点" UniqueName="projectSite" FilterControlAltText="Filter projectSite column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="150px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="150px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="contactName" HeaderText="联系人" Display="False" UniqueName="contactName" FilterControlAltText="Filter contactName column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="contactPhone" HeaderText="联系方式" UniqueName="contactPhone" FilterControlAltText="Filter contactPhone column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="150px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="150px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="projectDetail" HeaderText="详细描述" Display="False" UniqueName="projectDetail" FilterControlAltText="Filter projectDetail column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="siteDetail" HeaderText="详细地点" Display="False" UniqueName="siteDetail" FilterControlAltText="Filter siteDetail column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="hasDetail" Display="False" UniqueName="hasDetail" FilterControlAltText="Filter hasDetail column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="createDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="报修时间" UniqueName="createDate" DataType="System.DateTime" FilterControlAltText="Filter createDate column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="150px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="150px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="updateDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="更新时间" Display="False" UniqueName="updateDate" DataType="System.DateTime" FilterControlAltText="Filter updateDate column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="deleteStatus" Display="False" UniqueName="deleteStatus" FilterControlAltText="Filter deleteStatus column"></telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="projectStatus" UniqueName="cmbProjectStatus" FilterControlAltText="Filter cmbProjectStatus column" ItemStyle-Width="200px" HeaderStyle-Width="200px">
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                <ItemTemplate>
                                    <telerik:RadComboBox ID="cmbProjStatus" runat="server" Width="150px" SelectedValue='<%#Bind("projectStatus") %>'>
                                        <Items>
                                            <telerik:RadComboBoxItem Text="待分配" Value="0" Enabled="false" />
                                            <telerik:RadComboBoxItem Text="已分配" Value="1" Enabled="false" />
                                            <telerik:RadComboBoxItem Text="待跟进" Value="2" />
                                            <telerik:RadComboBoxItem Text="已完成" Value="3" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="详情" UniqueName="viewDetail" FilterControlAltText="Filter TemplateColumn column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="100px"></ItemStyle>
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="true">View</asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
            <div id="div_gridDetail">
                <telerik:RadGrid ID="GridDetail" runat="server" Height="500px" OnNeedDataSource="GridDetail_NeedDataSource" AutoGenerateColumns="False" AutoGenerateDeleteColumn="True" OnDeleteCommand="GridDetail_DeleteCommand" OnItemCommand="GridDetail_ItemCommand" OnItemDataBound="GridDetail_ItemDataBound">
                    <ClientSettings EnablePostBackOnRowClick="False" EnableRowHoverStyle="True">
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="detailID" CommandItemDisplay="Top" EditMode="PopUp">
                        <CommandItemSettings AddNewRecordText="分配新维修员" ShowRefreshButton="False" />
                        <Columns>
                            <telerik:GridBoundColumn DataField="detailID" HeaderText="维修单号" UniqueName="detailID" FilterControlAltText="Filter detailID column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="120px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="120px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="projectID" Display="False" UniqueName="projectID" FilterControlAltText="Filter projectID column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="repairmanID" HeaderText="维修人员" UniqueName="repairmanID" FilterControlAltText="Filter repairmanID column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="150px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="150px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="severity" HeaderText="损坏程度" UniqueName="severity" FilterControlAltText="Filter severity column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="150px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="150px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="faultType" HeaderText="故障类型" UniqueName="faultType" FilterControlAltText="Filter faultType column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="150px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="150px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="faultStatus" HeaderText="故障状态" UniqueName="faultStatus" FilterControlAltText="Filter faultStatus column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="170px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="170px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="faultDetail" HeaderText="详细描述" Display="False" UniqueName="faultDetail" FilterControlAltText="Filter faultDetail column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="add_requirement" HeaderText="额外需求" Display="False" UniqueName="add_requirement" FilterControlAltText="Filter add_requirement column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="createDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="创建时间" Display="False" UniqueName="createDate" FilterControlAltText="Filter createDate column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="updateDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="更新时间" UniqueName="updateDate" FilterControlAltText="Filter updateDate column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="170px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="170px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="deleteStatus" Display="False" UniqueName="deleteStatus" FilterControlAltText="Filter deleteStatus column"></telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn HeaderText="详情" UniqueName="viewDetail" FilterControlAltText="Filter TemplateColumn column" ItemStyle-Width="50px">
                                <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="100px"></ItemStyle>
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="true">View</asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                        </Columns>
                        <EditFormSettings EditFormType="Template">
                            <FormTemplate>
                                <div style="display: grid; justify-content: center;">
                                    <div style="margin-top: 20px;">
                                        <telerik:RadLabel ID="lblNewRM" runat="server" Text="维修人员："></telerik:RadLabel>
                                        <telerik:RadComboBox ID="cmbRMList" runat="server" Filter="Contains" AppendDataBoundItems="True" Width="240px"></telerik:RadComboBox>
                                    </div>
                                    <div style="display: flex; justify-content: space-between; padding: 10px 70px;">
                                        <telerik:RadButton ID="btnAssignRM" runat="server" Text="确认" CommandName="PerformInsert" Width="80px" Primary="true"></telerik:RadButton>
                                        <telerik:RadButton ID="btnCancelRM" runat="server" Text="取消" CommandName="Cancel" Width="80px" CausesValidation="False"></telerik:RadButton>
                                    </div>
                                </div>
                            </FormTemplate>
                        </EditFormSettings>
                        <CommandItemStyle Font-Bold="True"></CommandItemStyle>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>
    </form>
</body>
</html>
