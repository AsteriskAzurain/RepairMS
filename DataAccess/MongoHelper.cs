using DataAccess.Entity;
using MongoDB.Bson;
using MongoDB.Driver;
using MongoDB.Driver.GridFS;
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
            return result.Count > 0 ? result[0].GetValue("maxId").AsInt32 : 0;
        }

        public static IGridFSBucket getGridFSBucket(string database)
        {
            var bucket = new GridFSBucket(db, new GridFSBucketOptions { BucketName = database });
            return bucket;
        }

        public static ObjectId StorePicture(string database, string picName, byte[] picData, GridFSUploadOptions options)
        {
            ObjectId id;
            //var bucket = new GridFSBucket(db, new GridFSBucketOptions { BucketName = database });
            var bucket = getGridFSBucket(database);
            using (var stream = bucket.OpenUploadStream(picName, options))
            {
                id = stream.Id;
                stream.Write(picData, 0, picData.Length);
                stream.Close();
            }
            return id;
        }

        public static byte[] getPhotoDataByPicID(string database, ObjectId picID)
        {
            var bucket = getGridFSBucket(database);
            var bytes = bucket.DownloadAsBytes(picID);
            return bytes;
        }

        public static bool updatePhotoDelStatus(string database, ObjectId picID)
        {
            var picColl = GetCollection<BsonDocument>(database + ".files");
            var idFilter = new BsonDocument("_id", picID);
            var replacement = new BsonDocument("$set", new BsonDocument("metadata.deleteStatus", 0));
            var updateResult = picColl.UpdateOne(idFilter, replacement);
            return updateResult.IsAcknowledged && updateResult.ModifiedCount > 0;
        }

    }
}
