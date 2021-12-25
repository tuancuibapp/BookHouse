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
        public Book book { get; set; }
        public int number { get; set; }
        public bool rating { get; set; }
    }
}
