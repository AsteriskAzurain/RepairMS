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
    class paramRepository : paramTableDAL
    {
        private string collName = "param";
        private IMongoCollection<paramTable> collection;
        private FilterDefinition<paramTable> defaultFilter;

        public paramRepository()
        {
            collection = MongoHelper.GetCollection<paramTable>(collName);
            defaultFilter = Builders<paramTable>.Filter.Eq(p => p.deleteStatus, 1);
        }

        public bool DeleteEntity(int Id)
        {
            var idFilter = Builders<paramTable>.Filter.Eq(p => p.paramID, Id);
            try
            {
                var logicalDelResult = collection.UpdateOne(idFilter, Builders<paramTable>.Update.Set("deleteStatus", 0));
                return logicalDelResult.IsAcknowledged && logicalDelResult.ModifiedCount > 0;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public DataTable GetDataTableByTypeId(int typeID)
        {
            //string sql = "select * from [paramTable] where deleteStatus=1 and paramType= " + typeID.ToString();
            var typeIdFilter = Builders<paramTable>.Filter.Eq(p => p.paramType, typeID);
            typeIdFilter = typeIdFilter & defaultFilter;
            var paramList = collection.Find(typeIdFilter).ToList();
            return SQLHelper.ToDataTable(paramList);
        }

        public paramTable GetEntityById(int Id)
        {
            var idFilter = Builders<paramTable>.Filter.Eq(p => p.paramID, Id);
            var pinfo = collection.Find(idFilter).FirstOrDefault();
            return pinfo;
        }

        public DataTable GetEntityDatatable()
        {
            var paramList = collection.Find(defaultFilter).ToList();
            return SQLHelper.ToDataTable(paramList);
        }

        public DataTable GetParamListByType(int typeID)
        {
            //string sql = "select * from [paramTable] where deleteStatus=1 and paramType=" + typeID.ToString() + " order by paramValue ";
            var typeIdFilter = Builders<paramTable>.Filter.Eq(p => p.paramType, typeID);
            typeIdFilter = typeIdFilter & defaultFilter;
            var sortByParamVal = Builders<paramTable>.Sort.Ascending(p => p.paramValue);
            var paramList = collection.Find(typeIdFilter).Sort(sortByParamVal).ToList();
            return SQLHelper.ToDataTable(paramList);
        }

        public int SaveEntity(paramTable entity)
        {
            if (entity.paramID == -1)
            {
                entity.paramID = 1 + MongoHelper.GetMaxId<paramTable>(collection);
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
                var idFilter = Builders<paramTable>.Filter.Eq(p => p.paramID, entity.paramID);
                var updateResult = collection.UpdateOne(idFilter,
                    Builders<paramTable>.Update.Set("paramCode", entity.paramCode)
                                               .Set("paramText", entity.paramText)
                                               .Set("paramValue", entity.paramValue)
                                               .Set("paramType", entity.paramType)
                                               .Set("remark", entity.remark)
                    );
                return updateResult.IsAcknowledged ? Convert.ToInt32(updateResult.ModifiedCount) : 0;
            }
        }
    }
}
