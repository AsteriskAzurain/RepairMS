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
    public class employeeBLL
    {
        public employeeTableDAL dal = new employeeTableDAO();
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

    }
}
