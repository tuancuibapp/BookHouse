namespace DatabaseProvider.MyDB
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CartDetail")]
    public partial class CartDetail
    {
        [StringLength(5)]
        public string CartDetailID { get; set; }

        [StringLength(5)]
        public string CustomerID { get; set; }

        [StringLength(5)]
        public string BookID { get; set; }

        public short Quatity { get; set; }

        public int Price { get; set; }

        public virtual Book Book { get; set; }

        public virtual Customer Customer { get; set; }
    }
}
