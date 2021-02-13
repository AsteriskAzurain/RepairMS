using DataAccess.BLL;
using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RepairMS.ManageSystem
{
    public partial class Login : System.Web.UI.Page
    {
        public readonly employeeBLL eBLL = new employeeBLL();
        public readonly repairmanBLL rmBLL = new repairmanBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string userName = tbName.Text.Trim();
            string password = tbPswd.Text.Trim();
            if (userName == "") { RadAjaxManager1.Alert("请填写用户名。"); tbName.Focus(); return; }
            if (password == "") { RadAjaxManager1.Alert("请填写密码。"); tbPswd.Focus(); return; }
            bool isLoginSuccrss = false;
            object cuser;
            if (rdoRole.SelectedValue == "1")
            {
                cuser = eBLL.UserLogin(userName, password);
                isLoginSuccrss = (cuser as employeeTable).employeeID > 0;
            }
            else
            {
                cuser = rmBLL.UserLogin(userName, password);
                isLoginSuccrss = (cuser as repairmanTable).repairmanID > 0;
            }
            if (isLoginSuccrss)
            {
                Session["CurrentRole"] = rdoRole.SelectedValue;
                Session["CurrentLoginUser"] = cuser;
                RadAjaxManager1.Alert("登录成功");
                Response.Redirect("./MyRepairProject.aspx");
            }
            else
            {
                tbPswd.Text = "";
                RadAjaxManager1.Alert("登录失败，请检查后重试。");
            }
        }
    }

    /*
     protected void RadRadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadRadioButtonList radioButtonList = sender as RadRadioButtonList;
        string data = string.Format("selected index: {0}, selected value {1}, selected text: {2}",
                                    radioButtonList.SelectedIndex, radioButtonList.SelectedValue, radioButtonList.SelectedItem.Text);
        Label1.Text = data;
    }
     */


}