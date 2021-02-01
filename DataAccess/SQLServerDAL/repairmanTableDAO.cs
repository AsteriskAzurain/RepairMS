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
    public class repairmanTableDAO : repairmanTableDAL
    {
        public void DeleteEntity(int Id)
        {
            string strSql = "update repairmanTable set deleteStatus=0 where repairmanID= @repairmanID ";
            SqlParameter parameter = new SqlParameter("@repairmanID", Id);
            SQLHelper.ExecuteonQuery(strSql, parameter);
        }

        public repairmanTable GetEntityById(int Id)
        {
            SqlParameter param = new SqlParameter("@repairmanID", Id);
            string strSQL = "select * from [repairmanTable] where repairmanID = @repairmanID ";
            System.Data.SqlClient.SqlDataReader dr;
            dr = SQLHelper.ExecuteReader(strSQL, param);
            try
            {
                if (dr.Read())
                {
                    repairmanTable entity = new repairmanTable();
                    entity = SQLHelper.ReaderToList<repairmanTable>(dr)[0];
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
            string sql = "select * from [repairmanTable] where deleteStatus=1 ";
            DataTable dt = SQLHelper.ExecuteDataTable(sql, null);
            return dt;
        }

        public int SaveEntity(repairmanTable entity)
        {
            List<SqlParameter> paramList = new List<SqlParameter>();
            var repairmanID_parameter = new SqlParameter("@repairmanID", SqlDbType.Int);
            if (entity.repairmanID > 0) repairmanID_parameter.Value = entity.repairmanID;
            else repairmanID_parameter.Value = DBNull.Value;
            SqlParameter repairmanName_parameter = new SqlParameter("@repairmanName", entity.repairmanName);
            paramList.Add(repairmanName_parameter);
            SqlParameter password_parameter = new SqlParameter("@password", entity.password);
            paramList.Add(password_parameter);
            string sql = "";
            SqlParameter identityParameter = new SqlParameter("@IdentityId", SqlDbType.Int);
            if ((entity.repairmanID == -1))
            {
                identityParameter.Direction = ParameterDirection.Output;
                paramList.Add(identityParameter);
                sql = "insert into repairmanTable(repairmanName,password,deleteStatus) ";
                sql += "values(@repairmanName,@password,1) Select @IdentityId = @@identity  ";
            }
            else
            {
                paramList.Add(repairmanID_parameter);
                sql = "update repairmanTable set repairmanName = @repairmanName,password = @password where repairmanID =@repairmanID ";
            }
            int count = SQLHelper.ExecuteonQuery(sql, paramList.ToArray());

            if (entity.repairmanID == -1 && identityParameter != null) entity.repairmanID = Convert.ToInt32(identityParameter.Value);

            return count;
        }
    }
}
