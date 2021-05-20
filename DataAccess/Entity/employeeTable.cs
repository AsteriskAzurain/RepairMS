namespace DataAccess.Entity
{
    using MongoDB.Bson;
    using MongoDB.Bson.Serialization.Attributes;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("employeeTable")]
    public partial class employeeTable
    {
        [Key]
        [BsonElement("_id")]
        [BsonId]
        public int employeeID { get; set; }

        [StringLength(50)]
        public string employeeName { get; set; }

        [StringLength(50)]
        public string password { get; set; }

        public int deleteStatus { get; set; }
    }
}
