using DataAccess.Entity;
using DataAccess.IDAL;
using DataAccess.SQLServerDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.BLL
{
    public class projectBLL
    {
        public projectTableDAL dal = new projectTableDAO();

        public bool addNewRepairProject(projectTable entity)
        {
            entity.projectID = entity.projectID > 0 ? entity.projectID : -1;
            return dal.SaveEntity(entity) > 0;
        }

        public int updateRepairStatus(int id, int status)
        {
            return 0;
        }
    }
}
