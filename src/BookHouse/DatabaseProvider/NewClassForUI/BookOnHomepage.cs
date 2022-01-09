using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    public class BookOnHomepage
    {
        public string BookID { get; set; }
        public string BookName { get; set; }
        public int Price { get; set; }
        public float rating { get; set; }
        public string images { get; set; }
    }
}
