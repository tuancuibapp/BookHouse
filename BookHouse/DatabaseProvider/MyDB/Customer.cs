namespace DatabaseProvider.MyDB
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Customer")]
    public partial class Customer
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Customer()
        {
            CommentBooks = new HashSet<CommentBook>();
            OrderCarts = new HashSet<OrderCart>();
            Ratings = new HashSet<Rating>();
        }

        [StringLength(5)]
        public string CustomerID { get; set; }

        [Required]
        [StringLength(200)]
        public string CustomerName { get; set; }

        [Required]
        [StringLength(30)]
        public string UserName { get; set; }

        [Required]
        [StringLength(30)]
        public string Password { get; set; }

        [StringLength(100)]
        public string CustomerEmail { get; set; }

        [StringLength(11)]
        public string CustomerPhone { get; set; }

        [StringLength(200)]
        public string Address { get; set; }

        public bool? InBlankList { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CommentBook> CommentBooks { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderCart> OrderCarts { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Rating> Ratings { get; set; }
    }
}
