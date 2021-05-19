using DataAccess.Entity;
using MongoDB.Bson;
using MongoDB.Driver;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public static class MongoHelper
    {
        private static readonly string connStr = System.Web.Configuration.WebConfigurationManager.AppSettings["CONN_MongoDB"];
        private static IMongoDatabase db;

        public static IMongoDatabase GetDataBase()
        {
            var client = new MongoClient(connStr);
            db = client.GetDatabase("repairingInfoMS");
            return db;
        }

        public static IMongoCollection<T> GetCollection<T>(string collectionName)
        {
            if (db == null) GetDataBase();
            var collection = db.GetCollection<T>(collectionName);
            return collection;
        }

        public static int GetMaxId<T>(IMongoCollection<T> collection)
        {
            var maxStage = new BsonDocument(
                "$group",
                new BsonDocument {
                    { "_id", 0 },
                    { "maxId",new BsonDocument("$max","$_id") }
                }
            );
            var pipeline = PipelineDefinition<T, BsonDocument>
                .Create(new BsonDocument[] {
                    maxStage
                });
            var result = collection.Aggregate(pipeline).ToList();
            if (result.Count == 0) return 0;
            else
            {
                var maxid = result[0].GetValue("maxId").AsInt32;
                return maxid;
            }
        }


    }
}
