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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
        <div>
            <h1 style="text-align:center;">我的待处理项目</h1>
            <div id="div_search"></div>
            <div id="div_cards" class="card-container" runat="server"></div>
        </div>
    </form>
</body>
</html>
