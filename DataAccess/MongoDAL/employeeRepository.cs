using DataAccess.IDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess.Entity;
using System.Data;
using MongoDB.Driver;
using MongoDB.Bson;

namespace DataAccess.MongoDAL
{
    class employeeRepository : employeeTableDAL
    {
        private string collName = "employee";
        private IMongoCollection<employeeTable> collection;

        public employeeRepository()
        {
            collection = MongoHelper.GetCollection<employeeTable>(collName);
        }

        public employeeTable checkLoginInfo(employeeTable loginUser)
        {
            var loginFilter = Builders<employeeTable>.Filter.Eq(e => e.employeeName, loginUser.employeeName)
                    & Builders<employeeTable>.Filter.Eq(e => e.password, loginUser.password);
            var einfo = collection.Find(loginFilter).FirstOrDefault();
            return einfo;
        }

        public bool DeleteEntity(int Id)
        {
            var idFilter = Builders<employeeTable>.Filter.Eq(e => e.employeeID, Id);
            try
            {
                var deleteResult = collection.DeleteOne(idFilter);
                return deleteResult.IsAcknowledged && deleteResult.DeletedCount > 0;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public employeeTable GetEntityById(int Id)
        {
            var idFilter = Builders<employeeTable>.Filter.Eq(e => e.employeeID, Id);
            var einfo = collection.Find(idFilter).FirstOrDefault();
            return einfo;
        }

        public DataTable GetEntityDatatable()
        {
            //var collection = MongoHelper.GetCollection<employeeTable>(collName);
            //var first_employee = collection.Find<employeeTable>(new BsonDocument()).FirstOrDefault(); // 查找集合中的第一个文档
            var employeeList = collection.Find(Builders<employeeTable>.Filter.Empty).ToList(); // 查找集合中所有
            //var employeeList = collection.Find<employeeTable>(new BsonDocument()).ToList(); // 查找集合中所有
            return SQLHelper.ToDataTable(employeeList);
            //var cursor = collection.Find<employeeTable>(new BsonDocument()).ToCursor(); // 查找集合中所有 并遍历
            //foreach (var einfo in cursor.ToEnumerable())
            //{
            //    Console.WriteLine(einfo);
            //}
        }

        public int SaveEntity(employeeTable entity)
        {
            //var client = new MongoClient("mongodb://121.41.24.118:27017");
            //var database = client.GetDatabase("test0520");
            //var collection = database.GetCollection<employeeTable>("employee");

            // insert
            if (entity.employeeID == -1)
            {
                entity.employeeID = 1 + MongoHelper.GetMaxId(collection);
                entity.deleteStatus = 1;
                try
                {
                    collection.InsertOneAsync(entity);
                    return 1;
                }
                catch (Exception)
                {
                    return 0;
                }
            }
            else // update
            {
                var idFilter = Builders<employeeTable>.Filter.Eq(e => e.employeeID, entity.employeeID);
                var oldInfo = collection.Find(idFilter).FirstOrDefault();
                if (oldInfo == null) return 0;
                else
                {
                    try
                    {
                        var updateResult = collection.UpdateOne(idFilter,
                            Builders<employeeTable>.Update.Set("employeeName", entity.employeeName)
                                                          .Set("password", entity.password)
                                                          .Set("deleteStatus", entity.deleteStatus));
                        return Convert.ToInt32(updateResult.IsAcknowledged && updateResult.ModifiedCount > 0);
                    }
                    catch (Exception)
                    {
                        return 0;
                    }
                }
            }
        }

    }
}
