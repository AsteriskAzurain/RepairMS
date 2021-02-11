using DataAccess.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;

namespace RepairMS
{
    public static class Global
    {
        private static readonly Dictionary<string, int> paramTypeDict = new Dictionary<string, int>() {
                {"projectStatus",1 }, {"projectType",2 }, {"projectSite",3 }, {"faultType", 4 }, {"faultStatus", 1}
            };
        public static Dictionary<string, int> ParamTypeDict
        {
            get
            {
                return paramTypeDict;
            }
        }

        //public static readonly string projectURL = "./ProjectDetailPage.aspx";
        //public static readonly string detailURL = "./RepairDetailPage.aspx";

        private static readonly int projectStatus;
        private static readonly int projectType;
        private static readonly int projectSite;
        private static readonly int faultType;
        private static readonly int faultStatus;

        public static int ProjectStatus
        {
            get
            {
                return paramTypeDict["projectStatus"];
            }
        }
        public static int ProjectType
        {
            get
            {
                return paramTypeDict["projectType"];
            }
        }
        public static int ProjectSite
        {
            get
            {
                return paramTypeDict["projectSite"];

            }
        }
        public static int FaultType
        {
            get
            {
                return paramTypeDict["faultType"];
            }
        }
        public static int FaultStatus
        {
            get
            {
                return paramTypeDict["faultStatus"];
            }
        }

        public static void ComboBox_BindParamData(RadComboBox cmb, string type)
        {
            DataTable dt = new DataTable();
            paramBLL pBLL = new paramBLL();
            if (paramTypeDict.ContainsKey(type)) dt = pBLL.getParamListByType(paramTypeDict[type]);
            BindComboBoxList(cmb, dt, "paramValue", "paramText", 2);
        }
        public static void ComboBox_BindParamData(RadComboBox cmb, int typeID)
        {
            DataTable dt = new DataTable();
            paramBLL pBLL = new paramBLL();
            if (paramTypeDict.ContainsValue(typeID)) dt = pBLL.getParamListByType(typeID);
            BindComboBoxList(cmb, dt, "paramValue", "paramText", 2);
        }

        public static void ComboBox_BindLevelData(RadComboBox cmb)
        {
            string[] levelText = { "请选择", "低", "中", "高" };
            for (int i = 0; i < levelText.Length; i++)
            {
                RadComboBoxItem item = new RadComboBoxItem();
                item.Value = i.ToString();
                item.Text = levelText[i];
                cmb.Items.Add(item);
                item.DataBind();
            }
        }

        /// <summary>
        /// bind combobox's datasource
        /// </summary>
        /// <param name="addedItemFlag">1, add'SelectAll', 2 add'SelectNone'; </param>
        public static void BindComboBoxList(RadComboBox cb, object dataSource, string valueField, string textField, int addedItemFlag)
        {
            cb.DataValueField = valueField;
            cb.DataTextField = textField;
            cb.DataSource = dataSource;
            cb.DataBind();
            if ((addedItemFlag & 1) == 1) cb.Items.Insert(0, new RadComboBoxItem("--ALL--", "-1"));
            if ((addedItemFlag & 2) == 2) cb.Items.Insert(0, new RadComboBoxItem("请选择", "-1"));
            return;
        }

        public static string CmbItem_parseToText(object code, string flag)
        {
            paramBLL pBLL = new paramBLL();
            if (paramTypeDict.ContainsKey(flag)) return pBLL.getTextByTypeAndValue(code.ToString(), paramTypeDict[flag]);
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

        public static void InputReset(HtmlGenericControl container, params Control[] exceptControls)
        {
            foreach (Control ctrl in container.Controls)
            {
                if (exceptControls.Contains(ctrl)) continue;
                switch (ctrl.GetType().Name)
                {
                    case "RadComboBox":
                        (ctrl as RadComboBox).SelectedIndex = 0;
                        break;
                    case "RadTextBox":
                        (ctrl as RadTextBox).Text = "";
                        break;
                    case "RadDatePicker":
                        (ctrl as RadDatePicker).Clear();
                        break;
                    default:
                        System.Diagnostics.Debug.WriteLine(ctrl.GetType().Name);
                        System.Diagnostics.Debug.WriteLine("ID: " + ctrl.ID + "; clientID: " + ctrl.ClientID);
                        break;
                }
            }
        }
    }
}