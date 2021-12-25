using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    class HomepageUI
    {
        public List<Book> bestSellingBooks { get; set; }
        public List<Book> foreignLiteratureBooks { get; set; }
        public List<Book> vietnameseLiteratureBooks { get; set; }
        public List<Book> historyBooks { get; set; }
    }
}
