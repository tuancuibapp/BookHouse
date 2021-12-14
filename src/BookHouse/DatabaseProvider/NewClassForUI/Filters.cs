using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatabaseProvider.NewClassForUI
{
    public class Filters
    {
        public List<string> categories { get; set; }
        public List<bool> values { get; set; }
        public List<int> priceRange { get; set; }
        public float rating { get; set; }
        public bool sortInc { get; set; }
        public bool sortDec { get; set; }
        public string query { get; set; }
        
    }
}
