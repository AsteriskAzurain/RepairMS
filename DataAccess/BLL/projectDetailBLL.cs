using DataAccess.Entity;
using DataAccess.IDAL;
using DataAccess.SQLServerDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.BLL
{
    public class projectDetailBLL
    {
        public projectDetailTableDAL dal = new projectDetailTableDAO();

        public int assignRepairMan(int projID, int rmID)
        {
            projectDetailTable entity = new projectDetailTable();
            entity.detailID = -1;
            entity.projectID = projID;
            entity.repairmanID = rmID;
            entity.faultStatus = 2;
            entity.severity = 0;
            entity.faultType = 0;
            //entity.faultDetail = "";
            //entity.add_requirement = "";
            return dal.SaveEntity(entity);
        }

        public string getProjectRepairMan(int projID)
        {
            DataTable dt = getDetailDataTableByProjID(projID);
            if (dt.Rows.Count == 0) return "";
            else if (dt.Rows.Count == 1) return dt.Rows[0]["repairmanID"].ToString();
            else
            {
                List<string> rmList = dt.AsEnumerable().Select(row => row["repairmanID"].ToString()).ToList<string>();
                repairmanBLL rmBLL = new repairmanBLL();
                List<string> rmNameList = new List<string>();
                foreach (string rmID in rmList)
                {
                    repairmanTable rm = rmBLL.getRMinfoById(Convert.ToInt32(rmID));
                    if (rm != null) rmNameList.Add(rm.repairmanName);
                }
                return string.Join(",", rmNameList);
            }
        }

        public bool updateDetailInfo(projectDetailTable entity)
        {
            if (entity.detailID > 0) return dal.SaveEntity(entity) > 0;
            else return false;
        }

        public DataTable getDetailDataTableByProjID(int projID)
        {
            return dal.GetAllDetailByProjID(projID);
        }

        public DataTable getAllDetail()
        {
            return dal.GetEntityDatatable();
        }

        public projectDetailTable getDetailInfoByID(int id)
        {
            return dal.GetEntityById(id);
        }

        public bool setDetailStatus(int id, int status)
        {
            return dal.SetEntityStatus(id, status) > 0;
        }

        public bool deleteDetail(int id)
        {
            return dal.DeleteEntity(id);
        }

    }
}
