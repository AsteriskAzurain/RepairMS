using DataAccess.BLL;
using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace RepairMS.ManageSystem
{
    public partial class RepairDetailPage : System.Web.UI.Page
    {
        public projectDetailBLL detailBLL = new projectDetailBLL();
        public repairmanBLL rmBLL = new repairmanBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cmb_BindData();
                setInputEnable(false);

                int detailID;
                if (int.TryParse(Request.QueryString["detailID"], out detailID))
                {
                    tbDetailID.Text = detailID.ToString();
                    getRepairInfoByID(detailID);
                }
                else
                {
                    lblWarning.Visible = true;
                    btnEdit.Enabled = false;
                }
            }
            if (Session["CurrentRole"] != null)
            {
                if (Session["CurrentRole"].ToString() == "1") btnEdit.Visible = true;
                else
                {
                    btnEdit.Visible = false;
                    if (Session["CurrentLoginUser"] != null)
                    {
                        repairmanTable currentUser = Session["CurrentLoginUser"] as repairmanTable;
                        btnEdit.Visible = currentUser.repairmanName.Equals(tbRepairmanID.Text.Trim());
                    }
                }
            }
        }

        private void getRepairInfoByID(int detailID)
        {
            projectDetailTable entity = detailBLL.getDetailInfoByID(detailID);
            if (entity != null)
            {
                tbProjectID.Text = entity.projectID.ToString();
                viewProject.NavigateUrl = Global.projectURL + "?projID=" + entity.projectID.ToString();
                tbRepairmanID.Text = rmBLL.getRMinfoById(entity.repairmanID.Value).repairmanName;
                dateCreate.SelectedDate = entity.createDate.Value;
                cmbFaultStatus.SelectedValue = entity.faultStatus.ToString();
                cmbFaultType.SelectedValue = entity.faultType.ToString();
                cmbSeverity.SelectedValue = entity.severity.ToString();
                tbFaultDetail.Text = entity.faultDetail;
                tbAddRequirement.Text = entity.add_requirement;
            }
        }

        private void cmb_BindData()
        {
            Global.ComboBox_BindLevelData(cmbSeverity);
            Dictionary<int, RadComboBox> cmbList_param = new Dictionary<int, RadComboBox>() {
                {Global.FaultStatus,cmbFaultStatus },  {Global.FaultType,cmbFaultType }
            };
            foreach (int paramType in cmbList_param.Keys)
            {
                Global.ComboBox_BindParamData(cmbList_param[paramType], paramType);
            }
        }

        private void setInputEnable(bool isEnable)
        {
            RadWebControl[] UnEditableControls = { tbDetailID, tbProjectID, dateCreate, tbRepairmanID };
            foreach (RadWebControl ctrl in UnEditableControls) ctrl.Enabled = false;
            RadWebControl[] InputControls = { tbFaultDetail, tbAddRequirement };
            RadComboBox[] InputCombobox = { cmbFaultStatus, cmbFaultType, cmbSeverity };
            foreach (RadWebControl ctrl in InputControls) ctrl.Enabled = isEnable;
            foreach (RadComboBox cmb in InputCombobox) cmb.Enabled = isEnable;

            btnEdit.Enabled = !isEnable;
            viewProject.Enabled = !isEnable;
            div_editBtns.Visible = isEnable;
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            setInputEnable(true);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            projectDetailTable entity = detailBLL.getDetailInfoByID(Convert.ToInt32(tbDetailID.Text));
            if (cmbFaultStatus.SelectedIndex > 0) entity.faultStatus = Convert.ToInt32(cmbFaultStatus.SelectedValue);
            if (cmbFaultType.SelectedIndex > 0) entity.faultType = Convert.ToInt32(cmbFaultType.SelectedValue);
            if (cmbSeverity.SelectedIndex > 0) entity.severity = Convert.ToInt32(cmbSeverity.SelectedValue);
            if (tbFaultDetail.Text != "") entity.faultDetail = tbFaultDetail.Text;
            if (tbAddRequirement.Text != "") entity.add_requirement = tbAddRequirement.Text;
            if (detailBLL.updateDetailInfo(entity))
            {
                RadAjaxManager1.Alert("更新成功");
                setInputEnable(false);
                getRepairInfoByID(entity.detailID);
            }
            else RadAjaxManager1.Alert("更新失败");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            setInputEnable(false);
        }
    }
}