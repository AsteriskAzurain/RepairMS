using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DataAccess.Entity;
using DataAccess.IDAL;
using MongoDB.Driver;
using MongoDB.Bson;

namespace DataAccess.MongoDAL
{
    class projectRepository : projectTableDAL
    {
        private string collName = "project";
        private IMongoCollection<projectTable> collection;
        private FilterDefinition<projectTable> defaultFilter;


        public projectRepository()
        {
            collection = MongoHelper.GetCollection<projectTable>(collName);
            defaultFilter = Builders<projectTable>.Filter.Eq(p => p.deleteStatus, 1);

        }

        public bool DeleteEntity(int Id)
        {
            var idFilter = Builders<projectTable>.Filter.Eq(p => p.projectID, Id);
            try
            {
                var logicalDelResult = collection.UpdateOne(idFilter, Builders<projectTable>.Update.Set("deleteStatus", 0));
                return logicalDelResult.IsAcknowledged && logicalDelResult.ModifiedCount > 0;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public DataTable GetDataTableByEntity(projectTable entity, string startDate, string endDate)
        {
            FilterDefinition<projectTable> queryFilter = defaultFilter;
            if (!string.IsNullOrEmpty(entity.contactName)) queryFilter &= Builders<projectTable>.Filter.Eq(p => p.contactName, entity.contactName);
            if (entity.projectStatus != null) queryFilter &= Builders<projectTable>.Filter.Eq(p => p.projectStatus, entity.projectStatus);
            if (entity.projectType != null) queryFilter &= Builders<projectTable>.Filter.Eq(p => p.projectType, entity.projectType);
            if (entity.projectSite != null) queryFilter &= Builders<projectTable>.Filter.Eq(p => p.projectSite, entity.projectSite);
            if (entity.priority != null) queryFilter &= Builders<projectTable>.Filter.Eq(p => p.priority, entity.priority);
            if (!string.IsNullOrEmpty(startDate)) queryFilter &= Builders<projectTable>.Filter.Gte("createDate", DateTime.Parse(startDate));
            if (!string.IsNullOrEmpty(endDate)) queryFilter &= Builders<projectTable>.Filter.Lte("createDate", DateTime.Parse(endDate));

            var resultList = collection.Find(queryFilter).ToList();
            return SQLHelper.ToDataTable(resultList);
        }

        public DataTable GetDataTableByStatus(int status)
        {
            // select * from projectTable where deleteStatus=1 and projectStatus={0} order by createDate desc,priority desc
            var statusFilter = Builders<projectTable>.Filter.Eq(p => p.projectStatus, status);
            var sortRule = Builders<projectTable>.Sort.Descending(p => p.createDate).Descending(p => p.priority);
            var projList = collection.Find(defaultFilter & statusFilter).Sort(sortRule).ToList();
            return SQLHelper.ToDataTable(projList);
        }

        public projectTable GetEntityById(int Id)
        {
            var idFilter = Builders<projectTable>.Filter.Eq(p => p.projectID, Id);
            var proj = collection.Find(idFilter).FirstOrDefault();
            return proj;
        }

        public DataTable GetEntityDatatable()
        {
            var projList = collection.Find(defaultFilter).ToList();
            return SQLHelper.ToDataTable(projList);
        }

        public int SaveEntity(projectTable entity)
        {
            if (entity.projectID == -1)
            {
                entity.projectID = 1 + MongoHelper.GetMaxId(collection);
                entity.createDate = DateTime.Now;
                entity.deleteStatus = 1;
                try
                {
                    collection.InsertOne(entity);
                    return 1;
                }
                catch (Exception)
                {
                    return 0;
                }
            }
            else
            {
                var idFilter = Builders<projectTable>.Filter.Eq(p => p.projectID, entity.projectID);
                var updateResult = collection.UpdateOne(idFilter,
                    Builders<projectTable>.Update.Set("projectStatus", entity.projectStatus)
                                                 .Set("priority", entity.priority)
                                                 .Set("projectType", entity.projectType)
                                                 .Set("projectSite", entity.projectSite)
                                                 .Set("contactName", entity.contactName)
                                                 .Set("contactPhone", entity.contactPhone)
                                                 .Set("projectDetail", entity.projectDetail)
                                                 .Set("siteDetail", entity.siteDetail)
                                                 .Set("hasDetail", entity.hasDetail)
                                                 //.Set("createDate", entity.createDate)
                                                 .Set("updateDate", DateTime.Now)
                    //.Set("deleteStatus", entity.deleteStatus)
                    );
                return updateResult.IsAcknowledged ? Convert.ToInt32(updateResult.ModifiedCount) : 0;
            }
        }

        public int SetEntityStatus(int id, int status)
        {
            if (id > 0)
            {
                var idFilter = Builders<projectTable>.Filter.Eq(p => p.projectID, id);
                var updateResult = collection.UpdateOne(idFilter, Builders<projectTable>.Update.Set("projectStatus", status));
                return updateResult.IsAcknowledged ? Convert.ToInt32(updateResult.ModifiedCount) : 0;
            }
            else return 0;
        }
    }
}
