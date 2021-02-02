using DataAccess.IDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess.Entity;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.SQLServerDAL
{
    public class paramTableDAO : paramTableDAL
    {
        public bool DeleteEntity(int Id)
        {
            string strSql = "update paramTable set deleteStatus=0 where paramID= @paramID ";
            SqlParameter parameter = new SqlParameter("@paramID", Id);
            return SQLHelper.ExecuteonQuery(strSql, parameter) == 1;
        }

        public paramTable GetEntityById(int Id)
        {
            SqlParameter param = new SqlParameter("@paramID", Id);
            string strSQL = "select * from [paramTable] where paramID = @paramID ";
            System.Data.SqlClient.SqlDataReader dr;
            dr = SQLHelper.ExecuteReader(strSQL, param);
            try
            {
                if (dr.Read())
                {
                    paramTable entity = new paramTable();
                    entity = SQLHelper.ReaderToList<paramTable>(dr)[0];
                    return entity;
                }
                else return null;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.StackTrace);
                return null;
            }
            finally
            {
                if (!dr.IsClosed) dr.Close();
            }
        }

        public DataTable GetEntityDatatable()
        {
            string sql = "select * from [paramTable] where deleteStatus=1 ";
            DataTable dt = SQLHelper.ExecuteDataTable(sql, null);
            return dt;
        }

        public int SaveEntity(paramTable entity)
        {
            List<SqlParameter> paramList = new List<SqlParameter>();
            var paramID_parameter = new SqlParameter("@paramID", SqlDbType.Int);
            if (entity.paramID > 0) paramID_parameter.Value = entity.paramID;
            else paramID_parameter.Value = DBNull.Value;
            SqlParameter paramCode_parameter = new SqlParameter("@paramCode", entity.paramCode);
            paramList.Add(paramCode_parameter);
            SqlParameter paramText_parameter = new SqlParameter("@paramText", entity.paramText);
            paramList.Add(paramText_parameter);
            SqlParameter paramValue_parameter = new SqlParameter("@paramValue", entity.paramValue);
            paramList.Add(paramValue_parameter);
            var paramType_parameter = new SqlParameter("@paramType", entity.paramType);
            paramList.Add(paramType_parameter);
            SqlParameter remark_parameter = new SqlParameter("@remark", entity.remark);
            paramList.Add(remark_parameter);
            string sql = "";
            SqlParameter identityParameter = new SqlParameter("@IdentityId", SqlDbType.Int);
            if (entity.paramID == -1)
            {
                identityParameter.Direction = ParameterDirection.Output;
                paramList.Add(identityParameter);
                sql = "insert into paramTable(paramCode,paramText,paramValue,paramType,remark,deleteStatus) ";
                sql += "values(@paramCode,@paramText,@paramValue,@paramType,@remark,1) Select @IdentityId = @@identity  ";
            }
            else
            {
                paramList.Add(paramID_parameter);
                sql = "update paramTable set paramCode = @paramCode,paramText = @paramText,paramValue = @paramValue,paramType = @paramType,remark = @remark where paramID =@paramID ";
            }
            int count = SQLHelper.ExecuteonQuery(sql, paramList.ToArray());

            if (entity.paramID == -1 && identityParameter != null) entity.paramID = Convert.ToInt32(identityParameter.Value);

            return count;
        }
    }
}
