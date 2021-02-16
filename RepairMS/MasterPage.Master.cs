using System;
using Telerik.Web.UI;

namespace RepairMS
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CurrentRole"] != null)
            {
                RadMenu1.Items.Clear();
                int role = Convert.ToInt32(Session["CurrentRole"]);
                if (role == 0) // 维修人员
                {
                    RadMenuItem item1 = new RadMenuItem("待处理项目", "./ManageSystem/MyRepairProject.aspx");
                    RadMenu1.Items.Add(item1);
                    RadMenuItem item2 = new RadMenuItem("登出", "./ManageSystem/Login.aspx");
                    RadMenu1.Items.Add(item2);
                }
                else // 管理员
                {
                    RadMenuItem[] items = new RadMenuItem[]
                    {
                        new RadMenuItem("待分配项目", "./ManageSystem/AssignProject.aspx?Status=0"),
                        new RadMenuItem("已分配项目", "./ManageSystem/AssignProject.aspx?Status=1"),
                        new RadMenuItem("待跟进项目", "./ManageSystem/RepairProject.aspx?Status=2"),
                        new RadMenuItem("已完成项目", "./ManageSystem/RepairProject.aspx?Status=3"),
                        new RadMenuItem("维修人员管理", "./ManageSystem/RepairMan.aspx"),
                        new RadMenuItem("登出", "./ManageSystem/Login.aspx")
                    };
                    RadMenu1.Items.AddRange(items);
                }
            }
        }
    }
}