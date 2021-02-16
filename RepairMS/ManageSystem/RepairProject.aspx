<%@ Page Language="C#" MasterPageFile="../MasterPage.Master" AutoEventWireup="true" CodeBehind="RepairProject.aspx.cs" Inherits="RepairMS.ManageSystem.RepairProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../styles/default.css" rel="stylesheet" />
    <style>
        .searchArea {
            margin: 20px;
        }

            .searchArea div.row {
                display: flex;
                align-items: center;
                margin-top: 10px;
            }

            .searchArea .RadButton:nth-of-type(1) {
                margin-left: 80px;
            }

            .searchArea .RadButton:nth-of-type(2) {
                margin-left: 15px;
            }

            .searchArea .RadComboBox {
                margin-right: 20px;
            }

        li.rcbDisabled:hover {
            cursor: no-drop;
        }
    </style>
    <script type="text/javascript">
        function ClientSelectedIndexChanging(sender, args) {
            args.set_cancel(true);

            var domEvent = args.get_domEvent();
            var item = args.get_item();
            var value = item.get_value();
            if (value == "2") { theCallback(item, domEvent) }
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbStatus">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="h1Title" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridProject" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnQuery">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridProject" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnClear">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="div_search"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridProject" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cmbStatus">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="h1Title" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="cmbStatus" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridProject" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnQuery">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cmbStatus" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridProject" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnClear">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="div_search" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridProject" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="GridProject">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridProject" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="GridDetail">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GridProject" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="GridDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <div style="width: 1200px; margin: auto;">
        <h1 runat="server" id="h1Title" style="text-align: center; margin-bottom: 30px;"><%=pageTitle %>项目</h1>
        <div id="div_search" class="searchArea" runat="server">
            <div class="row">
                <telerik:RadLabel ID="lblStatus" runat="server" Text="状态：" Width="85px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbStatus" runat="server" AutoPostBack="True" OnSelectedIndexChanged="cmbStatus_SelectedIndexChanged"></telerik:RadComboBox>
                <telerik:RadLabel ID="lblType" runat="server" Text="报修类型：" Width="85px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbType" runat="server"></telerik:RadComboBox>
                <telerik:RadLabel ID="lblSite" runat="server" Text="报修地点：" Width="85px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbSite" runat="server"></telerik:RadComboBox>
            </div>
            <div class="row">
                <telerik:RadLabel ID="lblPriority" runat="server" Text="优先级：" Width="85px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbPriority" runat="server"></telerik:RadComboBox>
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
        <div id="div_gridProject">
            <telerik:RadGrid ID="GridProject" runat="server" Height="310px" AutoGenerateColumns="False" OnItemDataBound="GridProject_ItemDataBound" OnNeedDataSource="GridProject_NeedDataSource" OnSelectedIndexChanged="GridProject_SelectedIndexChanged">
                <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                <ClientSettings EnablePostBackOnRowClick="True" EnableRowHoverStyle="True">
                    <Selecting AllowRowSelect="True" />
                    <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                </ClientSettings>
                <MasterTableView DataKeyNames="projectID" AllowAutomaticUpdates="True">
                    <CommandItemSettings ShowRefreshButton="False"></CommandItemSettings>
                    <Columns>
                        <telerik:GridBoundColumn DataField="projectID" HeaderText="项目号" UniqueName="projectID" FilterControlAltText="Filter projectID column">
                            <HeaderStyle HorizontalAlign="Center" Width="100px" Wrap="false"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" Wrap="False" Width="100px"></ItemStyle>
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
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <ItemTemplate>
                                <telerik:RadComboBox ID="cmbProjStatus" runat="server" Width="150px" SelectedValue='<%#Bind("projectStatus") %>' AutoPostBack="True" OnSelectedIndexChanged="cmbProjStatus_SelectedIndexChanged" OnClientSelectedIndexChanging="ClientSelectedIndexChanging">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="待分配" Value="0" Enabled="false" />
                                        <telerik:RadComboBoxItem Text="已分配" Value="1" Enabled="false" />
                                        <telerik:RadComboBoxItem Text="待跟进" Value="2" />
                                        <telerik:RadComboBoxItem Text="已完成" Value="3" />
                                    </Items>
                                </telerik:RadComboBox>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridHyperLinkColumn Text="View" UniqueName="viewDetail" AllowSorting="false" Target="_blank" DataNavigateUrlFields="projectID" DataNavigateUrlFormatString="./ProjectDetailPage.aspx?projID={0}">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" Wrap="False" Width="100px"></ItemStyle>
                        </telerik:GridHyperLinkColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
        <div id="div_gridDetail">
            <telerik:RadGrid ID="GridDetail" runat="server" Height="500px" AutoGenerateColumns="False" AutoGenerateDeleteColumn="True" OnDeleteCommand="GridDetail_DeleteCommand" OnItemCommand="GridDetail_ItemCommand" OnNeedDataSource="GridDetail_NeedDataSource" OnItemDataBound="GridDetail_ItemDataBound">
                <ClientSettings EnablePostBackOnRowClick="False" EnableRowHoverStyle="True">
                    <Selecting AllowRowSelect="True" />
                    <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
                </ClientSettings>
                <MasterTableView DataKeyNames="detailID" CommandItemDisplay="Top" EditMode="PopUp">
                    <CommandItemSettings AddNewRecordText="分配新维修员" ShowRefreshButton="False" ShowAddNewRecordButton="True" />
                    <Columns>
                        <telerik:GridBoundColumn DataField="detailID" HeaderText="维修单号" UniqueName="detailID" FilterControlAltText="Filter detailID column">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" Wrap="False" Width="100px"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="projectID" Display="False" UniqueName="projectID" FilterControlAltText="Filter projectID column"></telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="repairmanID" HeaderText="维修人员" UniqueName="repairmanID" FilterControlAltText="Filter repairmanID column">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" Wrap="False" Width="120px"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="severity" HeaderText="损坏程度" UniqueName="severity" FilterControlAltText="Filter severity column">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" Wrap="False" Width="120px"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="faultType" HeaderText="故障类型" UniqueName="faultType" FilterControlAltText="Filter faultType column">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" Wrap="False" Width="120px"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="faultStatus" HeaderText="故障状态" UniqueName="faultStatus" FilterControlAltText="Filter faultStatus column">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="120px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" Wrap="False" Width="120px"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="add_requirement" HeaderText="附加需求" UniqueName="add_requirement" FilterControlAltText="Filter add_requirement column">
                            <HeaderStyle HorizontalAlign="Center" Width="300px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Left" Width="300px"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="createDate" HeaderText="创建时间" Display="False" UniqueName="createDate" FilterControlAltText="Filter createDate column" DataFormatString="{0:yyyy/MM/dd}"></telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="updateDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="更新时间" UniqueName="updateDate" FilterControlAltText="Filter updateDate column">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="150px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" Wrap="False" Width="150px"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="deleteStatus" UniqueName="deleteStatus" FilterControlAltText="Filter deleteStatus column" Display="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="faultDetail" UniqueName="faultDetail" Display="false" FilterControlAltText="Filter faultDetail column" HeaderText="详细描述"></telerik:GridBoundColumn>
                        <telerik:GridHyperLinkColumn Text="View" UniqueName="viewDetail" AllowSorting="false" Target="_blank" DataNavigateUrlFields="detailID" DataNavigateUrlFormatString="./RepairDetailPage.aspx?detailID={0}">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="100px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" Wrap="False" Width="100px"></ItemStyle>
                        </telerik:GridHyperLinkColumn>
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
</asp:Content>
