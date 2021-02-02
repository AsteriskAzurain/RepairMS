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
        public repairmanTable checkLoginInfo(repairmanTable loginUser)
        {
            string strSQL = " select * from repairmanTable where deleteStatus=1 and repairmanName=@repairmanName and password=@password ";
            SqlParameter[] paramArr = new SqlParameter[] {
                new SqlParameter("@repairmanName",loginUser.repairmanName),
                new SqlParameter("@password",loginUser.password)
            };
            System.Data.SqlClient.SqlDataReader dr = SQLHelper.ExecuteReader(strSQL, paramArr);
            IList<repairmanTable> list = SQLHelper.ReaderToList<repairmanTable>(dr);
            return list.Count > 0 ? list[0] : loginUser;
        }

        public bool DeleteEntity(int Id)
        {
            string strSql = "update repairmanTable set deleteStatus=0 where repairmanID= @repairmanID ";
            SqlParameter parameter = new SqlParameter("@repairmanID", Id);
            return SQLHelper.ExecuteonQuery(strSql, parameter) == 1;
        }

        public repairmanTable GetEntityById(int Id)
        {
            SqlParameter param = new SqlParameter("@repairmanID", Id);
            string strSQL = "select * from [repairmanTable] where repairmanID = @repairmanID ";
            System.Data.SqlClient.SqlDataReader dr;
            dr = SQLHelper.ExecuteReader(strSQL, param);
            try
            {
                repairmanTable entity = new repairmanTable();
                entity = SQLHelper.ReaderToList<repairmanTable>(dr)[0];
                return entity;
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
