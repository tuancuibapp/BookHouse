using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace DatabaseProvider
{
    public partial class MyDB : DbContext
    {
        public MyDB()
            : base("name=MyDB1")
        {
        }

        public virtual DbSet<TVLT_Users> TVLT_Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<TVLT_Users>()
                .Property(e => e.ID)
                .IsUnicode(false);

            modelBuilder.Entity<TVLT_Users>()
                .Property(e => e.Uid)
                .IsFixedLength();

            modelBuilder.Entity<TVLT_Users>()
                .Property(e => e.Pwd)
                .IsFixedLength();

            modelBuilder.Entity<TVLT_Users>()
                .Property(e => e.Fullname)
                .IsFixedLength();
        }
    }
}
