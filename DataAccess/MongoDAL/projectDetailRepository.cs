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
using System.Collections;

namespace DataAccess.MongoDAL
{
    class projectDetailRepository : projectDetailTableDAL
    {
        private string collName = "projectDetail";
        private IMongoCollection<projectDetailTable> collection;
        private FilterDefinition<projectDetailTable> defaultFilter;

        public projectDetailRepository()
        {
            collection = MongoHelper.GetCollection<projectDetailTable>(collName);
            defaultFilter = Builders<projectDetailTable>.Filter.Eq(pd => pd.deleteStatus, (byte)1);
        }

        public bool DeleteEntity(int Id)
        {
            var idFilter = Builders<projectDetailTable>.Filter.Eq(pd => pd.detailID, Id);
            try
            {
                var logicalDelResult = collection.UpdateOne(idFilter, Builders<projectDetailTable>.Update.Set("deleteStatus", 0));
                return logicalDelResult.IsAcknowledged && logicalDelResult.ModifiedCount > 0;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public DataTable GetAllDetailByProjID(int projID)
        {
            string sql = string.Format("select * from projectDetailTable where deleteStatus=1 and projectID={0} order by createDate desc", projID);
            var projIdFilter = Builders<projectDetailTable>.Filter.Eq(pd => pd.projectID, projID);
            var sortByCreateDate = Builders<projectDetailTable>.Sort.Descending(pd => pd.createDate);
            var detailList = collection.Find(defaultFilter & projIdFilter).ToList();
            return SQLHelper.ToDataTable(detailList);
        }

        public projectDetailTable GetEntityById(int Id)
        {
            var idFilter = Builders<projectDetailTable>.Filter.Eq(pd => pd.detailID, Id);
            var detail = collection.Find(idFilter).FirstOrDefault();
            return detail;
        }

        public DataTable GetEntityDatatable()
        {
            var detailList = collection.Find(defaultFilter).ToList();
            return SQLHelper.ToDataTable(detailList);
        }

        public IList<projectDetailTable> getMyProjectByQuery(int rmID, projectTable projInfo)
        {
            var projCollection = MongoHelper.GetCollection<projectTable>("project");
            var projQueryFilter = Builders<projectTable>.Filter.Eq(p => p.deleteStatus, (byte)1);
            if (projInfo.projectID > 0) projQueryFilter &= Builders<projectTable>.Filter.Eq(p => p.projectID, projInfo.projectID);
            if (projInfo.projectStatus != null) projQueryFilter &= Builders<projectTable>.Filter.Eq(p => p.projectStatus, projInfo.projectStatus);
            if (projInfo.projectType != null) projQueryFilter &= Builders<projectTable>.Filter.Eq(p => p.projectType, projInfo.projectType);
            if (projInfo.projectSite != null) projQueryFilter &= Builders<projectTable>.Filter.Eq(p => p.projectSite, projInfo.projectSite);
            var projProjectFilter = Builders<projectTable>.Projection.Include(p => p.projectID);
            //BsonArray idArr = new BsonArray();
            List<int> idArr = new List<int>();
            var cursor = projCollection.Find(projQueryFilter).Project(projProjectFilter).ToCursor(); // 查找集合中所有 并遍历
            foreach (BsonDocument pdoc in cursor.ToEnumerable())
            {
                //idArr.Add(new BsonInt64(pdoc.GetValue("_id").AsInt32));
                idArr.Add(pdoc.GetValue("_id").AsInt32);
            }
            var queryFilter = defaultFilter;
            queryFilter &= Builders<projectDetailTable>.Filter.Eq(pd => pd.repairmanID, rmID);
            queryFilter &= Builders<projectDetailTable>.Filter.In("projectID", idArr.AsEnumerable());
            if (projInfo.updateDate > DateTime.MinValue)
            {
                // 将detail表的createDate字段放入project的updateDate字段中，方便传值
                queryFilter &= (Builders<projectDetailTable>.Filter.Gte("createDate", projInfo.updateDate.Value)
                 & Builders<projectDetailTable>.Filter.Lt("createDate", projInfo.updateDate.Value.AddDays(1)));
            }
            var detailList = collection.Find(queryFilter).ToList();
            return detailList;
        }

        public IList<projectDetailTable> getMyRepairProjectList(int rmID)
        {
            var projCollection = MongoHelper.GetCollection<projectTable>("project");
            var projQueryFilter = Builders<projectTable>.Filter.Eq(p => p.deleteStatus, (byte)1);
            var projProjectFilter = Builders<projectTable>.Projection.Include(p => p.projectID);
            List<int> idArr = new List<int>();
            var cursor = projCollection.Find(projQueryFilter).Project(projProjectFilter).ToCursor(); // 查找集合中所有 并遍历
            foreach (BsonDocument pdoc in cursor.ToEnumerable())
            {
                idArr.Add(pdoc.GetValue("_id").AsInt32);
            }
            var queryFilter = defaultFilter;
            queryFilter &= Builders<projectDetailTable>.Filter.Eq(pd => pd.repairmanID, rmID);
            queryFilter &= Builders<projectDetailTable>.Filter.In("projectID", idArr.AsEnumerable());
            var sortByCreateDate = Builders<projectDetailTable>.Sort.Descending(pd => pd.createDate);
            var detailList = collection.Find(queryFilter).Sort(sortByCreateDate).ToList();
            return detailList;
        }

        public int SaveEntity(projectDetailTable entity)
        {
            if (entity.detailID == -1)
            {
                entity.detailID = 1 + MongoHelper.GetMaxId(collection);
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
                var idFilter = Builders<projectDetailTable>.Filter.Eq(p => p.detailID, entity.detailID);
                var updateResult = collection.UpdateOne(idFilter,
                    Builders<projectDetailTable>.Update.Set("projectID", entity.projectID)
                                                       .Set("repairmanID", entity.repairmanID)
                                                       .Set("severity", entity.severity)
                                                       .Set("faultType", entity.faultType)
                                                       .Set("faultStatus", entity.faultStatus)
                                                       .Set("faultDetail", entity.faultDetail)
                                                       .Set("add_requirement", entity.add_requirement)
                                                       //.Set("createDate", entity.createDate)
                                                       .Set("updateDate", DateTime.Now)
                    //.Set("deleteStatus", entity.deleteStatus)
                    );
                return Convert.ToInt32(updateResult.IsAcknowledged && updateResult.ModifiedCount > 0);
            }
        }

        public int SetEntityStatus(int id, int status)
        {
            var idFilter = Builders<projectDetailTable>.Filter.Eq(pd => pd.detailID, id);
            var updateResult = collection.UpdateOne(idFilter, Builders<projectDetailTable>.Update.Set("faultStatus", status).Set("updateDate", DateTime.Now));
            return Convert.ToInt32(updateResult.IsAcknowledged && updateResult.ModifiedCount > 0);
        }

    }
}
