namespace DataAccess.Entity
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("repairmanTable")]
    public partial class repairmanTable
    {
        [Key]
        public int repairmanID { get; set; }

        [StringLength(50)]
        public string repairmanName { get; set; }

        [StringLength(50)]
        public string password { get; set; }

        public byte? deleteStatus { get; set; }
    }
}
