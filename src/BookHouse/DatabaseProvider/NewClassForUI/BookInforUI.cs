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
        public BookInforUI()
        {
            book = new Book();
        }
        public Book book { get; set; }
        public string category { get; set; }
        public float rating { get; set; }
        public List<Comment> comments { get; set; }
        public string images { get; set; }
        public int sold { get; set; }
    }
}