using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace DatabaseProvider.MyDB
{
    public partial class MyDB : DbContext
    {
        public MyDB()
            : base("name=MyDB")
        {
        }

        public virtual DbSet<Admin> Admins { get; set; }
        public virtual DbSet<Book> Books { get; set; }
        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<CommentBook> CommentBooks { get; set; }
        public virtual DbSet<Customer> Customers { get; set; }
        public virtual DbSet<FAQ> FAQs { get; set; }
        public virtual DbSet<Img> Imgs { get; set; }
        public virtual DbSet<OrderCart> OrderCarts { get; set; }
        public virtual DbSet<OrderCartDetail> OrderCartDetails { get; set; }
        public virtual DbSet<Rating> Ratings { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Admin>()
                .Property(e => e.AdminID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Admin>()
                .Property(e => e.UserName)
                .IsFixedLength();

            modelBuilder.Entity<Admin>()
                .Property(e => e.Password)
                .IsFixedLength();

            modelBuilder.Entity<Book>()
                .Property(e => e.BookID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Book>()
                .HasMany(e => e.CommentBooks)
                .WithRequired(e => e.Book)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Book>()
                .HasMany(e => e.Imgs)
                .WithRequired(e => e.Book)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Book>()
                .HasMany(e => e.Ratings)
                .WithRequired(e => e.Book)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Book>()
                .HasMany(e => e.Categories)
                .WithMany(e => e.Books)
                .Map(m => m.ToTable("BookCategory").MapLeftKey("BookID").MapRightKey("CategoryID"));

            modelBuilder.Entity<Category>()
                .Property(e => e.CategoryID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<CommentBook>()
                .Property(e => e.CommentID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<CommentBook>()
                .Property(e => e.BookID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<CommentBook>()
                .Property(e => e.CustomerID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.CustomerID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Customer>()
                .Property(e => e.UserName)
                .IsFixedLength();

            modelBuilder.Entity<Customer>()
                .Property(e => e.Password)
                .IsFixedLength();

            modelBuilder.Entity<Customer>()
                .Property(e => e.CustomerEmail)
                .IsFixedLength();

            modelBuilder.Entity<Customer>()
                .Property(e => e.CustomerPhone)
                .IsFixedLength();

            modelBuilder.Entity<Customer>()
                .HasMany(e => e.CommentBooks)
                .WithRequired(e => e.Customer)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Customer>()
                .HasMany(e => e.Ratings)
                .WithRequired(e => e.Customer)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<FAQ>()
                .Property(e => e.QuestionID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Img>()
                .Property(e => e.ImagePath)
                .IsFixedLength();

            modelBuilder.Entity<Img>()
                .Property(e => e.BookID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<OrderCart>()
                .Property(e => e.OrderCartID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<OrderCart>()
                .Property(e => e.CustomerID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<OrderCart>()
                .Property(e => e.Phone)
                .IsFixedLength();

            modelBuilder.Entity<OrderCartDetail>()
                .Property(e => e.DetailID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<OrderCartDetail>()
                .Property(e => e.OrderCartID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<OrderCartDetail>()
                .Property(e => e.BookID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Rating>()
                .Property(e => e.RatingID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Rating>()
                .Property(e => e.BookID)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Rating>()
                .Property(e => e.CustomerID)
                .IsFixedLength()
                .IsUnicode(false);
        }
    }
}
