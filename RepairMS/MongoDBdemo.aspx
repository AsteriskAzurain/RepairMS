<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MongoDBdemo.aspx.cs" Inherits="RepairMS.MongoDBdemo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
        <div>
            <h1>MongoDB demo</h1>
            <telerik:RadButton ID="RadButton1" runat="server" Text="RadButton" OnClick="RadButton1_Click"></telerik:RadButton>
        </div>
    </form>
</body>
</html>
