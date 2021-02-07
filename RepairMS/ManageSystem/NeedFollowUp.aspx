<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NeedFollowUp.aspx.cs" Inherits="RepairMS.ManageSystem.NeedFollowUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>待跟进项目查询 - SBS报修后台管理系统</title>
    <style>
        #div_search {
            margin: 20px;
        }

            #div_search div.row {
                display: flex;
                align-items: center;
                margin-top: 10px;
            }

            #div_search .RadButton:nth-of-type(1) {
                margin-left: 80px;
            }

            #div_search .RadButton:nth-of-type(2) {
                margin-left: 15px;
            }

            #div_search .RadComboBox {
                margin-right: 20px;
            }
    </style>

    <script type="text/javascript">
        function ClientSelectedIndexChanging(sender, args) {
            args.set_cancel(true);

            var domEvent = args.get_domEvent();
            var item = args.get_item();
            var value = item.get_value();
            if (value == "2") theCallback(arg, item, domEvent)
            if (value == "3" && confirm("确认要完成项目吗？")) { theCallback(item, domEvent) }
        }

        function theCallback(item, domEvent) {
            var combo = item.get_parent();

            var text = combo.get_text();
            var lastSeparatorIndex = combo._getLastSeparatorIndex(text);

            var textToSet = text.substring(0, lastSeparatorIndex + 1) + item.get_text();

            combo.set_text(textToSet);
            combo.set_originalText(textToSet);
            combo.set_value(item.get_value());

            combo.set_selectedItem(item);
            combo.set_selectedIndex(item.get_index());

            item.set_selected(true);
            item.highlight();

            combo.raise_selectedIndexChanged(null, domEvent);

            var command = {
                Command: "Select",
                Index: item.get_index()
            };

            combo.postback(command);
        }

    </script>
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
            <div id="div_search" runat="server">
                <div class="row">
                    <telerik:RadLabel ID="lblStatus" runat="server" Text="状态：" Width="85px"></telerik:RadLabel>
                    <telerik:RadComboBox ID="cmbStatus" runat="server">
                        <Items>
                            <telerik:RadComboBoxItem Text="请选择" Value="-1" />
                            <telerik:RadComboBoxItem Text="待分配" Value="0" Enabled="false" />
                            <telerik:RadComboBoxItem Text="已分配" Value="1" Enabled="false" />
                            <telerik:RadComboBoxItem Text="待跟进" Value="2" />
                            <telerik:RadComboBoxItem Text="已完成" Value="3" />
                        </Items>
                    </telerik:RadComboBox>
                    <telerik:RadLabel ID="lblType" runat="server" Text="报修类型：" Width="85px"></telerik:RadLabel>
                    <telerik:RadComboBox ID="cmbType" runat="server"></telerik:RadComboBox>
                    <telerik:RadLabel ID="lblSite" runat="server" Text="报修地点：" Width="85px"></telerik:RadLabel>
                    <telerik:RadComboBox ID="cmbSite" runat="server"></telerik:RadComboBox>
                </div>
                <div class="row">
                    <telerik:RadLabel ID="lblPriority" runat="server" Text="优先级：" Width="85px"></telerik:RadLabel>
                    <telerik:RadComboBox ID="cmbPriority" runat="server"></telerik:RadComboBox>
                    <div>
                        <telerik:RadLabel ID="lblCreateDate" runat="server" Text="报修时间：" Width="80px"></telerik:RadLabel>
                        <telerik:RadDatePicker ID="dateStart" runat="server" AutoPostBack="True">
                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" Culture="zh-CN" FastNavigationNextText="&amp;lt;&amp;lt;" runat="server"></Calendar>
                            <DateInput DisplayDateFormat="yyyy/M/d" DateFormat="yyyy/M/d" LabelWidth="" runat="server" AutoPostBack="True"></DateInput>
                        </telerik:RadDatePicker>
                        <label style="margin: 0 5px;">至</label>
                        <telerik:RadDatePicker ID="dateEnd" runat="server" AutoPostBack="True">
                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" Culture="zh-CN" FastNavigationNextText="&amp;lt;&amp;lt;" runat="server"></Calendar>
                            <DateInput DisplayDateFormat="yyyy/M/d" DateFormat="yyyy/M/d" LabelWidth="" runat="server" AutoPostBack="True"></DateInput>
                        </telerik:RadDatePicker>
                        <telerik:RadButton ID="btnQuery" runat="server" Text="查询" Primary="true" Width="120px" OnClick="btnQuery_Click"></telerik:RadButton>
                        <telerik:RadButton ID="btnClear" runat="server" Text="清空" Width="120px" OnClick="btnClear_Click"></telerik:RadButton>
                    </div>
                </div>
            </div>
            <div id="div_gridProject">
                <telerik:RadGrid ID="GridProject" runat="server" Height="310px" AutoGenerateColumns="False" OnNeedDataSource="GridProject_NeedDataSource" OnSelectedIndexChanged="GridProject_SelectedIndexChanged" OnItemDataBound="GridProject_ItemDataBound">
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
                            <telerik:GridTemplateColumn DataField="projectStatus" UniqueName="cmbProjectStatus" FilterControlAltText="Filter cmbProjectStatus column" ItemStyle-Width="200px" HeaderStyle-Width="200px" HeaderText="状态">
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                <ItemTemplate>
                                    <telerik:RadComboBox ID="cmbProjStatus" runat="server" Width="150px" SelectedValue='<%#Bind("projectStatus") %>' OnSelectedIndexChanged="cmbProjStatus_SelectedIndexChanged" AutoPostBack="True" OnClientSelectedIndexChanging="ClientSelectedIndexChanging">
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
                                        <telerik:RadComboBox ID="cmbRMList" runat="server" Filter="Contains" AppendDataBoundItems="True" Width="240px" EmptyMessage="Select a RepairMan"></telerik:RadComboBox>
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
