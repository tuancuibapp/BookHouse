namespace DatabaseProvider.MyDB
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("FAQ")]
    public partial class FAQ
    {
        [Key]
        [StringLength(5)]
        public string QuestionID { get; set; }

        [Required]
        [StringLength(2000)]
        public string Question { get; set; }

        [Required]
        [StringLength(2000)]
        public string Answer { get; set; }
    }
}
