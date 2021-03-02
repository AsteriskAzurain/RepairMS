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
            grid-template-columns: 10px 100px auto;
            justify-content: center;
            /*justify-items: center;*/
        }

        .span-col-2 {
            text-align: center;
            grid-column: span 2;
        }

        .span-col-3 {
            text-align: center;
            grid-column: span 3;
        }

        .span-row-2 {
            grid-row: span 2;
        }

        #queryForm {
            margin-left: 20px;
            /*grid-template-rows: 75px 36px auto;*/
            /*grid-template-columns: 200px 300px;*/
            grid-template-rows: 75px 70px 40px 40px 100px 40px 100px;
        }

        .text-right {
            text-align: right;
        }

        #queryRepair {
            font-size: small;
            display: grid;
            width: fit-content;
            margin: auto;
            grid-template-columns: 270px 70px;
            grid-template-rows: 30px;
            justify-items: left;
        }

        #titleArea {
            /*width: 400px;*/
            /*height: 80px;*/
            padding-bottom: 30px;
            margin: auto;
            text-align: center;
        }

            #titleArea h1 {
                margin-bottom: 5px;
            }

        .smbtnLogin {
            font-size: 9px !important;
            float: right;
            right: 10%;
        }

            .smbtnLogin.RadLinkButton {
                padding: 2px !important;
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
        <div id="titleArea">
            <telerik:RadLinkButton ID="btnLogin" runat="server" Text="后台登录" NavigateUrl="~/ManageSystem/Login.aspx" Width="70px" Height="25px" CssClass="smbtnLogin"></telerik:RadLinkButton>
            <h1>校园报修信息管理系统</h1>
            <%--<span><a href="ManageSystem/Login.aspx" style="float: right;">后台登录</a></span>--%>
        </div>
        <div style="/*margin: auto; */ display: flex; justify-content: center;">
            <div id="repairForm" class="container" runat="server">
                <h2 class="span-col-3">新增报修单</h2>
                <span>&nbsp;</span>
                <telerik:RadLabel ID="lblContactName" runat="server" Text="姓名："></telerik:RadLabel>
                <telerik:RadTextBox ID="tbContactName" runat="server"></telerik:RadTextBox>
                <span style="color: red;">*</span>
                <telerik:RadLabel ID="lblContactPhone" runat="server" Text="联系方式："></telerik:RadLabel>
                <telerik:RadTextBox ID="tbContactPhone" runat="server" InputType="Tel"></telerik:RadTextBox>
                <span>&nbsp;</span>
                <telerik:RadLabel ID="lblPriority" runat="server" Text="优先级："></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbPriority" runat="server"></telerik:RadComboBox>
                <span style="color: red;">*</span>
                <telerik:RadLabel ID="lblProjectType" runat="server" Text="报修类别："></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbProjectType" runat="server"></telerik:RadComboBox>
                <span style="color: red;">*</span>
                <telerik:RadLabel ID="lblProjectSite" runat="server" Text="报修地点："></telerik:RadLabel>
                <telerik:RadComboBox ID="cmbProjectSite" runat="server"></telerik:RadComboBox>
                <span style="color: red;">*</span>
                <telerik:RadLabel ID="lblSiteDetail" runat="server" Text="具体位置："></telerik:RadLabel>
                <telerik:RadTextBox ID="tbSiteDetail" runat="server" Width="300px"></telerik:RadTextBox>
                <span>&nbsp;</span>
                <telerik:RadLabel ID="lblProjectDetail" runat="server" Text="详细描述："></telerik:RadLabel>
                <telerik:RadTextBox ID="tbProjectDetail" runat="server" Width="300px" Height="100px" TextMode="MultiLine"></telerik:RadTextBox>
                <span>&nbsp;</span>
                <telerik:RadButton ID="btnSubmit" runat="server" Text="提交" RenderMode="Lightweight" Primary="true" CssClass="span-col-2" OnClick="btnSubmit_Click"></telerik:RadButton>
            </div>
            <div id="queryForm" class="container" runat="server">
                <h2 class="span-col-2">查询报修情况</h2>
                <div class="span-col-2" id="queryRepair">
                    <telerik:RadTextBox ID="tbQueryID" runat="server" EmptyMessage="输入查询的报修单号" Width="270px"></telerik:RadTextBox>
                    <telerik:RadButton runat="server" ID="btnQuery" OnClick="btnQuery_Click" RenderMode="Lightweight" EnableEmbeddedSkins="false" Width="60px" Height="60px">
                        <Icon PrimaryIconCssClass="rbSearch" />
                    </telerik:RadButton>
                    <telerik:RadTextBox ID="tbQueryName" runat="server" EmptyMessage="输入查询的报修者" Width="270px"></telerik:RadTextBox>
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
