using DataAccess.BLL;
using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            }
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
            entity.projectID = pBLL.addNewRepairProject(entity);
            if (entity.projectID != -1)
            {
                RadAjaxManager1.Alert("报修已提交。");
                clearForm();
                tbQueryID.Text = entity.projectID.ToString();
                fillQueryForm(entity.projectID);
            }
            else RadAjaxManager1.Alert("提交失败，请重试。");

        }

        private void clearForm()
        {
            tbContactName.Text = "";
            tbContactPhone.Text = "";
            cmbPriority.SelectedIndex = 0;
            cmbProjectType.SelectedIndex = 0;
            cmbProjectSite.SelectedIndex = 0;
            tbSiteDetail.Text = "";
            tbProjectDetail.Text = "";

            tbProjectStatus.Text = "";
            tbRepairMan.Text = "";
            tbQueryDetail.Text = "";
            tbUpdateDate.Text = "";
            tbFaultDetail.Text = "";
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            string queryID = tbQueryID.Text.Trim();
            if (queryID == "") { RadAjaxManager1.Alert("请输入报修单号。"); tbQueryID.Focus(); return; }
            fillQueryForm(Convert.ToInt32(queryID));
        }

        private void fillQueryForm(int queryID)
        {
            projectTable info = pBLL.getProjectInfoByID(queryID);
            
            if (info != null)
            {
                tbProjectStatus.Text = paramBLL.getProjectStatusByValue(info.projectStatus.Value);
                tbRepairMan.Text = dBLL.getProjectRepairMan(queryID);
                if(info.projectDetail!=null && info.projectDetail!="") tbQueryDetail.Text = info.projectDetail;
                if (info.updateDate != null) tbUpdateDate.Text = info.updateDate.Value.ToString("yyyy/MM/dd");

                DataTable dt = dBLL.getDetailDataTableByProjID(queryID);
                if (dt.Rows.Count > 0) tbFaultDetail.Text = dt.Rows[0]["faultDetail"].ToString();
            }
        }
    }
}