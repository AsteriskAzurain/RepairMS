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
    public class projectBLL
    {
        public projectTableDAL dal = new projectTableDAO();

        public int addNewRepairProject(projectTable entity)
        {
            entity.projectID = entity.projectID > 0 ? entity.projectID : -1;
            return dal.SaveEntity(entity);
        }

        public bool updateRepairStatus(int id, int status)
        {
            return dal.SetEntityStatus(id, status) > 0;
        }

        public DataTable getMyNeedAssignProject()
        {
            return dal.GetDataTableByStatus(0);
        }

        public DataTable getHasAssignedProject()
        {
            return dal.GetDataTableByStatus(1);
        }

        public DataTable getMyNeedFollowUpProject()
        {
            return dal.GetDataTableByStatus(2);
        }

        public DataTable getFinishedProject()
        {
            return dal.GetDataTableByStatus(3);
        }

        public bool updateProjectInfo(projectTable entity)
        {
            if (entity.projectID > 0) return dal.SaveEntity(entity) > 0;
            else return false;
        }

        public projectTable getProjectInfoByID(int id)
        {
            return dal.GetEntityById(id);
        }

        public DataTable getAllProject()
        {
            return dal.GetEntityDatatable();
        }

        public DataTable getDataTableByEntity(projectTable entity, string startDate = "", string endDate = "")
        {
            if (entity.projectID > 0 && (entity = getProjectInfoByID(entity.projectID)) != null)
                return SQLHelper.ToDataTable(new projectTable[] { entity });
            return dal.GetDataTableByEntity(entity, startDate, endDate);
        }
    }
}
