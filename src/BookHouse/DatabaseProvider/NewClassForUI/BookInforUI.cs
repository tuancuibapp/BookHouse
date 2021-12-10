using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    public class BookInforUI
    {
        public Book book { get; set; }
        public float rating { get; set; }
        public List<string> comments { get; set; }
        public List<string> images { get; set; }
    }
}
