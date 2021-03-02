<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="RepairMS.ManageSystem.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>登录 - 校园报修信息管理系统</title>

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" />

    <style>
        .container {
            display: grid;
            grid-template-columns: 100px auto;
            grid-row-gap: 20px;
            justify-content: center;
            align-items: center;
            margin: auto;
            border: 1px solid black;
            padding: 20px;
            width: 400px;
        }

        .span-col-2 {
            text-align: center;
            grid-column: span 2;
        }

        .mt-20 {
            margin-top: 20px;
        }

        .mb-20 {
            margin-bottom: 20px;
        }

        #titleArea {
            margin: 20px 0;
        }

            #titleArea h2 {
                margin-top: 5px;
                margin-bottom: 0px;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnLogin">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tbName" UpdatePanelCssClass="" />
                        <telerik:AjaxUpdatedControl ControlID="tbPswd" UpdatePanelCssClass="" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <div class="container">
            <div id="titleArea" class="span-col-2">
                <h2>校园报修信息管理系统</h2>
                <h2>登录</h2>
            </div>
            <telerik:RadLabel ID="lblRole" runat="server" Text="登录身份："></telerik:RadLabel>
            <telerik:RadRadioButtonList ID="rdoRole" runat="server" Direction="Horizontal">
                <Items>
                    <telerik:ButtonListItem Text="维修人员" Value="0" Selected="true" />
                    <telerik:ButtonListItem Text="管理人员" Value="1" />
                </Items>
            </telerik:RadRadioButtonList>
            <telerik:RadLabel ID="lblName" runat="server" Text="登录名："></telerik:RadLabel>
            <telerik:RadTextBox ID="tbName" runat="server"></telerik:RadTextBox>
            <telerik:RadLabel ID="lblPswd" runat="server" Text="密码："></telerik:RadLabel>
            <telerik:RadTextBox ID="tbPswd" runat="server" TextMode="Password"></telerik:RadTextBox>
            <telerik:RadButton ID="btnForget" runat="server" Visible="false" Text="忘记密码？" BorderStyle="None" Font-Underline="true" ForeColor="#0000cc" CssClass="span-col-2"></telerik:RadButton>
            <telerik:RadButton ID="btnLogin" runat="server" Text="登录" OnClick="btnLogin_Click" RenderMode="Lightweight" Primary="true" CssClass="span-col-2 mt-20"></telerik:RadButton>
            <telerik:RadLinkButton ID="btnNewRepair" runat="server" Text="跳转填写报修单" NavigateUrl="~/NewRepair.aspx" CssClass="span-col-2 mb-20"></telerik:RadLinkButton>
        </div>
    </form>
</body>
</html>
