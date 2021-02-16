using DataAccess.Entity;
using System;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace RepairMS
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        public int UserRole;
        public string UserName;
        public repairmanTable currentRepairMan;
        public employeeTable currentEmployee;

        protected void Page_Load(object sender, EventArgs e)
        {
            UserRole = -1;
            if (Session["CurrentRole"] != null)
            {
                RadMenu1.Items.Clear();
                UserRole = Convert.ToInt32(Session["CurrentRole"]);
                if (UserRole == 0) // 维修人员
                {
                    RadMenuItem item1 = new RadMenuItem("我的项目", "./ManageSystem/MyRepairProject.aspx");
                    RadMenu1.Items.Add(item1);
                }
                else // 管理员
                {
                    RadMenuItem[] items = new RadMenuItem[]
                    {
                        new RadMenuItem("待分配项目", "./ManageSystem/AssignProject.aspx?Status=0"),
                        new RadMenuItem("已分配项目", "./ManageSystem/AssignProject.aspx?Status=1"),
                        new RadMenuItem("待跟进项目", "./ManageSystem/RepairProject.aspx?Status=2"),
                        new RadMenuItem("已完成项目", "./ManageSystem/RepairProject.aspx?Status=3"),
                        new RadMenuItem("维修人员管理", "./ManageSystem/RepairMan.aspx")
                    };
                    RadMenu1.Items.AddRange(items);
                }
            }

            if (UserRole > -1 && Session["CurrentLoginUser"] != null)
            {
                if (UserRole == 0) { currentRepairMan = Session["CurrentLoginUser"] as repairmanTable; UserName = currentRepairMan.repairmanName; }
                else { currentEmployee = Session["CurrentLoginUser"] as employeeTable; UserName = currentEmployee.employeeName; }
                lblWelcome.Text = string.Format("您好, <br /> {0}{1}.", (UserRole == 0 ? "维修员" : "管理员"), UserName);
            }

            string pagename = ContentPlaceHolder1.Page.GetType().ToString().ToLower();
            string redirectURL = "alert('此页面无权限访问。'); window.location.href='./Login.aspx';";
            if (pagename.Contains("MyRepairProject".ToLower())) //ASP.managesystem_myrepairproject_aspx
            {
                if (UserRole != 0)
                    ContentPlaceHolder1.Page.ClientScript.RegisterClientScriptBlock(GetType(), "ToLogin", redirectURL, true);
            }
            else
            {
                if (UserRole != 1)
                    ContentPlaceHolder1.Page.ClientScript.RegisterClientScriptBlock(GetType(), "ToLogin", redirectURL, true);
            }
        }
    }
}