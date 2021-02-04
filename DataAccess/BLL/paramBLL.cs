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
    public class paramBLL
    {
        public paramTableDAL dal = new paramTableDAO();

        public string getProjectStatusByValue(int value, int returnType = 0)
        {
            DataTable dt = dal.GetDataTabelByTypeId(1);
            if (dt.Rows.Count == 0) return "";
            string returnTypeStr = returnType == 0 ? "paramText" : "paramCode";
            List<string> rstList = dt.AsEnumerable().Where(row => row["paramValue"].Equals(value.ToString())).Select(row => row[returnTypeStr].ToString()).ToList<string>();
            return rstList.Count > 0 ? rstList[0].ToString() : "";
        }

        public string getTextByTypeAndValue(string value, int typeID)
        {
            DataTable dt = dal.GetDataTabelByTypeId(typeID);
            if (dt.Rows.Count == 0) return "";
            List<string> rstList = dt.AsEnumerable().Where(row => row["paramValue"].Equals(value)).Select(row => row["paramText"].ToString()).ToList<string>();
            return rstList.Count > 0 ? rstList[0].ToString() : "";
        }
    }
}
