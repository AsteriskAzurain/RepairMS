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
    public partial class NeedFollowUp : System.Web.UI.Page
    {
        public int projectStatus = 2;
        projectBLL projBLL = new projectBLL();
        projectDetailBLL detailBLL = new projectDetailBLL();
        repairmanBLL rmBLL = new repairmanBLL();
        paramBLL paramBLL = new paramBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            // TODO add rowIndex
            if (!IsPostBack)
            {
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
                if (cmb != null) cmbRMList_GetData(cmb);
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

        private void cmbRMList_GetData(RadComboBox cmbRMList)
        {
            DataTable dt = new DataTable();
            dt = rmBLL.getAllRepairMen();
            RadComboBoxItem emptyItem = new RadComboBoxItem();
            emptyItem.Value = "";
            emptyItem.Text = "Select a RepairMan";
            cmbRMList.Items.Add(emptyItem);
            emptyItem.DataBind();
            foreach (DataRow row in dt.Rows)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Value = row["repairmanID"].ToString();
                item.Text = row["repairmanName"].ToString();
                cmbRMList.Items.Add(item);
                item.DataBind();
            }
        }

        public string parseToText(object code, string flag)
        {
            Dictionary<string, int> paramTypeDict = new Dictionary<string, int>() {
                {"projectStatus",1 }, {"projectType",2 }, {"projectSite",3 }, {"faultType", 4 }, {"faultStatus", 1}
            };
            if (paramTypeDict.ContainsKey(flag)) return paramBLL.getTextByTypeAndValue(code.ToString(), paramTypeDict[flag]);
            else
            {
                if (flag == "priority" || flag == "severity")
                {
                    if (code.ToString() == "1") return "低";
                    if (code.ToString() == "2") return "中";
                    if (code.ToString() == "3") return "高";
                }
            }
            return "";
        }

        protected void GridProject_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                string[] flagArr = { "priority", "projectType", "projectSite" };
                foreach (string flag in flagArr)
                {
                    item[flag].Text = parseToText(item[flag].Text, flag);
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
                    item[flag].Text = parseToText(item[flag].Text, flag);
                }
            }

        }

    }
}