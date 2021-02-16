using DataAccess.BLL;
using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace RepairMS.ManageSystem
{
    public partial class ProjectDetailPage : System.Web.UI.Page
    {
        public projectBLL projBLL = new projectBLL();
        public projectDetailBLL detailBLL = new projectDetailBLL();
        public repairmanBLL rmBLL = new repairmanBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cmb_BindData();
                setInputEnable(false);

                int projID;
                if (int.TryParse(Request.QueryString["projID"], out projID))
                {
                    tbProjectID.Text = projID.ToString();
                    getProjInfoByID(projID);
                }
                else
                {
                    lblWarning.Visible = true;
                    btnEdit.Enabled = false;
                }
            }
            btnEdit.Visible = (Session["CurrentRole"] != null && Session["CurrentRole"].ToString() == "1");
        }
        private void getProjInfoByID(int projID)
        {
            projectTable entity = projBLL.getProjectInfoByID(projID);
            if (entity != null)
            {
                cmbProjectStatus.SelectedValue = entity.projectStatus.ToString();
                cmbProjectType.SelectedValue = entity.projectType.ToString();
                cmbPriority.SelectedValue = entity.priority.ToString();
                dateCreate.SelectedDate = entity.createDate.Value;
                tbContactName.Text = entity.contactName;
                tbContactPhone.Text = entity.contactPhone;
                tbProjectDetail.Text = entity.projectDetail;
                cmbProjectSite.SelectedValue = entity.projectSite.ToString();
                tbSiteDetail.Text = entity.siteDetail;
                if (entity.updateDate.HasValue) dateUpdate.SelectedDate = entity.updateDate.Value;
                tbRepairman.Text = detailBLL.getProjectRepairMan(projID);
                setDetailGridVisible(Convert.ToBoolean(entity.hasDetail));
            }
        }

        private void cmb_BindData()
        {
            Global.ComboBox_BindLevelData(cmbPriority);
            Dictionary<int, RadComboBox> cmbList_param = new Dictionary<int, RadComboBox>() {
                {Global.ProjectStatus,cmbProjectStatus },  {Global.ProjectType,cmbProjectType }, {Global.ProjectSite,cmbProjectSite }
            };
            foreach (int paramType in cmbList_param.Keys)
            {
                Global.ComboBox_BindParamData(cmbList_param[paramType], paramType);
            }
        }

        private void setInputEnable(bool isEnable)
        {
            RadWebControl[] UnEditableControls = { tbProjectID, dateUpdate, tbRepairman };
            foreach (RadWebControl ctrl in UnEditableControls) ctrl.Enabled = false;
            RadWebControl[] InputControls = { dateCreate, tbContactName, tbContactPhone, tbProjectDetail, tbSiteDetail };
            RadComboBox[] InputCombobox = { cmbProjectStatus, cmbProjectType, cmbPriority, cmbProjectSite };
            foreach (RadWebControl ctrl in InputControls) ctrl.Enabled = isEnable;
            foreach (RadComboBox cmb in InputCombobox) cmb.Enabled = isEnable;

            btnEdit.Enabled = !isEnable;
            div_editBtns.Visible = isEnable;
            //div_Griddetail.Visible = isEnable;
        }

        private void setDetailGridVisible(bool isVisible)
        {
            div_Griddetail.Visible = isVisible;
            if (isVisible)
            {
                int projID = Convert.ToInt32(tbProjectID.Text);
                DataTable dt = detailBLL.getDetailDataTableByProjID(projID);
                GridDetail.DataSource = dt;
                GridDetail.DataBind();
            }
        }

        protected void GridDetail_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                int rmID = Convert.ToInt32(item["repairmanID"].Text);
                item["repairmanID"].Text = rmBLL.getRMinfoById(rmID).repairmanName;
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            setInputEnable(true);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            projectTable entity = projBLL.getProjectInfoByID(Convert.ToInt32(tbProjectID.Text));
            if (entity != null)
            {
                if (cmbProjectStatus.SelectedIndex > 0) entity.projectStatus = Convert.ToInt32(cmbProjectStatus.SelectedValue);
                if (cmbProjectType.SelectedIndex > 0) entity.projectType = Convert.ToInt32(cmbProjectType.SelectedValue);
                entity.priority = Convert.ToInt32(cmbPriority.SelectedValue);
                if (dateCreate.SelectedDate.HasValue) entity.createDate = dateCreate.SelectedDate.Value;
                if (tbContactName.Text != "") entity.contactName = tbContactName.Text.Trim();
                if (tbContactPhone.Text != "") entity.contactPhone = tbContactPhone.Text.Trim();
                if (tbProjectDetail.Text != "") entity.projectDetail = tbProjectDetail.Text;
                if (cmbProjectSite.SelectedIndex > 0) entity.projectSite = Convert.ToInt32(cmbProjectSite.SelectedValue);
                if (tbSiteDetail.Text != "") entity.siteDetail = tbSiteDetail.Text.Trim();
                if (dateUpdate.SelectedDate.HasValue) entity.updateDate = dateUpdate.SelectedDate.Value;
                if (projBLL.updateProjectInfo(entity))
                {
                    RadAjaxManager1.Alert("更新成功");
                    setInputEnable(false);
                    getProjInfoByID(entity.projectID);
                }
                else RadAjaxManager1.Alert("更新失败");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            setInputEnable(false);
        }
    }
}