namespace DataAccess.Entity
{
    using MongoDB.Bson;
    using MongoDB.Bson.Serialization.Attributes;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("projectTable")]
    public partial class projectTable
    {
        [Key]
        [BsonElement("_id")]
        [BsonId]
        public int projectID { get; set; }

        public int? projectStatus { get; set; }

        public int? priority { get; set; }

        public int? projectType { get; set; }

        public int? projectSite { get; set; }

        [StringLength(50)]
        public string contactName { get; set; }

        [StringLength(50)]
        public string contactPhone { get; set; }

        [Required]
        [StringLength(255)]
        public string projectDetail { get; set; }

        [StringLength(255)]
        public string siteDetail { get; set; }

        public int hasDetail { get; set; }

        public DateTime? createDate { get; set; }

        public DateTime? updateDate { get; set; }

        public int deleteStatus { get; set; }
    }
}
