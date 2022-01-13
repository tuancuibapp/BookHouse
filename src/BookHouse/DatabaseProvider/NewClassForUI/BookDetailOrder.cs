using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    public class BookDetailOrder
    {
        public string bookID { get; set; }
        public string bookName { get; set; }
        public int number { get; set; }
        public float price { get; set; }
    }
}
