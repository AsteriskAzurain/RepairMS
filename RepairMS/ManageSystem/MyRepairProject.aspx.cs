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
    public partial class MyRepairProject : System.Web.UI.Page
    {
        projectBLL projBLL = new projectBLL();
        projectDetailBLL detailBLL = new projectDetailBLL();
        repairmanBLL rmBLL = new repairmanBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CurrentRole"] == null || Session["CurrentRole"].ToString().Equals("1")) return;

            repairmanTable currentUser = new repairmanTable();
            if (Session["CurrentLoginUser"] == null) return;
            else
            {
                currentUser = Session["CurrentLoginUser"] as repairmanTable;
                hiddenRMID.Value = currentUser.repairmanID.ToString();
                if (ViewState["isQuery"] == null || ViewState["isQuery"].ToString() == "false")
                    getMyProjectData(currentUser.repairmanID);
            }
            if (!IsPostBack)
            {
                ViewState["isQuery"] = "false";
                cmb_BindData();
            }
        }

        private void getMyProjectData(int rmID)
        {
            List<projectDetailTable> detailList = detailBLL.getMyRepairProjectIDList(rmID).ToList();
            showDetailList(detailList);
        }

        private void showDetailList(List<projectDetailTable> detailList)
        {
            div_cards.Controls.Clear();
            foreach (projectDetailTable detail in detailList)
            {
                int detailID = detail.detailID;
                int projectID = detail.projectID.Value;
                DateTime createDate = detail.createDate.Value;
                createCard(detailID, createDate, projBLL.getProjectInfoByID(projectID));
            }
        }

        private void createCard(int detailID, DateTime createDate, projectTable entity)
        {
            RadCard card = new RadCard();
            // CardHeaderComponent
            //      CardTitleComponent: ProjectType
            //      CardSubtitleComponent: priority
            //      CardSubtitleComponent: CreateDate
            CardHeaderComponent head = new CardHeaderComponent();
            CardTitleComponent title = new CardTitleComponent();
            title.Content = Global.CmbItem_parseToText(entity.projectType, "projectType");
            head.Controls.Add(title);
            CardSubtitleComponent subtitle1 = new CardSubtitleComponent();
            subtitle1.Content = "优先级: " + Global.CmbItem_parseToText(entity.priority, "priority");
            subtitle1.CssClass = "float-right";
            head.Controls.Add(subtitle1);
            CardSubtitleComponent subtitle2 = new CardSubtitleComponent();
            subtitle2.Content = createDate > DateTime.MinValue ? "分配日期: " + createDate.ToShortDateString() : "报修时间: " + entity.createDate.Value.ToShortDateString();
            head.Controls.Add(subtitle2);
            card.Controls.Add(head);
            // CardBodyComponent
            //      p: 项目号
            //      p: 联系人姓名、手机号
            //      p: 报修地点、具体位置
            //      p: 详细描述
            CardBodyComponent body = new CardBodyComponent();
            HtmlGenericControl p1 = new HtmlGenericControl();
            p1.TagName = "p";
            p1.Attributes.Add("class", "threecols");
            p1.InnerHtml = string.Format("<span>项目号:</span><span class='span-col-2'>{0}</span>", entity.projectID);
            //p1.InnerText = "项目号: " + entity.projectID.ToString();
            body.Controls.Add(p1);
            HtmlGenericControl p2 = new HtmlGenericControl();
            p2.TagName = "p";
            p2.Attributes.Add("class", "threecols");
            p2.InnerHtml = string.Format("<span>联系人:</span><span>{0}</span><span>{1}</span>", entity.contactName, entity.contactPhone);
            body.Controls.Add(p2);
            HtmlGenericControl p3 = new HtmlGenericControl();
            p3.TagName = "p";
            p3.Attributes.Add("class", "threecols");
            p3.InnerHtml = string.Format("<span>报修地点:</span><span>{0}</span><span>{1}</span>", Global.CmbItem_parseToText(entity.projectSite, "projectSite"), entity.siteDetail);
            body.Controls.Add(p3);
            HtmlGenericControl p4 = new HtmlGenericControl();
            p4.TagName = "p";
            p4.Attributes.Add("class", "threecols");
            p4.InnerHtml = string.Format("<span>详细描述:</span><span class='span-col-2'>{0}</span>", entity.projectDetail);
            //p4.InnerText = "详细描述: " + entity.projectDetail;
            body.Controls.Add(p4);
            card.Controls.Add(body);
            // CardActionsContainerComponent
            //      CardActionComponent
            //              RadComboBox: cmbProjectStatus
            //      CardActionComponent
            //              RadButton: btnViewProj
            //      CardActionComponent
            //              RadButton: btnFillDetail
            CardActionsContainerComponent btnContainer = new CardActionsContainerComponent();
            btnContainer.CardActionsAlignment = CardActionsAlignmentType.Stretched;
            btnContainer.Orientation = CardComponentOrientation.Vertical;
            CardActionComponent action1 = new CardActionComponent();
            RadComboBox cmb = new RadComboBox();
            //cmb.ID = "cmbProjectStatus";
            cmb.Attributes.Add("projectID", entity.projectID.ToString());
            Global.ComboBox_BindParamData(cmb, Global.ProjectStatus);
            cmb.Items[0].Enabled = false; cmb.Items[1].Enabled = false;
            cmb.SelectedValue = entity.projectStatus.ToString();
            cmb.AutoPostBack = true;
            cmb.SelectedIndexChanged += new RadComboBoxSelectedIndexChangedEventHandler(cmbProjectStatus_SelectedIndexChanged);
            cmb.EnableEmbeddedSkins = false;
            cmb.CssClass = "k-button k-flat k-primary";
            cmb.Font.Size = FontUnit.Parse("14px");
            action1.Controls.Add(cmb);
            btnContainer.Controls.Add(action1);
            CardActionComponent action2 = new CardActionComponent();
            RadLinkButton btn1 = new RadLinkButton();
            //btn1.ID = "btnViewProj";
            btn1.Text = "项目详情";
            btn1.NavigateUrl = Global.projectURL + "?projID=" + entity.projectID.ToString();
            btn1.Target = "_blank";
            btn1.EnableEmbeddedSkins = false;
            btn1.CssClass = "k-button k-flat k-primary";
            btn1.Font.Size = FontUnit.Parse("14px");
            action2.Controls.Add(btn1);
            btnContainer.Controls.Add(action2);
            CardActionComponent action3 = new CardActionComponent();
            RadLinkButton btn2 = new RadLinkButton();
            //btn2.ID = "btnFillDetail";
            btn2.Text = "填写维修记录";
            btn2.NavigateUrl = Global.detailURL + "?detailID=" + detailID.ToString();
            btn2.Target = "_blank";
            btn2.EnableEmbeddedSkins = false;
            btn2.CssClass = "k-button k-flat k-primary";
            btn2.Font.Size = FontUnit.Parse("14px");
            action3.Controls.Add(btn2);
            btnContainer.Controls.Add(action3);
            card.Controls.Add(btnContainer);
            div_cards.Controls.Add(card);
        }

        protected void cmbProjectStatus_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox thiscmb = sender as RadComboBox;
            int projectID = Convert.ToInt32(thiscmb.Attributes["projectID"]);
            int projectStatus = Convert.ToInt32(thiscmb.SelectedValue);
            string projStatusStr = Global.CmbItem_parseToText(projectStatus, "projectStatus");
            if (projBLL.updateRepairStatus(projectID, projectStatus)) RadAjaxManager1.Alert(string.Format("此项目（项目号: {0}）已更新至【{1}】状态。", projectID, projStatusStr));
            else RadAjaxManager1.Alert("状态更新失败。");
        }

        private void cmb_BindData()
        {
            Dictionary<int, RadComboBox> cmbList_param = new Dictionary<int, RadComboBox>() {
                { Global.ProjectStatus,cmbProjectStatus},  {Global.ProjectType,cmbProjectType }, {Global.ProjectSite,cmbProjectSite }
            };
            foreach (int paramType in cmbList_param.Keys)
            {
                Global.ComboBox_BindParamData(cmbList_param[paramType], paramType);
            }
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            projectTable proj = new projectTable();
            int rmID = (string.IsNullOrEmpty(hiddenRMID.Value)) ? 0 : Convert.ToInt32(hiddenRMID.Value);
            if (tbProjectID.Text != "") proj.projectID = Convert.ToInt32(tbProjectID.Text);
            if (cmbProjectStatus.SelectedIndex > 0) proj.projectStatus = Convert.ToInt32(cmbProjectStatus.SelectedValue);
            if (cmbProjectType.SelectedIndex > 0) proj.projectType = Convert.ToInt32(cmbProjectType.SelectedValue);
            if (cmbProjectSite.SelectedIndex > 0) proj.projectSite = Convert.ToInt32(cmbProjectSite.SelectedValue);
            if (DateDetailCreate.SelectedDate.HasValue) proj.updateDate = DateDetailCreate.SelectedDate.Value;
            List<projectDetailTable> detailList = detailBLL.getMyRepairProjectIDList(rmID, proj).ToList();
            ViewState["isQuery"] = "true";
            showDetailList(detailList);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ViewState["isQuery"] = "false";
            Global.InputReset(div_search);
        }
    }
}