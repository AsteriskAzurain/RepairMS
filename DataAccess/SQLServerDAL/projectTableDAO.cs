﻿using DataAccess.IDAL;
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
    public class projectTableDAO : projectTableDAL
    {
        public bool DeleteEntity(int Id)
        {
            string strSql = "update projectTable set deleteStatus=0 where projectID= @projectID ";
            SqlParameter parameter = new SqlParameter("@projectID", Id);
            return SQLHelper.ExecuteonQuery(strSql, parameter) == 1;
        }

        public projectTable GetEntityById(int Id)
        {
            SqlParameter param = new SqlParameter("@projectID", Id);
            string strSQL = "select * from [projectTable] where projectID = @projectID ";
            System.Data.SqlClient.SqlDataReader dr;
            dr = SQLHelper.ExecuteReader(strSQL, param);
            try
            {
                projectTable entity = new projectTable();
                entity = SQLHelper.ReaderToList<projectTable>(dr)[0];
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
            string sql = "select * from [projectTable] where deleteStatus=1 ";
            DataTable dt = SQLHelper.ExecuteDataTable(sql, null);
            return dt;
        }

        public int SaveEntity(projectTable entity)
        {
            List<SqlParameter> paramList = new List<SqlParameter>();
            var projectID_parameter = new SqlParameter("@projectID", SqlDbType.Int);
            if (entity.projectID > 0) projectID_parameter.Value = entity.projectID;
            else projectID_parameter.Value = DBNull.Value;
            var projectStatus_parameter = new SqlParameter("@projectStatus", entity.projectStatus);
            paramList.Add(projectStatus_parameter);
            var priority_parameter = new SqlParameter("@priority", entity.priority);
            paramList.Add(priority_parameter);
            var projectType_parameter = new SqlParameter("@projectType", entity.projectType);
            paramList.Add(projectType_parameter);
            var projectSite_parameter = new SqlParameter("@projectSite", entity.projectSite);
            paramList.Add(projectSite_parameter);
            SqlParameter contactName_parameter = new SqlParameter("@contactName", entity.contactName);
            paramList.Add(contactName_parameter);
            SqlParameter contactPhone_parameter = new SqlParameter("@contactPhone", entity.contactPhone);
            paramList.Add(contactPhone_parameter);
            SqlParameter projectDetail_parameter = new SqlParameter("@projectDetail", entity.projectDetail);
            paramList.Add(projectDetail_parameter);
            SqlParameter siteDetail_parameter = new SqlParameter("@siteDetail", entity.siteDetail);
            paramList.Add(siteDetail_parameter);
            SqlParameter hasDetail_parameter = new SqlParameter("@hasDetail", entity.hasDetail);
            paramList.Add(hasDetail_parameter);
            string sql = "";
            SqlParameter identityParameter = new SqlParameter("@IdentityId", SqlDbType.Int);
            if (entity.projectID == -1)
            {
                identityParameter.Direction = ParameterDirection.Output;
                paramList.Add(identityParameter);
                sql = "insert into projectTable(projectStatus,priority,projectType,projectSite,contactName,contactPhone,projectDetail,siteDetail,hasDetail,createDate,deleteStatus) ";
                sql += "values(@projectStatus,@priority,@projectType,@projectSite,@contactName,@contactPhone,@projectDetail,@siteDetail,0,GETDATE(),1) Select @IdentityId = @@identity  ";
            }
            else
            {
                paramList.Add(projectID_parameter);
                sql = "update projectTable set projectStatus = @projectStatus,priority = @priority,projectType = @projectType,projectSite = @projectSite,contactName = @contactName,contactPhone = @contactPhone,projectDetail = @projectDetail,siteDetail = @siteDetail,hasDetail = @hasDetail,updateDate = GETDATE() where projectID =@projectID ";
            }
            int count = SQLHelper.ExecuteonQuery(sql, paramList.ToArray());

            return entity.projectID > 0 ? count : (identityParameter == null ? -1 : Convert.ToInt32(identityParameter.Value));

        }

        public int SetEntityStatus(int id, int status)
        {
            string strSql = " update projectTable set projectStatus={1}, updateDate=GETDATE() where projectID={0} ";
            strSql = string.Format(strSql, id, status);
            return SQLHelper.ExecuteonQuery(strSql);
        }

        public DataTable GetDataTableByStatus(int status)
        {
            string strSql = string.Format("select * from projectTable where deleteStatus=1 and projectStatus={0} order by createDate desc,priority desc ", status);
            return SQLHelper.ExecuteDataTable(strSql, null);
        }

        public DataTable GetDataTableByEntity(projectTable entity, string startDate, string endDate)
        {
            string strSQL = "select * from projectTable where deleteStatus=1 ";
            if (entity.contactName != null) strSQL += string.Format(" and contactName='{0}' ", entity.contactName.ToString());
            if (entity.projectStatus != null) strSQL += " and projectStatus= " + entity.projectStatus.ToString();
            if (entity.projectType != null) strSQL += " and projectType= " + entity.projectType.ToString();
            if (entity.projectSite != null) strSQL += " and projectSite= " + entity.projectSite.ToString();
            if (entity.priority != null) strSQL += " and priority= " + entity.priority.ToString();
            if (startDate != "") strSQL += string.Format(" and createDate >= '{0}' ", startDate);
            if (endDate != "") strSQL += string.Format(" and createDate <= '{0}' ", endDate);
            return SQLHelper.ExecuteDataTable(strSQL, null);
        }
    }
}
