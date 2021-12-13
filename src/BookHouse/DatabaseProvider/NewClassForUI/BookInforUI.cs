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
        public List<CommentBook> comments { get; set; }
        public List<Img> images { get; set; }
        public int sold { get; set; }
    }
}
