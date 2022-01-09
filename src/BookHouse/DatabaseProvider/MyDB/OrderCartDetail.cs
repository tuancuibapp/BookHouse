namespace DatabaseProvider.MyDB
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("OrderCartDetail")]
    public partial class OrderCartDetail
    {
        [Key]
        [StringLength(5)]
        public string DetailID { get; set; }

        [StringLength(5)]
        public string OrderCartID { get; set; }

        [StringLength(5)]
        public string BookID { get; set; }

        public short Quatity { get; set; }

        public int? PriceForDetail { get; set; }

        public bool Order_or_Cart { get; set; }

        public bool? IsRating { get; set; }

        public virtual Book Book { get; set; }

        public virtual OrderCart OrderCart { get; set; }
    }
}
