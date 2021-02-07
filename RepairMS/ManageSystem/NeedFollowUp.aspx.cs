using DataAccess.BLL;
using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;

namespace RepairMS.ManageSystem
{
    public partial class NeedFollowUp : System.Web.UI.Page
    {
        projectBLL projBLL = new projectBLL();
        projectDetailBLL detailBLL = new projectDetailBLL();
        repairmanBLL rmBLL = new repairmanBLL();
        paramBLL paramBLL = new paramBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            // TODO add rowIndex
            if (!IsPostBack)
            {
                cmb_BindData();
                getProjectData();
                getDetailData(0);
            }
        }

        private void getProjectData()
        {
            DataTable dt = projBLL.getMyNeedFollowUpProject();
            if (dt.Rows.Count > 0)
            {
                ViewState["GridProjData"] = dt;
                GridProject.DataSource = dt;
                GridProject.DataBind();
            }
        }

        private void getDetailData(int projID)
        {
            ViewState["SelectedProjID"] = projID;
            DataTable dt = detailBLL.getDetailDataTableByProjID(projID);
            ViewState["GridDetailData"] = dt;
            GridDetail.DataSource = dt;
            GridDetail.DataBind();
        }

        protected void GridProject_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            DataTable dt = ViewState["GridProjData"] as DataTable;
            (sender as RadGrid).DataSource = dt;
        }

        protected void GridDetail_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            DataTable dt = ViewState["GridDetailData"] as DataTable;
            (sender as RadGrid).DataSource = dt;
        }

        protected void GridProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (GridProject.SelectedItems.Count > 0)
            {
                GridDataItem gridItem = GridProject.SelectedItems[0] as GridDataItem;
                int projId = Convert.ToInt32(gridItem.GetDataKeyValue("projectID").ToString());

                if (projId > 0) getDetailData(projId);
            }
        }

        protected void GridDetail_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            GridDataItem item = e.Item as GridDataItem;
            int detailId = Convert.ToInt32(item.GetDataKeyValue("detailID"));
            if (detailBLL.deleteDetail(detailId))
            {
                int rowIndex = item.ItemIndex;
                DataTable dt = ViewState["GridDetailData"] as DataTable;
                dt.Rows.RemoveAt(rowIndex);
                ViewState["GridDetailData"] = dt;
            }
            GridDetail.Rebind();
        }

        protected void GridDetail_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == RadGrid.InitInsertCommandName) //"Add new" button clicked
            {
                e.Canceled = true;
                if (GridProject.SelectedItems.Count == 0) { RadAjaxManager1.Alert("请先选择报修项目。"); return; }
                e.Item.OwnerTableView.InsertItem();
                GridEditableItem insertedItem = e.Item.OwnerTableView.GetInsertItem();
                RadComboBox cmb = insertedItem.FindControl("cmbRMList") as RadComboBox;
                if (cmb != null)
                {
                    DataTable dt = rmBLL.getAllRepairMen();
                    Global.BindComboBoxList(cmb, dt, "repairmanID", "repairmanName", 0);
                }
            }
            else if (e.CommandName == RadGrid.PerformInsertCommandName)
            {
                GridEditableItem editedItem = e.Item as GridEditableItem;
                RadComboBox cmb = editedItem.FindControl("cmbRMList") as RadComboBox;
                if (cmb == null || cmb.SelectedIndex == 0) { RadAjaxManager1.Alert("请选择维修人员。"); e.Canceled = true; return; }
                int rmID = Convert.ToInt32(cmb.SelectedItem.Value);
                int projID = Convert.ToInt32(ViewState["SelectedProjID"]);
                int detailID = detailBLL.assignRepairMan(projID, rmID);
                if (detailID > 0)
                {
                    DataTable dt = ViewState["GridDetailData"] as DataTable;
                    DataRow newRow = dt.NewRow();
                    newRow["detailID"] = detailID;
                    newRow["projectID"] = projID;
                    newRow["repairmanID"] = rmID;
                    dt.Rows.Add(newRow);
                    dt.AcceptChanges();
                    ViewState["GridDetailData"] = dt;

                }
                else e.Canceled = true;
            }
        }

        private void cmb_BindData()
        {
            Global.ComboBox_BindLevelData(cmbPriority);
            Dictionary<int, RadComboBox> cmbList_param = new Dictionary<int, RadComboBox>() {
                {Global.ProjectType,cmbType }, {Global.ProjectSite,cmbSite }
            };
            foreach (int paramType in cmbList_param.Keys)
            {
                Global.ComboBox_BindParamData(cmbList_param[paramType], paramType);
            }
        }

        protected void GridProject_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                string[] flagArr = { "priority", "projectType", "projectSite" };
                foreach (string flag in flagArr)
                {
                    item[flag].Text = Global.CmbItem_parseToText(item[flag].Text, flag);
                }
            }
        }

        protected void GridDetail_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                int rmID = Convert.ToInt32(item["repairmanID"].Text);
                item["repairmanID"].Text = rmBLL.getRMinfoById(rmID).repairmanName;
                string[] flagArr = { "severity", "faultType", "faultStatus" };
                foreach (string flag in flagArr)
                {
                    item[flag].Text = Global.CmbItem_parseToText(item[flag].Text, flag);
                }
            }

        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            projectTable entity = new projectTable();
            if (cmbStatus.SelectedIndex > 0) entity.projectStatus = Convert.ToInt32(cmbStatus.SelectedValue);
            if (cmbType.SelectedIndex > 0) entity.projectType = Convert.ToInt32(cmbType.SelectedValue);
            if (cmbSite.SelectedIndex > 0) entity.projectSite = Convert.ToInt32(cmbSite.SelectedValue);
            if (cmbPriority.SelectedIndex > 0) entity.priority = Convert.ToInt32(cmbPriority.SelectedValue);
            string startDate = "", endDate = "";
            if (dateStart.SelectedDate.HasValue) startDate = dateStart.SelectedDate.Value.ToShortDateString();
            if (dateEnd.SelectedDate.HasValue) endDate = dateEnd.SelectedDate.Value.ToShortDateString();
            DataTable dt = projBLL.getDataTableByEntity(entity, startDate, endDate);

            ViewState["GridProjData"] = dt;
            GridProject.DataSource = dt;
            GridProject.DataBind();

            //Global.InputReset(div_search);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Global.InputReset(div_search);
        }

        protected void cmbProjStatus_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cmb = sender as RadComboBox;
            GridDataItem gridItem = (cmb.NamingContainer as GridDataItem);
            int projId = Convert.ToInt32(gridItem.GetDataKeyValue("projectID").ToString());
            int status = Convert.ToInt32(cmb.SelectedValue);
            if (projBLL.updateRepairStatus(projId, status)) getProjectData();
        }
    }
}