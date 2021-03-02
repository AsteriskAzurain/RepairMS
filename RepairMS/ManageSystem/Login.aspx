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
            margin-top: 20px;
        }

            #titleArea h2 {
                margin-top: 5px;
                margin-bottom: 0px;
            }

        #roleArea {
            grid-column: span 2;
            display: flex;
            justify-content: space-between;
            width: 230px;
            margin: auto;
        }

        input[type="checkbox"][id^="cb"] {
            display: none;
        }

        label {
            border: 1px solid #fff;
            display: block;
            position: relative;
            cursor: pointer;
        }

            label:before {
                background-color: white;
                color: white;
                content: " ";
                display: block;
                border-radius: 50%;
                border: 1px solid grey;
                position: absolute;
                top: -5px;
                left: -5px;
                width: 25px;
                height: 25px;
                text-align: center;
                line-height: 28px;
                transition-duration: 0.4s;
                transform: scale(0);
                z-index: 1;
            }

            label img {
                height: 160px;
                width: 96px;
                border: #ddd 1px solid;
                transition-duration: 0.2s;
                transform-origin: 50% 50%;
            }

        :checked + label {
            /*border-color: #ddd;*/
            border-color: transparent;
        }

            :checked + label:before {
                content: "✓";
                background-color: grey;
                transform: scale(1);
            }

            :checked + label img {
                transform: scale(0.9);
                box-shadow: 0 0 5px #333;
                z-index: -1;
            }

        .d-none {
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                function fun_changeRDOval(sender, args, val) {
                    var cb1 = document.getElementById("cb1")
                    var cb2 = document.getElementById("cb2")
                    if (val == 0) cb2.checked = false
                    else if (val == 1) cb1.checked = false

                    var radioButtonList = $find("<%=rdoRole.ClientID%>")
                    radioButtonList.set_selectedIndex(val);
                }
            </script>
        </telerik:RadCodeBlock>
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
                <%--<span style="float: right"><a href="../NewRepair.aspx">跳转填写报修单</a></span>--%>
            </div>
            <div id="roleArea">
                <%--<telerik:RadImageButton ID="btnImgAdmin" runat="server" Image-Url="~/images/adminIcon.png" AutoPostBack="false" Image-Sizing="Stretch" Width="96px" Height="160px" BorderColor="#DDDDDD" BorderStyle="Solid" BorderWidth="2px"></telerik:RadImageButton>--%>
                <%--<telerik:RadImageButton ID="btnImgRm" runat="server" Image-Url="~/images/rmIcon.png" AutoPostBack="false" Image-Sizing="Stretch" Width="96px" Height="160px" BorderColor="#DDDDDD" BorderStyle="Solid" BorderWidth="2px"></telerik:RadImageButton>--%>
                <input type="checkbox" id="cb1" onclick="fun_changeRDOval(null, null, 0)" />
                <label for="cb1">
                    <img src="../images/rmIcon.png" alt="维修人员" /></label>
                <input type="checkbox" id="cb2" onclick="fun_changeRDOval(null, null, 1)" />
                <label for="cb2">
                    <img src="../images/adminIcon.png" alt="管理人员" /></label>

            </div>
            <telerik:RadLabel ID="lblRole" runat="server" Text="登录身份：" Visible="false"></telerik:RadLabel>
            <telerik:RadRadioButtonList ID="rdoRole" runat="server" Direction="Horizontal" CssClass="d-none">
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
