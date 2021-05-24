using DataAccess.BLL;
using DataAccess.Entity;
using MongoDB.Bson;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
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
        public employeeBLL eeBLL = new employeeBLL();
        public repairmanBLL rmBLL = new repairmanBLL();
        private bool isEditable = false;
        private bool isInterrupted = false;

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
                if (entity.photos != null) { ViewState["PhotoList"] = entity.photos; GridPhoto.Rebind(); }
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
            isEditable = isEnable;
            RadWebControl[] UnEditableControls = { tbDetailID, tbProjectID, dateCreate, tbRepairmanID };
            foreach (RadWebControl ctrl in UnEditableControls) ctrl.Enabled = false;
            RadWebControl[] InputControls = { tbFaultDetail, tbAddRequirement, RadAsyncUpload1 };
            RadComboBox[] InputCombobox = { cmbFaultStatus, cmbFaultType, cmbSeverity };
            foreach (RadWebControl ctrl in InputControls) ctrl.Enabled = isEnable;
            foreach (RadComboBox cmb in InputCombobox) cmb.Enabled = isEnable;

            btnEdit.Enabled = !isEnable;
            viewProject.Enabled = !isEnable;
            div_editBtns.Visible = isEnable;

            GridPhoto.Rebind();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            setInputEnable(true);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (isInterrupted) return;

            projectDetailTable entity = detailBLL.getDetailInfoByID(Convert.ToInt32(tbDetailID.Text));
            if (cmbFaultStatus.SelectedIndex > 0) entity.faultStatus = Convert.ToInt32(cmbFaultStatus.SelectedValue);
            if (cmbFaultType.SelectedIndex > 0) entity.faultType = Convert.ToInt32(cmbFaultType.SelectedValue);
            if (cmbSeverity.SelectedIndex > 0) entity.severity = Convert.ToInt32(cmbSeverity.SelectedValue);
            if (tbFaultDetail.Text != "") entity.faultDetail = tbFaultDetail.Text;
            if (tbAddRequirement.Text != "") entity.add_requirement = tbAddRequirement.Text;
            List<repairPhoto> newList = new List<repairPhoto>();
            List<string> fnList_old = entity.photos.Select(photo => photo.picName).ToList();
            foreach (UploadedFile uploadPic in RadAsyncUpload1.UploadedFiles)
            {
                repairPhoto pic = new repairPhoto();
                pic.detailID = entity.detailID;
                if (Session["CurrentRole"] != null && Session["CurrentLoginUser"] != null)
                {
                    pic.roleID = Convert.ToInt32(Session["CurrentRole"]);
                    if (pic.roleID == 1) pic.userID = (Session["CurrentLoginUser"] as employeeTable).employeeID;
                    else if (pic.roleID == 0) pic.userID = (Session["CurrentLoginUser"] as repairmanTable).repairmanID;
                }
                pic.picName = uploadPic.FileName;
                byte[] fileData = new byte[uploadPic.InputStream.Length];
                uploadPic.InputStream.Read(fileData, 0, (int)uploadPic.InputStream.Length);
                pic.picData = fileData;
                pic.deleteStatus = 1;
                if (!fnList_old.Contains(pic.picName)) newList.Add(pic);
            }
            entity.photos = newList;
            //if (entity.photos == null) entity.photos = newList;
            //else
            //{
            //    foreach (var existPhoto in entity.photos)
            //    {
            //        if (newList.Contains(existPhoto)) continue;
            //        else existPhoto.deleteStatus = 0;
            //    }
            //    //newList = newList.Except(entity.photos).ToList(); //取差集
            //    entity.photos = newList.Union(entity.photos).ToList(); //剔除重复项
            //}

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

        protected void RadAsyncUpload1_FileUploaded(object sender, FileUploadedEventArgs e)
        {
            List<repairPhoto> photoList = new List<repairPhoto>();
            if (ViewState["PhotoList"] != null) photoList = ViewState["PhotoList"] as List<repairPhoto>;
            List<string> nameList1 = photoList.Select(p => p.picName).ToList();
            List<string> nameList2 = new List<string>();
            foreach (UploadedFile uploadPic in RadAsyncUpload1.UploadedFiles)
            {
                if (nameList1.Contains(uploadPic.FileName) || nameList2.Contains(uploadPic.FileName))
                {
                    RadAjaxManager1.Alert("Existing photo, please remove the original photos first.");
                    isInterrupted = true;
                    return;
                }
                nameList2.Add(uploadPic.FileName);
            }
        }

        protected void GridPhoto_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (ViewState["PhotoList"] != null)
            {
                (sender as RadGrid).DataSource = ViewState["PhotoList"] as List<repairPhoto>;
            }
        }

        protected void GridPhoto_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "ViewPhoto")
            {
                GridDataItem dataitem = e.Item as GridDataItem;
                string picId = dataitem["picID"].Text;
                string picName = dataitem["picName"].Text;
                string fileExt = picName.Substring(picName.LastIndexOf(".") + 1);
                fileExt = new string[] { "jpeg", "jpg", "png" }.Contains(fileExt) ? fileExt : "jpg";
                byte[] picData = detailBLL.getPhotoDataByPicID(picId);
                if (picData.Length > 0)
                {
                    RadBinaryImage1.DataValue = picData;
                }
            }
            else if (e.CommandName == "DownloadPhoto")
            {
                GridDataItem dataitem = e.Item as GridDataItem;
                string picId = dataitem["picID"].Text;
                string picName = dataitem["picName"].Text;
                string fileExt = picName.Substring(picName.LastIndexOf(".") + 1);
                fileExt = new string[] { "jpeg", "jpg", "png" }.Contains(fileExt) ? fileExt : "jpg";
                byte[] picData = detailBLL.getPhotoDataByPicID(picId);
                if (picData.Length > 0)
                {
                    Response.Clear();
                    Response.ContentType = "image/" + fileExt;
                    Response.AddHeader("content-disposition", "attachment; filename=" + picName);
                    Response.BinaryWrite(picData);
                }
            }
            else if (e.CommandName == "DeletePhoto")
            {
                GridDataItem dataitem = e.Item as GridDataItem;
                int detailId = Convert.ToInt32(dataitem["detailID"].Text);
                string picId = dataitem["picID"].Text;
                RadAjaxManager1.Alert("删除" + (detailBLL.updatePhotoDelStatus(picId) ? "成功" : "失败"));
                getRepairInfoByID(detailId);
            }
        }

        protected void GridPhoto_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                Button btn = item["Delete"].Controls[0] as Button;
                btn.Enabled = isEditable;
                int roleId, userId;
                if (int.TryParse(item["roleID"].Text, out roleId) && int.TryParse(item["userID"].Text, out userId))
                {
                    if (roleId == 1)
                    {
                        item["roleID"].Text = "管理员";
                        employeeTable ee = eeBLL.getEEinfoById(userId);
                        item["userID"].Text = ee.employeeName;
                    }
                    else
                    {
                        item["roleID"].Text = "维修人员";
                        repairmanTable rm = rmBLL.getRMinfoById(userId);
                        item["userID"].Text = rm.repairmanName;
                    }
                }

            }
        }
    }
}