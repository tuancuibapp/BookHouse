using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    public class RatingUI
    {
        public RatingUI()
        {
            book = new Book();
        }
        public Book book { get; set; }
        public float rating { get; set; }
        public int sold { get; set; }
        public string image { get; set; }
        public float price { get; set; }
    }
}
