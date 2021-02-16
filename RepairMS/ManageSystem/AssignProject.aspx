<%@ Page Language="C#" MasterPageFile="../MasterPage.Master" AutoEventWireup="true" CodeBehind="AssignProject.aspx.cs" Inherits="RepairMS.ManageSystem.AssignProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../styles/default.css" rel="stylesheet" />
    <title><%=pageTitle %>项目查询 - SBS报修后台管理系统</title>

    <style>
        #div_main {
            display: grid;
            grid-template-columns: 200px 100px 800px;
            align-items: center;
            justify-items: center;
        }

        #div_search {
            display: grid;
            width: 1100px;
            margin: auto;
            padding-bottom: 30px;
            grid-row-gap: 10px;
            align-items: center;
            grid-template-columns: repeat(3,30%) auto;
        }

            #div_search .RadButton {
                justify-self: center;
            }

        .rowDisabled.rgSelectedRow td {
            color: black !important;
            background-color: lightgray !important;
        }

        #cmbProjectStatus_DropDown li.rcbDisabled:hover {
            cursor: no-drop;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
    <div style="width: 1100px; margin: auto;">
        <h1 style="text-align: center; margin-bottom: 30px;"><%=pageTitle %>项目</h1>
        <div id="div_search">
            <div>
                <telerik:RadLabel ID="lblProjID" runat="server" Text="报修单号：" Width="80px"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbProjID" runat="server"></telerik:RadTextBox>
            </div>
            <div style="grid-column: span 3;">
                <telerik:RadLabel ID="lblProjStatus" runat="server" Text="报修状态:" Width="80px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbProjectStatus" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cmbProjectStatus_SelectedIndexChanged"></telerik:RadComboBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblPriority" runat="server" Text="优先级:" Width="80px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbPriority" runat="server"></telerik:RadComboBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblProjType" runat="server" Text="报修类型:" Width="80px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbProjectType" runat="server"></telerik:RadComboBox>
            </div>
            <div>
                <telerik:RadLabel ID="lblProjSite" runat="server" Text="报修地点:" Width="80px"></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbProjectSite" runat="server"></telerik:RadComboBox>
            </div>
            <telerik:RadButton ID="btnQuery" runat="server" Text="查询" Width="100px" Primary="True" OnClick="btnQuery_Click"></telerik:RadButton>
        </div>
        <div id="div_main">
            <div id="div_GridRM">
                <telerik:RadGrid ID="GridRM" runat="server" OnNeedDataSource="GridRM_NeedDataSource" AutoGenerateColumns="False" Width="200px" AllowPaging="True" Height="550px">
                    <ClientSettings>
                        <Selecting AllowRowSelect="True"></Selecting>
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridBoundColumn DataField="repairmanID" Display="False" UniqueName="repairmanID" FilterControlAltText="Filter column column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="repairmanName" UniqueName="repairmanName" FilterControlAltText="Filter column1 column" HeaderText="维修人员">
                                <HeaderStyle HorizontalAlign="Center" Font-Bold="True"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="password" Display="False" UniqueName="password" FilterControlAltText="Filter column2 column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="deleteStatus" Display="False" UniqueName="deleteStatus" FilterControlAltText="Filter column3 column"></telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <PagerStyle Mode="NextPrev" PageSizeControlType="None" HorizontalAlign="Center" AlwaysVisible="true" PagerTextFormat="{4} &nbsp;Page <strong>{0}</strong> of <strong>{1}</strong>"></PagerStyle>
                </telerik:RadGrid>
            </div>
            <div id="div_btn">
                <telerik:RadButton ID="btnAssign" runat="server" Text=">>" OnClick="btnAssign_Click" Primary="True" Width="50px" ToolTip="分配"></telerik:RadButton>
            </div>
            <div id="div_GridProj">
                <telerik:RadGrid ID="GridProj" runat="server" OnNeedDataSource="GridProj_NeedDataSource" AutoGenerateColumns="False" AllowPaging="True" Height="550px" OnItemDataBound="GridProj_ItemDataBound">
                    <ClientSettings>
                        <Selecting AllowRowSelect="True"></Selecting>
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>
                    <MasterTableView>
                        <Columns>
                            <telerik:GridBoundColumn UniqueName="projectID" FilterControlAltText="Filter column column" DataField="projectID" HeaderText="项目号">
                                <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Width="100px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="projectStatus" Display="False" UniqueName="projectStatus" FilterControlAltText="Filter projectStatus column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="priority" HeaderText="优先级" UniqueName="priority" FilterControlAltText="Filter priority column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="100px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="projectType" HeaderText="报修类型" UniqueName="projectType" FilterControlAltText="Filter projectType column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="120px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="120px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="projectSite" HeaderText="报修地点" UniqueName="projectSite" FilterControlAltText="Filter projectSite column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="120px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="120px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="contactName" Display="False" UniqueName="contactName" FilterControlAltText="Filter contactName column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="contactPhone" Display="False" UniqueName="contactPhone" FilterControlAltText="Filter contactPhone column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="projectDetail" Display="False" UniqueName="projectDetail" FilterControlAltText="Filter projectDetail column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="siteDetail" Display="False" UniqueName="siteDetail" FilterControlAltText="Filter siteDetail column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="hasDetail" Display="False" UniqueName="hasDetail" FilterControlAltText="Filter hasDetail column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="createDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="报修日期" UniqueName="createDate" DataType="System.DateTime" FilterControlAltText="Filter createDate column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="150px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="150px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="updateDate" DataFormatString="{0:yyyy/MM/dd}" Display="False" UniqueName="updateDate" FilterControlAltText="Filter updateDate column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="deleteStatus" Display="False" UniqueName="deleteStatus" FilterControlAltText="Filter deleteStatus column"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="维修人员" UniqueName="repairman" FilterControlAltText="Filter repairman column">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="150px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="150px"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridHyperLinkColumn Text="View" UniqueName="viewDetail" AllowSorting="false" Target="_blank" DataNavigateUrlFields="projectID" DataNavigateUrlFormatString="./ProjectDetailPage.aspx?projID={0}">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" Width="100px"></ItemStyle>
                            </telerik:GridHyperLinkColumn>
                        </Columns>
                    </MasterTableView>
                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                    <PagerStyle AlwaysVisible="True" PageSizeControlType="None" HorizontalAlign="Center"></PagerStyle>
                </telerik:RadGrid>
            </div>
        </div>
    </div>
</asp:Content>
