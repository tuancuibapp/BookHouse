using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseProvider.MyDB;
namespace DatabaseProvider.NewClassForUI
{
    public class HomepageUI
    {
        public List<BookOnHomepage> bestSellingBooks { get; set; }
        public List<BookOnHomepage> foreignLiteratureBooks { get; set; }
        public List<BookOnHomepage> vietnameseLiteratureBooks { get; set; }
        public List<BookOnHomepage> historyBooks { get; set; }
    }
}
