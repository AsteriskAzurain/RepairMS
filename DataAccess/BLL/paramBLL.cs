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
    public class paramBLL
    {
        //public paramTableDAL dal = new paramTableDAO();
        public paramTableDAL dal = new paramRepository();

        public string getProjectStatusByValue(int value, int returnType = 0)
        {
            DataTable dt = dal.GetDataTableByTypeId(1);
            if (dt.Rows.Count == 0) return "";
            string returnTypeStr = returnType == 0 ? "paramText" : "paramCode";
            List<string> rstList = dt.AsEnumerable().Where(row => row["paramValue"].Equals(value.ToString())).Select(row => row[returnTypeStr].ToString()).ToList<string>();
            return rstList.Count > 0 ? rstList[0].ToString() : "";
        }

        public string getTextByTypeAndValue(string value, int typeID)
        {
            DataTable dt = dal.GetDataTableByTypeId(typeID);
            if (dt.Rows.Count == 0) return "";
            List<string> rstList = dt.AsEnumerable().Where(row => row["paramValue"].Equals(value)).Select(row => row["paramText"].ToString()).ToList<string>();
            return rstList.Count > 0 ? rstList[0].ToString() : "";
        }

        public DataTable getParamListByType(int typeID)
        {
            return dal.GetParamListByType(typeID);
        }
    }
}
