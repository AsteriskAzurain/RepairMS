namespace DataAccess.Entity
{
    using MongoDB.Bson;
    using MongoDB.Bson.Serialization.Attributes;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("repairmanTable")]
    public partial class repairmanTable
    {
        [Key]
        [BsonElement("_id")]
        [BsonId]
        //[BsonRepresentation(BsonType.ObjectId)]
        public int repairmanID { get; set; }

        [StringLength(50)]
        public string repairmanName { get; set; }

        [StringLength(50)]
        public string password { get; set; }

        public int deleteStatus { get; set; }
    }
}
