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
    class repairmanRepository : repairmanTableDAL
    {
        private string collName = "repairman";
        private IMongoCollection<repairmanTable> collection;
        private FilterDefinition<repairmanTable> defaultFilter;

        public repairmanRepository()
        {
            collection = MongoHelper.GetCollection<repairmanTable>(collName);
            defaultFilter = Builders<repairmanTable>.Filter.Eq(rm => rm.deleteStatus, (byte)1);
        }

        public repairmanTable checkLoginInfo(repairmanTable loginUser)
        {
            var loginFilter = Builders<repairmanTable>.Filter.Eq(rm => rm.repairmanName, loginUser.repairmanName)
                    & Builders<repairmanTable>.Filter.Eq(rm => rm.password, loginUser.password);
            var rminfo = collection.Find(loginFilter).FirstOrDefault();
            return rminfo;
        }

        public bool DeleteEntity(int Id)
        {
            var idFilter = Builders<repairmanTable>.Filter.Eq(rm => rm.repairmanID, Id);
            try
            {
                var logicalDelResult = collection.UpdateOne(idFilter, Builders<repairmanTable>.Update.Set("deleteStatus", 0));
                return logicalDelResult.IsAcknowledged && logicalDelResult.ModifiedCount > 0;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public repairmanTable GetEntityById(int Id)
        {
            var idFilter = Builders<repairmanTable>.Filter.Eq(rm => rm.repairmanID, Id);
            var rminfo = collection.Find(idFilter).FirstOrDefault();
            return rminfo;
        }

        public DataTable GetEntityDatatable()
        {
            var sortByName = Builders<repairmanTable>.Sort.Ascending(rm => rm.repairmanName);
            var rmList = collection.Find(defaultFilter).Sort(sortByName).ToList();
            return SQLHelper.ToDataTable(rmList);
        }

        public DataTable GetEntityDatatableAll()
        {
            var rmList = collection.Find(Builders<repairmanTable>.Filter.Empty).ToList();
            return SQLHelper.ToDataTable(rmList);
        }

        public DataTable getRMListByName(string name)
        {
            BsonDocument nameBson = new BsonDocument();
            nameBson.Add("repairmanName", new BsonRegularExpression("^.*" + name + ".*$", "i"));
            var nameFilter = Builders<repairmanTable>.Filter.Text(name);
            var rmList = collection.Find(nameBson).ToList();
            return SQLHelper.ToDataTable(rmList);
        }

        public bool isNameExist(string name, bool isAll)
        {
            BsonDocument nameFilter = new BsonDocument();
            nameFilter.Add("repairmanName", new BsonRegularExpression("^.*" + name + ".*$", "i"));
            FilterDefinition<repairmanTable> queryFilter = nameFilter;
            if (!isAll) queryFilter = defaultFilter & nameFilter;
            var recordCount = collection.Find(queryFilter).Count();
            return recordCount > 0;
        }

        public int SaveEntity(repairmanTable entity)
        {
            if (entity.repairmanID == -1)
            {
                entity.repairmanID = 1 + MongoHelper.GetMaxId(collection);
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
                var idFilter = Builders<repairmanTable>.Filter.Eq(rm => rm.repairmanID, entity.repairmanID);
                var updateResult = collection.UpdateOne(idFilter, Builders<repairmanTable>.Update.Set("repairmanName", entity.repairmanName).Set("password", entity.password));
                return Convert.ToInt32(updateResult.IsAcknowledged && updateResult.ModifiedCount > 0);
            }
        }

        public bool switchDeleteStatus(int rmId, int newStatus)
        {
            var idFilter = Builders<repairmanTable>.Filter.Eq(rm => rm.repairmanID, rmId);
            var updateResult = collection.UpdateOne(idFilter, Builders<repairmanTable>.Update.Set("deleteStatus", newStatus));
            return updateResult.IsAcknowledged && updateResult.ModifiedCount > 0;
        }
    }
}
