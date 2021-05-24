using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Entity
{
    [Serializable]
    public class repairPhoto
    {
        public ObjectId picID { get; set; }

        public int? roleID { get; set; }

        public int? userID { get; set; }

        public int? detailID { get; set; }

        public string picName { get; set; }

        public byte[] picData { get; set; }

        public int deleteStatus { get; set; }
    }
}
