<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewRepair.aspx.cs" Inherits="RepairMS.NewRepair" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>新增报修单</title>
    <style>
        .container {
            display: grid;
            width: 500px;
            border: solid 1px;
            padding: 30px;
            grid-row-gap: 20px;
            align-items: center;
        }

        #repairForm {
            /*margin: auto;*/
            grid-template-columns: 100px auto;
            justify-content: center;
            /*justify-items: center;*/
        }

        .span-col-2 {
            text-align: center;
            grid-column: span 2;
        }

        #queryForm {
            margin-left: 20px;
            /*grid-template-rows: 75px 36px auto;*/
            /*grid-template-columns: 200px 300px;*/
            grid-template-rows: 75px repeat(3,40px) 100px 40px 100px;
        }

        .text-right {
            text-align: right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">

            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnSubmit">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tbContactName" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbContactPhone" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="cmbPriority" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="cmbProjectType" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="cmbProjectSite" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbSiteDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbProjectDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnSubmit">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tbContactName"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbContactPhone"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="cmbPriority"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="cmbProjectType"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="cmbProjectSite"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbSiteDetail"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbProjectDetail"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbQueryID" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="btnQuery" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbProjectStatus" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbRepairMan" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbQueryDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbUpdateDate" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbFaultDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnQuery">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tbContactName" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbContactPhone" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="cmbPriority" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="cmbProjectType" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="cmbProjectSite" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbSiteDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbProjectDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbQueryID" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbProjectStatus" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbRepairMan" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbQueryDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbUpdateDate" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="tbFaultDetail" UpdatePanelCssClass=""></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <div style="/*margin: auto; */ display: flex; justify-content: center;">
            <div id="repairForm" class="container">
                <h2 class="span-col-2">新增报修单</h2>
                <telerik:RadLabel ID="lblContactName" runat="server" Text="姓名："></telerik:RadLabel>
                <telerik:RadTextBox ID="tbContactName" runat="server"></telerik:RadTextBox>
                <telerik:RadLabel ID="lblContactPhone" runat="server" Text="联系方式："></telerik:RadLabel>
                <telerik:RadTextBox ID="tbContactPhone" runat="server" InputType="Tel"></telerik:RadTextBox>
                <telerik:RadLabel ID="lblPriority" runat="server" Text="优先级："></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbPriority" runat="server">
                    <Items>
                        <telerik:RadComboBoxItem Text="请选择" Value="0" />
                        <telerik:RadComboBoxItem Text="低" Value="1" />
                        <telerik:RadComboBoxItem Text="中" Value="2" />
                        <telerik:RadComboBoxItem Text="高" Value="3" />
                    </Items>
                </telerik:RadComboBox>
                <telerik:RadLabel ID="lblProjectType" runat="server" Text="问题类型："></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbProjectType" runat="server">
                    <Items>
                        <telerik:RadComboBoxItem Text="电脑问题" Value="1" />
                        <telerik:RadComboBoxItem Text="器材问题" Value="2" />
                        <telerik:RadComboBoxItem Text="其他问题" Value="3" />
                    </Items>
                </telerik:RadComboBox>
                <telerik:RadLabel ID="lblProjectSite" runat="server" Text="报修地点："></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbProjectSite" runat="server">
                    <Items>
                        <telerik:RadComboBoxItem Text="教室" Value="1" />
                        <telerik:RadComboBoxItem Text="宿舍" Value="2" />
                        <telerik:RadComboBoxItem Text="其他" Value="3" />
                    </Items>
                </telerik:RadComboBox>
                <telerik:RadLabel ID="lblSiteDetail" runat="server" Text="具体位置："></telerik:RadLabel>
                <telerik:RadTextBox ID="tbSiteDetail" runat="server" Width="300px"></telerik:RadTextBox>
                <telerik:RadLabel ID="lblProjectDetail" runat="server" Text="详细描述："></telerik:RadLabel>
                <telerik:RadTextBox ID="tbProjectDetail" runat="server" Width="300px" Height="100px" TextMode="MultiLine"></telerik:RadTextBox>
                <telerik:RadButton ID="btnSubmit" runat="server" Text="提交" RenderMode="Lightweight" Primary="true" CssClass="span-col-2" OnClick="btnSubmit_Click"></telerik:RadButton>
            </div>
            <div id="queryForm" class="container">
                <h2 class="span-col-2">查询报修情况</h2>
                <div class="span-col-2" style="display: flex; width: fit-content; margin: auto;">
                    <telerik:RadTextBox ID="tbQueryID" runat="server" Width="270px"></telerik:RadTextBox>
                    <telerik:RadButton ID="btnQuery" runat="server" Text="查询" RenderMode="Lightweight" Primary="true" Width="80px" OnClick="btnQuery_Click"></telerik:RadButton>
                </div>
                <telerik:RadLabel ID="lblProjectStatus" runat="server" Text="项目状态：" CssClass="text-right"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbProjectStatus" runat="server" Width="250px" Enabled="false"></telerik:RadTextBox>
                <telerik:RadLabel ID="lblRepairMan" runat="server" Text="分配人员：" CssClass="text-right"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbRepairMan" runat="server" Width="250px" Enabled="false"></telerik:RadTextBox>
                <telerik:RadLabel ID="lblQueryDetail" runat="server" Text="详细描述：" CssClass="text-right"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbQueryDetail" runat="server" Width="250px" Height="85px" Enabled="false"></telerik:RadTextBox>
                <telerik:RadLabel ID="lblUpdateDate" runat="server" Text="维修时间：" CssClass="text-right"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbUpdateDate" runat="server" Width="250px" Enabled="false"></telerik:RadTextBox>
                <telerik:RadLabel ID="lblFaultDetail" runat="server" Text="说明事项：" CssClass="text-right"></telerik:RadLabel>
                <telerik:RadTextBox ID="tbFaultDetail" runat="server" Width="250px" Height="85px" Enabled="false"></telerik:RadTextBox>

            </div>
        </div>
    </form>
</body>
</html>
