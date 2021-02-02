﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="RepairMS.ManageSystem.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>登录 - SBS报修后台管理系统</title>

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

        .my-20 {
            margin: 20px 0;
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
            <h2 class="span-col-2">登录</h2>
            <telerik:RadLabel ID="lblRole" runat="server" Text="登录身份："></telerik:RadLabel>
            <telerik:RadRadioButtonList ID="rdoRole" runat="server" Direction="Horizontal" AutoPostBack="true">
                <Items>
                    <telerik:ButtonListItem Text="维修人员" Value="0" Selected="true" />
                    <telerik:ButtonListItem Text="管理人员" Value="1"  />
                </Items>
            </telerik:RadRadioButtonList>
            <telerik:RadLabel ID="lblName" runat="server" Text="登录名："></telerik:RadLabel>
            <telerik:RadTextBox ID="tbName" runat="server"></telerik:RadTextBox>
            <telerik:RadLabel ID="lblPswd" runat="server" Text="密码："></telerik:RadLabel>
            <telerik:RadTextBox ID="tbPswd" runat="server" TextMode="Password" ></telerik:RadTextBox>
            <telerik:RadButton ID="btnForget" runat="server" Visible="false" Text="忘记密码？" BorderStyle="None" Font-Underline="true" ForeColor="#0000cc" CssClass="span-col-2"></telerik:RadButton>
            <telerik:RadButton ID="btnLogin" runat="server" Text="登录" OnClick="btnLogin_Click"
                RenderMode="Lightweight" Primary="true" CssClass="span-col-2 my-20"></telerik:RadButton>

        </div>
    </form>
</body>
</html>
