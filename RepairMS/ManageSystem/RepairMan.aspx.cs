using DataAccess.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace RepairMS.ManageSystem
{
    public partial class RepairMan : System.Web.UI.Page
    {

        public readonly repairmanBLL rmBLL = new repairmanBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getGridData();
            }
        }

        private void getGridData()
        {
            DataTable dt = rmBLL.getAllRepairMen(true);
            if (dt.Rows.Count > 0)
            {
                ViewState["GridData"] = dt;
                GridRM.DataSource = dt;
                GridRM.DataBind();
            }
        }

        protected void GridRM_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            DataTable dt = ViewState["GridData"] as DataTable;
            (sender as RadGrid).DataSource = dt;
        }

        protected void GridRM_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                int deleteStatus = Convert.ToInt32(gridItem["deleteStatus"].Text);
                Button btnStatus = gridItem["buttonStatus"].Controls[0] as Button;
                btnStatus.Text = deleteStatus == 1 ? "在职" : "不可用";
                btnStatus.CssClass = "statusButton status-" + deleteStatus.ToString();
            }
        }

        protected void GridRM_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "switchStatus")
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                int rmID = Convert.ToInt32(gridItem["repairmanID"].Text);
                int deleteStatus = Convert.ToInt32(gridItem["deleteStatus"].Text);
                if (rmBLL.switchDeleteStatus(rmID, deleteStatus))
                {
                    int rowIndex = e.Item.ItemIndex + GridRM.CurrentPageIndex * GridRM.PageSize;
                    DataTable dt = ViewState["GridData"] as DataTable;
                    dt.Rows[rowIndex]["deleteStatus"] = deleteStatus == 1 ? "0" : "1";
                    ViewState["GridData"] = dt;
                }
            }
            GridRM.Rebind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string name = tbName.Text.Trim();
            if (name == "") { RadAjaxManager1.Alert("姓名不能为空。"); tbName.Focus(); return; }
            if (rmBLL.isRMNameExist(name)) { RadAjaxManager1.Alert("维修人员已存在，请检查后重试。"); tbName.Focus(); return; }
            if (rmBLL.addNewRepairMan(name)) { RadAjaxManager1.Alert("添加成功。"); tbName.Text = ""; }
            getGridData();
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            DataTable dt = rmBLL.getRMListByName(tbName.Text.Trim());
            ViewState["GridData"] = dt;
            GridRM.DataSource = dt;
            GridRM.DataBind();
        }
    }
}