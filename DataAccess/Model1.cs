namespace DataAccess
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using Entity;

    public partial class Model1 : DbContext
    {
        public Model1()
            : base("name=Model1")
        {
        }

        public virtual DbSet<employeeTable> employeeTable { get; set; }
        public virtual DbSet<paramTable> paramTable { get; set; }
        public virtual DbSet<projectDetailTable> projectDetailTable { get; set; }
        public virtual DbSet<projectTable> projectTable { get; set; }
        public virtual DbSet<repairmanTable> repairmanTable { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<employeeTable>()
                .Property(e => e.employeeName)
                .IsUnicode(false);

            modelBuilder.Entity<employeeTable>()
                .Property(e => e.password)
                .IsUnicode(false);

            modelBuilder.Entity<paramTable>()
                .Property(e => e.paramCode)
                .IsUnicode(false);

            modelBuilder.Entity<paramTable>()
                .Property(e => e.paramText)
                .IsUnicode(false);

            modelBuilder.Entity<paramTable>()
                .Property(e => e.paramValue)
                .IsUnicode(false);

            modelBuilder.Entity<paramTable>()
                .Property(e => e.remark)
                .IsUnicode(false);

            modelBuilder.Entity<projectDetailTable>()
                .Property(e => e.faultDetail)
                .IsUnicode(false);

            modelBuilder.Entity<projectDetailTable>()
                .Property(e => e.add_requirement)
                .IsUnicode(false);

            modelBuilder.Entity<projectTable>()
                .Property(e => e.contractName)
                .IsUnicode(false);

            modelBuilder.Entity<projectTable>()
                .Property(e => e.contractPhone)
                .IsUnicode(false);

            modelBuilder.Entity<projectTable>()
                .Property(e => e.projectDetail)
                .IsUnicode(false);

            modelBuilder.Entity<projectTable>()
                .Property(e => e.siteDetail)
                .IsUnicode(false);

            modelBuilder.Entity<repairmanTable>()
                .Property(e => e.repairmanName)
                .IsUnicode(false);

            modelBuilder.Entity<repairmanTable>()
                .Property(e => e.password)
                .IsUnicode(false);
        }
    }
}
