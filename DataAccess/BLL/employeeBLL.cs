using DataAccess.Entity;
using DataAccess.IDAL;
using DataAccess.MongoDAL;
using DataAccess.SQLServerDAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.BLL
{
    public class employeeBLL
    {
        //public employeeTableDAL dal = new employeeTableDAO();
        public employeeTableDAL dal = new employeeRepository();
        public employeeTable UserLogin(string userName, string password)
        {
            if (userName != "" && password != "")
            {
                employeeTable loginUser = new employeeTable();
                loginUser.employeeID = -1;
                loginUser.employeeName = userName;
                loginUser.password = password;
                loginUser = dal.checkLoginInfo(loginUser);
                if (loginUser != null && loginUser.employeeID > -1) return loginUser;
            }
            return new employeeTable();
        }

        public int testInsert(employeeTable e)
        {
            return dal.SaveEntity(e);
        }

        public DataTable testGetAll()
        {
            DataTable dt = dal.GetEntityDatatable();
            return dt;
        }

        public employeeTable testGetOne(int id)
        {
            return dal.GetEntityById(id);
        }

        public bool testDeleteOne(int id)
        {
            return dal.DeleteEntity(id);
        }

        public bool testUpdateOne(employeeTable entity)
        {
            if (entity.employeeID > 0) return dal.SaveEntity(entity) > 0;
            else return false;
        }
    }
}
