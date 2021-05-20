         using DataAccess.Entity;
using DataAccess.IDAL;
using DataAccess.SQLServerDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess.MongoDAL;

namespace DataAccess.BLL
{
    public class repairmanBLL
    {
        //public repairmanTableDAL dal = new repairmanTableDAO();
        public repairmanTableDAL dal = new repairmanRepository();

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

        public DataTable getAllRepairMen(bool isIncludeDeteled = false)
        {
            return isIncludeDeteled ? dal.GetEntityDatatableAll() : dal.GetEntityDatatable();
        }

        public bool deleteRepairMan(int rmID)
        {
            return dal.DeleteEntity(rmID);
        }

        public repairmanTable getRMinfoById(int rmID)
        {
            return dal.GetEntityById(rmID);
        }

        public bool addNewRepairMan(string name)
        {
            repairmanTable entity = new repairmanTable();
            entity.repairmanID = -1;
            entity.repairmanName = name;
            entity.password = "111111";
            return dal.SaveEntity(entity) > 0;
        }

        public bool updateRMinfo(repairmanTable entity)
        {
            return entity.repairmanID > 0 && dal.SaveEntity(entity) > 0;
            //if (entity.repairmanID > 0) return dal.SaveEntity(entity) > 0;
            //else return false;
        }

        public bool switchDeleteStatus(int rmId, int currentStatus)
        {
            return dal.switchDeleteStatus(rmId, currentStatus == 0 ? 1 : 0);
        }

        public DataTable getRMListByName(string name)
        {
            return dal.getRMListByName(name);
        }

        public bool isRMNameExist(string name, bool isAll = false)
        {
            return dal.isNameExist(name, isAll);
        }
    }
}
