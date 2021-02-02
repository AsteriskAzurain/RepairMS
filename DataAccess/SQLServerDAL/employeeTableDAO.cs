using DataAccess.IDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess.Entity;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;

namespace DataAccess.SQLServerDAL
{
    public class employeeTableDAO : employeeTableDAL
    {
        public employeeTable checkLoginInfo(employeeTable loginUser)
        {
            string strSQL = " select * from employeeTable where deleteStatus=1 and employeeName=@employeeName and password=@password ";
            SqlParameter[] paramArr = new SqlParameter[] {
                new SqlParameter("@employeeName",loginUser.employeeName),
                new SqlParameter("@password",loginUser.password)
            };
            System.Data.SqlClient.SqlDataReader dr = SQLHelper.ExecuteReader(strSQL, paramArr);
            IList<employeeTable> list = SQLHelper.ReaderToList<employeeTable>(dr);
            return list.Count > 0 ? list[0] : loginUser;
        }

        public bool DeleteEntity(int Id)
        {
            string strSql = "update employeeTable set deleteStatus=0 where employeeID= @employeeID ";
            SqlParameter parameter = new SqlParameter("@employeeID", Id);
            return SQLHelper.ExecuteonQuery(strSql, parameter) == 1;
        }

        public employeeTable GetEntityById(int Id)
        {
            SqlParameter param = new SqlParameter("@employeeID", Id);
            string strSQL = "select * from [employeeTable] where employeeID = @employeeID ";
            System.Data.SqlClient.SqlDataReader dr;
            dr = SQLHelper.ExecuteReader(strSQL, param);
            try
            {
                if (dr.Read())
                {
                    employeeTable entity = new employeeTable();
                    entity = SQLHelper.ReaderToList<employeeTable>(dr)[0];
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
            string sql = "select * from [employeeTable] where deleteStatus=1 ";
            DataTable dt = SQLHelper.ExecuteDataTable(sql, null);
            return dt;
        }

        public int SaveEntity(employeeTable entity)
        {
            List<SqlParameter> paramList = new List<SqlParameter>();
            var employeeID_parameter = new SqlParameter("@employeeID", SqlDbType.Int);
            if (entity.employeeID > 0) employeeID_parameter.Value = entity.employeeID;
            else employeeID_parameter.Value = DBNull.Value;
            SqlParameter employeeName_parameter = new SqlParameter("@employeeName", entity.employeeName);
            paramList.Add(employeeName_parameter);
            SqlParameter password_parameter = new SqlParameter("@password", entity.password);
            paramList.Add(password_parameter);
            string sql = "";
            SqlParameter identityParameter = new SqlParameter("@IdentityId", SqlDbType.Int);
            if (entity.employeeID == -1)
            {
                identityParameter.Direction = ParameterDirection.Output;
                paramList.Add(identityParameter);
                sql = "insert into employeeTable(employeeName,password,deleteStatus) ";
                sql += "values(@employeeName,@password,1) Select @IdentityId = @@identity  ";
            }
            else
            {
                paramList.Add(employeeID_parameter);
                sql = "update employeeTable set employeeName = @employeeName,password = @password where employeeID =@employeeID ";
            }
            int count = SQLHelper.ExecuteonQuery(sql, paramList.ToArray());
            if (entity.employeeID == -1 && identityParameter != null) entity.employeeID = Convert.ToInt32(identityParameter.Value);
            return count;
        }


    }
}
