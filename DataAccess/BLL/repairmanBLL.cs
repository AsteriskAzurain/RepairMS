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
    public class repairmanBLL
    {
        public repairmanTableDAL dal=new repairmanTableDAO();
        public repairmanTable UserLogin(string userName, string password)
        {
            if (userName != "" && password != "")
            {
                repairmanTable loginUser = new repairmanTable();
                loginUser.repairmanID = -1;
                loginUser.repairmanName = userName;
                loginUser.password = password;
                loginUser = dal.checkLoginInfo(loginUser);
                if (loginUser != null && loginUser.repairmanID > -1) return loginUser;
            }
            return new repairmanTable();
        }

        public DataTable getAllRepairMen()
        {
            return dal.GetEntityDatatable();
        }

        public bool deleteRepairMan(int rmID)
        {
            return dal.DeleteEntity(rmID);
        }

        public repairmanTable getRMinfoById(int rmID)
        {
            return dal.GetEntityById(rmID);
        }

        public bool addNewRepairMan(repairmanTable entity)
        {
            entity.repairmanID = entity.repairmanID > 0 ? entity.repairmanID : -1;
            return dal.SaveEntity(entity) > 0;
        }

        public bool updateRMinfo(repairmanTable entity)
        {
            return entity.repairmanID > 0 && dal.SaveEntity(entity) > 0;
            //if (entity.repairmanID > 0) return dal.SaveEntity(entity) > 0;
            //else return false;
        }


    }
}
