namespace DataAccess.Entity
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("projectDetailTable")]
    public partial class projectDetailTable
    {
        [Key]
        public int detailID { get; set; }

        public int? projectID { get; set; }

        public int? repairmanID { get; set; }

        public int? severity { get; set; }

        public int? faultType { get; set; }

        public int? faultStatus { get; set; }

        [StringLength(255)]
        public string faultDetail { get; set; }

        [StringLength(255)]
        public string add_requirement { get; set; }

        public DateTime? createDate { get; set; }

        public DateTime? updateDate { get; set; }

        public byte deleteStatus { get; set; }
    }
}
