<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewRepair.aspx.cs" Inherits="RepairMS.NewRepair" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>新增报修单</title>
    <style>
        #repairForm {
            display: grid;
            width: 500px;
            border: solid 1px;
            padding: 30px;
            margin: auto;
            grid-template-columns: 100px auto;
            grid-row-gap: 20px;
            justify-content: center;
            /*justify-items: center;*/
            align-items: center;
        }

        .span-col-2 {
            text-align: center;
            grid-column: span 2;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <div id="repairForm">
            <h2 class="span-col-2">新增报修单</h2>
            <telerik:RadLabel ID="RadLabel2" runat="server" Text="姓名："></telerik:RadLabel>
            <telerik:RadTextBox ID="RadTextBox2" runat="server"></telerik:RadTextBox>
            <telerik:RadLabel ID="RadLabel1" runat="server" Text="联系方式："></telerik:RadLabel>
            <telerik:RadTextBox ID="RadTextBox1" runat="server" InputType="Tel"></telerik:RadTextBox>
            <telerik:RadLabel ID="RadLabel3" runat="server" Text="优先级："></telerik:RadLabel>
            <telerik:RadComboBox ID="RadComboBox1" runat="server">
                <Items>
                    <telerik:RadComboBoxItem Text="请选择" Value="0" />
                    <telerik:RadComboBoxItem Text="低" Value="1" />
                    <telerik:RadComboBoxItem Text="中" Value="2" />
                    <telerik:RadComboBoxItem Text="高" Value="3" />
                </Items>
            </telerik:RadComboBox>
            <telerik:RadLabel ID="RadLabel4" runat="server" Text="问题类型："></telerik:RadLabel>
            <telerik:RadComboBox ID="RadComboBox2" runat="server">
                <Items>
                    <telerik:RadComboBoxItem Text="电脑问题" Value="电脑问题" />
                    <telerik:RadComboBoxItem Text="器材问题" Value="器材问题" />
                </Items>
            </telerik:RadComboBox>
            <telerik:RadLabel ID="RadLabel5" runat="server" Text="报修地点："></telerik:RadLabel>
            <telerik:RadComboBox ID="RadComboBox3" runat="server">
                <Items>
                    <telerik:RadComboBoxItem Text="教室" Value="0" />
                    <telerik:RadComboBoxItem Text="宿舍" Value="1" />
                    <telerik:RadComboBoxItem Text="其他" Value="2" />
                </Items>
            </telerik:RadComboBox>
            <telerik:RadLabel ID="RadLabel6" runat="server" Text="具体位置："></telerik:RadLabel>
            <telerik:RadTextBox ID="RadTextBox3" runat="server" Width="300px"></telerik:RadTextBox>
            <telerik:RadLabel ID="RadLabel7" runat="server" Text="详细描述："></telerik:RadLabel>
            <telerik:RadTextBox ID="RadTextBox4" runat="server" Height="100px" Width="300px" TextMode="MultiLine"></telerik:RadTextBox>
            <telerik:RadButton ID="btnSubmit" runat="server" Text="提交" RenderMode="Lightweight" Primary="true" CssClass="span-col-2"></telerik:RadButton>
        </div>
    </form>
</body>
</html>
