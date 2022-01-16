namespace DatabaseProvider.MyDB
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("OrderDetail")]
    public partial class OrderDetail
    {
        [Key]
        [StringLength(5)]
        public string DetailID { get; set; }

        [StringLength(5)]
        public string OrderID { get; set; }

        [StringLength(5)]
        public string BookID { get; set; }

        public short Quatity { get; set; }

        public int? PriceForDetail { get; set; }

        public bool? IsRating { get; set; }

        public virtual Book Book { get; set; }

        public virtual Order Order { get; set; }
    }
}
