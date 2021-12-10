namespace DatabaseProvider.MyDB
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CommentBook")]
    public partial class CommentBook
    {
        [Key]
        [StringLength(5)]
        public string CommentID { get; set; }

        [Required]
        [StringLength(5)]
        public string BookID { get; set; }

        [Required]
        [StringLength(5)]
        public string CustomerID { get; set; }

        [Required]
        [StringLength(2000)]
        public string Content { get; set; }

        public virtual Book Book { get; set; }

        public virtual Customer Customer { get; set; }
    }
}
