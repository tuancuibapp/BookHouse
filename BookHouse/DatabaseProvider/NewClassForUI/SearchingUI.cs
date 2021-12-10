using DatabaseProvider.MyDB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseProvider.NewClassForUI
{
    public class SearchingUI
    {
        public List<Book> books { get; set; }
        public Filters filters { get; set; }
    }
}
