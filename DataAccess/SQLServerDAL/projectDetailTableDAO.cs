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
    public class projectDetailTableDAO : projectDetailTableDAL
    {
        public bool DeleteEntity(int Id)
        {
            string strSql = "update projectDetailTable set deleteStatus=0 where detailID= @detailID ";
            SqlParameter parameter = new SqlParameter("@detailID", Id);
            return SQLHelper.ExecuteonQuery(strSql, parameter) == 1;
        }

        public projectDetailTable GetEntityById(int Id)
        {
            SqlParameter param = new SqlParameter("@detailID", Id);
            string strSQL = "select * from [projectDetailTable] where detailID = @detailID ";
            System.Data.SqlClient.SqlDataReader dr;
            dr = SQLHelper.ExecuteReader(strSQL, param);
            try
            {
                if (dr.Read())
                {
                    projectDetailTable entity = new projectDetailTable();
                    entity = SQLHelper.ReaderToList<projectDetailTable>(dr)[0];
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
            string sql = "select * from [projectDetailTable] where deleteStatus=1 ";
            DataTable dt = SQLHelper.ExecuteDataTable(sql, null);
            return dt;
        }

        public int SaveEntity(projectDetailTable entity)
        {
            List<SqlParameter> paramList = new List<SqlParameter>();
            var detailID_parameter = new SqlParameter("@detailID", SqlDbType.Int);
            if (entity.detailID > 0) detailID_parameter.Value = entity.detailID;
            else detailID_parameter.Value = DBNull.Value;
            var projectID_parameter = new SqlParameter("@projectID", entity.projectID);
            paramList.Add(projectID_parameter);
            var repairmanID_parameter = new SqlParameter("@repairmanID", entity.repairmanID);
            paramList.Add(repairmanID_parameter);
            var severity_parameter = new SqlParameter("@severity", entity.severity);
            paramList.Add(severity_parameter);
            var faultType_parameter = new SqlParameter("@faultType", entity.faultType);
            paramList.Add(faultType_parameter);
            var faultStatus_parameter = new SqlParameter("@faultStatus", entity.faultStatus);
            paramList.Add(faultStatus_parameter);
            SqlParameter faultDetail_parameter = new SqlParameter("@faultDetail", entity.faultDetail);
            if (entity.faultDetail == null || entity.faultDetail == "") faultDetail_parameter.Value = DBNull.Value;
            paramList.Add(faultDetail_parameter);
            SqlParameter add_requirement_parameter = new SqlParameter("@add_requirement", entity.add_requirement);
            if (entity.add_requirement == null || entity.add_requirement == "") add_requirement_parameter.Value = DBNull.Value;
            paramList.Add(add_requirement_parameter);
            string sql = "";
            SqlParameter identityParameter = new SqlParameter("@IdentityId", SqlDbType.Int);
            if (entity.detailID == -1)
            {
                identityParameter.Direction = ParameterDirection.Output;
                paramList.Add(identityParameter);
                sql = "insert into projectDetailTable(projectID,repairmanID,severity,faultType,faultStatus,faultDetail,add_requirement,createDate,deleteStatus) ";
                sql += "values(@projectID,@repairmanID,@severity,@faultType,@faultStatus,@faultDetail,@add_requirement,GETDATE(),1) Select @IdentityId = @@identity  ";
            }
            else
            {
                paramList.Add(detailID_parameter);
                sql = "update projectDetailTable set projectID = @projectID,repairmanID = @repairmanID,severity = @severity,faultType = @faultType,faultStatus = @faultStatus,faultDetail = @faultDetail,add_requirement = @add_requirement,updateDate = GETDATE() where detailID =@detailID ";
            }
            int count = SQLHelper.ExecuteonQuery(sql, paramList.ToArray());

            //if (entity.detailID == -1)
            //{
            //    if (identityParameter != null)
            //    {
            //        entity.detailID = Convert.ToInt32(identityParameter.Value);
            //        return entity.detailID;
            //    }
            //    else return -1;
            //}
            //else return count;

            return entity.detailID > 0 ? count : (identityParameter == null ? -1 : Convert.ToInt32(identityParameter.Value));
        }

        public DataTable GetAllDetailByProjID(int projID)
        {
            string sql = string.Format("select * from projectDetailTable where deleteStatus=1 and projectID={0} order by createDate desc", projID);
            return SQLHelper.ExecuteDataTable(sql, null);
        }

        public int SetEntityStatus(int id, int status)
        {
            string strSql = string.Format(" update projectDetailTable set faultStatus={1},updateDate=GETDATE() where detailID={0} ", id, status);
            return SQLHelper.ExecuteonQuery(strSql, null) ;
        }
    }
}
