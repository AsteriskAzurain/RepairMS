﻿using DataAccess.BLL;
using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace RepairMS
{
    public partial class NewRepair : System.Web.UI.Page
    {
        public readonly projectBLL pBLL = new projectBLL();
        public readonly projectDetailBLL dBLL = new projectDetailBLL();
        public readonly paramBLL paramBLL = new paramBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //initForm();
                cmb_BindData();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            projectTable entity = new projectTable();
            entity.projectID = -1;
            entity.projectStatus = 0;
            entity.hasDetail = 0;
            entity.contactName = tbContactName.Text.Trim();
            string contactPhone = tbContactPhone.Text.Trim();
            if (contactPhone != "") entity.contactPhone = contactPhone;
            else { RadAjaxManager1.Alert("请填写联系方式。"); tbContactPhone.Focus(); return; }
            entity.priority = Convert.ToInt32(cmbPriority.SelectedValue);
            if (cmbProjectType.SelectedIndex > 0) entity.projectType = Convert.ToInt32(cmbProjectType.SelectedValue);
            else { RadAjaxManager1.Alert("请选择报修类别。"); cmbProjectType.Focus(); return; }
            if (cmbProjectSite.SelectedIndex > 0) entity.projectSite = Convert.ToInt32(cmbProjectSite.SelectedValue);
            else { RadAjaxManager1.Alert("请选择报修地点。"); cmbProjectSite.Focus(); return; }
            string detailSite = tbSiteDetail.Text.Trim();
            if (detailSite != "") entity.siteDetail = detailSite;
            else { RadAjaxManager1.Alert("请填写具体位置。"); tbSiteDetail.Focus(); return; }
            entity.projectDetail = tbProjectDetail.Text.Trim();
            entity.projectID = pBLL.addNewRepairProject(entity);
            if (entity.projectID > 0)
            {
                RadAjaxManager1.Alert("报修已提交。");
                Global.InputReset(repairForm);
                //Global.InputReset(queryForm, tbQueryID);
                tbQueryID.Text = entity.projectID.ToString();
                fillQueryForm(entity.projectID.ToString());
            }
            else RadAjaxManager1.Alert("提交失败，请重试。");

        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            string queryID = tbQueryID.Text.Trim();
            string queryName = tbQueryName.Text.Trim();
            if (queryID + queryName == "") { RadAjaxManager1.Alert("请输入报修单号或报修者姓名。"); return; }
            fillQueryForm(queryID, queryName);
        }

        private void fillQueryForm(string strqueryID, string strQueryName = "")
        {
            projectTable info = new projectTable();
            int queryID = 0;

            if (!string.IsNullOrEmpty(strqueryID))
            {
                queryID = Convert.ToInt32(strqueryID);
                info = pBLL.getProjectInfoByID(queryID);
            }
            else if (!string.IsNullOrEmpty(strQueryName))
            {
                info.contactName = strQueryName;
                DataTable dt = pBLL.getDataTableByEntity(info);
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    queryID = Convert.ToInt32(row["projectID"]);
                    info.projectID = queryID;
                    info.projectStatus = Convert.ToInt32(row["projectStatus"]);
                    info.projectDetail = row["projectDetail"] == null ? "" : row["projectDetail"].ToString();
                    info.updateDate = row["updateDate"] == null ? DateTime.MinValue : Convert.ToDateTime(row["updateDate"]);
                }
            }

            if (queryID > 0)
            {
                tbProjectStatus.Text = paramBLL.getProjectStatusByValue(info.projectStatus.Value);
                tbRepairMan.Text = dBLL.getProjectRepairMan(queryID);
                if (info.projectDetail != null && info.projectDetail != "") tbQueryDetail.Text = info.projectDetail;
                if (info.updateDate != null && info.updateDate > DateTime.MinValue) tbUpdateDate.Text = info.updateDate.Value.ToString("yyyy/MM/dd");

                DataTable dt = dBLL.getDetailDataTableByProjID(queryID);
                if (dt.Rows.Count > 0) tbFaultDetail.Text = dt.Rows[0]["faultDetail"].ToString();
            }
            else RadAjaxManager1.Alert("无对应项目，请检查报修单号后重试。");
        }

        private void cmb_BindData()
        {
            Global.ComboBox_BindLevelData(cmbPriority);
            Dictionary<int, RadComboBox> cmbList_param = new Dictionary<int, RadComboBox>() {
                 {Global.ProjectType,cmbProjectType }, {Global.ProjectSite,cmbProjectSite }
            };
            foreach (int paramType in cmbList_param.Keys)
            {
                Global.ComboBox_BindParamData(cmbList_param[paramType], paramType);
            }
        }
    }
}