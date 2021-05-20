namespace DataAccess.Entity
{
    using MongoDB.Bson;
    using MongoDB.Bson.Serialization.Attributes;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("paramTable")]
    public partial class paramTable
    {
        [Key]
        [BsonElement("_id")]
        [BsonId]
        public int paramID { get; set; }

        [StringLength(50)]
        public string paramCode { get; set; }

        [StringLength(50)]
        public string paramText { get; set; }

        [StringLength(50)]
        public string paramValue { get; set; }

        public int? paramType { get; set; }

        [StringLength(255)]
        public string remark { get; set; }

        public int deleteStatus { get; set; }
    }
}
