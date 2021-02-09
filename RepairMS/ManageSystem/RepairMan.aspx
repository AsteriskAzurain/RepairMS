<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RepairMan.aspx.cs" Inherits="RepairMS.ManageSystem.RepairMan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>维修人员管理 - SBS报修后台管理系统</title>
    <style>
        #div_container {
            width: 600px;
            margin: auto;
            margin-top: 50px;
        }

        #div_formRM {
            display: flex;
            margin: 40px 0 15px 0;
        }

            #div_formRM .rbPrimaryButton {
                margin-left: 30px;
                margin-right: 15px;
            }

        .statusButton {
            width: 75px;
            height: 30px;
            border: 1px solid gainsboro;
            border-radius: 15px !important;
        }

        .status-0 {
            color: black;
            background-color: gainsboro;
        }

        .status-1 {
            color: white;
            background-color: #337ab7;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="GridRM">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="GridRM" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnAdd">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tbName" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="GridRM" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnQuery">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tbName" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="GridRM" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <div id="div_container">
            <h1 style="text-align: center;">维修人员管理</h1>
            <div id="div_formRM">
                <telerik:RadTextBox ID="tbName" runat="server" Width="350px" EmptyMessage="Name of the repairman"></telerik:RadTextBox>
                <telerik:RadButton ID="btnAdd" runat="server" Text="添加" RenderMode="Lightweight" Primary="true" Width="100px" OnClick="btnAdd_Click" UseSubmitBehavior="false"></telerik:RadButton>
                <telerik:RadButton ID="btnQuery" runat="server" Text="查找" RenderMode="Lightweight" Width="100px" OnClick="btnQuery_Click"></telerik:RadButton>
            </div>
            <div id="div_gridRM">
                <telerik:RadGrid ID="GridRM" runat="server" AutoGenerateColumns="False" RenderMode="Lightweight"
                    OnNeedDataSource="GridRM_NeedDataSource" OnItemDataBound="GridRM_ItemDataBound" OnItemCommand="GridRM_ItemCommand" AllowPaging="True">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <ClientSettings>
                        <Selecting AllowRowSelect="True"></Selecting>
                        <Scrolling AllowScroll="True" ScrollHeight="430px" UseStaticHeaders="True"></Scrolling>
                    </ClientSettings>
                    <MasterTableView>
                        <RowIndicatorColumn Visible="False">
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn Created="True">
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridBoundColumn DataField="repairmanID" HeaderText="编号" UniqueName="repairmanID" DataType="System.Int32" FilterControlAltText="Filter column column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="repairmanName" HeaderText="姓名" UniqueName="repairmanName" FilterControlAltText="Filter column1 column">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="200px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="password" Visible="False" UniqueName="password" FilterControlAltText="Filter column2 column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="deleteStatus" HeaderText="状态" UniqueName="deleteStatus" FilterControlAltText="Filter column3 column" Display="false">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="100px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn CommandName="switchStatus" DataTextField="deleteStatus" FilterControlAltText="Filter column column" HeaderText="状态" UniqueName="buttonStatus" ButtonType="PushButton">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Width="120px"></ItemStyle>
                            </telerik:GridButtonColumn>
                        </Columns>
                        <PagerStyle AlwaysVisible="True" />
                    </MasterTableView>

                    <FilterMenu RenderMode="Lightweight"></FilterMenu>

                    <HeaderContextMenu RenderMode="Lightweight"></HeaderContextMenu>
                </telerik:RadGrid>
            </div>
        </div>
    </form>
</body>
</html>
