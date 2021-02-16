<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyRepairProject.aspx.cs" Inherits="RepairMS.ManageSystem.MyRepairProject" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .card-container {
            display: flex;
            box-sizing: border-box;
            flex-wrap: wrap;
            justify-content: center;
        }

        .k-card {
            width: 325px;
            margin: 2%;
        }

        .k-card-footer {
            text-align: center;
            border-width: 1px 0 0;
            border-color: inherit;
        }

        .k-card .rbButton.k-button.rbHovered {
            color: inherit;
        }

        .k-button.RadButton.rbRounded {
            border-radius: 0;
        }

        .float-right {
            float: right;
        }

        .k-card-body p.threecols {
            display: grid;
            grid-template-columns: 25% 25% 50%;
        }

        .span-col-2 {
            grid-column: span 2;
        }

        ul.rcbList {
            background-color: white;
        }

            ul.rcbList li.rcbHovered {
                background-color: #F0F0F0;
            }

            ul.rcbList li.rcbDisabled:hover {
                cursor: no-drop;
            }

        #div_search {
            width: 1000px;
            margin: auto;
            display: grid;
            grid-row-gap: 10px;
            grid-template-columns: repeat(2,350px) repeat(2,150px);
        }

            #div_search .RadButton {
                justify-self: center;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
        <div>
            <h1 style="text-align: center;">我的待处理项目</h1>
            <div id="div_search" runat="server">
                <div>
                    <asp:HiddenField ID="hiddenRMID" runat="server" />
                    <telerik:RadLabel ID="lblProjID" runat="server" Width="90px">项目号：</telerik:RadLabel>
                    <telerik:RadTextBox ID="tbProjectID" runat="server"></telerik:RadTextBox>
                </div>
                <div style="grid-column: span 3;">
                    <telerik:RadLabel ID="lblDetailCreateDate" runat="server" Width="90px">分配日期：</telerik:RadLabel>
                    <telerik:RadDatePicker ID="DateDetailCreate" runat="server"></telerik:RadDatePicker>
                </div>
                <div>
                    <telerik:RadLabel ID="lblProjType" runat="server" Width="90px">报修类别：</telerik:RadLabel>
                    <telerik:RadComboBox ID="cmbProjectType" runat="server"></telerik:RadComboBox>
                </div>
                <div>
                    <telerik:RadLabel ID="lblProjSite" runat="server" Width="90px">报修地点：</telerik:RadLabel>
                    <telerik:RadComboBox ID="cmbProjectSite" runat="server"></telerik:RadComboBox>
                </div>
                <telerik:RadButton ID="btnQuery" runat="server" Text="查询" Width="120px" Primary="true" OnClick="btnQuery_Click"></telerik:RadButton>
                <telerik:RadButton ID="btnClear" runat="server" Text="清空" Width="120px" OnClick="btnClear_Click"></telerik:RadButton>
            </div>
            <div id="div_cards" class="card-container" runat="server"></div>
        </div>
    </form>
</body>
</html>
