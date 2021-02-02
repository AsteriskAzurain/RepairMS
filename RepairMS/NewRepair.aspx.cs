using DataAccess.BLL;
using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RepairMS
{
    public partial class NewRepair : System.Web.UI.Page
    {
        public readonly projectBLL pBLL = new projectBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) initForm();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            projectTable entity = new projectTable();
            entity.projectID = -1;
            entity.projectStatus = 0;
            entity.hasDetail = 0;
            string contactName = tbContactName.Text.Trim();
            if (contactName != "") entity.contactName = contactName;
            string contactPhone = tbContactPhone.Text.Trim();
            if (contactPhone != "") entity.contactPhone = contactPhone;
            else { RadAjaxManager1.Alert("请填写联系方式。"); tbContactPhone.Focus(); return; }
            entity.priority = Convert.ToInt32(cmbPriority.SelectedValue);
            entity.projectType = Convert.ToInt32(cmbProjectType.SelectedValue);
            entity.projectSite = Convert.ToInt32(cmbProjectSite.SelectedValue);
            string detailSite = tbSiteDetail.Text.Trim();
            if (detailSite != "") entity.siteDetail = detailSite;
            else { RadAjaxManager1.Alert("请填写具体地点。"); tbSiteDetail.Focus(); return; }
            string detail = tbProjectDetail.Text.Trim();
            if (detail != "") entity.projectDetail = detail;

            if (pBLL.addNewRepairProject(entity)) { RadAjaxManager1.Alert("报修已提交。"); initForm(); }
            else RadAjaxManager1.Alert("提交失败，请重试。");

        }

        private void initForm()
        {
            tbContactName.Text = "";
            tbContactPhone.Text = "";
            cmbPriority.SelectedIndex = 0;
            cmbProjectType.SelectedIndex = 0;
            cmbProjectSite.SelectedIndex = 0;
            tbSiteDetail.Text = "";
            tbProjectDetail.Text = "";
        }
    }
}