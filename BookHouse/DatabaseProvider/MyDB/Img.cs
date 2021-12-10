namespace DatabaseProvider.MyDB
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Img")]
    public partial class Img
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(300)]
        public string ImagePath { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(5)]
        public string BookID { get; set; }

        public virtual Book Book { get; set; }
    }
}
