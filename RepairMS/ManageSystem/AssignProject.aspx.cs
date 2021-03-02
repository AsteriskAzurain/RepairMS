using DataAccess.BLL;
using DataAccess.Entity;
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
    public partial class AssignProject : System.Web.UI.Page
    {
        public string pageTitle;

        private repairmanBLL rmBLL = new repairmanBLL();
        private projectBLL projBLL = new projectBLL();
        private paramBLL paramBLL = new paramBLL();
        private projectDetailBLL detailBLL = new projectDetailBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["projectStatus"] = 0;
                if (Request.QueryString["Status"] != null) ViewState["projectStatus"] = Request.QueryString["Status"];
                cmb_BindData();
                getRMList();
                getProjData();
            }
            pageTitle = ViewState["projectStatus"].ToString() == "0" ? "待分配" : "已分配";
            Page.Title = pageTitle + "项目查询 - 校园报修信息管理系统";
        }

        protected void GridRM_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = ViewState["GridRMData"] as DataTable;
        }

        protected void GridProj_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = ViewState["GridProjData"] as DataTable;
        }

        private void getRMList()
        {
            DataTable dt = rmBLL.getAllRepairMen();
            ViewState["GridRMData"] = dt;
            GridRM.DataSource = dt;
            GridRM.DataBind();
        }

        private void getProjData()
        {
            string status = ViewState["projectStatus"].ToString();
            DataTable dt = status == "0" ? projBLL.getMyNeedAssignProject() : projBLL.getHasAssignedProject();
            ViewState["GridProjData"] = dt;
            GridProj.DataSource = dt;
            GridProj.DataBind();
        }

        protected void GridProj_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                int projID = Convert.ToInt32(item["projectID"].Text);
                string rms = detailBLL.getProjectRepairMan(projID);
                if (!string.IsNullOrEmpty(rms)) { item.CssClass = " rgRow rowDisabled "; item["repairman"].Text = rms; }
                else { item["repairman"].Text = "未分配"; item["repairman"].ForeColor = System.Drawing.Color.Red; }

                string[] flagArr = { "projectStatus", "priority", "projectType", "projectSite" };
                foreach (string flag in flagArr)
                {
                    item[flag].Text = Global.CmbItem_parseToText(item[flag].Text, flag);
                }

                foreach (GridColumn column in GridProj.MasterTableView.RenderColumns)
                {
                    item[column.UniqueName].ToolTip = item["projectDetail"].Text;
                }
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            if (GridProj.SelectedItems.Count == 0) { RadAjaxManager1.Alert("请选择要分配的项目。"); return; }
            if (GridRM.SelectedItems.Count == 0) { RadAjaxManager1.Alert("请选择要分配的人员。"); return; }
            if (!(GridProj.SelectedItems[0] as GridDataItem)["repairman"].Text.Equals("未分配")) { RadAjaxManager1.Alert("此项目已分配维修人员。"); return; }
            int rmID = Convert.ToInt32((GridRM.SelectedItems[0] as GridDataItem)["repairmanID"].Text);
            int projID = Convert.ToInt32((GridProj.SelectedItems[0] as GridDataItem)["projectID"].Text);
            int detailID = detailBLL.assignRepairMan(projID, rmID);
            if (detailID > 0) projBLL.updateRepairStatus(projID, 1);
            getProjData();
        }

        private void cmb_BindData()
        {
            Global.ComboBox_BindLevelData(cmbPriority);
            Dictionary<int, RadComboBox> cmbList_param = new Dictionary<int, RadComboBox>() {
                {Global.ProjectType,cmbProjectType }, {Global.ProjectSite,cmbProjectSite }, { Global.ProjectStatus,cmbProjectStatus}
            };
            foreach (int paramType in cmbList_param.Keys)
            {
                Global.ComboBox_BindParamData(cmbList_param[paramType], paramType);
            }
            cmbProjectStatus.Items[3].Enabled = false;
            cmbProjectStatus.Items[4].Enabled = false;
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            projectTable entity = new projectTable();
            if (tbProjID.Text != "") entity.projectID = Convert.ToInt32(tbProjID.Text);
            if (cmbProjectStatus.SelectedIndex > 0) entity.projectStatus = Convert.ToInt32(cmbProjectStatus.SelectedValue);
            if (cmbProjectType.SelectedIndex > 0) entity.projectType = Convert.ToInt32(cmbProjectType.SelectedValue);
            if (cmbProjectSite.SelectedIndex > 0) entity.projectSite = Convert.ToInt32(cmbProjectSite.SelectedValue);
            if (cmbPriority.SelectedIndex > 0) entity.priority = Convert.ToInt32(cmbPriority.SelectedValue);
            DataTable dt = projBLL.getDataTableByEntity(entity);
            ViewState["GridProjData"] = dt;
            GridProj.DataSource = dt;
            GridProj.DataBind();
        }

        protected void cmbProjectStatus_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if (cmbProjectStatus.SelectedIndex > 0)
            {
                ViewState["projectStatus"] = cmbProjectStatus.SelectedValue;
                pageTitle = cmbProjectStatus.SelectedItem.Text;
                getProjData();
            }
        }
    }
}