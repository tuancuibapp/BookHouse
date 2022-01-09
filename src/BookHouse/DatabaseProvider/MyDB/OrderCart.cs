namespace DatabaseProvider.MyDB
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("OrderCart")]
    public partial class OrderCart
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public OrderCart()
        {
            OrderCartDetails = new HashSet<OrderCartDetail>();
        }

        [StringLength(5)]
        public string OrderCartID { get; set; }

        [StringLength(5)]
        public string CustomerID { get; set; }

        [StringLength(100)]
        public string Address { get; set; }

        [StringLength(11)]
        public string Phone { get; set; }

        [StringLength(50)]
        public string OrderState { get; set; }

        public int? TotalPrice { get; set; }

        [StringLength(200)]
        public string NoteForOrder { get; set; }

        [Column(TypeName = "date")]
        public DateTime? OrderDate { get; set; }

        [Column(TypeName = "date")]
        public DateTime? ReceivedDate { get; set; }

        [StringLength(200)]
        public string RecipientName { get; set; }

        public bool? Order_or_Cart { get; set; }

        [StringLength(100)]
        public string DeliveryMethod { get; set; }

        public int? DeliveryCharrge { get; set; }

        public int? GoodsPrice { get; set; }

        public virtual Customer Customer { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderCartDetail> OrderCartDetails { get; set; }
    }
}
