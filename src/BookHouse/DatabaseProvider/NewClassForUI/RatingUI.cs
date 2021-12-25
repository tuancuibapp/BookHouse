using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    class RatingUI
    {
        public Book book { get; set; }
        public float rating { get; set; }
        public int sold { get; set; }
        public List<string> images { get; set; }
        public float price { get; set; }
    }
}
