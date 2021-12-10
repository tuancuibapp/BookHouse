namespace DatabaseProvider.MyDB
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Rating")]
    public partial class Rating
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(5)]
        public string RatingID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(5)]
        public string BookID { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(5)]
        public string CustomerID { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short RatingStar { get; set; }

        public virtual Book Book { get; set; }

        public virtual Customer Customer { get; set; }
    }
}
